Received: from mta0.migadu.com (out-127.mta0.migadu.com [91.218.175.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13474A8A1B
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 15:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791819855; cv=none; b=UlNhzSsiwHwKsCXf2NH8hHqUJ2MjG80pz0hAv5VVEJYHCzqlYvoEuFR+FzboBoZ0mCsOYXrDXk9PPVQW1uZcFe868V9do/XhU5OqirJJ3TJUwqG5jV5cEL6Tso2LMlwus2+477luxX4FwBGxEKFW3bsJhgQPCOJRwhwE6UZVPkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791819855; c=relaxed/simple;
	bh=Nff4WKqseVpdJ/DF7AlnYVuX4puuuQ0pFpve7vJB2uA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q9xfYRTX2sUT57x40SpXp/Ipu+K4nUk4Krj2yvRFecRm6YBbO4IBmczReNUglHbTtzcan2kBNezgzt8XDhSzRgxWhqPlVY6IUqbrEK/6CGviHFRa74ECth6BgGqc5/GTr1oxsC1afCubRSHHiS1Ud4RtMOUGrHES7xKeaA6Je40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AfNmFIHh; arc=none smtp.client-ip=91.218.175.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AfNmFIHh"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Nff4WKqseVpdJ/DF7AlnYVuX4puuuQ0pFpve7vJB2uA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791819852; v=1; x=1792424652;
 b=AfNmFIHhJxa66KJP64TQZsa/eUSYWaDDF8NQIP5aBpzy+sl6kgXMwsgeVL9gpvLyclZuBzWs
 BStGxf9KbKr4dYX9d7LZsmj/F5akOHthQV/k9Cwcc4Gsfj1EFlhvwTkSFhgn5ktQb4WVCWGGrXl
 LIV+AIs/k1b7S6zAxWtBEP0g=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 19cab078b9f3f0bc;
	Mon, 12 Oct 2026 15:44:12 +0000
X-Mizu-Trace-ID: 19cab078b9f3f0bc
X-Migadu-Flow: FLOW_OUT
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Quentin Monnet <qmo@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	Avinash Duduskar <avinash.duduskar@gmail.com>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Jordan Rife <jordan@jrife.io>,
	Rong Tao <rongtao@cestc.cn>,
	Eyal Birger <eyal.birger@gmail.com>,
	Pu Lehui <pulehui@huawei.com>,
	Jingguo Tan <tanjingguo@huawei.com>,
	Lin Ma <malin89@huawei.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v2 13/21] bpf: Add tracing_multi link fdinfo support for bpf progs
Date: Mon, 12 Oct 2026 23:40:15 +0800
Message-ID: <20261012154024.29423-14-leon.hwang@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261012154024.29423-1-leon.hwang@linux.dev>
References: <20261012154024.29423-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Show the target bpf prog info in the fdinfo.

$ cat /proc/self/fdinfo/13
pos:	0
flags:	02000000
mnt_id:	18
ino:	1045
link_type:	tracing_multi
link_id:	9
prog_tag:	9a7f9e3ab6f138ab
prog_id:	25
attach_type:	61
cnt:	2
prog-id	 btf-id	 cookie	 func
21	 4	 16706819	 target_1
22	 5	 16706819	 target_2

Different from the fdinfo of link whose targets are kernel functions, here
shows 'prog-id' instead of 'obj-id' to describe the ID of the target bpf
progs. And, 'func' shows the concrete function name of the target bpf
progs, because the function name can be retrieved by bpftool via 'prog-id'
+ 'btf-id'.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/trace/bpf_trace.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index d4af42e25fe5..8b1a52350cfd 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3761,26 +3761,45 @@ static int bpf_tracing_multi_link_fill_link_info(const struct bpf_link *link,
 }
 
 #ifdef CONFIG_PROC_FS
+static const char *bpf_prog_func_name(struct bpf_prog *prog, u32 btf_id)
+{
+	const struct btf *btf = prog->aux->btf;
+	const struct btf_type *t;
+
+	t = btf_type_by_id(btf, btf_id);
+	if (!t || !btf_type_is_func(t))
+		return "";
+
+	return btf_name_by_offset(btf, t->name_off);
+}
+
 static void bpf_tracing_multi_show_fdinfo(const struct bpf_link *link,
 					  struct seq_file *seq)
 {
 	struct bpf_tracing_multi_link *tr_link =
 		container_of(link, struct bpf_tracing_multi_link, link);
 	bool has_cookies = !!tr_link->cookies;
+	bool has_progs = !!tr_link->tgt_progs;
 
 	seq_printf(seq, "attach_type:\t%u\n", tr_link->link.attach_type);
 	seq_printf(seq, "cnt:\t%u\n", tr_link->nodes_cnt);
 
-	seq_printf(seq, "%s\t %s\t %s\t %s\n", "obj-id", "btf-id", "cookie", "func");
+	seq_printf(seq, "%s\t %s\t %s\t %s\n", has_progs ? "prog-id" : "obj-id", "btf-id", "cookie",
+		   "func");
 	for (int i = 0; i < tr_link->nodes_cnt; i++) {
 		struct bpf_tracing_multi_node *mnode = &tr_link->nodes[i];
+		u64 cookie = has_cookies ? tr_link->cookies[i] : 0;
 		u32 btf_id, obj_id;
 
 		bpf_trampoline_unpack_key(mnode->trampoline->key, &obj_id, &btf_id);
-		seq_printf(seq, "%u\t %u\t %llu\t %pS\n",
-			   obj_id, btf_id,
-			   has_cookies ? tr_link->cookies[i] : 0,
-			   (void *) mnode->trampoline->ip);
+		if (has_progs)
+			seq_printf(seq, "%u\t %u\t %llu\t %s\n",
+				   obj_id, btf_id, cookie,
+				   bpf_prog_func_name(tr_link->tgt_progs[i], btf_id));
+		else
+			seq_printf(seq, "%u\t %u\t %llu\t %pS\n",
+				   obj_id, btf_id, cookie,
+				   (void *) mnode->trampoline->ip);
 
 		cond_resched();
 	}
-- 
2.55.0

