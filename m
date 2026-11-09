Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794248463;
	b=F+1eJZeW/vOdiaIyLgUX5MiGSoGMuEgrB3hEt+WYBjwDXlwofW8Hsw6slPxPDpEw16Au
	 sZeUzZWJXHffddx8a+8vuWoCOWbVhYyQG5hRiDKk1Kx+S6GJxTP0m+Y0OUCd5BCCmSo4x
	 JhPrrwnJOIVo9DFeRb/oGUzcgSVTsRb0/tglomA5A7NqsE7WXS16DWY4Hq7LObKgZAUmE
	 xtVVQ8MoP9/v2Vs2U6C4qJCYR6D1x8OOQuRFsJ4NtkPmmZQNoaeHho46jWB93uf9njNg5
	 EJmHcVDsDuEap2odylZ4XTOLDO6W0tC70IjX8nkmGIGyLwSc27/CJSms/kf563bLcDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794248463;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=gEPELYJHRhDoQ8vUQdhiZRZ4YFN9U+y4r/BTZwiRPj8=;
	b=FSmKHiwO+ZmBZigEc1xnoL6oDAufLt5wD6lML9DN4lJMvyTkCL7hQoFpZuMAfC7hVpk7
	 obyLD9cH4R8H4gFeOk5CPCm8xeW78TJkn5KPk6fhPsDwium1Rjtanp2WkhBJaB1w4o0F1
	 wxM6AM7Le9ykojcRpeoXVJ+vtOApYwU4sNGMgyr+eP6EcKJHlr0/2k9VSYX434+kElPFn
	 ANhtX0y0Ovmd397+ZR8URxFZ1U65y2At1Go9RhoPeXHXYHqPvDdLvRY/XikQ/2YfJu/oa
	 tpVRWn0fSxn67RsSQhBYxCtUcG0Ivg8zWtyTTc/gtoJa+Zoph2ItBOYauGVU19JubLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b="BiezL0/0";
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F44660A261E
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 18:21:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F44660A261E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=BiezL0/0
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3b0bbdeae06so702051a91.1
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 10:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis.com; s=google; t=1794248462; x=1794853262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gEPELYJHRhDoQ8vUQdhiZRZ4YFN9U+y4r/BTZwiRPj8=;
        b=BiezL0/0aX92dryYlFDAIacCFm3iH29XPoLeOi+WZHiCfLg+VM2IdNcaO1iLbCBKWj
         cuXvDPpOFyOBS2KMXWIAmftee7iyISrgnm/Cg99gDccNKssRkHf2strJpOW7CpIH1l8k
         h28NLksiV78UOEAerXFA9JD9zrQKCL0kf6TiBNhCTAgOqOLeaacPlsjqATnzOSSF1TjB
         dx8Jt5fqu7r2z1+gC2hGd5yer8rueynhUf1zA4diWpjv34akR4FgppfFgk80Zxj2ziYt
         lw0yln3KiK4uR3q7YXcgsTJ1jEhLgQHV3cHMinoWhuIxDC0/c0YEF5conf1hDJpz9Jjd
         qN3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794248462; x=1794853262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gEPELYJHRhDoQ8vUQdhiZRZ4YFN9U+y4r/BTZwiRPj8=;
        b=MOO8/EE/acbfY3MObsROB2CrR5yzMs8mKn3RTIhNeoMY5w9fb1Eodz+rf9slG13qVf
         NPBqHtEaiovDvTDEnRTKffDR+mbvTkUVo4hxuIFpt0mm27Hd0HFlR61JUKfA/SSZWWKf
         11ClmnNGpXmK6AIoK5Tdot2GUXknOpJ4EOt5ucNzlWlOGIjzyp53ODMjuj33Kz55YLFF
         H2nuVuVKCB/FVg2bwoyT7067skEyLplmyu0khIgfI4bwRJKo4qnjL4O47kT0Sy9byKdg
         hBckYxlXqarC44/7tAdV37khhkgFUCVW68cfJMzeTraQSJQZB2HEAi7YxUxa7xdrGApS
         5oOQ==
