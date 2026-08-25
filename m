Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5EC401A18;
	Tue, 25 Aug 2026 14:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787666770; cv=none; b=Azq9nZCoConDjd6gnzid3Qx8I7REzvh7/mUImZvlCnc/E33ENQICcBdw+VNhZv7+F6yIVBFJZhnr5hroOEFBfksSfJxRPaG78hK+ImnwAI2aS5zm83T6KmJzcEVy88Ho3ZtekF+2v7/gdoWB7tQJToYzkRE1YgZXf5pbNc/8zWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787666770; c=relaxed/simple;
	bh=bET5m+wsbVA3KT9DMiJYc1Evez01O5UKs18POIMxK8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lkx365194ULuD5tXV5SPRSN6dfRgRMSDP6DInCpjTQ+h2LYvz307MCRA9wo9KFDk3ix+JuCqg+ebfB/ClkfNlNjOyzfav7WvbiOv7JjnuKHtu3wPmivKg0I8B8QR5YDIu4JiHwWenM0U3YMTID5+5Q9v84r9twa7er/71OIO/qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=KjDYTbMa; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="KjDYTbMa"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=O9pxOFjmhzfspSsmHJDLgQWciEpCS1zx82fh/O4yVZo=; b=KjDYTbMaVOpf+QfiYgIGtokzdT
	rErPkdsJNgvxcNhC8a3gxASWI2KYENcRf9YSQHGIJCNsV2IXjF2SxbxTouX2E9df4to673NLzD5xD
	vflGPKWHNmdd/6am3ptIRm3y15g7xooOQetyfrI71KlBsbZ1/6Pevi4gpLI6h46pZ7k8f/uuAJG1C
	ueRzS2lSJGlI5MRLxNh/cQoKWPmYMPq7e89cd6NZ86IIh9qUlWyXmnWDM08vX4x8lUwMUiO/aF7g/
	O6kZFwwXeojLJdCXxXS8XR+1BNUr8kvWPo55HBuPsHoOszTiLWPoI/kvxSVnXC3Kd1XBghueoC8jM
	gjZnYGJA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wyrmw-00EUTR-0p;
	Tue, 25 Aug 2026 14:06:06 +0000
Date: Tue, 25 Aug 2026 07:06:02 -0700
From: Breno Leitao <leitao@debian.org>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH] bpf: arena: reschedule while freeing the arena pages
Message-ID: <ao2gP7Y6UJ2o2tUc@gmail.com>
References: <20260824-b4-bpf-arena-free-resched-v1-1-5c447477a64b@debian.org>
 <20260824170831.33E051F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824170831.33E051F000E9@smtp.kernel.org>
X-Debian-User: leitao

On Mon, Aug 24, 2026 at 05:08:30PM +0000, sashiko-bot@kernel.org wrote:
> > diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> > index 7b6847200b431..c5f6bebbb15c3 100644
> > --- a/kernel/bpf/arena.c
> > +++ b/kernel/bpf/arena.c
> > @@ -364,6 +364,7 @@ static int existing_page_cb(pte_t *ptep, unsigned long addr, void *data)
> >  	 * the freed page. So it all relies on 1.
> >  	 */
> >  	__free_page(page);
> > +	cond_resched();
> 
> [Severity: High]
> Does adding cond_resched() here violate the lazy MMU mode contract?
> 
> The callback existing_page_cb() is a pte_fn_t called by apply_to_pte_range(),
> which establishes an atomic context by wrapping the callback loop in
> lazy_mmu_mode_enable():
> 
> mm/memory.c:apply_to_pte_range() {
> ...
> 	lazy_mmu_mode_enable();
> 	if (fn) {
> 		do {
> 			if (create || !pte_none(ptep_get(pte))) {
> 				err = fn(pte, addr, data);
> ...
> }
> 
> On architectures like PowerPC64 with hash MMUs, lazy_mmu_mode_enable()
> explicitly disables preemption. Since preemption is disabled, cond_resched()
> evaluates to a no-op, which means it won't actually yield the CPU and will
> fail to resolve the original softlockup.
> 
> Additionally, if CONFIG_DEBUG_ATOMIC_SLEEP is enabled, this could trigger a
> "sleeping function called from invalid context" bug during teardown.

That is a good point, I think a better approach would be to drop the
cond_resched() from the callback -- existing_page_cb() goes back to its
original form.

Then we walks the range in chunks from arena_map_free() instead, so the
resched happens outside the lazy MMU section (FREE_CHUNK_SZ is SZ_64M):

      addr = bpf_arena_get_kern_vm_start(arena);
      end = addr + SZ_4G + GUARD_SZ / 2;
      while (addr < end) {
              u64 size = min_t(u64, end - addr, FREE_CHUNK_SZ);

              apply_to_existing_page_range(&init_mm, addr, size,
                                           existing_page_cb, arena);
              cond_resched();
              addr += size;
      }

Would this be a better approach?
--breno
