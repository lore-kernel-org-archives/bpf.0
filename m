Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEFD26560A
	for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 10:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772014912; cv=none; b=uJP27EKXRoHZkkXJ4hgq7pslZq27sry/k2Job2Flc7igum4UIhwYV68OqbjT6AKgzkNFgk4UDv38flmCu0+3AgS9wB6V1Dskjc6QlJOpFYfZkEIgD38ZWLTjPmB8nnFe+StChRFPKpcu7pcCAsCcCQ6k5NAY5wGl+PL0nVkP1AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772014912; c=relaxed/simple;
	bh=2nSRz3xdfQ/+Vp0Ax0DpPsdzoGVdWAcOtHs0/LpFfkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GP0FiueeliCLRYCJnUEUGFD4HBgVQxIC65Kwx2c5hBsQA2prnUnj4qNoZ7Sa+Qv5oiP9I/vwC/TSTUC3/ytF3bp5jwcTpgCRA3BmfDcls5HPAQGsJFtaYk+aKKvIFTv75g3TYUtYW0AQ+v3FuynUpVZ++E2IPL7Tfu4D5fepmik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S39oeoCb; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S39oeoCb"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4836f4cbe0bso50266205e9.3
        for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 02:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772014909; x=1772619709; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=glQw7gI2CNTRlL7fs/Cgz9GR5YxSpe0kIhUBT8I3Sno=;
        b=S39oeoCbjm34cj1HPF3/uXH9OK7RkThFq6WrRcktEnK7CuY1IgS12X1oPhdR9kCSgc
         foNRXpsadKZI1QiI0iQ7otsf77jEDcB3K86XnGUOtbXX70yt5Sz+0vx1kVTdJHPEsce1
         7cXJNa/LPYUTP3lhnFGRkph630AWPZe6jzlXJlGkRQizsmTxo2+Hal7GOaj/gKl7Wu4f
         qFYRlFYTyrJ9ttuHBitgJiq/lv15KcO/mM+UdbbUItGTKy5IpfuRYPnYptpe8lqXJSQi
         xh2oh28R/DuGBjYjFUZ+b4rcUbeaLd66eT9AC19cItfbzX3/J4cR+SUuTOCD5ApXxGN/
         21kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772014909; x=1772619709;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=glQw7gI2CNTRlL7fs/Cgz9GR5YxSpe0kIhUBT8I3Sno=;
        b=qEv/2MCFLBm3BqPVdXtsigvoJbJHi1U4VdL6VYAQ9hsKM4xKdxAtnaOHlnpmrTh2R5
         XaYgbiig80cxjdW/QM/SsvXHVNxPCswZtpCVsb2evzTqo08bXicP8Mc2Qdjs3mRCLTf1
         SCd/oG/p+CL2oIODZFeY4GGDFPa/CbyNOEBuYfxqOfYOr3b5geBGBwcSa35o6dwhT6M1
         GG0ebgJvFU7iBWC2MtEmzeUdG/xNauWK7KjMwqVFMUniCfru1oqBknnCJGTMiFCiHtS0
         8TN0Y60Y1ILhMWM4TSjrJzRIY7p+D2NBDYB3+VcRGUePqXWojxNcEqcO2TfQdC/ltAQX
         OnkA==
X-Gm-Message-State: AOJu0Yzjb3azr7LsIO2ut40Hi7XUjnAWMslYQsfVdAfvCe33stkbtBur
	z1v9k1p1K83h9THVO77jqbcA9/+ydmUIUZIj3/ryctdx3X/WGQHVkMEL
X-Gm-Gg: ATEYQzw0r66Bn3GOKoA2nxuxXCFp9lswhvPjnFwSWqbsvk+qYSy8wEZ+ZMK+DRnTeg6
	b2IkLU08UYDICejOZ1N6dI6REhQuPdftKBPe/T4770cKSGO12VBAKIYwlOOIc8JpETCgsJZw+8Z
	kR7ycYX7HXg2M5eHQBi+HXBlSDGVuna3/YXbAxOFkQ0ioZZqKmt78RWI2BVlzq2HmvNw35RczMv
	RSScUnrNrWwNcmbz0SnNLmqO46iKBkZnnc5KPHr/y7VssNB53YsKoVBU0t7YtH5CD2gEDxeW/zG
	4tLarsLJi8Mk5SWsFVnJSCuh8cd1Z0zxBjR7Y1eKPbdGQrhlpbzRNX4buxDOooD+EAtQlwdIqqY
	2xB5ztRocBPw8yTe5/JDvYNqV6VzSd3xMMtTG5cn2xIE6Y1kjGkeR1l9zZMFPDdpU2MXMqbebXp
	zucIE6D3lk4j1LNgxPoL48XZMMB0dXphFLTZjCrft5FXzm4EjWCMAMJYLjRGH/qRK6Xg3S2q18/
	8XuAA==
