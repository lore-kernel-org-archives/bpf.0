Received: from mail-wr2-f11.google.com (mail-wr2-f11.google.com [74.125.225.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD91A41A903
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 06:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788503829; cv=none; b=BhVewubZTCOqxsQxXFd3QVERIqCc0ZENVGkTCrfuXI9u3DZEXxFYpATCoOkYTNQLnxRFlhtSO4Xf7Z+97cmemAo3zhELRB+e+Z22QWpixmOCL9DRXzwondIDDfnzyFaWXZmvGXUSpxgKZ274EnZtnVaZVQ/apvPLS65s1Zz6gfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788503829; c=relaxed/simple;
	bh=V9VV1kVOwyj5UEb47NRJAjhRSDhdYMowL5m0jpbCZCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TrLVjeo8E05Z9kqGyElevHFo20LVfOLSYtaib8g5WdKycr5Cp0hT7y1sWMqENjGe5LpeQkiGDXtA266Cr/JOuIAFS7hKK/Q+aY1i8yoSTmxzgrbb3Q/8aAbckPS+m76u795Cf8+GXZo3Q5rV/GoayxgfRBQEIXKe10B1MFZh278=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gH1XXkcj; arc=none smtp.client-ip=74.125.225.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gH1XXkcj"
Received: by mail-wr2-f11.google.com with SMTP id ffacd0b85a97d-48431ba6e38so20351f8f.1
        for <bpf@vger.kernel.org>; Thu, 03 Sep 2026 23:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788503825; x=1789108625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XzexIWlhTN/A5wBmQcOPNGGUTtI32mGihzkOS4xXL3g=;
        b=gH1XXkcjcS3ep2rq7AO2b0PHtAIwg7dC+ksEWYz3P5Jd/4NVS7WWAUUuHtMOKi8A/f
         nhD+A/MFeZmgTTKC/bYO7+LMQzyycq/+Tni8Lso6U/km40c9Unqv0gaqxrF9sw973H7U
         rxBU08201uS1fTuWEwog4wCaRvse9etUxlxaWu9LYF/JLe7eicXF7tOsCcBLxpqRREa1
         xIcrIZpL94Mu51RnrY6QZ7/9voirSv7WHNr8IFhk/Gewtd5RNFJZnPmIU8yVaT3T+V0k
         S5wAiPWMkV975XrcO1AhpDJU2qCu5Q8kiTAOzIgMol5VzpHMlvSxJJR3vT99mqE+DVHt
         kYvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788503825; x=1789108625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XzexIWlhTN/A5wBmQcOPNGGUTtI32mGihzkOS4xXL3g=;
        b=GwILmGchi+Xeer4Ii0zNjP8np7iFuZEykosRvtClSFAXs5K8O0FyQwjZ4ao+Uhe1Bx
         ET7WfszbamY+ctSqey1XnAF4h+NuCTcqvBEVfpTf1V8OBYbQCVjMV9bdZoRk66hRS1I7
         wYTqm/mcAgDPvU4+jshZhYzE6z7T+OPdsppIHMXM2FtkXsrsgD/xTXV2jkREb9Y6LFtj
         gLTOBelan+KK53x27/TUR+I6smFOVkn68nXciZn7z1w+uEXK8UXo45FaXR0imoXMuYOe
         TezCRW94L9upjUw/T7fVO1t75CeZJ1mtcZ0vZFQfwrNzCBm60/qt9+yT19JZKEVqKhKi
         ddIw==
X-Gm-Message-State: AFuF++n6Bl6eIA1LTKjdrKNqpWIHIXzfSgvbok6/RsmBmneRSED+DOdb
	ir+r5CEsdLOYPWC7GXZRfh2LxLytdEK0RKUp6XZqWRYVrZi7mAF8b5jh440tZYsv
X-Gm-Gg: AYBFou3U7Pe5D0zVKFsBMPSKwecIzAn3Ns/vPJHs18tA1bYgZ5pjEUvtBKOA7/t4Ew1
	fqjVLYakZ/lAyjB4LZTkvBHU6SOnc1ZQ2q5vJHKn3P3yscsdwKVi8gb1Fk4dZjXpIwjuRNAtEf3
	sd/vw+z67U1xRCES0TMmAgB5weOcrB4y1340LzTxaNS36spT//AjGXXIdg5BsTD/ryry3EdH3HD
	4fruHjhu/SWJcY8N1m7KXhwASZ3l0G5fzYGvkr70thBNhNIusGz+FFMnnN4Mo5H10wgan9Gx0Ew
	CC/sZDUnjHz6q3VNCJmFIbBd9U7OY54fVt8DN3CmTd5XhPwCnsf1n7pGGeTFNXECTsr18+3/IU6
	GDRgAIUAA2kIU3ErlBIHFqOtDX8CfVcaqGgQtwDQYN4W9HzWg/9fNnWz3UW52FnYcmcmnFrEIjU
	rNSnGjcu8Y8h4o5msmna1Z3D1yWun9GRCafMJAzPUGO8e9LXSqoN2OwLWZKcSuTjVxhrQWm+W9v
	/F7KoKDtoI7ULjmxuyhEqSQTzs1BPBdJzu4V+zmuamy0+i2PP4Iyq5R/uFVExuepuOfVUg33j7W
	sk+Gdwm9OKlumZu0T1vu4MCH7MSHhqao8pyYJjdT
X-Received: by 2002:a05:600c:c4b8:b0:49c:799a:177b with SMTP id 5b1f17b1804b1-49cf82be855mr26785815e9.2.1788503824756;
        Thu, 03 Sep 2026 23:37:04 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce5927b68sm180216205e9.1.2026.09.03.23.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 23:37:04 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Ning Ding <dingning04@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Nicholas Carlini <npc@anthropic.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v1 8/8] selftests/bpf: Reject refcount acquisition after RCU unlock
Date: Fri,  4 Sep 2026 08:36:46 +0200
Message-ID: <20260904063650.3877826-9-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904063650.3877826-1-memxor@gmail.com>
References: <20260904063650.3877826-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1790; i=memxor@gmail.com; h=from:subject; bh=UFxYaQXVBNATr1x5p3orV09A2rwwzpQ5UexFnEal+Eg=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWtW2pUWIYaofo7irR3bb/grb9uzNik77+WMRM5tdYoer 2+ujnjfUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgInME2H4w3fpA0exy+Uj366X LjKdku7W/Vhv5pVJH3Vn7Y/8sjpl23mGfzbrmqYL3tGYuYyR935O3PEIaRW9ZukzK2Y9njNN6ND aBH4A
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

From: Ning Ding <dingning04@gmail.com>

Add a sleepable verifier test that loads a refcount-only local kptr in an
explicit RCU read-side critical section, ends the section, and passes the
pointer to bpf_refcount_acquire().

The loaded pointer never carries NON_OWN_REF. After RCU unlock it retains
MEM_ALLOC while becoming PTR_UNTRUSTED, which previously made the kfunc
argument check accept it as a live allocated object. Expect verification to
reject the untrusted argument instead.

Signed-off-by: Ning Ding <dingning04@gmail.com>
[ kkd: Rewrote commit log ]
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../bpf/progs/refcounted_kptr_fail.c          | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c b/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
index 5abd8387d26f..7be45100c4d6 100644
--- a/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
@@ -187,6 +187,33 @@ long rbtree_remove_after_rcu_unlock(void *ctx)
 	return 0;
 }
 
+SEC("?syscall")
+__failure __msg("R1 is neither owning or non-owning ref")
+long refcount_acquire_after_rcu_unlock(void *ctx)
+{
+	struct map_value_refcount_only *mapval;
+	struct node_refcount_only *node, *ref;
+	int idx = 0;
+
+	mapval = bpf_map_lookup_elem(&stashed_refcount_only, &idx);
+	if (!mapval)
+		return 0;
+
+	bpf_rcu_read_lock();
+	node = mapval->node;
+	if (!node) {
+		bpf_rcu_read_unlock();
+		return 0;
+	}
+	bpf_rcu_read_unlock();
+
+	ref = bpf_refcount_acquire(node);
+	if (ref)
+		bpf_obj_drop(ref);
+
+	return 0;
+}
+
 SEC("?syscall")
 __failure __msg("invalid mem access 'scalar'")
 long graph_kptr_after_spin_unlock(void *ctx)
-- 
2.53.0

