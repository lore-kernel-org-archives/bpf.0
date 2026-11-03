Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793729964;
	b=yUQf00Qul4MLaP+XkwtBNzOspx/a1+MV9sEQTuH42LWWTJ+q1JGd+CRMnq51J2KyiHZL
	 /2C/PBBjMUFnOQfoeq7N2YAJ/fONmk5Me4rfyRtfkKtJfHrFULMZLwP0lj8Tmrx7uXZTT
	 2AOGxmaQZas+EOZOCMchLJpeVepDIF7zHyb3RpWiaIQ/ix9zTgzbApzodj7UcF8BI/eNF
	 Gb+WBGpV+GZf6efwKT60zLDdJrcYYXvaO94yLniuschX2cFo4dRJF6byIw2YZKQ0Ketu2
	 xTf9nXkjUQVt0+TXwDkAmyhlZENALwU6p6Z0uhfg5xa+03T3ZPk1la5dPLRZuHIoYBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793729964;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=cy5NVa4zy9qS6Mga9ltUsUEtCniHJojXVPr9zJunu6w=;
	b=bNttc1wgaU0roMWGU/hFmBxEw2DIs4ZUWNO2QTbfxRpZDEX3jBt1byXaIK2oaJzjyHR6
	 Bpv/RVGAknosIAipwjYnVpFssIpMnDzXn0ddkNfh/iJozdGDJ8lwDtMANU/iJ5IrqJu95
	 pkCjIX01PSyKqH0Cf2iJC/QXviS+QEoLQWEuICYFutETAMdvFUfi/9ulKXRg7O3ThyR3i
	 hxd17zTyKPuh0OSTTGlPREkJ6DoRDZakBnMdJUR5fNZlCjSWCXClxxBp6NduL3bzHu3Wz
	 EHdJYbDDS7Hl+PRp7HVpxYmwFtd2FjdXteo3mI5YoDgE3PDdfMaGZshVfIAd0jQ6Zog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=uY60S5MK;
	arc=none smtp.remote-ip=91.218.175.198
Received: from mta0.migadu.com (out-198.mta0.migadu.com [91.218.175.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9937C606EE91
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 18:19:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9937C606EE91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=uY60S5MK
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=q/ovGyzi7R6zckhCMNiZ94Ym7wcqVfK/WB2DmfreLvE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793729961; v=1; x=1794334761;
 b=uY60S5MKlcJBRQE7QgAzdlErxEa/P0Xz3XTcdwSEwp/x9Os8jVdf1kXYjtk0aJdc99tnVbBV
 2T9Yw6K+tPwiTDmhUxo5kn7/+tm0jaXXSKDQGA59oqR7eCnx3ojDHmVczGN2abMha5s6nUuojwS
 yGbqow2+R7l+RFjjnRHKzgNc=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a72f377556df3c9b;
	Tue, 03 Nov 2026 18:19:21 +0000
X-Mizu-Trace-ID: a72f377556df3c9b
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
Subject: [PATCH bpf-next v4 8/8] selftests/bpf: cast explicitly in the arena subprog and callback faults
Date: Tue,  3 Nov 2026 10:18:16 -0800
Message-ID: <20261103181816.254686-9-vineet.gupta@linux.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103181816.254686-1-vineet.gupta@linux.dev>
References: <20261103181816.254686-1-vineet.gupta@linux.dev>
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

Stream tests fail with BPF_GCC, e.g.

  test_stream_arena_fault_address:FAIL:stream__open_and_load unexpected error: -13

They call stream__open_and_load(), which loads every program in the object,
and two of those do not verify:

  #481/11 stream_success/stream_arena_subprog_fault:FAIL
  #481/12 stream_success/stream_arena_callback_fault:FAIL

Both dereference an arena pointer and leave the cast to the compiler:

  int __arena *addr = (int __arena *)0xdeadbeef;
  *addr = 1;

Without arena support __arena is only btf_type_tag("arena"), so no
addr_space_cast is emitted and the store is to a scalar, which the
verifier rejects. GCC splits it into byte stores, 0xdeadbeef not
being aligned:

  r2=3735928559 ll
  *(u8*)(r2+0)=1            <- plain store, no cast

Their siblings in the same file do not rely on the compiler; they use
bpf_addr_space_cast(), which emits the instruction byte by byte and
works anywhere. Do the same here.

The address space has to come off the local as well. Left on, a
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

Measured on bpf-next with a stock bpf-gcc, test_progs before and
after. Every test that loads this object recovers, not just the arena
ones:

  stream_arena_fault_address                   FAIL -> OK
  stream_fd                                    FAIL -> OK
  stream_fd/blocking                           FAIL -> OK
  stream_fd/edge                               FAIL -> OK
  stream_fd/empty                              FAIL -> OK
  stream_fd/hup                                FAIL -> OK
  stream_fd/nmi_epoll                          FAIL -> OK
  stream_fd/nonblock                           FAIL -> OK
  stream_fd/open                               FAIL -> OK
  stream_oversize                              FAIL -> OK
  stream_partial_read                          FAIL -> OK
  stream_success                               FAIL -> OK
  stream_success/stream_arena_callback_fault   FAIL -> OK
  stream_success/stream_arena_subprog_fault    FAIL -> OK
  stream_syscall                               FAIL -> OK

and the subtests of the object that failed to load appear for the
first time:

  stream_arena_fault_address/read_fault             -> OK
  stream_arena_fault_address/write_fault            -> OK
  stream_arena_fault_address/xchg_fault             -> OK
  stream_arena_fault_address/cmpxchg_fault          -> OK
  stream_arena_fault_address/load_acquire_fault     -> OK

Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
---
v3 -> v4: was 6/8. No longer drops #include <bpf_arena_common.h>,
which the arena_base() patch now needs in this file.

 tools/testing/selftests/bpf/progs/stream.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/stream.c b/tools/testing/selftests/bpf/progs/stream.c
index b4d88d0e01ad..8c49a130150b 100644
--- a/tools/testing/selftests/bpf/progs/stream.c
+++ b/tools/testing/selftests/bpf/progs/stream.c
@@ -341,9 +341,10 @@ int stream_arena_cmpxchg_fault(void *ctx)
 
 static __noinline void subprog(void)
 {
-	int __arena *addr = (int __arena *)0xdeadbeef;
+	int *addr = (int *)0xdeadbeef;
 
 	arena_ptr = &arena;
+	bpf_addr_space_cast(addr, 0, 1);
 	*addr = 1;
 }
 
@@ -364,9 +365,10 @@ int stream_arena_subprog_fault(void *ctx)
 
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

