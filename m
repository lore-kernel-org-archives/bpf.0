Return-Path: <SRS0=5Irp=CQ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F92C43461
	for <bpf@archiver.kernel.org>; Mon,  7 Sep 2020 16:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62E632080A
	for <bpf@archiver.kernel.org>; Mon,  7 Sep 2020 16:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent-com.20150623.gappssmtp.com header.i=@isovalent-com.20150623.gappssmtp.com header.b="WuomelGJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730991AbgIGQmu (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 7 Sep 2020 12:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730901AbgIGQgm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Sep 2020 12:36:42 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D8FC061573
        for <bpf@vger.kernel.org>; Mon,  7 Sep 2020 09:36:41 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id o5so16373423wrn.13
        for <bpf@vger.kernel.org>; Mon, 07 Sep 2020 09:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QWC8ABqOj9tnGBywTcIQeelbRdA8/0ZzqwQDNhLengM=;
        b=WuomelGJnWurYaBUF2nmtrnHY+KjbPYEBfz8tqpfeXDstSfVNlxEc5pAGGDjiEx4p8
         rwuIr/MS02JMRmUkl4w5HgrXGYTQoeyGlD4Yw7ipAtlTsE9vyiZ42bfQYdrbaC3NR1Xx
         pAS+fsQVBsrk0OkitURXQt2DlKp0z/P19z3OcLPh24lqpXmavlp6SnLpJBRrlUIxKfcY
         eOrPdEKgrPROdEz5mcoTcmUWRV56iAWx1o62pKATZsbqYEugPH0DWnZZRAVAkoYSsyTU
         ao5vMa7Fz4B/VggMIK3+pOvcNC/bWqmYCRyJzyWsaCbBeyLVsmJIX3nM9pVLtGfFLlG/
         MVVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QWC8ABqOj9tnGBywTcIQeelbRdA8/0ZzqwQDNhLengM=;
        b=CpUjYcUu4hYf/+YXp+icxRf8DinVoHCmchpnEtxpAb1lIKjGkvuiEq8/VRtAhIS2kr
         SVQIthrFhcFhli/RuF7Bm342yWbw/Lngueg+f520EjrBg3wYJNpyQq3QRqqTjAjXBeqC
         Y+v8H+HKHag2dNTTstGiFI3Hv3/p3lbAEHEoddC4MS0qIQ/GZAd+6BPFUQyZvI1agHrK
         ByauIdh7q4zVP8h27jR3dySQs49pRHWwBcB5frtzrmP/jQAbiO3BPZWgwygLguWUKI95
         IfbWesUdsJrGTRxWr7JEIgSpoVa+dva4sAf1nwg0wuwXBS+iVb22weXLv3oQ8ssSVMG8
         s5Tg==
X-Gm-Message-State: AOAM531XRho72pg/72MPv8NStUlJ30l1dVBK10KSxBdeQjcxuxMmjTki
        unGudzNdxrR2Vbf7T7SX8RsrOw==
X-Google-Smtp-Source: ABdhPJx7ybduonsODy8DQshJzntV5ZBDwmr061Tj42v2kmVoMKExLWWqKRntYKJq9qFKJwAKVTJyGQ==
X-Received: by 2002:a5d:60cc:: with SMTP id x12mr21913343wrt.84.1599496600562;
        Mon, 07 Sep 2020 09:36:40 -0700 (PDT)
Received: from localhost.localdomain ([194.35.119.17])
        by smtp.gmail.com with ESMTPSA id p11sm26443677wma.11.2020.09.07.09.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 09:36:40 -0700 (PDT)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next v2 0/2] tools: bpftool: support creating outer maps
Date:   Mon,  7 Sep 2020 17:36:32 +0100
Message-Id: <20200907163634.27469-1-quentin@isovalent.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This series makes bpftool able to create outer maps (maps of types
array-of-maps and hash-of-maps). This is done by passing the relevant
inner_map_fd, which we do through a new command-line keyword.

A first patch also cleans up the function related to dumping map elements.

v2:
- v1 was wrongly expected to allow bpftool to dump the content of outer
  maps (already supported). v2 skipped that patch, and instead replaced it
  with a clean-up for the dump_map_elem() function.

Quentin Monnet (2):
  tools: bpftool: clean up function to dump map entry
  tools: bpftool: add "inner_map" to "bpftool map create" outer maps

 .../bpf/bpftool/Documentation/bpftool-map.rst |  10 +-
 tools/bpf/bpftool/bash-completion/bpftool     |  22 ++-
 tools/bpf/bpftool/map.c                       | 149 ++++++++++--------
 3 files changed, 114 insertions(+), 67 deletions(-)

-- 
2.25.1

