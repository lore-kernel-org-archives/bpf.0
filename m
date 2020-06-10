Return-Path: <SRS0=M8wK=7X=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D31C433DF
	for <bpf@archiver.kernel.org>; Wed, 10 Jun 2020 18:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD83320656
	for <bpf@archiver.kernel.org>; Wed, 10 Jun 2020 18:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="snp8Zh03"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729305AbgFJSuT (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 10 Jun 2020 14:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729248AbgFJSuT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Jun 2020 14:50:19 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0164DC03E96B
        for <bpf@vger.kernel.org>; Wed, 10 Jun 2020 11:50:18 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id 205so3133442qkg.3
        for <bpf@vger.kernel.org>; Wed, 10 Jun 2020 11:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eRvVqDo/sW+IkzOCwkljRr9QBmI4ScXSfu7DDF6Hl3g=;
        b=snp8Zh03HmmlZU6Q2WZqq/OaC2Bq82WVV1ZGBI1iDWtBy3NaPHEEyDhofGcSkfQF8a
         PmtCCrI0Iijjf+gsWkjB4zlXpQOd3vGw2h9CsCKb5hkh4NnrkDq/S5NLH5/H7RMrsCS2
         be5ehJ8DIHqjpkD9TJrJYonSBB2cT6TvbyASB+y2o1xsPWIKhORExyGMwifgCud5ayrn
         daXOcXlhu8SevMz1Su/qjKVx0c63JxRLUtuKklrLMZ41lNPU02X4//bNefq84rDeRrcI
         46te2oq4gmDL/t1zbGMWcsdZXdLYEiztKD3Em2a4UsinTU0dH8G88bsJwKE3A5thrzWt
         Kemw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eRvVqDo/sW+IkzOCwkljRr9QBmI4ScXSfu7DDF6Hl3g=;
        b=P22KL3FGegP8Fctp59MhzdjpybkPPQTcgxVHU4i04Qg7eKl05LPKkyssbHFy617NcK
         d3TEBJyByp2ao9xl5iPXttn0xEaMAUyVnP6rMFPgqkRPZ5qOeMo8+7ACrugKSi4Xn9Ee
         0UVErJPvYK6a2rYYLKmT7a2+gCMuWrDbnSgJdYmBJTDUU9cPbkHStWR+UII34wtpThh5
         f7+YI2dR3fQ7xz5st2p8pK5E/0OndoBJgZcE+PQNuvL8V2VDMa8pNzlLmKviiQsWq7+f
         WDXXKWWkhYCisVTyzwHax9viTWEzGCi1YUCP4NYd1e435iAen3S883Jj7dWGB2AlYFGF
         U36g==
X-Gm-Message-State: AOAM532/S3uiZ7wtU2+T/AulfPtgh4wRb2pX3+ZzU2kncqepNrc474uG
        K+vjj5MIrmOgju88eIaKQcleLpTCm32K0t3EE6E=
X-Google-Smtp-Source: ABdhPJzIjWDlsx5xiNwII5EdA4R63Cv6pDU1th93za72AY7zVaeQwSop7BQQMNsHqaFuHRF1OTsi8nv9rpedoSM0u7c=
X-Received: by 2002:a05:620a:12d2:: with SMTP id e18mr4749205qkl.437.1591815017192;
 Wed, 10 Jun 2020 11:50:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200610130807.21497-1-tklauser@distanz.ch>
In-Reply-To: <20200610130807.21497-1-tklauser@distanz.ch>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 10 Jun 2020 11:50:06 -0700
Message-ID: <CAEf4Bzbiz6qST5Ws4pKB4qZdqfwG_12UgFeQk96da1qipAJS9Q@mail.gmail.com>
Subject: Re: [PATCH bpf] tools, bpftool: check return value of function codegen
To:     Tobias Klauser <tklauser@distanz.ch>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jun 10, 2020 at 6:09 AM Tobias Klauser <tklauser@distanz.ch> wrote:
>
> The codegen function might fail an return an error. Check its return
> value in all call sites and handle it properly.
>
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> ---

codegen() can fail only if the system ran out of memory or the static
template is malformed. Both are highly unlikely. I wonder if the
better approach would be to just exit(1) on such an unlikely error
inside codegen() and make the function itself void-returning.

We'll probably expand codegen to other languages soon, so not having
to do those annoying error checks everywhere is a good thing.

What do you think?

[...]
