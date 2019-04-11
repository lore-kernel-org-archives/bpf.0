Return-Path: <SRS0=sRBR=SN=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB62CC10F11
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 02:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 822322083E
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 02:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="wJEOab7a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfDKCjZ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 10 Apr 2019 22:39:25 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40080 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbfDKCjZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Apr 2019 22:39:25 -0400
Received: by mail-qt1-f194.google.com with SMTP id x12so5412559qts.7
        for <bpf@vger.kernel.org>; Wed, 10 Apr 2019 19:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=5hdeHeIhbo74N79DSVByhE5qThmCJ2T3OY0155197ng=;
        b=wJEOab7a2PvUlK+f/yaaBTwbNe9NYxzawqioN4GILXtrUJ61Pu5PwuYUS2+Ujo/0lE
         iZjMrZutXkFCDhH+szaZkb6vFppjPhALk8zcPWpxPVVXC+8BRD5F4RjmSE/QW0ZKI5IQ
         wOTAFgDrAEp1nCol1D6O34FcPW/Kxdj9l7/ULCQgNw2WNUagmUWE225bjtRQTi4wkMyq
         SmGeF4Gbuyo99b+/eRG6Su+vKAhZhqU36tsVsqLbxUvw2cmf3zgw+Izb0Wdjf7zS8OJ9
         hr/46i7+mDsfqq/BHEgsT4Qayczakk0vlNPK6Aw1UVzTAINv44Q1QAkpEysvBDEH8Z5/
         StYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=5hdeHeIhbo74N79DSVByhE5qThmCJ2T3OY0155197ng=;
        b=iRNxvWvRjGYh/aOvfXBAdECK2gCcszLashgtFrC6i1AybH2uHag58q50C8QPQE2bf/
         pJJzRGgotbdoGKAZSBLKa8OdwTJPONsI+7uYuPqlQP3BLMe9eZLPlBvs5omkGk+yfWxk
         eqLuqrIPDD9hEU1Qh12NCUrSUtvTKo/+C//Egsczed6dnkOuw/rOGfxCHVIesGgmoH72
         tMNcBFfSJuB9ku+sMkcA8jOr3cA71V1HzXhFygPPFAjIT7F41ESZtS3UXeFHn2BV/WM9
         aeuh98VzKnhGcNJvnLvucbcMYmyzbIsy+eR+dF2aMmajh5RC9vAGjl2qRqIEuIfMsAkl
         WcvA==
X-Gm-Message-State: APjAAAVfXcSNIR7O4uS7dGf48JK3rQAzzTWRbKmnx7NdbFNSG+0ZX82A
        /AWJSMS9+Gm89vrhRNXkL01/mQ==
X-Google-Smtp-Source: APXvYqxMphd0uaH9LWBBwMIpRV3mbxlijf+rkIgfIrT62Bs3uleXJRI/0l4blm0wGAxgjGlspoAOaA==
X-Received: by 2002:ac8:35ea:: with SMTP id l39mr40617224qtb.151.1554950364569;
        Wed, 10 Apr 2019 19:39:24 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id o64sm18329126qkd.12.2019.04.10.19.39.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Apr 2019 19:39:24 -0700 (PDT)
Date:   Wed, 10 Apr 2019 19:39:19 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Jiong Wang <jiong.wang@netronome.com>
Cc:     alexei.starovoitov@gmail.com, daniel@iogearbox.net,
        bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com
Subject: Re: [oss-drivers] [PATCH/RFC v2 bpf-next 02/19] bpf: refactor
 propagate_liveness to eliminate code redundance
Message-ID: <20190410193919.4373744e@cakuba.netronome.com>
In-Reply-To: <1554925833-7333-3-git-send-email-jiong.wang@netronome.com>
References: <1554925833-7333-1-git-send-email-jiong.wang@netronome.com>
        <1554925833-7333-3-git-send-email-jiong.wang@netronome.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 10 Apr 2019 20:50:16 +0100, Jiong Wang wrote:
> Access to reg states were not factored out, the consequence is long code
> for dereferencing them which made the indentation not good for reading.
> 
> This patch factor out these code so the core code in the loop could be
> easier to follow.
> 
> Signed-off-by: Jiong Wang <jiong.wang@netronome.com>

Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
