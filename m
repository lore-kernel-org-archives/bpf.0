Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794955832;
	b=Htd6FMuc6zUOScRwIRFBlx3mV57p5S0x5YXlhIYk9cbGnScclI4WglFrnBq/L308eXLa
	 k7BQekAMq0wcMv4PUOi7FsmeVddS5IDqw2B2e+5X1EzExSGopRkOB/Rq3Oh82aKU7ZPbo
	 qJfdo/2T6OE8rDSyQLJU7HXXO7TkSo0TZpNEYP44V2CBWHnIpXdJD/SPJIw9h3BpqbNtk
	 RCe7mg/EkrnvuZCRt2YI97saNM2ecJhBrB7kgktW8K1driiWNlAoRphzKk1xZGbGc8+S/
	 WDhE8aSeOleRS3vw0exkAdxX/8cZkz3HgQWR1A1f4t+nhRuZRsAC5oskGwsy3geuXuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794955832;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=v5LZprz+0la2YSbdDTFfgchlevOg7w1sc283MrLEFHQ=;
	b=0h1KBidLFi+e6PYdeGLRxz5A3sMHWGdEa6y3R6vBj6xQcPrr3sHl8B8eKRMHKFShj3Nz
	 KRlCkcsfqdWE6I2G8SidQ53tsm41D4VtU4+Xcy1nN4GM7xbHnomb1bIFIItDvUfcU0wPU
	 THTgqTXW2gr6hDgwI9vVM5fvA3SvCjmxA/B/iyKQfRHjr4A7DkLHIoJOXYQtF0UlxwoVU
	 EV8Kg54SQL/OAg0nlC8WfG59RY6w/1yzsAaKxovI+HRVK5lgSSgCaU5m8emcnzdzsRVCq
	 a0g4L2akFLaj1wlvR60qmdneb926/b64EBWzB/rY5QH/DPcmsUuEZWAP6ateKseoS3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WdfVn2u4;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF9F606A31C
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 22:50:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ADF9F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WdfVn2u4
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-380b40319bdso703779eec.1
        for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 14:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794955831; x=1795560631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=v5LZprz+0la2YSbdDTFfgchlevOg7w1sc283MrLEFHQ=;
        b=WdfVn2u42i3Av2qTH269DHP7zpKExvU06VLNqsFEEqviGe9sXQ76Eh4dOyXZ4eGA4t
         PqKsufesmyweD/WXi684Ji3/ES1nIoL9OUJb42HGmSApFCq5t1adMRf73YlCybw/7S2p
         2LSR+rREHFK4K7L3ZyMOeWuOU/3VqL+j52Eyclx6OgI2RNM8XUrJe5M5E8NiJp0go6mM
         Y8QHkvrACn6M6rrEWQoNI5MoqHBWOyx8Va1Cbd76gstMjoxYZFE1ov3X3tt+TzkaVb8a
         CXrSyklHehkrZDj0pB7tWZI8kElbbc8tbvFJ81BdiYtV96aEhP4lZcoffKB7nREtIutX
         e8qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794955831; x=1795560631;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v5LZprz+0la2YSbdDTFfgchlevOg7w1sc283MrLEFHQ=;
        b=AqcJGCkIbfbhpyissf8ysMia7y0X8hZoyoHG8J36nQ8xYi+WxRzDjH+j88Uervs0tU
         fvlSOmrWfxbYM2Vw5CzMu98jJYjNCkXyrXXIxYrjbWLrNokV0dp9lEC8fvP7/ynPHFbr
         +tSoezgBpilFlLAy3SuNxY3dQ032L/hU++W5rgTq8DOW52DI2ipoVivT/zPkoC8O6jsN
         d/vooqGJr1M7AOqgi1U761JxjATb97Gl4fN3XPa7nbBdgE09RJMKRCch8qF63rOQ/J87
         tTROUv36gcwi1Ii1PZSd2WT82Qw1G8trT7O2ZTqYWDTFz7S4523S6T0LUdFsnsT/jkRy
         WbkA==
X-Forwarded-Encrypted: i=1; AL+hErG5065cu14+C4Dx8BUpCCrDQCZkvHn//URiRZAUU3vrf9iTaVYTp/1vQBk6a3YKl9oNl1A=@vger.kernel.org
X-Gm-Message-State: APuU4Z9ksaOJACgXSwufRf5y9AojKKO9+dnW3S1f/+BK0kj2tJekNVi3
	FvYiGSaeHHpmoHsZQVpaMHLmrY7Haz6xELhxBGBrCQLziUhi7gTVx+SY
X-Gm-Gg: AZFdTZfzft6SLzmUpIWL/ulV7ZFB5GqUKVYGSuDZS1HTZPYJtgud512bONoJkBbj4dY
	r5xcJcmHI1sNi4pwmbRwWyJRL9Rg+tjAnCRildAxrFZs7fmNZZqDb0wTgB0FGBKtMVSoOsbuwi0
	OTBaS3psE4uPYaos8mYuGyAhDfS+rAbvq5QHh+zISt9JEOdI9YzyuBxs81d39J386DomLCuoXwF
	aVDZ3pi+1p1b3w5Xl+kqnWYGTxgBhV+WfuidbsYfQxXS+rwgO06n6PGDu3YuYjAFFOCdQvItUFL
	LodHkUOjs85e/5TORoYI/V87gVWvT3dUOkBeBKl84GfTEjF9n1AtsAF/C2+rReTYOGX20JGujRg
	0Cayy30TTXY6ZpIGuJtUm6Ccgh3XIVR/zSRyXcEj2F3GVDx2t3YqtOtHiP242wI7hEzSk5GnwS6
	o9LDhFijHuhdPhz4D+X0qBbUL3UPWsicVGDmmysduiVkhiqkl3134yni1a+jxvRh5hR5tATD72T
	QCw08C2Ac66bVxF+ajHaJUHOTb4AOIt/1IVmKjhM9dZkS16F1fABR4Od9qO+rLVjCMYmBapofT3
	t73d75vjH4Yacd1OgMySSehbtwtQShNn6gEbTwYx9pYTBq/CEf1w65plZdPrQvhTuh2Wqse6EVp
	Nk8+YQ1V/DL43eSOvKuujjDnJjwxKvEevvf5ubDOwSWc2Q4D1CxMZUPbBnCnVrLB3gv66A34kEu
	DvVZNilGT8hLU69QSqkQoILm7bImJCgg+uOStGcYnE0YSgneCr3kujS+/7jOx7YvqPlM7H6j3nv
	lnLAVpdQIezPw==
