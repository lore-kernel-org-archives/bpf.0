Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EB94F0559;
	Fri, 25 Sep 2026 23:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790378611; cv=none; b=YjROQZqoFWWWtFH7zN+SUAhNHvWLqKSUqX4dc9ItepzMJPdwtDUL1nVMZlmREbYr4SOl80PBDl/7T+aeu/N73OsZu1PnTFazX7MrQIfC6h00JkzpRyWBJLLGkQXZbSRwimeLClQ8TzFNyc/SYuDf0XpKUh+UGNTDhSBLCgAWlZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790378611; c=relaxed/simple;
	bh=TolYpbJbCc0DrTJCefTmPSF0h/5Fm1FUBaiY/JQaHMI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=hMLa8mtS+smDLRzeT/wKVNxi0WQ9WGvzzvAxwW95Z4P/MpMjqbOkTAMZpAo58hJMn3A8imqMv1tBHaYsfoNUK7PFbe3ge+uEppvYgwMp9FiPsl6LtEDHmk0546SfyHUdV7prKhRLt/nFaXvjy21aqGaRu8NbsPNQAXMb/M6to0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n5qNRJQ8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n5qNRJQ8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34E6C1F00893;
	Fri, 25 Sep 2026 23:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790378609;
	bh=OfljGB/7Fu3p4TuaneIZhF6kiczY+7wGkVmi5z6Y0Gg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=n5qNRJQ8CTKgxXeXRfRI9XFt1+P8jkh/uI9WLYj/6bIkiik8xtNAVCi9cZTliWpdX
	 dGfUvQw14vSScibJUdZpBA/6DL3NbmESFDYaaoB8TSVrmjomujWsRJqYzm4z9Ce75J
	 eJON5vxHxi8aKApLmqTH5ePDdJ+maDwHtS0lEaQ52QS6bNaB+vgnak4XOIL9JEH2gb
	 TvxLzWLXZaIjE7LwML4WUNeJkxa+LVqtpJsZZeW4vpgh4/Od/9WZ6/uyv2WvvDc74T
	 cEcDzNAn3VvxfGw4SwuFVrVHiB0vuvAA5vzALcv2tNVz0FpNzXld9T0yKYIPfKf+Gm
	 3SfY3KWbMmcSg==
Content-Type: multipart/mixed; boundary="===============7365346226462959331=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9faaf7e8ce215ae641225ac696e5ff94b2367b688d509fc9dde43df10a0b066f@mail.kernel.org>
In-Reply-To: <20260925224229.1850-5-wanjay@amazon.com>
References: <20260925224229.1850-5-wanjay@amazon.com>
Subject: Re: [PATCH bpf-next v3 4/9] bpf: take the vmlinux BTF from the btf_vmlinux module
From: bot+bpf-ci@kernel.org
To: wanjay@amazon.com,bpf@vger.kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com
Cc: alan.maguire@oracle.com,martin.lau@linux.dev,yonghong.song@linux.dev,jolsa@kernel.org,nathan@kernel.org,nsc@kernel.org,linux-kbuild@vger.kernel.org,mcgrof@kernel.org,petr.pavlu@suse.com,samitolvanen@google.com,linux-modules@vger.kernel.org,ojeda@kernel.org,rust-for-linux@vger.kernel.org,arnd@arndb.de,linux-kernel@vger.kernel.org,abuehaze@amazon.com,doebel@amazon.de,mpohlack@amazon.de,jay.wang.upstream@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 25 Sep 2026 23:23:28 +0000 (UTC)

