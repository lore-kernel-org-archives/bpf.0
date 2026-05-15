Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27A13DE454
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 05:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778821494; cv=none; b=myj7/H4LSmQnt9LpyqAYX3s3Ef/tMUsWfKUXB3wG9vV7bUDCW3zS+VfH8VZJ/mf6P4vlQN0ldxk3A3Zd0JvYlnWnONLo+D91k2DexHFc5cOwY/owdy8Z0uA54/7+cJHA8dot+mNVgcB18PtRI9CGfx2gqSOVYwrM5IoIIZJEkLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778821494; c=relaxed/simple;
	bh=LE8jfo45c+SRwiSVqT2/Y0314N5ZIYQwpVi4AglxEfA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZvVIFYeQmmUbvB4uffjNEqYEGx2LkWEmYRj12qAXWz+hz0+xE3qImOuLbtJz34EFajND7JicDpI7AB63d0r/DuV7aZVmsENniFgiFYVZFPx1fLU04lBcAz5Nm1gr/d2qOV2+EfF3ey8I0EfxeBjEQPHMCeyZHaRrXwkLoh1g1zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D4QTrN7P; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4QTrN7P"
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-c80227c9572so4116057a12.2
        for <bpf@vger.kernel.org>; Thu, 14 May 2026 22:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778821492; x=1779426292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MDkpadn+ZjaKcKAsJOyp81emebQ7DUn9DAmh7WWqOus=;
        b=D4QTrN7PD1+oEKiUNYqxgR6J366MMhDtyJ+JYW0kcNKsWypaLjkETtulk2EdPwf3W9
         Q2F2+ijWPXcekrxR31bqYEK4pshu8dL1Ut093yyD0G1+kCbAoF/2DtmgL62gdXGftvO/
         8j/ZFG7RYgTsEKysbLS2v1z359E4rL9GIrIltW8+QIItRK6rEUKSK8CH6Wzj13Q3dQOf
         M4BhtUd2KBqCfpecKwfCUxkIQo1cUit6aW1sh+ZZuQZ4dj1g6MkzdcSEc7PuiYU22G+d
         ErVJeNNXdDznoojXLA9fasljsaXnuMUzfFXcVuHanUrOnEtnTuqK5fTO7PQ+iYp3ZcBC
         Ukuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778821492; x=1779426292;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MDkpadn+ZjaKcKAsJOyp81emebQ7DUn9DAmh7WWqOus=;
        b=VsJ9mtPtloQBSMsTrIOCXWrff1H0wU5x/KyrrS4y4ajFLbPrUqZ2yv399wULuKnCJE
         ps8hY9q+mG5u9qvuLjui92SdPZyVYLqSPqO/iwMjxfN8K2BTsU10onp6mEi8PknUSfSS
         PBZVZERoOhGxW/pZZvwTzi+6tz6gCAAgbfaG3l/p4DsKz/62RfM/cQfpUwP3trKnLR6/
         Z9LtXbFkux560iwQa+kSIX53Tymo+Wf03Lat92p4IAKydpFJWJlxE3cf/iE+w1IbEjOA
         h74bWeQKCAVMNpTpv+D9hNygpTDKjPS6KCt0MJjJxYlp1qZh0iK+3OHZ2ilZRZJHMtY5
         yWZw==
X-Forwarded-Encrypted: i=1; AFNElJ9tgNGzzy57T9I+IJedxtWwK02AMeMBhqQIlUXxAig1nV+5Nbs1S46l2lpijcpkxhaPDUM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu2Ea7uiKP9ZXC4ci/FhqFDgnnZf6EQKjDqCYYpUuyRZoV+1RR
	rSX9AapYzv8wV5Ds5K8Fmg44bJofhoFQ/84B71XHczcjX/E4NunhyRDm
