Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AFA38B993
	for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 04:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768968752; cv=pass; b=BE0z+R3HH2N4MzD+zQgSfA5iJLojKq9V7W6bDQ156DzsZKnM3PeOWvyJNl8nbZH+gh7sQdUoqeHSMrqwqI+DqUVOsjKBX025BRx2ufA1N+Nx/zARdKThWF6VgX/DgeqJJhgwoFcQ7Zmzid0YI6SwbHt4rDDeqFtW8e1JdRnLpNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768968752; c=relaxed/simple;
	bh=aLUt4k6Od5o9LKVcFoFJxVPDxiRTYBnrSQG++OERRVc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KtqiTe2RqXZsEWJsq6MPiPzySiJnvE2+VLVtWGh0FVeSY3iFB0x62DoE2lP2ZTrntzxSQVDIJ0pnf8ObNjz1iNlmABQUe3waNk3o7iWXDDjgFAMVYOP8nOgGDv9EwsNoxGHxz7gHvEPB5zAIdQjWjvoqhYmMtB2yTzdY1LsmUzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VtpxjZ2S; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VtpxjZ2S"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a0a95200e8so40098815ad.0
        for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 20:12:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768968743; cv=none;
        d=google.com; s=arc-20240605;
        b=M/AnmOz1p4FJpqIkMl2qmKSi/eNt6d3x9QhwTguhXXxY8uMViDCvxKutGNXrCRRqSu
         dljtC8YNAI1ywK6QtNRjgT+gXabF3cLYXVgxRvdUIyV0Yg5IU4TaGlDmGiDqO+1jB4Eq
         oFmy6pKEBK22v3GX7KYEVqWXEVGWJFckrej/tIoQjwpbM58Lgqj0STvYRhdgrPqMwxMw
         Efan2GHXGlqr+5vPj4pkiqp1kJjRpcWZjD/fAn0nDZ9SM/LE/a1kOaJGq8TXnMHTmKkN
         kf1nWrgmUQrrWZsFWEfs3iVTFu43A6PjWKTFSJCTtyL/Q+AllBBz9bQxlWfFYvdlcZmZ
         SpuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=toc67hYd9ZEB83MLwiwrRxa2cY0Idu7PjNgfB0rz6Ak=;
        fh=CLJqd8hGfHtLmV2wTj7Cp/zF1O5JFzuk2EM4fapume0=;
        b=jNVH1CIN/x0BHiqDCYQcTEk3Gwyjo9s2VEp79baozUduG2REvF4RbwON3RF55ViwB2
         05pqKsutQh9eu6crkYRMXobp3DqotXfjd8zSSouJhSBTsp06xejR3hCWsrDDlP3a3iXH
         Dl4Q/hjpAp5OMTQns26hgrGd7kNknoxDeQ5yNE4BMFJzizmvG8yS7EwXhkMwYbzdY2DI
         79FTfhqlt7X7qHlsobQxKGHWWpBDkJIxQ9kE1iM0TS9Uad19lDjsQK5dJZRQVw5nE4br
         CYUx93amDpkPSZsk/ucB+NaT9++oprekw+TCzscu5f0WvVy7ngc3QGKsJUTy8ARJYAUC
         RZxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768968743; x=1769573543; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=toc67hYd9ZEB83MLwiwrRxa2cY0Idu7PjNgfB0rz6Ak=;
        b=VtpxjZ2SWI54h9k6jwfYeMdA61wwTXDb0mDN+GMtYUT3Thh4qyFRtGzbi6J9N6g/tO
         ycN4d1nDMoaKr8aAExMePud4p8G4IeIUCgGpKayquBWb8UoSihDGWu9lhEcjn7x/1jJT
         +s19lJn9Dd8gLcUNRtrrmWJv97zvw6SVv56ogvhXhS72iecPFclcn/4kZG3uj/N3q6ZG
         96SLZH0Ga6W1yc3a6cncBO0eOgs/dHwmTltIscTCZWRLBx4OJNZzFjEqXDJ0w40gdT3K
         2PSQtzCIyiOLh6slblT02ZuIRurHSB3GMiqAd/sNJWUUAX0aP6zyp8IZizrJ+WzPhtKT
         jTTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768968743; x=1769573543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=toc67hYd9ZEB83MLwiwrRxa2cY0Idu7PjNgfB0rz6Ak=;
        b=cYCZgDBMMtT1pOKufuU1ZIH5KDytNeFa4lZxKNo+gKFZrqprtznoLYTYNKTUWaRWil
         X4nBubfnfE/Ry7pfUTjDjjYtBnp/C49yWNqRjfs+y+1WoZpbuWt+9CbDig0bAupgeC8m
         plx+QPKkj/CKRhQijgGWHgKgnbBMHS2MYvYK7iXwVpDq9T25/uNtLtG006DKW+/mj5RL
         Lcxsxi3ng8cZRCZ5ppf3p/c5rWa2tYH2jTmj6UPkA6b3D8HOgdQIjMvUARaku7ZkeO/C
         Cl/AnFXTFU9j6O84zZY2AcvCQ4RmX0stQgtakEsO2DZTEQ9ThKi2+2qjhB9K08ht5PZj
         VwBw==
