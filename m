Return-Path: <SRS0=e5FL=Y4=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C69CA9EB5
	for <bpf@archiver.kernel.org>; Mon,  4 Nov 2019 16:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D401A214B2
	for <bpf@archiver.kernel.org>; Mon,  4 Nov 2019 16:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OST/unt/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbfKDQeO (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 4 Nov 2019 11:34:14 -0500
Received: from mail-lf1-f42.google.com ([209.85.167.42]:45561 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727838AbfKDQeO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 4 Nov 2019 11:34:14 -0500
Received: by mail-lf1-f42.google.com with SMTP id v8so12696011lfa.12;
        Mon, 04 Nov 2019 08:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rOLD+6cKLfPUwTYKxFJjwpmi3VGH2ZQhWjike0kdKRo=;
        b=OST/unt/peeJfd7oGfvFoqndmsOCKdubBqfV//AZJu1a3I0Ussr5NAH/AVvQ+vdsqv
         6ESKKkA5dx9hOlLW2rmGExLZqOezznknqYkj9GAIpNt+4UJKqABqqycxyTMnFTFiUaqU
         hjb88iTyWFaB3HPmcJ2NKeGBO0N2MODrraWL0IApkzbWhBFr8JjpUwR+EShR9fg4w7C+
         mMfqJBPzoyLhhZbiNMYh1EVShKJmGEh3hVIzGh29AXcBR3ZbsXzTGXCAiTKDZNJb3E4t
         hEszaAQAdD0b8p/LeO7rGL7EFlLjKLOBYomLpcDEpSzkZOZw91+rL6d8/TuSQ2WWiF+e
         6YMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rOLD+6cKLfPUwTYKxFJjwpmi3VGH2ZQhWjike0kdKRo=;
        b=SN2v9FaZ6H0mlkL7/1zGiISX9H3du3V91e5gUJ0u0jJZWTehJHk/nrc0lKvQwGlqCu
         XHdWVL8UJQvmjwl+OlAF3n9PRh5s0zL01RDFhUrCBnxuVVaFVyaMiY/XWck3fsCODU9U
         LDICzxUz719ph+P1UwASURZmpjTpn3iq5YHv+xLCupVVBxPCrP5z1Tv19TFVWTiXdLNX
         QyD7iyxvyZzyxdddyJZLfg6tr7X9+a9L3k8yTtVI+vINKVRg6oGmIogdJJz1l33hsmmd
         NFHGlKnhQIo7/Hb4yfD/rtVAcZcixXo6cRn9pIt6VLzbR6VQf/XUrmadws9gkiLtQDMK
         asfw==
X-Gm-Message-State: APjAAAWSW15NeWyr3fFy86cLYIR6eaDNeD11jYWfE591i8L6GJqpJb/q
        yzgJUWO3PD+3EQ4jwRI252BiN574ufoO1tPN3ic=
X-Google-Smtp-Source: APXvYqykrL5tjosVmKL0J0gReLZ2X6NRv2jXL88EZ8eJ9ReVCrZGrZzKedPkpqtTZCc3Rcw5p27o0pRNZ7t78NsVihU=
X-Received: by 2002:a19:10:: with SMTP id 16mr17605276lfa.100.1572885252071;
 Mon, 04 Nov 2019 08:34:12 -0800 (PST)
MIME-Version: 1.0
References: <20191102202632.2108287-1-ast@kernel.org> <20191102.161058.2119575310571747872.davem@davemloft.net>
In-Reply-To: <20191102.161058.2119575310571747872.davem@davemloft.net>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 4 Nov 2019 08:34:00 -0800
Message-ID: <CAADnVQKx9rPOpf-fsac6NLJ9za81hKpeCLw0r5mywmLjk-RMjA@mail.gmail.com>
Subject: Re: pull-request: bpf-next 2019-11-02
To:     David Miller <davem@davemloft.net>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Nov 2, 2019 at 4:11 PM David Miller <davem@davemloft.net> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
> Date: Sat, 2 Nov 2019 13:26:32 -0700
>
> > The following pull-request contains BPF updates for your *net-next* tree.
> >
> > We've added 30 non-merge commits during the last 7 day(s) which contain
> > a total of 41 files changed, 1864 insertions(+), 474 deletions(-).
>
> Pulled, please double check my handling of the test_offload.py revert.

Sorry for delay.
Daniel posted a fix:
https://patchwork.ozlabs.org/patch/1188975/
