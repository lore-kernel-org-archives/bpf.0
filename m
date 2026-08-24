Received: from mta0.migadu.com (out-123.mta0.migadu.com [91.218.175.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2420026ED46
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 21:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787605323; cv=none; b=fXNzawYvo4QKhX8c6wsjXwPoL5sFEk6nl7xL2Wnefb+ZjnZDUuseNBmS8o5dk/jeJlMRyL34RjDltbUeN9PmWvL7L0sJsmMxR+LqsrQ4g5+px0COR62Kto2AvvecWlHHT2NyOixzyUnZhasp+pENtCXy/IowDw49azkCSI6bHT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787605323; c=relaxed/simple;
	bh=0RuIPJejN9nuZbZ3EQBsl7txHAD7py6J66lfmh6dHio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eT8zbK320E2pF5r5qDUiJdPUEbSSW29TtNIqxstGD762VO6xbqvJ3/C4C6+C87I/I23hPZhWjPwTnpdN/73+4RmWvSmIF1XF+famXzA7DJ11sKqiPQxge+k04R/+sRSLnHli5JIkizMVTO9QsQW35QlgfX0EHZ3q9Tx7VQp/4IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TyomA1na; arc=none smtp.client-ip=91.218.175.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TyomA1na"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=0RuIPJejN9nuZbZ3EQBsl7txHAD7py6J66lfmh6dHio=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787605319; v=1; x=1788210119;
 b=TyomA1nawTKgNrqEGpaN2prsBsKqrv20EDJ8Au9MQ7UIY1gkC7tpYUxzXOcGNSbwg8wN8lsC
 bBloAoMRFlXVr1E4TAKIPO2CFN0ozAibcJTAocIwfVfQIxgGcADCy9npqSA1WPU2XVONqGzLwp0
 JGC4IoIDcxgLtwpTjTcrHhd8=
X-Envelope-To: bpf@vger.kernel.org
Received: from gvineet-fedora-PF5JGVFY.thefacebook.com (2620:10d:c090:500::4:2c42)
	by smtp.migadu.com with ESMTPS id 54b6f19022c601bd;
	Mon, 24 Aug 2026 21:01:59 +0000
X-Mizu-Trace-ID: 54b6f19022c601bd
X-Migadu-Flow: FLOW_OUT
From: Vineet Gupta <vineet.gupta@linux.dev>
To: bpf@vger.kernel.org
Cc: Vineet Gupta <vineet.gupta@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 1/3] selftests/bpf: name the remaining placeholder programs dummy_test [NFC]
Date: Mon, 24 Aug 2026 14:01:40 -0700
Message-ID: <20260824210142.3933580-2-vineet.gupta@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824210142.3933580-1-vineet.gupta@linux.dev>
References: <20260824210142.3933580-1-vineet.gupta@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thirteen of the fifteen feature-gated placeholder programs are called
dummy_test. Two are not: hence this patch.

This is purely cosmetic as nothing depends on those names.
The non-compliant setups use RUN_TESTS(skel) which goes through all
programs normally. This is just more consistent and grep friendly.

Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
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

