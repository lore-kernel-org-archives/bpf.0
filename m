Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com [74.125.230.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7174A1DE5
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 15:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789052940; cv=none; b=DWFUJckM3CMIkMLh94tINVv4lgWzzcfkvcGZB4MP6LIpaMPnX53R8np8xk3fBanmCAC5OE1jTSx+WNRK+spmoOA9wfPm7XGPTrxELyxb4iXBAJOmxwiWZY09vXqoUo4ZsvS/G+zCUzxZtKx5mYvxzAAYDuaTDMOCQagcGQcm3ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789052940; c=relaxed/simple;
	bh=3DbHv+iTX4L3PJMeVnUlH/TtcwZtYZl3I9H/zJtf8Z4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LSXiDbeAFH3cmNpM8uV23x/OkwIrDdHl7hnAv1kVf80Wf7iRDH5e67Gu3R+BC2xvqdKK+l1JUUrtQ8G46valTmeqlsA4Jlrc7BrQyoG198PE0ycScQfjtvvuJ+DbVtb6VuVTfm/4JvxjJY01n21BvIpIWDZdboFw1nvZcytB6+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=WFgCb8Il; arc=none smtp.client-ip=74.125.230.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="WFgCb8Il"
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a354118856so13816621fa.1
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 08:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1789052933; x=1789657733; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=42dvhu2SyGXAENM7Q7aMtAhVbORcgby5xBEV1XxO6q4=;
        b=WFgCb8IlvANt4TEJLxYScr75C4qA6CHHltoEJo2pUztSAMWyrc+NzC3+nuT8pgyoIC
         c0znlYpAjTVGeplChNfExcVnQ9iNunw4VnixpvIyZIxTreNhP950ADd/XN/glRBGpOIK
         tjoaR0htRz4j4V4UToEZxPPcYlYyxHOpcvGE+ygPFDL8Tt1kRSrgensnnQSAjkAdYL+0
         fvYUmsWYLo8Vg4OB4gdvO05Zgg/4zwuGjMwpry8jLQung0mor6/u11vnwRNIdbpDD3FK
         1XMt1/oFgFF9zEWJk5aDbbbu5VX7IAHqmNVy0eb1OAsgEzUgxxSoXesEz32WKc82lQfP
         EBvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789052933; x=1789657733;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=42dvhu2SyGXAENM7Q7aMtAhVbORcgby5xBEV1XxO6q4=;
        b=sARnassq229tjvdmzLTf89rgJeEkwjQARlRvOFvA1kiTkcWABcxR40QPtXl19XBuqo
         G1cksKHWM+pMCY6qQ4LDevIeJ5CSERiGiPws41ZqzDsmjLvNzF1I2z+hNYLJTWukXvVD
         wMYwkzqRJymmZVlHxer0od9dwn69PqECfMf2rEPRRXFZRQuyeUDHDh/Z1A1rZmPRs3WP
         D0WD0Tk0tcwT4nykTLm0fMnPCtwJdd+q2Js49nq+v6nY+zfHe2p0munnljPtpRuwjl5s
         Je0AtBZ9GfCW661l9FHJbK+vZNBXNiMYQKAXfYig20PIXMOwbDf4l+zbdumriXY63v10
         m68A==
X-Gm-Message-State: AFuF++m+5HfE/H+0b0uzfPJrH6wxSFC67NRUcFLxuRW49Ugq99vYrWg3
	rBQfmHZVkmdljparA+KToNO3UWVL554V/B0tG79anxsq6+Y98ANY0nZwGsWdYl0JzR2hEumlloG
	stw3/W0Y=
X-Gm-Gg: AYBFou2g1Bil7Bf7shLi9g1cO1bawoGzulW750nU3VGleb8TedAbY6fbco3yIZ7Pr+K
	0Op+tS4cws+qRJqENpcVrDHaFKm4mYr7KL0wEI99m9A4fyYf97PJtwJA1bWMDx3wjvmv4mSrFrw
	+dEl2vk3iEWGIBfkh/avMoU98l+D9mguBP9hl6vPjjtXyJ0krDD5rVfYC5EZuTHpyifU9AaNjjU
	d4bLyaOnqYePne178pkzvnnkh4fysV23aqNmqy+wZg2Y7hijFzD31HUrz1H3wdSf0lN9AcyMMBg
	jDKdvY+618o4p3QS0MDDYBlwlE3+oe2VoDquHVltkLWBfLwS7Y8AAthBWR9WvZtqKb/Yt/BrI3Y
	9kIdPB2hY0mSLE/2p0ryZ/8Ky9/ciKONtJsAkDAqW7QYOQv3eY8NXARmI++XqZOl4mQ2qCJw56h
	i9QkE2CKGUpl3Xde/d95gPUwsBDMMIO2uCcatBZUS8BEspe/pB30AnwY3oQWuNRYVwAmRKmFxeI
	cjCj/c1wUwD0fwIMyOneTXSbBjrUjI+E+jnL77KQmbhjdgK
X-Received: by 2002:a17:906:ba85:b0:c26:1648:a066 with SMTP id a640c23a62f3a-c2941b3a8bdmr347406966b.33.1789048983836;
        Thu, 10 Sep 2026 07:03:03 -0700 (PDT)
Received: from cloudflare.com (79.184.140.212.ipv4.supernova.orange.pl. [79.184.140.212])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d036440sm928281666b.5.2026.09.10.07.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 07:03:03 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Thu, 10 Sep 2026 16:02:48 +0200
Subject: [PATCH net-next v2 13/14] selftests/bpf: Test skb_ext read from
 sk_skb stream verdict hook
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-bpf-meta-inside-skb-ext-v2-13-0b21e42180b0@cloudflare.com>
References: <20260910-bpf-meta-inside-skb-ext-v2-0-0b21e42180b0@cloudflare.com>
In-Reply-To: <20260910-bpf-meta-inside-skb-ext-v2-0-0b21e42180b0@cloudflare.com>
To: netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Stanislav Fomichev <sdf@fomichev.me>
Cc: bpf@vger.kernel.org, kernel-team@cloudflare.com, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Simon Horman <horms@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Florian Westphal <fw@strlen.de>, Jack Wang <163wangjack@gmail.com>
X-Mailer: b4 0.16.0

Test bpf_dynptr_from_skb_ext() from sk_skb context. Write to skb_ext from
TC on loopback; read from skb_ext from the sockmap verdict program.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 .../selftests/bpf/prog_tests/socket_helpers.h      |  1 +
 .../bpf/prog_tests/xdp_context_test_run.c          | 80 ++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  | 18 +++++
 3 files changed, 99 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/socket_helpers.h b/tools/testing/selftests/bpf/prog_tests/socket_helpers.h
index 0d59503a0c73..eb114a6ea6f9 100644
--- a/tools/testing/selftests/bpf/prog_tests/socket_helpers.h
+++ b/tools/testing/selftests/bpf/prog_tests/socket_helpers.h
@@ -3,6 +3,7 @@
 #ifndef __SOCKET_HELPERS__
 #define __SOCKET_HELPERS__
 
+#include <error.h>
 #include <sys/un.h>
 #include <linux/vm_sockets.h>
 
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
index 2814bfa0d6b5..01241276c4d3 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -4,6 +4,7 @@
 #include <linux/ipv6.h>
 #include <linux/netfilter.h>
 #include <arpa/inet.h>
+#include "socket_helpers.h"
 #include "test_xdp_context_test_run.skel.h"
 #include "test_xdp_meta.skel.h"
 
@@ -1678,6 +1679,83 @@ static void test_skb_ext_seg6local(struct test_xdp_meta *skel)
 		unlink(SEG6_PIN_PATH);
 }
 
