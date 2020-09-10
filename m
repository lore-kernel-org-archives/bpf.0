Return-Path: <SRS0=E2Hj=CT=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6949C433E2
	for <bpf@archiver.kernel.org>; Thu, 10 Sep 2020 10:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4F07206BE
	for <bpf@archiver.kernel.org>; Thu, 10 Sep 2020 10:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent-com.20150623.gappssmtp.com header.i=@isovalent-com.20150623.gappssmtp.com header.b="povkCprx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730873AbgIJK2i (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 10 Sep 2020 06:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730984AbgIJK1E (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Sep 2020 06:27:04 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF51C061756
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2020 03:27:03 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id t10so6125357wrv.1
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2020 03:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WO5vaAWz6zN0FZiYh2WcgshVBm9JSmYHIvf75JDkwkc=;
        b=povkCprx1nxa7PduohZnkEFMgX5YQaqAYI9H6/+Pt3k/kEzF5HderxhGIa2vT/fsgw
         ZyOfJFgzKCFTYNVEbgg7CU5fHRat+n+r+Na952Iv6HUywTMntGb8E15OupOt1VrCJ5/E
         e1Lgw/HzB7INnm7UE2nGFRh3hY8Ci4Xv6/WZD/g+Ul3FR7RWV1++AS/hFXiGYwLJLHRd
         QhznOVYPDFqMRSRM1k64elgCIG92IyakCsqpd2m5BfmLMvGwOSVy/W+Pn0JOPsORGYWx
         afDN+vKw1Wkddg++vblEb3MhXLp5s60H1Go8N1fqqmHGt8nRFlsxm/LMyqkY97BSawc5
         AsUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WO5vaAWz6zN0FZiYh2WcgshVBm9JSmYHIvf75JDkwkc=;
        b=djC8xBhDbiZGAMidNeld0YIdRIF+o3q5hVwAUmj8Mt6/F/Y/Dy0Vw9xl8DKSFjf2Ww
         o8Bljpc4O8BCSPOdX65EpywHD72ruL5GbYP63BtGdID8eHnfYRM/VYjFDkAVhAlpHd3u
         iccUR1G8FQkqYCK6o4zzrQApsmVdrkPEXNFqdxzoFc6NoKxmD5GSnW/sVJfVRNAZYMNc
         zQS8KA85T4oLm3skdHxR9wMWvir4AhSlXgTsLVIBqqeXhbwOx8CZNCNNKtPDTSlpKVJU
         D6wOi1Jsvw09bzc+yBWjitHUK5tDMksx56YQLGddAYoQL/z1CEgx7BlX17q9pGx2XUB7
         U7eA==
X-Gm-Message-State: AOAM530DPX4+Vicf2TxZYiIVlrFz5e4PIL1P255RgKGPwtnMdqij3rpA
        lCGi1kM0ksUVqODUYvq2FgWaUg==
X-Google-Smtp-Source: ABdhPJw9kVA0zePHLa3oFTsXrh+4IQhuYDnz3JWs3wTwEUBmjCOCKYftMlpOsnmtsgMtWz+z+omBMg==
X-Received: by 2002:adf:f7ca:: with SMTP id a10mr8165621wrq.321.1599733622416;
        Thu, 10 Sep 2020 03:27:02 -0700 (PDT)
Received: from localhost.localdomain ([194.35.119.178])
        by smtp.gmail.com with ESMTPSA id h186sm3039494wmf.24.2020.09.10.03.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 03:27:01 -0700 (PDT)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next v3 0/2] tools: bpftool: support creating outer maps
Date:   Thu, 10 Sep 2020 11:26:49 +0100
Message-Id: <20200910102652.10509-1-quentin@isovalent.com>
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

The first two patches also clean up the function related to dumping map
elements.

v3:
- Add a check on errno being ENOENT before skipping outer map entry in
  dumps.

v2:
- v1 was wrongly expected to allow bpftool to dump the content of outer
  maps (already supported). v2 skipped that patch, and instead replaced it
  with a clean-up for the dump_map_elem() function.

Quentin Monnet (3):
  tools: bpftool: clean up function to dump map entry
  tools: bpftool: keep errors for map-of-map dumps if distinct from
    ENOENT
  tools: bpftool: add "inner_map" to "bpftool map create" outer maps

 .../bpf/bpftool/Documentation/bpftool-map.rst |  10 +-
 tools/bpf/bpftool/bash-completion/bpftool     |  22 ++-
 tools/bpf/bpftool/map.c                       | 149 ++++++++++--------
 3 files changed, 114 insertions(+), 67 deletions(-)

-- 
2.25.1

