Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E5651B172;
	Fri, 18 Sep 2026 17:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789752304; cv=none; b=czxARAsXWzDTMNNWzISw57lz365o80yc5k7h4IfGrEzNSRzHRGjlROQwN8JalBudA0cnBULGHvofRylZIdFTTgzqHftbEFTW4Xt+5/eWV/VrGHYB0S3/erUEUSz6p8fGjww2ShgSiHdalNOTvZs0m82YHOgCE6d1GwukHSPE3y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789752304; c=relaxed/simple;
	bh=k9loHwbjbFtNefqL9fgH782oIzs3XLn/+r9Ypzw4pk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cAaPe3P2cKOXTdbNva1NeD6h0kHOdfBAvDTtXgMiEwM22It6dG9QCNY8SMpZNeXq9hh24/jJHxCHErf6E3Y92x7P2InWLLr1oW+JHe62KxNTK73S1HgRIIGuVKyjcA8MxUY8XhgA3eBBruZHSn4r2UXtIX/c7zXHsD9GuqV7+9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Z1sevU0p; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Z1sevU0p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=LO
	NQR/eTuMAe5RuWYz+f969kvAnzBf9rM/KZ984g2kg=; b=Z1sevU0pS9ofcMSHOo
	eTXqxGrHZoCEIueEcfha+uT2t/CATKWCQouePoLXivBemA6kQ/b1yPNrNHqpZbcq
	MkRf12Y/63affycHnTBvTMkbhvGcgGs9mkfvkEMnVDKvOal07Hm3Rnc06bTR449i
	f3YwrSXYT/RXnaDrJPixt4Gu4=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wCHKsy6c61q2cb6BQ--.22248S2;
	Sat, 19 Sep 2026 01:24:11 +0800 (CST)
From: Hui Su <sh_def@163.com>
To: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>,
	Quentin Monnet <qmo@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hui Su <sh_def@163.com>
Subject: [PATCH bpf 2/3] selftests/bpf: Test querying BPF_F_PREORDER cgroup attachments
Date: Sat, 19 Sep 2026 02:24:06 +0900
Message-ID: <20260918172407.3459188-3-sh_def@163.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918172407.3459188-1-sh_def@163.com>
References: <20260918172407.3459188-1-sh_def@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCHKsy6c61q2cb6BQ--.22248S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Jr4kWw4UKrykuFW5Kr15Arb_yoWxGr15pF
	ykXFyUKF15Xa4UXF4Ut3y7Zr42qF1DXF1YkrZ5Wr1Y9FWUWFyv9ryrKF4YkFyft3yDZw1I
	vwn8Zrs8XrWDWF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pi5CzJUUUUU=
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbC6hsRcGqtc7ueCgAA3L

Extend cgroup_mprog_opts selftests to verify that BPF_PROG_QUERY reports
BPF_F_PREORDER in prog_attach_flags for both direct program and link
attachments.

Specifically, in test_preorder_prog_attach_detach() and
test_preorder_link_attach_detach(), verify that:
- Programs attached with BPF_F_PREORDER report
  BPF_F_ALLOW_MULTI | BPF_F_PREORDER (0x42) in prog_attach_flags.
- Programs attached without BPF_F_PREORDER report BPF_F_ALLOW_MULTI (0x2).
- Transient flags such as BPF_F_AFTER or BPF_F_LINK are not present in
  prog_attach_flags.
- Per-program attach flags are validated by matching each attached prog_id
  via a query helper, avoiding fragile assumptions on the internal slot
  order of the direct query list.

Signed-off-by: Hui Su <sh_def@163.com>
---
 .../bpf/prog_tests/cgroup_mprog_opts.c        | 94 ++++++++++++++++++-
 1 file changed, 91 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_mprog_opts.c b/tools/testing/selftests/bpf/prog_tests/cgroup_mprog_opts.c
index bb60704a3ef9..343357d9c460 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgroup_mprog_opts.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_mprog_opts.c
@@ -273,13 +273,31 @@ static void test_link_attach_detach(int atype)
 	close(cg);
 }
 
