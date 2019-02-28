Return-Path: <SRS0=vk/n=RD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CCD7C43381
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 19:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30C37218D8
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 19:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="L4yukYrJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731126AbfB1TgC (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 28 Feb 2019 14:36:02 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44860 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730852AbfB1TgC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Feb 2019 14:36:02 -0500
Received: by mail-wr1-f65.google.com with SMTP id w2so23268295wrt.11
        for <bpf@vger.kernel.org>; Thu, 28 Feb 2019 11:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=user-agent:from:to:cc:subject:date:message-id:mime-version;
        bh=wTbLc/zvzJWD1hDJHVEh34tKe2SbhX+MUbOQbxJcpSA=;
        b=L4yukYrJmqTLhz4WwwQI3Scxshi20SW9m+DEpjld+RGJMtMyRmfzR4XheD9JQOwH6p
         Hyc5erxBp24X9V91dFG7myxp0kfvbj9JYgxbTPVRRx96Tphsh1qX74x9Eq5YjgLAbuim
         XhpOPem2s4ZePJdG4HlETwG4Spe2lod/nj0pVwlW6DHFBGFA97i4yfr1bSkYQcqn7jh0
         rpZxFMujGo2isgNUjaVf3VbHoR+Y57+ULR3VsuxzoALMGkwwU60S5cOLJB3eL87VORTe
         ND7Jsk83RtGVA8FbiJb6FdcCaaMOZ8QBab1AdAwHj7vtB3GShUpg5oCpSCgBXmrOsvbo
         4F0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:user-agent:from:to:cc:subject:date:message-id
         :mime-version;
        bh=wTbLc/zvzJWD1hDJHVEh34tKe2SbhX+MUbOQbxJcpSA=;
        b=NASEWcpyqgG1bMTb3uhOjdVAYI1TONzMB52GGIWjAkXtwxabCUO6k3vsFry1FjP4gx
         srzF3IPQTgRddCjW8Fd5PRvS/QTAbx+6NTEn4NB1PUKknKfJfRPEmPLl6ilPx6vqpneo
         6IZFxUkXgHw4uq+fXDcXTZSE7NJrMaPIMyXSf02OqIDWwfvKGaIjGenfa+VuethSg7k2
         sOkw7xKgARDJutyJ5mbEFcvkqtittj9gSBgN3Y8NtXHRJUdpDTirboBR2V8SWojfC2h3
         BbfpxIEiphGgmQolQ7yoaRYA/YwQ38iOoEwxWZFtCNWN9Y9Bs7pYYmRQgBHUmppOCYIP
         hcjQ==
X-Gm-Message-State: APjAAAUAbeM6Wj/8PIiMkhLyJ0j48psb0bcv0j1mwQCobk9k+nbQwVs/
        hQ2TX98XsR/n9ygJeRuD5POlhQ==
X-Google-Smtp-Source: APXvYqxNhF9fKElHYFCls6wx2BqJDFVLocSspKfjN3T7l9cjVK6XRJe8j8El/T0PWMlLyWdewBo0pw==
X-Received: by 2002:adf:cd02:: with SMTP id w2mr738967wrm.30.1551382560963;
        Thu, 28 Feb 2019 11:36:00 -0800 (PST)
Received: from LAPTOP-V3S7NLPL (cpc1-cmbg19-2-0-cust104.5-4.cable.virginm.net. [82.27.180.105])
        by smtp.gmail.com with ESMTPSA id j8sm24741974wro.52.2019.02.28.11.36.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 11:36:00 -0800 (PST)
User-agent: mu4e 0.9.18; emacs 25.2.2
From:   Jiong Wang <jiong.wang@netronome.com>
To:     lebedev.ri@gmail.com
Cc:     yhs@fb.com, bpf@vger.kernel.org, llvm-commits@lists.llvm.org
Subject: Re: [llvm] r355124 - bpf: improve dead Defs check for XADD 
Date:   Thu, 28 Feb 2019 19:35:58 +0000
Message-ID: <87tvgnu2n5.fsf@netronome.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


Hi Roman,

The patch set was reviewed at:

https://lore.kernel.org/bpf/1551300641-1727-1-git-send-email-jiong.wang@netronome.com/T/#t

That is where BPF communicty, including the major LLVM developer centred at.

And for the testcase, it is included in the second patch inside the set.

(And my commit user id is associated with my previous company email
address, I will try to pushed from git next time so I could change the
author email address)

Regards,
Jiong
