Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B831F5EA
	for <bpf@vger.kernel.org>; Sat, 14 Mar 2026 02:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773454534; cv=none; b=sIwWgjUMlLxEbb70I9v8HTZECGPO17l41rMsgf6KRzGo6eH7k0ftQgJOqRzAzElcShYZQUj1oTFrBDkXK2pCjM6VCSAkZd58FiHAev+ftasLM/KsQAJ3vVHgq794m1wXWN9UxUx9u3h7atrgYiLLMi/QOfaEKX0uLIAJzz4lwZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773454534; c=relaxed/simple;
	bh=jYwGpNiYiCE/9nEXbY5VfJIINt0H1QWNggxGxDjJ3ww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O+9gzYe0qCCBORid4a1yqoEAIxaZ9PGd9O1ZXKVOZ8qz17xSMHVP6lBpewZ84cTWmMd/ohMODAFXC3jdxaVPAx+dlifzEgRliU3sYAG+BjN8UHocFxik7iEcL3uI1+ghOMWQi13X6XZQitMxcGw1ixMcpCauFt71mziESwoZxpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EFSxvuZA; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EFSxvuZA"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c70f91776fcso1194451a12.0
        for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 19:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773454532; x=1774059332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nzqp7Zv9Oh2AN/hjLVnU+QXpZxAjV2vKbrJiSpiOKrg=;
        b=EFSxvuZAG/yGLDOcxlDI9HDl8HOlh3rq/OzuL6kIgqJSPyG+kWB1P/pCLErKSE+f68
         Bo5kypdj0THY60Sv6M7bGmTn/wba1ywTmqx5j2MCc2L7+xonltEQ23/fypNiRdpAEgLO
         HKRCgYPhStKvQoBVY5s/BFiLpqP5NJHXLu2Ax4JktbqIyNbtLri2UbAzLqreTogEbAWn
         puLh9sqpYI5UQy6QzdVdfMb12a8PAjNCJRYel2sby6CNCr6VGTaU3M4YoKq/16hk01Z/
         eNo3SjvqXQkRVDahNq8B6xmxGRTVNWvQjnVM/xb6LVCviXdWhuPCczN5O8Y1tVAod0KM
         mNCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773454532; x=1774059332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Nzqp7Zv9Oh2AN/hjLVnU+QXpZxAjV2vKbrJiSpiOKrg=;
        b=XUUPTOqz34eIips9O9IiKx8s70BAikIb/c99+SxVRxF0flud/4z/dbz7JBekzWIbTS
         tlyawIP+i+ULMCk9JrlvXJ2b1sJLfdEz7n/YKzAyzjHb13oRzuy5K8O7r4p8YxuNXFeX
         nTitnKgMwtWccL5m5h1ai+VDyA/JhRSl+e7qoDr6onDC5cnOmn++l24U+Tf74r3MwNSq
         hVrfj4vFk5UwtU2rTlghMBoTdD4JZ7ONnM2u7t1lVlvedzT2YDkYyOplZejzwSYooI30
         5fZ0sllC7FsY/wVPis7xD6gS/d/a4g9bVENFFWplxmlJEZ7KrWjqjk77upTUeqbP/7s9
         5dnA==
X-Gm-Message-State: AOJu0YzlOHEuHXr+LDqKAb6oOtDehScPJhGR4dGtAGbf4RdaMIiD4Xwh
	wzat2NthPWt2gZp6dm20+8U3Cbfif9jisd0f9VcTqeXcv4CvhzUw59g1uPQiv/PpJR8=
X-Gm-Gg: ATEYQzwC307YLaXHx1QvpjnYb6FjcIy0mQpZGPPdcde0USR25e+d659uR7hbuRH6hVp
	mGH6tdhq07giykcSvB+XDYFpK4Uqs9LsJP3wNkkwCwDGfgQ3CRfQ1HEo6re7M8b10+5X/bBtys4
	szgS56rcy7Ih0Rcy/Ag1m/rtV7E7ht1ni6VLJohgGUR5+d4V6AHIKiFyxGKmk1/KFxvrVpL+bLm
	K00V6j5phxSobgymDHGu+8f1Oiw08IpCzygwWoWZcyfkIKMd/VK4EI0YGlg8bs5FBO/kbUWNilh
	n7HYwEhIx0KjXpXxmNeCNEXnk+1rW5vh5Ux/4Jle+dnFRtjyOPbT8bChhPCvUgzpHz+STKfkxeZ
	Bpebcr7tGlFvOQkoh2KzJXy3DQU5IV6dZ+AwszCLP2YaYxkjvgmTRat8NZO/6wohRmskLCW4gop
	iEI/4OZisBa8XtmE4AKVgXCHwBmiwLbmRhIbKwIMpP+/70mKoW0R2pzc8/nitJVyOazswFbVTiV
	evsOKvxa2/9AmlYcX0w
