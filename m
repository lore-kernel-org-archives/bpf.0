Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795098512;
	b=quW1Bin0kz3MkQrghSzqt/ynd827L3Q1JSd5+uQXV/PYjkn78A0sCbszneSgXEu73XUx
	 csk3ug9kQDJlOS+ZJESyB3UnwwTSRx1WDrejedkYQelZ2OTVPGc5DLGJ1oxGQgPhjoMmg
	 qEWcmzYx26x90d/FFt7GZ95wUFJpiSB5c6rmPrfcm2yPKv1Dt/lwTomat5TPWj8LIuJ2b
	 vE+wJrhKsiveLWuZoJhsag993ct2nZ0+mBplsXro+9zD5r9bR5DeC9oRZ6iz4nUBdm+1i
	 OqCSlmmD5VbCGCrh6GLNoTZSlwEH+XuJ9LDmy5ngPktNbYdCTuarv0sU2GuYgBu79aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795098512;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=yS9PkcupkmBUULWAOgY91rTcBOMVHLv9wSEvkbIJlRQ=;
	b=eLVaZj7DP5RIFhwsTnKl5o5Tvz1V39TrntkqSoZ2XwpATvpSBNygvyyq8xqUNmxvi82d
	 UpMLple7G2Ib1Syy1GtHTe1jEmQ0V5BdWnzVpknm9RDXxNN1dKOmn3ovsi6B/5vTSCuFr
	 yBg07IUMHiJjGdeKlP+7v4zGeDTNr5Tg6WjZiPogxAEvr6LNaUF7owCPG28u8MI8uNxKG
	 gFCGlm9Q/NnNnVZ2jBMs+L9qDc1TS07ifYrKx7DMnEbrwCtvHQNwnh3RJXQ7N4/81ifGV
	 5XAg3o5WWLU2wTXH88oCrcJXQKYe558vMd1Yw0G4JYANphYryEmFw0+C5dQ7xtxZqUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=blackwall.org;
	spf=none smtp.mailfrom=blackwall.org;
	dkim=pass header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=ApVtSKFr;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422FD606A324
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 14:28:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 422FD606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=ApVtSKFr
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4a358881793so1232738f8f.0
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 06:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1795098510; x=1795703310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yS9PkcupkmBUULWAOgY91rTcBOMVHLv9wSEvkbIJlRQ=;
        b=ApVtSKFra7sw7tiiYo9X03xJs85sE7B87SraN/6FwsDodVmmqBgBU2lkpEEPuR0MDa
         bUMuBMYC6oVinV445pL5r99GdV5XwGViBZduWTaiT8Y5bbxqvFJ49I1HQuy2go8/MOMz
         LuYKs3Q6DiLYdE2MR1931FUzl2ddquTOH+KI3mwDALIKIgn+R3kH4p91HTbzD1hKhjvc
         O/WO4M23XpQnWNxhEQuvMsXi9e4cBPc6Ps4sG8KbQlO/rad9NKTbJd/Nhma3q4KlDwAp
         U9HBUtZionIA+SQNuFYNhu5qsImYpwE1PZeMTt2TzjO/TgyHrP2HyKxA80OdFg1gAdV/
         VQMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795098510; x=1795703310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yS9PkcupkmBUULWAOgY91rTcBOMVHLv9wSEvkbIJlRQ=;
        b=hzwIiMQ6spkMb+KG6z4E9gqXXOIueI667Yx5K4Bm4znxaPmAWC+sDonffBBk+Te1Rm
         xDqoWe0Q+0ENM1rVRU9qphCA1pi7x0jm4zhqX19vLsD/a0ttFY769jtsMMorJfU9CHyi
         2nEVwDtUGwl3dX5uAloK3ereQzIojqPZlP0qEcO1z2CnXiDlLtISN0JBxq+XDvu8iqvp
         A1s/8Dai1wLbPKlUeQi0htbmjjykDEFOvop5WkEBlAqFhXI7cay5ezBo9lA7ALHMGiq1
         ODV4ZoZXoEhiWQa0CsnSrVAy/1RoVDjA8Kcy0MpCRPqMOfGy5fs6Pnyux2CM8MQB4UdA
         9KyQ==
X-Gm-Message-State: APuU4Z/98yaJTWXmEFfZPRcxgPDdVeslXJ5PzM8QbjWdxrYOh45jjUMP
	Qw/hoiYYrl+ZCJAkM2gxmjKPfPLB7XUp2uScKyiUG9R6W/kAuPPx+itqm3/zzvZvwkKbINFJVDl
	EaVV/YLG3Gb6F
X-Gm-Gg: AZFdTZdYHw7IedCA+XD3ohQbPKZ8BwtTDf577KBxr5YmQYzjdhfJoLR2qcXot1aRPPC
	Y8ajCIXPjJQ0JZ8ysGp0ydsifjokOop/lTIHEAak9ghbVIPl6r/6VWmn2ALrWp+U3rxFYYFj7y/
	F+HPJZynAdSlB2Z93Ms5M1xu4CKcBRnpg2XuudNgzv4Ty/ytJwslbtspAFKSo8bBawGPpIuwsTa
	7uSD4RS7EbpH4U+NXmHDJOdn3sS22jUe+Bq0c8wRSkx2gIITfdMDZHV0DtZrMuDIaQecrFTYfKi
	h0qJ9gIQnkP9z1P1PsYj93dbzc9BA6vSxkvZl5w5iLF5WTv3UO1wJETt2ecNxOma7lLPy6FIfAm
	AsigZ6T5Fncb/Ale/T3GznQFQjcUFiivn3xRmn6OXfYXic3dAVQoIfTi7z8INd4k9Ll5h/dHm4f
	MjqVJ3WAQGkW5fZeSujTs2n7ot7XAXCDBhWAYPqvGR4k8R0YAIG+CgfT5z5bPCknVDl2vXWFlcm
	cNGzH6HfbEbjqCUGVxFJfSJsLhmiH1aoBMNE44yIDpXZgGySzu7xyjJgva8YjRGpmLn7WI0Ahab
	+VOjvQYxgSlco+ODIaN52WM83zRXEc4Av3u1Llqka35vUcKVnxg=
X-Received: by 2002:a05:6000:4b1e:b0:48d:f39b:83de with SMTP id ffacd0b85a97d-4a6346da7f5mr12970665f8f.3.1795098509534;
        Thu, 19 Nov 2026 06:28:29 -0800 (PST)
