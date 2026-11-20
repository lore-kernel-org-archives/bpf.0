Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795133515;
	b=knD6KerNa1jLsS/sQqTB7S6/T1Z/eT0CFsEszMrsXV/0xbYsIhvLoEs2FHBMtxKmz9X1
	 buOTcw+F59I5FmA+6xrI4i2DkyqCX2P125Kn5EUQK36Wh88BRlKBi8EtVhbOp0JFNsiPz
	 dPQMJION3L4XA0c10NFx1Y9wUbDTkxZfizD/UKm6kNXQnFnxJz81YJhgvYDJjVwH4G/ze
	 /fYY099yBz7BLOjpg86oGhaLXiNnBuL/B1DGZPA9+Gz0gfjy0dF3SZsmdH6PB64IEpuv6
	 icWIhA+sm9cjfTrPXy6kXQ1kdV5zojxVE5mD2U9pX2D0TMnytO1y6rp6vdfl64aM8tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795133515;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=0n8RQ5daGUajegrFGIDzOS2pE0C08y0z4IZEWt/Wx9Y=;
	b=dbJ8b2+N08Bb7NSHSt847qjjaG4E/QYMMmip9LzNzXlcrbyRoKBxQK1UQy/qrEgA1mXg
	 NckOBcMxkzgrN3E9y4uECM/Zdoq18z5nzSGwtEVDlP6foT9V+TBI+YxUWddKKpby4uEjJ
	 /2EjXJhY9dOQifpzVnFJ6O90txRpB3e0/aNXClaE16MsMI3FJ28xDE+u5DqZu0uMFWmij
	 wdFMgUvdhtaXK+OlL3C1gs60+f1cGrYTBfzw3r/Wa4ax5suE1U75h/QesPVksUPp4Jy1M
	 FQI6O64xKiTCNBB9wNfH2Ajy6r2Uya8OTdJD1ms1k82edX5YDWgzxTfWApGTBTGRImg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=blsDCkJq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5576660A260E
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 00:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=blsDCkJq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2E061F000CF;
	Fri, 20 Nov 2026 00:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795133515;
	bh=0n8RQ5daGUajegrFGIDzOS2pE0C08y0z4IZEWt/Wx9Y=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=blsDCkJqkLn9DVbbiXgmsNJZh9/ZpGgkLVoit2AoblZx4QJeRuA/3aO8F6Fb7JUwM
	 2J0GRST4aZQKND5c6+uxaPJbwHarLjwZ+K/0pUehcVfK/+SvbIJ+wWkJ3E5mlRzvfx
	 l2Qv+xYpQD7SHllMYnYvMC3X/rXeXEjamgnUhnm1YNt8gcelE85F4WXkAqlveWiJY3
	 ivCgXWfVAQT+bSwdt1QoHBRES+XrZaZAVV3MzkOqa//zw5fHGYmlRrvFbQnC4WyDhq
	 6QtnClwa8bYw42t92PN/+7ABzWBJlWVM8bQS8pqGSed07ssQv+b5SahSUD1r3lzSfY
	 iXSzMuw/gCRfg==
Content-Type: multipart/mixed; boundary="===============3228154552357935840=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <cb1e3f94e014f103aa0c70544036a61ade5c31250e759b63aabe09ab2a4575f8@mail.kernel.org>
In-Reply-To: <20261119232652.3392590-1-yonghong.song@linux.dev>
References: <20261119232652.3392590-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v3 1/2] libbpf: Fix CO-RE relocations of unsigned 32-bit enum values
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 20 Nov 2026 00:11:53 +0000 (UTC)

--===============3228154552357935840==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> libbpf: Fix CO-RE relocations of unsigned 32-bit enum values

TL;DR: Possible regression in libbpf CO-RE: on targets whose enum BTF has no
kflag (pre-6.0 kernels), negative enumerators like -1 may be zero-extended to
4294967295 instead of sign-extended. Selftest doesn't cover it.

