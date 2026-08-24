Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8689A3F44E2
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 10:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787567773; cv=none; b=iUKHZUccJFH6a75icTDCJ3B7cGDU5SX+8SmFRn2w3HM2b4pQRDPOhWicLNvDCDoYMXMee6nv7RZNQtuS4qYojnhaLkGg+kM1gzzASepGi6KjDzDjzTaxIAjiwu8GfqFD1alwTS/shewQtfSap56XVNeCn3dqIL9Q3lBt9TnWp38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787567773; c=relaxed/simple;
	bh=ZADepv4xdZNHwkECNW6lTUQg1E3k8x91LQejLz/Xkjo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QdXij81eXQOqdHlVN+6IAHPvVj3C196MbOWf3suTsseD1pCs3rL5Q7eU9VKX6n9ZzLutG8hqOAkcJgR3qXj603XI10mDuw5rE6b4cWH5rq7678HT5U+oVlXv1a7zjyAQSHLAwE3zYfbZaaDReoPCVBmYUAMSY3Had0/urN1Df60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NpJqlqUW; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NpJqlqUW"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cbedf433a99so3229803a12.2
        for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 03:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787567772; x=1788172572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2Ub+0nllkodHP25aTWDnva9lNWnoZ/bfNEL+dwIlbIQ=;
        b=NpJqlqUWe26gvhZ4ViR3C/UeEF/FC/ahCcKSdybPBsUBqJ5fmXi88X5xQfE8Z6rtPB
         CNsP7TMesqcRwD7ZEEypMaouIpX/h1DPkgeIE18b9mWn5zSKznD/YZ0LCn+rG75V+mMG
         /WBOkXCE33IAQ47KWxdxeoyn27YyqBsVEprq2cMVSElck5bFURcY2HS3pkW4YlUFUPvR
         B6Fgt8NWIh/vU+g0cDEECLth1VtXUS/kcRK2g/4h1Pq24NSKSC0p7rAR4yf7WrqqHbAG
         O5PyAiUv7Kwk8csPdovc/qvdZAyJYNtwfpDC4KjRRuQICwTmW821NdOfI67cYzxwiNVq
         s+Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787567772; x=1788172572;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2Ub+0nllkodHP25aTWDnva9lNWnoZ/bfNEL+dwIlbIQ=;
        b=D+chIFlQLeO43zcRohr9Vycv3WZoNBSg5wQVP6qKWlHW8F1s8QcoV8gBIlZ5qcqGCi
         OmdYe6chPU6aL2rxo9CTqN9rX+PkOFauup2HMCDZTk8F6r/nn+YRc1mRCh3pofNEcQ37
         6araIWVeFR/EgMADeqFGyTNdPs9+ipaYzjgOMsSeFJQBuma4pbQfVdQ1orLklvDRpTNo
         CXxUOO/AhpQmbPyCU0t3OsWsYdBIrFDwOr4Dcp7DmiRSDVFwTTn80cj7Wda4o0RuS0nz
         68V17AajfgRjTN/VjNgvpWxEwpn4aLGV0VnVGaY1Le19zHKMFkKgJvRNIYAPNHAXM5YX
         0ILw==
X-Forwarded-Encrypted: i=1; AHgh+RoeIkj90EYM5abOream5HS0hl2A0NdAMPt4maZW6+oVdc27Y1LToeofTgyJ8JtKQB0grZc=@vger.kernel.org
X-Gm-Message-State: AFuF++nKIYM8PH/gstKcYgqOFR0Uqn842jl3UrlrNLetFhy01Ik4qfvP
	FVKfHxZSb8nkE6+na7VL4e2oNqLhNv6CnEKmxwfGFT2UiwTSsrDMUdY+
