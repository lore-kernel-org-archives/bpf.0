Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FF43B4EB3
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 11:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785756340; cv=none; b=GrU1CH5SQTRW5/o5w7iRpnElZPUCkfV1NSX+qR/RClPGX9mdjAun5KkwGDl/BjneSEID+E3P/EY/13kgrP0Cm7PmavZhK6P2t8bPhRLobKyXSvry4kxGsTi0zlN/VRJ/rtDNuDGSENQ9nABYa7j0WSiAtkjJ59nF7pjIzygi4EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785756340; c=relaxed/simple;
	bh=3D5E0Lg5JRXAFqtPciAWQdBsJA6gxPLeVVy3eBFgJWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sa8SehTJOi2SNyEXMTIhQ8WCrGKSZ1EExoDc14sTWKQ6MoAup79YQUO9/uJZ/T3XKiwKjy/R3+p6RVI/XuPej/8KjCrgg4bjiGDhSiB/jxMcCengbQVeA60epymiaduXkJNmrQpJSMxHQ0HIWk6MBoXKLSSz8UCvYMkyzOgoslw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bmk9Wrpk; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bmk9Wrpk"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cab973140bso39231205ad.3
        for <bpf@vger.kernel.org>; Mon, 03 Aug 2026 04:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785756337; x=1786361137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ff8M+EQ6msWxWzt89+Hwii7UDIx1WOzy+ofanQLYJRM=;
        b=bmk9WrpkeR/pHSdMq+DQUhUKI25DBP9CqCMreF9NyDwkTE4jDS+ZqKz3I9yTrMbvUc
         fYFgauIGuym/mVVFU1lDg9KPvgy2t39N4nOwZRJPrziG37Yj8gcMyl/TIYeF7zJPMsJO
         dBCeYamCWdJAWT8wagm+ED0CL9VqN9xUWSLvio+hYjrLZbAiolWT+aK2+fddOQcdmPos
         AXv/Zf6b7cKbgF/BZFpRF5DCBREy3e9IgsBlsS48wr9x7how26Y4zzwIDhohnC1KwAvr
         L6H05UwrE0gwEtufEQh5QK1FZQNs/KeS06uylRCcs04X7YeUtmVmd0q2qX2HuNZch/Xb
         UWhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785756337; x=1786361137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ff8M+EQ6msWxWzt89+Hwii7UDIx1WOzy+ofanQLYJRM=;
        b=amM824ymXtFhbDpmt6mqZJ0Jk7JZldwLULZPaADe2gukox6g7OjO4J5tEkRMZpy/Ym
         jdI8MPiGMUvAKRCW1gF23VTIRNlwjPVua/ESSZq2UxrrRnp1HW7UKHnhKHrPQsQ3LFvq
         9+cO+ToI3Q/FWygOXoY1gXHHCLHdYZFr9zPN4sgy2TVghlYFho7wq44wTiPnNaYqLpwy
         hzsFdi9mx/NvAdBi6eIsUKdwM+xYx38oj9SBoNdGEREvHAw24a8XS4LnBKr4giw2lsDM
         j/0FiYEGt/tmHKFtiEjXG2CHm6gTmIPr7ggrCUElAVgmts6skNk1rVh6kRlkIKDvbTYf
         a5xg==
X-Gm-Message-State: AOJu0Yx3SzZNzbbdDj7MvSHef4v3+HIlRdc7zbkvRhjJ5XU/mjywSf2C
	QhvoP7wu9N5l/HKYgR/0DnF7SmImMz1INjHei+eVssHm9Ydr3id+xo5RD9RWkaiC
