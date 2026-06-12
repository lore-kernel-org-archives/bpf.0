Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9593EB7F0
	for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 11:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781264471; cv=none; b=SORIK4SGUb5vlageEEFdMUc/oojT6nzBheePxXLBQSUfjCdEaGwcYqMPE3fJqNeG7GXS7rQdBd57Z2ztsNdkRzd5CkTmO28qXJeiYAtVwBeJ07HYOcX8qOw7vpByDhnzTiCbkSaFo8BbV2u7IrpARSfMKwvuqpRQ1GaF6Qw0zko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781264471; c=relaxed/simple;
	bh=huaKkF4OiakemF/G5xWufP2q3bw29Ry5/D4MKYONanA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pyK9HlFURimQJMk2RP5w8FXqm+yPc0D2L061mewLWNM2eb8/dyo2Bf1YEb9UQ5nKrhG6cVkCCOZbqLNkyS5gBqB0bBUZoSgJqh/c6JZGttzZ6XNO5I3rmqiCcpgPqyzM2BGN8u2ormp1QqddRVjxx7xN2ngTZaQM/ZycRT59Zpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oGweB2aj; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oGweB2aj"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-36d98b68d68so598196a91.2
        for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 04:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781264468; x=1781869268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WSlICPsYDJ4jrvEuREacBilLreADCVqW54GB3CcEXOQ=;
        b=oGweB2ajY3TcvkPOocH3D3BDZjyqR27g12SU/Zb4eGozEgyTaStJpgZHtEwTHULWZY
         fR34Tv1rfYJR/aa0zKEd4pt+yPRKBHJKNUGm8Hdd29fey3artIt3KRgt5J7/phSpbDkT
         UF9R3GrMVYnLT2RyoXHx3gkoH6k5wMOt2bUvur2mzV2PcwY789YveU5+tXRx66/Df8aY
         mDU4//fE6ZgYaQCfZ0o24dqOCbALaDs6VBLjkabDuCzeEWuOLi4GYnXPLWYyPqavS2TB
         q5tKiaYYV2VHSG8l9IaW0+dYQmdtNkXjhtspkRdc7el2qT6HK6A+qVAhzPLhNhRuf80o
         Rc/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781264468; x=1781869268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WSlICPsYDJ4jrvEuREacBilLreADCVqW54GB3CcEXOQ=;
        b=Vn3PykuNOAgXYo/BsgqtNzrOJ4ua1YP608CQCEatXLcMJZEa1dMmZIZdwiSpWwe91z
         igXOuxSoIBsIoEogLb+Ceyeyodr8Yr6PkL13cZ1T3kXEBCw7B4LXvZfuhB5eT1RnedM3
         rZzC9+y/BfkKb/UjUASwrDq9MwznxHAWM7wV9oMMB70d7LaNBFhdu52km/tQydz9CtXc
         IzVypoE/jEgKj4L0xOpLR/+XC/UwAy8MKSMz9xLZktHU3UQyJkwVnY4sdn9oscOz2Rvr
         wmlxCLAW/UGP39iF6NhRItcS12Q+2d17s5Udu1wTYFv/9Fw69h61fcwr9W1eMwYNEoja
         oBJw==
X-Gm-Message-State: AOJu0Yzn++QknCc5ZQaFJkz+bKN5q2nRZ3LZdJfCT5g22s7yNFZ+ysQ4
	gX6Qr3usXflpcmcCw3GNsoz0TSzFt7wRSTV16lMMPSa6VgiJJVu976hxOsOKxwQXu3o=
