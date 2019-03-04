Return-Path: <SRS0=/NIo=RH=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A76FC43381
	for <bpf@archiver.kernel.org>; Mon,  4 Mar 2019 17:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 207E02070B
	for <bpf@archiver.kernel.org>; Mon,  4 Mar 2019 17:32:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RxYwejvd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbfCDRcv (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 4 Mar 2019 12:32:51 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39861 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbfCDRcu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 4 Mar 2019 12:32:50 -0500
Received: by mail-ot1-f66.google.com with SMTP id e15so4900160otk.6;
        Mon, 04 Mar 2019 09:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m5IkZWT9E8I0wOW9EXdZklb2UNPzG9hG+TZTZ86CMGE=;
        b=RxYwejvdyPaRCAi5f+jgWV4d/I/eQw1auThmaV6adIU0OWWJP5vOOJaoWjp03JfMpe
         BpWnfQlkZvqSYLHrhKoHs61i5kWstlqP0drxDjj5pQcc+dfp6udOIhKr704ctxs2Rnsk
         qV4Cb79gy5qM+4egeC9+ulWbOHkMdP/AG4+47nOSfsm1ZIQPs/51veOfNl4VI5k4GlwV
         TtdtgIGn/wLDjvKekFtSL7U2twARh8VzC8+vWuP5qmM+DOmUWCeQhrvvEKr4s7DGjEiC
         Z8lOfZWc7umj3rjGtY6ozMmxKGdNb0d85DVlPq4T9f8pqbav0hx+pycW9yhErh/FSCJM
         cBkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m5IkZWT9E8I0wOW9EXdZklb2UNPzG9hG+TZTZ86CMGE=;
        b=SZ0aFrutNeOVwJV6jNcOtSI7qXM0hihdOIdS9EaFyG52bi8EL/96pdY1DMEVqNDWHf
         ztUWybwQNSWAdq2PAiPM+9ScXORcgYeL50WGmffBNpF8wI+ouz4X25LEztwwitdIZBOY
         69VGKa4YtFm2M/7U4aBBBK5fNtArfmVN++ygPIdeby2liLxzdphnqyd6dAd/LAZW/DNz
         aYd8P5aSFWfBtIMB5WH0vCLz0Y97gdoH4UqYDSNJnJS9ePFzFyFwIG2Pf1ZXQukDYQsK
         ZhReFXh12NMj6LQcoDea5/C0CLvRSy/devOcu1v//FMYwl3XahmjPtMqGlLp5j+3fqNQ
         oC4A==
X-Gm-Message-State: APjAAAU2Mn5GSq3lVAwZB3gsZczERSC08njcp0qnkkXp0BhzNK6kKSLY
        crtVMv0zS/+YlBovybO8Ud56WSN0hdFSFN7a7wk=
X-Google-Smtp-Source: APXvYqzcs2v5V8j1sEs48j7sIKDxi4+2HNqn75OWcTMLwbm5HmWOc7o7ZYuDeym+O2iaI/AuK6hZdMFaPBOb+MJKWZ0=
X-Received: by 2002:a9d:d88:: with SMTP id 8mr13865665ots.164.1551720769781;
 Mon, 04 Mar 2019 09:32:49 -0800 (PST)
MIME-Version: 1.0
References: <20190228231829.11993-1-daniel@iogearbox.net> <20190228231829.11993-2-daniel@iogearbox.net>
 <CAEf4BzZr1OQhiXS6+jraq_=HtjhTPvsNqcbizKKQvxPmOgZgXg@mail.gmail.com> <3311ac2f-2947-62d7-2be8-dcb4b23c6b5b@iogearbox.net>
In-Reply-To: <3311ac2f-2947-62d7-2be8-dcb4b23c6b5b@iogearbox.net>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 4 Mar 2019 09:32:38 -0800
Message-ID: <CAEf4Bzax_FtX1Gg0Y4RY2-4NKXq+pxcBHxfh2bnZb9NBQ=HDdw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/7] bpf: implement lookup-free direct value access
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <ast@fb.com>, bpf@vger.kernel.org,
        Networking <netdev@vger.kernel.org>,
        Joe Stringer <joe@wand.net.nz>,
        john fastabend <john.fastabend@gmail.com>, tgraf@suug.ch,
        Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        lmb@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 4, 2019 at 7:59 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 03/04/2019 07:03 AM, Andrii Nakryiko wrote:
> > On Thu, Feb 28, 2019 at 3:31 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
> [...]
> >> @@ -6664,8 +6669,10 @@ static int replace_map_fd_with_map_ptr(struct bpf_verifier_env *env)
> >>                 }
> >>
> >>                 if (insn[0].code == (BPF_LD | BPF_IMM | BPF_DW)) {
> >> +                       struct bpf_insn_aux_data *aux;
> >>                         struct bpf_map *map;
> >>                         struct fd f;
> >> +                       u64 addr;
> >>
> >>                         if (i == insn_cnt - 1 || insn[1].code != 0 ||
> >>                             insn[1].dst_reg != 0 || insn[1].src_reg != 0 ||
> >
> > Next line after this one rejects ldimm64 instructions with off != 0.
> > This check needs to be changed, depending on whether src_reg ==
> > BPF_PSEUDO_MAP_VALUE, right?
>
> Yes, that's correct, I already have that changed in my local branch for
> supporting non-zero off.
>
> > This is also to the previously discussed question of not enforcing
> > offset (imm=0 in 2nd part of insn) for BPF_PSEUDO_MAP_FD. Seems like
> > verifier *does* enforce that (not that I'm advocating for re-using
> > BPF_PSEUDO_MAP_FD, just stumbled on this bit when going through
> > verifier code).
>
> Not really, lets test:

Ah, sorry, my bad. That code tests .off, not .imm, so yeah, any imm
would be accepted.

>
> [...]
>         .insns = {
>         BPF_MOV64_IMM(BPF_REG_0, 0),
>         BPF_RAW_INSN(BPF_LD | BPF_IMM | BPF_DW, BPF_REG_1,
>                      BPF_PSEUDO_MAP_FD, 0, 0),
>         BPF_RAW_INSN(0, 0, 0, 0, 0xfefefe),
>         BPF_EXIT_INSN(),
>         },
> [...]
>
> #545/p test14 ld_imm64: reject 2nd imm != 0 FAIL
> Unexpected success to load!
> 0: (b7) r0 = 0
> 1: (18) r1 = 0xffff97e612486400
> 3: (95) exit
> processed 3 insns (limit 131072), stack depth 0
> Summary: 0 PASSED, 0 SKIPPED, 2 FAILED
>
> So I still think it would be worth doing something like the below
> for bpf:

Yep, lgtm.

>
> From 290f739ae6bab7b0709d327855a1812f9022beed Mon Sep 17 00:00:00 2001
> From: Daniel Borkmann <daniel@iogearbox.net>
> Date: Mon, 4 Mar 2019 14:22:41 +0000
> Subject: [PATCH bpf] bpf: fix replace_map_fd_with_map_ptr wrt ldimm64 wrt second imm field
>
> Non-zero imm value in the second part of the ldimm64 instruction for
> BPF_PSEUDO_MAP_FD is invalid, and thus must be rejected. The map fd
> only ever sits in the first instructions' imm field. None of the BPF
> loaders known to us are using it, so risk of regression is minimal.
> For clarity and consistency, the few insn->{src_reg,imm} occurences
> are rewritten into insn[0].{src_reg,imm}. Add a test case to the BPF
> selftest suite as well.
>
> Fixes: 0246e64d9a5f ("bpf: handle pseudo BPF_LD_IMM64 insn")
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  kernel/bpf/verifier.c                           | 10 +++++-----
>  tools/testing/selftests/bpf/verifier/ld_imm64.c | 17 +++++++++++++++--
>  2 files changed, 20 insertions(+), 7 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 0e4edd7e3c5f..c8d2a948db37 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -6678,17 +6678,17 @@ static int replace_map_fd_with_map_ptr(struct bpf_verifier_env *env)
>                                 /* valid generic load 64-bit imm */
>                                 goto next_insn;
>
> -                       if (insn->src_reg != BPF_PSEUDO_MAP_FD) {
> -                               verbose(env,
> -                                       "unrecognized bpf_ld_imm64 insn\n");
> +                       if (insn[0].src_reg != BPF_PSEUDO_MAP_FD ||
> +                           insn[1].imm != 0) {
> +                               verbose(env, "unrecognized bpf_ld_imm64 insn\n");
>                                 return -EINVAL;
>                         }
>
> -                       f = fdget(insn->imm);
> +                       f = fdget(insn[0].imm);
>                         map = __bpf_map_get(f);
>                         if (IS_ERR(map)) {
>                                 verbose(env, "fd %d is not pointing to valid bpf_map\n",
> -                                       insn->imm);
> +                                       insn[0].imm);
>                                 return PTR_ERR(map);
>                         }
>
> diff --git a/tools/testing/selftests/bpf/verifier/ld_imm64.c b/tools/testing/selftests/bpf/verifier/ld_imm64.c
> index 28b8c805a293..4a1ff4560a8a 100644
> --- a/tools/testing/selftests/bpf/verifier/ld_imm64.c
> +++ b/tools/testing/selftests/bpf/verifier/ld_imm64.c
> @@ -121,8 +121,8 @@
>         "test12 ld_imm64",
>         .insns = {
>         BPF_MOV64_IMM(BPF_REG_1, 0),
> -       BPF_RAW_INSN(BPF_LD | BPF_IMM | BPF_DW, 0, BPF_REG_1, 0, 1),
> -       BPF_RAW_INSN(0, 0, 0, 0, 1),
> +       BPF_RAW_INSN(BPF_LD | BPF_IMM | BPF_DW, 0, BPF_REG_1, 0, 999),
> +       BPF_RAW_INSN(0, 0, 0, 0, 0),
>         BPF_EXIT_INSN(),
>         },
>         .errstr = "not pointing to valid bpf_map",
> @@ -139,3 +139,16 @@
>         .errstr = "invalid bpf_ld_imm64 insn",
>         .result = REJECT,
>  },
> +{
> +       "test14 ld_imm64: reject 2nd imm != 0",
> +       .insns = {
> +       BPF_MOV64_IMM(BPF_REG_0, 0),
> +       BPF_RAW_INSN(BPF_LD | BPF_IMM | BPF_DW, BPF_REG_1,
> +                    BPF_PSEUDO_MAP_FD, 0, 0),
> +       BPF_RAW_INSN(0, 0, 0, 0, 0xfefefe),
> +       BPF_EXIT_INSN(),
> +       },
> +       .fixup_map_hash_48b = { 1 },
> +       .errstr = "unrecognized bpf_ld_imm64 insn",
> +       .result = REJECT,
> +},
> --
> 2.17.1
>
