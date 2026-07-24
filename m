Received: from mail-wr2-f1.google.com (mail-wr2-f1.google.com [74.125.225.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18836371887
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 20:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784924202; cv=none; b=qlKamdZYAkEeBH89TEZBIW8XxPsg3+SirQzdkUALmIQ99DDGcwOJ1zBua1xwynjYwLNZn2tnjyRLQcBncNxd50i5J8Fn9snMGqSZGdS/cEIdWXAq8spVJVnl76RZYRceeIHz7xRvdKb+aJIF1IWlam5Y5GnPzswr1K+zHK+xuWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784924202; c=relaxed/simple;
	bh=bNh0Ynjot0mzbqFkwlLkzOTjpCibN5xJLPTB2AzAvtI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RgjFYJybnXFf6XlRTWenI89mZLubcU+X1Z0/lDY7/cpr06wqZ37qZbTH3SyWaLGs29229BkEDdqjBSsUHOFG/zbkNruP78OePAGi7tFlOCLhLVG3Q2oLqxHk5G7fMzq022quB7OdJiNdZ/CrahYvF2HBp7had6ke1IxM5cLN4RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IAxaYVl0; arc=none smtp.client-ip=74.125.225.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IAxaYVl0"
Received: by mail-wr2-f1.google.com with SMTP id ffacd0b85a97d-473b8c0fd5aso224868f8f.1
        for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 13:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784924197; x=1785528997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zPNWg/X+Meg9wbD8Ixm42yh6qOU5A1tbBLJvz7YZHws=;
        b=IAxaYVl0up9L60n8mICCkVYlgY2j9z+bQcgF81mLT7mZq8FP79csGK5j8/1SjWYW+v
         GPC0eUYkBpBNa/80tnBpX8iF+WDoZW4qmSO+O7fo6TvshFZK2ulVxwoshbfgRUa9hKm0
         UPnyhC//jIu6FhZ+qk159YOaG6Y1wp1QPWedMELTp7jQlyWKDpzKxKcU82WN5OI4BZLw
         zwplRs6xoxJXZNybhUhL/AK7GikJ9KcL8NGbDbxXzJNGMxvuBeYPbKhcBcuDQ3AiHjZy
         9eebsLS0oKB6+9TvvoICVRtNFcq5itgv4Ummkn7yxKeswpdw8ZSkQKy1Gy9bHHtRSfWU
         jVyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784924197; x=1785528997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zPNWg/X+Meg9wbD8Ixm42yh6qOU5A1tbBLJvz7YZHws=;
        b=i1bdoH6+LcCWOVcQKhYmM8BzpmofUyFLl+eY3vs5Dnd17olPEKqnQ7jasToN0aYJE0
         TJsFRL52dQZnzQRzsrc5ktsjoCRtgO3oEzFpJWI+xE/rXOhNsyWiPLss7vkn5VaratFj
         upI/sQp9snl1ZvVHAFIkCa8/iGjT9l66RbD/9pKk5yCZLAv94ezPnG4eTYqRGylrLw/p
         DkqMeOQ8wUKshdWFis5XAqPDMQ6V++rL/U6Y10+PcrDAzHJobzyHc/nROuCdomzBSda0
         kW302VnJixpbQvWkUMEXIGz0kVknnAL0dFgYvQZmuyYchoF/6oynoGFlN6Dfy2yoWXc0
         zNZg==
X-Gm-Message-State: AOJu0YxqMzrbyCA32mBkMxM0cJ8hYqC5BnWfrNEIo/xJIAvwIAfvG8O0
	/mQh4mWhjLMAxV0bIJ1q6JsNlcIpvMryh+UbePtp+gkRK5P8/L2Vcq8L5U10G1vJ
X-Gm-Gg: AR+sD13WvgURei3zpFfBu9iDsq3d7o78fRqQnaqwyZZxY94tJTZOEvWUfjAghm3mr6v
	IrgS1QFIQr8MJwu45Cn1hmrzU9WcGgLJjlQldmroTy0WOSwl4kJ6XIUECqmbR6D4JOgaHftSbil
	GvGAdBbBbuE8/UvGKuehQixZ+08TjOG5ge8zdxEDT0Qmkm25LJASiTdaZMFUyQK8bD0tJzYVfzi
	Bxh2jaPeMvp59qhm0GFh0LJE4v2DsfJ7xMY3m5APfdQq0QXk7vhaN0D54tljLM7taqcto8d7xHn
	WTd7a8kY/0NZvm6Eaxs7Cfp1Jhp2PbOee4o45/hbkStCQ8+rl935C06FvBBhmHqZ9TKCOuj1Hdq
	NxRlNomH4P9b9xrcAEIYem4WHb5yZSSyZ+TBxwsrTraqUZkne75Qa5kdVInV/M9XrfRRibd9POI
	lCLh90MWCcqGALJoaE74pPzsMTZZTuGmtWapL0wUsX6EZ2M7Bz2Irc33t37zw1atP85qls2JUAf
	Y/oY6CtIn/QRS/G8kbthWjUG4AM8xaKHp6aBUepAqVU
X-Received: by 2002:a05:6000:3107:b0:47f:6b9a:9d54 with SMTP id ffacd0b85a97d-47f8d61a4b5mr11284566f8f.7.1784924197359;
        Fri, 24 Jul 2026 13:16:37 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c532d4sm25923485f8f.22.2026.07.24.13.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 13:16:37 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 2/2] selftests/bpf: Test res spin locks in tracing programs
Date: Fri, 24 Jul 2026 22:16:32 +0200
Message-ID: <20260724201634.3025247-3-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724201634.3025247-1-memxor@gmail.com>
References: <20260724201634.3025247-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2821; i=memxor@gmail.com; h=from:subject; bh=bNh0Ynjot0mzbqFkwlLkzOTjpCibN5xJLPTB2AzAvtI=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JISv5eOwSw8v3pNX/vsqoadxR8mT5xal9Nj5779TN2mUl9 tFwy06BjlIWBjEuBlkxRZaS//uYjE9U/g60XcYNM4eVCWQIAxenAEwk4igjQ2OOj4bWMgX+FI/D 255c3Dqrp6Lu2I5zshsVeQ7tMGKU2sPwP6jvs7T1M6FZXDZGx77XVElefHzjSnjn9Lik5mseE+S 2sQIA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Exercise bpf_res_spin_lock() from kprobe, tracepoint, perf event, and raw
tracepoint programs. Keep the existing bpf_spin_lock() rejection checks so
the tests cover the split verifier policy for the two lock types.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../bpf/progs/verifier_helper_restricted.c    | 66 +++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_helper_restricted.c b/tools/testing/selftests/bpf/progs/verifier_helper_restricted.c
index 889c9b78b912..b3beb8f6dd19 100644
--- a/tools/testing/selftests/bpf/progs/verifier_helper_restricted.c
+++ b/tools/testing/selftests/bpf/progs/verifier_helper_restricted.c
@@ -10,6 +10,18 @@ struct val {
 	struct bpf_spin_lock l;
 };
 
+struct bpf_res_spin_lock {
+	__u32 val;
+};
+
+struct res_val {
+	int cnt;
+	struct bpf_res_spin_lock l;
+};
+
+extern int bpf_res_spin_lock(struct bpf_res_spin_lock *lock) __ksym;
+extern void bpf_res_spin_unlock(struct bpf_res_spin_lock *lock) __ksym;
+
 struct {
 	__uint(type, BPF_MAP_TYPE_ARRAY);
 	__uint(max_entries, 1);
@@ -17,6 +29,28 @@ struct {
 	__type(value, struct val);
 } map_spin_lock SEC(".maps");
 
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, struct res_val);
+} map_res_spin_lock SEC(".maps");
+
+static __always_inline int use_res_spin_lock(void)
+{
+	struct res_val *val;
+	int key = 0;
+
+	val = bpf_map_lookup_elem(&map_res_spin_lock, &key);
+	if (!val)
+		return 0;
+	if (bpf_res_spin_lock(&val->l))
+		return 0;
+	val->cnt++;
+	bpf_res_spin_unlock(&val->l);
+	return 0;
+}
+
 SEC("kprobe")
 __description("bpf_ktime_get_coarse_ns is forbidden in BPF_PROG_TYPE_KPROBE")
 __failure __msg("program of this type cannot use helper bpf_ktime_get_coarse_ns")
@@ -165,4 +199,36 @@ l0_%=:	exit;						\
 	: __clobber_all);
 }
 
+SEC("kprobe")
+__description("bpf_res_spin_lock is allowed in BPF_PROG_TYPE_KPROBE")
+__success
+int res_spin_lock_bpf_prog_type_kprobe(void *ctx)
+{
+	return use_res_spin_lock();
+}
+
+SEC("tracepoint")
+__description("bpf_res_spin_lock is allowed in BPF_PROG_TYPE_TRACEPOINT")
+__success
+int res_spin_lock_bpf_prog_type_tracepoint(void *ctx)
+{
+	return use_res_spin_lock();
+}
+
+SEC("perf_event")
+__description("bpf_res_spin_lock is allowed in BPF_PROG_TYPE_PERF_EVENT")
+__success
+int res_spin_lock_bpf_prog_type_perf_event(void *ctx)
+{
+	return use_res_spin_lock();
+}
+
+SEC("raw_tracepoint")
+__description("bpf_res_spin_lock is allowed in BPF_PROG_TYPE_RAW_TRACEPOINT")
+__success
+int res_spin_lock_bpf_prog_type_raw_tracepoint(void *ctx)
+{
+	return use_res_spin_lock();
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.53.0

