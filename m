Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6C331F9A2
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 05:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776405559; cv=none; b=LwLTmjV9FLlwws7QBmHGRS/5/BQ7hqfJidyIZE8eWN0jTHcvuxCIUqp9LjMtXrAHQk3sVj/lGLWD1arT1ZXqAgRYJNPecVE4xl77tiHYJv8vIq4uKTQ3rXsIOn+AGPslf7Il553P3e6E8og+E/tzjyqCVMtA2sku2J8mAYUBuSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776405559; c=relaxed/simple;
	bh=LrQmhGVuXmqRcDFJDnXQ1uDIeEFCki/jecbQ+zSzXhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JvpfCRxKyA+d1gX04PBdS5RE4aw8N4j20Pu8Ti7b4sI0o3HQkz4XtPSayvm8dMCVy5rRQmofqna/yc5/HLC+tckkYDpW+QYX+qFSTNjdfubiot8C06LYghjd4QsVYM0mJMO9/SJmxQ/LbAi9QwZqpwpOaa1AHhT0wBOes4FicrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VE1TEBsy; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VE1TEBsy"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b9c01854477so69434466b.0
        for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 22:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776405556; x=1777010356; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OqJI+IW0G1LFG5I0ZW7bizZZGji7sw0kuf5i5tJCjbw=;
        b=VE1TEBsyPQSktXzvoIVFaxpR+prt4++vG+v/ktY0htlwxdbBUedDMCY4o0gp+Pyf3C
         Rayvy50a/vlN5LZMm+hidhJxsJmxZoAh2uN4YpOscRv+H4mdZgCsaCu00FdGDcpPGdLg
         GHwIsyCZIXTsJRhnCTLFzm2deul1uFQbSVOn1tGOXzrCeRMtB+DSATga/4D98G9IjSvX
         TmcVQqld7+C0sgza7B0mRDLbY20h/fbYC2/VdaOEV98mFgn4sFCuYaqUZprUH2kTaACF
         L/vmX4DgKSE7OLOA6LOnTLlekyavgiCLAIOuoFwyj8fgGSh4X+4wsSJGmPW+FMDT5XQK
         sgBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776405556; x=1777010356;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OqJI+IW0G1LFG5I0ZW7bizZZGji7sw0kuf5i5tJCjbw=;
        b=U0s79j/YMJbStYSpe3N1PbbdBjox34izmNk9JoaYMQxdsd0m6TFetqGnN2xUmKOZXg
         0b+YqnXt3VVMFZAaRNY/cr6RTG3trVHXs5ruGz4tlCF7GXFVltZ/cUwJ1AhqOKpF8fZi
         Oz9gtclzJLePhlar9onfxgapPa8x+OXUC7T2m0NbQx9gPIcNyN4XBSchiik9FMYpp5b8
         jzMo5U2Y5Nbda0Pols8/VMTGWLIMDMuq0E9a5ZSUnndamxk4eGLvXSrZHCGoijj56GGx
         DRAo6Phb7/ScdRLSd4pHYskrL1IVgouo+pqoXT21P2Drwgy/Xu1dMKGeqGz8iVzEbxWP
         RucQ==
X-Forwarded-Encrypted: i=1; AFNElJ9C/UHu0kfLYfUVEb4tUJa+cVLePZ3LmlIbdZMjCNVr7UVMdB/2VSW9TE802jvI+HcVQKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkuyUusSNbdK59s9DochHuPTSWslFzPOP+RDwxu5N8Tvx3i0us
	LdK4vtsHeVpGPonCeKDgkDigAKAmMeiYhD+QpwoKfivU+SPbz6E7n7XEhNU84eLgZw==
