Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F339385D7D;
	Thu, 13 Aug 2026 17:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786643280; cv=none; b=lnVZz0n1EJF1ygq9bB12tKxU4r7NLXyh29aKF1u/qll4y2hgG9G/TAlR3GgpBGWOtfUuy8Ew1Qxaw4Wnaocg59qwV+6k8f2/AS3oHSPZ/CXmVAqNeAvfL0PVsEnH7ajtlIDLvbxM7FWbgOIZgwrvKDg/cccwdEvOAL01fHrGp3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786643280; c=relaxed/simple;
	bh=1CYW0i+lW++6QIhwUBddZ8XJqGMhScftIHevpWyhMgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GQi9+MMbvNI1CnRriQchtDb+KJCOufJ4mRuMWYBX6FqvXo1IFxqcW2P+fzZzuoa2q7Q54iiOqeZsLLGk14MW33UP4VZPpFMLIQViCK44g7njPSyXypEQn7NkGgeHlL/FkZ4N9dbccvelf9jFfrkRASkSyNvkgxy7+HUGegrmKAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=nn5Lnw81; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="nn5Lnw81"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2DFBF1596;
	Thu, 13 Aug 2026 10:47:42 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 69FF23F632;
	Thu, 13 Aug 2026 10:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786643266; bh=1CYW0i+lW++6QIhwUBddZ8XJqGMhScftIHevpWyhMgA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nn5Lnw81w1QjuPz1RXLa4mOPfZawnfwvqyFOA1yyoewdcvO+/rD6/grSpFM/TtGPo
	 VQlEITvj3yBJQqcPyEl9NflGhE3/AHrsgy4lXQlM/ucNvSA3KdFUIYm1nGTNt/NQLa
	 I1K51kkmUU+OwKnvX9tXG1V6SdGYjM97G3+pzSC8=
Date: Thu, 13 Aug 2026 18:47:38 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Harry Yoo <harry@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>, bpf@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Dmitry Vyukov <dvyukov@google.com>, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	kasan-dev@googlegroups.com,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH RFC 3/5] mm/slab, kmemleak: handle kmemleak freeing in
 kfree_nolock()
Message-ID: <an4DOrvgdJcfOVvb@arm.com>
References: <20260807-kfree_nolock_kmalloc-v1-0-ba993cbf7a60@kernel.org>
 <20260807-kfree_nolock_kmalloc-v1-3-ba993cbf7a60@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807-kfree_nolock_kmalloc-v1-3-ba993cbf7a60@kernel.org>

On Fri, Aug 07, 2026 at 03:50:29PM +0200, Vlastimil Babka (SUSE) wrote:
> Kmemleak handling is one of the reasons why kfree_nolock() cannot
> currently handle kmalloc() objects, because calling kmemleak_free()
> would involve spinning on its internal raw spinlocks.
> 
> Kmemleak is a debugging mechanism so we could simply defer all
> kfree_nolock() to irq_work if it's enabled, and eat the extra cost. But
> that would be unnecessary pessimistic. We expect kfree_nolock() will be
> still mostly called on objects from kmalloc_nolock() that are not
> registered in kmemleak so they still don't need any deferred freeing.
> 
> Thus introduce kmemleak_may_need_free() that can check if the object is
> registered. This is done using __lookup_object() performed under a
> raw_spin_trylock_irqsave(), which is safe to attempt from kfree_nolock()
> (except from a NMI on a !CONFIG_SMP system). When that trylock fails or
> can't be attempted, we however must assume the object might be
> registered, and defer the freeing.

The only risk is during kmemleak scanning when kmemleak_lock is
repeatedly held by scan_block() even for minutes. There may be some
timing where most kfree_nolock() deferred during such scanning. Not sure
it matters much though, unless the kfree_nolock() use becomes widely
spread. If it becomes problematic, we could add a new RCU-protected hash
that's searchable for this specific case (we can't remove the rbtree as
we need interval searching in general).

Otherwise the kmemleak changes look ok to me.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

>  void kfree_nolock(const void *object)
>  {
> @@ -6844,9 +6848,23 @@ void kfree_nolock(const void *object)
>  	 */
>  	kasan_slab_free(s, x, false, false, /* skip quarantine */true);

Not related to kmemleak but I noticed this call here: if we relax
kfree_nolock() for any slab objects, would the above poison
SLAB_TYPESAFE_BY_RCU objects while they are still in use? I guess we
should not allow such slabs on this path.

Sashiko had some comments as well, I haven't gone through them but it
also mentioned SLAB_TYPESAFE_BY_RCU on another patch.

-- 
Catalin
