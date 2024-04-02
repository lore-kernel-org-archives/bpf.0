Received: from smtp5.epfl.ch (smtp5.epfl.ch [128.178.224.8])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E9715B117
	for <bpf@vger.kernel.org>; Tue,  2 Apr 2024 19:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.178.224.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712085135; cv=none; b=nL1lo/J/gn9aSGD+6WcnV6zK1Y4OsUrDySQ9EiR5tFBFrtRMa3mQ8ibfilbknLUsi742sMoEMz8k/eJuNszbshuK9TGY7yxwkvpFNoL61v7yfMsLC6DluaLQFHd5Ur+cEzyalRedb+TOZVPu+b660RYopiSxAVZ2ponQseHu1/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712085135; c=relaxed/simple;
	bh=x6rxRT1h+SC6NJwYXPFi6moDA2j5o1gXSuhls1XMYo0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AjWx2evK8/f6WEtVoxyanMfVzEkJ9xzwmU3Kfn+Cv82/SEl3K0jvXhwHFX7btjbv/0/YvHNuz+HyYGiTiSlUgwMajz9LDGMoTB24JC8qwkWmqKXV8wkbrFj/m8t99asD34TdRev0jETr9uzYM+DaHulmVY5hOxUjF+prtXQvVbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=epfl.ch; spf=pass smtp.mailfrom=epfl.ch; dkim=pass (1024-bit key) header.d=epfl.ch header.i=@epfl.ch header.b=YFqYfbIW; arc=none smtp.client-ip=128.178.224.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=epfl.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=epfl.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=epfl.ch header.i=@epfl.ch header.b="YFqYfbIW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=epfl.ch;
      s=epfl; t=1712084712;
      h=From:To:CC:Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
      bh=x6rxRT1h+SC6NJwYXPFi6moDA2j5o1gXSuhls1XMYo0=;
      b=YFqYfbIW/Je7eoMuZCPIWKDRJbtFQDb/84/U0AYFCjAWifDavrLiv3CzPRpnuJ3J2
        GoYvyTu9RBjGq2lVSk+jedInG94CsfoatTJ6LDtGPX2+pQu8PDHHhbxeHVoySB5wC
        V6sH+fg/+Aq1Vb/XQLAp5Nhn524DfYS41Tnq83K0g=
Received: (qmail 10155 invoked by uid 107); 2 Apr 2024 19:05:12 -0000
Received: from ax-snat-224-185.epfl.ch (HELO ewa10.intranet.epfl.ch) (192.168.224.185) (TLS, ECDHE-RSA-AES256-GCM-SHA384 (P-256 curve) cipher)
  by mail.epfl.ch (AngelmatoPhylax SMTP proxy) with ESMTPS; Tue, 02 Apr 2024 21:05:12 +0200
