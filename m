Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758EF279355
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 17:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776361918; cv=none; b=kpZFdQ8OBRmdxT6U6+f8+XVmAUenIoA2o8SqhZhwpNiAr+C9Ri2pwLtLEN7mVZFYc1ayyrgRkph5XflmTo7umw3agd+f5kxOqzVSpVkW0sLnc/0xW38g67aj+PYI7vv5DMcT36957dW+nyknOnpgvzXsCnDw9+ZFgt1DI7u+ju8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776361918; c=relaxed/simple;
	bh=1EH6/eggcrN+2q9BPJj+q+jQoBGLudz6LP8XGzBakHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qfMK2J4IFnsJ6vL3s/FkPR8wn3bNhh8CSv3mRC/FJfLI+6HkxNifigoioHF0BE+Qv1V7Kq9DEbms2sKqrA2YBDDROwP/BnCGnOkglAlFZPxkLtpSTnSLwREuCrQFnFE34HWCHRR551dFRt5s/WwEaewTQCYdJvoUz8ykdFF9c9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YTTA8rxb; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YTTA8rxb"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso100223585e9.2
        for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 10:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776361916; x=1776966716; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9lw0+OPmfDnGiyamEFF6WGsMRzAbLtpadOQYAgY907c=;
        b=YTTA8rxbnB+J5CV2XcmJ3SSlXScX1XSU1qeDd81CYlVmJKQzbKNrCjk63Iq6ollpF0
         31MORBfn4TzuRioNpWoCeJDl0aLDitj1U23rvWxCQzGeE0CTK3YZtWdiLo94BHrHognd
         QKhl49brpU7G82ZWN88jp0fTu6dQz28jPX+7yaAnE+4gt+Qe/9lHpfJAP6Vp7ll6FA3n
         6OKwcuwr67BrhfXcGbZa/MA3VL2FZ9JPcRTzscAvu9+XqTaYFI3mpfLd5gW/eA9eGBrw
         5nrQnU7Gf9N/vNvgt8qraEfQT+eVLgf3AwccITrupzuL5gAWPeQWJwoSWR7tiPmfevNK
         jwJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776361916; x=1776966716;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9lw0+OPmfDnGiyamEFF6WGsMRzAbLtpadOQYAgY907c=;
        b=mKbEo0LIq1TorpwjpBrFglBu18YvJxoIXeT27fcuL0SOn08UXDUmbsklQ2zJa5QUS+
         3OqtxM2w6JQhd4je/Lyn6b9lB9Ca5krxM0sIEIBA0aOQPml4kYW1IGwYLQ49awEvZBuL
         XZbAGP4N6IhAOmeBG3N3EBuRtSbl44Fobo2OEhNnDgNZxZDm6RI6VcZ0hJ7y9sSfGr7b
         LnkDsKz+kiBEtCbavZF+mHjxATTEpqj8AUq8Pid6AQyXjscuLdTgFd+of9wWcE3WCKfM
         ch88MOXh6meDhwnEaBSbRXbN+r0nRJRuvhCGXsX/5/GHPuhTFSr1Z9PekNfGbySJBzfL
         G+mA==
X-Forwarded-Encrypted: i=1; AFNElJ++lPXdapdwe7meNi+AytuEqmzSi5J+fVPx86Px5CxLfxRDi1G+zB3TCE1tEfnFnWlQhHM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4/eZbG1z0Pfztmw+SWtBQ8h+qRPXB605PyHImrIuHNm0ASn2/
	jQu0AbN91BnSO6EMqALzer697Yl+e+BbMnFjIl3T3Yb7+MJt0lIoeqhR
X-Gm-Gg: AeBDieuGvUOoPQ2+uxYvFhjCDH87rp3msyaQ1hKQcBBXKnGYb06o1Vlkfgq1Nk3IeaJ
	EmgcoXzMU07fhulYn5xVg7vrd6iDzE51uxzpXNE0GeBX743AdAq5alsY5woX+ahd9sNBRzgZZgz
	vX8WCL+jeCNP0T0EAe+FDlUnbzVWlX1Z+vBCie693e+9zTM/d/QNhJpaTmsKeryLH/X+j7UpcrX
	/NVnyP/TB5hSUNqOJwA0IB2cpPTiNjoJQTO9oC+iokKB4GX7UQfE1/Anh2PRigYx4xcyJoyuaWe
	XX9ksvBJvSEI0DClUtNmf64f8NUfs91v8w1fSFK0jVxB8pKwBFJFkOrI+HmGGQvG/XOrekcYg3I
	kdUa35q9LCp2Yilf6xE1p7vUOhQ6Oh9kAMkY1mjJiw3gNFqh1XJw91XRbnsJTT0oYdrWnJUpKP4
	Kwhl00RCgxLZGL04x3ylvg0tbp8rTwc0HFD2tyt0YQT7q9MM9Nl3HQWVvSVhGju3++/rbklQwZ2
	6WtnDKWSxIOR05qm1bExkTANhgSB97lyX2p4RQAfXMCMgNXIiH7OnMed4DDpuioNa3hbjB+FXza
	VsVzgA9sWdxJvtkP6/k+3sxuiWbC6GRvVlsPRmSP3YjdOje5bsD1