X-Gm-Gg: Acq92OEJoVf1Ko+biLIzjRRp/gA8EXE/RdNko9/SrDeL/u9GBorLaSFf1RzzCtfJjNj
	A7gKBoJIULa/WLUcb/VwLAqfdtSi8RDgtpDe/KZQlrD3br2RkrQ+0yLYuSMgMLxYfD7wC+diloF
	oddT1qxZfwRJGjxcev4xWE1UsVPbjjORw5MlijuZd56xk/Ye5cOLiGgw/WbLmazZV6MkA/LKIzT
	+JpzeEuY9TJgi7X7PqAFmE6Uy3gosbbD87BRZn8xtkl5zCl4QO6lVypMVOUvS4uVGNq/G3Pb4ea
	17coRqZVA0sWfThKaJReBS7k1ENz0cCFu1DfRAC2qEqigkzcsA7J76TqIJzsBUch7/edrsx0vdX
	zOh4cPeoCNz6KQB6jG7NXK+JnXPSjW0bLwR9o0aCWDGJYdfdEKDtaAD6xUdllaOwrWZ7PgqgiPv
	R3N2GFShDhZXJk4lpmj1WS4QwdjXfwbROtHfXL3oYUbf90wsk55GR24DoUkjZ6Hu/uIhweA+JaS
	Q9rUzWrN4L3
X-Received: by 2002:a17:903:46cc:b0:2c0:ccdb:e023 with SMTP id d9443c01a7336-2c41255db98mr29606425ad.17.1781264468386;
        Fri, 12 Jun 2026 04:41:08 -0700 (PDT)
Received: from localhost.localdomain ([45.142.165.58])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4327ac72asm20697455ad.38.2026.06.12.04.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 04:41:08 -0700 (PDT)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	davem@davemloft.net,
	kuba@kernel.org,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	shuah@kernel.org,
	jiayuan.chen@linux.dev,
	toke@redhat.com,
	menglong.dong@linux.dev,
	emil@etsalapatis.com,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH bpf v5 2/2] selftests/bpf: Cover generic devmap egress last-dst rewrite
Date: Fri, 12 Jun 2026 19:40:32 +0800
Message-ID: <20260612114032.244616-3-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260612114032.244616-1-sun.jian.kdev@gmail.com>
References: <20260612114032.244616-1-sun.jian.kdev@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Strengthen xdp_veth_egress to check that each destination observes the
MAC selected for its own egress ifindex, instead of only checking that
the observed MAC differs from a single magic value.

Add a generic XDP last-destination test where an earlier destination does
not have a devmap egress program while the final destination does. This
covers the case where the final destination runs on the original skb and
could otherwise rewrite packet data still shared with an earlier cloned
skb.

Use deterministic DEVMAP_HASH keys for the egress map so the intended
last destination is stable. Initialize the result map with a sentinel
value and check that store_mac_1 overwrites it before checking that the
earlier destination did not observe the MAC written by the final
destination.

Suggested-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
---
 .../selftests/bpf/prog_tests/test_xdp_veth.c  | 166 +++++++++++++++++-
 1 file changed, 163 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c b/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c
index 3e98a1665936..1675b32753a8 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c
@@ -456,7 +456,11 @@ static void xdp_veth_egress(u32 flags)
 			.remote_flags = flags,
 		}
 	};
-	const char magic_mac[6] = { 0xAA, 0xBB, 0xCC, 0xDD, 0xEE, 0xFF};
+	const unsigned char egress_macs[VETH_PAIRS_COUNT][ETH_ALEN] = {
+		{ 0xAA, 0xBB, 0xCC, 0xDD, 0xEE, 0x01 },
+		{ 0xAA, 0xBB, 0xCC, 0xDD, 0xEE, 0x02 },
+		{ 0xAA, 0xBB, 0xCC, 0xDD, 0xEE, 0x03 },
+	};
 	struct xdp_redirect_multi_kern *xdp_redirect_multi_kern;
 	struct bpf_object *bpf_objs[VETH_EGRESS_SKEL_NB];
 	struct xdp_redirect_map *xdp_redirect_map;
@@ -512,7 +516,13 @@ static void xdp_veth_egress(u32 flags)
 						 &net_config, prog_cfg, i))
 			goto destroy_xdp_redirect_map;
 
-		err = bpf_map_update_elem(mac_map, &ifindex, magic_mac, 0);
+		{
+			__be64 mac = 0;
+
+			memcpy(&mac, egress_macs[i], ETH_ALEN);
+			err = bpf_map_update_elem(mac_map, &ifindex, &mac, 0);
+		}
+
 		if (!ASSERT_OK(err, "bpf_map_update_elem"))
 			goto destroy_xdp_redirect_map;
 