X-Forwarded-Encrypted: i=1; AJvYcCUvhzs07AjqNB9P2Cmv+hK0i2O/pr2pNMXgwUmMlYsKDlApwao7jM4NUSJCRwgM4yO07So=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp/efEQIadFjqzA92uX7dDDpRgVvc3Srm+T09G17HFp1lbMoW+
	4xwsYp2pxsWa3Kww7Cjnfeu2rsnvy05aQMe/BNQdV+asq04aLjKnfL5nXKSgRnb0eDeyqT7/ps1
	s4fP8zQ6B7Im7q2AAEk/rjY7U4brMswU=
X-Gm-Gg: AZuq6aLyPGA/vt6Sfxd751qSBJe0/v+ZLw9iu7US5KEUhrTR4QYJXl/abvvQ4yZTjui
	RnYP1jKPyuG2TR1Ew+zobfo9HA0xabvgeWDonanzHSeds3DrXxfRKNEJ034KRIObZxPMtG6YHdG
	Bhm4zGgIOUBfEd6rl8PSJiOSlPQCA9nz0xSzmNfmwLJwUrvpC4x8enLqQVj06cwybLLuDTjQ4cN
	CFs2NueGEQIWq0j92BXMfLE/4T4yQPCnwVdn8Jjk97EPWJwfJLDlj/MWh6cMlRVMJk536I=
X-Received: by 2002:a17:903:252:b0:295:b46f:a6c2 with SMTP id
 d9443c01a7336-2a76ad6bfc7mr43451125ad.37.1768968742544; Tue, 20 Jan 2026
 20:12:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120070555.233486-1-dongml2@chinatelecom.cn>
 <20260120070555.233486-2-dongml2@chinatelecom.cn> <CAEf4BzYjbP4KwuVNT_pgjfXy=+7saEezmp1ck2L5txwtik5WYw@mail.gmail.com>
 <10788751.nUPlyArG6x@7940hx> <CAADnVQ+Om14RF1GvA0vkhKdsCtVGzbacftEZarLJ-LKdYXUZ+g@mail.gmail.com>
