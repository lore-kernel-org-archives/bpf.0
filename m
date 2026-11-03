Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793694507;
	b=n9HETNRZVjRg1ihmCmITSYZ/EH0Y8L6w7k2fIGl0pe6WgksS7olm7u9QJ+5bUTFgNjHm
	 MXCms8jr6TcMaMMPUiZYUA+jKSWuMN0MTzWDtJJBaFmAyhZnJCjx6rVv0r8VMNJUPLRNT
	 ICQRvAlRd5vzg9nGqF94MLMuCGecp2J3wcdmxt6/sL0dsFuGRFPECVdscfPvyRkA5QPix
	 mS0KBSwsOJH2iQWxNULHpKrRlHVtjPd++IJ/qVTEx7CTTj/EpI/+ed6Q7+P/N/VROpoeb
	 w5adXt8PsuWCwo9ifflaz5QqEO9WlLOzMvh4ODARlnCKLBDuj3s0KVxb2nxEMZOgZJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793694507;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=syysjtWhfrzlfEaldEsTM26pEEl0o8azDUYhhDNzYQk=;
	b=DAYSkgEaroM6EYJ3mn17J0J1pQkxhkoL/bki/kmrdunwrzSCtMH1emUxEQzzS00XTUPi
	 RXO6pnQsv7wHN2B5mkCxtWgQ7OVV0ugHdXVvflU5phf+YkR+h6eZNsOxqGpFK/6wavE2H
	 ZLDKurZgdAJewT9SabUalYZQ2SIHw+ByUMKqbcvoWQDY8Rp3pN+6RE0Q14KWWVVFdBkSI
	 nL9TD/TMYbw7no5rGM4FAUtKMv69ef4zv+ejoMrp/+GrjfjUX3gLo38IXP+kM/7UZkYB+
	 cy9kzqJB065EHStuZmwhEqcP0HmsMrMx40Ir+4ZSIeTl7dudhqKS4NhoCg5iuCTXsng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lww+V+Uc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F0A606A337;
	Tue,  3 Nov 2026 08:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lww+V+Uc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83B2F1F00A15;
	Tue,  3 Nov 2026 08:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793694506;
	bh=syysjtWhfrzlfEaldEsTM26pEEl0o8azDUYhhDNzYQk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Lww+V+Uc0HnDEMnlaPNGK3FmZK2Wnvx+sTOFI0bhrUqedqS0E/A0WpmuXi/Dfb6X5
	 bwKWFdt/R6ToGf3lwLiEyRLjZCzQcisgulT3d0c2vrmJNw7vKlhbX6QAiIIKcm6UEy
	 Fa/xbMH2eLwCFtpeE6fDPW4ceKZeaWhv7vINA+DqB/1Gx+fTixflTB6NGWvcDWGNOB
	 wHsTp6tH8WC46WwQ6qu+a5wSXNryqO6BX/EUINPYInua8QLpUDce6s+KNl3fnaDTOA
	 nOBkdr4yc1IjgCHHU/FZP0CcI74qSbOppjVpZC5skjUQtdpo8rId3LS9ViUZmkR82p
	 mV8vrx9PwAzTA==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Tue, 03 Nov 2026 08:27:44 +0000
Subject: [PATCH 3/5] locking/rwsem: add down_read[_killable]_nosteal()
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-khugepaged-latency-fix-v1-3-a07ab16ac860@kernel.org>
References: <20261103-khugepaged-latency-fix-v1-0-a07ab16ac860@kernel.org>
In-Reply-To: <20261103-khugepaged-latency-fix-v1-0-a07ab16ac860@kernel.org>
To: David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Will Deacon <will@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Waiman Long <longman@redhat.com>, Suren Baghdasaryan <surenb@google.com>, 
 Vlastimil Babka <vbabka@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7465; i=ljs@kernel.org;
 h=from:subject:message-id; bh=xtvSRfFhxlbNSRroaUFE9M6KTB+D22EsX7i6cFBQZL0=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLJezub5/9PB9+MNEfPOmi3q32b+565bpTJjuYhysUMdp
 +n9RX6rOkpZGMS4GGTFFFmefxHfHyQSNq/zgr8bzBxWJpAhDFycAjCRlUmMDI8POjeq85rmRQn5
 zgz7E3Ev91+B7sPupdEH2JvUc9bt+cTwv95OP7WoI2nxt1kMizfePH/WbM3nJu32fbecG7bVfbH
 dywwA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

