Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A093009F2
	for <bpf@vger.kernel.org>; Thu,  2 Jul 2026 02:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782959113; cv=none; b=iGs1k/A4f3HCYXEnHSI9yb3EjIJdniVY2/z8unOvB69I0jQdu+1HFRacSh7adIgqwaOjvUrd9jmCZe6Q379i+qztGViV37WNAAfaJVsr9gT/F/Ov3BQznotr8PFZpbgrjaIieQhitYJ5X2bBjf8Bfw+Ns+6Efi5b6icExWwG2YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782959113; c=relaxed/simple;
	bh=/1uI0PINc3JAPZ3jgxtMPxNgd3W4a0i+Eg0weuYEt9Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S3OUHpRGlu2NJ1NL9r3RoOoY2krC9Of5JhdP5fS+bCcEvgxhDcwtrQuqwBrJJyHi2oGGxKXO4rJfgxD5s8fO7vNRolRPPRBusn7IU59IEGCa6Ll3tQ8sDJ582e7Hx25iX/spUCWPH/pq+8Q2wlEVG4pAZSNZoFJqyqRQ/GoNvFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uu0es29L; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uu0es29L"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782959110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2z5u1ZhZaI359hc2wfdkg8LPj2X4q4oVjTNlw+7cREc=;
	b=uu0es29LMd/p6+MjeB2c8IiDd88nldql6FDPeomqsr6uLHAsGsjMXcUmWf4W0ErFBhPAEN
	kqocuNGh4zw/U0L7IwU5SGd4ctcb+AW6IfATXcNKFEuNqu9Zs0WbZl8z+OVR70azHGnV64
	eFZ0NN5LG5JZdCPmYE9dmiU7IJENJ4k=
From: George Guo <dongtai.guo@linux.dev>
To: Huacai Chen <chenhuacai@kernel.org>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Hengqi Chen <hengqi.chen@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	George Guo <guodongtai@kylinos.cn>,
	bpf@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 09/11] selftests/bpf: Enable arena LDSX tests on LoongArch
Date: Thu,  2 Jul 2026 10:23:20 +0800
Message-Id: <20260702022322.51033-10-dongtai.guo@linux.dev>
In-Reply-To: <20260702022322.51033-1-dongtai.guo@linux.dev>
References: <20260702022322.51033-1-dongtai.guo@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: George Guo <guodongtai@kylinos.cn>

The verifier test_loader only runs an __arch_*-tagged test when the tag
matches the running architecture.  The arena sign-extending load (LDSX)
subtests in verifier_ldsx are tagged for x86_64 and arm64 only, so they
are skipped on LoongArch even though the JIT now supports the
instruction.

Tag the arena LDSX subtests (disasm, exception, S8, S16, S32) with
__arch_loongarch, and add the expected LoongArch JIT disassembly to the
disasm subtest, so they run and are checked there.

Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 .../testing/selftests/bpf/progs/verifier_ldsx.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_ldsx.c b/tools/testing/selftests/bpf/progs/verifier_ldsx.c
index 41340877dc9d..55039dde3dc5 100644
--- a/tools/testing/selftests/bpf/progs/verifier_ldsx.c
+++ b/tools/testing/selftests/bpf/progs/verifier_ldsx.c
@@ -286,6 +286,19 @@ __jited("add	x11, x0, x28")
 __jited("ldrsh	x22, [x11, #0x18]")
 __jited("add	x11, x0, x28")
 __jited("ldrsb	x22, [x11, #0x20]")
+__arch_loongarch
+__jited("add.d	$t2, $a5, $s6")
+__jited("ld.w	$s2, $t2, 16")
+__jited("add.d	$t2, $a5, $s6")
+__jited("ld.h	$s2, $t2, 24")
+__jited("add.d	$t2, $a5, $s6")
+__jited("ld.b	$s2, $t2, 32")
+__jited("add.d	$t2, $a0, $s6")
+__jited("ld.w	$s3, $t2, 16")
+__jited("add.d	$t2, $a0, $s6")
+__jited("ld.h	$s3, $t2, 24")
+__jited("add.d	$t2, $a0, $s6")
+__jited("ld.b	$s3, $t2, 32")
 __naked void arena_ldsx_disasm(void *ctx)
 {
 	asm volatile (
@@ -317,6 +330,7 @@ __description("Arena LDSX Exception")
 __success __retval(0)
 __arch_x86_64
 __arch_arm64
+__arch_loongarch
 __naked void arena_ldsx_exception(void *ctx)
 {
 	asm volatile (
@@ -338,6 +352,7 @@ __description("Arena LDSX, S8")
 __success __retval(-1)
 __arch_x86_64
 __arch_arm64
+__arch_loongarch
 __naked void arena_ldsx_s8(void *ctx)
 {
 	asm volatile (
@@ -369,6 +384,7 @@ __description("Arena LDSX, S16")
 __success __retval(-1)
 __arch_x86_64
 __arch_arm64
+__arch_loongarch
 __naked void arena_ldsx_s16(void *ctx)
 {
 	asm volatile (
@@ -400,6 +416,7 @@ __description("Arena LDSX, S32")
 __success __retval(-1)
 __arch_x86_64
 __arch_arm64
+__arch_loongarch
 __naked void arena_ldsx_s32(void *ctx)
 {
 	asm volatile (
-- 
2.25.1

