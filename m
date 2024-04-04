Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165DA1C6A7
	for <bpf@vger.kernel.org>; Thu,  4 Apr 2024 18:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712255502; cv=none; b=Ya1A6qwSpXihV1oMt5PBhjg49R26k55eMeuV1kzSZBkKEe6mbTizE5rwk0pafHaLtguRDJ3wDrLaRL0lF/cXlm7mk3Y0GKJ7iUgZCaGVOeuOrhUlV62kQoWJAd6jwGkoXuIgIlf1u1pONtZK+2bmAMPfwsJqIyigDm9XByQCYWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712255502; c=relaxed/simple;
	bh=8ze2z4SWxAgfp5spNxfdnzXxa74gZuolYVOEXd8zJ70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cy4kIPA/dGWAUQDBX4FbJdlquxBFlRtuGhU+3cJwR49i4T97IfcH0QhDRYyccewue+4rsMCXhbPaqUmMMH+LcmpWhtsSpF6Jje8NyV1wFYiKHRFHD9pWLfYhH/Ri3qDOrakw2Y59TYydhyNb3zwLyy8GCLhpAcWAwm3ay0KpS1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gTOpBpFi; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gTOpBpFi"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4162b5ba2bbso6083605e9.1
        for <bpf@vger.kernel.org>; Thu, 04 Apr 2024 11:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712255499; x=1712860299; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9BdbUxfjLmAjKQj6utRAWQE3Jq/J+ZaMsti61l/TrVQ=;
        b=gTOpBpFi3WLTC5PajeRQuNp67Utnq/r/d+rOWj3O/LaCGiILzp6OutAWgb4kmH0KsK
         8PAHisZZXgsolcpCEowN+PDUO1O4iUf6Za7xs8UWU+MgWQRMzu3UTCcr10m1oyBEIkrc
         pU5DQ1jV80vlToqGYbnNSCnDYJA1/RPJJWk2rdB6Zin50UFQXAzaMsXB5RxZ2mxEEv8/
         fgO3boqQ2JbwdiltgHVKJnWXQabsCgNXj0g9Cv1cBpGOJgT6Gkl/Lv0WCXJy9eIDp2mU
         Uh26L6Nz52fuK7oaLLcs2SWyKzMjHoK1audgyaKCZRHMJqKN95V+Kb3MtxR1+yXgym6Y
         gfMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712255499; x=1712860299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9BdbUxfjLmAjKQj6utRAWQE3Jq/J+ZaMsti61l/TrVQ=;
        b=Y5Y9e70MILjaGLDzqvJ6YEAiuKIERIYB7ol1P5yI3dA41PnJ1sVspsyERoRnHhQuDF
         yh8Zq+voGgl32JPuQO2L3+Q2tFFU+F10jBVK0gN8rOqDzH/qRo4lsckvQW/4T6CxZbBJ
         2ioIthXXHnuwdsmWjzFiY1k6nyzYemPqGqjfBB5e00NNxJDl/sgtOF/fsSNrH/Y2pxP+
         wqh4VSO8qmm+A+e5EDb1mfirH+XCZ8UzTVuZ+hxhnNw23E+xjVrgVVsZrxxwAi3dfI+l
         CK5X8h4lBluztdFWRJ6mQn12b2Wa/DxUg8f9tJrh2VhPtCHGrd2K2k20yM7VrbYW4bik
         Mb4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVm44Ba3+SRtIEB5w6594lXahYxOZETT+XxZ7WOSxwLWTqre1voYjHHdk+8zTxps5VODd9W8eBLlZsUI8lzF0d9IW2x
X-Gm-Message-State: AOJu0YxFpuF9yzo5uekhg/MrCLXte9GDZpVmAMk1l0EGa4R87ufAOJBG
	cQrfgpm9gR2ZsOMH6gOp4vVahWz2tiLxvfwhiBGGFRK1qHbxezO9/Y1wnVGFbeEjYGkf40N8FYI
	rbOpN4KB+LPFu/c+lM/QaZrZobBg=
X-Google-Smtp-Source: AGHT+IEBC5J9WGzCyRxeRn5VDa2PNT8jqr2LTyDJYjTvlaQDiHF1wzkl/8byeHpVi8YJLAA9HY8c6GJVrjsNUeJVReE=
X-Received: by 2002:adf:ee89:0:b0:343:34a9:12bc with SMTP id
 b9-20020adfee89000000b0034334a912bcmr2027609wro.51.1712255499405; Thu, 04 Apr
 2024 11:31:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404002640.1774210-1-andrii@kernel.org> <20240404002640.1774210-3-andrii@kernel.org>
 <CAADnVQKc9QgOxvru-tqii0GO7H5+QD_=_v3O7_ant4BU1cNmKw@mail.gmail.com> <936229b3-ba4a-4c46-8042-977e5f069800@linux.dev>
In-Reply-To: <936229b3-ba4a-4c46-8042-977e5f069800@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 4 Apr 2024 11:31:28 -0700
Message-ID: <CAADnVQJUOLZys=caUdHOA5JKwnmM8==P6JUYOLQ659+PbNayfQ@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 2/2] bpf: inline bpf_get_branch_snapshot() helper
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>, 
	John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 11:28=E2=80=AFAM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
