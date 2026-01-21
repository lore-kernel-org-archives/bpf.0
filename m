Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE69C34165B
	for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 17:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769017157; cv=pass; b=oWsrlISQMDDumbq6KZSiwr+vTxRC0cdYkfUociLqOb7mTr18EtNWzYSNL9Z2oq47r27E1dAqgDrj+c6Fh7il6sBffzXcgmp5wbdIhLp42Gk4OfD/ruGgDTJHn6qG2Quj8BuyQ9VJoIab/tX5pBqSOvvKM/p7kafg08vvCnd1QeA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769017157; c=relaxed/simple;
	bh=qCmYva5jEN1tFWNy0cKXK4uKFZcKVDLG/DhghvX0UxY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qAJKbBlKiYFt+Yl3LCSgSIhwgVoOlQVViX8S2O3hY7FCudTs3J5Y1HNf+admbKJR3gOVjuxeFwAaX217IlopLUb4nDp10vCSYOknq7in63g3axoUJmPm623omhxkW36s9ZN3h8lmQ72hDuxM+pq0+vID1XEf/EZfZmx4lh5D3MM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VfYltyIl; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VfYltyIl"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5014acad6f2so144401cf.1
        for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 09:39:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769017153; cv=none;
        d=google.com; s=arc-20240605;
        b=By8bx6sBY7WltVz0GAjXt68HhbW7p3EOXhdXYaSsxq+tLKnxqrF0e+qH8MmkhsVlJR
         dO8OOWkUmgeYr6HOmbvzigUHYfY5g1bQu2n/U+XKTP4Gq6vF3CzP3PxWjrm/ii4OSifn
         d0yzO4DMyubrI8j5tsBR+9zCWzghEunBQwa4x38dkiYr6nlov+LCFCthMn+N1ZCJXtJ+
         b2aGdzyhRrxaTbdIggEytG+VwnT/Tfw4T7vGRZ5BEEuxXLM1fyY+xcmCBOtbX8cZHk35
         jXcxwnEi3ydBQu7CoiPFy1/p1gt0AMmNzDR949P41pT9iMMzAfC9Bszj9bzgy8lQRKro
         0jnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WZPB/nAuSxHMF8z7YKq4XwyLCyx1N2zE8w1NIox3Cbs=;
        fh=Rpec4Qh8eYyf3OYx15wBOM73ytppKAqmbrkthYesaTQ=;
        b=OQDspCXm/uCZga9X0NlHcAQOyWPZbR8aVD3c8H84p0aenVwMqmYz9PvJE1/u75Lo4I
         yDQnhmpVKN0dXOG/dGnbVxF+J0lhpLDUuEkwZ+onWXKY9L5Yjj12VdHw18ZEu/NZfY91
         XC+IAuhjPMgPhDCCUSGgRtw2WmKvKgEKjyixYN2HThczEBLi7dj1t2CX6hQcyZKy4SH4
         q75cWKnf62H78iN/dAKOG+1ei4PYrkcZz13GL9R6Oj7SRzfxIjmcaIuXLfiLtn+qgmf8
         7HloCSBkudtoVV6H3l2pNhmc+B42HxPAW9x6FjbXZHuBC0BgLsD/+Vg9Acdmr2LQpbmY
         IR3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769017153; x=1769621953; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WZPB/nAuSxHMF8z7YKq4XwyLCyx1N2zE8w1NIox3Cbs=;
        b=VfYltyIlrzU+xYJNFGzoJJD8fPYy1xTxzlqJZ1Zt74WgaY00Nberp4z9/V3R5PL//1
         EEvhO7p0/z1fSVeXTocwnRkiGeyvQeiQYtCYUA27SkxoeOp4/M8Xagv5RPa8Acxgj+KD
         5eHxGwSXk5WFt5m+xow0RJASK7O7wHnvotPy2oNmdGJtp8m0W8UOv1DmPwCyUN2pGt0B
         liKdWKxjZ26TfK8dhSYu3PM5VC0EIRbyBQJcrFadHRq7GlnLKnHo6Cb2UB8PuvYH4QMN
         tMzsjoyRXLYbBFNexTEFKvOAT4Ml/+Dp2dGOYwxrQfw0JxJh9sBAZv7hSNhvlLUSKdXZ
         bRtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769017153; x=1769621953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WZPB/nAuSxHMF8z7YKq4XwyLCyx1N2zE8w1NIox3Cbs=;
        b=MlJD6Ze8TM7Ehak4FutpVO7RJ9WebJQbsY/gNj+uST7C42mc69SGQkUrA5yhT3gQQ2
         X3VM7FnNAjvOZ/4Ohc+gCc/epDo8qmqk1Xp+jLD+1cTYXUqIBNruMZ/WTsc8RjNeixlc
         22qc4zzl9BLZpje/ODtgp270BpV6xvB1xtmZIt9wsd57sTVIZsZym/UtnxC02iTQVc0V
         2gG0Z1YwWg9Teycasx45qf5m3YRs/JZ9eD7evuiGZO3IMhzDOK/4GO7FHltpr9VgLxO2
         ++/b5XvBDUT4iV/A1uOiSMxhyMCfPFJJytmgZKSVxQOFuolJ3nGCS8YxvOEEx7Z5nn0R
         646g==
