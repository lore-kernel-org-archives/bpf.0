Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D691A4963C8
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 14:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789048977; cv=none; b=W5w8ifMEa6m/VY0G7Ykqzao3SnM9Qc3646OwK+pIcL+0vIN3zboEdkbewsfuxdbFi4ZWweYU3AqzUIgdt37WAdJtyo0J7n/9SjV6OfCRkktuAIfHmcqM82K5aVJZp7iQV+fCDesJlVcGflKSMWKF20EjRd3nWJjIrkcKsXRhbM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789048977; c=relaxed/simple;
	bh=cd7U6sBwAJ9/oTQseveTlVwDmh+eMKrpH0GaQtXPj8Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cDD86qWhK8b12SgLEKlZXsvkuT594AP+0Qbb4f23WKMUm2dmOX40oVsaWigWAoG5VRp6fWndzBaCf3hd22+KW06IpnXaMElmnqDn9/tPMmnzpgWYg6Ho9T4I4iolwNW7ohL4s48ZskfcR1yoQGmYQbI4Wu8nPXrhifOB3r6Vvf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=MwwSa0YB; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="MwwSa0YB"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c2956d30b56so48994666b.1
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 07:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1789048973; x=1789653773; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3pBmwNSWHN0yjp8GjiKNRVDKqbDamZhuMB1kehBa5sw=;
        b=MwwSa0YB/wk1VDIDqk65nzRI+/FE0leElwMLNmnJ3JE7uqQfkSqMnc/9HsBL6wFzhC
         O1Zm1IN+UA4Rm8cvnjTwSP5eZoAHZtoi/I3LNxqbQxx6Yx+MLHvon3usoitN7jW3f4uE
         8I2ItCbIEqdB87ejcQ0QhZn+uv01tqayJBSd0C798An12xhxruYHiuOTsRX1Odh06aEC
         WT+I8heqswfh+Nlx5uDiwoCe51tdZxEorVAxN1v47nIJRoW87PGbbPieou71tBtEaRbk
         lZBxMjrhP+wkCndxTTxC0qel4KVUKN2eP9YaP2Pns7dsGKvSlYEgqdvP8lIWzeTIuLGl
         Gu5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789048973; x=1789653773;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3pBmwNSWHN0yjp8GjiKNRVDKqbDamZhuMB1kehBa5sw=;
        b=BlNmBXy9a4OGnHESGzY7kT2Q1F8J+ZmBvx2osMZ3KEfCemJE7Up542oGdn/e2+62eh
         DnxFtqdSA9dq6MFZV6IyvmLFVZ/aFzwipI5EvoDRVQ3ZChOsdc4cqaf8U7kDLaNUJnBn
         mz1zCne5sjsptEPOj//Sj194q9NRMYX1JsJ7wC9rRsfB3UuiJv9PeLa6cfjIIG95Kdb/
         +SvSx7Aa/wJaS4d9To6lJuLUp0jDc6+NEuCnXAyd/lK1Zepi7DbE6LEqcVWDWTVS17mv
         cYyGt1WllAZfwyt39sUQ4XbuA8jj3eUKWh4jMdjDHo3HYT29A2MUlJrotRxOAegv+GxG
         u/2w==
X-Gm-Message-State: AFuF++l4B8hWtI+whKvHvN9sqphrDIJjnMGcoivx02udR9xYLTFAUEuI
	ur3LtdoQybBL9GAxu1q9I3es+VHLo8qbTsAd6fJsukcOVf7ZV67hBnMT0KcH4J8QuFY=
