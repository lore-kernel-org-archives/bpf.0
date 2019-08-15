Return-Path: <SRS0=AlFI=WL=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C435C3A589
	for <bpf@archiver.kernel.org>; Thu, 15 Aug 2019 15:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 027A8208C2
	for <bpf@archiver.kernel.org>; Thu, 15 Aug 2019 15:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="1kcjpTKS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733287AbfHOPAd (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 15 Aug 2019 11:00:33 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38388 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733212AbfHOPAc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Aug 2019 11:00:32 -0400
Received: by mail-wm1-f66.google.com with SMTP id m125so1509031wmm.3
        for <bpf@vger.kernel.org>; Thu, 15 Aug 2019 08:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=pqXHMCyiEVNf4+xvhljjx2JY9Jv+OJDBLPu20spwLGA=;
        b=1kcjpTKStSECAIBsrWF+5LT0hscOwObqwkPAR2kowkFsLCSIX1f2ErtxCFWq0bHTuK
         QjIAIFg6SkhEua2LQ2f6kXAaYrdiPd91BK7xm7fHwicf68lWKGWnFCdGx/0CzsPx2ai8
         0JmxRcIOMPKuYEt5l8WNu8JJvaD6vM6MHrPAZmf6183bKiB7FqLs6yNgFjEtRKmpvIcw
         i1GKkv4mzNliF5EbrBr4mvldG1DiTFMaAp7TJispce4tStdSMFQ5ubVfp3sdHYyTm987
         aScCT4D/v9rmnQLlRsdun46BZwaoiQqR+Y6Q9VRVrdAIMhY2NivI7xOZKiItImQvziPO
         couQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pqXHMCyiEVNf4+xvhljjx2JY9Jv+OJDBLPu20spwLGA=;
        b=NUcdSiF0HfHcjzERKU38Uie2hUykiLXJkDPGX1O1RFMnBxuEnmJmmjmeItQEXaHsvA
         aJDa/BpSq1AN/zBMFiCAAWiBW3afNYHG3Gahx7sUBd6RI9if38m30m/yFxxNOniypzvm
         grGzINNmdjuPRtK1G9jKnjTRjFeA7OzstmACCOdQFDWx9JnompTJCR1/j39weoUwPytY
         KrlC4ye0EoLxo04C7nuZvvbkWGvMmA/VBuR0mPqvsBNIFyphK7OMLQdXZMkgFBRQrvdm
         twVPVRiP2FNopuIbVO7v2c012MgaSAaXSv2gYapDD5FthCo013Gl+pe+QQP0sDmpY796
         ZESA==
X-Gm-Message-State: APjAAAUFQW4P1gEsARsyJfvBVeIP7z3H7jpWrHJDccqNim4WbySmC7yV
        12TY4dVDXC3H6bigI+1Qefd8IgW1TyCsyA==
X-Google-Smtp-Source: APXvYqz+FeTxTbAuP+6QOY6U0MoFC4m7iqzFifuD+/6HjdCzyAgU00+QAxuQ8cvlSxtzEKykByCV3Q==
X-Received: by 2002:a1c:c1c1:: with SMTP id r184mr3178341wmf.9.1565881230406;
        Thu, 15 Aug 2019 08:00:30 -0700 (PDT)
Received: from cbtest32.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id a23sm2794857wma.24.2019.08.15.08.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 08:00:29 -0700 (PDT)
From:   Quentin Monnet <quentin.monnet@netronome.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com,
        Quentin Monnet <quentin.monnet@netronome.com>
Subject: [PATCH bpf-next 0/5] bpf: list BTF objects loaded on system
Date:   Thu, 15 Aug 2019 16:00:14 +0100
Message-Id: <20190815150019.8523-1-quentin.monnet@netronome.com>
X-Mailer: git-send-email 2.17.1
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,
This set adds a new command BPF_BTF_GET_NEXT_ID to the bpf() system call,
adds the relevant API function in libbpf, and uses it in bpftool to list
all BTF objects loaded on the system (and to dump the ids of maps and
programs associated with them, if any).

The main motivation of listing BTF objects is introspection and debugging
purposes. By getting BPF program and map information, it should already be
possible to list all BTF objects associated to at least one map or one
program. But there may be unattached BTF objects, held by a file descriptor
from a user space process only, and we may want to list them too.

As a side note, it also turned useful for examining the BTF objects
attached to offloaded programs, which would not show in program information
because the BTF id is not copied when retrieving such info. A fix is in
progress on that side.

Quentin Monnet (5):
  bpf: add new BPF_BTF_GET_NEXT_ID syscall command
  tools: bpf: synchronise BPF UAPI header with tools
  libbpf: refactor bpf_*_get_next_id() functions
  libbpf: add bpf_btf_get_next_id() to cycle through BTF objects
  tools: bpftool: implement "bpftool btf show|list"

 include/linux/bpf.h                           |   3 +
 include/uapi/linux/bpf.h                      |   1 +
 kernel/bpf/btf.c                              |   4 +-
 kernel/bpf/syscall.c                          |   4 +
 .../bpf/bpftool/Documentation/bpftool-btf.rst |   7 +
 tools/bpf/bpftool/bash-completion/bpftool     |  20 +-
 tools/bpf/bpftool/btf.c                       | 342 +++++++++++++++++-
 tools/include/uapi/linux/bpf.h                |   1 +
 tools/lib/bpf/Makefile                        |   2 +-
 tools/lib/bpf/bpf.c                           |  24 +-
 tools/lib/bpf/bpf.h                           |   1 +
 tools/lib/bpf/libbpf.map                      |   5 +
 12 files changed, 393 insertions(+), 21 deletions(-)

-- 
2.17.1

