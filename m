Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0C63BA220
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 18:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789755346; cv=none; b=uheldXHiKNIiCYObQTXMREdJZlIX4FK3H/SBIR8rp5nzhVZBzjT/K3fvA4gt61HT7F2gtpRjLoD8F9HfdR9C6KR4ld6eaOPUSH8pb9y+ONJkgtlBawCd7wL3Y+Jnm2x2HOogpTcu4f6r8Qj14h8SioXWlQ+LKkagQKv0D5Z8RI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789755346; c=relaxed/simple;
	bh=UW97uPNSNrTK6jutpjjkvntZGw7SBIzT0iZNX03Dbh4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FyfFuaR+nmbyYYuMvYKUPtCo8cUPqiUkGNvfFvun5zDBtoBnADenM80mhtRF+ysvRZO1X8se5sSxw4DNLyDJh8I6EYPT3IhjE36V26TLVrxxQugNovWwboNV2Ma5lTokXDKXkXpSbFOANii4RdfasXGfU4L660d3XXea6bZ1V5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rkva4QKJ; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rkva4QKJ"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2db18fe459dso6798875ad.3
        for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 11:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789755344; x=1790360144; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=mvTSiRV51oR/yVxzUp4oGn04dRaMcsY7QaitZazhI0E=;
        b=Rkva4QKJuLhHaigrS0THnYitLCXpDEwOdzc8E0kJIrrx+IY9hyi5wAEvPpBoTLhCwm
         qRbHKu5qby5ew4ysVdaSvhLA4+z22BEPCo+MbFRr9FPpFKgMUzBb2FXv8Jb/6DkM6Nq0
         MALVtSUawx2WmShk5SGMtPYWetSwheob3PsigLP3a/yJXn9TisSGBdn42LEI4/M/f0QQ
         veIiOpYU0uoRxfzDcDqIukEz1tMAstOtZYWbO0aYVqJd/q1NV7yuQ2bOtxWbQbkVED2d
         w9Q7bEFmM5UrLwU3ZyB1rnPRh7Yub3uhGntrksqXhDddgEJ1u87wHuf/2OyPklNT4wLX
         DLvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789755344; x=1790360144;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mvTSiRV51oR/yVxzUp4oGn04dRaMcsY7QaitZazhI0E=;
        b=i+KlbBKqEuMEk8XPr9q/z9X+yWGQyBeeBXeuLy6dmlAVFbuIid1MCHcbzgT9/XTuMl
         QSq/5mkyjg3TsPnduj1o5z/StjLRAo4U5C2SDj6t/xIXV2Z/nDjjuNclWUaK2XGU3VJz
         8asgu615fq5iHUr1S9OQagRAoBEy66aSIPznZIfdloCsgmeBBA3Fv4gbX+W30igoXb8h
         96TPX0dwKhLbo0pkawU0aZXW8A1AUhJWkFV/Kzdi8yj9HbkPQrs2+XuGEP3a1YPsNhJd
         f+7vOIOHAa78Hjub4LiPNpRV/ARKqQCxmOnVH+H0f1k+S9YV9ZfLBxnBe191dN9/zUl6
         SV4A==
X-Forwarded-Encrypted: i=1; AKwUvByx7lSQQmcLMngBv+yCwD/PucHULbn3ghIrYcWxlQKCLJjQnApd/ZH6ln+5nLwhLt5e10c=@vger.kernel.org
X-Gm-Message-State: AFuF++mYW6ovaKC57+MUrMNfRtl5tEVEfheod7JHYQwOzDvAFC5/1dPQ
	fkfov0SkzVKmc0LXnZa7GiQzr/cx0YfVX9evvLWthTwyVXQHFjl4ttUf
X-Gm-Gg: AYBFou0uGBZ520IjQ4F9ykZ4XVb1pq3VTeK7xndxwOlX5IVi8iHnhJsWVl+5gvuADAn
	8RKul8lfIGDATndoNb8n5E8UrDYqzd+ozKl1jegfBW5rSndystG5DfvaRIAS6Ez6k1i3hig+PXZ
	Uvgdcs8rrQQ8DNlVE1/QQDHQ/oaGxBCYPXDfh+UHg20SVFjn0AaMy7xgc1xwfyngguTcilEeaUM
	U8IKWXKGmJ+MgbFDGgR8PIOcAYwkmMZPjVS/BgOZDrNUFOTo+3x6bmytMqAS43Nr88fT074LsEI
	stbcQq72R4Tjo2DfFQOpkSS0Lir4mLjqgkQTTj5XPbU5+bmfpiUiXPHLNKWwGmIpqj62X0d1a3t
	KVJBfrKcdg5gzDUxUhwoZqt29ILzKKP+o1ImGkQDaHMl6wp5iGHmfhyLYiFvzkyb4gQJYh7m/fj
	a2AKT0Cxq01c7umbtbWCd6wM803pIR/I5UMEPF3IrwlBVj3DtkaS6alJX4QDcZXQRjOBik3G8JN
	vufHuNLXZN1D9XBVcHMpDFd55z3j70cdxc80S9GDXuFF0+8nPrXXVbqYTSenIV8iZ+P
