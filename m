Received: from outbound.soverin.net (outbound.soverin.net [185.233.34.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D32D361DB1
	for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 11:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.233.34.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771847831; cv=none; b=pHxOJ6mRHRjRDnNqP5sxIMRB5cFu39ZJFLJKBnQ7Ll3wUjTxr9ufa50oeMwvUuiYCBmnHS6NH1UKQzbxF7TCG4JNfmxRD0benMPrdbcwqmlwXiufprCuml4OciiBotZnT1Ku4wLSmwYpLzX4TlG8Lp53aJ7smUYOcN/i4yNHtns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771847831; c=relaxed/simple;
	bh=fj5rlXzvXA/I1FVL19r/W0m9si/oEMfPmcHb7Z9p/70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HeXGaH9nkIXQi2mNAYnKhZe9AsuF0k5ZatZTdC3eKQ6gzyxUdQzuyPg+AzoxIZR1r97xo3i9aUs03zYNFQ15ez2CPnFbS/Vc/DkRC4ZtMEPBs55VEyTTP22Hqu9Q17RhZ98UACJDMNl1XFPlyli8FvGgmu/+8yi2F+NutsLCxBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qmon.net; spf=pass smtp.mailfrom=qmon.net; dkim=pass (2048-bit key) header.d=qmon.net header.i=@qmon.net header.b=MIvQEalq; arc=none smtp.client-ip=185.233.34.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qmon.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qmon.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qmon.net header.i=@qmon.net header.b="MIvQEalq"
Received: from smtp.soverin.net (unknown [10.10.4.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by outbound.soverin.net (Postfix) with ESMTPS id 4fKK1H3xqJz74;
	Mon, 23 Feb 2026 11:50:43 +0000 (UTC)
Received: from smtp.soverin.net (smtp.soverin.net [10.10.4.99]) by soverin.net (Postfix) with ESMTPSA id 4fKK1H0m0Zz6Z;
	Mon, 23 Feb 2026 11:50:43 +0000 (UTC)
Authentication-Results: smtp.soverin.net;
	dkim=pass (2048-bit key; unprotected) header.d=qmon.net header.i=@qmon.net header.a=rsa-sha256 header.s=soverin1 header.b=MIvQEalq;
	dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qmon.net; s=soverin1;
	t=1771847443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T4/NovDbZ2I9QifLn7WexZcRbDHVjCtbNjJS4GwkFe4=;
	b=MIvQEalq/TD+AgwMDY4QKaeIFOmrUA6WsXULr3udraLpdh1i0KJV5zVnYHcS1JuFaYM5dL
	q+C0P5Y4vm0JbUBrBMbq8mHlzdTiFIVt8OXhWwt6WSUz1JFeH6eval10eJDs/LgfnfEQVD
	jNfVXM9a1xypboNMRfHekFxKN6jSWZXyOHaHJMak+Mvaumtq6IJ/1TcZwzYyb9hqO2a++l
	3RgV103Mac7p0j/EqZfrrpIoGgEDRGmDztpJ+qrYzCgcgjKsODENrQ/m0GzQll7eA7EYl1
	e9SOCvgKGza4M3BMlwZHCPxiCgBu+3e+ZG85QaByPuNRNZCxTX1htTuw+pphfw==
X-CMAE-Score: 0
X-CM-Analysis: v=2.4 cv=UsCZN/wB c=1 sm=1 tr=0 ts=699c3f13 a=vzOQIoBu8N4nb49veeH0EQ==:617 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=maIFttP_AAAA:8 a=6gl_cCoBAAAA:8 a=Cj_RZmtuHQ-gFTPhAEIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=qR24C9TJY6iBuJVj_x8Y:22 a=Bor9z-CvbNo2M6AZn8_k:22
X-CM-Envelope: MS4xfJZreZIgfFxW893SbxiHgPc/ht2RA++5efAq7NJZmsPFyuuc4YqLmK71jSrRtPp3HN5rUaL6/AHfWnZfIbYRQOjGIb5Nm0UMrIdEYYd95Wphy2YLUnor 5NVLi1c4gLRaldA8iD9W69j+hOT/O2bwCJOUFrgusjno5zhvhc7lHXdYDZwaGwzCBsMoRuDV6TvbMqwd3QUTnw6tFRkeGW66l9SFZe18ukdcINLluWVm5c/N wUOXuxT9SSeimsJmH4/mZphoPNlt31CzicCcM5UpX+lFtPAczaDiDeMdDNhNEdFqAyzrP6LmqSiyF7TJWe41jAKu9WI8veU6TbdpjSxVMzu8+fglhCJKGlwv mBl7aHlS
X-Soverin-Id: 019c8a56-6238-7530-8219-f0377e53833e
Message-ID: <4ccb0ad0-3e50-4548-b8d6-e2d7e93b3dad@qmon.net>
Date: Mon, 23 Feb 2026 11:50:42 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 2/3] bpftool: support merging multiple module BTFs in
 btf dump
To: Josef Bacik <josef@toxicpanda.com>, bpf@vger.kernel.org
Cc: Alan Maguire <alan.maguire@oracle.com>
References: <cover.1771625484.git.josef@toxicpanda.com>
 <d04e23314b04024a61fe295dfd28a0f215a6449b.1771625484.git.josef@toxicpanda.com>
From: Quentin Monnet <qmo@qmon.net>
Content-Language: en-GB
In-Reply-To: <d04e23314b04024a61fe295dfd28a0f215a6449b.1771625484.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spampanel-Class: ham

2026-02-20 17:43 UTC-0500 ~ Josef Bacik <josef@toxicpanda.com>
> Add support for specifying multiple file sources in 'bpftool btf dump'
> to generate a single C header containing types from vmlinux plus
> multiple kernel modules:
> 
>   bpftool btf dump file /sys/kernel/btf/mod1 file /sys/kernel/btf/mod2 format c
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
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>


Thanks for this patch!


> Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>


Looking at Documentation/process/coding-assistants.rst and git logs, I
believe this tag should be like "Assisted-by: Claude:claude-opus-4-6".
(Same for other patches in the series.)


> ---
>  tools/bpf/bpftool/btf.c | 135 ++++++++++++++++++++++++++++++++++++----
>  1 file changed, 122 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> index 946612029dee..16bc1332639f 100644
> --- a/tools/bpf/bpftool/btf.c
> +++ b/tools/bpf/bpftool/btf.c
> @@ -28,6 +28,7 @@
>  #define FASTCALL_DECL_TAG	"bpf_fastcall"
>  
>  #define MAX_ROOT_IDS		16
> +#define MAX_BTF_FILES		64
>  
>  static const char * const btf_kind_str[NR_BTF_KINDS] = {
>  	[BTF_KIND_UNKN]		= "UNKNOWN",
> @@ -958,20 +959,127 @@ static int do_dump(int argc, char **argv)
>  		NEXT_ARG();
>  	} else if (is_prefix(src, "file")) {
>  		const char sysfs_prefix[] = "/sys/kernel/btf/";
> +		const char *files[MAX_BTF_FILES];
> +		int nr_files = 0;
>  
> -		if (!base_btf &&
> -		    strncmp(*argv, sysfs_prefix, sizeof(sysfs_prefix) - 1) == 0 &&
> -		    strcmp(*argv, sysfs_vmlinux) != 0)
> -			base = get_vmlinux_btf_from_sysfs();
> -
> -		btf = btf__parse_split(*argv, base ?: base_btf);
> -		if (!btf) {
> -			err = -errno;
> -			p_err("failed to load BTF from %s: %s",
> -			      *argv, strerror(errno));
> -			goto done;
> -		}
> +		files[nr_files++] = *argv;
>  		NEXT_ARG();
> +
> +		/* Collect additional file arguments. Use strcmp (exact match)
> +		 * to avoid ambiguity with file paths that are prefixes of
> +		 * "file" (e.g., "./f").
> +		 */


I don't understand why we'd remove subcommand prefixing here, each file
name should be preceded with the "file" keyword so from command parsing,
there's no ambiguity?


> +		while (argc && strcmp(*argv, "file") == 0) {
> +			NEXT_ARG();
> +			if (!REQ_ARGS(1)) {
> +				err = -EINVAL;
> +				goto done;
> +			}
> +			if (nr_files >= MAX_BTF_FILES) {
> +				p_err("too many BTF files (max %d)",
> +				      MAX_BTF_FILES);
> +				err = -E2BIG;
> +				goto done;
> +			}
> +			files[nr_files++] = *argv;
> +			NEXT_ARG();
> +		}
> +
> +		if (nr_files == 1) {
> +			/* Single file — preserve existing behavior exactly */


I guess Claude inserted this comment. Please use a regular dash, there's
no need to turn the file into UTF-8 for this (or remove the comment).


> +			if (!base_btf &&
> +			    strncmp(files[0], sysfs_prefix,
> +				    sizeof(sysfs_prefix) - 1) == 0 &&
> +			    strcmp(files[0], sysfs_vmlinux) != 0)
> +				base = get_vmlinux_btf_from_sysfs();
> +
> +			btf = btf__parse_split(files[0], base ?: base_btf);
> +			if (!btf) {
> +				err = -errno;
> +				p_err("failed to load BTF from %s: %s",
> +				      files[0], strerror(errno));
> +				goto done;
> +			}
> +		} else {


That's quite a lot of processing in the middle of the argument parsing
code, I wouldn't mind having this as a separate function.


> +			struct btf *vmlinux_base = base_btf;
> +			struct btf *combined, *mod;
> +			int j, ret;
> +
> +			/* Auto-detect vmlinux base from sysfs if needed */
> +			if (!vmlinux_base) {
> +				for (j = 0; j < nr_files; j++) {
> +					if (strncmp(files[j], sysfs_prefix,
> +						    sizeof(sysfs_prefix) - 1) == 0 &&
> +					    strcmp(files[j], sysfs_vmlinux) != 0) {
> +						base = get_vmlinux_btf_from_sysfs();
> +						vmlinux_base = base;
> +						break;
> +					}
> +				}
> +			}
> +			if (!vmlinux_base) {
> +				p_err("base BTF is required when merging multiple BTF files; use -B/--base-btf or use sysfs paths");
> +				err = -EINVAL;
> +				goto done;
> +			}
> +
> +			/* Filter out vmlinux from the file list */
> +			for (j = 0; j < nr_files; j++) {
> +				if (strcmp(files[j], sysfs_vmlinux) == 0) {
> +					p_info("skipping %s (already loaded as base)",
> +					       sysfs_vmlinux);
> +					memmove(&files[j], &files[j + 1],
> +						(nr_files - j - 1) * sizeof(files[0]));
> +					nr_files--;
> +					j--;
> +				}
> +			}
> +			if (nr_files == 0) {
> +				p_err("no module BTF files to merge (all paths were vmlinux)");
> +				err = -EINVAL;
> +				goto done;
> +			}
> +
> +			combined = btf__new_empty_split(vmlinux_base);
> +			if (!combined) {
> +				err = -errno;
> +				p_err("failed to create combined BTF: %s",
> +				      strerror(-err));
> +				goto done;
> +			}
> +
> +			for (j = 0; j < nr_files; j++) {
> +				mod = btf__parse_split(files[j], vmlinux_base);
> +				if (!mod) {
> +					err = -errno;
> +					p_err("failed to load BTF from %s: %s",
> +					      files[j], strerror(-err));
> +					btf__free(combined);
> +					goto done;
> +				}
> +
> +				ret = btf__add_btf(combined, mod);
> +				btf__free(mod);
> +				if (ret < 0) {
> +					p_err("failed to merge BTF from %s: %s",
> +					      files[j], strerror(-ret));
> +					btf__free(combined);
> +					err = ret;
> +					goto done;
> +				}
> +			}
> +
> +			ret = btf__dedup(combined, NULL);
> +			if (ret) {
> +				p_err("failed to dedup combined BTF: %s",
> +				      strerror(-ret));
> +				btf__free(combined);
> +				err = ret;
> +				goto done;
> +			}
> +
> +			btf = combined;
> +		}
>  	} else {
>  		err = -1;
>  		p_err("unrecognized BTF source specifier: '%s'", src);
> @@ -1445,7 +1553,8 @@ static int do_help(int argc, char **argv)
>  		"       %1$s %2$s dump BTF_SRC [format FORMAT] [root_id ROOT_ID]\n"
>  		"       %1$s %2$s help\n"
>  		"\n"
> -		"       BTF_SRC := { id BTF_ID | prog PROG | map MAP [{key | value | kv | all}] | file FILE }\n"
> +		"       BTF_SRC := { id BTF_ID | prog PROG | map MAP [{key | value | kv | all}] |\n"
> +		"                    file FILE [file FILE]... }\n"


As Alan said, can you please update the related man page? There's the
command summary at the top, and then the command description to update.

Can you please also update bash-completion/bpftool? You could use:

    diff --git i/tools/bpf/bpftool/bash-completion/bpftool w/tools/bpf/bpftool/bash-completion/bpftool
    index a28f0cc522e4..babb0d4e9753 100644
    --- i/tools/bpf/bpftool/bash-completion/bpftool
    +++ w/tools/bpf/bpftool/bash-completion/bpftool
    @@ -961,10 +961,14 @@ _bpftool()
                             *)
                                 # emit extra options
                                 case ${words[3]} in
    -                                id|file)
    +                                id)
                                         COMPREPLY=( $( compgen -W "root_id" -- "$cur" ) )
                                         _bpftool_once_attr 'format'
                                         ;;
    +                                file)
    +                                    COMPREPLY=( $( compgen -W "root_id file" -- "$cur" ) )
    +                                    _bpftool_once_attr 'format'
    +                                    ;;
                                     map|prog)
                                         if [[ ${words[3]} == "map" ]] && [[ $cword == 6 ]]; then
                                             COMPREPLY+=( $( compgen -W "key value kv all" -- "$cur" ) )


Thanks,
Quentin
