Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069E839A7FE
	for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 15:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774453335; cv=none; b=K278bLhBNxqG+NqfEOHNjpUrMJDy7YQ3VDEUIwTDU+1cggWR7z1azZW4GvKEfzpEI/gcfRaLHRaV6D6BihIfTtZ77LWGAF0UjiDHZlY8fXCJd6sVZQnUZzaBoa4SJDMa2r6WZl5TiC07a6TSyNwepV5wuZJMIlmlPzpMx1SFN/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774453335; c=relaxed/simple;
	bh=toS7UUE6wFJTL19DVzAONQ7Jlc/gULcgXL/ZAbuTzdI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t8+0VqmAb7Y1BouTexPqK8MUsTP1QBsBjgvMPkNTWt4UMxWDzqOXgMFeAlTbGspJABz8wRFP0MYJYsVIJjYu73KP5nEEZ/HknKCqMx5v/hUDiATz5CjubO3sTf8uPHAuFtRZ4P+tnqVg6pcc8AcRz6A0MALNFolke/DdtXUTVG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cEfzyRVX; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cEfzyRVX"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43b8982c2f4so679563f8f.2
        for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 08:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774453332; x=1775058132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZqPXz+Sa/AY6Vo8qNYqeoHSuweF/2Tg4HA9dNOaxg0o=;
        b=cEfzyRVXwJ/ySEXBaH7dTEKa+C/dffXAg3dYTU4ISN+5G7nGIy6gaiHG2qN27Sb1GO
         5ztsPBRKljNUh1EHk2gNyMo1uaeS90HecqwBallrs1LVldeN+mvQiWXCR6GT33osJeYH
         grc7YQXeCeqc/4L9wxIkLU1Z7KsU2A5VsefstjsGQxPHEg6Mz5dJtTX1IBMfxcAc1p+P
         6XQPmBphvVJagA7Egq2r+sfwIrAJHkFKF7MK5YhZmyWFR5mt3s09I7MEtX2s+niYaAgN
         TxFXD9cdk4pOL9dfTyVf8GkKghXRyy4rszeeTH/yKe8fJRId2wZDHHFw1zgGa0EvrMS5
         6U4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774453332; x=1775058132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZqPXz+Sa/AY6Vo8qNYqeoHSuweF/2Tg4HA9dNOaxg0o=;
        b=NCMv8xoGuY8Oh9t0Wjxk8t/x8cJHyGlVVQ86j0RuMf29f++XxjgR91++fOxCKybEMG
         HZLdYNUC+KfvodpEYf4V1uqWsWfxRvM8Rsdsu4jqQ1YVfDhwtIsXD0Rg+Q+V+oBP1E9U
         fAsenhOB/zZxj0PIT+Yn21A3ujIlSKA/Nppe/JnJToETw2TjoEkhe6sCQHcMnpKmCmvN
         Tk+uwOLHRG/1D8JPbAeXODVVhGI0bt8BKm0g5aA3tj4ENRLULSMH+JMTiRTO6xT2X3xJ
         QLj0udwHFKhIJWp/CbhsmI7dEJRMwpKmLrAUxWNWWcyOQ5oSHkwn3FejFyJAV1JVqX/R
         OPvQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4lcCYP6I55BP14WQTzc+c022VgWXciZhjgBw/V9Q5iYwPtRJKKxNDnSbbUZ4mlQGhUlU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ5Gm9OqHmKCfVysqjEOkB2iqwtDbl6JjWdTff/SCSRaPYOe36
	M+6VNdCyMPMrE2axrAw1LJkC9wfWhmtBAySPwhJbmSDu1Ud0g+nPHMCb
X-Gm-Gg: ATEYQzxvsip8sSyCtrwZdPPLg+ZQ910Kss4qlaFDOZVgqPuagSJ2f5C7MsrkAXaj1Ya
	lo+7KznmLGTIeOOFdqzdSkWuriyvyVLFpU94JrcrRvlA22UleQxPw62Df93KVhrKvznpr6fR5qN
	IAuU1xv59GRiig+FtTfBwwPrF5aurOfKZQ0EXnGcQVvxdjaSwGwdvRVtTpwjfzrqrpz0G6DZ6+S
	FVI+Gq6hdZ0uzFEDwSgDXSScZNFhIO+Grib0QOdCgtlTjdVhwIQyZWDZ06zN1E6WJQeDsonbqnF
	X76wS62Rbu3Gvb5Dahh/CAeDhlSK0+ALgWJwG4l1Fb9n/1yypM+Sk7frHewltHBoYozMiM8kM2j
	rj0ltnMG7/6PVVFbxdVg40mbc7EFJzOnA7XL+YFE2uRqp5Ox1w4xm9POXUnAZe4wQUbphNzEAf8
	IHlt39WfkkWxE3i2vw8wu/YwwQ713vZni2gNEaLVlKZV9+lXVwNQgUcr+l4Pv8ZUVo
