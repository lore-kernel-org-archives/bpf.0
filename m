Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7BE64
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 13:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782307561; cv=none; b=uB/esMZzO8BK0cs3Z3Oz51LOYXTTlSFwFrMMOSLdWdLjsOwlNovb8/EHWxpAKP/ZEMEsoQkDnR+2ud1eRODyrdPC97y0AXoIJW3AJbcMjBoH1EHLH97CBIk7XMsJqySofwoEyOmgqLtQqwubzOBKDXOUJoua04L4Av7IskJtqjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782307561; c=relaxed/simple;
	bh=cGsvFqKt48J3tFNloG3MIWlD+UIIEcvaSQWyH+/OwpE=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aD5c1Omz4sV6DI1Qd+1GdCKdCe0cYpI/5RsB7Nwpjvc06HVi71kz3hRGi9HJ5Ibu0fVea2LNvHK/+Rqu5VscFwZNbXkuJa40jgrSIaTZQA8/RDoEAspS1T8p+q+7sVDA7iG+eaOfBGySZUaSyuNI08CmYwbMMwPJ8UGRnJevuXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZDHNRh3F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZDHNRh3F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0D491F000E9;
	Wed, 24 Jun 2026 13:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782307560;
	bh=6yCuah6p98kL6OVQhtMtiLHK/0SQjYdQEF9xaMkuceU=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=ZDHNRh3F9ZKAG8adhssQ/6aBOcZW8VzX8wFh2K24SWHlSq0eOBXAWnqD6lLHviy1S
	 R8ei//FkldHyqaX5+13PihB4DWE2yVIiVrX6dcs5ssx+P1XXxfTHnMdB0MWnNgaPTi
	 fIf2Rm93n8zCkqhQVcSviWxbAvOk60KVSO3tObRmSNo78n4zCUF7BsjcITfdpD0qsD
	 cDyR1DSY2vV8zRWqV+Yi9nz0qt4Sz3Wpkkhm2TO+DTfctDlS0jO1Cxvie5tkIV10EJ
	 e9ycNVWTJPlaOC5q9zlMfiBZsjbDj21bsd6eHA+k5mWKpby3aztE6BiGnPmGc4OYxr
	 iuQt7uPrt9efw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 4/4] mm/slab: serialize defer_free_barrier()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: mkoutny@suse.com, hannes@cmpxchg.org, bpf@vger.kernel.org, tj@kernel.org
In-Reply-To: <20260624-kmalloc-nolock-fixes-v1-4-fdf4d17351dd@kernel.org>
References: <20260624-kmalloc-nolock-fixes-v1-0-fdf4d17351dd@kernel.org>
 <20260624-kmalloc-nolock-fixes-v1-4-fdf4d17351dd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 13:25:59 +0000
Message-Id: <20260624132559.D0D491F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Skipping offline CPUs in defer_free_barrier() causes a Use-After-F=
ree when an offline CPU resumes and processes stranded defer_free_objects.
--

commit f2e5ab943e275050dc4612d4d6e119be44858827
Author: Harry Yoo (Oracle) <harry@kernel.org>

mm/slab: serialize defer_free_barrier()

This commit addresses a potential hang in defer_free_barrier() by executing
it under slab_mutex and cpus_read_lock(). It also changes the iteration
from for_each_possible_cpu() to for_each_online_cpu() since the lock
is now held.

Closes: https://sashiko.dev/#/patchset/20260615-kfree_rcu_nolock-v3-0-70a54=
f3775bb%40kernel.org?part=3D5

> diff --git a/mm/slub.c b/mm/slub.c
> index 4a3618e3967ed..52c8d3f337827 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -6411,7 +6411,11 @@ void defer_free_barrier(void)
>  {
>  	int cpu;
> =20
> -	for_each_possible_cpu(cpu)
> +	/* irq_work_sync() may use rcuwait that requires serialization */
> +	lockdep_assert_held(&slab_mutex);
> +	lockdep_assert_cpus_held();
> +
> +	for_each_online_cpu(cpu)

[Severity: High]
By changing this to for_each_online_cpu(), does this skip offline CPUs
that might still hold pending deferred free objects?

If kfree_nolock() is called during CPU teardown after smpboot_park_threads()
or from a late NMI on an offline CPU, the defer_free work could remain
stranded on the offline CPU's lazy_list.

Because kmem_cache_destroy() would now skip waiting for these offline CPUs,
it could successfully destroy the cache while objects are still queued.

When the CPU is eventually brought back online, wouldn't the resumed CPU
process the stranded objects in free_deferred_objects() and dereference the
already destroyed cache?

mm/slub.c:free_deferred_objects() {
    ...
        s =3D slab->slab_cache;
        ...
        set_freepointer(s, x, NULL);
        __slab_free(s, slab, x, x, 1, _THIS_IP_);
    ...
}

> +		irq_work_sync(&per_cpu_ptr(&defer_free_objects, cpu)->work);
>  }
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260624-kmalloc-no=
lock-fixes-v1-0-fdf4d17351dd@kernel.org?part=3D4
