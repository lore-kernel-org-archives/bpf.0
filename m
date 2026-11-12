Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794527437;
	b=CozsU9Q9RP8JKGwIq36XnsSWHbWIx48EymrmSnCha4EQpiJv43IAE+5pcdnwzaN2YEYV
	 vOOZmQ6nyd3os1Mk49nMHQvfyzSSlCnTs8LUbfoOa24HX1zU17Uj6adXvHmnq3jI2ESv0
	 JQ02753iPk65xX2fyZKGEMGyLsknuKpdji1B3d4kvcZvEUGbx0K7pK0/PnP3O3CEVcX8G
	 uC+IT1BlrQQhSaXPzyPc+mbHa3zi2plVXI4ybu/diqOhsDwiJfiB9WRz1cLteY8LCHtiB
	 wEa68XBTrJB9y3bnVm9j7Z15iNV+TFb2o4t9k4r2m3Ua7CyMg5dYQnUc+z6vAuf/ekA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794527437;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=KYerT8C4qC+ZU83I8xoTGRYN8+Qc7EuzFMb4fJ6T9dU=;
	b=bvJTcBLjyi0HXNtTjDmlmAaDZc6vuF9RCEgRKG9S3F5SkpuZrPo+HhnYcQRt2DbfBWKC
	 0HNK8aYaSyiiIOLDgCe87AOdX9tVUFnJhDNcN9R3pVCnefA+BENeVzGcWAZKHLI5HhhaK
	 IMLMhtbsGO+PZoT7Kd8xrB9kehYhDD0HwGxx958769KoYPO+9K90TH9+53/xU/KEbTHUR
	 MjtA7UHfGZDfgkFoKNWF3rkcTaTxG3u2XoP4fDdixC/JZfLceapxV88GLj2mYRdfMQ5iy
	 fdgifQ1I85dY7szOryJHw+EgXlWUaRyQQUF9WR19LA9gdk23+prnNpY5g0oNLWcHgTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XEjICfBH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D84606A8BD;
	Thu, 12 Nov 2026 23:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XEjICfBH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 881F91F000CF;
	Thu, 12 Nov 2026 23:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794527437;
	bh=KYerT8C4qC+ZU83I8xoTGRYN8+Qc7EuzFMb4fJ6T9dU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XEjICfBHV6jmHi2oZbRaTIi8Kd3xMUHxJtLk+s+Tno85YKvi7de5vAgn8PRZYYf7H
	 2q3lAAuBcZYe6bpWywA1PzQZ0KXtZBjqVimJgVyI/4erunHrO1ZSQtB3BEQcVQL5lQ
	 gqoGoDnGDXbVv4sMdFW6vWVRDGc16q2KbNhDQjOhWWPswVG5oQvDNNRqmDr+LS5fYm
	 /RKra+AxKcD8RkYbMfL91gRqnMDVe0BrwSOC6Fr3OFw3mGZ5PP0sNNUsdpfKZSX0xe
	 rCpjR3lWPt0tiC/RcrRe5eRNCX+mqpGXcfyeEYjUB6QXYrJ8MpDY4kygLd/BD1brZB
	 lnKvD98emxmFg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	jv@jvosburgh.net,
	haiyangz@microsoft.com,
	ast@kernel.org,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	bpf@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 5/5] selftests/bpf: check replacing and detaching XDP on a bond through a link
Date: Thu, 12 Nov 2026 15:50:27 -0800
Message-ID: <20261112235027.4072149-6-kuba@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261112235027.4072149-1-kuba@kernel.org>
References: <20261112235027.4072149-1-kuba@kernel.org>
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

The bond tests attach and destroy links, but never replace the program
behind one, or detach it without closing the link. Both only ever
operate on the device the link was created on, and rely on the bond to
pass the change down to its slaves.

Check that the slave follows the replacement and the detach, and that
the program which got replaced is released - the bond used to leak it.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../selftests/bpf/prog_tests/xdp_bonding.c    | 96 +++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c b/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c
index ab0f01be4131..05f2e8079858 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c
@@ -516,6 +516,99 @@ static void test_xdp_bonding_nested(struct skeletons *skeletons)
 	system("ip link del bond_nest2");
 }
 
