Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E464834C140
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 04:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781152429; cv=none; b=BVz5J4MJsU6uApPhH/cyFComsI+6TLV9IXZuFVUzQtG9NZh1PDO/hwedWa7dc9oZlqhWpDfMBUv9LWUS66STtpKh8XCDmgLL0WscHC8j2AXTEAA58F4s7CKlXin3vfgeQd3r0DuGOqwAB0BY5Zs6pI8aoZ6vV/VEWQTgfPN2xTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781152429; c=relaxed/simple;
	bh=icBrsN59mHgz4NxH0sJu+pk9mpLQ/NXvFDcrs3OpjGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t0KGCoc2pPXg+8W2oyEt8ZSBpSUm+BwpgJqFdhtyKQULXdLhBnyk8NG9UcdCNioRQo9d0ala75kEUrs93pXlxgIR17s3q20IH637dO+XZ20Euo+zGmmeq+AFQ1ZaZpQWje8y6Eb8A+l5djUWxxNgjjOSbgK8cnybPLEqkH9raeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VhEmMOMf; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VhEmMOMf"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2c0c2d8b95bso54575485ad.1
        for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 21:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781152427; x=1781757227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o7z92KAWUhWwB4qQw1v/v0SOnEZwf5l4UXEOMjS0mEk=;
        b=VhEmMOMfLoZdO+jIL7cHugqDXYll8aaira6k7DColedgGvlTQQUMeu6cnO2s7EcLWM
         VHfYA8PyzBYq7owmKez9/+dSPtKo+/Wv2zmx6TH8Jsb2AYRBuppV7B36yVw0sXrc4g/E
         qBEa7/I2HowIDLYY7fEUIFta5X9Oz1l4V+UnCfEJVRRT8XqV3L9WLnbNlCkVrziUckZe
         f1iA6xNzEC0jsdd7Jd+N70FJJaJei1WJwcxU97CG2NzFzQFgzMDH1w+LPEcNVGZP8uME
         UrEeud8lj/aYhM0AntD+a2qA/Zueo/NE2NKjT+BK+suXFicCCPSbBRgMw3wevK3/MrX9
         Igfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781152427; x=1781757227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o7z92KAWUhWwB4qQw1v/v0SOnEZwf5l4UXEOMjS0mEk=;
        b=dHSnCHRvGwFSSQPZmwK6DVPLy2lUMVLuVwTkYhNzf7lriD46PeeZRRIbetRLZFUoFw
         an4kwJn0R+Nt1E3DW+dNREpAxBZbliGeHRV6sVK5a7iK7zB/aJDtbJl/Vlf+y6+UzmCn
         C9N+gloINlZOtHDOmXKEb/ebw3d6XmCTtZvVXzT722LN+wiHWz5DW+mWKRRjOEVbetW6
         jSIbLpDgPbFtCnNc99vECvla1StnO8ObHkCG7rqy8j5y+F2LjqoeuNlZIJkRXeRVUf5K
         SjYjtO7Rusz/BXdhZ29Ra+NV2+DKSV7eP+ZTme5qZN4OkJnlD6apRNyBUL98xl1HCoOi
         u96g==
X-Gm-Message-State: AOJu0YzDVrWOwgUTdyToQ2wveDogAtl2k2FCs7j35VyoRO4PAh0UjBxs
	iSp+0OKyRgXudIVxSevg/9g90M7yUG+Ei49DPOGNrGp0UE1vP3AYq1k9tKg23MFBoD4=
X-Gm-Gg: Acq92OEtUw88fzWemG8NkygXVGeD+3CRBxigsUMiRs8MsW+7dylaeyvSMO788iW6xfg
	D6lEnHHOtu+7T7gz9vP1amsEd4A9Z+Bzra4+3GhYdPaRTAnQAxD+x1NLd30i8IjrC1c12NCuWSA
	/j6k0Hh527Mak+GDuQT2R3t95awRCTTzKva1FwzTQ1Yadk6ktgaiWy4Z7jAA4j1bbKijEdZXBRO
	7AnrSMAcvgRq0axlHNXFhNlVGbzjs7ddBSO7Ak03YkMH1k3fzIj/wqcCjhWpuHNrkXkyV/uJFmM
	967wssgrXdzbdBU+kU7uwvUjx9pZxS1/LAzwo3wqcd+TfXiFEfHBWYwtdV+0SO3Dx5UBnglLFv6
	RFfN/BhVUh0anrj9FgOI3mi5bdNlEhy/3NjmPCImKUk5/7JeSvdHnNO1jkMIWuz9bpX1g9MqTeh
	c54b3ekbWsT4Xnpcad4kLU/9Jt3BI6OTcC+u34iq2oBHtxL452z0UCrv4xAC+xlSBw5o62l3vpc
	fIqBFrecZbtkORYV2D9CwHqF4uO
