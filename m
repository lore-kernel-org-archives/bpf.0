Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795223643;
	b=jBmpx79r3ma4ok+1mzmF9WXyZPgNpWMFzxbAUKMgHmWUZG1Cfv8hZ/QcDIu6lXxw6Tvs
	 xHG8Uz5T7W89fIB+XcvFiQNUhR+0F4ajDMlfE1FP5y25FklpSbajlpTw7CjDbzRjvmzLl
	 oMC2PBuCYeoHSBf8J8IqS88JfC174smdosBlPNGIB7lqMnVsd/YKBWah9fzQt31z+mKWE
	 GF2K+BAN2gHALjMUZQa+4g7W8Iinf1jqOSLFYFnkpaYD/PNOShdN8WjggHcRE/LgrNshx
	 zwsYev87MaJKADBn2Aiea1+itgJOyT+HAkQLjPR49rNqIqGVCIsB4gr33627IbV5DlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795223643;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=nIb5IDUYIl8DBaEEr7LZkXsa92bsTP3yu+JKyQjAJsU=;
	b=MFdJ/XiPlCofW6w75026rIxIxeM5I/uPk+AEmvX1PXzLXndA4qUGPb56SjYJIh9rVflA
	 tDm7nGLXbq52FnRlcrqKJWlhnLWdVwcQ5hzDMW7ErK/lkkis414fG/2IUMXj2zaIFYgQr
	 RbAPInFgzwCleH0gnihY1SedhD5S6oZGRFQ1AYSe65uQizt/7tQ2XSg8RO0X+tNI8Smnm
	 tPOHTmqzz9fY82c2hAU08Khs5N/qmnrtkFhsuKzF1OTnZpt4VMjayxYnlsuRyazEheCFG
	 5dNWzb/48JbX/6q/z4X82pOjg4Ikcmm10B3BGCH2oaXsBelv7sOE5AkIwZs5k0TLEzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=co1wYc1x;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDA5606A331;
	Sat, 21 Nov 2026 01:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=co1wYc1x
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 429A81F000C0;
	Sat, 21 Nov 2026 01:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795223643;
	bh=nIb5IDUYIl8DBaEEr7LZkXsa92bsTP3yu+JKyQjAJsU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=co1wYc1xoXBqz/LauO/xxEZdlxswoKIRIHjnUforOk9AyM11PyoYcTClM6v/sbP4y
	 PjOdG+pP0B5O6xAcGwXJPyvU0VEPf8UVsWfmLpgM6ByQjO0p1ZvgaiEWSXRILx5FHL
	 DGG0VIl2vnKwWmsuwL8+8c6ie7+naY5yCoVrGH5pc1DJMNTJquCwsPtW131YqjLgM/
	 ysejTEMs4JJGhbcn0RCF8I1Z//AepiIoqX0t9n4rXaoDU4Fc4vKlNCNoCfCL6hSKdr
	 C2KiYQx7f1gDqDydLkVpt8WfdqhAFV3T86gb79gwaTEbfFZLRaCtedPY6L3qWEqrYG
	 jMRVvWcVs+cVw==
Content-Type: multipart/mixed; boundary="===============7431607082218699323=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <fbfaa7de60fbbd5b5c495fed0005daa700d1da496bf37c6a7d86f443493b8a89@mail.kernel.org>
In-Reply-To: <20261121003403.2928928-4-ihor.solodrai@linux.dev>
References: <20261121003403.2928928-4-ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v2 3/6] libbpf: Resolve kfunc variants by prototype
From: bot+bpf-ci@kernel.org
To: ihor.solodrai@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com
Cc: alan.maguire@oracle.com,emil@etsalapatis.com,jolsa@kernel.org,song@kernel.org,tj@kernel.org,yonghong.song@linux.dev,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,sched-ext@lists.linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat, 21 Nov 2026 01:14:01 +0000 (UTC)

--===============7431607082218699323==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> libbpf: Resolve kfunc variants by prototype

TL;DR: A module BTF load error in find_kfunc_btf_id() may be returned as
-EINVAL and mistaken for "no compatible prototype", so a weak kfunc in vmlinux
could be treated as missing and strong ones get a misleading error.

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c

[ ... ]

> +/*
> + * Search vmlinux and module BTFs. Return:
> + *   - a BTF ID for a unique match;
> + *   - -ESRCH if the family is absent;
> + *   - -EINVAL if no candidate has a compatible prototype;
> + *   - -ENOTUNIQ if more than one candidate has a compatible prototype;
> + *   - another negative error on failure.
> + */
> +static int find_kfunc_btf_id(struct bpf_object *obj, const struct extern_desc *ext,
> +			     struct btf **res_btf, struct module_btf **res_mod_btf)
> +{
> +	size_t name_len = bpf_core_essential_name_len(ext->name);
> +	int kfunc_id = 0, nr_cands = 0, err;
> +	size_t i;
> +
> +	err = load_module_btfs(obj);
> +	if (err)
> +		return err;

Can this return -EINVAL for a reason other than a prototype mismatch?

load_module_btfs() calls btf_get_from_fd(), which goes through btf_new()
and can return -EINVAL from btf_parse_hdr(), btf_parse_type_sec() or
btf_sanity_check() when libbpf rejects a module's BTF.  That error is
returned here unchanged.

[ ... ]

> +	if (kfunc_id == -EINVAL) {
>  		if (ext->is_weak)
>  			return 0;
> +		pr_warn("extern (func ksym) '%s': no compatible prototype in kernel or module BTFs\n",
> +			ext->name);
> +		return kfunc_id;
>  	}

bpf_object__resolve_ksym_func_btf_id() treats that -EINVAL as "no
compatible prototype".  A __weak kfunc is then left unresolved even if it
exists in vmlinux, so bpf_ksym_exists() reports it as missing.  A strong
kfunc fails with the misleading "no compatible prototype" message.

Also, load_module_btfs() has already set obj->btf_modules_loaded = true by
then, so later kfuncs and the CO-RE lookups in bpf_core_find_cands() would
continue with a partial module list instead of failing the load.

Before this patch, a kfunc found in vmlinux never called
load_module_btfs().  When the lookup did reach it, find_ksym_btf_id()
returned the error as is, and only -ESRCH was treated as absence.

Other errors from load_module_btfs() (-ENOMEM, errors from the BTF
syscalls) also return here without a message naming the extern, because
the generic "if (kfunc_id < 0) return kfunc_id;" path prints nothing.

Would it make sense to call load_module_btfs() in the caller, or to keep
its error apart from the -ESRCH/-EINVAL/-ENOTUNIQ results?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/44845964556
--===============7431607082218699323==--
