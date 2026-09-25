Received: from mail-oo2-f37.google.com (mail-oo2-f37.google.com [74.125.231.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C344F6487
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 21:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790370787; cv=none; b=p4XuqW5PtrPx8jYPLE6xSSWm+EMR4/9BVRe8PJVTeE4UemVxIpCnChn5CYev1NXtk7aI+5cnK8eFroSnx0UUvZ4fsiyr5J+sKzqaitfE5NNgXtNVGJd3V5SZ+oH/SEeOlp6zje09kltK297P6djV+/FokvDBvPEbI20vEHu7QOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790370787; c=relaxed/simple;
	bh=xWKDax6C5940X9AmksDZ7CblyprAQn0RjG9jOxBPgEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ulEdc+LtX5VI93pgvfoGbtk3fjNqKwQRQBGeztIBpLk7rWV8suAM0O6u6IEe4LwyjV3k8my4Jw8MK9TERFefkx+TEkUxuP1I1w1n5VqDvQjzRBNoWKOZFbzMyQWqQ0BqWcJjWDpX483f7itCu4UFnBMfLgW1fWzhrXu01dj7CeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b01Nz6UN; arc=none smtp.client-ip=74.125.231.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b01Nz6UN"
Received: by mail-oo2-f37.google.com with SMTP id 46e09a7af769-8137b129131so892995a34.2
        for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 14:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790370785; x=1790975585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AdhpD0eLHsutspBR7K8ZwhYWd3RmbhugEm4Rj6g/utQ=;
        b=b01Nz6UNZWdTEjaeIe/fN8J408L9+GV0aUwUW0HIbCwkns20ub72seXOETnGDDz6Gh
         Q9LlFXUeNoEDq7D+xyQVc/ycc9lVXnBMU9t+1zE/gOBE+OdmbDnaoZlrGw/aENJCN2qJ
         TvbQYR/qIZ6F+WRJWa4nic6OecJCiH5/jFMv2Lrb0sIIMJYLQsZlgI8J9CLXCPGJqDQT
         ii4Z9wDiPXH6juhLPmnuFYhDsSPVOh3dEcmOuKLSDRutzLRZ3Hasbubh+nUUAlmXWZqT
         6BEh63rt2DDUiP0baU4JOoxLqLQwV6zBeQ2awWFuAMmcEbQjHCZ+ulh5lsI/XdpoEVAT
         820Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790370785; x=1790975585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AdhpD0eLHsutspBR7K8ZwhYWd3RmbhugEm4Rj6g/utQ=;
        b=Ht2RKtdavtFJQTvTu1UI0zt4l+d169pKiEZgo5b2/qiqt39k/lcXUk/PchxXnPVa8k
         oAdCGJxGvhofh745YHnQG91cOMc7iEg6NK4VuVNT/V2M07JlZNTox0vzuHcdzF3EWz80
         sj7UOOzsq9M5M0i7MUYs4ZuDeqzKhEMv40rpSUowphN4BpTWbQMvRh+60zcRQqv6qnkS
         Zqf6HT9PUml+AEpMyG0m4ZxftMBExIAXFXjrnozvV1F9zxGojfBf5r8ZfQHiFqfi7vVq
         eNbMLEEg76U7ZOUJTJcylXgKEKusK0cMPqpvVlsjc3+QRxvQLJkS+drBZE+u55XkUp0A
         M8Dg==
X-Gm-Message-State: AFuF++m32tGunwP6I+iN4L0PsvVZfq/W/l4n+TOxexrAuXqsidwWa18Q
	ImqkRVNd7b95Un6INXOgjgFY/jnIKiLx/X9CAih0WQxH+ygqeZhFjL3Kk7q4Sw==
X-Gm-Gg: AYBFou34jeLqrVfKBep2C45StR4H5uabtEE7n5F06RQ2U5ml5MuruvKXvEk57nW4XEc
	RbEXyTpCyyrydR0GtJ8tH8UUSN5bgT7sCwkTmh3w5AXhB5ZvY8PbZmi/UWBdJNdOOMx6f22t5sw
	bs0mfOtxJLd7/cvA3xo4QEgE1ZjBOUG5c7FNv/2kVKxw0muUeDuYPC3UfX5fk7kFC/ndCCJflP3
	Sy8SGNleJKOy3IEUYcoK9UxVcRpNuQK+yZ6B5P5AKVCk3JNAr3cQv4RZ+onJDoFsnY0RTlSg1dO
	WYvjEUpWZcZN/QYyVJCsCW9RM0ErUBJp3FZ9K6N45jpVcTAeRmxaNQ8wk9890A6JFnEmy8Dfo/A
	ducukS/A32fUYyI7VqKlvopElzTc0fObzCq3SpbQQhvtheLIdfGF1Vpvg9EoUIPX3KD/FryHPiJ
	NIUfFEEnpSUWCpTC/pGQrZ6rjcZgZ+miJAW0Og5SSUPe9zasnk4UqXTdmHJtOicw==
X-Received: by 2002:a05:6830:630e:b0:813:5e38:12ee with SMTP id 46e09a7af769-8178347c3bdmr8239776a34.25.1790370785171;
        Fri, 25 Sep 2026 14:13:05 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4c::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-818e97abfabsm3677860a34.23.2026.09.25.14.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 14:13:04 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 05/12] bpf: Check global subprog untrusted arguments in the common path
Date: Fri, 25 Sep 2026 14:12:49 -0700
Message-ID: <20260925211256.1834061-6-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260925211256.1834061-1-ameryhung@gmail.com>
References: <20260925211256.1834061-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Global subprogram arguments tagged __arg_untrusted deliberately
accept any caller value. The callee is verified separately with a
read-only untrusted pointer, whose accesses use protected probe-read
instructions.

Keep the untrusted type in the canonical bpf_subprog_info used to
prepare the callee state. Represent it as ARG_IGNORE only in the
temporary bpf_func_proto used for call-site checking, then extend the
guarded check_func_arg() path to cover it.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a84143285b3f..7932d81a5aa9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10805,9 +10805,18 @@ static void gen_subprog_arg_proto(const struct bpf_subprog_info *sub, const stru
 
 	memset(proto, 0, sizeof(*proto));
 	for (arg = 0; arg < btf_type_vlen(func_proto); arg++) {
+		enum bpf_arg_type arg_type = sub->args[slot].arg_type;
 		const struct btf_type *t;
 
-		proto->arg_type[arg] = sub->args[slot].arg_type;
+		if (arg_type & PTR_UNTRUSTED) {
+			/*
+			 * An __arg_untrusted argument accepts any caller value. The
+			 * callee treats it as read-only and uses probe-read instructions
+			 * to protect against invalid memory access.
+			 */
+			arg_type = ARG_IGNORE;
+		}
+		proto->arg_type[arg] = arg_type;
 		t = btf_type_skip_modifiers(btf, args[arg].type, NULL);
 		slot += btf_arg_slots(t);
 	}
@@ -10870,16 +10879,10 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 		t = btf_type_skip_modifiers(btf, args[arg].type, NULL);
 		nslots = btf_arg_slots(t);
 
-		if (arg_type == ARG_SCALAR) {
+		if (arg_type == ARG_SCALAR || arg_type == ARG_IGNORE) {
 			ret = check_func_arg(env, arg, slot, 0, &meta, env->insn_idx);
 			if (ret)
 				return ret;
-		} else if (arg_type & PTR_UNTRUSTED) {
-			/*
-			 * Anything is allowed for untrusted arguments, as these are
-			 * read-only and probe read instructions would protect against
-			 * invalid memory access.
-			 */
 		} else if (arg_type == ARG_PTR_TO_CTX) {
 			ret = check_func_arg_reg_off(env, reg, argno, ARG_PTR_TO_CTX);
 			if (ret < 0)
-- 
2.52.0

