Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E861E3D6494
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 07:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788507945; cv=none; b=aJ+N7kKIJiHI3J03yfUSLJ+LcND1CfIbSoJIYInVBitI+vV5x9/yaVhHmXtHoTTEpBJzvMx9IiHGlmurNvIZXjna//i+Ucw+IuC/936oUEOc4S7nzqmaK5D1tLix9mkusj8pUmcl6vvHdgiS1Qsa/rLurlNm4pki2rT2speUiQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788507945; c=relaxed/simple;
	bh=2PiyT4lkP69WW7bhr69QC/fcEj4E6Np8aq0ohGf9cjI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fhW9mX8CnzbitzPCLO5rP/pNDXRTlv4awnJTK+T++6mRTI/WWScQ81/sjFg7RRjBHEsEWHjFDTzf8JtnF8sN1tQQWDZmVJ8d2RxAuCpdXi+130OtVDkSb2vnEp0w347YZS6Blc04o1aXbY2VXnb5ZJcyX2fxJFZweDqgBSypjHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sRFGDd2+; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sRFGDd2+"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49cdc81f40eso4591225e9.2
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 00:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788507942; x=1789112742; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Lji2idfeozvJnmPqvMblHn0PL784DsXhTEMqBmPAYVw=;
        b=sRFGDd2+Jz5xhco1tT3iyRHBT6EOuRraKbF4yUmz0FJnuRd5IZ7mq+cIiV0kA/IQ7F
         I3W9flz3GkC6mDJpzzEJ3hYcEC0hKmYodagJxzbhlhpZJjAq/6Of+fR7v/hj1NSABt1Y
         j3UTRUYwfIY+Ljh3SGTukx0PssuX3tEuyY4RzsLKWMkFWQSljA8z6Lvx0jD2rDElsUSy
         tN5IMNguIDnXGcm8KUNww64o3+1eYC0a0qTarZUh72pV4uIiJtU3WzBvgCzsLPPSJM2h
         F0QWxI8Dlh+hO3T9VvsaBN6sbe2vAHWAF9v58YdNxx9fw0Gn76dTkQql7LF5sJwocCit
         oXQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788507942; x=1789112742;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Lji2idfeozvJnmPqvMblHn0PL784DsXhTEMqBmPAYVw=;
        b=AAQuvqHd5/z5IKW2CR6PgQ+Lg8/GiYvI49gvUgSwL7a6E6vYNObHAC2qN3dYeYkCXI
         srvO+7AYsqn5WzgG2SfdVmNN/40dZEQY2NSC/mIpRh73l75cDl4rSWR0wbBxJQXj/pPS
         CxoRjk5ffWJ07lV9Qa74wc+N2lTWLpO3Ydl+Duk5YmT7sN2SsHY9jYrLuO1gcKwA3gAE
         vBUY3fsOMTscWCOPqK2IRXrQ8pibuF1ZyPHp415IuiAfhP7jfJiOkoL6VCgMRVnjdYKK
         Cfd6J3qzjHTr24Yj7zH5XpOcjMW160lBBmv8JwUPMq5ICy1XpaSbsHdYa6q26vCXBL0p
         fJGw==
X-Forwarded-Encrypted: i=1; AKwUvBw7djaW8rsYEpugeBc667V8xmMfROrg3visJ3rcY0tdtOkely1rkvKUVvHPKJmY2UXQmF8=@vger.kernel.org
X-Gm-Message-State: AFuF++k4IqAShYVy25Rkc/oF/8HoCniaO+WS04li9tfcGV0MuU755SYG
	sjRJTeKfkR6xj7s21zOt6789AIsu2L9zMOMA7vhY9CofWR/TUTUOgm85eQzXvXIT
X-Gm-Gg: AYBFou102Oy2JepEEk7GiO8bgzBkBa94sCYEiLh43Mpfw/MdIG169KXu9UIDYlg5yma
	tUsxU7sJSVJyO/M7NLs0Gij6GPeeQZ/NBlVJpEPRn+m5bDLwq5cAcEnKuUoTaJgcn1oeDX/bmVy
	ay/frI2DLE8A3O3846bmRakpcIapx+3ra/PLEpmZI7xlo/KwHvmSyfOnJ20J5K/RaoYi/Enp9ki
	xb2OVXAwKLaI/6eCBsHol2+A1MvUHaEZyR0O05wbu/fhX17+Crn1jOODc1hq5tGsL3HL6DUDFP5
	Duf7dpGKyCB6yQIw6mT1WaZoTx5Uox4TWMt/wbSjQ13yLs8kB+hVlXHAJ+WzBJ6q8egibiAOFW0
	XhfoGS3rixx6ptBTvhRMM/ii1kGP47afsrgmHHUf5s3VBpzCSSABm8qsuw5CmyjsaVPnOo7B7BR
	Ct0k/rE6OluHXmzXcxk4tzG74SHJM/kKKx3A==