X-Gm-Gg: AYBFou1ID64Z9WAo29x+41gWSVAYuzOnijasaxmipEiBiPDoFmtmShDUDiX4u0Z6xmA
	NdWOHtX7Ei8sD2ty9O63ALx8RlT/dao6fC5Mq7wPc+IiIo/iHrRpZvNECGfEpTRtu/Qn38E0qIE
	ywArNagnh6A650zX+7DXeWVrfbvtMDcoMn/uSOjs8KUQ9lt/8cJWOFo6e0YgAcYHTlMe2JvWar5
	tdl4aeGhd9A4YpOcgvq71OBkJSVXb0l/2vsbJAevIDPc8+J72zj68Fo9k3yot7CYELJasooP/Ik
	KNEfemsQK7P8avAQt47MSaENHviD+NqHNw6HxbllB7/Ho2VtUQpcYwfwtkQZ+AjDHVh9269AL05
	NvK9eGkdGknI5Q222dUaPmwvA1AKXZ2aSXibEp5ykLgep/pIF0KG2ena+zsK4lUfBfaIc7eynEG
	i9nsHU9h0OaKzhwpbxhRgMPEWqxq7JIQOyQUdQXP/qlhWfEBlW2wuAM9va65NHwQxc8Xfron4+q
	Q/RYXhDUTR+AMtyA7fF+avtwcBYsXU8jTxJESwjUwxT1+1u
X-Received: by 2002:a17:907:3e90:b0:c29:448b:f5d0 with SMTP id a640c23a62f3a-c29448bfc23mr303337366b.33.1789048972875;
        Thu, 10 Sep 2026 07:02:52 -0700 (PDT)
Received: from cloudflare.com (79.184.140.212.ipv4.supernova.orange.pl. [79.184.140.212])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d4a98efsm937086466b.14.2026.09.10.07.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 07:02:52 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Thu, 10 Sep 2026 16:02:41 +0200
Subject: [PATCH net-next v2 06/14] selftests/bpf: Test skb_ext survival
 across veth and GRE
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-bpf-meta-inside-skb-ext-v2-6-0b21e42180b0@cloudflare.com>
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

Write skb_ext at TC egress and read it back at TC ingress after the
packet crosses device boundaries:

- survives_veth: veth forwarding between two netns
- survives_gre: GRE encap/decap between two gretap endpoints over
  loopback in a single netns

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 .../bpf/prog_tests/xdp_context_test_run.c          | 162 +++++++++++++++++++++
 1 file changed, 162 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
index f7617aef4d35..d7e81cddb55b 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -885,6 +885,164 @@ static void test_clone_redir_ext_write_after(struct test_xdp_meta *skel,
 	netns_free(ns);
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
+	int i;
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
+	if (!ASSERT_GT(rx_ifindex, 0, "if_nametoindex rx"))
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
+	if (!ASSERT_GT(tx_ifindex, 0, "if_nametoindex tx"))
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
+	/* Poll every 10 msec up to 1 sec */
+	for (i = 0; i < 100 && !skel->bss->test_pass; i++)
+		usleep(10000);
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
+	int i;
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
+	if (!ASSERT_GT(tx_ifindex, 0, "tx_ifindex"))
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
+	if (!ASSERT_GT(rx_ifindex, 0, "rx_ifindex"))
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
+	/* Poll every 10 msec up to 1 sec */
+	for (i = 0; i < 100 && !skel->bss->test_pass; i++)
+		usleep(10000);
+	ASSERT_TRUE(skel->bss->test_pass, "test_pass");
+
+close:
+	netns_free(ns);
+}
+
 void test_skb_ext_basic(void)
 {
 	struct test_xdp_meta *skel = NULL;
@@ -935,6 +1093,10 @@ void test_skb_ext_basic(void)
 	if (test__start_subtest("clone_redir_ext_slice_write_after"))
 		test_clone_redir_ext_write_after(skel,
 						 skel->progs.tc_skb_ext_slice_write_after_clone_redir);
+	if (test__start_subtest("survives_veth"))
+		test_skb_ext_scrub_veth(skel);
+	if (test__start_subtest("survives_gre"))
+		test_skb_ext_scrub_gre(skel);
 
 	test_xdp_meta__destroy(skel);
 }

-- 
2.43.0