X-Received: by 2002:a17:903:1b63:b0:2ae:8077:b1c1 with SMTP id d9443c01a7336-2aecaaf4bc3mr51337345ad.30.1773454532507;
        Fri, 13 Mar 2026 19:15:32 -0700 (PDT)
Received: from kali-VMware-Virtual-Platform.. ([185.218.127.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece627683sm33450305ad.32.2026.03.13.19.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 19:15:31 -0700 (PDT)
From: Daniel Wade <danjwade95@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	eddyz87@gmail.com,
	ameryhung@gmail.com,
	ast@kernel.org,
	danjwade95@gmail.com
Subject: [PATCH bpf v4 2/2] selftests/bpf: Add tests for maybe_fork_scalars() OR vs AND handling
Date: Sat, 14 Mar 2026 13:15:21 +1100
Message-ID: <20260314021521.128361-3-danjwade95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260314021521.128361-1-danjwade95@gmail.com>
References: <20260314021521.128361-1-danjwade95@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add three test cases to verifier_bounds.c to verify that
maybe_fork_scalars() correctly tracks register values for BPF_OR
operations with constant source operands:

1. or_scalar_fork_rejects_oob: After ARSH 63 + OR 8, the pushed
   path should have dst = 8. With value_size = 8, accessing
   map_value + 8 is out of bounds and must be rejected.

2. and_scalar_fork_still_works: Regression test ensuring AND
   forking continues to work. ARSH 63 + AND 4 produces pushed
   dst = 0 and current dst = 4, both within value_size = 8.

3. or_scalar_fork_allows_inbounds: After ARSH 63 + OR 4, the
   pushed path has dst = 4, which is within value_size = 8
   and should be accepted.

These tests exercise the fix in the previous patch, which makes the
pushed path re-execute the ALU instruction so it computes the correct
result for BPF_OR.

Signed-off-by: Daniel Wade <danjwade95@gmail.com>
Reviewed-by: Amery Hung <ameryhung@gmail.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/progs/verifier_bounds.c     | 94 +++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index a0bb7fb40e..d8fe6f98e7 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -1200,4 +1200,98 @@ l0_%=:	r0 = 0;						\
 	: __clobber_all);
 }
 
+SEC("socket")
+__description("maybe_fork_scalars: OR with constant rejects OOB")
+__failure __msg("invalid access to map value")
+__naked void or_scalar_fork_rejects_oob(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r9 = r0;					\
+	r6 = *(u64*)(r9 + 0);				\
+	r6 s>>= 63;					\
+	r6 |= 8;					\
+	/* r6 is -1 (current) or 8 (pushed) */		\
+	if r6 s< 0 goto l0_%=;				\
+	/* pushed path: r6 = 8, OOB for value_size=8 */	\
+	r9 += r6;					\
+	r0 = *(u8*)(r9 + 0);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("maybe_fork_scalars: AND with constant still works")
+__success __retval(0)
+__naked void and_scalar_fork_still_works(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r9 = r0;					\
+	r6 = *(u64*)(r9 + 0);				\
+	r6 s>>= 63;					\
+	r6 &= 4;					\
+	/*						\
+	 * r6 is 0 (pushed, 0&4==0) or 4 (current)	\
+	 * both within value_size=8			\
+	 */						\
+	if r6 s< 0 goto l0_%=;				\
+	r9 += r6;					\
+	r0 = *(u8*)(r9 + 0);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("maybe_fork_scalars: OR with constant allows in-bounds")
+__success __retval(0)
+__naked void or_scalar_fork_allows_inbounds(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r9 = r0;					\
+	r6 = *(u64*)(r9 + 0);				\
+	r6 s>>= 63;					\
+	r6 |= 4;					\
+	/*						\
+	 * r6 is -1 (current) or 4 (pushed)		\
+	 * pushed path: r6 = 4, within value_size=8	\
+	 */						\
+	if r6 s< 0 goto l0_%=;				\
+	r9 += r6;					\
+	r0 = *(u8*)(r9 + 0);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0

