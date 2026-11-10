Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794283064;
	b=fWh7SWmyVBZJH+ksp4qBM8nDvxWRLGyJtnIlaeA8PgOmr1fFoCvBciTud5vwDQ/4XzYW
	 fALL5dVmEPethSW9pUkufvWA5KCsxKTiFYinwLdY+ccHMHTpd88c4YmD6uBcCe8LHsA1V
	 0wMuLrdP3clMYm836wH2frQkPzZDcW5vrM4dlqPc/tgQx6U2MdfxOdFhlr0LDRQxSMVOp
	 LLW5enA3l3mspPyZe3N4nhn7mMXiPD00F7qPqjOhiQiOdT+SlpgbcAetwG/bEaaS7mFE1
	 uOp5kCgxmymvi70YNgMmwQKOwaSO+705MrHTWkj2hfxMcBDARHcgIPWyoPHoqqzesww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794283064;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=SBYnNw8wugDgfMzsse/6gFJtKXzUvfFkSoxPV5cebOs=;
	b=Q+gBpygCaeDl47FUaY8Bf7wK6AfTOsjoKsSFd4j+e8muVM1I0RdHL4NIx9ijL0izXZcr
	 Ip+PW6AtVIJsLgAg6xDNkWghZV2MdCT8dwiHgHdQeWCLlkODpDcz8RLKeD/lGgK7/9Hjp
	 OSx1W12mf/lU/r4QaNCJ10jY86iGpVn32GoVv2QRuok1e2nRBmo52r77QX7HfTMw0j44L
	 PpbjC3EJtiKqVG2b2JzWeI30Hjz1EeLoVQ7R7fiPjYDfP7VNpv+0F6FzRtQvhzijBdkpf
	 YtIi2yxijF5DVdsiF2kXSRpisLK+NdGdbS5emEA5A0/EoWO+KtVzocYE/eogCmlH90Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=al7fTmwx;
	arc=none smtp.remote-ip=209.85.208.51
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E28F60A2607
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 03:57:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E28F60A2607
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=al7fTmwx
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6b587538a37so2238046a12.2
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 19:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1794283062; x=1794887862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SBYnNw8wugDgfMzsse/6gFJtKXzUvfFkSoxPV5cebOs=;
        b=al7fTmwx7PwUBq416kyWYJB9kfiSju9sVjUHSHR0g1U02eYnfHr/5VlZOzwLrqGO2+
         blaLgQSq/gh1LM/gNEAiCSVJ8DdKPlTSoaibME9K679ZvWVmM4HZjjKubOmZwdxoFvZ1
         C4tGeCV8ZS6n53XG/xFKj5Cd6R75APMhWOaPf/xlDT6T6W7mUTzkZnWYdIDOkeXqcAoy
         1KKs0+VM6BMdSldoPjIUhG0GvmITTWXzoI2wbkY8u13IOyhWmc5k5ZsaVzY+fNisOtJL
         Sp74g+kBgrGNBAaiprjSkPznDgvw2J34fAGvjuMzWDhgMh+1FlPMDLdtEEy1/+4bj0fP
         gt2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794283062; x=1794887862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SBYnNw8wugDgfMzsse/6gFJtKXzUvfFkSoxPV5cebOs=;
        b=SFPCUjzTws9UaRS7Klevt5M4NLCQuBBYp2mlUztluDfIFiGslfxiebaUl4209p8WPv
         q1XzCWr7TjHIn5pc97EoJEJ8IUzjE7PvtIPwNy1zyukj8I4mGVLcu6jBsDL7Hy9/esbK
         qjuMISpx+pBopuEnaqqs3gK6FuKmwA49U8r7XxIJcc7itYrbPbPVkHYeSjgkyWCqfw1m
         6B+JMR1dTEWFxX3fl4X7mUhUY8lZcPy3DVPXIB8DC9kmnEz4imvJASRdKEit7GIOgXz6
         pABkW7NE4GUbZuzZNgDu/rIvVesy+pbhBX5p8lpJth6qqziqWqHyibc7dWmBqrqEcwD4
         3K+A==
X-Gm-Message-State: APuU4Z/7nr/uEcUMofTazXtr/PryI1g0NxcQjgo7PwZTC309z351AAQD
	zJf7nafBWYN+xSaoxjcxpc0RfP8GCB5QcYMJ1WPVraQz3p3NEX2hzIly+kGyWvGlKKpvDnYttnu
	luQxgOAg=
