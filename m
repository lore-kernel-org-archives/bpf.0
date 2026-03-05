Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5703221F20
	for <bpf@vger.kernel.org>; Thu,  5 Mar 2026 23:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772751979; cv=pass; b=YRCoFHfCsB63vtztiszRmDr8PzQTJBMXe43c0KoC91g99YHTxhsu19YPg+EIF67RMbK4ui+P1i9ecX5N82GRkHVRyoaGucTNpD3ClEtAEeW8ynJzJ+jwZuoN4UPQvEpCrv3LCXoyMeT/QbNrZZrONWwDev0MfOl+Iap/O5/UUdc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772751979; c=relaxed/simple;
	bh=Z3Ees2z5ATfJI51o0fHL7dEjaFolQWw1S0Cv0DlzVCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PCTQQMyEe7wp8CUq71NJqVYEd+S1lYnlxMY7UdZvWloDrzt9vcic/n2LiGrp2c9Z4NPJbkOpFpQe0ToU+S9cbRVF5IGZzE+2kTlS8vlpy3otwF6kqspTS1ZndtkP9WhC/mMXSfaaOFdhhFB7ph45fwnYkXbBMCP6MIoz/G9cntk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yr5+631R; arc=pass smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yr5+631R"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3597b474cbdso3076133a91.1
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 15:06:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772751977; cv=none;
        d=google.com; s=arc-20240605;
        b=FCziAcWtChbF54hXadzd64TmATqwvhnxJ0L91ouRMRyqLT/GSMUAZ6fgYlpfVRv7kG
         /zJeCwHy9hl1su8s2u2kNyKXpQIiYLuuB4uWVXt/o+JvjufsiYZ1eEQrjUtQViPVgtSH
         Jy2IKqWQAiIVShw+ueUw45K0RarnGVZ+Py0n7RasQBoReuCVcpi9YBb6RqbtazQXRi0f
         P8T58G8D6IqZKT4La3rWzwCcGQ3IIf4iXpoyHSoz/Apvck4bUQcVLDeXgJwJfRifJ5G+
         sGRqC4cio89BfluWOAfYiFQyP+ZO1dYHsh64BarukJZDPsFCGalHxAUFlD9FSR5c+hQJ
         7ZeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jRbFECNCewN24rk8zlpCKK6tQRfLEuXg+J0gHWhvyX0=;
        fh=JTlkmD1MYWXt1XMmJU9pKdqdO8edwx0mpL0T2uUqQCE=;
        b=aNyq/PE66Gljs+fGajnwT28LWNyJvpTojNH9qwZVwYMx5q4HUJ6AxHiqUpXO/4iowc
         Gxt/5c8/nYmv7BbX/KOYRaplOVhS/nmogscJkrWsjf7AzeG4ZcXQLJdNfcKTweTS31+2
         x3DFBDzD5xLaVNxMhWYYhzDcfifKulPQc2xOgvaSir2aOjd3rbG0wjoOg9eypnT+g/NJ
         0Ej/gFM78nK8Vs+yK0GkQFE27WltlPh25UwpQMZ5bPVMqtTcxv2bN6DbmY7rUjyzsUV4
         qYaMhoiu0RyCDeujdBlDRFtRUEcmTxu28qRMgy45cZDkDtTV7KxsufKV3foUGTYrsSyw
         c79w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772751977; x=1773356777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jRbFECNCewN24rk8zlpCKK6tQRfLEuXg+J0gHWhvyX0=;
        b=Yr5+631RQsGcoUJ7FMsBOpECAYz11QLYheEhJxIvTec8qvrmKiyF3uER+OUKISOenY
         HRhCV6TJFQfW6cvqG8fwQ8YDiKFxhFIEs/zBU53YWo+1+kGUBAlGhISItuqoRdIvcvtP
         Oaw+yuzE8GxbyDwdPLa52zpQ9/pQRbZtQxng8AUEeQgJDeskmXwHIIY+IANpvSdz+ITc
         YASEbPRjk95ljb80Yn22Xi9oSc8E8yligIG5S9aoU3Cw4m1dE+wPkO3R7iAMkTUKsW3u
         2I4azm9DFBMSkjachAMBtdndrxhJKWLIgCOwGmFBVtwjGi305naiPg9YT4Va+Guay+3Q
         f+pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772751977; x=1773356777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jRbFECNCewN24rk8zlpCKK6tQRfLEuXg+J0gHWhvyX0=;
        b=OkXTA+95xmX8W+InTPzIsOmnSlN7TNJjDcA0v+2xzuo0JNmnkQ/zVE3kHH1peYyoAs
         lcHhpwOBufOcsvVw/+/pWE++0ssso88td0ZqiRxPrS2UvvoOFdg8A08Y5805PNwb2nAo
         t/NC7YkgowQ/Aa9yH1av4iM1xyY6pyJYzIsCxICVKrLB3in5eW/t0rFSHf6PTIZaYpb8
         e77hfgiyzU/kGLvFNZtS0IPlelop3n8F+UAnWbCStxM1EVPowU1DyGxESiXLUUA3d7oB
         P2gEeIyccUuwEmJrLANUMEqRFNHqb2KvVSgqDo3z/XpjPwDHfhpABc1BpAeQz3+N2R75
         UOYQ==
