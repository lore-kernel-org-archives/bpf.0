Received: from mail-oi1-f194.google.com (mail-oi1-f194.google.com [209.85.167.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDF628A1E6
	for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 11:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773746346; cv=none; b=k85GQiFTnkh5SohMZM/jbWlZ+L7Is1Kmn6R4POTLLcmaHsfGBdogqkaggHrquLjTf1wpUh/vTMN90XwTz2mUprUIgnWgCOub1btPno4lNG2aff4tI0wHX1q/a3iUmP2bVLzk/cETzInP14XIc8st7RTp6pAwR6NYvdiZThzC2uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773746346; c=relaxed/simple;
	bh=xMU+jRWr1qQYwGaXBcSqzxc6rNeNL978Dgd8RrkBUu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hXL/xZA4RZreVv5AXfnERd0Gk9WLrUUTvfqh9mBdLVavJScnSzvZIvAgk4pbp73yklL4adYbg5Ntpbql61/8U+amKRQVZ8cmMjbfWln9sc2/TVY7nisOIvCmgPjXvpVfvgmB/P4Gy9vSAdWMHdtuM1LElgSuwcrsa/zDrwDX2NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ly2PTYmX; arc=none smtp.client-ip=209.85.167.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ly2PTYmX"
Received: by mail-oi1-f194.google.com with SMTP id 5614622812f47-4672076355aso3843981b6e.2
        for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 04:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773746342; x=1774351142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mvd5QCxyCh6u9LHKIxevGalYBNiEErr3yJuXaYmWUF8=;
        b=ly2PTYmXeS45wd1zE4BrQvuxtQgblb/a4tQMJzS/29QkcLltKITLUXN+aiTQ1Q6NCz
         ODMglBEc+5cMkvtv23U/q7bKIKiFPU5lOoGAfbGNOXHQRUyLTl5pwU/5bV21uVM+W2Gk
         DgGjdg/OqSAhWof0Yjm7PqL9pAXpnnNsM8g36uWY3/9CXvg0S9CebTnQppsBTKA2ACTe
         FOM3EF2ZzrS6z3W4N3DQsTKKHKb3TT5w+iRdkFdkoisygLz35sKxrbzLaCENMzUNRhxM
         UCGi3x9ZZ1eqLWb8hJ/bY6wU+Q5l6aJyYxyM8jIzLEfHj1KNxs4eVLun+somvDBP02FG
         ur0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773746342; x=1774351142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Mvd5QCxyCh6u9LHKIxevGalYBNiEErr3yJuXaYmWUF8=;
        b=PCKNMWTdTGGD5BgQ7FkW0ACXIykd44Y5KQsxUN0eKGuUPjzUvm9OsAXkleANt/50uK
         Qw9X6/SdpoxRWfJZm0RirY3VzxLCjftpcq8rnFRYebbruW0UPl2o/k+Lc9NIQ+MvHKrc
         7ucUrHbDkk6KsMwydvXpVNbmvAfqcRuRgT8JEckAyAYgIzwaHj1onnDVeWpmJMbGWTRp
         UE8w4/WcQ1tXhQ2l4fuDWdfn6/v8tVw0w1qpu+WTfu9uOfVjwAhNrSFAgJnF2ZnH5QPY
         lPsiAUa/QjxadeQXe2fmb56ri8SG9sdpsubkX+neXQjsa2rQj+CsnSOp3JRC2WofHbcC
         3EWQ==
X-Gm-Message-State: AOJu0YyeAfM19VbYOAFKflTd/B7jfAobizEJhMM9OYa/0Qv3xhN2Q/xk
	Mka/dqf82ELDk4dmk1kmChAZ3KFE/SxT53Xj7uSJtPKsJmmYnlu+lhYEXJPxUVEa
X-Gm-Gg: ATEYQzzKCuOhII1DsFTqkbwgyRzDcUkDJTh5IYBCoYV5sV5FAVpcNiZ9JT7Ff9/I9lt
	2LbByBxYIdHkhNWCAI6yZyZDOy1N0ZvVJm0IvWdkAGMjhqwrO/V9RoM4828lgXs2qJisxwTLo9N
	9ASkDIXXKif7YL21sNnB7iKwIbC5Z+qV8gz2Xl3mTmZ6fAElDGVhpzEYLue6QjE3V59RN3vOBpG
	jM/aLxVd7AgD8cI2RGx8R0rTqUyR1I5EiP/MldQXluV9uDDXssubhxYssbXDfHq6CFWrqAgKAcZ
	BEQM6eKgJKTCvztJlhDKYOLXaRTVFHveYETNsztjrQOo9SgD6Ua1ybDu7hJPO8FuY3ml8v5qZmq
	IOginHutzbAKf1l/o8W+tDT9wOwROjXG5RUiFAYjoBQ5U4hEz2pUlpCmKkYfvxv5dByEBA53eDB
	zfmT83lsGefnpa+hMxCqOCiKd9Qu3jy4l93va7F4FyG0ez
X-Received: by 2002:a05:6820:490a:b0:67b:a5ef:825c with SMTP id 006d021491bc7-67bda98fd44mr8201761eaf.15.1773746342294;
        Tue, 17 Mar 2026 04:19:02 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:74::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67bc91174fbsm10954607eaf.4.2026.03.17.04.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 04:19:00 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Dan Schatzberg <dschatzberg@meta.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 4/4] selftests/bpf: Test modified syscall ctx for global subprog
Date: Tue, 17 Mar 2026 04:18:49 -0700
Message-ID: <20260317111850.2107846-5-memxor@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260317111850.2107846-1-memxor@gmail.com>
References: <20260317111850.2107846-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1913; h=from:subject; bh=xMU+jRWr1qQYwGaXBcSqzxc6rNeNL978Dgd8RrkBUu8=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBpuTHjoFrAySbjqZ6cgfv+p0aa9gORoNyuxA0+NiFs Q6OjwJuJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCabkx4wAKCRBM4MiGSL8RylfzD/ 4qLPrej350aB21DPGHcws0VAB8K7D9xJz2NFDQUpvhmYbffTG7jF0lDYCiUAq9MF/jFSgOSY37v2B3 FnzV5yDwju4WefZJJ9lLvMsNaV5ak1NKwO0B/rzbSqxFBi8V1GCdYJUjjZIYlXYrwdcNdb0Rzlb6FW oWqfNsHApx12o4V9Mw5HD2iJTJT3M+XVM0/fIfnAMZSpu5qZctkLW7E0k/DdSd1Sf/+Zq8WPORowy/ LmNzjfohCr7vvdgY2GKH49qQxoDiskfY3y0uA6EATCVGKA3v/wglkkA2fdDvfTJwa70IXds2Z0ERdi 8oT6SYwEsqSR1t6pBSWT9NbdL93Pe0PeAdYvHOuBckZecL8lJGmbnbPA74/T26u2BQR4i5SwuXJHTg o32TQqLibmVkHacJS0jLG5l93CMuS5u2JY0hi9xZ3f10FqEjJbJ3yFB+UYiv7xK2UjLGp/NbBIXxxu fNbgFc80JyV69zYOvVGvtt5UvQx68ppQ9BPKELzEVz6/gToiMyX8WIrR1YPx8PI6MVAXLhRlAJD13I y2dBuJB/Zq5UFX8FzzaPuJw56oZLKj9VhFAxgnwogr5dOFx1cob6CVgHg3gztGE3gs70F96fFqJqUR aM86wnDny5SUcn4L5s/D+s6td/m+S7vIgkc4AGDjJtVv5dMQpOxM1tCWAuEA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Ensure that global subprogs can only accept an unmodified PTR_TO_CTX for
syscall programs. For all other program types, fixed or variable offsets
on PTR_TO_CTX is rejected when passed into an argument of any call
instruction type, through the unified logic of check_func_arg_reg_off.

Finally, add a positive example of a case that should succeed with all
our previous changes.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../bpf/progs/verifier_global_subprogs.c      | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
index 2250fc31574d..0c14adaddb90 100644
--- a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
+++ b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
@@ -357,6 +357,48 @@ int arg_tag_ctx_syscall(void *ctx)
 	return tracing_subprog_void(ctx) + tracing_subprog_u64(ctx) + tp_whatever(ctx);
 }
 
