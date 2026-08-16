Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3FE20ADF8;
	Sun, 16 Aug 2026 08:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786870669; cv=none; b=dZ1B+JYxBubSfPkggSsG4wOuleTQuL+25XdYsyY8B8YsQdIx5UdvXk0A0tZ9rKVLjSPVz8TPMo8E4OFHCGzpGZZ7CNi3FGtB/Ts2Np3diKtiSAB3UbC75LwVkdMxKcVMfTzlVjrufz80h8YeZRXtFXDVFomIJOZliN57kQDTA0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786870669; c=relaxed/simple;
	bh=6DS7FH776J9wqKEfTWPjQFZe4I3VIsty9GPpVBPKojQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eLJ6v4HC6/7x+8QO6r+PRZQCyvlrjsVCN+5Go+xDRPbv7F+tDeKKBpHPP1fTvnhnU/dZ50Z7MAgNSHvNxGLmhXU/lwqW0zmKTU+SsFABAcprgk22d3Vv3ats3yQLODA6Vf310wnC7rbk0TmAWM2AVWfoWN5UFzvGDjNDYLAg/j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VR05XeTI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VR05XeTI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB26E1F000E9;
	Sun, 16 Aug 2026 08:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786870667;
	bh=lxg3zSjfgsGdtnMFPPc1net8ai8HVHRVzJ+pz34suTQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VR05XeTIfZeWTCrOG83xB9eAtnE5lKALOm4EZ8eSavHcO2sEgd+PUb1XiUwQcpQ4L
	 JSgCJyTjbv/79Sl8twoJfMuUGuH11s9zNiyyXJLTmxHiUkqeFxhoOcQhCWsKXxaV9O
	 M18IUlT5BTPmKSFKonIkm5Ibwio8g+U5iB3+EL7s/iowFX6ROz18XgHfwH4vEeMBPO
	 FMGZeW9pCg56etfYGd5zUkwvihYFktcFbDQJp7pNcPwo3PfEEOHrb0w1ymbX9CKIYj
	 O7eXpK5Ih6xxnBoRW9JwW4P3l1vj2zJjwCdu/1yEyrbX2v5NzL7bLC+NTIMc+8uZ8t
	 +Gt9QUcwp0D7g==
Date: Sun, 16 Aug 2026 11:57:35 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>, Song Liu <song@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Leon Hwang <leon.hwang@linux.dev>
Subject: Re: [PATCH bpf-next v3 4/5] bpf, x86: make sure allocation in
 arch_bpf_trampoline_size() is writable
Message-ID: <aoF7f3lH_rz7mxSR@kernel.org>
References: <20260716-execmem-x86-rox-bpf-v0-v3-0-4e76158c01c5@kernel.org>
 <20260716-execmem-x86-rox-bpf-v0-v3-4-4e76158c01c5@kernel.org>
 <an8r7EODLIL-bZM3@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <an8r7EODLIL-bZM3@krava>

Hi,

On Fri, Aug 14, 2026 at 04:53:32PM +0200, Jiri Olsa wrote:
> On Thu, Jul 16, 2026 at 10:51:38AM +0300, Mike Rapoport (Microsoft) wrote:
> > arch_bpf_trampoline_size() allocates a buffer to get actual size required
> > for a trampoline.
> > 
> > This buffer must be in the module address space because
> > __arch_prepare_bpf_trampoline() calculates  rel32 offsets relatively to
> > that buffer.
> > 
> > In preparation for enabling ROX mode for EXECMEM_BPF make sure that the
> > allocated memory is writable.
> > 
> > Add bpf_jit_alloc_exec_rw() wrapper for execmem_alloc_rw() and use it for > buffer allocation in arch_bpf_trampoline_size().
> > 
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > ---
> >  arch/x86/net/bpf_jit_comp.c | 5 ++---
> >  include/linux/filter.h      | 1 +
> >  kernel/bpf/core.c           | 5 +++++
> >  3 files changed, 8 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> > index de7515ea1bea..b2feec81e231 100644
> > --- a/arch/x86/net/bpf_jit_comp.c
> > +++ b/arch/x86/net/bpf_jit_comp.c
> > @@ -3703,13 +3703,12 @@ int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
> >  	int ret;
> >  
> >  	/* Allocate a temporary buffer for __arch_prepare_bpf_trampoline().
> > -	 * This will NOT cause fragmentation in direct map, as we do not
> > -	 * call set_memory_*() on this buffer.
> >  	 *
> >  	 * We cannot use kvmalloc here, because we need image to be in
> >  	 * module memory range.
> > +	 * Since it must be writable use bpf_jit_alloc_exec_rw().
> >  	 */
> > -	image = bpf_jit_alloc_exec(PAGE_SIZE);
> > +	image = bpf_jit_alloc_exec_rw(PAGE_SIZE);
> 
> hi,
> this change (this particular patch plus possibly others in this set) is
> causing tracing_multi attachment bench slowdown
> 
> the benchmark allocates huge number of trampolines and I'm seeing extra
> arch_bpf_trampoline_size code paths in the attached perf profile 
> 
> I'm not that familiar with the allocator, but following hack makes the
> benchmark ok again:
> 
> 	diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> 	index 6a94370a2448..bbff3c9c6681 100644
> 	--- a/kernel/bpf/core.c
> 	+++ b/kernel/bpf/core.c
> 	@@ -1130,7 +1130,7 @@ void *bpf_jit_alloc_exec(unsigned long size)
> 	 
> 	 void *bpf_jit_alloc_exec_rw(unsigned long size)
> 	 {
> 	-	return execmem_alloc_rw(EXECMEM_BPF, size);
> 	+	return execmem_alloc(EXECMEM_MODULE_DATA, size);

This is fine on x86 because all execmem types live in the same 2G
range. Other architectures may have _BPF and MODULE_DATA in different
ranges, e.g arm64 and some configurations of powerpc.

> 	 }
> 	 
> 	 void bpf_jit_free_exec(void *addr)
> 
> 
> I still need to do more checks, but I'm wondering if we could actually fix
> this by not allocating image data in arch_bpf_trampoline_size at all..
> and just teach __arch_prepare_bpf_trampoline to survive NULL image data
> and just return the size in such case

