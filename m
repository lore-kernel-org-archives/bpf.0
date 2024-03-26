Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009E657899
	for <bpf@vger.kernel.org>; Tue, 26 Mar 2024 02:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711419754; cv=none; b=hXvx6Egpf+iSgWE1ve2/jpYcEGMTivoOi+yfl50lO0exlKQsj3Gr9xs5CIrlrnb/FWsA21jeaKJmHqKyOUytl+Q2v4XgLsRI2O7WSNZJUlWtNCgwZtkGRQcd/ajkSrq3NTk/AXpP19qqcbsKo7chTNfBT74Dd/FlDgNS041VwPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711419754; c=relaxed/simple;
	bh=4u5lIQ5hf8JUocCikOwvDPVulu0YIX4Hk/lPf6H/Tns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o1HF/31e2YjeW3t1zru+XYiuzuiuXcKt0Qhcpm8v3+8sI6wvYjoo9YsFbdC4ZJJLLQKatgjOpSWV27CXjbaFd+8w2RMOi3haQ7eqGp7AxRc+EsaQQ68/FEi2nb4brahlnwBd1Q5JNjBM0na0a6GsEoJJVHjyaOp1D0qLpR33dIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 65AA624DD285; Mon, 25 Mar 2024 19:22:19 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	John Fastabend <john.fastabend@gmail.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v3 5/5] selftests/bpf: Add some tests with new bpf_program__attach_sockmap() APIs
Date: Mon, 25 Mar 2024 19:22:19 -0700
Message-ID: <20240326022219.657808-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240326022153.656006-1-yonghong.song@linux.dev>
References: <20240326022153.656006-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add a few more tests in sockmap_basic.c and sockmap_listen.c to
test bpf_link based APIs for SK_MSG and SK_SKB programs.
Link attach/detach/update are all tested.

All tests are passed.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 90 +++++++++++++++++++
 .../selftests/bpf/prog_tests/sockmap_listen.c | 38 ++++++++
 .../bpf/progs/test_skmsg_load_helpers.c       |  6 ++
 .../bpf/progs/test_sockmap_pass_prog.c        | 11 ++-
 .../progs/test_sockmap_skb_verdict_attach.c   |  2 +-
 5 files changed, 145 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/too=
ls/testing/selftests/bpf/prog_tests/sockmap_basic.c
index 63fb2da7930a..b4b38f92b864 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
@@ -131,6 +131,40 @@ static void test_skmsg_helpers(enum bpf_map_type map=
_type)
 	test_skmsg_load_helpers__destroy(skel);
 }
=20
+static void test_skmsg_helpers_with_link(enum bpf_map_type map_type)
+{
+	struct test_skmsg_load_helpers *skel;
+	struct bpf_link *link, *link2;
+	struct bpf_program *prog;
+	int err, map;
+
+	skel =3D test_skmsg_load_helpers__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "test_skmsg_load_helpers__open_and_load"))
+		return;
+
+	prog =3D skel->progs.prog_msg_verdict;
+	map =3D bpf_map__fd(skel->maps.sock_map);
+
+	link =3D bpf_program__attach_sockmap(prog, map);
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach_sockmap"))
+		goto out;
+
+	err =3D bpf_prog_attach(bpf_program__fd(prog), map, BPF_SK_MSG_VERDICT,=
 0);
