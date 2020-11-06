Return-Path: <SRS0=kVCt=EM=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E42C55178
	for <bpf@archiver.kernel.org>; Fri,  6 Nov 2020 10:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5430A2087E
	for <bpf@archiver.kernel.org>; Fri,  6 Nov 2020 10:38:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j/C2zcYC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgKFKiX (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 6 Nov 2020 05:38:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbgKFKhx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 Nov 2020 05:37:53 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54980C0613D4
        for <bpf@vger.kernel.org>; Fri,  6 Nov 2020 02:37:53 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id s13so859407wmh.4
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2020 02:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GQFn82EPSsaqSkZSdg3eEn7h3cPHKXwNy46wDlBGgtk=;
        b=j/C2zcYC4D+GfLAzIhkvRR6L8uPmphnnzDvPzLQqul0mdudVnCKPs+1Iw/lcztSu/u
         ehSnM1Y1dlPRi1V3+rCJtl6a4bRayalim8Q84El78bG5UPxlGowvU8s+KsEaDy+B9CYY
         WTNlI+86Rcs/FiRdn3tS4dmaepXXPMG4doBlo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GQFn82EPSsaqSkZSdg3eEn7h3cPHKXwNy46wDlBGgtk=;
        b=NQiyz6yui60Es8XeO4bSf60xZ+N17f20SBEPpeTmToX9U4oxo4EWqE2bUuerQG53vd
         alshi+qGa6t/F11SBIM4YKtAbqqV/heHztEsQ6vRm9N4a7IFZrxBRVEPanpbJxXSVr/G
         wQnVTkiPW/QrWCNHgdLWKYhqAKZ3Y4wTOVaaEBSMWyrNmvH5zGKwJNZEen3FL5Q3eLIJ
         5sJ3AByB3Qu24cGt7/OaMRGL/HpmXgpDMBAWH/37cda1CldFZkR0WxRoeCF3GQEZqB/C
         sY2Yu/rKsw2Hdp9/v9JgQ1ucYu22S1oOZJWEjQvmWF4MVfHE8MzjCtluRIaVg6UMJFjb
         O5nQ==
X-Gm-Message-State: AOAM531vVgZ3TwDpnbBHn5MefItz4J0WhCPrSUbuq/e1H9mL0NAKJsHh
        LPfSbp3dlilk5BnZ6TwwkJbSBA==
X-Google-Smtp-Source: ABdhPJxqxJxJ05Nq1CUl1iDZ+iYqb1g80guta6CJa2B4QY+4vCFDZ4/oMFjb34vtf7/N8tL0/rreQQ==
X-Received: by 2002:a1c:2108:: with SMTP id h8mr1716760wmh.63.1604659072052;
        Fri, 06 Nov 2020 02:37:52 -0800 (PST)
Received: from kpsingh.c.googlers.com.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id t1sm1537639wrs.48.2020.11.06.02.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 02:37:51 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Martin KaFai Lau <kafai@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>, Hao Luo <haoluo@google.com>
Subject: [PATCH bpf-next v6 3/9] libbpf: Add support for task local storage
Date:   Fri,  6 Nov 2020 10:37:41 +0000
Message-Id: <20201106103747.2780972-4-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201106103747.2780972-1-kpsingh@chromium.org>
References: <20201106103747.2780972-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

Updates the bpf_probe_map_type API to also support
BPF_MAP_TYPE_TASK_STORAGE similar to other local storage maps.

Acked-by: Martin KaFai Lau <kafai@fb.com>
Signed-off-by: KP Singh <kpsingh@google.com>
---
 tools/lib/bpf/libbpf_probes.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index 5482a9b7ae2d..ecaae2927ab8 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -230,6 +230,7 @@ bool bpf_probe_map_type(enum bpf_map_type map_type, __u32 ifindex)
 		break;
 	case BPF_MAP_TYPE_SK_STORAGE:
 	case BPF_MAP_TYPE_INODE_STORAGE:
+	case BPF_MAP_TYPE_TASK_STORAGE:
 		btf_key_type_id = 1;
 		btf_value_type_id = 3;
 		value_size = 8;
-- 
2.29.1.341.ge80a0c044ae-goog

