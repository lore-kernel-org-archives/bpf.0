Return-Path: <SRS0=adOE=RE=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA2FDC43381
	for <bpf@archiver.kernel.org>; Fri,  1 Mar 2019 23:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A1A2205F4
	for <bpf@archiver.kernel.org>; Fri,  1 Mar 2019 23:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JgOd1UER"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbfCAXWq (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 1 Mar 2019 18:22:46 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42861 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfCAXWp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Mar 2019 18:22:45 -0500
Received: by mail-qk1-f193.google.com with SMTP id y140so15351624qkb.9;
        Fri, 01 Mar 2019 15:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q02CBW+ZZmmgK1qC+Z2omlOl5L28VYh0LQh91K8lQSQ=;
        b=JgOd1UERlsMU8QmPPTvyYneUD8xsK3luKNNzWFMMePHw3ohyYGiLr9DPj8mDczF2YK
         2ABGSbXPqpdhfaVzrxaM24x+Pq8/bLaAWg8A1Geq+YwPlIQjbXE42ICzjh7obMp5gFUz
         OlYw+FrPGWsjrLttHV/nn5Kl/iHkC9g/g01iKKSJnJjv+3KBzvsuHRUWcTSHW74Lc/xS
         amljKgWS9NZPLVjMxM9wcqZpnXaEy30EWk8hMr0ODDSYWfKqVOtablJyboD3CGQbz8Lc
         XHokI2zCQg1XxNgooCxEM7sizXB23TGnq7a9fM4/SaSttou0NF8r006+1GOf5t2QUboP
         xa0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q02CBW+ZZmmgK1qC+Z2omlOl5L28VYh0LQh91K8lQSQ=;
        b=pBwTTxIDYObiMxznsVOV8H2OrnnnOCHPP9N8r9qmZT4UwgrdNfVD4ZeavIHWCNnzCb
         7Nn2clG0Nk667e+gSOyJ+xJx7tH/+Gz0HyLxC3JzmolHqf9H7cKMCr/pWyqGDZxtYged
         mfx3lomzpawuJYSJ+BjdL5jQ9HX8snpmyuNuB7T5N8tcR1Rt05slB2D1c7lYU8l9kV50
         mgJ2kDO8vS0xLZ/943vIrj7/VG13NngfsPCeDhk+hNfJH4O2sRPAXSyYTJlGsEppd6Tv
         KgpSvzvchakNsFBiOZn3/5aN0ERTmnoP53mILBVUloxBWI0HHemRjLURigtWoEPVFJxm
         U3NA==
X-Gm-Message-State: APjAAAW98tjYjkCtwmLobQgE+7Ks8agdqTxPGNGmQE1f/S6QVxPkmQNL
        cuhJqJDMd87P+ZxrHm78fPmDeXME5QsSz3lrwGM=
X-Google-Smtp-Source: APXvYqyzXJm4R7YVNOVd/RLTkNPMCqyktSc3byJzHWhJKOWr5Y9WxuNde35d5+obsWk7hVHztz+H8D4IKQ7niGYaMAE=
X-Received: by 2002:a37:bc04:: with SMTP id m4mr5796530qkf.41.1551482564198;
 Fri, 01 Mar 2019 15:22:44 -0800 (PST)
MIME-Version: 1.0
References: <20190301210821.8330-1-daniel@iogearbox.net>
In-Reply-To: <20190301210821.8330-1-daniel@iogearbox.net>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Fri, 1 Mar 2019 15:22:33 -0800
Message-ID: <CAPhsuW7KwUns7WeAqx3s1Po0Vif0fvp8mZRYvpVm-nFtYzTYTg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: add test cases for non-pointer sanitiation logic
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <ast@fb.com>, afabre@cloudflare.com,
        Marek Majkowski <marek@cloudflare.com>, bpf@vger.kernel.org,
        Networking <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 1, 2019 at 1:10 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> Add two additional tests for further asserting the
> BPF_ALU_NON_POINTER logic with cases that were missed
> previously.
>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Marek Majkowski <marek@cloudflare.com>
> Cc: Arthur Fabre <afabre@cloudflare.com>
> ---
>  .../selftests/bpf/verifier/value_ptr_arith.c  | 44 ++++++++++++++++++-
>  1 file changed, 43 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/verifier/value_ptr_arith.c b/tools/testing/selftests/bpf/verifier/value_ptr_arith.c
> index 4b721a77bebb..c3de1a2c9dc5 100644
> --- a/tools/testing/selftests/bpf/verifier/value_ptr_arith.c
> +++ b/tools/testing/selftests/bpf/verifier/value_ptr_arith.c
> @@ -173,7 +173,7 @@
>         .retval = 0,
>  },
>  {
> -       "sanitation: alu with different scalars",
> +       "sanitation: alu with different scalars 1",
>         .insns = {
>         BPF_MOV64_IMM(BPF_REG_0, 1),
>         BPF_LD_MAP_FD(BPF_REG_ARG1, 0),
> @@ -198,6 +198,48 @@
>         .result = ACCEPT,
>         .retval = 0x100000,
>  },
> +{
> +       "sanitation: alu with different scalars 2",
> +       .insns = {
> +       BPF_MOV64_IMM(BPF_REG_0, 1),
> +       BPF_LD_MAP_FD(BPF_REG_1, 0),
> +       BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
> +       BPF_MOV64_REG(BPF_REG_2, BPF_REG_FP),
> +       BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -16),
> +       BPF_ST_MEM(BPF_DW, BPF_REG_FP, -16, 0),
> +       BPF_EMIT_CALL(BPF_FUNC_map_delete_elem),
> +       BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
> +       BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
> +       BPF_MOV64_REG(BPF_REG_2, BPF_REG_FP),
> +       BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -16),
> +       BPF_EMIT_CALL(BPF_FUNC_map_delete_elem),
> +       BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
> +       BPF_MOV64_REG(BPF_REG_8, BPF_REG_6),
> +       BPF_ALU64_REG(BPF_ADD, BPF_REG_8, BPF_REG_7),
> +       BPF_MOV64_REG(BPF_REG_0, BPF_REG_8),
> +       BPF_EXIT_INSN(),
> +       },
> +       .fixup_map_array_48b = { 1 },
> +       .result = ACCEPT,
> +       .retval = -EINVAL * 2,

Why "-EINVAL * 2" here?

> +},
> +{
> +       "sanitation: alu with different scalars 3",
> +       .insns = {
> +       BPF_MOV64_IMM(BPF_REG_0, EINVAL),
> +       BPF_ALU64_IMM(BPF_MUL, BPF_REG_0, -1),
> +       BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
> +       BPF_MOV64_IMM(BPF_REG_0, EINVAL),
> +       BPF_ALU64_IMM(BPF_MUL, BPF_REG_0, -1),
> +       BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
> +       BPF_MOV64_REG(BPF_REG_8, BPF_REG_6),
> +       BPF_ALU64_REG(BPF_ADD, BPF_REG_8, BPF_REG_7),
> +       BPF_MOV64_REG(BPF_REG_0, BPF_REG_8),
> +       BPF_EXIT_INSN(),
> +       },
> +       .result = ACCEPT,
> +       .retval = -EINVAL * 2,
> +},
>  {
>         "map access: value_ptr += known scalar, upper oob arith, test 1",
>         .insns = {
> --
> 2.17.1
>