X-Gm-Message-State: APuU4Z8QvxSwzTatL/LHBnW1BfTtXTmpsMivdpxPbSobm4hN0hFof5rZ
	LaCbSAefweO3TgkCNSktFbfW/fnjJTVNW88FDxc2DqkNl89FTQWe5lGle749BADa9jzq8AHIcms
	vXMu0eRk=
X-Gm-Gg: AYBFou3+YJV5QdPV9N17wKdfFYuxVOp/0UhSHzeAlzFS/340V2jhuyKiGYO/U6lNvd4
	egj0fI/r4tx3gZ1jnWbCgJMdQeGBrBAcHC27lEq5wWdXhSprRygxSkQBXWdkOqlUFcioZYiu2oy
	JSv+dC4kF3Ifp8/egspWTcoZgx6jxZO0eZdN25vRWqNPBu8jXJeCBh3SEOQsL6NoaN/q3xC/sG3
	DZKzp7gI58+oZqpWibSxFr1bnMHgpF7bEmWMQau9ID5FshNcLD+v284r7W6G3C2IW8R10El4qi1
	4SOteLyyCKis85q/Abg7S7YsyYPsnF8IwmVERIaez2qJY+by1HP4ykV5FejVePqPUIO+oVE0pEl
	RccZvP1VzIf83xC4Q2wGD+5rmzYLg8jiRgevoRALOn0cyZi0fkcfcADt1gt102qsBUnFDWps10p
	klWYjsZPY5flLjjTVMr7Uw/OI37WaE1L0O4vg/SwVBO+661uIlNh8w33mIKlV9lvq+Y0cIr0KN/
	BefJo7tmvAUaWPiWb4d6kwapgh+Z1wtBvGpH0mEmmBrZylrTBS4WHvC9dDJjUNzVkCRDw5nOrFt
	zHRtvPrDhU3VbRbchpaQVmDU6SFu5HdSYmAC7dDf3FF5NKKvyIQgheHDHGqsOkd6vkPTmYe+0OE
	yRt9q2uVa9zhBttS6quytGS3OsDHwth66WrXHDP1GCD5EhsTJxg==
X-Received: by 2002:a17:90b:4cd0:b0:3ac:1c76:61c3 with SMTP id 98e67ed59e1d1-3b166cdc367mr438312a91.27.1794248462389;
        Mon, 09 Nov 2026 10:21:02 -0800 (PST)
Received: from alpine05.ht.home (107-190-31-93.cpe.teksavvy.com. [107.190.31.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1676e2974sm474860a91.9.2026.11.09.10.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 10:21:01 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v4 3/9] selftests/bpf: libarena: Make spinlock trylock match arena_spin_unlock
Date: Mon,  9 Nov 2026 18:20:48 +0000
Message-ID: <20261109182055.7581-4-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261109182055.7581-1-emil@etsalapatis.com>
References: <20261109182055.7581-1-emil@etsalapatis.com>
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
 .../libarena/include/bpf_arena_spin_lock.h    | 34 +++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/libarena/include/bpf_arena_spin_lock.h b/tools/testing/selftests/bpf/libarena/include/bpf_arena_spin_lock.h
index 055b5892cb63..560ee18fd287 100644
--- a/tools/testing/selftests/bpf/libarena/include/bpf_arena_spin_lock.h
+++ b/tools/testing/selftests/bpf/libarena/include/bpf_arena_spin_lock.h
@@ -233,7 +233,26 @@ static __always_inline int arena_spin_trylock(arena_spinlock_t __arena *lock)
 	if (unlikely(val))
 		return 0;
 
-	return likely(atomic_try_cmpxchg_acquire(&lock->val, &val, _Q_LOCKED_VAL));
+	bpf_preempt_disable();
+	val = atomic_try_cmpxchg_acquire(&lock->val, &val, _Q_LOCKED_VAL);
+	if (unlikely(!val))
+		bpf_preempt_enable();
+
+	return val;
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
+	if (unlikely(val))
+		return 0;
+
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
+		__ret = arena_spin_trylock((lock)) ? 0 : -EBUSY;\
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

