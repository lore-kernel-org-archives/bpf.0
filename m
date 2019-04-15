Return-Path: <SRS0=RZwz=SR=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B40F8C10F0E
	for <bpf@archiver.kernel.org>; Mon, 15 Apr 2019 23:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83C2C206B6
	for <bpf@archiver.kernel.org>; Mon, 15 Apr 2019 23:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="BDr2ewpC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbfDOXEE (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 15 Apr 2019 19:04:04 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36020 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbfDOXEE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Apr 2019 19:04:04 -0400
Received: by mail-qt1-f194.google.com with SMTP id s15so21263603qtn.3
        for <bpf@vger.kernel.org>; Mon, 15 Apr 2019 16:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=PrjLsNDor/DBfIia2lzzGDg8ulnJV4mlMLs7jVYTK2M=;
        b=BDr2ewpCLV0fgcyphTwhfEnTxTM41bnJWwhJyB7HJ/EVN1q9PrVzGFrLll1oB46QHh
         lL3m5CQI+vNPJYKQZ82IvN1lX56c5inzjRI2f4jEAt23EhEpiejRfiOYyWNFDKevgJbO
         In6sKWZQK6uQTyIRHfFKwrgUaeMEQDPv6Y6T2aU/4Qw9ReZmpjuBSLCs81gVCSJx6tNY
         pNLhVIre9D5djMDBTz8wdoE4qcgp1spAVj+YiE0rGeAMe5tQlVmyayPLvo1dVpg3/nFN
         x8MeJE6JUpd8Xa2FsgvGzi/JS6Ppn3OEQzkY7VKy6UFOlYzkO5ciEaLPPkrXvUalNnuI
         EfoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=PrjLsNDor/DBfIia2lzzGDg8ulnJV4mlMLs7jVYTK2M=;
        b=PmVJ1dwCqFIvsA0nhcgQYSRXU9oS/P9GBZsKveDHlN7Ptd9L/D+1IgKCuFQJBzvL3T
         nrIgZREhfuMSmpUytAZ/3fku5QYckVi3+JUKUZZivQEIC151o+2doKhojs9GwL4Cz0Rz
         P4TGFCyGVRLMhsodLTPUP3Miy5q5f8aY1zx5b+0f4R4fm4ydGa7GsAPOuAfWCj+Oj5HL
         TMkO5zeaMjmCQbP/BXLbXkJT6lk+qxKUEQ2lPffEDt/alUgdXibCX42WS5QEGTdp3WkX
         jxKHhKCUPcqt5+CXKMi4p13in0eG0HviVQr+mprUH7HyZay8UG2Gyuj79n/QLbel6T7p
         /jrA==
X-Gm-Message-State: APjAAAW9CPdqH2j2h7u0sMXQgmPJ1emOBS4KzqZ00ck7bPMTZTCd0Y7L
        HsfU7oUddcv0AnhWL/EZTVaSmw==
X-Google-Smtp-Source: APXvYqwWDCVGDf6A1sGFsx/cNTbIRShUhRePjKIhu5fnEO96Z54EtayRZRwyj6VPJel1CdMjFXUoEg==
X-Received: by 2002:a0c:d116:: with SMTP id a22mr62862044qvh.32.1555369443151;
        Mon, 15 Apr 2019 16:04:03 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id m31sm36017948qtm.46.2019.04.15.16.04.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 16:04:03 -0700 (PDT)
Date:   Mon, 15 Apr 2019 16:03:59 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Jiong Wang <jiong.wang@netronome.com>
Cc:     alexei.starovoitov@gmail.com, daniel@iogearbox.net,
        bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com
Subject: Re: [PATCH v4 bpf-next 01/15] bpf: split read liveness into
 REG_LIVE_READ64 and REG_LIVE_READ32
Message-ID: <20190415160359.4aa87fe6@cakuba.netronome.com>
In-Reply-To: <1555349185-12508-2-git-send-email-jiong.wang@netronome.com>
References: <1555349185-12508-1-git-send-email-jiong.wang@netronome.com>
        <1555349185-12508-2-git-send-email-jiong.wang@netronome.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 15 Apr 2019 18:26:11 +0100, Jiong Wang wrote:
> Register liveness infrastructure doesn't track register read width at the
> moment, while the width information will be needed for the later 32-bit
> safety analysis pass.
> 
> This patch take the first step to split read liveness into REG_LIVE_READ64
> and REG_LIVE_READ32.
> 
> Liveness propagation code are updated accordingly. They are taught to
> understand how to propagate REG_LIVE_READ64 and REG_LIVE_READ32 at the same
> propagation iteration. For example, "mark_reg_read" now propagate "flags"
> which could be multiple read bits instead of the single REG_LIVE_READ64.
> 
> A write still screen off all width of reads.
> 
> Signed-off-by: Jiong Wang <jiong.wang@netronome.com>

Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>

Thanks!
