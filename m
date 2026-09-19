Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07651A262A
	for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 17:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789838093; cv=none; b=G9K+B6gvdo67zEYgMHukGqc1PU7cbiMTPWNkTn1XV2cSQAKaZxMan6GDN/JU/NTwzrryPRPC6/JHIn+1pve6n1FP+rmBD1M5EcxjtEXzuEdksVLJAWqxo3w0HeWxsynujpdinM8REDu0bUy5FUDd/BO7tT4dgqxeKgWqtPqngdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789838093; c=relaxed/simple;
	bh=PGZzHUHFHYTXrrUg2O+WQoA1hsv6kLUB3pqq1Y2X5Ww=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TyFxowXS2JRUTNGxHzKpgLTuFGBOBtJHeKDr3RoVSKgrmsb23KAs0rfOg37kXlw6Gy+7TW+Eq6w8zCNdLugVtXV54bBfNIzvXUmu7ylVOrgSzYaHZgGNM/xY6fqnh3NVbAebP/x/8NiLiPOKymBCxzktI1qDshiRSfaC8k2n3HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JXsKlzUi; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JXsKlzUi"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e721b5503so16900545e9.0
        for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 10:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789838090; x=1790442890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PO9QkOcRvzbwAD+Es+kdxYQwQzMtVSQSyoVPRMtp9qc=;
        b=JXsKlzUiuVQ70d3qjdMMHWK2F1U5S58ajPbDMSohtnfWFbtCJYYCaZ72UjXsKIyzCo
         0q12iZIfHv60FK6yB/rMcd79FHSLSzwL83awh9uU+QwFDhQIJ/bCIU3cXrxywPdqSPnM
         b/olPA6H8fMEvOo3nHJderxkzxf6qaW5POrO0uO0wxrRYTgTbr3ESTXE9GQ6s3bpkkx2
         2i1nVAWJLsx2NRwSKspdaZM4fEheb2jZ+lLwgEFuaQ2lXb8gI+qmyPTlrFOlUp9xp3ib
         B0vLkkFd3qbnXG65SWnwmPTRYE4pGHNaoutWKFBuAM7GvYySQJC60rhuYB/ZTVfLaLt9
         lT4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789838090; x=1790442890;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PO9QkOcRvzbwAD+Es+kdxYQwQzMtVSQSyoVPRMtp9qc=;
        b=Frrov7kzcL13f4ycwhjtMAtl7i8RolzjDrj4MM9x7+U/kOMbjmQiivZ3oS2DvKYyhr
         H4svyK6PGA8HTOOUcA6nCD8kZ2aOvat8yniGcj/U4DG84+S47KTqYoiVVCN1pf+q0HeJ
         5uxQ5y0c0Dvmw83ix8qLLHIYA4yAON0tOzTXmlAUKHENzcDmG6kU8uSnysr+5QzbVK4Y
         a94/vXGOVG5ga7SMGpY/SIQXD3eiOHK7PpP6Rfp7BI5eRAODyCiuWexjLR6jcLagPD3Q
         K5DRgm6kMUZMfJnxOFHtn5IOe1V/HAg0mbaoOPC5eM40KylNwpJjV8V9fVN0oZjSguYv
         2W2A==
X-Forwarded-Encrypted: i=1; AKwUvBwPHWuZz6JDyWl+6lOdhnF+m2HmmoOVDwcfWhDUUPiHRlFtlg0tiMECGbscbsQTaUClY4g=@vger.kernel.org
X-Gm-Message-State: AFuF++m3Hg8HQl9jAmVNMRpQDEmjBmKn58qHJsrQ0KrffL/1Sb2xKCij
	19GSyRyKeNNAuECS+vbNYc4bGUIf4UVgxLQWANi5V5aBnXckJtE5uLeD
X-Gm-Gg: AYBFou1lT3LRLI9A7Ek0WAklZGMeCY9rNYxLj82ap2yvZy5kas1aXSL8McYGZ2Rnz3M
	KEjE5VL9xOyGLXcDGynNmFnUeKjUTUk9zG02mNI83zGozO74OsN8vzsxbcZBc/QVnoSU6vp/VDE
	1XWo8153x2A5SHPdLCWIfFiQLbaNwqhfUuSSnJrngIlLYK2+h7iOWlwppgDzaf/1rhEqkH/DZdj
	Hz7eX0F8VjxUpAph8hPt0RG3f3J3bP9s7RvJ/fpCvRZ35PIuGogFOL9zha7OyTBcXxxdQmtH1gE
	ZQl5kp3MuyLk0xcoQ/IOAjdtTB2K6p0ZXlu7By0OoRq2Izu+sCcMOEcYT6etOLNCWh3Sc+/df2d
	97HDWFwUMPkkg8wn3DkYrggJrpEO3OkWhZS9ZfDGS1Q8+pOhlzCAucsW3XvuYqzGxoVWWcZzrB+
	mDeQEbjA3eWwG83Ryg5Aas0BSCpktGmVBVVQrVka0rOIWatccBtOEAfw4JpOA/mc/XIWEFfPs1t
	yUqF4zadOBesXnRE6vP9mP53aGmYe/ZGFuGw7Gno6P+Hegf5GJxK2sSiZpomjX2kHFC/+whf581
	/vyM1W7NybyaigslSC6SYyuO6Fcz1iZYRAGYUdUllYLNonsgv/fGqUaYUgHJ3lkrh23Wwhx7N/O
	RIBMWKu5FzkcJLhc=
