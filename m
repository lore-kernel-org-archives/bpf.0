Received: from mail-wr2-f1.google.com (mail-wr2-f1.google.com [74.125.225.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676872D6E44
	for <bpf@vger.kernel.org>; Sun,  2 Aug 2026 02:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785637085; cv=none; b=liTWg+qg9j/9ZHDD3Qvy2ge2RdrITHR7pZrHYpvGdcpZrKaIxW8Iu3ngBIh7OqIjebq1+wVSPyixlb5qmbyVjS/ZlWzE28DMR799LFepFi8nFKpa1JmpuiK93X3xLLJZzX/ZHuOslyHuob7+yS/PVCu8lDlgyojO1NoCJ9RbqkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785637085; c=relaxed/simple;
	bh=PH0tOsKSdOqs86+BJ6xaoeGHG94nUInSI9wnQ9S3rO4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sEGI74gHxEG9hke9pqv4OnMCQjwugj0Nu/E8auHbJe76ymYPpSnV9RWsL8ttqSnAl9S8ZvuLGJH/SFewR5tiVmeZI25xtscTwwKK/Px4nazKT/WNVMEClPZNWJvZ+Gv03+X6UbCUa1NnHlxhWVUg58v9YT5szokvzbbDi3TrsMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d+C/r9xv; arc=none smtp.client-ip=74.125.225.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+C/r9xv"
Received: by mail-wr2-f1.google.com with SMTP id ffacd0b85a97d-47f9c6bc99eso735284f8f.0
        for <bpf@vger.kernel.org>; Sat, 01 Aug 2026 19:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785637081; x=1786241881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Qu8AkiHUB1v43UxSk1C1buGbgAPzLEa96nCpwGg4MQM=;
        b=d+C/r9xv9mD4K3sUMwUs0fZXNcigebhDBBs3jHBPEnpdOiYK4U50wAFl34rh8I1XnG
         dammVHCmxjnrNW1NI20O6pbM+Wib05SQRvyZrhnXjmDotDusogK0Zf9W1492JHy9hVhC
         y3qdbhSlaJoFnGldhVFe8i68zAcZPHJWSXokKOnTsV6tukecZGKv/uLb698kXFW+AGZt
         2Kt0vIcosnLDHUPCZuBnWOijYmfaVgL6mYFNqvIVyLPBqe54wQLipyyDoWNgv2g5/Aq7
         6MGqhUcFWMEGcRM+UdunqtHT9IqR4q0jwRueYsVYV/VEMuaKOski/FonbqdJCJ+jdasB
         HZ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785637081; x=1786241881;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qu8AkiHUB1v43UxSk1C1buGbgAPzLEa96nCpwGg4MQM=;
        b=XLu2SwVTEWkqLX3ZaGzcFOALOWprOxROtKNpPgfOrle04dh6dAjWU9+JaCaYwccESh
         wPhJcCP4GWCXI8pVJAPBucKQG8UNX2xOnn11zUuAF1IZIJcbNRchqhAoc8i1Psbwa7I0
         HvwDEgTqvVmB80oLLBH9/HWI6plGyjzIN2stX7WuYc0sqSKUMs/VKFub2BT1JFDpsbU5
         nl05E6YH94Jz9l0yqRbv8gqKy+2XAv0mgSfnieolzUSIxLVI1kOcG26MBciNi/cj7jpk
         ZJKKCPmC4MIbRr5ye4lo9bANYhInTseJJd00UARkJq5+flb4kLoF6DH0aQb+KkKk7eB2
         g7Dw==
X-Gm-Message-State: AOJu0Yzt42K0XMLk3taq1lvl8Jp0VxtmiOenb749MIlAtni4iZMjvdCc
	Bk1xEDIdOtOXloJwuUiZRAca6aMC7UA3ONpyxaX9PgZbnmdLJwDQBQDOONUK3TuC
X-Gm-Gg: AR+sD12v6oU8n2K+HwCkrfcHGxyS+iHIqaL2GqiTuY7gjm9TE7//Qa/fSBWD2ImWJ/s
	TVr2WH4XNHt4m/Up45hY8vTpUvgjI5g3okEHXDOE+Q9ooq9dQ48pnJgQ211dPTYXxTCoxZrsRRR
	X2w9AY0RxPXhRxqGXcnQKP9nZk0cT3ieR2q77DW+auDDtFMY3ZSRrVi1bfD5qyLcYkevv1VQxQ2
	CAUHGvN21IBHqvpCpP4C2KgUD9EQAOmqNmFQ+YxlVPf99yQ6N59EW4Wavtk1YMvnlLQgSCTfza8
	4awuhqeokCS9eB+oMl+yKcLOVWKmaUf4dTwnM9cMjIowDxlOG69sZ+BCslLJd4J6F3eW11wUV/d
	8WHKBm4A++ZUtI+tUjP0rJ+ES82MqRI4XcqsJGjgFl6wCd4oyYJ9+XwInSYre02IVkfEMcF6DeP
	llbaMk4HLl9ksdRCNLK3yWNNCo5TPSgd/N4vV//L5n72QwZm0plVNlHmcHz43EkPF6mZInmUX2P
	QKzKMeW2Arwz0Or22QFTDbS8df2HWvp4uu/32fJ9ZCkKaoc+nv31NUZKVlHa8fZwzah6XPuLbMc
	Bg2mcY/zpLOHKOxXBk15KWlJ568=
X-Received: by 2002:a05:600c:34c6:b0:493:a966:d5b5 with SMTP id 5b1f17b1804b1-4980c66b50emr98886845e9.2.1785637081309;
        Sat, 01 Aug 2026 19:18:01 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807bb45ebsm71486525e9.4.2026.08.01.19.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 19:18:00 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v1] rqspinlock: Reset tail when preserving queue on deadlock
Date: Sun,  2 Aug 2026 04:17:59 +0200
Message-ID: <20260802021759.1139457-1-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2942; i=memxor@gmail.com; h=from:subject; bh=5UB0j91JgrCFeTKJ8xwSP39nxPTBhU6U1KuaHreJCKY=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIStvBffekwLfLz5x7NqhcCFk6kvh4rKtARF86jOnOYhu9 r19Sdy6o5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABPpiGdk6Iiw/i+e2HLZmulU wpUbUXu46pdF6kvdmrD0iVBG17VLLgx/xS7fyL27Xiv4NiOPYfb9K9PzJS7u3b+1Sm3ucTs5vy2 /GAA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Currently, the destruction of the waiter queue is suppressed for
rqspinlock in cases where a deadlock is detected. Deadlock checks happen
relatively frequently (on entry for AA, within 1ms for ABBA), and waiter
threads may not be involved in locking scenarios involving deadlocks.
Thus, it is useful to not flush the queue and let other waiters take a
stab at acquiring the lock after we detect a deadlock and exit.

However, we need to follow the same logic as what we did previously for
the waitq_timeout label: reset the tail, and if we cannot, signal the
next waiter appropriately. In case of deadlocks, this signal would just
mark the MCS node as unlocked, and in case of timeouts, it would signal
RES_TIMEOUT_VAL. The difference thus is in the value propagated, which
decides whether the queue remains active or gets flushed.

Not doing the tail reset, and waiting for the next waiter can lead to
cases where we are the final waiter, and thus no next waiter arrives,
leading to intermittent stalls in this path. Once the next waiter does
join, we will be unblocked. In the theoretical case when the next waiter
never joins, we risk stalling indefinitely.

This can only happen for ABBA deadlocks, since entry into the wait queue
is guarded with AA checks. A precise sequence of executions leading up
to this scenario can be:

CPU 0 holds lock A.
CPU 1 holds lock B.
CPU 2 attempts lock B, becomes the pending waiter for B.
CPU 0 attempts lock B. B has locked+pending bits set, thus CPU 0 queues.
CPU 1 attempts lock A.
CPU 0 detects an ABBA deadlock.

Once deadlock detection happens for CPU 0, it will sit waiting for the
next waiter in the queue to populate node->next, which will experience
delays until such a waiter arrives.

Fix this by adjusting the logic for the check for deadlocks preceding
the waitq_timeout label. It would make sense to consolidate code for
both cases and use 'ret' to distinguish the value being propagated, but
that is left as an exercise for a future refactoring task to avoid diff
noise in this patch.

Fixes: 7bd6e5ce5be6 ("rqspinlock: Disable queue destruction for deadlocks")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/rqspinlock.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/rqspinlock.c b/kernel/bpf/rqspinlock.c
index e4e338cdb437..2129defc4a9a 100644
--- a/kernel/bpf/rqspinlock.c
+++ b/kernel/bpf/rqspinlock.c
@@ -572,9 +572,10 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)

 	/* Disable queue destruction when we detect deadlocks. */
 	if (ret == -EDEADLK) {
-		if (!next)
+		if (!try_cmpxchg_tail(lock, tail, 0)) {
 			next = smp_cond_load_relaxed(&node->next, (VAL));
-		arch_mcs_spin_unlock_contended(&next->locked);
+			arch_mcs_spin_unlock_contended(&next->locked);
+		}
 		goto err_release_node;
 	}

--
2.53.0

