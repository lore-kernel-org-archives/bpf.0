Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6757717C98
	for <bpf@vger.kernel.org>; Wed,  3 Apr 2024 18:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712167774; cv=none; b=R+FVAn0e1eTuYKXmVFtN8tuE2y8TseHrdUcJ+NFwMcp9qiixtCudSF4/2+fWWEn65k5anPVveLClyX/Xmv39gkAakVVe2dlW1TBn49KVq72ovO9Oedacoq1hqCtgv/ETQP4EcsVTLu9z0i8WsBvlemk0A/8LJ7XYynd23fYBvgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712167774; c=relaxed/simple;
	bh=XTL9q6185HCbcVWA2aAOnkKAqWdrsX3JZJzHjQXPTxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M2s7KzSF2jjxRIEGVY5cH6cabj2MHANbwJ7SV9cEVfJ/fblMRDz7vpPzDNRvRxybgZuBQxYc4tTXFpyZdckW0l6qIMrgOvFQPAmRstRQWtZdATmku0YZ66IoHUwQqVHQahabR1KkeuaL7pqUCbNCa7Z8kENW6ODvhteZN78NGQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YXFdY0GA; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YXFdY0GA"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5d81b08d6f2so177755a12.0
        for <bpf@vger.kernel.org>; Wed, 03 Apr 2024 11:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712167771; x=1712772571; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g5U/s482fGIRbUVxCAubj8I9WA58LPh4ufX5Vkh/gsc=;
        b=YXFdY0GAdT9hDB+9cElSDP9/bOB9D80cg9u7N+H9mgFN4fSL1aK/0Zg8Y7+EFnWltt
         I26vz7wPghzPJ5jdB3TPqMNRUNnJMes0ncve679AiW18BNFThm8MVywUGE220PsPACzJ
         7CV9NBZNTudXhYU/3BXjQGM4JbTy8DVI2TDDdUu/hUsbG+eujJWUWijcibSXraVvuURT
         XNwiGVLxfsROes+3FWRneBIzn7d8qfoRnKTcjWJlnmEkI9l0AieAJRQoMIdLk3XH3W+G
         sWg8ZXfVmSJ/ze0Gwj/K+Cx+eYnHNUBmQhwNQUVOUlDz/cQxAL6CeOvmV3FnzwOJTz+P
         Fjzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712167772; x=1712772572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g5U/s482fGIRbUVxCAubj8I9WA58LPh4ufX5Vkh/gsc=;
        b=H9yJvVkUEf+9zroImPVrzEx7+3fDt1bj0r931FKQ4WKPyS5XbM+sehodbHHH6M7baS
         UCfIPrS2ysp4xtkZOUEtMnLGoDQ7WPcjsNdbNVjzvooxw1gJSxYfIrJxl75tFq/YS9Y4
         TgNz8HZvxtifOeS8JFNHwhaP5vfL4F3YG3D0ig4HWYlEWXDgff56+LMnZx9zgpviXDn6
         QjZ2lht098ETsjqK/yhwTXvR+u+7oRbi749QRj13IhqxAsm3mhPtgeSdLXMUvkAVh27N
         MEUuuhVEPFGR9kb1539efxR8vcAhhYXe9Eg8/w2cuNNNtUN/MXAyNCzR5Vo6HGgvupkS
         u54A==
X-Forwarded-Encrypted: i=1; AJvYcCV1xleEXT64ZqxhnXoZSszt6wONHDA0KEb+HMZWI+WQ5CgVQr3qlm5cRyzu1g7/VR9sgr78+gDE2E6ih+3ETgwOUPv6
X-Gm-Message-State: AOJu0YzPH+zKLRCw8oUnRFy4jusA+l5bfmRAq/04YUEDjZDpVOiDl9FT
	OZKaePASueAp/tg32byiGvXsIlL+xT3Ql42n5nDYpzlvYvuRc9lw6JhbnVnEaF9LOLNSNsRzv+9
	DCsvVjNEjJh35s+wsyjA9za3QVUw=
X-Google-Smtp-Source: AGHT+IEez3mAWoL8PZF6UIBHflq4rM8DcYF6bofOEM5IVv6S34pU8FiJCYk6Ca9mfkdM1MzQxvaCb12mmN4n1EkbtG8=
X-Received: by 2002:a17:90a:68cc:b0:29f:7672:7fee with SMTP id
 q12-20020a17090a68cc00b0029f76727feemr255900pjj.31.1712167771622; Wed, 03 Apr
 2024 11:09:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402190542.757858-1-andrii@kernel.org> <20240402190542.757858-3-andrii@kernel.org>
 <CAADnVQJoyFoU53eSqC4OtfbnEO7CS=TCSPKpW=vJB4qY5QJJdg@mail.gmail.com>
