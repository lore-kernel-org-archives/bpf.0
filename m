Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794271126;
	b=JbHK7g8I7mV1oQxPnG92gYq8lywhE/LSmJz6lm6vapulmJ2AarqVe6pQ47Ad4UAuPQoY
	 pgkc66TTsWLdaB6qM+J+DiZPRmbgq6zkeKj0dd8FOhXXUaDbXFBVFh7yTm3VoKzyaRfCX
	 JhI1q7TvqSMVTU1TxBk3RwLAtR9JV+b1e5Xm7j3o3Sd0cOonsl3z/kYehp0hi4HHElmxq
	 zdkk/OwcnF9+Qu0x+JTipLYz4Yr53GzXVe3qFg9UeweT4BKEHtzd+pP01Kson8Id6fuUg
	 El1753fY5fhN7nW0tFf9tLThuua2+ccW26QPIVSNJP1RdWHMP3T5QkDEFbxCN91373A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794271126;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OpgqsyE1vyGupU5CGfIRJKgieGT7cl8Mtd6IWDRavyQ=;
	b=mP7VNRkUJR4NLYoJVSfMDuk8ogyhyeFBQhqDB9W6R6hpkmqkh6551erTA6/cM9r5Wo/G
	 CSq8tIwLX49EIJJVEeQT23Z78w1HgODtzGrp5IjQVF0Ac2GVlEjbXDnBO4KVgF0QHcdJ9
	 c0lTz60jAMw/MgKLPrUPk9QqEWq0g/A7aktk7huHrvLEbAXrhYc4xcIWcZ3u3RoPRVgtF
	 iGZkhfxFQD9jt9AeAs51cG2nI9pQMuqnAE6BtPTLewLaX9f1ceYcE33gSEA+4s73zI83o
	 h3MBK0vuOjJ83ck75JN4vyYoTHISHqREvojYFBJiE4xTZ4Smpau86WQ+IL2XsAaKfnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=m4GMr2uw;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D0D606A337
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 00:38:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0D0D606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=m4GMr2uw
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3b0e0e65adbso744057a91.3
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 16:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis.com; s=google; t=1794271125; x=1794875925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OpgqsyE1vyGupU5CGfIRJKgieGT7cl8Mtd6IWDRavyQ=;
        b=m4GMr2uwZq9pGMB36r+uKMLwf85ZIc8YW0fJTHRFOUaZV3Vtqbg9ALZln5Nir/N4W7
         3eJJPJQL219ny8wSDxbz1vzz7OQU79DiWP3wgrz2nu0cZWO1nrwc1VMEq5NV728yl1q8
         gyrH04bD930gFfgxYb47eLHsOHYuLPkpXKnpI/aAJFO1ipthjCAYpFWBuM5Ui4xEOQPm
         by4fdcaF4CWYnX4DZsx8k2wktJiQw41ySEz4bGWfg9Y4mlEvgAnZYpPC+hncfmRvGXOs
         TopV/eKI0OQE77fqXco57gxGeZHQJILA31sILgAtUYLz61W8J1h9+/hjxAotv8zhF21U
         HOQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794271125; x=1794875925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OpgqsyE1vyGupU5CGfIRJKgieGT7cl8Mtd6IWDRavyQ=;
        b=cuTt/cxyukNmK4c1yr6EvjZe8zJbjSXmA4qGNreMh/KI0yjlfEQZoPofjaAox5CB7r
         PdGVf9sYlL+UDul/RcQB9nwpERV8RBVxoMPuM/VTqjlXZNsuTLOUHyW+Vdtike75iFTY
         ilSjuDocdaycDzjOIv87yM/cW9Y2bE8guASYXxGAtNzsUhNNFyQBiN4ta5xjLtVvGIm+
         1Mx2HBk6x93MM7vxZNOOCHJGOjhyAwRZ2xy8jJKhNrSigTPYurMPNaWVrgOt9yGCQGY5
         hyV0Ap6hDW8ZDfTio+vSR+h43TkBT21qS0LIQuQrxBm3bJlt8rtwOy1PerCzFIWDjmUX
         pACg==
X-Gm-Message-State: APuU4Z9oUT1+I8ncY/vbCpTXuEh+z+dK4gZw9yvTZgHEQ4LCBv8kyIBx
	IoWcYjZ9fxwDmH0HCy8oN7C3V861nESZuslwQWRhSNu5PNTDov4NUUuz/Qw4JsvmfrGEcqWHnjK
	gQm90S+A=
