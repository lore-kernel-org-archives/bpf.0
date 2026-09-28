Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127A04AEBE5
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 11:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790595634; cv=none; b=V49MdYDFAAgxt9pvJisU3mMEafI13EM0CHn9tDPu7YneAVq+WhKiXp5fv6oiAhySC9TdzVihY6JifxgIqkPS479TcmOMvo/XJXTQq2zWIueP1iDN9gQ/YnyilLb8dTMKzmCiPuG3zSKozWb8Ar+wvkoiQf6lc4npAUFd1aNV2Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790595634; c=relaxed/simple;
	bh=rgstUqMT4KZ0czW9meFMULds8Vo4NDqrHrPJMCwUK/o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k/Dfn6ZZXQlJ5aJ+O56HO6YWorgaAs0C2YXZyN+UZwvHlS6Lo92Qp8FWD4X+wNWlz5XB5JFAdOfpzvW+LT3bYrrwC90OR0sn4gQZWRKswcjozKnrsZjv6aY0dBZG7udNNLZZ5RXAqTZyG/e9Lt6+4QyaHlnpuDsGbB4ro86F874=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=N8lSzttV; arc=none smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="N8lSzttV"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a605c198fdso4586586a12.2
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 04:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1790595630; x=1791200430; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zvZ48sAxF/8N/0BbFvVBsZDDiPIt+ro9tL/tJPEMiuA=;
        b=N8lSzttV5fInR/UjbHAW/d1ixCITcD6fgsRmEP1eIGA+tMrAUun6/3A4Oa7KzhlQ8C
         AkKeKhykhHsYuUg6NWCclYiDNlguZa9MmBY3+nIwLUyG0xOQV2b1VE0aIsl0LL8jgmie
         YAAUsawb+zAyO8kF8TRH8rf/WZqfT40+yc1PXkMEfY+NOQOrI++Nqurjbep87VT/l5Wv
         QgUUTwvw5bAZr9axjye9XEeMxLu8iUzleZLdo8cX6WGSwRxW9Jnhi6FP5dOruz2q/hr6
         v46B6ZZOrtHwUslKIvpl/5YEO7mSBrZujlHuKvFsXp72C8gIew98G8nDiY0zO/ZQxF2m
         HtWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790595630; x=1791200430;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zvZ48sAxF/8N/0BbFvVBsZDDiPIt+ro9tL/tJPEMiuA=;
        b=VHQAaNqacNdeyrb1X/pn9R5ABRVu/xpaWDtBeqwnzrt8QtepYG9CW5n0pZcPe7a7Ko
         esZDa5y4z3F/ZFSU0mt+TMeHWoZDryXg9XXLgRCLugBQHwlSXQD7+q4l3XeKF6BK+JLk
         vB3Ngc035yj6xtSOJM24Fdpkhj1uvKIyforw+3EIsG6D4zdH60quWtIGpN6VhTlXcC7J
         3QHvya7S0bU32dKSjovipZSxwumotsxnxHIsSQm8n2AQjOnrY/4qAlBSA0egyx/IzgAu
         Ey57oLHxbclNJwuZtvZ73H2ZuDLmgYsMo9SvL36hpypROsRV4SBz0IzXN4SneGp9v1Zb
         Q7mA==
X-Gm-Message-State: AFuF++koRlPQTCZwmOXQOAvyS+el0gOqHW0p50PYuqVt4H2jda4lXxC0
	WHPtspmwjlvU8bXzPWFdDtZehGjaT4kOwb7eABw+0MqmcPh4Oe5ITs6sBY9Fyw9A85k=
X-Gm-Gg: AYBFou2V5x7hRY4oGmaK2xUnKPJRtL34W6cWfI5zp7jgOAHKdZWi5JFSQN4zFnkM2Yk
	+fNqyVg51cgpGVLtjoikqNRectLSkMUswpI0rwAtO3yHwrlJhPPqcAPi/VFKCUJkCZ2yMnJNnm6
	6Y7wfftIeDhcKWJYq5/K+VnCnFutlZcw2bjXNy494aZ7n7zCfkzWssKHOQ3nYR/cjrKXrWHcCJX
	Ge+gGm5s6pCigUEwBmlx8IY5sxQZcOuWc2GDJSLnoRYHhONW49gtOd0iZJ+NSXxTbj85KXPXOnj
	v79MfKnRS+ggKfNT7A0WPuLHLBxIRKMbZ50TyJhG6PL/hIE23uUFs6ypVoMU1atrQT/Ul2BrlFG
	OjQPyMSZY9ciLrizbgTU/BHRtEBWuig5285cRDhG90qcVmkVOtaczUw0D8rF0ec0txDkohOnNoG
	NgyKCO+Xf9MUwRBs0K4x2JrR5MUtYLIcPGZ38DQKd5MspLeIhYA5MXztj+P+N7cVOsm/uwawmZU
	ddnHXOkNulB2xde2Qg7kP4iitvUBkmU+yTtCJGR4nbWHS+2eb6CF0Ms6S6NCgD/VPc93fm3uxeV
	I5OO2rmUHqa2
