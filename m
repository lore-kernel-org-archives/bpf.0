Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3263F3803F4;
	Wed,  8 Jul 2026 13:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783518121; cv=none; b=R67Ht7+wL1QZLY192nN4g086qx8IXcs0dwr4r2wZ1ax+OP/FGKUX0q3zkMgXraaj+X7lw2X6/Q9lTMOBjJQaRVgIlXxJZrrc3nIE2C7aAaRRM+DQBnvfvHfttLEoYo/h1cX79/4Kv4CkSScj+fjpCykhurF08aN02Lpx1enig8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783518121; c=relaxed/simple;
	bh=aWYlSl1iKd+S/LFdxx9EKTZByuDcw7WfLy/kJpP40Lg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ii6RyxTi+GVM/IOAWHrX+TVWUbF1RtN83LJRP19l5Vk8DD5XmtQFaAf28YeVgFvA0f5AgZzegcn0rBQUX07GXd6yLWAQ+0KyyQ2E6LPfut/1ngUGF4vt5CHJPVf8D4vpg87zhNUVKGVKy/u2hmr++rHvdVpAHyA9N9ilHF5Yd0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K7d7PHI1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K7d7PHI1"
Received: by smtp.kernel.org (Postfix) with ESMTPS id EE048C2BCF4;
	Wed,  8 Jul 2026 13:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783518121;
	bh=aWYlSl1iKd+S/LFdxx9EKTZByuDcw7WfLy/kJpP40Lg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=K7d7PHI1R2B+ae/wDg5xwBOnZk6DbWkMaY1YKH4Lk30yBUr115+7i24rCn7gTI0rw
	 h+gpCG7Ols1PmlbmSWoonsL4Mof4TdHTmw0FRSgewbPLnXRufqHjls+hRUCIMWUDFW
	 B6YiJHR01g3C0epZ98GkhFNCOrVCQ61wGA9IfNpeLFAzOGEwUCTtI0NNVLfCNfZUnn
	 2F9FI0caCqCE0Wowz+a+9PD7Xc8uU55XRVDfuPOnN9XBHb+wQV0xQ+lbETuPBNbcUf
	 ReZTsIvtAGX3SUmbOauSmeV04v/MlTTiCHeUtfi/R9RrnSDcFCfsQMvaQVEVMGkhU+
	 /SGR9IVrDIExQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D09D8C44501;
	Wed,  8 Jul 2026 13:42:00 +0000 (UTC)
From: Mattia Meleleo via B4 Relay <devnull+mattia.meleleo.coralogix.com@kernel.org>
Date: Wed, 08 Jul 2026 15:40:57 +0200
Subject: [PATCH bpf v2 2/2] selftests/bpf: Test FIONREAD on a sockmap
 socket without a verdict program
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-fionread-no-verdict-v2-2-29dd293621c7@coralogix.com>
References: <20260708-fionread-no-verdict-v2-0-29dd293621c7@coralogix.com>
In-Reply-To: <20260708-fionread-no-verdict-v2-0-29dd293621c7@coralogix.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 Jiayuan Chen <jiayuan.chen@linux.dev>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Mattia Meleleo <mattia.meleleo@coralogix.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783518119; l=2540;
 i=mattia.meleleo@coralogix.com; s=20260707; h=from:subject:message-id;
 bh=p7lS9BLCvIzk4qRf5KI1vjYiReTBJhPhNVqmY8gvgxU=;
 b=zidsfoXQVVjr8qXp8v/wgttXzZ9KXCEg/FS17WN9aNkwrJnTH+cmUDhGghDWN0U9pwtueba5j
 Yde+vEcC9KCBvy4GdbjXKLNw3rzF7bN5uRarJc6s8QXpJ3lt5CY0xDJ
X-Developer-Key: i=mattia.meleleo@coralogix.com; a=ed25519;
 pk=cs1zLoe3YDm4bJ7bfbPaZH0lHnd871JyJLiSh2eEzLs=
X-Endpoint-Received: by B4 Relay for mattia.meleleo@coralogix.com/20260707
 with auth_id=857
X-Original-From: Mattia Meleleo <mattia.meleleo@coralogix.com>
Reply-To: mattia.meleleo@coralogix.com

From: Mattia Meleleo <mattia.meleleo@coralogix.com>

Add a test validating that FIONREAD on a TCP socket in a sockmap
without a verdict program reports data pending in sk_receive_queue.

Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Mattia Meleleo <mattia.meleleo@coralogix.com>
---
 .../selftests/bpf/prog_tests/sockmap_basic.c       | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
index cb3229711..f0f368201 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
@@ -1373,6 +1373,43 @@ static void test_sockmap_multi_channels(int sotype)
 	test_sockmap_pass_prog__destroy(skel);
 }
 
+/* A socket in a sockmap without a verdict program keeps its ingress data
+ * in sk_receive_queue: FIONREAD must account for it.
+ */
+static void test_sockmap_no_verdict_fionread(void)
+{
+	int err, map, zero = 0, sent, avail;
+	int c0 = -1, c1 = -1, p0 = -1, p1 = -1;
+	struct test_sockmap_pass_prog *skel;
+	char buf[256] = "0123456789";
+
+	skel = test_sockmap_pass_prog__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+	map = bpf_map__fd(skel->maps.sock_map_rx);
+
+	err = create_socket_pairs(AF_INET, SOCK_STREAM, &c0, &c1, &p0, &p1);
+	if (!ASSERT_OK(err, "create_socket_pairs()"))
+		goto out;
+
+	err = bpf_map_update_elem(map, &zero, &c1, BPF_NOEXIST);
+	if (!ASSERT_OK(err, "bpf_map_update_elem(c1)"))
+		goto out_close;
+
+	sent = xsend(p1, &buf, sizeof(buf), 0);
+	ASSERT_EQ(sent, sizeof(buf), "xsend(p1)");
+	avail = wait_for_fionread(c1, sizeof(buf), IO_TIMEOUT_SEC);
+	ASSERT_EQ(avail, sizeof(buf), "ioctl(FIONREAD)");
+
+out_close:
+	close(c0);
+	close(p0);
+	close(c1);
+	close(p1);
+out:
+	test_sockmap_pass_prog__destroy(skel);
+}
+
 void test_sockmap_basic(void)
 {
 	if (test__start_subtest("sockmap create_update_free"))
@@ -1415,6 +1452,8 @@ void test_sockmap_basic(void)
 		test_sockmap_skb_verdict_shutdown();
 	if (test__start_subtest("sockmap skb_verdict fionread"))
 		test_sockmap_skb_verdict_fionread(true);
+	if (test__start_subtest("sockmap no_verdict fionread"))
+		test_sockmap_no_verdict_fionread();
 	if (test__start_subtest("sockmap skb_verdict fionread on drop"))
 		test_sockmap_skb_verdict_fionread(false);
 	if (test__start_subtest("sockmap skb_verdict change tail"))

-- 
Git-155)