X-Gm-Message-State: AOJu0YybNMCEL7DU7U4IK1PifUOE6rq5wKg5nGeJODVuXjQKVcLIQTVE
	TTq62XdDvF4VPfPu7/MJWPPFnbTdWDVccsj4ZcI1RY8mkJ08fYPBvU24SLD90ma6h6NNQ82BUkr
	k97L2Kfw2L/KO1DhZWgwBOJnTehHplfiKnw==
X-Gm-Gg: ATEYQzy573JauCzJWep8UJFYPaCR90tySYzXfkGWccIAWamTUycQI+YdPUHiCeUzakL
	odQchsegQLK+Wx5xHMYxzpvNmSzQBzB9laB8wPjwWjmONe1JIsQInOQN2quz1awICJ9w0y0Pwt1
	oJwYVrsHOrtqnOpa//0FmFZ0wHQYcB8QiS1enyM7OZwuAEO9IwOm0KNLEZnPK/b5+CNLJP6RFLd
	L++bKgLfHhussN/2As9lQhDKLelOJyp6PA+aCOHuHeLqPjwxHqosvxuW6K3E1kJv6eL4G+sG7zO
	CqWZPGwQutUATwjTRN7tWIA=
X-Received: by 2002:a17:90b:4ac7:b0:359:7fe6:7de with SMTP id
 98e67ed59e1d1-359be3736e7mr36455a91.23.1772751977019; Thu, 05 Mar 2026
 15:06:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1772657690.git.josef@toxicpanda.com> <b19c2760ffe48cec546dd3810d237f8cad20d606.1772657690.git.josef@toxicpanda.com>
In-Reply-To: <b19c2760ffe48cec546dd3810d237f8cad20d606.1772657690.git.josef@toxicpanda.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 5 Mar 2026 15:06:04 -0800
X-Gm-Features: AaiRm50qcW5_9yuZPgBx6_vDAJ5UpKosuB3HJUmntuSMai3sEKnf1thHelyI_7Q
Message-ID: <CAEf4BzZMOCApZXtku9AA=8o517x5OezPJNZUKmBMjDRTgqGGXA@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] bpftool: support merging multiple module BTFs in
 btf dump
