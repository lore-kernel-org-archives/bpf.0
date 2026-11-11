Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794365086;
	b=4iUkO0OuGnY4KuTLvkZ6MMwjv7Ec85zon/0AYqeGW/KStrlU4qrN5hWsowIC9JqZzCl0
	 Zk5WNsA3lu/669Qj2kCBBfIT8I3M9Yiq4yHp/YVtObg3z9pKaP0UWdA/aOy2GqJUhNfml
	 NsVhJenor2QDEHzERrjqsSiTvkM4t7OQKIhcHtf+vlr9DUc/qFAeSQZEtoKoXuw17CqLX
	 bp+JgSDGtn/xECa0zRHnRVTKFIGaB2VWBEUvl2lWdEmwrfh5n3SntxRCqhXCpXU7wKnMw
	 VDX8HETZzGxy//LsN85VkoI5pNj3boUEYTnK3orxNRNMm9w+Q2vm5hYAaPJk08ZXPhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794365086;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=TUYSHL7RUqo6jZfd99xoUSa35O+Vzwg8I7v6n/QNgiE=;
	b=U9BJnnb2AzP6tf0cbiotIhxCJQyXY/hSVX1rigU1WQDUOl6MwA/hPC8O24+7QkAq+kBY
	 8ArWPGLB79k5Sqyq+9sVRmy4wXjYTI5GKozjg+fweD6ikTTFqCTfP6u2Oo0LQhYoBKFXw
	 IaShIVJTGd+tWCd1qehKqH0T+0vLn4x87mPxWuy6OXWthrM/0xYp7a1YLAJdUwBbekvz4
	 gO1iJvKiEYkKaoyGKaZ+CCrkZfZN6xlq6gNmwc2SeVRkPw0p94Ilr7txzsV2pyK9+pTIe
	 W5syon5o0GbLhaW+qJEGY5izwmO7KvXpAS2mdqHKZBPCtzBcR4o9U8oJ+q8RcvphfNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=npd7kjWH;
	arc=none smtp.remote-ip=117.135.210.3
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C34606A320
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 02:44:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7C34606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=npd7kjWH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=TU
	YSHL7RUqo6jZfd99xoUSa35O+Vzwg8I7v6n/QNgiE=; b=npd7kjWHSiH0Wl0b2Y
	njnGwRojlXZw3VVWDCfhdxPBGxaEqV1fBNm40W3SbvJueTzVTm6UzYO8qGY57dnT
	7ql0CIOFKbmTjPUlRYDnsB8CPGq12h2chiG3qu/gWvVNE9XD1HD1Oa161jpgAzAp
	vPO8nQRv3xPSfFRhol5fgpLi0=
Received: from kylin-ERAZER-H610M.. (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgBXCgpq1vNqdIGjEw--.26036S6;
	Wed, 11 Nov 2026 10:43:57 +0800 (CST)
From: Yun Lu <luyun_611@163.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev
Cc: yatsenko@meta.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v3 4/6] bpf: Invalidate async callbacks before detaching them
Date: Wed, 11 Nov 2026 10:43:31 +0800
Message-ID: <20261111024333.228633-5-luyun_611@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111024333.228633-1-luyun_611@163.com>
References: <20261111024333.228633-1-luyun_611@163.com>
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
X-CM-TRANSID:PSgvCgBXCgpq1vNqdIGjEw--.26036S6
X-Coremail-Antispam: 1Uf129KBjvJXoWxZryDKr1xtF1rArW7KryUKFg_yoW5Jw4rpr
	4YqFWjkr4DGF4vvw4Iyw48Ga4rA39YqanxGryFgayFvr98Wrn2vrykWFy2vFZxArs5AF1j
	va1jqFsxXrWUC3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j5dbbUUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbC6w1oN2rz1m1YyAAA3L

From: Yun Lu <luyun@kylinos.cn>

__bpf_async_init() publishes a callback object C before checking usercnt.
On a non-preallocated HASH map, a syscall BPF program can pause after
publication while another CPU configures and queues C on the live value.
If usercnt then drops to zero, init's failure cleanup can race with uref
cleanup and deletion. The old code permits this interleaving:

  1. Init's cleanup detaches C and pauses before clearing C->map.
  2. Uref cleanup and deletion see an empty slot; deletion retires the
     element for reclamation.
  3. C's queued WQ callback enters outside the freeing GP's waiting set
     and reads a valid map, program and callback function.
  4. Init's cleanup resumes and invalidates C, but cancel_work() does not
     wait for the running callback.
  5. The element is freed while the callback can still access its value.

Invalidate C before detaching it. Use xchg() on cb->map to select the only
canceller that clears the slot and consumes the map-owned reference.
Until it clears the slot, init cannot publish a replacement, so a plain
slot store cannot overwrite a new callback object.

Protect the initial access to C with regular RCU. Order unlink before the
slot load, and acquire prior invalidation when the slot is already empty.

Fixes: 1bfbc267ec91 ("bpf: Enable bpf_timer and bpf_wq in any context")
Signed-off-by: Yun Lu <luyun@kylinos.cn>

---
 kernel/bpf/helpers.c |  15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index a08b2af56ee6..716be7a852b5 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1747,15 +1747,18 @@ static void bpf_async_cancel_and_free(struct bpf_async_kern *async)
 {
 	struct bpf_async_cb *cb;
 
-	if (!READ_ONCE(async->cb))
+	/* Another canceller can release the map-owned cb reference. */
+	guard(rcu)();
+	/* Order unlink before reading async->cb, including an empty slot. */
+	smp_mb();
+	/* Acquire any invalidation published before the slot was cleared. */
+	cb = smp_load_acquire(&async->cb);
+	/* Only the first invalidator detaches cb and drops the map's reference. */
+	if (!cb || !xchg(&cb->map, NULL))
 		return;
 
-	cb = xchg(&async->cb, NULL);
-	if (!cb)
-		return;
+	WRITE_ONCE(async->cb, NULL);
 
-	/* Callbacks that run after this see NULL and return. */
-	WRITE_ONCE(cb->map, NULL);
 	bpf_async_update_prog_callback(cb, NULL, NULL);
 	/*
 	 * No refcount_inc_not_zero(&cb->refcnt) here. Dropping the last
-- 
2.43.0