In-Reply-To: <CAADnVQ+Om14RF1GvA0vkhKdsCtVGzbacftEZarLJ-LKdYXUZ+g@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 20 Jan 2026 20:12:09 -0800
X-Gm-Features: AZwV_Qgqnnx41U8_yMztkT3t-Y5yNNkkRjDzM2bobYpRIXLJi-SWuKhgpE3nA8c
Message-ID: <CAEf4BzbVGx+0vn6n9T3rpePN7D4Mm54Xzc1spdSjvmrj1mV-0Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 1/2] bpf, x86: inline bpf_get_current_task()
 for x86_64
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Menglong Dong <menglong.dong@linux.dev>, Menglong Dong <menglong8.dong@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Eduard <eddyz87@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 20, 2026 at 7:10=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Jan 20, 2026 at 5:58=E2=80=AFPM Menglong Dong <menglong.dong@linu=
x.dev> wrote:
> >
> > On 2026/1/21 09:23 Andrii Nakryiko <andrii.nakryiko@gmail.com> write:
> > > On Mon, Jan 19, 2026 at 11:06=E2=80=AFPM Menglong Dong <menglong8.don=
g@gmail.com> wrote:
> > > >
> > > > Inline bpf_get_current_task() and bpf_get_current_task_btf() for x8=
6_64
> > > > to obtain better performance.
> > > >
> > > > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > > > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> > > > ---
> > > > v5:
> > > > - don't support the !CONFIG_SMP case
> > > >
> > > > v4:
> > > > - handle the !CONFIG_SMP case
> > > >
> > > > v3:
> > > > - implement it in the verifier with BPF_MOV64_PERCPU_REG() instead =
of in
> > > >   x86_64 JIT.
> > > > ---
> > > >  kernel/bpf/verifier.c | 22 ++++++++++++++++++++++
> > > >  1 file changed, 22 insertions(+)
> > > >
> > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > index 9de0ec0c3ed9..c4e2ffadfb1f 100644
> > > > --- a/kernel/bpf/verifier.c
> > > > +++ b/kernel/bpf/verifier.c
> > > > @@ -17739,6 +17739,10 @@ static bool verifier_inlines_helper_call(s=
truct bpf_verifier_env *env, s32 imm)
> > > >         switch (imm) {
> > > >  #ifdef CONFIG_X86_64
> > > >         case BPF_FUNC_get_smp_processor_id:
> > > > +#ifdef CONFIG_SMP
> > > > +       case BPF_FUNC_get_current_task_btf:
> > > > +       case BPF_FUNC_get_current_task:
> > > > +#endif
> > >
> > > Does this have to be x86-64 specific inlining? With verifier inlining
> > > and per_cpu instruction support it should theoretically work across
> > > all architectures that do support per-cpu instruction, no?
> > >
> > > Eduard pointed out [0] to me for why we have that x86-64 specific
> > > check. But looking at do_misc_fixups(), we have that early
> > > bpf_jit_inlines_helper_call(insn->imm)) check, so if some JIT has mor=
e
> > > performant inlining implementation, we will just do that.
> > >
> > > So it seems like we can just drop all that x86-64 specific logic and
> > > claim all three of these functions as inlinable, no?
> > >
> > > And even more. We can drop rather confusing
> > > verifier_inlines_helper_call() that duplicates the decision of which
> > > helpers can be inlined or not, and have:
> >
> > The verifier_inlines_helper_call() is confusing, but I think we can't
> > remove the x86-64 checking. For example, some architecture
> > don't support BPF_FUNC_get_current_task both in
> > bpf_jit_inlines_helper_call() and verifier_inlines_helper_call(), which
> > means it can't be inline.
> >
> > >
> > > if (env->prog->jit_requested && bpf_jit_supports_percpu_insn() {
> > >     switch (insn->imm) {
> > >     case BPF_FUNC_get_smp_processor_id:
> > >         ...
> > >         break;
> > >     case BPF_FUNC_get_current_task_btf:
> > >     case BPF_FUNC_get_current_task_btf:
> > >         ...
> > >         break;
> > >     default:
> > > }
> > >
> > > And the decision about inlining will live in one place.
> > >
> > > Or am I missing some complications?
> >
> > As Alexei said, the implement of "current" is architecture specific,
> > and the per-cpu variable "current_task" only exist on x86_64.
> >

Ah, ok, that's the complication :)

> > >
> > > And with all that, should we mark get_current_task and
> > > get_current_task_btf as __bpf_fastcall?
> >
> > I think it make sense, and the I saw bpf_get_smp_processor_id does
> > such operation:
> >
> > const struct bpf_func_proto bpf_get_smp_processor_id_proto =3D {
> >         [...]
> >         .allow_fastcall =3D true,
> > };
> >
> > PS: I'm a little confused about the fast call. We inline many helper,
> > but it seems that bpf_get_smp_processor_id is the only one that
> > use the "allow_fastcall". Why? I'd better study harder.
>
> It's
> static __bpf_fastcall __u32 (* const bpf_get_smp_processor_id)(void) =3D
> (void *) 8;
>
> and
> #define __bpf_fastcall __attribute__((bpf_fastcall))
>
> which makes LLVM use more registers at the callsite (less spill/fill).
>
> Looking at the patch again. I think it's fine as-is.
> fastcall can be a follow up.

Yeah, it's fine as is. But it still seems like
verifier_inlines_helper_call() is an unnecessary extra hop we can
remove (even if it has to stay arch-specific).
