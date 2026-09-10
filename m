Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0604549B200
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 14:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789048975; cv=none; b=PymuN7/Dod79SjBkgmvLSAtHYVGLp/o4+wQHRwu5HQs8eqHL8ztyDKjkGCsVQznQ3Q9rF0rGTIDHM1uHovnhAHdBSOKkVP1mmUYfYYMJ0AyyHrNuiRT4hnU8o85pPtsrEliS8ut/CuY4Xvwtj7Nws2UXT4zzCxVrEdqIZGxVZ3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789048975; c=relaxed/simple;
	bh=rC0Yd3CXyDFRpnHOHLiFaSLmxcyY7LEJf5u7KFgqIC8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fk6bs7EWxJ/p932h8d9PXylVM3HrHeNq4kSVr5Y8St5mmPrE/BXf8irVQtL/XAS3b2eayhkpu94+cM2TiHxvu89hNu0ou1gwSgORgCXPU+AVn2SLwIJWhTNioD5JO8qiEf+xZ+r9s6Ecb0Qm6xRWFRi6ky0VZM/uV1IEgwFeNQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=FTiQCj2+; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="FTiQCj2+"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f8694aeso268558666b.0
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 07:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1789048971; x=1789653771; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mq8IbU/5eQsM/lONMbLuHU7eTdgL0/fDzLp8sxUozu4=;
        b=FTiQCj2+K51NySnkpCjF1xqz5riDbJMpBpuVwWOP4yGWI2hbSXiEvh/+g0L9mTO7rt
         k6qsNBzBSzmEJ0w8bLzU9aDFZIZCOJMYwSsNSBTsTg9fdSQLpkQuddtAKht57QjyhbFu
         Xe77F3uxyq06Shg5MmcZUEEZQ4gmbKZmqfe/6x3TE+mmlL9ufuScMPCkFZtqX4hyHkrE
         WGKNfWinNxWXDisFcJV9koa+ay0WqNRPeg4FmrudeDDqBczsQYxB+7A89IbQTYzdOnhI
         92hSkDRoq9jWdD5dJrv3SdvxmEzcTyQELtRDaWRDgcFaiXf3K+G7SHL0jL8/zjnd70PS
         yvew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789048971; x=1789653771;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mq8IbU/5eQsM/lONMbLuHU7eTdgL0/fDzLp8sxUozu4=;
        b=seondg62AJWBJnhY8exJWuZ7J8tNMSvF4ptV1yfWRSwevwDuVOnZNWFWd64iGS8WHL
         tepM5DBysZVH8eOsPs0XxivJLRIRRF6i2NmE+XFpWF28sgs2FyJVE2McBbrjzKuyxyIn
         Q3QaQkHC1Qz61zu991uUwIvy7TbPGQUpLyRdSHgLz5vuCnCvLKrX1HdKCAd/42xW7ovH
         1v6dpdDTzGjPGDHKcIrL8bbVFYNGd9AZbP0Oi3gYEpZ+0TBBSxAEDNgrB3M9L7qVrsu0
         XguWqBaaj4hNb+R3iJAQBsJdiQ4tWol7EwXiAQfCFAdE+N1NlW3XWTDeE4JI+4TkPsbg
         VAxw==
X-Gm-Message-State: AFuF++kfaKFpcXokUoatZDnrOZuWxE1YgZNXrAp10o8bKq9YJIm3ySoO
	ozUNGDwB/amA31BgV32S7v2CG1npUr2Ass8RX4YEJm1JIsehgdhWSKoPvt+JPyH/ITE=
X-Gm-Gg: AYBFou2FZcxJLaiLXS/pWGk+Wmz4cM612AhfDYR27UVwwdaHYp3TivmbAV7wLpGcm0I
	35UxcKxUPVzQdpf6z+4tQEElyHjOIUNkCoAE9EM8612WCaIF4gbq7F2u1l3ZsjOa285OStL4RGq
	aZRyf84BXo9DICijWRlMRo6J3niLcvvNPxTiPr86kp2/4TRohdXXO6G4caSZBMTPrm0bwdjZ2kT
	+qjJOeI7DU7VFF3buGi9XRzx+/yhI3h1tPMSnLXVwWKWoq7swujrLq8r7wi2pRA16QNSc0OW8a2
	ZgpVaN/964lcCBIp+WC3X+ymCrHIjNbgMQeg6kqOVNC2JsT/nmrJNqpC3Lav8V/IXx9aU9HHmQP
	QY3Kpt8FHoOGqBkZKQ6yqAxmFbrMwI9LDbe67VQrrP1z4z0UKmh/2wYE8aNfUo1e0oq/nvFJLgd
	cuuBjczZMG5yzchnklCzOjzIBzThSgVnGlO+hcnGq0UJTAXF+GHL67DqLs62lIO13SjCXJPRiHS
	z6pkqqWdTOsRQZgtcm0fM60jqP1hQAhSvLnfbfHt12w/2BR
