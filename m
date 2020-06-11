Return-Path: <SRS0=s2Gn=7Y=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65132C433DF
	for <bpf@archiver.kernel.org>; Thu, 11 Jun 2020 18:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4667120838
	for <bpf@archiver.kernel.org>; Thu, 11 Jun 2020 18:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LvUKenyV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbgFKSCq (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 11 Jun 2020 14:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbgFKSCq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Jun 2020 14:02:46 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425B9C03E96F
        for <bpf@vger.kernel.org>; Thu, 11 Jun 2020 11:02:46 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id f18so6500678qkh.1
        for <bpf@vger.kernel.org>; Thu, 11 Jun 2020 11:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ii6TqQ51Bobpe8G3ammikyCmEQx/uy00ewub+gCjREc=;
        b=LvUKenyVcNLtWEoyq4u0NB/OQ5bXNK6Faq2+hpWqa57OF/nu0o51XP8naJMgRdMFa5
         Qkgmg5UMz6Fz9owx61N3VKyfm1emKrVEpw9IGFgDJHJc4x5iuutAis0sh8dgLeJdFvUj
         ImPAyZg7neS2/wFxD0EWGpdXClibLCKQkc2yYKyaqOWdxQJWHF6C5WixIvYl8pQs8pw5
         aIH2oOeYw22RDkNQzBQIBJre0Cx2NS+iLMz31SCSqdtNOHoZpxQnE0wXXVAvLuAsdfrE
         cjMQFDlbJqWxhitkIU9F/p83zoYVgI2w+2bUOqrBf/sYT04IgCCHtUZGsmH0Obmf4Lca
         IlSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ii6TqQ51Bobpe8G3ammikyCmEQx/uy00ewub+gCjREc=;
        b=F7q1FsWK/xC1IJ53+swEEI6VJMgRiZkXpJfhTsYdv2RjuGk7Q9NOUOaGdTxZmwrbEY
         Q1D4xkuNpsMv27SDQ0gMZ+AbCDcYO4JwUZvxLQKnEmvVr5Mn/vnSdaSRPSnLX1lgiDFr
         VLW548Tmoqql9meUkbvvlP5n30yAuRcYGCY0bf6Jz3YtzCf/P1s+FiMlhAT84HRRdlr1
         EtLLX4p/KNiOvOIxeIfCk1AOOGRRiGav2B2WsUpbF3zvU9SmNl+/W+oeIXvW2m0q3u0z
         N16rZO6nSnTiT/+IJ3PGWqhicHq5XqBJCmIzoTRCvjjnkYoaplqfUCjPwBzWkznKMz6X
         h7Bg==
X-Gm-Message-State: AOAM532I2Q9MtqQObuJ/m2hEnE/FySiwe/wSaKRH5cxB03IDZO2uqwsy
        zdZyCBcq580CxS0zCgklu3aLH8b9ES+OCusSDK9TRJxb
X-Google-Smtp-Source: ABdhPJypt7zIlNPdXV+ME1s6LUv/S1YzZyI+Qn2o0dh/UKMx1ZTJkoWjkyI/Nt9QgKx2nOuIv3MyqObIXnK9yr2dhC8=
X-Received: by 2002:a37:a89:: with SMTP id 131mr9384865qkk.92.1591898565493;
 Thu, 11 Jun 2020 11:02:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200610130807.21497-1-tklauser@distanz.ch> <20200611103341.21532-1-tklauser@distanz.ch>
In-Reply-To: <20200611103341.21532-1-tklauser@distanz.ch>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 11 Jun 2020 11:02:34 -0700
Message-ID: <CAEf4BzaHaHKSVuNt7kgFm53-byDro1ijADD+Q-i39yMfT9pT-g@mail.gmail.com>
Subject: Re: [PATCH] tools, bpftool: Exit on error in function codegen
To:     Tobias Klauser <tklauser@distanz.ch>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jun 11, 2020 at 3:33 AM Tobias Klauser <tklauser@distanz.ch> wrote:
>
> Currently, the codegen function might fail and return an error. But its
> callers continue without checking its return value. Since codegen can
> fail only in the ounlikely case of the system running out of memory or
> the static template being malformed, just exit(-1) directly from codegen
> and make it void-returning.
>
> Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> ---

LGTM. Thanks!

Acked-by: Andrii Nakryiko <andriin@fb.com>

[...]
