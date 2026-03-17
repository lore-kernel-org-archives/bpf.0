Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0154315F
	for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 06:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773727441; cv=none; b=UVboF3kZqej7ng3HJhSfokDRI7/rdV3gLTrUyxq6aWZmmjSECUXBLnhOz/abvFbGhLQvHCU1D1QrdlL//6rsQCEU9GehRPYTWf1dcK7YNroCDguhKuA/vLfatU+p4lJ1spoPef1uN0ah7kmxDld1uetlfiPhYojdjvaX36DfH7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773727441; c=relaxed/simple;
	bh=mEnYiXQ6HsSjGR0CUZeCDeqis9yOPNhLBYhqt9Y3i2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VoKlkLNo2huzzQsasZ4kZsilYuEEktUGr8amdIoRyb8J1YSl+GgI3CXE6k9mPmBbWEbQxZ4DHmU6oZpiXaSKL4bw6vWkzQOeqAG9P6Z/eAj6cR7dMRV6ESvXZpn2zxTRD34fIx4S/uKQCjJJI0+rjei7JRFgWrFeT6pc2FBz4pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=I491/JWX; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="I491/JWX"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-486507134e4so1748485e9.0
        for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 23:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773727438; x=1774332238; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rgDztRv3e/AdYxlz758pYfr86dBPxW2dW9gdh5B7vog=;
        b=I491/JWX4RV5GBwjir9b9sqHKKl4m994wLAREfLp+rRnvcXOJ6ve7yLP1yNWmIs6yD
         qM1lDP1+FtvOKnCINrFhpHSszVVlfgjAzYtDKm/fF/E1wnOwbOYYnKyLv5Edq/50UWwz
         SepWB/KYohVfAapOQdVjZvJ8Si1/uuwRjHM1yeNU42hiBNGtiXGo3hjxRX1BavA/0Ahb
         CkZMcsoJxypP7xAH0EpLT436ngqgCt9GEMzxqP3pU8E7s9Gyo5VuP5QQRStWKdPw94yS
         S4z332IzPxi+999z5rxAGIvmjw2hmxBoQG43ThXjrIVtnkkkSAaCJ9ZjIVsFLz1OAs96
         HAFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773727438; x=1774332238;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rgDztRv3e/AdYxlz758pYfr86dBPxW2dW9gdh5B7vog=;
        b=dO0xf/+U4gMlB3v2GLl8w1jSMAO0gIdcoY8kgjOnsNbczeixee+IvcG1lojn2nsuuV
         2eDvIEzm8IqJaWO7Z2m5uzd8yGEZt5fZiMAXAioYMq4QEAWmo/mzRWkpIYuM+a0hkuqX
         55BaO379SLTBD6OIXW4XeP7Eu1KNH71fhSWxtTE6b6Bq/fAsWJRizPojnF0pIbx4i0pn
         KIJjZ7voo3xyKlrTmJk/O61A0QsuRNK7BjhJ8r4rinqOuntdBjOLwtjFjR665jzrLzMP
         nxT0Nu/FcQ/5cz5kStdMUJGY3bP2tIIv+cXSOWRJRPrVE9W0hSqeyxB+o9OjthsKjrug
         yoMg==
X-Forwarded-Encrypted: i=1; AJvYcCVANnI2Pcupo2Dz0ZsOIwz+SRCm9iKRuJml3ozcB8Abju5igMJ+46mlyghcjz4qwFE0sNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhb15bcgQPTUuXhwKKwOLD+CBZbK6NztBPPP3OyArtXzbhg8dx
	KjbQV8ZJenPFaJMhSQIl55NfGQtRe1yEWB6ETJuRRoDNy8P2sgAbD3e9s6pQRWsEn/U=
X-Gm-Gg: ATEYQzwDYvt1sFGPESUfhMu1UBJWdflWUVDBlCmigrYB76+b0E0ikDxB4YvBxsr7owU
	nAq4OORjLYT7vQ+NXG0kZm2fY1YFFPfRFnXoEaUWES7SJtY2OFiK/CB8bG4g2huViTXM5V7TK9D
	hlNiOuBI3VMZxwJOQLOAG/eGcHUw3W2YuVAJTUpb9q6IcLv61B5/UGhPUd4MGPYKRrEm58eLli6
	qC2hA9CFLsLahkcpjGyXstn9Q7IztNN8PLUtCBfK9iimq7f0ElguFRVBaTt15sDPt1G0gkxpM2g
	QfraCzVpFkL8oID9oaeaYhx9aYR7l/PuStItTTXWOAfpQLhfslkluBXYdVpw7IVxOyZcdXG/tuG
	PbQ6AhnHnT3t3TM41VGtrW/+NG0YwWEYGu2vfJgoc/rlsNJDmbuuoG/jU1qT4LG+22Y4/5XLiXT
	JGXgFuWIirz08GL9Td9r8=
