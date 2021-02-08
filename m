Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA261C433E0
	for <bpf@archiver.kernel.org>; Mon,  8 Feb 2021 18:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1D1D64E88
	for <bpf@archiver.kernel.org>; Mon,  8 Feb 2021 18:24:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235503AbhBHSYU (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 8 Feb 2021 13:24:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235628AbhBHSW4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Feb 2021 13:22:56 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25CA2C06178A
        for <bpf@vger.kernel.org>; Mon,  8 Feb 2021 10:22:16 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id i71so15526860ybg.7
        for <bpf@vger.kernel.org>; Mon, 08 Feb 2021 10:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0ofkf5FlAYCfY6AC1DnSul+wjyRR+lUYlsXbMG1RyFA=;
        b=o9cbi9pGKZstq0LYEPsUDLjTMsmTsSk7QRngVyiXVhdeRbUQLoo+VqmfpcVS5qpuK+
         2R2eO1TJmZGkAhV75Imq3OuGIZZyz/I6h8eH74UTGkHjbc7h+7zaVQApcjpVwO/lPIBp
         c+NblAyA5UElvRuI+CWoI5Le0UuIR3WTAodE5x7xfTYfb3D32u8Wn06DftEFq+0e31sb
         Sz2igLqrWmAPABMRtTXgF4vT39Zz/oy+0uHuetx5U4fW2RHqgKKcwFzhbOUlPhfFugJx
         YMnDsxydGXmF13VflheNkK0MKKtgtR2+QajpC4mkplYs6Jl4GudyxDm6HayU8CUc6YOR
         KWlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0ofkf5FlAYCfY6AC1DnSul+wjyRR+lUYlsXbMG1RyFA=;
        b=lyZdszMnxxnJgQ511UbxB4DMLA29RgUtRp2LgTj6k1jQ9JvW+kjq0JPX3b9l04xq1x
         cMjcpvZkj+ojoOlVC3MqadJEgujJWL0qpL3FtNLTw82IvBn0NMfhhZvVnjYlq7ILsfei
         LbTgVsyxC8gXq9r9ntUhnxkcYxJb2mSJH9ems6uMVcjzPkTp0UbC0bihDPMsk5unqaF/
         FxRkFed8UB4QrTOLTs+SziIO3SlpJjOrLNIZ8wVKFIIjmKSGRT7XiAylvkqM2UzW4LsZ
         ZpMjhnPljD3syWrNbX92KvQQiknEZyzULcnQF4HOZvv2LZJznab3VhNBWSUkAyFtTDEP
         Nk4g==
X-Gm-Message-State: AOAM531TIGfOpITRTNsEPq36izcjkYokGYDa8uuTssBBuR5gb+NGvvyI
        uSE0mDsvXVzijdfrXVng2FlJ1JQ4mfj2zm7X9OGen/WS/vc=
X-Google-Smtp-Source: ABdhPJyPX8iD5EZmFWzXU7Ynk1Cr6d11wQrylbYNRGM5VBUJs6WKwO5+3StAidKjOenIJGMWhoZ+k9wQzdxmmA+RH/E=
X-Received: by 2002:a25:3805:: with SMTP id f5mr10434686yba.27.1612808535432;
 Mon, 08 Feb 2021 10:22:15 -0800 (PST)
MIME-Version: 1.0
References: <20210204234827.1628857-1-yhs@fb.com> <20210204234834.1629568-1-yhs@fb.com>
In-Reply-To: <20210204234834.1629568-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 8 Feb 2021 10:22:04 -0800
Message-ID: <CAEf4BzYC27CGJKuWWRmbKGUBoGhkFiftT+omyD9bkbT3wub1vQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 6/8] bpftool: print local function pointer properly
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 4, 2021 at 5:53 PM Yonghong Song <yhs@fb.com> wrote:
>
> With later hashmap example, using bpftool xlated output may
> look like:
>   int dump_task(struct bpf_iter__task * ctx):
>   ; struct task_struct *task = ctx->task;
>      0: (79) r2 = *(u64 *)(r1 +8)
>   ; if (task == (void *)0 || called > 0)
>   ...
>     19: (18) r2 = subprog[+18]
>     30: (18) r2 = subprog[+26]
>   ...
>   36: (95) exit
>   __u64 check_hash_elem(struct bpf_map * map, __u32 * key, __u64 * val,
>                         struct callback_ctx * data):
>   ; struct bpf_iter__task *ctx = data->ctx;
>     37: (79) r5 = *(u64 *)(r4 +0)
>   ...
>     55: (95) exit
>   __u64 check_percpu_elem(struct bpf_map * map, __u32 * key,
>                           __u64 * val, void * unused):
>   ; check_percpu_elem(struct bpf_map *map, __u32 *key, __u64 *val, void *unused)
>     56: (bf) r6 = r3
>   ...
>     83: (18) r2 = subprog[+-46]

this +-46 looks very confusing...

>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  tools/bpf/bpftool/xlated_dumper.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/tools/bpf/bpftool/xlated_dumper.c b/tools/bpf/bpftool/xlated_dumper.c
> index 8608cd68cdd0..7bdd90503727 100644
> --- a/tools/bpf/bpftool/xlated_dumper.c
> +++ b/tools/bpf/bpftool/xlated_dumper.c
> @@ -196,6 +196,9 @@ static const char *print_imm(void *private_data,
>         else if (insn->src_reg == BPF_PSEUDO_MAP_VALUE)
>                 snprintf(dd->scratch_buff, sizeof(dd->scratch_buff),
>                          "map[id:%u][0]+%u", insn->imm, (insn + 1)->imm);
> +       else if (insn->src_reg == BPF_PSEUDO_FUNC)
> +               snprintf(dd->scratch_buff, sizeof(dd->scratch_buff),
> +                        "subprog[+%d]", insn->imm + 1);

why not `subprog[%+d]` instead (see above about confusing output)

>         else
>                 snprintf(dd->scratch_buff, sizeof(dd->scratch_buff),
>                          "0x%llx", (unsigned long long)full_imm);
> --
> 2.24.1
>
