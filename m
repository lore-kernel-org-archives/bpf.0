Return-Path: <SRS0=v7MC=QX=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 087BAC10F07
	for <bpf@archiver.kernel.org>; Sat, 16 Feb 2019 20:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFF93222A1
	for <bpf@archiver.kernel.org>; Sat, 16 Feb 2019 20:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="YkkwTwvC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729599AbfBPUNa (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 16 Feb 2019 15:13:30 -0500
Received: from mail-pg1-f176.google.com ([209.85.215.176]:35803 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727270AbfBPUNa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 16 Feb 2019 15:13:30 -0500
Received: by mail-pg1-f176.google.com with SMTP id s198so6467448pgs.2
        for <bpf@vger.kernel.org>; Sat, 16 Feb 2019 12:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:organization:mime-version
         :content-transfer-encoding;
        bh=WbinMWDWHpv6jSKxrMFHWByDDIdQPx25QINy9Svwylc=;
        b=YkkwTwvCaPnbiFv0qJEfIRMVeh/C1feK6be/yJL2/UVE3jVEPSDpruHkuofjAM37jx
         jzs74NvOPYCyhBc5CsSnznXoWChcRVStZa1crkei4IFyM5R7B5yxPHtGGgPCBQzTX7OU
         ZzQiV9mOUrFCd+FraGXuTxr8WVRdzRju2oDHSpvR9Fl40aYdZ2irgreRcvL6GYG4t4By
         aETCY2vlJgiSFyPSP7h7ST1Dg6GnNKSl7upgaRE55KG/0cxBTRzD+PUoMmljUeco4uyt
         cqPltlCaYZBYlX2My9yC8q5rIaKMzCsbkHPwIW7p/0BRCbS90oonPi73Pbkc0r4iuquO
         A5bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:organization
         :mime-version:content-transfer-encoding;
        bh=WbinMWDWHpv6jSKxrMFHWByDDIdQPx25QINy9Svwylc=;
        b=W0QrUL3UEiE5e1RSja/34XmOM65nBi02z2+Gwq9JZSvYXeoTMtR2BwP91On0tQsdg9
         toL91cnjwdaot7JtMoGaofirHL+niWeonFkSX0qo5T4r2tAKoBAAKXmdJVHRT4hfdQHT
         /MHQ7wsFtJ9f8++90O0tTbKi2D4utcp2sYOJUwSOYrCxz0AJLoZH8uOS3GyYcGnt8PUc
         yMTRA2KdTX5/en5GJSIU3FHCVwX11W5a1PQPaiWNDAt3TNwRPKxhQqMHTHsYJ+Q0wusa
         5qJ1lAUu8TjqJ+Qa7T3nERw+LMfdZ+3R6ChwvAeN0FwyU4OFMx2J/t14kQVF0XbIWCOm
         ulYg==
X-Gm-Message-State: AHQUAuaQ8RfWWZ3wcGitJ/bGQcGgHwU9SGbm7e2I7/eascTN7WNk49yu
        kn93acNmLNdJVk1F+v7/AQn6GTlvVF8=
X-Google-Smtp-Source: AHgI3IYF25/h0nV6q21QC41RY+E0hZTTDG65EhGu9KDYKEJcEBTPz0W1iKapmq03uTDd2tRS6bk5vA==
X-Received: by 2002:a63:df09:: with SMTP id u9mr15186714pgg.299.1550348009325;
        Sat, 16 Feb 2019 12:13:29 -0800 (PST)
Received: from cakuba.netronome.com ([2601:646:8e00:1b7a::2])
        by smtp.gmail.com with ESMTPSA id v11sm15789952pfa.49.2019.02.16.12.13.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 16 Feb 2019 12:13:29 -0800 (PST)
Date:   Sat, 16 Feb 2019 12:13:25 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     lsf-pc@lists.linux-foundation.org, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [LSF/MM TOPIC] BPF: Scaling the verifier
Message-ID: <20190216121325.4ad7e34b@cakuba.netronome.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

I'd like to attend the LSF/MM Summit 2019, the BPF track.  I'm working
on BPF, and the initial author of bpftool and networking BPF offload.

I'd like to discuss ways of scaling the verifier to 1M instructions,
something that Alexei often mentions as a design goal :)  

I'd like to share results of verifier performance analysis, and
evaluation of a few possible optimization ideas.  Related to that - we
got rid of the last piece of shared verifier state in Oct 2017, but the
global verifier lock is still there, we should probably sketch a way
forward on that front.


If there is space at the back of the room, I'd also like to attend the
MM discussions (in HMM area, as it relates to BPF offload and sharing
BPF state with next-gen networking HW), and NVMe discussion (again, in
networking context).
