Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795055600;
	b=Txm6+JOF72sjBiWrwAZ55+lqmWiP4s4SSomH8MbrQPK9MKTGPpM3OfAwAup3hEz8bXTc
	 1dWyr36ZQh8QrovR9lxTXVX4emFj8uoq3o1DqP/NBQ4hwxuF3Pk+BuFf03KDrOtNesqo4
	 8i5oYO1M/EZH7ciPErQ5aWbRGRQE1ru623VIs/iNLv4ryXQDUvdJV7CFTf3NstVjsFKu/
	 R00fjGBsgL9amCUQH6Zb0NutdYEi5Ex61dpVnyApDItr7RIjFPMDFSrqd79ZybCvd9hU6
	 T/wbrR0mFJph4rCJ4re2JvsgCvMLoe4FqJtjjVqjwJXGN10DOU1vprDpP6oT3UOxRuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795055600;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=eSTQlcfr7aWNzCzMGv98ZXpMo4wDZ/dh6OvhB6AdnV8=;
	b=TBs7jMCjrLK92vWEoiteEOD0pyxMDP54qFLJinGnHCH53nUvtUqTCV/7R+ZjiuIWaEg1
	 jji3Jf9S6OPtpRJbYCu7m8ED2dreEviY1vJ5qUfygOZs4Mem+8ggz0VVc57RwYtixsfhr
	 apR5LLg/9VBDeQsE1UMpafLvGzzgsi6quDygDl6RHhmA+q3eFmsKkeqZviAiak3HIRdkO
	 dRBt0/Huh6gxYsEhyzPmK5MbHjcTupaq3B3xbt6kR0hPBT2bHuEFFhGqldm0uO9IvJCzy
	 9GSySfF1PpRb7iADpKKf9wfxmQjhw2MgsvhB5uxska20c2CUIWH3dm6aDkQzeEx0tCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CLB0O+sz;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB506606A335
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 02:33:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB506606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CLB0O+sz
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-38431138772so419457eec.1
        for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 18:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795055596; x=1795660396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eSTQlcfr7aWNzCzMGv98ZXpMo4wDZ/dh6OvhB6AdnV8=;
        b=CLB0O+szDPkso7maJprAP7ev252n/nLU/zhtaiCLqSUlcfPgkeu+iK6RpQ3nDtG1bv
         SybxS4LFZBlhQVBD1Y2hVskqA/84SebLzWneh57V0vKkb7pkALV9GyCRBnm8afbEBrfG
         gcopIjampdhgrlPL3pnXrW+AVOiNPOFrkjUlgAfFQz2mSCIfXtwekITaJNLTX4HfwEJd
         rJrPy8fMHaEDg/MuxA3gm6YI+B5Bgg2mNcGbUDMATfC5fjlPAubTGs2Uq8cOzBnwTDQg
         dgPa0kfXpGRrM1I9IYST/6a66cslZVCqQKK05O+tRKTEwpgf7EpPY0lLXnW1cNYQ36sF
         JTHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795055596; x=1795660396;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eSTQlcfr7aWNzCzMGv98ZXpMo4wDZ/dh6OvhB6AdnV8=;
        b=1o3DycodOtRsZcPIZbEDmklAwa31rWMZtogdTeq0lrZUtSMsEUCOIMemMMgHdwYrk4
         XJjQy216jKFVH3DO3DoKver1ScrS96H7crkZ4eI7XqnfC58N2TMsZ+wlHVp8+/8je/o2
         Uc7dIBLC4ugN9cwaNdoVZbIE+eaAvx8vCviXRYR7O2FV1OYs5tLn3vfe0XkPTkz85Eck
         J0OYqCBcNNBQSO85WkmmKhy9KsAErNkUa5c7QwJSr3SpHetcilwoqW5rFNZjNPJkbpqQ
         xXd/3x8qakVQqZDCz5d4wXv+xTDjfxclu+tmrVuhWVx8jRx9H2IvDtfpt0+OzrfBxCv4
         Bg+Q==
X-Forwarded-Encrypted: i=1; AL+hErGdD3Ry8LovwQsV8lkQU6Sk9TpVKGUNxiFX5OJe7BQ2/Uwp3YTEmLJPAukKusRqQHCZHV8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+UC+t54bnBSqRycxX6jGfjccjP7eUtjgNZerS/v6LOQrGuWQZf
	tChkzH2oxr4Rz+r7js5vZmEe+SejgqkqfjFMIXVJ84RNeLMDIORkgNmW