> On 4/4/24 11:14 AM, Alexei Starovoitov wrote:
> > On Wed, Apr 3, 2024 at 5:27=E2=80=AFPM Andrii Nakryiko <andrii@kernel.o=
rg> wrote:
> >> Inline bpf_get_branch_snapshot() helper using architecture-agnostic
> >> inline BPF code which calls directly into underlying callback of
> >> perf_snapshot_branch_stack static call. This callback is set early
> >> during kernel initialization and is never updated or reset, so it's ok
> >> to fetch actual implementation using static_call_query() and call
> >> directly into it.
> >>
> >> This change eliminates a full function call and saves one LBR entry
> >> in PERF_SAMPLE_BRANCH_ANY LBR mode.
> >>
> >> Acked-by: John Fastabend <john.fastabend@gmail.com>
> >> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> >> ---
> >>   kernel/bpf/verifier.c | 55 +++++++++++++++++++++++++++++++++++++++++=
++
> >>   1 file changed, 55 insertions(+)
> >>
> >> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> >> index 17c06f1505e4..2cb5db317a5e 100644
> >> --- a/kernel/bpf/verifier.c
> >> +++ b/kernel/bpf/verifier.c
> >> @@ -20181,6 +20181,61 @@ static int do_misc_fixups(struct bpf_verifier=
_env *env)
> >>                          goto next_insn;
> >>                  }
> >>
> >> +               /* Implement bpf_get_branch_snapshot inline. */
> >> +               if (prog->jit_requested && BITS_PER_LONG =3D=3D 64 &&
> >> +                   insn->imm =3D=3D BPF_FUNC_get_branch_snapshot) {
> >> +                       /* We are dealing with the following func prot=
os:
> >> +                        * u64 bpf_get_branch_snapshot(void *buf, u32 =
size, u64 flags);
> >> +                        * int perf_snapshot_branch_stack(struct perf_=
branch_entry *entries, u32 cnt);
> >> +                        */
> >> +                       const u32 br_entry_size =3D sizeof(struct perf=
_branch_entry);
> >> +
> >> +                       /* struct perf_branch_entry is part of UAPI an=
d is
> >> +                        * used as an array element, so extremely unli=
kely to
> >> +                        * ever grow or shrink
> >> +                        */
> >> +                       BUILD_BUG_ON(br_entry_size !=3D 24);
> >> +
> >> +                       /* if (unlikely(flags)) return -EINVAL */
> >> +                       insn_buf[0] =3D BPF_JMP_IMM(BPF_JNE, BPF_REG_3=
, 0, 7);
> >> +
> >> +                       /* Transform size (bytes) into number of entri=
es (cnt =3D size / 24).
> >> +                        * But to avoid expensive division instruction=
, we implement
> >> +                        * divide-by-3 through multiplication, followe=
d by further
> >> +                        * division by 8 through 3-bit right shift.
> >> +                        * Refer to book "Hacker's Delight, 2nd ed." b=
y Henry S. Warren, Jr.,
> >> +                        * p. 227, chapter "Unsigned Divison by 3" for=
 details and proofs.
> >> +                        *
> >> +                        * N / 3 <=3D> M * N / 2^33, where M =3D (2^33=
 + 1) / 3 =3D 0xaaaaaaab.
> >> +                        */
> >> +                       insn_buf[1] =3D BPF_MOV32_IMM(BPF_REG_0, 0xaaa=
aaaab);
> >> +                       insn_buf[2] =3D BPF_ALU64_REG(BPF_MUL, BPF_REG=
_2, BPF_REG_0);
> >> +                       insn_buf[3] =3D BPF_ALU64_IMM(BPF_RSH, BPF_REG=
_2, 36);
> >> +
> >> +                       /* call perf_snapshot_branch_stack implementat=
ion */
> >> +                       insn_buf[4] =3D BPF_EMIT_CALL(static_call_quer=
y(perf_snapshot_branch_stack));
> > How will this work on non-x86 ?
> > I tried to grep the code and looks like only x86 does:
> > static_call_update(perf_snapshot_branch_stack,...)
> >
> > so on other arch-s static_call_query() will return zero/einval?
> > And above will crash?
>
> Patch 1 will give the answer.In events/core.c, we have the following:
> DEFINE_STATIC_CALL_RET0(perf_snapshot_branch_stack,
> perf_snapshot_branch_stack_t); #define DEFINE_STATIC_CALL_RET0(name,
> _func) \ DECLARE_STATIC_CALL(name, _func); \ struct static_call_key
> STATIC_CALL_KEY(name) =3D { \ .func =3D __static_call_return0, \ .type =
=3D 1,
> \ }; \ ARCH_DEFINE_STATIC_CALL_RET0_TRAMP(name) So the default value for
> perf_snapshot_branch_stack  is
> __static_call_return0.
>
> In static_call.c, long __static_call_return0(void) { return 0; }
> EXPORT_SYMBOL_GPL(__static_call_return0); So we should be fine.

I see. Thanks for explaining.
