Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793206593;
	b=xT5WmsvcMfM5y8SZo8HeT2qPGZAh/8e4Z8L2acHas2uQNgnKNi1OHpPIbkeUPmmxLZPa
	 Q+roJujFUGMJYHrCxURk/Ehm974JcVNhy0YCA+CJfUyImSqhabc7bRfTJ4jV0LCDMi/GR
	 wl2Rt1LoBuMtcMo1QdGFbwtP9h2PR+bLQjXnkSKIgJ2lpsKQ40s8H0BBIRIzC92layfO5
	 FT6YlMZn7NKUUW4baEmosIh7daKO/tYkrr9vPQXnmK/jcf0Qhhyn9qXvP+84kXfN1As3X
	 UK7AKDy3ea9egA7tSkBvLgfIyIVaglE53ShWGqodyKDK6nSuvprTVw5q8wuxY29Kv/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793206593;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Subject:From:
	 To:Cc:X-Mailer:References:In-Reply-To;
	bh=kyFCRoyBUxLKzVM5Ky5RkepOUrjYWuax/Okp6By3xKE=;
	b=qmSN+s/Ac42/2J13Hh4rSMZZ+A8zLLX3JSpObEyxbaM/1t0jYUcJ84MVxSukPJSSRtYN
	 Rr9plaoZEqgl45gbwdQSAj88JkI/lFeVNRJb5n7lEiz/LUbuh6syUa4WJMc5lKCiCF+n+
	 h5y6evXFx2NUQzcw70FBP5l9JxVaJDt51vUhi6QOPpkCIk3tupoi77CDBoOR5pbGAGHwq
	 yXO6SmSWA1PDkRuqYIbgFjazU8w47v5cAL+G+eire9JE02DVPzaxtzcXBTVdVLzlCWT2L
	 41aUNmy8fbrRMHs8VzqddU16zAafuYEAgGg/xg3PySRMMfBliwi8ulOVOLDPHdDALrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RA0F7wy0;
	arc=none smtp.remote-ip=74.125.225.74
Received: from mail-wr2-f10.google.com (mail-wr2-f10.google.com [74.125.225.74])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4660960A262F
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 16:56:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4660960A262F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RA0F7wy0
Received: by mail-wr2-f10.google.com with SMTP id ffacd0b85a97d-48df0245ce6so666491f8f.0
        for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 09:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793206591; x=1793811391; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kyFCRoyBUxLKzVM5Ky5RkepOUrjYWuax/Okp6By3xKE=;
        b=RA0F7wy0NtD1gHt90kWdy3NmqHPLpVlfhvqG0Rp2hPiB10kNUM5sVGW7Luht8zayy8
         ye91pukA/S7+gdqDa3RJKYjdby9e8RwB0SWwc5WCiWYQZEq114Fm9jo04QAyhp4Sn2Lx
         Us1CRy07YDmU9c7k0ZoEKkUI8t7ORCOZ74eYiUT0SsW6CdN3sJVCqsPwPYAsRMoysSGf
         fKn3hANPFx+nVFlkpDpCEGce3d7xPtFpn8FvYwW1d967HvzkTO7zZySWeBZ4desw5RYq
         cSnmzWQzD2/ej2w3B3vvcRIILdPxxUlbuDgWXy5qy47eROsV9xbwpuVjccngP/v+jFXi
         EUNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793206591; x=1793811391;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kyFCRoyBUxLKzVM5Ky5RkepOUrjYWuax/Okp6By3xKE=;
        b=QOUXtXj4ocQot31iNuXF0mrcimuGLfBZn1FrpUc7am9aL75QO3NV+Zb5pBF276IOx9
         KyrZgAFU7CSdW5EaYcyXBi7qO+v0WuYAySBP+bkspocAIaM+jBzdfSPMn46xAXB9eUz/
         M3SSQ2Evp7tMX2QyvTH/Rvu8EimIBfLYPNBqGSht/6kG84UTn1OL0q8uYzn5SSwSmVkc
         Dth3nQcA821SFurbWqF59btURw9yI5FoaIchCiVewHL1c7Xyaxp6kKu8TQvgHvhKr0Ek
         2xvVlLoggGBWR+1AWTB6To8Pl+GasXBHZQwQwzpkqENRqrJt93vexC89o1GEgAfkLMAw
         L6Zw==
