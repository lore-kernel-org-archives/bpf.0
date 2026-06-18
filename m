Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6470A37B3FD
	for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 18:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781806845; cv=none; b=RTSlDUFAZ/YkuIhJGxNeS7AZ97rtMCCCJj9tTtSCNPrmdKq5PpXq6NDQqg7NBxrWDwHJvhACZkbBYG1bjAebhg1o2ckhexmC8MWz9g2ie8kZuCr03e7+ykTWOmOKwQPZ/SXXvkXMFdhXQZ0yQmrUbi9BiTX5cxvwHUQHrrGERHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781806845; c=relaxed/simple;
	bh=8TW8CEh4uQDl1LPXXMpeWiZOcVMOrk56iUojbRyb1Y4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DPCTB06TmVg3yun1GLSUzLcgB8ONvyHKaLA2Sgb9JPHzR423/cieyjPmyQYfwjAcXelMGRtxb59NpXMTl4xQCNtht/wTIeXKFHxOOXae+ai848gDl31rWcz5ExZ9bXBXdbx25hpYPTCflUzDvA1Wu4DVc0Syo1ho0wUCUrmr9ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20251104.gappssmtp.com header.i=@jrife-io.20251104.gappssmtp.com header.b=YRid3r6h; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20251104.gappssmtp.com header.i=@jrife-io.20251104.gappssmtp.com header.b="YRid3r6h"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-30bc5fa5a2aso165070eec.0
        for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 11:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20251104.gappssmtp.com; s=20251104; t=1781806841; x=1782411641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BT2oq9gTrDaMMkE1yXo+V+1LVar+mTuItHPxWSCdycE=;
        b=YRid3r6haC34T3h3ix0fuq0b6t1xGEIu+O+SAUeJOhLE3u4HEr3NSCgNzXtmh0Jcqu
         xjQtKgdAWmAH6D1Hp2aRR8PT+8V7EjGFuheBP78oAP9yYBlKNc3OcyAxADdIxpuymG1B
         cO1DQ9aC/43Tx9KTP/sIwIUxM3GfGSZYfYwLChjwgegscNq6AZQLwOQ7xOw5AWeVVSIW
         VPoYYbEtJoeA1eZPyM9tFf2SFzyRbIe/zH+Yw8DSfuTWhYWuJR7iPj3XzUCOg82GjQ6M
         F9ANsXkAOYjD62f27YZ8EXYrDiDogiEfUXM8KHm6e6cQcRwzHtI5Fd/3JcMrWhj8qSlr
         eKxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781806841; x=1782411641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BT2oq9gTrDaMMkE1yXo+V+1LVar+mTuItHPxWSCdycE=;
        b=P/VajUWeZQnB4stcXLx3YvpMNhx7L+5iiPUeX/VaRptfl4GDF9mGa2g+3lqr0+tcg1
         BcEx02aW3vX5QzNS1j8BXMjOrmoxq64Es8G2kfLoLvIj5AieHi9ZxBYyNdX0i5CC5igl
         oO1lTVkCdBQ7YplXGIoWtt9V8YnJ/GrzWXSVL4NVK9bv3qcWm5CxRx2VxAiWgy98iESS
         QetRDOgJ36BHOhwHXVHRVP2rc3Kn3cL20asXkU3jm9kvywgm4TnpxyZyXMFJYXiz+vmX
         tfLhybi1hGlGFYXonNQdoHItebnFBrJUO9v8yqv7YvlkPN5OlWNp6Z9pZfN3Hg0ab9N0
         MK3Q==
X-Gm-Message-State: AOJu0Yyxf9WmVzBJRnDyos3bgyrs8UQdzubioawMd7Wl8ivayJN4pjor
	33/Qet8I5BWgVnD09dQgynyDMvWzjxyCwRG0FTlbjomUKZC6dHPAz2RifVMwQcnRcR1sOF4sotU
	gscbk
