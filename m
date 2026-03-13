Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C16128395
	for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 02:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773368286; cv=none; b=T9pKjMv0OALdMwYdahqkfIb9BmuKXdElhDG1szC15LBxfWazGnATeWmha8Wa59DKZ/+NEZv2YP62bSyom0nmlwdaJbffszCTfhHk6Sk7ZSRLvNHyDdJCV4xBsj7jldlFL3wx70K30+16kG5EYAGsChIkIMT8KQOHndyqRTS9BmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773368286; c=relaxed/simple;
	bh=RO5L0IcsPTwoCRx/lx4zdhtJ9vMf/LzxnekwLj6RS+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q7v+5nvP3/Dc7VniIvsj2bMi4WmEmzScyaiRqLijZH4xIznSn43OuqQ7OV99/Y2MAmFzo8m9cSaWf0KvNh5Q/eHfgZnMO50kyan27eyKIWEbIwLQwiLhw7+FfzSOd+opjoShQg+1HPBNIzlW4eJlJqgt0BWZEhx1EPm0pU3aKto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ka01h3rC; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ka01h3rC"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48558d6ef83so1271025e9.3
        for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 19:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773368283; x=1773973083; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PlFYSYiXO4Zwx7UG7C0mcEOzk5R3gKj4A/DxDA+DOoU=;
        b=Ka01h3rCGZHgCFKcVjkmQPywK1MKVi+dRw7Lr7R/e4b/Thn7D3EwC2jlCOB4pVQAF4
         mNrzL30Phw1tVQpW48IV4mpsud9+14IVE0OH64V15NDXyrSR9Ym9L/96/KXcC7H1As8I
         xApNFBlOZux0NMEbsteK0P8eKMb5q/xR5k7piofYjmwq42uR6vd8Fb4HnN37IhleVXOw
         mf6xo1GgzGoODpXeAni40ndkQQ8R+L56rDq28OwpfrN8oBUBSHrEtL+g7HvaOkony28o
         wHENfsrS940/L9FE4L1A1Uvx/uYVDDs7nUbxSD+0/kfVabcmXC4AyXjB4dw+UPonjWgd
         gK4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773368283; x=1773973083;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PlFYSYiXO4Zwx7UG7C0mcEOzk5R3gKj4A/DxDA+DOoU=;
        b=Rr+VZHmHDpFu4VYvpKziEuQRI2WLAg0SUfjk1rMQQWGkAGufTk+OrhrekRzcmVHBsx
         XotjVvGljR/yOUHpm/3MaKoVWS7Kb9TpOgePu5HS+8dURQDxkhkv00mjuM74ZTMsFrS2
         snGF3XSySUnhSxp/csYGYLTqj0Ua/L43/IlbTmi8smQ+vKu1HJESHEnm4/EwA2384twk
         jETYTr51gbhJMwaN6olgmhgwKXZP8gb+asJlk4Nb7dBOF4XrNVrudixh5rOeHg33Fuml
         KpTJka/6yGeQucZUZARA/XBesVRQjR8NNW61psQp++xBAmNM6o5itVjJl4ivumvNqcDM
         p3Ag==
X-Forwarded-Encrypted: i=1; AJvYcCULy0Dl9PAR5aFfJrR2G6ZYx17VoRaLhY0Kiu0yCE5vxTKotTd6bmsghNoVRClzKIZ5cxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEV5SPbZVgDX+l4CwLMedg7vpBxjPjyFuZT4+vw5FDXjAqNbbO
	oqDYOGME/kL5MJAZKt2MvIIkfbFrB06J3+IxlxcuxB24EPHZfPVPWWozYyJ+iJz4RKU=
X-Gm-Gg: ATEYQzyUkbpk9JJHsjo4oBcjPbWgcvrFSR+KXR7gMXlWHaNFoYQc2kOVqTRtrVYp1uy
	Wr0qpquEcTP9wJlMJeaeqE7xX5PBoc+OKAnQSkF/O3FGv3O/bDJcGWaNtbQxwMcYG6x+bAKoXy3
	CiBLAHF82hvy7j9s8OzUemgWZ9ANg13OrZup9YmTy2AIqpKYYmoICjwVlOMr1wO5H4PcjxOqqkS
	Smp/WTYtPxF7x/9dvpgozJfB8r5MNzNmyeo6ogHqkuMaV3UbIU1vLm5ei19qq6LyuadHspH9fJT
	D8x8FlRvJmDDfrfchzXllSGbDk2zSugBHXrWX5Gc976VbneyjW4mTZx9v42mY6o7VcL/SEgy2Sz
	qBP6nhRf5CieWIW8I5Q6MKPP/AvgfTKMf28Hp5iJQS+9HP7hQQ2awFouI5ZYa/YQwLXYcGZAlq/
	7fxIP47oYkE/dGmRfhxB8=