X-Gm-Message-State: AFq9FYLPDUNRwCZ+/sFrsrFWpNRhN9NmIgihzvRTGJUXXLNRGJ1zqTQM
	jgGJ6EH4yPyVpq4tJZZG1CxyNye+nHvZX/lHbz5FbBI6JeEzB0/H/ETZ
X-Gm-Gg: AYBFou2xXqz2AI/6ZG+RnMA+6oBbABdWiyAMHUEC/F3PTwbNY9dGmAL4Voll8G80ns1
	sgMZ4pKwlbJgnyAXUWhc7qZRiLtKlA+lK+XXoGftV+znITVKjz6uF0nRfUATsiJiMulnGNfPG7d
	SyZXOuUtp2OjH1/bIKFwMOIB9/KjsrqV8iYiRAbrVAtyiSVHqzGDirgC2nxsux8DU97t8mDXAp+
	VDo9QfsU+c6E5k/22SfxafQkAE5o6e+UQWy6CbjVoqwUHyvHMsUgThBByoSc2doVi8R22AP17DB
	87U0RrWj61WLKBdpv+i+De2OHjnbQOUgUO8jhxns+LgUii0Fc7dUveSTtVFS44nbHkMpvOW7zAP
	j8UkFnsTOqyKK8HtkF9hzTb2jrUKM7IwY9adohO+1V2JLwcsi3nUKfSMAsnHbwZ0oIHdCV7JT5n
	BM0ZMbGOIMIwTzxHsuKiHnMMm7ohh/y/69zVNMtKGForJXpeICEMz+wZ+dxkFyurDzrbexe2SRk
	e+0+Qep0/1Di6c8uij9ycAlLG5phfMWfWnM3gQUFovHkaO/APlaqK7E0C4gQ3RqD6KI1JWHfTez
	AJEAsw4S8O8wGLr4TKrEye1e2wQqXX9fUhP3xkICj33XJH8HCmGiRB8reHAQT3rI37lTQ21eltV
	y7aNy05haKztLNBPQJ/mG2zFjPbJJx8h8fF+wFY7xhFj2kW68R7pgjc8DV3VBuRKxloL+
X-Received: by 2002:adf:fe8b:0:b0:48d:f99d:a0d2 with SMTP id ffacd0b85a97d-48e5d5909b6mr5268317f8f.15.1793206591394;
        Wed, 28 Oct 2026 09:56:31 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc3dd7sm29612267f8f.15.2026.10.28.09.56.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2026 09:56:30 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 28 Oct 2026 17:56:30 +0100
Message-Id: <DMGMON3EQ62I.20R7XJBDGWJ4U@gmail.com>
Subject: Re: [PATCH bpf-next 0/7] bpf: Inline IRQ enter/exit instructions
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Emil Tsalapatis" <emil@etsalapatis.com>, "Alexei Starovoitov"
 <alexei.starovoitov@gmail.com>
Cc: <bpf@vger.kernel.org>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <daniel@iogearbox.net>
X-Mailer: aerc 0.21.0
References: <20261027162820.10887-1-emil@etsalapatis.com>
 <DMFRZIXSG0M2.YYE6X1OWNQWL@gmail.com>
 <CABFh=a6PxhNKnQ7KJJ9TbWhLg_GOQYWPxe3QSEAGEMTQ=o-5Vg@mail.gmail.com>
In-Reply-To: <CABFh=a6PxhNKnQ7KJJ9TbWhLg_GOQYWPxe3QSEAGEMTQ=o-5Vg@mail.gmail.com>

