Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795584763;
	b=F2jjJSLeDyDJb/prws7jJN64OIZSe4W2qmUfCQkSQRk/o5/GB6jhrF6pYe55b3l/WmB/
	 ftzfelIRHuslk5lZLPrUN6hwAWv3IASDmXad+moamaqlh4cJRqSBjNcHMcoM2eGy09qok
	 qTtrXuCTkHHyhj8nrp5sxnWZZ/FmBmiel9WmHh+ERHqu7Ue1v8+AJfnXpSUoTzYA7K/d1
	 U5pfsu3hhHrC9vzcIERwlZFAt/8OiDDAmaw5EsOn7K1VDh/UVazTjL1kZOVveJRWRuNvi
	 nhT7CKldo/Rn0kQ/vKzBD+KNwHDlPJ7Db5/2+yycBlZj8vAUi/6sv2Z2HoZOqxGOwuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795584763;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=PpZ9ZbkPNT2Bgz/pdhHSzwCmq4DzoUNbsfs0MraZjOg=;
	b=1CurwzwEnT274MPPHeSBwu8ZaelEYVqhaq1VazizdF/td7xKucmDQdOz8E4Mnh6frf9t
	 d6ahmMEJikUj2ZjsQgYdMZClGL9p4yXA5bykJjv+CLqw1A2yYez/vaFV77idWefn290+K
	 t+cskwGgVSswy92gQ4zOUYoOutiyD46Ct6ODkqHWp/9UeQ/Royyw5fmcgFH0WXBVoCLVr
	 3XCuBpAIDwAKR8PGA/HNq+yGkFMZSYm2epITvkMXjUoE5FDBUT4BTNQRkEW50xWtnJIDi
	 pWhmns4ysFvuZTBUiwCxZRoUUBdX6R9W7hOJVuQjUN45eifcQdBK2InjQbl9p44ovQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=hYnOaNak;
	arc=none smtp.remote-ip=117.135.210.3
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1C7606A31E
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 05:32:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED1C7606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=hYnOaNak
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Pp
	Z9ZbkPNT2Bgz/pdhHSzwCmq4DzoUNbsfs0MraZjOg=; b=hYnOaNak3EaaYJGUja
	qTtBH984tL376NwNEuLziR8TUYMYZTSm5pCsoGIX0cvTOE5uy16u8V9YW4We+Ipb
	jqu/zVg4AlvzqsprDsqVPAijGCUOVigl29MwHY28y1JUHMreMkDOSZNZIyLCkuji
	FtEdU7wGgZ/SxROXoR58Ril2k=
Received: from kylin-ERAZER-H610M.. (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wDnL6jCcgZrriN8JQ--.11907S6;
	Wed, 25 Nov 2026 13:31:52 +0800 (CST)
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
Subject: [PATCH bpf-next v5 4/6] bpf: Invalidate async callbacks before detaching them
Date: Wed, 25 Nov 2026 13:31:30 +0800
Message-ID: <20261125053132.444234-5-luyun_611@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125053132.444234-1-luyun_611@163.com>
References: <20261125053132.444234-1-luyun_611@163.com>
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
X-CM-TRANSID:_____wDnL6jCcgZrriN8JQ--.11907S6
X-Coremail-Antispam: 1Uf129KBjvJXoWxZryDKr1xtF1rCryUWFyDZFb_yoW5GF48pr
	WSqry0kr4qgFsavw4I9w48C3WrZws3ta13CF90gayFvr98Xr1vqry8KFy29F98Ars3AF4j
	vayjqr4aqFWUuaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jnzVbUUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbC7Agr+WsGcsikTwAA3K

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

Invalidate C before detaching it. Every canceller clears cb->map, then
compare-exchanges the slot; the one that detaches C consumes the
map-owned reference and performs the cancellation. A canceller that
loses the compare-exchange returns. The compare-exchange detaches only
the observed object; a replacement callback object manages its own
reference.

Protect the initial access to C with regular RCU. Order unlink before the
slot load with the existing full barrier; the successful compare-exchange
orders the invalidation before the empty slot.

Fixes: 1bfbc267ec91 ("bpf: Enable bpf_timer and bpf_wq in any context")
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Yun Lu <luyun@kylinos.cn>
---
 kernel/bpf/helpers.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 74e0961..c665663 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1752,15 +1752,20 @@ static void bpf_async_cancel_and_free(struct bpf_async_kern *async)
 {
 	struct bpf_async_cb *cb;
 
-	if (!READ_ONCE(async->cb))
-		return;
-
-	cb = xchg(&async->cb, NULL);
+	/* Another canceller can release the map-owned cb reference. */
+	guard(rcu)();
+	/* Order unlink before reading async->cb, including an empty slot. */
+	smp_mb();
+	cb = READ_ONCE(async->cb);
 	if (!cb)
 		return;
 
 	/* Callbacks that run after this see NULL and return. */
 	WRITE_ONCE(cb->map, NULL);
+	/* The one who detaches cb drops the map's reference. */
+	if (cmpxchg(&async->cb, cb, NULL) != cb)
+		return;
+
 	bpf_async_update_prog_callback(cb, NULL, NULL);
 	/*
 	 * No refcount_inc_not_zero(&cb->refcnt) here. Dropping the last
-- 
2.43.0

