Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793559951;
	b=zkOXC88vbqGG7RA0FljBnnaBliGkxtT5FpVUqYGT7RiATHXkmpkD5gIjTjDoeakROkPw
	 V8b1V6ZBJNwitI6Yr73a8nLkCXHlU5FDvh3MaRgoMSshXuV9hWRKRdjtRLngZNvilLGY/
	 B9zVf0MSFgmN3eVTHIeVseuGAR5wZndYOK/SU3M9IY6vLNMwR5QDi9a8wkz6XexbMooF0
	 0oNxWvGxcpsnVvhoYNbxfpKnXM4f25ZOqMvYLDNL4NImBeWaMaT+I2zssAu1k2TP73IXz
	 tvmDuZJGnn3m3yrq8/QhW1ocitLu1N+LnyX0ed7PJx7DfZ0ycsPz1LHgbLVMyLD3MEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793559951;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=HMLWhk1ywvLeexRwjk39Jo89VloTz9sqFmYaSvhP/k0=;
	b=nK6Ij8sm6FAwvAU9NT9i6vMYwZnUTsBLzG01QtE+AfZXOTtzi8ml7ATh+gnZgzBAmKJR
	 +WNpm6VT/XkHbt52Omh9MuFIJ8Jvf6C8yk3lm1K9m4o9/uclL1fiYcjhCVN8GWB2WlNp+
	 FywsHwOpQYbpSbsi4cvdD1fajMDvYwtZj28AhyQq//5/Rv3uReYiYBkKpT7XahXwalO7Z
	 QpZcWp8a67NSRsfm0F1+dDadS9uOn//UdA3AVcMOBweevQi98ZID3pZzqb2IYjMDvzGox
	 2TriSSSPrB6voATodX4z5KsjNqNkSyfXhVRmOIZNEzmDrhsWquJpcgG7YL2T4NiJrjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o+wdmNnX;
	arc=none smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCF2606A324
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 19:05:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8DCF2606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o+wdmNnX
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2e95bd1c14cso21034455ad.2
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 11:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793559951; x=1794164751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HMLWhk1ywvLeexRwjk39Jo89VloTz9sqFmYaSvhP/k0=;
        b=o+wdmNnX9Bm+8WhHrOHAgjwKBqydp77CyMBaGZFZknIGJALwUAT87N8RLOosqv2rNW
         rLeEoyrbvBxmuYen/Kxf8XwXwGnCEH6YjufaUFOCouk9M7n2aoTf7q0TJeDpn6h2lPyz
         DHKMidhROpftBzjR5Pj6LuFmttSK6dNI41e6lO1NJgzjTRFE+kq9aEJXP0mbpoAXH9bX
         ccwacc2OoLBo15eDFAKyN7XokeoIw+We1FKAQiYuhiQ1xC54aj846Ud7DZZFBQKPo1KV
         PJqaXMWbZam9qWFXbRBVjDrUjxVm8IcOmebM2Bkm/dXb5vLXKUm2ELhNyjzhAN/4xv4j
         vuPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793559951; x=1794164751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HMLWhk1ywvLeexRwjk39Jo89VloTz9sqFmYaSvhP/k0=;
        b=HctnFhvZb8qRR7UNmnLc9HZwLvK0gwS3DYPqAcbtE8rgXw0eS2Wx0zbNW6wn3mmUpu
         +xOoDKY+YkZB1NPKzPyMaRWITKFQx0aEocYVCplTVjFaL4xgPPc8KFtbhrdj8a6e/VFC
         VagC8igobNQV1QXsDGOzpxiZW/djyPKgKUp8kkyTbA9HOU3CrAOG7J8aUP1JRuVXrj1U
         xvqbGZ2FCofQ5pZvmpVAcEBdUeQMWi+OkyMLqjwhi6ebA2zpwn/WaI8JvegAH37xBtzM
         qEFQnHf43hcc4JhxamEJyOPksO89y6kTy3u4aS09/kgPYRfoZDt3gKgtTzwQUw0wHkhO
         41qA==
X-Gm-Message-State: APuU4Z9dBDlHSbv950ys1BpXcyw7kFZGRToHfxnTRBjiNJBPcAO7K9Lh
	j5QunlOGc8bfXmDQuVjy1mGfULTuEGApxPCWAZ1JYHwSKzjYM3NusCPswRiLVw==
