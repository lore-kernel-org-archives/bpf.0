Return-Path: <SRS0=/NIo=RH=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC34C10F03
	for <bpf@archiver.kernel.org>; Mon,  4 Mar 2019 23:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D84120684
	for <bpf@archiver.kernel.org>; Mon,  4 Mar 2019 23:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m57W7Hpz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbfCDXBh (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 4 Mar 2019 18:01:37 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42156 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbfCDXBh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 4 Mar 2019 18:01:37 -0500
Received: by mail-qk1-f195.google.com with SMTP id y140so3779614qkb.9;
        Mon, 04 Mar 2019 15:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZQVpOIrHimQNF0NuRtHA6GtavlcFZ+4wBLlHt8DzGHA=;
        b=m57W7HpzrRSujnYILC/5QBiur7M1Dxfd59E/I9smpq+FghkwGSM1E6PvsfoVf+mGRk
         YQ3OXJv3Vw74RZa+wJC9jP9RxLtQhqKpn2xQniGokhnu8zrDkG7wRIxLxckKAesHhLLc
         CGy8gE/cOFUj0xTjqOp4Efb114T9WfsQASKYqtRATSLzEePBkVlBY6K0lvNDBOfPJK/v
         IIH0QGU3+qM/hkEENc2cMus4B6BDl9Cbf9efXBsFRTMojkuhvoCjsYgCaaNqBokgRywZ
         erHberVtEXvwlxQOp7jIHBneC/BxS1rdhs3WJFcDTQ+CeDHwLW8XSwS2DFoErA72wJ50
         oxYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZQVpOIrHimQNF0NuRtHA6GtavlcFZ+4wBLlHt8DzGHA=;
        b=Z4N9nRdGiQQvuvWIF2I+L9c6/W6l1Jot21ui7UDQR11T2gwIscDIx9exDr+Y1TYgzb
         kNAqGOUDvlGOozk5kxpm8vHBm/NC3Xr2ZayGJ/zFdfqcAK0JG97EkIItRw9v6hkjrPk/
         8agZuxRAy0YS0h/+DOhdsyHrTx4z9VJbX9ZTOdWrCBot9mnpSGUovFs+EsuFNVATYSvl
         hXBP06MewZS5LgDG55N1M2VhDsUFhdHxLGpukxHwfxMvIw2Bc1fSzRPs6bDhzgUvvoaw
         +dl97aBcEdvdo0Yj7CfVPAeKHu/gcRN3d/VTTyfn3h1O6lusFVliIS+GeAlc/twLYbv5
         4/lQ==
X-Gm-Message-State: APjAAAVyV/r/wwQjhsCjFGTbeJfHC2clyCOLZRWsOFnmgEeCs7dmSlzV
        xZNPJbjqhHAccXiVnwk6hRzYhRW12GjHIox0vwU=
X-Google-Smtp-Source: APXvYqwCrqKHeLTCQLCLknDk+P7TmmAsrK732K2PQI0KxSqLcmzO+E1VTChwvJMt/URRM52+1MvjYMGN/TPinW2b1EE=
X-Received: by 2002:a37:8b87:: with SMTP id n129mr14933708qkd.5.1551740495375;
 Mon, 04 Mar 2019 15:01:35 -0800 (PST)
MIME-Version: 1.0
References: <20190304200853.22558-1-daniel@iogearbox.net>
In-Reply-To: <20190304200853.22558-1-daniel@iogearbox.net>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Mon, 4 Mar 2019 15:01:24 -0800
Message-ID: <CAPhsuW6yiUu6WSkC5Xz+Lks+mq7Af-xtqVe-K7oO=bdPUJA8gA@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: fix replace_map_fd_with_map_ptr's ldimm64 second
 imm field
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 4, 2019 at 12:09 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> Non-zero imm value in the second part of the ldimm64 instruction for
> BPF_PSEUDO_MAP_FD is invalid, and thus must be rejected. The map fd
> only ever sits in the first instructions' imm field. None of the BPF
> loaders known to us are using it, so risk of regression is minimal.
> For clarity and consistency, the few insn->{src_reg,imm} occurrences
> are rewritten into insn[0].{src_reg,imm}. Add a test case to the BPF
> selftest suite as well.
>
> Fixes: 0246e64d9a5f ("bpf: handle pseudo BPF_LD_IMM64 insn")
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>

Acked-by: Song Liu <songliubraving@fb.com>

> ---
>  [ Needs to wait until bpf tree has everything fast-forwarded from
>    Linus' tree. ]
>
>  kernel/bpf/verifier.c                           | 10 +++++-----
>  tools/testing/selftests/bpf/verifier/ld_imm64.c | 15 ++++++++++++++-
>  2 files changed, 19 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 0e4edd7..c8d2a94 100644
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
> index 28b8c80..3856dba 100644
> --- a/tools/testing/selftests/bpf/verifier/ld_imm64.c
> +++ b/tools/testing/selftests/bpf/verifier/ld_imm64.c
> @@ -122,7 +122,7 @@
>         .insns = {
>         BPF_MOV64_IMM(BPF_REG_1, 0),
>         BPF_RAW_INSN(BPF_LD | BPF_IMM | BPF_DW, 0, BPF_REG_1, 0, 1),
> -       BPF_RAW_INSN(0, 0, 0, 0, 1),
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
> 2.9.5
>