X-Received: by 2002:a05:600c:468c:b0:49f:c331:39e4 with SMTP id 5b1f17b1804b1-49fc5671095mr87272955e9.7.1789838089820;
        Sat, 19 Sep 2026 10:14:49 -0700 (PDT)
Received: from MacBook-Pro-von-Karl.localdomain (dynamic-2a02-3100-a017-2b01-05fe-203b-7cd2-a640.310.pool.telefonica.de. [2a02:3100:a017:2b01:5fe:203b:7cd2:a640])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-487244608e7sm8986486f8f.6.2026.09.19.10.14.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 19 Sep 2026 10:14:49 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Vlastimil Babka <vbabka@kernel.org>,
	Harry Yoo <harry@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Alexei Starovoitov <ast@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hao Li <hao.li@linux.dev>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Amery Hung <ameryhung@gmail.com>,
	Swaraj Gaikwad <swarajgaikwad1925@gmail.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-mm@kvack.org,
	bpf@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH] mm: restrict can_spin_trylock() to preemptible context on PREEMPT_RT
Date: Sat, 19 Sep 2026 19:14:43 +0200
Message-Id: <20260919171443.90512-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On PREEMPT_RT kmalloc_nolock() deadlocks the machine when the caller
holds a pi_lock. A BPF program which creates task local storage from
the sched_waking tracepoint is enough. With it mainline hangs in 10 of
10 boots on a Raspberry Pi 500+ and in 7 of 28 boots in a 4 CPU x86-64
QEMU guest. The CPUs spin on raw locks with interrupts disabled and
there is no output.

sched_waking fires in try_to_wake_up() with p->pi_lock held.
can_spin_trylock() refuses only NMI and hard interrupt context on
PREEMPT_RT, so kmalloc_nolock() does spin_trylock_irqsave() on
n->list_lock, which is a sleeping lock. Two things go wrong:

 - rt_spin_trylock() takes the rtmutex wait_lock under the pi_lock. A
   regular kmalloc() on another CPU holds wait_lock and takes a
   pi_lock in try_to_take_rt_mutex().

 - If the trylock succeeded and a waiter arrived, rt_spin_unlock() has
   to wake it. That is a try_to_wake_up() inside try_to_wake_up():

     try_to_wake_up               raw_spin_lock_irqsave(&p->pi_lock)
     rt_mutex_slowunlock
     rt_spin_unlock
     spin_unlock_irqrestore(&n->list_lock)
     get_from_partial_node
     ___slab_alloc
     __kmalloc_nolock_noprof
     bpf_local_storage_alloc
     ...
     bpf_trace_run1
     try_to_wake_up               sched_waking, a pi_lock is held

   The pi_lock held there belongs to the woken task, not to current.

