Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BD937418C
	for <bpf@vger.kernel.org>; Sat, 13 Jun 2026 11:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781349392; cv=none; b=Gajy6WSG8rAEmJ9wFYHoaUMBipUvq4na/yTdlFD2Ic7sR7MGGB8LdleRLzI+UmCTMjEv5n/xrBiOD9Acpv6Wh1cIjcVk4nJGOVsxSVOHoWhDR0r9lXmP6BeqUs/f4pxGbzx9yWJ4gfBpZkZiksE+pHSpRP9nnuf6MksyM2dZTt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781349392; c=relaxed/simple;
	bh=eu3B+FWKADk7yxyxP1ivxQwb12nb1N5PWjPA92DS8kU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JCP/wfa2jp5IVykEUBesjZejrG75aUtWCxxXaL0o5eX78yKpXlljl9eFIo7XnVxcgfSZqCcNntGGMeY1tPsNBMYjlTUFXny7ifB+R60WE1WOReYdHhC+Ks3UIa41MVON3UusrB8ABZJh8PYsaqBojpwQADOk9s30AeiVOYjHPAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qjdzRubC; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qjdzRubC"
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2c0b944f6edso19271725ad.2
        for <bpf@vger.kernel.org>; Sat, 13 Jun 2026 04:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781349390; x=1781954190; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/dbSOUSYc1LSV+9Gbc8y38h+2MyhDot+YIg0YvLxd2U=;
        b=qjdzRubCNS0WLd3tsFA2YU3SQi+PFGl01T9Oj9OJJCb6ORagr9tttdG+O3DDGeD3rP
         M5emhZOZ2ucilqYh5gMY9wbhryEUL7ifpscLDBO9LTnQ5RFDWzIaJitt5UKGV2T5BU+h
         IVV7ucYNQ8Hx9Va3efYDpQv0BpM78O5FgiO8hysmfmMUM+2KRahmQNkHz7iPbemfr4u5
         5w11+HRT6Jb0G38QXszrg6c3wAHwUeR/uH5WrU9TKpU6c6ne6SUuBgmNQaiPcXN4k8Xn
         AKetLd91h9ccME5ql+Z/S6EpQ6x2Umvq6p7SDk5UerryAGsXVEe6gDOLAw9CEGoQRUFR
         PTcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781349390; x=1781954190;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/dbSOUSYc1LSV+9Gbc8y38h+2MyhDot+YIg0YvLxd2U=;
        b=OTZ+kv0SxI9uwD+iHO80J22fe2GyMeZgUw4w8p/vUMb44lW1uAgFL1oKKlGUL0l9Bw
         Eclkk5WPacWOmDS4/uchPqKfUEs+7/p0proKSTWCESEXlXJrIbrsP5RTafSizwLjpHb0
         aj9j+kS3hf3Cz6F4JzvmCOjDRF++UqtQKalQh98LWv+5D7xHCb/jC5v8w1Bmg+GXurg2
         M5tlqR9BAvQlJYE6vPr4RFe3wsfuDnMFj+5TReIC9PJtuUd69+6ZU27nXThMkMdq9kxz
         fbcF/swPLCKAK+Sfdw1wYjJS1oa2RcUt5Gx3fkKkWLK8O9u0lhOTvY+zUUSgM3LVlOYj
         EBdA==
X-Gm-Message-State: AOJu0Yzagw8jsevygrsD0GYsE+nE9vQxofhI7JZ1wsJLehBX8eQtuVWR
	8eURag2I3/qYRP2VLmUPj6t4VdTaZXDS6yHIf+Rq3RR4F+44n6WS0M7x
X-Gm-Gg: Acq92OGLlFf9CCOWM+rqwbPMj9o8v1JsYAmTrdPAJWUnLd0GI6kcsf1dyob+69Mg9qG
	w56q5VIXr1XEBMdKR3w+Ln0sj/S8uhrdDCABMuI7y43qknDqY3uLCY53jXeQc//UOMSg+G0UGZL
	qV5iV+ZeC8xL7BujvE+s62usE8coZ1Oc44H/amxFBD43V8IpWYpwYhy/9KG4xkZtMQ6s25+9VFY
	+56AaDCY9KLk7LcdxQKerJ+f6M38me5xVoNG5fgV+Jl62svYW78/AOMOPGhGnany9jMBZaX7GM2
	t+TEheI0vqkctjYpVusv1zxd+w70KrXAqv1PIkDTc0npRsuElkI1Cqf0lIPwN9zmRkx6fKXydkM
	vngOOgWUAJyMep+2MYsUzBn800c+lKNxAEYW8JmfzmkEg4EtcE3Ncu/2wI57fhr1fle5fVECE7p
	y6qTdQmlQmaDzSWRW6AXi+ruxnxwey
X-Received: by 2002:a17:903:2f45:b0:2b4:656b:aeb0 with SMTP id d9443c01a7336-2c66429b0c5mr37094675ad.35.1781349390000;
        Sat, 13 Jun 2026 04:16:30 -0700 (PDT)