X-Received: by 2002:a17:907:1c15:b0:c24:d6f0:aa0 with SMTP id a640c23a62f3a-c2945e90087mr290909566b.11.1789048971163;
        Thu, 10 Sep 2026 07:02:51 -0700 (PDT)
Received: from cloudflare.com (79.184.140.212.ipv4.supernova.orange.pl. [79.184.140.212])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d53c37csm911956266b.32.2026.09.10.07.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 07:02:50 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Thu, 10 Sep 2026 16:02:40 +0200
Subject: [PATCH net-next v2 05/14] selftests/bpf: Test skb_ext on cloned
 skbs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-bpf-meta-inside-skb-ext-v2-5-0b21e42180b0@cloudflare.com>
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

Cover skb_ext behavior when an skb is cloned, by TC mirred (mirror to a
dummy device) and by bpf_clone_redirect():

- clone_ext_read: the extension written at tap ingress is readable
  from the mirred clone at dummy ingress -- the clone shares the
  extension with the original
- clone_ext_cow: opening the extension with F_CREATE on the clone
  triggers copy-on-write, so overwriting the clone's data does not
  affect the original -- verified by a tp_btf/kfree_skb probe that
  checks the original skb still carries meta_want
- clone_redir_ext_write_after / clone_redir_ext_slice_write_after: a
  write to an skb_ext dynptr after bpf_clone_redirect() fails with
  -EBUSY/NULL while the clone is queued on a netem-delayed loopback and
  keeps the ext block shared, and dynptrs and pointers to backing memory
  get invalidated on skb clone; re-acquiring the dynptr with F_CREATE
  COWs the block and the write succeeds

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 tools/testing/selftests/bpf/config                 |   1 +
 .../bpf/prog_tests/xdp_context_test_run.c          | 182 +++++++++++++++++++++
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  | 126 ++++++++++++++
 .../testing/selftests/bpf/progs/verifier_skb_ext.c |  45 +++++
 4 files changed, 354 insertions(+)

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index 502f4504bdba..9bbfa351bced 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -137,3 +137,4 @@ CONFIG_SMC_HS_CTRL_BPF=y
 CONFIG_DIBS=y
 CONFIG_DIBS_LO=y
 CONFIG_PM_WAKELOCKS=y
+CONFIG_NET_SCH_NETEM=y
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
index 252ac02de81b..f7617aef4d35 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -713,6 +713,178 @@ static void test_skb_ext_tuntap(struct bpf_program *tc_prio_1_prog,
 		      tc_prio_2_prog, test_pass);
 }
 
