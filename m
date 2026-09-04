Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC473B3891
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 19:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788551508; cv=none; b=E/nAJ3vNPeMupr+p6pRDjoSbcEjBXhZ3jljj8alxCfvWaafGbmgtANfKBQJ23f1181doRd1tTL9RNF3JQSGHgXT1AyYL0spusDQJlkXewBwlFZrdPA+qMmQRCX0ug6fTSSWqyRzeGRrGI0ECvaxOlM+h2urLDWgdr/Wi6stW/cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788551508; c=relaxed/simple;
	bh=WtpKffk3cusl9Qtu7bcBmG20buJHAHab36M3KdSl+vA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E/H/EoQ+jWMGehFHNfiztUkmpLwMGVg6J3NiOvE2ONEEJ/GNBBaC/rbaNEddXmwX/E6KfMdsnH0f/jdkh64YoDcL2o/Soc6fPD4MSnlUECj9oOlkGEKoQvG5GXBpF5TUsKREUCP+6YLmkQu6L2gTz50rzSUN9m2OAfYNq7rsD9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aPeUyygg; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPeUyygg"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8485b358552so1220582b3a.2
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 12:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788551502; x=1789156302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DQCTqvUlSwcygaUD7WF/GhyApu6o4em2Qqn+xndUeoE=;
        b=aPeUyygg9NMw7KGknp/o3qWN1vdM6PedAEuTS4r0IyO37qSn1AuYGSzbqxMVXLSlPr
         7RlkMNd39h43pDBoNTJQpctNDbEg4PM8IOw+uFdqupKcUdUbvKZt1ksDuK2XTSmI9kS/
         Uhd5O/VPPytxGkoezGTj7D0pfCUZJmJkaumMo1MRPpYCIerBXIHiZl6KW5ygFoQpMUZM
         1HH9tc64NpcxMOrib6kGDWWhDVPt3x5fjnv8aUppkghd5xYThJZZhCynshPP8DVmaZeN
         pNBF/n9mfeWkcwQfBmdSldyfaDVOjt/W2/scBlo1ZS5Iz+RB+GZPHkroAhmzc7cbwdfS
         PGSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788551502; x=1789156302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DQCTqvUlSwcygaUD7WF/GhyApu6o4em2Qqn+xndUeoE=;
        b=Kcpp3JtTfQ4cEssWSRiTVsBrBUOQh4tFnve9K3IHsnHKiYjAHmZ01WNkyGoA2OevA+
         wM6MgIhb63g3Bj/jcTp9NgrcWqosuJN2Sid3VKtJWoAkJYMKsucj/roO+ElogzratOQR
         pw8E5p4z3Efm0jOqxS47xDyQx0i0O2VhHEoojDVtJpXVGJ2PpSuWU4cBM0B1MNZkQ86s
         z9oUhpW12oNGsB8rRBiaQZe2PyyIpvbzn/InxYGGc+2H8Nej1b3axa3cDK96Uz3nhoFE
         ZtBmSu3gbP4gWLFkysxGVeJEeUZrGenfCogUU3ucKGryG9+7xCXtClYAfzv6mKUp8IaZ
         pdlQ==
X-Gm-Message-State: AFuF++krq36NwJOSyRcRPg+AFK6zSf17cz04Z/uWRgykMTnZq+CsSKmY
	n2SzeSgXBgZuyEQK7U9vWMoo/GhJHfJZtxV3oV6G2qvvNNsoAuIxuQWTUTtGcw==
X-Gm-Gg: AYBFou160yC7XAxPjNfoOx3bkMshOx4kppqIlyYVYVkHCyBpwTxKvX6tcsI6N7btrH0
	vTQ8oC3HAnhCWwRRSyYawh+rDZ4r6/+gxg+8fHA37o0swAhMvKOWPI22vY5atbSaTMyBhk2YF3Q
	oXjbK1RbmhQKElsE5kwfAHtGTBAwdt3R4O889CNROZ5jt+vZKXPxumlt4X1EzyzhIc0MKEZnPzk
	1TFVu9XexWLH2HP/wjVHUv5IntfJh4JA2soorRhkiqa0qyVg9bvOUKB4ONtBZvQyPDLbKcsHXxV
	iXU/iGPA/Dnbx9jufOfR+r8CpPGmJ3XNPE1siql2SxQpiad26VEbUWzbIvp+ag1KZw7sYgJwfRT
	ewtyJ3VS17DUZhz/G0TSEYV6tm7w1Yo2mJRw2YOwHC+jFuYXA5hvNdPHC0AG7J2jZTAZUgxwxLg
	r7EahZiPxelJEyhVo/3etKBVu9sRvkoMziW8H+qgPFGqlDCuxCiec8GUAbOz6U8+aPtMfQhtR8X
	inALcCqGyNHGIt8oaesAIeEWwgv//E73h0dnCcE99yi9lQm4+tWteZNi9igAlPLoXyR9w/QpA6X
	vYcxrprjVHolvuW7BrUWgY4QInjPQrRcd6oE4n7pO20wXYNp+80FTqIJsbtc9YcxYmO7tZfqCv0
	=
X-Received: by 2002:a05:6a00:ac8a:b0:857:726d:2e9c with SMTP id d2e1a72fcca58-8616b560a78mr11539240b3a.25.1788551502338;
        Fri, 04 Sep 2026 12:51:42 -0700 (PDT)
