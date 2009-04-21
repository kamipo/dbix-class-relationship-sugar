package DBIx::Class::Relationship::Sugar;

use strict;
use warnings;
our $VERSION = '0.01';

use base 'DBIx::Class::Relationship';
use autobox::String::Inflector;

sub might_have {
    my $class = caller;
    shift if $class eq $_[0];

    $class->next::method(@_);
}

sub has_one {
    my $class = caller;
    shift if $class eq $_[0];

    $class->next::method(@_);
}

sub _has_one {
    my ($class, $join_type, $rel, $f_class, $cond, $attrs) = @_;

    $f_class ||= $class->schema_class . '::' . $rel->camelize;
    $f_class   = $class->schema_class . $f_class if $f_class =~ /^::/;

    $cond ||= {"foreign.@{[$class->table->singularize]}_id" => 'self.id'};

    $class->next::method($rel, $f_class, $cond, $attrs);
}

sub belongs_to {
    my $class = caller;
    shift if $class eq $_[0];
    my ($rel, $f_class, $cond, $attrs) = @_;

    $f_class ||= $class->schema_class . '::' . $rel->camelize;
    $f_class   = $class->schema_class . $f_class if $f_class =~ /^::/;

    $cond ||= {id => "$rel\_id"};

    $class->next::method($rel, $f_class, $cond, $attrs);
}

sub has_many {
    my $class = caller;
    shift if $class eq $_[0];
    my ($rel, $f_class, $cond, $attrs) = @_;

    $f_class ||= $class->schema_class . '::' . $rel->singularize->camelize;
    $f_class   = $class->schema_class . $f_class if $f_class =~ /^::/;

    $cond ||= {"foreign.@{[$class->table->singularize]}_id" => 'self.id'};

    $class->next::method($rel, $f_class, $cond, $attrs);
}

sub many_to_many {
    my $class = caller;
    shift if $class eq $_[0];
    my ($meth, $rel, $f_rel, $rel_attrs) = @_;

    $f_rel ||= $meth->singularize;

    $class->next::method($meth, $rel, $f_rel, $rel_attrs);
}

sub schema_class {ref shift->result_source_instance->schema}

1;
__END__

=head1 NAME

DBIx::Class::Relationship::Sugar -

=head1 SYNOPSIS

  use DBIx::Class::Relationship::Sugar;

=head1 DESCRIPTION

DBIx::Class::Relationship::Sugar is

=head1 AUTHOR

Ryuta Kamizono E<lt>kamipo@gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