X-Gm-Gg: AYBFou2q384Ht4zX3iTVjtcvLWaG1VNBNCPjKTXCNnu5kCKijQYk1A5yCX5HSlH7hEz
	SsBshjCOzRn8wuwCUM1lmHk41+64gH3Fp18aHpVcUPYfAgKn3aZiRRvg2KMToaGE2i5Vs9xX9Iw
	MWkqwxGfpWeQWCVTJdJcDAbZRv/ApfSK1WeHrFYfAzowZ0vsSr72EXBKx3C6lDvUdRzGe9CSkfc
	xEdhG+duI0IDlpZb6W9sXixVnOuJ3BmlWPbVaExrqPiTHWM9cLqI6/AK6IZbdvBeHz7XcqvZWI1
	Wg7BdwEW5n9CHHw8kXAjgHdWlga9r+yl8DVHolsMdq02a3SKgWJM5wJ5iC0DrA/DZfGXBOMO3hG
	KHvwTKmtT3BuMmgEfi/TA9mj66uLS++FyPg7roar41oUlQBLbKNy2qnUwYOMbXuqeMRI2iu4xpc
	2Thor5aCu20bmlAktO7V4/RK3Orv5eQzCMdoTsYT6V+W5QvKmCgm+BskuX7NWTqBOCS2Tky/bMn
	GfpXtsea0DSzrFztm7b7hT74jLNJOsNAQNRtQaBtYd0K74iDb9VJThTnqjMyq3+36SQxNxbuDo2
	g9a3nxOFu5hvKc6qkFA0Kihr3fYs+B7wcyq8ExlU3llhvggcqMbO2l4WVc6WBQd2cPqPBXS5tIc
	SuJCMzc47
X-Received: by 2002:aa7:d496:0:b0:6ac:934e:a9ca with SMTP id 4fb4d7f45d1cf-6b755626f5fmr854123a12.0.1794283061765;
        Mon, 09 Nov 2026 19:57:41 -0800 (PST)
Received: from L9JK9NPFH9.lan ([104.28.20.56])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7579047c9sm548801a12.33.2026.11.09.19.57.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Nov 2026 19:57:40 -0800 (PST)
From: Tianyi Gao <tianyi@cloudflare.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Vladimir Vdovin <deliran@verdict.gg>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Tushar Vyavahare <tushar.vyavahare@intel.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Madalin Bucur <madalin.bucur@nxp.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Chris J Arges <carges@cloudflare.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	llvm@lists.linux.dev,
	kernel-team@cloudflare.com,
	Tianyi Gao <tianyi@cloudflare.com>
Subject: [PATCH bpf-next 06/15] selftests/bpf: Test the skb core extension kfuncs
Date: Tue, 10 Nov 2026 03:57:04 +0000
Message-ID: <a0de7cb0815f2bc21f868cbe451958c910baf225.1794281983.git.tianyi@cloudflare.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794281983.git.tianyi@cloudflare.com>
References: <cover.1794281983.git.tianyi@cloudflare.com>
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

Add tests for the kfuncs that store and delete skb core extension
entries.

An XDP program cannot read the area, because it is below data_meta. So
the tests check the return values of the kfuncs and the lower bound of
bpf_xdp_adjust_head(), bpf_xdp_adjust_meta() and bpf_xdp_pull_data().
A later patch tests the skb fields.

xdp_skb_ext uses BPF_PROG_RUN. It has test cases for the size of the
area, invalid arguments, -ENOSPC, delete, and a tc program that calls
the kfuncs. The live_frames subtest checks that the area of a recycled
page is not valid for the next packet. The subtest fails if no page is
recycled.

test_xsk checks that the store kfuncs return 0 in copy mode and
-EOPNOTSUPP in zero-copy mode. xdp_pull_data checks that a stored hash
entry reduces the maximum pull length by 12 bytes.

