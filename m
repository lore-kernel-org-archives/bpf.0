Return-Path: <SRS0=J20p=SM=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F39C10F0E
	for <bpf@archiver.kernel.org>; Wed, 10 Apr 2019 02:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 513E4206B7
	for <bpf@archiver.kernel.org>; Wed, 10 Apr 2019 02:39:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="qk4XpOUr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbfDJCjQ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 9 Apr 2019 22:39:16 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45077 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfDJCjQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Apr 2019 22:39:16 -0400
Received: by mail-pf1-f193.google.com with SMTP id e24so443721pfi.12
        for <bpf@vger.kernel.org>; Tue, 09 Apr 2019 19:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kpCEf/Qq7tuBHkUCvzw9RDQhyuv+fkTrLJtMvQIPB04=;
        b=qk4XpOUrgdAyWaYDdG7h6tprWKEK6itk0//ZrqrqyoY7gjC+0AgDmpzNeW9N+4twsb
         PNeU7GmxnWKBUWcpK5Mu+MjTzeTgI5HNruxyPimpPtni+YYo2Mq946tsXYAwXnA4VM6c
         e6zR94qu1RzUUSsce4TQFBR9pXfg8IKhMptrM9q+VckxVJUdM08X79lwWhG4IesgnSVD
         y6/P0JoZSfEshzh8XDsNtF9tx8p/I+yW9F69pylWW6XVhov23qd57f092E3ucoyy+OZK
         VCxOdzbydInBLhlKaLwOXFsXKA2xWTm6IDHhrT0g2UFPICef5AweOOV66Vc9+Upgofiy
         gKfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kpCEf/Qq7tuBHkUCvzw9RDQhyuv+fkTrLJtMvQIPB04=;
        b=Yw4/nVRsyQiIy0FZap8KSojVXlqJCrRVKJMs9GA9xz2540iPqr2YOaNIo/tk6RpzLO
         XmbeLFmd0GZkQK80S7P+ogfkbLRfSoswlv93IUk4s1cENAEhIHipCafnb4fa4kuU7Dm4
         yx/iAFFw1Zej99FGpbuXIZ592HKPggPTCo8hp0H6FicSJCaz6sNA1CfQehQoJmdwULPM
         dJZFvTSNplWcDU3nwJWE2CJexg6/PlRpnV9RlHGbeiqYfgha5sL/a8mhQgQ23dBFD2Ab
         gBuJhIly9wySU7ZX1/TtJiLqwQB3JtXBlPoV7kI6LZMS/Jhb1BGOx5xZqVvJHC/VhxGY
         L/lg==
X-Gm-Message-State: APjAAAXSM+7UMQqJm6C5+uUNXx75mvNPgDitR0AfpJbmYPg0tsv7hNbu
        zQ4Y0OleYgHgs+UeVQyQ+8ZbXA==
X-Google-Smtp-Source: APXvYqw16sMRHvFYQ3DY42TI6+ZNAJ0fTb/DDxMV7h7al7Ra/c7r7BCU13HsEinvDxl29+Bqk/5WLQ==
X-Received: by 2002:a63:6988:: with SMTP id e130mr22004349pgc.150.1554863955782;
        Tue, 09 Apr 2019 19:39:15 -0700 (PDT)
Received: from shemminger-XPS-13-9360 (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id c1sm40310406pgk.44.2019.04.09.19.39.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Apr 2019 19:39:15 -0700 (PDT)
Date:   Tue, 9 Apr 2019 19:39:11 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Huang Rui <huangruippp@gmail.com>
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com, kafai@fb.com, songliubraving@fb.com,
        yhs@fb.com, jiri@mellanox.com, ecree@solarflare.com,
        idosch@mellanox.com, petrm@mellanox.com,
        alexander.h.duyck@intel.com, amritha.nambiar@intel.com,
        lirongqing@baidu.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, xdp-newbies@vger.kernel.org,
        bpf@vger.kernel.org, roopa@cumulusnetworks.com,
        nikolay@cumulusnetworks.com, bridge@lists.linux-foundation.org
Subject: Re: [PATCH] net:bridge:always disable auto-tuning when the user
 specified MTU
Message-ID: <20190409193911.2d68a64d@shemminger-XPS-13-9360>
In-Reply-To: <20190410023208.25435-1-huangruiPPP@gmail.com>
References: <20190410023208.25435-1-huangruiPPP@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 10 Apr 2019 02:32:08 +0000
Huang Rui <huangruippp@gmail.com> wrote:

> For example.
> My purpose is to create a bridge br0 and join eth0 into br0.
> if we use this following way, the auto-tuning flag will not be disabled.
> 
> If eth0's mtu is 1200
> step 1.brctl addbr br0
> step 2.brctl addif br0 eth0
> step 3.ifconfig br0 mtu 1200
> step 4.ifconfig eth0 mtu 1500
> 
> Result:
> br0's MTU: 1500, eth0's MTU: 1500
> 
> Expected:
> br0's MTU: 1200, eth0's MTU: 1500
> 
> I have specified br0's MTU,  but auto-min policy works. So the MTU is
> not the result what we expected.
> As expected, if i have specified bridge's MTU, it will set the flag:
> BROPT_MTU_SET_BY_USER in net_bridge_opts disabled and auto-min/max
> policy will not work.But in this case, because the dev_set_mtu return
> early, the BROPT_MTU_SET_BY_USER flag will not be disabled and
> auto-min/max policy will still work.
> 
> Signed-off-by: Huang Rui <huangruiPPP@gmail.com>

A bridge like this going to drop frames.
A frame received with MTU of 1200 will get dropped.
The proper way to do this is to change MTU of both interfaces to match.

