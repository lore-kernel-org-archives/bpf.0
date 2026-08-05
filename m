Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52ECC361950
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 23:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785973276; cv=none; b=qGPjvbb+ZtJtchw8m5n983mg7cdKVjw90QDX+YNxP9CkCdSLp1CJ133DwSp3Q/R8zyDI0K3t+vgReTdXdZlFiW0FsXUlizv5SkcTu1TisJvyYfDoZtHihhdfTTJ9pMQkxe79UfWNuygWfYN7iWtE0DnRaW8tZZBX17+VER5gDRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785973276; c=relaxed/simple;
	bh=Jis2S4tgjn6374XnFYCkZXB27nmh2T+Ik9kheVWfYjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JCgphVqSgXsZfcMFdJU9vRnzIEG4gomgG+78b9aMGI5dKh1LA/SDBSzKhcX3wxlPrIxUc7BEtGYboVW5Vkm/j7nPtg3I2Ge5Buw0zt7h5Df5k7GTiImZOJL2QHsft6k0hmfUbg6KE6aFHms5XLEdmvDQthfFO68sexMdP3BOTlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nvGZ9guY; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nvGZ9guY"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84e84a6c4bfso453444b3a.1
        for <bpf@vger.kernel.org>; Wed, 05 Aug 2026 16:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785973275; x=1786578075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HrIf+Edn++d6wNFgJNuIXpHXoc2jM8IzZvutcAUZv5o=;
        b=nvGZ9guYBD0PSqSH357cUO0eeWmSyeU7nwpHa3Jz95zi/Cf6KVHMJK07FVZ9s9wZbK
         DJWmTAmYhhg0Lry5d/cgPHk3eITsGXs/qa+SxnZWcUzap75KnXKHPEq23cuUly3O0dbv
         B/W0z+KprfFbf1k4ZJmPkGey4YDnFLDUbUdcZkRqhmb33sYlgqyz4Wg9kmto+oqqeQnW
         Z5a+CgFpHRpu7uGr3XXCLioOjS+7Wxux8HAwO3RQoMY/TYaI2yVwpjW/ZY618WDKDORB
         T0/szcRyW+vn+1bZI4i2yfIUISOIh4M5UXjV7Wx2As6w+chg6cp8VtcgZdkz5Yf+dQiF
         Dvwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785973275; x=1786578075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HrIf+Edn++d6wNFgJNuIXpHXoc2jM8IzZvutcAUZv5o=;
        b=bhN6d+OGKx/oTNTP83IYX0r6PqAOsncPIFV43Inl52CQ3t7ZPTqQAxySM41sVDA+Je
         njGaiGmHWAZnHyChJrlvnEuF0BpyNgZ63+yRLVSfizoVzw6+CA20wRJsi/b9nqugqblJ
         7TgDms3Wbe5zJbCSabVue8d1wiGNGQiDj/JISIsQ8J9Oi8UTzPxGi/9m/rbmwQqIgg09
         ePTWM1vbUiNRHbHnmcgsGKB2vUI9FgfiKpQAtIk2nuKCocxm0zjpE1sfB7GBJsET6ucv
         LBWF0KK0IY0LF3jBXdrJIoG8nvBvPO9MymZT0N7z0+c12bbMK9gLiWrSldRAwiJHlIGK
         VtKQ==
X-Gm-Message-State: AOJu0YyPHex0kBsbYd+2XvoyXw9A4qH/9m0y+vU0t9sDTD5EkDAJs1re
	gXVVcRIhBg/UATCN/oNWM+uebhxm8PKmR+8fjzR4YTC5GlhcCXkc+XBdn9qKRA==
