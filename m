Return-Path: <SRS0=hlnV=YQ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AAB6CA9EB6
	for <bpf@archiver.kernel.org>; Wed, 23 Oct 2019 15:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D0112064A
	for <bpf@archiver.kernel.org>; Wed, 23 Oct 2019 15:41:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="irN2kiQL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404319AbfJWPlA (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 23 Oct 2019 11:41:00 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34790 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404266AbfJWPk7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Oct 2019 11:40:59 -0400
Received: by mail-wr1-f68.google.com with SMTP id t16so17499240wrr.1
        for <bpf@vger.kernel.org>; Wed, 23 Oct 2019 08:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=veaWPcqNKkHO2xesR9++rJ5BEwtFW1XMdldljCUmrk8=;
        b=irN2kiQLBDfDnCbkJkg5TiJ0d5LvrWcrQ5jUW84CdQAxBOp1dChVo9su8AS5uRSXFp
         ryQ+1X1PYcX+WoSysGNEbEJPpc0fpgfTWJoUNywUDNIbqA8mH3ODHwEWSeyCJhLouOeE
         DVHVp69j/ByZgGGQgC+qzhbsjg2qiHrZ2bFtw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=veaWPcqNKkHO2xesR9++rJ5BEwtFW1XMdldljCUmrk8=;
        b=Q73cXH+0uj/wItG7L0lJDXxL6tJor8Qg39rx9ggZq7aK9PUafs/Sb+L7jrDXfeOHpP
         oBO3UAv7qarYxmt/gTigXgN7qUOeVsqfXMooDRPOC8i3YHrWHaofzmqv/OkEQdsp7m3C
         T81rKCQOL/BCPdS1RhXlzM5MZv2hk26bl/7M5KILYO1XjCgGh+ENilC+Ux0evKV/IiJr
         r1DIsmnGOsC2OQN30RgyO0AHsJYpLmrR/fK++NTscEXFYLkWyzwexFv8VIcy4IdX+LUC
         uGt/hER932I7Y3mYEBRlkc3HRfKkxsSU8C82yQw5UOBtHOPpMVaWtKnCFToN+oSSeq8C
         XXNg==
X-Gm-Message-State: APjAAAU2wEcugrrdg9NH0PdnSyTEkSZoItshSz/6XN2oZwb5GZeP3UeG
        7WKzlN3PHeWCdvJVKnn+O5KFPw==
X-Google-Smtp-Source: APXvYqwikxw4MBCiG3jMJl/r6iNmK2oFCpBVjH1jp5K/GYEMf1X3ljOFTScw2qqjSvtT/PV9J5kUBg==
X-Received: by 2002:adf:dc44:: with SMTP id m4mr7923796wrj.203.1571845257764;
        Wed, 23 Oct 2019 08:40:57 -0700 (PDT)
Received: from kpsingh-kernel.localdomain (90.226.197.178.dynamic.wless.zhbmb00p-cgnat.res.cust.swisscom.ch. [178.197.226.90])
        by smtp.gmail.com with ESMTPSA id a186sm21123622wmd.3.2019.10.23.08.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 08:40:57 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next v2] libbpf: Fix strncat bounds error in libbpf_prog_type_by_name
Date:   Wed, 23 Oct 2019 17:40:38 +0200
Message-Id: <20191023154038.24075-1-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

On compiling samples with this change, one gets an error:

 error: ‘strncat’ specified bound 118 equals destination size
  [-Werror=stringop-truncation]

    strncat(dst, name + section_names[i].len,
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     sizeof(raw_tp_btf_name) - (dst - raw_tp_btf_name));
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

strncat requires the destination to have enough space for the
terminating null byte.

Fixes: f75a697e09137 ("libbpf: Auto-detect btf_id of BTF-based raw_tracepoint")
Signed-off-by: KP Singh <kpsingh@google.com>
---
 tools/lib/bpf/libbpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 290684b504b7..dc7d493a7d3d 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -4693,7 +4693,7 @@ int libbpf_prog_type_by_name(const char *name, enum bpf_prog_type *prog_type,
 			}
 			/* prepend "btf_trace_" prefix per kernel convention */
 			strncat(dst, name + section_names[i].len,
-				sizeof(raw_tp_btf_name) - (dst - raw_tp_btf_name));
+				sizeof(raw_tp_btf_name) - sizeof("btf_trace_"));
 			ret = btf__find_by_name(btf, raw_tp_btf_name);
 			btf__free(btf);
 			if (ret <= 0) {
-- 
2.20.1