Received: from [192.168.0.30] ([175.204.13.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c42fbb5b79sm45215975ad.36.2026.06.13.04.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 04:16:29 -0700 (PDT)
From: Woojin Ji <random6.xyz@gmail.com>
Date: Sat, 13 Jun 2026 20:16:19 +0900
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Cover var-offset stack
 reads from zero spills
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260613-bpf-stack-var-off-zero-v1-v2-2-a324af0f00ea@gmail.com>
References: <20260613-bpf-stack-var-off-zero-v1-v2-0-a324af0f00ea@gmail.com>
In-Reply-To: <20260613-bpf-stack-var-off-zero-v1-v2-0-a324af0f00ea@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 John Fastabend <john.fastabend@gmail.com>
Cc: bpf@vger.kernel.org, Woojin Ji <random6.xyz@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4806; i=random6.xyz@gmail.com;
 h=from:subject:message-id; bh=eu3B+FWKADk7yxyxP1ivxQwb12nb1N5PWjPA92DS8kU=;
 b=owEBbQKS/ZANAwAKAUOXRMMVrfhrAcsmYgBqLTwFyl7A5jw/rPk1dNKJJ9GuDg09PBL0+sxBf
 AAl0IyuphyJAjMEAAEKAB0WIQSrknTJbxUcAdPNt5BDl0TDFa34awUCai08BQAKCRBDl0TDFa34
 a+UHEACNig8qrlJ6ZQ0I86fdJPuL8mlqJOeidpuCyG5Lg5EPWVR15t2bc/eLpBVngqqFOnESPb8
 amkCB7YMqOInXQtQwvIUnKId9BRpFHi4SyMeDA5yJ8AZ9rcOEBwooZiGbwvk7ihdkQkPzCjjnHr
 0SmpzyRjW3QG/QVD5PIpSRJo+EfgnVVqTPLw4zjw1I7wGtDYfavCl3KR7C+MNQO42piWfNhPD7D
 LFCMuH+DdmjqmdDojyj6sq/aYBioGzKWIgoOCVlofUeBlzUQxee/EBQFM+GdS9PuQ6oMfQGbX8w
 kNa960Ki2juxvJvZS8BY1P2gCBmtUQSsfRi/nKMIRad8zW/b7oca40wmR7cUsZ+FGOiQm8ARrQY
 3rWhsg/xNgdKS8MJYf/mSTwwI8JlIf6GH8+9Z/mBZwLnO4TDtklBFhfFzQybFoRWbC15i87t806
 aHRTpDEGyg2nj6ypUTDEHcGk/xEnTlV+SeCepHZnVthSzecGYmQOiyrAOJoHTopfsCZLTksd/n4
 5wvPhcVbDJMNLt5gvAJHLv7lQHWuwMT8MFnVsIoHfxGBmGrtwSxZvXchND8enrc6Yikuvf7mwHL
 UHPWr9Ufwm4Z8VBOtybgcY3DyRi9qbotl6LU5nXJ64uOIis40FFsQOQUoeGOHJZl1Hf1/qc35RE
 1pXLuIKQSufFt4Q==
X-Developer-Key: i=random6.xyz@gmail.com; a=openpgp;
 fpr=AB9274C96F151C01D3CDB790439744C315ADF86B

Add verifier_var_off coverage for variable-offset stack reads from
spilled scalar constant zero values.

Cover single-slot and cross-slot spilled zero reads, a sub-8-byte spill
with neighbouring STACK_ZERO bytes, and a sub-8-byte spill with
neighbouring STACK_MISC bytes that must not be treated as zero. Add a
state-pruning negative test to ensure the verifier marks the spilled
zero stack slot precise before using it to derive a const-zero register.

Use verifier log assertions to check both the zero result and the
precision backtracking trail.

Assisted-by: opencode:gpt-5.5
Signed-off-by: Woojin Ji <random6.xyz@gmail.com>
---
 .../testing/selftests/bpf/progs/verifier_var_off.c | 148 +++++++++++++++++++++
 1 file changed, 148 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_var_off.c b/tools/testing/selftests/bpf/progs/verifier_var_off.c
index f345466bc..f0052d831 100644
--- a/tools/testing/selftests/bpf/progs/verifier_var_off.c
+++ b/tools/testing/selftests/bpf/progs/verifier_var_off.c
@@ -59,6 +59,154 @@ __naked void stack_read_priv_vs_unpriv(void)
 "	::: __clobber_all);
 }
 
+SEC("cgroup/skb")
+__description("variable-offset stack read preserves spilled zero")
+__success
+__log_level(2)
+__msg("mark_precise: frame0: regs= stack=-8")
+__msg("R3=0")
+__failure_unpriv __msg_unpriv("R2 variable stack access prohibited for !root")
+__retval(0)
+__naked void stack_read_var_off_preserves_spilled_zero(void)
+{
+	asm volatile ("\
+	r0 = 0;\
+	*(u64*)(r10 - 8) = r0;\
+	r2 = *(u32*)(r1 + 0);\
+	r2 &= 7;\
+	r2 -= 8;\
+	r2 += r10;\
+	r3 = *(u8*)(r2 + 0);\
+	r1 = r10;\
+	r1 += -1;\
+	r1 += r3;\
+	*(u8*)(r1 + 0) = r3;\
+	r0 = 0;\
+	exit;\
+"	::: __clobber_all);
+}
+
+SEC("cgroup/skb")
+__description("variable-offset stack read preserves spilled zero across slots")
+__success
+__log_level(2)
+__msg("mark_precise: frame0: regs= stack=-8,-16")
+__msg("R3=0")
+__failure_unpriv __msg_unpriv("R2 variable stack access prohibited for !root")
+__retval(0)
+__naked void stack_read_var_off_preserves_spilled_zero_across_slots(void)
+{
+	asm volatile ("\
+	r0 = 0;\
+	*(u64*)(r10 - 8) = r0;\
+	*(u64*)(r10 - 16) = r0;\
+	r2 = *(u32*)(r1 + 0);\
+	r2 &= 15;\
+	r2 -= 16;\
+	r2 += r10;\
+	r3 = *(u8*)(r2 + 0);\
+	r1 = r10;\
+	r1 += -1;\
+	r1 += r3;\
+	*(u8*)(r1 + 0) = r3;\
+	r0 = 0;\
+	exit;\
+"	::: __clobber_all);
+}
+
+SEC("cgroup/skb")
+__description("variable-offset stack read preserves partial spilled zero")
+__success
+__log_level(2)
+__msg("mark_precise: frame0: regs= stack=-8")
+__msg("R3=0")
+__failure_unpriv __msg_unpriv("R2 variable stack access prohibited for !root")
+__retval(0)
+__naked void stack_read_var_off_preserves_partial_spilled_zero(void)
+{
+	asm volatile ("\
+	r0 = 0;\
+	*(u8*)(r10 - 9) = r0;\
+	*(u8*)(r10 - 10) = r0;\
+	*(u8*)(r10 - 11) = r0;\
+	*(u8*)(r10 - 12) = r0;\
+	*(u8*)(r10 - 13) = r0;\
+	*(u8*)(r10 - 14) = r0;\
+	*(u8*)(r10 - 15) = r0;\
+	*(u32*)(r10 - 8) = r0;\
+	r2 = *(u32*)(r1 + 0);\
+	r2 &= 15;\
+	if r2 > 10 goto l0_%=;\
+	r2 -= 15;\
+	r2 += r10;\
+	r3 = *(u8*)(r2 + 0);\
+	r1 = r10;\
+	r1 += -1;\
+	r1 += r3;\
+	*(u8*)(r1 + 0) = r3;\
+l0_%=: r0 = 0;\
+	exit;\
+"	::: __clobber_all);
+}
+
+SEC("cgroup/skb")
+__description("variable-offset stack read partial spill with misc data")
+__failure
+__msg("invalid variable-offset write to stack R1")
+__failure_unpriv __msg_unpriv("R2 variable stack access prohibited for !root")
+__naked void stack_read_var_off_partial_spill_with_misc_data(void)
+{
+	asm volatile ("\
+	r0 = 0;\
+	*(u32*)(r10 - 8) = r0;\
+	r2 = *(u32*)(r1 + 0);\
+	r2 &= 7;\
+	r2 -= 8;\
+	r2 += r10;\
+	r3 = *(u8*)(r2 + 0);\
+	r1 = r10;\
+	r1 += -1;\
+	r1 += r3;\
+	*(u8*)(r1 + 0) = 0;\
+	r0 = 0;\
+	exit;\
+"	::: __clobber_all);
+}
+
+SEC("cgroup/skb")
+__description("variable-offset stack read tracks spilled zero precisely")
+__failure
+__flag(BPF_F_TEST_STATE_FREQ)
+__log_level(2)
+__msg("mark_precise: frame0: regs= stack=-8")
+__msg("invalid variable-offset write to stack R1")
+__failure_unpriv __msg_unpriv("R2 variable stack access prohibited for !root")
+__naked void stack_read_var_off_tracks_spilled_zero_precisely(void)
+{
+	asm volatile ("\
+	r6 = *(u32*)(r1 + 0);\
+	r6 &= 1;\
+	r0 = 0;\
+	if r6 != 0 goto l0_%=;\
+	*(u64*)(r10 - 8) = r0;\
+	goto l1_%=;\
+l0_%=: r0 = 1;\
+	*(u64*)(r10 - 8) = r0;\
+l1_%=: r0 = 0;\
+	r2 = *(u32*)(r1 + 4);\
+	r2 &= 7;\
+	r2 -= 8;\
+	r2 += r10;\
+	r3 = *(u8*)(r2 + 0);\
+	r1 = r10;\
+	r1 += -1;\
+	r1 += r3;\
+	*(u8*)(r1 + 0) = 0;\
+	r0 = 0;\
+	exit;\
+"	::: __clobber_all);
+}
+
 SEC("cgroup/skb")
 __description("variable-offset stack read, uninitialized")
 __success

-- 
2.54.0