Received: from localhost (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4ab53e891d8sm130120f8f.10.2026.11.19.06.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 06:28:28 -0800 (PST)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: bpf@vger.kernel.org
Cc: Nikolay Aleksandrov <razor@blackwall.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Paul Chaignon <paul@isovalent.com>,
	Alasdair McWilliam <alasdair.mcwilliam@isovalent.com>
Subject: [PATCH bpf-next 8/8] selftests/bpf: Check assigned socket lifetime across queues and drops
Date: Thu, 19 Nov 2026 16:22:30 +0200
Message-ID: <20261119142231.2612515-9-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261119142231.2612515-1-razor@blackwall.org>
References: <20261119142231.2612515-1-razor@blackwall.org>
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

Exercise assignment across redirects, drops, classic BPF actions and
NFQUEUE, including queued SYN retransmissions.

Keep listeners open while tracing socket puts and checking queued skb
ownership. Use a local CO-RE queue type. Call tracing requires a non-LTO
kernel with dynamic ftrace and BPF trampolines. The tracing subtests do
not support i386 or MIPS64.
Use nft and tc for setup. Skip missing address families, tools and
explicitly disabled prerequisites; fail unexpected setup errors.

Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
CC: Alexei Starovoitov <ast@kernel.org>
CC: Daniel Borkmann <daniel@iogearbox.net>
CC: Andrii Nakryiko <andrii@kernel.org>
CC: Eduard Zingerman <eddyz87@gmail.com>
CC: Kumar Kartikeya Dwivedi <memxor@gmail.com>
CC: Martin KaFai Lau <martin.lau@linux.dev>
CC: Song Liu <song@kernel.org>
CC: Yonghong Song <yonghong.song@linux.dev>
CC: Jiri Olsa <jolsa@kernel.org>
CC: Emil Tsalapatis <emil@etsalapatis.com>
CC: Ihor Solodrai <ihor.solodrai@linux.dev>
CC: Paul Chaignon <paul@isovalent.com>
CC: Alasdair McWilliam <alasdair.mcwilliam@isovalent.com>

 tools/testing/selftests/bpf/config            |   5 +
 .../selftests/bpf/prog_tests/assign_reuse.c   | 357 ++++++++++++++++++
 .../bpf/prog_tests/sk_assign_netkit.c         | 296 ++++++++++++++-
 .../selftests/bpf/progs/sk_assign_lifetime.c  | 182 +++++++++
 .../selftests/bpf/progs/sk_assign_netkit.c    |  16 +
 .../selftests/bpf/progs/test_assign_reuse.c   |  45 ++-
 tools/testing/selftests/bpf/unpriv_helpers.c  |  16 +
 tools/testing/selftests/bpf/unpriv_helpers.h  |   2 +
 8 files changed, 910 insertions(+), 9 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/sk_assign_lifetime.c

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index 30b744844ef5..c3daa319fe5b 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -59,6 +59,7 @@ CONFIG_LIRC=y
 CONFIG_LIVEPATCH=y
 CONFIG_LWTUNNEL=y
 CONFIG_LWTUNNEL_BPF=y
+CONFIG_MEMBARRIER=y
 CONFIG_MEMCG=y
 CONFIG_MODULE_SIG=y
 CONFIG_MODULE_SRCVERSION_ALL=y
@@ -69,6 +70,7 @@ CONFIG_MPLS=y
 CONFIG_MPLS_IPTUNNEL=y
 CONFIG_MPLS_ROUTING=y
 CONFIG_MPTCP=y
+CONFIG_NET_ACT_BPF=y
 CONFIG_NET_ACT_GACT=y
 CONFIG_NET_ACT_MIRRED=y
 CONFIG_NET_ACT_SKBMOD=y
@@ -87,6 +89,7 @@ CONFIG_NET_SCH_BPF=y
 CONFIG_NET_SCH_FQ=y
 CONFIG_NET_SCH_INGRESS=y
 CONFIG_NET_SCH_HTB=y
+CONFIG_NET_SCH_PLUG=y
 CONFIG_NET_SCH_RED=y
 CONFIG_NET_SCHED=y
 CONFIG_NETDEVSIM=y
@@ -114,7 +117,9 @@ CONFIG_NETFILTER_XTABLES_LEGACY=y
 CONFIG_NF_FLOW_TABLE=y
 CONFIG_NF_FLOW_TABLE_INET=y
 CONFIG_NETFILTER_NETLINK=y
+CONFIG_NETFILTER_NETLINK_QUEUE=y
 CONFIG_NFT_FLOW_OFFLOAD=y
+CONFIG_NFT_QUEUE=y
 CONFIG_IP_NF_IPTABLES=y
 CONFIG_IP6_NF_IPTABLES=y
 CONFIG_IP6_NF_FILTER=y
diff --git a/tools/testing/selftests/bpf/prog_tests/assign_reuse.c b/tools/testing/selftests/bpf/prog_tests/assign_reuse.c
index 7b19193ed3d7..b4e77836b28d 100644
--- a/tools/testing/selftests/bpf/prog_tests/assign_reuse.c
+++ b/tools/testing/selftests/bpf/prog_tests/assign_reuse.c
@@ -3,12 +3,17 @@
 #include <uapi/linux/if_link.h>
 #include <test_progs.h>
 #include <stdint.h>
+#include <net/if.h>
+#include <linux/membarrier.h>
+#include <linux/pkt_sched.h>
 
 #include <netinet/tcp.h>
 #include <netinet/udp.h>
 
 #include "network_helpers.h"
+#include "unpriv_helpers.h"
 #include "test_assign_reuse.skel.h"
+#include "sk_assign_lifetime.skel.h"
 
 #define NS_TEST "assign_reuse"
 #define LOOPBACK 1
@@ -391,6 +396,339 @@ static void run_assign_reuse(int family, int sotype, const char *ip, __u16 port,
 	free_fds(fd_sv, nr_listens);
 }
 
+static struct sk_assign_lifetime *open_release_trace(int server)
+{
+	static const char * const targets[] = { "sock_pfree_ref", "sock_gen_put" };
+	struct sk_assign_lifetime *lifetime;
+	int ret, i;
+
+	if (!kernel_config_has("CONFIG_LTO_NONE=y")) {
+		printf("SKIP: release call tracing requires a confirmed non-LTO kernel\n");
+		test__skip();
+		return NULL;
+	}
+	if (!kernel_config_has("CONFIG_DYNAMIC_FTRACE=y")) {
+		printf("SKIP: release call tracing requires dynamic ftrace\n");
+		test__skip();
+		return NULL;
+	}
+	for (i = 0; i < ARRAY_SIZE(targets); i++) {
+		ret = libbpf_find_vmlinux_btf_id(targets[i], BPF_TRACE_FENTRY);
+		if (ret <= 0) {
+			printf("SKIP: %s tracing is unavailable\n", targets[i]);
+			test__skip();
+			return NULL;
+		}
+	}
+	lifetime = sk_assign_lifetime__open();
+	if (!ASSERT_NEQ(lifetime, NULL, "lifetime_open"))
+		return NULL;
+	lifetime->rodata->release_cookie = cookie(server);
+	bpf_program__set_autoload(lifetime->progs.queue_enter, false);
+	bpf_program__set_autoload(lifetime->progs.queue_observe, false);
+	if (!ASSERT_OK(sk_assign_lifetime__load(lifetime), "lifetime_load") ||
+	    !ASSERT_OK(sk_assign_lifetime__attach(lifetime), "lifetime_attach")) {
+		sk_assign_lifetime__destroy(lifetime);
+		return NULL;
+	}
+	return lifetime;
+}
+
+static bool wait_for_release(struct sk_assign_lifetime *lifetime, __u64 packets)
+{
+	int i;
+
+	for (i = 0; i < POLL_RETRIES; i++) {
+		if (__atomic_load_n(&lifetime->bss->released_packets,
+				    __ATOMIC_ACQUIRE) >= packets)
+			break;
+		usleep(POLL_INTERVAL_US);
+	}
+	return ASSERT_EQ(lifetime->bss->released_packets, packets,
+			 "released_packets") &&
+	       ASSERT_EQ(lifetime->bss->release_errors, 0, "release_errors");
+}
+
+static bool action_setup_ok(int err, const char *feature)
+{
+	if (err == -ENOENT || err == -EOPNOTSUPP) {
+		printf("SKIP: %s is unavailable\n", feature);
+		test__skip();
+		return false;
+	}
+	return ASSERT_OK(err, feature);
+}
+
+static void run_assign_redirect(int family, const char *ip, bool egress,
+				bool drop)
+{
+	bool hook_created = false, tc_attached = false;
+	struct sk_assign_lifetime *lifetime = NULL;
+	DECLARE_LIBBPF_OPTS(bpf_tc_hook, rx_hook,
+		.ifindex = LOOPBACK,
+		.attach_point = BPF_TC_INGRESS,
+	);
+	DECLARE_LIBBPF_OPTS(bpf_tc_hook, tc_hook,
+		.ifindex = LOOPBACK,
+		.attach_point = egress ? BPF_TC_EGRESS : BPF_TC_INGRESS,
+	);
+	DECLARE_LIBBPF_OPTS(bpf_tc_opts, tc_opts,
+		.handle = 1,
+		.priority = 1,
+	);
+	struct test_assign_reuse *skel = NULL;
+	bool rx_attached = false;
+	const int zero = 0;
+	int server = -1;
+	int ret, i, j;
+	__u64 fd_val;
+
+	if (!setup_family(family))
+		goto cleanup;
+	skel = test_assign_reuse__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		goto cleanup;
+	skel->rodata->dest_port = PORT;
+	skel->rodata->check_redirect = true;
+	skel->rodata->drop_after_assign = drop;
+	if (!ASSERT_OK(test_assign_reuse__load(skel), "skel_load"))
+		goto cleanup;
+	server = start_server(family, SOCK_DGRAM, ip, PORT, IO_TIMEOUT_MS);
+	if (!ASSERT_GE(server, 0, "start_server"))
+		goto cleanup;
+	fd_val = server;
+	ret = bpf_map_update_elem(bpf_map__fd(skel->maps.sk_map),
+				  &zero, &fd_val, BPF_NOEXIST);
+	if (!ASSERT_OK(ret, "sk_map_update"))
+		goto cleanup;
+	if (egress) {
+		lifetime = open_release_trace(server);
+		if (!lifetime)
+			goto cleanup;
+	}
+	ret = bpf_tc_hook_create(&tc_hook);
+	if (!ret)
+		hook_created = true;
+	if (!action_setup_ok(ret == -EEXIST ? 0 : ret, "bpf_tc_hook_create"))
+		goto cleanup;
+	tc_opts.prog_fd = bpf_program__fd(skel->progs.tc_main);
+	if (!action_setup_ok(bpf_tc_attach(&tc_hook, &tc_opts), "bpf_tc_attach"))
+		goto cleanup;
+	tc_attached = true;
+	if (egress && !drop) {
+		tc_opts.prog_id = 0;
+		if (!action_setup_ok(bpf_tc_attach(&rx_hook, &tc_opts),
+				     "attach_observer"))
+			goto cleanup;
+		rx_attached = true;
+	}
+	for (i = 0; i < TEST_ITERATIONS; i++) {
+		ASSERT_EQ(echo_test_udp(server), EAGAIN, "packet_dropped");
+		for (j = 0; j < POLL_RETRIES; j++) {
+			if (__atomic_load_n(&skel->bss->completed_packets,
+					    __ATOMIC_ACQUIRE) >= i + 1)
+				break;
+			usleep(POLL_INTERVAL_US);
+		}
+		if (!ASSERT_EQ(skel->bss->completed_packets, i + 1,
+			       "observer_completed"))
+			goto cleanup;
+		if (egress && !wait_for_release(lifetime, i + 1))
+			goto cleanup;
+		ASSERT_EQ(skel->bss->assign_calls, i + 1, "assign_calls");
+		ASSERT_EQ(skel->bss->assign_errors, 0, "assign_errors");
+		ASSERT_EQ(skel->bss->redirected_packets, drop ? 0 : i + 1,
+			  "redirected_packets");
+		ASSERT_EQ(skel->bss->redirected_sockets,
+			  egress && !drop ? i + 1 : 0, "redirected_sockets");
+	}
+cleanup:
+	if (rx_attached) {
+		tc_opts.flags = 0;
+		tc_opts.prog_fd = 0;
+		tc_opts.prog_id = 0;
+		ASSERT_OK(bpf_tc_detach(&rx_hook, &tc_opts), "detach_observer");
+	}
+	if (tc_attached) {
+		tc_opts.flags = 0;
+		tc_opts.prog_fd = 0;
+		tc_opts.prog_id = 0;
+		ASSERT_OK(bpf_tc_detach(&tc_hook, &tc_opts), "bpf_tc_detach");
+	}
+	if (hook_created) {
+		tc_hook.attach_point = BPF_TC_INGRESS | BPF_TC_EGRESS;
+		bpf_tc_hook_destroy(&tc_hook);
+	}
+	sk_assign_lifetime__destroy(lifetime);
+	test_assign_reuse__destroy(skel);
+	if (server >= 0)
+		close(server);
+}
+
+static int action_filter_add(const char *pin_path, bool egress, bool redirect)
+{
+	const char *direction = egress ? "egress" : "ingress";
+	const char *filter = "tc filter add dev lo";
+	const char *next;
+	char action[128];
+
+	snprintf(action, sizeof(action), "action bpf object-pinned %s pipe",
+		 pin_path);
+	if (!egress)
+		next = "action mirred egress redirect dev assign_dummy";
+	else
+		next = redirect ? "" : action;
+	return SYS_NOFAIL("%s %s protocol all pref 1 handle 1 matchall %s %s",
+			  filter, direction, action, next);
+}
+
+static void run_assign_action(bool egress, bool redirect)
+{
+	bool lo_created = false, device = false, plug_created = false;
+	DECLARE_LIBBPF_OPTS(bpf_tc_hook, plug_hook,
+		.attach_point = BPF_TC_QDISC,
+		.parent = TC_H_ROOT,
+		.qdisc = "plug",
+	);
+	struct sk_assign_lifetime *lifetime = NULL;
+	DECLARE_LIBBPF_OPTS(bpf_tc_hook, lo_hook,
+		.ifindex = LOOPBACK,
+		.attach_point = BPF_TC_INGRESS | BPF_TC_EGRESS,
+	);
+	DECLARE_LIBBPF_OPTS(bpf_tc_hook, hook,
+		.attach_point = BPF_TC_EGRESS,
+	);
+	DECLARE_LIBBPF_OPTS(bpf_tc_opts, opts,
+		.handle = 1,
+		.priority = 1,
+	);
+	struct test_assign_reuse *skel = NULL;
+	bool prog_pinned = false;
+	char pin_path[64];
+	int server = -1;
+	__u64 fd_val;
+	int zero = 0;
+	int ret, i;
+
+	if (!setup_family(AF_INET))
+		return;
+	if (SYS_NOFAIL("tc -V")) {
+		printf("Missing required tc tool\n");
+		test__skip();
+		return;
+	}
+	if (kernel_config_disabled("CONFIG_NET_CLS_MATCHALL") ||
+	    kernel_config_disabled("CONFIG_NET_ACT_BPF") ||
+	    (!egress && (kernel_config_disabled("CONFIG_NET_ACT_MIRRED") ||
+			 kernel_config_disabled("CONFIG_DUMMY")))) {
+		printf("SKIP: classic TC action prerequisites are disabled\n");
+		test__skip();
+		return;
+	}
+	if (!egress) {
+		ret = syscall(__NR_membarrier, MEMBARRIER_CMD_QUERY, 0, 0);
+		if ((ret < 0 && errno == ENOSYS) ||
+		    (ret >= 0 && !(ret & MEMBARRIER_CMD_GLOBAL))) {
+			printf("SKIP: global membarrier is unavailable\n");
+			test__skip();
+			return;
+		}
+		if (!ASSERT_GE(ret, 0, "membarrier_query"))
+			return;
+	}
+	ret = bpf_tc_hook_create(&lo_hook);
+	if (!action_setup_ok(ret, "clsact"))
+		goto cleanup;
+	lo_created = true;
+	if (!egress) {
+		SYS(cleanup, "ip link add assign_dummy type dummy");
+		device = true;
+		SYS(cleanup, "ip link set assign_dummy up");
+		hook.ifindex = if_nametoindex("assign_dummy");
+		plug_hook.ifindex = hook.ifindex;
+		if (!action_setup_ok(bpf_tc_hook_create(&plug_hook), "plug"))
+			goto cleanup;
+		plug_created = true;
+		if (!action_setup_ok(bpf_tc_hook_create(&hook), "observer_clsact"))
+			goto cleanup;
+	} else {
+		hook.ifindex = LOOPBACK;
+		hook.attach_point = BPF_TC_INGRESS;
+	}
+	skel = test_assign_reuse__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		goto cleanup;
+	skel->rodata->dest_port = PORT;
+	skel->rodata->classic_action = true;
+	skel->rodata->redirect_action = redirect;
+	skel->rodata->pass_observer = !egress;
+	skel->rodata->check_redirect = true;
+	if (!ASSERT_OK(test_assign_reuse__load(skel), "skel_load"))
+		goto cleanup;
+	server = start_server(AF_INET, SOCK_DGRAM, "127.0.0.1", PORT,
+			      IO_TIMEOUT_MS);
+	if (!ASSERT_GE(server, 0, "start_server"))
+		goto cleanup;
+	fd_val = server;
+	if (!ASSERT_OK(bpf_map_update_elem(bpf_map__fd(skel->maps.sk_map),
+					   &zero, &fd_val, BPF_NOEXIST), "sk_map_update"))
+		goto cleanup;
+	if (egress) {
+		lifetime = open_release_trace(server);
+		if (!lifetime)
+			goto cleanup;
+	}
+	if (!egress || redirect) {
+		opts.prog_fd = bpf_program__fd(skel->progs.tc_main);
+		if (!action_setup_ok(bpf_tc_attach(&hook, &opts), "observer_attach"))
+			goto cleanup;
+	}
+	snprintf(pin_path, sizeof(pin_path), "/sys/fs/bpf/sk_assign_action_%d",
+		 getpid());
+	ret = bpf_program__pin(skel->progs.action_assign, pin_path);
+	if (!ASSERT_OK(ret, "pin_action"))
+		goto cleanup;
+	prog_pinned = true;
+	if (!ASSERT_OK(action_filter_add(pin_path, egress, redirect),
+		       "action_filter_add"))
+		goto cleanup;
+	if (!ASSERT_EQ(echo_test_udp(server), EAGAIN, "packet_not_delivered"))
+		goto cleanup;
+	for (i = 0; i < POLL_RETRIES; i++) {
+		if (__atomic_load_n(&skel->bss->completed_packets, __ATOMIC_ACQUIRE))
+			break;
+		usleep(POLL_INTERVAL_US);
+	}
+	if (!ASSERT_EQ(skel->bss->completed_packets, 1, "observer_completed") ||
+	    !ASSERT_EQ(skel->bss->assign_calls, 1, "assign_calls") ||
+	    !ASSERT_EQ(skel->bss->assign_errors, 0, "assign_errors") ||
+	    !ASSERT_EQ(skel->bss->redirected_sockets, egress, "assigned_socket"))
+		goto cleanup;
+	if (egress && !wait_for_release(lifetime, 1))
+		goto cleanup;
+	if (!ASSERT_OK(bpf_map_delete_elem(bpf_map__fd(skel->maps.sk_map), &zero),
+		       "sk_map_delete"))
+		goto cleanup;
+	close(server);
+	server = -1;
+	if (!egress && !ASSERT_OK(kern_sync_rcu(), "sync_rcu"))
+		goto cleanup;
+cleanup:
+	if (prog_pinned)
+		ASSERT_OK(bpf_program__unpin(skel->progs.action_assign, pin_path),
+			  "unpin_action");
+	if (plug_created)
+		ASSERT_OK(bpf_tc_hook_destroy(&plug_hook), "plug_destroy");
+	if (lo_created)
+		ASSERT_OK(bpf_tc_hook_destroy(&lo_hook), "clsact_destroy");
+	if (device)
+		SYS_NOFAIL("ip link del assign_dummy");
+	sk_assign_lifetime__destroy(lifetime);
+	if (server >= 0)
+		close(server);
+	test_assign_reuse__destroy(skel);
+}
+
 void test_assign_reuse(void)
 {
 	struct nstoken *tok = NULL;
@@ -418,6 +756,25 @@ void test_assign_reuse(void)
 		run_assign_reuse(AF_INET, SOCK_DGRAM, "127.0.0.1", PORT, true);
 	if (test__start_subtest("udpv6_egress"))
 		run_assign_reuse(AF_INET6, SOCK_DGRAM, "::1", PORT, true);
+	if (test__start_subtest("ipv4_ingress_redirect"))
+		run_assign_redirect(AF_INET, "127.0.0.1", false, false);
+	if (test__start_subtest("ipv6_ingress_redirect"))
+		run_assign_redirect(AF_INET6, "::1", false, false);
+	if (test__start_subtest("ipv4_egress_redirect"))
+		run_assign_redirect(AF_INET, "127.0.0.1", true, false);
+	if (test__start_subtest("ipv6_egress_redirect"))
+		run_assign_redirect(AF_INET6, "::1", true, false);
+	if (test__start_subtest("ipv4_egress_drop"))
+		run_assign_redirect(AF_INET, "127.0.0.1", true, true);
+	if (test__start_subtest("ipv6_egress_drop"))
+		run_assign_redirect(AF_INET6, "::1", true, true);
+
+	if (test__start_subtest("classic_action_mirred"))
+		run_assign_action(false, false);
+	if (test__start_subtest("classic_action_egress_pipe"))
+		run_assign_action(true, false);
+	if (test__start_subtest("classic_action_egress_redirect"))
+		run_assign_action(true, true);
 
 cleanup:
 	close_netns(tok);
diff --git a/tools/testing/selftests/bpf/prog_tests/sk_assign_netkit.c b/tools/testing/selftests/bpf/prog_tests/sk_assign_netkit.c
index eb2dd03b923e..17e414efa6e7 100644
--- a/tools/testing/selftests/bpf/prog_tests/sk_assign_netkit.c
+++ b/tools/testing/selftests/bpf/prog_tests/sk_assign_netkit.c
@@ -3,9 +3,15 @@
 #include <netinet/tcp.h>
 #include <uapi/linux/if_link.h>
 #include <test_progs.h>
+#include <stdint.h>
+#include <linux/netfilter.h>
+#include <linux/netfilter/nfnetlink.h>
+#include <linux/netfilter/nfnetlink_queue.h>
 #include "netlink_helpers.h"
 #include "network_helpers.h"
+#include "unpriv_helpers.h"
 #include "sk_assign_netkit.skel.h"
+#include "sk_assign_lifetime.skel.h"
 
 #define NS_HOST "sk_assign_host"
 #define NS_POD "sk_assign_pod"
@@ -18,6 +24,14 @@
 #define IO_TIMEOUT_MS 1000
 #define POLL_RETRIES 5000
 #define POLL_INTERVAL_US 1000
+#define QUEUE_TIMEOUT_MS 5000
+#define QUEUE_CLIENT_TIMEOUT_MS 10000
+
+struct queue_request {
+	struct nlmsghdr n;
+	struct nfgenmsg g;
+	char buf[512];
+};
 
 struct netkit_request {
 	struct nlmsghdr n;
@@ -25,6 +39,238 @@ struct netkit_request {
 	char buf[1024];
 };
 
+struct queue_worker {
+	struct sk_assign_lifetime *skel;
+	__u64 *measurement_done;
+	__u64 *blocked_syns;
+	pthread_t thread;
+	bool wait_retransmit;
+	int reference_errors;
+	int error;
+	int fd;
+};
+
+static int queue_config(int fd, int type, const void *data, int len)
+{
+	struct sockaddr_nl addr = { .nl_family = AF_NETLINK };
+	struct queue_request req = {
+		.n.nlmsg_len = NLMSG_LENGTH(sizeof(struct nfgenmsg)),
+		.n.nlmsg_type = (NFNL_SUBSYS_QUEUE << 8) | NFQNL_MSG_CONFIG,
+		.n.nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK,
+		.g.version = NFNETLINK_V0,
+	};
+	struct nlmsgerr *err;
+	char reply[512];
+	int ret;
+
+	addattr_l(&req.n, sizeof(req), type, data, len);
+	ret = sendto(fd, &req, req.n.nlmsg_len, 0, (void *)&addr, sizeof(addr));
+	if (ret < 0)
+		return -errno;
+	ret = recv(fd, reply, sizeof(reply), 0);
+	if (ret < 0)
+		return -errno;
+	if (ret < NLMSG_LENGTH(sizeof(*err)))
+		return -EIO;
+	if (((struct nlmsghdr *)reply)->nlmsg_type != NLMSG_ERROR)
+		return -EPROTO;
+	err = NLMSG_DATA((struct nlmsghdr *)reply);
+	return err->error;
+}
+
+static int queue_open(void)
+{
+	struct nfqnl_msg_config_cmd cmd = { .command = NFQNL_CFG_CMD_BIND };
+	struct sockaddr_nl addr = { .nl_family = AF_NETLINK };
+	struct nfqnl_msg_config_params params = {
+		.copy_range = htonl(UINT16_MAX),
+		.copy_mode = NFQNL_COPY_PACKET,
+	};
+	int fd, err;
+
+	fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_NETFILTER);
+	if (fd < 0)
+		return -errno;
+	if (bind(fd, (void *)&addr, sizeof(addr)) ||
+	    settimeo(fd, QUEUE_TIMEOUT_MS)) {
+		err = -errno;
+		goto out;
+	}
+	err = queue_config(fd, NFQA_CFG_CMD, &cmd, sizeof(cmd));
+	if (err)
+		goto out;
+	err = queue_config(fd, NFQA_CFG_PARAMS, &params, sizeof(params));
+	if (!err)
+		return fd;
+out:
+	close(fd);
+	return err;
+}
+
+static bool queue_tracing_target(struct bpf_program *prog, const char *name)
+{
+	int err;
+
+	err = bpf_program__set_attach_target(prog, 0, name);
+	if (err == -ESRCH || err == -ENOENT) {
+		printf("SKIP: %s BTF is unavailable\n", name);
+		test__skip();
+		return false;
+	}
+	return ASSERT_OK(err, "tracing_target");
+}
+
+static void *queue_verdict(void *arg)
+{
+	struct nfqnl_msg_verdict_hdr verdict = { .verdict = htonl(NF_ACCEPT) };
+	struct sockaddr_nl addr = { .nl_family = AF_NETLINK };
+	struct queue_worker *worker = arg;
+	struct nfqnl_msg_packet_hdr *hdr;
+	struct queue_request req = {
+		.n.nlmsg_len = NLMSG_LENGTH(sizeof(struct nfgenmsg)),
+		.n.nlmsg_type = (NFNL_SUBSYS_QUEUE << 8) | NFQNL_MSG_VERDICT,
+		.n.nlmsg_flags = NLM_F_REQUEST,
+		.g.version = NFNETLINK_V0,
+	};
+	char buf[UINT16_MAX + 1];
+	__u32 errors, mark = 0;
+	struct nlmsghdr *nlh;
+	bool packet = false;
+	struct rtattr *attr;
+	int fd, ret, len, i;
+
+	ret = recv(worker->fd, buf, sizeof(buf), 0);
+	if (ret < 0) {
+		worker->error = -errno;
+		return NULL;
+	}
+	nlh = (void *)buf;
+	if (!NLMSG_OK(nlh, ret) ||
+	    nlh->nlmsg_type != ((NFNL_SUBSYS_QUEUE << 8) | NFQNL_MSG_PACKET)) {
+		worker->error = -EPROTO;
+		return NULL;
+	}
+	len = nlh->nlmsg_len - NLMSG_LENGTH(sizeof(struct nfgenmsg));
+	attr = (void *)((char *)NLMSG_DATA(nlh) +
+		       NLMSG_ALIGN(sizeof(struct nfgenmsg)));
+	for (; RTA_OK(attr, len); attr = RTA_NEXT(attr, len)) {
+		switch (attr->rta_type & NLA_TYPE_MASK) {
+		case NFQA_PACKET_HDR:
+			if (RTA_PAYLOAD(attr) < sizeof(*hdr))
+				goto invalid;
+			hdr = RTA_DATA(attr);
+			verdict.id = hdr->packet_id;
+			packet = true;
+			break;
+		case NFQA_MARK:
+			if (RTA_PAYLOAD(attr) != sizeof(mark))
+				goto invalid;
+			memcpy(&mark, RTA_DATA(attr), sizeof(mark));
+			mark = ntohl(mark);
+			break;
+		}
+	}
+	if (!packet || !mark)
+		goto invalid;
+	if (worker->wait_retransmit) {
+		for (i = 0; i < POLL_RETRIES; i++) {
+			if (__atomic_load_n(worker->blocked_syns, __ATOMIC_RELAXED))
+				break;
+			usleep(POLL_INTERVAL_US);
+		}
+		if (i == POLL_RETRIES)
+			worker->error = -ETIMEDOUT;
+	}
+	fd = bpf_map__fd(worker->skel->maps.observed);
+	ret = bpf_map_lookup_elem(fd, &mark, &errors);
+	if (ret) {
+		worker->error = -errno;
+	} else {
+		worker->reference_errors = errors;
+		if (bpf_map_delete_elem(fd, &mark))
+			worker->error = -errno;
+	}
+	__atomic_store_n(worker->measurement_done, 1, __ATOMIC_RELEASE);
+	addattr_l(&req.n, sizeof(req), NFQA_VERDICT_HDR, &verdict, sizeof(verdict));
+	ret = sendto(worker->fd, &req, req.n.nlmsg_len, 0,
+		     (void *)&addr, sizeof(addr));
+	if (ret < 0)
+		worker->error = -errno;
+	return NULL;
+invalid:
+	worker->error = -EPROTO;
+	return NULL;
+}
+
+static bool setup_nfqueue(struct sk_assign_netkit *skel,
+			  struct queue_worker *worker, int server, int family,
+			  bool retransmit)
+{
+	const char *nft_family = family == AF_INET ? "ip" : "ip6";
+	socklen_t cookie_len = sizeof(__u64);
+	struct sk_assign_lifetime *lifetime;
+	__u64 cookie;
+
+	if (!kernel_config_has("CONFIG_LTO_NONE=y")) {
+		printf("SKIP: queue tracing requires a confirmed non-LTO kernel\n");
+		test__skip();
+		return false;
+	}
+	if (!kernel_config_has("CONFIG_DYNAMIC_FTRACE=y")) {
+		printf("SKIP: queue tracing requires dynamic ftrace\n");
+		test__skip();
+		return false;
+	}
+	if (kernel_config_disabled("CONFIG_NF_TABLES") ||
+	    kernel_config_disabled("CONFIG_NFT_QUEUE") ||
+	    kernel_config_disabled(family == AF_INET ? "CONFIG_NF_TABLES_IPV4" :
+						    "CONFIG_NF_TABLES_IPV6")) {
+		printf("SKIP: nftables queue or family support is disabled\n");
+		test__skip();
+		return false;
+	}
+	worker->fd = queue_open();
+	if (worker->fd == -EPROTONOSUPPORT || worker->fd == -EOPNOTSUPP ||
+	    worker->fd == -EINVAL) {
+		printf("SKIP: NFQUEUE is unavailable\n");
+		test__skip();
+		return false;
+	}
+	if (!ASSERT_GE(worker->fd, 0, "queue_open"))
+		return false;
+	if (!ASSERT_OK(getsockopt(server, SOL_SOCKET, SO_COOKIE, &cookie,
+				  &cookie_len), "listener_cookie"))
+		return false;
+	worker->skel = sk_assign_lifetime__open();
+	lifetime = worker->skel;
+	if (!ASSERT_OK_PTR(lifetime, "lifetime_open"))
+		return false;
+	lifetime->rodata->listener_cookie = cookie;
+	bpf_program__set_autoload(lifetime->progs.release_enter, false);
+	bpf_program__set_autoload(lifetime->progs.release_exit, false);
+	bpf_program__set_autoload(lifetime->progs.release_put, false);
+	if (!queue_tracing_target(lifetime->progs.queue_enter, "nf_queue") ||
+	    !queue_tracing_target(lifetime->progs.queue_observe,
+				  "nfqnl_enqueue_packet"))
+		return false;
+	if (!ASSERT_OK(sk_assign_lifetime__load(lifetime), "lifetime_load"))
+		return false;
+	if (!ASSERT_OK(sk_assign_lifetime__attach(lifetime), "lifetime_attach"))
+		return false;
+	worker->measurement_done = &skel->bss->measurement_done;
+	worker->blocked_syns = &skel->bss->blocked_syns;
+	worker->wait_retransmit = retransmit;
+	SYS(out, "nft add table %s sk_assign", nft_family);
+	SYS(out, "nft add chain %s sk_assign pre '%s'", nft_family,
+	    "{ type filter hook prerouting priority 0; }");
+	SYS(out, "nft add rule %s sk_assign pre meta mark 1 queue num 0",
+	    nft_family);
+	return ASSERT_OK(pthread_create(&worker->thread, NULL, queue_verdict,
+				       worker), "queue_thread");
+out:
+	return false;
+}
+
 static int create_netkit(void)
 {
 	struct rtattr *linkinfo, *data, *peer_info;
@@ -148,13 +394,16 @@ static int enable_netns_ipv6(const char *name)
 	return err;
 }
 
-static void run_netkit(int family)
+static void run_netkit(int family, bool nfqueue, bool retransmit)
 {
 	const char *dest = family == AF_INET ? "198.18.0.99" : "2001:db8:99::99";
-	struct network_helper_opts client_opts = { .timeout_ms = IO_TIMEOUT_MS };
+	struct queue_worker worker = { .reference_errors = -1, .fd = -1 };
 	const char *bind_addr = family == AF_INET ? "0.0.0.0" : "::";
 	int server = -1, client = -1, accepted = -1;
 	struct netns_obj *host = NULL, *pod = NULL;
+	struct network_helper_opts client_opts = {
+		.timeout_ms = IO_TIMEOUT_MS,
+	};
 	struct sockaddr_storage expected, actual;
 	struct sk_assign_netkit *skel = NULL;
 	struct network_helper_opts opts = {
@@ -165,9 +414,15 @@ static void run_netkit(int family)
 	char buf[sizeof(TEST_DATA) - 1];
 	struct nstoken *pod_tok = NULL;
 	struct bpf_link *link = NULL;
+	bool worker_started = false;
 	socklen_t len, actual_len;
 	int i, err;
 
+	if (nfqueue && SYS_NOFAIL("nft -v")) {
+		printf("Missing required nft tool\n");
+		test__skip();
+		return;
+	}
 	err = socket(family, SOCK_STREAM, 0);
 	if (err < 0 && errno == EAFNOSUPPORT) {
 		printf("SKIP: address family %d is unavailable\n", family);
@@ -224,6 +479,7 @@ static void run_netkit(int family)
 		goto cleanup;
 	skel->rodata->dest_port = DEST_PORT;
 	skel->rodata->proxy_port = PROXY_PORT;
+	skel->rodata->measure_queue = nfqueue;
 	if (!ASSERT_OK(sk_assign_netkit__load(skel), "skel_load"))
 		goto cleanup;
 	link = bpf_program__attach_netkit(skel->progs.assign_socket,
@@ -234,7 +490,14 @@ static void run_netkit(int family)
 		       "make_sockaddr"))
 		goto cleanup;
 
-	for (i = 0; i < TEST_ITERATIONS; i++) {
+	if (nfqueue) {
+		if (!setup_nfqueue(skel, &worker, server, family, retransmit))
+			goto cleanup;
+		worker_started = true;
+		client_opts.timeout_ms = QUEUE_CLIENT_TIMEOUT_MS;
+	}
+
+	for (i = 0; i < (nfqueue ? 1 : TEST_ITERATIONS); i++) {
 		pod_tok = open_netns(NS_POD);
 		if (!ASSERT_NEQ(pod_tok, NULL, "open_pod"))
 			goto cleanup;
@@ -276,12 +539,23 @@ static void run_netkit(int family)
 	}
 	if (!ASSERT_OK(bpf_link__detach(link), "detach_netkit"))
 		goto cleanup;
-	ASSERT_GE(skel->bss->listener_assignments, TEST_ITERATIONS,
-		  "listener_assignments");
+	ASSERT_GE(skel->bss->listener_assignments,
+		  nfqueue ? 1 : TEST_ITERATIONS, "listener_assignments");
 	ASSERT_GT(skel->bss->established_assignments, 0, "established_assignments");
 	ASSERT_GT(skel->bss->request_rejections, 0, "request_rejections");
 	ASSERT_EQ(skel->bss->assign_errors, 0, "assign_errors");
+	if (retransmit)
+		ASSERT_GT(skel->bss->blocked_syns, 0, "retransmitted_syn_blocked");
 cleanup:
+	if (worker_started) {
+		ASSERT_OK(pthread_join(worker.thread, NULL), "queue_join");
+		ASSERT_OK(worker.error, "queue_verdict");
+		ASSERT_EQ(worker.reference_errors, 0, "queue_references");
+		ASSERT_EQ(worker.skel->bss->queue_errors, 0, "queue_map_errors");
+	}
+	if (worker.fd >= 0)
+		close(worker.fd);
+	sk_assign_lifetime__destroy(worker.skel);
 	close_netns(pod_tok);
 	bpf_link__destroy(link);
 	if (accepted >= 0)
@@ -298,7 +572,15 @@ static void run_netkit(int family)
 void test_sk_assign_netkit(void)
 {
 	if (test__start_subtest("tcpv4"))
-		run_netkit(AF_INET);
+		run_netkit(AF_INET, false, false);
 	if (test__start_subtest("tcpv6"))
-		run_netkit(AF_INET6);
+		run_netkit(AF_INET6, false, false);
+	if (test__start_subtest("tcpv4_nfqueue"))
+		run_netkit(AF_INET, true, false);
+	if (test__start_subtest("tcpv6_nfqueue"))
+		run_netkit(AF_INET6, true, false);
+	if (test__start_subtest("tcpv4_nfqueue_retransmit"))
+		run_netkit(AF_INET, true, true);
+	if (test__start_subtest("tcpv6_nfqueue_retransmit"))
+		run_netkit(AF_INET6, true, true);
 }
diff --git a/tools/testing/selftests/bpf/progs/sk_assign_lifetime.c b/tools/testing/selftests/bpf/progs/sk_assign_lifetime.c
new file mode 100644
index 000000000000..619a52e6bc19
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/sk_assign_lifetime.c
@@ -0,0 +1,182 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_core_read.h>
+#include <bpf/bpf_tracing.h>
+
+struct nf_queue_entry___local {
+	struct sk_buff *skb;
+} __attribute__((preserve_access_index));
+
+struct queue_state {
+	__u64 destructor;
+	__u64 sk;
+	__u32 refs;
+	__u32 mark;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 64);
+	__type(key, __u64);
+	__type(value, struct queue_state);
+} queued SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 64);
+	__type(key, __u32);
+	__type(value, __u32);
+} observed SEC(".maps");
+
+struct release_state {
+	__u64 parent;
+	__u64 sk;
+	__u64 puts;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 8);
+	__type(key, __u64);
+	__type(value, struct release_state);
+} releasing SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 8);
+	__type(key, __u64);
+	__type(value, __u64);
+} active_releases SEC(".maps");
+
+const volatile __u64 listener_cookie;
+const volatile __u64 release_cookie;
+__u64 released_packets;
+__u64 release_errors;
+__u64 queue_errors;
+
+static __always_inline bool is_test_listener(struct sock *sk)
+{
+	return sk && listener_cookie &&
+	       BPF_CORE_READ(sk, __sk_common.skc_state) == BPF_TCP_LISTEN &&
+	       BPF_CORE_READ(sk, __sk_common.skc_cookie.counter) == listener_cookie;
+}
+
+SEC("fentry/nf_queue")
+int BPF_PROG(queue_enter, struct sk_buff *skb)
+{
+	struct sock *sk = BPF_CORE_READ(skb, sk);
+	struct queue_state state = {};
+	__u64 key = (__u64)skb;
+
+	if (!is_test_listener(sk))
+		return 0;
+	state.refs = BPF_CORE_READ(sk, __sk_common.skc_refcnt.refs.counter);
+	state.sk = (__u64)sk;
+	state.destructor = (__u64)BPF_CORE_READ(skb, destructor);
+	state.mark = BPF_CORE_READ(skb, mark);
+	if (bpf_map_update_elem(&queued, &key, &state, BPF_NOEXIST))
+		__sync_fetch_and_add(&queue_errors, 1);
+	return 0;
+}
+
+SEC("fentry/nfqnl_enqueue_packet")
+int BPF_PROG(queue_observe, struct nf_queue_entry___local *entry,
+	     unsigned int queuenum)
+{
+	struct sk_buff *skb = BPF_CORE_READ(entry, skb);
+	struct queue_state *before;
+	__u64 key = (__u64)skb;
+	__u32 mark, errors;
+	struct sock *sk;
+	__u32 refs;
+
+	sk = BPF_CORE_READ(skb, sk);
+	if (!is_test_listener(sk))
+		return 0;
+	before = bpf_map_lookup_elem(&queued, &key);
+	if (!before)
+		return 0;
+	refs = BPF_CORE_READ(sk, __sk_common.skc_refcnt.refs.counter);
+	mark = BPF_CORE_READ(skb, mark);
+	errors = before->refs < 2 || refs < 2 ||
+		 (__u64)sk != before->sk || mark != before->mark ||
+		 (__u64)BPF_CORE_READ(skb, destructor) != before->destructor;
+	if (bpf_map_update_elem(&observed, &mark, &errors, BPF_NOEXIST))
+		__sync_fetch_and_add(&queue_errors, 1);
+	bpf_map_delete_elem(&queued, &key);
+	return 0;
+}
+
+SEC("fentry/sock_pfree_ref")
+int BPF_PROG(release_enter, struct sk_buff *skb)
+{
+	struct sock *sk = BPF_CORE_READ(skb, sk);
+	__u64 task = bpf_get_current_task();
+	struct release_state state = {};
+	__u64 key = (__u64)skb;
+	__u64 *parent;
+
+	if (!sk || !release_cookie ||
+	    BPF_CORE_READ(sk, __sk_common.skc_cookie.counter) != release_cookie)
+		return 0;
+	parent = bpf_map_lookup_elem(&active_releases, &task);
+	if (parent)
+		state.parent = *parent;
+	state.sk = (__u64)sk;
+	if (bpf_map_update_elem(&releasing, &key, &state, BPF_NOEXIST)) {
+		__sync_fetch_and_add(&release_errors, 1);
+		return 0;
+	}
+	if (bpf_map_update_elem(&active_releases, &task, &key, BPF_ANY)) {
+		__sync_fetch_and_add(&release_errors, 1);
+		bpf_map_delete_elem(&releasing, &key);
+	}
+	return 0;
+}
+
+SEC("fentry/sock_gen_put")
+int BPF_PROG(release_put, struct sock *sk)
+{
+	__u64 task = bpf_get_current_task();
+	struct release_state *state;
+	__u64 *key;
+
+	key = bpf_map_lookup_elem(&active_releases, &task);
+	if (!key)
+		return 0;
+	state = bpf_map_lookup_elem(&releasing, key);
+	if (state && state->sk == (__u64)sk)
+		state->puts++;
+	return 0;
+}
+
+SEC("fexit/sock_pfree_ref")
+int BPF_PROG(release_exit, struct sk_buff *skb)
+{
+	__u64 task = bpf_get_current_task();
+	struct release_state *before;
+	__u64 key = (__u64)skb;
+	__u64 increment = 1;
+	int ret;
+
+	before = bpf_map_lookup_elem(&releasing, &key);
+	if (!before)
+		return 0;
+	if (before->puts != 1)
+		__sync_fetch_and_add(&release_errors, 1);
+	if (before->parent)
+		ret = bpf_map_update_elem(&active_releases, &task,
+					  &before->parent, BPF_EXIST);
+	else
+		ret = bpf_map_delete_elem(&active_releases, &task);
+	if (ret)
+		__sync_fetch_and_add(&release_errors, 1);
+	if (bpf_map_delete_elem(&releasing, &key))
+		__sync_fetch_and_add(&release_errors, 1);
+	asm volatile("%0 = atomic_fetch_add((u64 *)(%1 + 0), %0);"
+		     : "+r"(increment) : "r"(&released_packets) : "memory");
+	return 0;
+}
+
+char LICENSE[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/sk_assign_netkit.c b/tools/testing/selftests/bpf/progs/sk_assign_netkit.c
index 766f21d11772..ba9e31d1437d 100644
--- a/tools/testing/selftests/bpf/progs/sk_assign_netkit.c
+++ b/tools/testing/selftests/bpf/progs/sk_assign_netkit.c
@@ -12,10 +12,14 @@
 
 const volatile __u16 dest_port;
 const volatile __u16 proxy_port;
+const volatile bool measure_queue;
 __u64 listener_assignments;
 __u64 established_assignments;
 __u64 assign_errors;
 __u64 request_rejections;
+__u64 measurement_started;
+__u64 measurement_done;
+__u64 blocked_syns;
 struct bpf_sock_tuple probe_tuple;
 __u32 probe_len;
 __u32 probe_state;
@@ -64,6 +68,18 @@ int assign_socket(struct __sk_buff *skb)
 	}
 	if (th + 1 > data_end || th->dest != bpf_htons(dest_port))
 		return TCX_PASS;
