Received: from mta0.migadu.com (out-220.mta0.migadu.com [91.218.175.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6644A2A55
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 15:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791819695; cv=none; b=i+ynZpJ4vbwOedyLD2DI62oB8D/qmDjh4G3TV4RFBDA4WtEW5bdal3NkDpEl2/3Dh1RGFDBulQ8XEGqcemoU8rJ9hZzToeBHxP5nFonvwW1w7WZOILFdPJ5DjNFKjhnwQSQIxTMsiuuOwaYyelpWwKMIBcsDpYbGxYDCFlB+vVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791819695; c=relaxed/simple;
	bh=axDQ4dkTM6d5ZogA6nXbx/GFf6JlKyhWTl62Hgegwg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MYbZs0/nDYHFN+EjRjQQCGgmg27BaZI4gP6oJvTQOqcbbxz5VkacHGLH91vA0F/aatVr3Q8OjmvQQrloW8Gkl9kd6aEv3vkEuhIgs1Jl3L+8OtK7PKAEbZc165giYKuL0QW7gCRBUxFAxxiQWQ/qZWlTAEW0jRk4fvSwKSB2XLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YVMMbo7t; arc=none smtp.client-ip=91.218.175.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YVMMbo7t"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=axDQ4dkTM6d5ZogA6nXbx/GFf6JlKyhWTl62Hgegwg0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791819692; v=1; x=1792424492;
 b=YVMMbo7t/Qh1jZ96vfWGkKGiu7sNRWWrJvEH1fOJxHYBbKlL18c+4ZUdnT38ulcHPgqxrkWE
 s69Zf75l7xjEHB1di9SKU8AAS2Br5AljzZsdZ6c0c76FwFftFIwvIRa6uusFHwQVrqzcu+asUhn
 HpOPP6rLeu9V2zObHRMHvUh0=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id d020435859dc5170;
	Mon, 12 Oct 2026 15:41:32 +0000
X-Mizu-Trace-ID: d020435859dc5170
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
Subject: [PATCH bpf-next v2 02/21] bpf: Drop unnecessary ftrace_location() in register/unregister/modify_fentry_multi()
Date: Mon, 12 Oct 2026 23:40:04 +0800
Message-ID: <20261012154024.29423-3-leon.hwang@linux.dev>
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

Since 'tr->ip' is already a 'ftrace_location()'-ed IP in
bpf_trampoline_lookup(), it is unnecessary to call ftrace_location() again
in register/unregister/modify_fentry_multi().

No functional changes intended.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/bpf/trampoline.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 17f2a8133f61..21d460866dfe 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -1629,8 +1629,8 @@ static void ftrace_hash_add(struct ftrace_hash *hash, struct ftrace_func_entry *
 static int register_fentry_multi(struct bpf_trampoline *tr, struct bpf_tramp_image *im, void *ptr)
 {
 	unsigned long addr = (unsigned long) im->image;
-	unsigned long ip = ftrace_location(tr->ip);
 	struct bpf_tracing_multi_data *data = ptr;
+	unsigned long ip = tr->ip;
 
 	/*
 	 * Different BTF ids get different trampolines, but they can still
@@ -1651,13 +1651,12 @@ static int register_fentry_multi(struct bpf_trampoline *tr, struct bpf_tramp_ima
 static int unregister_fentry_multi(struct bpf_trampoline *tr, u32 orig_flags, void *ptr)
 {
 	unsigned long addr = (unsigned long) tr->cur_image->image;
-	unsigned long ip = ftrace_location(tr->ip);
 	struct bpf_tracing_multi_data *data = ptr;
 
 	if (bpf_trampoline_use_jmp(tr->flags))
 		addr = ftrace_jmp_set(addr);
 
-	ftrace_hash_add(data->unreg, data->entry, ip, addr);
+	ftrace_hash_add(data->unreg, data->entry, tr->ip, addr);
 	tr->cur_image = NULL;
 	return 0;
 }
@@ -1666,13 +1665,12 @@ static int modify_fentry_multi(struct bpf_trampoline *tr, u32 orig_flags, struct
 			       bool lock_direct_mutex, void *ptr)
 {
 	unsigned long addr = (unsigned long) im->image;
-	unsigned long ip = ftrace_location(tr->ip);
 	struct bpf_tracing_multi_data *data = ptr;
 
 	if (bpf_trampoline_use_jmp(tr->flags))
 		addr = ftrace_jmp_set(addr);
 
-	ftrace_hash_add(data->modify, data->entry, ip, addr);
+	ftrace_hash_add(data->modify, data->entry, tr->ip, addr);
 	tr->cur_image = im;
 	return 0;
 }
-- 
2.55.0