X-Gm-Gg: AYBFou22Zu9kFxWlJ+tvpcy4zdSRS4ef9+z9hllsIv/FDjTvIfpThOSv67vVszfWmHZ
	Zoa2s19qDmf3LTSR6/myyQdWwobpCmfOPSoFrwYPwS0EG8UnrPZWn6FrZ3zAzBCnLq6bvSiheWq
	Bs0AqgloKcidxRAFl6LmzihbLIplYRB9cLbep6Jj5x9WhzkJPa982SbnOJOfEVnPjx3CW+NTbMq
	K4FTGRVYehadRjliX7yuqZaYDwnebhlA3fh6hXl4gJHXHCRJoi+/lldraQWDVnoQ4L5a18FNfGR
	jBsLYNxjZ+4YrrXhH5vDkT9FFksEF3V3iyocTKAZ0KRbjozHZd99BDtO+o4cezDfUxoUQxllAAb
	IDE5yuvgVpVr7oFoM6n5QEDQCa4Awjt8prsTJ4wbQk3ihAuG5y1saKEP/JxpHgc/+4t25Gu7ZF2
	xx61HCDuYEnkpLe/Y32NZrvxneg9o28fm+/RZToRFuI1IgNKoLyXDFjFtZgltPLrWSbtoub8oHh
	E+m9c4l1xR2Rq5J5hcoz1rBbic0STzn4byTghQqmiI5nyzmpuV0yMN8UiFSXusqddJsR3enGOe6
	VCOLk+yKCX/VKCikRkdAcYv3GKRiC/kOOuHI4w+Fos4C5Mc16J36Ks9eG1JaturGcC17S2RsdIr
	9HC9P0okK3dXKDKK5oit0y0DkcVs=
X-Received: by 2002:a17:90b:1fc8:b0:3ac:9a5e:9ce9 with SMTP id 98e67ed59e1d1-3b166ca430cmr1280076a91.29.1794271125097;
        Mon, 09 Nov 2026 16:38:45 -0800 (PST)
Received: from alpine05.ht.home (107-190-31-93.cpe.teksavvy.com. [107.190.31.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b168eacb73sm640209a91.1.2026.11.09.16.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 16:38:44 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v5 3/9] selftests/bpf: libarena: Make spinlock trylock match arena_spin_unlock
Date: Tue, 10 Nov 2026 00:38:32 +0000
Message-ID: <20261110003838.8739-4-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261110003838.8739-1-emil@etsalapatis.com>
References: <20261110003838.8739-1-emil@etsalapatis.com>
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

The arena_spin_trylock() macro is currently only used within the
lock slowpath, and so does not disable preemption. However, this
means it does not properly pair with arena_spin_unlock() that does.
Rename the existing function to arena_spin_trylock_raw() to denote
it just handles the test-and-test-and-set, and make a version of
the function that handles preemption. Also add an _irqsave() variant.

Fixes: 88d706ba7cc5 ("selftests/bpf: Introduce arena spin lock")
Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 .../libarena/include/bpf_arena_spin_lock.h    | 36 +++++++++++++++++--
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/libarena/include/bpf_arena_spin_lock.h b/tools/testing/selftests/bpf/libarena/include/bpf_arena_spin_lock.h
index 055b5892cb63..c0eedb59986d 100644
--- a/tools/testing/selftests/bpf/libarena/include/bpf_arena_spin_lock.h
+++ b/tools/testing/selftests/bpf/libarena/include/bpf_arena_spin_lock.h
@@ -224,16 +224,35 @@ u32 arena_fetch_set_pending_acquire(arena_spinlock_t __arena *lock)
 /**
  * arena_spin_trylock - try to acquire the queued spinlock
  * @lock : Pointer to queued spinlock structure
- * Return: 1 if lock acquired, 0 if failed
+ * Return: 0 if lock acquired, -EBUSY if failed
  */
 static __always_inline int arena_spin_trylock(arena_spinlock_t __arena *lock)
 {
 	int val = atomic_read(&lock->val);
 
+	if (unlikely(val))
+		return -EBUSY;
+
+	bpf_preempt_disable();
+	val = atomic_try_cmpxchg_acquire(&lock->val, &val, _Q_LOCKED_VAL);
+	if (unlikely(!val))
+		bpf_preempt_enable();
+
+	return val ? 0 : -EBUSY;
+}
+
+/*
+ * Trylock variant without preemption disable/reenable.
+ * Used within the lock slowpath.
+ */
+static __always_inline int arena_spin_trylock_raw(arena_spinlock_t __arena *lock)
+{
+	int val = atomic_read(&lock->val);
+
 	if (unlikely(val))
 		return 0;
 
-	return likely(atomic_try_cmpxchg_acquire(&lock->val, &val, _Q_LOCKED_VAL));
+	return atomic_try_cmpxchg_acquire(&lock->val, &val, _Q_LOCKED_VAL);
 }
 
 __noinline __weak
@@ -346,7 +365,7 @@ int arena_spin_lock_slowpath(arena_spinlock_t __arena *lock, u32 val)
 	 * attempt the trylock once more in the hope someone let go while we
 	 * weren't watching.
 	 */
-	if (arena_spin_trylock(lock))
+	if (arena_spin_trylock_raw(lock))
 		goto release;
 
 	/*
@@ -527,6 +546,17 @@ static __always_inline void arena_spin_unlock(arena_spinlock_t __arena *lock)
 		(__ret);                                 \
 	})
 
+#define arena_spin_trylock_irqsave(lock, flags)			\
+	({							\
+		int __ret;					\
+		bpf_local_irq_save(&(flags));			\
+		__ret = arena_spin_trylock((lock));		\
+		if (__ret)					\
+			bpf_local_irq_restore(&(flags)); 	\
+		(__ret);                                 	\
+	})
+
+
 #define arena_spin_unlock_irqrestore(lock, flags) \
 	({                                        \
 		arena_spin_unlock((lock));        \
-- 
2.52.0

