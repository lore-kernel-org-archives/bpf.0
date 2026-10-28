Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793145904;
	b=dtbOIIhn9Yody+RWhnqaRZnIVWzoTp0OqNHK9+FSDufnpfLVo93kCnIfNIP/0otzZe0M
	 aNHZkZgY8SonYtU5NyROi7JB1S7fGrUlli4SzSCzRU3wU2OqrEUajCPqybyUA8nXfm8h6
	 RGseR4nL2TNBDfLU1kYgDCtxntT2DrvgUB59nTh16v+5DCYQUwEI/ftUEvMEm7PpzN1x6
	 8LHO5Fw0EWkGMTQ001FWqWgZ8ZVk/fM2fbp/3KoD0tQUWibuNnGXat+isDI6qbLiOyMNR
	 rB5+O1gDf+QoynPw1OQkRKTFAvz3s1HULz1LsOMqJpiHQPtUNZSUV58X4zCLA2RXwBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793145904;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=ah4gzw5OiHfYj57lOarZOXCU6RfDPS1zY+caCBQQGnA=;
	b=ygsYsh7S4jYO2JrFE7pq/aUPPkb83Pzbf/uLwTsp3gXbnHGtFpmXxLiFsazUmyyOARo6
	 yAToQhMZROOuoq1QSbXQ7vM/KeVBX8DpLFwfcEGn4Y+ACeE7UFQuWQTo7FDAQMhLcItKt
	 Ve4veIztfYRoZtPdszQAVajiKcU6tZYsDgWP1dwBhupcD5Tsur65As3V77a1SOBPydxrF
	 CTPLGPDgRDQ+UvqkZ3I3QSC0RZJQbuEvValRLGQC2QUn6bpfAqJ48bTXLzzmEbxwhSQ2B
	 G4pZYynmd+LL/7bjTquDWRWqw62gqPLsHvjD0ep8cp6pQPMJhm5DiFukvLwQ7QL69lQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=TwGC2TzJ;
	arc=none smtp.remote-ip=91.218.175.10
Received: from mta0.migadu.com (out-10.mta0.migadu.com [91.218.175.10])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2510C606A320
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 00:05:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2510C606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=TwGC2TzJ
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=psa7zx1Xe6yGIkcQOpjXlYI3zz/TQ9U0VkcLjx2WVoI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793145902; v=1; x=1793750702;
 b=TwGC2TzJdfwSNEmrRrDbN7E/YKUglZXDJk93kXtg8RHIHAsB5m6nJKHM5O2fwADzREZrrYNI
 EoFK+ZeF5WsLxVfkw1cRmFH0xwWGSJoPMOgfP1kzmrkGczu+YNoLm68CPpmEy8THreaVszS5E2e
 AckDE179ZO0DtezqI8nkMtZI=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 84ceb785ec4e11b7;
	Wed, 28 Oct 2026 00:05:02 +0000
X-Mizu-Trace-ID: 84ceb785ec4e11b7
X-Migadu-Flow: FLOW_OUT
From: Vineet Gupta <vineet.gupta@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	john.fastabend@gmail.com,
	shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	jose.marchesi@oracle.com,
	david.faust@oss.qualcomm.com,
	Vineet Gupta <vineet.gupta@linux.dev>
Subject: [PATCH bpf-next v1 6/7] selftests/bpf: cast explicitly in the arena subprog and callback faults
Date: Tue, 27 Oct 2026 17:04:10 -0700
Message-ID: <20261028000411.4010967-7-vineet.gupta@linux.dev>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Four stream tests fail with BPF_GCC:

  test_stream_arena_fault_address:FAIL:stream__open_and_load unexpected error: -13
  #479 stream_oversize:FAIL
  #480 stream_partial_read:FAIL
  #482 stream_syscall:FAIL

They call stream__open_and_load(), which loads every program in the object,
and two of those do not verify:

  #481/11 stream_success/stream_arena_subprog_fault:FAIL
  #481/12 stream_success/stream_arena_callback_fault:FAIL

Both dereference an arena pointer and leave the cast to the compiler:

  int __arena *addr = (int __arena *)0xdeadbeef;
  *addr = 1;

Without arena support __arena is only btf_type_tag("arena"), so no
addr_space_cast is emitted and the store is to a scalar, which the
verifier rejects.  GCC splits it into byte stores, 0xdeadbeef not
being aligned:

  r2=3735928559 ll
  *(u8*)(r2+0)=1            <- plain store, no cast

Their siblings in the same file do not rely on the compiler; they use
bpf_addr_space_cast(), which emits the instruction byte by byte and
works anywhere.  Do the same here.

The address space has to come off the local as well.  Left on, a
compiler that supports arenas casts a second time for the
dereference, on a pointer the explicit cast has already converted:

  r2 = addr_space_cast(r2, 0, 1)
  r3 = addr_space_cast(r2, 0, 1)
  *(u32*)(r3+0)=1

With it off, GCC with and without arena support and clang all emit the
same thing, which is what the test wants:

  r2 = addr_space_cast(r2, 0, 1)
  *(u32*)(r2+0)=1

What these two assert is the fault report, not how the pointer was
produced, so nothing they were testing is lost.

Measured on bpf-next with a stock bpf-gcc, test_progs before and after.
Fifteen results go FAIL -> OK -- every test that loads this object, not
just the arena ones:

  stream_arena_fault_address             stream_oversize
  stream_fd        stream_fd/blocking    stream_partial_read
  stream_fd/edge   stream_fd/empty       stream_success
  stream_fd/hup    stream_fd/nmi_epoll   stream_success/stream_arena_callback_fault
  stream_fd/open   stream_fd/nonblock    stream_success/stream_arena_subprog_fault
                                         stream_syscall

and the five stream_arena_fault_address subtests become visible for the
first time (read, write, xchg, cmpxchg and load_acquire faults).

Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
---
 tools/testing/selftests/bpf/progs/stream.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/stream.c b/tools/testing/selftests/bpf/progs/stream.c
index 1ae015c4e6b4..dc56779cac06 100644
--- a/tools/testing/selftests/bpf/progs/stream.c
+++ b/tools/testing/selftests/bpf/progs/stream.c
@@ -5,7 +5,6 @@
 #include <bpf/bpf_helpers.h>
 #include "bpf_misc.h"
 #include "bpf_experimental.h"
-#include <bpf_arena_common.h>
 
 struct arr_elem {
 	struct bpf_res_spin_lock lock;
@@ -381,9 +380,10 @@ int stream_arena_cmpxchg_fault(void *ctx)
 
 static __noinline void subprog(void)
 {
-	int __arena *addr = (int __arena *)0xdeadbeef;
+	int *addr = (int *)0xdeadbeef;
 
 	arena_ptr = &arena;
+	bpf_addr_space_cast(addr, 0, 1);
 	*addr = 1;
 }
 
@@ -404,9 +404,10 @@ int stream_arena_subprog_fault(void *ctx)
 
 static __noinline int timer_cb(void *map, int *key, struct bpf_timer *timer)
 {
-	int __arena *addr = (int __arena *)0xdeadbeef;
+	int *addr = (int *)0xdeadbeef;
 
 	arena_ptr = &arena;
+	bpf_addr_space_cast(addr, 0, 1);
 	*addr = 1;
 	return 0;
 }
-- 
2.53.0-Meta

