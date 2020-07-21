Return-Path: <SRS0=BdeU=BA=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E19C433DF
	for <bpf@archiver.kernel.org>; Tue, 21 Jul 2020 19:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4064F2072E
	for <bpf@archiver.kernel.org>; Tue, 21 Jul 2020 19:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q4ttGl1M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729171AbgGUT7E (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 21 Jul 2020 15:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728691AbgGUT7D (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Jul 2020 15:59:03 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF77C061794
        for <bpf@vger.kernel.org>; Tue, 21 Jul 2020 12:59:03 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id q6so21357ljp.4
        for <bpf@vger.kernel.org>; Tue, 21 Jul 2020 12:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tacDAKNSAP5bEbMMXmh1uJ5mpnX2O3kof3Bea1Z6xj4=;
        b=q4ttGl1M1FgyfAJlZMOM00W0HqUxKaLwtxVZrJe1vu5bZPgHwJ1st7TxKaaeX00nol
         JW5W/1giAvDbh0jPPjP3xoyO3u8C+1ItINcCLiUGaq5cVDBcx98rtKS4FuKjIdKSdA6w
         emFnhmIU2bx8Rxol9/WA3e2T7hx/Lu0J4efllmgtGVXzB00KGa6pAMXzqUFlJ/noJLxk
         3zv1zvmmyO947hJotoP2MkSSLJKYM5qKcvADe+/y/KUqZiahTmDt/OukgPrFBaCOfMcI
         MpqqoCTfmZ9EI2CtsPM9YR9JgsSywL/3k5YbzVZ21vmooBaJ5utint3oYWVuV0SjwS5Z
         G/UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tacDAKNSAP5bEbMMXmh1uJ5mpnX2O3kof3Bea1Z6xj4=;
        b=nSYKHOitKK1m1R8jVMgmIh1AysY3goorHSv/6NUb68DfNR2/zM58y03dlfVgh5Gb9p
         Icn61CHXa9HTsu3trzV37XfKqwpKDCrjWHrwpQBm1UrN5DXht+RYFTWKLx7eyhFz/bu8
         jVNSFcYO095Sw+d9aD5klc4pQdW+isLv2O/7IfmNoAaGLTMtyeygpwAPQ3KOn44waMy9
         9+Xfa6Za02wJEbI04yJOyB5mpGSS+oX1DBoUW3Wjf401cICV3joRMFBO65cjzBiXtp7r
         a9tnyP4Zg14fYv2NmCpxIHl/XVlDz6CZWqGPxLstL47Uj/bcnrD7HHcKZQ53MVrr+i0M
         wmDg==
X-Gm-Message-State: AOAM531F8VOW8WpI8H0NL046xqxv5b87yROgzWgkcW49mJDCtheRht9S
        eGsSKT0E0PthqThZ3IXA10TpJaHk9Apcb33+yB0=
X-Google-Smtp-Source: ABdhPJyqzVIicF7AutK3LNL9av6i7njg2p+cXEO01RQB43NgNNcNM5pSn9t+PSljbUU4jqOSymtMsfrmzG1F0gU/g1s=
X-Received: by 2002:a2e:9a4d:: with SMTP id k13mr14276943ljj.283.1595361541661;
 Tue, 21 Jul 2020 12:59:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200720114806.88823-1-iii@linux.ibm.com>
In-Reply-To: <20200720114806.88823-1-iii@linux.ibm.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 21 Jul 2020 12:58:50 -0700
Message-ID: <CAADnVQKp=eAcZKbf_L5mGVBNZmcFJpa4=U4i34US1dUf3ELdew@mail.gmail.com>
Subject: Re: [PATCH bpf-next] samples/bpf, selftests/bpf: use bpf_probe_read_kernel
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jul 20, 2020 at 4:48 AM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> A handful of samples and selftests fail to build on s390, because
> after commit 0ebeea8ca8a4 ("bpf: Restrict bpf_probe_read{, str}()
> only to archs where they work") bpf_probe_read is not available
> anymore.
>
> Fix by using bpf_probe_read_kernel.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

Applied. Thanks