+/*
+ * Test skb_ext survival across TC ingress -> sk_skb verdict hook.  TC ingress
+ * writes skb_ext on loopback; the verdict program reads it on skb delivery to a
+ * socket in the sockmap.
+ */
+static void test_skb_ext_sk_skb(struct test_xdp_meta *skel)
+{
+	LIBBPF_OPTS(bpf_tc_hook, tc_hook,
+		    .ifindex = 1 /* IFINDEX_LO */,
+		    .attach_point = BPF_TC_INGRESS);
+	LIBBPF_OPTS(bpf_tc_opts, tc_opts, .handle = 1, .priority = 1);
+	struct bpf_link *verdict_link = NULL;
+	struct sockaddr_in addr;
+	socklen_t addr_len = sizeof(addr);
+	struct netns_obj *ns = NULL;
+	char buf[TEST_PAYLOAD_LEN];
+	int c1 = -1, p1 = -1;
+	int map = -1, zero = 0;
+	ssize_t n;
+	int ret;
+
+	ns = netns_new("tc_to_sk_skb", true);
+	if (!ASSERT_OK_PTR(ns, "netns_new"))
+		return;
+
+	skel->bss->test_pass = false;
+
+	ret = bpf_tc_hook_create(&tc_hook);
+	if (!ASSERT_OK(ret, "bpf_tc_hook_create"))
+		goto cleanup;
+
+	tc_opts.prog_fd = bpf_program__fd(skel->progs.tc_skb_ext_write_port);
+	ret = bpf_tc_attach(&tc_hook, &tc_opts);
+	if (!ASSERT_OK(ret, "bpf_tc_attach"))
+		goto cleanup;
+
+	map = bpf_map_create(BPF_MAP_TYPE_SOCKMAP, NULL, sizeof(int),
+			     sizeof(int), 1, NULL);
+	if (!ASSERT_GE(map, 0, "bpf_map_create"))
+		goto cleanup;
+
+	verdict_link = bpf_program__attach_sockmap(skel->progs.sk_skb_skb_ext_read,
+						   map);
+	if (!ASSERT_OK_PTR(verdict_link, "attach_sockmap"))
+		goto cleanup;
+
+	if (!ASSERT_OK(create_pair(AF_INET, SOCK_STREAM, &c1, &p1), "create_pair"))
+		goto cleanup;
+
+	if (!ASSERT_OK(bpf_map_update_elem(map, &zero, &c1, BPF_NOEXIST), "map_update"))
+		goto cleanup;
+
+	if (!ASSERT_OK(getsockname(c1, (struct sockaddr *)&addr, &addr_len),
+		       "getsockname"))
+		goto cleanup;
+	skel->bss->target_port = addr.sin_port;
+
+	n = send(p1, test_payload, TEST_PAYLOAD_LEN, 0);
+	if (!ASSERT_EQ(n, TEST_PAYLOAD_LEN, "send"))
+		goto cleanup;
+
+	n = recv_timeout(c1, buf, sizeof(buf), MSG_DONTWAIT, IO_TIMEOUT_SEC);
+	ASSERT_EQ(n, TEST_PAYLOAD_LEN, "recv");
+	ASSERT_TRUE(skel->bss->test_pass, "test_pass");
+
+cleanup:
+	if (c1 >= 0)
+		close(c1);
+	if (p1 >= 0)
+		close(p1);
+	bpf_link__destroy(verdict_link);
+	if (map >= 0)
+		close(map);
+	bpf_tc_hook_destroy(&tc_hook);
+	netns_free(ns);
+}
+
 void test_skb_ext_cross_hook(void)
 {
 	struct test_xdp_meta *skel = NULL;
@@ -1709,6 +1787,8 @@ void test_skb_ext_cross_hook(void)
 				 skel->progs.lwt_xmit_skb_ext_write, "xmit", true);
 	if (test__start_subtest("tc_to_seg6local"))
 		test_skb_ext_seg6local(skel);
+	if (test__start_subtest("tc_to_sk_skb"))
+		test_skb_ext_sk_skb(skel);
 
 	test_xdp_meta__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_meta.c b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
index 00312a549ea9..5b1a5b9b610e 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_meta.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
@@ -1232,4 +1232,22 @@ int seg6local_skb_ext_read(struct __sk_buff *ctx)
 	return BPF_OK;
 }
 
+/* Read skb_ext from sk_skb stream verdict hook */
+SEC("sk_skb/stream_verdict")
+int sk_skb_skb_ext_read(struct __sk_buff *ctx)
+{
+	__u8 meta_have[META_SIZE];
+	struct bpf_dynptr meta;
+
+	if (bpf_dynptr_from_skb_ext(ctx, 0, 0, &meta))
+		return SK_PASS;
+	if (bpf_dynptr_read(meta_have, META_SIZE, &meta, 0, 0))
+		return SK_PASS;
+	if (!check_metadata(meta_have))
+		return SK_PASS;
+
+	test_pass = true;
+	return SK_PASS;
+}
+
 char _license[] SEC("license") = "GPL";

-- 
2.43.0