X-Gm-Gg: AR+sD10/HL75qA2+KFUszNtWhWYcGykQLu2yzpqJ8zqiqbzuQeYEobQlH6N0Zmz2rDy
	2tnQEk6MBf6v9+5J1QfSjzfVZcA2DbPOx0zJn4Iqwf4c1qHSGWSUU4xY9qWEKjUHeYhib/7ZnFw
	T9zfG2SUYH9U/hklEzcFgKNIlNxYGJtRonxBvwd46j6yQrxvtLtc3HfkTyyeZhSxxOEJO0U1l56
	azUCDnldBswUZdDDzkRTEYehJ9Cfi0sDOaw60VdADl4RSzWfVTK8ihfAAUxS4jBC7IQ4yo7ijPj
	0otgdHAMzVEibboL7rQT6x+/6K0PvYpSS+C5v0WrzBpUbrM/eWAmVHrQtoeLJb5F9WzxF5K6Dhl
	z4esPOHaAcunu5nGdkaEWI8Aovf9XSuAkXGZjhf0oqN7X+wQthUBIYBf+9k9Xese2mPYjOPtpc1
	/xSn0YABQTI3gZQ5iUQ2bF1e59t0XeKgBfVJ2ucyiIA/hLNGp1QMoHgaPH9uIEAcOEa6ChfVPNV
	3/90F78+z1iJXpLDv6VroJ/WVA=
X-Received: by 2002:a17:902:e950:b0:2c6:90ec:f601 with SMTP id d9443c01a7336-2d05219d40emr97049545ad.8.1785756337361;
        Mon, 03 Aug 2026 04:25:37 -0700 (PDT)
Received: from patterson.cs.ubc.ca (patterson.cs.ubc.ca. [198.162.52.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04ae5a91asm36190685ad.21.2026.08.03.04.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 04:25:36 -0700 (PDT)
From: Ning Ding <dingning04@gmail.com>
To: bpf@vger.kernel.org
Cc: memxor@gmail.com,
	greg@kroah.com,
	Ning Ding <dingning04@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>,
	Viktor Malik <vmalik@redhat.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Leon Hwang <leon.hwang@linux.dev>,
	Kaitao Cheng <chengkaitao@kylinos.cn>,
	Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf v3 2/4] selftests/bpf: Test refcount_acquire return nullability
Date: Mon,  3 Aug 2026 04:22:09 -0700
Message-ID: <20260803112218.3361213-3-dingning04@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260803112218.3361213-1-dingning04@gmail.com>
References: <20260803112218.3361213-1-dingning04@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The verifier could accept an unchecked bpf_refcount_acquire() result for a
borrowed RCU-loaded map kptr. If the call returns NULL, passing the result
to bpf_obj_drop() can crash the kernel.

Add tests showing that an owned input remains non-NULL, a checked borrowed
result is accepted, and an unchecked borrowed result is rejected.

Assisted-by: Codex:gpt-5.5
Assisted-by: ChatGPT:GPT-5.6-Thinking
Signed-off-by: Ning Ding <dingning04@gmail.com>
---
 .../selftests/bpf/progs/refcounted_kptr.c     | 61 +++++++++++++++++++
 .../bpf/progs/refcounted_kptr_fail.c          | 47 ++++++++++++++
 2 files changed, 108 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr.c b/tools/testing/selftests/bpf/progs/refcounted_kptr.c
index 61906f48025cc..fd35093285c0d 100644
--- a/tools/testing/selftests/bpf/progs/refcounted_kptr.c
+++ b/tools/testing/selftests/bpf/progs/refcounted_kptr.c
@@ -23,6 +23,15 @@ struct map_value {
 	struct node_data __kptr *node;
 };
 
+struct node_refcount_only {
+	long key;
+	struct bpf_refcount refcount;
+};
+
+struct map_value_refcount_only {
+	struct node_refcount_only __kptr *node;
+};
+
 struct {
 	__uint(type, BPF_MAP_TYPE_ARRAY);
 	__type(key, int);
@@ -30,6 +39,13 @@ struct {
 	__uint(max_entries, 2);
 } stashed_nodes SEC(".maps");
 
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, int);
+	__type(value, struct map_value_refcount_only);
+	__uint(max_entries, 1);
+} stashed_refcount_only SEC(".maps");
+
 struct node_acquire {
 	long key;
 	long data;
@@ -832,6 +848,51 @@ long rbtree_refcounted_node_ref_escapes_owning_input(void *ctx)
 	return 0;
 }
 
