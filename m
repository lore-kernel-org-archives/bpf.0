Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BAD367294
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 14:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788187602; cv=none; b=cl96TVhxo2fQbIwtanDZySMKMgcRtAfIDkWR9g4AFZF1lWnsnlfou7jDDq4dv+WeIrX9tZjAJUYNcn55SuVm9eRV7FwAHNnGg4q+QjXX5Ep+riGBQSbJIAT0V7hd9rSRAtBvS+tJiXuYNud91rpTMd4W1PJpPpnbI3GxKCnHdh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788187602; c=relaxed/simple;
	bh=hhxCZOWE0m1CQmRr+lBi1twSJUyPrG9S1DZCHwPksqo=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=QqTK6jWEwyn81q9L7jE7SuMfntKO5HIowsaJl91A7KwKDJTKa/+aMsfwaOkIVr8ZHCLYYMCANzgpvQQyjOV1Bo1ONBWeoOMdB34eSWjfq0TxIql4lbGeaR4QU0pSCeL1K9ujqwx6sx8mf9/LtjOU13i+zypglPb8GfSTViRU1bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SfH3DFBj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SfH3DFBj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C249D1F000E9;
	Mon, 31 Aug 2026 14:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788187601;
	bh=6G57dBNp5Eehm5dZWjhQAy/acxLgMH0snVDB+CKSFNM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=SfH3DFBj8TgIVXIkIwBfpCwxFB5+N2RYaFhugeakEtGtfdfwy5bU6wpp0SFKBcdFA
	 ywGVtU9ZJlRuy6s6mV7M+bObLduryI+szugFDf5c0t2I1t00Z4DVMYqdZJmfRYSeOg
	 vslQkRKsMkkhv/iLXk/YXKyNBscp4yJAX1gWhN/p1aumthZcSX9D7Go8HpIgobeyyg
	 K9OtAA+9cpXReUTqB5qhsd/xwJDjFabW5Lm41s+MR7eT19lv/SEo0pFDJ7jZ6yLriM
	 pF/mrRKb5C/nAJI/6WEcgnw97xSNmV6hsvU/RRxnUaNqHA4gQTVlT1muBhK8Igdx9e
	 hD5h++nmwDBIw==
Content-Type: multipart/mixed; boundary="===============2441318220079674291=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0d8168d43d5376a1f7cd9cff27658ce299e03993b3c5181883e647ccdc7b506b@mail.kernel.org>
In-Reply-To: <20260831133809.1161-2-zhaofuyu@vivo.com>
References: <20260831133809.1161-2-zhaofuyu@vivo.com>
Subject: Re: [PATCH bpf-next v6 1/2] libbpf: support selective kernel module BTF loading via bpf_object_open_opts
From: bot+bpf-ci@kernel.org
To: zhaofuyu@vivo.com,bpf@vger.kernel.org
Cc: eddyz87@gmail.com,andrii.nakryiko@gmail.com,alan.maguire@oracle.com,zhaofuyu@vivo.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 31 Aug 2026 14:46:40 +0000 (UTC)

--===============2441318220079674291==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index b965ad5715403..1cabf7e465546 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -224,10 +224,32 @@ struct bpf_object_open_opts {
>  	 * point (/sys/fs/bpf), in case this default behavior is undesirable.
>  	 */
>  	const char *bpf_token_path;

[ ... ]

> +	/*
> +	 * Optional list of kernel module names whose BTFs should be loaded.
> +	 * nr_btf_module_names specifies the number of entries in
> +	 * btf_module_names.
> +	 *
> +	 * With btf_module_names:
> +	 * - when provided, only the BTFs of the specified modules are loaded;
> +	 * - when an empty list is provided, no module BTFs are loaded;
> +	 * - when NULL, all module BTFs are loaded as before.
> +	 *
> +	 * The list must contain valid, non-empty module names and must not
> +	 * contain duplicate entries; otherwise -EINVAL is returned.
> +	 *
> +	 * This affects:
> +	 * - BPF CO-RE relocations against types defined in modules;
> +	 * - BTF-based resolution of attach targets;
> +	 * - module-qualified tracing multi-attach targets;
> +	 * - struct_ops kernel type resolution;
> +	 * - extern (ksym) resolution for kernel symbols defined in modules.
> +	 */
> +	const char **btf_module_names;
> +	size_t nr_btf_module_names;
                      ^^
This isn't a bug, but would btf_module_cnt (or just cnt-style naming) fit
better here? The other opts structs in libbpf.h pair their arrays with a
cnt field: bpf_kprobe_multi_opts uses cnt, bpf_uprobe_multi_opts uses
cnt, and bpf_tracing_multi_opts uses cnt. This looks like the only nr_*
field in the public header, and the field name becomes part of the stable
public API once it ships.

>
>  	size_t :0;
>  };
> -#define bpf_object_open_opts__last_field bpf_token_path
> +#define bpf_object_open_opts__last_field nr_btf_module_names


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33399468751
--===============2441318220079674291==--
