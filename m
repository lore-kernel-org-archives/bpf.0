Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A39C330B2D
	for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 21:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773871144; cv=pass; b=V1giS3yRT45rEsRvrek4RCAcuT0odYcTXf1SvGMesCqQmB+nL9DDDD1p7Uhi4Ex7LuJ4cu4HoYtIz4STteDo0PbflGyBxgBLI7F8LFOWtPOhmoHUQZWH5S2R57vttbZUMoY3U6OPV5+ubMeoN3wDEgsiX0mFEpsBnX2DCIIMi9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773871144; c=relaxed/simple;
	bh=LBAoVguEB9z0oh4fo+AfRLGGskh0kYTNiGKhyiGcRsM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iZRGDboOhzGFZ162dYgh/tp7jjSlHb3mJRtGbPh7jgAR0OK35sjkD7NtoJvPWQe7w6eWbkuB1OUus128ZBxGpOrLWLhuc0jJf/Dn/PJCI3bDznQfmmE9G80a9C09Y9J8CppXVwyykKlItTpukvgiyCreleOAKAbdsN4GoSS/9MM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AOf+VvW9; arc=pass smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AOf+VvW9"
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-48535a0ef86so2391455e9.1
        for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 14:59:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773871141; cv=none;
        d=google.com; s=arc-20240605;
        b=LPfpK92RMmpUVy+vzbbowp3dI4au58nJQkBcaOSZ//sDtkQJTJ3ST5tBEjb3GvKk1I
         xS7KI+G2mMWvQUhICS39rdVKLnO9B3kGl1JVAjSZIeYhx/07elG06hpZ5OpGFB7CSws8
         yKRzSMqqyPZHADaBg40QLWyWCFle3cpoDguk4XZFehjnyVL6Hr86Qh0EbcJT1TKNQhCB
         5/zpHCKIRa+lcDSaj0yxPTqO2jLHob+cy99ToWcUeLvYrwz5HlZK3bXzbcr5d0JBgvba
         YD0sqdvo6mb8/fiGvYuYiBS6QwU+Y5HJrvk0SIr/fxDsqdmaO25RpQS9yKRPmLChGJsr
         Ao/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=49BwSPLiEX8+5XU4HbuzavX1ooJbNSrFgOaw5DQET7M=;
        fh=/a9NE+q/iF6BSjZWlUSkJGOG2OqEMPLYbwOXFeboNd0=;
        b=VgdN3Lrque9YngRXdbPGM9hZaX7PeKevjQS6ocQTyqRekk7F3idJ6rV17XL+HAhxSk
         P+gY6QMVai2NW9HPh53TvQ8ho6dteY9SWnlLlS72MoTqQKPePCZ9l1LA2zLB487xQVKs
         247W5iWeoOIkxwVugDQn7GoJmxqsB6o5p6g7B0Ru6ymeUV7uOBIQcKtg0iDMT6Dl2Yja
         vCP/b3wkwsBfLEgppIhyh+Fx2KnfOqE+JSL5usK59blr89Z7dFuHveCNpTHSPBg3IeE2
         Obo+aqCFgOraKAJagTTdexYM1vjt9VYsuToko/4RoCaeTDAfpj1N93KiZOplljIVDeA5
         p5PA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773871141; x=1774475941; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=49BwSPLiEX8+5XU4HbuzavX1ooJbNSrFgOaw5DQET7M=;
        b=AOf+VvW9/XwTZv3xPHfp4G08KmIPKBqE05keEVJnlr45HawN6bNW2WJYS11ne7XnoF
         FSBpk2Kqizyz+RK08tszopRTAtRET24uungphDphM1vF9msnnfysindxUbuCD8mvl/Tt
         cfl56afiWdGn92GXm6a0DNrTKk0Jdpd7aYjE9VPofDcMIzkInY9PCIflKQ5JQCtzeZxJ
         6FR6ff3zLPP2bccSPf8Jen/dsluk1/u6rcEvLqnwoTSZ5ECYY8kF7NfN+rM5DzrfESFq
         +h4tOGqmTuZRdP+q97hbdwWnuRoWqIcNb1xPCeR/Ix2TPj5Mn4N7NtuB5ZtN5qwvg3AG
         +faQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773871141; x=1774475941;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=49BwSPLiEX8+5XU4HbuzavX1ooJbNSrFgOaw5DQET7M=;
        b=G7ssYZs8u6ib7k/SSLzoQRhImWVXs1wtCjInlJUOd8U0IEZwe2Zb834fBX+0t0Mxij
         emBh1tudMFGt65XmtyPFb3NZxd8gLwiGnDMKRw/TTlIDo6ofeobCF4gCqofTjHt2SMYX
         5icNXy1NeprY3SGGUskUVhaO1zuVPYU5FpvPc4GlTFpdhaHaF/bgFJJ/8HmFtVqZALBg
         mk+XFCcVsM2XIf1IVIMwa2gHeu8Kn9fmXJmF4Kw3QYd+lQyu1sYSvxuA3bnC9uDO+d68
         SM7bU0/k+8b9WW3U1rsUeCuiriU7OOwWG4aWTwXTSPqT1oHGZp8tADq+ZuHG69+jl0BZ
         Gg+A==