X-Received: by 2002:a05:600c:529b:b0:483:348a:d3f3 with SMTP id 5b1f17b1804b1-483a95dde23mr282372745e9.18.1772014909124;
        Wed, 25 Feb 2026 02:21:49 -0800 (PST)
Received: from Tunnel ([81.6.34.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd733706sm59127215e9.13.2026.02.25.02.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 02:21:48 -0800 (PST)
Date: Wed, 25 Feb 2026 11:21:46 +0100
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
	Srinivas Narayana <srinivas.narayana@rutgers.edu>,
	Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
Subject: Re: [PATCH v2 bpf 3/4] selftests/bpf: Test refinement of
 single-value tnum
Message-ID: <aZ7NOlhsG5RZIhIl@Tunnel>
References: <cover.1771594636.git.paul.chaignon@gmail.com>
 <1bd78db44bef27d9d7fb549ed3eb8811ee2a5e5e.1771594636.git.paul.chaignon@gmail.com>
 <c0ed78441523309a84ac93e962d73f202337fbb4.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0ed78441523309a84ac93e962d73f202337fbb4.camel@gmail.com>

On Fri, Feb 20, 2026 at 04:20:55PM -0800, Eduard Zingerman wrote:
> On Fri, 2026-02-20 at 14:57 +0100, Paul Chaignon wrote:
> > This patch introduces selftests to cover the new bounds refinement
> > logic introduced in the previous patch. Without the previous patch,
> > the first two tests fail because of the invariant violation they
> > trigger. The last test fails because the R10 access is not detected as
> > dead code. In addition, all tests fail because of R0 having a
> > non-constant value in the verifier logs.
> >
> > Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> > ---
> 
> Hi Paul,

Hi Eduard,

Sorry for the late answer, I've been travelling.

> 
> I have a few nitpicks, sorry for not commenting about it in v1.

No worries. The AI bot also found a new small thing :')

I noticed you haven't acked the first patch. I think it's a bit thougher
to follow, so is there anything we could do to ease review?

> 
> >  .../selftests/bpf/progs/verifier_bounds.c     | 91 +++++++++++++++++++
> >  1 file changed, 91 insertions(+)
> >
> > diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
> > index 560531404bce..41dd249faadd 100644
> > --- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
> > +++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
> > @@ -1863,4 +1863,95 @@ l1_%=:	r0 = 1;				\
> >  	: __clobber_all);
> >  }
> >
> > +/* This test covers the bounds deduction when the u64 range and the tnum
> > + * overlap only at umax. After instruction 3, the ranges look as follows:
> > + *
> > + * 0    umin=0xe01     umax=0xf00                              U64_MAX
> > + * |    [xxxxxxxxxxxxxx]                                       |
> > + * |----------------------------|------------------------------|
> > + * |   x               x                                       | tnum values
> > + *
> > + * The verifier can therefore deduce that the R0=0xf00=3840.
> > + */
> > +SEC("socket")
> > +__description("bounds refinement with single-value tnum on umax")
> > +__msg("3: (15) if r0 == 0xe00 {{.*}} R0=3840")
> > +__success __log_level(2)
> > +__flag(BPF_F_TEST_REG_INVARIANTS)
> > +__naked void bounds_refinement_tnum_umax(void *ctx)
> > +{
> > +	asm volatile("			\
> > +	call %[bpf_get_prandom_u32];	\
> > +	r0 |= 0xe00;			\
> > +	r0 &= 0xf00;			\
> > +	if r0 == 0xe00 goto +2;		\
> > +	if r0 == 0xf00 goto +1;		\
> > +	r0 = 0;				\
> 
> Nit: make this `r10 = 0;`, just like in the last test?
>      (and in the next test).
> 
> Also, the test works the same if I replace 0xe00 -> 0xe, 0xf00 -> 0xf.
> Maybe pick the smaller constants to ease the readability?

If we switch to 0xe and 0xf, the test won't validate the changes
anymore: it will pass regardless of the second patch. That's because
the range would only contain two values. We can however change it to
0xe0 and 0xf0.

[...]

> Also, I think a few more tests are necessary, there are three cases:
> 
>          if (umin_in_tnum && tnum_next > reg->umax_value) {  // A
> 	 	...
>          } else if (!umin_in_tnum && tnum_next == tmax) {    // B
> 	 	...
>          } else if (!umin_in_tnum && tnum_next <= reg->umax_value && // C
> 	 	...
>          }
> 
> If I remove 'umin_in_tnum &&' from A no tests fail.

That would be expected. As you pointed out in the v1, this part of the
condition is not strictly necessary because it should be implied by the
second part. We ended up adding it just for readability.

> If I remove '!umin_in_tnum &&' from B or C test cases
> 'verifier_bounds/verifier_bounds/bounds check based on reg_off + var_off + insn_off. test{1,2}' fail,
> but these seem unrelated.
> Maybe craft a few test cases covering these conditions?

Ack. I'll include the two cases I mentioned when discussing this in the
v1.

Thanks for the review!
