Return-Path: <SRS0=W3SG=S2=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17FF2C10F11
	for <bpf@archiver.kernel.org>; Wed, 24 Apr 2019 19:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2E35205ED
	for <bpf@archiver.kernel.org>; Wed, 24 Apr 2019 19:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V3LaD6Fp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbfDXTU6 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 24 Apr 2019 15:20:58 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:33173 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfDXTU6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Apr 2019 15:20:58 -0400
Received: by mail-it1-f194.google.com with SMTP id v8so190490itf.0;
        Wed, 24 Apr 2019 12:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=t01MNPH95iV3/L8GHsBWy/k0LUv8mKFUQRfsNP+cyFg=;
        b=V3LaD6Fp/XxZ3tH0EuSGVcWbfjfkEdVaWir6WCmv1miBItuttNSMCgvzIhrzV65l2n
         aXFgi/oe8ZIpea585w65AcqnXf+ObKcGaYAh6qJ0fNWxiYcbl9smPZJs/e/ydtaB8CET
         x9yT+Zq6AKxMMyBcq7bNdZnk+/M6yKfllXv2IzsHU9NC00w/tEA84uylFht1+8q9VpfM
         Lw1mAHGsvkKhQv9iNsVe6VbVuCUCTH3pdcX2s5jGZcJV6kroAq5M7H5poY7QTVRh7Y6P
         v9IMjhQKnRJPFPI1d7g4efIVZn7AuGrqrhW7WP1a0PtU6brJyymu3HljB7GQCh9MzBSx
         ItVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=t01MNPH95iV3/L8GHsBWy/k0LUv8mKFUQRfsNP+cyFg=;
        b=SBTzy9BT7VmKbtsbib3i6zmg4TkW5phHBZ2jNmMehvn2vNdxFuUPzVyDRNtNQHpZF8
         7+JSCoggN21BJ9anXM1iTzxqr+7xBhByBmFTXsux/q/aeZNhWDG+DbxLjjIifa0/iuLO
         /vX3E7sjuFerTV94kw9qG2/ceOMRWhWMS+rBv1tNOxzSSt2WZYTfoH2yqBHcfY6sHcZd
         tw58wY/wzO3n/7OsylKDO57uGaDQxijti3G9+ai2hwDVNa19fo4s719S9YDQzi2uCLUU
         8/D+hH3vhJ58QJpECYMhf2qrPGMjArjVpN5euknfFr6sv5mR9SgK6iHinNrc8OPREPvL
         ZpdQ==
X-Gm-Message-State: APjAAAWJnx0sVns9dFaTB83eF7+kYusNIOSZU8mfqKzWNGuJwmocJ0dy
        L9ncIQ71IGEtg9KYLUbeyW6NWURO/nw=
X-Google-Smtp-Source: APXvYqzuarsuwedbwjdN348QI3851/LP3Psx+CDv5HoLZ3Ober9jFOVVdHjhInIeOHddn9OuJINOsQ==
X-Received: by 2002:a24:43c8:: with SMTP id s191mr526771itb.109.1556133657569;
        Wed, 24 Apr 2019 12:20:57 -0700 (PDT)
Received: from [127.0.1.1] ([184.63.162.180])
        by smtp.gmail.com with ESMTPSA id o17sm6526944ioa.31.2019.04.24.12.20.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 12:20:56 -0700 (PDT)
Subject: [bpf PATCH 0/3] sockmap/ktls fixes
From:   John Fastabend <john.fastabend@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        john.fastabend@gmail.com
Date:   Wed, 24 Apr 2019 12:20:47 -0700
Message-ID: <155613361373.20131.9399480750962676899.stgit@john-XPS-13-9360>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Series of fixes for sockmap and ktls, see patches for descriptions.

---

John Fastabend (3):
      bpf: tls, implement unhash to avoid transition out of ESTABLISHED
      bpf: sockmap remove duplicate queue free
      bpf: sockmap fix msg->sg.size account on ingress skb


 include/net/tls.h  |   14 ++++++++++++-
 net/core/skmsg.c   |    1 +
 net/ipv4/tcp_bpf.c |    2 --
 net/tls/tls_main.c |   57 ++++++++++++++++++++++++++++++++++++++--------------
 net/tls/tls_sw.c   |   13 ++++++++----
 5 files changed, 65 insertions(+), 22 deletions(-)

--
Signature