+	if (!ASSERT_ERR(err, "bpf_prog_attach"))
+		goto out;
+
+	link2 =3D bpf_program__attach_sockmap(skel->progs.prog_msg_verdict_clon=
e, map);
+	if (!ASSERT_ERR_PTR(link2, "bpf_program__attach_sockmap"))
+		goto out;
+
+	err =3D bpf_link__update_program(link, skel->progs.prog_msg_verdict_clo=
ne);
+	ASSERT_OK(err, "bpf_link__update_program");
+
+out:
+	bpf_link__detach(link);
+	test_skmsg_load_helpers__destroy(skel);
+}
+
 static void test_sockmap_update(enum bpf_map_type map_type)
 {
 	int err, prog, src;
@@ -298,6 +332,27 @@ static void test_sockmap_skb_verdict_attach(enum bpf=
_attach_type first,
 	test_sockmap_skb_verdict_attach__destroy(skel);
 }
=20
+static void test_sockmap_skb_verdict_attach_with_link(void)
+{
+	struct test_sockmap_skb_verdict_attach *skel;
+	struct bpf_program *prog;
+	struct bpf_link *link;
+	int map;
+
+	skel =3D test_sockmap_skb_verdict_attach__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+	prog =3D skel->progs.prog_skb_verdict;
+	map =3D bpf_map__fd(skel->maps.sock_map);
+	link =3D bpf_program__attach_sockmap(prog, map);
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach_sockmap"))
+		goto out;
+
+	bpf_link__detach(link);
+out:
+	test_sockmap_skb_verdict_attach__destroy(skel);
+}
+
 static __u32 query_prog_id(int prog_fd)
 {
 	struct bpf_prog_info info =3D {};
@@ -532,6 +587,33 @@ static void test_sockmap_skb_verdict_peek(void)
 	test_sockmap_pass_prog__destroy(pass);
 }
=20
+static void test_sockmap_skb_verdict_peek_with_link(void)
+{
+	struct test_sockmap_pass_prog *pass;
+	struct bpf_program *prog;
+	struct bpf_link *link;
+	int err, map;
+
+	pass =3D test_sockmap_pass_prog__open_and_load();
+	if (!ASSERT_OK_PTR(pass, "open_and_load"))
+		return;
+	prog =3D pass->progs.prog_skb_verdict;
+	map =3D bpf_map__fd(pass->maps.sock_map_rx);
+	link =3D bpf_program__attach_sockmap(prog, map);
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach_sockmap"))
+		goto out;
+
+	err =3D bpf_link__update_program(link, pass->progs.prog_skb_verdict_clo=
ne);
+	if (!ASSERT_OK(err, "bpf_link__update_program"))
+		goto out;
+
+	test_sockmap_skb_verdict_peek_helper(map);
+	ASSERT_EQ(pass->bss->clone_called, 1, "clone_called");
+out:
+	bpf_link__detach(link);
+	test_sockmap_pass_prog__destroy(pass);
+}
+
 static void test_sockmap_unconnected_unix(void)
 {
 	int err, map, stream =3D 0, dgram =3D 0, zero =3D 0;
@@ -796,6 +878,8 @@ void test_sockmap_basic(void)
 		test_sockmap_skb_verdict_attach(BPF_SK_SKB_STREAM_VERDICT,
 						BPF_SK_SKB_VERDICT);
 	}
+	if (test__start_subtest("sockmap skb_verdict attach_with_link"))
+		test_sockmap_skb_verdict_attach_with_link();
 	if (test__start_subtest("sockmap msg_verdict progs query"))
 		test_sockmap_progs_query(BPF_SK_MSG_VERDICT);
 	if (test__start_subtest("sockmap stream_parser progs query"))
@@ -812,6 +896,8 @@ void test_sockmap_basic(void)
 		test_sockmap_skb_verdict_fionread(false);
 	if (test__start_subtest("sockmap skb_verdict msg_f_peek"))
 		test_sockmap_skb_verdict_peek();
+	if (test__start_subtest("sockmap skb_verdict msg_f_peek with link"))
+		test_sockmap_skb_verdict_peek_with_link();
 	if (test__start_subtest("sockmap unconnected af_unix"))
 		test_sockmap_unconnected_unix();
 	if (test__start_subtest("sockmap one socket to many map entries"))
@@ -820,4 +906,8 @@ void test_sockmap_basic(void)
 		test_sockmap_many_maps();
 	if (test__start_subtest("sockmap same socket replace"))
 		test_sockmap_same_sock();
+	if (test__start_subtest("sockmap sk_msg attach sockmap helpers with lin=
k"))
+		test_skmsg_helpers_with_link(BPF_MAP_TYPE_SOCKMAP);
+	if (test__start_subtest("sockhash sk_msg attach sockhash helpers with l=
ink"))
+		test_skmsg_helpers_with_link(BPF_MAP_TYPE_SOCKHASH);
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/to=
ols/testing/selftests/bpf/prog_tests/sockmap_listen.c
index a92807bfcd13..54c93eee1808 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
@@ -767,6 +767,24 @@ static void test_msg_redir_to_connected(struct test_=
sockmap_listen *skel,
 	xbpf_prog_detach2(verdict, sock_map, BPF_SK_MSG_VERDICT);
 }
=20
+static void test_msg_redir_to_connected_with_link(struct test_sockmap_li=
sten *skel,
+						  struct bpf_map *inner_map, int family,
+						  int sotype)
+{
+	struct bpf_program *verdict =3D skel->progs.prog_msg_verdict;
+	int verdict_map =3D bpf_map__fd(skel->maps.verdict_map);
+	int sock_map =3D bpf_map__fd(inner_map);
+	struct bpf_link *link;
+
+	link =3D bpf_program__attach_sockmap(verdict, sock_map);
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach_sockmap"))
+		return;
+
+	redir_to_connected(family, sotype, sock_map, verdict_map, REDIR_EGRESS)=
;
+
+	bpf_link__detach(link);
+}
+
 static void redir_to_listening(int family, int sotype, int sock_mapfd,
 			       int verd_mapfd, enum redir_mode mode)
 {
@@ -869,6 +887,24 @@ static void test_msg_redir_to_listening(struct test_=
sockmap_listen *skel,
 	xbpf_prog_detach2(verdict, sock_map, BPF_SK_MSG_VERDICT);
 }
=20
+static void test_msg_redir_to_listening_with_link(struct test_sockmap_li=
sten *skel,
+						  struct bpf_map *inner_map, int family,
+						  int sotype)
+{
+	struct bpf_program *verdict =3D skel->progs.prog_msg_verdict;
+	int verdict_map =3D bpf_map__fd(skel->maps.verdict_map);
+	int sock_map =3D bpf_map__fd(inner_map);
+	struct bpf_link *link;
+
+	link =3D bpf_program__attach_sockmap(verdict, sock_map);
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach_sockmap"))
+		return;
+
+	redir_to_listening(family, sotype, sock_map, verdict_map, REDIR_EGRESS)=
;
+
+	bpf_link__detach(link);
+}
+
 static void redir_partial(int family, int sotype, int sock_map, int pars=
er_map)
 {
 	int s, c0 =3D -1, c1 =3D -1, p0 =3D -1, p1 =3D -1;
@@ -1316,7 +1352,9 @@ static void test_redir(struct test_sockmap_listen *=
skel, struct bpf_map *map,
 		TEST(test_skb_redir_to_listening),
 		TEST(test_skb_redir_partial),
 		TEST(test_msg_redir_to_connected),
+		TEST(test_msg_redir_to_connected_with_link),
 		TEST(test_msg_redir_to_listening),
+		TEST(test_msg_redir_to_listening_with_link),
 	};
 	const char *family_name, *map_name;
 	const struct redir_test *t;
diff --git a/tools/testing/selftests/bpf/progs/test_skmsg_load_helpers.c =
b/tools/testing/selftests/bpf/progs/test_skmsg_load_helpers.c
index b753672f04c9..2914fbf1b05b 100644
--- a/tools/testing/selftests/bpf/progs/test_skmsg_load_helpers.c
+++ b/tools/testing/selftests/bpf/progs/test_skmsg_load_helpers.c
@@ -49,4 +49,10 @@ int prog_msg_verdict(struct sk_msg_md *msg)
 	return prog_msg_verdict_common(msg);
 }
=20
+SEC("sk_msg")
+int prog_msg_verdict_clone(struct sk_msg_md *msg)
+{
+	return prog_msg_verdict_common(msg);
+}
+
 char _license[] SEC("license") =3D "GPL";
diff --git a/tools/testing/selftests/bpf/progs/test_sockmap_pass_prog.c b=
/tools/testing/selftests/bpf/progs/test_sockmap_pass_prog.c
index 1d86a717a290..032c3c6310d4 100644
--- a/tools/testing/selftests/bpf/progs/test_sockmap_pass_prog.c
+++ b/tools/testing/selftests/bpf/progs/test_sockmap_pass_prog.c
@@ -23,10 +23,19 @@ struct {
 	__type(value, int);
 } sock_map_msg SEC(".maps");
=20
-SEC("sk_skb")
+SEC("sk_skb/stream_verdict")
 int prog_skb_verdict(struct __sk_buff *skb)
 {
 	return SK_PASS;
 }
=20
+int clone_called;
+
+SEC("sk_skb/stream_verdict")
+int prog_skb_verdict_clone(struct __sk_buff *skb)
+{
+	clone_called =3D 1;
+	return SK_PASS;
+}
+
 char _license[] SEC("license") =3D "GPL";
diff --git a/tools/testing/selftests/bpf/progs/test_sockmap_skb_verdict_a=
ttach.c b/tools/testing/selftests/bpf/progs/test_sockmap_skb_verdict_atta=
ch.c
index 3c69aa971738..d25b0bb30fc0 100644
--- a/tools/testing/selftests/bpf/progs/test_sockmap_skb_verdict_attach.c
+++ b/tools/testing/selftests/bpf/progs/test_sockmap_skb_verdict_attach.c
@@ -9,7 +9,7 @@ struct {
 	__type(value, __u64);
 } sock_map SEC(".maps");
=20
-SEC("sk_skb")
+SEC("sk_skb/verdict")
 int prog_skb_verdict(struct __sk_buff *skb)
 {
 	return SK_DROP;
--=20
2.43.0

