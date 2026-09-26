Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395C7477E4D
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 14:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790432477; cv=none; b=jk8HDgrJBcrolackT6k2l5faZOvlGoXjN/TZtw9L6t79efmbezWXzhAWfx9DPJYbCdzKGBkQK4eiQ8gnmADh5lBtS2N7zRdBWl03gWImci9sFlZSLB2RA6Z/LdsTyFqRwDj8u5C/ww4CEq+shuP37AZaQ4bJCVjpG1aZfuDpV5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790432477; c=relaxed/simple;
	bh=LztGugWqoypo7YLyVnbO/aCFsomnBLd2TbZLp9c3GTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TU/uBalv6cM7R9I7fWpG7uFi2fOx3u3Q8rZV1K1+sZztFRtiupZVR7e7j4DjdvJCaxcHsk8r9AdKxrDASup1Sv6FMirJFwUlQSYIKMsLyJqHIrFrvCD/A6Z2LFi9Xf2i5fNy0OpwVpBGjSUW3pMSE7T5Kmw3HwkL3dVG0iB8jaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cCbg58+Z; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cCbg58+Z"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccd4f99dso1186582a91.2
        for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 07:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790432475; x=1791037275; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZfVCSEH8wNRY/7JSUuYKXFs43CZE73bxPz8ZiuRfzw8=;
        b=cCbg58+ZUwG5SUcowK4Qb4TiIrjtKgqIvd5Pk94VlTzkM2aAz0zQIjxJ6NwsVd11G9
         0h31LQuHIaIHtd54kqQWlGYamW9P4tmJyfzxdsQfif9Ohy1foguMzja4o7S2k6RxED4O
         b9J80id1eVqbrpTYHwn2z8pnTfFd2YVXVmst3lr6i+D/4WIvr43b31Hz5r3Shu/dr+WP
         wZhPwf4+Xl3SL5aDy1mmM43r0ecRaMpGhptg8GvkhdRY7G6TPRqWp2uKwWC5QSiq4Md5
         rr207W6I76UxrxT8oUdkMOWMSJfowg4VimHTy2Sw8PgIKiHFoCW4QbkUQF2o9IKOSKsj
         Y8IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790432475; x=1791037275;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZfVCSEH8wNRY/7JSUuYKXFs43CZE73bxPz8ZiuRfzw8=;
        b=uMtaSxAhtuBSzq62aq4cwy79me1nN8jIA7vBiBZpmPTdgQUx/Xkd6+58ppUv8W8IyN
         OSp+18dHY618Dajcoao22ug0CexKu2E+7ndqSstEESrVF1Irkwcs029YvsAi++yn4ir1
         tiadDZvhHlUTF/6NLwpxNPlmsjWyXaw9x8PIOliu9wNgxoiAjCD9/TfA0tvyGzDVQiAw
         fd52QvQGPVV+wN90ObTb5lbPNt3KG5NVH10nFHZv+dQUOqlH+Zt0cUdh7pI4PPBFoLDA
         nSw64QKVMrRMjof08GbPJXmdVKJABS9pk+8b6aK/OCHwzOqynyb+MEnHwntlKer8Bfla
         GaCA==
X-Gm-Message-State: AFq9FYJN7qsIXbwgVXXy1ExQhTwa0hW+w5zgDnN3sbj+ACPRF2oVID+l
	5+jO7bS080fcdc1Rye9UwBoQhYEvRpR3Sq6TX8Ri+5zjVBr4Scd8FPCVzdfTYnslxuU=
X-Gm-Gg: AYBFou0Cor6//PTtgyjIMjQxgUmKMrXn98LpY+uByey5iTrCaqk9VTsD9nzJdYSMq3E
	czq9KFTYTOZS1DtAg8biQ95Z5VHG/MBj21Cj0bk4b1Vx+IRWlRul1kS8coB5sjYDgLfXfnQyNWJ
	Eiel4iWX+jzTaj/c6MPUGFFY4wAcIOn1iZz4MVUfSwSjQckOdtWtsAKmA7hhD7HO4GPQ40PiiT/
	C3WwC02AUhFYiGYsvCSu2hovvr1pRtJ++R4u0ER9g3gjmWnowg7omDpBtZR6Zs3lPRdcJ0PPgEZ
	O7EvR2vq3SYv97Hm72QkEdwEJdQJh1T4ZtiehnIjn7qmI4qvbXmum0lnGJ2Fc5NKHh6StutnczL
	+RFO5yxc53xF+rCEXgUci+HHD/9itXz3w57YHMedCXHv0XvzMcpT6omuhc5uuUp6H5zfCnNSvTI
	6DK0Km20jkumwXikftaWz+s31/m8M8rQTx4x2+/UBMUskcw+Qt2g0K96k/mwirkvK5MFc8jS6ny
	H3I7yQXc7/Vi2wlmv7O6CF7h+CgElaX/kJxbuyHvQ==