X-Gm-Gg: AZFdTZfvabah1WJqKRPaVuUHZMzLqJVpa9YobJnDAkTvJWj2Ru0balo4kL/5sAXRnqu
	djXanyiTDx/H6yEKlgjtsrD6iMDN1dcsir9GabgW7qV8TciLWv7/D0bBbUfeKS7GjZiOleUZP1N
	Rw/C8JYw2/I3F/9hnDLt9IKZcrV3DMT0TipRfnfsiXalBxcFVtO/80fv1yTCjlEKLPsl6fbgVH4
	4p2k7m7Jgob5/j/yTbIBpJmHGWEszXUGw2mKBkVgp5xIveF5E5tKdE/kfmgbCbziH6KnlymkKUl
	aHOok5TfC7DsHkRUTgI96KbAiIidYov6JnoYQxc9L/bT5dFgKB/hIe0FYlhcAq6Y38wNJEn3h5Z
	rnTfZpKDgGfzvbyNhPNZDS4RN7E3gILNE6eySS3fP5+1R3ufwpNECCZxAcZt+EihjQUfV+ZeiJY
	5aJ8JgZWY9kDc/OMOTX/4iwJpjpYgFOiPJI+VnEQxB1rPq3n8VDuaBg2pA3lcywtbW2R6RGQZTq
	ZA5S4pHII8d+M4rbpMcH7JChXuy7C8rGuqfjamxolVLvn+T09FkTuwDoU1YFGXT81ixxrPsrj+e
	aMyN8Leu5gxp7smr1i+UiGdsV1AGinqHmCGjRiArXRr9xOsyFHujjN4Y+MMcOKS3VEk0XyDdoNJ
	zewN9iQXn8+HEM6HUjmmIO4S3wVTAkLINFYugjiiOro4MZO+7gNCplFBHCz48y2EqPJCBvBz5ux
	gL86F4u/n6RomRHqvJh5U98kfxE6PZbaIH+Y3tGBIctI9DXBeDK4pFaykyEHpBs0NJuwPbkuQWl
	p1jcpEPR4dP
X-Received: by 2002:a05:693c:804c:b0:378:2e89:3958 with SMTP id 5a478bee46e88-38280f22793mr3994461eec.19.1795055595568;
        Wed, 18 Nov 2026 18:33:15 -0800 (PST)
Received: from FT6N242TWK ([223.181.117.48])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a6df02adsm13110627eec.14.2026.11.18.18.33.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 18 Nov 2026 18:33:15 -0800 (PST)
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
Subject: [PATCH bpf-next v3] rqspinlock: Keep claiming the lock while the queue head is still the tail
Date: Thu, 19 Nov 2026 08:03:07 +0530
Message-ID: <20261119023307.65178-1-jain.sm@gmail.com>
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

From: Kumar Kartikeya Dwivedi <memxor@gmail.com>

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
that can be a long time, with interrupts disabled. The same happens on
v6.17 and v6.18 for any NMI waiter, as the trylock fallback was used
for all of them. The AA path needs the interrupted context to have
taken its entry for the lock and not to try the lock again, so it is
much narrower.

Only a different tail shows that a waiter did xchg_tail() and will
link into our node. So retry the claim as long as the tail is ours,
and keep PENDING, which belongs to the waiter. That waiter either
clears the bit, or on x86, where queued_fetch_set_pending_acquire() is
a lock btsl followed by a separate load, it no longer sees our tail and
becomes the pending waiter behind the new owner. Update the comments
that described the old claim.

Found with a TLA+ model of the slow path. With this change the model
has no violation in the configurations where the head hangs without
it (an NMI waiter using the trylock fallback, and the AA bail-out),
also with the btsl and the load of queued_fetch_set_pending_acquire()
modelled as two steps on x86; the model reaches the case above where
the waiter no longer sees the tail. A userspace port of the slow path,
driven through the interleaving above, hangs without this change and
completes with the lock word clean with it. I have not reproduced the
hang on a running kernel.

