Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794527436;
	b=jjwAXo3W9MN2sdm9qgz95OhCB1ZtaTysCDM21/r9LgIoiw026loTIV4GwXSBVl9qS4yK
	 XIoSR/T2hFDgq9P7CaXIIveJ96MdA8JY8q6WngTVX9Ds7EjeYE/A1s9E0HOUZEdH90dAs
	 eT0YROXqoPrJw2mVPcbogPjS7NQj0SiGgDI9rcow+FhqCy1SFwPu9piYY9/b+AqzotsLy
	 1oTNW2JH6+p9RdJCbn5Hkcgkx9WPxYIJEDUWRcHJHuMQyL8waPPPAXL+P9UlTHUNxlaOq
	 FDWS6qljAYugBxfoadjUvTwKi/eKzVI2Dhh24xkV2fO1insZex7OAYm8uj27zgGWUCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794527436;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=PB2qdAhQNuG8GV9re69M66DCL0EMV/YLsr8tzNwyQh0=;
	b=xObDv6XrKzW5oCtaXQAqNamkapfSwXipNGm5bSzn8Bfw4JU522I8+n6nN72nf6IQZNcs
	 GNdXlt6vOAwf1j7uNyUJg2CKJFK7tPWTKfNykUz4BjTCgW0ypSDN7Zht3aTR3kx5eQzDu
	 ulAxhN+zzKeAL7HGaM9KsIo0/2X1wA1O7Qnn2lK1U2Z5HiOijEMME2/FPrWlcpE84Gork
	 cyPckZBcYaheEovTjbKxvpOfc+645uIZ/FWdbonrlSLtQvrsfH3o+pkpjZ56q5af9gctC
	 1zE5whGMaI/Sb4xtbzLfRm8iYAcVC+0DYTIhIA2WIsqcAZcpR06Qu7R0LkQma5st2bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lOY0uBYN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8A7606A8AD;
	Thu, 12 Nov 2026 23:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lOY0uBYN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E276E1F000C4;
	Thu, 12 Nov 2026 23:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794527436;
	bh=PB2qdAhQNuG8GV9re69M66DCL0EMV/YLsr8tzNwyQh0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lOY0uBYNHIlhp6v7OghEekHt40hz+norza42fWx3e+AYYPW7q2evNQJ3UMxdcmgrN
	 31xg2/Alc2JrL1HWzhYjJvBpChBFHxBRjEhhZNOxSdFe1mWk0Pz8g4wb6bsdypWFkX
	 Hs0Lw6UK1LPsi3cwVTl9x0zyjMdi5VuvjXkn/lqSoBnJA7VUY3MDF5/cWagFvu1EOW
	 QS8gFrruQda5Eg8Qo9kyomgNk/k5BgHkCkF/eT0TGo1nHxVccsM97gFbTyxLNlRRxT
	 Tt5zrCPkz27vYXN+4TJDDVPl23ItdDX/mc2MRPQWUritO/wldFRiCmY+V3UpfBgdSz
	 5HYigRfgnQpMg==
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
Subject: [PATCH net-next 4/5] selftests/bpf: check XDP attach on a nested bond slave
Date: Thu, 12 Nov 2026 15:50:26 -0800
Message-ID: <20261112235027.4072149-5-kuba@kernel.org>
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

test_xdp_bonding_attach() already covers a flat bond both ways round:
the master is refused while a slave has a program, and a slave is
refused while the master has one. The nested test only ever checked
that attaching to the outermost master succeeds.

That left the more interesting half of the nesting untested. With
bond -> bond_nest1 -> bond_nest2, bond_nest2 refuses a program of its
own only if the program the outer bond pushed down is recorded on it.
Before "net: record XDP programs propagated to lower devices" it was
recorded nowhere, and a second program could be attached to bond_nest2
while the outer bond's was already running on it. Check that the attach
is refused, and with -EBUSY, which is what the recorded program gives.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../selftests/bpf/prog_tests/xdp_bonding.c    | 24 ++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c b/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c
index c42488e445c2..ab0f01be4131 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c
@@ -461,11 +461,15 @@ static void test_xdp_bonding_attach(struct skeletons *skeletons)
 	system("ip link del vxlan");
 }
 
-/* Test with nested bonding devices to catch issue with negative jump label count */
+/*
+ * Test with nested bonding devices to catch issue with negative jump label
+ * count, and check that a nested slave refuses a program of its own.
+ */
 static void test_xdp_bonding_nested(struct skeletons *skeletons)
 {
+	struct bpf_link *link2 = NULL;
 	struct bpf_link *link = NULL;
-	int bond, err;
+	int bond, nest2, err;
 
 	if (!ASSERT_OK(system("ip link add bond type bond"), "add bond"))
 		goto out;
@@ -488,10 +492,24 @@ static void test_xdp_bonding_nested(struct skeletons *skeletons)
 	if (!ASSERT_OK(err, "set bond_nest2 master"))
 		goto out;
 
+	nest2 = if_nametoindex("bond_nest2");
+	if (!ASSERT_GT(nest2, 0, "if_nametoindex bond_nest2"))
+		goto out;
+
 	link = bpf_program__attach_xdp(skeletons->xdp_dummy->progs.xdp_dummy_prog, bond);
-	ASSERT_OK_PTR(link, "attach program to master");
+	if (!ASSERT_OK_PTR(link, "attach program to master"))
+		goto out;
+
+	/*
+	 * Attaching to a nested slave is not allowed either. The program the
+	 * outer bond pushed down is recorded there too.
+	 */
+	link2 = bpf_program__attach_xdp(skeletons->xdp_dummy->progs.xdp_dummy_prog, nest2);
+	ASSERT_EQ(libbpf_get_error(link2), -EBUSY,
+		  "attach program to nested slave when master has program");
 
 out:
+	bpf_link__destroy(link2);
 	bpf_link__destroy(link);
 	system("ip link del bond");
 	system("ip link del bond_nest1");
-- 
2.56.0

