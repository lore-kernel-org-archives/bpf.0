Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626DD3CCFD1;
	Fri, 17 Apr 2026 19:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776454087; cv=none; b=tzIeRG00E1UkCIqySv61RN3OpU+ZVqz5OExcZbHtVPePLiNuwrDjsUicZI5E0MKPDoXYjAHOIc0JQnTbNrdbkivryVeGGko8X/3e8dIGW3viYmVIcIFXfzZ0gLPake5Xw9anbXQ3GDNUCcnMl5IFRMV9oiWExsTwVC5gebFZb9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776454087; c=relaxed/simple;
	bh=CMETxZGOBpdMreAkPevI7QAY16ozc/jDr+4l673+hy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sMaMIEVYxWjm74EcXmRT5KrsHxGv5P6/GV0EHmr5Gr+VNz37NH0T6TNHDMNePukwq85yta8iZz8Y40UgqQkbngy7CLoJFQk+5IJg33V3PsfSCL5SO39Hm7PyZwh1J4DiEafyWNimmuA8MLZsKsQ3OZbeBAvMAwaTuRlFh2pv7jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NYPXTc48; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NYPXTc48"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CF42C19425;
	Fri, 17 Apr 2026 19:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776454087;
	bh=CMETxZGOBpdMreAkPevI7QAY16ozc/jDr+4l673+hy0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NYPXTc48FBMMwvSxr2DycdvVXBLVCq+IycHT43v9IsfffhCEfrzOn73xFENsPr5mF
	 Ay7xpGexDibaua6RSW8P/kZTAwbmknVOTmZxc9z5roQCfXB6fRCo82IkeAh/uLvglf
	 lh4q1QZyqkzKWW+gupYkRTd4RLvANnC9immvikYXfc3jY0VOQkPm2YQYzsdKvIkrfF
	 RKYEUXjlXZ9yDooneW9KZwJN4xUDXaUnK8ZXD5Qvtxx/jQV4PbNAGt3cR/XO1u1pTi
	 ZW8woELFoHjkEICokf8xFibbelXdzBngfXxD5nUDl1IDACT7jSTnP7mMSSHeJO9O6Z
	 lRWM9BDW841qQ==
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
Subject: [PATCHv5 bpf-next 16/28] bpf: Add support for tracing_multi link fdinfo
Date: Fri, 17 Apr 2026 21:24:50 +0200
Message-ID: <20260417192502.194548-17-jolsa@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260417192502.194548-1-jolsa@kernel.org>
References: <20260417192502.194548-1-jolsa@kernel.org>
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
ino:    3087
link_type:      tracing_multi
link_id:        9
prog_tag:       599ba0e317244f86
prog_id:        94
attach_type:    59
cnt:    10
obj-id   btf-id  cookie  func
1        91593   8       bpf_fentry_test1+0x4/0x10
1        91595   9       bpf_fentry_test2+0x4/0x10
1        91596   7       bpf_fentry_test3+0x4/0x20
1        91597   5       bpf_fentry_test4+0x4/0x20
1        91598   4       bpf_fentry_test5+0x4/0x20
1        91599   2       bpf_fentry_test6+0x4/0x20
1        91600   3       bpf_fentry_test7+0x4/0x10
1        91601   1       bpf_fentry_test8+0x4/0x10
1        91602   10      bpf_fentry_test9+0x4/0x10
1        91594   6       bpf_fentry_test10+0x4/0x10

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/trace/bpf_trace.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 8e71d56f337c..35927640c4f2 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3622,9 +3622,39 @@ static void bpf_tracing_multi_link_dealloc(struct bpf_link *link)
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
+	seq_printf(seq, "attach_type:\t%u\n", tr_link->link.attach_type);
+	seq_printf(seq, "cnt:\t%u\n", tr_link->nodes_cnt);
+
+	seq_printf(seq, "%s\t %s\t %s\t %s\n", "obj-id", "btf-id", "cookie", "func");
+	for (int i = 0; i < tr_link->nodes_cnt; i++) {
+		struct bpf_tracing_multi_node *mnode = &tr_link->nodes[i];
+		u32 btf_id, obj_id;
+
+		bpf_trampoline_unpack_key(mnode->trampoline->key, &obj_id, &btf_id);
+		seq_printf(seq, "%u\t %u\t %llu\t %pS\n",
+			   obj_id, btf_id,
+			   has_cookies ? tr_link->cookies[i] : 0,
+			   (void *) mnode->trampoline->ip);
+
+		cond_resched();
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

