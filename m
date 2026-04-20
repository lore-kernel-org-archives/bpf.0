Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6371F32FA2E
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 15:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776699409; cv=none; b=OmRLyOcqbE8PhDeGidnNcDLRNV5s9M4FhB5MEGx3HSLTVcpfMVE6LDELeOwgSLn+QK6KGQA25HeILWKiayc4OBpyJNXYi0Egs1ie5azEyNCTcO6bMO4ryG2z82bJmFHRl8Gcbgma1FwTW7dB9/wA+kqtyony7lZvWiD5KhtOGeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776699409; c=relaxed/simple;
	bh=2UdaTs8H+StiygTWAEoCtUbaDZEZALTnFheiNtDzAo0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bRfj9MQl6rXVSKNVl9OceZ3IivVNRKCQffkypNN7JjxPzDV/LTvYgqbqJto4ScK9c+R5yxmcsB8hBkZpnlBiPgiMA1ruNZPwurwvDyQ7GPk2PQrzprqBbLh6HgmQcTWIeqMKdbV8ZL8OX/UKtID+ocStHLO5gb08L+9tpZmUlOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jpzs03vW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jpzs03vW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C11C8C19425;
	Mon, 20 Apr 2026 15:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776699409;
	bh=2UdaTs8H+StiygTWAEoCtUbaDZEZALTnFheiNtDzAo0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jpzs03vWdlaSNYOXmfDIRlEpf3+TPokpmhlKeG8dQZogDJrYL/nQZDAcL83S0lsb1
	 ArCFF8oZKqk6iDMI2aFu2NOLhRAnfS2LW8N0EEIzHnabxC8guaboPbHemdiqtuOV6Z
	 bG91eSzR6tsAQiKPzXC4MB7GclcXYZF1Ew1RBeDmB643BBj/amGBlm4VT9jcWs2VDJ
	 D/2D2wQEOvCIERCBU9H/dBy71T7DryPPZxpVTP10B/34JKZK1RHHknbJuN6uL1hTnu
	 oNJl/9cZkSqEiPTw3BcjfV8kKBEO7KiXhIjp4JIKKu9uhoNjZM+NaH3jR8djwuLodE
	 zczFSENU62bSg==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	"Alexei Starovoitov" <ast@kernel.org>,
	"Daniel Borkmann" <daniel@iogearbox.net>,
	"Andrii Nakryiko" <andrii@kernel.org>,
	"Martin KaFai Lau" <martin.lau@linux.dev>,
	"Eduard Zingerman" <eddyz87@gmail.com>,
	"Kumar Kartikeya Dwivedi" <memxor@gmail.com>,
	"Song Liu" <song@kernel.org>,
	"Yonghong Song" <yonghong.song@linux.dev>,
	"Xu Kuohai" <xukuohai@huaweicloud.com>,
	"Catalin Marinas" <catalin.marinas@arm.com>,
	"Will Deacon" <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH bpf-next 3/3] selftests/bpf: Enable stack argument tests for arm64