--===============7365346226462959331==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index 4b63bb91550a..81e6c65fe5f6 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h
> @@ -602,6 +602,7 @@ __u32 *btf_field_iter_next(struct btf_field_iter *it);
>  const char *btf_name_by_offset(const struct btf *btf, u32 offset);
>  const char *btf_str_by_offset(const struct btf *btf, u32 offset);
>  struct btf *btf_parse_vmlinux(void);
> +void *btf_vmlinux_data(u32 *size, bool load);
>  struct bpf_prog_get_target_btf(const struct bpf_prog *prog);
>  u32 *btf_kfunc_flags(const struct btf *btf, u32 kfunc_btf_id, const struct bpf_prog *prog);
>  int btf_kfunc_check_flag(const struct btf *btf, u32 kfunc_btf_id, u32 flag);

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index da86162ba6d9..84968244a10f 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -21922,26 +21922,51 @@ int bpf_check_attach_btf_id_multi(struct btf *btf, struct bpf_prog *prog, u32 bt
>  	return 0;
>  }
>
> +/*
> + * Returns the parsed vmlinux BTF, NULL if the kernel has none, or an ERR_PTR
> + * if it is malformed.  With CONFIG_DEBUG_INFO_BTF=m the BTF lives in the
> + * btf_vmlinux module; the first caller loads it and parses it.  May sleep.
> + */
>  struct btf *bpf_get_btf_vmlinux(void)
>  {
>  	/* Pairs with the smp_store_release() on the parse path below. */
>  	struct btf *btf = smp_load_acquire(&btf_vmlinux);
> +	u32 size;
>
> -	if (!btf && IS_ENABLED(CONFIG_DEBUG_INFO_BTF)) {
> -		mutex_lock(&btf_vmlinux_lock);
> -		btf = btf_vmlinux;
> -		if (!btf) {
> -			btf = btf_parse_vmlinux();
> -			/*
> -			 * Order the parsed BTF contents and the globals the
> -			 * parse populated (e.g. bpf_ctx_convert.t) before
> -			 * the pointer publication. Pairs with the acquire
> -			 * on the lockless fast path above.
> -			 */
> -			smp_store_release(&btf_vmlinux, btf);
> +	if (btf || !IS_ENABLED(CONFIG_DEBUG_INFO_BTF))
> +		return btf;
> +
> +	/*
> +	 * Loading the module may take a while and its notifier must not be
> +	 * blocked by us, so do it outside btf_vmlinux_lock.  Not available:
> +	 * behave like a kernel without BTF, and retry next time.
> +	 */
> +	if (!btf_vmlinux_data(&size, true))
> +		return NULL;
> +
> +	mutex_lock(&btf_vmlinux_lock);
> +	btf = btf_vmlinux;
> +	if (!btf) {
> +		btf = btf_parse_vmlinux();
> +		/*
> +		 * With =m the BTF was checked against the kernel when the
> +		 * module loaded, so a failure here is a resource problem
> +		 * (-ENOMEM) rather than a broken BTF: do not remember it,
> +		 * the next caller retries.
> +		 */
> +		if (IS_MODULE(CONFIG_DEBUG_INFO_BTF) && IS_ERR(btf)) {
> +			mutex_unlock(&btf_vmlinux_lock);
> +			return btf;

Does this error path account for deterministic parse failures?

The comment states that with CONFIG_DEBUG_INFO_BTF=m a parse failure
here is a resource problem (-ENOMEM) because the payload was checked
when the module loaded. btf_vmlinux_module_coming() does verify the
size and SHA-256 match the .BTF.meta values this kernel was built with.

However, btf_parse_vmlinux() calls btf_parse_base(), which can still
fail with errors that depend only on the content:

kernel/bpf/btf.c:btf_parse_base()
    btf_parse_hdr()           -> -E2BIG, -ENOENT, -EINVAL
    btf_parse_str_sec()       -> -EINVAL
    btf_check_all_metas()     -> -EINVAL for unknown kind or bad name
    btf_check_modifier_chain_length() -> -ELOOP

These checks are deterministic. A broken BTF would fail on every
attempt, yet the code never caches the error. With CONFIG_DEBUG_INFO_BTF=y
the same condition gives 'in-kernel BTF is malformed' and the ERR_PTR
is cached once. With =m, every later caller repeats the full parse of
the ~5.4 MiB BTF while holding btf_vmlinux_lock: kvmalloc of the types
array, a walk over all metas, then the free.

Callers include bpf_prog_load(), struct_ops map creation,
BPF_BTF_GET_NEXT_ID (which runs before the CAP_SYS_ADMIN check in
bpf_obj_get_next_id()), and read()/mmap() of the 0444
/sys/kernel/btf/vmlinux. An unprivileged user can therefore make the
kernel re-parse repeatedly and serialize other BTF users behind the
mutex.

Also, /sys/kernel/btf/vmlinux returns -ENODEV even though the raw bytes
are present, because btf_sysfs_vmlinux_load() requires a successful
parse.

Would it be better to cache only on content errors (e.g. all errors
except -ENOMEM) and retry resource failures, or to skip caching only
on specific errors?

>  		}
> -		mutex_unlock(&btf_vmlinux_lock);
> +		/*
> +		 * Order the parsed BTF contents and the globals the
> +		 * parse populated (e.g. bpf_ctx_convert.t) before
> +		 * the pointer publication. Pairs with the acquire
> +		 * on the lockless fast path above.
> +		 */
> +		smp_store_release(&btf_vmlinux, btf);
>  	}
> +	mutex_unlock(&btf_vmlinux_lock);
>  	return btf;
>  }

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36198628965
--===============7365346226462959331==--
