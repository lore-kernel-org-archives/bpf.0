Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD98F39DBCB
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 13:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776347158; cv=none; b=uoiwya3Fr7tMtSbGk8+JdHW3iTkd+Nzsv20JhKoY/PmiPnFTOiysrjggPOnt5gkzYKB2o222o32sy1+/+IqWpC1JJ/sQW8DLMZA6ePoRSlh7EGZjEKX4/niYzBz6MzSRpF/POhPu61NRT2HZYJVIh4DCoef48zu7VBapK/2KACo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776347158; c=relaxed/simple;
	bh=AA3dYvEohTXQUKP6EJOqKNKoIOc/IKK73N0SYnPofU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HBg/JyUPLhkxN1DBwiAvjjdMsNOmCm5nrwfiqO5lBdi76KYesszg4Quwg/vYIXNDRM8sOf7fJkKc8yOYPS9mZ2/vJNX3pFBTzVsPqMdATQnkNlKGPJdTmfOBptPfaOmqytrTQUs7NEESR23lDzGMzyAV0XMfq4YQok2bWcuBpgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jzEiXA2y; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jzEiXA2y"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43d6fbd0954so3711178f8f.1
        for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 06:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776347155; x=1776951955; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=issAxQOvx3MyYsIUEl9HbrPW5aCoSwdHCKMlz9FgfpQ=;
        b=jzEiXA2yY0cKViVUCo/7im3vg6yAZVAcTDdPizN3vqi4IUx6eYkhNGIFbkfOJ4mbUr
         MgZa3hEsIUar5jsTWZVgSF91gHNVA0ciAXVGBpJdu0pI1PSM5r1hViREkFLyk2uHVC6f
         5NnOx9z0tnQ+DKGcBAIJ1itdBOXO2+ZVOgHMhyiIfHRghuja08ovvk5V+v6mstADp0f2
         jlvLYRcTVnsLKEcuYaPZJwTUrGuLIc8MfhUbeoP3DNlI9qbBsIonwKF2w8RwV9jK9i0a
         12HJecbAhzGlONKcoRnPhtzjJJO0sZvC2CFgryJ/6zoXErh6bsdVVRNp5QyNqyOLoXNA
         sgTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776347155; x=1776951955;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=issAxQOvx3MyYsIUEl9HbrPW5aCoSwdHCKMlz9FgfpQ=;
        b=IQL/GcXPwqqt8RYHbZwHVlQmHspSOQmbbk8y1Kq+jIHrxaArRy+Q1IddisO1kvjaXQ
         ZAvp8pFuKZRVJeJ8nc3j/wOpf2gMUwzJnXbv2OyIFUVaxe2mGysgoim+AcACUfmtyAnU
         aaSCWzMBy6K15nCUy24APwr5en7sxKcDokwKw6Hxa/JRWfWj/VqEdY0Z0LWbCcNoal1X
         HfJNafAbkj35ZCjUpPpF/B5URcRjBFPbUNeLs4b2zPnfyzWbkXf5sm85fw1Xn80v7DPu
         0EdoANYPFDIRvdMLDLjAfYmOrPHdjprkcH7PjZBlU4L8kdYYPqSKN3YLYzOiPUQtaf6U
         JJjw==
X-Forwarded-Encrypted: i=1; AFNElJ9pMO54pz/uoSP5EwefF6gYMGNJroOzs+FMyN2+QlZljHUUGgYpmGGRX70S5WZ9j2g52u8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlenT332e5jSy902QJ0XbNsakSODl4pMejkEx9+A28EG5DTE28
	c76rmJCa6oudOIw2apvHPAIhW98L20UVCeR6l7TaIQfyx1oDUZXrpCWe
X-Gm-Gg: AeBDieunj8l4tZLWKgIAVst3hxg8HNyskIZ1Rvr8eHQVN94WiGR0fDQU/mUk6lh6cBk
	Y7u0KubyoYthpZ3VYgIpcDB38e6JrpVPQEnsayJG2RG+NDDgdBvO+G2MfZSPW0kTJuiH6kYoh44
	2BurO4l3VtXRoSgD71DDgbOKo9hOAiiYVFKyfOUsqifnUbjY1hFthmUKX3SsJ4cWYCnjWGaXAru
	lTm7DywnHaMWmTwgmHvNNUHJuBtoSjKGFzlkJTM6LvxibyAowzA46UZ5iwxMBKyaf3Lt8KxTFtN
	VDp3mfNGDyIrBp++BEMRT17wf+ybNXgKv3Rw2/qNLHXOc2rvc3PYSaGU/QsZa+pKZ20uOWlTfHO
	a9UGRHrsgSKhu3E+LqByYIaU/4zZDlElU5xb2k/bvLdu5C9++tG3xGRs6oe/9pqt/xUFXbVcOmA
	zgZAD6OH0JpTRuuNZgedB4clYU72yCOwqUgAFe9bUy3KKZIP4BXc4QpVzescRtD2z8iWnuCczNJ
	iFzdkVC0JdHfkm/YAtD6hInlIH15P3SoN5vG/LNo+ts/kH96X+BX1CJFz7pntAVFpdn5HITzjbF
	Jz/QDj2jbigYvQ4vcuKJlpGaBFPWHIXuy0F4dFNyoj6DI8I7CvTY