On Wed Oct 28, 2026 at 2:55 AM CET, Emil Tsalapatis wrote:
> On Tue, Oct 27, 2026 at 4:53=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>>
>> On Tue, Oct 27, 2026 at 09:28 AM Emil Tsalapatis <emil@etsalapatis.com> =
wrote:
>> > Add inlining for those functions. The inlining happens in two stages.
>> > First replace the call itself with a special BPF instruction denoting
>> > an IRQ disable-and save, or restore-and-enable. Those instructions
>> > are translated by the architecture-specific JIT into the corresponding
>> > operation.
>>
>> No. That doesn't scale. We cannot add new insns for every to-be-inlined =
kfunc.
>> See bpf_jit_inlines_helper_call().
>>
>
> Ack, the code below seems strictly better than reserving an instruction.
>
>> Like:
>>
>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>> index 6a2fe3d..c1c9a1c 100644
>> --- a/arch/x86/net/bpf_jit_comp.c
>> +++ b/arch/x86/net/bpf_jit_comp.c
>> @@ -3495,6 +3495,17 @@ populate_extable:
>>                         }
>>                         if (!imm32)
>>                                 return -EINVAL;
>> +                       if (src_reg =3D=3D BPF_PSEUDO_KFUNC_CALL && bpf_=
jit_inlines_kfunc_call(func)) {
>> +                               if (func =3D=3D (u8 *)bpf_local_irq_save=
) {
>> +                                       /* pushfq; pop [rdi]; cli */
>> +                                       EMIT4(0x9C, 0x8F, 0x07, 0xFA);
>> +                               } else {
>> +                                       /* test dword ptr [rdi], X86_EFL=
AGS_IF; je 1f; sti; 1: */
>> +                                       EMIT2_off32(0xF7, 0x07, X86_EFLA=
GS_IF);
>> +                                       EMIT3(X86_JE, 1, 0xFB);
>> +                               }
>> +                               break;
>> +                       }
>>                         if (src_reg =3D=3D BPF_PSEUDO_KFUNC_CALL) {
>>                                 fm =3D bpf_jit_find_kfunc_model(bpf_prog=
, insn);
>>                                 if (!fm)
>> @@ -5116,6 +5127,14 @@ bool bpf_jit_supports_kfunc_call(void)
>>         return true;
>>  }
>>
>> +bool bpf_jit_inlines_kfunc_call(void *func)
>> +{
>> +       if (!IS_ENABLED(CONFIG_BPF_SYSCALL) || IS_ENABLED(CONFIG_TRACE_I=
RQFLAGS) ||
>> +           cpu_feature_enabled(X86_FEATURE_XENPV))
>> +               return false;
>> +       return func =3D=3D bpf_local_irq_save || func =3D=3D bpf_local_i=
rq_restore;
>> +}
>>
>> ...
>>
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> index 648abe1..26b6a9d 100644
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
>> @@ -5197,8 +5197,8 @@ BTF_ID_FLAGS(func, bpf_get_kmem_cache, KF_PERFMON)
>>  BTF_ID_FLAGS(func, bpf_iter_kmem_cache_new, KF_ITER_NEW | KF_SLEEPABLE)
>>  BTF_ID_FLAGS(func, bpf_iter_kmem_cache_next, KF_ITER_NEXT | KF_RET_NULL=
 | KF_SLEEPABLE)
>>  BTF_ID_FLAGS(func, bpf_iter_kmem_cache_destroy, KF_ITER_DESTROY | KF_SL=
EEPABLE)
>> -BTF_ID_FLAGS(func, bpf_local_irq_save)
>> -BTF_ID_FLAGS(func, bpf_local_irq_restore)
>> +BTF_ID_FLAGS(func, bpf_local_irq_save, KF_FASTCALL)
>> +BTF_ID_FLAGS(func, bpf_local_irq_restore, KF_FASTCALL)
>>
>> and corresponding bits in bpf_get_call_summary()...
>>
>> but before doing any of that there gotta be performance numbers that it'=
s worth doing.
>>
>
> Makes sense, I assume you mean more macro numbers from
> production-grade programs apart from ubench numbers.
>

While you are it, it would be useful for bpf_preempt_{disable,enable}() to =
get
similar treatment.

>> pw-bot: cr