@@ -531,15 +541,162 @@ static void xdp_veth_egress(u32 flags)
 
 	for (i = 0; i < 2; i++) {
 		u32 key = i;
+		__be64 expected = 0;
 		u64 res;
 
 		err = bpf_map_lookup_elem(res_map, &key, &res);
 		if (!ASSERT_OK(err, "get MAC res"))
 			goto destroy_xdp_redirect_map;
 
-		ASSERT_STRNEQ((const char *)&res, magic_mac, ETH_ALEN, "compare mac");
+		/* store_mac_1/2 run on the second/third remote veths. */
+		memcpy(&expected, egress_macs[i + 1], ETH_ALEN);
+		ASSERT_EQ(res, expected, "compare mac");
+	}
+
+destroy_xdp_redirect_map:
+	close_netns(nstoken);
+	xdp_redirect_map__destroy(xdp_redirect_map);
+destroy_xdp_redirect_multi_kern:
+	xdp_redirect_multi_kern__destroy(xdp_redirect_multi_kern);
+destroy_xdp_dummy:
+	xdp_dummy__destroy(xdp_dummy);
+
+	cleanup_network(&net_config);
+}
+
+static void xdp_veth_egress_last_dst(u32 flags)
+{
+	struct prog_configuration prog_cfg[VETH_PAIRS_COUNT] = {
+		{
+			.local_name = "xdp_redirect_map_all_prog",
+			.remote_name = "xdp_dummy_prog",
+			.local_flags = flags,
+			.remote_flags = flags,
+		},
+		{
+			.local_name = "xdp_redirect_map_all_prog",
+			.remote_name = "store_mac_1",
+			.local_flags = flags,
+			.remote_flags = flags,
+		},
+		{
+			.local_name = "xdp_redirect_map_all_prog",
+			.remote_name = "xdp_dummy_prog",
+			.local_flags = flags,
+			.remote_flags = flags,
+		}
+	};
+	const unsigned char egress_macs[VETH_PAIRS_COUNT][ETH_ALEN] = {
+		{ 0xAA, 0xBB, 0xCC, 0xDD, 0xEE, 0x01 },
+		{ 0xAA, 0xBB, 0xCC, 0xDD, 0xEE, 0x02 },
+		{ 0xAA, 0xBB, 0xCC, 0xDD, 0xEE, 0x03 },
+	};
+	struct xdp_redirect_multi_kern *xdp_redirect_multi_kern;
+	struct bpf_object *bpf_objs[VETH_EGRESS_SKEL_NB];
+	struct xdp_redirect_map *xdp_redirect_map;
+	struct net_configuration net_config = {};
+	int mac_map, egress_map, res_map;
+	struct nstoken *nstoken = NULL;
+	struct xdp_dummy *xdp_dummy;
+	__be64 sentinel_mac = 0;
+	__be64 last_mac = 0;
+	__be64 res;
+	u32 key;
+	int err;
+	int i;
+
+	xdp_dummy = xdp_dummy__open_and_load();
+	if (!ASSERT_OK_PTR(xdp_dummy, "xdp_dummy__open_and_load"))
+		return;
+
+	xdp_redirect_multi_kern = xdp_redirect_multi_kern__open_and_load();
+	if (!ASSERT_OK_PTR(xdp_redirect_multi_kern, "xdp_redirect_multi_kern__open_and_load"))
+		goto destroy_xdp_dummy;
+
+	xdp_redirect_map = xdp_redirect_map__open_and_load();
+	if (!ASSERT_OK_PTR(xdp_redirect_map, "xdp_redirect_map__open_and_load"))
+		goto destroy_xdp_redirect_multi_kern;
+
+	if (!ASSERT_OK(create_network(&net_config), "create network"))
+		goto destroy_xdp_redirect_map;
+
+	mac_map = bpf_map__fd(xdp_redirect_multi_kern->maps.mac_map);
+	if (!ASSERT_OK_FD(mac_map, "open mac_map"))
+		goto destroy_xdp_redirect_map;
+
+	egress_map = bpf_map__fd(xdp_redirect_multi_kern->maps.map_egress);
+	if (!ASSERT_OK_FD(egress_map, "open map_egress"))
+		goto destroy_xdp_redirect_map;
+
+	bpf_objs[0] = xdp_dummy->obj;
+	bpf_objs[1] = xdp_redirect_multi_kern->obj;
+	bpf_objs[2] = xdp_redirect_map->obj;
+
+	nstoken = open_netns(net_config.ns0_name);
+	if (!ASSERT_OK_PTR(nstoken, "open NS0"))
+		goto destroy_xdp_redirect_map;
+
+	for (i = 0; i < VETH_PAIRS_COUNT; i++) {
+		struct bpf_devmap_val devmap_val = {};
+		int ifindex = if_nametoindex(net_config.veth_cfg[i].local_veth);
+		u32 key = i;
+
+		SYS(destroy_xdp_redirect_map,
+		    "ip -n %s neigh add %s lladdr 00:00:00:00:00:01 dev %s",
+		    net_config.veth_cfg[i].namespace, IP_NEIGH,
+		    net_config.veth_cfg[i].remote_veth);
+
+		if (attach_programs_to_veth_pair(bpf_objs, VETH_EGRESS_SKEL_NB,
+						 &net_config, prog_cfg, i))
+			goto destroy_xdp_redirect_map;
+
+		{
+			__be64 mac = 0;
+
+			memcpy(&mac, egress_macs[i], ETH_ALEN);
+			err = bpf_map_update_elem(mac_map, &ifindex, &mac, 0);
+		}
+
+		if (!ASSERT_OK(err, "bpf_map_update_elem"))
+			goto destroy_xdp_redirect_map;
+
+		devmap_val.ifindex = ifindex;
+		devmap_val.bpf_prog.fd = -1;
+
+		if (i == VETH_PAIRS_COUNT - 1)
+			devmap_val.bpf_prog.fd =
+				bpf_program__fd(xdp_redirect_multi_kern->progs.xdp_devmap_prog);
+
+		err = bpf_map_update_elem(egress_map, &key, &devmap_val, 0);
+		if (!ASSERT_OK(err, "bpf_map_update_elem"))
+			goto destroy_xdp_redirect_map;
 	}
 
+	res_map = bpf_map__fd(xdp_redirect_map->maps.rx_mac);
+	if (!ASSERT_OK_FD(res_map, "open rx_map"))
+		goto destroy_xdp_redirect_map;
+
+	memcpy(&sentinel_mac, egress_macs[VETH_PAIRS_COUNT - 1], ETH_ALEN);
+	memcpy(&last_mac, egress_macs[VETH_PAIRS_COUNT - 1], ETH_ALEN);
+
+	key = 0;
+	err = bpf_map_update_elem(res_map, &key, &sentinel_mac, 0);
+	if (!ASSERT_OK(err, "init rx mac"))
+		goto destroy_xdp_redirect_map;
+
+	SYS_NOFAIL("ip netns exec %s ping %s -i 0.1 -c 4 -W1 > /dev/null ",
+		   net_config.veth_cfg[0].namespace, IP_NEIGH);
+
+	err = bpf_map_lookup_elem(res_map, &key, &res);
+	if (!ASSERT_OK(err, "get MAC res"))
+		goto destroy_xdp_redirect_map;
+
+	if (!ASSERT_NEQ(res, sentinel_mac, "rx_mac overwritten by store_mac_1"))
+		goto destroy_xdp_redirect_map;
+
+	if (!ASSERT_NEQ(res, last_mac, "earlier dst not rewritten by last dst"))
+		goto destroy_xdp_redirect_map;
+
 destroy_xdp_redirect_map:
 	close_netns(nstoken);
 	xdp_redirect_map__destroy(xdp_redirect_map);
@@ -596,4 +753,7 @@ void test_xdp_veth_egress(void)
 
 	if (test__start_subtest("SKB_MODE/egress"))
 		xdp_veth_egress(XDP_FLAGS_SKB_MODE);
+
+	if (test__start_subtest("SKB_MODE/egress_last_dst"))
+		xdp_veth_egress_last_dst(XDP_FLAGS_SKB_MODE);
 }
-- 
2.43.0