+SEC("tc")
+__success
+long refcount_acquire_owning_input_no_null_check(void *ctx)
+{
+	struct node_refcount_only *n, *m;
+
+	n = bpf_obj_new(typeof(*n));
+	if (!n)
+		return 1;
+
+	m = bpf_refcount_acquire(n);
+	bpf_obj_drop(m);
+	bpf_obj_drop(n);
+
+	return 0;
+}
+
+SEC("tc")
+__success
+long refcount_acquire_rcu_map_kptr_null_checked(void *ctx)
+{
+	struct map_value_refcount_only *mapval;
+	struct node_refcount_only *n, *m;
+	int idx = 0;
+
+	mapval = bpf_map_lookup_elem(&stashed_refcount_only, &idx);
+	if (!mapval)
+		return 1;
+
+	bpf_rcu_read_lock();
+	n = mapval->node;
+	if (!n) {
+		bpf_rcu_read_unlock();
+		return 2;
+	}
+	m = bpf_refcount_acquire(n);
+	bpf_rcu_read_unlock();
+
+	if (!m)
+		return 3;
+	bpf_obj_drop(m);
+
+	return 0;
+}
+
 static long __stash_map_empty_xchg(struct node_data *n, int idx)
 {
 	struct map_value *mapval = bpf_map_lookup_elem(&stashed_nodes, &idx);
diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c b/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
index 024ef2aae2008..acd3e81a39168 100644
--- a/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
@@ -19,6 +19,15 @@ struct node_refcounted {
 	struct bpf_refcount refcount;
 };
 
+struct node_refcount_only {
+	long key;
+	struct bpf_refcount refcount;
+};
+
+struct map_value_refcount_only {
+	struct node_refcount_only __kptr *node;
+};
+
 extern void bpf_rcu_read_lock(void) __ksym;
 extern void bpf_rcu_read_unlock(void) __ksym;
 
@@ -28,6 +37,13 @@ private(A) struct bpf_rb_root groot __contains(node_acquire, node);
 private(B) struct bpf_spin_lock lock;
 private(B) struct bpf_list_head head __contains(node_refcounted, list);
 
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, int);
+	__type(value, struct map_value_refcount_only);
+	__uint(max_entries, 1);
+} stashed_refcount_only SEC(".maps");
+
 static bool less(struct bpf_rb_node *a, const struct bpf_rb_node *b)
 {
 	struct node_acquire *node_a;
@@ -80,6 +96,37 @@ long refcount_acquire_maybe_null(void *ctx)
 	return 0;
 }
 
+SEC("?tc")
+__failure __msg("Possibly NULL pointer passed to trusted R1")
+long refcount_acquire_rcu_map_kptr_unchecked_drop(void *ctx)
+{
+	struct map_value_refcount_only *mapval;
+	struct node_refcount_only *tmp, *n, *m;
+	int idx = 0;
+
+	tmp = bpf_obj_new(typeof(*tmp));
+	if (!tmp)
+		return 3;
+	bpf_obj_drop(tmp);
+
+	mapval = bpf_map_lookup_elem(&stashed_refcount_only, &idx);
+	if (!mapval)
+		return 1;
+
+	bpf_rcu_read_lock();
+	n = mapval->node;
+	if (!n) {
+		bpf_rcu_read_unlock();
+		return 2;
+	}
+	m = bpf_refcount_acquire(n);
+	bpf_rcu_read_unlock();
+
+	bpf_obj_drop(m);
+
+	return 0;
+}
+
 SEC("?tc")
 __failure __msg("Unreleased reference id=3 alloc_insn={{[0-9]+}}")
 long rbtree_refcounted_node_ref_escapes_owning_input(void *ctx)
-- 
2.43.0