X-Forwarded-Encrypted: i=1; AJvYcCVqwaXrk83Emc06hc+ieBnNPg9S0sCYlW5Z6yYmFqrZRuoAI3lrVeycup1GeJGWCho+vIc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnTrs8pl8va9XD7GAqxEfMMrbV6xyglEEJ3JWNWz6pBdp/xh9/
	rAVnQBBTqwM9XpYiZvHLPo9IqmLeVRiFDuwrYTsmZ8b4zFh/Elc6DtmCXwc50uYQiWl09x3ZM4J
	VpUqT3XKN6nUdbo7unhN8EX4nyMPx3WY=
X-Gm-Gg: ATEYQzwnS8u1eIvUf3f+ixRz5+8GHwu64Vls1GvXcyWU+FprMnTAqtnoGtyW6X3CcyX
	vQnuzN9bvrX0H95cxgp7gdbeomnnbpl2JqgjZbdSJVE65opgccttCzXRiZD2YRrC5vxIhtw7JvN
	uJkmQ0hkgZ1FUMjvM7MT57mz8sSbbOBXZExmTsfJpyYj4UCxzfUYDXGTmSK9kcw88Qdg9PwfBz5
	t0sR0b7i54uqYgCIlRD0EHJoffTWNCjU7l3SsX7Zp15+Acztic+1rr97IGaVDywbvBlgM5Rtd5u
	HiTdOSQK791ZNEdTwJn00b3FAEwgYPu5C5G90SO+yVtER7H9RVGVAKtD4NN+b8CPwqoyVA==
X-Received: by 2002:a05:600c:4753:b0:477:7bca:8b34 with SMTP id
 5b1f17b1804b1-486f44383e1mr88549485e9.6.1773871141262; Wed, 18 Mar 2026
 14:59:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318103526.2590079-1-memxor@gmail.com> <20260318103526.2590079-3-memxor@gmail.com>
 <878qbpkxh9.fsf@gmail.com> <e04886a885e3fef31cd2cb4487a93e3b76deb153.camel@gmail.com>