X-Received: by 2002:a05:600c:8b6d:b0:499:a277:e8b5 with SMTP id 5b1f17b1804b1-49cf7fdd67emr58089435e9.3.1788507941628;
        Fri, 04 Sep 2026 00:45:41 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::25dc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee3b0af8sm136522525e9.0.2026.09.04.00.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 00:45:39 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 4 Sep 2026 09:45:37 +0200
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCHv2 bpf-next 3/3] bpf, x86: Add support for jit dry run
Message-ID: <app3IQUwVF97Tfq1@krava>
References: <20260903092039.477827-1-jolsa@kernel.org>
 <20260903092039.477827-4-jolsa@kernel.org>
 <DL697WN5AOBE.C8WRI12FLOG2@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DL697WN5AOBE.C8WRI12FLOG2@gmail.com>

On Thu, Sep 03, 2026 at 09:40:46PM -0700, Alexei Starovoitov wrote:
> On Thu Sep 3, 2026 at 2:20 AM PDT, Jiri Olsa wrote:
> > Adding support to run jit code generation in dry_run mode that won't
> > store any code and only returns the jir code size.
> >
> > The dry_run is enabled when __arch_prepare_bpf_trampoline is called
> > with rw_image argument as NULL.
> >
> > It's used in arch_bpf_trampoline_size where it allows to skip the
> > image allocation, that gives speed up for tracing_multi attachment.
> >
> > With current code:
> >
> >   # ./test_progs -t tracing_multi_bench_attach -v
> >   ...
> >   serial_test_tracing_multi_bench_attach: found 55227 functions
> >   serial_test_tracing_multi_bench_attach: attached in   1.563s
> >   serial_test_tracing_multi_bench_attach: detached in   0.256s
> >
> > With the fix:
> >
> >   # ./test_progs -t tracing_multi_bench_attach -v
> >   ...
> >   serial_test_tracing_multi_bench_attach: found 55235 functions
> >   serial_test_tracing_multi_bench_attach: attached in   0.798s
> >   serial_test_tracing_multi_bench_attach: detached in   0.258s
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  arch/x86/net/bpf_jit_comp.c | 42 ++++++++++++++++++-------------------
> >  1 file changed, 20 insertions(+), 22 deletions(-)
> >
> > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> > index ee2ddeba3de1..d1af7dc5c5ce 100644
> > --- a/arch/x86/net/bpf_jit_comp.c
> > +++ b/arch/x86/net/bpf_jit_comp.c
> > @@ -25,6 +25,7 @@ static bool all_callee_regs_used[4] = {true, true, true, true};
> >  
> >  struct jit_emit_context {
> >  	u8 *prog;
> > +	bool dry_run;
> >  };
> >  
> >  static u8 *emit_code(u8 *ptr, u32 bytes, unsigned int len)
> > @@ -42,7 +43,10 @@ static u8 *emit_code(u8 *ptr, u32 bytes, unsigned int len)
> >  
> >  static void emit_code_jit(struct jit_emit_context *jit, u32 bytes, unsigned int len)
> >  {
> > -	jit->prog = emit_code(jit->prog, bytes, len);
> > +	if (jit->dry_run)
> > +		jit->prog += len;
> > +	else
> > +		jit->prog = emit_code(jit->prog, bytes, len);
> 
> Sorry, I don't believe that skipping emit makes that much
> of runtime difference.
> I suspect jit_alloc + jit_free are costly.
> In such case the earlier patches are not needed.
> Point emit logic to some scratch area and discard it.
> Same effect with half of the changes.
> 
> pw-bot: cr
> 

yes, I got same speed up with the change below

jirka


---
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 48429fae0641..1bba19a9a17f 100644
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
@@ -3819,23 +3833,14 @@ int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
 			     struct bpf_tramp_nodes *tnodes, void *func_addr)
 {
 	struct bpf_tramp_image im;
-	void *image;
-	int ret;
 
-	/* Allocate a temporary buffer for __arch_prepare_bpf_trampoline().
-	 *
-	 * We cannot use kvmalloc here, because we need image to be in
-	 * module memory range.
-	 * Since it must be writable use bpf_jit_alloc_exec_rw().
-	 */
-	image = bpf_jit_alloc_exec_rw(PAGE_SIZE);
-	if (!image)
+	if (!trampoline_size_image)
 		return -ENOMEM;
 
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