X-Received: by 2002:a17:903:1107:b0:2dd:c100:4b7e with SMTP id d9443c01a7336-2ddc1005f33mr6466515ad.53.1789755343970;
        Fri, 18 Sep 2026 11:15:43 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:e136:8952:772a:93a4? ([2620:10d:c090:500::4:e681])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c33188f76sm319160eec.21.2026.09.18.11.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 11:15:43 -0700 (PDT)
Message-ID: <4599bf823fbe81380ca7980a2d60283ca73e28aa.camel@gmail.com>
Subject: Re: [PATCH bpf v2 2/2] selftests/bpf: Cover frame changes in
 bounded loops
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis <emil@etsalapatis.com>, Nicholas Carlini <npc@anthropic.com>, 
	kkd@meta.com, kernel-team@meta.com
Date: Fri, 18 Sep 2026 11:15:41 -0700
In-Reply-To: <20260918011313.3053497-3-memxor@gmail.com>
References: <20260918011313.3053497-1-memxor@gmail.com>
	 <20260918011313.3053497-3-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-09-18 at 03:13 +0200, Kumar Kartikeya Dwivedi wrote:
> Add two finite loops whose progress is represented only by changing the
> frame number of a stack pointer. Each loop first reads zero from the
> caller's stack, switches to the same offset in the callee's stack, and
> exits after reading one on its next iteration.
>=20
> Keep the pointer in a register in one test and spill it in the other to
> exercise both regsafe() and stacksafe() during exact state comparison.
> Force frequent checkpoints so the tests exercise infinite-loop detection,
> and check that both programs return one when run.
>=20
> Without the frameno comparison in regs_exact(), both programs are
> rejected with an "infinite loop detected" diagnostic instead of loading
> successfully.
>=20
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Tested-by: Eduard Zingerman <eddyz87@gmail.com>

>  .../selftests/bpf/progs/verifier_loops1.c     | 70 +++++++++++++++++++
>  1 file changed, 70 insertions(+)
>=20
> diff --git a/tools/testing/selftests/bpf/progs/verifier_loops1.c b/tools/=
testing/selftests/bpf/progs/verifier_loops1.c
> index d248ce877f14..ada7e1105a95 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_loops1.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_loops1.c
> @@ -303,4 +303,74 @@ __naked void maybe_exit_scc_bug1(void)
>  	::: __clobber_all);
>  }
> =20
> +/*
> + * The loop reads zero from the caller's stack on its first iteration an=
d
> + * one from the callee's stack on its second iteration. At the loop head=
er,
> + * only the frame number of the pointer in r1 changes.
> + */
> +static __naked __noinline __used
> +void loop_stack_frames_reg(void)
> +{
> +	asm volatile (
> +	"*(u64 *)(r10 - 8) =3D 1;"
> +	"1: r0 =3D *(u64 *)(r1 + 0);"

Nit: please use formatting as below:

  "1:"
	"r0 =3D *(u64 *)(r1 + 0);"

> +	"if r0 !=3D 0 goto 2f;"
> +	"r1 =3D r10;"
> +	"r1 +=3D -8;"
> +	"goto 1b;"
> +	"2: exit;"
> +	::: __clobber_all);
> +}
> +
> +SEC("xdp")
> +__description("bounded loop changing stack frame in a register")
> +__success __retval(1)
> +__flag(BPF_F_TEST_STATE_FREQ)
> +__naked void bounded_loop_stack_frames_reg(void)
> +{
> +	asm volatile (
> +	"*(u64 *)(r10 - 8) =3D 0;"
> +	"r1 =3D r10;"
> +	"r1 +=3D -8;"
> +	"call loop_stack_frames_reg;"
> +	"exit;"
> +	::: __clobber_all);
> +}

--- 8< ---

> +/*
> + * Exercise the same frame change through a spilled pointer. All registe=
rs
> + * at the loop header are identical, while fp-16 points to a different f=
rame.
> + */
> +static __naked __noinline __used
> +void loop_stack_frames_spill(void)
> +{
> +	asm volatile (
> +	"*(u64 *)(r10 - 8) =3D 1;"
> +	"*(u64 *)(r10 - 16) =3D r1;"
> +	"1: r1 =3D *(u64 *)(r10 - 16);"
> +	"r0 =3D *(u64 *)(r1 + 0);"
> +	"if r0 !=3D 0 goto 2f;"
> +	"r1 =3D r10;"
> +	"r1 +=3D -8;"
> +	"*(u64 *)(r10 - 16) =3D r1;"
> +	"goto 1b;"
> +	"2: exit;"
> +	::: __clobber_all);
> +}
> +
> +SEC("xdp")
> +__description("bounded loop changing stack frame in a spill")
> +__success __retval(1)
> +__flag(BPF_F_TEST_STATE_FREQ)
> +__naked void bounded_loop_stack_frames_spill(void)
> +{
> +	asm volatile (
> +	"*(u64 *)(r10 - 8) =3D 0;"
> +	"r1 =3D r10;"
> +	"r1 +=3D -8;"
> +	"call loop_stack_frames_spill;"
> +	"exit;"
> +	::: __clobber_all);
> +}
> +
>  char _license[] SEC("license") =3D "GPL";

I think this test is redundant, existing tests should already cover
the chain stack_safe -> regsafe.

--- >8 ---
