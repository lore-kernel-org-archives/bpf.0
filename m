Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792697962;
	b=yV3rbpcGiPep80T8hhzOVz+abl495Nu1e+TOixJn3BeAFqqJGxXSdROUPf0uPKmedUDQ
	 k91POheUyATH6EeNmqbbRLpbLsPS1gxNl4GQ+mP3H4oMrtxT2CcDdYL3MGuXDEDay3jK4
	 b3keGMYD/h8dpU2AD6mqjrk5ucNG1v4aczUMwSNfKrz/s3NjL8+B4+074NRSQ2RlsVLV8
	 MiJAJ+tNIfUhFLpVdzO6+/WbFYtN/N4vNc25ktyPHof2VzuxuaVoQ107d8n+egfwIrdhD
	 23mD654bJhYHD1swbEZ72goldpfEo7ZyA/RQoWpn3bYodgGQWoWDCsAtnx0mfxdvPPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792697962;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=CXFOQ58yRb7ArLvRTOCPZICunogkgYzN7mdYgP5TB4k=;
	b=bGawv1xgE3/ThDoi6paH5AtBWWGObMNMen1CPxR6EPiesj/WrUKxQ4hfyY4jFZRvaGUD
	 v/ataQClfhgA1u6ommCHLTZ1Ire7IWcH6sw0KhIrdj4RXk45+fflkrcU9ZfYykQpERM3m
	 H5fN7jN6Qpt8FCSh9gFjxefg57DaNEwZU61OlaeirbnGuK+ld+AifcocZOH31VEndItud
	 mj9uIVY+wMHuZfm+OSDiX/cxAeKwwQEbjBSc7eMezwFYG83nvQDw34NFjmyMWQWhDYKVf
	 yiqbOaZt8fl40Rt2OmiOhXGz9RqyTkwBcog9HsejVgIhRbTwNrsmKTVY78GwAVBQKiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GI6wq92a;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24383606A31F
	for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 19:39:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24383606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GI6wq92a
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a1df4c0966so538525e9.1
        for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 12:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792697960; x=1793302760; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CXFOQ58yRb7ArLvRTOCPZICunogkgYzN7mdYgP5TB4k=;
        b=GI6wq92amG3nXNJXsW0bjacM5JKVAtiI+15FQxc2gYUuHQaZoVQXWcmIeHMtniURgc
         BWFJLZ0UhbDA8ScFjafYyvw6eQ/FrxXuLcfbrcZN9O+pczbA6iP5FlGylaiD/OnrSmPt
         rBPznyHGS7EWacu+54N5982SnUgeW9KwCAkW1BxJ8KkqJmyTikQx0VpItb+6KYw+dFG+
         P7uX6jcpYfdLqmNC/rKD42LaTtyh7ItkDB9U3gNiVAtuReY5gJxz96/Nl5fThSbgROZG
         13jJZfqJeTcen7XZX2fnE9IRfWJMCN6AWv/reSUKzZKsK4XylhuQLfU1Y0wc/d0VBUrf
         cfxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792697960; x=1793302760;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CXFOQ58yRb7ArLvRTOCPZICunogkgYzN7mdYgP5TB4k=;
        b=rreoLs/po58JYy0G5EpGnN/PqrYSxm8ZtI8c2Tp9jKlen8ETd0eo1cbOe1QA1sHnqC
         ws3orNmAfL6eV7KVPcZNQ/TRVO8NZyLF3rk64B+NL8ZcDpN3FYuzWZ5VQc/3U4A/tb6x
         JoNyPYwXkmzhhFdGJ6gLhWL3N3z5Tlcy9pQugZQQO2zmcUGTrCKXnxFjiqJ32MKiskOL
         1zQnhvybxr8CQyGMw25zm/y20caR0aXEV9s3qt2ocjPknDO7xBP5B/lS5RZIV9/Lu2DB
         ri9BIBx0KjJbNML4leFbSU19qwXTcXeCke9gLx592aQhYsTC1q2PPF9K2STc8XcMgOLZ
         sg/w==
X-Forwarded-Encrypted: i=1; AKwUvBxaurTru2Ufsh62FAoKlDUxHf/VqAV9oZL2fJ6Ax0NCe2JChQGv4gYAd1dGEB2n6j79va8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLoqeUyxptn2gOQKFo6K2nQK46dwOLe7NLyH8eOj1r7NOx3+0GK
	+I0otmEI8TId9Eo5x6thFgagt3qwXSU3ZxxnB1z3xA7vc5lFZYCK1SNX
X-Gm-Gg: AYBFou3DkhjU4Ebdw6/oW6V69PF2jsG3B95wkgje60QU68LJB2TTJoNOAhdPKXvskS9
	Q16EY9OJBjUDWK3t6UfzIq5xat9v3EM5UOAzLfP3+i3hBi1oIdy0o+3CVq6DUMOujB6PFYAvi7y
	O3J4GXYx9adG+PolU8pmNpZVbOy02wNc5cNBaoZ0HouBaDL3TMXQW4sbK1Z8gdrFIZoKytlSO9d
	SeNPK25+xbsk2LdjUlI/mTcMguzNa7KprbRW0iUpkpIIOY4Hc/Z5M9B1DcAFF3M7tSF3iZzZmnv
	ITjjhlOWe37E7cy7+ZOb8pFdN35Tw7G0LdpyacX5LFMsC3iuZZ9yBs41JfkS0aMSzGyo0T9+71S
	u+ClPPjVjL6WDJyEW3xHjsJ73lezJ0MtRN3wrxr+NKKBWGYlE4a3BNJkCmePI1fO92PDgkqHbkG
	TG5gi2F4z+0wdkIKkFklPeKfCyGSwyBkQQRGuDKcPXU+pY7Lvk9hpqbZmNMn2SAmeJPfHwCyJJo
	/+81SZ0IeSKc9Pz1N1akpwFdkv0MruglCYjzrQ66j4=