X-Received: by 2002:a17:907:c602:20b0:c2a:fcf5:c6b4 with SMTP id a640c23a62f3a-c2afcf5f0b1mr400518266b.49.1790595630108;
        Mon, 28 Sep 2026 04:40:30 -0700 (PDT)
Received: from cloudflare.com (2a01-110f-491b-1300-c0dd-2af4-566b-b23f.aa.ipv6.supernova.orange.pl. [2a01:110f:491b:1300:c0dd:2af4:566b:b23f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2dc70bb213sm218313666b.43.2026.09.28.04.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 04:40:29 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 28 Sep 2026 13:40:22 +0200
Subject: [PATCH net-next 05/15] selftests/bpf: Basic tests for metadata
 passing with gated skb tracepoints
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-bpf-meta-gated-tracepoints-v1-5-844dbf3e1edf@cloudflare.com>
References: <20260928-bpf-meta-gated-tracepoints-v1-0-844dbf3e1edf@cloudflare.com>
In-Reply-To: <20260928-bpf-meta-gated-tracepoints-v1-0-844dbf3e1edf@cloudflare.com>
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
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
X-Mailer: b4 0.16.0

Cover metadata passing where test programs stash per-packet metadata in a
hash map (meta_map) keyed by the skb address, tag packets as traced with
bpf_trace_skb(), propagate entries from the tp_btf/skb_copy tracepoint, and
reclaim them from the raw_tp/skb_free tracepoint:

- write_read: stash metadata at tap ingress, read it back on the same hook
  after a device round trip, and verify the free tracepoint drained the
  meta_map
- clone_read: metadata stashed at tap ingress is readable from a mirred
  clone (tc mirror to a dummy device) - the copy tracepoint propagates the
  entry to the clone, and the free tracepoint reaps both

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 tools/testing/selftests/bpf/config                 |   2 +
 .../bpf/prog_tests/xdp_context_test_run.c          | 165 ++++++++++++++++++++-
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  |  83 +++++++++++
 3 files changed, 245 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index ea7044f30adc..692909b28d3a 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -7,6 +7,7 @@ CONFIG_BPF_JIT=y
 CONFIG_BPF_KPROBE_OVERRIDE=y
 CONFIG_BPF_LIRC_MODE2=y
 CONFIG_BPF_LSM=y
+CONFIG_SKB_GATED_TRACEPOINTS=y
 CONFIG_BPF_STREAM_PARSER=y
 CONFIG_BPF_SYSCALL=y
 # CONFIG_BPF_UNPRIV_DEFAULT_OFF is not set
@@ -136,3 +137,4 @@ CONFIG_SMC_HS_CTRL_BPF=y
 CONFIG_DIBS=y
 CONFIG_DIBS_LO=y
 CONFIG_PM_WAKELOCKS=y
+CONFIG_NET_SCH_NETEM=y
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
index 448807676176..c9b115c14acb 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -16,6 +16,7 @@
 #define DUMMY_NAME "dum0"
 #define TAP_NETNS "xdp_context_tuntap"
 #define LWT_NETNS "xdp_context_lwt"
+#define SKB_TRACE_NETNS "skb_trace_tuntap"
 
 #define TEST_PAYLOAD_LEN 32
 static const __u8 test_payload[TEST_PAYLOAD_LEN] = {
@@ -331,10 +332,11 @@ void test_xdp_context_veth(void)
 	netns_free(tx_ns);
 }
 
-static void test_tuntap(struct bpf_program *xdp_prog,
-			struct bpf_program *tc_prio_1_prog,
-			struct bpf_program *tc_prio_2_prog,
-			bool *test_pass)
+static void __test_tuntap(const char *nsname,
+			  struct bpf_program *xdp_prog,
+			  struct bpf_program *tc_prio_1_prog,
+			  struct bpf_program *tc_prio_2_prog,
+			  bool *test_pass)
 {
 	LIBBPF_OPTS(bpf_tc_hook, tc_hook, .attach_point = BPF_TC_INGRESS);
 	LIBBPF_OPTS(bpf_tc_opts, tc_opts, .handle = 1, .priority = 1);
@@ -345,7 +347,7 @@ static void test_tuntap(struct bpf_program *xdp_prog,
 
 	*test_pass = false;
 
-	ns = netns_new(TAP_NETNS, true);
+	ns = netns_new(nsname, true);
 	if (!ASSERT_OK_PTR(ns, "create and open ns"))
 		return;
 
@@ -396,6 +398,15 @@ static void test_tuntap(struct bpf_program *xdp_prog,
 	netns_free(ns);
 }
 
+static void test_tuntap(struct bpf_program *xdp_prog,
+			struct bpf_program *tc_prio_1_prog,
+			struct bpf_program *tc_prio_2_prog,
+			bool *test_pass)
+{
+	__test_tuntap(TAP_NETNS, xdp_prog, tc_prio_1_prog, tc_prio_2_prog,
+		      test_pass);
+}
+
 /* Write a packet to a tap dev and copy it to ingress of a dummy dev */
 static void test_tuntap_mirred(struct bpf_program *xdp_prog,
 			       struct bpf_program *tc_prog,
@@ -693,3 +704,147 @@ void test_xdp_context_lwt_encap(void)
 
 	test_xdp_meta__destroy(skel);
 }
+
+/* Assert that the free tracepoint prog drained the metadata stash */
+static void assert_meta_stash_empty(struct bpf_map *meta_map)
+{
+	struct bpf_map_info info = {};
+	__u32 info_len = sizeof(info);
+
+	if (!ASSERT_OK(bpf_map_get_info_by_fd(bpf_map__fd(meta_map), &info,
+					      &info_len),
+		       "get_info"))
+		return;
+
+	ASSERT_EQ(info.map_extra, 0, "meta_map not empty");
+}
+
+static void test_skb_trace__tuntap(struct test_xdp_meta *skel)
+{
+	struct bpf_link *link;
+
+	skel->bss->free_count = 0;
+
+	link = bpf_program__attach(skel->progs.skb_free);
+	if (!ASSERT_OK_PTR(link, "prog_attach"))
+		return;
+
+	__test_tuntap(SKB_TRACE_NETNS, NULL /* xdp */, skel->progs.tc_meta_write,
+		      skel->progs.tc_meta_read, &skel->bss->test_pass);
+
+	ASSERT_GE(skel->bss->free_count, 1, "free_count");
+	assert_meta_stash_empty(skel->maps.meta_map);
+
+	bpf_link__destroy(link);
+}
+
+/*
+ * Test if stashed metadata survives skb clone (via tc mirred).
+ * tap_prog writes on the tap ingress, dummy_prog runs on the clone
+ * (dummy ingress).
+ */
+static void test_skb_trace__mirred_clone(struct test_xdp_meta *skel)
+{
+	LIBBPF_OPTS(bpf_tc_hook, tc_hook, .attach_point = BPF_TC_INGRESS);
+	LIBBPF_OPTS(bpf_tc_opts, tc_opts, .handle = 1, .priority = 1);
+	struct bpf_link *put_link = NULL, *copy_link = NULL;
+	struct netns_obj *ns = NULL;
+	int dummy_ifindex;
+	int tap_ifindex;
+	int tap_fd = -1;
+	int ret;
+
+	skel->bss->write_done = false;
+	skel->bss->test_pass = false;
+	skel->bss->free_count = 0;
+	skel->bss->copy_done = false;
+
+	put_link = bpf_program__attach(skel->progs.skb_free);
+	if (!ASSERT_OK_PTR(put_link, "put_attach"))
+		return;
+
+	copy_link = bpf_program__attach(skel->progs.skb_copy);
+	if (!ASSERT_OK_PTR(copy_link, "copy_attach"))
+		goto close;
+
+	ns = netns_new("mirred_clone", true);
+	if (!ASSERT_OK_PTR(ns, "netns_new"))
+		goto close;
+
+	/* Dummy dev: attach reader */
+	SYS(close, "ip link add name " DUMMY_NAME " type dummy");
+	SYS(close, "ip link set dev " DUMMY_NAME " up");
+
+	dummy_ifindex = if_nametoindex(DUMMY_NAME);
+	if (!ASSERT_GT(dummy_ifindex, 0, "dummy_ifindex"))
+		goto close;
+
+	tc_hook.ifindex = dummy_ifindex;
+	ret = bpf_tc_hook_create(&tc_hook);
+	if (!ASSERT_OK(ret, "dummy_hook_create"))
+		goto close;
+
+	tc_opts.prog_fd = bpf_program__fd(skel->progs.tc_meta_read);
+	ret = bpf_tc_attach(&tc_hook, &tc_opts);
+	if (!ASSERT_OK(ret, "dummy_attach"))
+		goto close;
+
+	/* TAP dev: attach writer + mirred to dummy */
+	tap_fd = open_tuntap(TAP_NAME, true);
+	if (!ASSERT_GE(tap_fd, 0, "open_tuntap"))
+		goto close;
+
+	SYS(close, "ip link set dev " TAP_NAME " up");
+
+	tap_ifindex = if_nametoindex(TAP_NAME);
+	if (!ASSERT_GT(tap_ifindex, 0, "tap_ifindex"))
+		goto close;
+
+	tc_hook.ifindex = tap_ifindex;
+	ret = bpf_tc_hook_create(&tc_hook);
+	if (!ASSERT_OK(ret, "tap_hook_create"))
+		goto close;
+
+	tc_opts.prog_id = 0;
+	tc_opts.prog_fd = bpf_program__fd(skel->progs.tc_meta_write);
+	ret = bpf_tc_attach(&tc_hook, &tc_opts);
+	if (!ASSERT_OK(ret, "tap_attach"))
+		goto close;
+
+	SYS(close, "tc filter add dev " TAP_NAME " ingress "
+		   "protocol all matchall "
+		   "action mirred ingress mirror dev " DUMMY_NAME);
+
+	ret = write_test_packet(tap_fd);
+	if (!ASSERT_OK(ret, "write_test_packet"))
+		goto close;
+
+	ASSERT_TRUE(skel->bss->write_done, "write_done");
+	ASSERT_TRUE(skel->bss->test_pass, "test_pass");
+	ASSERT_TRUE(skel->bss->copy_done, "copy_done");
+	ASSERT_GE(skel->bss->free_count, 2, "free_count");
+	assert_meta_stash_empty(skel->maps.meta_map);
+
+close:
+	bpf_link__destroy(copy_link);
+	bpf_link__destroy(put_link);
+	if (tap_fd >= 0)
+		close(tap_fd);
+	netns_free(ns);
+}
+
+void test_skb_trace_basic(void)
+{
+	struct test_xdp_meta *skel = NULL;
+
+	skel = test_xdp_meta__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open and load skeleton"))
+		return;
+
+	if (test__start_subtest("write_read"))
+		test_skb_trace__tuntap(skel);
+	if (test__start_subtest("clone_read"))
+		test_skb_trace__mirred_clone(skel);
+
+	test_xdp_meta__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_meta.c b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
index 08b03be0b891..35a2c0e6ccb0 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_meta.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
@@ -3,9 +3,11 @@
 
 #include <bpf/bpf_endian.h>
 #include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
 #include <errno.h>
 
 #include "bpf_kfuncs.h"
+#include "bpf_misc.h"
 #include "bpf_tracing_net.h"
 
 #define META_SIZE 32
@@ -689,4 +691,85 @@ int helper_skb_change_proto(struct __sk_buff *ctx)
 	return TC_ACT_SHOT;
 }
 
+struct {
+	__uint(type, BPF_MAP_TYPE_RHASH);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__uint(max_entries, 128);
+	__type(key, struct __sk_buff *);
+	__type(value, __u8[META_SIZE]);
+} meta_map SEC(".maps");
+
+bool write_done;
+
+static void write_meta(struct __sk_buff *ctx, void *map)
+{
+	if (bpf_map_update_elem(map, &ctx, &meta_want, BPF_NOEXIST))
+		return;
+	bpf_trace_skb(bpf_cast_to_kern_ctx(ctx), 0);
+	write_done = true;
+}
+
+/* Stash test metadata in the meta_map, keyed by the skb address */
+SEC("tc")
+int tc_meta_write(struct __sk_buff *ctx)
+{
+	if (!is_test_packet_tc(ctx))
+		return TC_ACT_SHOT;
+
+	write_meta(ctx, &meta_map);
+	return TC_ACT_UNSPEC;
+}
+
+/* Read test metadata stashed in the meta_map on the same hook */
+SEC("tc")
+int tc_meta_read(struct __sk_buff *ctx)
+{
+	__u8 *meta_have;
+
+	meta_have = bpf_map_lookup_elem(&meta_map, &ctx);
+	if (!meta_have)
+		return TC_ACT_SHOT;
+	if (!check_metadata(meta_have))
+		return TC_ACT_SHOT;
+
+	test_pass = true;
+	return TC_ACT_UNSPEC;
+}
+
+int free_count;
+
+SEC("raw_tp/skb_free")
+int BPF_PROG(skb_free, struct sk_buff *skb, enum skb_drop_reason reason,
+	     void *location)
+{
+	__u8 *meta_have;
+
+	meta_have = bpf_map_lookup_elem(&meta_map, &skb);
+	if (!meta_have)
+		return 0;
+	if (bpf_map_delete_elem(&meta_map, &skb))
+		return 0;
+
+	free_count++;
+	return 0;
+}
+
+bool copy_done;
+
+SEC("tp_btf/skb_copy")
+int BPF_PROG(skb_copy, struct sk_buff *dst, struct sk_buff *src)
+{
+	__u8 *meta_have;
+
+	meta_have = bpf_map_lookup_elem(&meta_map, &src);
+	if (!meta_have)
+		return 0;
+	if (bpf_map_update_elem(&meta_map, &dst, meta_have, BPF_NOEXIST))
+		return 0;
+
+	bpf_trace_skb(dst, 0);
+	copy_done = true;
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";

-- 
2.43.0

