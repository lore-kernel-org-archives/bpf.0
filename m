Return-Path: <SRS0=p5ic=RF=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6DD7C43381
	for <bpf@archiver.kernel.org>; Sat,  2 Mar 2019 00:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D67220823
	for <bpf@archiver.kernel.org>; Sat,  2 Mar 2019 00:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fvu1nH49"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725966AbfCBAEl (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 1 Mar 2019 19:04:41 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35399 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfCBAEl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Mar 2019 19:04:41 -0500
Received: by mail-qt1-f194.google.com with SMTP id p48so29942076qtk.2;
        Fri, 01 Mar 2019 16:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VJHkPgwG4xaK0x07j2D9yCy9zQCkDD8Au52WR4RPm1U=;
        b=Fvu1nH49QZcnadD0pG7G94RqV6b8nHwQZaL9/8q8WThoSX1AZPKQlgrkUUSTgdFpCZ
         7N33rYZK0UtzfPCQSJzF8vuoUl6Q39wVo2Mkald0Jxmq5A6ZBvK4hGlwuFKapBY7unHY
         xInfirXx6bOQc15BZKD5Ysz1nUoalbMjdKP19ixLwoSon+k98ymv+gHIzEhndGoNzLS2
         eYhqV9NXrJZxooFRIs2qnNpTeQOSs0sKIgjGZBh3X7DyOzgj2iH0rC3UfpIcoaFGRCv2
         mAPxRZ+9o3bTMKMaxgthsQDd78ckbBGSxm4j9Ks5sUYjLqaw4pR9Tnvy3QZKO/gR2GkF
         b2DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VJHkPgwG4xaK0x07j2D9yCy9zQCkDD8Au52WR4RPm1U=;
        b=UjxJ0/Yh4Mb42CPFAmvhHu7Zo1OaDW83XBydZDTMdTPyBItN0LRs+2foOsjHs/0FqD
         mXmWLt7hQNlS3z3tD7MjUj5CT27rm+xOmgktf8iXY0U8FRne2jwPwLGt391i8VM94zRG
         9krLmcWD2lhVQz0d4bPf4iGJHIECbkEH/ONp6d05IaJCt7eQj3fnxgdzNOAd1itAhn6R
         e7HM/BMNer0d2KFIzVo+3V/Mo1UpA/uKmp5glo+dpalkcKhwyQdycLRyE+d+utNBm5Zv
         9C/UkQjowBXwAgJcqVrWWYPsBzjnWRP3iT8S1qv41N/e5GttysFRystAbcEwe5Bf59Bn
         aUew==
X-Gm-Message-State: APjAAAUgL33BemqP0J/8cbVTMQedJpmc1Nk0mDdQRcxFHqvpd5SOl+Us
        5HPQ9z/Bq4JTxkBr9UpxqPjIAJxAm8LpL4djX+M=
X-Google-Smtp-Source: APXvYqz3FeGzat+x6ULvLC/qz6fGD3KZAQcx5JDlUjqo7q8pkBuLS/eTn5bY0DtvRaC2DZ5lc1omU0jVDEp6iSW0+DA=
X-Received: by 2002:ac8:f4c:: with SMTP id l12mr6191142qtk.225.1551485079324;
 Fri, 01 Mar 2019 16:04:39 -0800 (PST)
MIME-Version: 1.0
References: <20190301210821.8330-1-daniel@iogearbox.net> <CAPhsuW7KwUns7WeAqx3s1Po0Vif0fvp8mZRYvpVm-nFtYzTYTg@mail.gmail.com>
 <aa825653-85f1-63c0-0dce-5963ab0aaeb1@iogearbox.net>
In-Reply-To: <aa825653-85f1-63c0-0dce-5963ab0aaeb1@iogearbox.net>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Fri, 1 Mar 2019 16:04:28 -0800
Message-ID: <CAPhsuW7dmvG-Uz2WJujerw3b7on6j8CJt9zfuojU9m2AAsiK_A@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: add test cases for non-pointer sanitiation logic
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <ast@fb.com>, afabre@cloudflare.com,
        Marek Majkowski <marek@cloudflare.com>,
        bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 1, 2019 at 3:27 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 03/02/2019 12:22 AM, Song Liu wrote:
> > On Fri, Mar 1, 2019 at 1:10 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
> >>
> >> Add two additional tests for further asserting the
> >> BPF_ALU_NON_POINTER logic with cases that were missed
> >> previously.
> >>
> >> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> >> Cc: Marek Majkowski <marek@cloudflare.com>
> >> Cc: Arthur Fabre <afabre@cloudflare.com>
> >> ---
> >>  .../selftests/bpf/verifier/value_ptr_arith.c  | 44 ++++++++++++++++++-
> >>  1 file changed, 43 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/tools/testing/selftests/bpf/verifier/value_ptr_arith.c b/tools/testing/selftests/bpf/verifier/value_ptr_arith.c
> >> index 4b721a77bebb..c3de1a2c9dc5 100644
> >> --- a/tools/testing/selftests/bpf/verifier/value_ptr_arith.c
> >> +++ b/tools/testing/selftests/bpf/verifier/value_ptr_arith.c
> >> @@ -173,7 +173,7 @@
> >>         .retval = 0,
> >>  },
> >>  {
> >> -       "sanitation: alu with different scalars",
> >> +       "sanitation: alu with different scalars 1",
> >>         .insns = {
> >>         BPF_MOV64_IMM(BPF_REG_0, 1),
> >>         BPF_LD_MAP_FD(BPF_REG_ARG1, 0),
> >> @@ -198,6 +198,48 @@
> >>         .result = ACCEPT,
> >>         .retval = 0x100000,
> >>  },
> >> +{
> >> +       "sanitation: alu with different scalars 2",
> >> +       .insns = {
> >> +       BPF_MOV64_IMM(BPF_REG_0, 1),
> >> +       BPF_LD_MAP_FD(BPF_REG_1, 0),
> >> +       BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
> >> +       BPF_MOV64_REG(BPF_REG_2, BPF_REG_FP),
> >> +       BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -16),
> >> +       BPF_ST_MEM(BPF_DW, BPF_REG_FP, -16, 0),
> >> +       BPF_EMIT_CALL(BPF_FUNC_map_delete_elem),
> >> +       BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
> >> +       BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
> >> +       BPF_MOV64_REG(BPF_REG_2, BPF_REG_FP),
> >> +       BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -16),
> >> +       BPF_EMIT_CALL(BPF_FUNC_map_delete_elem),
> >> +       BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
> >> +       BPF_MOV64_REG(BPF_REG_8, BPF_REG_6),
> >> +       BPF_ALU64_REG(BPF_ADD, BPF_REG_8, BPF_REG_7),
> >> +       BPF_MOV64_REG(BPF_REG_0, BPF_REG_8),
> >> +       BPF_EXIT_INSN(),
> >> +       },
> >> +       .fixup_map_array_48b = { 1 },
> >> +       .result = ACCEPT,
> >> +       .retval = -EINVAL * 2,
> >
> > Why "-EINVAL * 2" here?
>
> This is array map so deletion will return -EINVAL, basically I
> wanted to get a test case under socket filters where helper
> returns a stable value which is then unknown scalar to do some
> alu64 op with where sanitation logic triggers. So map_delete_elem()
> came in handy for that test.

I see, so the *2 comes from

BPF_ALU64_REG(BPF_ADD, BPF_REG_8, BPF_REG_7)

Thanks for the explanation.

Acked-by: Song Liu <songliubraving@fb.com>