Since bpf_jit_alloc_exec_rw() is only used by
x86::arch_bpf_trampoline_size() I think we can directly allocate from
_MODULE_DATA there and drop bpf_jit_alloc_exec_rw(), like (build tested
only) patch below does.

If/when other architectures would implement arch_bpf_trampoline_size(),
they'll probably need to deal with this differently.


From 14dff78529a9204408a5c14036954df5f2f76431 Mon Sep 17 00:00:00 2001
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Sun, 16 Aug 2026 11:27:32 +0300
Subject: [PATCH] x86/bpf: make arch_bpf_trampoline_size allocate from
 EXECMEM_MODULE_DATA

Jiri Olsa reports slowdown of tracing_multi benchmark that allocates huge
number of trampolines [1].

The slowdown caused by extra protection changes in execmem_alloc_rw() and
execmem_free().

With ROX caches enabled, all execmem allocations except EXECMEM_MODULE_DATA
are ROX after the allocation. execmem_alloc_rw() temporarily sets them to
W+NX and execmem_free() resets them back to ROX.

The only user of bpf_jit_alloc_exec_rw() is x86::arch_bpf_trampoline_size()
that only needs a temporary writable buffer in the modules address space.

On x86 executable memory and module data are constrained to the same
address range, so x86::arch_bpf_trampoline_size() can directly use
execmem_alloc(EXECMEM_MODULE_DATA)

Replace the call to bpf_jit_alloc_exec_rw() with a call to
execmem_alloc(EXECMEM_MODULE_DATA) in x86::arch_bpf_trampoline_size() and
drop bpf_jit_alloc_exec_rw() helper.

Reported-by: Jiri Olsa <olsajiri@gmail.com>
Link: https://lore.kernel.org/all/an8r7EODLIL-bZM3@krava
Fixes: f0334294a428 ("bpf, x86: make sure allocation in arch_bpf_trampoline_size() is writable")
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/x86/net/bpf_jit_comp.c | 8 +++++---
 include/linux/filter.h      | 1 -
 kernel/bpf/core.c           | 5 -----
 3 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index b2feec81e231..7d064d3e2788 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -13,6 +13,7 @@
 #include <linux/bpf_verifier.h>
 #include <linux/memory.h>
 #include <linux/sort.h>
+#include <linux/execmem.h>
 #include <asm/extable.h>
 #include <asm/ftrace.h>
 #include <asm/set_memory.h>
@@ -3706,15 +3707,16 @@ int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
 	 *
 	 * We cannot use kvmalloc here, because we need image to be in
 	 * module memory range.
-	 * Since it must be writable use bpf_jit_alloc_exec_rw().
+	 * Since it must be writable use execmem_alloc(EXECMEM_MODULE_DATA)
+	 * that returns writable memory in the module address space.
 	 */
-	image = bpf_jit_alloc_exec_rw(PAGE_SIZE);
+	image = execmem_alloc(EXECMEM_MODULE_DATA, PAGE_SIZE);
 	if (!image)
 		return -ENOMEM;
 
 	ret = __arch_prepare_bpf_trampoline(&im, image, image + PAGE_SIZE, image,
 					    m, flags, tnodes, func_addr);
-	bpf_jit_free_exec(image);
+	execmem_free(image);
 	return ret;
 }
 
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 32d5297c557e..14acb2455746 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1333,7 +1333,6 @@ bpf_jit_binary_alloc(unsigned int proglen, u8 **image_ptr,
 void bpf_jit_binary_free(struct bpf_binary_header *hdr);
 u64 bpf_jit_alloc_exec_limit(void);
 void *bpf_jit_alloc_exec(unsigned long size);
-void *bpf_jit_alloc_exec_rw(unsigned long size);
 void bpf_jit_free_exec(void *addr);
 void bpf_jit_free(struct bpf_prog *fp);
 struct bpf_binary_header *
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index e2076667b245..1b89c18cf246 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1128,11 +1128,6 @@ void *bpf_jit_alloc_exec(unsigned long size)
 	return execmem_alloc(EXECMEM_BPF, size);
 }
 
-void *bpf_jit_alloc_exec_rw(unsigned long size)
-{
-	return execmem_alloc_rw(EXECMEM_BPF, size);
-}
-
 void bpf_jit_free_exec(void *addr)
 {
 	execmem_free(addr);
-- 
2.53.0

 
> thanks,
> jirka

-- 
Sincerely yours,
Mike.