X-EPFL-Auth: fymHF+A+Bl+FfXPpIe3Jy/hHM3/W1gkuxr9+GiJp94ndJnH5GUg=
Received: from ewa07.intranet.epfl.ch (128.178.224.178) by
 ewa10.intranet.epfl.ch (128.178.224.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 2 Apr 2024 21:05:12 +0200
Received: from ewa07.intranet.epfl.ch ([fe80::f470:9b62:7382:7f3a]) by
 ewa07.intranet.epfl.ch ([fe80::f470:9b62:7382:7f3a%4]) with mapi id
 15.01.2507.035; Tue, 2 Apr 2024 21:05:12 +0200
From: Tao Lyu <tao.lyu@epfl.ch>
To: "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>
CC: "andrii@kernel.org" <andrii@kernel.org>, "yonghong.song@linux.dev"
	<yonghong.song@linux.dev>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	Sanidhya Kashyap <sanidhya.kashyap@epfl.ch>, "mathias.payer@nebelwelt.net"
	<mathias.payer@nebelwelt.net>, "meng.xu.cs@uwaterloo.ca"
	<meng.xu.cs@uwaterloo.ca>
Subject: Re: [PATCH] Inaccurate rejection conditions
Thread-Topic: [PATCH] Inaccurate rejection conditions
Thread-Index: AQHaesE6oKSpMDyWD0GxBW9b6juLYLFVNVmAgAAlwOA=
Date: Tue, 2 Apr 2024 19:05:12 +0000
Message-ID: <cae53ceb455c415fa2c4b10ec0a74df3@epfl.ch>
References: <20240320122153.3622252-1-tao.lyu@epfl.ch>,<CAEf4Bza98OQ-axH-o1xE4KA72Ga9bLwdDuWJS_irESbbxp1saA@mail.gmail.com>
In-Reply-To: <CAEf4Bza98OQ-axH-o1xE4KA72Ga9bLwdDuWJS_irESbbxp1saA@mail.gmail.com>
Accept-Language: en-US, fr-CH
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

>>
>> Signed-off-by: Tao Lyu <tao.lyu@epfl.ch>
>> ---
>>=A0 kernel/bpf/verifier.c | 1 +
>>=A0 1 file changed, 1 insertion(+)
>>
>> Hi,
>>
>> I am sorry to bother you due to my confusion on constraints about stack =
writes.
>>
>> 1. When an instruction stores 64-bit values onto the stack with fixed of=
fset and BPF_CAP only,
>>=A0=A0=A0 the verifier marks the stack slot type as STACK_SPILL, no matte=
r whether they are scalar or pointers.
>>
>> 2. Then, a store instruction with a **32-bit scalar value** on the same =
stack slot leads to a verification rejection.
>>=A0=A0=A0 As it says, this might corrupt the stack pointer by asserting i=
f the stack slot type is STACK_SPILL.
>>=A0=A0=A0 However, even if the stack slot type is STACK_SPILL, it might s=
tore a 64-bit scalar and not a stack pointer.
>>=A0=A0=A0 IMHO, this "issue" might originate from the incomplete conditio=
ns in the check_stack_write_fixed_off() function below.
>>=A0=A0=A0 It only checks if the stack slot is a spilled register but forg=
ets to check if the spilled register type is a pointer.
>>
>>=A0 4479 static int check_stack_write_fixed_off(struct bpf_verifier_env *=
env,
>>=A0 ...
>>=A0 4494=A0=A0=A0=A0 if (!env->allow_ptr_leaks &&
>>=A0 4495=A0=A0=A0=A0=A0=A0=A0=A0 is_spilled_reg(&state->stack[spi]) &&
>>=A0 4496=A0=A0=A0=A0=A0=A0=A0=A0 size !=3D BPF_REG_SIZE) {
>>=A0 4497=A0=A0=A0=A0=A0=A0=A0=A0 verbose(env, "attempt to corrupt spilled=
 pointer on stack\n");
>>=A0 4498=A0=A0=A0=A0=A0=A0=A0=A0 return -EACCES;
>>=A0 4499=A0=A0=A0=A0 }
>>=A0 ...
>>=A0 4600 }
>>
>> Below is an example bpf program, which stores a 64-bit and 32-bit immedi=
ate value on the same stack slot.
>> But the second one gets rejected due to the above.
>>
>> 0: R1=3Dctx() R10=3Dfp0
>> ; asm volatile ( @ repro.bpf.c:679
>> 0: (7a) *(u64 *)(r10 -8) =3D 1=A0=A0=A0=A0=A0=A0=A0=A0=A0 ; R10=3Dfp0 fp=
-8_w=3D1
>> 1: (62) *(u32 *)(r10 -8) =3D 1
>> attempt to corrupt spilled pointer on stack
>> processed 2 insns (limit 1000000) max_states_per_insn 0 total_states 0 p=
eak_states 0 mark_read 0.
>>
>> If my understanding is correct, then we can apply the attached patch.
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index de7813947981..65f7eb315e9c 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -4493,6 +4493,7 @@ static int check_stack_write_fixed_off(struct bpf_=
verifier_env *env,
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0 */
>>=A0=A0=A0=A0=A0=A0=A0=A0 if (!env->allow_ptr_leaks &&
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 is_spilled_reg(&state->stack[spi]) &=
&
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 state->stack[spi].spilled_ptr.type !=3D =
SCALAR_VALUE &&
>
> I think it's possible to easily convert PTR_TO_MEM kind of register to
> SCALAR_VALUE through arithmetic operations, and so allowing to spill
> SCALAR_VALUE to stack is basically just as dangerous as spilling
> PTR_TO_MEM directly.
>
> So it feels a bit dangerous to do this.

Hi Andrii, thanks for the reply.

I think you might misunderstand this issue.
Let me rephrase it below:

** The verifier should allow partially overwriting an 8-byte stack slot
that contains a spilled scalar instead of rejecting it,
as the example shows below.**=20

0: R1=3Dctx() R10=3Dfp0
; asm volatile ( @ repro.bpf.c:679
0: (7a) *(u64 *)(r10 -8) =3D 1=A0=A0=A0=A0=A0=A0=A0=A0=A0 ; R10=3Dfp0 fp-8_=
w=3D1
1: (62) *(u32 *)(r10 -8) =3D 1
attempt to corrupt spilled pointer on stack

In this case, it's about overwriting a spill of a 64-bit scalar=20
with another scalar with a smaller size (e.g., 32-bit).=20
Pointers are not related to this IIUC.

Thanks for your time again.

>
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 size !=3D BPF_REG_SIZE) {
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 verbose(env, "attempt to=
 corrupt spilled pointer on stack\n");
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EACCES;
>> --
>> 2.25.1
>>
