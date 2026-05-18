Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10ED027816C
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 17:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779124042; cv=none; b=g0qZ4oVPt9LRpLfe4IeT1fSdeE4usz3MT1u3jFttxcM3y30QXG/j0a4JjOTGb14RFZjZkQL9Qba6t7ZvLXfytLT9luctaHJ39fj1VUjmggq/+k4kiGCeTuoz4Lw11jJhsIAV/Co+gcUV+QZIB/N6hII4LAYAWqLSqYhBe9IIAOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779124042; c=relaxed/simple;
	bh=0d92nKsILldaG5KcgGwmxuWMoDm+8edMkHW2YKbN2Og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Scw3zziPLQshZMUHMATJOFE0+tUkTR0kDn1vAzjaA/wt948tG+IUcYav30BAqIT9wQDq5iNf5OFi+VCRSYKeYN7xe5DD/ESWktiM0pnLgWKnYXHhfV1E3SyhLitnqYdmOjnXpM4Tg2dFoGTIR4he+EaYyBO5zdUjy1rrS89+WP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HLRdHPsi; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HLRdHPsi"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c7b9f54d3deso2091154a12.1
        for <bpf@vger.kernel.org>; Mon, 18 May 2026 10:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779124040; x=1779728840; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pQBD1pOu6yZoCHpJ70rmlGRDmngML/+8uAz5xw0+M0Q=;
        b=HLRdHPsiMYFVF7ON4AtIutoJBVmP5AVi0aJxiXaBD3Ygbr68I5BTp/chi9olZS5Kpc
         4JjXl0N2yEruLmtbnXU0OAcYll10IvOKL/wN8tgt5gtEy4nT4GUslAanRSWmC1k2SmYX
         QltRLGBIHA4PXHNJkZ7ERJ0VbAOeczJljTqN7VARRkLtIQGRsAqGmQ8YHesPtyH/qrAg
         h4gq7DL3hrjPQYWWO1O3d+U9gMhQ7k7QDQRn6fiSw2DfSkyAYqYXfTv/ntAJTL16UXbg
         +uu7ar4tytqvRjfvQ8QyWUWhXctisNJfCjxB2XNDWBn+i7+KLxXRZpRoALpfw7sITquE
         2EoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779124040; x=1779728840;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pQBD1pOu6yZoCHpJ70rmlGRDmngML/+8uAz5xw0+M0Q=;
        b=ib6uKftBQhGxAybcSXK1NaC/R5V2smNSmBSqwymLGwRb1iGbssyG+OX6oP6KrGjBM/
         SfdNmFDQxV3c6ELCZWPS7EOERyZns3iFaCTmJG1kj3WGpUeUD5HSw3L/zeVZ9767jPUC
         ygQArrKmxeUcBLOGevBmWKQmYcn1h8NoruDrsF1KIrJozByuPX3UDUyDVXYHSWdKGzGD
         9MhqNTdAE1XnepKInRMGfAB6+r6QhBY1jw1SjvLKZ+Jeh/MVRvpNq/w4pfdva1niGZnC
         yQC7XoffI/slrRLMCDnueYMWwghOUg2sEHCg6jWH8QJ1hx53YCCywFUFuXRsbIaMVy4O
         JoXw==
X-Forwarded-Encrypted: i=1; AFNElJ8SH9UOJeWKtRzoPGpxywM2hdgE5x8m2K1k/vJ+cdib5L1dQM7xtfKqH80aPQmXIPQOzys=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwL15Zx4OBNH4CiCus6EOvJtzZxHlNJZEJyC5Psr0rWIJaz9pz
	dEs7HBLUk34Ia4G31lsyMXf3IIL0pIyQpe4NdwzQwxJrq62MY38K5SGe
X-Gm-Gg: Acq92OED8wlLAPgBQ6IUwXq7eX6lXPF2CP4X6EEsFkQbqFE4RxKbwVQ8NWan7RDc52n
	IMOxdw80onygQGIZvASxxnKDqbkJHn5fOX/nZuhx1PC8Fp42DoqI/FdEcW2NSbC1lAkF8TNyaj8
	+kNSO2FqkxLtx4bAHCW4bHfWZ+0KGWcOEAr4YNwp/zSoULjxXmuoya2Bt/Vxek8RDA0/ZN71PeE
	/a88clCi7yODGFPDVzxMezZ/GaWM+SrFVW0jOjQDujclsZe5WAULyeL2x9K6+poDmM2Rrx77Jqp
	UdaDiwE3QgqSemNsdE6I90I4WQsHnnH2AtlAJjb7vzZL+XUvaF0ZCPhK2ykN73o347x6aiUbxjk
	4h/HKFs5mZ5EfnI8Or7OXjERqB42e1hVgvD7qaucU7wR19KU9htrMVe7G3wJJCv52gy6/cAZKBm
	FbvJKi0csiNklu9aMStYyRkoW5XCYyiVnNtQ==
X-Received: by 2002:a05:6a20:748d:b0:3a3:1164:c7a6 with SMTP id adf61e73a8af0-3b22e81f7a7mr17501052637.14.1779124040350;
        Mon, 18 May 2026 10:07:20 -0700 (PDT)
Received: from google.com ([118.150.148.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82bb0fef5esm13229899a12.15.2026.05.18.10.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 10:07:20 -0700 (PDT)
Date: Tue, 19 May 2026 01:07:09 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Greg Ungerer <gerg@kernel.org>
Cc: geert@linux-m68k.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
	jolsa@kernel.org, jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com,
	marscheng@google.com, linux-kernel@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org, bpf@vger.kernel.org,
	Daniel Palmer <daniel@thingy.jp>
Subject: Re: [PATCH bpf-next v3] m68k, bpf: Add initial BPF JIT compiler
 support
Message-ID: <agtHPT7Oo4MZ6CBc@google.com>
References: <20260511212756.3163955-1-visitorckw@gmail.com>
 <f30f7e98-4749-4925-b999-2653941b42ee@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f30f7e98-4749-4925-b999-2653941b42ee@kernel.org>

Hi greg,

On Tue, May 12, 2026 at 09:57:11PM +1000, Greg Ungerer wrote:
> Hi Kuan-Wei,
> 
> On 12/5/26 07:27, Kuan-Wei Chiu wrote:
> > Add a BPF JIT compiler for the m68k architecture.
> > 
> > The JIT generates m68k machine code targeting m68020+ processors. It
> > currently excludes 68000/68010 and coldfire processors, as it relies on
> > 32 bit branch displacements (b<cc>.l) to handle large bpf programs.
> 
> FWIW the ColdFire ISA_B and newer instruction set extensions do support
> the 32 bit branch displacement instruction forms. So that would mean that
> at least the MMU based version 4 cores may be able to be supported
> without too much extra effort.
> 
Sorry for getting back to you so late, and thanks for the info!

I haven't thoroughly checked what else the current implementation might
lack for coldfire support, but I suspect it won't be as simple as just
modifying the kconfig. For instance, at least the exg instruction I'm
currently using is not supported on coldfire.

Since the current patch is already quite large, I'm inclined to focus
on getting everything running correctly on classic m68k first. Once
this initial support is merged in-tree, we can revisit it and figure
out the necessary adjustments for coldfire.

That being said, getting coldfire supported would definitely be cool!

Regards,
Kuan-Wei
