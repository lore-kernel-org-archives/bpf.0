Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C37FC433EF
	for <bpf@archiver.kernel.org>; Mon, 11 Jul 2022 21:13:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbiGKVNX (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 11 Jul 2022 17:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiGKVNX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Jul 2022 17:13:23 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080F133A25;
        Mon, 11 Jul 2022 14:13:21 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id r6so7764872edd.7;
        Mon, 11 Jul 2022 14:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=9vJqD4dzKiefaURSHAzLn/KqkmwP/2hOLemxSE6nXqw=;
        b=bmWur8VTc2YHg662mUHDsMzevR3CeXD6HsvfX937EYWhgLFsNaoO49Sgbncjt3Pncf
         phDrEaNFFfzOxNq27QvLmHDhQ98GLvMlTsBU9K7klijeYSHL/+o+8IkV77L1y85GZqKK
         hAhoNKByCVg75T5iIU7A63/pkzQoQnuditCXdnCD+HOMBcnourCRM33yqFmlAGhnhawS
         3wbluXKXPnpikO2Of5DGfCsdqqA/Tfk7EJBZYyE0n5OFNK0UdEFFEaeNcMovUO1CUxAO
         cT35Mjg4vbLB3EVs1LzKjvPeMKhv5xP4L2KwThfPiaIsEy90nzF3xLNFzis6XdqgJtXX
         YUWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=9vJqD4dzKiefaURSHAzLn/KqkmwP/2hOLemxSE6nXqw=;
        b=Qq5xq+lxoelQd7n/ZmM8tK+V58TsjYqJ9SPIbBC0xebOgfwlsrmr1xCIIwRlMp9VaR
         7HiGMcJcxRgQd7lb0s5Wh7UoLXewY+bOuKKChRlZfkIGVJy+GkWyClYqgT+J1iIae70n
         Drr1C20JGgA96qtiiUosjlz6+ySQCvZ5QpkJCP7HNpfWvoS8yBtv3QPHRhgciTx1Vwkz
         PjYB3FQ3ygg1tdmLq/Me5YxjyBFXRA4NOwwls89Q6+axWxd5ZUUEBHFsPzVUxURKItyL
         EO2eLIRg3keZDmQSEPAL125Qtzml5A8RoWXgW/hMwtnI31HCo4mPx8CxM9qAMESdWPhT
         UFvg==
X-Gm-Message-State: AJIora8iGCP7lcJuW6BQBTklUu8GfC3Q8y/M098mn2khzn4GNoPFSpML
        SiQO2vZieTBiGcUFxJXPEwA=
X-Google-Smtp-Source: AGRyM1vpuBDVRTyo9k7hWrbxwGW/aE8q3aNoICJ24NNjG0knFtRUwDF9bsIt3LHbqbm9ninaV4JGjA==
X-Received: by 2002:a05:6402:1e8c:b0:43a:c57f:2cbb with SMTP id f12-20020a0564021e8c00b0043ac57f2cbbmr17183847edf.97.1657573999624;
        Mon, 11 Jul 2022 14:13:19 -0700 (PDT)
Received: from laptop ([77.222.6.10])
        by smtp.gmail.com with ESMTPSA id az21-20020a170907905500b0072b02f99e55sm3039939ejc.197.2022.07.11.14.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 14:13:19 -0700 (PDT)
Date:   Mon, 11 Jul 2022 23:13:17 +0200
From:   Fedor Tokarev <ftokarev@gmail.com>
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        ftokarev@gmail.com
Subject: [PATCH] bpf: btf: Fix vsnprintf return value check
Message-ID: <20220711211317.GA1143610@laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

vsnprintf returns the number of characters which would have been written if
enough space had been available, excluding the terminating null byte. Thus,
the return value of 'len_left' means that the last character has been
dropped.

Signed-off-by: Fedor Tokarev <ftokarev@gmail.com>
---
 kernel/bpf/btf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index eb12d4f705cc..a9c1c98017d4 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6519,7 +6519,7 @@ static void btf_snprintf_show(struct btf_show *show, const char *fmt,
 	if (len < 0) {
 		ssnprintf->len_left = 0;
 		ssnprintf->len = len;
-	} else if (len > ssnprintf->len_left) {
+	} else if (len >= ssnprintf->len_left) {
 		/* no space, drive on to get length we would have written */
 		ssnprintf->len_left = 0;
 		ssnprintf->len += len;
-- 
2.25.1

