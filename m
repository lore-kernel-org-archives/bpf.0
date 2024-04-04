Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF65135A4B
	for <bpf@vger.kernel.org>; Thu,  4 Apr 2024 20:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712261299; cv=none; b=fwYbY6QUze8BSFSbRDG7lNrhEeSAkc3Q8kd+lOYIj+Qx5iwwt0iDMhrh2rL8GaMrEVZi/rpYA8DN99FSyHp+1GcQiIuHWp6RytJqfsldojIslzy6gBSAenIKTBYamY7ytUEH5FSe71OuEz4ZXkEpQ1c2qJ4wURLAFaNCKrAr4qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712261299; c=relaxed/simple;
	bh=7gIfBeg4W8b/lDEEtJ8K2bIbnf0yYpFejSqBh4nmFks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jdy+vJVXUvUi1FaTYHaLlHFKp94s3NFla8R5ytiJaj54HW7FA5lkTRORTvQfftOJEB6+AHmPb/cphR6NqulahY8tSnGdRevvN/5qBUa1ZJ2sAiHL3eX6JKRN4U1evUxuJ20LNKRBbABPhtWwDM5pkRi4XjWV25sKJVdGrUgOB/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AsKDU2qZ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AsKDU2qZ"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e27f800ad0so10212685ad.1
        for <bpf@vger.kernel.org>; Thu, 04 Apr 2024 13:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712261298; x=1712866098; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d4NGyYoZwIcoyvCLGknGbkVs2FYPG64sBHKY5J9Zdts=;
        b=AsKDU2qZlJau7EnCRLf5Va5ZxzbcqWObx9wHIoIRf5um/l6nkzp+FiNGbg/Zu1bUbR
         qJu8WiAi/RkGhzZt1jd7GAHcL7r2LABqwwviDWgfa3A5mEzku9ccTakAzRBQ+79bAbwI
         OdXQmdGpGQPnegPXHVxk3GTTf/za4Kkkr1s64dNelXicm5fgNRGqe0IluMxiLuGIjDGL
         zEqCV0Z/W8hfe+zo9/Pibvc9GtCkEXz/QOXP8/tteBY2caHD5g1GwUVtk9MCb+fOjaUN
         aCTwcyMT/Kj5Nwgv6kx++Z448TIIZJAfD42l9rYc4FYtHeayLlxoIpv6Vfsf6QMt4KON
         zLCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712261298; x=1712866098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d4NGyYoZwIcoyvCLGknGbkVs2FYPG64sBHKY5J9Zdts=;
        b=ioUk36WbOqJsou70fho+imdNJlp/OYO8UrPaK22iSVeH5CSth93q4jzTSncQYWBA99
         uCBtSFI54Mo+dnZhseJOa23Dq+7pkVkjdTZVW2rqLRjiHxUxHRSjihzGcTMSt6W6kzqR
         Y6vv1pb1DdGN/l8aKO8S6nMrduuNZYqo+yfviaoFVTz3+TWOBFgEPjkOaO5qllsyPVxX
         UO21xxMUzxEA4ku9jj1vgn7R4eAqCLU6Q1/HgILsfLfQKvnEe+DaVoe6fLsajy1OJNRT
         IqmUcHXbmoycssHVYvVIirqHvEn56UXCIV38G8nIfYaOmeDzrK22YbMX/sF4Gu9oiZt/
         CkWw==
X-Forwarded-Encrypted: i=1; AJvYcCWe8I7c4YHyYN1cUEbraz25yx2aVJZQh0lqgkw86ij9J7ONtXhem021AEoz6LTDtMk/lkLp0viO2wNIbun2yevVkKHA
X-Gm-Message-State: AOJu0YxLyl8u5UyWe1M2xJkFqlVWwlnnKUDTJEgJsS345psqvRXNNMMv
	87QsC6AwqRL9Q6PyrBFsacE+f6L2/HhYUX7m0MUtr5ru6+gh92WzF+2GapRhcI4wkkUUd1RHaQs
	u0FtM57rEjzJVh4BgYRfswQUaaiNDVQZioJs=
X-Google-Smtp-Source: AGHT+IHduAhlTxFIxEupEyJ0DpmYwBsdhBZi5JUcl7xLSwRlZ3YGV0AN0cu3zxvi+Affsb/K8bQeCh7wfuAaR6jNvDA=
X-Received: by 2002:a17:902:d48a:b0:1e2:82fc:bf71 with SMTP id
 c10-20020a170902d48a00b001e282fcbf71mr3817320plg.22.1712261297583; Thu, 04
 Apr 2024 13:08:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404002640.1774210-1-andrii@kernel.org> <20240404002640.1774210-3-andrii@kernel.org>
 <CAADnVQKc9QgOxvru-tqii0GO7H5+QD_=_v3O7_ant4BU1cNmKw@mail.gmail.com>
 <936229b3-ba4a-4c46-8042-977e5f069800@linux.dev> <CAADnVQJUOLZys=caUdHOA5JKwnmM8==P6JUYOLQ659+PbNayfQ@mail.gmail.com>