X-Gm-Gg: AfdE7ckp23TV51XWU4wbQarREBSOSMBQjR9MpFP2b0KMqND8VL8FpDgfeT55ATX9sfP
	eZiMqEIfP3+W5W19Q36VcRBMQ8DxUkyzLVOyXDwbMwe1lQomooUjh2NCQkgYuxCkXoB7Qb7Eped
	hdDHdhjfA0uzA03Cd7Ljde7ucAqpx0uTXg6kkVIGJ2X47L9Elmv61Ppo7DubBY9lsSZJwvx2n1u
	6z39ImqWtZnxibp7FOGaUqfPlJfEcMKpx/sk1lOdprUprxvE1FUZDxlTO9DiXykr4eZgw6uVWon
	MRYdXLa50RdpE/WKMYKXrScSOHu3ZRNdD3CYXfoJhaOIS5PS8ronZeJ+BgXKeZUj0SQBXZyGuZy
	aWOXqmz203NbzFKXiG+gxkvlNG903P4SOqyIinh6BbQfw6to63EMX48Tt3iF7iH97foe0eoR4Zq
	GT
X-Received: by 2002:a05:7301:4b16:b0:304:3c33:7afd with SMTP id 5a478bee46e88-30c06fea693mr160987eec.1.1781806841105;
        Thu, 18 Jun 2026 11:20:41 -0700 (PDT)
Received: from t14.. ([2001:5a8:47ec:d700:1b1d:38b6:64b7:ee72])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c06c33c88sm205950eec.19.2026.06.18.11.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 11:20:40 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	netdev@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Paul Chaignon <paul.chaignon@gmail.com>
Subject: [PATCH v2 bpf-next 2/2] selftests/bpf: Add tests for bpf_redirect_peer with BPF_F_EGRESS
Date: Thu, 18 Jun 2026 11:20:33 -0700
Message-ID: <20260618182035.43811-3-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260618182035.43811-1-jordan@jrife.io>
References: <20260618182035.43811-1-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend redirect tests to cover bpf_redirect_peer(BPF_F_EGRESS). SRC
redirects to DST using bpf_redirect_peer(BPF_F_EGRESS) then traffic is
hairpinned into DST using bpf_redirect.

Signed-off-by: Jordan Rife <jordan@jrife.io>
---
 .../selftests/bpf/prog_tests/tc_redirect.c    | 68 +++++++++++++++++++
 .../selftests/bpf/progs/test_tc_peer.c        | 22 ++++++
 2 files changed, 90 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
index 64fbda082309..af8968b89ad7 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
+++ b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
@@ -192,6 +192,8 @@ static int create_netkit(int mode, char *prim, char *peer)
 	req.n.nlmsg_len += sizeof(struct ifinfomsg);
 	addattr_l(&req.n, sizeof(req), IFLA_IFNAME, peer, strlen(peer));
 	addattr_nest_end(&req.n, peer_info);
+	addattr32(&req.n, sizeof(req), IFLA_NETKIT_SCRUB,
+		  NETKIT_SCRUB_NONE);
 	addattr_nest_end(&req.n, data);
 	addattr_nest_end(&req.n, linkinfo);
 
@@ -405,6 +407,24 @@ static int netns_load_bpf(const struct bpf_program *src_prog,
 	return -1;
 }
 
+static struct bpf_link *netns_attach_nk(const char *ns, int ifindex,
+					struct bpf_program *prog)
+{
+	LIBBPF_OPTS(bpf_netkit_opts, optl);
+	struct nstoken *nstoken = NULL;
+	struct bpf_link *link = NULL;
+
+	nstoken = open_netns(ns);
+	if (!ASSERT_OK_PTR(nstoken, "setns"))
+		goto cleanup;
+
+	link = bpf_program__attach_netkit(prog, ifindex, &optl);
+cleanup:
+	if (nstoken)
+		close_netns(nstoken);
+	return link;
+}
+
 static void test_tcp(int family, const char *addr, __u16 port)
 {
 	int listen_fd = -1, accept_fd = -1, client_fd = -1;
@@ -1082,6 +1102,53 @@ static void test_tc_redirect_peer(struct netns_setup_result *setup_result)
 	close_netns(nstoken);
 }
 
