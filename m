Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4930F3CB561;
	Sun,  9 Aug 2026 15:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786287774; cv=none; b=srticwy6D9kejSIdZKgY/nB5eO7uiZ9HWv77ch5WQYyVV7nqyIx4vFjt9HB36magXNJFIJDeoGC46XhGnWIwny3P77uhzm10cLIzjsE/7sZT4JPkJDnKLxd03jeUFeXoTb4FGKtghnB+ulz9dQmH3U5tTiBWioG1EobdjBzBFgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786287774; c=relaxed/simple;
	bh=7Sg0M1Pso7u9S1IroiOYbnUf8qOXAj3UA7JZPPX8w84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V7jxLV4rZRV8Tc17lPrvNnutV+NPGxdKjxU9bPdKcwkr5UsEARbzM9sa1voK+hE7etDjXiUDyQlrBaqtfGXvnrIE4yeOBtbIR5MV056aU7W7yaHDjq2MxSB2xYIqmjHWF4K5q4G1J2fvaxA90hNBqD6TYv4PEfdY4iBGGDGC+WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GbVj7eXd; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GbVj7eXd"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786287770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UNeZp3MPMEvz8aXrCIJri7M6DLgx9QVZUN9FITbE8Ww=;
	b=GbVj7eXdJHqpWo8+c70h4avQLIYBuWLpFld8RD8AZzGJWcoY5gxZpI0DecQ6vHxTsFNtQk
	PkHZiYu1aaxa4HiMjmIYGOT2AthLMoZt/e8x3ZbbFKvqWi/jgZY9yt+t43rapqJGXtnVGL
	mH3uVyymFcfpWNBwnvQXKE64VXvX4ac=
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
Subject: [PATCH bpf-next 06/13] bpf: Add tracing_multi link fdinfo support for bpf progs
Date: Sun,  9 Aug 2026 23:01:04 +0800
Message-ID: <20260809150111.45000-7-leon.hwang@linux.dev>
In-Reply-To: <20260809150111.45000-1-leon.hwang@linux.dev>
References: <20260809150111.45000-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

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

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/trace/bpf_trace.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index a805a5b73303..80928401830c 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3759,26 +3759,46 @@ static int bpf_tracing_multi_link_fill_link_info(const struct bpf_link *link,
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
+	bool has_progs = !!tr_link->progs;
 
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
+		btf_id = has_progs ? (u32) mnode->trampoline->key : btf_id;
+		if (has_progs)
+			seq_printf(seq, "%u\t %u\t %llu\t %s\n",
+				   obj_id, btf_id, cookie,
+				   bpf_prog_func_name(tr_link->progs[i], btf_id));
+		else
+			seq_printf(seq, "%u\t %u\t %llu\t %pS\n",
+				   obj_id, btf_id, cookie,
+				   (void *) mnode->trampoline->ip);
 
 		cond_resched();
 	}
-- 
2.55.0