To: Josef Bacik <josef@toxicpanda.com>
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 4, 2026 at 12:57=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> Add support for specifying multiple file sources in 'bpftool btf dump'
> to generate a single C header containing types from vmlinux plus
> multiple kernel modules:
>
>   bpftool btf dump file /sys/kernel/btf/mod1 file /sys/kernel/btf/mod2 fo=
rmat c
>
> This is useful for BPF programs that need to access types defined in
> kernel modules. Previously this required a separate bpftool invocation
> for each module, producing separate headers that could not be combined
> due to overlapping vmlinux type definitions.
>
> The implementation collects all file paths, then for the multi-file
> case creates an empty split BTF on the vmlinux base and iteratively
> merges each module's types into it via btf__add_btf(). The single-file
> code path is preserved exactly to avoid any regression risk.
>
> Auto-detection of vmlinux as the base BTF from sysfs paths works as
> before. If vmlinux itself appears in the file list it is skipped with
> a warning since its types are already provided by the base.
>
> Assisted-by: Claude:claude-opus-4-6
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  .../bpf/bpftool/Documentation/bpftool-btf.rst |  11 +-
>  tools/bpf/bpftool/bash-completion/bpftool     |   6 +-
>  tools/bpf/bpftool/btf.c                       | 132 ++++++++++++++++--
>  3 files changed, 132 insertions(+), 17 deletions(-)
>
> diff --git a/tools/bpf/bpftool/Documentation/bpftool-btf.rst b/tools/bpf/=
bpftool/Documentation/bpftool-btf.rst
> index d47dddc2b4ee..cf75a7fa2d6b 100644
> --- a/tools/bpf/bpftool/Documentation/bpftool-btf.rst
> +++ b/tools/bpf/bpftool/Documentation/bpftool-btf.rst
> @@ -27,7 +27,7 @@ BTF COMMANDS
>  | **bpftool** **btf dump** *BTF_SRC* [**format** *FORMAT*] [**root_id** =
*ROOT_ID*]
>  | **bpftool** **btf help**
>  |
> -| *BTF_SRC* :=3D { **id** *BTF_ID* | **prog** *PROG* | **map** *MAP* [{*=
*key** | **value** | **kv** | **all**}] | **file** *FILE* }
> +| *BTF_SRC* :=3D { **id** *BTF_ID* | **prog** *PROG* | **map** *MAP* [{*=
*key** | **value** | **kv** | **all**}] | **file** *FILE* [**file** *FILE*]=
... }
>  | *FORMAT* :=3D { **raw** | **c** [**unsorted**] }
>  | *MAP* :=3D { **id** *MAP_ID* | **pinned** *FILE* }
>  | *PROG* :=3D { **id** *PROG_ID* | **pinned** *FILE* | **tag** *PROG_TAG=
* | **name** *PROG_NAME* }
> @@ -58,9 +58,12 @@ bpftool btf dump *BTF_SRC* [format *FORMAT*] [root_id =
*ROOT_ID*]
>      When **prog** is provided, it's expected that program has associated=
 BTF