X-Received: by 2002:a17:903:2b03:b0:2c0:aef8:23eb with SMTP id d9443c01a7336-2c2f24a19abmr13489805ad.25.1781152427145;
        Wed, 10 Jun 2026 21:33:47 -0700 (PDT)
Received: from u2404-VMware-Virtual-Platform.localdomain ([2a12:a304:100::109f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609e05fsm270794455ad.54.2026.06.10.21.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 21:33:46 -0700 (PDT)
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
Subject: [PATCH bpf v3 2/2] selftests/bpf: Cover generic devmap egress last-dst rewrite
Date: Thu, 11 Jun 2026 12:33:17 +0800
Message-ID: <20260611043317.512843-3-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260611043317.512843-1-sun.jian.kdev@gmail.com>
References: <20260611043317.512843-1-sun.jian.kdev@gmail.com>
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

Add a generic XDP last-destination test where earlier destinations do
not have a devmap egress program while the final destination does. This
covers the case where the final destination runs on the original skb and
could otherwise rewrite packet data still shared with earlier cloned
skbs.

Use deterministic DEVMAP_HASH keys for the egress map so the intended
last destination is stable.

Suggested-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
---
 .../selftests/bpf/prog_tests/test_xdp_veth.c  | 152 +++++++++++++++++-
 1 file changed, 149 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c b/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c
index 3e98a1665936..681415cacb75 100644
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
@@ -512,7 +516,7 @@ static void xdp_veth_egress(u32 flags)
 						 &net_config, prog_cfg, i))
 			goto destroy_xdp_redirect_map;
 
-		err = bpf_map_update_elem(mac_map, &ifindex, magic_mac, 0);
+		err = bpf_map_update_elem(mac_map, &ifindex, egress_macs[i], 0);
 		if (!ASSERT_OK(err, "bpf_map_update_elem"))
 			goto destroy_xdp_redirect_map;
 
@@ -531,13 +535,16 @@ static void xdp_veth_egress(u32 flags)
 
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
 	}
 
 destroy_xdp_redirect_map:
@@ -551,6 +558,142 @@ static void xdp_veth_egress(u32 flags)
 	cleanup_network(&net_config);
 }
 
+static void xdp_veth_egress_last_dst(u32 flags)
+{
+	struct prog_configuration prog_cfg[VETH_PAIRS_COUNT] = {
+		{
+			.local_name = "xdp_redirect_map_all_prog",
+			.remote_name = "store_mac_1",
+			.local_flags = flags,
+			.remote_flags = flags,
+		},
+		{
+			.local_name = "xdp_redirect_map_all_prog",
+			.remote_name = "store_mac_2",
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
+	struct net_configuration net_config;
+	int mac_map, egress_map, res_map;
+	struct nstoken *nstoken = NULL;
+	struct xdp_dummy *xdp_dummy;
+	__be64 last_mac = 0;
+	bool found = false;
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
+		err = bpf_map_update_elem(mac_map, &ifindex, egress_macs[i], 0);
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
+	}
+
+	SYS_NOFAIL("ip netns exec %s ping %s -i 0.1 -c 4 -W1 > /dev/null ",
+		   net_config.veth_cfg[0].namespace, IP_NEIGH);
+
+	res_map = bpf_map__fd(xdp_redirect_map->maps.rx_mac);
+	if (!ASSERT_OK_FD(res_map, "open rx_map"))
+		goto destroy_xdp_redirect_map;
+
+	memcpy(&last_mac, egress_macs[VETH_PAIRS_COUNT - 1], ETH_ALEN);
+
+	for (i = 0; i < VETH_PAIRS_COUNT - 1; i++) {
+		u32 key = i;
+		u64 res;
+
+		err = bpf_map_lookup_elem(res_map, &key, &res);
+		if (err == -ENOENT)
+			continue;
+		if (!ASSERT_OK(err, "get MAC res"))
+			goto destroy_xdp_redirect_map;
+
+		found = true;
+		ASSERT_NEQ(res, last_mac, "compare last dst mac");
+	}
+
+	ASSERT_TRUE(found, "found earlier dst mac");
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
 void test_xdp_veth_redirect(void)
 {
 	if (test__start_subtest("0"))
@@ -596,4 +739,7 @@ void test_xdp_veth_egress(void)
 
 	if (test__start_subtest("SKB_MODE/egress"))
 		xdp_veth_egress(XDP_FLAGS_SKB_MODE);
+
+	if (test__start_subtest("SKB_MODE/egress_last_dst"))
+		xdp_veth_egress_last_dst(XDP_FLAGS_SKB_MODE);
 }
-- 
2.43.0

