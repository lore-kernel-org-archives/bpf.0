Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F705D75D
	for <bpf@vger.kernel.org>; Thu, 14 Mar 2024 15:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710428721; cv=none; b=ZWuIuBiKp2mi7vhsjAjt4L82yGiUQQW+mV1qzDmXmDqUuOSEhq/JycYAVUGBrAKfgnHwgkI1gCgzERmD2nG3JJ+lD2fcRUIYIk7O6QVT24T3J0w1sqxQioR3rUQzVaqY98Icdj60jB173FUgv1WYJgT+BZHxeMJ6SvgZ8bA6NiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710428721; c=relaxed/simple;
	bh=/ZOE4ZNDwWzj9JvUeVN9qTKbPV+a/h5Po7XlsY+K8i4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TTkfY1DFtgR/HT+NUb4un2wR++tPViqci4LyNNEMsLo/Xt6JPMkSyImHeiglXbnehWB2jOhKDKd+ZOnJ+mPjWkJNXd9ivdc9g0mnj8tBtffehYRZT3x+zn6zrIjoq8ySO7f/uywS5rzPCAzimKJZRdo91BmMNa74q4e2udmShD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mmsjcjyY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mmsjcjyY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72E65C433C7;
	Thu, 14 Mar 2024 15:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710428721;
	bh=/ZOE4ZNDwWzj9JvUeVN9qTKbPV+a/h5Po7XlsY+K8i4=;
	h=From:To:Cc:Subject:Date:From;
	b=mmsjcjyY98o9NMyyeF/usxbxxfpU1/Pn7sRk1gWYsgnTwthGzmQlVzsyvHBgucJpG
	 l4ZU3KZ60KBn46bofbWq1FcrlLVK+YF41uHHQghV7EvUQJR6vrsTcX1KV/rM0+/fQT
	 f+sSODe5KLw3hGco7Xdtf2n4aQHQVXRscbIARNZrmhHyAd0/JoVqo7jXFGHOl4NZan
	 0efn4rBCPZfOCd1eK2RR8C10ncJ2SeWSbwksfYQ09QBXvU+jyn7kqbHTfdZeWYDJaf
	 SH2pbmAlC3mdmAg16Z9YS6pvHGbyb7q0TBQnmXTNd2bHDjE9uMNy0vMeWLLHE1YMh5
	 PcimoH9VxBLig==
From: qmo@kernel.org
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	Quentin Monnet <qmo@kernel.org>
Subject: [PATCH bpf-next v2] libbpf: Prevent null-pointer dereference when prog to load has no BTF
Date: Thu, 14 Mar 2024 15:04:38 +0000
Message-Id: <20240314150438.232462-1-qmo@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Quentin Monnet <qmo@kernel.org>

In bpf_objec_load_prog(), there's no guarantee that obj->btf is non-NULL
when passing it to btf__fd(), and this function does not perform any
check before dereferencing its argument (as bpf_object__btf_fd() used to
do). As a consequence, we get segmentation fault errors in bpftool (for
example) when trying to load programs that come without BTF information.

v2: Keep btf__fd() in the fix instead of reverting to bpf_object__btf_fd().

Fixes: df7c3f7d3a3d ("libbpf: make uniform use of btf__fd() accessor inside libbpf")
Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Quentin Monnet <qmo@kernel.org>
---
v1 was: 'Revert "libbpf: make uniform use of btf__fd() accessor inside libbpf"'
---
 tools/lib/bpf/libbpf.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index efab29b8935b..124883eaa0cf 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -7317,9 +7317,9 @@ static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog
 	char *cp, errmsg[STRERR_BUFSIZE];
 	size_t log_buf_size = 0;
 	char *log_buf = NULL, *tmp;
-	int btf_fd, ret, err;
 	bool own_log_buf = true;
 	__u32 log_level = prog->log_level;
+	int ret, err;
 
 	if (prog->type == BPF_PROG_TYPE_UNSPEC) {
 		/*
@@ -7343,9 +7343,8 @@ static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog
 	load_attr.prog_ifindex = prog->prog_ifindex;
 
 	/* specify func_info/line_info only if kernel supports them */
-	btf_fd = btf__fd(obj->btf);
-	if (btf_fd >= 0 && kernel_supports(obj, FEAT_BTF_FUNC)) {
-		load_attr.prog_btf_fd = btf_fd;
+	if (obj->btf && btf__fd(obj->btf) >= 0 && kernel_supports(obj, FEAT_BTF_FUNC)) {
+		load_attr.prog_btf_fd = btf__fd(obj->btf);
 		load_attr.func_info = prog->func_info;
 		load_attr.func_info_rec_size = prog->func_info_rec_size;
 		load_attr.func_info_cnt = prog->func_info_cnt;
-- 
2.34.1