>      object with BTF types.
>
> -    When specifying *FILE*, an ELF file is expected, containing .BTF sec=
tion
> -    with well-defined BTF binary format data, typically produced by clan=
g or
> -    pahole.
> +    When specifying *FILE*, an ELF file or a raw BTF file (e.g. from
> +    ``/sys/kernel/btf/``) is expected.  Multiple **file** arguments may =
be
> +    given to merge BTF from several kernel modules into a single output.
> +    When sysfs paths are used, vmlinux BTF is loaded automatically as th=
e
> +    base; if vmlinux itself appears in the file list it is skipped.
> +    A base BTF can also be specified explicitly with **-B**.
>
>      **format** option can be used to override default (raw) output forma=
t. Raw
>      (**raw**) or C-syntax (**c**) output formats are supported. With C-s=
tyle
> diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftoo=
l/bash-completion/bpftool
> index a28f0cc522e4..babb0d4e9753 100644
> --- a/tools/bpf/bpftool/bash-completion/bpftool
> +++ b/tools/bpf/bpftool/bash-completion/bpftool
> @@ -961,10 +961,14 @@ _bpftool()
>                          *)
>                              # emit extra options
>                              case ${words[3]} in
> -                                id|file)
> +                                id)
>                                      COMPREPLY=3D( $( compgen -W "root_id=
" -- "$cur" ) )
>                                      _bpftool_once_attr 'format'
>                                      ;;
> +                                file)
> +                                    COMPREPLY=3D( $( compgen -W "root_id=
 file" -- "$cur" ) )
> +                                    _bpftool_once_attr 'format'
> +                                    ;;
>                                  map|prog)
>                                      if [[ ${words[3]} =3D=3D "map" ]] &&=
 [[ $cword =3D=3D 6 ]]; then
>                                          COMPREPLY+=3D( $( compgen -W "ke=
y value kv all" -- "$cur" ) )
> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> index 946612029dee..c44e86a64760 100644
> --- a/tools/bpf/bpftool/btf.c
> +++ b/tools/bpf/bpftool/btf.c
> @@ -28,6 +28,7 @@
>  #define FASTCALL_DECL_TAG      "bpf_fastcall"
>
>  #define MAX_ROOT_IDS           16
> +#define MAX_BTF_FILES          64
>
>  static const char * const btf_kind_str[NR_BTF_KINDS] =3D {
>         [BTF_KIND_UNKN]         =3D "UNKNOWN",
> @@ -878,6 +879,49 @@ static bool btf_is_kernel_module(__u32 btf_id)
>         return btf_info.kernel_btf && strncmp(btf_name, "vmlinux", sizeof=
(btf_name)) !=3D 0;
>  }
>
> +static struct btf *merge_btf_files(const char **files, int nr_files,
> +                                  struct btf *vmlinux_base)
> +{
> +       struct btf *combined, *mod;
> +       int ret;
> +
> +       combined =3D btf__new_empty_split(vmlinux_base);
> +       if (!combined) {
> +               p_err("failed to create combined BTF: %s",
> +                     strerror(errno));
> +               return NULL;
> +       }
> +
> +       for (int j =3D 0; j < nr_files; j++) {
> +               mod =3D btf__parse_split(files[j], vmlinux_base);
> +               if (!mod) {
> +                       p_err("failed to load BTF from %s: %s",
> +                             files[j], strerror(errno));

this fits even under 80 characters...

> +                       btf__free(combined);
> +                       return NULL;
> +               }
> +
> +               ret =3D btf__add_btf(combined, mod);
> +               btf__free(mod);
> +               if (ret < 0) {
> +                       p_err("failed to merge BTF from %s: %s",
> +                             files[j], strerror(-ret));

this is under 100

> +                       btf__free(combined);
> +                       return NULL;
> +               }
> +       }
> +
> +       ret =3D btf__dedup(combined, NULL);
> +       if (ret) {
> +               p_err("failed to dedup combined BTF: %s",
> +                     strerror(-ret));

ditto

> +               btf__free(combined);
> +               return NULL;
> +       }
> +
> +       return combined;
> +}
> +
>  static int do_dump(int argc, char **argv)
>  {
>         bool dump_c =3D false, sort_dump_c =3D true;
> @@ -958,20 +1002,83 @@ static int do_dump(int argc, char **argv)
>                 NEXT_ARG();
>         } else if (is_prefix(src, "file")) {
>                 const char sysfs_prefix[] =3D "/sys/kernel/btf/";
> +               struct btf *vmlinux_base =3D base_btf;
> +               const char *files[MAX_BTF_FILES];
> +               int nr_files =3D 0;
>
> -               if (!base_btf &&
> -                   strncmp(*argv, sysfs_prefix, sizeof(sysfs_prefix) - 1=
) =3D=3D 0 &&
> -                   strcmp(*argv, sysfs_vmlinux) !=3D 0)
> -                       base =3D get_vmlinux_btf_from_sysfs();
> -
> -               btf =3D btf__parse_split(*argv, base ?: base_btf);
> -               if (!btf) {
> -                       err =3D -errno;
> -                       p_err("failed to load BTF from %s: %s",
> -                             *argv, strerror(errno));
> -                       goto done;
> +               /* First grab our argument, filtering out the sysfs_vmlin=
ux. */
> +               if (strcmp(*argv, sysfs_vmlinux) !=3D 0) {
> +                       files[nr_files++] =3D *argv;
> +               } else {
> +                       p_info("skipping %s (will be loaded as base)",
> +                              *argv);

I mean... why is your Claude so frugal with per-line characters?

(fixed all this and a bunch more below)

pushed to bpf-next

>                 }
>                 NEXT_ARG();
> +
> +               while (argc && is_prefix(*argv, "file")) {
> +                       NEXT_ARG();
> +                       if (!REQ_ARGS(1)) {
> +                               err =3D -EINVAL;
> +                               goto done;
> +                       }
> +                       /* Filter out any sysfs vmlinux entries. */
> +                       if (strcmp(*argv, sysfs_vmlinux) =3D=3D 0) {
> +                               p_info("skipping %s (will be loaded as ba=
se)",
> +                                      *argv);
> +                               NEXT_ARG();
> +                               continue;
> +                       }
> +                       if (nr_files >=3D MAX_BTF_FILES) {
> +                               p_err("too many BTF files (max %d)",
> +                                     MAX_BTF_FILES);
> +                               err =3D -E2BIG;
> +                               goto done;
> +                       }
> +                       files[nr_files++] =3D *argv;
> +                       NEXT_ARG();
> +               }
> +
> +               /* Auto-detect vmlinux base if any file is from sysfs */
> +               if (!vmlinux_base) {
> +                       for (int j =3D 0; j < nr_files; j++) {
> +                               if (strncmp(files[j], sysfs_prefix,
> +                                           sizeof(sysfs_prefix) - 1) =3D=
=3D 0) {
> +                                       base =3D get_vmlinux_btf_from_sys=
fs();
> +                                       vmlinux_base =3D base;
> +                                       break;
> +                               }
> +                       }
> +               }
> +
> +               /* All files were the sysfs_vmlinux, handle it like we us=
ed to */
> +               if (nr_files =3D=3D 0) {
> +                       nr_files =3D 1;
> +                       files[0] =3D sysfs_vmlinux;
> +               }
> +
> +               if (nr_files =3D=3D 1) {
> +                       btf =3D btf__parse_split(files[0],
> +                                              base ?: base_btf);
> +                       if (!btf) {
> +                               err =3D -errno;
> +                               p_err("failed to load BTF from %s: %s",
> +                                     files[0], strerror(errno));
> +                               goto done;
> +                       }
> +               } else {
> +                       if (!vmlinux_base) {
> +                               p_err("base BTF is required when merging =
multiple BTF files; use -B/--base-btf or use sysfs paths");
> +                               err =3D -EINVAL;
> +                               goto done;
> +                       }
> +
> +                       btf =3D merge_btf_files(files, nr_files,
> +                                             vmlinux_base);
> +                       if (!btf) {
> +                               err =3D -errno;
> +                               goto done;
> +                       }
> +               }
>         } else {
>                 err =3D -1;
>                 p_err("unrecognized BTF source specifier: '%s'", src);
> @@ -1445,7 +1552,8 @@ static int do_help(int argc, char **argv)
>                 "       %1$s %2$s dump BTF_SRC [format FORMAT] [root_id R=
OOT_ID]\n"
>                 "       %1$s %2$s help\n"
>                 "\n"
> -               "       BTF_SRC :=3D { id BTF_ID | prog PROG | map MAP [{=
key | value | kv | all}] | file FILE }\n"
> +               "       BTF_SRC :=3D { id BTF_ID | prog PROG | map MAP [{=
key | value | kv | all}] |\n"
> +               "                    file FILE [file FILE]... }\n"
>                 "       FORMAT  :=3D { raw | c [unsorted] }\n"
>                 "       " HELP_SPEC_MAP "\n"
>                 "       " HELP_SPEC_PROGRAM "\n"
> --
> 2.53.0
>
>