+	if (measure_queue) {
+		skb->mark = 0;
+		if (th->syn && !th->ack) {
+			if (__sync_val_compare_and_swap(&measurement_started, 0, 1)) {
+				__sync_fetch_and_add(&blocked_syns, 1);
+				return TCX_DROP;
+			}
+			skb->mark = 1;
+		} else if (!__sync_val_compare_and_swap(&measurement_done, 0, 0)) {
+			return TCX_DROP;
+		}
+	}
 	if (ipv4) {
 		tuple.ipv4.sport = th->source;
 		tuple.ipv4.dport = th->dest;
diff --git a/tools/testing/selftests/bpf/progs/test_assign_reuse.c b/tools/testing/selftests/bpf/progs/test_assign_reuse.c
index 9098fe4707ff..5e77161dc81b 100644
--- a/tools/testing/selftests/bpf/progs/test_assign_reuse.c
+++ b/tools/testing/selftests/bpf/progs/test_assign_reuse.c
@@ -26,8 +26,16 @@ union {
 
 const volatile __u16 dest_port;
 const volatile bool select_sock;
+const volatile bool classic_action;
+const volatile bool redirect_action;
+const volatile bool pass_observer;
+const volatile bool check_redirect;
+const volatile bool drop_after_assign;
 __u64 assign_calls;
 __u64 assign_errors;
+__u64 redirected_packets;
+__u64 redirected_sockets;
+__u64 completed_packets;
 
 struct {
 	__u64 expected_cookie;
@@ -165,6 +173,20 @@ assign_sk(struct __sk_buff *skb, typeof(exchanges[0]) *exchange)
 	bpf_sk_release(sk);
 	if (ret)
 		return TC_ACT_SHOT;
+	if (classic_action) {
+		skb->mark = 1;
+		if (redirect_action)
+			return bpf_redirect(skb->ifindex, BPF_F_INGRESS);
+		return TC_ACT_PIPE;
+	}
+	if (check_redirect) {
+		if (drop_after_assign) {
+			__sync_lock_test_and_set(&completed_packets, assign_calls);
+			return TC_ACT_SHOT;
+		}
+		skb->mark = 1;
+		return bpf_redirect(skb->ifindex, BPF_F_INGRESS);
+	}
 	if (select_sock)
 		return bpf_redirect(skb->ifindex, BPF_F_INGRESS);
 	return TC_ACT_OK;
@@ -212,13 +234,20 @@ maybe_assign_udp(struct __sk_buff *skb, struct udphdr *uh)
 	return assign_sk(skb, exchange);
 }
 
-SEC("tc")
-int tc_main(struct __sk_buff *skb)
+static __always_inline int process_packet(struct __sk_buff *skb)
 {
 	void *data_end = (void *)(long)skb->data_end;
 	void *data = (void *)(long)skb->data;
 	struct ethhdr *eth;
 
+	if (check_redirect && skb->mark == 1) {
+		__sync_fetch_and_add(&redirected_packets, 1);
+		if (skb->sk)
+			__sync_fetch_and_add(&redirected_sockets, 1);
+		__sync_lock_test_and_set(&completed_packets, redirected_packets);
+		return pass_observer ? TC_ACT_OK : TC_ACT_SHOT;
+	}
+
 	eth = (struct ethhdr *)(data);
 	if (eth + 1 > data_end)
 		return TC_ACT_SHOT;
@@ -249,3 +278,15 @@ int tc_main(struct __sk_buff *skb)
 			return TC_ACT_SHOT;
 	}
 }
+
+SEC("tc")
+int tc_main(struct __sk_buff *skb)
+{
+	return process_packet(skb);
+}
+
+SEC("action")
+int action_assign(struct __sk_buff *skb)
+{
+	return process_packet(skb);
+}
diff --git a/tools/testing/selftests/bpf/unpriv_helpers.c b/tools/testing/selftests/bpf/unpriv_helpers.c
index c8dd5d848584..0743bdd416f4 100644
--- a/tools/testing/selftests/bpf/unpriv_helpers.c
+++ b/tools/testing/selftests/bpf/unpriv_helpers.c
@@ -70,6 +70,22 @@ static int config_contains(const char *pat)
 	return 0;
 }
 
+bool kernel_config_has(const char *entry)
+{
+	return config_contains(entry) == 1;
+}
+
+bool kernel_config_disabled(const char *name)
+{
+	char pattern[128];
+	int ret;
+
+	ret = snprintf(pattern, sizeof(pattern), "# %s is not set", name);
+	if (ret < 0 || ret >= sizeof(pattern))
+		return false;
+	return kernel_config_has(pattern);
+}
+
 static bool cmdline_contains(const char *pat)
 {
 	int fd, cnt, ret = false;
diff --git a/tools/testing/selftests/bpf/unpriv_helpers.h b/tools/testing/selftests/bpf/unpriv_helpers.h
index c24d53e14f3a..13758872b7f1 100644
--- a/tools/testing/selftests/bpf/unpriv_helpers.h
+++ b/tools/testing/selftests/bpf/unpriv_helpers.h
@@ -4,6 +4,8 @@
 
 #define UNPRIV_SYSCTL "kernel/unprivileged_bpf_disabled"
 
+bool kernel_config_has(const char *entry);
+bool kernel_config_disabled(const char *name);
 bool get_unpriv_disabled(void);
 bool get_unpriv_sysctl_disabled(void);
 bool get_unpriv_mitigations_disabled(void);
-- 
2.47.3

