Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.74.67.63
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795095074;
	b=BPnLc1d6pTkcsLe2bpdjFJst7y3HwinB43TAVvnDVrr/n7zhOf+vdDUeaLjjMOdH1GVh
	 p+9avL8hAFqNrBpyCZvMJ7wkTkIiCYxlN/LBgGc7KWQDxb2P9XMzXm48JWvsqTCHjVnAY
	 J2/AUar8LMaj6k2fxg0a6Rr7Mx3aO/qh91ogcxWzt+Jo42lGlo0P/Zomhx1XK8WaSqPzn
	 CSjiNv7bIp73xNeqVJjfY6Ci18N2nBiqhmcAVSzxsk4av/E1vd7BcOjfodquL4bDavTvK
	 XYfT6lAuVwW/7HpCkWkVbjgyc+szh5l1DH+RzPGB8+mqjWdd2c1YeKYvqbYTSZVN2kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795095074;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 DKIM-Signature;
	bh=ek7NZSZk66IEwU0BTvcPsgNpxaCLENhsZm176O6DDyU=;
	b=NSfAEZpgN8o+xxze6KZCeFDYtTvOEaTfEpLACto/lUJOegdObII4+0e/uz9FSQwSadaj
	 6QdS+QqzinJSwdb1RR000blnP6pCKBEz209FyFyc8PUzgsFdyV+PTD63CmKOFwnmzpjN6
	 8jIpaAmbdPBGjV+InBnRCsfEyTYTqLFN2N3kkRSpe3Q/Pr2CExIT43HEkh9zf+pzBcDuF
	 wVVKZcDpSM5DTDU3u9YRj9jvPYOOs0YCN5IAP+vDIbgAyCq1t8Vfg3bq0432ZztauvqBZ
	 GKfC8mg82cqf8WuU+AZO0kH3YvFyCkNzakyAOg9L9n/egRqnNXbC86u9wu2A2rFJC3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=poczta.fm;
	spf=pass smtp.mailfrom=poczta.fm;
	dkim=pass header.d=poczta.fm header.i=@poczta.fm header.a=rsa-sha256 header.s=dk header.b="yQjV/pXu";
	arc=none smtp.remote-ip=217.74.67.63
