Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB8D38C2C1
	for <bpf@vger.kernel.org>; Sat, 25 Apr 2026 22:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777157324; cv=none; b=Y2B2JnxKQ0CgW3AmjJGFio/KUFWkRn2QpbYS1h/lb9xqhOUyt7K9QkQ9zJAdOmrRhTGhJTxrk+rpPsR9Qh0+/ni5LygLkANDPj1jxptK/ZO5EOIQen62CI7yn6IfdHrs2CP6jXubh+hYvtg/93tvriop/ZKBo+97X1bVhR78BMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777157324; c=relaxed/simple;
	bh=tisqbBiQOrX5QgMxLy7h82xu6ok2R6VpeMRBHwAntys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HJYYSUAu9NM+r0zd6FUAC2G7J0PNH3OTya3lo+6Kv8ol2hcK4QcWbMLsQqNSIGqGP/6N2IUdcBiU/0kTdnYwVD3UL2IS62MArEe3zqIbVvnTAiiXzHG+guDczye9ZyobKclpV7WtZVly7E6V2h/4cC0KJkh07VJnWzkhb+leKEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gIsTrg8s; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gIsTrg8s"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3590042fa8eso7024487a91.1
        for <bpf@vger.kernel.org>; Sat, 25 Apr 2026 15:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777157322; x=1777762122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U+iE6KdkA5/98x4RutU6UDhzCFUBpekHeO8u7faLOew=;
        b=gIsTrg8sNWZpXTRFC1a0mxE8ClpeFrrsMpNUfEzFwj89BC1jLa4tx3AFpdesg0PEGN
         YoKimAruXVTAzRF6bJ8OXEZtRTgP42Ztt8o3PB4oAdINj1SfU0if66n1Y/2zGQS5Z7Ad
         /Bx5lTHqArcs4a9yPo8yMLSC1+aU0mtEUMlmHTQugs24VhHy96P34R6T8xMv9cPnhm8A
         BN2lt/LXfX85XzzELi7hfCEoQ/V/Q27xKVsvbU2szZJ0CqCaoJnBxCwi/YJfRyFFCSKY
         jgvh9mKnjZ1EqC7+lbJ7DLa01qKD0QyQMyDIeLIESibqT8vHYivkHTNWfLzp2AdmH3wy
         1DvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777157322; x=1777762122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U+iE6KdkA5/98x4RutU6UDhzCFUBpekHeO8u7faLOew=;
        b=bgajWy9UpW+2mcJu0HIRxIVoqaWNCn7wjf5gheN5xbBXd3MqVyVUCwaBui5gH2+n2w
         dLlwz1BCJlh0g81GhsBFX3d3i2FMyYifiibmGZ7/W1sQha+HWVdyAYN1MjXGnUXK3INm
         us0dxbImLS5DIf1mkQsOUuXw4zgL09sE+bCSy2ex1EAyHWXAhsgLskUmKZnasbkqm2Ar
         89SpQ5ZwCG58gBbT9VBX8ssxW67DatiqAAA1cCW06ujqISq8/1oqe4Hx/3ebURfyvLjm
         WO4Sy6KB2caEwtEdJww0nqyo40CJ5dNyK+FVd11kEoanxL748d30x/RATXUTz6/tQMBY
         SqmA==
X-Gm-Message-State: AOJu0Yx9lVQtx0IEU28mNv6aJFHbanaGoxjRHygw5Ue1p0ccaD/oe6iA
	VwydwE+7U0hIevgVrY6K05vS7bCeIbc21qkXTe+u8A5220xBAE5S4644nYgWnRiK
X-Gm-Gg: AeBDietZrmygIaRNtR3fFwOymhj8yd0raQ1kitNCPbED/IrJ+UbPNBcMkjZLePgqVqP
	pj5ebPDh+7e0OwM5TkjEq9Kld2fAkycz9CYihzWW0YW+RgcM9dNEl2cDLDhXKrGW4pKfA723781
	4NXjax28phyHK9JqE7+asmaihJcffQj+zxM4U+Pu7OvHmhNFBdWWAMsHyR7yW5+I3z1G+uo6lMk
	dWwlguUdS2qbGsBudu+mxICwp2zUa8YMnV2ewRHwWOIJ9+G+/vHV8/j1IfJB2keYRqLNa8irk/t
	G86UpPj9kqsKw4vNUkcsTO0iQjn5UMUcJL9HTgZlAHK89vws4q82TU/zGhJHC/Y//0S7cenJqDc
	+RL1j4CAP+01ITq6F75eeWlhp2UIXLyhshnHOJ4YE9j+R6L+YIQBhaW12/z48LQ0j/SqCfZPIly
	yV3Tb/5W92sWqgHu/leI/oYZ6la6ZmArh+fz1388Eqqyjkqm149hFW2tMnplSI/Z3n92LRFgMuc
	/Wl/A==
X-Received: by 2002:a17:90b:3d01:b0:35a:cf:64a6 with SMTP id 98e67ed59e1d1-361404af0a4mr40157845a91.23.1777157321909;
        Sat, 25 Apr 2026 15:48:41 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-361410a7a9fsm27323615a91.12.2026.04.25.15.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 15:48:41 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Subject: [PATCH bpf-next 2/2] selftests/bpf: a test for proper cnums compare in is_state_visited()
Date: Sat, 25 Apr 2026 15:48:24 -0700
Message-ID: <20260425-cnum-range-within-v1-2-2fdca70cb09d@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260425-cnum-range-within-v1-0-2fdca70cb09d@gmail.com>
References: <20260425-cnum-range-within-v1-0-2fdca70cb09d@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Test case demonstrating a bug in cnum comparison logic fixed by
previous commit. A pruning point is reached with r6 in two states:
1. 32-bit range of [0x7FFFFFF0, U32_MAX] ∪ [0, 0x10]
2. 32-bit range of [0x100, 0x200]

At pruning point the buggy is_state_visited() logic would assume that
would assume range (2) to be a subset of (1) and fail to explore the
path performing division by zero.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../testing/selftests/bpf/progs/verifier_bounds.c  | 27 ++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index 5dd243e653c9..a3e4c0945137 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -2267,4 +2267,31 @@ __naked void deduce64_from_32_wrapping_32bit(void)
 	: __clobber_all);
 }
 
+/* Check that range_within() compares cnum ranges, not min/max projections. */
+SEC("socket")
+__failure __msg("div by zero")
+__flag(BPF_F_TEST_STATE_FREQ)
+__naked void range_within_cnum_cross_both_boundaries(void)
+{
+	asm volatile ("							\
+	call %[bpf_get_prandom_u32];					\
+	r1 = 0x80000020;						\
+	if r0 > r1 goto 1f;						\
+	r0 += 0x7FFFFFF0;			/* PATH 1 */		\
+	goto 2f;							\
+1:	call %[bpf_get_prandom_u32];		/* PATH 2 */		\
+	if r0 < 0x100 goto 3f;						\
+	if r0 > 0x200 goto 3f;						\
+2:	/* PATH 1: r0 ∈ [0x7FFFFFF0, U32_MAX] ∪ [0, 0x10] */		\
+	/* PATH 2: r0 ∈ [0x100, 0x200] */				\
+	if r0 != 0x100 goto 3f;	/* True only on PATH 2 */		\
+	r0 /= 0;							\
+3:	exit;								\
+	"
+	:: __imm(bpf_map_lookup_elem),
+	   __imm_addr(map_hash_8b),
+	   __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";

-- 
2.53.0
