Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1CB3438BB
	for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 03:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785209935; cv=none; b=rrl2YHE/B8xvxdgdhbyPpLSOFFWc7UqoBA7XEpdrr80VI9rKHR4jCn5altucotrFonKXwP8St+QeLNndefBw6ajv1aIJny+7jkAfzccGtKRKsdnY2zRGeL9E0snYHDlgJjKBjlrmgXVUTrZoXeDN0ZkmTJZOsnGsGShn9iAR60E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785209935; c=relaxed/simple;
	bh=rZjYNl3+MPB+91xxVJNulZvx9ICIzCZfQoEYPHyNCEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W+FkxQoP88njRfbkVgevORpj6iCJuDZZEkVY/TzM3jbw8Yihiw4EZr0W0FwwOD5+ZT/7juig0J1dcD5XKz9ij0dqz7NP7gSiwULpHtN8tihfNYCZ6s9SbmWmhZp7Sobgthy1OHynboUua/4R+2kEYaiLDRp8jbNmX74J8wiL7UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MVTpRJws; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVTpRJws"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84e0688b859so2071633b3a.0
        for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 20:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785209933; x=1785814733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q8rlllOW1RK3ni0UfDzUVjg1yaTTz9iURLbN/ICv9wY=;
        b=MVTpRJwsBIBf8bL//bMNDDFRrETpq2j5uJVpbekoiXHUezVLCjVr1G4JERzPQ1fsAZ
         bO4hjdnDHdpEJL7tQuC4pX4HgOWdfRVZWbTVTAoCIg5LpletYSI5Pemo3VKWOmmWEpW2
         523hwHwyAbRvxNfojE9uVetu3uxH83IjjLwlcU/wZ6W0mgv2AluY99B2kJWoKx6XI71y
         cJZ0sKUb0v5E6PtWSJ1ErN6nniF64cO0cLJT2r/p+qN89NHjxLNHrAkYDMEelU4m88oK
         +NZjzzezMY4eHK5a8yatpBntS1DNCJ3W4HWoanK2Kr0/UAVGl4/CLUHO6UQNZKo05PLJ
         KsbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785209933; x=1785814733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=q8rlllOW1RK3ni0UfDzUVjg1yaTTz9iURLbN/ICv9wY=;
        b=N2VXwz72jf1c3MY0Jf0E15gzoOOFg3oScrbI9PbAGnPDBOa3kZy3DDv1h0Ocw3tHPS
         qFl/5hcAtQ/sGOymJ6Q/wjPfRAT4sPLN15SwZ3iPpC4M8qZcKSkVc1VO5kjdNoZMLAj2
         F074WiICjxjLWv+Dg/VPhYotUnQSTNAA7ntvoluyjDHpTeeTIy19Tk6lHW08GyZ98Ij0
         g2oE17fBikEgWYRs9YOcc19JleZVp3KL7zu0jmq0ZDhburHXe0CO1kFqzA6aN3YGf3td
         r6XJVUJTV1Du/MxDaQvsAYNOXNdpBsxTIn7awNfIPDkN+G6PAjg4IUzlxnjcje99ikH5
         FMQw==
X-Gm-Message-State: AOJu0YymJ+UeZeSh2O34s/LM8Y973fKLzlu0xp/vm8nupfw2xoLUojp0
	HEYBkX8iKjkYh1E58WcmgnhQVXL5iry6R+tw2JUjTsq1FG4Nqg4o18XlR/LiUUL9
X-Gm-Gg: AR+sD11czLYtuI9NssxbWZYUUrni/EjPuCmWIi+FQIIYCKZgTC/fu0p6driT2I4vOOy
	w58f4skvy9xw6JI0Bz3XoOxEtg38V4SthgRm0+W7As+hJ33s03O2EadmrHUFdNCmDUxmwRvweQF
	ERE5HzMcCHQlWbUxm68r6kcg4bztpIaTN9Jel4My2nSJhT4H19BH067n+eE6c1U8BEZNvOH2DsL
	dw8JgQMbBlC3a5zf8JNb1PDTp+ZSZSl31N27qwDNzkG8MS3OBX8eoUY1FMjIW4KY6SEbPFVs7uO
	hpRlusWV2I/uf2Vu1PvI2oMO55+KwRKgmXQ3HH8Ur0JTZ1sdQU5+kwjfDXfj2fNL1qn/y0oSvst
	UeVKXN+GvM8/E0eFHL+8j2mPd3Ypyr4xb8zsjQAg0JR+N6kb1DnEwGdqBlJdYAfxkKwgPsR9zYj
	iQxLh/4hvJOUsIZCHOfSKb1BoIXckN/g==
X-Received: by 2002:a05:6a00:84f:b0:847:8d54:f4f9 with SMTP id d2e1a72fcca58-84e93358f09mr584000b3a.51.1785209932964;
        Mon, 27 Jul 2026 20:38:52 -0700 (PDT)
Received: from patterson.cs.ubc.ca (patterson.cs.ubc.ca. [198.162.52.65])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e5325856dsm3753865b3a.9.2026.07.27.20.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 20:38:52 -0700 (PDT)
From: Ning Ding <dingning04@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	shuah@kernel.org,
	danieltimlee@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Ning Ding <dingning04@gmail.com>