Received: from sid-dev-env.cgrhrlrrq2nuffriizdlnb1x4b.xx.internal.cloudapp.net ([4.155.54.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8615404876fsm1497684b3a.59.2026.09.04.12.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 12:51:41 -0700 (PDT)
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
To: bpf@vger.kernel.org
Cc: Siddharth Chintamaneni <sidchintamaneni@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	rlmenge@gmail.com,
	hargar@linux.microsoft.com,
	apais@microsoft.com
Subject: [PATCH bpf-next v1 7/7] selftests/bpf: Test timed may_goto with private stacks
Date: Fri,  4 Sep 2026 19:51:32 +0000
Message-ID: <20260904195132.141068-8-sidchintamaneni@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260904195132.141068-1-sidchintamaneni@gmail.com>
References: <20260904195132.141068-1-sidchintamaneni@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add private_stack_timed_may_goto() with enough stack usage to select a
private stack. Check that the JIT uses the private-stack frame pointer
when constructing the pointer passed to the architecture trampoline.

Update the translated instruction expectations in may_goto_batch_2(),
may_goto_interaction_x86_64(), and may_goto_interaction() for the
additional pointer construction instruction and adjusted branch offsets.

Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
---
 .../bpf/progs/verifier_bpf_fastcall.c         | 30 ++++++++++---------
 .../selftests/bpf/progs/verifier_may_goto_1.c | 17 ++++++-----
 .../bpf/progs/verifier_private_stack.c        | 19 ++++++++++++
 3 files changed, 44 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c b/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
index 328cf630210a..c5996d9dc8cc 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
@@ -635,15 +635,16 @@ __xlated("4: r0 = &(void __percpu *)(r0)")
 __xlated("...")
 /* may_goto expansion starts */
 __xlated("6: r12 = *(u64 *)(r10 -24)")
-__xlated("7: if r12 == 0x0 goto pc+6")
+__xlated("7: if r12 == 0x0 goto pc+7")
 __xlated("8: r12 -= 1")
-__xlated("9: if r12 != 0x0 goto pc+2")
-__xlated("10: r12 = -24")
-__xlated("11: call unknown")
-__xlated("12: *(u64 *)(r10 -24) = r12")
+__xlated("9: if r12 != 0x0 goto pc+3")
+__xlated("10: r12 = r10")
+__xlated("11: r12 += -24")
+__xlated("12: call unknown")
+__xlated("13: *(u64 *)(r10 -24) = r12")
 /* may_goto expansion ends */
-__xlated("13: *(u64 *)(r10 -8) = r1")
-__xlated("14: exit")
+__xlated("14: *(u64 *)(r10 -8) = r1")
+__xlated("15: exit")
 __success
 __naked void may_goto_interaction_x86_64(void)
 {
@@ -676,15 +677,16 @@ __xlated("2: r1 = 1")
 __xlated("3: call bpf_get_smp_processor_id")
 /* may_goto expansion starts */
 __xlated("4: r12 = *(u64 *)(r10 -24)")
-__xlated("5: if r12 == 0x0 goto pc+6")
+__xlated("5: if r12 == 0x0 goto pc+7")
 __xlated("6: r12 -= 1")
-__xlated("7: if r12 != 0x0 goto pc+2")
-__xlated("8: r12 = -24")
-__xlated("9: call unknown")
-__xlated("10: *(u64 *)(r10 -24) = r12")
+__xlated("7: if r12 != 0x0 goto pc+3")
+__xlated("8: r12 = r10")
+__xlated("9: r12 += -24")
+__xlated("10: call unknown")
+__xlated("11: *(u64 *)(r10 -24) = r12")
 /* may_goto expansion ends */
-__xlated("11: *(u64 *)(r10 -8) = r1")
-__xlated("12: exit")
+__xlated("12: *(u64 *)(r10 -8) = r1")
+__xlated("13: exit")
 __success
 __naked void may_goto_interaction(void)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c b/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c
index db7e30da234f..1721897160dc 100644
--- a/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c
+++ b/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c
@@ -90,15 +90,16 @@ __arch_loongarch
 __xlated("0: *(u64 *)(r10 -16) = 65535")
 __xlated("1: *(u64 *)(r10 -8) = 0")
 __xlated("2: r12 = *(u64 *)(r10 -16)")
-__xlated("3: if r12 == 0x0 goto pc+6")
+__xlated("3: if r12 == 0x0 goto pc+7")
 __xlated("4: r12 -= 1")
-__xlated("5: if r12 != 0x0 goto pc+2")
-__xlated("6: r12 = -16")
-__xlated("7: call unknown")
-__xlated("8: *(u64 *)(r10 -16) = r12")
-__xlated("9: r0 = 1")
-__xlated("10: r0 = 2")
-__xlated("11: exit")
+__xlated("5: if r12 != 0x0 goto pc+3")
+__xlated("6: r12 = r10")
+__xlated("7: r12 += -16")
+__xlated("8: call unknown")
+__xlated("9: *(u64 *)(r10 -16) = r12")
+__xlated("10: r0 = 1")
+__xlated("11: r0 = 2")
+__xlated("12: exit")
 __success
 __naked void may_goto_batch_2(void)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_private_stack.c b/tools/testing/selftests/bpf/progs/verifier_private_stack.c
index 3d9994a52464..639b53363c9a 100644
--- a/tools/testing/selftests/bpf/progs/verifier_private_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_private_stack.c
@@ -70,6 +70,25 @@ __naked void no_private_stack_nested(void)
 "	::: __clobber_all);
 }
 
+SEC("fentry/bpf_fentry_test9")
+__description("Private stack, timed may_goto")
+__success __retval(0)
+__arch_x86_64
+__jited("	movabsq	$0x{{.*}}, %r9")
+__jited("...")
+__jited("	movq	%r9, %r10")
+__arch_arm64
+__jited("	mov	x9, x25")
+int private_stack_timed_may_goto(void)
+{
+	volatile __u64 stack_space[16] = {};
+
+	while (can_loop)
+		;
+
+	return stack_space[0];
+}
+
 __used
 __naked static void cumulative_stack_depth_subprog(void)
 {
-- 
2.43.0

