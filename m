Return-Path: <SRS0=US5c=RX=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10213C43381
	for <bpf@archiver.kernel.org>; Wed, 20 Mar 2019 12:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2DAD21871
	for <bpf@archiver.kernel.org>; Wed, 20 Mar 2019 12:54:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QfyAT6l/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbfCTMyC (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 20 Mar 2019 08:54:02 -0400
Received: from mail-pf1-f169.google.com ([209.85.210.169]:43574 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727222AbfCTMyC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Mar 2019 08:54:02 -0400
Received: by mail-pf1-f169.google.com with SMTP id c8so1866848pfd.10;
        Wed, 20 Mar 2019 05:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8jgI/FmvlJaP2hZiIBCLGu9+1MttHd5oQtDar/JHNL0=;
        b=QfyAT6l/ehpmfensZOg2xO1+BtdOcKsQUCktz3qhcKlrL9JRZduPWk8ym8jRWVI2c5
         9BQY/GrAOdZ7j+UiPASKTi+K+fGxg+FMMsAUrOUCCjBXkjW7SjHu00ns8Vyerqqw1W8K
         0fQ6tl2IQA/Dz9a7qT/IPtMP5plQuxrOVJDgnmhfdY8m9/rbPDgkzW2q2dBPD9JjtE8J
         ZGbTjdd35IA2TgXc1sAImuit6sUojz4iQirN/UgHTMBbM9COBzweeIMBP3B6PMwWFA/g
         tL3lqmA5tbFk5F3e4pVKCs1shxLAh50QPGN/BnbfynRwRwx2cfERFkg9OWAqpE5B2YQL
         JmaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8jgI/FmvlJaP2hZiIBCLGu9+1MttHd5oQtDar/JHNL0=;
        b=GrPPNkiw8GNh/XQRRSn6sur3iZI8yiBVlr/CyRH7gvBZCUjcxayi3N85HTgkRrFZ+h
         zaQZ01a0t1nfAvYMQignIrKJHz9rWyNkpU4iI8n68ao5JgGfwxAGWCqUf+lmO+B3FXv0
         CepsnNDXEMegqSMrmRrYvw7/pNJCoKJPIfddv47hLnN7+C6WJ0OpPcHx9igFUlvc2jyW
         +IAb8Y6N9NJubbLXInAHPAYHvgwn7XnkqU1+hxTqE6bP+BekqTBHcGhfhNDldfag0bDm
         hmpamjc4ILSOC//WDZHevNRJrpVXqAY+lNwlJmLog8Bo3A+VPL58+WK8CznQnVAbAbEX
         Dj/Q==
X-Gm-Message-State: APjAAAWs5VFmx95uSoEU2j16il7XNElgf9NIezk6cIwMcEUvMxw3dh4w
        Y5VoCChJE9tK8tE4GQJC4pg=
X-Google-Smtp-Source: APXvYqwsGL01PHBuOTrIp8z5ZnHZBR91MliDVBiPtLk5eY7aD215fyBwb1bbO62UeSc8ZiWwJwJ6wg==
X-Received: by 2002:a17:902:1101:: with SMTP id d1mr7587631pla.19.1553086441317;
        Wed, 20 Mar 2019 05:54:01 -0700 (PDT)
Received: from localhost.localdomain ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id r8sm2707467pfd.8.2019.03.20.05.53.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 05:54:00 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>
Cc:     Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [PATCHv2 bpf-next 3/3] bpf, tests: don't use __bpf_constant_htons()
Date:   Wed, 20 Mar 2019 21:53:35 +0900
Message-Id: <20190320125335.19621-3-sergey.senozhatsky@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190320125335.19621-1-sergey.senozhatsky@gmail.com>
References: <20190320125335.19621-1-sergey.senozhatsky@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Prefer bpf_htons() instead.

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/flow_dissector.c | 4 ++--
 tools/testing/selftests/bpf/test_progs.c                | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
index bcbd928c96ab..a194305f98d1 100644
--- a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
+++ b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
@@ -28,7 +28,7 @@ static struct bpf_flow_keys pkt_v4_flow_keys = {
 	.thoff = sizeof(struct iphdr),
 	.addr_proto = ETH_P_IP,
 	.ip_proto = IPPROTO_TCP,
-	.n_proto = __bpf_constant_htons(ETH_P_IP),
+	.n_proto = bpf_htons(ETH_P_IP),
 };
 
 static struct bpf_flow_keys pkt_v6_flow_keys = {
@@ -36,7 +36,7 @@ static struct bpf_flow_keys pkt_v6_flow_keys = {
 	.thoff = sizeof(struct ipv6hdr),
 	.addr_proto = ETH_P_IPV6,
 	.ip_proto = IPPROTO_TCP,
-	.n_proto = __bpf_constant_htons(ETH_P_IPV6),
+	.n_proto = bpf_htons(ETH_P_IPV6),
 };
 
 void test_flow_dissector(void)
diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 5d10aee9e277..909b339f97f4 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -11,18 +11,18 @@ int error_cnt, pass_cnt;
 bool jit_enabled;
 
 struct ipv4_packet pkt_v4 = {
-	.eth.h_proto = __bpf_constant_htons(ETH_P_IP),
+	.eth.h_proto = bpf_htons(ETH_P_IP),
 	.iph.ihl = 5,
 	.iph.protocol = IPPROTO_TCP,
-	.iph.tot_len = __bpf_constant_htons(MAGIC_BYTES),
+	.iph.tot_len = bpf_htons(MAGIC_BYTES),
 	.tcp.urg_ptr = 123,
 	.tcp.doff = 5,
 };
 
 struct ipv6_packet pkt_v6 = {
-	.eth.h_proto = __bpf_constant_htons(ETH_P_IPV6),
+	.eth.h_proto = bpf_htons(ETH_P_IPV6),
 	.iph.nexthdr = IPPROTO_TCP,
-	.iph.payload_len = __bpf_constant_htons(MAGIC_BYTES),
+	.iph.payload_len = bpf_htons(MAGIC_BYTES),
 	.tcp.urg_ptr = 123,
 	.tcp.doff = 5,
 };
-- 
2.21.0