Date: Mon, 20 Apr 2026 08:36:01 -0700
Message-ID: <20260420153603.4097618-4-puranjay@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260420153603.4097618-1-puranjay@kernel.org>
References: <20260420153603.4097618-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that arm64 supports stack arguments, enable the existing stack_arg,
stack_arg_kfunc and verifier_stack_arg tests for __TARGET_ARCH_arm64.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 tools/testing/selftests/bpf/progs/stack_arg.c     |  3 ++-
 .../testing/selftests/bpf/progs/stack_arg_kfunc.c |  3 ++-
 .../selftests/bpf/progs/verifier_stack_arg.c      | 15 ++++++++++++++-
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/stack_arg.c b/tools/testing/selftests/bpf/progs/stack_arg.c
index 8c198ee952ff..b1276009fd30 100644
--- a/tools/testing/selftests/bpf/progs/stack_arg.c
+++ b/tools/testing/selftests/bpf/progs/stack_arg.c
@@ -23,7 +23,8 @@ struct {
 
 int timer_result;
 
-#if defined(__TARGET_ARCH_x86) && defined(__BPF_FEATURE_STACK_ARGUMENT)
+#if (defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)) && \
+	defined(__BPF_FEATURE_STACK_ARGUMENT)
 
 const volatile bool has_stack_arg = true;
 
diff --git a/tools/testing/selftests/bpf/progs/stack_arg_kfunc.c b/tools/testing/selftests/bpf/progs/stack_arg_kfunc.c
index 6cc404d57863..3818cd0cb67b 100644
--- a/tools/testing/selftests/bpf/progs/stack_arg_kfunc.c
+++ b/tools/testing/selftests/bpf/progs/stack_arg_kfunc.c
@@ -6,7 +6,8 @@
 #include "bpf_kfuncs.h"
 #include "../test_kmods/bpf_testmod_kfunc.h"
 
-#if defined(__TARGET_ARCH_x86) && defined(__BPF_FEATURE_STACK_ARGUMENT)
+#if (defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)) && \
+	defined(__BPF_FEATURE_STACK_ARGUMENT)
 
 const volatile bool has_stack_arg = true;
 
diff --git a/tools/testing/selftests/bpf/progs/verifier_stack_arg.c b/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
index 66dd11840a63..8f1eef911f70 100644
--- a/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
+++ b/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
@@ -12,7 +12,8 @@ struct {
 	__type(value, long long);
 } map_hash_8b SEC(".maps");
 
-#if defined(__TARGET_ARCH_x86) && defined(__BPF_FEATURE_STACK_ARGUMENT)
+#if (defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)) && \
+	defined(__BPF_FEATURE_STACK_ARGUMENT)
 
 __noinline __used
 static int subprog_6args(int a, int b, int c, int d, int e, int f)
@@ -36,6 +37,7 @@ SEC("tc")
 __description("stack_arg: subprog with 6 args")
 __success
 __arch_x86_64
+__arch_arm64
 __naked void stack_arg_6args(void)
 {
 	asm volatile (
@@ -55,6 +57,7 @@ SEC("tc")
 __description("stack_arg: two subprogs with >5 args")
 __success
 __arch_x86_64
+__arch_arm64
 __naked void stack_arg_two_subprogs(void)
 {
 	asm volatile (
@@ -84,6 +87,7 @@ SEC("tc")
 __description("stack_arg: read from uninitialized stack arg slot")
 __failure
 __arch_x86_64
+__arch_arm64
 __msg("invalid read from stack arg off 8 depth 0")
 __naked void stack_arg_read_uninitialized(void)
 {
@@ -99,6 +103,7 @@ SEC("tc")
 __description("stack_arg: gap at offset -8, only wrote -16")
 __failure
 __arch_x86_64
+__arch_arm64
 __msg("stack arg#6 not properly initialized")
 __naked void stack_arg_gap_at_minus8(void)
 {
@@ -120,6 +125,7 @@ __description("stack_arg: pruning with different stack arg types")
 __failure
 __flag(BPF_F_TEST_STATE_FREQ)
 __arch_x86_64
+__arch_arm64
 __msg("R1 invalid mem access 'scalar'")
 __naked void stack_arg_pruning_type_mismatch(void)
 {
@@ -157,6 +163,7 @@ SEC("tc")
 __description("stack_arg: release_reference invalidates stack arg slot")
 __failure
 __arch_x86_64
+__arch_arm64
 __msg("R1 invalid mem access 'scalar'")
 __naked void stack_arg_release_ref(void)
 {
@@ -207,6 +214,7 @@ SEC("tc")
 __description("stack_arg: pkt pointer in stack arg slot invalidated after pull_data")
 __failure
 __arch_x86_64
+__arch_arm64
 __msg("R1 invalid mem access 'scalar'")
 __naked void stack_arg_stale_pkt_ptr(void)
 {
@@ -246,6 +254,7 @@ SEC("tc")
 __description("stack_arg: null propagation rejects deref on null branch")
 __failure
 __arch_x86_64
+__arch_arm64
 __msg("R1 invalid mem access 'scalar'")
 __naked void stack_arg_null_propagation_fail(void)
 {
@@ -285,6 +294,7 @@ SEC("tc")
 __description("stack_arg: missing store on one branch")
 __failure
 __arch_x86_64
+__arch_arm64
 __msg("stack arg#6 not properly initialized")
 __naked void stack_arg_missing_store_one_branch(void)
 {
@@ -327,6 +337,7 @@ SEC("tc")
 __description("stack_arg: share a store for both branches")
 __success __retval(0)
 __arch_x86_64
+__arch_arm64
 __naked void stack_arg_shared_store(void)
 {
 	asm volatile (
@@ -369,6 +380,7 @@ SEC("tc")
 __description("stack_arg: write beyond max outgoing depth")
 __failure
 __arch_x86_64
+__arch_arm64
 __msg("stack arg write offset -80 exceeds max 7 stack args")
 __naked void stack_arg_write_beyond_max(void)
 {
@@ -393,6 +405,7 @@ SEC("tc")
 __description("stack_arg: sequential calls reuse slots")
 __failure
 __arch_x86_64
+__arch_arm64
 __msg("stack arg#6 not properly initialized")
 __naked void stack_arg_sequential_calls(void)
 {
-- 
2.52.0