X-Gm-Gg: AR+sD11b4ZjamUOFkUBrBebqvG6yLpcYhMuaC8KWJglu6myzLmoIEMINl2gdiYwDIaj
	zFrsNkV+++2sofp3/0NDzNAxZ0bgsQv38RALvq3F/b5QYagGdRYQwKnoJLxgbrFCYF6Q/EJz2WO
	/DPTPtvlqgBQlyu0hwSqQAPtS0uhu4nYfZJZqdjOVMvlbScqG07kawHif27xHZ0oMJmM16ig7Fk
	ZlsWbUSLQBQ1aHHnlJTOWe//qmK+v/Qo0LJdB803ARh0kktdu9HbuXyJQvjvTxI/KN+ijmqUuKY
	B29YOjm2Dssnl1RfoEe0x7v+0YqstzLd2P35YU1UAkMkpIrFkjz3EDTXZkvk76Xy40i8BELsZ8Q
	Lshi3s3QpJ3U+7JXfgUDrZc6pFWC/SqSHJEwTYydMvhG3mIqUCrZRp+dYi1NuYvUteyu0a8kfN+
	N2wOTTYyhNQShpKIrWs9wKM0k55no48kSSqXlX7oa2TkI7Ifz2G60lpDF7w6XIhfyfs1ODCfIbu
	cqjEyYqYYlgJuZO
X-Received: by 2002:a05:6a00:13a7:b0:84b:9a69:156d with SMTP id d2e1a72fcca58-84f47b4992cmr277476b3a.0.1785973274699;
        Wed, 05 Aug 2026 16:41:14 -0700 (PDT)
Received: from patterson.cs.ubc.ca (patterson.cs.ubc.ca. [198.162.52.65])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f45bc5696sm139516b3a.53.2026.08.05.16.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 16:41:14 -0700 (PDT)
From: Ning Ding <dingning04@gmail.com>
To: bpf@vger.kernel.org
Cc: memxor@gmail.com,
	puranjay@kernel.org,
	paulmck@kernel.org,
	Ning Ding <dingning04@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 1/2] bpf: Account for preempt and IRQ state in RCU protection
Date: Wed,  5 Aug 2026 16:39:33 -0700
Message-ID: <20260805233940.3966981-2-dingning04@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260805233940.3966981-1-dingning04@gmail.com>
References: <20260805233940.3966981-1-dingning04@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Disabling preemption or local IRQs keeps the current CPU in an RCU
read-side critical section, but in_rcu_cs() does not account for either
state. The verifier therefore rejects safe kptr accesses and invalidates
pointers when another RCU source ends.

Include preemption-disabled and IRQ-disabled state in in_rcu_cs().
Invalidate RCU-protected pointers on RCU unlock, preempt enable, or IRQ
restore only after the final protection ends.

Signed-off-by: Ning Ding <dingning04@gmail.com>
---
 kernel/bpf/verifier.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d925197c2e5f7..a1005783db300 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4452,8 +4452,9 @@ static bool in_sleepable(struct bpf_verifier_env *env)
 static bool in_rcu_cs(struct bpf_verifier_env *env)
 {
 	return env->cur_state->active_rcu_locks ||
-	       env->cur_state->active_locks ||
-	       !in_sleepable(env);
+	       env->cur_state->active_irq_id ||
+	       env->cur_state->active_preempt_locks ||
+	       env->cur_state->active_locks || !in_sleepable(env);
 }
 
 /* Once GCC supports btf_type_tag the following mechanism will be replaced with tag check */
@@ -11663,6 +11664,9 @@ static int process_irq_flag(struct bpf_verifier_env *env, struct bpf_reg_state *
 		err = unmark_stack_slot_irq_flag(env, reg, kfunc_class);
 		if (err)
 			return err;
+
+		if (!in_rcu_cs(env))
+			invalidate_rcu_protected_refs(env);
 	}
 	return 0;
 }
@@ -13181,7 +13185,8 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			verbose(env, "unmatched rcu read unlock (kernel function %s)\n", func_name);
 			return -EINVAL;
 		}
-		if (--env->cur_state->active_rcu_locks == 0)
+		env->cur_state->active_rcu_locks--;
+		if (!in_rcu_cs(env))
 			invalidate_rcu_protected_refs(env);
 	} else if (preempt_disable) {
 		env->cur_state->active_preempt_locks++;
@@ -13191,6 +13196,8 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			return -EINVAL;
 		}
 		env->cur_state->active_preempt_locks--;
+		if (!in_rcu_cs(env))
+			invalidate_rcu_protected_refs(env);
 	}
 
 	if (sleepable && !in_sleepable_context(env)) {
-- 
2.43.0