+/*
+ * Replace, then detach the program on a bond through its link. The link only
+ * knows about the bond, the slave has to follow it, and the replaced program
+ * has to be released.
+ */
+static void test_xdp_bonding_link_update(struct skeletons *skeletons)
+{
+	LIBBPF_OPTS(bpf_prog_load_opts, opts, .expected_attach_type = BPF_XDP);
+	struct bpf_program *new_prog = skeletons->xdp_dummy->progs.xdp_dummy_prog;
+	struct bpf_insn insns[] = {
+		BPF_MOV64_IMM(BPF_REG_0, XDP_PASS),
+		BPF_EXIT_INSN(),
+	};
+	int veth, bond, err, fd, old_fd = -1, link_fd = -1;
+	struct bpf_prog_info info = {};
+	__u32 old_id, new_id, id, len;
+
+	if (!ASSERT_OK(system("ip link add veth type veth"), "add veth"))
+		goto out;
+	if (!ASSERT_OK(system("ip link add bond type bond"), "add bond"))
+		goto out;
+
+	veth = if_nametoindex("veth");
+	if (!ASSERT_GT(veth, 0, "if_nametoindex veth"))
+		goto out;
+	bond = if_nametoindex("bond");
+	if (!ASSERT_GT(bond, 0, "if_nametoindex bond"))
+		goto out;
+
+	err = system("ip link set veth master bond");
+	if (!ASSERT_OK(err, "set veth master"))
+		goto out;
+
+	/* same attach type as the skeleton's, or the link won't take it */
+	old_fd = bpf_prog_load(BPF_PROG_TYPE_XDP, "xdp_old", "GPL", insns,
+			       ARRAY_SIZE(insns), &opts);
+	if (!ASSERT_GE(old_fd, 0, "load old program"))
+		goto out;
+	len = sizeof(info);
+	if (!ASSERT_OK(bpf_prog_get_info_by_fd(old_fd, &info, &len), "old program info"))
+		goto out;
+	old_id = info.id;
+
+	memset(&info, 0, sizeof(info));
+	len = sizeof(info);
+	err = bpf_prog_get_info_by_fd(bpf_program__fd(new_prog), &info, &len);
+	if (!ASSERT_OK(err, "new program info"))
+		goto out;
+	new_id = info.id;
+
+	link_fd = bpf_link_create(old_fd, bond, BPF_XDP, NULL);
+	if (!ASSERT_GE(link_fd, 0, "attach old program to bond"))
+		goto out;
+
+	err = bpf_xdp_query_id(veth, XDP_FLAGS_DRV_MODE, &id);
+	if (!ASSERT_OK(err, "query veth") ||
+	    !ASSERT_EQ(id, old_id, "veth runs the old program"))
+		goto out;
+
+	err = bpf_link_update(link_fd, bpf_program__fd(new_prog), NULL);
+	if (!ASSERT_OK(err, "replace the program through the link"))
+		goto out;
+
+	err = bpf_xdp_query_id(veth, XDP_FLAGS_DRV_MODE, &id);
+	if (!ASSERT_OK(err, "query veth") ||
+	    !ASSERT_EQ(id, new_id, "veth follows to the new program"))
+		goto out;
+
+	/* nothing but our fd should be holding on to the old program now */
+	close(old_fd);
+	old_fd = -1;
+	fd = bpf_prog_get_fd_by_id(old_id);
+	if (!ASSERT_EQ(fd, -ENOENT, "old program released") && fd >= 0)
+		close(fd);
+
+	err = bpf_link_detach(link_fd);
+	if (!ASSERT_OK(err, "detach the link"))
+		goto out;
+
+	err = bpf_xdp_query_id(veth, XDP_FLAGS_DRV_MODE, &id);
+	if (!ASSERT_OK(err, "query veth"))
+		goto out;
+	ASSERT_EQ(id, 0, "veth has no program left");
+
+out:
+	if (link_fd >= 0)
+		close(link_fd);
+	if (old_fd >= 0)
+		close(old_fd);
+	system("ip link del veth");
+	system("ip link del bond");
+}
+
 /*
  * Test that XDP redirect via xdp_master_redirect() does not crash when
  * the bond master device is not up. When bond is in round-robin mode but
@@ -826,6 +919,9 @@ void serial_test_xdp_bonding(void)
 	if (test__start_subtest("xdp_bonding_nested"))
 		test_xdp_bonding_nested(&skeletons);
 
+	if (test__start_subtest("xdp_bonding_link_update"))
+		test_xdp_bonding_link_update(&skeletons);
+
 	if (test__start_subtest("xdp_bonding_features"))
 		test_xdp_bonding_features(&skeletons);
 
-- 
2.56.0

