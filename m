Return-Path: <SRS0=xBUo=3E=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D53FC33CB6
	for <bpf@archiver.kernel.org>; Wed, 15 Jan 2020 18:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 495BA2465A
	for <bpf@archiver.kernel.org>; Wed, 15 Jan 2020 18:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u6yLAPqV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729299AbgAOSne (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 15 Jan 2020 13:43:34 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:40624 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729169AbgAOSnc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Jan 2020 13:43:32 -0500
Received: by mail-pf1-f201.google.com with SMTP id d127so11420565pfa.7
        for <bpf@vger.kernel.org>; Wed, 15 Jan 2020 10:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bTzv6GNpgfrRZmeHOV0jVc+oFdZ9HuTWtPYHIUcg/W4=;
        b=u6yLAPqVa3ro09ZQhcPDbZBH6GA5ByMOsoiAYioTquy1hYzT8AeaEuB4kL/6IqUBPx
         0AqW1RIVD5mdOKoW9TemSg0AcKRhjLT3fUbCuIyhuy1yWsB7VlhrjwJkPRNshtCrszdb
         F/1Pk3RRjKtgGFtVaKh/hwIV28EmWUB8esDtd+10tZGMRs2tIXL1Eh8Dl72vyVMDfkgn
         Vl1LasdRigJ4pIrOOmCVj6GfgOZDFO2RQX1Gqxv2zrTraGVkFdNO+Iv+F+YDswQTy/dz
         MtqEXUYbt2z18+QEjMLnKygiEOVfMNunMnm29fORAte0NRZSBRmHgylNnqlh76NQSB7G
         GH9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bTzv6GNpgfrRZmeHOV0jVc+oFdZ9HuTWtPYHIUcg/W4=;
        b=gjDLiaLft6mA1iEc/NKLRQiM0RJ4vZJTKMYCbtu3Ag82zkCV7NUnSgNUdecLF9xvAv
         UkhOWC77FchPjbZk8edlItC3FhPARvyqNQ4cpNn92FBtqMs/I4oTmiRc/XL/6Evfc7PQ
         JZLsdM6dq3DCZzkHu55/yIH1dZRbhzcFfXSMEWEOP/qMm2G467IeQMpQDB7K5mCeWa5A
         u4cdnFEPNeicGvfQdbvikiiEZgFIA2cfdG19QMr7zkFFyAc8FQExrs4DChUUO2rqBKcV
         KTJ6ZT7e7FHhBVNJcsi1HFBwbZGtOG/WbudV73iFTbQlI9AQldFbKynd2tLf5q7dOtOk
         qRtQ==
X-Gm-Message-State: APjAAAVTYwibjex/ojtc/aVGxcl7dhWihHyeLKt0iF1MQVbwfkHpf8CF
        6Iit7tNmwJql/gJ+vKeJsqggT5/oOwtR
X-Google-Smtp-Source: APXvYqxTfe7jLbFuDD+gZt1hs9KW/RLDoX7XAgEuKsCqDnYZQRqqvUy6B5pjHryPABA00K3D9D/UlRd4jAFC
X-Received: by 2002:a65:578e:: with SMTP id b14mr34722927pgr.444.1579113811637;
 Wed, 15 Jan 2020 10:43:31 -0800 (PST)
Date:   Wed, 15 Jan 2020 10:43:03 -0800
In-Reply-To: <20200115184308.162644-1-brianvv@google.com>
Message-Id: <20200115184308.162644-5-brianvv@google.com>
Mime-Version: 1.0
References: <20200115184308.162644-1-brianvv@google.com>
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
Subject: [PATCH v5 bpf-next 4/9] bpf: add lookup and update batch ops to arraymap
From:   Brian Vazquez <brianvv@google.com>
To:     Brian Vazquez <brianvv.kernel@gmail.com>,
        Brian Vazquez <brianvv@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Stanislav Fomichev <sdf@google.com>,
        Petar Penkov <ppenkov@google.com>,
        Willem de Bruijn <willemb@google.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This adds the generic batch ops functionality to bpf arraymap, note that
since deletion is not a valid operation for arraymap, only batch and
lookup are added.

Signed-off-by: Brian Vazquez <brianvv@google.com>
Acked-by: Yonghong Song <yhs@fb.com>
---
 kernel/bpf/arraymap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index f0d19bbb9211e..95d77770353c9 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -503,6 +503,8 @@ const struct bpf_map_ops array_map_ops = {
 	.map_mmap = array_map_mmap,
 	.map_seq_show_elem = array_map_seq_show_elem,
 	.map_check_btf = array_map_check_btf,
+	.map_lookup_batch = generic_map_lookup_batch,
+	.map_update_batch = generic_map_update_batch,
 };
 
 const struct bpf_map_ops percpu_array_map_ops = {
-- 
2.25.0.rc1.283.g88dfdc4193-goog

