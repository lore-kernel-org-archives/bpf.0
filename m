Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB443C944A
	for <bpf@vger.kernel.org>; Sun, 16 Aug 2026 20:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786913092; cv=none; b=r3+A5WCx/5SAgKq5E+AYQqo+ptpa4/vCUekIxqbov3RerhiVk172xIUPOBvPr6/NMPnZWJNUyyWy6Xcvl4Jnbrdhmq7KxqGErFCtIQzafx1FQYdcvE9rd0fa/fnxgf3vGtIEKrWjE7PstYZhUP+Y1rr8yomPU8auz4XOhZv5sMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786913092; c=relaxed/simple;
	bh=qfHa7Bz92IskvnpEI/0GIr4jnmqJsZ8MM3R91QgoPuY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dMr2Zp1FhR7F14sXnwqzhgNXcqrxW5EHB3k2j6GVKaV0+Svdm+MRxrla3X6GXmjRHoqoknV5yxt3ofKODqlXz9T4yBPO+hsdrXmpzQKyh1yW5Xu25wc/amJgpJhh9dmMU+Acs3uQy6cnERqfHc7Ma/1RoTY01pgxqblPxJYmJIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l6C3am3f; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l6C3am3f"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-480033bdcf4so1564649f8f.2
        for <bpf@vger.kernel.org>; Sun, 16 Aug 2026 13:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786913089; x=1787517889; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CHWpGY/dpT3kUP2xxLApnQIlJZH8C24mnr9pYwyZJ1Q=;
        b=l6C3am3fD/f7k7Kuy+zZv9R+ya9KynhHRA/z5eKUp9a/+LKrTNb6jjq/JmKx1XTHYe
         60A9QGUujQz4gEBrpevPYohsTT3T2rjsUUGE94EU/3/vY5PmYXKTHHsXwMAaHvwfiCUZ
         dI1hJNLVvM200HFSIJlmIOm3jbEYLpt2W4Z/THjS5vzVAqdNeHDNCithO0YHfZka+naw
         v2OKfx7DJVIRpt4X4zOA/62PEKGZo2Q6TRt42XDNxtbHuFn3K0x5r23rWPjPTACT6Zva
         V8jK8EMAMR2PkiVWem/c8kE3pA6dUKc5b3jSuxF0gJW1p5JoTxi/0p02h8OZkCSSYlEY
         CfrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786913089; x=1787517889;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CHWpGY/dpT3kUP2xxLApnQIlJZH8C24mnr9pYwyZJ1Q=;
        b=aU2aj/iHiG3U1iPxdM8AfzQSV1OiALBnuUIe4mpnxHhZ4wh13t/E6pmu2CQ5wU9Y+/
         M79w9hUsIwW8E1kHHL9ykCVjw1Y1lb878IA1qglJMt8vQq5roUAZCCO6FefvsA/9ExWP
         o2keDJnxiemnZXQC4ybqxlJ/UxfQ4vVF6W17D5m1ODnb5snUvHwMhbSejIqjfQd8u4Va
         Jo2Xey15D4t2/oCrTZhwcs3ksi9eYsGJeCnp0oUiuFUFbjSa7JwjGVneS6Z7tVzvjw7R
         7nEB1J+YGI/vhMZqtTCTWjHVQVQdl5UzaxHtMmTd4C4HkidvBLoIkZYJectcFHcXi0Ni
         08bg==
X-Forwarded-Encrypted: i=1; AHgh+Rp6ZGx5EwfjiKlq7R99OB/XIx9EZknmPXarpOQDmLiV6SqaOi+yfBisAIP1giKyllLfZGM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0UCLNn8RC+9qp4RfkROXoql5lukZ//J+HGnQGcbruAQhbVh8f
	xTyRbAXEy5XBNLPwRhVtLR1XYo8HJXgqK/Dz7nlNQy/lfUFQ9FoB08nD
