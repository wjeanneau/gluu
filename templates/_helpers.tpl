{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "gluu.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "gluu.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "gluu.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a fully qualified redis name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "gluu.redis.fullname" -}}
{{- if .Values.redis.fullnameOverride -}}
{{- .Values.redis.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- printf "%s-%s" .Release.Name .Values.redis.name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s-%s" .Release.Name $name .Values.redis.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create the name of the service account to use for the redis component
*/}}
{{- define "gluu.serviceAccountName.redis" -}}
{{- if .Values.serviceAccounts.redis.create -}}
    {{ default (include "gluu.redis.fullname" .) .Values.serviceAccounts.redis.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccounts.redis.name }}
{{- end -}}
{{- end -}}

{{/*
Create a fully qualified opendj name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "gluu.opendj.fullname" -}}
{{- if .Values.opendj.fullnameOverride -}}
{{- .Values.opendj.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- printf "%s-%s" .Release.Name .Values.opendj.name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s-%s" .Release.Name $name .Values.opendj.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create the name of the service account to use for the opendj component
*/}}
{{- define "gluu.serviceAccountName.opendj" -}}
{{- if .Values.serviceAccounts.opendj.create -}}
    {{ default (include "gluu.opendj.fullname" .) .Values.serviceAccounts.opendj.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccounts.opendj.name }}
{{- end -}}
{{- end -}}

{{/*
Create a fully qualified oxauth name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "gluu.oxauth.fullname" -}}
{{- if .Values.oxauth.fullnameOverride -}}
{{- .Values.oxauth.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- printf "%s-%s" .Release.Name .Values.oxauth.name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s-%s" .Release.Name $name .Values.oxauth.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create the name of the service account to use for the oxauth component
*/}}
{{- define "gluu.serviceAccountName.oxauth" -}}
{{- if .Values.serviceAccounts.oxauth.create -}}
    {{ default (include "gluu.oxauth.fullname" .) .Values.serviceAccounts.oxauth.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccounts.oxauth.name }}
{{- end -}}
{{- end -}}

{{/*
Create a fully qualified oxtrust name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "gluu.oxtrust.fullname" -}}
{{- if .Values.oxtrust.fullnameOverride -}}
{{- .Values.oxtrust.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- printf "%s-%s" .Release.Name .Values.oxtrust.name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s-%s" .Release.Name $name .Values.oxtrust.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create the name of the service account to use for the oxtrust component
*/}}
{{- define "gluu.serviceAccountName.oxtrust" -}}
{{- if .Values.serviceAccounts.oxtrust.create -}}
    {{ default (include "gluu.oxtrust.fullname" .) .Values.serviceAccounts.oxtrust.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccounts.oxtrust.name }}
{{- end -}}
{{- end -}}

{{/*
Create a fully qualified config name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "gluu.config.fullname" -}}
{{- if .Values.config.fullnameOverride -}}
{{- .Values.config.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- printf "%s-%s" .Release.Name .Values.config.name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s-%s" .Release.Name $name .Values.config.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create the name of the service account to use for the config component
*/}}
{{- define "gluu.serviceAccountName.config" -}}
{{- if .Values.serviceAccounts.config.create -}}
    {{ default (include "gluu.config.fullname" .) .Values.serviceAccounts.oxtconfigrust.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccounts.config.name }}
{{- end -}}
{{- end -}}
