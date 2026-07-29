Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212FD437460;
	Wed, 29 Jul 2026 08:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785314639; cv=none; b=iyKhrqhWcsxrvrSFWPbunmK1tH2UjrVr6mTZjQUC2P937099JwXVj/0nDPtpjsHFlQpbjXHUgoI3uK5FLQAF15XTGI8F28lfwLxghvA+T0NKmEKHKzfJpm/w1uu7faKjA6DeGso3juQpz53CE4eb4CTSWBOAqclmWuLOd7TWma8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785314639; c=relaxed/simple;
	bh=hY0vGJ5oWpZkjSNNigk0+5X7wMff+4GaaswThuv48yo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Y3zP5Mb4TMGKPCVQgnwPbeDi7SBIb9VuRPO2IFdsOGM0PsPDf39Or6L9hzi1aZzhY3TXK7zzLvOe+i9VfYX15P66lAuey5v66w/fvO8tiWluZfwRBCWSZfMzNQlh2TXBvcmmwJodxjHWyIoU3TT8ATIjsI2npJoRT1ZdLKogOI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FH4utjkc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FH4utjkc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 782261F000E9;
	Wed, 29 Jul 2026 08:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785314637;
	bh=q3uoDiZ1H0nNWQdRFHwiOJ33C4x0gTBBKZZuXTolWdk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FH4utjkcQWqeWmKSDN2sFspZij/0FGJW022rRHCD1O68+ZoW9q8trgwTvfUnX8EHW
	 yYBITqQfpivnlx8ldeZ9xuQaWLIlPapfFYrc1AM/8e1vRHUrtDzIKVbluy2W/YenIL
	 ERG56Mkv+SEfLigM9QUz0m9fla1cFUW2aNG2/EQObUoRRQ5XG5QhJByiazPxoDodVl
	 0aBCgmvn6w+GoZUQ3DXakTiC1fJPZ+ZLV4BMxZ81032fNsn+WoycFUzEYeoZnGH2Cq
	 glykjnYzvShxmNEc73vQ9Fhy0GnQ2vckVvw/I5+7SMHtfEkaIHrU1Hdu3Fo7TFp+3u
	 ifZJg185YM+1A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 5/8] mm/slab: allow kfree_rcu_sheaf() on PREEMPT_RT
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SGFycnkgWW9vIChPcmFjbGUp?= <harry@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
In-Reply-To: <20260729-kfree_rcu_nolock-v5-5-a28cdcda9673@kernel.org>
References: <20260729-kfree_rcu_nolock-v5-0-a28cdcda9673@kernel.org>
 <20260729-kfree_rcu_nolock-v5-5-a28cdcda9673@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 08:43:57 +0000
Message-Id: <20260729084357.782261F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Calling kvfree_call_rcu() or kfree_rcu() on PREEMPT_RT under a raw=
 spinlock or hardirq context triggers a lockdep 'Invalid wait context' warn=
ing and potential deadlocks due to unconditional local_trylock() acquisitio=
n.

Pre-existing issues:
- [High] Allocating memory with GFP_NOWAIT inside __kfree_rcu_sheaf() can d=
eadlock on scheduler locks via kswapd wakeup.
--

--- Patch [5]: [PATCH v5 5/8] mm/slab: allow kfree_rcu_sheaf() on PREEMPT_R=
T ---
commit 2f2c22c6e4b6eb6bae0d210e9892e5c589edbd06
Author: Harry Yoo (Oracle) <harry@kernel.org>

mm/slab: allow kfree_rcu_sheaf() on PREEMPT_RT

This patch enables kfree_rcu_sheaf() on PREEMPT_RT by passing
SLAB_FREE_NOLOCK when on PREEMPT_RT, avoiding spinning. It skips
the lockdep map on PREEMPT_RT to avoid suppressing valid warnings.

Link: https://lore.kernel.org/linux-mm/6811cc17-8ee4-48c8-8cbf-6bf4d9f98162=
@kernel.org [1]
Link: https://lore.kernel.org/linux-mm/40591888-3a87-433e-b3d2-cda1cab543be=
@kernel.org [2]

diff --git a/mm/slab_common.c b/mm/slab_common.c
index d81cc2136c688..9c2cca9add893 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
[ ... ]
@@ -1987,7 +1995,7 @@ void kvfree_call_rcu(struct rcu_head *head, void *ptr)
 	if (!head)
 		might_sleep();
=20
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT) && kfree_rcu_sheaf(ptr))
+	if (kfree_rcu_sheaf(ptr))
 		return;
=20
 	// Queue the object but don't yet schedule the batch.
diff --git a/mm/slub.c b/mm/slub.c
index 92c99ff34a2c9..6c81722afb18c 100644
--- a/mm/slub.c
+++ b/mm/slub.c
[ ... ]
@@ -6100,10 +6101,10 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, void *=
obj, unsigned int free_flags)
 	struct slab_sheaf *rcu_sheaf;
 	bool allow_spin =3D free_flags_allow_spinning(free_flags);
=20
-	if (WARN_ON_ONCE(IS_ENABLED(CONFIG_PREEMPT_RT)))
-		return false;
+	VM_WARN_ON_ONCE(IS_ENABLED(CONFIG_PREEMPT_RT) && allow_spin);
=20
-	lock_map_acquire_try(&kfree_rcu_sheaf_map);
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		lock_map_acquire_try(&kfree_rcu_sheaf_map);
=20
 	if (!local_trylock(&s->cpu_sheaves->lock))

[Severity: High]
Does this unconditionally acquire a sleepable RT-mutex on PREEMPT_RT?

Since this patch removes the !IS_ENABLED(CONFIG_PREEMPT_RT) safeguard in
kvfree_call_rcu(), kfree_rcu_sheaf() can now reach this local_trylock() on
PREEMPT_RT.

kvfree_call_rcu() is frequently called from hardirq or raw spinlock context=
s.
On PREEMPT_RT, local_trylock() maps to an RT-mutex. Acquiring it from these
contexts will trigger a lockdep Invalid wait context warning.

Furthermore, if a hardirq interrupts the CPU while it already holds the
RT-mutex's internal raw wait_lock, can this trylock self-deadlock?

[Severity: High]
This is a pre-existing issue, but can the empty sheaf allocation in this
function deadlock on scheduler locks?

Further down in __kfree_rcu_sheaf(), the code does:

    gfp_t gfp =3D allow_spin ? GFP_NOWAIT : __GFP_NOWARN;
    ...
    empty =3D alloc_empty_sheaf(s, gfp, alloc_flags);

When allow_spin is true, this uses GFP_NOWAIT, which includes the
__GFP_KSWAPD_RECLAIM bit.

If kvfree_call_rcu() is called from scheduler code holding pi_lock or
rq_lock, and the allocation falls back to the page allocator, it will invoke
wakeup_kswapd(). This enters the scheduler via try_to_wake_up() and
attempts to acquire pi_lock or rq_lock again, causing a self-deadlock.

Should this use a bare flag like __GFP_NOWARN without reclaim bits?

>  		goto fail;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729-kfree_rcu_=
nolock-v5-0-a28cdcda9673@kernel.org?part=3D5