X-Gm-Gg: AYBFou33kEYYgr32/CDBfgtqHuonAhYQ1qMa7xnAiOgUgkibffaHZLTyFEelNJnxlDX
	G4woarKBJW1JN9GLQgf/ppQrt+kHaGSdi601eZtk2F/qWds1jy0u8WnNB+STv1xD4cSxq+v3msE
	bXB+xXq9/4ARITiYf5xEgLuQxq8UduEwXRIhLWvceYlajYBkRrnhNPrKvXgCZgfxnQ9iiClkGJF
	jILaf0sVj6uI0/U4ikk6FhAV4mJLb99mPXMwnPl/G/oTaKm3m4npxhHxsxZgoW2SE8aT9ki49l6
	mqxh2IyyHL01ijSmqAU2VanJpmHQxdWPkellSAmImSeZK0dx25C8B7igCnefyrjZYh52O6acba6
	IQlxxYCo5//y4NQDzEDe3QQ4ZrwpVqUbwn13s0j0xJ/JgK8Ah0W+QNUg5+CCbjGEYNCiuiMM6cB
	ZVCdO7ipw8K1lqteMEc3DYXGAaqG1wOZmWUO5aXoOpeS+PEfzJFHjMQlhrEi7uvKRzbNumt07qb
	wppDmmM5JeL5ez8BB9b/WjLEnTgIXd8sHknad5Ni+OHP2QPbeh3rOBn3/nwNX2VtaacDyIBzgqD
	RPSK/7WsMJW0KRZMRLIUlfOZcRkcNkGj9OvrMvxzDweska+FzZt1t3Qp/dVxhM1VkorhBNnpnNp
	bkaJSJwQENrtIFEyb84NP0GYc5g6WjKpn6biXXkoVH87sKVZl7vuAtKksBMnBozgfR4hJ3ZVc/Q
	==
X-Received: by 2002:a17:902:f642:b0:2e9:970c:2c2 with SMTP id d9443c01a7336-2eb364f3544mr79647285ad.48.1793559950623;
        Sun, 01 Nov 2026 11:05:50 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb3927ff6bsm19355555ad.52.2026.11.01.11.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 11:05:50 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf 02/27] bpf: Clamp the trace length before the skip test in stackid_init()
Date: Sun,  1 Nov 2026 19:05:10 +0000
Message-ID: <20261101190535.1454146-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261101190535.1454146-1-alexei.starovoitov@gmail.com>
References: <20261101190535.1454146-1-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

stackid_init() gives a bucket of the stack map
min(trace_nr - skip, max_depth - skip) trace entries. Here max_depth is the
size of a bucket plus skip, but at most perf_event_max_stack. Context
markers can make trace_nr larger than that, so the skip test can pass when
max_depth < skip. Then 'max_depth - skip' wraps, and the kernel can write
after the bucket.

Clamp trace_nr to max_depth before the skip test, as __bpf_get_stack_pe()
does. The result changes only when skip >= max_depth. Then it is -EFAULT.
Until now skip == max_depth could give the id of an empty trace.

get_perf_callchain() releases the trace, so an NMI can change trace->nr.
Use READ_ONCE() in bpf_get_stackid(), so the compiler reads it one time.

Fixes: 23f852daa4ba ("bpf: Fix stackmap overflow check in __bpf_get_stackid()")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/stackmap.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 7d90891cce0a..a19126f5db02 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -522,12 +522,14 @@ static int stackid_init(struct stackid *stackid, struct bpf_map *map,
 	u32 skip = flags & BPF_F_SKIP_FIELD_MASK;
 	u32 max_depth;
 
+	max_depth = stack_map_calculate_max_depth(map->value_size, stack_map_data_size(map), flags);
+	/* trace_nr can be above max_depth and max_depth below skip: clamp first */
+	trace_nr = min_t(u32, trace_nr, max_depth);
 	if (trace_nr <= skip)
 		/* skipping more than usable stack trace */
 		return -EFAULT;
 
-	max_depth = stack_map_calculate_max_depth(map->value_size, stack_map_data_size(map), flags);
-	stackid->nr = min_t(u32, trace_nr - skip, max_depth - skip);
+	stackid->nr = trace_nr - skip;
 	stackid->len = stackid->nr * sizeof(u64);
 	stackid->ips = trace->ip + skip;
 	stackid->hash = jhash2((const u32 *)stackid->ips, stackid->len / sizeof(u32), 0);
@@ -642,7 +644,8 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
 			/* couldn't fetch the stack trace */
 			return -EFAULT;
 
-		err = stackid_fastpath(&stackid, map, trace, trace->nr, flags);
+		/* the entry is released already, an NMI can change trace->nr */
+		err = stackid_fastpath(&stackid, map, trace, READ_ONCE(trace->nr), flags);
 		if (err != -ENOENT)
 			return err;
 
-- 
2.55.0