Subject: [PATCH bpf] bpf: Reject writes through untrusted allocated pointers
Date: Mon, 27 Jul 2026 20:38:37 -0700
Message-ID: <20260728033837.1466123-1-dingning04@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260726021304.97ED91F000E9@smtp.kernel.org>
References: <20260726021304.97ED91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A kptr loaded under an RCU read lock has MEM_ALLOC set. After
bpf_rcu_read_unlock(), the verifier marks it PTR_UNTRUSTED, but
check_ptr_to_btf_access() still allows writes because
type_is_ptr_alloc_obj() ignores that flag.

Reject writes through MEM_ALLOC pointers that are PTR_UNTRUSTED. Reads
remain allowed and are converted to probe-memory accesses.

Also skip the owning-reference check for these pointers, since they no
longer have a live reference after leaving the RCU critical section.

Add verifier tests for the rejected write and permitted read cases.

Fixes: 503e4def5414 ("bpf: Replace open code with for allocated object check")
Closes: https://lore.kernel.org/all/20260726021304.97ED91F000E9@smtp.kernel.org/
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Ning Ding <dingning04@gmail.com>
---
 kernel/bpf/verifier.c                         |  6 +-
 .../bpf/progs/local_kptr_stash_fail.c         | 58 +++++++++++++++++++
 2 files changed, 62 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7aa47342dc65..24c151ad2e62 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5804,13 +5804,15 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 		 * program allocated objects (which always have id > 0),
 		 * but not for untrusted PTR_TO_BTF_ID | MEM_ALLOC.
 		 */
-		if (atype != BPF_READ && !type_is_ptr_alloc_obj(reg->type)) {
+		if (atype != BPF_READ &&
+		    (!type_is_ptr_alloc_obj(reg->type) || reg->type & PTR_UNTRUSTED)) {
 			verbose(env, "only read is supported\n");
 			return -EACCES;
 		}
 
 		if (type_is_alloc(reg->type) && !type_is_non_owning_ref(reg->type) &&
-		    !(reg->type & MEM_RCU) && !reg_is_referenced(env, reg)) {
+		    !(reg->type & (MEM_RCU | PTR_UNTRUSTED)) &&
+		    !reg_is_referenced(env, reg)) {
 			verifier_bug(env, "allocated object must have a referenced id");
 			return -EFAULT;
 		}
diff --git a/tools/testing/selftests/bpf/progs/local_kptr_stash_fail.c b/tools/testing/selftests/bpf/progs/local_kptr_stash_fail.c
index fcf7a7567da2..d7b8cd6458bb 100644
--- a/tools/testing/selftests/bpf/progs/local_kptr_stash_fail.c
+++ b/tools/testing/selftests/bpf/progs/local_kptr_stash_fail.c
@@ -8,14 +8,22 @@
 #include "../bpf_experimental.h"
 #include "bpf_misc.h"
 
+extern void bpf_rcu_read_lock(void) __ksym;
+extern void bpf_rcu_read_unlock(void) __ksym;
+
 struct node_data {
 	long key;
 	long data;
 	struct bpf_rb_node node;
 };
 
+struct plain_data {
+	long key;
+};
+
 struct map_value {
 	struct node_data __kptr *node;
+	struct plain_data __kptr *plain;
 };
 
 struct node_data2 {
@@ -31,6 +39,7 @@ struct node_data2 {
  * [35] TYPE_TAG 'kptr_ref' type_id=34
  */
 struct node_data *just_here_because_btf_bug;
+struct plain_data *just_here_because_btf_bug2;
 
 struct {
 	__uint(type, BPF_MAP_TYPE_ARRAY);
@@ -82,4 +91,53 @@ long drop_rb_node_off(void *ctx)
 	return 0;
 }
 
+SEC("?tc")
+__failure __msg("only read is supported")
+long write_untrusted_alloc_obj(void *ctx)
+{
+	struct map_value *mapval;
+	struct node_data *res;
+	int idx = 0;
+
+	mapval = bpf_map_lookup_elem(&some_nodes, &idx);
+	if (!mapval)
+		return 1;
+
+	bpf_rcu_read_lock();
+	res = mapval->node;
+	if (!res) {
+		bpf_rcu_read_unlock();
+		return 2;
+	}
+	barrier_var(res);
+	bpf_rcu_read_unlock();
+
+	res->key = 42;
+	return 0;
+}
+
+SEC("?tc")
+__success
+long read_untrusted_alloc_obj(void *ctx)
+{
+	struct map_value *mapval;
+	struct plain_data *res;
+	int idx = 0;
+
+	mapval = bpf_map_lookup_elem(&some_nodes, &idx);
+	if (!mapval)
+		return 1;
+
+	bpf_rcu_read_lock();
+	res = mapval->plain;
+	if (!res) {
+		bpf_rcu_read_unlock();
+		return 2;
+	}
+	barrier_var(res);
+	bpf_rcu_read_unlock();
+
+	return res->key;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0

