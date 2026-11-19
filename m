Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795052344;
	b=ABQoNbwm/BLXCpDK31nmq0UEU1i8jRXiwvrHYZYeq8VcC66Yvit2rU8hfziZMH3izkXG
	 r4orWBpdBIynTbAcAqTZMb+Jgz/XlNvd5T3oQbAxU4LDPMV5Nh6YvX4SEA0lWdm/g+O/i
	 LPl71tNeXaE8CPiQF0dSf9fg7fqtI9eGskG7mF8mLNUhX3Bvrjct1Y7UqZokGTX/z2yX4
	 XpHX9fnqg6yc1lY+iQ67VCJmkDNOaabsXevWhq4pZCeGtgPZNO2j8MTgaQ04GDr6XCDqq
	 MWwJaB3SgLOZUkAbcp7kjzB8/KQGcUMM0ZK5QLaESXr5IUH06SeOhAR8JFORCU6INXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795052344;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=pcVobQ6pdsPePLIZ/BBz4G2XF5J7pWqm1D1h7L58vTo=;
	b=HOK25fXRbAIaNjuK5LHMIFmB7NLfaIGmhmyTxFVNuxJrChVeSgASxXydEY9IzvjXqVFf
	 XcSpMqCRRDZ8l8Zoqq4oLd9I5ByJLepsIP1V3aLNo6+Rmz6NQqZGne0aCaPgHsZZdkPYD
	 YMRlK8L/GQj4UomOjR8L1RK/1sdLPIYKuF8LOhnBe7qzoyMglyw3W1ZI7bFOiKHaRBTrA
	 r7hDozAAETdPSduplgV9Qb9ijeE/MVZBbOQFZyU1CVr9L3GD5zEN11tAf+YEI4RSlNzxH
	 DTyfwgZljZ29c59oJ5bNboVPjsIyUD5aK/StcDUp6kXggraWKnm179g86/nhKMO0HqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=ccSGHZ15;
	arc=none smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC4060A2634
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 01:39:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2DC4060A2634
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=ccSGHZ15
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6b408f2d936so2867454a12.1
        for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 17:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1795052342; x=1795657142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pcVobQ6pdsPePLIZ/BBz4G2XF5J7pWqm1D1h7L58vTo=;
        b=ccSGHZ15/ZgOGR8IqTTC2ci5ZtHFCkvm0Hb6fQPjcMVpqXZytSMhaRxMCXyDwadjFV
         2jvR1V85z/h1YsbpP6YFAkjK35UK/YxOftElkKDqZGYiej+iMWyzMQsVA8E1ZV6brlVm
         eFaYZw5goZY9eLDohkYPL8vF634Dcg0Nihxb+K5efYasQAG3XwQ913eeVc+5RDTmlu/N
         ezYcELPFqJdtJn5iOTO/ynQgZExOJsFf6vAHL1aYjc58/rPgdNqo6sMDa3cw5O+/mUmI
         eV2FzCIHLaqATmnRR2dsCoNF/Owj95KUfwvEECcVWDSr4aQO5MHCRwC4ZN1qkLjKVD7w
         SUfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795052342; x=1795657142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pcVobQ6pdsPePLIZ/BBz4G2XF5J7pWqm1D1h7L58vTo=;
        b=AwsJd8DozF8uErGogA2aDML/pTVpXH3Tsb0NXRhzbgrE2rFMSRx+tOojTzEkSTv+qx
         aTIUBNplPQBWrdXE2fEqShi3Y278b1g911DhKeXvwD8D7ep8ICd48QLeub9aqrsMxy/N
         Fp5oo6n9MtNc0s0P0SgMq6YLJs5tokll77Sv+psCRlZgK9rC2NIT1O5BV9Gd25/K0mMo
         DjDx7WyMPVqciz8lWmDhxmE/DO4iBseY9EUlYwZdQSQZmepi5tx9Wa4yBOowjcxDpJNH
         zDfA7dofcKlAB6Vra4l7xJoN2EI4PfXMOHwMersYG25pher9TUvCFhgpFFZyX1oZkYO7
         bY2g==
X-Forwarded-Encrypted: i=1; AL+hErFwVJpSzvrS5PiQDZ5Wvccb37lBTeKTtvKP8+OJDLTlI4IwspIdt971+qW/YuAfkJ0vwNE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/tmLhiO5oBGAjIiJno2qLB2yvi1lSZbJkTeRznjeGKQvpa/tQ0
	jnF7Zz5rUXMDqf9M2YCJWEla+lCw1BuD3QExAz7xm/W2dbtpusTgiQaFVG7LKcXrx9Y=
X-Gm-Gg: AYBFou1ha4DHkYn9C2B0hhqwoLYLFCJJiu+tWGF1BlvT/Eo/xPaedo/sRpS9cEpWdJ9
	LmNAP7RghRniabPCrfPK3hc8EgOToCr7arFRj9RMOdZebdfiTcfi2KUPRJToq1lsc+GXnkOSIta
	LVt42tb9eO2RI5TT3+eywZ6M/WB/aB63+b7lPLdN89GCvyqirL3drn7xlDpvUbaublooI29pdvP
	zCYd5PXrmMahtQmeXU8aOJzLS9gjC7aHN0d7YbhpA9HrcCMAEQcd12hKpgKewJUoLeJcxTlG7LK
	CF2BQhYYfUNjA+ID48j6Voe2v2JewEQdjx1YR+ZbKBBkEUAuCgFy/8OQS6vHMqJsJoM+38YUKaw
	AmuPwgpOHCn1Z9A/XIhmFpfj04YaKIyYd3FrTdzZyE7K+4ZkjPKrQ41PI97SRU1UeirBQ9/qKgr
	X5soeDMccgb60v8mn7E7nfnhMR6fqwBjADLMbU+zRMOsgQQkcqcINSAti++ZS6dCw/K7wErKJT3
	j+xuvAHyYo5dohI+R8NMw77SdNBjxz/jOIfEhsPMu0L6LEFEqEIAG8PeA7auM/GQSWPJZJRpaap
	vtvXlgAeyXEihk2+SMmmc90yAJayRMznQJV69t2RlAByuWwikDKMkfeQTaWFk6JUpNw8ncaK7nB
	beaQ=
