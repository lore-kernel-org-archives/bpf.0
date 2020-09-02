Return-Path: <SRS0=GkhW=CL=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE6B2C433E6
	for <bpf@archiver.kernel.org>; Wed,  2 Sep 2020 05:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F14D206C0
	for <bpf@archiver.kernel.org>; Wed,  2 Sep 2020 05:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zkh2k9pl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgIBFoI (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 2 Sep 2020 01:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgIBFoH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Sep 2020 01:44:07 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E3BC061244;
        Tue,  1 Sep 2020 22:44:06 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id ls14so1809338pjb.3;
        Tue, 01 Sep 2020 22:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=yPq3a99xM1mUD3ttcWcCjeAtZSKF7PhgIOKZGDWekoo=;
        b=Zkh2k9plTeNhr/oslvacVjSGx3aozvVPhm3BKBKmoZlWVTM2bigW93D/S9fS/H7ZKv
         yFP4Yt4G36FTOHRTNoZ3wkTGdY6WM1Kywqytb63hmEolK2HmUjp5yeYsK8UYzLAA0Ujo
         vpeXbSekbvAOvB9L33y2ZGywSXZhx9SxIvoRFNwJ03ZVgbPvtHdVWNMGWvtycQhbwxpY
         +RcpkzGF/ZsuxqiAUJCvuhEemgWLaIU6WHpXpXt3bnaiETi4sf80QpfcQQRnjvTC06V8
         W2lTuDB2nSpfNYQvB0ncgrxT1tabpji47DB0yPjECPkfIAyuInPhUUgFBqUoUcCb6mjk
         nC9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=yPq3a99xM1mUD3ttcWcCjeAtZSKF7PhgIOKZGDWekoo=;
        b=JWf/1ReSGYoXZlU5cvAvZB+eGKFvJkOMHeGfc8Nh65MW2hTaeFP5JIPtB1qaRhsq5y
         Z4zOO8//D/7YG32tJDiI0rVr7aekjyGAulrbxiiOnpecX96kBq18/gYOBW4WlU6eM1OK
         jK32t+nPvCNvMC3izurGls5i/auasaLfyOke7F4OHKxtq/EuhynodyNTkoEXIPuhf+Xu
         0derjx+vxZ2N4qAQRbQlbDSTYvOWqHgrrNZLcPZCyAMh9M97ywFjmGkqEahAh8J0IFqQ
         Xyh445GrIA78NDvyyFQS1bkqbOUBcaWxu9fEWeyaY8Ix9y/UofXY7hUYqJIXlbcoLtxV
         SRcQ==
X-Gm-Message-State: AOAM5304U2BmEM83IVqMYSn223ihxzcNB5LhIAvwAv1MD1PFVoFMnZ9r
        VDf1kgR0wg+TrlAM9lvxhU4=
X-Google-Smtp-Source: ABdhPJxpTp+1HTl5BNvE0YLyN8MnYJCYxPePU57m9MWlUPsJn94ttcvMwEvBo2jbj1/FhwTcVWs1cw==
X-Received: by 2002:a17:90a:414d:: with SMTP id m13mr745521pjg.163.1599025445397;
        Tue, 01 Sep 2020 22:44:05 -0700 (PDT)
Received: from localhost ([184.63.162.180])
        by smtp.gmail.com with ESMTPSA id 68sm4080426pfd.64.2020.09.01.22.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 22:44:04 -0700 (PDT)
Date:   Tue, 01 Sep 2020 22:43:57 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Andrii Nakryiko <andriin@fb.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, ast@fb.com, daniel@iogearbox.net
Cc:     andrii.nakryiko@gmail.com, kernel-team@fb.com,
        Andrii Nakryiko <andriin@fb.com>
Message-ID: <5f4f311d37ba8_5f3982088@john-XPS-13-9370.notmuch>
In-Reply-To: <20200901015003.2871861-2-andriin@fb.com>
References: <20200901015003.2871861-1-andriin@fb.com>
 <20200901015003.2871861-2-andriin@fb.com>
Subject: RE: [PATCH v2 bpf-next 01/14] libbpf: ensure ELF symbols table is
 found before further ELF processing
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko wrote:
> libbpf ELF parsing logic might need symbols available before ELF parsing is
> completed, so we need to make sure that symbols table section is found in
> a separate pass before all the subsequent sections are processed.
> 
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>
> ---

LGTM

Acked-by: John Fastabend <john.fastabend@gmail.com>
