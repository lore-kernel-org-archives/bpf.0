Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795059111;
	b=mkF/JVjk6Y7ZHBGu+kdfnnN7jCua4diczBZfXbLlSogSewo8p9EuhLOK3cwIN/2v8cEF
	 R2BoTLxHEV5gujzd9gtm0gCyO0SszgcvAPGIOC2ukXviBJpEPUNCrC47r60td5CYRNflU
	 1r17WRGfilbyJ96vU+VfTs8bo357Jf2D56wGeHPRZqI3+T5kP47HGVOmReEJMEbqUwlNj
	 rB2FkunW6anySoXQiEjsTnT/vWzCcEFZTz+rKdGdROoLudLZs+KkUTECgS408oJ/BLf3q
	 TcdHk/scB6H5ORdFj3m+m76/ih3ZYQ32HHfup0ZGGYR1FZpvsiSOvIucA0dCRf54AUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795059111;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=ZTSKuv1Y/ayf3OUAgf4L36na0LDQnAtOoUi764CgDOU=;
	b=c7Lx79yDVnNqGgg4DbskynzHuPbrKTAfJ7q320JKV8HjTLdodruJO31NhCeE2OjkXpN3
	 cAzchUyNqYHxoeco1uZ59H223pc+S3IbYQzulkeLSdaSXhPXUmSbEJDAQNtdvHLZ+r984
	 vm1pP3KH9IHFprjTSWGIGMkyvB7GV1EQlgQGvAmIfppULs4RIX4KT1/ydVXqy0kJbSx/+
	 CPtwKuZs/iF4ET8lUtNxHrJP3ga99b+OAcRPYaMhoFfq6c8f5Z+i87B47S5aYsWwAaOby
	 xV2gC6VlFg1HswD4uy3JTK1cg664mBzVhLaW12o/3GLJzXf9hNpJ3OF9OKBwPPT0q4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=S7Vcsyaz;
	arc=none smtp.remote-ip=117.135.210.5
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251A1606A320
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 03:31:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 251A1606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=S7Vcsyaz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=ZT
	SKuv1Y/ayf3OUAgf4L36na0LDQnAtOoUi764CgDOU=; b=S7VcsyazXslWeAbrwn
	VTsMiDywfZs/5kN569qH+F9kf56zFqaAzjCryzsy2QY/XdLWbtM4H4ojV1hRaaWK
	oFsSI6HLwegiQmnGfk6Oyd+Z8Q65Qkn/adUTi48m/BabG7cdre3QvWLinkN/3bDl
	7AF8twnvsF2LNJRuWKws8ZavA=
Received: from kylin-ERAZER-H610M.. (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD3Xzx1bf5qM8OwJA--.54798S6;
	Thu, 19 Nov 2026 11:31:07 +0800 (CST)
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
Subject: [PATCH bpf-next v4 4/6] bpf: Invalidate async callbacks before detaching them
Date: Thu, 19 Nov 2026 11:30:49 +0800
Message-ID: <20261119033051.196177-5-luyun_611@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261119033051.196177-1-luyun_611@163.com>
References: <20261119033051.196177-1-luyun_611@163.com>
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
X-CM-TRANSID:_____wD3Xzx1bf5qM8OwJA--.54798S6
X-Coremail-Antispam: 1Uf129KBjvJXoWxZryDKr1xtF1rArW7KryUKFg_yoW5Jw4rpr
	4YqFWjkr4DGF4vvw4Iyw48Ga4rZ39YqanxGFyFgayFvr98Wrn2vrykWFy2vFZxArs5AF1j
	va1jqFsxXrWUC3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jYc_fUUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbC7BvTomr+bXsjzQAA3q

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
 kernel/bpf/helpers.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 468486102073..fa7e514ffd19 100644
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

