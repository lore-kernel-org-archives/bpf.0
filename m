Return-Path: <SRS0=ta3s=Y7=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 474EEFA372C
	for <bpf@archiver.kernel.org>; Thu,  7 Nov 2019 02:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E31D218AE
	for <bpf@archiver.kernel.org>; Thu,  7 Nov 2019 02:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jUuAB9/r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbfKGCuO (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 6 Nov 2019 21:50:14 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43854 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727443AbfKGCuO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Nov 2019 21:50:14 -0500
Received: by mail-qt1-f193.google.com with SMTP id l24so738357qtp.10;
        Wed, 06 Nov 2019 18:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9nCvA3gEV01dvB/sO3Fi4X7jcQkZ1f77jKTKksvxLZc=;
        b=jUuAB9/rt8iADI6nv+Wo0qGjLgM/XMJRlVcIeq+hza2zj6FVDsbDKPldAPbbZbHp7q
         b8a8CR9pbKCc5X0fQFhxoyaCEnp8ycHGM9j8ZyDumN69KUCewgaUDnY0g4QPSUJ/Fx3Z
         mk4Hql5JR4PJX+lKFj28kcSstStNY7kpg/igsi/bxjWVRUhb9VVTpJQ7Q2u1AN2N9NEY
         VQEs18jf//0fC18CN4iLNerND0/CpbXyX2J3ggMOuw9gCExu3tLkqlrr5I0XmzbPbwS9
         kdZk8A+UC+Sp6DVaBlScFVykjox1/wEUM1c0hY52qOyNn5N+P1h40jHhO/cGKW74kF1q
         41Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9nCvA3gEV01dvB/sO3Fi4X7jcQkZ1f77jKTKksvxLZc=;
        b=dKK4JwKoaft9HuZY6ENsd48ezOtdYfzEYegSY6wfS96aCGBf2T+nWmG+f+O1LWK/gE
         CtfkzFS6BLGZJ0x8kcgxpj3zgMP8xP5GBFL66ASM84OEDrnRxM6Nv1qybhiRNDC0YNJu
         eEVrDyaUiJL/KUb9n5mkiSezANNRazCGLk3iH5cAGx4jPiXAW5vTc5sf1MH5s2u2CBQy
         VDTCeTOWy4bfWD8qqR7UU9dp6qjOPdtd9wITck+tReu2dNtqlK1BVimQ5IEhd1gjrVE7
         3eaCoxPU+owJd60U5JjZAipN9KlUWnBtDAjmclI/bRBIZZRV9Q1TCithv/9jbAC7U7nz
         UgwQ==
X-Gm-Message-State: APjAAAWizAMqGDibHgPCU3a/m3ituzjA6S6rC3FKiK/Fp+NomIlweBji
        T5FP7Nhy3S/1WxLLvcey4u9QHRz6lVuINnSbdzM=
X-Google-Smtp-Source: APXvYqwdu05cX2LqU0iWzEIyz+ns5lunqe+h4BybMqO7m7/haNsOmwiL1HRSrWMH+JvVml5EYMQyDrIYGr/IalW5n8U=
X-Received: by 2002:aed:35e7:: with SMTP id d36mr1440795qte.59.1573095013477;
 Wed, 06 Nov 2019 18:50:13 -0800 (PST)
MIME-Version: 1.0
References: <20191107014639.384014-1-kafai@fb.com> <20191107014645.384662-1-kafai@fb.com>
In-Reply-To: <20191107014645.384662-1-kafai@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 6 Nov 2019 18:50:02 -0800
Message-ID: <CAEf4BzY6aDYKUGv2D-xy2bQKuH6zeMGvqA5p74xjcUXKq5KDZA@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 3/3] bpf: Add cb access in kfree_skb test
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 6, 2019 at 5:47 PM Martin KaFai Lau <kafai@fb.com> wrote:
>
> Access the skb->cb[] in the kfree_skb test.
>
> Signed-off-by: Martin KaFai Lau <kafai@fb.com>
> ---

Acked-by: Andrii Nakryiko <andriin@fb.com>

>  .../selftests/bpf/prog_tests/kfree_skb.c      | 54 +++++++++++++++----
>  tools/testing/selftests/bpf/progs/kfree_skb.c | 25 +++++++--
>  2 files changed, 63 insertions(+), 16 deletions(-)
>

[...]

>
> +       meta.ifindex = _(dev->ifindex);
> +       meta.cb8_0 = cb8[8];
> +       meta.cb32_0 = cb32[2];

Have you tried doing it inside __builtin_preserve_access_index region?
Does it fail because of extra allocations against meta?

> +
>         bpf_probe_read_kernel(&pkt_type, sizeof(pkt_type), _(&skb->__pkt_type_offset));
>         pkt_type &= 7;
>

[...]
