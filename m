Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F01B44062B
	for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 22:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787265137; cv=none; b=tvMVMLB/LesOGU/I5Q5EJ/wE3+cHOE+u7PbG1WOmXmQ0sBb8UtxIbqEuoNu8bYI/b7NcXXYdEToxZT7VWAVWtDV3ECufPSqULV/vgFj6erdMEjrplXBnW0jAg37ydhYn2nUtE7ztcd/unPDGpFcGR8iWvZIBHMXGyuGpWG5U9d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787265137; c=relaxed/simple;
	bh=0k/B4BWXAbR4yDxkLlR7pSd88uFWIfGwHupq58yPvMA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CQUIoI+78gKMuTUg/TztmGCHONiyWD409AHcxwOc6W27wK2Ed29r1V7Y/qap3ZxtTndFYQsoNahh9nJJtYrALheAk5g6aoxA0JeFNhLOjrWlXfBif2LF//hmS9tjWKbfXziewibuOZYxujbAXV+k8gtvXlRJ/BK6HQwVYK/WDYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j3Nn1dza; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3Nn1dza"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2d5655cc850so4828035ad.3
        for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 15:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787265136; x=1787869936; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=1yVEVD7IPGffxOw2thK1OhfOygs5/vdFPOJ5C0IN8Q8=;
        b=j3Nn1dzaF7uzp2I7yQ/9e3+Hd0zL6hEk18saANG+xapO/tsIC3dhMCP3qbkIQNkANC
         P4dVswYS3MWihmWlWlyKbITU/bJNLFdHjaOrC4UuApPG1Sjal4sN5SDC2d1dzE1e1bhU
         /mIidMvYd3puPdE64duWCD+BRHQ1i6vMGoXceSjvFNLHPfk6S6DYxtiai1PQDE5hSkmx
         Di1jf3eg05Hwgduq8O5nQ7z7VXwGQz/H8rXPFXtKBlHk3e6Jm7Khh4QrWL2ZtKfs4yda
         tMsIzxqZFVA87FMr6Zys7IFYce1YsE7+0dzi5k5CjEsclYuKUI7KQS0cW01L6whPgGWO
         CxVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787265136; x=1787869936;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1yVEVD7IPGffxOw2thK1OhfOygs5/vdFPOJ5C0IN8Q8=;
        b=qIOqFJecFMNjjKs/Nei7O3rzHpI6XKG6PcFaH/uNtX+WFKTgZW47FbbE7wOS/DH4Rn
         WDj7UBNQ7zE2ppX4tRLLhI23fv3DeWd7EHXejXj+EoGEGnypBGBruPTra3uNkd2nrZYC
         ZwnRf+m6+rroWALGmx8ItzaKYa4CblSlBT3LaJPexcED82IrdZ6mvNh2jjc5SONWftDr
         EsHsRnXrYnOm7LrmLj/w4yuWL6rTmI3FFmqQxNj/5VXIOchAFZwzj2MRr6FUTtnTteCo
         Bd6aPbmxuY75PWz/g9uQzxWHuVHBUBMuLsXFTSASoA2Kgc0U4Ti9lc75loT7q5MdO/Xj
         rUsQ==
X-Gm-Message-State: AFuF++kYo0dPGZXWFG4nbtAnRFMdBEHLYKgcnZxkTKFbDNx3U4PreFS0
	cn4XGlLE3LUCpGzWzeqtwtVrQHUJQLqElrOO+0KKpkVnSpH1gfTiPwSi
X-Gm-Gg: AR+sD112MFLbDLX4vsDtfflNdYPVfGLvkQzdSpH0w8R0FSxoY/Ndd6BwUuL7SDMaVap
	rzhAUarvADNJRBU8Vl3e9ZuoUmw3Z0kHA2kCTeU2jYEexY8X7ZtTB1Ho/kQaSkFEFYqd1RAGPry
	rQCbCaOGv7GV/G+ep6oLXeyjra06hPNl05EDXBMt5B2ZNOUS+Nj8X9fGLcUSqXY2+yabLc6g2k4
	caqL9s9Z5BgC6klzPHHBqOqPW+4ncT2ivPamFCVryEDeYSIgvWhjNEHCw/l/Wa/k+SgAGAhqGZA
	Jz+2VoIGYb9H7vWcuNGzHkXxiBDEp0oIK80OZg6HHVbhi/9DTTB55H9EAo1Vii58J7WeHTLH9lC
	DKWzm467/0J/gHXAzUb2+jqmclQhrLThjownWd5rZFRc7ap+LoHjVSRFAaoN3y/Fw+7JHwOPEMq
	IYVwHtD9ySPZCwh56ATKD+NVdI9T9Rqs/DuAkbQ1WBIA+dfJ/k+LbJkeFaPQySgPmrpMr46Hugq
	MDDL5ddTO8JSmJuwNMtBkelsyTVyi1aRZh6d2xp/+skkw==
X-Received: by 2002:a17:902:e785:b0:2ca:6eca:492f with SMTP id d9443c01a7336-2d64b0e2c7fmr36769405ad.14.1787265135595;
        Thu, 20 Aug 2026 15:32:15 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:89bc:48d2:9457:6223? ([2620:10d:c090:500::6:c5ba])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bf10ca5csm19881157eec.17.2026.08.20.15.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 15:32:15 -0700 (PDT)