+static int find_prog_attach_flags(const struct bpf_prog_query_opts *opts,
+				  __u32 prog_id, __u32 *flags)
+{
+	__u32 i;
+
+	for (i = 0; i < opts->count; i++) {
+		if (opts->prog_ids[i] == prog_id) {
+			*flags = opts->prog_attach_flags[i];
+			return 0;
+		}
+	}
+	return -ENOENT;
+}
+
 static void test_preorder_prog_attach_detach(int atype)
 {
 	LIBBPF_OPTS(bpf_prog_attach_opts, opta);
 	LIBBPF_OPTS(bpf_prog_detach_opts, optd);
-	__u32 fd1, fd2, fd3, fd4;
+	LIBBPF_OPTS(bpf_prog_query_opts, optq);
+	__u32 fd1, fd2, fd3, fd4, id1, id2, id3, id4;
+	__u32 prog_attach_flags[10] = {0};
+	__u32 prog_ids[10] = {0};
 	struct cgroup_mprog *skel;
 	int cg, err;
+	__u32 flags;
 
 	cg = test__join_cgroup("/preorder_prog_attach_detach");
 	if (!ASSERT_GE(cg, 0, "join_cgroup /preorder_prog_attach_detach"))
@@ -294,6 +312,11 @@ static void test_preorder_prog_attach_detach(int atype)
 	fd3 = bpf_program__fd(skel->progs.getsockopt_3);
 	fd4 = bpf_program__fd(skel->progs.getsockopt_4);
 
+	id1 = id_from_prog_fd(fd1);
+	id2 = id_from_prog_fd(fd2);
+	id3 = id_from_prog_fd(fd3);
+	id4 = id_from_prog_fd(fd4);
+
 	assert_mprog_count(cg, atype, 0);
 
 	LIBBPF_OPTS_RESET(opta,
@@ -357,6 +380,34 @@ static void test_preorder_prog_attach_detach(int atype)
 
 	assert_mprog_count(cg, atype, 4);
 
+	optq.prog_ids = prog_ids;
+	optq.prog_attach_flags = prog_attach_flags;
+	optq.count = 10;
+	err = bpf_prog_query_opts(cg, atype, &optq);
+	if (!ASSERT_OK(err, "prog_query"))
+		goto cleanup4;
+
+	ASSERT_EQ(optq.count, 4, "count");
+	/* Direct query reports attached programs in cgroup list order.
+	 * Lookup by prog_id to verify per-program flags independently of slot index.
+	 */
+	err = find_prog_attach_flags(&optq, id1, &flags);
+	if (ASSERT_OK(err, "find id1"))
+		ASSERT_EQ(flags, BPF_F_ALLOW_MULTI, "flags id1");
+
+	err = find_prog_attach_flags(&optq, id2, &flags);
+	if (ASSERT_OK(err, "find id2"))
+		ASSERT_EQ(flags, BPF_F_ALLOW_MULTI | BPF_F_PREORDER, "flags id2");
+
+	err = find_prog_attach_flags(&optq, id3, &flags);
+	if (ASSERT_OK(err, "find id3"))
+		ASSERT_EQ(flags, BPF_F_ALLOW_MULTI | BPF_F_PREORDER, "flags id3");
+
+	err = find_prog_attach_flags(&optq, id4, &flags);
+	if (ASSERT_OK(err, "find id4"))
+		ASSERT_EQ(flags, BPF_F_ALLOW_MULTI, "flags id4");
+
+cleanup4:
 	err = bpf_prog_detach_opts(fd4, cg, atype, &optd);
 	ASSERT_OK(err, "prog_detach");
 	assert_mprog_count(cg, atype, 3);
@@ -384,10 +435,14 @@ static void test_preorder_prog_attach_detach(int atype)
 static void test_preorder_link_attach_detach(int atype)
 {
 	LIBBPF_OPTS(bpf_cgroup_opts, opta);
+	LIBBPF_OPTS(bpf_prog_query_opts, optq);
 	struct bpf_link *link1, *link2, *link3, *link4;
 	struct cgroup_mprog *skel;
-	__u32 fd2;
-	int cg;
+	__u32 fd2, id1, id2, id3, id4;
+	__u32 prog_attach_flags[10] = {0};
+	__u32 prog_ids[10] = {0};
+	int cg, err;
+	__u32 flags;
 
 	cg = test__join_cgroup("/preorder_link_attach_detach");
 	if (!ASSERT_GE(cg, 0, "join_cgroup /preorder_link_attach_detach"))
@@ -399,6 +454,11 @@ static void test_preorder_link_attach_detach(int atype)
 
 	fd2 = bpf_program__fd(skel->progs.getsockopt_2);
 
+	id1 = id_from_prog_fd(bpf_program__fd(skel->progs.getsockopt_1));
+	id2 = id_from_prog_fd(fd2);
+	id3 = id_from_prog_fd(bpf_program__fd(skel->progs.getsockopt_3));
+	id4 = id_from_prog_fd(bpf_program__fd(skel->progs.getsockopt_4));
+
 	assert_mprog_count(cg, atype, 0);
 
 	LIBBPF_OPTS_RESET(opta,
@@ -460,6 +520,34 @@ static void test_preorder_link_attach_detach(int atype)
 
 	assert_mprog_count(cg, atype, 4);
 
+	optq.prog_ids = prog_ids;
+	optq.prog_attach_flags = prog_attach_flags;
+	optq.count = 10;
+	err = bpf_prog_query_opts(cg, atype, &optq);
+	if (!ASSERT_OK(err, "prog_query"))
+		goto cleanup4;
+
+	ASSERT_EQ(optq.count, 4, "count");
+	/* Direct query reports attached programs in cgroup list order.
+	 * Lookup by prog_id to verify per-program flags independently of slot index.
+	 */
+	err = find_prog_attach_flags(&optq, id1, &flags);
+	if (ASSERT_OK(err, "find id1"))
+		ASSERT_EQ(flags, BPF_F_ALLOW_MULTI, "flags id1");
+
+	err = find_prog_attach_flags(&optq, id2, &flags);
+	if (ASSERT_OK(err, "find id2"))
+		ASSERT_EQ(flags, BPF_F_ALLOW_MULTI | BPF_F_PREORDER, "flags id2");
+
+	err = find_prog_attach_flags(&optq, id3, &flags);
+	if (ASSERT_OK(err, "find id3"))
+		ASSERT_EQ(flags, BPF_F_ALLOW_MULTI | BPF_F_PREORDER, "flags id3");
+
+	err = find_prog_attach_flags(&optq, id4, &flags);
+	if (ASSERT_OK(err, "find id4"))
+		ASSERT_EQ(flags, BPF_F_ALLOW_MULTI, "flags id4");
+
+cleanup4:
 	bpf_link__destroy(link4);
 	assert_mprog_count(cg, atype, 3);
 
-- 
2.55.0