X-Received: by 2002:a05:600c:a105:b0:485:3af5:7e53 with SMTP id 5b1f17b1804b1-488d6839821mr261694475e9.19.1776361915648;
        Thu, 16 Apr 2026 10:51:55 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00b55a04a9836ebec0.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:b55a:4a9:836e:bec0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f5818d70sm119654275e9.4.2026.04.16.10.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 10:51:55 -0700 (PDT)
Date: Thu, 16 Apr 2026 19:51:53 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: sashiko@lists.linux.dev
Cc: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
	bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Test for empty intersection
 of tnum and u64
Message-ID: <aeEhua0q1C8xCO0F@mail.gmail.com>
References: <20260415160728.657270-3-harishankar.vishwanathan@gmail.com>
 <20260415182952.C7B77C19424@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260415182952.C7B77C19424@smtp.kernel.org>

On Wed, Apr 15, 2026 at 06:29:52PM +0000, sashiko-bot@kernel.org wrote:
> Sashiko AI review found 2 potential issue(s):
> - [Medium] The test relies on the verifier treating the return value of `bpf_get_prandom_u32()` as a completely unbounded 64-bit scalar. If the verifier is improved to track its true 32-bit bounds, the test will silently stop testing the intended logic.
> - [Medium] The inline comments in `empty_tnum_u64_intersection` incorrectly describe the verifier state at the wrong instruction boundaries and use incorrect terminology.
> --
> 
> commit f07d8c6131ab63ef38acb708d393fc328146ef7c
> Author: Paul Chaignon <paul.chaignon@gmail.com>
> 
> selftests/bpf: Test for empty intersection of tnum and u64
> 
> This commit adds a verifier selftest for a scenario where the tnum and u64
> values don't intersect on a branch. It uses bpf_get_prandom_u32() and
> conditional jumps to test if the verifier correctly deduces that the branch
> is dead code.
> 
> > diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
> > index c1ae013dee29c..151c7a479a6b8 100644
> > --- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
> > +++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
> 
> [ ... ]
> 
> > @@ -2184,4 +2184,29 @@ __naked void tnums_equal_impossible_constant(void *ctx)
> >  	: __clobber_all);
> >  }
> >  
> > +SEC("socket")
> > +__description("dead branch: tnum and u64 don't intersect on true branch")
> > +__success
> > +__naked void empty_tnum_u64_intersection(void *ctx)
> > +{
> > +	asm volatile("									\
> > +	call %[bpf_get_prandom_u32];							\
> > +	r6 = r0;									\
> 
> Since bpf_get_prandom_u32() returns a u32, its runtime value is strictly
> within [0, 0xffffffff]. If a future verifier update bounds prandom_u32() to
> this range, the verifier will accurately determine that the jump
> (r6 s< 0xe00000002) is always taken and prune the fallthrough path as dead
> code.
> 
> Would this cause the test to silently pass while no longer providing any test
> coverage for the tnum intersection logic? Could a truly unknown 64-bit value
> be constructed instead to prevent this test fragility?

That's not a bad comment, but I would expect bpf_get_prandom_u32_proto
to be part of the API at this point. Many other selftests use it to
retrieve a RET_INTEGER from the verifier's point of view. If we were to
ever change that, we'd likely get more than one failure.

> 
> > +	r1 = 0xe00000002 ll;								\
> > +	r2 = 0xf00000000 ll;								\
> > +	if r6 s< r1 goto +2;								\
> > +	/* On fallthrough, r6's u64=[0xe00000002;0xf00000000] */			\
> 
> Are these inline comments describing the verifier state accurately? The upper
> bound of 0xf00000000 does not seem to be established until the fallthrough of
> the next instruction (if r6 s> r2 goto +1).

The convention seems to be that comments explain the next line, not the
previous (cf. other tests and [1]).

1: https://lore.kernel.org/bpf/CAADnVQJ2hX6E1_p557MYJOQLxXROzDxezwr-x79A7MyZZLzJuA@mail.gmail.com/

> 
> > +	/*                      tnum=(0xe00000000; 0x1ffffffff) */			\
> > +	if r6 s> r2 goto +1;								\
> > +	/* On fallthrough, r6's tnum=(0xe00000001; 0x100000000) */			\
> 
> Does this tnum state actually describe the fallthrough path? It appears to
> describe the mathematically deduced state on the jump target (true branch) of
> the w6 == 1 check, making the term "fallthrough" incorrect here.

Same here.

> 
> > +	/* It doesn't intersect with the u64 so the condition is always false */	\
> > +	if w6 == 1 goto +1;								\
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260415160728.657270-1-harishankar.vishwanathan@gmail.com?part=2
> 
