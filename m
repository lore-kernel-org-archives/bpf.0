Return-Path: <SRS0=TYu4=YZ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A6CCA9ECF
	for <bpf@archiver.kernel.org>; Fri,  1 Nov 2019 03:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF5ED208E3
	for <bpf@archiver.kernel.org>; Fri,  1 Nov 2019 03:07:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="gk6PoWf6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbfKADHN (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 31 Oct 2019 23:07:13 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38121 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbfKADHN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 31 Oct 2019 23:07:13 -0400
Received: by mail-lj1-f195.google.com with SMTP id y23so8391059ljc.5
        for <bpf@vger.kernel.org>; Thu, 31 Oct 2019 20:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9YjtUu+ZjBUpJQENL1NViWSeyjL7FzrnZoX2E0Dq1O0=;
        b=gk6PoWf6ZXUa6579VGeypvSp4C/K6mNANQBb4tcmQkX6dvtZSZ34TzwohmOP6ZKOTc
         yI2zVzM1p6A5omsx/w3LB/K8p7bHFBaIBapdzxh8ZQjSmhgZDdm9nQRNZ7s+LnrLKj7y
         K6VDH3NV+FnkRVRTTfXfj6JQMJykdHCALOx7GmhgLth14vV+BxmHHzdFvoCzKveVQoHF
         a1Y2P2JG3diLgCGQvJ7YAVDeEne5EwFbeA+hWYxq7yv4O0u8mtJCPAFzl2tvshSWc5xq
         LmV+glrUysJXth9xi+SuUpU5t2IDftsgo30B0GzaeEor4M72n5U0jdq0y37gjyDG2Npn
         dMwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9YjtUu+ZjBUpJQENL1NViWSeyjL7FzrnZoX2E0Dq1O0=;
        b=l8c5V68uw6rVbQkYgvW7u5EuhZzuijP3UqCjL9lXt/Yvz6yP6YhscoiV2JGkeqeLO5
         oVntWNDXSnmbrQkoD3Aoxf84VK0maq/H5JqD8/ChByh32EwxOZaFZxacR0ldvmiJvhho
         1bTGcobjVVWi21Nkox0WMQTBroT6kPbetLJtoH1hLtNEdr0wfXXT4iNtHis+V6/W+4uc
         PtWmng/XUUltPTvUoY0EHcctIXiKzc1M5OjWqAos+Jo+bEgiNN79A5n8Z0b2yfdOX0V7
         cmlPmTT4ZmzhfHFbchabhKFxrebyyDAhKbTqV5r977lV1GEd5PEz5OKm05LWr5uDMvRU
         JN+Q==
X-Gm-Message-State: APjAAAX2n1IsZZuHO04ioK32foq14BBWIaxUpM8i3O2mNPAeN72z1bmS
        ubw5toKXb8V8Vi43FNZxByE4EQ==
X-Google-Smtp-Source: APXvYqxBgStPWBSoVB7roZSG+OwDwgB8iap4XvkdoTiqNOC9zDQxJ8xPS2ZnA0FZbY47bi/cZihz+w==
X-Received: by 2002:a2e:8694:: with SMTP id l20mr6374058lji.64.1572577630658;
        Thu, 31 Oct 2019 20:07:10 -0700 (PDT)
Received: from jkicinski-Precision-T1700.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id v6sm3926282ljd.15.2019.10.31.20.07.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Oct 2019 20:07:09 -0700 (PDT)
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     davem@davemloft.net
Cc:     alexei.starovoitov@gmail.com, daniel@iogearbox.net,
        bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com,
        Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: [PATCH net 0/3] fix BPF offload related bugs
Date:   Thu, 31 Oct 2019 20:06:57 -0700
Message-Id: <20191101030700.13080-1-jakub.kicinski@netronome.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi!

test_offload.py catches some recently added bugs.

First of a bug in test_offload.py itself after recent changes
to netdevsim is fixed.

Second patch fixes a bug in cls_bpf, and last one addresses
a problem with the recently added XDP installation optimization.

Jakub Kicinski (3):
  selftests: bpf: Skip write only files in debugfs
  net: cls_bpf: fix NULL deref on offload filter removal
  net: fix installing orphaned programs

 net/core/dev.c                              | 3 ++-
 net/sched/cls_bpf.c                         | 8 ++++++--
 tools/testing/selftests/bpf/test_offload.py | 5 +++++
 3 files changed, 13 insertions(+), 3 deletions(-)

-- 
2.23.0