+/*
+ * Test if skb_ext survives skb clone (via tc mirred).
+ * dummy_prog runs on the clone (dummy ingress).
+ */
+static void test_mirred_clone_ext(struct test_xdp_meta *skel,
+				  struct bpf_program *dummy_prog)
+{
+	LIBBPF_OPTS(bpf_tc_hook, tc_hook, .attach_point = BPF_TC_INGRESS);
+	LIBBPF_OPTS(bpf_tc_opts, tc_opts, .handle = 1, .priority = 1);
+	struct netns_obj *ns = NULL;
+	int dummy_ifindex;
+	int tap_ifindex;
+	int tap_fd = -1;
+	int ret;
+
+	skel->bss->write_done = false;
+	skel->bss->test_pass = false;
+
+	ns = netns_new("mirred_clone", true);
+	if (!ASSERT_OK_PTR(ns, "netns_new"))
+		return;
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
+	tc_opts.prog_fd = bpf_program__fd(dummy_prog);
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
+	tc_opts.prog_fd = bpf_program__fd(skel->progs.tc_skb_ext_write);
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
+
+close:
+	if (tap_fd >= 0)
+		close(tap_fd);
+	netns_free(ns);
+}
+
+static void test_mirred_clone_ext_cow(struct test_xdp_meta *skel)
+{
+	struct bpf_link *tp_link;
+
+	skel->bss->clone_cow_done = false;
+	tp_link = bpf_program__attach(skel->progs.tp_kfree_skb_cow_check);
+	if (!ASSERT_OK_PTR(tp_link, "attach_tp"))
+		return;
+
+	test_mirred_clone_ext(skel, skel->progs.tc_skb_ext_clone_redir_cow);
+	bpf_link__destroy(tp_link);
+}
+
+/*
+ * Writer clones via bpf_clone_redirect() from the prog itself to loopback
+ * whose netem qdisc delays the clone, so it stays queued and keeps sharing
+ * the ext block while the prog writes again. When the qdisc finally leaks
+ * the clone back to lo ingress, the reader there must still see the
+ * clone-time snapshot.
+ */
+static void test_clone_redir_ext_write_after(struct test_xdp_meta *skel,
+					     struct bpf_program *writer)
+{
+	LIBBPF_OPTS(bpf_tc_hook, tc_hook, .attach_point = BPF_TC_INGRESS);
+	LIBBPF_OPTS(bpf_tc_opts, tc_opts, .handle = 1, .priority = 1);
+	struct netns_obj *ns = NULL;
+	int tap_ifindex;
+	int tap_fd = -1;
+	int ret, i;
+
+	skel->bss->test_pass = false;
+	skel->bss->write_blocked = false;
+
+	ns = netns_new("clone_redir_ext", true);
+	if (!ASSERT_OK_PTR(ns, "netns_new"))
+		return;
+
+	/* Redirect target: lo held back by netem delay */
+	SYS(close, "ip link set dev lo up");
+	SYS(close, "tc qdisc add dev lo root netem delay 50ms");
+
+	/* Reader on the clone: lo ingress */
+	tc_hook.ifindex = if_nametoindex("lo");
+	ret = bpf_tc_hook_create(&tc_hook);
+	if (!ASSERT_OK(ret, "lo_hook_create"))
+		goto close;
+
+	tc_opts.prog_fd = bpf_program__fd(skel->progs.tc_skb_ext_read);
+	ret = bpf_tc_attach(&tc_hook, &tc_opts);
+	if (!ASSERT_OK(ret, "lo_attach"))
+		goto close;
+
+	/* TAP dev: attach writer which clone_redirects to lo */
+	tap_fd = open_tuntap(TAP_NAME, true);
+	if (!ASSERT_GE(tap_fd, 0, "open_tuntap"))
+		goto close;
+
+	SYS(close, "ip link set dev " TAP_NAME " up");
+
+	tap_ifindex = if_nametoindex(TAP_NAME);
+	if (!ASSERT_GE(tap_ifindex, 0, "tap_ifindex"))
+		goto close;
+
+	skel->bss->clone_redir_ifindex = tc_hook.ifindex;
+
+	tc_hook.ifindex = tap_ifindex;
+	ret = bpf_tc_hook_create(&tc_hook);
+	if (!ASSERT_OK(ret, "tap_hook_create"))
+		goto close;
+
+	tc_opts.prog_id = 0;
+	tc_opts.prog_fd = bpf_program__fd(writer);
+	ret = bpf_tc_attach(&tc_hook, &tc_opts);
+	if (!ASSERT_OK(ret, "tap_attach"))
+		goto close;
+
+	ret = write_test_packet(tap_fd);
+	if (!ASSERT_OK(ret, "write_test_packet"))
+		goto close;
+
+	ASSERT_TRUE(skel->bss->write_blocked, "write_blocked");
+
+	/* Clone arrives after the netem delay; poll every 10 msec up to 1 sec */
+	for (i = 0; i < 100 && !skel->bss->test_pass; i++)
+		usleep(10000);
+	ASSERT_TRUE(skel->bss->test_pass, "test_pass");
+
+close:
+	if (tap_fd >= 0)
+		close(tap_fd);
+	netns_free(ns);
+}
+
 void test_skb_ext_basic(void)
 {
 	struct test_xdp_meta *skel = NULL;
@@ -753,6 +925,16 @@ void test_skb_ext_basic(void)
 		test_skb_ext_tuntap(skel->progs.tc_skb_ext_double_alloc,
 				    NULL, /* tc prio 2 */
 				    &skel->bss->test_pass);
+	if (test__start_subtest("clone_ext_read"))
+		test_mirred_clone_ext(skel, skel->progs.tc_skb_ext_read);
+	if (test__start_subtest("clone_ext_cow"))
+		test_mirred_clone_ext_cow(skel);
+	if (test__start_subtest("clone_redir_ext_write_after"))
+		test_clone_redir_ext_write_after(skel,
+						 skel->progs.tc_skb_ext_write_after_clone_redir);
+	if (test__start_subtest("clone_redir_ext_slice_write_after"))
+		test_clone_redir_ext_write_after(skel,
+						 skel->progs.tc_skb_ext_slice_write_after_clone_redir);
 
 	test_xdp_meta__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_meta.c b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
index 43840ee32d35..ff134204a33e 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_meta.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
@@ -3,6 +3,7 @@
 
 #include <bpf/bpf_endian.h>
 #include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
 #include <errno.h>
 
 #include "bpf_kfuncs.h"
@@ -690,6 +691,8 @@ int helper_skb_change_proto(struct __sk_buff *ctx)
 	return TC_ACT_SHOT;
 }
 