X-Received: by 2002:a17:90b:3d8d:b0:3a0:ddef:3d69 with SMTP id 98e67ed59e1d1-3a0ddef3f5amr1764274a91.58.1790432475477;
        Sat, 26 Sep 2026 07:21:15 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0c2e986easm10949613a91.1.2026.09.26.07.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 07:21:15 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 32/36] selftests/bpf: tests for register base/step state pruning
Date: Sat, 26 Sep 2026 07:20:30 -0700
Message-ID: <20260926-scev-minimal-rebase-v1-32-c8e5ab5ba79f@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260926-scev-minimal-rebase-v1-0-c8e5ab5ba79f@gmail.com>
References: <20260926-scev-minimal-rebase-v1-0-c8e5ab5ba79f@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Tests for the base/step reasoning in states.c:range_within():
- step_prune_hit_multiple: prune a step-4 range contained in a cached
  step-2 range when the scalar is used to address the stack.
- step_prune_miss_non_multiple: do not let a cached step-2 range hide a
  step-3 path reaching division by zero.
- step_prune_hit_const_on_line: prune constant 6 against a cached
  base-0, step-3 range.
- step_prune_miss_const_off_line: do not prune constant 7 against that
  range even though its bounds and tnum admit the value.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/progs/verifier_bounds_step.c     | 183 +++++++++++++++++++++
 1 file changed, 183 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds_step.c b/tools/testing/selftests/bpf/progs/verifier_bounds_step.c
index a8358b625ce7..cb55fc216bc8 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds_step.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds_step.c
@@ -121,4 +121,187 @@ l_bad_%=:						\
 	: __clobber_all);
 }
 