In-Reply-To: <e04886a885e3fef31cd2cb4487a93e3b76deb153.camel@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 18 Mar 2026 22:58:24 +0100
X-Gm-Features: AaiRm52-sqDOHBym7py13ZhhmHFOkHSSHMk4Od3SdXE2d57j8yYGHBsjjKfcQmU
Message-ID: <CAP01T76nfHrk+cFrq-sAVNVsjFsBgi+Cf5ANWGrmkQmbHANJww@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/3] selftests/bpf: Add syscall ctx variable
 offset tests
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	Emil Tsalapatis <emil@etsalapatis.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Dan Schatzberg <dschatzberg@meta.com>, kkd@meta.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 18 Mar 2026 at 22:41, Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> On Wed, 2026-03-18 at 14:45 +0000, Mykyta Yatsenko wrote:
> > Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:
> >
> > > Add various tests to exercise fixed and variable offsets on PTR_TO_CTX
> > > for syscall programs, and cover disallowed cases for other program types
> > > lacking convert_ctx_access callback. Load verifier_ctx with CAP_SYS_ADMIN
> > > so that kfunc related logic can be tested. While at it, convert assembly
> > > tests to C.
>
> Nit: I'd move the conversion to a separate patch in the set.
>
> [...]
>
> > > @@ -173,7 +179,7 @@ void test_verifier_cgroup_skb(void)           { RUN(verifier_cgroup_skb); }
> > >  void test_verifier_cgroup_storage(void)       { RUN(verifier_cgroup_storage); }
> > >  void test_verifier_const(void)                { RUN(verifier_const); }
> > >  void test_verifier_const_or(void)             { RUN(verifier_const_or); }
> > > -void test_verifier_ctx(void)                  { RUN(verifier_ctx); }
> > > +void test_verifier_ctx(void)                  { RUN_WITH_CAP_SYS_ADMIN(verifier_ctx); }
>
> Wouldn't this be the same as to use RUN_TESTS(), like a few lines below?

Oh yeah, let me try that.

> Also, tjos changes the semantics by always running verifier_ctx tests
> with CAP_SYS_ADMIN, is that important?
>

If RUN_TESTS works I will drop it, yes, but I think it mostly matters
for priv/unpriv testing.

> > >  void test_verifier_ctx_sk_msg(void)           { RUN(verifier_ctx_sk_msg); }
> > >  void test_verifier_d_path(void)               { RUN(verifier_d_path); }
> > >  void test_verifier_default_trusted_ptr(void)  { RUN_TESTS(verifier_default_trusted_ptr); }
>
> [...]
>
> > > diff --git a/tools/testing/selftests/bpf/progs/verifier_ctx.c
> > > b/tools/testing/selftests/bpf/progs/verifier_ctx.c
>
> [...]
>
> > > +   SEC(type)                                                       \
> > > +   __description(type ": reject kfunc zero-sized ctx access")      \
> > > +   __failure __msg("R1 type=ctx expected=fp")                      \
> > > +   int no_rewrite_##name##_kfunc_zero(void *ctx)                   \
> > > +   {                                                               \
> > > +           bpf_kfunc_call_test_mem_len_pass1(ctx, 0);              \
> > > +           return 0;                                               \
> > >     }
> > >
> > > -no_rewrite_ctx_access("syscall", syscall, 4, u32);
>
> --- 8< ----------------------------------------------
>
> > > -no_rewrite_ctx_access("kprobe", kprobe, 8, u64);
> > > -no_rewrite_ctx_access("tracepoint", tp, 8, u64);
> > > -no_rewrite_ctx_access("raw_tp", raw_tp, 8, u64);
> > > -no_rewrite_ctx_access("raw_tracepoint.w", raw_tp_w, 8, u64);
> > > -no_rewrite_ctx_access("fentry/bpf_modify_return_test", fentry, 8, u64);
> > > -no_rewrite_ctx_access("cgroup/dev", cgroup_dev, 4, u32);
> > > -no_rewrite_ctx_access("netfilter", netfilter, offsetof(struct bpf_nf_ctx, skb), u64);
> > > +no_rewrite_ctx_access("kprobe", kprobe, 8, __u64);
> > > +no_rewrite_ctx_access("tracepoint", tp, 8, __u64);
> > > +no_rewrite_ctx_access("raw_tp", raw_tp, 8, __u64);
> > > +no_rewrite_ctx_access("raw_tracepoint.w", raw_tp_w, 8, __u64);
> > > +no_rewrite_ctx_access("fentry/bpf_modify_return_test", fentry, 8, __u64);
> > > +no_rewrite_ctx_access("cgroup/dev", cgroup_dev, 4, __u32);
> > > +no_rewrite_ctx_access("netfilter", netfilter, offsetof(struct bpf_nf_ctx, skb), __u64);
>
> ---------------------------------------------- >8 ---
>
> The chunks above differ only in '__' prefix for u32/u64.
>

Ack, will clean up.

> [...]
