Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042FE3655E4
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 01:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790039624; cv=none; b=u2KdjhO18Bi7zpfTxPghzusfPi+I5UGObv/rWZ2+r34zZJ6evda+bqS+sTxtQA1nDc/dgCESKv3u1pNuXl0uGUPfLbTVaM/tAhKcZxMZBI5GQ7IXLdHm526W0kTCSN5b8RAFRAsn1fR/pKfTj9omobzKYZR9VzcL7KbZ5YewbQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790039624; c=relaxed/simple;
	bh=5wHgZPnkRsHrWDa7uIHhIOY0vjBbq+cDF2mBpaEeiTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FAH8pbnqfXmkGYVvT/CyAW2soLK1tP9dM/B1MJMZWwMVxC4x2jd+cxWiTGBBFBvj5Ep8kPbvOImRciQcJNY5Qd1ut6hV75bBx8kE0Ydk/URMvboWPyvfee339R5GzUyhQkJk2Z9bA6EPK6MKbdmV/o+Ryz3uhTRHAqDe6ElMc3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UQTyuz7D; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQTyuz7D"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-86efece610cso2581473b3a.0
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 18:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790039622; x=1790644422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cBRK9VXq3KZXsD393Mq8Z3DcWbnaAsIxU9F6bZ+9CLo=;
        b=UQTyuz7D0zc5r2RQSUZWpBa9gyDuk6ha6i/a1A5cDj384RGn5z6x+fRf1BRMdeq8xp
         WC9pG8r6HgA00MJn5ALpz0w71qSS0S7m1oCvjOppLlaDZz3fg4ueemZuZvelQMZQmiDG
         p/4QmckEI51l7IMI2jQzm3iGzqDJ+hXciRLn3EksdjVrdlEUmCIUavslWHa0Cd9TBwUo
         EQSsxV8UY1q4nSB9rlZVKPLqWXVAJlEMFp5NvreiEM3r4/aAkjQgtJ7hvoApufHafDlm
         ejMK4c65lCyWo+omBvz+C3XD3fSeGAXHS0Fabzk8dL01lwbiKmyg6ZMAI+BeFqmtvfgk
         rxRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790039622; x=1790644422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cBRK9VXq3KZXsD393Mq8Z3DcWbnaAsIxU9F6bZ+9CLo=;
        b=R+wGvBHsAqfDv4nUK2gcUQ5hXJKwFEjyAtERXY134xnuP8LxWFWemQQAwNgyVVObae
         hi4/jWcHbCpqCNzgU4n6RG31uRHR1Ely3w7pHBM0jeBMJ8u7dmf2OOehaW/itdB/r1l8
         dxosrQpDqAG5a+eqSLSGWo95x2+sH1O6vYQZEDU+DT+lV6zRlv7rFyBudS+g517YdmcU
         HQvAiBRNlXPOVIUlcfD8xWyvq2XIzjVenMGO0K+RERukbGxhvztjlsMv698s03bN1SKz
         8ZvpqsPS8rnXJBOjFRDCTrerXOQF2ScpaEyMqL88wqX4w9BJf6t5XejhvaBpkp9zhmLK
         TGbw==
X-Gm-Message-State: AFuF++nxJTzakiBXf3Yoibrkjz+uU8B+KfpLMnVvWUoJhQS9epZ22xtm
	6yog+5oHB3HJJB3RXrIZgDpB/M4LaexeWdV5ZtzNO6M2AQhKe+ytZI28S0ov8A==
X-Gm-Gg: AYBFou3jqVq5X+4JV/859MI4MBYFlz9KGHASYKfyICUt0lpKnhQY91RBDk0LIYGmYU/
	jG90JYpS6VckOmkYQ1cPQWZtQn1V1tnsVQMnh2bYEeL8f6zG1q8jzKQqJLbpQgCjHoRZD56U6R5
	v9qA2D8qJwOoKaz40MlQCCXnMkJwrLOWU9jQGuMV4Cuhm4oM1GNzL09gLSi4ZmGDujr+mwYZoIr
	C++qwZddaMLO7D0moC8oGPtRssZfe80fDrzmh/ym9a2fGpN+1aJ2pLJ/Dfveeu/3XH7AVsKsl69
	NE4Ux2+YSZlSQECyiFpFTMzrCTpbXnZiPfQwuAc89qEbplP8HpdxeqLdqO5K6YaOpETbMX4kYew
	GKImIYD1TjZoh29U5dAoR/L6/HaxeFFz7yeBh/2nqJdtKBjFbOkNsgWd8vBYS2G6nydxEUskZBU
	v6qa9zv5ifbEkhPKgt/o1Wm10j7W4IGV7zaNVW5mrVnt/e7g3Ff4vVj8MxQ5VxVlGWlhKBF6aTh
	QYBkS/JP9APvrNSYQzQPc0fS6ukj13HmDXR8eLL1dMXjYSxy7uiN7n8fNAoMOeszgGRDAziNO0K
	ABqt7GysWkRUOBLnqjQPqCvUpMbUuhnRz0yHSa6vGuIuOgqV65YGgg==
X-Received: by 2002:a05:6a00:e15:b0:869:ffe4:47a3 with SMTP id d2e1a72fcca58-874ddd01bb9mr16352192b3a.20.1790039622123;
        Mon, 21 Sep 2026 18:13:42 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87c333aa9cdsm50574b3a.59.2026.09.21.18.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 18:13:41 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	a.s.protopopov@gmail.com
Subject: [PATCH bpf-next 03/17] bpf: Don't fold loads from insn_array maps into constants
Date: Tue, 22 Sep 2026 01:13:09 +0000
Message-ID: <20260922011323.1298619-4-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922011323.1298619-1-alexei.starovoitov@gmail.com>
References: <20260922011323.1298619-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

bpf_compute_const_regs() constant-folds loads from frozen read-only maps
via bpf_map_direct_read(). insn_array maps are frozen and read-only too,
but their values are addresses of jitted insns that are not known during
verification. bpf_map_direct_read() returns zero, the register loaded
from the first two elements of a jump table becomes const 0 and
bpf_prune_dead_branches() may rewrite a conditional jump on it.

check_map_mem_read() in the main pass marks such register as PTR_TO_INSN.
Treat it as unknown in const_fold as well.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/const_fold.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/bpf/const_fold.c b/kernel/bpf/const_fold.c
index 7f1b30059cc8..982125026eaf 100644
--- a/kernel/bpf/const_fold.c
+++ b/kernel/bpf/const_fold.c
@@ -181,7 +181,12 @@ static void const_reg_xfer(struct bpf_verifier_env *env, struct const_arg_info *
 		int off = src->val + insn->off;
 		u64 val = 0;
 
+		/*
+		 * Values of insn_array map are addresses of jitted instructions,
+		 * which are not known until the program is jitted.
+		 */
 		if (!bpf_map_is_rdonly(map) || !map->ops->map_direct_value_addr ||
+		    map->map_type == BPF_MAP_TYPE_INSN_ARRAY ||
 		    off < 0 || off + size > map->value_size ||
 		    bpf_map_direct_read(map, off, size, &val, is_ldsx)) {
 			*dst = unknown;
-- 
2.55.0