+struct step_val {
+	__u8 data[1024];
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, struct step_val);
+} step_map SEC(".maps");
+
+/* Old register [4..130, step 2] should prune cur register [8..64, step 4]. */
+SEC("socket")
+__success __log_level(2)
+__msg("7: (27) r6 *= 4                       ; R6=scalar({{.*}}umin32=8,{{.*}}umax32=68,{{.*}},step=0+4)")
+__msg("10: (27) r7 *= 2                      ; R7=scalar({{.*}}umin32=4,{{.*}}umax32=130,{{.*}},step=0+2)")
+__msg("11: (25) if r0 > 0x2a goto pc+1")
+__msg("from 11 to 13: safe")
+__flag(BPF_F_TEST_STATE_FREQ)
+__naked void step_prune_hit_multiple(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r6 = r0;					\
+	call %[bpf_get_prandom_u32];			\
+	r7 = r0;					\
+	call %[bpf_get_prandom_u32];			\
+	r6 &= 0x0f;					\
+	r6 += 2;					\
+	r6 *= 4;					\
+	r7 &= 0x3f;					\
+	r7 += 2;					\
+	r7 *= 2;					\
+	if r0 > 42 goto 1f;	/* can't predict */	\
+	r6 = r7;		/* step=2 explored first, step=4 explored next */ \
+1:	r0 = r10;					\
+	r6 = -r6;					\
+	r0 += r6;					\
+	*(u8 *)(r0 + 0) = 7;	/* force r6 precise */	\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32),
+	  __imm(bpf_map_lookup_elem),
+	  __imm_addr(step_map)
+	: __clobber_all);
+}
+
+/* Old register [0..126, step 2] should not prune cur register [0..45, step 3]. */
+SEC("socket")
+__failure __log_level(2)
+__msg("6: (27) r6 *= 3                       ; R6=scalar({{.*}}smin32=0,{{.*}}umax32=45,{{.*}},step=0+3)")
+__msg("8: (27) r7 *= 2                       ; R7=scalar({{.*}}smin32=0,{{.*}}umax32=126,{{.*}},step=0+2)")
+__msg("9: (25) if r0 > 0x2a goto pc+1")
+__msg("11: (15) if r6 == 0x3 goto pc+2")
+__msg("11: R6=scalar({{.*}},step=0+2)")
+__msg("13: (95) exit")
+__msg("from 9 to 11: {{.*}} R6=scalar({{.*}},step=0+3)")
+__msg("from 11 to 14")
+__msg("div by zero")
+__flag(BPF_F_TEST_STATE_FREQ)
+__naked void step_prune_miss_non_multiple(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r6 = r0;					\
+	call %[bpf_get_prandom_u32];			\
+	r7 = r0;					\
+	call %[bpf_get_prandom_u32];			\
+	r6 &= 0x0f;					\
+	r6 *= 3;					\
+	r7 &= 0x3f;					\
+	r7 *= 2;					\
+	if r0 > 42 goto 1f;	/* can't predict */	\
+	r6 = r7;		/* step=2 explored first, step=3 explored next */ \
+1:							\
+	if r6 == 3 goto 2f;	/* false if step=2, should not prune step=3 */ \
+	r0 = 0;						\
+	exit;						\
+2:							\
+	r0 /= 0;		/* trap */		\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/*
+ * Constant current register lying on the cached line: cached is {0,3,6,...}
+ * (step 3, base 0), current is the constant 6. range_within() takes the
+ * constant branch: imod(6, 3) == base 0, so cur is on the line and the
+ * (precise) state is pruned -> "safe".
+ */
+SEC("socket")
+__success __log_level(2)
+__flag(BPF_F_TEST_STATE_FREQ)
+__msg("14: (27) r1 *= 3")		/* cached path: step 3 line */
+__msg("16: (b7) r1 = 6")		/* current path: const 6, on the line */
+__msg("17: safe")			/* pruned at join: imod(6, 3) == 0 */
+__naked void step_prune_hit_const_on_line(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r6 = r0;					\
+	r1 = 0;						\
+	*(u32*)(r10 - 4) = r1;				\
+	r2 = r10;					\
+	r2 += -4;					\
+	r1 = %[step_map] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l_out_%=;			\
+	r7 = r0;					\
+	r1 = r6;					\
+	r1 &= 0xff;					\
+	if r6 > 0 goto l_cur_%=;			\
+	r1 *= 3;			/* old: step 3 */	\
+	goto l_join_%=;					\
+l_cur_%=:						\
+	r1 = 6;				/* cur: const on line */	\
+l_join_%=:						\
+	r0 = r7;					\
+	r0 += r1;			/* r1 forced precise */	\
+	r2 = *(u8 *)(r0 + 0);				\
+l_out_%=:						\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32),
+	  __imm(bpf_map_lookup_elem),
+	  __imm_addr(step_map)
+	: __clobber_all);
+}
+
+/*
+ * Constant current register NOT on the cached line: cached is {0,3,6,...}
+ * (step 3, base 0), current is the constant 7. imod(7, 3) == 1 != base 0,
+ * so range_within() fails and the join is traversed again. A power-of-two
+ * step is avoided on purpose: with step 3 the tnum is loose enough to admit
+ * 7, so imod() is
+ * the sole check that rejects it. No failure shape is possible here: 7 is
+ * within the line's bounds and tnum, and the cached line path already
+ * verifies the whole outro, so an eager prune could not miss an error.
+ */
+SEC("socket")
+__success __log_level(2)
+__flag(BPF_F_TEST_STATE_FREQ)
+__msg("14: (27) r1 *= 3")		/* cached path: step 3 line */
+__msg("16: (b7) r1 = 7")		/* current path: const 7, off the line */
+/* not pruned: current continues past the join with the constant offset 7 */
+__msg("19: R0=map_value({{.*}}imm=7) R1=7")
+__naked void step_prune_miss_const_off_line(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r6 = r0;					\
+	r1 = 0;						\
+	*(u32*)(r10 - 4) = r1;				\
+	r2 = r10;					\
+	r2 += -4;					\
+	r1 = %[step_map] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l_out_%=;			\
+	r7 = r0;					\
+	r1 = r6;					\
+	r1 &= 0xff;					\
+	if r6 > 0 goto l_cur_%=;			\
+	r1 *= 3;			/* old: step 3 */	\
+	goto l_join_%=;					\
+l_cur_%=:						\
+	r1 = 7;				/* cur: const off line */	\
+l_join_%=:						\
+	r0 = r7;					\
+	r0 += r1;			/* r1 forced precise */	\
+	r2 = *(u8 *)(r0 + 0);				\
+l_out_%=:						\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32),
+	  __imm(bpf_map_lookup_elem),
+	  __imm_addr(step_map)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";

-- 
2.55.0
