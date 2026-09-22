Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E1B396B73;
	Tue, 22 Sep 2026 02:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790045730; cv=none; b=dCTdII2CELhmuBpJF6UN4gBkR2ScPxw3HVoUkbZ3sCGNqBJcb3st7/kUBLMa1Sj9BVq4XAtsIotwsDosijQ3xr+Tjkg9evkRKzaDHZPkZvGW5tacRg4A/w1R4hC8tzzxtrpaF/jHp0uwMXyh32XIM4J/x4IGhgjRsz+0wj61+TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790045730; c=relaxed/simple;
	bh=0xzZVOhoypwAdF5+Xju08tZYyhoMjnoxCtlg3ugodOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qmAMQOldst9GbFR8EDC8BsRouX0dHYcOipvu1pyO/I2ZlFhi4he5CYkfLVdIZBC+nsV5bgVVxOmsaLvpsO/IBbXl0n9ogoVWHWgZsxcvoWn95Ac1lwyy8Q5MQopH1ns5Txrv2HxFmm6NUAlfS8c/UdpeyU3TX/zNPYpCTPbc1Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=bytErMrh; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="bytErMrh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=cb
	55GOKo+r5kxR5wVL0sF6MPAalrQ/xmn6/rb5ZTF6I=; b=bytErMrhSD0epy/Jkt
	pF9c5n+b5e+PWB+/czsKEt+vfp+wHVD35Ux5driXB7+UHFu1JZ/3ZSx2R7cJVIKm
	uVX6CHwmBPRyGA/Kcl97HpI0zHqrDuedwI9YnZ9DqGsaEggCFTP5Z7hlnA5v7eAg
	3p/PatXV/CEfimwyM8UuZrh/s=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wDXf5f17bFqiWEXAA--.13164S2;
	Tue, 22 Sep 2026 10:54:46 +0800 (CST)
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
Subject: [PATCH bpf-next v3 2/3] selftests/bpf: Test querying BPF_F_PREORDER cgroup attachments
Date: Tue, 22 Sep 2026 11:54:41 +0900
Message-ID: <20260922025442.3176057-3-sh_def@163.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922025442.3176057-1-sh_def@163.com>
References: <20260922025442.3176057-1-sh_def@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXf5f17bFqiWEXAA--.13164S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWw4xKFyfXw1UCw48Gw1DAwb_yoWrKF1xpF
	ykXFy7tF1rXa4UXa15t3y7Zr4avFn7X3W2kFWFgwn09FWDWFy09ry8KF4YyF1ft395Zw1I
	vwn0vrsxXr1DWF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pi5CzJUUUUU=
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbC6Ra-H2qx7fYr2gAA3u

Extend cgroup_mprog_opts selftests to verify that BPF_PROG_QUERY reports
BPF_F_PREORDER in prog_attach_flags for both direct program and link
attachments.

Verify that:
- Programs attached with BPF_F_PREORDER report
  BPF_F_ALLOW_MULTI | BPF_F_PREORDER (0x42) in prog_attach_flags.
- Programs attached without BPF_F_PREORDER report BPF_F_ALLOW_MULTI
  (0x2).
- Transient flags such as BPF_F_AFTER or BPF_F_LINK are not present in
  prog_attach_flags.

Signed-off-by: Hui Su <sh_def@163.com>
---

Notes (bpf-preorder-v3-20260922-check):
    Testing:
    - PASS: ./test_progs -t cgroup_preorder (x86_64 QEMU/KVM).
    - Result reused after a content-equivalent rebase; the patch diff is unchanged.

 .../bpf/prog_tests/cgroup_mprog_opts.c        | 71 ++++++++++++++++++-
 1 file changed, 69 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_mprog_opts.c b/tools/testing/selftests/bpf/prog_tests/cgroup_mprog_opts.c
