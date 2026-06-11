Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DFE3E8356
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 11:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781178167; cv=none; b=Ljde9W4TYWtQtm4z+8fMoiA8lImzBXKwRqAmu2bTbl2MlqTjP6h4twsj/F416MNMTsx4Esj2Y5xzJvsjn4X6f8j98eLujZO1/EYG3aVceK1lGs0tuaU20/PqBwfyTPIjj9yUjNlSPfEHVgEcxT9wvppjukiSIuJmz8y4B1Mq+k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781178167; c=relaxed/simple;
	bh=jVM22laFmY+m9wu3ovT2n5FzBa6xr2+qoIrsK/TXuAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BSbh3F5TNU+jHi/WlqQExPmBOFozSnonW2j0c2ZPd0yrkZsHXG9HM7aFRN2zbMdA4wJ9yHTzGYxcsZEXiElly7MyyFLG95bbd8Z2VsmWdVqpdew37ptM8ijqcjYUoWxvp+m6tq4DAbwi39QOsSlAgfUz1/PUiqh3wE7E7agKxWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ryso2RCc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ryso2RCc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 918051F00893;
	Thu, 11 Jun 2026 11:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781178165;
	bh=D3W9ePesDNOLr8UgGui5svJUMXbGAdkAwOdK0Bxcres=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ryso2RCcRtMQgcCc6lVtgg5CrHHFOcT0Upb7JAIa+fSEdwIV4bKzvvTvOh2QnW8Qw
	 rzz4XexpOaQ5Fg2QJyjl3Wh9JBzK/qQ8YJhnchhbn6HkkjcWWZfImPlrkCkw7mrjSq
	 eL9zaVXE+Ly8xpYrBN9NH/DTlD46ljwe4nJ4xY/8/cRAhNgJpuNnq0jj1DzhyhBUfJ
	 I0X3ZWg0xkLDc6KqPcvSZzdZpOwFMMCA4vgrlQlI5OM6nVXX8SjUb0h9rm84KQKmRC
	 Sp6ZsVNIcOEEq1EHSThr57KbBRSUyY/vXNXVLaXgykxfz5/6sB1GkJ8xKZN4PMOqzv
	 lePcJ0XXUG/9Q==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCHv3 bpf-next 1/7] bpf: Guard __get_user acesss with access_ok for uprobe_multi data
Date: Thu, 11 Jun 2026 13:42:24 +0200
Message-ID: <20260611114230.950379-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611114230.950379-1-jolsa@kernel.org>
References: <20260611114230.950379-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As reported by sashiko [1] we need to use access_ok to check the user
space data bounds before we use __get-user to get it.

[1] https://lore.kernel.org/bpf/20260610145235.CB1441F00893@smtp.kernel.org/
Fixes: 0b779b61f651 ("bpf: Add cookies support for uprobe_multi link")
Fixes: 89ae89f53d20 ("bpf: Add multi uprobe link")
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/trace/bpf_trace.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 90432f0fc2a8..b5a12af2d3f8 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3224,6 +3224,7 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 	unsigned long __user *uoffsets;
 	u64 __user *ucookies;
 	void __user *upath;
+	unsigned long size;
 	u32 flags, cnt, i;
 	struct path path;
 	char *name;
@@ -3261,6 +3262,16 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 	uref_ctr_offsets = u64_to_user_ptr(attr->link_create.uprobe_multi.ref_ctr_offsets);
 	ucookies = u64_to_user_ptr(attr->link_create.uprobe_multi.cookies);
 
+	/*
+	 * All uoffsets/uref_ctr_offsets/ucookies arrays have the same value
+	 * size, we need to check their address range is safe for __get_user
+	 * calls.
+	 */
+	size = sizeof(*uoffsets) * cnt;
+	if (!access_ok(uoffsets, size) || !access_ok(uref_ctr_offsets, size) ||
+	    !access_ok(ucookies, size))
+		return -EFAULT;
+
 	name = strndup_user(upath, PATH_MAX);
 	if (IS_ERR(name)) {
 		err = PTR_ERR(name);
-- 
2.54.0