Fixes: 0d80e7f951be ("rqspinlock: Choose trylock fallback for NMI waiters")
Fixes: 087849cca31d ("rqspinlock: Precede non-head waiter queueing with AA check")
Reported-by: Shashank Mohan Jain <jain.sm@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Assisted-by: LLM
Signed-off-by: Shashank Mohan Jain <jain.sm@gmail.com>
---
Changes in v3:
- Kumar's patch with his authorship and Signed-off-by (Alexei).
  Kumar, please tell me if you would rather send it yourself.
- Use Alexei's simpler loop (PENDING is 0 on the first pass, so no
  separate 'new' and no second tail check) and his comment updates,
  which also cover the two stale comments (Alexei, BPF CI).
- Checked the x86 case Alexei raised: the model now has the lock btsl
  and the load of queued_fetch_set_pending_acquire() as two steps. It
  reaches the window where the head clears the tail between them and the
  waiter becomes the pending waiter, with no violation; without the fix
  the head still hangs.

Changes in v2:
- Kumar's approach instead of resetting the tail in the wait for next.
- Target bpf-next, drop Cc: stable (Kumar).

v2: https://lore.kernel.org/all/20261118104758.98620-1-jain.sm@gmail.com/
v1: https://lore.kernel.org/all/20261117225023.36660-1-jain.sm@gmail.com/

Prepared with Claude Code (Anthropic), model Claude Opus 5.5
(claude-opus-5-5).

 kernel/bpf/rqspinlock.c | 35 ++++++++++++++---------------------
 1 file changed, 14 insertions(+), 21 deletions(-)

diff --git a/kernel/bpf/rqspinlock.c b/kernel/bpf/rqspinlock.c
index 111ec80..14d3798 100644
--- a/kernel/bpf/rqspinlock.c
+++ b/kernel/bpf/rqspinlock.c
@@ -378,9 +378,7 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 	/*
 	 * If we observe contention, there is a concurrent locker.
 	 *
-	 * Undo and queue; our setting of PENDING might have made the
-	 * n,0,0 -> 0,0,0 transition fail and it will now be waiting
-	 * on @next to become !NULL.
+	 * Undo and queue.
 	 */
 	if (unlikely(val & ~_Q_LOCKED_MASK)) {
 
@@ -616,29 +614,24 @@ waitq_timeout:
 	/*
 	 * claim the lock:
 	 *
-	 * n,0,0 -> 0,0,1 : lock, uncontended
+	 * n,*,0 -> 0,*,1 : lock, uncontended
 	 * *,*,0 -> *,*,1 : lock, contended
 	 *
-	 * If the queue head is the only one in the queue (lock value == tail)
-	 * and nobody is pending, clear the tail code and grab the lock.
-	 * Otherwise, we only need to grab the lock.
-	 */
-
-	/*
-	 * Note: at this point: (val & _Q_PENDING_MASK) == 0, because of the
-	 *       above wait condition, therefore any concurrent setting of
-	 *       PENDING will make the uncontended transition fail.
+	 * If the queue head is the only one in the queue, clear the tail code
+	 * and grab the lock. Otherwise, we only need to grab the lock.
+	 *
+	 * A waiter that sets PENDING now may leave with -EDEADLK and never
+	 * queue behind us, so retry as long as the tail is ours. PENDING
+	 * belongs to that waiter, keep it. It either clears the bit or, on
+	 * x86, no longer sees our tail and becomes the pending waiter.
 	 */
-	if ((val & _Q_TAIL_MASK) == tail) {
-		if (atomic_try_cmpxchg_relaxed(&lock->val, &val, _Q_LOCKED_VAL))
-			goto release; /* No contention */
+	while ((val & _Q_TAIL_MASK) == tail) {
+		if (atomic_try_cmpxchg_relaxed(&lock->val, &val,
+					       (val & _Q_PENDING_MASK) | _Q_LOCKED_VAL))
+			goto release;
 	}
 
-	/*
-	 * Either somebody is queued behind us or _Q_PENDING_VAL got set
-	 * which will then detect the remaining tail and queue behind us
-	 * ensuring we'll see a @next.
-	 */
+	/* Somebody is queued behind us, ensuring we'll see a @next. */
 	set_locked(lock);
 
 	/*
-- 
2.54.0 (Apple Git-157)

base-commit: 32b66b94c86f009b49668de7340f2ed65aad2dc5
