Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81644E4C38
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 12:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791981316; cv=none; b=ig6Waa/IshqJ9ubYRcVOH/wMPfqmDi4zTBGfwcijzGQQIBj2X412/G/lOjmnsXYVoGQ+bQg+kpPFxL4fXMkKrx8V3d4l+30m3RTxP2OPnyZfrESWl5cJF9wsfraecVcSJysRbCXs+BFQuGb88Hc/XGw/80YfWIvRBx76G8G97Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791981316; c=relaxed/simple;
	bh=JID+5g3N2NzMm5veKoBPvH2ibg+eIuVR2toHlHU5Pb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=km3nXdJ6ppzx6+fXHRVzpoy70zARpLUtE+35jK1CVCSGMUljVTutGxUxqfoyMWNDBF4ACBb2zpNlJkSov4DzGUsUeNv72dmaaUjWVvW5PpH4vHzl3tqW5H1YQQMzX9ZNfprveY16PUCuIl/MltsaQhoUaBg9OZTvsQ2ih+72HxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=cUBpl6wn; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="cUBpl6wn"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-91054f537ccso46107766d6.1
        for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 05:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1791981312; x=1792586112; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QmQpU9PI8un7KuCGa3rKdlGVWqm4zvZIc3vocEo9k9Q=;
        b=cUBpl6wnmz0vitD8q+khvWzYLa+T9q1Nw88RWxGVwIl8bWmDCPTX8p3OccB+U+21J5
         YAfFXCaE7q4Z5WX7GC7/rJYRXoWWBfXjhaa6WIn8c+0O4RsAN5QjoYVQ8KqKKIszunMN
         3MYE6HaGGoon1IA+FXJDV45pAnX+g6Kfegm15lpDQxGV8nigGIuZ2B6n4whp7jt5xXCN
         DvPPtSdaYdi7C2JBkf0yjgaJxLkg21ahkDXX9QJZNz6JeT4V1XCGku/nrJ6kXG+LeyHj
         x2mTch2RKGEMJcWpr/nrSzL66emPTsklWtjx+4MhUmLce8B+uoDcv9CN2P1lY89MT91E
         PTCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791981312; x=1792586112;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QmQpU9PI8un7KuCGa3rKdlGVWqm4zvZIc3vocEo9k9Q=;
        b=P47r/a8DWnwnL5BclopiqTphrOXQlz73wsUCModrWmf43f5B9wdW0bcgGtCf0RuzNM
         ZcmmhnUmzs9aqKflmASMn96pAbaoI9XBWgIfaXejodFqN/rhxSJTx0asYxqnf63liPvB
         o0weghJwq4MhiVfwChp2qepHAcWvZyFz1/ib1C3wDwfBYd/Xh8DLyhU+2ZHNW+XIzgrk
         BQqChY8kcMbgtthYuy6AdD0i4VODuoY0rmsAafQ+vF/gVlP6zMIzq27qHhMS7q0TrdCT
         iVy6GAeLSZ3lSNghWf1iG0nPnTj/MIhY8TrrIBwKAU/+KooMmGD5r/eOQWOpCoyFoJDS
         4l7g==
X-Forwarded-Encrypted: i=1; AKwUvByfym0flcMre6VxRtb101kWM+YcLqR1fnEqBRFUsgq6q6UqugdKVVYz2PgXKWOOr5MrGig=@vger.kernel.org
X-Gm-Message-State: AFq9FYIo1MGrbtZ92WmkRU1X6awYrX6blIfR0K0BjlIp/d3Bv3YEZIQD
	oD2hGbV/T8eXQV2x1p6if6pKTYHhHxZdUKqIw/nNQmfJHFCt3XeAwdnBksbD8PygQ0c=
X-Gm-Gg: AYBFou1NNKKeL9z4Hmqtpe6F+EDjz4bWojanYN9N6YhyPZnH2h2yLRyIlFyzjyPipqa
	aIiIedaCyk9ZbJjZAJ44zMdFUI+8hRFWlk+Du5bMkVoqBsTIkwCj9d+ERkcvmyc4mqNjhbN4oDv
	HwLnlI5XOuJanr2w2BxHuN0hU6ba7vvNihFPVdTth3+8UCL3r8zM+1uhgMwBbCdRfXp0nlYpM85
	3XnlBANMfu3biQNunnmFLb0kVrgtxBjSpQybOKMI+TwqmxfUdtFvq8DplA+Iyk6g7VTtkKXSvGm
	kwNVG/YF8R7a1oZzzmfT895JnzGO/ElSveekgPfGHSlf6JjJtng7XbxYMJxaUq343ZmOfoF0iB3
	TiAK+utf5jNw8h62J+D2h7n6+ctniL9luPiNiXGiIaxSPQocYREtWBwcVeq0RMXa+8kvpnl9iuI
	djtJJsWdOXkL6n3mHFlaPYqC9XnCE8N8bFFuEBEbKsFxVwI3AuF7BT2lgRiM+ujmFI7U5pZj4M3
	Qfm3Pf7DCyTyX7d27QLhnIt0q7eMT0lX4lY/K7EIRyo8g419J2mqObq
X-Received: by 2002:a05:620a:d95:b0:93e:e376:9b1d with SMTP id af79cd13be357-93ee376b37cmr1452850885a.9.1791981312473;
        Wed, 14 Oct 2026 05:35:12 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93ef502608bsm483806485a.25.2026.10.14.05.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 05:35:12 -0700 (PDT)
Date: Wed, 14 Oct 2026 08:35:09 -0400
From: Gregory Price <gourry@gourry.net>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, memxor@gmail.com, mingo@redhat.com, peterz@infradead.org, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, akpm@linux-foundation.org, 
	david@kernel.org, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, 
	shakeel.butt@linux.dev, roman.gushchin@linux.dev, yu.c.chen@intel.com, 
	zhao1.liu@intel.com, bpf@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/3] BPF-based per-cgroup NUMA balancing mode
 selection
Message-ID: <as92ra-Ko2c7OdRS@gourry-fedora-PF4VCD3F>
References: <20261012120438.52849-1-laoar.shao@gmail.com>
 <as5RFhW1Ch8ta5nZ@gourry-fedora-PF4VCD3F>
 <CALOAHbCOTSOPTzoSqKoBJZ56o0pfW_dGQ7ZM_e1jT9N16z3VPQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALOAHbCOTSOPTzoSqKoBJZ56o0pfW_dGQ7ZM_e1jT9N16z3VPQ@mail.gmail.com>

On Wed, Oct 14, 2026 at 11:08:40AM +0800, Yafang Shao wrote:
> >
> > I also concur with Tejun that ops seems like overkill for this feature,
> > this seems like something that can already be managed.
> 
> Tejun also suggested starting with a smaller kfunc rather than the
> heavyweight struct_ops, in a separate mailing list thread. I agree
> that this would be a good starting point.
> 
> >
> > For example, why not add a new numa balancing mode bit that says
> > "enabled but only for explicitly opted in tasks" and then ignore the
> > global default mempolicy, e.g.:
> >
> >   if (numab_mode & NUMA_BALANCING_OPT_IN &&
> >       mpol != default &&
> >       mpol.flags & MPOL_F_NUMA_BALANCING)
> >       /* do balancing */
> 
> Another option would be to add a cgroup::numab_mode field (without
> exposing a cgroupfs interface file for now) to implement per-cgroup
> numab mode. I will think it over, considering both your suggestion and
> Tejun's.
> 

I don't have a strong feeling either way, if Tejun thinks a kfunc is
acceptable here then that's probably preferable to any new UAPI changes
until the value is proven.

Thank you for the consideration,
~Gregory