+static void test_tc_redirect_peer_ing(struct netns_setup_result *setup_result)
+{
+	struct test_tc_peer *skel;
+	struct nstoken *nstoken;
+	int err;
+
+	nstoken = open_netns(NS_FWD);
+	if (!ASSERT_OK_PTR(nstoken, "setns fwd"))
+		return;
+
+	skel = test_tc_peer__open();
+	if (!ASSERT_OK_PTR(skel, "test_tc_peer__open"))
+		goto done;
+
+	skel->rodata->IFINDEX_SRC = setup_result->ifindex_src_fwd;
+	skel->rodata->IFINDEX_DST = setup_result->ifindex_dst_fwd;
+	ASSERT_EQ(bpf_program__set_expected_attach_type(skel->progs.tc_src_ing,
+		  BPF_NETKIT_PRIMARY), 0, "src_prog_attach_type");
+	ASSERT_EQ(bpf_program__set_expected_attach_type(skel->progs.tc_dst_ing,
+		  BPF_NETKIT_PRIMARY), 0, "dst_prog_attach_type");
+
+	err = test_tc_peer__load(skel);
+	if (!ASSERT_OK(err, "test_tc_peer__load"))
+		goto done;
+
+	skel->links.tc_src_ing = netns_attach_nk(NS_SRC,
+						 setup_result->ifindex_src,
+						 skel->progs.tc_src_ing);
+	if (!ASSERT_OK_PTR(skel->links.tc_src_ing, "attach_src"))
+		goto done;
+	skel->links.tc_dst_ing = netns_attach_nk(NS_DST,
+						 setup_result->ifindex_dst,
+						 skel->progs.tc_dst_ing);
+	if (!ASSERT_OK_PTR(skel->links.tc_dst_ing, "attach_dst"))
+		goto done;
+
+	if (!ASSERT_OK(set_forwarding(false), "disable forwarding"))
+		goto done;
+
+	test_connectivity();
+
+done:
+	if (skel)
+		test_tc_peer__destroy(skel);
+	close_netns(nstoken);
+}
+
 static int tun_open(char *name)
 {
 	struct ifreq ifr;
@@ -1280,6 +1347,7 @@ static void *test_tc_redirect_run_tests(void *arg)
 
 	RUN_TEST(tc_redirect_peer, MODE_VETH);
 	RUN_TEST(tc_redirect_peer, MODE_NETKIT);
+	RUN_TEST(tc_redirect_peer_ing, MODE_NETKIT);
 	RUN_TEST(tc_redirect_peer_l3, MODE_VETH);
 	RUN_TEST(tc_redirect_peer_l3, MODE_NETKIT);
 	RUN_TEST(tc_redirect_neigh, MODE_VETH);
diff --git a/tools/testing/selftests/bpf/progs/test_tc_peer.c b/tools/testing/selftests/bpf/progs/test_tc_peer.c
index 365eacb5dc34..cfb9ef7f467c 100644
--- a/tools/testing/selftests/bpf/progs/test_tc_peer.c
+++ b/tools/testing/selftests/bpf/progs/test_tc_peer.c
@@ -34,6 +34,28 @@ int tc_src(struct __sk_buff *skb)
 	return bpf_redirect_peer(IFINDEX_DST, 0);
 }
 
+SEC("tc")
+int tc_dst_ing(struct __sk_buff *skb)
+{
+	if (!skb->mark) {
+		skb->mark = 0x1;
+		return bpf_redirect_peer(IFINDEX_SRC, BPF_F_EGRESS);
+	}
+
+	return bpf_redirect(IFINDEX_DST, 0);
+}
+
+SEC("tc")
+int tc_src_ing(struct __sk_buff *skb)
+{
+	if (!skb->mark) {
+		skb->mark = 0x1;
+		return bpf_redirect_peer(IFINDEX_DST, BPF_F_EGRESS);
+	}
+
+	return bpf_redirect(IFINDEX_SRC, 0);
+}
+
 SEC("tc")
 int tc_dst_l3(struct __sk_buff *skb)
 {
-- 
2.43.0