X-Gm-Gg: AeBDietAHq2YUnFFXhOBtdGb5X5jiWVqe8cQSuhqSpfgMQHAn4fDhJ0Fcn+Y5F+SU4y
	nZGQdNt0P0Hd2Li1XqEPalChz4lndB2UF2KQ//vchXGy7TsGDWVpPi+udgpEVsfYqJVGOSHc5U4
	TWcvZ12UNbfeFFNPLubP8D5MVyQFuXxH7EIxsMmYY0fzBY90jSyIW0yw+T0Hw20dy36OZ5XGuEb
	VOtsV3vR4YLZCZEgv9BL4LSQABxvoQJXTsTKv8Z7O095oSwBUpnvoeg2nO+ouhWvdLHtBEfDZz3
	oO67AZXLSNU0jPo9NO8hrJPMKvYsn6uarz6nnZBJLx+YSI3hM8hcrEe+koaKj8nmFzXvTyxmf84
	YTHFf53rbn6TYURzM+hEi7xAO+oZSVhfrNmO+sZP0LcEdtOdiBB27PlXTtgLoekQmEskXxv+Mnj
	V3CXjPPXsvCqvS+hAeuq7UsI3qzqCvvq2E384Dukr++oDFaYJ4GBhxCfOZtlv9/iAocysbb1B6v
	j+cDp4DCve9
X-Received: by 2002:a17:907:3f14:b0:b9f:18e2:f3b6 with SMTP id a640c23a62f3a-ba41de2e595mr67835366b.30.1776405555643;
        Thu, 16 Apr 2026 22:59:15 -0700 (PDT)
Received: from google.com (57.35.34.34.bc.googleusercontent.com. [34.34.35.57])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba45121109csm20849166b.6.2026.04.16.22.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 22:59:15 -0700 (PDT)
Date: Fri, 17 Apr 2026 05:59:11 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Song Liu <song@kernel.org>
Cc: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org,
	ast@kernel.org, andrii@kernel.org, memxor@gmail.com,
	daniel@iogearbox.net, eddyz87@gmail.com
Subject: Re: [PATCH bpf-next v7 0/9] Introduce arena library and runtime
Message-ID: <aeHML12PVPizitny@google.com>
References: <20260412174546.18684-1-emil@etsalapatis.com>
 <aeFFQL-bOTN5dg7V@google.com>
 <aeFHKUsf86jw1v9W@google.com>
 <CAPhsuW4nvpP6UJ0xO0yJ=FcAVOrWDX6ASvcp04kWQfYBx=72mA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW4nvpP6UJ0xO0yJ=FcAVOrWDX6ASvcp04kWQfYBx=72mA@mail.gmail.com>

On Thu, Apr 16, 2026 at 01:43:49PM -0700, Song Liu wrote:
> On Thu, Apr 16, 2026 at 1:31 PM Matt Bobrowski <mattbobrowski@google.com> wrote:
> [...]
> > >
> > > I haven't had an opportunity to go through this patch series just yet,
> > > but can I just say that it excites me considerably! I've been wanting
> > > to carve out some time to implement something exactly like this for a
> > > very long time (since BPF arena maps were initially introduced) as I
> > > think it's going to be incredibly valuable for BPF users moving
> > > forward.
> >
> > I swear that I also saw a notification stating that this series was
> > applied to bpf/bpf-next.git (master), but upon checking I only see
> > that commit 4c5f21d4dfa ("selftests/bpf: Add tests for non-arena/arena
> > operations") from the series was applied. What's going on there?
> 
> Part of it was committed. From patchwork-bot:
> 
> Here is the summary with links:
>   - [bpf-next,v7,1/9] bpf: Allow instructions with arena source and
> non-arena dest registers
>     (no matching commit)
>   - [bpf-next,v7,2/9] selftests/bpf: Add tests for non-arena/arena operations
>     https://git.kernel.org/bpf/bpf-next/c/4c5f21d4dfa4
>   - [bpf-next,v7,3/9] selftests/bpf: Move bpf_arena_spin_lock.h to the top level
>     (no matching commit)
>   - [bpf-next,v7,4/9] selftests/bpf: Move READ_ONCE/WRITE_ONCE macros
> to bpf_experimental.h
>     (no matching commit)
>   - [bpf-next,v7,5/9] selftests/bpf: Add basic libarena scaffolding
>     (no matching commit)
>   - [bpf-next,v7,6/9] selftests/bpf: Add arena ASAN runtime to libarena
>     (no matching commit)
>   - [bpf-next,v7,7/9] selftests/bpf: Add ASAN support for libarena selftests
>     (no matching commit)
>   - [bpf-next,v7,8/9] selftests/bpf: Add buddy allocator for libarena
>     (no matching commit)
>   - [bpf-next,v7,9/9] selftests/bpf: Add selftests for libarena buddy allocator
>     (no matching commit)

Ah, yeah, I realized only after I had sent out my email.
