Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793708700;
	b=CRnPDCSub4SvZdoZsZSdJFTO2MJsHiFHS0fTa670FzsJzUC3cV9RGltCrBsBhC4jKwlD
	 pFdd8cQwZlu837uXKd8ugVHEK8OeOZm3E18U2Jpv0L9Zo9OCni6P93vY3ZULlgVsBSaZ1
	 ibv4ftSEokI7tRuqZSTmf8iS49Bp/YABr2V5F7RBnavFasTeX7ShuCuXZLtujwzr5li09
	 TUCsW6UyLBXndNiqfFL6LcihP4z3WMtjtttoSyXyCOszcnoRv2NIGDlQsaWkBshbrx/xN
	 DNN2rNgDeT96ngyiWg8KM0BeyiRjLpLjRl1VunO00xQlYISKsFFes4XXynKrPZ2e7lQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793708700;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ib1Dni4qza/67GkuIbDzSdhClKYEF4f+ldPyq0GWH5M=;
	b=QXxCOf6HlXA8tZdWLPtUM64TAEJRlms+x0vp12xvr/sfW9/c+jHcT7Airzp3s3Om2SBt
	 S+xqoRmn+qnonKNp8Q+vqCjMJRS5v5wvmfcaClLpoa4GBO3d4UAy3AHIbZrzwrLOpQ8Tt
	 aKwrvGN45Q4sOJIirf7xTl1BAEnCWqR2cKNglqM0aUZbhqo9us1Nyu075nTWRx11TwxRW
	 YFBeNcdMvThoSBFECvMtqx1Rmp+tjSH4uz2bfrZYroEaBd2ewWST/ljTLALGqgWJfyIxT
	 wOGcL3EH9/0a2TZd8JA37OBKam19ic/1q2pVUULVwS3OEwD9REg53EbuuWoF6DeMtqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WdFlpf65;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C22606A326;
	Tue,  3 Nov 2026 12:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WdFlpf65
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D972B1F000C1;
	Tue,  3 Nov 2026 12:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793708699;
	bh=ib1Dni4qza/67GkuIbDzSdhClKYEF4f+ldPyq0GWH5M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WdFlpf65xK4cXe3wKfv8T1cOVbNZfDm8uIeit8eITrirURwfPiMoXltzFF3VvNVBp
	 Y81d82tZK8zLrcgUSrApu/yeRvQLJqEbcaDEspTm/jctPS0HG4Zt9T8Ub0zn8NUj3l
	 GTWfhPL4f70ouNNddBJq1Iikp8+JRJJ7tHoagPpPhP2o0Rkum9zpq1rRBtIzKchIYe
	 UIxqEGQKaemTEND+2Hum2H/zXbd7Y6xYSGUMm7n75wJcvZiqLJO7/f+R7x6i0yADEc
	 MLkYLXWaxiTax5uzo6q51ee21eYAYeUmkVu+9FK1K7s+4LPy6i2w10BADZDSXTO7uE
	 h/oCA2ZsMOS6w==
Date: Tue, 3 Nov 2026 12:24:47 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Waiman Long <longman@redhat.com>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 3/5] locking/rwsem: add down_read[_killable]_nosteal()
Message-ID: <aunLcWto870swo38@gremlin>
References: <20261103-khugepaged-latency-fix-v1-0-a07ab16ac860@kernel.org>
 <20261103-khugepaged-latency-fix-v1-3-a07ab16ac860@kernel.org>
 <20261103115159.GK1813469@noisy.programming.kicks-ass.net>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103115159.GK1813469@noisy.programming.kicks-ass.net>

On Tue, Nov 03, 2026 at 12:51:59PM +0100, Peter Zijlstra wrote:
> On Tue, Nov 03, 2026 at 08:27:44AM +0000, Lorenzo Stoakes (ARM) wrote:
> > Since commit 1a728dff855a ("locking/rwsem: Enable reader optimistic lock
> > stealing") a sleeping, queued writer whose handoff timeout hasn't expired
> > can have its lock stolen by a read lock issued before a woken queued writer
> > was able to acquire a lock.
> >
> > To avoid write lock starvation, this is only permitted if no other read
> > locks are held.
> >
> > However, this behaviour defeats the purpose of a reader periodically
> > dropping the lock to allow writers in, as doing so only works if the write
> > lock is acquired first, another read lock is held, or a queued writer's
> > handoff timeout has expired.
> >
> > Provide a means of indicating this intent via down_read_nosteal() and
> > down_read_killable_nosteal().
> >
> > Implement it by exposing a steal parameter to rwsem_down_read_slowpath(),
> > update the starvation logic to modify this parameter and modify the steal
> > branch to check it first.
> >
> > Also drop the duplicated RWSEM_WRITER_LOCKED check and remove the
> > goto as the steal condition makes this redundant.
> >
> > Exposing this function is safe as it only makes the lock more pessimistic,
> > so does not impact lock contention.
>
> Not generally a fan of this -- can't we tweak the steal thing to never
> steal if there are pending writers?

Oh, well, I had assumed I couldn't fiddle with that behaviour across
rwsem's in general, so if I can yeah that's preferable!

I could send that change separately then and drop it out of this series.

Something like this?

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index b9c180ac1eee..d6572e207523 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -1034,22 +1034,29 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, long count, unsigned int stat
 	 * Reader optimistic lock stealing.
 	 */
 	if (!(count & (RWSEM_WRITER_LOCKED | RWSEM_FLAG_HANDOFF))) {
-		rwsem_set_reader_owned(sem);
-		lockevent_inc(rwsem_rlock_steal);
+		bool steal = true;

-		/*
-		 * Wake up other readers in the wait queue if it is
-		 * the first reader.
-		 */
-		if ((rcnt == 1) && (count & RWSEM_FLAG_WAITERS)) {
+		if (count & RWSEM_FLAG_WAITERS) {
 			raw_spin_lock_irq(&sem->wait_lock);
-			if (sem->first_waiter)
+			first = sem->first_waiter;
+			if (first && first->type == RWSEM_WAITING_FOR_WRITE) {
+				/* Writers always take precedence. */
+				steal = false;
+			} else if (first && rcnt == 1) {
+				/* First reader, wake other readers in queue. */
 				rwsem_mark_wake(sem, RWSEM_WAKE_READ_OWNED,
 						&wake_q);
+			}
 			raw_spin_unlock_irq(&sem->wait_lock);
-			wake_up_q(&wake_q);
 		}
-		return sem;
+
+		if (steal) {
+			rwsem_set_reader_owned(sem);
+			lockevent_inc(rwsem_rlock_steal);
+			if (!wake_q_empty(&wake_q))
+				wake_up_q(&wake_q);
+			return sem;
+		}
 	}

 queue:
--
Cheers, Lorenzo