X-Gm-Gg: AR+sD11FnKHu/Rv0hjPwHUfKcmnOVGGeLwxtKSMqnE8ZLbLrski6hDJBytrBF4Weunq
	rsi/a7LUJbJc98yE+3JCHsxB3Bl7Npu77cFNM5bP00DxfeSaWZF6SrsnovPWrTlvFHlB9m0MS/I
	Xy9OrSzbIOHLG818cIUzZzFzGQoHYdXBMxrZe5DMQtQDp/mbq1wHHKW0TB86C0uHAXTFemEvCXz
	NuVd5oELepFZLzhGI/stdWanokgTcTGXFHVkmdgw3mLsQ4dEcf2OReqgWCeU3wBaVQNmeSGWHIE
	EoVZPZcHEuRUvMNCFhUGEOtWMq9KyS00D14TgtEpvh3Oig57sj+P+8ezFCxyZDuKv14zDEYoj1Q
	Nr/5IwFhHKGTq9+lalqyzI4MRNgm4JzaTJV0GyZenZzTw7FAiI+q4I4DKkj7UnIpV8k4w+1b0Nj
	ciNTvBYyM78yFE6Qj6BBdkvg3hRU+y+DfEKWLUFMFiMeP8q2hBh10deR5LVvIAaIqsV/lJcWnqA
	CkKbcoAQbyRle973WG0OeKFd5TJQt6hm9gbGofaVP1LARA56A==
X-Received: by 2002:a05:6a21:3382:b0:3c4:396d:4a6c with SMTP id adf61e73a8af0-3cd2fd9f17dmr44398621637.5.1787567771598;
        Mon, 24 Aug 2026 03:36:11 -0700 (PDT)
Received: from baaz.tail58d41.ts.net ([2401:4900:8850:f081:3f06:139b:b140:eb29])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f909c6c9sm29350169eec.6.2026.08.24.03.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 03:36:10 -0700 (PDT)
From: Muhammad Falak R Wani <falakreyaz@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Muhammad Falak R Wani <falakreyaz@gmail.com>
Subject: [PATCH] bpf: Cancel special fields on rhashtab value recycle instead of freeing
Date: Mon, 24 Aug 2026 16:05:01 +0530
Message-ID: <20260824103502.3154292-1-falakreyaz@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit a3a81d2476512 ("bpf: Cancel special fields on map value recycle")
changed array and hashtab update/delete paths to avoid full special-field
destruction while recycling a map value. Such paths can run in NMI
context for tracing programs, where referenced kptr destructors are not
generally safe. Instead, bpf_obj_cancel_fields() cancels the NMI-safe
timer, workqueue, and task_work fields and leaves referenced kptr cleanup
to a later safe destruction path.

Resizable hashtable special-field support was added four days earlier by
commit 6905f8601298e ("bpf: Allow special fields in resizable hashtab"),
but its equivalent paths were not converted. BPF_MAP_TYPE_RHASH permits
referenced kptr fields and can be used by perf-event programs, which may
run in NMI context. rhtab_map_update_existing() and rhtab_delete_elem()
therefore still call bpf_obj_free_fields() directly and may invoke a
referenced kptr destructor from NMI context.

bpf_disable_instrumentation() around the rhashtable operations only
prevents a nested instrumentation program from reentering a bucket lock.
It does not change the execution context of the current program and
therefore does not make a subsequent destructor call NMI-safe.

Use bpf_obj_cancel_fields() in both paths, matching array and hashtab.
On delete, the allocator destructor performs full cleanup after the RCU
grace periods. On an in-place update, the kptr remains attached to the
map value until a BPF program explicitly removes it or the element is
later freed, matching the array-map semantics promised when rhashtable
special-field support was introduced.

Extend the map kptr lifetime test with an rhashtable variant. It stashes
a referenced kptr, updates the ordinary fields of the existing value,
and verifies that the update does not release the reference.

Fixes: 6905f8601298e ("bpf: Allow special fields in resizable hashtab")
Signed-off-by: Muhammad Falak R Wani <falakreyaz@gmail.com>
---
 kernel/bpf/hashtab.c                          | 26 ++++++++-----------
 .../selftests/bpf/prog_tests/map_kptr.c       | 11 ++++++++
 tools/testing/selftests/bpf/progs/map_kptr.c  | 12 +++++++++
 3 files changed, 34 insertions(+), 15 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index d40cb5dd446ca..a395928a3cf20 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -2864,16 +2864,6 @@ static int rhtab_map_alloc_check(union bpf_attr *attr)
 	return htab_map_alloc_check(attr);
 }
 
