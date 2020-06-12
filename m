Return-Path: <SRS0=5juC=7Z=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E5ADC433E0
	for <bpf@archiver.kernel.org>; Fri, 12 Jun 2020 22:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDFB620663
	for <bpf@archiver.kernel.org>; Fri, 12 Jun 2020 22:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/K6eexY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgFLW1C (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 12 Jun 2020 18:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgFLW1C (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Jun 2020 18:27:02 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF32AC03E96F;
        Fri, 12 Jun 2020 15:27:01 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id q19so12833842lji.2;
        Fri, 12 Jun 2020 15:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=etKK0PJEb1db058qQhJXVFpsTlugAG+cnL16z01cY8o=;
        b=M/K6eexYQiZP+v489DoNeUNJc0xtkvhIymy/lKVPEG79FLY6p9iAgIZ6EY0IcLfpPc
         C1FTksIO5lrv5XYIrAviQsfUDrge+1qOp7j9HimIMA7Q1SIUAmCAMwhlaZyYrsJLKpOX
         WVjk92eZSkiGkCxeW/4TWIOFvENQ1UFljl8dj9vjNTPKYu3jD67sWZUCxAjVpxkoTLGO
         5OLHDqFILSq9SFL+d+GKiHnrY5EPLRTMtBqXCbqsgWuq8rfKMyvOv8nT/dPjLkGpOCcI
         r6H/qN4mEirZ9svv1oGVzNoigcxV+d0Rpp3JMMHgp91pAk3hxdiVQXxJKH1sQTrbhOh8
         eC+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=etKK0PJEb1db058qQhJXVFpsTlugAG+cnL16z01cY8o=;
        b=U19wZ9Kf3xzIuHxNcqXlfQp/O87L4/umWWn0Zrgsc1G0YeRUXAOvoIR2RWYCm3YxpX
         EQnKOazzjSlWHJrrH7ccXzH9yuqZCcR0k4s/1w8Ot9Arr1+Rw+i7IQDJS8/a+fkHPOIx
         qn+tb04zivvpzbOYq1IrMdMFiErt6+gEq0JOS5H/Ihk+ukSGqjfeYm2nhBYz4BjDmkWm
         Q5PKmvY6OpsPst67iUWd7MCNBwU5VpH4M/hdZzTB1dxJaSxyNhgqzOwTLBXRbbTv4Y7Y
         lu3+jHb5+vvkqohUCtEput1EWxWcyuNpw8BTGlrNB8ADelc7stTJzL/XmOI2MdD+hW8E
         Kr/A==
X-Gm-Message-State: AOAM533RejlWdq6FU1adF1muF4EZN66Tso5The3xM+QAyib81NrogcyK
        OaArfYjSp2LLk6U7sUgq9fsF1qrbEyjxygFDX/I=
X-Google-Smtp-Source: ABdhPJzU3Ajj2pba/mzBGU5dNaLOgn81OQ4fAU3tcndyhMjQMzroJo9umsi3ROWn5K8zXlvxsi3BebvILKJoabwKp6s=
X-Received: by 2002:a2e:9187:: with SMTP id f7mr8114683ljg.450.1592000820240;
 Fri, 12 Jun 2020 15:27:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200612201603.680852-1-andriin@fb.com> <20200612220506.nad3zmcg7j75hnsz@distanz.ch>
In-Reply-To: <20200612220506.nad3zmcg7j75hnsz@distanz.ch>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 12 Jun 2020 15:26:48 -0700
Message-ID: <CAADnVQKiyCaqPAO0yCuiFJOmvrxexxkaXJNCQEwxpsHjcm6j8g@mail.gmail.com>
Subject: Re: [PATCH bpf] tools/bpftool: fix skeleton codegen
To:     Tobias Klauser <tklauser@distanz.ch>
Cc:     Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jun 12, 2020 at 3:05 PM Tobias Klauser <tklauser@distanz.ch> wrote:
>
> On 2020-06-12 at 22:16:03 +0200, Andrii Nakryiko <andriin@fb.com> wrote:
> > Remove unnecessary check at the end of codegen() routine which makes codegen()
> > to always fail and exit bpftool with error code. Positive value of variable
> > n is not an indicator of a failure.
> >
> > Cc: Tobias Klauser <tklauser@distanz.ch>
> > Fixes: 2c4779eff837 ("tools, bpftool: Exit on error in function codegen")
> > Signed-off-by: Andrii Nakryiko <andriin@fb.com>
>
> Reviewed-by: Tobias Klauser <tklauser@distanz.ch>
>
> Sorry about this, thanks for fixing it.

Applied. Thanks
