Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE0541B8C7
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 08:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786695280; cv=none; b=Xz1EGAan9xUHVwuGQYXO8WifMPh5oum4JrKlsRL3cdB9ol16w2wlb7AY8wDnqQqxPp8leF6ge4+Xf763/saSHg2RXgWZs6O6ss4PhdwW4KkBvm8voXdTVy97jxt+OK4E7W0T4NAd2ZvRZnHVmEV9keE0eHb8hPOBiWktYIJNTP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786695280; c=relaxed/simple;
	bh=UatcUVa5wuFS5yw4/RKkRAIzEEXh8HYLbp6g1tiRtn8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VhFjbeyVTHr4JIL19hVETof0Ywdte+EOlKsufTrns9ysrVbM9COX+30pvbWTxeeldctcvkC+dUSOHkVfGzsJFtl6Gtq5UBe3wu76Ip6YD1PKTwYhezQnQm464LwR75wcIl5M8FrR11q/aaYTTuIULNCwJABchgbL0FeLo38AIXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=B/OGLX2Y; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="B/OGLX2Y"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6a0a4aa99bdso1055366a12.1
        for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 01:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1786695272; x=1787300072; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GQlkHbgy0XN1qvL6qI/NDlKINcvmios6Wf2KjVtzATE=;
        b=B/OGLX2Yyp3WypHt/qytaJmksGKR9haFgVnHMi+Ni2qwJp2rCrr4QFTdds521XQv/M
         LX4Y2Qj9TYFrOjSHwR2iMTbCrKEUMP3OpINB9PZTUuG+MrBo++f9sATRHscSZGGDP1f6
         sMEKyVWyv5o2ynwew74O1I78lYMLSt6eDqlHfG6tDq37QeTidDCD5USUZyf6CDUfHW2H
         Mdnp/RUpF8BemML1I1uXOgmBFVN0j5QC6CbnCC1pnOigBMiqJjeuPJhcFL1+m3+0seQf
         sitmCiMJFl/n2MkrPK5pUu5A0imvNppmxQd4y0pH2EvX7wB8LGhgY3+HROU9or+mlrrM
         V/6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786695272; x=1787300072;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GQlkHbgy0XN1qvL6qI/NDlKINcvmios6Wf2KjVtzATE=;
        b=MVCNltJm48UwmlRvF26aS86rZaLTT8kkg+C2S/5jWkCLQONdh7D0gt5QoCvUExW986
         9D4VoCRsbgpbm53n53/IyEtZx0464d/CAA1hu8AjgowsNaSfF1IJtzhHT1s0GTLphbMs
         BMwG8rYCv8RnfzFWwK+m2Q3M9e4DwjSs7RgAa7qmUvN/KJRJiZqQXM+uUIU/QreBJu7C
         5Vm+z6LQ9Z0ZMGRDtDwxieaLAPZfPbN1Hd6zwz7s5Cosmd7i6tHpZqj01+ZtKPEHjEkY
         hbzRY5A6VC4/hoMlNfKbbmTTs4Et3pX53pF9tFA1MxZvy0un7Bjg9UUDMHUrvd0a7ISf
         xouQ==
X-Gm-Message-State: AOJu0YzPHCn6UVdcZphQdwaXAUI1OgZk4l/8GYsdbYOsjJuN7LqRa7QV
	Wuj6zPuh/uQBiDbes62I2PYymAL6HjgLI8GdxHYCjwoajGYVaJDpvtBwsRSa5HC6KHY=
X-Gm-Gg: AR+sD13en3xPttf9LWlB4CCBV3NrkqlTGOtFBmwAtTgXrRLc9e/KU9usUcR9I1a13f8
	XmZM65lnTr8fJrZl/56lL4XkSJrMLuZObWXjIuLSjMnXcFHoDsup3Js3mzS0d8qzu5V+LeHiAoT
	anuXqfR+VRlngPSm/NrxID1L+8PJDRJyCJ/qXWgN9MA2D59apB1EPUm8njJD91q3sPfwh/hLgYg
	zBjhdG+IheaaayoPRB7dhk0B5RziHcOT2LQoW+D9e0ozdahjxUQdA/DBLgPeo+VyzCobljys2zk
	3saYeCagCkKdabehMzCcV2ihL2ptbW5GJsnyJHkmM7lu8UtzqQpDgkal0U3OlJvzReFmo1PQJv8
	XFWFdhEVcVmQ/jzqnqRZOWEzDFOWgzMrR/+TmOVLOF/qLrNo/XhLFGVwv4eYeAGBHozf53jnb9+
	LG23a3PNSmj8T8Yy47vHLiRdgOP4+1VTnBcC3mrJZ1UQGpQG1cF9uvhpYoIu8NbcrSCsSHV3mEJ
	hSyJR3xSzmh0TiQmDnUII+t8zePTflZPCrca2FBbugYmg/0