X-Forwarded-Encrypted: i=1; AJvYcCXuUNf09hu7H0Lxm9NrL1oOxvArt19PVXMxlblOfYK6kGoe+AmPEsinha5NKXAF6DRiJrk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDCuTUkOblDVNVEkI4rTIja8zfJcO0CmVLhO2pu5mEWgkSDdXv
	1lQptfe3G+bjCh04W8nbNLh9owqA7UANWjheyL3BKUhClh6ttlLEWgs40Tb4XaEMNo+rv9GGm0V
	29FsPLNOVUMJhdfLkR1x7PQ3Ujwb0s6rkg/uniFBU
X-Gm-Gg: AZuq6aLKgBaBg+emxa6JitXDccBtzB4wLFRwH06OMQuoxTnCDrdFqa+axwwklXI7U0T
	fO64MDn4+2+q2/Roocgr1SS1LSxW6ZRl+Bo7iIYUfm48ungWgMHjKdKB17pTYzhbbGJkURsg7fd
	tQIVs9e6gNQTt/TaINyXS+tkXTCQ6lR/UJ5Oi+WT2EmhaCGiYxfkfUkPaAb2PxrNb7n8SlhxYg9
	P1UMZwFGdQ6qeLvgCYrDRIOycrFz3wzGPwnzAvTL2Zm93yn5Xgtaf2A70OeHqmPPqqv/8szCrb4
	jFT6BwDLSql5dZT8FW+7VaI=
X-Received: by 2002:ac8:5994:0:b0:4ed:8103:8c37 with SMTP id
 d75a77b69052e-502e0c6494emr14807601cf.12.1769017152599; Wed, 21 Jan 2026
 09:39:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116-sheaves-for-all-v3-0-5595cb000772@suse.cz>
 <20260116-sheaves-for-all-v3-14-5595cb000772@suse.cz> <2tvnelafuozzzfyvmxvflqmx2sepgy7ottnw4n2trkh33rrk6b@oewlapq3smvg>
In-Reply-To: <2tvnelafuozzzfyvmxvflqmx2sepgy7ottnw4n2trkh33rrk6b@oewlapq3smvg>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 21 Jan 2026 17:39:00 +0000
X-Gm-Features: AZwV_Qi3Y2iex4LEenR-glhvYF5fdvLAgmEL3JsgkohqCrj2SiE002EgBpgOZDM
Message-ID: <CAJuCfpHGSxK99sSDmnh+xqJOaqLX6vVoH4oyPUS7J6J74RU=9A@mail.gmail.com>
Subject: Re: [PATCH v3 14/21] slab: simplify kmalloc_nolock()
To: Hao Li <hao.li@linux.dev>
Cc: Vlastimil Babka <vbabka@suse.cz>, Harry Yoo <harry.yoo@oracle.com>, 
	Petr Tesarik <ptesarik@suse.com>, Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	bpf@vger.kernel.org, kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 20, 2026 at 12:07=E2=80=AFPM Hao Li <hao.li@linux.dev> wrote:
>
> On Fri, Jan 16, 2026 at 03:40:34PM +0100, Vlastimil Babka wrote:
> > The kmalloc_nolock() implementation has several complications and
> > restrictions due to SLUB's cpu slab locking, lockless fastpath and
> > PREEMPT_RT differences. With cpu slab usage removed, we can simplify
> > things:
> >
> > - relax the PREEMPT_RT context checks as they were before commit
> >   a4ae75d1b6a2 ("slab: fix kmalloc_nolock() context check for
> >   PREEMPT_RT") and also reference the explanation comment in the page
> >   allocator
> >
> > - the local_lock_cpu_slab() macros became unused, remove them
> >
> > - we no longer need to set up lockdep classes on PREEMPT_RT
> >
> > - we no longer need to annotate ___slab_alloc as NOKPROBE_SYMBOL
> >   since there's no lockless cpu freelist manipulation anymore
> >
> > - __slab_alloc_node() can be called from kmalloc_nolock_noprof()
> >   unconditionally. It can also no longer return EBUSY. But trylock
> >   failures can still happen so retry with the larger bucket if the
> >   allocation fails for any reason.
> >
> > Note that we still need __CMPXCHG_DOUBLE, because while it was removed
> > we don't use cmpxchg16b on cpu freelist anymore, we still use it on
> > slab freelist, and the alternative is slab_lock() which can be
> > interrupted by a nmi. Clarify the comment to mention it specifically.
> >
> > Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> > ---
> >  mm/slab.h |   1 -
> >  mm/slub.c | 144 +++++++++++++-----------------------------------------=
--------
> >  2 files changed, 29 insertions(+), 116 deletions(-)
> >
>
> Looks good to me.
> Reviewed-by: Hao Li <hao.li@linux.dev>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

>
> --
> Thanks,
> Hao
