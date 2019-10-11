Return-Path: <SRS0=XZ9j=YE=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D63D7ECE58D
	for <bpf@archiver.kernel.org>; Fri, 11 Oct 2019 17:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0F00206A1
	for <bpf@archiver.kernel.org>; Fri, 11 Oct 2019 17:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bu2w7LBI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbfJKR47 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 11 Oct 2019 13:56:59 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39125 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728374AbfJKR47 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Oct 2019 13:56:59 -0400
Received: by mail-qk1-f193.google.com with SMTP id 4so9671573qki.6;
        Fri, 11 Oct 2019 10:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PV/mRv0VHozMbhZyS4wH4qDCHdvSnH7LmBWWEImzAow=;
        b=Bu2w7LBIFloqYPX+gkgt/4BdOy0SiOVabgwLSzj3vkIe8hvcUM1To/TNn2cgsjUVlh
         uTXmxZ0AJ3eoY2DeSV3x2uq1X566gRHeVr8ECXgDGUq+BSJKCPZdhDCL7clT3D9lmzdq
         7Zk0dAHZIMknaM8HAozU7GrnJiOvhG23WjNr2Q8vlWAxSDTSQWbrE9Pl+V0WgQcbVyIR
         L1Oag+OALIw9C4DJbHiu2r8rrtLilGUsVuMf+KQ3DqN2PTafgf6Xrbm4nKh8KZeQ7jdb
         OXH//ATfpowji29DFHxSo9h8T5xeOCuz/MLmyDdQY8fhxcK7LJNacLeoQPwrJ9n4MA5W
         ImaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PV/mRv0VHozMbhZyS4wH4qDCHdvSnH7LmBWWEImzAow=;
        b=F9hu8Uoeontkj0jopWL7kdPKyhQFSJ7oND07uizNPRkiCaOJ1n6U/Y6Yw47gJJzjv4
         wQsYyzDUvwXUmwC7dpV0tfNsQU+fmaoLZNENUQcsK27ByrFF0TDuwkDPDJy38y2wSG0B
         brDFLSIO2T4knEkihDqQA2WH73sZECKLiHLDHzJzbpIXbCH4+WK22TFWqckLZcXVG8ez
         9e3ljmvtZshOCuoc3DPwk9HopI310TrnbvoLcl8G2pdIz8UG7s/oZv9G5NJL16iGjqNZ
         o60fubDJvrvl8Rkt3ZOFj3cU4WPc4FZvzPFrx+4c1RPwgMCaG3Znc4jaquA8auNjYDjk
         2CTQ==
X-Gm-Message-State: APjAAAXF/m9kURgNArfRWiKh/wT6dEjRvNuNYTb5mlXgbEkyudgeOyH+
        7T55hKutXaPhYc5O/y4RFeaLPtaOnZHlPlOQkG8=
X-Google-Smtp-Source: APXvYqxWiC/R0cGjm5onLxVMDKn0tfsRkn0CHqvpLsECf8bm196Pm+8olgWz2+VF3lBX/8didxpOjSkrmeZVUYV4Em0=
X-Received: by 2002:a37:4c13:: with SMTP id z19mr17712216qka.449.1570816617916;
 Fri, 11 Oct 2019 10:56:57 -0700 (PDT)
MIME-Version: 1.0
References: <20191010041503.2526303-1-ast@kernel.org> <20191010041503.2526303-4-ast@kernel.org>
In-Reply-To: <20191010041503.2526303-4-ast@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 11 Oct 2019 10:56:46 -0700
Message-ID: <CAEf4BzYf3Q9rbwfG8PbXCHm=QoegP0d8ezYWqwtdNcSORdzhTA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 03/12] bpf: process in-kernel BTF
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>, x86@kernel.org,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 9, 2019 at 9:15 PM Alexei Starovoitov <ast@kernel.org> wrote:
>
> If in-kernel BTF exists parse it and prepare 'struct btf *btf_vmlinux'
> for further use by the verifier.
> In-kernel BTF is trusted just like kallsyms and other build artifacts
> embedded into vmlinux.
> Yet run this BTF image through BTF verifier to make sure
> that it is valid and it wasn't mangled during the build.
> If in-kernel BTF is incorrect it means either gcc or pahole or kernel
> are buggy. In such case disallow loading BPF programs.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

Acked-by: Andrii Nakryiko <andriin@fb.com>

>  include/linux/bpf_verifier.h |  4 +-
>  include/linux/btf.h          |  1 +
>  kernel/bpf/btf.c             | 71 +++++++++++++++++++++++++++++++++++-
>  kernel/bpf/verifier.c        | 20 ++++++++++
>  4 files changed, 94 insertions(+), 2 deletions(-)
>

[...]