X-Received: by 2002:a05:600c:4f54:b0:485:3b5b:eb8 with SMTP id 5b1f17b1804b1-485567052b8mr21200495e9.26.1773368283049;
        Thu, 12 Mar 2026 19:18:03 -0700 (PDT)
Received: from u94a ([2401:e180:8d68:7358:55be:6563:4437:e6fe])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a07384a7dsm4472256b3a.57.2026.03.12.19.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 19:18:02 -0700 (PDT)
Date: Fri, 13 Mar 2026 10:17:52 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/2] bpf: Avoid one round of bounds deduction
Message-ID: <wficveatl5cscfiaasqanow72ejlzifrcatj7z3r4dtu6nul77@bpfukkbrhml6>
References: <5b8fed05cc97cd3730bbdfbb452699b7edd16963.1772840030.git.paul.chaignon@gmail.com>
 <621f8a301a3a29af041ea8384ab09498e3f20322.camel@gmail.com>
 <d4f6ebe35ff98cf3aeabe132027d7a05ae4dda4f.camel@gmail.com>
 <d6ed91eb3fc9783811ae9981728a5db57decbfe4.camel@gmail.com>
 <xec3lnz6smkki57civu5z6hlr5vl6kqnec7f7zxza4vifs2qf7@g4o6gxqmcnlz>
 <cc228139101e28d2bc76beb371a2c3f89eed75f3.camel@gmail.com>
 <abMHY2sCSe6xEKR3@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abMHY2sCSe6xEKR3@mail.gmail.com>

On Thu, Mar 12, 2026 at 07:35:15PM +0100, Paul Chaignon wrote:
> On Tue, Mar 10, 2026 at 12:45:39PM -0700, Eduard Zingerman wrote:
> > On Tue, 2026-03-10 at 15:56 +0800, Shung-Hsi Yu wrote:
> > 
> > [...]
> > 
> > > Agree that perhaps we still need to keep 3 rounds of deduction after
> > > poking at this further.
> > > 
> > > I tried to run an updated cbmc script[a], manually editing the file to
> > > change the number of __reg_deduce_bounds calls made, and check whether
> > > an extra call would further change reg_state. For
> > > __reg_deduce_bounds_old, it needs 3 calls to pass verification, and for
> > > __reg_deduce_bounds_new, it still needs 3.
> > 
> > Using the same logic I played with orderings a bit:
> > - For new ordering 3 and 4 deduction rounds are proven to be identical.
> > - For ordering in [1] 2 and 3 deduction rounds are proven to be identical,
> 
> Nice!

\o/

> >   1 round is not enough.
> > 
> > So, I think [2] is the way to go:
> > 
> > static void __reg_deduce_bounds(struct bpf_reg_state *reg)
> > {
> >         deduce_bounds_64_from_64(reg);
> >         deduce_bounds_32_from_64(reg);
> >         deduce_bounds_32_from_32(reg);
> >         deduce_bounds_64_from_32(reg);
> > }
> > 
> > With __reg_deduce_bounds() done 2 times.

Can confirm that's the case on my side as well.

> Thanks Eduard and Shung-Hsi for the amazing reviews and contributions!
> I'll send a v3 with:
> 1. The renaming commit from Eduard.
> 2. The initial reshuffle + additional reshuffle from [1].
> 3. The removal of one __reg_deduce_bounds.
> 4. The selftest and I'll see if I can craft a second selftest from the
>    new inputs you shared Shung-Hsi.

Perhaps I can try to see if I can come up with a better example, from
the difference between initial reshuffle vs additional reshuffle.

The problem is that I'm operating on a simplified assumption of "not
being able to converage to a fix-point is bad because it could lead to
bound invariant violation". So taking this chance to ask, does that all
ties back to is_scalar_branch_taken and reg_set_min_max (or was it
regs_refine_cond_op) difference?

Also, when we fail to reach a fix-point, it does not become a problem
immediately, but only becomes a invariant violation some where down the
line when we again do bound deduction?

I haven't actually look into an invariant violation myself, so details
are rather hazy. 

> > [1] https://github.com/eddyz87/deduce-bounds-verif/blob/76755f763f9282b74ca4e2251f83767502a98e5e/deduce_bounds_new.c#L321
> > [2] https://github.com/eddyz87/bpf/tree/deduce-bounds-reshuffle
> > 
> > [...]
