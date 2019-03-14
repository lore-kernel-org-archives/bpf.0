Return-Path: <SRS0=VVzb=RR=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46016C10F06
	for <bpf@archiver.kernel.org>; Thu, 14 Mar 2019 12:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A47B21019
	for <bpf@archiver.kernel.org>; Thu, 14 Mar 2019 12:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="Wa+4MROF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbfCNMi4 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 14 Mar 2019 08:38:56 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38284 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbfCNMi4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Mar 2019 08:38:56 -0400
Received: by mail-wm1-f66.google.com with SMTP id a188so2536948wmf.3
        for <bpf@vger.kernel.org>; Thu, 14 Mar 2019 05:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=2gJqpjeO2tFHMEfAo/H/f4j0/ZQfYG1m8XJ0ufJe6jI=;
        b=Wa+4MROFmvzM/sCdcQyqt+XuKNK9XGGZHq+wCSpOiXSPcdnNDGw66Og/aPpgWOL8Rt
         J+FBYkIeMLBLAjkl0Q/PA+VK2LPde93zgFC0EBMvxRH+/vDLqWgx7eGPHFrFYi7LuaKY
         jZekPjRD2eECyWE98WayYlUNUEJk/i3rdNnEnS6j1V/om8mvpzJjJkm5o5HBomIqcMgd
         o2tpe9kcEKF4MX2roDzRqRFmwkHy/ni2Jl/C5rZ3xiklhnJImBavZpXUNLm4r1G6liPe
         hg7dwLs6xgA9GepQaxNrcwZ4LMu1+lpNjTlptsuCVwA+pbsDGpftkOm9TiowGHWoE+NN
         mzqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2gJqpjeO2tFHMEfAo/H/f4j0/ZQfYG1m8XJ0ufJe6jI=;
        b=S4op0dIKH1ZC5jPJXVCX62BiO9B97KE0PC+rCTn0KYD/RLn0eseYVU1AZMhlRadNUB
         YdCN15W4grdvWF7yUBgc8aHXxSlZFPPKW/ByEVJLZUyjG5XMxtJYBOFQ8BPAGvHqvW/H
         uzHDB36qvnPnjd86MQPgA85rUbhXQUGx3BM0KTBjVqArOgXAdkWKP6IQJ/JDQ7vElwxP
         VFneufvg1+EN6n7JCSDUgKJa2ZgCTiQd6QOYzX6+iwAjPIEQeN2+/R6B0Eg/l32KWvPL
         ubO5y2DkaIHa3QqORB8R8YLVLySlQCDcru6WtO0xibhLSCjWBc351GD8gU/LqmEmUH/j
         RBJg==
X-Gm-Message-State: APjAAAX41mdd27JvPsNrhrNeCeCKntwe5xQlYfmDgzcITIXr+RIWuqrY
        owaP/c3F0Ngsg3rAApRIIMP0Zw==
X-Google-Smtp-Source: APXvYqyFbc5hxSCiUM35Falko0/MPP4Ky3a1y4nScbYgl3NexASgZGUW6tOKSqZsvg4ykhh9hSUQ7A==
X-Received: by 2002:a1c:c90e:: with SMTP id f14mr2305671wmb.23.1552567134133;
        Thu, 14 Mar 2019 05:38:54 -0700 (PDT)
Received: from reblochon.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id u8sm2285569wml.22.2019.03.14.05.38.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 05:38:53 -0700 (PDT)
From:   Quentin Monnet <quentin.monnet@netronome.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com,
        Quentin Monnet <quentin.monnet@netronome.com>
Subject: [PATCH bpf 0/3] fixes and additions for BPF helpers doc
Date:   Thu, 14 Mar 2019 12:38:38 +0000
Message-Id: <20190314123841.13092-1-quentin.monnet@netronome.com>
X-Mailer: git-send-email 2.14.1
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,
This set is an update to the documentation for the BPF helper functions in
the UAPI header bpf.h, used to generate the bpf-helpers(7) man page.

First patch contains fixes to the current documentation. The second patch
adds documentation for the two helpers bpf_spin_lock() and
bpf_spin_unlock(). The last patch simply reports the changes to the version
of that header in tools/.

Quentin Monnet (3):
  bpf: fix documentation for eBPF helpers
  bpf: add documentation for helpers bpf_spin_lock(), bpf_spin_unlock()
  tools: bpf: synchronise BPF UAPI header with tools

 include/uapi/linux/bpf.h       | 183 +++++++++++++++++++++++++++--------------
 tools/include/uapi/linux/bpf.h | 183 +++++++++++++++++++++++++++--------------
 2 files changed, 240 insertions(+), 126 deletions(-)

-- 
2.14.1

