Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793904091;
	b=s/q9ztNJj9belv6UplpRNvtfvrzx+mkbNG3HvkplNhyMNCZHIrnTfLElHt7RywHANz/g
	 siZqHVYid0y3QatxAyXgAuHWAxkTBPDSbGUPuzFUvagihL+jMyryCR2sQShdXH6IZ1o7d
	 524t4BtgB8+bdzwJplf+k63G3BsKW7xYH+i155vlZSwQMSwko2afNCKJfjmLUVl5qqXy4
	 7UYUG7GPtDhWSkFTPWMygHet5fHnCcbuvcjrAkaYCV208HwlF8tQ7cKdiGbk7NNDqNl7e
	 rVpNReXBfyOAxzlE3avN2oHwqaaVzIsKYNL0OtJAW5fISpBs0HmjfzN8Ur4fklO5juA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793904091;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=Ao83bkd/tSb+gzvRHOhQcBytaDanZ7yH56Tl/7rLQMw=;
	b=pm2yCAqWtwb8XfD+zGzc5xykz6lha+n3XVTpwRa0IddL5sTftGVc+CzwGF9XyGpstB7y
	 djTbk/g0+B1fkoBqpzAaG1oJ0FFv7qy0UvRWTp2UUvGDGbQUJsLoFWWmfamDivhqOMuaq
	 NCJicP2TBtMrstn1Db3bvk8Be6BpwZ87aeyKKWXTMias7TMGKioTz8KXkb8gzlHxnKM4X
	 lOiGzgky51VwVEfG+iDQ53qbzca0BPvqtv+fLs0vzZ1g+1+pdnYTSUMe5Lm/OtdBcwjue
	 Av9Vc2ixKA8zgADK0aP2DHOcruxwXYpMnRliLDlsxxVlFH6qAzD22zesvsddM+qP4aQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ax7Rdzpg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D2A606A32C
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 18:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ax7Rdzpg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69AB51F000C1;
	Thu,  5 Nov 2026 18:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793904090;
	bh=Ao83bkd/tSb+gzvRHOhQcBytaDanZ7yH56Tl/7rLQMw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ax7RdzpgK5lj7o2Zbwf4CHO9msDL56GCWYqzsin30PZqUtYMLVVMEdbxfhEeMDQIE
	 hJVCbd9cCWUs2frNMAMWR1//nK+pfAvnJRUxFLj7UQmE6OdhcwhaFAyImttIOn1ZFZ
	 +J7cB5Br3wjp6KiInENFXWRnMnQOacgbzIgOtt8svhiqqQ1L2Vc4FD3Tn4NDKhNwlA
	 W/S//ca+UxxCE0LU6RfrNBXkzfcRG/zjkIrs1iZxv2m7MyHn4JHrHCeV+HbtiHgc7L
	 +TcleU98jx7sC4sEpF3wJpUZCJp9ckAd0vPfVHNlibD0o5OrqdZyGzI/vZVUt01gSD
	 8dLgV/kJP3mCw==
Content-Type: multipart/mixed; boundary="===============2006081096416102589=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <ccf64f8cf04be6730d9d8a9b1ac14b0013c478a595bc736388d48d55218e180e@mail.kernel.org>
In-Reply-To: <20261105175845.30357-11-ihor.solodrai@linux.dev>
References: <20261105175845.30357-11-ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v4 10/17] bpftool: Apply __bpf_relocatable per record on BTF dump
From: bot+bpf-ci@kernel.org
To: ihor.solodrai@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com,qmo@kernel.org
Cc: bpf@vger.kernel.org,alan.maguire@oracle.com,cupertino.miranda@oracle.com,david.faust@oss.qualcomm.com,irogers@google.com,jose.marchesi@oracle.com,vineet.gupta@linux.dev,yonghong.song@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu,  5 Nov 2026 18:41:30 +0000 (UTC)

--===============2006081096416102589==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpftool: Apply __bpf_relocatable per record on BTF dump

TL;DR: Tagging every struct, including verifier-rewritten context types like
__sk_buff, may make GCC-BPF programs fail verification until later patches fix
it; unverified. Consider excluding context types in this patch for
bisectability.

> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> --- a/tools/bpf/bpftool/btf.c
> +++ b/tools/bpf/bpftool/btf.c

[ ... ]

> @@ -1131,6 +1131,24 @@ static int btf_c_annotate_type_tags(struct btf *btf)
>  	return 0;
>  }
>
> +static int btf_c_annotate_records(struct btf *btf)
> +{
> +	__u32 i, cnt = btf__type_cnt(btf);
> +	int err;
> +
> +	for (i = 1; i < cnt; i++) {
> +		const struct btf_type *t = btf__type_by_id(btf, i);
> +
> +		if (!btf_is_composite(t))
> +			continue;
> +		err = btf__add_decl_attr(btf, "__bpf_relocatable", i, -1);

Can this break GCC-BPF programs that access verifier-rewritten context
types?

btf_c_annotate_records() tags every struct and union, including __sk_buff,
xdp_md, bpf_sock, bpf_sock_ops, sk_msg_md, bpf_sockopt and the like.

For Clang nothing changes, since the old pragma already applied
preserve_access_index to these types.  GCC-BPF ignored the pragma, so
vmlinux.h never gave it preserve_access_index.  With this patch GCC-BPF
applies the attribute to the context types as well, unless
BPF_NO_PRESERVE_ACCESS_INDEX is defined.

For program types with convert_ctx_access, check_ctx_access() in the
verifier rejects a ctx pointer that has an added offset:

    __check_ptr_off_reg(env, reg, argno, fixed_off_ok)
    fixed_off_ok = !env->ops->convert_ctx_access

With preserve_access_index on these types the compiler can emit pointer
arithmetic, for example for a one-byte load at offset 1 into skb->mark,
and the verifier then rejects an otherwise valid program.  A GCC-BPF tc
program that includes vmlinux.h without BPF_NO_PRESERVE_ACCESS_INDEX could
pass before this patch and fail after it.

The in-tree GCC-BPF selftests are not affected because the bpf_gcc flavor
passes -DBPF_NO_PRESERVE_ACCESS_INDEX.  I did not build with GCC-BPF to
confirm the exact instructions it emits.

This is addressed later in the series by 87b9a5139319 ("bpftool: Skip
__bpf_relocatable on verifier-rewritten context types") and
c6d74cfddc8d ("bpftool: Emit __bpf_static_offset on verifier-rewritten
context types").  Would it be better to put the context-type exclusion in
this patch, or ahead of it, so GCC-BPF context accesses don't break in the
window between them (for example when bisecting)?

> +		if (err < 0)
> +			return err;
> +	}
> +
> +	return 0;
> +}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42081937070
--===============2006081096416102589==--
