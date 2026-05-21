Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB97F3EE1C6
	for <bpf@vger.kernel.org>; Thu, 21 May 2026 14:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779373779; cv=none; b=L/HugVOxbFUKlNh0bAombibib4WUbgaETFSWmfU8bhdy+URHtZjVmm9xdTZgcyNIu/PrcWOPBZFfza1cvCDvZJ9xgzEVzDxv6FfbHkSYEZjwrh1WwhxN5Et1/FcOKCpN81T9T+bGwk0Cc4cC/cnQ8UlLGZ4uELjifa6L8Bqd7w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779373779; c=relaxed/simple;
	bh=L8X/Vtnahfr1UKdViXhLKWhf9qHUBPeIKLu97RI+aL8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VnZYd20SurKSLfJm9jDM1hsVSSgO+EAuVcKwSVyBNijd45kVTGfYBAYbPwbw7ln6n/n2awJJ/aWjog6L3WDD3iitTeb5Le0v+PIl82VB8WFE9ECVPhfuITnnmPo/1GsTk6aRjLGHL4p+Guz8U6VZGzKKBpR4Ukwyy2BkvAKQfCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pWkyhPoa; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pWkyhPoa"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779373775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Hw2iSi5nOOVvlhwvxYfHRrDn76QQRLFbRQOPEaOi5gE=;
	b=pWkyhPoa58XOqB8Oismhu3yUX3jShmcFhalKAS/TS+Citaz/A1tJ+73T+8S/tJuoAbqs8N
	q9zI0SN6YFaVcx4J4m3dhRl9wpOZI3VDd4w/a6ZoCRe+pMzxbbd8qQsjTd9b9C++2T/Na4
	1hly5Lsh2FI7jTKFVK1jwW+enKsbRdg=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v2] bpf: Fix concurrent regression in map_create()
Date: Thu, 21 May 2026 22:29:09 +0800
Message-ID: <20260521142909.95818-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Because there is time gap between bpf_map_new_fd() and close_fd(), a
concurrent thread is able to close the new fd and opens a new, unrelated
file with the exact same fd number. Thereafter, this close_fd() might
inadvertently close the unrelated file.

To avoid such regression, do finalize log before security_bpf_map_create().

However, in order to achieve it, move bpf_get_file_flag(),
security_bpf_map_create(), bpf_map_alloc_id(), and bpf_map_new_fd() from
__map_create() to map_create(). And, rename __map_create() to
map_create_alloc() meanwhile.

Then, in order to reuse the map and token when all checks pass in
map_create_alloc(), pass "struct bpf_map **" and "struct bpf_token **" to
map_create_alloc().

Fixes: 49f9b2b2a18c ("bpf: Add syscall common attributes support for map_create")
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
v1 -> v2:
* Finalize log before security_bpf_map_create() (per Alexei).
* v1: https://lore.kernel.org/bpf/20260518145446.6794-3-leon.hwang@linux.dev/
---
 kernel/bpf/syscall.c | 80 ++++++++++++++++++++++++++------------------
 1 file changed, 47 insertions(+), 33 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 83de8fb9b9aa..28489e2fea04 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1359,7 +1359,8 @@ static int map_check_btf(struct bpf_map *map, struct bpf_token *token,
 
 #define BPF_MAP_CREATE_LAST_FIELD excl_prog_hash_size
 /* called via syscall */
-static int __map_create(union bpf_attr *attr, bpfptr_t uattr, struct bpf_verifier_log *log)
+static int map_create_alloc(union bpf_attr *attr, bpfptr_t uattr, struct bpf_verifier_log *log,
+			    struct bpf_map **mapp, struct bpf_token **tokenp)
 {
 	const struct bpf_map_ops *ops;
 	struct bpf_token *token = NULL;
@@ -1367,7 +1368,6 @@ static int __map_create(union bpf_attr *attr, bpfptr_t uattr, struct bpf_verifie
 	u32 map_type = attr->map_type;
 	struct bpf_map *map;
 	bool token_flag;
-	int f_flags;
 	int err;
 
 	err = CHECK_ATTR(BPF_MAP_CREATE);
@@ -1403,10 +1403,6 @@ static int __map_create(union bpf_attr *attr, bpfptr_t uattr, struct bpf_verifie
 		return -EINVAL;
 	}
 
-	f_flags = bpf_get_file_flag(attr->map_flags);
-	if (f_flags < 0)
-		return f_flags;
-
 	if (numa_node != NUMA_NO_NODE &&
 	    ((unsigned int)numa_node >= nr_node_ids ||
 	     !node_online(numa_node))) {
@@ -1598,6 +1594,49 @@ static int __map_create(union bpf_attr *attr, bpfptr_t uattr, struct bpf_verifie
 		goto free_map;
 	}
 
+	*mapp = map;
+	*tokenp = token;
+	return 0;
+
+free_map:
+	bpf_map_free(map);
+put_token:
+	bpf_token_put(token);
+	return err;
+}
+
+static int map_create(union bpf_attr *attr, bpfptr_t uattr, struct bpf_common_attr *attr_common,
+		      bpfptr_t uattr_common, u32 size_common)
+{
+	struct bpf_token *token = NULL;
+	struct bpf_verifier_log *log;
+	struct bpf_log_attr attr_log;
+	struct bpf_map *map = NULL;
+	int err, ret;
+	int f_flags;
+
+	log = bpf_log_attr_create_vlog(&attr_log, attr_common, uattr_common, size_common);
+	if (IS_ERR(log))
+		return PTR_ERR(log);
+
+	err = map_create_alloc(attr, uattr, log, &map, &token);
+
+	/* preserve original error even if log finalization is successful */
+	ret = bpf_log_attr_finalize(&attr_log, log);
+	if (ret)
+		err = ret;
+
+	kfree(log);
+
+	if (err)
+		goto free_map;
+
+	f_flags = bpf_get_file_flag(attr->map_flags);
+	if (f_flags < 0) {
+		err = f_flags;
+		goto free_map;
+	}
+
 	err = security_bpf_map_create(map, attr, token, uattr.is_kernel);
 	if (err)
 		goto free_map_sec;
@@ -1626,37 +1665,12 @@ static int __map_create(union bpf_attr *attr, bpfptr_t uattr, struct bpf_verifie
 free_map_sec:
 	security_bpf_map_free(map);
 free_map:
-	bpf_map_free(map);
-put_token:
+	if (map)
+		bpf_map_free(map);
 	bpf_token_put(token);
 	return err;
 }
 
-static int map_create(union bpf_attr *attr, bpfptr_t uattr, struct bpf_common_attr *attr_common,
-		      bpfptr_t uattr_common, u32 size_common)
-{
-	struct bpf_verifier_log *log;
-	struct bpf_log_attr attr_log;
-	int err, ret;
-
-	log = bpf_log_attr_create_vlog(&attr_log, attr_common, uattr_common, size_common);
-	if (IS_ERR(log))
-		return PTR_ERR(log);
-
-	err = __map_create(attr, uattr, log);
-
-	/* preserve original error even if log finalization is successful */
-	ret = bpf_log_attr_finalize(&attr_log, log);
-	if (ret) {
-		if (err >= 0)
-			close_fd(err);
-		err = ret;
-	}
-
-	kfree(log);
-	return err;
-}
-
 void bpf_map_inc(struct bpf_map *map)
 {
 	atomic64_inc(&map->refcnt);
-- 
2.54.0

