Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78BE379EF2;
	Tue, 24 Mar 2026 08:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774340471; cv=none; b=O6sHX7WZDZUzM2hSbafEAoDL0wqy9IGFtsbU4POQgeMY42OYQ5wTDyjhAQKqeHIf0BP9P5vWZPXIbVFy7Z2jQuLr618k8MSsxQeLLA5I7/4ADWvMlOT7s3961kK4y51Vox64AVpWB+/iWde9EecNKLHMB1kQXhTANeYUHqg2bbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774340471; c=relaxed/simple;
	bh=lZRBpv2EoCrYhYT4+Fibd7bR3HWjmQg7YCHm8mGVOjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hmw/azZQO4e5Y9nQxLRCFXmQxY9sw/x7Iy+kRPqU3L7IaxuPv9Sc2bnRuplMq3Qbqo6T7XrDS/99gBmnwJKOuZM3g1mZ84CKSvxqb/+SUoiCK9RBpldif9StM2v42mq187FKm8mQJjOycFtqw82VK3gfLotFMOZqBQGqEnTHsaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QrvgMr90; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QrvgMr90"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F3B6C19424;
	Tue, 24 Mar 2026 08:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774340471;
	bh=lZRBpv2EoCrYhYT4+Fibd7bR3HWjmQg7YCHm8mGVOjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QrvgMr90Heo2Q4aJV+7DiDes8zGIYIJEd0z0VMF7l4NJmfH9uMFinSg7HfFKtokBG
	 F6NEEF2562c6kp8KQLE9kkvOKq+wOhZcEgTBPk6S0JYybC0MdnSyervM9nYPiRpPl5
	 St3KhcJmlPrqUIjBjufM23izbXpU9GahNUBeASTUVeFUqoUus+khVwSlWS8vdEOBpf
	 XdR8L2bwkdmFTHgXderI8EDGyQZ2EWDswBEBYqtFRcFMOies8VlDQzmao3l7YQaStQ
	 he8tQI+6AO0cLgf5ZwOsPOGehn++3qn4hQgSGQ3/C5di8AuPvfnCZeASn4nIwXLQMf
	 sFxwDiXaPRuxg==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Steven Rostedt <rostedt@kernel.org>
Subject: [PATCHv4 bpf-next 13/25] bpf: Add support for tracing_multi link fdinfo
Date: Tue, 24 Mar 2026 09:18:34 +0100
Message-ID: <20260324081846.2334094-14-jolsa@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260324081846.2334094-1-jolsa@kernel.org>
References: <20260324081846.2334094-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding tracing_multi link fdinfo support with following output:

pos:    0
flags:  02000000
mnt_id: 19
ino:    3091
link_type:      tracing_multi
link_id:        382
prog_tag:       62073a1123f07ef7
prog_id:        715
cnt:    10
cookie   BTF-id  func
8        91203   bpf_fentry_test1+0x4/0x10
9        91205   bpf_fentry_test2+0x4/0x10
7        91206   bpf_fentry_test3+0x4/0x20
5        91207   bpf_fentry_test4+0x4/0x20
4        91208   bpf_fentry_test5+0x4/0x20
2        91209   bpf_fentry_test6+0x4/0x20
3        91210   bpf_fentry_test7+0x4/0x10
1        91211   bpf_fentry_test8+0x4/0x10
10       91212   bpf_fentry_test9+0x4/0x10
6        91204   bpf_fentry_test10+0x4/0x10

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/trace/bpf_trace.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 761501ce3a5f..41b691e83dc4 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3618,9 +3618,35 @@ static void bpf_tracing_multi_link_dealloc(struct bpf_link *link)
 	kvfree(tr_link);
 }
 
+#ifdef CONFIG_PROC_FS
+static void bpf_tracing_multi_show_fdinfo(const struct bpf_link *link,
+					  struct seq_file *seq)
+{
+	struct bpf_tracing_multi_link *tr_link =
+		container_of(link, struct bpf_tracing_multi_link, link);
+	bool has_cookies = !!tr_link->cookies;
+
+	seq_printf(seq, "cnt:\t%u\n", tr_link->nodes_cnt);
+
+	seq_printf(seq, "%s\t %s\t %s\n", "cookie", "BTF-id", "func");
+	for (int i = 0; i < tr_link->nodes_cnt; i++) {
+		struct bpf_tracing_multi_node *mnode = &tr_link->nodes[i];
+		u32 btf_id;
+
+		bpf_trampoline_unpack_key(mnode->trampoline->key, NULL, &btf_id);
+		seq_printf(seq, "%llu\t %u\t %pS\n",
+			   has_cookies ? tr_link->cookies[i] : 0,
+			   btf_id, (void *) mnode->trampoline->ip);
+	}
+}
+#endif
+
 static const struct bpf_link_ops bpf_tracing_multi_link_lops = {
 	.release = bpf_tracing_multi_link_release,
 	.dealloc_deferred = bpf_tracing_multi_link_dealloc,
+#ifdef CONFIG_PROC_FS
+	.show_fdinfo = bpf_tracing_multi_show_fdinfo,
+#endif
 };
 
 int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr)
-- 
2.53.0

