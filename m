Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A3F134419
	for <bpf@vger.kernel.org>; Thu, 21 Mar 2024 21:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711056482; cv=none; b=g3+O2aAOhZNXeMF74RQGr3fJ0hUzak8jvBrXdnvnyifv8vU689M6L/+xb1CzWnICKXmNj01GDhU1cRaVUEofNy5h9vgDglt39CliS2qjts6U4ehQGebxA2ZD7NmXR4VV3WFsvZD8OCxgq3i2Z1XZFpvfU40XFPVdh/4W12Anaj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711056482; c=relaxed/simple;
	bh=5YSbow8C7r7LxJmLUAIbW4qlP9Inezwyb4/NQGOCW7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UFuN9B03xQPHSYbCEdIcuOXB6qpZGvAn4/KxbKHoqRIybQfOnweqUhxiNTKJZv9rgqmxtPs0u7D9JFxuLTQKwmxpbxNI/JgAf/sjA4ZxMjw0w35G/yxAMssGqbbkV9joM9IppiJ+virPqFjfAgL5jGvbY6ab4ChQ3JLwOXRWMcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m3qtS0hQ; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m3qtS0hQ"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5d8b519e438so960843a12.1
        for <bpf@vger.kernel.org>; Thu, 21 Mar 2024 14:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711056480; x=1711661280; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a0rEd1Ltltod+ne/x88bJUE0+4B0i0sRPjxSQrEOG1k=;
        b=m3qtS0hQqw0py6fMgAytGGmRSk85SM9AaL3uYffaUTdm0aJoQbMEGxeUngYPj3Wgxw
         NKP92J5jcpx9CNRTqnPLc+vqkWR9mY9OokQkfIfOCt9cS2KjiyiyWYNEM6zV0uWXwJct
         UmQVDsNbEGK6pe1/+xcLqQn8lJdD7wM9TccofpBxF7sfr+UvSNQvfrv7nDv4vpNYSpOK
         TxdBrg/6f9kdFnAn+Xh4vUVZffp1UYZaJIKxWPbkfmW77f7fs5CHQOKFEumVsCZqzLbB
         sntNjs5svnYzfsw5FIXdHEXVzZDrxVtW/V1noETTriA7IvjtPl1BLYv/Ub3s6/SGPPwD
         4xLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711056480; x=1711661280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a0rEd1Ltltod+ne/x88bJUE0+4B0i0sRPjxSQrEOG1k=;
        b=knhjSJGsR6daW1/4xi/A7FnW39GgE0CxHdfU2/40YMylYBUJHlrDZgRvyWNyLAuM6P
         PQAu8qkmzsCYh589toIRyRzPR77tkctw8wT2TKXLODZY0JvhZl+bFUMjxoC9kfXxRSRK
         aAmO2xNUocvm0n4ZLRClcX4CsJz3Wp5YIm1BImxzI3XxpSUt9TXklPgvmUeSfuhdJhUc
         TvpF5e+YxBoE+f9MLpxccpcQJOsvTyhSuNbCXMu9KqRprMnGRgREnSa9WdifIEq+jxv7
         S7HI9Y1g3jjpk15Vdq7jYL122gldgZqyX128QvUVR/DOO5CZRfDGdrwDj/KpplHW/jo0
         ZXGQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9NjYSBiSUSkK6xCNCeJodJZI43fUHkiNMX/yf0tryzuB27f70KnEH0r6cWGeA38YkiA3Tnip3wfkzz3Gqv8OuCpbi
X-Gm-Message-State: AOJu0Yx61Dinq45zOIBBm+x5C78Sqv4nkS3/gohQl9rwb1zTlddTdOZb
	EhsklQ3p0cnRVbldvdQHFyZ7bV+gN2a5yLo7mX1u5gRC8YpR3Yu1BQbdTLJKEu7zNd5RjDfHlXE
	nmBPZTlIf5Tb2mwTSvJNfJBxwgQ0=
X-Google-Smtp-Source: AGHT+IG0nBroYVUuRtP5jXI1kv8wEGX/WVw6/QIPMqn5p6msFMbn9yN45TOxVrjGNTDAAEMKszSSiX7IGzLUzlraCTQ=
X-Received: by 2002:a17:90a:cc0c:b0:29b:c493:5c73 with SMTP id
 b12-20020a17090acc0c00b0029bc4935c73mr562877pju.25.1711056479979; Thu, 21 Mar
 2024 14:27:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321180501.734779-1-andrii@kernel.org> <20240321180501.734779-3-andrii@kernel.org>
 <ZfyhxfpOudwCVaD-@krava>
