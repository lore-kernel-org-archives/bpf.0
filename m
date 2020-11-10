Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C04A4C388F7
	for <bpf@archiver.kernel.org>; Tue, 10 Nov 2020 16:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6444220825
	for <bpf@archiver.kernel.org>; Tue, 10 Nov 2020 16:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m53OD465"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbgKJQno (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 10 Nov 2020 11:43:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730021AbgKJQno (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Nov 2020 11:43:44 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C036AC0613D1
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2020 08:43:42 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id l1so8989784wrb.9
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2020 08:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ypNg3iKjOccFBBHav4Bu16eF9gSk7+pwcjbdq2OsRdE=;
        b=m53OD4658ptkQtBs3J4tgWCzD2wagamUwOA/1iIqgdUk9u0o7rEn5hgPx0jwmsPlKE
         QCvrj/XKhDLBHDFhwN7JZ7O1t28PeqpxafWdtFc0NcmcNKNtuB4htMQHVKq1+SOXgGxl
         BkDbs/KhKNKQMGc6p/3ARrRYOMJ4idESrCaVfMwXt5PTJ9kdlqsmHB07/yyV7Ujbso7H
         hTJ+dWfEk7QwwV3tRJD+df57EDwtXsP0RO5irwRsKAcoqhCen5kuU4tLv3ObGvVQDVkW
         dj+2AYon4yfq+Z7bfsBZvw7Q3hFvD8UkywqFs4wAn0L5Yq1rGaZONeb4CuJ0+4u42hUb
         B//g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ypNg3iKjOccFBBHav4Bu16eF9gSk7+pwcjbdq2OsRdE=;
        b=MCJcx5bDyVBUBx2I+mCYCntuaRkIZSG/3XfcJwe8TOhkUPAuMuDp+G4UqaoboIZLra
         0cRrHK8Nu/TmjV30pQqSfgLWZR4GaEH4ZhCyBRZ9rnM3ykkSsQeKi3CviCZ7+CqJZbEo
         PeJ7I28TIytsfpi4ktg+bvPBbARI5WfwrPO7XN1EJRU7iRXUUwcmbwFyS1HsGjsciz92
         J2Zi1hWb2cMNwvtCUSlpjJ8WjsMKSrrgBUB4LZYtWMXvrp+B40U7SzoGKke0/U3rPwjC
         Zzp+5bIUa2DQK5LGRRlG7hDNks/EI8a9dX4ztq5QspxsxPDzEkPZmNbHbqCYeflklqfx
         vcFQ==
X-Gm-Message-State: AOAM532CTG554S9Ojx5hvu5Or+eXeamIBlSLIVigbCZP1Kci2aR/vB1S
        grIih6z39/FANkYAkTR0ZMntKQ==
X-Google-Smtp-Source: ABdhPJwhfgyj9vDMGXDAET8UWTaWe+tEdRINDbPuLQR55H6bQEQx5b08pohGnJWrYsuL+dxLDog8UQ==
X-Received: by 2002:adf:ef48:: with SMTP id c8mr25380037wrp.399.1605026621339;
        Tue, 10 Nov 2020 08:43:41 -0800 (PST)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id n123sm3272268wmn.38.2020.11.10.08.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 08:43:40 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, kafai@fb.com, songliubraving@fb.com,
        yhs@fb.com, andriin@fb.com, john.fastabend@gmail.com,
        kpsingh@chromium.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH bpf-next v3 0/7] tools/bpftool: Some build fixes
Date:   Tue, 10 Nov 2020 17:43:04 +0100
Message-Id: <20201110164310.2600671-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.29.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

A few fixes for cross and out-of-tree build of bpftool and runqslower.
These changes allow to build for different target architectures, using
the same source tree.

Since [v2], I addressed Andrii's comments on patches 3 and 5, and added
patch 7 which fixes a build slowdown.

[v2] https://lore.kernel.org/bpf/20201109110929.1223538-1-jean-philippe@linaro.org/

Jean-Philippe Brucker (7):
  tools: Factor HOSTCC, HOSTLD, HOSTAR definitions
  tools/bpftool: Force clean of out-of-tree build
  tools/bpftool: Fix cross-build
  tools/runqslower: Use Makefile.include
  tools/runqslower: Enable out-of-tree build
  tools/runqslower: Build bpftool using HOSTCC
  tools/bpftool: Fix build slowdown

 tools/bpf/bpftool/Makefile        | 44 ++++++++++++++++++-------
 tools/bpf/resolve_btfids/Makefile |  9 -----
 tools/bpf/runqslower/Makefile     | 55 +++++++++++++++----------------
 tools/build/Makefile              |  4 ---
 tools/objtool/Makefile            |  9 -----
 tools/perf/Makefile.perf          |  4 ---
 tools/power/acpi/Makefile.config  |  1 -
 tools/scripts/Makefile.include    | 10 ++++++
 8 files changed, 70 insertions(+), 66 deletions(-)

-- 
2.29.1