X-Gm-Gg: Acq92OHVXKe5iepj82pm/j1vugsENMBe+9wA6dPzOIlMLfMULQiVqeQRdcSCGITRlQV
	37nu85XyXlM0aRC9CIlAKks+qoUV5SPyuZ0PXFKXasceG9+dLJVS/Ibed86YJGz/UgPHzb0N396
	eHhMErlixBnONX020io0Cao/1OWEb1MbA3AWCNuEEslYwnbBCuOswdUMN4nWek1MLPGjy8PWmwk
	AbjLobEH0cT7nzz4udF2gJNyTGPdY7iteHFtpm5q1uh0MO7MH3nEZL1P5wTuGXiaok1tgv1QLUs
	/jOsvL4eYug7OhNtpkeoGFnvqgfD6IFQn8NqphCFTN86cYgQGhNDKqv17ILBpdj/Tk9rLGFzh3N
	ZHTg9vDSNtvTQTn5fLGG97MP6YJF2O09YipK2EPCRfvF/OchyNqiT95TddJg3iXEwSh8CtiuFGk
	+fT30AVVKNAbNMWUd0JpRWSHhEckGFzoo=
X-Received: by 2002:a17:903:1a8f:b0:2b7:86be:7673 with SMTP id d9443c01a7336-2bd7e85fce5mr27404215ad.6.1778821491625;
        Thu, 14 May 2026 22:04:51 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5d234540sm44205615ad.79.2026.05.14.22.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 22:04:51 -0700 (PDT)
From: Zhang Cen <rollkingzzc@gmail.com>
To: John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zerocling0077@gmail.com,
	2045gemini@gmail.com,
	Zhang Cen <rollkingzzc@gmail.com>
Subject: [PATCH] net: skmsg: pin the delayed-work psock in sk_psock_backlog
Date: Fri, 15 May 2026 13:04:37 +0800
Message-Id: <20260515050437.104716-1-rollkingzzc@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sk_psock_backlog() recovers the psock it operates on from the delayed
work item, but it takes its lifetime reference with
sk_psock_get(psock->sk).
That reloads sk->sk_user_data and can therefore return a replacement
psock after the old psock was detached and a new one was attached to
the same socket.

In that case the worker locks and drains the old psock, but the
reference it acquired belongs to the replacement psock. The exit path
then puts the detached old psock, which can underflow its refcount
after the last unlink while the replacement psock keeps the leaked
reference.

Take the reference on the delayed-work psock directly with
refcount_inc_not_zero(). If that fails, the old psock is already being
dropped, so skip the detached backlog instead of processing or putting
it. This keeps the worker's get/put pair on the same psock whose
work_state, ingress queue and state bits it manipulates.

The buggy scenario involves two paths, with each column showing the
order within that path:

path A label: detach and reattach path   path B label: old backlog worker
1. The last unlink drops the old         1. Delayed work resumes from the
   psock into sk_psock_drop().              old psock embedded in work.
2. sk_psock_drop() clears               2. The worker still sees
   sk->sk_user_data before the old         SK_PSOCK_TX_ENABLED on that
   TX state is cleared.                    old psock.
3. A new attach publishes a             3. sk_psock_get(psock->sk)
   replacement psock on the same           reloads sk->sk_user_data and
   socket.                                 refs the replacement psock.
4. The old psock is still queued for    4. The worker locks, drains and
   delayed backlog work.                   finally puts the detached old
                                           psock.

Sanitizer validation reported:
Non-fatal target warning: refcount_t underflow/use-after-free warning from refcount_warn_saturate triggered by sk_psock_backlog putting the detached old psock after last_old_ref_before_put reached 0.
use-after-free

Signed-off-by: Zhang Cen <rollkingzzc@gmail.com>

---
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -684,12 +684,12 @@ static void sk_psock_backlog(struct work_struct *work)
 	if (!sk_psock_test_state(psock, SK_PSOCK_TX_ENABLED))
 		return;
 
-	/* Increment the psock refcnt to synchronize with close(fd) path in
-	 * sock_map_close(), ensuring we wait for backlog thread completion
-	 * before sk_socket freed. If refcnt increment fails, it indicates
-	 * sock_map_close() completed with sk_socket potentially already freed.
+	/* Hold the delayed-work psock itself so teardown synchronizes with
+	 * the same object whose work_state, queues and state bits we touch.
+	 * If the refcnt is already zero, this psock is being dropped and its
+	 * detached backlog must no longer run.
 	 */
-	if (!sk_psock_get(psock->sk))
+	if (!refcount_inc_not_zero(&psock->refcnt))
 		return;
 	mutex_lock(&psock->work_mutex);
 	while ((skb = skb_peek(&psock->ingress_skb))) {