X-Received: by 2002:a05:6000:2912:b0:43b:8766:6005 with SMTP id ffacd0b85a97d-43b8899d143mr6042308f8f.20.1774453332131;
        Wed, 25 Mar 2026 08:42:12 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b919cf2b2sm609925f8f.18.2026.03.25.08.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 08:42:11 -0700 (PDT)
Date: Wed, 25 Mar 2026 15:42:10 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, Andrew Morton
 <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pm@vger.kernel.org, bpf@vger.kernel.org, arnd@arndb.de,
 will@kernel.org, peterz@infradead.org, mark.rutland@arm.com,
 harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, rafael@kernel.org,
 daniel.lezcano@linaro.org, memxor@gmail.com, zhenglifeng1@huawei.com,
 xueshuai@linux.alibaba.com, rdunlap@infradead.org,
 joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
 konrad.wilk@oracle.com
Subject: Re: [PATCH v10 00/12] barrier: Add
 smp_cond_load_{relaxed,acquire}_timeout()
Message-ID: <20260325154210.79a621df@pumpkin>
In-Reply-To: <acPo7l_pd5rnHpSX@arm.com>
References: <20260316013651.3225328-1-ankur.a.arora@oracle.com>
	<20260315184925.b6f93386e918ca79614843e3@linux-foundation.org>
	<874imftol4.fsf@oracle.com>
	<20260316233712.7cbfac27@pumpkin>
	<87ms07rlp9.fsf@oracle.com>
	<20260317091705.5a64fc56@pumpkin>
	<acPo7l_pd5rnHpSX@arm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Mar 2026 13:53:50 +0000
Catalin Marinas <catalin.marinas@arm.com> wrote:

> On Tue, Mar 17, 2026 at 09:17:05AM +0000, David Laight wrote:
> > On Mon, 16 Mar 2026 23:53:22 -0700
> > Ankur Arora <ankur.a.arora@oracle.com> wrote:  
> > > David Laight <david.laight.linux@gmail.com> writes:  
> > > > On arm64 I think you could use explicit sev and wfe - but that will wake all
> > > > 'sleeping' cpu; and you may not want the 'thundering herd'.    
> > > 
> > > Wouldn't we still have the same narrow window where the CPU disregards the IPI?  
> > 
> > You need a 'sevl' in the interrupt exit path.  
> 
> No need to, see the rule below in
> https://developer.arm.com/documentation/ddi0487/maa/2983-beijhbbd:
> 
> R_XRZRK
>   The Event Register for a PE is set by any of the following:
>   [...]
>   - An exception return.
> 

It is a shame the pages for the SEV and WFE instructions don't mention that.
And the copy I found doesn't have working hyperlinks to any other sections.
(Not even references to related instructions...)

You do need to at least comment that the "msr s0_3_c1_c0_0, %[ecycles]" is
actually WFET.
Is that using an absolute cycle count?
If so does it work if the time has already passed?
If it is absolute do you need to recalculate it every time around the loop?
__delay_cycles() contains guard(preempt_notrace()). I haven't looked what
that does but is it needed here since preemption is disabled?

Looking at the code I think the "sevl; wfe" pair should be higher up.
If they were before the evaluation of the condition then an IPI that set
need_resched() just after it was tested would cause a wakeup.
Clearly that won't help if the condition does anything that executes 'wfe'
and won't sleep if it sets the event - but I suspect they are unlikely.

I also wonder how long it takes the cpu to leave any low power state.
We definitely found that was an issue on some x86 cpu and had to both
disable the lowest low power state and completely rework some wakeup
code that really wanted a 'thundering herd' rather than the very gentle
'bring each cpu out of low power one at a time' that cv_broadcast()
gave it.

	David