index bb60704a3ef9..9ec5e4f96312 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgroup_mprog_opts.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_mprog_opts.c
@@ -273,11 +273,64 @@ static void test_link_attach_detach(int atype)
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
+static void assert_preorder_query_flags(int cg, int atype,
+					__u32 id1, __u32 id2,
+					__u32 id3, __u32 id4)
+{
+	LIBBPF_OPTS(bpf_prog_query_opts, optq);
+	__u32 prog_attach_flags[10] = {};
+	__u32 prog_ids[10] = {};
+	__u32 flags;
+	int err;
+
+	optq.prog_ids = prog_ids;
+	optq.prog_attach_flags = prog_attach_flags;
+	optq.count = 10;
+	err = bpf_prog_query_opts(cg, atype, &optq);
+	if (!ASSERT_OK(err, "prog_query"))
+		return;
+
+	ASSERT_EQ(optq.count, 4, "count");
+
+	/* Match by prog_id to avoid relying on query order. */
+	err = find_prog_attach_flags(&optq, id1, &flags);
+	if (ASSERT_OK(err, "find id1"))
+		ASSERT_EQ(flags, BPF_F_ALLOW_MULTI, "flags id1");
+
+	err = find_prog_attach_flags(&optq, id2, &flags);
+	if (ASSERT_OK(err, "find id2"))
+		ASSERT_EQ(flags, BPF_F_ALLOW_MULTI | BPF_F_PREORDER,
+			  "flags id2");
+
+	err = find_prog_attach_flags(&optq, id3, &flags);
+	if (ASSERT_OK(err, "find id3"))
+		ASSERT_EQ(flags, BPF_F_ALLOW_MULTI | BPF_F_PREORDER,
+			  "flags id3");
+
+	err = find_prog_attach_flags(&optq, id4, &flags);
+	if (ASSERT_OK(err, "find id4"))
+		ASSERT_EQ(flags, BPF_F_ALLOW_MULTI, "flags id4");
+}
+
 static void test_preorder_prog_attach_detach(int atype)
 {
 	LIBBPF_OPTS(bpf_prog_attach_opts, opta);
 	LIBBPF_OPTS(bpf_prog_detach_opts, optd);
-	__u32 fd1, fd2, fd3, fd4;
+	__u32 fd1, fd2, fd3, fd4, id1, id2, id3, id4;
 	struct cgroup_mprog *skel;
 	int cg, err;
 
@@ -294,6 +347,11 @@ static void test_preorder_prog_attach_detach(int atype)
 	fd3 = bpf_program__fd(skel->progs.getsockopt_3);
 	fd4 = bpf_program__fd(skel->progs.getsockopt_4);
 
+	id1 = id_from_prog_fd(fd1);
+	id2 = id_from_prog_fd(fd2);
+	id3 = id_from_prog_fd(fd3);
+	id4 = id_from_prog_fd(fd4);
+
 	assert_mprog_count(cg, atype, 0);
 
 	LIBBPF_OPTS_RESET(opta,
@@ -357,6 +415,8 @@ static void test_preorder_prog_attach_detach(int atype)
 
 	assert_mprog_count(cg, atype, 4);
 
+	assert_preorder_query_flags(cg, atype, id1, id2, id3, id4);
+
 	err = bpf_prog_detach_opts(fd4, cg, atype, &optd);
 	ASSERT_OK(err, "prog_detach");
 	assert_mprog_count(cg, atype, 3);
@@ -386,7 +446,7 @@ static void test_preorder_link_attach_detach(int atype)
 	LIBBPF_OPTS(bpf_cgroup_opts, opta);
 	struct bpf_link *link1, *link2, *link3, *link4;
 	struct cgroup_mprog *skel;
-	__u32 fd2;
+	__u32 fd2, id1, id2, id3, id4;
 	int cg;
 
 	cg = test__join_cgroup("/preorder_link_attach_detach");
@@ -399,6 +459,11 @@ static void test_preorder_link_attach_detach(int atype)
 
 	fd2 = bpf_program__fd(skel->progs.getsockopt_2);
 
+	id1 = id_from_prog_fd(bpf_program__fd(skel->progs.getsockopt_1));
+	id2 = id_from_prog_fd(fd2);
+	id3 = id_from_prog_fd(bpf_program__fd(skel->progs.getsockopt_3));
+	id4 = id_from_prog_fd(bpf_program__fd(skel->progs.getsockopt_4));
+
 	assert_mprog_count(cg, atype, 0);
 
 	LIBBPF_OPTS_RESET(opta,
@@ -460,6 +525,8 @@ static void test_preorder_link_attach_detach(int atype)
 
 	assert_mprog_count(cg, atype, 4);
 
+	assert_preorder_query_flags(cg, atype, id1, id2, id3, id4);
+
 	bpf_link__destroy(link4);
 	assert_mprog_count(cg, atype, 3);
 
-- 
2.55.0