Commit 99a3e3a1cfc9 ("slab: fix kmalloc_nolock() context check for
PREEMPT_RT") closed this for v6.19 with a !preemptible() check.
v7.0-rc1 relaxed it again, see the Fixes tag.

Allow preemptible context only, as v6.19 did. A held raw spinlock
implies !preemptible(), so the locks of the caller do not have to be
known. With this change both machines pass 10 of 10 boots.

The nolock allocations then fail on PREEMPT_RT from every context with
preemption or interrupts disabled, also where no scheduler lock is
held. Creation of BPF local storage from such a context fails, as it
did in v6.19.

Fixes: 073d5f156292 ("slab: simplify kmalloc_nolock()")
Assisted-by: LLM
---

Notes:
    RFC because I do not know if that last paragraph is acceptable for
    BPF. 073d5f156292 relaxed the check on purpose.
    
    Harry wrote that the _nolock() helpers can be called under pi_lock at
    least in theory, that it was tough to reproduce, and proposed a check
    of current's pi_lock:
    https://lore.kernel.org/r/apfwshahN_C6jBSn@nixos
    https://lore.kernel.org/r/apfyeYF8IE03aazT@nixos
    That check would not see the pi_lock in the stack above. Sebastian
    described the wait_lock and pi_lock order here:
    https://lore.kernel.org/r/20260831143500.x-saxdAs@linutronix.de
    
    Same config, program and load for all rows. x86-64 QEMU (TCG), 4 CPUs,
    PREEMPT_RT, no lockdep, 60 seconds of load per boot:
    
      v6.18                                  10 pass,  0 hang
      parent of f484f4a3e058                 10 pass,  0 hang
      f484f4a3e058                            0 pass, 10 hang
      v6.19                                  10 pass,  0 hang
      parent of 073d5f156292                 10 pass,  0 hang
      073d5f156292                            0 pass, 10 hang
      mainline 40288c9206c1 (v7.3-rc3)       21 pass,  7 hang
      mainline with this change              10 pass,  0 hang
    
    f484f4a3e058 ("bpf: Replace bpf memory allocator with kmalloc_nolock()
    in local storage") made the path reachable.
    
    Raspberry Pi 500+, arm64 defconfig plus PREEMPT_RT, same mainline
    commit: the output stops 1 to 2 seconds after the load starts. 4 of the
    10 boots were then reset by the hardware watchdog. The other 6 made no
    more progress but still answered ping.
    
    The stacks are from gdb on the hung QEMU guests, I have none from the
    Pi. gdb does not unwind through the JITed program. The frames below it
    are from a raw dump of the stacks. In that capture three of four CPUs
    wait like this for the pi_lock of the same task. The first case looks
    like this, two CPUs from the BPF program against one regular kmalloc():
    
      rt_mutex_slowtrylock           raw_spin_lock(&lock->wait_lock)
      rt_spin_trylock
      spin_trylock_irqsave(&n->list_lock)
      get_from_partial_node
      ___slab_alloc
      __kmalloc_nolock_noprof
    
      try_to_take_rt_mutex           raw_spin_lock(&task->pi_lock)
      rtlock_slowlock_locked
      rtlock_slowlock
      rt_spin_lock
      spin_lock(&n->list_lock)
      get_from_partial_node
      ___slab_alloc
    
    With lockdep and DEBUG_RT_MUTEXES the same program gives "possible
    circular locking dependency detected" for wait_lock and pi_lock on the
    first event.
    
    The program:
    
      struct {
    	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
    	__uint(map_flags, BPF_F_NO_PREALLOC);
    	__type(key, int);
    	__type(value, long);
      } per_task SEC(".maps");
    
      SEC("tp_btf/sched_waking")
      int BPF_PROG(on_waking, struct task_struct *p)
      {
    	struct task_struct *cur = bpf_get_current_task_btf();
    	long *v;
    
    	v = bpf_task_storage_get(&per_task, cur, 0,
    				 BPF_LOCAL_STORAGE_GET_F_CREATE);
    	if (v)
    		bpf_task_storage_delete(&per_task, cur);
    	return 0;
      }
    
    The delete only makes every event allocate again. The load is a few
    loopback ping floods, tmpfs and block writes, /proc walks and fork/pipe
    loops, so that list_lock sees contention. The program is more
    aggressive than a real tool and the load is synthetic.
    
    can_spin_trylock() is also used by the page allocator. Its nolock free
    paths fall back to their deferred lists. I did not test those
    separately. Kernels before v7.3-rc1 have no can_spin_trylock() and need
    the check in kmalloc_nolock() instead.

 mm/internal.h | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 38b1165212c94..29646c4afb419 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1641,10 +1641,14 @@ static inline bool can_spin_trylock(void)
 	 * confuse PI logic, so return immediately if called from hard IRQ or
 	 * NMI.
 	 *
-	 * Note, irqs_disabled() case is ok. spin_trylock() can be called
-	 * from raw_spin_lock_irqsave region.
+	 * Task context with a raw spinlock held is not safe either. The
+	 * caller may hold a pi_lock, like a BPF program on a tracepoint in
+	 * try_to_wake_up(). rt_spin_trylock() takes the rtmutex wait_lock
+	 * and can take a pi_lock under it. rt_spin_unlock() wakes a waiter
+	 * if there is one, which takes a pi_lock again. The locks held by
+	 * the caller are not known here, so allow preemptible context only.
 	 */
-	if (IS_ENABLED(CONFIG_PREEMPT_RT) && (in_nmi() || in_hardirq()))
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && !preemptible())
 		return false;
 
 	/* On UP, spin_trylock() always succeeds even when it is locked */

base-commit: 40288c9206c17eb66a603262e06a58d300d0f279
-- 
2.53.0

