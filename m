Received: from mail-wr2-f10.google.com (mail-wr2-f10.google.com [74.125.225.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D9138E8CA
	for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 01:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789782146; cv=none; b=hUl6NX8kUNMx/9q8JSdxpTCq328Ng9WNzKZF4QnXWjPIk/cvdMr/ycDnYVFDzKtsg9z6lxj2ReaDJ+FKisAoEPlDugnPjWq7ujG6p7eg1xRS2bbPNiH1FwIOivYEdBfL/VDEFpi6lXTbuVYkZcTWn1r4MVCcnWSA7q40+5AJ3sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789782146; c=relaxed/simple;
	bh=Mks0GsV+4VOCxSALRLHJuj2BnRudCbmv3rCBiQsttRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DUI00VKIzwVvo42ZbiDxJ2uM2JSbUiqpBeXlIbI4hKIL5oKdGSlOESnKeI0ZlQey0hUxCnBFs2T243e1Mn7HCrFG00kYc5oqV7uyXOIbi4iWyNKp+fvHQN6n9yDsQWdKbIuIcARuH+SEaHw0AtCgwoh4iYzbEKpO5qpqjfm9bS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CX/U25E9; arc=none smtp.client-ip=74.125.225.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CX/U25E9"
Received: by mail-wr2-f10.google.com with SMTP id ffacd0b85a97d-484373a2e82so492149f8f.0
        for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 18:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789782136; x=1790386936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Pjcqf1F/zdQiFmUf/TFt104dMjJoQ4uqckdO96KDt5o=;
        b=CX/U25E9Pueb+oPC9WAKD5FwFcUzoPJXMidlLPUriSRHTpPlQifP0tu5WtrJX0VD2A
         4H/i2/on81c+xZ+pMB0LvPgdIc4gOIhx2+Rthn32c7JwiECFlXXPPdHBbrp7Wdv5YZZy
         WPwM/rPP81yNkhL2daVww7wAbNaD7ZcBiA93A2Bd1VVornjLI121WJPlz/V00b7U85Em
         M+WEIOeHiQ36VF+TTki6/5gVxabyu958+sy1xQizXW+MyiO3vP7xUqwETPpFMo6PZo/H
         pAFdzvX+MnHfbC/azavQE6oJjSb/+JRM16cfdS1Bl2Q1fLwHfUMxDExZX4ZBSCLi/SvA
         oxKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789782136; x=1790386936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Pjcqf1F/zdQiFmUf/TFt104dMjJoQ4uqckdO96KDt5o=;
        b=tp2ta0bwFBmr3DhLHyG4UyOVxciJ9qXyCPuT4OpIeu1Vp5pYfkep06lv7h/FLA7BOQ
         eRBQqwPE5MVFtttSNeke6BdmCAbt+Eq+95PDaqkkXeD4+3Ik8lKV1NA5yADkWU0EQECo
         h1Xa/bEk+wHBQOFC0Nk2E06ZQuB/jjGJ2PHjEvj3HVPByN1KFIMXVx84U300L8WJL/R3
         UiCKHDGMIKx44Qrd9XeY6GKiW9ABQ/0hWZINsxxW5Ddka/dlD5lLfoAZoBjBZq7hqq1q
         I1SJutfeOWl03/QOYS7RsiUSFRvhnYXdQyqDw4tJ55X3dxW0AlBTcEE0X1/3WIIUZDim
         iprQ==
X-Gm-Message-State: AFuF++lGKpARpi9/SKuT2uKhGDzzimykw49Zwrot9JWfrFl8IPfky6xk
	09svuEgi82Uab8YJxFNZueB9uY1JJVAJDkLtwRMe7yrW/rOHG3PUnxmgSa9UipkX
X-Gm-Gg: AYBFou1+jH+T3jm0d60IK1u3YOL+1gM+AyZef7rhzNUlZw0ILhooY0mAiKFKGXWAQ2o
	Usb5I7Nfjyy6TYuNelHMwO7NMxeb97xWskNHCw3qLekrVxqcgOKIPnolN2F/gnLbTVHys519sNp
	l0JTSUDg4M54jWuV+LI824IjrNIjoFbKhegP27WNMs3irsQ1tuPH3NEi2J4/whltdj/hD3misQQ
	1wI6YyJINjWVRJ2mQMa42wZp2AZ8VcQzTSMryZ6qaKnLOxOAafv4WWB8gsue7oRmqolagQpCnju
	CywCd9FYOyfKRZ2h06GU5yBV3Y6og+Hrbn8Ws9KFTfLrbG64ILK+FHRf1/h3HB6ENKJog9vv8gJ
	tfnGFwIi/EZCACCL1dvRyGoermCx76XakYYsNx8HJjOPJrJprriKLm/FfkrLlFRv/ReQUZFUqC/
	LTUCU6sf83w7nzQoJ2JmSB2sQjUwYKOGt5DV3SnIaVALXgZMpOYJ694/6/stZ+VyeprczcU/A4y
	pfjPWqy3a0x+O3Gx5DKRAeewEv9mOhQ5xvLfr6CVJ2hDVpDQKAkt/LneIqmNFv+bqmPvB8krg6T
	IoduqNQML6xup1wAM3BoM39607Hveb+xVsefAQ==
X-Received: by 2002:a05:6000:18a9:b0:487:88b:4681 with SMTP id ffacd0b85a97d-4871e21aa62mr11289092f8f.10.1789782136219;
        Fri, 18 Sep 2026 18:42:16 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48724460753sm3065855f8f.10.2026.09.18.18.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 18:42:15 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Nicholas Carlini <npc@anthropic.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v4 1/2] bpf: Compare stack frames in regs_exact()
Date: Sat, 19 Sep 2026 03:42:10 +0200
Message-ID: <20260919014213.1840880-2-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260919014213.1840880-1-memxor@gmail.com>
References: <20260919014213.1840880-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5553; i=memxor@gmail.com; h=from:subject; bh=Mks0GsV+4VOCxSALRLHJuj2BnRudCbmv3rCBiQsttRQ=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWvts5PXuEr5fXd1ZEy99a57UVPzIo8dHPUlLmXrNDN+C Vyv7ZDtKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZQIYwcHEKwEQ85RgZ3sju9Q/8rnfpkVew 9VTnup7qQw5CH8JqzWJuvd79fcEEFYb/Naa5Vfv133XdbxLI3zDzxOz+9T9Fpy5Y+sL8I/O9Fov vDAA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

regs_exact() compares the register state up to id, followed by the ID
mappings, but does not compare frameno. The PTR_TO_STACK case in regsafe()
checks frameno separately, which is bypassed when exact comparison is
requested. Consequently, infinite-loop detection can treat pointers to
different stack frames as the same pointer and reject a finite loop.

For example, initialize fp-8 to zero in the caller and to one in the
callee, then pass the caller's fp-8 to the callee as r1:

    loop:
        r0 = *(u64 *)(r1 + 0);
        if r0 != 0 goto done;
        r1 = r10;
        r1 += -8;
        goto loop;
    done:
        exit;

The loop terminates after reading the callee's slot on its second
iteration. At the loop header, however, the only relevant difference is
r1's frameno, so exact comparison incorrectly reports an infinite loop.
The same problem occurs when the pointer is spilled to the stack.

Move frameno into the type-specific metadata union, ahead of id, so the
existing prefix comparison in regs_exact() covers it. Ordinary stack
pointers do not use another union member. Iterator and IRQ stack-slot
states use their dedicated union views and do not need a frame lookup.
This also keeps bpf_reg_state at 80 bytes.

Since frameno now shares storage with other pointer metadata, it is only
meaningful for PTR_TO_STACK registers. Return NULL from bpf_func() for
other register types. process_iter_arg(), get_constant_map_key() and
is_dynptr_reg_valid_init() look up the frame before checking the register
type and would otherwise index frame[] with a byte of the register's map
or BTF pointer. They dereference the frame only after their type check.

Move the states_maybe_looping() boundary from frameno to precise after the
field relocation. Its prefix comparison continues to cover the complete
value state and now includes frameno.

Continue to ignore precise. Precision marks control whether pruning may
ignore scalar ranges; they do not change the represented values, and exact
comparison already compares those ranges unconditionally. Marks can also
change through backtracking while an ancestor state is still being
explored.

Fixes: d5b892fd607a ("bpf: make infinite loop detection in is_state_visited() exact")
Reported-by: Eduard Zingerman <eddyz87@gmail.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h | 23 +++++++++++++++--------
 kernel/bpf/states.c          |  7 ++-----
 2 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index a7202b44ab10..6fe8e5dc57aa 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -45,6 +45,14 @@ struct bpf_reg_state {
 	union {
 		/* valid when type == PTR_TO_PACKET */
 		int range;
+		/*
+		 * Valid when type == PTR_TO_STACK. Inside the callee two registers
+		 * can be both PTR_TO_STACK like R1=fp-8 and R2=fp-8, but one of them
+		 * points to this function stack while another to the caller's stack.
+		 * To differentiate them 'frameno' is used which is an index in
+		 * bpf_verifier_state->frame[] array pointing to bpf_func_state.
+		 */
+		u8 frameno;
 
 		/*
 		 * For CONST_PTR_TO_MAP, PTR_TO_MAP_KEY, PTR_TO_MAP_VALUE and
@@ -155,14 +163,6 @@ struct bpf_reg_state {
 	 * during state comparisons.
 	 */
 	u32 map_uid;
-	/*
-	 * Inside the callee two registers can be both PTR_TO_STACK like
-	 * R1=fp-8 and R2=fp-8, but one of them points to this function stack
-	 * while another to the caller's stack. To differentiate them 'frameno'
-	 * is used which is an index in bpf_verifier_state->frame[] array
-	 * pointing to bpf_func_state.
-	 */
-	u8 frameno;
 	/* if (!precise && SCALAR_VALUE) min/max/tnum don't affect safety */
 	bool precise;
 };
@@ -1239,11 +1239,18 @@ static inline int bpf_get_spi(s32 off)
 	return (-off - 1) / BPF_REG_SIZE;
 }
 
+/*
+ * Return the function state a stack pointer register refers to. frameno
+ * shares storage with other pointer metadata, so return NULL for any
+ * other register type instead of indexing frame[] with aliased bytes.
+ */
 static inline struct bpf_func_state *bpf_func(struct bpf_verifier_env *env,
 					      const struct bpf_reg_state *reg)
 {
 	struct bpf_verifier_state *cur = env->cur_state;
 
+	if (reg->type != PTR_TO_STACK)
+		return NULL;
 	return cur->frame[reg->frameno];
 }
 
diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index e4ec007f7fa6..012b82513a3b 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -644,10 +644,7 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 		return range_within(rold, rcur) &&
 		       tnum_in(rold->var_off, rcur->var_off);
 	case PTR_TO_STACK:
-		/* two stack pointers are equal only if they're pointing to
-		 * the same stack frame, since fp-8 in foo != fp-8 in bar
-		 */
-		return regs_exact(rold, rcur, idmap) && rold->frameno == rcur->frameno;
+		return regs_exact(rold, rcur, idmap);
 	case PTR_TO_ARENA:
 		return true;
 	case PTR_TO_INSN:
@@ -1126,7 +1123,7 @@ static bool states_maybe_looping(struct bpf_verifier_state *old,
 	fcur = cur->frame[fr];
 	for (i = 0; i < MAX_BPF_REG; i++)
 		if (memcmp(&fold->regs[i], &fcur->regs[i],
-			   offsetof(struct bpf_reg_state, frameno)))
+			   offsetof(struct bpf_reg_state, precise)))
 			return false;
 	return true;
 }
-- 
2.53.0

