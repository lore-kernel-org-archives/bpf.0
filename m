Return-Path: <SRS0=9Oao=SO=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7008EC10F14
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 23:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 401EC2084D
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 23:25:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJ+a4e2w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbfDLXZE (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 12 Apr 2019 19:25:04 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41983 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726624AbfDLXZD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Apr 2019 19:25:03 -0400
Received: by mail-qk1-f193.google.com with SMTP id o129so6679804qke.8;
        Fri, 12 Apr 2019 16:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5y2M/y3oow3EckHpyfzZx57b28LjP/9rxagn+wecC5M=;
        b=mJ+a4e2wrdUYjEGg/E18Pufm0JIJo1VIf/XHJESYSh02RPePMClmFvMIyzRuB4uguB
         FvUkPD/BUUTFErPe7qhG8LLx8p5xNNH0YHb4Hyb63v8l5BlJKeB25kt1G/XV5+aBIl4V
         MeC41MSOE/W+oGAqYe0WhHJ3lTJu006QXc+/HuyxXLz9m0RX3xrEc+kCVN1T6NEKB/oy
         2wXC5+eNdOZ5NA7TeLY7B9tQqRsMtGces3D/FmtUzRVzdyI7jZok9nCri4dwLbY/d6I2
         UNjtOewkf/mtjVmm9g4SR5cqXAPZNSB48qZPZ1wAhldxwkbcE4qcVeZoLATaeEXEe1e9
         B0YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5y2M/y3oow3EckHpyfzZx57b28LjP/9rxagn+wecC5M=;
        b=T4SjVDmj3SZHS5XJ1GRTLc2+L94uPXIPcjmx8JVCZ1B0mkNKkNE0wneiFiRBipyhey
         uWpsL0POWtVNnPFxpmHTO0aylhFFa6wow9y0wEdYBx5FLOhoUxGJkpTpxZitxp5dMvQc
         1Dd+hIl4JW2rUaK1ErROKc7cMZEEr+IFi02vR/sgl5Se3NUGLaV+BgnG4Flz+hAwL9B/
         nWRAUGdEezIi3ogCa0UM10W/VRxl5uYfptyeW/s1+KYi5lVacwZZ4E2koioWka4SjI88
         kTTV39lDXC+QWbL4weVR7kmGO5VsYHQ1JroL/G69w8XJOXYUXm+7wugiTDpbKwtjvcCA
         7YKw==
X-Gm-Message-State: APjAAAW4CmbMXPwfxlTmF4uZsbf3Rp9wxiSpxa+YMnmvpf8wYVFwmsnn
        igTmey6sJBmZ/5nx4c97G02UHAPQoTf1vwwTCG5ozPNc
X-Google-Smtp-Source: APXvYqyC+g02YVUgcNLGPOi7C1vTiI+KFvS2dTJv1H3aD39suB6wBXNNI9MXsvXu6rMfGREEakuOXJZF299SWsAWK1E=
X-Received: by 2002:a05:620a:1597:: with SMTP id d23mr45411722qkk.226.1555111502425;
 Fri, 12 Apr 2019 16:25:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190412214132.2726285-1-ast@kernel.org>
In-Reply-To: <20190412214132.2726285-1-ast@kernel.org>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Fri, 12 Apr 2019 16:24:51 -0700
Message-ID: <CAPhsuW7qxRywrDQ8PLWiFwHtfSsc+24LD1dPBnsO+jpQf8adfA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: two scale tests
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 12, 2019 at 2:41 PM Alexei Starovoitov <ast@kernel.org> wrote:
>
> Add two tests to check that sequence of 1024 jumps is verifiable.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Acked-by: Song Liu <songliubraving@fb.com>

Shall we add a test that go beyond the 1M limit?

> ---
>  tools/testing/selftests/bpf/test_verifier.c  | 70 ++++++++++++++++++++
>  tools/testing/selftests/bpf/verifier/scale.c | 18 +++++
>  2 files changed, 88 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/verifier/scale.c
>
> diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
> index e2ebcaddbe78..6cb6a1074fd1 100644
> --- a/tools/testing/selftests/bpf/test_verifier.c
> +++ b/tools/testing/selftests/bpf/test_verifier.c
> @@ -208,6 +208,76 @@ static void bpf_fill_rand_ld_dw(struct bpf_test *self)
>         self->retval = (uint32_t)res;
>  }
>
> +/* test the sequence of 1k jumps */
> +static void bpf_fill_scale1(struct bpf_test *self)
> +{
> +       struct bpf_insn *insn = self->fill_insns;
> +       int i = 0, k = 0;
> +
> +       insn[i++] = BPF_MOV64_REG(BPF_REG_6, BPF_REG_1);
> +       /* test to check that the sequence of 1024 jumps is acceptable */
> +       while (k++ < 1024) {
> +               insn[i++] = BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
> +                                        BPF_FUNC_get_prandom_u32);
> +               insn[i++] = BPF_JMP_IMM(BPF_JGT, BPF_REG_0, bpf_semi_rand_get(), 2);
> +               insn[i++] = BPF_MOV64_REG(BPF_REG_1, BPF_REG_10);
> +               insn[i++] = BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_6,
> +                                       -8 * (k % 64 + 1));
> +       }
> +       /* every jump adds 1024 steps to insn_processed, so to stay exactly
> +        * within 1m limit add MAX_TEST_INSNS - 1025 MOVs and 1 EXIT
> +        */
> +       while (i < MAX_TEST_INSNS - 1025)
> +               insn[i++] = BPF_ALU32_IMM(BPF_MOV, BPF_REG_0, 42);
> +       insn[i] = BPF_EXIT_INSN();
> +       self->prog_len = i + 1;
> +       self->retval = 42;
> +}
> +
> +/* test the sequence of 1k jumps in inner most function (function depth 8)*/
> +static void bpf_fill_scale2(struct bpf_test *self)
> +{
> +       struct bpf_insn *insn = self->fill_insns;
> +       int i = 0, k = 0;
> +
> +#define FUNC_NEST 7
> +       for (k = 0; k < FUNC_NEST; k++) {
> +               insn[i++] = BPF_CALL_REL(1);
> +               insn[i++] = BPF_EXIT_INSN();
> +       }
> +       insn[i++] = BPF_MOV64_REG(BPF_REG_6, BPF_REG_1);
> +       /* test to check that the sequence of 1024 jumps is acceptable */
> +       while (k++ < 1024) {
> +               insn[i++] = BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
> +                                        BPF_FUNC_get_prandom_u32);
> +               insn[i++] = BPF_JMP_IMM(BPF_JGT, BPF_REG_0, bpf_semi_rand_get(), 2);
> +               insn[i++] = BPF_MOV64_REG(BPF_REG_1, BPF_REG_10);
> +               insn[i++] = BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_6,
> +                                       -8 * (k % (64 - 4 * FUNC_NEST) + 1));
> +       }
> +       /* every jump adds 1024 steps to insn_processed, so to stay exactly
> +        * within 1m limit add MAX_TEST_INSNS - 1025 MOVs and 1 EXIT
> +        */
> +       while (i < MAX_TEST_INSNS - 1025)
> +               insn[i++] = BPF_ALU32_IMM(BPF_MOV, BPF_REG_0, 42);
> +       insn[i] = BPF_EXIT_INSN();
> +       self->prog_len = i + 1;
> +       self->retval = 42;
> +}
> +
> +static void bpf_fill_scale(struct bpf_test *self)
> +{
> +       switch (self->retval) {
> +       case 1:
> +               return bpf_fill_scale1(self);
> +       case 2:
> +               return bpf_fill_scale2(self);
> +       default:
> +               self->prog_len = 0;
> +               break;
> +       }
> +}
> +
>  /* BPF_SK_LOOKUP contains 13 instructions, if you need to fix up maps */
>  #define BPF_SK_LOOKUP(func)                                            \
>         /* struct bpf_sock_tuple tuple = {} */                          \
> diff --git a/tools/testing/selftests/bpf/verifier/scale.c b/tools/testing/selftests/bpf/verifier/scale.c
> new file mode 100644
> index 000000000000..7f868d4802e0
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/verifier/scale.c
> @@ -0,0 +1,18 @@
> +{
> +       "scale: scale test 1",
> +       .insns = { },
> +       .data = { },
> +       .fill_helper = bpf_fill_scale,
> +       .prog_type = BPF_PROG_TYPE_SCHED_CLS,
> +       .result = ACCEPT,
> +       .retval = 1,
> +},
> +{
> +       "scale: scale test 2",
> +       .insns = { },
> +       .data = { },
> +       .fill_helper = bpf_fill_scale,
> +       .prog_type = BPF_PROG_TYPE_SCHED_CLS,
> +       .result = ACCEPT,
> +       .retval = 2,
> +},
> --
> 2.20.0
>