+bool write_done;
+
 /* Write to skb_ext using bpf_dynptr_write helper */
 SEC("tc")
 int tc_skb_ext_write(struct __sk_buff *ctx)
@@ -703,6 +706,7 @@ int tc_skb_ext_write(struct __sk_buff *ctx)
 	if (bpf_dynptr_write(&meta, 0, (void *)meta_want, ARRAY_SIZE(meta_want), 0))
 		return TC_ACT_SHOT;
 
+	write_done = true;
 	return TC_ACT_UNSPEC;
 }
 
@@ -874,4 +878,126 @@ int tc_skb_ext_double_alloc(struct __sk_buff *ctx)
 	return TC_ACT_UNSPEC;
 }
 
+static const __u8 meta_zero[META_SIZE] = {};
+
+bool clone_cow_done;
+
+/*
+ * Overwrite skb_ext on the clone via F_CREATE (COW) -- must not affect original.
+ * Runs on the dummy ingress (clone side), synchronously during tc mirred.
+ */
+SEC("tc")
+int tc_skb_ext_clone_redir_cow(struct __sk_buff *ctx)
+{
+	struct bpf_dynptr meta;
+
+	if (bpf_dynptr_from_skb_ext(ctx, 0, BPF_SKB_EXT_F_CREATE, &meta))
+		return TC_ACT_SHOT;
+
+	/* Zero out the clone's ext -- must not affect original */
+	if (bpf_dynptr_write(&meta, 0, (void *)meta_zero, META_SIZE, 0))
+		return TC_ACT_SHOT;
+
+	clone_cow_done = true;
+	return TC_ACT_SHOT;
+}
+
+/*
+ * Verify COW isolation at kfree_skb time: once clone_cow_done is set,
+ * check that the original skb still has meta_want.
+ */
+SEC("tp_btf/kfree_skb")
+int BPF_PROG(tp_kfree_skb_cow_check, struct sk_buff *skb)
+{
+	__u8 meta_have[META_SIZE];
+	struct bpf_dynptr meta;
+
+	if (!clone_cow_done)
+		return 0;
+
+	if (bpf_dynptr_from_skb_ext((struct __sk_buff *)skb, 0, 0, &meta))
+		return 0;
+	if (bpf_dynptr_read(meta_have, META_SIZE, &meta, 0, 0))
+		return 0;
+	if (!check_metadata(meta_have))
+		return 0;
+
+	test_pass = true;
+	return 0;
+}
+
+__u32 clone_redir_ifindex;
+bool write_blocked;
+
+/*
+ * Write skb_ext, clone the skb to a delayed qdisc so the clone keeps the ext
+ * block shared, then try to write to the same dynptr again. The write must fail
+ * with -EBUSY. Re-acquiring the dynptr with F_CREATE COWs the block and
+ * succeeds.
+ */
+SEC("tc")
+int tc_skb_ext_write_after_clone_redir(struct __sk_buff *ctx)
+{
+	struct bpf_dynptr meta;
+
+	if (!is_test_packet_tc(ctx))
+		return TC_ACT_UNSPEC;
+	if (bpf_dynptr_from_skb_ext(ctx, 0, BPF_SKB_EXT_F_CREATE, &meta))
+		return TC_ACT_SHOT;
+	if (bpf_dynptr_write(&meta, 0, (void *)meta_want, META_SIZE, 0))
+		return TC_ACT_SHOT;
+
+	if (bpf_clone_redirect(ctx, clone_redir_ifindex, 0 /* egress */))
+		return TC_ACT_SHOT;
+
+	/* ext now shared with the queued clone -- write must fail */
+	if (bpf_dynptr_write(&meta, 0, (void *)meta_zero, META_SIZE, 0) != -EBUSY)
+		return TC_ACT_SHOT;
+
+	/* Re-acquiring COWs the block -- write must succeed */
+	if (bpf_dynptr_from_skb_ext(ctx, 0, BPF_SKB_EXT_F_CREATE, &meta))
+		return TC_ACT_SHOT;
+	if (bpf_dynptr_write(&meta, 0, (void *)meta_zero, META_SIZE, 0))
+		return TC_ACT_SHOT;
+
+	write_blocked = true;
+	return TC_ACT_UNSPEC;
+}
+
+/*
+ * Same as above but using bpf_dynptr_slice_rdwr.
+ */
+SEC("tc")
+int tc_skb_ext_slice_write_after_clone_redir(struct __sk_buff *ctx)
+{
+	struct bpf_dynptr meta;
+	void *slice;
+
+	if (!is_test_packet_tc(ctx))
+		return TC_ACT_UNSPEC;
+	if (bpf_dynptr_from_skb_ext(ctx, 0, BPF_SKB_EXT_F_CREATE, &meta))
+		return TC_ACT_SHOT;
+	if (bpf_dynptr_write(&meta, 0, (void *)meta_want, META_SIZE, 0))
+		return TC_ACT_SHOT;
+
+	if (bpf_clone_redirect(ctx, clone_redir_ifindex, 0 /* egress */))
+		return TC_ACT_SHOT;
+
+	/* ext now shared with the queued clone -- slice must fail */
+	slice = bpf_dynptr_slice_rdwr(&meta, 0, NULL, META_SIZE);
+	if (slice)
+		return TC_ACT_SHOT;
+
+	/* Re-acquiring COWs the block -- slice must succeed */
+	if (bpf_dynptr_from_skb_ext(ctx, 0, BPF_SKB_EXT_F_CREATE, &meta))
+		return TC_ACT_SHOT;
+	slice = bpf_dynptr_slice_rdwr(&meta, 0, NULL, META_SIZE);
+	if (!slice)
+		return TC_ACT_SHOT;
+	__builtin_memcpy(slice, meta_zero, META_SIZE);
+
+	write_blocked = true;
+	return TC_ACT_UNSPEC;
+}
+
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/verifier_skb_ext.c b/tools/testing/selftests/bpf/progs/verifier_skb_ext.c
index db43f1051400..c2611c9315aa 100644
--- a/tools/testing/selftests/bpf/progs/verifier_skb_ext.c
+++ b/tools/testing/selftests/bpf/progs/verifier_skb_ext.c
@@ -7,6 +7,51 @@
 
 __u64 flags;
 
