Return-Path: <SRS0=Y+lb=WQ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F133C3A589
	for <bpf@archiver.kernel.org>; Tue, 20 Aug 2019 09:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B74422CF5
	for <bpf@archiver.kernel.org>; Tue, 20 Aug 2019 09:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="lLusJsP/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729436AbfHTJcL (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 20 Aug 2019 05:32:11 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34753 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729341AbfHTJcK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Aug 2019 05:32:10 -0400
Received: by mail-wr1-f67.google.com with SMTP id s18so11653135wrn.1
        for <bpf@vger.kernel.org>; Tue, 20 Aug 2019 02:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oUulDxxErU+azL0tyiV8vMBrr8x0fQefqueBCWkNWVg=;
        b=lLusJsP/uhZq7gKn1G6pJLEpYyMT2ewSVGUZw/It5XaKb8l7lTulQlwagc8UvdkJ7v
         H4IzMMJfu7ZEORMQgMDO+AvNPXYPtza+Ovk283Uk2Fq3R2olwrgSWgFiO7/o/eUzLB7n
         grklnlkdUULQAMj10LgH8UslEQGNTMJetpqyegn2nIsJQKVXAyTGymgTohjTAIaeMyeW
         /5xlDKllFzGJ4BqBi5CXqZAJIZvDvjYhlp23R8RnLs7LbVrJR3lTym4dy/0rN5qNGHLQ
         /wDb8qyNMYSpcsFRp7nYlUfKckPimXON+zYAien0FsLiHeyyls8tqe3LtIx8AuqQ1aZ/
         RoVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oUulDxxErU+azL0tyiV8vMBrr8x0fQefqueBCWkNWVg=;
        b=E5lEzFIG+wqr9BGcxkVrvdTusdgcpTC1N4zT03Vb3bUMjrQmcRQ2ZbpgsPuedH6YlU
         cT5g/IHFjsjQUdlVYvv8biWf+stSrss85IzVESp4BwgvEn/ZD2RpNoQB3tf2quCrQN+s
         mBSvnw4gy3vTly8tnre1zqO+2RlKdITVa95QfocPZElFYIpzfmNEZ9j3furO6gbY5Bl0
         JQSFBJ98P5tD9QTNce+hzehjvo4quzaLrMCUMBOfrYpcPKZkGKAytwZWuof2C1rbkaZV
         p6+nth3Ep6QfapgNMcWRccCD0YkKT/L0bE39txjk+VyF5lqbNaRMGA8sTElM/btZFfdh
         OIDQ==
X-Gm-Message-State: APjAAAXECq6tykWIlhg8adb86dEQ77r1kD4UQDreQ1FyR9dW6QB+bcs3
        7rSav7fmRkjurIouXC26tGxbPg==
X-Google-Smtp-Source: APXvYqw8+jcJrECTST+tSd5IlSgPP6vyYHYwUO0U0jzqrrvWwcCO6GkDGip7FaY3kpdN+7RuimrFeQ==
X-Received: by 2002:a5d:634c:: with SMTP id b12mr31890572wrw.127.1566293528225;
        Tue, 20 Aug 2019 02:32:08 -0700 (PDT)
Received: from cbtest32.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id p9sm16128190wru.61.2019.08.20.02.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 02:32:07 -0700 (PDT)
From:   Quentin Monnet <quentin.monnet@netronome.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com,
        Quentin Monnet <quentin.monnet@netronome.com>
Subject: [PATCH bpf-next v2 2/5] tools: bpf: synchronise BPF UAPI header with tools
Date:   Tue, 20 Aug 2019 10:31:51 +0100
Message-Id: <20190820093154.14042-3-quentin.monnet@netronome.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190820093154.14042-1-quentin.monnet@netronome.com>
References: <20190820093154.14042-1-quentin.monnet@netronome.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Synchronise the bpf.h header under tools, to report the addition of the
new BPF_BTF_GET_NEXT_ID syscall command for bpf().

Signed-off-by: Quentin Monnet <quentin.monnet@netronome.com>
---
 tools/include/uapi/linux/bpf.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 0ef594ac3899..8aa6126f0b6e 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -106,6 +106,7 @@ enum bpf_cmd {
 	BPF_TASK_FD_QUERY,
 	BPF_MAP_LOOKUP_AND_DELETE_ELEM,
 	BPF_MAP_FREEZE,
+	BPF_BTF_GET_NEXT_ID,
 };
 
 enum bpf_map_type {
-- 
2.17.1