X-Received: by 2002:a05:600c:1d1e:b0:4a0:34a:588c with SMTP id 5b1f17b1804b1-4a211c859dbmr1721105e9.14.1792697960247;
        Thu, 22 Oct 2026 12:39:20 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a2101cedcesm20827015e9.0.2026.10.22.12.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 12:39:19 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 22 Oct 2026 21:39:18 +0200
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>
Subject: Re: [RFC bpf-next 3/9] mm: Expose locked mprotect operation
Message-ID: <atpmZt_Je09hdlja@krava>
References: <20261021195759.119421-1-jolsa@kernel.org>
 <20261021195759.119421-4-jolsa@kernel.org>
 <atnjEc2-6CuKjFzH@gremlin>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atnjEc2-6CuKjFzH@gremlin>

On Thu, Oct 22, 2026 at 11:25:31AM +0100, Lorenzo Stoakes (ARM) wrote:
> On Wed, Oct 21, 2026 at 09:57:52PM +0200, Jiri Olsa wrote:
> > The bpf_user_page_exec() in following patch needs to change page
> > protections while holding current->mm's mmap write lock.
> >
> > Exposing the do_mprotect_pkey_locked helper for that.
> 
> Err, we'll need some more justification than this for exposing internal mm
> logic to the rest of the kernel please.
> 
> Note that you're already allowing any caller to bypass
> CONFIG_ARCH_HAS_PKEYS here which is immediately a broken thing.
> 
> >
> > Assisted-by: Codex:GPT-6
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> It's a no to this in its current form.

yes I suspected it'd be a problem, but as you mentioned
in the other reply, Alexei's proposal takes care of that

thanks,
jirka

> 
> > ---
> >  include/linux/mm.h |  3 +++
> >  mm/mprotect.c      | 20 +++++++++++++++-----
> >  2 files changed, 18 insertions(+), 5 deletions(-)
> >
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 63f40e615754..47e853093601 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -3435,6 +3435,9 @@ extern long change_protection(struct mmu_gather *tlb,
> >  extern int mprotect_fixup(struct vma_iterator *vmi, struct mmu_gather *tlb,
> >  	  struct vm_area_struct *vma, struct vm_area_struct **pprev,
> >  	  unsigned long start, unsigned long end, vm_flags_t newflags);
> > +/* Caller must hold current->mm's mmap write lock. */
> > +int do_mprotect_pkey_locked(unsigned long start, size_t len,
> > +			    unsigned long prot, int pkey);
> >
> >  /*
> >   * doesn't attempt to fault and will return short.
> > diff --git a/mm/mprotect.c b/mm/mprotect.c
> > index 2888ee638d87..8d800830d3e1 100644
> > --- a/mm/mprotect.c
> > +++ b/mm/mprotect.c
> > @@ -868,8 +868,8 @@ mprotect_fixup(struct vma_iterator *vmi, struct mmu_gather *tlb,
> >  /*
> >   * pkey==-1 when doing a legacy mprotect()
> >   */
> > -static int do_mprotect_pkey(unsigned long start, size_t len,
> > -		unsigned long prot, int pkey)
> > +int do_mprotect_pkey_locked(unsigned long start, size_t len,
> > +			    unsigned long prot, int pkey)
> >  {
> >  	unsigned long nstart, end, tmp, reqprot;
> >  	struct vm_area_struct *vma, *prev;
> > @@ -899,8 +899,7 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
> >
> >  	reqprot = prot;
> >
> > -	if (mmap_write_lock_killable(current->mm))
> > -		return -EINTR;
> > +	mmap_assert_write_locked(current->mm);
> >
> >  	/*
> >  	 * If userspace did not allocate the pkey, do not let
> > @@ -1013,10 +1012,21 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
> >  		error = -ENOMEM;
> >
> >  out:
> > -	mmap_write_unlock(current->mm);
> >  	return error;
> >  }
> >
> > +static int do_mprotect_pkey(unsigned long start, size_t len,
> > +			    unsigned long prot, int pkey)
> > +{
> > +	int ret;
> > +
> > +	if (mmap_write_lock_killable(current->mm))
> > +		return -EINTR;
> > +	ret = do_mprotect_pkey_locked(start, len, prot, pkey);
> > +	mmap_write_unlock(current->mm);
> > +	return ret;
> > +}
> > +
> >  SYSCALL_DEFINE3(mprotect, unsigned long, start, size_t, len,
> >  		unsigned long, prot)
> >  {
> > --
> > 2.54.0
> >
> 
> --
> Cheers, Lorenzo