> diff --git a/include/linux/btf.h b/include/linux/btf.h
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h
> @@ -525,6 +525,11 @@ static inline struct btf_enum *btf_enum(const struct btf_type *t)
>  	return (struct btf_enum *)(t + 1);
>  }
>  
> +static inline u64 btf_enum_value(const struct btf_type *t, const struct btf_enum *e)
> +{
> +	return btf_type_kflag(t) ? (s64)e->val : (u32)e->val;
> +}
> +

[ ... ]

> diff --git a/tools/lib/bpf/relo_core.c b/tools/lib/bpf/relo_core.c
> --- a/tools/lib/bpf/relo_core.c
> +++ b/tools/lib/bpf/relo_core.c

[ ... ]

> +static __u64 bpf_core_enumval(const struct btf_type *t, int idx)
> +{
> +	if (btf_is_enum(t))
> +		return btf_enum_value(t, btf_enum(t) + idx);
> +	return btf_enum64_value(btf_enum64(t) + idx);
> +}
> +
>  static int bpf_core_calc_enumval_relo(const struct bpf_core_relo *relo,
>  				      const struct bpf_core_spec *spec,
>  				      __u64 *val)
> @@ -875,10 +882,7 @@ static int bpf_core_calc_enumval_relo(const struct bpf_core_relo *relo,
>  		if (!spec)
>  			return -EUCLEAN; /* request instruction poisoning */
>  		t = btf_type_by_id(spec->btf, spec->spec[0].type_id);
> -		if (btf_is_enum(t))
> -			*val = btf_enum(t)[spec->spec[0].idx].val;
> -		else
> -			*val = btf_enum64_value(btf_enum64(t) + spec->spec[0].idx);
> +		*val = bpf_core_enumval(t, spec->spec[0].idx);
>  		break;

On the target side, bpf_core_enumval() treats kflag == 0 as unsigned:

    btf_enum_value(): return btf_type_kflag(t) ? (s64)e->val : (u32)e->val;

Is kflag == 0 really a safe indication of an unsigned enum here?

Before commit 6089fb325cf7 ("bpf: Add btf enum64 support"),
btf_enum_check_meta() refused any enum with kflag set, so the vmlinux and
module BTF of every pre-6.0 kernel has kflag == 0 on every enum, signed
ones included.  libbpf itself relies on this, since
bpf_object__sanitize_btf() clears the enum kflag when !FEAT_BTF_ENUM64.
Kernels built with pahole 1.22/1.23, which lib/Kconfig.debug still
allows, have no signedness bit either.

Take a program built with clang >= 15 against a recent vmlinux.h, running
on such a kernel:

    enum perf_event_state { ..., PERF_EVENT_STATE_OFF = -1, ... };
    long v = bpf_core_enum_value(enum perf_event_state,
                                 PERF_EVENT_STATE_OFF);

- Local BTF has kflag = 1, so orig_val = 0xffffffffffffffff and clang
  emits the same value in the ld_imm64.
- bpf_core_enumval_is_sext() returns false, because orig_val > UINT_MAX.
- Target BTF has kflag = 0, so new_val = (__u32)-1 = 0x00000000ffffffff.
- bpf_core_patch_insn() writes insn[0].imm = 0xffffffff and
  insn[1].imm = 0.

The program now gets 4294967295 instead of -1.  Before this patch, new_val
was btf_enum(t)[idx].val (an __s32) widened to __u64, i.e. sign-extended,
which was the right value here.  Comparisons such as
state == bpf_core_enum_value(...) (state widened to long) would stop
matching, and other negative enumerators such as CPUHP_INVALID = -1 hit
the same path.  Kernel-side CO-RE (bpf_core_apply(), light skeletons) runs
the same code and is affected when vmlinux BTF has no enum kflag.

The commit message says the target value "gets the extension given by the
kflag of the target enum".  That only works when the target BTF records
signedness.  Could the extension of a 32-bit target value come from the
signedness of the local enum (or of orig_val) when the target enum has
kflag == 0, as the GCC sign-extension case already does from the
instruction?

The selftest added later in the series covers only unsigned values on a
kflag-aware target, so it does not exercise this case.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/44640008097
--===============3228154552357935840==--