X-Received: by 2002:a17:907:a089:b0:c4d:31ad:9dd5 with SMTP id a640c23a62f3a-c510e3b3e30mr395519766b.42.1795052342557;
        Wed, 18 Nov 2026 17:39:02 -0800 (PST)
Received: from L9JK9NPFH9 ([104.28.20.56])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c51233c4080sm59785966b.16.2026.11.18.17.39.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 18 Nov 2026 17:39:02 -0800 (PST)
From: Tianyi Gao <tianyi@cloudflare.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>,
	David Keogh <dkeogh@amazon.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	David Woodhouse <dwmw2@infradead.org>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Nimrod Oren <noren@nvidia.com>,
	Alasdair McWilliam <alasdair@mcwilliam.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Alexei Starovoitov <ast@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Breno Leitao <leitao@debian.org>,
	=?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Danielle Ratson <danieller@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	bpf@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-team@cloudflare.com,
	nh-open-source@amazon.com,
	Stephen Hemminger <stephen@networkplumber.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	"Remy D. Farley" <one-d-wide@protonmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Andy Roulin <aroulin@nvidia.com>,
	Anil Kaushik <anilkaushikwireless@gmail.com>,
	Demos Ra <demosthenes.ra@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Hangbin Liu <hangbin.liu@linux.dev>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Joe Damato <joe@dama.to>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Li RongQing <lirongqing@baidu.com>,
	Louis Scalbert <louis.scalbert@6wind.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Michael Bommarito <michael.bommarito@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Song Liu <song@kernel.org>,
	Thorsten Leemhuis <linux@leemhuis.info>,
	Wang Zhan <wang.zhan@smartx.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Zhou Qiuyue <n0ps1edzz@gmail.com>,
	Tianyi Gao <tianyi.gao@linux.dev>,
	Tianyi Gao <tianyi@cloudflare.com>
Subject: [PATCH net-next v2 08/11] selftests/bpf: Test the tx_extra_headroom decl tag
Date: Thu, 19 Nov 2026 01:38:27 +0000
Message-ID: <20261119013830.36935-9-tianyi@cloudflare.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261119013830.36935-1-tianyi@cloudflare.com>
References: <20261119013830.36935-1-tianyi@cloudflare.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check that the verifier accepts a "tx_extra_headroom:" tag of
NETDEV_TX_EXTRA_HEADROOM_MAX (512 bytes), and rejects a tag above it, a
tag with a plus sign and two tags on the same program.

Signed-off-by: Tianyi Gao <tianyi@cloudflare.com>
---
v2:
- New patch.
---
 .../selftests/bpf/prog_tests/verifier.c       |  2 +
 .../bpf/progs/verifier_tx_extra_headroom.c    | 40 +++++++++++++++++++
 2 files changed, 42 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_tx_extra_headroom.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 6a494c381266..e3ef97ed092a 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -126,6 +126,7 @@
 #include "verifier_subreg.skel.h"
 #include "verifier_tailcall.skel.h"
 #include "verifier_tailcall_jit.skel.h"
+#include "verifier_tx_extra_headroom.skel.h"
 #include "verifier_typedef.skel.h"
 #include "verifier_uninit.skel.h"
 #include "verifier_unpriv.skel.h"
@@ -316,6 +317,7 @@ void test_verifier_subprog_topo(void)        { RUN(verifier_subprog_topo); }
 void test_verifier_subreg(void)               { RUN(verifier_subreg); }
 void test_verifier_tailcall(void)             { RUN(verifier_tailcall); }
 void test_verifier_tailcall_jit(void)         { RUN(verifier_tailcall_jit); }
+void test_verifier_tx_extra_headroom(void)    { RUN(verifier_tx_extra_headroom); }
 void test_verifier_typedef(void)              { RUN(verifier_typedef); }
 void test_verifier_uninit(void)               { RUN(verifier_uninit); }
 void test_verifier_unpriv(void)               { RUN(verifier_unpriv); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_tx_extra_headroom.c b/tools/testing/selftests/bpf/progs/verifier_tx_extra_headroom.c
new file mode 100644
index 000000000000..f15963e34434
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_tx_extra_headroom.c
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+SEC("tc")
+__attribute__((btf_decl_tag("tx_extra_headroom:512")))
+__success
+int tag_max(struct __sk_buff *skb)
+{
+	return 0;
+}
+
+SEC("tc")
+__attribute__((btf_decl_tag("tx_extra_headroom:513")))
+__failure __msg("invalid tx_extra_headroom tag '513'")
+int tag_above_max(struct __sk_buff *skb)
+{
+	return 0;
+}
+
+SEC("tc")
+__attribute__((btf_decl_tag("tx_extra_headroom:+20")))
+__failure __msg("invalid tx_extra_headroom tag '+20'")
+int tag_plus_sign(struct __sk_buff *skb)
+{
+	return 0;
+}
+
+SEC("tc")
+__attribute__((btf_decl_tag("tx_extra_headroom:20")))
+__attribute__((btf_decl_tag("tx_extra_headroom:30")))
+__failure __msg("multiple tx_extra_headroom tags for main subprog")
+int tag_twice(struct __sk_buff *skb)
+{
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.56.0