Received: from smtpo63.interia.pl (smtpo63.interia.pl [217.74.67.63])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB33606A338
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 13:31:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECB33606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=poczta.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=poczta.fm
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=poczta.fm header.i=@poczta.fm header.a=rsa-sha256 header.s=dk header.b=yQjV/pXu
Received: from localhost (unknown [80.68.231.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by poczta.interia.pl (INTERIA.PL) with ESMTPSA;
	Thu, 19 Nov 2026 14:31:09 +0100 (CET)
From: Slawomir Stepien <sst@poczta.fm>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Tianyi Gao <tianyi@cloudflare.com>,
	Octavian Purdila <tavip@google.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Slawomir Stepien <sst@poczta.fm>
Subject: [PATCH v7 bpf 5/5] selftests/bpf: Shrink test_run frags after generic XDP ran on lo
Date: Thu, 19 Nov 2026 14:30:32 +0100
Message-ID: <20261119133032.2015656-6-sst@poczta.fm>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261119133032.2015656-1-sst@poczta.fm>
References: <20261119133032.2015656-1-sst@poczta.fm>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=poczta.fm; s=dk;
	t=1795095072; bh=ek7NZSZk66IEwU0BTvcPsgNpxaCLENhsZm176O6DDyU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=yQjV/pXuU8HvAJ67XKahDyNu0UxnWZKUj0AmBXyw+8ifxEwFUjIKPkzycztwVaYGN
	 HhOgkZwdjbb6J8Lh4XCSAbl9UNl8ei6mIp2hL4IEZDWDnTgUQewAkQc7cBDzmEt3r2
	 riOZp2fpp/3a9i11AES5XMN7KD5z4Hh9k3q1a2OM=

bpf_prog_test_run_xdp() used the rxq info of the loopback device's
queue 0, and generic XDP sets the mem type of that rxq info for the
packets it handles. Run a packet through generic XDP on lo in a new
netns, then repeat xdp_adjust_frags_tail_shrink there, which frees
test_run frags from the program.

Without the test_run fix this hits WARN_ON() in page_pool_unref_netmem()
and leaks the frag pages; the test itself still passes, so the failure
shows up in the kernel log (and as a panic with panic_on_warn).

Signed-off-by: Slawomir Stepien <sst@poczta.fm>
---
 .../bpf/prog_tests/xdp_adjust_tail.c          | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c b/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c
index 43264347e7d7..c0d54cf421d8 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c
@@ -1,6 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <test_progs.h>
 #include <network_helpers.h>
+#include <linux/if_link.h>
+#include <net/if.h>
+#include "xdp_dummy.skel.h"
 
 static void test_xdp_adjust_tail_shrink(void)
 {
@@ -355,6 +358,52 @@ static void test_xdp_adjust_frags_tail_grow_64k(void)
 	bpf_object__close(obj);
 }
 
+/* bpf_prog_test_run_xdp() runs on the rxq of lo's queue 0, where generic
+ * XDP sets the mem type of the frags it hands to its program. Let generic
+ * XDP see a packet on lo first, then free test_run frags from the program.
+ */
+static void test_xdp_adjust_frags_tail_shrink_after_generic(void)
+{
+	struct sockaddr_in addr = {
+		.sin_family = AF_INET,
+		.sin_addr.s_addr = htonl(INADDR_LOOPBACK),
+		.sin_port = htons(9),
+	};
+	struct netns_obj *ns = NULL;
+	struct xdp_dummy *skel;
+	int fd = -1, lo;
+
+	skel = xdp_dummy__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "xdp_dummy__open_and_load"))
+		return;
+
+	ns = netns_new("xdp_adjust_tail_ns", true);
+	if (!ASSERT_OK_PTR(ns, "netns_new"))
+		goto out;
+
+	SYS(out, "ip link set dev lo up");
+	lo = if_nametoindex("lo");
+	if (!ASSERT_GT(lo, 0, "lo ifindex"))
+		goto out;
+
+	if (!ASSERT_OK(bpf_xdp_attach(lo, bpf_program__fd(skel->progs.xdp_dummy_prog),
+				      XDP_FLAGS_SKB_MODE, NULL), "attach generic XDP"))
+		goto out;
+
+	fd = socket(AF_INET, SOCK_DGRAM, 0);
+	if (ASSERT_GE(fd, 0, "socket"))
+		ASSERT_EQ(sendto(fd, "x", 1, 0, (struct sockaddr *)&addr, sizeof(addr)),
+			  1, "sendto");
+	bpf_xdp_detach(lo, XDP_FLAGS_SKB_MODE, NULL);
+
+	test_xdp_adjust_frags_tail_shrink();
+out:
+	if (fd >= 0)
+		close(fd);
+	netns_free(ns);
+	xdp_dummy__destroy(skel);
+}
+
 void test_xdp_adjust_tail(void)
 {
 	int page_size = getpagesize();
@@ -367,6 +416,8 @@ void test_xdp_adjust_tail(void)
 		test_xdp_adjust_tail_grow2();
 	if (test__start_subtest("xdp_adjust_frags_tail_shrink"))
 		test_xdp_adjust_frags_tail_shrink();
+	if (test__start_subtest("xdp_adjust_frags_tail_shrink_after_generic"))
+		test_xdp_adjust_frags_tail_shrink_after_generic();
 	if (test__start_subtest("xdp_adjust_frags_tail_grow")) {
 		if (page_size == 65536)
 			test_xdp_adjust_frags_tail_grow_64k();
-- 
2.56.0