X-Received: by 2002:a17:907:7b9f:b0:c20:23fb:bb05 with SMTP id a640c23a62f3a-c212a26d65cmr175208266b.15.1786695271997;
        Fri, 14 Aug 2026 01:14:31 -0700 (PDT)
Received: from cloudflare.com (79.184.184.176.ipv4.supernova.orange.pl. [79.184.184.176])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2123834ea2sm77291866b.53.2026.08.14.01.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 01:14:31 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Fri, 14 Aug 2026 10:14:07 +0200
Subject: [PATCH net-next 06/14] selftests/bpf: Test skb_ext survival across
 veth and GRE
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-bpf-meta-inside-skb-ext-v1-6-767edd862656@cloudflare.com>
References: <20260814-bpf-meta-inside-skb-ext-v1-0-767edd862656@cloudflare.com>
In-Reply-To: <20260814-bpf-meta-inside-skb-ext-v1-0-767edd862656@cloudflare.com>
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

Write skb_ext at TC egress and read it back at TC ingress after the
packet crosses device boundaries:

- survives_veth: veth forwarding between two netns
- survives_gre: GRE encap/decap between two gretap endpoints over
  loopback in a single netns

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 .../bpf/prog_tests/xdp_context_test_run.c          | 154 +++++++++++++++++++++
 1 file changed, 154 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
index 58b793cf14e5..de6030302536 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -783,6 +783,156 @@ static void test_mirred_clone_ext_cow(struct test_xdp_meta *skel)
 	bpf_link__destroy(tp_link);
 }
 
