Return-Path: <SRS0=wUMJ=RW=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E63D6C43381
	for <bpf@archiver.kernel.org>; Tue, 19 Mar 2019 02:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF80120850
	for <bpf@archiver.kernel.org>; Tue, 19 Mar 2019 02:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R22KOdnw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbfCSCsx (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 18 Mar 2019 22:48:53 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33301 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbfCSCsx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Mar 2019 22:48:53 -0400
Received: by mail-pg1-f196.google.com with SMTP id i7so9571034pgq.0;
        Mon, 18 Mar 2019 19:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+/bRxtBZAnAk4+2+6KrELoXqUx610KQWrZpqtui+Lwg=;
        b=R22KOdnwrwAnaRdp341VAl5En19hq6X0q7i5hfct7njZeuZ/2Gjm17qxOR/IbIP1wn
         +ZFFYYxvNV4/lroPYVI1s/l6AHc+0CIbXYXRmaY5Y1k7rrl3g20YPGH0SjvCtkLid4XX
         STXatyALB6LMIfZgWw1VJ/8r86b5/QNVq24DPEialn2GmPQWjFyijzwWMYryLzOOe0a4
         h453vCaGOhU3MfjFoVd8YgJ3x+uv7peMw9VGBlHcuniEFnBWX53XffH2iOL5yvp59hgK
         ZhdsSPjc/XabOKR/3UKdnCpBmwhhPFSx53hMh5mCkTmblVox7m9Ljs3MlEtEmG5yXIjG
         G/6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+/bRxtBZAnAk4+2+6KrELoXqUx610KQWrZpqtui+Lwg=;
        b=ameHNgt6IkAgvFpI4ptLS3cy1yrkVk/dNBPhPg+Z3PPqbSfzBOmJswNXg3QhqWptpM
         6US3FdVfvdofk/HNojY2Gf7Qm3hifhCINcewnpnT/DeRSyYV7RaateuuW+RAWOzGlhqJ
         +79/J7BNVsAQ0Zrj3ZCFafITsG/j3jN8Ab0kFzcwnP9nNc9KJgzLcWrkMr1GNDaaTr/l
         rvtZDFcjP2YzYDFPYYsosbNfkkqCU8mbWStmUwdFLmfldWQWFA5LytqisVil2AMSiyBg
         qE6t4lfQr3bn6sGeJ1fJoMrG+EKygJK/VxyIxolPKltKDg8DK9GhGbJcuX5uPhu3vvHY
         Obng==
X-Gm-Message-State: APjAAAU8XY8esr78atLbngCqPfcmWOmfYws/w358bJIWNMt8PX4HgnZw
        Q2Jmk96id+Q4+Y42Qi1OGNw=
X-Google-Smtp-Source: APXvYqxMKbBHE8jdjku07VIJx4QwyJN7efIcSYemjOKTXKiW9jnDqDrt0TvYTRc6hBjbTY0nTdj/Jw==
X-Received: by 2002:a17:902:b196:: with SMTP id s22mr90496plr.33.1552963732264;
        Mon, 18 Mar 2019 19:48:52 -0700 (PDT)
Received: from localhost.localdomain ([175.223.38.238])
        by smtp.gmail.com with ESMTPSA id z67sm27316437pfi.152.2019.03.18.19.48.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 19:48:51 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>
Cc:     Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [PATCH] bpf, tests: don't use __bpf_constant_htons()
Date:   Tue, 19 Mar 2019 11:48:43 +0900
Message-Id: <20190319024843.30807-1-sergey.senozhatsky@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Prefer bpf_htons() instead (since __bpf_constant_htons() was removed).

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