Message-ID: <9f50810d45db0b60248f106d21b4a278f3ec2156.camel@gmail.com>
Subject: Re: [PATCH v2 1/2] bpf: reject stack-argument callback subprograms
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, =?ISO-8859-1?Q?J=E9r=E9my?=
 Jean	 <Jeremy.Jean@oss.cyber.gouv.fr>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Kumar Kartikeya Dwivedi	 <memxor@gmail.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Date: Thu, 20 Aug 2026 15:32:13 -0700
In-Reply-To: <5d02cbe3-fd71-44e4-a6dd-706233ba248e@linux.dev>
References: <20260817204812.1637171-1-Jeremy.Jean@oss.cyber.gouv.fr>
	 <20260817204812.1637171-2-Jeremy.Jean@oss.cyber.gouv.fr>
	 <5d02cbe3-fd71-44e4-a6dd-706233ba248e@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-08-18 at 08:23 -0700, Yonghong Song wrote:
>=20
> On 8/17/26 1:48 PM, J=C3=A9r=C3=A9my Jean wrote:
> > Helper callbacks enter BPF subprograms through bpf_callback_t, whose
> > runtime ABI supplies five arguments. BTF validation nevertheless permit=
s
> > static callback subprograms to declare more than five arguments when JI=
T
> > stack arguments are supported.
> >=20
> > This lets verifier state for a callback use outgoing stack argument slo=
ts
> > prepared at the helper call site. The helper does not pass those slots.=
 On
> > x86-64, callback loads of arguments seven and later therefore read the
> > helper native frame instead of the synthetic values checked by the
> > verifier. KASAN reports a slab OOB write.
> >=20
> > Reject callback subprograms with incoming stack arguments when processi=
ng
> > callback calls.
> >=20
> > Fixes: 0f6bd5e7a804 ("bpf: Support stack arguments for bpf functions")
> > Assisted-by: Codex:gpt-5
> > Signed-off-by: J=C3=A9r=C3=A9my Jean <Jeremy.Jean@oss.cyber.gouv.fr>
> > ---
> >   kernel/bpf/verifier.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >=20
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index fdc5fbb1f78c..5fcefc0eaba0 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -9285,6 +9285,8 @@ static int push_callback_call(struct bpf_verifier=
_env *env, struct bpf_insn *ins
> >   	err =3D btf_check_subprog_call(env, subprog, caller->regs);
> >   	if (err =3D=3D -EFAULT)
> >   		return err;
> > +	if (bpf_in_stack_arg_cnt(&env->subprog_info[subprog]))
> > +		return -EINVAL;
>=20
> This is not good as user will not know why it failed. Your v1 does have a=
n error message.
>=20
> But this is not needed. Without above verifer.c change, user will get an =
error message:
>     func#0 writes 4 stack arg slots, but calls only require 0
>=20
> NACK, see my v1 comment: https://lore.kernel.org/bpf/14a7e7c2-36f7-4aa2-9=
b20-cc54700a9f1b@linux.dev/
>=20
> >  =20
> >   	/* set_callee_state is used for direct subprog calls, but we are
> >   	 * interested in validating only BPF helpers that can call subprogs =
as

Yonghong,

this is a real bug. Here is an example of a program that exposes
unsafe behavior:

    unsigned long arr[10];
   =20
    __noinline __used
    static int callback_9args(__u32 index, void *ctx, long a3, long a4,
                              long a5, long a6, long a7, long a8, long a9)
    {
            return arr[a9] % 2;    // verifier sees a9 as 0 and allows this=
 memory access
    }

    SEC("tc")
    __description("stack_arg: callback with incoming stack args")
    __failure
    __naked void stack_arg_callback_many_args(void)
    {
            asm volatile (
                    "r6 =3D 0;"
                    "*(u64 *)(r11 - 32) =3D 0;"
                    "*(u64 *)(r11 - 24) =3D 0;"
                    "*(u64 *)(r11 - 16) =3D 0;"
                    "*(u64 *)(r11 - 8) =3D 0;"
                    "r1 =3D 1;"
                    "r2 =3D %[callback_9args];"
                    "r3 =3D 0;"
                    "r4 =3D 0;"
                    "call %[bpf_loop];"
                    "r1 =3D 1;"
                    "r2 =3D 2;"
                    "r3 =3D 3;"
                    "r4 =3D 4;"
                    "r5 =3D 5;"
                    "*(u64 *)(r11 - 32) =3D 0;"
                    "*(u64 *)(r11 - 24) =3D 0;"
                    "*(u64 *)(r11 - 16) =3D 0;"
                    "*(u64 *)(r11 - 8) =3D 0;"
                    "call callback_9args;"   // this hides the callback cal=
l from the check in bpf_fixup_call_args()
                    "r0 =3D 0;"
                    "exit;"
                    :
                    : __imm_ptr(callback_9args),
                      __imm(bpf_loop)
                    : __clobber_common, "r6"
            );
    }

J=C3=A9r=C3=A9my,

Please update the test case as above, as your test case does not
really expose the bug. Also, I think that a better fix would be to
make stack arguments not-init in the callback frame. This way the
verifier would produce a proper error message.
