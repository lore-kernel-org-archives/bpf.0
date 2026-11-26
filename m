Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795718172;
	b=iG66VDzI3YLdqT9omQwU+g+GFgdtzMrKLWg0h/t5c+QGysgJJg+auJv9ChG6eOBvu1n7
	 xIqYOBiVjOo6R6SfGyMxCRC6533VMbS739aiQPBLTuZyoU978lWlwTEo5cbAwGJ7I2Xx+
	 jJLC2pQBox8baB3fi0dgxLYf6MXEPmLEMuQVkpnjJ+TDxwnB9UYkSEnseft8fhXT2v9Pg
	 syaEqJyuiMO7k7shmDMUNKejHdglElXvugfA2/WdRV1oaQYcKXGP2icZnPQzfvXUFZHzc
	 oANsUYpLVBE+5FJClzjYC1VBW377KLKmwyuJ38gvG3jvEeeBL7s/LxXVdMJF86T0t6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795718172;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=PHwK0hNZVvPYv3T2MF1Pcs9nSJSqEJMdMr72QHO07Qs=;
	b=ciPW+BrdAifSkLB9EXGc7SpZSc3oAne7JVABSaBDKMpNm/T6z3Bq54zP1Y5d+L6Ul/FM
	 So1+m3H91KwLZexCVZNgkNIykN+Sq6aHEcsNtTkWJtBWrel9AwnOA3wOvSzMRn8peHqls
	 a+N0VCL3+/L8KKYRfYlVUeCIuJ2C8GSqowSe5pcMsO5PenPLFuNC2fbkk7ZXfPzpM7uRV
	 3T5hBuzswfptDx5Rg05/KETzCe721kRHCmbyE2CvMstzKmWKcGgJb8L1ilxI0XcfR1j0V
	 VMxS6REymPNQ9XPTVphXV99/TUpB7Z1az71MTEQdREL8Vv7TWqfuku+yiebqAP0d2+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DsaLmj2F;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8173E606A31C
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 18:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DsaLmj2F
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBE011F000C4;
	Thu, 26 Nov 2026 18:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795718172;
	bh=PHwK0hNZVvPYv3T2MF1Pcs9nSJSqEJMdMr72QHO07Qs=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=DsaLmj2Fue7FSClIdqWq6QtoISYtt9WctxhXi52ZtVjB4z4c7PgqfrzTYHZ5k1f7x
	 zTSmZWz9eBsRX+YTGI3b7dFPlp+9Cq3HK2r+nf4iZ7NA6XodTgrSFnN8Bjx2zRDc8p
	 CvtDH3EBJT4eIa2z0bj0SFoM5lZB6HHo/Siq/xTO4iS1hWFO2JzP8Cks99HG+7PBDl
	 4Zx0eCnA5OZnk6TPo33pAnTR6BKOTv/J4hQu0u5DemFg10lPmicu/aO8xJyQWYSGxU
	 iAnw3HB/YpuL8EpMG0+V560W7oXTrO44AyhprtQQKAJDKokCqrn4lU/zgOfEVxB5UQ
	 PZrJjUMnobeDw==
Content-Type: multipart/mixed; boundary="===============1312326576970510557=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <2c14a84ab2ca76b12c34e5be65c4e51a969151f0c831386519a47a9c6245671b@mail.kernel.org>
In-Reply-To: <20261126175607.1883240-1-yonghong.song@linux.dev>
References: <20261126175607.1883240-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next 1/3] libbpf: Poison an enum value relocation out of the local enumerator range
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 26 Nov 2026 18:36:10 +0000 (UTC)

--===============1312326576970510557==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> libbpf: Poison an enum value relocation out of the local enumerator range

TL;DR: Possible wrong behaviour in relo_core.c: enum value relocations may be
wrongly poisoned when target BTF lacks the kflag (pre-6.0 kernels) and
negative enumerators, so valid programs could fail to load.

> diff --git a/tools/lib/bpf/relo_core.c b/tools/lib/bpf/relo_core.c
> --- a/tools/lib/bpf/relo_core.c
> +++ b/tools/lib/bpf/relo_core.c

[ ... ]

> +static bool bpf_core_enum_val_fits_int(__u64 val, bool val_signed)
> +{
> +	return val_signed ? (__s64)val == (__s32)val : val <= INT_MAX;
> +}

[ ... ]

> +	local_t = btf_type_by_id(local_spec->btf, local_spec->spec[0].type_id);
> +	targ_t = btf_type_by_id(targ_spec->btf, targ_spec->spec[0].type_id);
> +	local_signed = BTF_INFO_KFLAG(local_t->info);
> +	targ_signed = BTF_INFO_KFLAG(targ_t->info);
> +
> +	if (bpf_core_enum_fits_int(local_t)) {
> +		type = "int";
> +		fits = bpf_core_enum_val_fits_int(targ_val, targ_signed);
> +	} else if (local_t->size == 4) {
> +		type = "unsigned int";
> +		/* a negative value is sign-extended, so it is also too big */
> +		fits = targ_val <= UINT_MAX;

Can this reject valid programs when the target BTF has no kflag on a signed
enum?

Before commit 6089fb325cf7 ("bpf: Add btf enum64 support"),
btf_enum_check_meta() rejected any BTF_KIND_ENUM with kind_flag set, so
vmlinux and module BTF from pre-6.0 kernels (and from kernels built with
pahole older than 1.24) have kflag == 0 and store negative enumerators as
their u32 bit pattern.

For kflag == 0, bpf_core_enum_val() returns (__u32)e->val, so a target
enumerator of -1 becomes targ_val = 0xffffffff with targ_signed = false.

Consider a local enum such as enum perf_event_state from a modern
vmlinux.h, where PERF_EVENT_STATE_OFF = -1, running on a 5.x kernel:

    bpf_core_enum_fits_int(local_t)                 -> true
    bpf_core_enum_val_fits_int(0xffffffff, false)   -> 0xffffffff <= INT_MAX
                                                       -> false

The relocation is poisoned and the program fails to load if the
instruction is reachable.  Before this patch the ld_imm64 got 0xffffffff,
which truncates to the correct -1 in an int context such as:

    int x = bpf_core_enum_value(enum perf_event_state,
                                PERF_EVENT_STATE_OFF);

The mirror case also looks affected.  If the local enum comes from a
vmlinux.h generated on an old kernel, btf_dump prints the kflag == 0
values with %u (e.g. PERF_EVENT_STATE_OFF = 4294967295), so the local
enum is a 4-byte unsigned enum.  On a 6.0+ kernel with kflag set, targ_val
is 0xffffffffffffffff, which fails "targ_val <= UINT_MAX" and is
poisoned, where bpf_core_enum_value() previously returned the kernel's -1.

The commit message says pahole sets the kflag for a signed enum since
v1.24, "the minimum version now required for kernel BTF".  Doesn't that
only cover kernels built from this tree, rather than the older running
kernels that CO-RE targets?

The selftests added later in the series appear to use only target BTF
compiled by a modern clang that sets kflag, so they would not exercise
this.

Would it make sense to judge a 4-byte BTF_KIND_ENUM target without kflag
by its low 32 bits, accepting the value if it fits as either int or
unsigned int against a 32-bit local enumerator?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/45873143557
--===============1312326576970510557==--
