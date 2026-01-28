Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D5D3382D0
	for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 08:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769587580; cv=none; b=qACXN2kcTh9L7palIwqX743of39geca2XblmshnM7S7i9qLWGwqr9zmmYaWmzhthG25TzpPsKx3ZlJT0Vn4WsI8024qQcoCx7UCeqJInlYyflxC5szA5htLq6YXDAFMQf2+gzcbL/kB8PHX0cV8bahjbLOVw3p1qCAP4TQnBCkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769587580; c=relaxed/simple;
	bh=SO1TGZ8xW8231LsE450thXtlIuI21DNJjXgehoRLYWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tH25ce6XI1fDvNkYjoEWwt+0qOsMWTCb4Om/jzpQyvl0AK4jK+jYjIO7JBQLpiVB1fXbw3KVFCuPjjhbDIMXJVG3P1uc0xsjwl8ELGPR8itAL7NmqDJkQ1TUt/zKI5rl/r5vc6GFk0Af0p/IazWIRcGUYqACLz5gu61HnncrYhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=O2ENoo8/; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="O2ENoo8/"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4358fb60802so340378f8f.1
        for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 00:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1769587576; x=1770192376; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=enqYBRxEAs7b1XTfNQDYASta7yWhNLiXox4ui9P9FD4=;
        b=O2ENoo8/bEW8gcdI/dgvzkXUDm8xvSOnIlc/ZfpX7PaEAQXJMv9Q6nF+MVYRvzADqq
         LNNQSt2jNx7QvqlQxRQuzG0LvLD6ENqrTyUUXRyo1/v/uLrQ6I/7O45mb6BV+G+U+Ocu
         Ix5dTtHtPuxGZT1xi+3r4gWZ0j3y8eIFZB27FVcT/Lr06y1ba7uFzyjcXDIjcmZKZSt4
         aBLxtAqNTgiwU1DE33LS4ksm/vyIvRIHitpD9hzbD13L+xp8kD2n3ckRYTw3ivz4g0cP
         OTYDOO3wYQSHYaUqcss5P0ggpPsqLYWBYWu3huTWdR0zmDY6G5mM/C+yc0/wTztVnMux
         6K+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769587576; x=1770192376;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=enqYBRxEAs7b1XTfNQDYASta7yWhNLiXox4ui9P9FD4=;
        b=pYdwEzERytQ4hGt5oSNmbL1craZH/2X6UM7jSZCCkTmbGHGBrNU+dFdYl7QFEO4808
         teav+YkOp1kIK7yJSjqpEm7kPWPA1fDg4tALH9lWfYrDVy4NuroDPs5GLzYF58XK+iG1
         d4WCVJsAg1JtI/iEpTwg1W+DCfQvGYP1qYjcobbwi7Kirz56j6/wcwcUe3pUoGQR92+E
         AMjI8vZCN9YjI1e01Af1MIH+bCU4SjxbK7KmFoKnJpRcC6qoZKSPZlREANaFFPbCBo6D
         aenxUt3dQSP5cu2pVF5i759DqjG3fOs+sLLxZtni/wJREEbDdPNr8pIhFtqlpaT3ssZU
         JvGg==
X-Gm-Message-State: AOJu0Yy12aLTxItG4bjK+JTUh7cUMeSkLtoSkcTduxblUx/NL6vxtXLt
	Tp0QTPlZxitFtzdtztgpeh/Dr7dcjO/iGKjBdwkeiYjmELS0rmEbQaMD7biPGU40hBI=
X-Gm-Gg: AZuq6aJO1EaMo6KJ/7WRyJ+dsHmbBABop/fyj82UI7NvpxdZIgdINDWeIyUs7v0p1gT
	ZzGklHwdpZCx4w36kVauL+OzVsmIX5WznRwkTm2VxDnB1wqGr616L0OwTcb/PXzmSndMn873eVx
	bSZzJ9jfD24BQ9foOakt9YeF1eO+93pkdSHPfPQYItUoCvaJ74GHWBJpINoqEaRDL9NxxrHmAz9
	wd7XEqXVsVdGZaM/fLWQL+OY2+5BAJ9BJDfAlbEp3m333FjQEMbBLf6q8aVRTt6yxYxkG7bFGAB
	3glDj/+9OwpQU1UhELPrx8F+o0Di58cmkEjsYdiZmA/2lVWE/ARDR8du+EtzkHtA7oGToZP+Sqg
	A/2ch86qFIrWjZt5iZSBe//WuKZa3dRoix/L1MGtotXJ3JnktD5M4tiZGnuWrc1iPQgTvGTitMY
	0KDbWMXXLasTM+Pe+pc6/2pwJk
