Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9F93F9F58
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 16:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781023698; cv=none; b=pRUoaFOu/oy2/h3bRg0TN6zAG0VY8AlVeKGGTNX9TsFkV1vRGU5aKvVQBG++mLhAX20cjszLMsL5Gfgf7XFZs7h69YfGFzVHcIS4xP/pc4pBwsiWk8QtleHtPtEhnr50NXd0GTWUhM6ECGob4gDjKzHNU4wIx0f5dzwnbEcIW54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781023698; c=relaxed/simple;
	bh=00E9cvEjzG5aFbbiaYKxl0+KB+J89WdwaLKQUJQiHWY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SbEYoMDE6IJOHUINFr0i0h7iC4mkdFe41ZOUJrGmsKmdNBoa61uNMDQO0uXbqtLKnPHEAq4TF0AypzjNYJ1jann9EGtzGlXebXM6hwNDrLs+wXtPooU8HYOMGWGKvzR0sPCtDUC7e4y+noJrrrPhCMFj/72PEuJQhhW6V0K3zsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lm7Xte2t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lm7Xte2t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB3821F00898;
	Tue,  9 Jun 2026 16:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781023697;
	bh=VhiYzKXOWztPhQ+qxpC9u+ufc2M8WvwBA5hcsobX2Jg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Lm7Xte2tZMcCh8tS5Qu4rnYH/dujb6avmXRpDQItkOxz9v3uSB7M37pVG8jDFO50v
	 EXIPnhcMJLpgsfJ3/2UaOjSx0MzPrQeTDLgDicVVKhhkYPG7/uAGQXSp9+YFJGsUsX
	 sx5iYgbTg5YRNMTZ3x4NO9rw5U2rgEXJI9M9zMpSt3uB0Wop8NtJ3ckA+yq4aPZfR6
	 gEIdBEF0cdai1DsdGUdT0OpuZfvao5He3ng4M0m+bVPqFjQKSPqC7HkpNtsuEC8oEQ
	 CS0Rggt92lV1NuA52QC1pp8v3kumzhJcI3KEupe4BGLtbjPnpguXUjRgVKc2z+cS3e
	 9e+qx4QEGfzmg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 1/3] selftests/bpf: Keep int return type for
 tailcall subprogs with maps
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260609163952.1718472-1-yonghong.song@linux.dev>
References: <20260609163952.1718472-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 16:48:15 +0000
Message-Id: <20260609164816.DB3821F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The BPF array map `array` defines its value type as `__u64` (8 b=
ytes), but the code passes pointers to local `int` variables (4 bytes) as t=
he map value to `bpf_map_update_elem()`. This causes an out-of-bounds stack=
 read by the BPF helper, leading to either BPF verifier rejection or incorr=
ect map state.
--

commit 638a9e186d9da40d2e394848eda6a546f07a86fd
Author: Yonghong Song <yonghong.song@linux.dev>

selftests/bpf: Keep int return type for tailcall subprogs with maps

This commit prevents LLVM23 from changing the caller's return type in BPF
tailcalls by using a barrier_var. It also switches to using an Array map to
store subprog return values to preserve test results.

Link: https://github.com/llvm/llvm-project/pull/198426

> diff --git a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy=
1.c b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy1.c
> --- a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy1.c
> +++ b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy1.c

[ ... ]

> +struct {
> +	__uint(type, BPF_MAP_TYPE_ARRAY);
> +	__uint(max_entries, 2);
> +	__type(key, int);
> +	__type(value, __u64);
> +} array SEC(".maps");

[ ... ]

>  SEC("tc")
>  int entry(struct __sk_buff *skb)
>  {
> -	int ret =3D 1;
> +	int ret =3D 1, ret1, ret2, key1 =3D 0, key2 =3D 1;
> =20
>  	clobber_regs_stack();
> =20
>  	count++;
> -	subprog_tail(skb);
> -	subprog_tail(skb);
> +	ret1 =3D subprog_tail(skb);
> +	ret2 =3D subprog_tail(skb);
> +
> +	bpf_map_update_elem(&array, &key1, &ret1, 0);
> +	bpf_map_update_elem(&array, &key2, &ret2, 0);

[Severity: Medium]
Will the BPF verifier reject these bpf_map_update_elem() calls, or
will they read out-of-bounds on the stack?

The array map defines its value size as __u64 (8 bytes), but ret1 and
ret2 are declared as 32-bit int variables (4 bytes). When passed into
bpf_map_update_elem(), the helper will read 8 bytes starting from the
pointers to the 4-byte integers, potentially reading uninitialized
adjacent stack memory.

> =20
>  	return ret;
>  }

> diff --git a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy=
_fentry.c b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy_fe=
ntry.c
> --- a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy_fentry=
.c
> +++ b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy_fentry=
.c

[ ... ]

> +struct {
> +        __uint(type, BPF_MAP_TYPE_ARRAY);
> +        __uint(max_entries, 2);
> +        __type(key, int);
> +        __type(value, __u64);
> +} array SEC(".maps");

[ ... ]

>  SEC("fentry/dummy")
>  int BPF_PROG(fentry, struct sk_buff *skb)
>  {
> +	int key1 =3D 0, key2 =3D 1, ret1, ret2;
> +
>  	clobber_regs_stack();
> =20
>  	count++;
> -	subprog_tail(ctx);
> -	subprog_tail(ctx);
> +	ret1 =3D subprog_tail(ctx);
> +	ret2 =3D subprog_tail(ctx);
> +	bpf_map_update_elem(&array, &key1, &ret1, 0);
> +	bpf_map_update_elem(&array, &key2, &ret2, 0);

[Severity: Medium]
Are ret1 and ret2 causing the same 4-byte stack read for an 8-byte map value
here in the fentry program?

> =20
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609163947.1717=
694-1-yonghong.song@linux.dev?part=3D1
