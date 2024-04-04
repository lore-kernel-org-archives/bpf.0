Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BD51CD02
	for <bpf@vger.kernel.org>; Thu,  4 Apr 2024 02:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712199214; cv=none; b=sGfFYFZipiwC+N6fPuFNyZYc0h6EW7eFS1wr/TmxepRe1scGajHxkPi7QQrlpDLo/KRfyZvZKKiIuxiNk8yJP8IacVCSawhofkgs+AL0HvmpR6DafEKF2h82MfUzq6DqQU/9hpuCe7L3JebtXu20RlMfyB5E6jpaGKJeVnvlRAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712199214; c=relaxed/simple;
	bh=nY8pBElFEy6hCPr0s9CDd+phX6TK3x8PwkJXgmgXP8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lsVq9UW2sPs1+4D476gXmnlfr/+KTFWQNbDPu3w/ZWY0rOnccBkP5l2XJ9x1xyujc0+2B9KbM8+jfvUBFjrVSIaHOIRt1Q3SOuMNhG68dIB2tDnr4Xwe2IPouf094QmI6Pt1l3iKB+0JEfqSiBEZ9ldJGuQD9R7M91OkchoMfW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 3D8FD29CEB58; Wed,  3 Apr 2024 19:53:26 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	John Fastabend <john.fastabend@gmail.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v4 4/5] selftests/bpf: Refactor out helper functions for a few tests
Date: Wed,  3 Apr 2024 19:53:26 -0700
Message-ID: <20240404025326.2212865-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240404025305.2210999-1-yonghong.song@linux.dev>
References: <20240404025305.2210999-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

These helper functions will be used later new tests as well.
There are no functionality change.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 38 +++++++++++--------
 .../bpf/progs/test_skmsg_load_helpers.c       |  9 ++++-
 2 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/too=
ls/testing/selftests/bpf/prog_tests/sockmap_basic.c
index 77e26ecffa9d..63fb2da7930a 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
@@ -475,30 +475,19 @@ static void test_sockmap_skb_verdict_fionread(bool =
pass_prog)
 		test_sockmap_drop_prog__destroy(drop);
 }
=20
-static void test_sockmap_skb_verdict_peek(void)
+static void test_sockmap_skb_verdict_peek_helper(int map)
 {
-	int err, map, verdict, s, c1, p1, zero =3D 0, sent, recvd, avail;
-	struct test_sockmap_pass_prog *pass;
+	int err, s, c1, p1, zero =3D 0, sent, recvd, avail;
 	char snd[256] =3D "0123456789";
 	char rcv[256] =3D "0";
=20
-	pass =3D test_sockmap_pass_prog__open_and_load();
-	if (!ASSERT_OK_PTR(pass, "open_and_load"))
-		return;
-	verdict =3D bpf_program__fd(pass->progs.prog_skb_verdict);
-	map =3D bpf_map__fd(pass->maps.sock_map_rx);
-
-	err =3D bpf_prog_attach(verdict, map, BPF_SK_SKB_STREAM_VERDICT, 0);
-	if (!ASSERT_OK(err, "bpf_prog_attach"))
-		goto out;
-
 	s =3D socket_loopback(AF_INET, SOCK_STREAM);
 	if (!ASSERT_GT(s, -1, "socket_loopback(s)"))
-		goto out;
+		return;
=20
 	err =3D create_pair(s, AF_INET, SOCK_STREAM, &c1, &p1);
 	if (!ASSERT_OK(err, "create_pairs(s)"))
-		goto out;
+		return;
=20
 	err =3D bpf_map_update_elem(map, &zero, &c1, BPF_NOEXIST);
 	if (!ASSERT_OK(err, "bpf_map_update_elem(c1)"))
@@ -520,6 +509,25 @@ static void test_sockmap_skb_verdict_peek(void)
 out_close:
 	close(c1);
 	close(p1);
+}
+
+static void test_sockmap_skb_verdict_peek(void)
+{
+	struct test_sockmap_pass_prog *pass;
+	int err, map, verdict;
+
+	pass =3D test_sockmap_pass_prog__open_and_load();
+	if (!ASSERT_OK_PTR(pass, "open_and_load"))
+		return;
+	verdict =3D bpf_program__fd(pass->progs.prog_skb_verdict);
+	map =3D bpf_map__fd(pass->maps.sock_map_rx);
+
+	err =3D bpf_prog_attach(verdict, map, BPF_SK_SKB_STREAM_VERDICT, 0);
+	if (!ASSERT_OK(err, "bpf_prog_attach"))
+		goto out;
+
+	test_sockmap_skb_verdict_peek_helper(map);
+
 out:
 	test_sockmap_pass_prog__destroy(pass);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_skmsg_load_helpers.c =
b/tools/testing/selftests/bpf/progs/test_skmsg_load_helpers.c
index 45e8fc75a739..b753672f04c9 100644
--- a/tools/testing/selftests/bpf/progs/test_skmsg_load_helpers.c
+++ b/tools/testing/selftests/bpf/progs/test_skmsg_load_helpers.c
@@ -24,8 +24,7 @@ struct {
 	__type(value, __u64);
 } socket_storage SEC(".maps");
=20
-SEC("sk_msg")
-int prog_msg_verdict(struct sk_msg_md *msg)
+static int prog_msg_verdict_common(struct sk_msg_md *msg)
 {
 	struct task_struct *task =3D (struct task_struct *)bpf_get_current_task=
();
 	int verdict =3D SK_PASS;
@@ -44,4 +43,10 @@ int prog_msg_verdict(struct sk_msg_md *msg)
 	return verdict;
 }
=20
+SEC("sk_msg")
+int prog_msg_verdict(struct sk_msg_md *msg)
+{
+	return prog_msg_verdict_common(msg);
+}
+
 char _license[] SEC("license") =3D "GPL";
--=20
2.43.0

