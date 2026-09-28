Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C054FD296;
	Mon, 28 Sep 2026 22:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790635014; cv=none; b=VCfSofPgN+iQzEyLjBN6z2I4KwgMWGf47WMMP/vaPxeY0ILesREtWK1jeV0QcZvFgmZq3RUB0G3BngnztImVgaUc8uBDFxkVW3FwbY7mVWntBZz/MHK0CR9z939NKOrK1Wz12fOkTZm26Ukwf8A+cY/mG2qNuBErXbLVmm0ooeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790635014; c=relaxed/simple;
	bh=fyTc7NgG7aer+e1HR8NfUGBmVmNoCgZSmYbzfnL6hHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mCNvj8ColKhFQAn6MXXf7S/lLliX9YXtjr9MjsPKuEk49NeU0hd8CD+QhakX9UjTu4XcaW9yuxsUdaN4hYp1GnJHuncDamJE3qKd1Bce8Qs09N56VZJk/5fvgSnRxj/iCtnSybuvqEHVE5CIvFylQIx3MzifgfCOxvDFJYZgua8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TIsloHzm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TIsloHzm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B173E1F0089B;
	Mon, 28 Sep 2026 22:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790635013;
	bh=EqCKfTIqYiiQfGfL7Gl9Syaz4pkJt2hXF/QnfmKlaGc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TIsloHzmSjXXPtjnYihTtFBzWCcZluW3kRZkHdTzWf++bUXEM0f995+CzCBuTbPig
	 zO9AOKWmXkhOavH2iZLXg/+ty6MtqORqOnNjCqKSornUTtA+mno24OQrHMcpgQPZCT
	 MuPUZ1/yNdzlCj3DXJ0+LdRtCCWXCI7tL0z0pC8KU3QS4W2S1UeDDNOOH/wWT3VrM0
	 gskEpL4L8516M5lcHqtfwkXVu5b3XH6oQ7/RQtAAybrcA1lXB+0F9k5GMrFP+LtRLt
	 1L5D5kovSv2Yzl49suLc8WDovTj0AW+m2d2bGMFy5NEk/8sVNULR6hU2WJ11LZ7gIj
	 dn9DhFqeEv4Og==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	jv@jvosburgh.net,
	hawk@kernel.org,
	sdf@fomichev.me,
	emil@etsalapatis.com,
	liuhangbin@gmail.com,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	willemdebruijn.kernel@gmail.com,
	aleksander.lobakin@intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 4/5] selftests/bpf: check XDP attach on a nested bond slave
Date: Mon, 28 Sep 2026 15:36:47 -0700
Message-ID: <20260928223648.2739371-5-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928223648.2739371-1-kuba@kernel.org>
References: <20260928223648.2739371-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

test_xdp_bonding_attach() already covers a flat bond both ways round:
the master is refused while a slave has a program, and a slave is
refused while the master has one. The nested test only ever checked
that attaching to the outermost master succeeds.

That left the more interesting half of the nesting untested. Only the
direct upper is consulted when deciding whether a device is already
running XDP, so with bond -> bond_nest1 -> bond_nest2 the check on
bond_nest2 looks at bond_nest1, and it only sees a program there if
bond_nest1 recorded the one it was handed. Before the preceding fix it
did not, and a second program could be attached to bond_nest2 while the
outer bond's program was already running on it.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../selftests/bpf/prog_tests/xdp_bonding.c     | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c b/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c
index c42488e445c2..486e0f9a2ada 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c
@@ -464,8 +464,9 @@ static void test_xdp_bonding_attach(struct skeletons *skeletons)
 /* Test with nested bonding devices to catch issue with negative jump label count */
 static void test_xdp_bonding_nested(struct skeletons *skeletons)
 {
+	struct bpf_link *link2 = NULL;
 	struct bpf_link *link = NULL;
-	int bond, err;
+	int bond, nest2, err;
 
 	if (!ASSERT_OK(system("ip link add bond type bond"), "add bond"))
 		goto out;
@@ -488,10 +489,23 @@ static void test_xdp_bonding_nested(struct skeletons *skeletons)
 	if (!ASSERT_OK(err, "set bond_nest2 master"))
 		goto out;
 
+	nest2 = if_nametoindex("bond_nest2");
+	if (!ASSERT_GE(nest2, 0, "if_nametoindex bond_nest2"))
+		goto out;
+
 	link = bpf_program__attach_xdp(skeletons->xdp_dummy->progs.xdp_dummy_prog, bond);
-	ASSERT_OK_PTR(link, "attach program to master");
+	if (!ASSERT_OK_PTR(link, "attach program to master"))
+		goto out;
+
+	/* Attaching to a nested slave is not allowed either. Only the direct
+	 * upper is consulted, so this only holds if every device the program
+	 * was propagated to records it.
+	 */
+	link2 = bpf_program__attach_xdp(skeletons->xdp_dummy->progs.xdp_dummy_prog, nest2);
+	ASSERT_ERR_PTR(link2, "attach program to nested slave when master has program");
 
 out:
+	bpf_link__destroy(link2);
 	bpf_link__destroy(link);
 	system("ip link del bond");
 	system("ip link del bond_nest1");
-- 
2.55.0

