Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794440037;
	b=ZfbisPgtINSprN/alSa/NRBQDOz5WaoogFxTcwWEIcDJKQr/BT8AGC4l2Pz+IyU+uNv4
	 L6s2uxjOLFGhteGFGbmEIwTA6/iPCbV1WF9dy7o3omVyv3jqkTq7u8h7fiPGjzI/7Y+uF
	 4kTUUlLd4UKIwr7ZCMPvSh8m9JOudGRlIaueB+Fra0q4ltwiElN4kNUwB7ruKe7PXPFOK
	 0s4A07SB3HGTbkKYyf9mp4tUxIuiPFfbuzNeUpUpleJYf/VMkzTYxcDfzYNtg2CCivLEz
	 U2jEuU9XxifsU0zEJoBD17kxhO8HIAJn49Ci07ZW0xmysu9qHL+0Vr5dKWzQX03Iu+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794440037;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=F/OlDFQVTHa/HqTgHT3xJ6pLof0fezmulOfP0vkr8Hk=;
	b=uO5hmu+ifK0v710iqQvYee8g+MV26mzaQMrW+6Vpuu/BEFk00LB/XP8t4y7e2yAMZWV0
	 O3jgz38qHTICp8LfeiFeXQuixooIkSyU7J4RF+rge71aPhNm2r9Z3PIbhV+Ib6OF/Y3YK
	 JWRTH9Upzqk1ZqNuaWEzVrDzzjgEL3QjC+lmjgXjIKG0rYBS4EEOyoZYec+bntCtQVKcX
	 HFFfOFWVKvhtexEJ0mihC+2AVL7v0WHN4lc5SLEMdVltJWbNy2Dm3EJU5wUFrm5+HKSIe
	 jvbaFY5NoNu5L5C881++x4pg5YAnPzOZqrAMG9B2d4/5gWCI+92AoOOV9jHonCk44lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dUMv2gVi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CE7606A327;
	Wed, 11 Nov 2026 23:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dUMv2gVi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C957E1F00A05;
	Wed, 11 Nov 2026 23:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794440036;
	bh=F/OlDFQVTHa/HqTgHT3xJ6pLof0fezmulOfP0vkr8Hk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=dUMv2gVi4S1+5o680lSqLmtrZyt8TESvWzh4qz6rJrzK9Bd/LYIr1/xsobcq9F9uA
	 aHVyuOCOtpWzyI2awA+OcScSHbXZ+X85xbGBTD7OblNZhQcA9E9iBoFX22/bBT/lkv
	 k/hFEacwx6XTPk1kRPWED/2v/8wRPiP15dVmWrNPs+k28jiLh/3IUc36QNAmXTcive
	 Yy1WNge2cReeu7RhaDTiOpwRMu874xaGZw/VwVuBPztZKcQtTTWqsxePkJ6xIySuIS
	 yfmPb7iR8jROle9mEGZOBGndmTP+TB61gQTDSP2HgDVJbm1x21jEjxYI+WXlLao8/1
	 /2B0SVJaJ6ctQ==
Content-Type: multipart/mixed; boundary="===============5782755922972440684=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <8c6f9e7d8a4cb037b480c22ba2b6866133292bbd68ebdc777e385373950b793f@mail.kernel.org>
In-Reply-To: <20261111115911.1142000-3-david.laight.linux@gmail.com>
References: <20261111115911.1142000-3-david.laight.linux@gmail.com>
Subject: Re: [PATCH v3 next 02/13] scripts/kallsyms: Improve error reporting
From: bot+bpf-ci@kernel.org
To: david.laight.linux@gmail.com,pmladek@suse.com,kees@kernel.org,david.laight.linux@gmail.com,linux-kernel@vger.kernel.org,linux-kbuild@vger.kernel.org,bpf@vger.kernel.org,jim.cromie@gmail.com,ljs@kernel.org
Cc: mcgrof@kernel.org,andrey.grodzovsky@crowdstrike.com,rostedt@goodmis.org,andrii@kernel.org,wusamuel@google.com,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 11 Nov 2026 23:33:55 +0000 (UTC)

--===============5782755922972440684==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> scripts/kallsyms: Improve error reporting

TL;DR:
- Error message for failing to open the output file says "nin.out", likely a
  typo for "out.bin"
- usage() text for --all-symbols may be inaccurate: it covers all sections,
  not just local symbols

> diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
> --- a/scripts/kallsyms.c
> +++ b/scripts/kallsyms.c

[ ... ]

> @@ -822,6 +824,25 @@ static void sort_symbols(void)
>  	qsort(table, table_cnt, sizeof(table[0]), compare_symbols);
>  }
>  
> +static void usage(void)
> +{
> +	fprintf(stderr,
> +		"Usage: kallsyms [options] vmlinux out.bin > out.S\n"
> +		"       kallsyms --sysmap=out.map vmlinux\n"
> +		"           --all-symbols     Include all local symbols\n"

This isn't a bug, but is this description of --all-symbols accurate?

In symbol_valid() the option only disables the text range filter:

    if (!all_symbols) {
        ...
        if (symbol_in_range(s, text_ranges,
                            ARRAY_SIZE(text_ranges)) == 0)
            return 0;

so symbols from the data, rodata and bss sections are included, global and
local alike.  Local text symbols are already kept without the option.  This
also matches the CONFIG_KALLSYMS_ALL help text, "symbols from all sections".

Would something like "Include symbols from all sections, not only text" be
closer to what the code does?

[ ... ]

> @@ -845,49 +867,57 @@ int main(int argc, char **argv)
[ ... ]
>  	out_bin_name = argv[optind + 1];
>  	out_bin_file = fopen(out_bin_name, "w");
> -	if (!out_bin_file) {
> -		perror(out_bin_name);
> -		exit(EXIT_FAILURE);
> -	}
> +	if (!out_bin_file)
> +		err(EXIT_FAILURE, "failed to open nin.out file %s", out_bin_name);

Is "nin.out" a typo here?  usage() and the close-time message in main(),

    errx(EXIT_FAILURE, "error writing out.bin file %s", out_bin_name);

both call this file "out.bin".

The string is changed later in the series by 317dc01f3774 ("scripts/kallsyms:
make use of binary data output optional") to "failed to open bin.out file
%s", which still differs from the "out.bin" used by usage() and the
close-time message.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/43116767394
--===============5782755922972440684==--
