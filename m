Return-Path: <SRS0=dKsF=3G=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 142B5C33CB1
	for <bpf@archiver.kernel.org>; Fri, 17 Jan 2020 07:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7F4F2073A
	for <bpf@archiver.kernel.org>; Fri, 17 Jan 2020 07:09:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T1regV3z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbgAQHJb (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 17 Jan 2020 02:09:31 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:52528 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729011AbgAQHJb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Jan 2020 02:09:31 -0500
Received: by mail-pj1-f68.google.com with SMTP id a6so2746885pjh.2;
        Thu, 16 Jan 2020 23:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RK6UZgBmhgEaIuXMKp36pKBJr/MfZBh5b9X7zcGawqQ=;
        b=T1regV3zY65rFQ4cAN0QS9yAC71rCeI56atdE5P8FjvM1Pabnm/kJTqtVCp8E1fMSl
         aeNyfMxoW7u0ss6/mhGgBT4P/y1+tsuHFdJUfP2+JQWLNIjxnMlvR7Y7ajseV+OV2HGE
         SuLmCgx6yxaby8QJDugt+NTy00wn/tMhBl2dooYagoMfMRGByYA/gUCD1f+etGltq+2C
         wezFeCiRq6UAXPU24/7YfjmyfdKn05Ad71qr3Pe7dZYeQ6zzBgni+MGgE6IXDa5zSSyD
         tnAxyGRuXMCo8lZ/EGpOcddFvTMhkqwp/ilBW+Bicyny1CGPJ3jR0CCvQRuQxD0063kO
         P7Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RK6UZgBmhgEaIuXMKp36pKBJr/MfZBh5b9X7zcGawqQ=;
        b=GM9TMSbjnqfMxY1R/Mm27WfcHu5LqpXrR6yh1quhA8u9+GbQLHQ+1s0ur0Ai/rIxn6
         lLIXMUMSrIz66pcyp8YR5pvBz7FnG3O2A5RPTk4FG0bq7BbbEtU1rJkMWfDahtsMlIqR
         Oypu+inDA2pCpOLpKSspPVaZ3pbPgye2HViD8kPDqS5kKsNt2J6sBBWOTDCp2NyUxCpt
         hEuXV+78cbnApobKfJqxROYVur9Ye0DsXiHPvlKmgVSHjG9iftuSfdfyLr+GoGh/t0NZ
         ed58LUcZbCWD7tjf/srk18HEz1Q13EnyePUxmoBN9n5gapd4Ou9q83GBO60AtizMtYu0
         UXWw==
X-Gm-Message-State: APjAAAVNz4rfZrfqIT2QeRash/Z85dqv/z8ZKHZryKMtwfj9D8ESgNG7
        jHoG/1axDYH+zEt4dmsl4SjDUrDp
X-Google-Smtp-Source: APXvYqwGh+XubKBcjJppor0qa+63gq1314RAIqyPIQYDqMiYHhyop9TV1GQI0tvKKJ2nSiVn4+l5CQ==
X-Received: by 2002:a17:90a:cf11:: with SMTP id h17mr3982656pju.103.1579244970768;
        Thu, 16 Jan 2020 23:09:30 -0800 (PST)
Received: from hpg8-3.kern.oss.ntt.co.jp ([222.151.198.97])
        by smtp.gmail.com with ESMTPSA id d4sm407499pjg.19.2020.01.16.23.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 23:09:30 -0800 (PST)
From:   Yoshiki Komachi <komachi.yoshiki@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Petar Penkov <ppenkov.kernel@gmail.com>
Cc:     Yoshiki Komachi <komachi.yoshiki@gmail.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Petar Penkov <ppenkov@google.com>
Subject: [PATCH v2 bpf 2/2] selftests/bpf: Add test based on port range for BPF flow dissector
Date:   Fri, 17 Jan 2020 16:05:33 +0900
Message-Id: <20200117070533.402240-3-komachi.yoshiki@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200117070533.402240-1-komachi.yoshiki@gmail.com>
References: <20200117070533.402240-1-komachi.yoshiki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a simple test to make sure that a filter based on specified port
range classifies packets correctly.

Signed-off-by: Yoshiki Komachi <komachi.yoshiki@gmail.com>
Acked-by: Petar Penkov <ppenkov@google.com>
---
 tools/testing/selftests/bpf/test_flow_dissector.sh | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_flow_dissector.sh b/tools/testing/selftests/bpf/test_flow_dissector.sh
index a8485ae..174b72a 100755
--- a/tools/testing/selftests/bpf/test_flow_dissector.sh
+++ b/tools/testing/selftests/bpf/test_flow_dissector.sh
@@ -139,6 +139,20 @@ echo "Testing IPv4 + GRE..."
 
 tc filter del dev lo ingress pref 1337
 
+echo "Testing port range..."
+# Drops all IP/UDP packets coming from port 8-10
+tc filter add dev lo parent ffff: protocol ip pref 1337 flower ip_proto \
+	udp src_port 8-10 action drop
+
+# Send 10 IPv4/UDP packets from port 7. Filter should not drop any.
+./test_flow_dissector -i 4 -f 7
+# Send 10 IPv4/UDP packets from port 9. Filter should drop all.
+./test_flow_dissector -i 4 -f 9 -F
+# Send 10 IPv4/UDP packets from port 11. Filter should not drop any.
+./test_flow_dissector -i 4 -f 11
+
+tc filter del dev lo ingress pref 1337
+
 echo "Testing IPv6..."
 # Drops all IPv6/UDP packets coming from port 9
 tc filter add dev lo parent ffff: protocol ipv6 pref 1337 flower ip_proto \
-- 
1.8.3.1