-static void rhtab_check_and_free_fields(struct bpf_rhtab *rhtab,
-					struct rhtab_elem *elem)
-{
-	if (IS_ERR_OR_NULL(rhtab->map.record))
-		return;
-
-	bpf_obj_free_fields(rhtab->map.record,
-			    rhtab_elem_value(elem, rhtab->map.key_size));
-}
-
 static void rhtab_mem_dtor(void *obj, void *ctx)
 {
 	struct htab_btf_record *hrec = ctx;
@@ -2963,8 +2953,12 @@ static int rhtab_delete_elem(struct bpf_rhtab *rhtab, struct rhtab_elem *elem, v
 		rhtab_read_elem_value(&rhtab->map, copy, elem, flags);
 		check_and_init_map_value(&rhtab->map, copy);
 	}
-	/* Release internal structs: kptr, bpf_timer, task_work, wq */
-	rhtab_check_and_free_fields(rhtab, elem);
+	/*
+	 * Cancel timer, workqueue, and task_work fields before deferring the
+	 * element free. Referenced kptr destruction is not NMI-safe, so leave
+	 * it for rhtab_mem_dtor() after the RCU grace periods.
+	 */
+	bpf_obj_cancel_fields(&rhtab->map, rhtab_elem_value(elem, rhtab->map.key_size));
 	bpf_mem_cache_free_rcu(&rhtab->ma, elem);
 	return 0;
 }
@@ -3022,10 +3016,12 @@ static long rhtab_map_update_existing(struct bpf_map *map, struct rhtab_elem *el
 	 * BPF_F_LOCK, matching arraymap semantics.
 	 *
 	 * copy_map_value() skips special-field offsets, so old timers/
-	 * kptrs/etc. still sit in the slot. Cancel them after the copy
-	 * to match arraymap's update semantics.
+	 * kptrs/etc. still sit in the slot. This path may run in NMI context,
+	 * so only cancel timer/workqueue/task_work here. Keep kptr fields
+	 * attached to the value, matching arraymap semantics; referenced
+	 * kptrs are destroyed when the element is eventually freed.
 	 */
-	rhtab_check_and_free_fields(rhtab, elem);
+	bpf_obj_cancel_fields(&rhtab->map, old_val);
 	return 0;
 }
 
diff --git a/tools/testing/selftests/bpf/prog_tests/map_kptr.c b/tools/testing/selftests/bpf/prog_tests/map_kptr.c
index 17e707dddda8d..9fddf03387bb8 100644
--- a/tools/testing/selftests/bpf/prog_tests/map_kptr.c
+++ b/tools/testing/selftests/bpf/prog_tests/map_kptr.c
@@ -98,6 +98,12 @@ static void test_map_kptr_success(bool test_run)
 	ASSERT_OK(ret, "test_map_kptr_ref3 refcount");
 	ASSERT_OK(opts.retval, "test_map_kptr_ref3 retval");
 
+	ret = bpf_map__delete_elem(skel->maps.rhash_map, &key, sizeof(key), 0);
+	ASSERT_OK(ret, "rhash_map delete");
+	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.test_map_kptr_ref3), &opts);
+	ASSERT_OK(ret, "test_map_kptr_ref3 refcount");
+	ASSERT_OK(opts.retval, "test_map_kptr_ref3 retval");
+
 	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.test_ls_map_kptr_ref_del), &lopts);
 	ASSERT_OK(ret, "test_ls_map_kptr_ref_del delete");
 	skel->data->ref--;
