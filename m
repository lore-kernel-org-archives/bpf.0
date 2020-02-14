Return-Path: <SRS0=yg+S=4C=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC25AC2BA83
	for <bpf@archiver.kernel.org>; Fri, 14 Feb 2020 16:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 911942468F
	for <bpf@archiver.kernel.org>; Fri, 14 Feb 2020 16:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581696617;
	bh=j5+g+RQG+8iUqfhHmGbPWGjRcRjG8CzYFVOGHpcaMTw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h00iV4Vnl07CD5AoTfIgSpQdOdzHxhVkrQoius4iROK9kQd+n90PMr/fUm/Cb3Hzs
	 mnRKBkbTL+FkCgYLDRia/QEZV7yiroE23hRAHaYPB1YSW8rAHUpN+/eBD4iuAP6kBf
	 yFWblmxbkNr2CS7hpwo4EZSmbWAqkM1/QD1vziP0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391082AbgBNQKQ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:10:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:35706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391433AbgBNQKQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Feb 2020 11:10:16 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B30B82467E;
        Fri, 14 Feb 2020 16:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696615;
        bh=j5+g+RQG+8iUqfhHmGbPWGjRcRjG8CzYFVOGHpcaMTw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iJ9TmJByxRIXIVSdQs2zxoEv6wd3qlkEG4X+scMuV4lEAznyuo4xUxNYqslPKh7GN
         7b2J9DIreXxVIRIGWV81AIIIELNLDHkPygzPJlTKVtvCJUrnirAjfM73B72VO40hXH
         X8yatePeub2IpF4Wi0qCKtfwkyHyzlxLkSbW2Vcg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lorenz Bauer <lmb@cloudflare.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Martin KaFai Lau <kafai@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 397/459] selftests: bpf: Reset global state between reuseport test runs
Date:   Fri, 14 Feb 2020 11:00:47 -0500
Message-Id: <20200214160149.11681-397-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214160149.11681-1-sashal@kernel.org>
References: <20200214160149.11681-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Lorenz Bauer <lmb@cloudflare.com>

[ Upstream commit 51bad0f05616c43d6d34b0a19bcc9bdab8e8fb39 ]

Currently, there is a lot of false positives if a single reuseport test
fails. This is because expected_results and the result map are not cleared.

Zero both after individual test runs, which fixes the mentioned false
positives.

Fixes: 91134d849a0e ("bpf: Test BPF_PROG_TYPE_SK_REUSEPORT")
Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
Acked-by: Martin KaFai Lau <kafai@fb.com>
Acked-by: John Fastabend <john.fastabend@gmail.com>
Link: https://lore.kernel.org/bpf/20200124112754.19664-5-lmb@cloudflare.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../selftests/bpf/test_select_reuseport.c        | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_select_reuseport.c b/tools/testing/selftests/bpf/test_select_reuseport.c
index 7566c13eb51a7..079d0f5a29091 100644
--- a/tools/testing/selftests/bpf/test_select_reuseport.c
+++ b/tools/testing/selftests/bpf/test_select_reuseport.c
@@ -30,7 +30,7 @@
 #define REUSEPORT_ARRAY_SIZE 32
 
 static int result_map, tmp_index_ovr_map, linum_map, data_check_map;
-static enum result expected_results[NR_RESULTS];
+static __u32 expected_results[NR_RESULTS];
 static int sk_fds[REUSEPORT_ARRAY_SIZE];
 static int reuseport_array, outer_map;
 static int select_by_skb_data_prog;
@@ -662,7 +662,19 @@ static void setup_per_test(int type, unsigned short family, bool inany)
 
 static void cleanup_per_test(void)
 {
-	int i, err;
+	int i, err, zero = 0;
+
+	memset(expected_results, 0, sizeof(expected_results));
+
+	for (i = 0; i < NR_RESULTS; i++) {
+		err = bpf_map_update_elem(result_map, &i, &zero, BPF_ANY);
+		RET_IF(err, "reset elem in result_map",
+		       "i:%u err:%d errno:%d\n", i, err, errno);
+	}
+
+	err = bpf_map_update_elem(linum_map, &zero, &zero, BPF_ANY);
+	RET_IF(err, "reset line number in linum_map", "err:%d errno:%d\n",
+	       err, errno);
 
 	for (i = 0; i < REUSEPORT_ARRAY_SIZE; i++)
 		close(sk_fds[i]);
-- 
2.20.1

