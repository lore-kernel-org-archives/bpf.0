Received: from mta0.migadu.com (out-237.mta0.migadu.com [91.218.175.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8D838DC49
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 14:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792160460; cv=none; b=s/p+JyM1ptABdQNfr9nIOtLbePGTgwywZHm+sChMyFyDpn2U8EXvruEtmlr0893TmCSOFb/A4GGGgRwcv7OXcd/rqp2QEH838mM/ThLWklgZygB8rgZKluFecswS5zRW9jMfzWCSQFriAxlRJ3K9jY/2ziD41Qpe/j7p5v+3HRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792160460; c=relaxed/simple;
	bh=uLgps/BcCrUfqTwdXt1T1MjxdCO880rGw3kHRu4gKF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JN0rzgO3gmwZLZrz1MAD2ZqAIjaCGvVeWAOLRzLkK8536T1Ohge0BH5DH0ryGMyryc+4snQzeFusAR5fSndzOuS6WIueC1d/jzGocoFFCo+A2CAoxhghC4V2HFSv3FJFcHUDdX5ZwjWsozCS8cXrMlz1NEt+VF6FSUSKqTrCwnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Cjo3ABeT; arc=none smtp.client-ip=91.218.175.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Cjo3ABeT"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=uLgps/BcCrUfqTwdXt1T1MjxdCO880rGw3kHRu4gKF4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792160455; v=1; x=1792765255;
 b=Cjo3ABeTrzgICQyr4cPmCJqz9XwZLIVzAaRoaNMrkPpAbF2QBqynkVKDhn4h80YGywrib6zA
 hY5bfXE4f8rByFZgBAh4INsRQnZEox2+W/9mKyxT0mXS5el+K3gBsQ0aVpMX7cUURyWEfJ80B7l
 pfv9Y7Zop6UHIxCrBHihrxEI=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 18eec510ebf0c4fe;
	Fri, 16 Oct 2026 14:20:55 +0000
X-Mizu-Trace-ID: 18eec510ebf0c4fe
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
	linux-kernel@vger.kernel.org,
	Leon Hwang <leon.hwang@linux.dev>
Subject: [PATCH bpf-next 2/2] bpf: Drop unnecessary ftrace_location() in register/unregister/modify_fentry_multi()
Date: Fri, 16 Oct 2026 22:20:14 +0800
Message-ID: <20261016142014.12420-3-leon.hwang@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016142014.12420-1-leon.hwang@linux.dev>
References: <20261016142014.12420-1-leon.hwang@linux.dev>
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

Acked-by: Jiri Olsa <jolsa@kernel.org>
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