In-Reply-To: <CAADnVQJoyFoU53eSqC4OtfbnEO7CS=TCSPKpW=vJB4qY5QJJdg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 3 Apr 2024 11:09:19 -0700
Message-ID: <CAEf4Bza5gyTbU1oiSu523Rs3ijD-bfdPcfK-SXX1CjbvQQGtbw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/2] bpf: inline bpf_get_branch_snapshot() helper
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 10:51=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Apr 2, 2024 at 12:05=E2=80=AFPM Andrii Nakryiko <andrii@kernel.or=
g> wrote:
> >
> > Inline bpf_get_branch_snapshot() helper using architecture-agnostic
> > inline BPF code which calls directly into underlying callback of
> > perf_snapshot_branch_stack static call. This callback is set early
> > during kernel initialization and is never updated or reset, so it's ok
> > to fetch actual implementation using static_call_query() and call
> > directly into it.
> >
> > This change eliminates a full function call and saves one LBR entry
> > in PERF_SAMPLE_BRANCH_ANY LBR mode.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  kernel/bpf/verifier.c | 55 +++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 55 insertions(+)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index fcb62300f407..49789da56f4b 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -20157,6 +20157,61 @@ static int do_misc_fixups(struct bpf_verifier_=
env *env)
> >                         goto next_insn;
> >                 }
> >
> > +               /* Implement bpf_get_branch_snapshot inline. */
> > +               if (prog->jit_requested && BITS_PER_LONG =3D=3D 64 &&
> > +                   insn->imm =3D=3D BPF_FUNC_get_branch_snapshot) {
> > +                       /* We are dealing with the following func proto=
s:
> > +                        * u64 bpf_get_branch_snapshot(void *buf, u32 s=
ize, u64 flags);
> > +                        * int perf_snapshot_branch_stack(struct perf_b=
ranch_entry *entries, u32 cnt);
> > +                        */
> > +                       const u32 br_entry_size =3D sizeof(struct perf_=
branch_entry);
> > +
> > +                       /* struct perf_branch_entry is part of UAPI and=
 is
> > +                        * used as an array element, so extremely unlik=
ely to
> > +                        * ever grow or shrink
> > +                        */
> > +                       BUILD_BUG_ON(br_entry_size !=3D 24);
> > +
> > +                       /* if (unlikely(flags)) return -EINVAL */
> > +                       insn_buf[0] =3D BPF_JMP_IMM(BPF_JNE, BPF_REG_3,=
 0, 7);
>
> optimizing this out with is_reg_const(R3) is probably overkill?
> Just mentioning in case you need to skip this branch.

probably an overkill, we'd need to make sure that any code path has R3
as constant zero.

Also note that these not taken branches don't pollute even the most
detailed PERF_SAMPLE_BRANCH_ANY mode, CPU only records non-linear code
execution changes, so it's fine from my perspective.

>
> > +
> > +                       /* Transform size (bytes) into number of entrie=
s (cnt =3D size / 24).
> > +                        * But to avoid expensive division instruction,=
 we implement
> > +                        * divide-by-3 through multiplication, followed=
 by further
> > +                        * division by 8 through 3-bit right shift.
> > +                        * Refer to book "Hacker's Delight, 2nd ed." by=
 Henry S. Warren, Jr.,
> > +                        * p. 227, chapter "Unsigned Divison by 3" for =
details and proofs.
> > +                        *
> > +                        * N / 3 <=3D> M * N / 2^33, where M =3D (2^33 =
+ 1) / 3 =3D 0xaaaaaaab.
> > +                        */
> > +                       insn_buf[1] =3D BPF_MOV32_IMM(BPF_REG_0, 0xaaaa=
aaab);
> > +                       insn_buf[2] =3D BPF_ALU64_REG(BPF_REG_2, BPF_RE=
G_0, 0);
> > +                       insn_buf[3] =3D BPF_ALU64_IMM(BPF_RSH, BPF_REG_=
2, 36);
> > +
> > +                       /* call perf_snapshot_branch_stack implementati=
on */
> > +                       insn_buf[4] =3D BPF_EMIT_CALL(static_call_query=
(perf_snapshot_branch_stack));
> > +                       /* if (entry_cnt =3D=3D 0) return -ENOENT */
> > +                       insn_buf[5] =3D BPF_JMP_IMM(BPF_JEQ, BPF_REG_0,=
 0, 4);
> > +                       /* return entry_cnt * sizeof(struct perf_branch=
_entry) */
> > +                       insn_buf[6] =3D BPF_ALU32_IMM(BPF_MUL, BPF_REG_=
0, br_entry_size);
> > +                       insn_buf[7] =3D BPF_JMP_A(3);
> > +                       /* return -EINVAL; */
> > +                       insn_buf[8] =3D BPF_MOV64_IMM(BPF_REG_0, -EINVA=
L);
> > +                       insn_buf[9] =3D BPF_JMP_A(1);
> > +                       /* return -ENOENT; */
> > +                       insn_buf[10] =3D BPF_MOV64_IMM(BPF_REG_0, -ENOE=
NT);
> > +                       cnt =3D 11;
> > +
> > +                       new_prog =3D bpf_patch_insn_data(env, i + delta=
, insn_buf, cnt);
> > +                       if (!new_prog)
> > +                               return -ENOMEM;
> > +
> > +                       delta    +=3D cnt - 1;
> > +                       env->prog =3D prog =3D new_prog;
> > +                       insn      =3D new_prog->insnsi + i + delta;
> > +                       continue;
> > +               }
> > +
> >                 /* Implement bpf_kptr_xchg inline */
> >                 if (prog->jit_requested && BITS_PER_LONG =3D=3D 64 &&
> >                     insn->imm =3D=3D BPF_FUNC_kptr_xchg &&
> > --
> > 2.43.0
> >