+/* Test if skb_ext survives veth cross-netns forward */
+static void test_skb_ext_scrub_veth(struct test_xdp_meta *skel)
+{
+	LIBBPF_OPTS(bpf_tc_hook, tx_hook, .attach_point = BPF_TC_EGRESS);
+	LIBBPF_OPTS(bpf_tc_opts, tx_opts, .handle = 1, .priority = 1);
+	LIBBPF_OPTS(bpf_tc_hook, rx_hook, .attach_point = BPF_TC_INGRESS);
+	LIBBPF_OPTS(bpf_tc_opts, rx_opts, .handle = 1, .priority = 1);
+	struct netns_obj *rx_ns = NULL, *tx_ns = NULL;
+	struct nstoken *nstoken = NULL;
+	int rx_ifindex, tx_ifindex;
+	int ret;
+
+	tx_ns = netns_new(TX_NETNS, false);
+	if (!ASSERT_OK_PTR(tx_ns, "create tx_ns"))
+		return;
+
+	rx_ns = netns_new(RX_NETNS, false);
+	if (!ASSERT_OK_PTR(rx_ns, "create rx_ns"))
+		goto close;
+
+	SYS(close, "ip link add " RX_NAME " netns " RX_NETNS
+	    " type veth peer name " TX_NAME " netns " TX_NETNS);
+
+	/* Setup RX side: TC ingress reader */
+	nstoken = open_netns(RX_NETNS);
+	if (!ASSERT_OK_PTR(nstoken, "setns rx_ns"))
+		goto close;
+
+	SYS(close, "ip link set dev " RX_NAME " up");
+
+	rx_ifindex = if_nametoindex(RX_NAME);
+	if (!ASSERT_GE(rx_ifindex, 0, "if_nametoindex rx"))
+		goto close;
+
+	rx_hook.ifindex = rx_ifindex;
+	ret = bpf_tc_hook_create(&rx_hook);
+	if (!ASSERT_OK(ret, "bpf_tc_hook_create rx"))
+		goto close;
+
+	rx_opts.prog_fd = bpf_program__fd(skel->progs.tc_skb_ext_read);
+	ret = bpf_tc_attach(&rx_hook, &rx_opts);
+	if (!ASSERT_OK(ret, "bpf_tc_attach rx"))
+		goto close;
+
+	close_netns(nstoken);
+
+	/* Setup TX side: TC egress writer */
+	nstoken = open_netns(TX_NETNS);
+	if (!ASSERT_OK_PTR(nstoken, "setns tx_ns"))
+		goto close;
+
+	SYS(close, "ip link set dev " TX_NAME " up");
+
+	tx_ifindex = if_nametoindex(TX_NAME);
+	if (!ASSERT_GE(tx_ifindex, 0, "if_nametoindex tx"))
+		goto close;
+
+	tx_hook.ifindex = tx_ifindex;
+	ret = bpf_tc_hook_create(&tx_hook);
+	if (!ASSERT_OK(ret, "bpf_tc_hook_create tx"))
+		goto close;
+
+	tx_opts.prog_fd = bpf_program__fd(skel->progs.tc_skb_ext_write);
+	ret = bpf_tc_attach(&tx_hook, &tx_opts);
+	if (!ASSERT_OK(ret, "bpf_tc_attach tx"))
+		goto close;
+
+	skel->bss->test_pass = false;
+
+	ret = send_test_packet(tx_ifindex);
+	if (!ASSERT_OK(ret, "send_test_packet"))
+		goto close;
+
+	ASSERT_TRUE(skel->bss->test_pass, "test_pass");
+
+close:
+	close_netns(nstoken);
+	netns_free(rx_ns);
+	netns_free(tx_ns);
+}
+
+/* Test if skb_ext survives GRE tunnel encap+decap */
+static void test_skb_ext_scrub_gre(struct test_xdp_meta *skel)
+{
+	LIBBPF_OPTS(bpf_tc_hook, tx_hook, .attach_point = BPF_TC_EGRESS);
+	LIBBPF_OPTS(bpf_tc_opts, tx_opts, .handle = 1, .priority = 1);
+	LIBBPF_OPTS(bpf_tc_hook, rx_hook, .attach_point = BPF_TC_INGRESS);
+	LIBBPF_OPTS(bpf_tc_opts, rx_opts, .handle = 1, .priority = 1);
+	struct netns_obj *ns = NULL;
+	int tx_ifindex;
+	int rx_ifindex;
+	int ret;
+
+	skel->bss->test_pass = false;
+
+	ns = netns_new("gre_test", true);
+	if (!ASSERT_OK_PTR(ns, "netns_new"))
+		return;
+
+	/* Setup: gre_tx -> lo -> gre_rx */
+	SYS(close, "ip link set lo up");
+	SYS(close, "ip link add gre_tx type gretap"
+	    " local 127.0.0.1 remote 127.0.0.2");
+	SYS(close, "ip link set gre_tx up");
+	SYS(close, "ip addr add 127.0.0.2/8 dev lo");
+	SYS(close, "ip link add gre_rx type gretap"
+	    " local 127.0.0.2 remote 127.0.0.1");
+	SYS(close, "ip link set gre_rx up");
+
+	/* Write skb_ext on TC egress on GRE tx */
+	tx_ifindex = if_nametoindex("gre_tx");
+	if (!ASSERT_GE(tx_ifindex, 0, "tx_ifindex"))
+		goto close;
+
+	tx_hook.ifindex = tx_ifindex;
+	ret = bpf_tc_hook_create(&tx_hook);
+	if (!ASSERT_OK(ret, "tx_hook_create"))
+		goto close;
+
+	tx_opts.prog_fd = bpf_program__fd(skel->progs.tc_skb_ext_write);
+	ret = bpf_tc_attach(&tx_hook, &tx_opts);
+	if (!ASSERT_OK(ret, "tx_attach"))
+		goto close;
+
+	/* Read skb_ext on TC ingress on GRE rx */
+	rx_ifindex = if_nametoindex("gre_rx");
+	if (!ASSERT_GE(rx_ifindex, 0, "rx_ifindex"))
+		goto close;
+
+	rx_hook.ifindex = rx_ifindex;
+	ret = bpf_tc_hook_create(&rx_hook);
+	if (!ASSERT_OK(ret, "rx_hook_create"))
+		goto close;
+
+	rx_opts.prog_fd = bpf_program__fd(skel->progs.tc_skb_ext_read);
+	ret = bpf_tc_attach(&rx_hook, &rx_opts);
+	if (!ASSERT_OK(ret, "rx_attach"))
+		goto close;
+
+	/* Then use send_test_packet on GRE tx */
+	ret = send_test_packet(tx_ifindex);
+	if (!ASSERT_OK(ret, "send_test_packet"))
+		goto close;
+
+	ASSERT_TRUE(skel->bss->test_pass, "test_pass");
+
+close:
+	netns_free(ns);
+}
+
 void test_skb_ext_basic(void)
 {
 	struct test_xdp_meta *skel = NULL;
@@ -835,6 +985,10 @@ void test_skb_ext_basic(void)
 		test_mirred_clone_ext(skel, skel->progs.tc_skb_ext_read);
 	if (test__start_subtest("clone_ext_cow"))
 		test_mirred_clone_ext_cow(skel);
+	if (test__start_subtest("survives_veth"))
+		test_skb_ext_scrub_veth(skel);
+	if (test__start_subtest("survives_gre"))
+		test_skb_ext_scrub_gre(skel);
 
 	test_xdp_meta__destroy(skel);
 }

-- 
2.43.0

