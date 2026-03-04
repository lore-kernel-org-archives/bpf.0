Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EEE1EDA32;
	Wed,  4 Mar 2026 22:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772663037; cv=none; b=mDPMQiYCG9oVx7VSwgc4WCM7KTWiLOosfnoVXnnQEpl65DZt5xzJwudNVl3kNS7d1nMS/QVAhGZKmBcb6gB2lixtULoC0GUSMiUm7mZMe9Fhd7Llv9bZ7KPtPGdkIxh3JD453LB132irV/sOsSsyxaeNZt9VHDr0wk3XfH0KjyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772663037; c=relaxed/simple;
	bh=FKsnrcpRMi3YD9St4GuCX6pqKUUG/IJJegVpj9nOuZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E4diWO196Wbx5vrhjjtlTktl5ySUFDtc4ymk8u01Z2Izh/rg8Bz+g2rSa+95mD/5sm3CbXOMOee28GDPuvR0kWjCSqY3eEJja6yR0ixyfkH/iq1ORPg2dCV5YsXZ3njaFnAxlVLY1B2TQj/mjtL4cDC2xf7R5UcEfDRMdWo2xuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wjw42mXV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wjw42mXV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 814ECC4CEF7;
	Wed,  4 Mar 2026 22:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772663037;
	bh=FKsnrcpRMi3YD9St4GuCX6pqKUUG/IJJegVpj9nOuZs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wjw42mXVFDisEpcPWzk2spRMsCmY0yU1tpzzapgN2CELyjNrhjIk9jaGM2R0DJu7x
	 HRnolS/CyvFTj5FPesocodjWM2PdBv9xvfBLyTEC7a3jhMqjVJEEFssZRrSszuxtNJ
	 gI5xdEzvjuO55LykxdEuRokZFeIsZw+mruxHdj+ZsaLTUp/xcNVovQedPT3xPGtVhu
	 D5QK59OmNQ9n4lI1yslLG/Y7VtPBU4osdrWjB+XZXj3SZmBQVzB2kb1HzASmPhIeEx
	 WnVlaIRpLKPwWb8kbVx44BHcQ/BNHGOZA8sYtYhHFHP5wBh1kTTMtGxrWEvlQN6wxD
	 TDwi36nZQ7xYg==
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
Subject: [PATCHv2 bpf-next 12/23] bpf: Add support for tracing_multi link fdinfo
Date: Wed,  4 Mar 2026 23:21:30 +0100
Message-ID: <20260304222141.497203-13-jolsa@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260304222141.497203-1-jolsa@kernel.org>
References: <20260304222141.497203-1-jolsa@kernel.org>
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
            cookie     BTF-id func
                 0      91187 bpf_fentry_test1+0x4/0x10
                 0      91188 bpf_fentry_test10+0x4/0x10
                 0      91189 bpf_fentry_test2+0x4/0x10
                 0      91190 bpf_fentry_test3+0x4/0x20
                 0      91191 bpf_fentry_test4+0x4/0x20
                 0      91192 bpf_fentry_test5+0x4/0x20
                 0      91193 bpf_fentry_test6+0x4/0x20
                 0      91194 bpf_fentry_test7+0x4/0x10
                 0      91195 bpf_fentry_test8+0x4/0x10
                 0      91196 bpf_fentry_test9+0x4/0x10

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/trace/bpf_trace.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 3070b9de174d..e9951c4237e1 100644
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
+	seq_printf(seq, "%18s %10s %s\n", "cookie", "BTF-id", "func");
+	for (int i = 0; i < tr_link->nodes_cnt; i++) {
+		struct bpf_tracing_multi_node *mnode = &tr_link->nodes[i];
+		u32 btf_id;
+
+		bpf_trampoline_unpack_key(mnode->trampoline->key, NULL, &btf_id);
+		seq_printf(seq, "%18llx %10u %pS\n",
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