X-Received: by 2002:a05:7300:101:b0:375:388:a6d5 with SMTP id 5a478bee46e88-38281213cd5mr745964eec.32.1794955830577;
        Tue, 17 Nov 2026 14:50:30 -0800 (PST)
Received: from FT6N242TWK ([223.181.112.111])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a6800338sm1299282eec.11.2026.11.17.14.50.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 17 Nov 2026 14:50:29 -0800 (PST)
From: Shashank Mohan Jain <jain.sm@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf] rqspinlock: Reset tail if no waiter queues behind the queue head
Date: Wed, 18 Nov 2026 04:20:23 +0530
Message-ID: <20261117225023.36660-1-jain.sm@gmail.com>
X-Mailer: git-send-email 2.54.0
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

When the head of the wait queue claims the lock and its cmpxchg from
n,0,0 to 0,0,1 fails, it sets the locked bit and waits for node->next,
with no timeout. The comment, taken from qspinlock, says the cmpxchg
can only fail if somebody queued behind us, or if a waiter set PENDING,
which will then see our tail and queue behind us.

In rqspinlock that waiter does not always queue. After clear_pending()
it goes to queue:, and two paths return -EDEADLK there before
xchg_tail():

 - the trylock fallback for an NMI waiter whose per-CPU node is busy
   (in_nmi() && idx > 0), or when idx >= _Q_MAX_NODES;
 - check_deadlock_AA(), when this CPU already holds an entry for the
   lock.

For example, with the queue head H alone in the queue:

  CPU 0 (H, head)                    CPU 1 (NMI, idx 1 on another lock)
  reads lock->val == H,0,0
                                     queued_fetch_set_pending_acquire()
                                       sees tail H
  try_cmpxchg(H,0,0 -> 0,0,1) fails
  set_locked()          -> H,1,1
                                     clear_pending()   -> H,0,1
                                     in_nmi() && idx > 0, trylock fails
                                     return -EDEADLK
  waits for node->next ...

H now owns the lock and spins until another context queues on the same
lock. For a lock that is rarely taken, such as a hash map bucket lock,
that can be a long time, with interrupts disabled, so it shows up as an
RCU stall or a hard lockup. The same happens on v6.17 and v6.18 for any
NMI waiter, as the trylock fallback was used for all of them.

The AA path needs the interrupted context to have taken its entry for
the lock and not to try the lock again, so it is much narrower.

While waiting for the successor, reset the tail if it still points to
us, as the deadlock and timeout exits already do, and keep the lock. If
the tail has moved, a waiter has done xchg_tail() and will link into
our node, so keep waiting for it. try_cmpxchg_tail() reads the lock
word first, so the loop only adds a plain load while a successor
finishes linking.

Found with a TLA+ model of the slow path. A userspace port of the slow
path, driven through the interleaving above, hangs without this change
and completes with the lock word clean with it. I have not reproduced
the hang on a running kernel.

Fixes: 0d80e7f951be ("rqspinlock: Choose trylock fallback for NMI waiters")
Fixes: 087849cca31d ("rqspinlock: Precede non-head waiter queueing with AA check")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Shashank Mohan Jain <jain.sm@gmail.com>
---
Prepared with Claude Code (Anthropic), model Claude Opus 5.5
(claude-opus-5-5).

Based on mainline 63fdb511c27a. bpf and bpf-next have the same
rqspinlock.c. The TLA+ model and the userspace replay are not part of
the patch; I can post them if they help.

 kernel/bpf/rqspinlock.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/rqspinlock.c b/kernel/bpf/rqspinlock.c
index 111ec80..c50afaf 100644
--- a/kernel/bpf/rqspinlock.c
+++ b/kernel/bpf/rqspinlock.c
@@ -635,17 +635,26 @@ waitq_timeout:
 	}
 
 	/*
-	 * Either somebody is queued behind us or _Q_PENDING_VAL got set
-	 * which will then detect the remaining tail and queue behind us
-	 * ensuring we'll see a @next.
+	 * Either somebody is queued behind us or _Q_PENDING_VAL got set.
+	 * Unlike in qspinlock, the waiter that set _Q_PENDING_VAL may return
+	 * without queueing behind us (AA check, trylock fallback).
 	 */
 	set_locked(lock);
 
 	/*
 	 * contended path; wait for next if not observed yet, release.
+	 *
+	 * If we are still the tail, nobody has queued behind us and nobody
+	 * will link into our node, so reset the tail instead of waiting for
+	 * @next forever with the lock held.
+	 *
+	 * n,*,1 -> 0,*,1
 	 */
-	if (!next)
-		next = smp_cond_load_relaxed(&node->next, (VAL));
+	while (!next && !(next = READ_ONCE(node->next))) {
+		if (try_cmpxchg_tail(lock, tail, 0))
+			goto release;
+		cpu_relax();
+	}
 
 	arch_mcs_spin_unlock_contended(&next->locked);
 
-- 
2.54.0 (Apple Git-157)