Signed-off-by: Tianyi Gao <tianyi@cloudflare.com>
---
 .../selftests/bpf/prog_tests/test_xsk.c       |  25 ++
 .../selftests/bpf/prog_tests/test_xsk.h       |   2 +
 .../selftests/bpf/prog_tests/xdp_pull_data.c  |  12 +-
 .../selftests/bpf/prog_tests/xdp_skb_ext.c    |  41 +++
 .../selftests/bpf/progs/test_xdp_pull_data.c  |   7 +
 .../selftests/bpf/progs/test_xdp_skb_ext.c    |  41 +++
 .../selftests/bpf/progs/xdp_skb_ext_failure.c |  16 ++
 .../selftests/bpf/progs/xdp_skb_ext_success.c | 245 ++++++++++++++++++
 .../selftests/bpf/progs/xsk_xdp_progs.c       |  13 +
 tools/testing/selftests/bpf/xdp_skb_ext.h     |  15 ++
 10 files changed, 416 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_skb_ext.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_xdp_skb_ext.c
 create mode 100644 tools/testing/selftests/bpf/progs/xdp_skb_ext_failure.c
 create mode 100644 tools/testing/selftests/bpf/progs/xdp_skb_ext_success.c
 create mode 100644 tools/testing/selftests/bpf/xdp_skb_ext.h

diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
index 4549358cc8c2..f0d462a537e3 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
@@ -2461,6 +2461,31 @@ int testapp_xdp_metadata_mb(struct test_spec *test)
 	return testapp_xdp_metadata_copy(test);
 }
 