In-Reply-To: <ZfyhxfpOudwCVaD-@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 21 Mar 2024 14:27:48 -0700
Message-ID: <CAEf4BzaqfSELKyHwSj0khuP_hpob0spMVo-47GUp=sE+Ev7nXg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: inline bpf_get_branch_snapshot() helper
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, peterz@infradead.org, 
	song@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 2:08=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Thu, Mar 21, 2024 at 11:05:00AM -0700, Andrii Nakryiko wrote:
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
> >  kernel/bpf/verifier.c | 37 +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 37 insertions(+)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index de7813947981..4fb6c468e199 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -20130,6 +20130,43 @@ static int do_misc_fixups(struct bpf_verifier_=
env *env)
> >                       goto next_insn;
> >               }
> >
> > +             /* Implement bpf_get_branch_snapshot inline. */
> > +             if (prog->jit_requested && BITS_PER_LONG =3D=3D 64 &&
> > +                 insn->imm =3D=3D BPF_FUNC_get_branch_snapshot) {
> > +                     /* We are dealing with the following func protos:
> > +                      * u64 bpf_get_branch_snapshot(void *buf, u32 siz=
e, u64 flags);
> > +                      * int perf_snapshot_branch_stack(struct perf_bra=
nch_entry *entries, u32 cnt);
> > +                      */
> > +                     const u32 br_entry_size =3D sizeof(struct perf_br=
anch_entry);
> > +
> > +                     /* if (unlikely(flags)) return -EINVAL */
> > +                     insn_buf[0] =3D BPF_JMP_IMM(BPF_JNE, BPF_REG_3, 0=
, 5);
>
> nit, you moved the flags check on top, which I think makes sense and
> we should do it in bpf_get_branch_snapshot as well to keep it same
>

here I could control that it won't be taken in common case, so if we
are to do that in BPF helper itself, we should use unlikely() and
check that compiler actually honored it. I can add that in the next
revision.

> jirka
>
> > +                     /* transform size (bytes) into entry_cnt */
> > +                     insn_buf[1] =3D BPF_ALU32_IMM(BPF_DIV, BPF_REG_2,=
 br_entry_size);
> > +                     /* call perf_snapshot_branch_stack implementation=
 */
> > +                     insn_buf[2] =3D BPF_EMIT_CALL(static_call_query(p=
erf_snapshot_branch_stack));
> > +                     /* if (entry_cnt =3D=3D 0) return -ENOENT */
> > +                     insn_buf[3] =3D BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0=
, 4);
> > +                     /* return entry_cnt * sizeof(struct perf_branch_e=
ntry) */
> > +                     insn_buf[4] =3D BPF_ALU32_IMM(BPF_MUL, BPF_REG_0,=
 br_entry_size);
> > +                     insn_buf[5] =3D BPF_JMP_A(3);
> > +                     /* return -EINVAL; */
> > +                     insn_buf[6] =3D BPF_MOV64_IMM(BPF_REG_0, -EINVAL)=
;
> > +                     insn_buf[7] =3D BPF_JMP_A(1);
> > +                     /* return -ENOENT; */
> > +                     insn_buf[8] =3D BPF_MOV64_IMM(BPF_REG_0, -ENOENT)=
;
> > +                     cnt =3D 9;
> > +
> > +                     new_prog =3D bpf_patch_insn_data(env, i + delta, =
insn_buf, cnt);
> > +                     if (!new_prog)
> > +                             return -ENOMEM;
> > +
> > +                     delta    +=3D cnt - 1;
> > +                     env->prog =3D prog =3D new_prog;
> > +                     insn      =3D new_prog->insnsi + i + delta;
> > +                     continue;
> > +             }
> > +
> >               /* Implement bpf_kptr_xchg inline */
> >               if (prog->jit_requested && BITS_PER_LONG =3D=3D 64 &&
> >                   insn->imm =3D=3D BPF_FUNC_kptr_xchg &&
> > --
> > 2.43.0
> >
> >
