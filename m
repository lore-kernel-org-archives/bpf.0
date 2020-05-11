Return-Path: <SRS0=G4Pv=6Z=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23571C47255
	for <bpf@archiver.kernel.org>; Mon, 11 May 2020 16:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDBFE206DB
	for <bpf@archiver.kernel.org>; Mon, 11 May 2020 16:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent-com.20150623.gappssmtp.com header.i=@isovalent-com.20150623.gappssmtp.com header.b="mD5wda8x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730625AbgEKQPn (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 11 May 2020 12:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730614AbgEKQPm (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 11 May 2020 12:15:42 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7281C061A0C
        for <bpf@vger.kernel.org>; Mon, 11 May 2020 09:15:40 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id s8so11710181wrt.9
        for <bpf@vger.kernel.org>; Mon, 11 May 2020 09:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+1je8cjMVakSqZUMNmTAHqiph43cjQQrFs4Ld4TAOnA=;
        b=mD5wda8xpZFM0F1DkF3zV8uOQ5IbAoH4Ud8ykoLiutN86Q58DDWl3W0zedmiAimg1w
         kmhO0MdV9CJbkLzOHdSWYwmjkuSfMn2eBSOwvJrOHOvqq92Gx/UT3hb81Z9sSXiwsQpn
         OQvI9d07VfucEIDPx6DNNn6CaqZ695LSQICFBfa3CcKUEhzeyllgK35z7w6/fYbwqbQo
         O0rawjHIKZIG2HNo/zd1QF/Sz30FaPo5N7x90wkotuAeJ8o+djA1ban+JPscSzMq1n6l
         umsUVEXuT7iywhihtlWB67nkomLLLNpZ1M00nPxlId8g/9waWcaiSyuBx2g3RlkK89xZ
         ix8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+1je8cjMVakSqZUMNmTAHqiph43cjQQrFs4Ld4TAOnA=;
        b=M+5H2WXh2BOqJfD1V/s6dKFg6hUFPnVhVjHPQsqW/gBP8atz8Hz96kUNV1fKl5GoY6
         7DKxOZt8bOfR4Fj9I+/7od2xJpnkH/jbxM9rI5f0k5xT0RVtdK80euBJTpczjihhTof6
         86DoKJWxunM1o9XDfLrqpGSne8wyNgcZj2LI9pcRuojONfBbDZb9DDcAIJHaHVUtpS4F
         NmbkSWGUHS3dS9DrVA1XGQ1LQni5smxcFV05LlrnrkNpEMjmzEU80bmh0ow6c5yF5OA0
         ftEYBIgKgy3A1y5hxmidiO3c8uc4hWiMuA6ibCKMsHcA8P75VNopgunLDDw4EN4hwJdp
         1EFw==
X-Gm-Message-State: AGi0Puavhr9ZWVSZCdzWFdtLTMyIlAPFK5hiov6jIuyH0kWQ1/sP9GwM
        8LRrbUJm83h2zoVBkfl4u3Dy4g==
X-Google-Smtp-Source: APiQypLYj9CqVMj8z8FrtskLHc4FAIsFUSbR8GDIYFbr3K8NQeJ0ziy8i3G19mlhK9ow0s0r2zstYg==
X-Received: by 2002:a05:6000:1106:: with SMTP id z6mr13121983wrw.336.1589213739642;
        Mon, 11 May 2020 09:15:39 -0700 (PDT)
Received: from localhost.localdomain ([194.53.185.84])
        by smtp.gmail.com with ESMTPSA id v131sm54734wmb.27.2020.05.11.09.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 09:15:39 -0700 (PDT)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next v2 0/4] bpf: clean up bpftool, bpftool doc, bpf-helpers doc
Date:   Mon, 11 May 2020 17:15:32 +0100
Message-Id: <20200511161536.29853-1-quentin@isovalent.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This set focuses on cleaning-up the documentation for bpftool and BPF
helpers.

The first patch is actually a clean-up for bpftool itself: it replaces
kernel integer types by the ones that should be used in user space, and
poisons kernel types to avoid reintroducing them by mistake in the future.

Then come the documentation fixes: bpftool, and BPF helpers, with the usual
sync up for the BPF header under tools/. Please refer to individual commit
logs for details.

Quentin Monnet (4):
  tools: bpftool: poison and replace kernel integer typedefs
  tools: bpftool: minor fixes for documentation
  bpf: minor fixes to BPF helpers documentation
  tools: bpf: synchronise BPF UAPI header with tools

 include/uapi/linux/bpf.h                      | 109 ++++++++++--------
 scripts/bpf_helpers_doc.py                    |   6 +
 .../bpf/bpftool/Documentation/bpftool-btf.rst |  11 +-
 .../bpftool/Documentation/bpftool-cgroup.rst  |  12 +-
 .../bpftool/Documentation/bpftool-feature.rst |  12 +-
 .../bpf/bpftool/Documentation/bpftool-gen.rst |  21 ++--
 .../bpftool/Documentation/bpftool-iter.rst    |  12 +-
 .../bpftool/Documentation/bpftool-link.rst    |   9 +-
 .../bpf/bpftool/Documentation/bpftool-map.rst |  37 +++---
 .../bpf/bpftool/Documentation/bpftool-net.rst |  12 +-
 .../bpftool/Documentation/bpftool-perf.rst    |  12 +-
 .../bpftool/Documentation/bpftool-prog.rst    |  23 ++--
 .../Documentation/bpftool-struct_ops.rst      |  11 +-
 tools/bpf/bpftool/Documentation/bpftool.rst   |  11 +-
 tools/bpf/bpftool/btf_dumper.c                |   4 +-
 tools/bpf/bpftool/cfg.c                       |   4 +-
 tools/bpf/bpftool/main.h                      |   3 +
 tools/bpf/bpftool/map.c                       |   3 +-
 tools/bpf/bpftool/map_perf_ring.c             |   2 +-
 tools/bpf/bpftool/prog.c                      |   2 +-
 tools/include/uapi/linux/bpf.h                | 109 ++++++++++--------
 21 files changed, 249 insertions(+), 176 deletions(-)

-- 
2.20.1

