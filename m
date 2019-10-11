Return-Path: <SRS0=XZ9j=YE=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC3FC47404
	for <bpf@archiver.kernel.org>; Fri, 11 Oct 2019 18:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A2A7218AC
	for <bpf@archiver.kernel.org>; Fri, 11 Oct 2019 18:02:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vEJqWBNE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbfJKSCY (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 11 Oct 2019 14:02:24 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40939 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728374AbfJKSCX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Oct 2019 14:02:23 -0400
Received: by mail-qk1-f193.google.com with SMTP id y144so9681384qkb.7;
        Fri, 11 Oct 2019 11:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uvH3zY9Ae8PjYb+2rs975M3jIPTWD9fTgVebSjhl8Gg=;
        b=vEJqWBNEmB843DiuzdKWPesv8Ml7DKLPjHslfLuFRBy1IEZhRo41prZpJTSIwpxkQg
         7H3rvA/Ps8X/xM/oaciRY4/Dxluyj8MQUZPHjlIWR6dCdzoBdkveGmXdYlCah9LN45FG
         FOUwB9vOGJuhyZKEij3SOlUTn3B1PHa23NRz4lrC7FUOgOOZFQFP1ux801AeQjTQdS75
         2XwrWbO+1MarMi+xSl2YalER+fxiLn1gYDvs6EznBYigfaH2AEV4j0qYK53xvG7FaOeR
         ehlG5tttriCRYJHjHegSMVQSaaGasosSN5ft9afcnaiZ4wIgy8BLkxkkqnZOJygsufzm
         S9UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uvH3zY9Ae8PjYb+2rs975M3jIPTWD9fTgVebSjhl8Gg=;
        b=lpNRc+sy7jHP1qhZ7YCFqf7iN6w+G7ytt+YowhEIHJFxv72CvBPRGMyRu4n6ji+7WZ
         FotPal8FaYqHMVHMHK/jatg+6TWDTUXL0Ev3WNw5aL7Kx0CaH3s0oCKgOvLoGWfgavSl
         rxI1klxmbGFX0YVoqCN7Gr4VLEYdAotQ9SPGLjks6lbL2DDSSlkZybABxsMqbdXAlvox
         JrKnjyopIQTrpUg9sDdf5V03UsE7jnhSp20apb1NnsiBdricXh7So06B1v5r3ULOfyvi
         MQ7QqVwVp/ABnwVRACQp1/geK5kz+SpCBolTLwUC3bmaQydfsfzmRuFAx7kO+gE9X7GK
         DNPA==
X-Gm-Message-State: APjAAAWmGSUv+a0Vr5wX/bkQgNYhPwTsC/zg6O4/D8PseW5ZTn/DmXoe
        xIpqrvk7EFH8Ro3wYAqrPglkHo3Za00dxIeKSHY=
X-Google-Smtp-Source: APXvYqwxzWJeWi+LP9Xc3LgWNadrLwpMIaZZwzVIDpH+GTm7+bwF4MZ80e06PzjgfulCdPEfS7hGaDLK6s18M8E7Qxs=
X-Received: by 2002:a37:6d04:: with SMTP id i4mr17426523qkc.36.1570816942674;
 Fri, 11 Oct 2019 11:02:22 -0700 (PDT)
MIME-Version: 1.0
References: <20191010041503.2526303-1-ast@kernel.org> <20191010041503.2526303-6-ast@kernel.org>
In-Reply-To: <20191010041503.2526303-6-ast@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 11 Oct 2019 11:02:11 -0700
Message-ID: <CAEf4BzbONBDhK6WEMYEoz1JEcXR1tzNXPTq45fvWdTPKEjdyVQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 05/12] libbpf: auto-detect btf_id of raw_tracepoint
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

On Wed, Oct 9, 2019 at 9:17 PM Alexei Starovoitov <ast@kernel.org> wrote:
>
> For raw tracepoint program types libbpf will try to find
> btf_id of raw tracepoint in vmlinux's BTF.
> It's a responsiblity of bpf program author to annotate the program
> with SEC("raw_tracepoint/name") where "name" is a valid raw tracepoint.
> If "name" is indeed a valid raw tracepoint then in-kernel BTF
> will have "btf_trace_##name" typedef that points to function
> prototype of that raw tracepoint. BTF description captures
> exact argument the kernel C code is passing into raw tracepoint.
> The kernel verifier will check the types while loading bpf program.
>
> libbpf keeps BTF type id in expected_attach_type, but since
> kernel ignores this attribute for tracing programs copy it
> into attach_btf_id attribute before loading.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

Acked-by: Andrii Nakryiko <andriin@fb.com>

>  tools/lib/bpf/bpf.c    |  3 +++
>  tools/lib/bpf/libbpf.c | 17 +++++++++++++++++
>  2 files changed, 20 insertions(+)
>

[...]