+__weak int syscall_array_bpf_for(void *ctx __arg_ctx)
+{
+	int *arr = ctx;
+	int i;
+
+	bpf_for(i, 0, 100)
+		arr[i] *= i;
+
+	return 0;
+}
+
+SEC("?syscall")
+__success __log_level(2)
+int arg_tag_ctx_syscall_bpf_for(void *ctx)
+{
+	return syscall_array_bpf_for(ctx);
+}
+
+SEC("?syscall")
+__failure __log_level(2)
+__msg("arg#0 of syscall prog must have zero offset")
+int arg_tag_ctx_syscall_fixed_off_bad(void *ctx)
+{
+	char *p = ctx;
+
+	p += 8;
+	return subprog_ctx_tag(p);
+}
+
+SEC("?syscall")
+__failure __log_level(2)
+__msg("arg#0 of syscall prog must have zero offset")
+int arg_tag_ctx_syscall_var_off_bad(void *ctx)
+{
+	__u64 off = bpf_get_prandom_u32();
+	char *p = ctx;
+
+	off &= 4;
+	p += off;
+	return subprog_ctx_tag(p);
+}
+
 __weak int subprog_dynptr(struct bpf_dynptr *dptr)
 {
 	long *d, t, buf[1] = {};
-- 
2.52.0

