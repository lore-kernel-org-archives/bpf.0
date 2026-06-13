Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAE323D7CE
	for <bpf@vger.kernel.org>; Sat, 13 Jun 2026 18:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781375678; cv=none; b=SM3duh+CwtUQYINog+x1X1Wej9+RaosXW7J4kIrJEnahtByOkHfn9QdcXsT2+beDkvwjPkzISMg5XnDQQ42bcWlsHqlcw26mtZf/c7hpuJS70MqCdO+GE+sb5lZ9gQUgLuaKrvTYN6Gv27rOIBQgqaONwfK3B34BvDbcaQ0TqFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781375678; c=relaxed/simple;
	bh=GAKLF6aJLsrCYkl7Wo8RMDaiJFXvHtwXW6Fc3rVfCck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fVJ3dDodRYw/7sA2a6mMKVH6ho4zgYZeXl9kH9ebW1/W52CmkZgEgvktHYX5QxsbygNLjvApj6WyW6eI9uxXiV4wi7WQNdCcCLiLVU9wuoGtPbJpwt2sz95YnqhAea/Jc+5Ef3Ggo2QrjvJkw/dzTyPk2AVzMi3LLD79oTs/exg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20251104.gappssmtp.com header.i=@jrife-io.20251104.gappssmtp.com header.b=HdhOnMAm; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20251104.gappssmtp.com header.i=@jrife-io.20251104.gappssmtp.com header.b="HdhOnMAm"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-304da3b4508so253358eec.2
        for <bpf@vger.kernel.org>; Sat, 13 Jun 2026 11:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20251104.gappssmtp.com; s=20251104; t=1781375677; x=1781980477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yVRa8MFqgEcIxTeX5DcRDdMMa2fq5Bm7zRkC5sjv8Ls=;
        b=HdhOnMAmMZ4UwlWs4b0beZGyoJ9232KwVD1bLiyLKl12vpVkvEfJU75vLSNMrelIZN
         kaFx568M4A/FamZWg44rTYUTyfliXL6olKmovUkUm7HaIRagz9I3NdRgyhijgjVg45Wg
         dQCSwxpFF+OuBJAE2KPKCsoiUcG7RYsZSQoLAK9xcuh7j1sIVbWBCmAt8GEndCU3wO0b
         yJwq1OyqTkKJP6qmZXr4cdQhZiOwSVxi563a6RHtW8QDsotXKbu4OamPv7RsIn61H18Z
         V/GNxWSdqprvSWo13LnWPhAOiZavQ/oHhq29sEIQDXhnYPgwqr3H81d+hWVDXp+/4uWb
         vWvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781375677; x=1781980477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yVRa8MFqgEcIxTeX5DcRDdMMa2fq5Bm7zRkC5sjv8Ls=;
        b=r61a+qfM8c1Yx5i4UmLKcU8gt7Ot/hQPOWl7bs/HbQFhcIZcWiQBUpF2R/qKQv0M4O
         mfy0p23wjAZf3mm2O9SnAc4NoqAMxsRlGbB8/dhzoM7fs/rAOOjAC85i5NV+FNblKYY7
         1b+dkWHEkR3lE3IV5V1B13ja6fX9lreMNcj6188h8Vzv3UM6tzwGQLtr+VveViq/ziCK
         BS7KP8utesIXgG90T5OmZa71Ow+QHLUxYKnIechVo0QBNFptDuRY3CN/9vFfXsE+5YGM
         kZK0XQHPJtjURkVRbzY9mbwGNAnJu+82unlTDQ7njzg7AXypEFPplI/wxkO8eEhJ9xYd
         gS6A==
X-Gm-Message-State: AOJu0YxqMPByESoFhLqnOKhn0tLOD01ULDm7m3iNQPB9SZo0ldZV8+8i
	UOHuq8o4+mfnunjNNKyiq5gV7lP02O/qpKzFX62q49Q8G/TjQcSk58m8Zqg8UXYao21ZknOBLcH
	8dEfw
X-Gm-Gg: Acq92OE3ow7wvq1L1aZud58T02TOKmR6y6WkWp+LmKqfGWrAwrt9CbFaBOdYlp0aJI1
	B0svMmyYLq2cfrkEIIgdyHJ8mjFkvqI6dEI9QAQy/v9L/EBkfJH5kF0GXsS42iki6yMoXt0fIqd
	G/BQM2f/Vn/yJI14NkSoZWWZzp36820dYOkWjvi+zSbqLtDP2c6zO7CPLUpL+Q4Hu/DZqkmI5XP
	BobVvy/41mpfxj1VIwvl4Z+02ch566C11RE3VcSzd8kCLer/uyPHHVkbh0AL/BTAzv+LOs4i3gq
	j899PEJdm4ZQUKRfnXcypQvHrrdJrFJ4RtmlAN5SgZJCLUyb7FfAZfjPZvrQHbHHhcA8o8ZPCoO
	GDHNX2F2czTbOa7NGZMbGtaR05ocLzGupsC54EOAcavaW3Hzz60mjHQq0Qwjnkd1ZrTEFLT6376
	Efdmn+xZnjeMw=
X-Received: by 2002:a05:7300:640e:b0:2e5:faa9:ca76 with SMTP id 5a478bee46e88-308200bc9fbmr1859223eec.7.1781375676545;
        Sat, 13 Jun 2026 11:34:36 -0700 (PDT)
Received: from t14.. ([2001:5a8:47ec:d700:7881:81f1:548c:e2d3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e48e412sm9181543eec.4.2026.06.13.11.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 11:34:36 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	netdev@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: [PATCH v1 bpf-next 2/2] selftests/bpf: Add tests for bpf_redirect_peer with BPF_F_INGRESS
Date: Sat, 13 Jun 2026 11:34:06 -0700
Message-ID: <20260613183424.1198073-3-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260613183424.1198073-1-jordan@jrife.io>
References: <20260613183424.1198073-1-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend redirect tests to cover bpf_redirect_peer(BPF_F_INGRESS). SRC
redirects to DST using bpf_redirect_peer(BPF_F_INGRESS) then traffic is
hairpinned into DST using bpf_redirect(BPF_F_INGRESS).

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
index 365eacb5dc34..1f2345f05fcd 100644
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
+		return bpf_redirect_peer(IFINDEX_SRC, BPF_F_INGRESS);
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
+		return bpf_redirect_peer(IFINDEX_DST, BPF_F_INGRESS);
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