X-Received: by 2002:a05:600c:1d24:b0:485:379b:57bb with SMTP id 5b1f17b1804b1-485566c69a5mr270319685e9.3.1773727438078;
        Mon, 16 Mar 2026 23:03:58 -0700 (PDT)
Received: from u94a ([2401:e180:8d6c:7ab0:11ab:2f6c:191f:b326])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece845022sm130532745ad.83.2026.03.16.23.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 23:03:57 -0700 (PDT)
Date: Tue, 17 Mar 2026 14:03:51 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/2] bpf: Avoid one round of bounds deduction
Message-ID: <zdpe5txozbf5rc2clyouvptmtdsuu5eifq4t5b4ctfsxcmkxgq@txdvyjoirvyv>
References: <5b8fed05cc97cd3730bbdfbb452699b7edd16963.1772840030.git.paul.chaignon@gmail.com>
 <621f8a301a3a29af041ea8384ab09498e3f20322.camel@gmail.com>
 <d4f6ebe35ff98cf3aeabe132027d7a05ae4dda4f.camel@gmail.com>
 <d6ed91eb3fc9783811ae9981728a5db57decbfe4.camel@gmail.com>
 <xec3lnz6smkki57civu5z6hlr5vl6kqnec7f7zxza4vifs2qf7@g4o6gxqmcnlz>
 <cc228139101e28d2bc76beb371a2c3f89eed75f3.camel@gmail.com>
 <abMHY2sCSe6xEKR3@mail.gmail.com>
 <wficveatl5cscfiaasqanow72ejlzifrcatj7z3r4dtu6nul77@bpfukkbrhml6>
 <abPq5E33cehxfOjq@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abPq5E33cehxfOjq@mail.gmail.com>

On Fri, Mar 13, 2026 at 11:45:56AM +0100, Paul Chaignon wrote:
> On Fri, Mar 13, 2026 at 10:17:52AM +0800, Shung-Hsi Yu wrote:
> > On Thu, Mar 12, 2026 at 07:35:15PM +0100, Paul Chaignon wrote:
> > > On Tue, Mar 10, 2026 at 12:45:39PM -0700, Eduard Zingerman wrote:
> > > > On Tue, 2026-03-10 at 15:56 +0800, Shung-Hsi Yu wrote:
> 
> [...]
> 
> > > Thanks Eduard and Shung-Hsi for the amazing reviews and contributions!
> > > I'll send a v3 with:
> > > 1. The renaming commit from Eduard.
> > > 2. The initial reshuffle + additional reshuffle from [1].
> > > 3. The removal of one __reg_deduce_bounds.
> > > 4. The selftest and I'll see if I can craft a second selftest from the
> > >    new inputs you shared Shung-Hsi.
> > 
> > Perhaps I can try to see if I can come up with a better example, from
> > the difference between initial reshuffle vs additional reshuffle.
> 
> If you have another example, that'd be great. I tried to convert the
> inputs you gave into a selftest, but I'm starting to suspect it's not
> possible to reach those inputs.
> 
> I initially tried manually. For the first example, the trick was to
> write all (or most) jumps needed for the different bounds and then find
> the ordering that puts us in the exact case generated with CBMC. After
> failing to find that manually, I tried the brute force approach:
> generating all ordering of those jumps with a selftest that fails if we
> reach the state we're looking for. That also failed.

Hadn't further toyed with the counter examples yet, but given what
you've tried, I agree that it is highly likely not possible to reach
such inputs. So perhaps that additional reshuffle was not needed after
for the current codebase afterall (but still, we're much better off with
that merged).

> > 
> > The problem is that I'm operating on a simplified assumption of "not
> > being able to converage to a fix-point is bad because it could lead to
> > bound invariant violation". So taking this chance to ask, does that all
> > ties back to is_scalar_branch_taken and reg_set_min_max (or was it
> > regs_refine_cond_op) difference?
> 
> As Eduard answered, not reaching a fixed point in the refinement doesn't
> lead to invariant violations. It's just a missed opportunity to get more
> precise bounds. In general, Agni tells us the refinement functions are
> sound so if they output ill-formed bounds it's because they were given
> ill-formed bounds as input.

Thanks for the confirming as well! I was thinking about whether the
bound deduction patches were needed in stable as well, but looks like
there shouldn't be any security implication without them.

> > 
> > Also, when we fail to reach a fix-point, it does not become a problem
> > immediately, but only becomes a invariant violation some where down the
> > line when we again do bound deduction?
> > 
> > I haven't actually look into an invariant violation myself, so details
> > are rather hazy. 
> > 
> > > > [1] https://github.com/eddyz87/deduce-bounds-verif/blob/76755f763f9282b74ca4e2251f83767502a98e5e/deduce_bounds_new.c#L321
> > > > [2] https://github.com/eddyz87/bpf/tree/deduce-bounds-reshuffle
> > > > 
> > > > [...]
