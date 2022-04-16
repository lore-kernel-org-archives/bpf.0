Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8EAFC433EF
	for <bpf@archiver.kernel.org>; Sat, 16 Apr 2022 02:08:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiDPCKP (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 15 Apr 2022 22:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiDPCJL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Apr 2022 22:09:11 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D850C606F6
        for <bpf@vger.kernel.org>; Fri, 15 Apr 2022 19:06:39 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id a10so7475795qvm.8
        for <bpf@vger.kernel.org>; Fri, 15 Apr 2022 19:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2aZT5zhZbSY/+EJMti4wIaGahOw4Saj1zZaSQ83TiLY=;
        b=TLzukGIBKc4DPM3h0EHYMlG3b6TJyF72PvxuYy8MlfKCGm/ZA8wse2o5AcsvGTaIhq
         Ocie9QpiLm8AlDvFmGpslI2c7CEyRtoh6P5570UVYOTTbTIkXQubMNMhq30pQhQTJLbK
         etBk42/Y/t52ZX/6S+i2ulNsGR4zzwXB7EwMifvTRt/hwHK13cI+QD64K3OxBTrkMu3e
         G9jD+LT9rixt/6lXG1eq/lFtZtEiZmCLVLYXRok/zEfTnXCOd9+gUevPRof4Sesz+HiF
         vYDSB1zfsK+VHh3mGF3u3ASWTYPPRVdBWQnq+GYuM8DsaEUPy3TcDIAFIUS2nSj9yux6
         ORNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2aZT5zhZbSY/+EJMti4wIaGahOw4Saj1zZaSQ83TiLY=;
        b=dp5TwMnxVEAP/oX1/95EBM0OpjOKgqOcTkhUaCWDTmMFB7a4gFhi2cfvzrHPOFfIpx
         sp/AkFTaA+m1wNdnx9Ty7QWBqeTKKRNTHbB61AbqWugPyDuIIx3znqau2/yvHT2nzhuT
         yhflpTN245+0cT97Q5nJLeGEeX5t0tCNmdx4Xz87ZyIbAIru/qZALeg2ZEdpzds+ZcHk
         UNhgYJ0ryZSBOLU0eWAj3agoSax9Elnay7GU3M/0iexcL0oKIPgqvwneYUABwiTDvo2y
         enO+RZQvF6cydyXdxhzRr2HHtm4tcLQO0k5KcqTOA2zkwi9aDSE+NzySQkC6sXBlrImu
         bsrQ==
X-Gm-Message-State: AOAM531x4tzrDN3cu5QMw56Bupmg2jPg9j+omx1K5RnukjYzpBSrr1yx
        5bUokjHevznZ6rbryRAN86ouOArVjgvuzbq9sTiy54N+
X-Google-Smtp-Source: ABdhPJyV8EKL9lc4gruqNBHsoU34wRrMfjSsfcL0D/wJKhq/Y7h90lAXZ+5ltwUcDasy3qlK3Peqavny0/JmX7yG4R8=
X-Received: by 2002:a17:902:7209:b0:158:c67b:3915 with SMTP id
 ba9-20020a170902720900b00158c67b3915mr1516832plb.67.1650070260378; Fri, 15
 Apr 2022 17:51:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220414223704.341028-1-alobakin@pm.me>
In-Reply-To: <20220414223704.341028-1-alobakin@pm.me>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sat, 16 Apr 2022 00:50:49 +0000
Message-ID: <CAADnVQ+rGR9vaDD1GM3mPgTkece711KZ+ME1MPWN8KYohydZyQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 00/11] bpf: random unpopular userspace fixes (32
 bit et al.)
To:     Alexander Lobakin <alobakin@pm.me>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 14, 2022 at 3:44 PM Alexander Lobakin <alobakin@pm.me> wrote:

Please do not send encrypted patches.
Use plain text.

Also for bpf fixes please use [PATCH bpf] subject.
cc maintainers and bpf@vger only.
There is no need to spam such a huge list of people.
