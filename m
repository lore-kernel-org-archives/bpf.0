Received: from mail-ed2-f35.google.com (mail-ed2-f35.google.com [74.125.228.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227F44AF17E
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 11:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790595635; cv=none; b=L373nic7lkhkPXX59hbvdw6LySmt/yyKVHkdVWhc3//IC95bYVUkJugGzD0VLWz5UqYFsXAgylcNvU7pgRPslGEbxn2m6t/F6ZLIXoOmPdP9MTdr62QPNZcDyjDVTgTB5uiKBymqbVpOTA6H1Aj/Hek02mW/vGDBW92qQxXr09s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790595635; c=relaxed/simple;
	bh=g6EVWnm52NHn3HVCEViqVgeLHHPOgD9nrXiavo+aWv4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QpbvKlcM9fXDtFIcx7H7kgh0PKpzhoB0Cr1szJJ2jtxNqzKSCs6w2XpMYQa7QSy0Tg6sd+cqkr3vy84aiR6IIc1epMtbWI9+9w8Y4Kh2PByFzOm01nOkXCKmmIPBsO108ZqKZOFmyq5Uyj9EuorAZpXZ+7BdKKTQG6HegNV+Z0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Ni9ARtre; arc=none smtp.client-ip=74.125.228.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Ni9ARtre"
Received: by mail-ed2-f35.google.com with SMTP id 4fb4d7f45d1cf-6aaeeacce15so4040522a12.1
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 04:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1790595631; x=1791200431; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M5+H6FPF3XGvaw9tYBI8EyPTLFuYfrRv5EG1kCVWTG4=;
        b=Ni9ARtreRcYIwwiQ9Un6yT9296aUYrvZGUN69j8ZSWZ5H5iISZim001RVBmcDpOblH
         TgibZApmnKMnioqM9jacxGysZ1h3rYuYCo7e/PU12BAltpHh97BhV5CnWK/M4S5fCp/D
         aKmbWpI7exLpqiDLK0YOQ6O7V4MiUm4qJcBhHiXuwNzHF1AsHGit7p02ueKHdgBxhTxr
         JfIeD0isXeapV71K4RaADIpawWkKvWEFGPLgQtxncV8+3Zf2RxgNrPEsUeaaT6y5t7wz
         mAk7ucYp/qct7usG/FWoJOkw73bWsPwvOo/3K2xWb+l6gbI6FufLj/5s3UlN5Qj1aU42
         +B0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790595631; x=1791200431;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M5+H6FPF3XGvaw9tYBI8EyPTLFuYfrRv5EG1kCVWTG4=;
        b=osSaFOG3LwBPldLNgiomB6VboYChguJQAXOgXVIsPGoBJjsssZ2Lzz7mLo1XLFJcw8
         QbTDAJXtxDHUwTP/RnQa9M5uCvvY9lapYxuQPH2E/fv/QhvKJErhl82cpWrvPSM3+ZdI
         6VDtngQXJOZAOhHgbBMXfHpno8jjBuWO9C0dmB0F7RFXv3CZhF+V6uL+ccsNEBJp2cJN
         riChtoBQqML20B3QndaCvnlPKNBEGoleQIuMUIWSXd42CkDFqeV5NteCsrkLr3vbysFj
         sf6iRiATwP6KqDoBjE7xN9zr/Bwn0RomxUJ3weUL6CXiIa+HLQ87QqPeuxU52Ni2J0MF
         6bjA==
X-Gm-Message-State: AFuF++loUj1ou3c9JH0HtI/oyYnOq52bbay53Mk27eitJGSR1Q0SDEWM
	rUwyAfOrBzoEIgWEOUT21DBrqfpvMzak2bR2WdbAHQJ3qGGpOOfkHBdSNV28GW9x+IQ=
X-Gm-Gg: AYBFou0bA9xhpcWisxZWl0JqC6Y9LIki5R2L04x75pXUAXqkxMcILdjC5ipmXOYtiLv
	+qnrBP1+uGfBct1yFB1l8mrXKgdWhZt0iQUUYpmyAHkxcuIKKyPmv/Lr04wcN6t3pBa8jrbnsqq
	pjLkiQGBlqrAVR15AiZ1FB4TMf9NVA1bq86hviVBGiYgR8ftVynhAeDzj36cLmInoE1+QDy3bjJ
	Ahm/pexizazkkuSkrQThow4iQOGuPyfQlw+eK7WnZhaosvPnXAEpFCvLlI9e+T3iqzNIUnX5wCW
	noLlRV63tOl7Fl1rewniTeg4oE1W6bMaPurPE3HD8gMEP6cueGz+tsQEwXy+/k3Ntm7IWCbnwId
	DNqHiWUhm/q7gWrMCiQjPed76G1NeSf3wpqP0NPhXb8hYsNw2WqNpg1hko00ZuDpBKMuo3fhisf
	bcp87QI2yVsnwBlAe1HjmkXR9c3fdfSdag8oZQQeSVKKiuMpDDlbP6zVwF+o9nO1v0AZKcMn7Lv
	gt5EUOTVVZ5nf7TBhKPgBG4MHZz8qoPr7lOFUt9G98OkedO4TwsTWVsH3nPOQQhVTC9d4A7hwq3
	0VCixcPWeKfm
X-Received: by 2002:a17:906:f588:b0:c26:1648:a065 with SMTP id a640c23a62f3a-c2ac24ba0demr1120420366b.32.1790595631333;
        Mon, 28 Sep 2026 04:40:31 -0700 (PDT)
Received: from cloudflare.com (2a01-110f-491b-1300-c0dd-2af4-566b-b23f.aa.ipv6.supernova.orange.pl. [2a01:110f:491b:1300:c0dd:2af4:566b:b23f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2dbd3bcac3sm257134666b.73.2026.09.28.04.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 04:40:30 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 28 Sep 2026 13:40:23 +0200
Subject: [PATCH net-next 06/15] selftests/bpf: Test passing metadata across
 veth and GRE
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-bpf-meta-gated-tracepoints-v1-6-844dbf3e1edf@cloudflare.com>
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

Stash metadata at TC egress and read it back at TC ingress after the packet
crosses device boundaries, relying on the gated skb tracepoints to reclaim
the stash once the packet is freed:

- survives_veth: veth forwarding between two netns
- survives_gre: GRE encap/decap between two gretap endpoints over loopback

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 .../bpf/prog_tests/xdp_context_test_run.c          | 190 +++++++++++++++++++++
 1 file changed, 190 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
index c9b115c14acb..1155e868ffbd 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -833,6 +833,192 @@ static void test_skb_trace__mirred_clone(struct test_xdp_meta *skel)
 	netns_free(ns);
 }
 
+/* Test if skb_ext survives veth cross-netns forward */
+static void test_skb_trace__veth(struct test_xdp_meta *skel)
+{
+	LIBBPF_OPTS(bpf_tc_hook, tx_hook, .attach_point = BPF_TC_EGRESS);
+	LIBBPF_OPTS(bpf_tc_opts, tx_opts, .handle = 1, .priority = 1);
+	LIBBPF_OPTS(bpf_tc_hook, rx_hook, .attach_point = BPF_TC_INGRESS);
+	LIBBPF_OPTS(bpf_tc_opts, rx_opts, .handle = 1, .priority = 1);
+	struct netns_obj *rx_ns = NULL, *tx_ns = NULL;
+	struct bpf_link *put_link = NULL;
+	struct nstoken *nstoken = NULL;
+	int rx_ifindex, tx_ifindex;
+	int ret;
+	int i;
+
+	put_link = bpf_program__attach(skel->progs.skb_free);
+	if (!ASSERT_OK_PTR(put_link, "put_attach"))
+		return;
+
+	tx_ns = netns_new(TX_NETNS, false);
+	if (!ASSERT_OK_PTR(tx_ns, "create tx_ns"))
+		goto close;
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
+	rx_opts.prog_fd = bpf_program__fd(skel->progs.tc_meta_read);
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
+	tx_opts.prog_fd = bpf_program__fd(skel->progs.tc_meta_write);
+	ret = bpf_tc_attach(&tx_hook, &tx_opts);
+	if (!ASSERT_OK(ret, "bpf_tc_attach tx"))
+		goto close;
+
+	skel->bss->test_pass = false;
+	skel->bss->free_count = 0;
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
+	/* Skb is freed after RX delivery; wait for free tp */
+	for (i = 0; i < 100 && !skel->bss->free_count; i++)
+		usleep(10000);
+	ASSERT_GE(skel->bss->free_count, 1, "free_count");
+
+	assert_meta_stash_empty(skel->maps.meta_map);
+
+close:
+	bpf_link__destroy(put_link);
+	close_netns(nstoken);
+	netns_free(rx_ns);
+	netns_free(tx_ns);
+}
+
+/* Test if skb_ext survives GRE tunnel encap+decap */
+static void test_skb_trace__gre(struct test_xdp_meta *skel)
+{
+	LIBBPF_OPTS(bpf_tc_hook, tx_hook, .attach_point = BPF_TC_EGRESS);
+	LIBBPF_OPTS(bpf_tc_opts, tx_opts, .handle = 1, .priority = 1);
+	LIBBPF_OPTS(bpf_tc_hook, rx_hook, .attach_point = BPF_TC_INGRESS);
+	LIBBPF_OPTS(bpf_tc_opts, rx_opts, .handle = 1, .priority = 1);
+	struct bpf_link *put_link = NULL;
+	struct netns_obj *ns = NULL;
+	int tx_ifindex;
+	int rx_ifindex;
+	int ret;
+	int i;
+
+	put_link = bpf_program__attach(skel->progs.skb_free);
+	if (!ASSERT_OK_PTR(put_link, "put_attach"))
+		return;
+
+	ns = netns_new("gre_test", true);
+	if (!ASSERT_OK_PTR(ns, "netns_new"))
+		goto close;
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
+	tx_opts.prog_fd = bpf_program__fd(skel->progs.tc_meta_write);
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
+	rx_opts.prog_fd = bpf_program__fd(skel->progs.tc_meta_read);
+	ret = bpf_tc_attach(&rx_hook, &rx_opts);
+	if (!ASSERT_OK(ret, "rx_attach"))
+		goto close;
+
+	/* Then use send_test_packet on GRE tx */
+	skel->bss->test_pass = false;
+	skel->bss->free_count = 0;
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
+	/* Skb is freed after RX delivery; wait for free tp */
+	for (i = 0; i < 100 && !skel->bss->free_count; i++)
+		usleep(10000);
+	ASSERT_GE(skel->bss->free_count, 1, "free_count");
+
+	assert_meta_stash_empty(skel->maps.meta_map);
+
+close:
+	bpf_link__destroy(put_link);
+	netns_free(ns);
+}
+
 void test_skb_trace_basic(void)
 {
 	struct test_xdp_meta *skel = NULL;
@@ -845,6 +1031,10 @@ void test_skb_trace_basic(void)
 		test_skb_trace__tuntap(skel);
 	if (test__start_subtest("clone_read"))
 		test_skb_trace__mirred_clone(skel);
+	if (test__start_subtest("survives_veth"))
+		test_skb_trace__veth(skel);
+	if (test__start_subtest("survives_gre"))
+		test_skb_trace__gre(skel);
 
 	test_xdp_meta__destroy(skel);
 }

-- 
2.43.0