X-Gm-Gg: AR+sD13bRuCZuuWmeQUgdo27yOyDX29c66OsUM01EYBjC+nTt6d+ZqBbhAYGtHrsJF9
	yqy9GE5l48VvcJRrEIRZaABm+0vwTgNf8yWWTL7tw3vrHV1uG9j0foI30yl/JN2N8mMu70oLb8y
	A82PzdFvWanQkI3y9QFsaZLysjJ14omixxg+EjJo1EErBAR6X2l/CvinkKPkbfs/EXz74pnsP2+
	Xh3WPhQ/5Q/TOZYe/DG6T05/Bi2GoK8N421bvYqhGs2DGenCejaamuajyGzW+CSUZT26Ppxxisi
	yq2PUYpYbMu04OlPlzxv82/+JI/CeSY+8bUSKMkGxiOg1Ts1Ar+IOllpMQA8FaGCQ9ZbBGEqXnD
	u6CmqfIth3ZK+l9jYvIvotUaZf+gd76Ls/xKaRcxqYnX77uQ2Nfeb3/i7Kp+DWC6hEyRuFRb1D5
	eZltLt1/Ex7jDi5lz8G1JCSyZtHYitj83gCtzEgrZaP3zfFf0=
X-Received: by 2002:a05:600c:564a:b0:498:ff3:71ed with SMTP id 5b1f17b1804b1-49987993affmr244683295e9.17.1786913089155;
        Sun, 16 Aug 2026 13:44:49 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f21a31dsm28434597f8f.9.2026.08.16.13.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 13:44:48 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 16 Aug 2026 22:44:46 +0200
To: Mike Rapoport <rppt@kernel.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
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
Message-ID: <aoIhPvP8yM-3f60Y@krava>
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
> 	 }
> 	 
> 	 void bpf_jit_free_exec(void *addr)
> 
> 
> I still need to do more checks, but I'm wondering if we could actually fix
> this by not allocating image data in arch_bpf_trampoline_size at all..
> and just teach __arch_prepare_bpf_trampoline to survive NULL image data
> and just return the size in such case

fyi doing ^^^ is not so straigh forward as I hoped for, but if we just allocate
dummy page at init and used that in arch_bpf_trampoline_size we get some speedup

I'll rebase that on top of your fix and send it out later


with your fix:
	serial_test_tracing_multi_bench_attach: found 55077 functions
	serial_test_tracing_multi_bench_attach: attached in   1.470s
	serial_test_tracing_multi_bench_attach: detached in   0.249s


with change below:
	serial_test_tracing_multi_bench_attach: found 55079 functions
	serial_test_tracing_multi_bench_attach: attached in   0.754s
	serial_test_tracing_multi_bench_attach: detached in   0.247s

thanks,
jirka


---
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 1a9fb530adc3..3e8ba33944c9 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -9,6 +9,7 @@
 #include <linux/filter.h>
 #include <linux/if_vlan.h>
 #include <linux/bitfield.h>
+#include <linux/init.h>
 #include <linux/bpf.h>
 #include <linux/bpf_verifier.h>
 #include <linux/memory.h>
@@ -23,6 +24,19 @@
 
 static bool all_callee_regs_used[4] = {true, true, true, true};
 
+/*
+ * Reuse a writable image in the BPF execmem range for size calculation.
+ * Its contents do not affect size calculation.
+ */
+static void *trampoline_size_image;
+
+static int __init init_trampoline_size_image(void)
+{
+	trampoline_size_image = bpf_jit_alloc_exec_rw(PAGE_SIZE);
+	return trampoline_size_image ? 0 : -ENOMEM;
+}
+late_initcall(init_trampoline_size_image);
+
 static u8 *emit_code(u8 *ptr, u32 bytes, unsigned int len)
 {
 	if (len == 1)
@@ -3811,23 +3825,11 @@ int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
 			     struct bpf_tramp_nodes *tnodes, void *func_addr)
 {
 	struct bpf_tramp_image im;
-	void *image;
-	int ret;
-
-	/* Allocate a temporary buffer for __arch_prepare_bpf_trampoline().
-	 *
-	 * We cannot use kvmalloc here, because we need image to be in
-	 * module memory range.
-	 * Since it must be writable use bpf_jit_alloc_exec_rw().
-	 */
-	image = bpf_jit_alloc_exec_rw(PAGE_SIZE);
-	if (!image)
-		return -ENOMEM;
 
-	ret = __arch_prepare_bpf_trampoline(&im, image, image + PAGE_SIZE, image,
-					    m, flags, tnodes, func_addr);
-	bpf_jit_free_exec(image);
-	return ret;
+	return __arch_prepare_bpf_trampoline(&im, trampoline_size_image,
+					     trampoline_size_image + PAGE_SIZE,
+					     trampoline_size_image, m, flags,
+					     tnodes, func_addr);
 }
 
 static int emit_bpf_dispatcher(u8 **pprog, int a, int b, s64 *progs, u8 *image, u8 *buf)