X-Received: by 2002:a5d:5f90:0:b0:43d:309b:9c4f with SMTP id ffacd0b85a97d-43d64235d55mr40902724f8f.6.1776347154995;
        Thu, 16 Apr 2026 06:45:54 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00b55a04a9836ebec0.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:b55a:4a9:836e:bec0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead33d518sm14121747f8f.6.2026.04.16.06.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 06:45:54 -0700 (PDT)
Date: Thu, 16 Apr 2026 15:45:52 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>, Helen Koike <koike@igalia.com>,
	harishankar.vishwanathan@gmail.com, andrii@kernel.org,
	yonghong.song@linux.dev, ast@kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-dev@igalia.com
Subject: Re: [PATCH 1/2] bpf: deduce_bounds_64_from_32 tightening with
 circular range logic
Message-ID: <aeDoEOQKNthSpj2R@mail.gmail.com>
References: <20260410124035.297632-1-koike@igalia.com>
 <16990d86263fb24079e6f0b476a8854ec2366932.camel@gmail.com>
 <7tgaeg4mpuoage626jaxu6sl6yht2ace4saog7yyx33pope7xk@kixri3atcb5q>
 <ffb759d53577d1fe05b31373cd0a5bdd6661f547.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ffb759d53577d1fe05b31373cd0a5bdd6661f547.camel@gmail.com>

On Thu, Apr 16, 2026 at 12:43:44AM -0700, Eduard Zingerman wrote:
> On Thu, 2026-04-16 at 11:52 +0800, Shung-Hsi Yu wrote:
> > On Wed, Apr 15, 2026 at 12:12:45AM -0700, Eduard Zingerman wrote:
> > > On Fri, 2026-04-10 at 09:40 -0300, Helen Koike wrote:
> > > > Unify handling of signed and unsigned using circular range logic.
> > [...]
> > > Hi Helen, Harishankar, Shung-Hsi, Paul,
> > > 
> > > I think this algorithm is correct and covers all cases discussed earlier.
> > > I also prepared simple correctness check using cbmc in [1].
> > 
> > Given the "Fix invariant violations and improve branch detection" is
> > merged and the original Syzkaller reproducer no longer triggers an issue,
> > teaching the verfier how to do better bound deduction (i.e., precision
> > improvement) seems less appealing than before, unless:
> 
> There is only so much information that can be gained from 32->64
> tightening. I think this patch-set makes such tightening as precise as
> it can be. Which is a nice property, hence I'd like to proceed merging
> it.

I've sent a patch [1] that might be addressing the same gaps in
deduce_bounds_64_from_32() (outside of the s32 case maybe?). At least,
the selftests introduced here pass with that patch as well. It doesn't
require cnums and looks a bit easier to follow IMO.

I wrote it while trying to fix the reg_bounds selftests and only noticed
yesterday that it might be overlapping with this. cnums probably have
other benefits, but maybe they're not needed to address the issues
identified here?

1: https://lore.kernel.org/bpf/b2a0346a5b0818008503b721c62621918d84ad0a.1776344897.git.paul.chaignon@gmail.com/

> 
> > 1. LLVM produced program show similar pattern and was rejected by the
> >    verifier, which will be fixed by this patchset
> > 2. We're proceeding with cnum RFC as a whole, and this marks the first
> >    step (I am assuming this is the case?)
> 
> This is likely, I'm about to share the RFC.
> 
> > My understanding is that we just need the verifier to be smart enough
> > to accept safe LLVM-generated program, where as Syzkaller-generated one
> > is not as much of a concern if it does not causes any issue. cnum
> > improvement make sense because it simplifies the code, and could
> > potentially be the last time we have to touch 32->64 deduction (famous
> > last word).
> > 
> > Shung-Hsi
> > 
> > [...]