@@ -147,6 +153,7 @@ enum map_update_kptr_case {
 	MAP_UPDATE_KPTR_ARRAY,
 	MAP_UPDATE_KPTR_HASH,
 	MAP_UPDATE_KPTR_HASH_MALLOC,
+	MAP_UPDATE_KPTR_RHASH,
 };
 
 static struct bpf_program *map_update_kptr_prog(struct map_kptr *skel,
@@ -159,6 +166,8 @@ static struct bpf_program *map_update_kptr_prog(struct map_kptr *skel,
 		return skel->progs.test_hash_map_update_kptr;
 	case MAP_UPDATE_KPTR_HASH_MALLOC:
 		return skel->progs.test_hash_malloc_map_update_kptr;
+	case MAP_UPDATE_KPTR_RHASH:
+		return skel->progs.test_rhash_map_update_kptr;
 	}
 
 	return NULL;
@@ -204,6 +213,8 @@ void serial_test_map_kptr(void)
 		test_map_update_kptr(MAP_UPDATE_KPTR_HASH);
 	if (test__start_subtest("update_hash_malloc_map_kptr"))
 		test_map_update_kptr(MAP_UPDATE_KPTR_HASH_MALLOC);
+	if (test__start_subtest("update_rhash_map_kptr"))
+		test_map_update_kptr(MAP_UPDATE_KPTR_RHASH);
 
 	skel = rcu_tasks_trace_gp__open_and_load();
 	if (!ASSERT_OK_PTR(skel, "rcu_tasks_trace_gp__open_and_load"))
diff --git a/tools/testing/selftests/bpf/progs/map_kptr.c b/tools/testing/selftests/bpf/progs/map_kptr.c
index 0d87c97dac991..44210dd3c0ec9 100644
--- a/tools/testing/selftests/bpf/progs/map_kptr.c
+++ b/tools/testing/selftests/bpf/progs/map_kptr.c
@@ -57,6 +57,14 @@ struct hash_malloc_map {
 	__uint(map_flags, BPF_F_NO_PREALLOC);
 } hash_malloc_map SEC(".maps");
 
+struct {
+	__uint(type, BPF_MAP_TYPE_RHASH);
+	__type(key, int);
+	__type(value, struct map_value);
+	__uint(max_entries, 1);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+} rhash_map SEC(".maps");
+
 struct pcpu_hash_malloc_map {
 	__uint(type, BPF_MAP_TYPE_PERCPU_HASH);
 	__type(key, int);
@@ -421,6 +429,7 @@ int test_map_kptr_ref1(struct __sk_buff *ctx)
 	bpf_map_update_elem(&hash_map, &key, &val, 0);
 	bpf_map_update_elem(&hash_malloc_map, &key, &val, 0);
 	bpf_map_update_elem(&lru_hash_map, &key, &val, 0);
+	bpf_map_update_elem(&rhash_map, &key, &val, 0);
 
 	bpf_map_update_elem(&pcpu_hash_map, &key, &val, 0);
 	bpf_map_update_elem(&pcpu_hash_malloc_map, &key, &val, 0);
@@ -430,6 +439,7 @@ int test_map_kptr_ref1(struct __sk_buff *ctx)
 	TEST(hash_map);
 	TEST(hash_malloc_map);
 	TEST(lru_hash_map);
+	TEST(rhash_map);
 
 	TEST_PCPU(pcpu_array_map);
 	TEST_PCPU(pcpu_hash_map);
@@ -468,6 +478,7 @@ int test_map_kptr_ref2(struct __sk_buff *ctx)
 	TEST(hash_map);
 	TEST(hash_malloc_map);
 	TEST(lru_hash_map);
+	TEST(rhash_map);
 
 	TEST_PCPU(pcpu_array_map);
 	TEST_PCPU(pcpu_hash_map);
@@ -599,6 +610,7 @@ int name(void *ctx)						\
 
 DEFINE_HASH_UPDATE_KPTR_TEST(test_hash_map_update_kptr, hash_map)
 DEFINE_HASH_UPDATE_KPTR_TEST(test_hash_malloc_map_update_kptr, hash_malloc_map)
+DEFINE_HASH_UPDATE_KPTR_TEST(test_rhash_map_update_kptr, rhash_map)
 
 SEC("syscall")
 int test_ls_map_kptr_ref1(void *ctx)
-- 
2.55.0

