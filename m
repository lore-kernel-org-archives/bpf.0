Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6801272CC
	for <bpf@vger.kernel.org>; Tue,  5 Mar 2024 20:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709670156; cv=none; b=a1iqNnlRPVXWWiR0loLM3mfjMLvoEALw+MBz7oLKbFTR4+E/UGT8fgC4msNob3+tLhWtp17kYb5EMg7YtqPvw4VzbkSsWd2bC2Z0v5jXOZqBkNtSqSr1LXNE5qZcaP8dOOgpxjWCRL9v3efm0f19pKow20SzYKW1Tl4g9+iZhrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709670156; c=relaxed/simple;
	bh=MMALlOIIbeAtcNLw1RPXJnh0FlrbdcsyK+VZwU9Cl4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k7AcpYJeBG+TwTfp9DdEU5nP9KeOkKqj91DU2RM7SAnETZ7lZGHHfpJnm9NWXywmq72nHOd34KTsmdrlqwi4KHKQW4TMChsg10aD/3uJFC5AVBN5OPFInMvKn82fFa8IGz/dJ7acWg4yeuvZcxNc+6Q9oUTaAp1OsgToPK5d50o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 681AA14A91BF; Tue,  5 Mar 2024 12:22:21 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [RFC PATCH bpf-next 5/5] selftests/bpf: Add some tests with new bpf_program__attach_sk_msg() API
Date: Tue,  5 Mar 2024 12:22:21 -0800
Message-ID: <20240305202221.3892487-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240305202155.3890667-1-yonghong.song@linux.dev>
References: <20240305202155.3890667-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In sockmap_basic.c and sockmap_listen.c, there are a few tests
dealing with BPF_PROG_TYPE_SK_MSG and those tests are using
prog attach/detach. This patch added new tests by copying the
original corresponding tests but using bpf_program__attach_sk_msg()
and bpf_link__detach() APIs.

All tests are passed.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 27 +++++++++++++
 .../selftests/bpf/prog_tests/sockmap_listen.c | 38 +++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/too=
ls/testing/selftests/bpf/prog_tests/sockmap_basic.c
index 77e26ecffa9d..37eb1ce414a3 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
@@ -131,6 +131,29 @@ static void test_skmsg_helpers(enum bpf_map_type map=
_type)
 	test_skmsg_load_helpers__destroy(skel);
 }
=20
+static void test_skmsg_helpers_with_link(enum bpf_map_type map_type)
+{
+	struct test_skmsg_load_helpers *skel;
+	struct bpf_program *prog;
+	struct bpf_link *link;
+	int map;
+
+	skel =3D test_skmsg_load_helpers__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "test_skmsg_load_helpers__open_and_load"))
+		return;
+
+	prog =3D skel->progs.prog_msg_verdict;
+	map =3D bpf_map__fd(skel->maps.sock_map);
+
+	link =3D bpf_program__attach_sk_msg(prog, map, BPF_SK_MSG_VERDICT);
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach_sk_msg"))
+		goto out;
+
+	close(bpf_link__fd(link));
+out:
+	test_skmsg_load_helpers__destroy(skel);
+}
+
 static void test_sockmap_update(enum bpf_map_type map_type)
 {
 	int err, prog, src;
@@ -812,4 +835,8 @@ void test_sockmap_basic(void)
 		test_sockmap_many_maps();
 	if (test__start_subtest("sockmap same socket replace"))
 		test_sockmap_same_sock();
+	if (test__start_subtest("sockmap sk_msg attach helpers with link"))
+		test_skmsg_helpers_with_link(BPF_MAP_TYPE_SOCKMAP);
+	if (test__start_subtest("sockhash sk_msg attach helpers with link"))
+		test_skmsg_helpers_with_link(BPF_MAP_TYPE_SOCKHASH);
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/to=
ols/testing/selftests/bpf/prog_tests/sockmap_listen.c
index a92807bfcd13..4bff0a857b04 100644
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
+	link =3D bpf_program__attach_sk_msg(verdict, sock_map, BPF_SK_MSG_VERDI=
CT);
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach_sk_msg"))
+		return;
+
+	redir_to_connected(family, sotype, sock_map, verdict_map, REDIR_EGRESS)=
;
+
+	close(bpf_link__fd(link));
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
+	link =3D bpf_program__attach_sk_msg(verdict, sock_map, BPF_SK_MSG_VERDI=
CT);
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach_sk_msg"))
+		return;
+
+	redir_to_listening(family, sotype, sock_map, verdict_map, REDIR_EGRESS)=
;
+
+	close(bpf_link__fd(link));
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
--=20
2.43.0