In-Reply-To: <CAADnVQJUOLZys=caUdHOA5JKwnmM8==P6JUYOLQ659+PbNayfQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 4 Apr 2024 13:08:05 -0700
Message-ID: <CAEf4BzZo2-6ax8-zybfp=28N7H3EsPuQQ5uPNuaN0ZyXZU7cnA@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 2/2] bpf: inline bpf_get_branch_snapshot() helper
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, Andrii Nakryiko <andrii@kernel.org>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kernel Team <kernel-team@meta.com>, John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 11:31=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Apr 4, 2024 at 11:28=E2=80=AFAM Yonghong Song <yonghong.song@linu=
x.dev> wrote:
> >
> >
> > On 4/4/24 11:14 AM, Alexei Starovoitov wrote:
> > > On Wed, Apr 3, 2024 at 5:27=E2=80=AFPM Andrii Nakryiko <andrii@kernel=
.org> wrote:
> > >> Inline bpf_get_branch_snapshot() helper using architecture-agnostic
> > >> inline BPF code which calls directly into underlying callback of
> > >> perf_snapshot_branch_stack static call. This callback is set early
> > >> during kernel initialization and is never updated or reset, so it's =
ok
> > >> to fetch actual implementation using static_call_query() and call
> > >> directly into it.
> > >>
> > >> This change eliminates a full function call and saves one LBR entry
> > >> in PERF_SAMPLE_BRANCH_ANY LBR mode.
> > >>
> > >> Acked-by: John Fastabend <john.fastabend@gmail.com>
> > >> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > >> ---
> > >>   kernel/bpf/verifier.c | 55 +++++++++++++++++++++++++++++++++++++++=
++++
> > >>   1 file changed, 55 insertions(+)
> > >>
> > >> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > >> index 17c06f1505e4..2cb5db317a5e 100644
> > >> --- a/kernel/bpf/verifier.c
> > >> +++ b/kernel/bpf/verifier.c
> > >> @@ -20181,6 +20181,61 @@ static int do_misc_fixups(struct bpf_verifi=
er_env *env)
> > >>                          goto next_insn;
> > >>                  }
> > >>
> > >> +               /* Implement bpf_get_branch_snapshot inline. */
> > >> +               if (prog->jit_requested && BITS_PER_LONG =3D=3D 64 &=
&
> > >> +                   insn->imm =3D=3D BPF_FUNC_get_branch_snapshot) {
> > >> +                       /* We are dealing with the following func pr=
otos:
> > >> +                        * u64 bpf_get_branch_snapshot(void *buf, u3=
2 size, u64 flags);
> > >> +                        * int perf_snapshot_branch_stack(struct per=
f_branch_entry *entries, u32 cnt);
> > >> +                        */
> > >> +                       const u32 br_entry_size =3D sizeof(struct pe=
rf_branch_entry);
> > >> +
> > >> +                       /* struct perf_branch_entry is part of UAPI =
and is
> > >> +                        * used as an array element, so extremely un=
likely to
> > >> +                        * ever grow or shrink
> > >> +                        */
> > >> +                       BUILD_BUG_ON(br_entry_size !=3D 24);
> > >> +
> > >> +                       /* if (unlikely(flags)) return -EINVAL */
> > >> +                       insn_buf[0] =3D BPF_JMP_IMM(BPF_JNE, BPF_REG=
_3, 0, 7);
> > >> +
> > >> +                       /* Transform size (bytes) into number of ent=
ries (cnt =3D size / 24).
> > >> +                        * But to avoid expensive division instructi=
on, we implement
> > >> +                        * divide-by-3 through multiplication, follo=
wed by further
> > >> +                        * division by 8 through 3-bit right shift.
> > >> +                        * Refer to book "Hacker's Delight, 2nd ed."=
 by Henry S. Warren, Jr.,
> > >> +                        * p. 227, chapter "Unsigned Divison by 3" f=
or details and proofs.
> > >> +                        *
> > >> +                        * N / 3 <=3D> M * N / 2^33, where M =3D (2^=
33 + 1) / 3 =3D 0xaaaaaaab.
> > >> +                        */
> > >> +                       insn_buf[1] =3D BPF_MOV32_IMM(BPF_REG_0, 0xa=
aaaaaab);
> > >> +                       insn_buf[2] =3D BPF_ALU64_REG(BPF_MUL, BPF_R=
EG_2, BPF_REG_0);
> > >> +                       insn_buf[3] =3D BPF_ALU64_IMM(BPF_RSH, BPF_R=
EG_2, 36);
> > >> +
> > >> +                       /* call perf_snapshot_branch_stack implement=
ation */
> > >> +                       insn_buf[4] =3D BPF_EMIT_CALL(static_call_qu=
ery(perf_snapshot_branch_stack));
> > > How will this work on non-x86 ?
> > > I tried to grep the code and looks like only x86 does:
> > > static_call_update(perf_snapshot_branch_stack,...)
> > >
> > > so on other arch-s static_call_query() will return zero/einval?
> > > And above will crash?
> >
> > Patch 1 will give the answer.In events/core.c, we have the following:
> > DEFINE_STATIC_CALL_RET0(perf_snapshot_branch_stack,
> > perf_snapshot_branch_stack_t); #define DEFINE_STATIC_CALL_RET0(name,
> > _func) \ DECLARE_STATIC_CALL(name, _func); \ struct static_call_key
> > STATIC_CALL_KEY(name) =3D { \ .func =3D __static_call_return0, \ .type =
=3D 1,
> > \ }; \ ARCH_DEFINE_STATIC_CALL_RET0_TRAMP(name) So the default value fo=
r
> > perf_snapshot_branch_stack  is
> > __static_call_return0.
> >
> > In static_call.c, long __static_call_return0(void) { return 0; }
> > EXPORT_SYMBOL_GPL(__static_call_return0); So we should be fine.
>
> I see. Thanks for explaining.
>

Yep, just like Yonghong explained. And I also dropped that CONFIG_X86
check in anticipation of [0], which hopefully lands some time in the
not too distant future.

  [0] https://lore.kernel.org/all/20240125094119.2542332-1-anshuman.khandua=
l@arm.com/
