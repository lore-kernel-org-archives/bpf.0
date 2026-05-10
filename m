Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6875282F24;
	Sun, 10 May 2026 03:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778384262; cv=none; b=Cj2iIRoJMcNloTr49IrXMQyPur2pcW7p2XAhZhmugd7NS9vk/aJsPHU2hjl+ClHM6TFqL12aG75TfrafMIMrW6hSv7kAdjmHy/SiRxJcR4+1Ko5bOcquPpUNEtM2Syxzfxrmojj4HYXFPvIYPp4I/zMXm+kE06TTS61Ya5Kv9Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778384262; c=relaxed/simple;
	bh=EAgzwamQDWcbg+us06raC3tmZM4WWg/EnjcQAm3h8GQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=qOqctr3orV/jBARK8IbjHcspsrIUwKZBl7KEiz6ct2AKVb/zoLX8C8Iz9TvvbNh84IX2xzyJAags7nqHFKQTaP7+eBP/F1lkg6M41eyupCYHrSCg00AAxYA03ONq5j48j5CmLWxHLkD1qquG+SqXmi5487kK8yZf88beZMB4/40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sUiW2Q5w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sUiW2Q5w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3872AC2BCB8;
	Sun, 10 May 2026 03:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778384262;
	bh=EAgzwamQDWcbg+us06raC3tmZM4WWg/EnjcQAm3h8GQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=sUiW2Q5wYnb46NQLTp85qwXk+msKtfj1shtAmAoEFE5Zf0kwap60jVwKbEdMmZgvK
	 zoNSvcOeiHGX6opPwBAtW7RiD4gsj2syBqhtDUJ7IEm5/jrHlFbnrM8Ojd1lNhps6s
	 1UAee8OFn/KF/D0JJhYu+iWHojlwzFfEpdVkuZp20q0fZJhlsYOk61V0Ux5XjHaU/g
	 vtspSvt3AwNrr0C4u+qAfarHZ4UbSzwnuIVW90IVwg8gDu577xew1Y8YotbzFn4hzI
	 WCqBVDseQvOXOGzcLRUA71pNN36scfBKxcFNOAKihf6Y++2eq30gOVCdDkKN29r/lY
	 qYA67yY8svI/A==
Content-Type: multipart/mixed; boundary="===============3160110146962498715=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <94121dde23acce08992f446a4e3321b6c48b3f833f8b00c181485bcd6de63d87@mail.kernel.org>
In-Reply-To: <20260510030147.27900-1-chensong_2000@126.com>
References: <20260510030147.27900-1-chensong_2000@126.com>
Subject: Re: [PATCH V2 2/2] kernel/bpf/verifier: Support module kfunc resolution via instruction offset
From: bot+bpf-ci@kernel.org
To: chensong_2000@126.com,andrii@kernel.org,eddyz87@gmail.com,ast@kernel.org,daniel@iogearbox.net,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,alexei.starovoitov@gmail.com
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,chensong_2000@126.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun, 10 May 2026 03:37:42 +0000 (UTC)

--===============3160110146962498715==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> old mode 100644
> new mode 100755

Should this file really be made executable? Kernel source files should
not have the executable bit set. This appears to be an accidental
file mode change.

> index 11054ad89c14..7c7441cc3c2e
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -2734,7 +2735,16 @@ int bpf_add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, u16 offset)
>  	if (err)
>  		return err;
>
> -	addr = kallsyms_lookup_name(kfunc.name);
> +	if (offset) {
> +		struct bpf_kfunc_btf kf_btf = { .offset = offset };
> +		struct module *mod;
> +		struct bpf_kfunc_btf *b;
> +		b = bsearch(&kf_btf, btf_tab->descs, btf_tab->nr_descs,
> +            sizeof(btf_tab->descs[0]), kfunc_btf_cmp_by_off);
             ^^^^

The continuation line here uses spaces instead of tabs. Should this be
indented with tabs to match the kernel coding style?

> +		mod = b->module;
> +		addr = find_kallsyms_symbol_value(mod, kfunc.name);
> +	} else
> +		addr = kallsyms_lookup_name(kfunc.name);

The if branch uses braces for multiple statements, but the else branch
omits them. Does this match the expected style for the rest of the
file? The coding style guide suggests using braces on both branches
when one requires them.

>  	if (!addr) {
>  		verbose(env, "cannot find address for kernel function %s\n", kfunc.name);
>  		return -EINVAL;


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25618517155
--===============3160110146962498715==--