+/* User space can write the headroom of AF_XDP zero-copy buffers */
+int testapp_xdp_skb_ext_store(struct test_spec *test)
+{
+	struct xsk_xdp_progs *skel_rx = test->ifobj_rx->xdp_progs;
+	struct xsk_xdp_progs *skel_tx = test->ifobj_tx->xdp_progs;
+	int expected = test->mode == TEST_MODE_ZC ? -EOPNOTSUPP : 0;
+	int ret;
+
+	test_spec_set_xdp_prog(test, skel_rx->progs.xsk_xdp_skb_ext_store,
+			       skel_tx->progs.xsk_xdp_skb_ext_store,
+			       skel_rx->maps.xsk, skel_tx->maps.xsk);
+
+	ret = testapp_validate_traffic(test);
+	if (ret)
+		return ret;
+
+	if (skel_rx->bss->store_ret != expected) {
+		ksft_print_msg("[%s] expected store result [%d], got [%d]\n",
+			       __func__, expected, skel_rx->bss->store_ret);
+		return TEST_FAILURE;
+	}
+
+	return TEST_PASS;
+}
+
 int testapp_hw_sw_min_ring_size(struct test_spec *test)
 {
 	int ret;
diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.h b/tools/testing/selftests/bpf/prog_tests/test_xsk.h
index 03753ddc5dcd..6f13440438b8 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xsk.h
+++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.h
@@ -268,6 +268,7 @@ int testapp_xdp_metadata(struct test_spec *test);
 int testapp_xdp_metadata_mb(struct test_spec *test);
 int testapp_xdp_prog_cleanup(struct test_spec *test);
 int testapp_xdp_shared_umem(struct test_spec *test);
+int testapp_xdp_skb_ext_store(struct test_spec *test);
 
 void *worker_testapp_validate_rx(void *arg);
 void *worker_testapp_validate_tx(void *arg);
@@ -293,6 +294,7 @@ static const struct test_spec tests[] = {
 	{.name = "XDP_SHARED_UMEM", .test_func = testapp_xdp_shared_umem},
 	{.name = "XDP_METADATA_COPY", .test_func = testapp_xdp_metadata},
 	{.name = "XDP_METADATA_COPY_MULTI_BUFF", .test_func = testapp_xdp_metadata_mb},
+	{.name = "XDP_SKB_EXT_STORE", .test_func = testapp_xdp_skb_ext_store},
 	{.name = "ALIGNED_INV_DESC_MULTI_BUFF", .test_func = testapp_aligned_inv_desc_mb},
 	{.name = "TOO_MANY_FRAGS", .test_func = testapp_too_many_frags},
 	{.name = "XDP_ADJUST_TAIL_SHRINK", .test_func = testapp_adjust_tail_shrink},
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_pull_data.c b/tools/testing/selftests/bpf/prog_tests/xdp_pull_data.c
index 910dabe95afd..570fef579f8b 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_pull_data.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_pull_data.c
@@ -81,7 +81,8 @@ static void run_test(struct test_xdp_pull_data *skel, int retval,
 
 	skel->bss->data_len = data_len;
 	if (pull_len & PULL_MAX) {
-		int headroom = XDP_PACKET_HEADROOM - meta_len - skel->bss->xdpf_sz;
+		int headroom = XDP_PACKET_HEADROOM - meta_len -
+			       skel->bss->xdpf_sz - skel->bss->ext_sz;
 		int tailroom = frame_sz - XDP_PACKET_HEADROOM -
 			       data_len - skel->bss->sinfo_sz;
 
@@ -170,6 +171,15 @@ static void test_xdp_pull_data_basic(void)
 	run_test(skel, XDP_DROP, pg_sz, buff_len, 0, max_data_len,
 		 PULL_MAX | PULL_PLUS_ONE);
 
+	skel->bss->ext_sz = skel->bss->hash_ext_sz;
+
+	/* multi-buf pkt, hash stored, no tailroom, pull requires memmove */
+	run_test(skel, XDP_PASS, pg_sz, buff_len, 0, max_data_len, PULL_MAX);
+
+	/* multi-buf pkt, hash stored, no tailroom */
+	run_test(skel, XDP_DROP, pg_sz, buff_len, 0, max_data_len,
+		 PULL_MAX | PULL_PLUS_ONE);
+
 out:
 	test_xdp_pull_data__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_skb_ext.c b/tools/testing/selftests/bpf/prog_tests/xdp_skb_ext.c
new file mode 100644
index 000000000000..bd36e22e22a6
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_skb_ext.c
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include <network_helpers.h>
+#include "test_xdp_skb_ext.skel.h"
+#include "xdp_skb_ext_success.skel.h"
+#include "xdp_skb_ext_failure.skel.h"
+
+/* The area of a reused page is not valid for the next packet */
+static void test_live_frames(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts,
+		    .data_in = &pkt_v4,
+		    .data_size_in = sizeof(pkt_v4),
+		    .flags = BPF_F_TEST_XDP_LIVE_FRAMES,
+		    .repeat = 256,
+	);
+	struct test_xdp_skb_ext *skel;
+	int prog_fd;
+
+	skel = test_xdp_skb_ext__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "test_xdp_skb_ext__open_and_load"))
+		return;
+
+	prog_fd = bpf_program__fd(skel->progs.live_frames);
+	if (!ASSERT_OK(bpf_prog_test_run_opts(prog_fd, &opts), "test_run"))
+		goto out;
+	ASSERT_GT(skel->bss->reused_ok, 0, "reused_ok");
+	ASSERT_EQ(skel->bss->reused_bad, 0, "reused_bad");
+	ASSERT_EQ(skel->bss->store_err, 0, "store_err");
+out:
+	test_xdp_skb_ext__destroy(skel);
+}
+
+void test_xdp_skb_ext(void)
+{
+	RUN_TESTS(xdp_skb_ext_success);
+	RUN_TESTS(xdp_skb_ext_failure);
+
+	if (test__start_subtest("live_frames"))
+		test_live_frames();
+}
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_pull_data.c b/tools/testing/selftests/bpf/progs/test_xdp_pull_data.c
index c41a21413eaa..49c8f4bb91f7 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_pull_data.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_pull_data.c
@@ -7,6 +7,8 @@ int xdpf_sz;
 int sinfo_sz;
 int data_len;
 int pull_len;
+int ext_sz;
+int hash_ext_sz;
 
 #define XDP_PACKET_HEADROOM 256
 
@@ -14,6 +16,8 @@ SEC("xdp.frags")
 int xdp_find_sizes(struct xdp_md *ctx)
 {
 	xdpf_sz = sizeof(struct xdp_frame);
+	hash_ext_sz = sizeof(struct xdp_skb_ext) +
+		      sizeof(struct xdp_skb_ext_hash);
 	sinfo_sz = __PAGE_SIZE - XDP_PACKET_HEADROOM -
 		   (ctx->data_end - ctx->data);
 
@@ -31,6 +35,9 @@ int xdp_pull_data_prog(struct xdp_md *ctx)
 	if (data_len != data_end - data)
 		return XDP_DROP;
 
+	if (ext_sz && bpf_xdp_skb_ext_store_rx_hash(ctx, 0, XDP_RSS_TYPE_NONE))
+		return XDP_DROP;
+
 	err = bpf_xdp_pull_data(ctx, pull_len);
 	if (err)
 		return XDP_DROP;
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_skb_ext.c b/tools/testing/selftests/bpf/progs/test_xdp_skb_ext.c
new file mode 100644
index 000000000000..e072e051af48
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_xdp_skb_ext.c
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <vmlinux.h>
+#include "xdp_skb_ext.h"
+#include <bpf/bpf_endian.h>
+#include <bpf/bpf_helpers.h>
+
+/* Written to the first byte of the packet. A reused page keeps it. */
+#define MARK_STORED 0xaa
+
+int reused_ok, reused_bad, store_err;
+
+SEC("xdp")
+int live_frames(struct xdp_md *ctx)
+{
+	__u8 *mark = (void *)(long)ctx->data;
+
+	if (mark + 1 > (__u8 *)(long)ctx->data_end)
+		return XDP_DROP;
+	/* A reused page: MAX_META_LEN fits only if its area was reset */
+	if (*mark == MARK_STORED) {
+		if (bpf_xdp_adjust_meta(ctx, -MAX_META_LEN)) {
+			reused_bad++;
+		} else {
+			reused_ok++;
+			bpf_xdp_adjust_meta(ctx, MAX_META_LEN);
+		}
+	}
+	if (bpf_xdp_skb_ext_store_rx_hash(ctx, 1, XDP_RSS_TYPE_L4_IPV4_TCP) ||
+	    bpf_xdp_skb_ext_store_rx_vlan(ctx, bpf_htons(ETH_P_8021Q), 1) ||
+	    bpf_xdp_skb_ext_store_rx_csum(ctx, XDP_CHECKSUM_UNNECESSARY,
+					  SKB_MAX_CSUM_LEVEL))
+		store_err++;
+
+	mark = (void *)(long)ctx->data;
+	if (mark + 1 > (__u8 *)(long)ctx->data_end)
+		return XDP_DROP;
+	*mark = MARK_STORED;
+	return XDP_DROP;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/xdp_skb_ext_failure.c b/tools/testing/selftests/bpf/progs/xdp_skb_ext_failure.c
new file mode 100644
index 000000000000..d6030a2da236
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/xdp_skb_ext_failure.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+/* The kfuncs are only for XDP programs */
+SEC("tc")
+__failure
+__msg("calling kernel function bpf_xdp_skb_ext_store_rx_hash is not allowed")
+int store_from_tc(struct __sk_buff *skb)
+{
+	return bpf_xdp_skb_ext_store_rx_hash((struct xdp_md *)skb, 1,
+					     XDP_RSS_TYPE_L4_IPV4_TCP);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/xdp_skb_ext_success.c b/tools/testing/selftests/bpf/progs/xdp_skb_ext_success.c
new file mode 100644
index 000000000000..158882f91c54
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/xdp_skb_ext_success.c
@@ -0,0 +1,245 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <vmlinux.h>
+#include "xdp_skb_ext.h"
+#include <errno.h>
+#include <bpf/bpf_endian.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+#define HDR_SZ 4
+#define HASH_SZ 8
+#define VLAN_SZ 4
+#define CSUM_SZ 4
+#define EXT_SZ (HDR_SZ + HASH_SZ + VLAN_SZ + CSUM_SZ)
+
+static int store_hash(struct xdp_md *ctx)
+{
+	return bpf_xdp_skb_ext_store_rx_hash(ctx, 1, XDP_RSS_TYPE_L4_IPV4_TCP);
+}
+
+static int store_vlan(struct xdp_md *ctx)
+{
+	return bpf_xdp_skb_ext_store_rx_vlan(ctx, bpf_htons(ETH_P_8021Q), 1);
+}
+
+static int store_csum(struct xdp_md *ctx)
+{
+	return bpf_xdp_skb_ext_store_rx_csum(ctx, XDP_CHECKSUM_UNNECESSARY,
+					     SKB_MAX_CSUM_LEVEL);
+}
+
+static int store_all(struct xdp_md *ctx)
+{
+	int ret;
+
+	ret = store_hash(ctx);
+	if (!ret)
+		ret = store_vlan(ctx);
+	if (!ret)
+		ret = store_csum(ctx);
+	return ret;
+}
+
+/* Leave @len bytes of headroom above data_meta */
+static int leave_headroom(struct xdp_md *ctx, int len)
+{
+	return bpf_xdp_adjust_meta(ctx, -(MAX_META_LEN - len));
+}
+
+/*
+ * The test run copies data_meta out, so give the room back. Not inlined:
+ * clang would read ctx through a modified ctx pointer, which the verifier
+ * rejects.
+ */
+static __noinline int restore_meta(struct xdp_md *ctx, int ret)
+{
+	bpf_xdp_adjust_meta(ctx, ctx->data - ctx->data_meta);
+	return ret;
+}
+
+/* A second store of the same id takes the same place */
+SEC("xdp")
+__success __retval(0)
+int store_same_id(struct xdp_md *ctx)
+{
+	int ret;
+
+	ret = store_all(ctx);
+	if (!ret)
+		ret = store_hash(ctx);
+	if (!ret)
+		ret = leave_headroom(ctx, EXT_SZ);
+	return restore_meta(ctx, ret);
+}
+
+SEC("xdp")
+__success __retval(-EINVAL)
+int adjust_meta_into_area(struct xdp_md *ctx)
+{
+	int ret;
+
+	ret = store_all(ctx);
+	if (!ret)
+		ret = leave_headroom(ctx, EXT_SZ - CSUM_SZ);
+	return restore_meta(ctx, ret);
+}
+
+SEC("xdp")
+__success __retval(0)
+int adjust_head_to_area(struct xdp_md *ctx)
+{
+	int ret;
+
+	ret = store_all(ctx);
+	if (!ret)
+		ret = bpf_xdp_adjust_head(ctx, -(MAX_META_LEN - EXT_SZ));
+	if (!ret)
+		bpf_xdp_adjust_head(ctx, MAX_META_LEN - EXT_SZ);
+	return ret;
+}
+
+SEC("xdp")
+__success __retval(-EINVAL)
+int adjust_head_into_area(struct xdp_md *ctx)
+{
+	int ret;
+
+	ret = store_all(ctx);
+	if (!ret)
+		ret = bpf_xdp_adjust_head(ctx, -(MAX_META_LEN - EXT_SZ + 1));
+	return ret;
+}
+
+SEC("xdp")
+__success __retval(-EINVAL)
+int csum_complete(struct xdp_md *ctx)
+{
+	return bpf_xdp_skb_ext_store_rx_csum(ctx, XDP_CHECKSUM_COMPLETE, 0);
+}
+
+SEC("xdp")
+__success __retval(-EINVAL)
+int csum_none_level1(struct xdp_md *ctx)
+{
+	return bpf_xdp_skb_ext_store_rx_csum(ctx, XDP_CHECKSUM_NONE, 1);
+}
+
+SEC("xdp")
+__success __retval(-EINVAL)
+int csum_level_too_big(struct xdp_md *ctx)
+{
+	return bpf_xdp_skb_ext_store_rx_csum(ctx, XDP_CHECKSUM_UNNECESSARY,
+					     SKB_MAX_CSUM_LEVEL + 1);
+}
+
+SEC("xdp")
+__success __retval(-EINVAL)
+int vlan_bad_proto(struct xdp_md *ctx)
+{
+	return bpf_xdp_skb_ext_store_rx_vlan(ctx, bpf_htons(0x1234), 1);
+}
+
+SEC("xdp")
+__success __retval(-EINVAL)
+int del_bad_id(struct xdp_md *ctx)
+{
+	return bpf_xdp_skb_ext_del(ctx, XDP_SKB_EXT_NUM);
+}
+
+/* Failed calls do not create the area */
+SEC("xdp")
+__success __retval(0)
+int einval_no_area(struct xdp_md *ctx)
+{
+	bpf_xdp_skb_ext_store_rx_csum(ctx, XDP_CHECKSUM_COMPLETE, 0);
+	bpf_xdp_skb_ext_store_rx_vlan(ctx, bpf_htons(0x1234), 1);
+	bpf_xdp_skb_ext_del(ctx, XDP_SKB_EXT_NUM);
+	return restore_meta(ctx, leave_headroom(ctx, 0));
+}
+
+SEC("xdp")
+__success __retval(0)
+int enospc_smaller_fits(struct xdp_md *ctx)
+{
+	int ret;
+
+	ret = leave_headroom(ctx, HDR_SZ + VLAN_SZ);
+	if (!ret && store_hash(ctx) != -ENOSPC)
+		ret = -1;
+	if (!ret)
+		ret = store_vlan(ctx);
+	return restore_meta(ctx, ret);
+}
+
+SEC("xdp")
+__success __retval(-ENOSPC)
+int enospc_full(struct xdp_md *ctx)
+{
+	int ret;
+
+	ret = leave_headroom(ctx, HDR_SZ + VLAN_SZ);
+	if (!ret)
+		ret = store_vlan(ctx);
+	if (!ret)
+		ret = store_csum(ctx);
+	return restore_meta(ctx, ret);
+}
+
+/* Without the area, a delete must not write where the header would be */
+SEC("xdp")
+__success __retval(0)
+int del_no_area(struct xdp_md *ctx)
+{
+	__u32 *meta;
+	int ret;
+
+	if (leave_headroom(ctx, 0))
+		return -1;
+	meta = (void *)(long)ctx->data_meta;
+	if (meta + 1 > (__u32 *)(long)ctx->data)
+		return restore_meta(ctx, -1);
+	*meta = ~0U;
+	ret = bpf_xdp_skb_ext_del(ctx, XDP_SKB_EXT_HASH);
+	meta = (void *)(long)ctx->data_meta;
+	if (meta + 1 > (__u32 *)(long)ctx->data)
+		return restore_meta(ctx, -1);
+	if (!ret && *meta != ~0U)
+		ret = -1;
+	return restore_meta(ctx, ret);
+}
+
+/* A delete does not shrink the area */
+SEC("xdp")
+__success __retval(-ENOSPC)
+int del_keeps_area(struct xdp_md *ctx)
+{
+	int ret;
+
+	ret = leave_headroom(ctx, HDR_SZ + HASH_SZ);
+	if (!ret)
+		ret = store_hash(ctx);
+	if (!ret)
+		ret = bpf_xdp_skb_ext_del(ctx, XDP_SKB_EXT_HASH);
+	if (!ret)
+		ret = store_vlan(ctx);
+	return restore_meta(ctx, ret);
+}
+
+/* A deleted entry keeps its place */
+SEC("xdp")
+__success __retval(0)
+int del_reuse(struct xdp_md *ctx)
+{
+	int ret;
+
+	ret = leave_headroom(ctx, HDR_SZ + HASH_SZ);
+	if (!ret)
+		ret = store_hash(ctx);
+	if (!ret)
+		ret = bpf_xdp_skb_ext_del(ctx, XDP_SKB_EXT_HASH);
+	if (!ret)
+		ret = store_hash(ctx);
+	return restore_meta(ctx, ret);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c b/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c
index 023d8befd4ca..103f1469b4d6 100644
--- a/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c
+++ b/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c
@@ -3,6 +3,7 @@
 
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
+#include <bpf/bpf_endian.h>
 #include <linux/if_ether.h>
 #include <linux/ip.h>
 #include <linux/errno.h>
@@ -18,6 +19,10 @@ struct {
 static unsigned int idx;
 int adjust_value = 0;
 int count = 0;
+int store_ret;
+
+extern int bpf_xdp_skb_ext_store_rx_vlan(struct xdp_md *ctx, __be16 vlan_proto,
+					 __u16 vlan_tci) __ksym;
 
 SEC("xdp.frags") int xsk_def_prog(struct xdp_md *xdp)
 {
@@ -58,6 +63,14 @@ SEC("xdp.frags") int xsk_xdp_populate_metadata(struct xdp_md *xdp)
 	return bpf_redirect_map(&xsk, 0, XDP_DROP);
 }
 
+SEC("xdp.frags") int xsk_xdp_skb_ext_store(struct xdp_md *xdp)
+{
+	store_ret = bpf_xdp_skb_ext_store_rx_vlan(xdp,
+						  bpf_htons(ETH_P_8021Q), 0);
+
+	return bpf_redirect_map(&xsk, 0, XDP_DROP);
+}
+
 SEC("xdp") int xsk_xdp_shared_umem(struct xdp_md *xdp)
 {
 	void *data = (void *)(long)xdp->data;
diff --git a/tools/testing/selftests/bpf/xdp_skb_ext.h b/tools/testing/selftests/bpf/xdp_skb_ext.h
new file mode 100644
index 000000000000..540ba7c6aa1b
--- /dev/null
+++ b/tools/testing/selftests/bpf/xdp_skb_ext.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#pragma once
+
+#ifndef ETH_P_8021Q
+#define ETH_P_8021Q 0x8100
+#endif
+
+#ifndef XDP_PACKET_HEADROOM
+#define XDP_PACKET_HEADROOM 256
+#endif
+
+/* Metadata in BPF_PROG_RUN must be this size or smaller */
+#define MAX_META_LEN (XDP_PACKET_HEADROOM - (int)sizeof(struct xdp_frame))
+
+#define SKB_MAX_CSUM_LEVEL 3
-- 
2.56.0