X-Received: by 2002:a05:6000:1787:b0:435:9a18:5a29 with SMTP id ffacd0b85a97d-435dd1ba13fmr6723122f8f.11.1769587576172;
        Wed, 28 Jan 2026 00:06:16 -0800 (PST)
Received: from localhost (109-81-26-156.rct.o2.cz. [109.81.26.156])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10edfe7sm4930747f8f.14.2026.01.28.00.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 00:06:15 -0800 (PST)
Date: Wed, 28 Jan 2026 09:06:14 +0100
From: Michal Hocko <mhocko@suse.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	JP Kobryn <inwardvessel@gmail.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Suren Baghdasaryan <surenb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH bpf-next v3 00/17] mm: BPF OOM
Message-ID: <aXnDdkYmtipGwSjK@tiehlicka>
References: <20260127024421.494929-1-roman.gushchin@linux.dev>
 <aXh_LpTzDhvv20uB@tiehlicka>
 <7ia44io6kbwj.fsf@castle.c.googlers.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ia44io6kbwj.fsf@castle.c.googlers.com>

On Tue 27-01-26 21:01:48, Roman Gushchin wrote:
> Michal Hocko <mhocko@suse.com> writes:
> 
> > On Mon 26-01-26 18:44:03, Roman Gushchin wrote:
> >> This patchset adds an ability to customize the out of memory
> >> handling using bpf.
> >> 
> >> It focuses on two parts:
> >> 1) OOM handling policy,
> >> 2) PSI-based OOM invocation.
> >> 
> >> The idea to use bpf for customizing the OOM handling is not new, but
> >> unlike the previous proposal [1], which augmented the existing task
> >> ranking policy, this one tries to be as generic as possible and
> >> leverage the full power of the modern bpf.
> >> 
> >> It provides a generic interface which is called before the existing OOM
> >> killer code and allows implementing any policy, e.g. picking a victim
> >> task or memory cgroup or potentially even releasing memory in other
> >> ways, e.g. deleting tmpfs files (the last one might require some
> >> additional but relatively simple changes).
> >
> > Are you planning to write any highlevel documentation on how to use the
> > existing infrastructure to implement proper/correct OOM handlers with
> > these generic interfaces?
> 
> What do you expect from such a document, can you, please, elaborate?

Sure. Essentially an expected structure of the handler. What is the API
it can use, what is has to do and what it must not do. Essentially a
single place you can read and get enough information to start developing
your oom handler.

> I'm asking because the main promise of bpf is to provide some sort
> of a safe playground, so anyone can experiment with writing their
> bpf implementations (like sched_ext schedulers or bpf oom policies)
> with minimum risk. Yes, it might work sub-optimally and kill too many
> tasks, but it won't crash or deadlock the system.
> So in way I don't want to prescribe the "right way" of writing
> oom handler, but it totally makes sense to provide an example.
> 
> As of now the best way to get an example of a bpf handler is to look
> into the commit "[PATCH bpf-next v3 12/17] bpf: selftests: BPF OOM
> struct ops test".

Examples are really great but having a central place to document
available API is much more helpful IMHO. The generally scattered nature
of BPF hooks makes it really hard to even know what is available to oom
handlers to use.

> Another viable idea (also suggested by Andrew Morton) is to develop
> a production ready memcg-aware OOM killer in BPF, put the source code
> into the kernel tree and make it loadable by default (obviously under a
> config option). Myself or one of my colleagues will try to explore it a
> bit later: the tricky part is this by-default loading because there are
> no existing precedents.

It certainly makes sense to have trusted implementation of a commonly
requested oom policy that we couldn't implement due to specific nature
that doesn't really apply to many users. And have that in the tree. I am
not thrilled about auto-loading because this could be easily done by a
simple tooling.

-- 
Michal Hocko
SUSE Labs