+SEC("tc")
+__description("skb_ext slice is invalidated by bpf_clone_redirect")
+__failure
+int skb_ext_stale_slice_after_clone_redirect(struct __sk_buff *ctx)
+{
+	struct bpf_dynptr meta;
+	__u8 *slice;
+
+	if (bpf_dynptr_from_skb_ext(ctx, 0, BPF_SKB_EXT_F_CREATE, &meta))
+		return 0;
+
+	slice = bpf_dynptr_slice_rdwr(&meta, 0, NULL, 8);
+	if (!slice)
+		return 0;
+
+	bpf_clone_redirect(ctx, 1, 0);
+
+	/* Stale: the clone shares the ext block the slice points into. */
+	*slice = 0;
+
+	return 0;
+}
+
+SEC("tc")
+__description("skb_ext slice is invalidated when ext is re-opened with F_CREATE")
+__failure
+int skb_ext_stale_slice_after_recreate(struct __sk_buff *ctx)
+{
+	struct bpf_dynptr d1, d2;
+	__u8 *slice;
+
+	if (bpf_dynptr_from_skb_ext(ctx, 0, 0, &d1))
+		return 0;
+
+	slice = bpf_dynptr_slice(&d1, 0, NULL, 8);
+	if (!slice)
+		return 0;
+
+	/* May COW the ext block, leaving the slice pointing at the old one. */
+	if (bpf_dynptr_from_skb_ext(ctx, 0, BPF_SKB_EXT_F_CREATE, &d2))
+		return 0;
+
+	return *slice;
+}
+
 SEC("tp_btf/kfree_skb")
 __description("F_CREATE is rejected in tracing programs")
 __failure __msg("is not allowed in lsm/tracing programs")

-- 
2.43.0

