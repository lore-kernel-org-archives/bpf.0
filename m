Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA3B31355D
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 18:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786386660; cv=none; b=lQLMURBC/lpfCFzgrxXSxm8WhFqxglsaPaYTjuqDKe99XEwOQVh63lGJTGVUra51S+5HVbcetS18KB/s9tl4xUV5jVxzxfwA+j1Vwss3W6pHrL9UKk+cFYs/Z1bH5Jzlb+4PgWKFvfziSrHKK+jFYyUeOaivbcNieQbY9cU7ZZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786386660; c=relaxed/simple;
	bh=wBIPq+LAaLuJ1moyKiKMR5wtIBn+XpcnHWoJL7PU/0M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dMe4oswCc5svx8Jqnk1LBFJjGs47pDamK645LPmRXJtobWo05YDTHSCO4L6VA8F+O5Cz5P7goSkP2+ybku/T3RCFqf+7qrf8qqxQs3qvef7jOli3d6DK0bFOd20GNTIEZMnlxG93qxVfBiS1SHAKL5CVAODbCBEH7F1PGxyXfs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d+CVVV40; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+CVVV40"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC4721F000E9;
	Mon, 10 Aug 2026 18:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786386659;
	bh=GNrckLdpo/R5upnatFKbMlsPdyJLL6+VM7177amYNNI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=d+CVVV40bZvlW3VVtHeSJ1Rg5FC6GCobf/mDZSWlgtPGbeIxQDLoQybTG2VlombIi
	 U0nrEh3Am27+uMt2pNagw/IFNbwwKzllJMhcmtIICCopCtalS316FF/EWoYG5P9idl
	 f5Irmr/slmmfLejcRTvDLuDhvhIJRYZ1Nwt0cumIEzSFw33qeQobAdK+phSfjUhOnh
	 Fdn6rhfZpqtTKJmvMm4FBXZWNMrQVu+8zKGJCAM7qFS2UB6W10hp6Dl/8Rq7DrFGGa
	 SAZAwlnVgsOAcZbTFs0UmEBY2ozv/zjIC9Dk9FapzY1O7xYLOVIqeEemujQdDC5Fi+
	 HMjRNOOrKEI+Q==
From: Puranjay Mohan <puranjay@kernel.org>
To: Eduard Zingerman <eddyz87@gmail.com>, Daniel Borkmann
 <daniel@iogearbox.net>, memxor@gmail.com
Cc: bpf@vger.kernel.org, Puranjay Mohan <puranjay12@gmail.com>
Subject: Re: [PATCH bpf-next 4/6] bpf, arm64: Clear fetch destination on
 faulting arena atomic
In-Reply-To: <7778fb7a81005f982f4073472f0435bc63a9287c.camel@gmail.com>
References: <20260810134346.466004-1-daniel@iogearbox.net>
 <20260810134346.466004-4-daniel@iogearbox.net>
 <7778fb7a81005f982f4073472f0435bc63a9287c.camel@gmail.com>
Date: Mon, 10 Aug 2026 19:30:51 +0100
Message-ID: <m2wltxj09w.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Eduard Zingerman <eddyz87@gmail.com> writes:

> On Mon, 2026-08-10 at 15:43 +0200, Daniel Borkmann wrote:
>> Same problem as on x86-64: add_exception_handler() folds "there is no
>> destination register to clear" and "this is a store" into one DONT_CLEAR
>> value ...
>>=20
>> =C2=A0 if (BPF_CLASS(insn->code) !=3D BPF_LDX && !bpf_atomic_is_load_acq=
(insn))
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dst_reg =3D DONT_=
CLEAR;
>>=20
>> ... which ex_handler_bpf() then reads back as the access direction:
>>=20
>> =C2=A0 bool is_write =3D (dst_reg =3D=3D DONT_CLEAR);
>>=20
>> A RMW carrying BPF_FETCH is both. emit_lse_atomic() reads the old value
>> into src_reg for BPF_{ADD,AND,OR,XOR} | BPF_FETCH and BPF_XCHG, and into
>> r0 for BPF_CMPXCHG, so a fault over an unmapped arena page is correctly
>> reported as a WRITE but leaves that register holding a stale value inste=
ad
>> of the 0 that every other BPF_PROBE_* access delivers. Same as on x86-64,
>> add a separate ARENA_WRITE bit for the direction and fill FIXUP_REG in
>> from bpf_atomic_load_reg().
>>=20
>> Fixes: e612b5c1d3ee ("bpf, arm64: Add support for lse atomics in bpf_are=
na")
>> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
>> Cc: Puranjay Mohan <puranjay@kernel.org>
>> ---
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
>> =C2=A0arch/arm64/net/bpf_jit_comp.c | 36 +++++++++++++++++++++++++------=
----
>> =C2=A01 file changed, 26 insertions(+), 10 deletions(-)
>>=20
>> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp=
.c
>> index d14d297ebb96..796ff9193cfb 100644
>> --- a/arch/arm64/net/bpf_jit_comp.c
>> +++ b/arch/arm64/net/bpf_jit_comp.c
>
> ...
>
>> @@ -1183,13 +1187,25 @@ static int add_exception_handler(const struct bp=
f_insn *insn,
>> =C2=A0	 * dst_reg like a BPF_LDX does, hence it must not be treated as a=
 store
>> =C2=A0	 * here.
>> =C2=A0	 */
>> -	if (BPF_CLASS(insn->code) !=3D BPF_LDX && !bpf_atomic_is_load_acq(insn=
))
>> -		dst_reg =3D DONT_CLEAR;
>> +	if (BPF_CLASS(insn->code) !=3D BPF_LDX && !bpf_atomic_is_load_acq(insn=
)) {
>> +		/*
>> +		 * A store has no destination register to clear, except for a
>> +		 * read-modify-write with BPF_FETCH, which also reads the old
>> +		 * value into src_reg, or into r0 for a BPF_CMPXCHG. Either way
>> +		 * the access is still reported as a write.
>> +		 */
>> +		int load_reg =3D bpf_atomic_load_reg(insn);
>
> Nit: I think it would be more in line with the current arm64 jit organiza=
tion
>      if bpf_atomic_load_reg() call is moved to the add_exception_handler()
>      callsite in the build_insn(), where it handles BPF_PROBE_ATOMIC.
>

Wouldn't that cause more code churn?