Since commit 1a728dff855a ("locking/rwsem: Enable reader optimistic lock
stealing") a sleeping, queued writer whose handoff timeout hasn't expired
can have its lock stolen by a read lock issued before a woken queued writer
was able to acquire a lock.

To avoid write lock starvation, this is only permitted if no other read
locks are held.

However, this behaviour defeats the purpose of a reader periodically
dropping the lock to allow writers in, as doing so only works if the write
lock is acquired first, another read lock is held, or a queued writer's
handoff timeout has expired.

Provide a means of indicating this intent via down_read_nosteal() and
down_read_killable_nosteal().

Implement it by exposing a steal parameter to rwsem_down_read_slowpath(),
update the starvation logic to modify this parameter and modify the steal
branch to check it first.

Also drop the duplicated RWSEM_WRITER_LOCKED check and remove the
goto as the steal condition makes this redundant.

Exposing this function is safe as it only makes the lock more pessimistic,
so does not impact lock contention.

Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 include/linux/rwsem.h  |  2 ++
 kernel/locking/rwsem.c | 71 +++++++++++++++++++++++++++++++++++++++++---------
 2 files changed, 60 insertions(+), 13 deletions(-)

diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
index 6a1a7bae5f81..66ab6fad5e24 100644
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -227,8 +227,10 @@ static inline void rwsem_assert_held_write(const struct rw_semaphore *sem)
  * lock for reading
  */
 extern void down_read(struct rw_semaphore *sem) __acquires_shared(sem);
+void down_read_nosteal(struct rw_semaphore *sem) __acquires_shared(sem);
 extern int __must_check down_read_interruptible(struct rw_semaphore *sem) __cond_acquires_shared(0, sem);
 extern int __must_check down_read_killable(struct rw_semaphore *sem) __cond_acquires_shared(0, sem);
+int __must_check down_read_killable_nosteal(struct rw_semaphore *sem) __cond_acquires_shared(0, sem);
 
 /*
  * trylock for reading -- returns 1 if successful, 0 if contention
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index b9c180ac1eee..75fa9fcdee91 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -1014,7 +1014,8 @@ static inline void rwsem_cond_wake_waiter(struct rw_semaphore *sem, long count,
  * Wait for the read lock to be granted
  */
 static struct rw_semaphore __sched *
-rwsem_down_read_slowpath(struct rw_semaphore *sem, long count, unsigned int state)
+rwsem_down_read_slowpath(struct rw_semaphore *sem, long count, unsigned int state,
+			 bool steal)
 {
 	long adjustment = -RWSEM_READER_BIAS;
 	long rcnt = (count >> RWSEM_READER_SHIFT);
@@ -1023,17 +1024,16 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, long count, unsigned int stat
 
 	/*
 	 * To prevent a constant stream of readers from starving a sleeping
-	 * writer, don't attempt optimistic lock stealing if the lock is
-	 * very likely owned by readers.
+	 * writer, only attempt optimistic lock stealing if the lock is
+	 * unlikely to be owned by readers.
 	 */
-	if ((atomic_long_read(&sem->owner) & RWSEM_READER_OWNED) &&
-	    (rcnt > 1) && !(count & RWSEM_WRITER_LOCKED))
-		goto queue;
+	steal &= !(atomic_long_read(&sem->owner) & RWSEM_READER_OWNED) ||
+		rcnt <= 1;
 
 	/*
 	 * Reader optimistic lock stealing.
 	 */
-	if (!(count & (RWSEM_WRITER_LOCKED | RWSEM_FLAG_HANDOFF))) {
+	if (steal && !(count & (RWSEM_WRITER_LOCKED | RWSEM_FLAG_HANDOFF))) {
 		rwsem_set_reader_owned(sem);
 		lockevent_inc(rwsem_rlock_steal);
 
@@ -1052,7 +1052,6 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, long count, unsigned int stat
 		return sem;
 	}
 
-queue:
 	waiter.task = current;
 	waiter.type = RWSEM_WAITING_FOR_READ;
 	waiter.timeout = jiffies + RWSEM_WAIT_TIMEOUT;
@@ -1281,14 +1280,15 @@ static struct rw_semaphore *rwsem_downgrade_wake(struct rw_semaphore *sem)
 /*
  * lock for reading
  */
-static __always_inline int __down_read_common(struct rw_semaphore *sem, int state)
+static __always_inline int __down_read_common(struct rw_semaphore *sem, int state,
+					      bool steal)
 {
 	int ret = 0;
 	long count;
 
 	preempt_disable();
 	if (!rwsem_read_trylock(sem, &count)) {
-		if (IS_ERR(rwsem_down_read_slowpath(sem, count, state))) {
+		if (IS_ERR(rwsem_down_read_slowpath(sem, count, state, steal))) {
 			ret = -EINTR;
 			goto out;
 		}
@@ -1301,17 +1301,27 @@ static __always_inline int __down_read_common(struct rw_semaphore *sem, int stat
 
 static __always_inline void __down_read(struct rw_semaphore *sem)
 {
-	__down_read_common(sem, TASK_UNINTERRUPTIBLE);
+	__down_read_common(sem, TASK_UNINTERRUPTIBLE, true);
+}
+
+static __always_inline void __down_read_nosteal(struct rw_semaphore *sem)
+{
+	__down_read_common(sem, TASK_UNINTERRUPTIBLE, false);
 }
 
 static __always_inline int __down_read_interruptible(struct rw_semaphore *sem)
 {
-	return __down_read_common(sem, TASK_INTERRUPTIBLE);
+	return __down_read_common(sem, TASK_INTERRUPTIBLE, true);
 }
 
 static __always_inline int __down_read_killable(struct rw_semaphore *sem)
 {
-	return __down_read_common(sem, TASK_KILLABLE);
+	return __down_read_common(sem, TASK_KILLABLE, true);
+}
+
+static __always_inline int __down_read_killable_nosteal(struct rw_semaphore *sem)
+{
+	return __down_read_common(sem, TASK_KILLABLE, false);
 }
 
 static inline int __down_read_trylock(struct rw_semaphore *sem)
@@ -1502,6 +1512,11 @@ static inline void __down_read(struct rw_semaphore *sem)
 	rwbase_read_lock(&sem->rwbase, TASK_UNINTERRUPTIBLE);
 }
 
+static inline void __down_read_nosteal(struct rw_semaphore *sem)
+{
+	__down_read(sem);
+}
+
 static inline int __down_read_interruptible(struct rw_semaphore *sem)
 {
 	return rwbase_read_lock(&sem->rwbase, TASK_INTERRUPTIBLE);
@@ -1512,6 +1527,11 @@ static inline int __down_read_killable(struct rw_semaphore *sem)
 	return rwbase_read_lock(&sem->rwbase, TASK_KILLABLE);
 }
 
+static inline int __down_read_killable_nosteal(struct rw_semaphore *sem)
+{
+	return __down_read_killable(sem);
+}
+
 static inline int __down_read_trylock(struct rw_semaphore *sem)
 {
 	return rwbase_read_trylock(&sem->rwbase);
@@ -1577,6 +1597,16 @@ void __sched down_read(struct rw_semaphore *sem)
 }
 EXPORT_SYMBOL(down_read);
 
+void __sched down_read_nosteal(struct rw_semaphore *sem)
+	__no_context_analysis
+{
+	might_sleep();
+	rwsem_acquire_read(&sem->dep_map, 0, 0, _RET_IP_);
+
+	LOCK_CONTENDED(sem, __down_read_trylock, __down_read_nosteal);
+}
+EXPORT_SYMBOL(down_read_nosteal);
+
 int __sched down_read_interruptible(struct rw_semaphore *sem)
 	__no_context_analysis
 {
@@ -1607,6 +1637,21 @@ int __sched down_read_killable(struct rw_semaphore *sem)
 }
 EXPORT_SYMBOL(down_read_killable);
 
+int __sched down_read_killable_nosteal(struct rw_semaphore *sem)
+	__no_context_analysis
+{
+	might_sleep();
+	rwsem_acquire_read(&sem->dep_map, 0, 0, _RET_IP_);
+
+	if (LOCK_CONTENDED_RETURN(sem, __down_read_trylock, __down_read_killable_nosteal)) {
+		rwsem_release(&sem->dep_map, _RET_IP_);
+		return -EINTR;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(down_read_killable_nosteal);
+
 /*
  * trylock for reading -- returns 1 if successful, 0 if contention
  */

-- 
2.56.0

