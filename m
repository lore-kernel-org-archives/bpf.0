Received: from mta1.migadu.com (out-41.mta1.migadu.com [95.215.58.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F1F29CE9
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 20:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787343214; cv=none; b=oupIxx4sfJCX/0WiUEnzU47fz5VXSABW7rFJVmjwAc9alkkIX0TV5NB88ui1nc4jzl3HpGMReIflHOGc/8nZ1lgXRrAuDvAPF5RCtSQKRUa6aGSJZgcxCpbKWd37hwRkR8AgUsGzwbUL+VKwwpA+kuYqiInTDg0uroPe6zmqVZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787343214; c=relaxed/simple;
	bh=sIHJLwhMLZXjw5UibA80PaY80kXw3BXHjlGNGylp/dc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Efy8jLW7tHRnIy+6SMbOjTgAEuTcbFQ045/THkYKKF3kVdeXlDub2cvuQ611DsJ9bxKABwmIJrHCS4zJIxpenBfzBRP7hmvO7UwthAZzLUYElp1B/zSTb1mDxuZGoIBFQXyVIpuID6sNja516537yGTRGju8rafrd7fm86e05Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dde5NP+Z; arc=none smtp.client-ip=95.215.58.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dde5NP+Z"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=sIHJLwhMLZXjw5UibA80PaY80kXw3BXHjlGNGylp/dc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787343210; v=1; x=1787948010;
 b=dde5NP+Z8LnSVzAd3Bnu/ULTq6LCAH4o9xmvhMbxkkMWCF2cMLHGsYETpZaUvYi/Yk/C274z
 PDblVu3CfkpGsH2A7Bz6vrXkFLf6CiOUMjNAopN6Nd/xHxawj4qJZ39OqPxzGET2+9sQMMhmF+5
 z0yVm7qwT5JFZNvGZsGQAR2c=
X-Envelope-To: bpf@vger.kernel.org
Received: from gvineet-fedora-PF5JGVFY (67.169.75.212)
	by smtp.migadu.com with ESMTPS id df571abee5f0a9a1;
	Fri, 21 Aug 2026 20:13:29 +0000
X-Mizu-Trace-ID: df571abee5f0a9a1
X-Migadu-Flow: FLOW_OUT
From: Vineet Gupta <vineet.gupta@linux.dev>
To: bpf@vger.kernel.org
Cc: Vineet Gupta <vineet.gupta@linux.dev>
Subject: [PATCH bpf-next 1/3] selftests/bpf: name the remaining placeholder programs dummy_test [NFC]
Date: Fri, 21 Aug 2026 13:13:14 -0700
Message-ID: <20260821201316.1059129-2-vineet.gupta@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821201316.1059129-1-vineet.gupta@linux.dev>
References: <20260821201316.1059129-1-vineet.gupta@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Eleven of the thirteen feature-gated placeholder programs are called
dummy_test. Two are not: hence this patch.

This is purely cosmetic as nothing depends on those names.
The non-complaint setups use RUN_TESTS(skel) which does thru all
programs normally. This is just more consistent and grep friendly.

Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
---
 tools/testing/selftests/bpf/progs/arena_kfunc.c    | 2 +-
 tools/testing/selftests/bpf/progs/stack_arg_fail.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/arena_kfunc.c b/tools/testing/selftests/bpf/progs/arena_kfunc.c
index bf0d304e0e59..47bed5c4c488 100644
--- a/tools/testing/selftests/bpf/progs/arena_kfunc.c
+++ b/tools/testing/selftests/bpf/progs/arena_kfunc.c
@@ -234,7 +234,7 @@ __arch_x86_64
 __arch_arm64
 __description("arena_arg_stack: not supported, dummy test")
 __success
-int arena_arg_stack(void *ctx)
+int dummy_test(void *ctx)
 {
 	return 0;
 }
diff --git a/tools/testing/selftests/bpf/progs/stack_arg_fail.c b/tools/testing/selftests/bpf/progs/stack_arg_fail.c
index ad9d4bfe15dc..6f6f59306d0e 100644
--- a/tools/testing/selftests/bpf/progs/stack_arg_fail.c
+++ b/tools/testing/selftests/bpf/progs/stack_arg_fail.c
@@ -104,7 +104,7 @@ __naked void r11_store_zero_off(void)
 SEC("tc")
 __description("stack_arg_fail: not supported, dummy test")
 __success
-int test_stack_arg_big(struct __sk_buff *skb)
+int dummy_test(struct __sk_buff *skb)
 {
 	return 0;
 }
-- 
2.53.0-Meta

