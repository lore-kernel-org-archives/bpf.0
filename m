Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7162E24E4AF;
	Mon, 16 Mar 2026 07:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773647635; cv=none; b=OSDnRwyiW+5EnYZqCRDSC6SPZcu8nApqxc3IGUfm4IrHiNHtwyj+F/wjgPWLbY7wmvYRIrql4D26JTvwGpYEEduz5vyaAPjBC2GbWJ79ewopaF2vDeBH0sh5FEjnb9wjqXy4QowBDrfkmiNfN4v7yuzEM5vkVn3DiuOxlo3YV5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773647635; c=relaxed/simple;
	bh=lZRBpv2EoCrYhYT4+Fibd7bR3HWjmQg7YCHm8mGVOjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mf5zN15N1gaELl4+WaJkaMDP9NaFVXWFHsdS1v8vvgwe1hqgt0U3YP49MNFtXvGN894oweHigpJxKqgnp6qNJcyWWHowiFE/KqdnH162v9D1OIe1UNG8UdQSSOlrF3jtnoFutvXGeH1ZeqZOApgFg4mopr7TKX1hJgDf2TUItI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wjn1Pila; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wjn1Pila"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19440C19421;
	Mon, 16 Mar 2026 07:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773647634;
	bh=lZRBpv2EoCrYhYT4+Fibd7bR3HWjmQg7YCHm8mGVOjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wjn1Pilay9uYnKM3z3UWqN0PeSY0yvvsMIAFhR/NSY0q/Du9C7KsebwjwwWdXnLk6
	 dFJ5M+ge/UEvctLB8VClaWMJshirYXjDGNhAOiKI0BTVyLsftaeUXKa4Zyr+uz2Zwu
	 RXjr3dTkaBHRnarCeP3wXdsDp7TTNYOtNZVC8p93WpDOOmqMz3vb1sp7e5dSM3EGXW
	 tPc/16LNP614DSPOejE76bp+SUZJ8NgvKt25VhuSc8VXgI/GvpSIVtSNYCrWsTN2KG
	 rKpBJeK8QZPhb11dOfzb0zYRr/P1y5z1gODN/tz7P5/x2YaPOyX9//Wf8x/D9PelEY
	 n2yTx5joXu6tw==
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
Subject: [PATCHv3 bpf-next 12/24] bpf: Add support for tracing_multi link fdinfo
Date: Mon, 16 Mar 2026 08:51:26 +0100
Message-ID: <20260316075138.465430-13-jolsa@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260316075138.465430-1-jolsa@kernel.org>
References: <20260316075138.465430-1-jolsa@kernel.org>
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

