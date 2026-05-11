Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6C0314D2D;
	Mon, 11 May 2026 11:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778498719; cv=none; b=CrGz/Yq0xbgA8jA5/zHrt4t8MAxRA6CUFbe6ckaQij5PJpiAVnbmG3xRC0bWkoKqPmHOeVk2YY8vG2s+WSU67edYVmXLWL8bum2abvOsN+Gra+1B6Prqp2d63BbaAzrOWTERP0OgtL0DH8JNtLzMISBkFV5Au6PJe+yAptNQ7pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778498719; c=relaxed/simple;
	bh=Q8rVNnwf4dEP5Fda05JLilhu6EDnhwbUwJkDwg0YZQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EQobataaeFfSzZs2oUIB5j3N1dwnE1B5nCfer0YoV9BcJ+8OrjJl+3VXAQvNhEzlobbtZjuDCbvIfJdPa/ErnKIH8vyguafarmYDa4eFhArVzI5c8F/4jtbs3RKN7mQRiZUs0YJK6GzpYa+Zioo6GeAksoJJLTNp5ABhqRaOpCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O3p0WQEI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O3p0WQEI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28352C2BCB0;
	Mon, 11 May 2026 11:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778498719;
	bh=Q8rVNnwf4dEP5Fda05JLilhu6EDnhwbUwJkDwg0YZQY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O3p0WQEIUGSnM4o9AHaajsmMzyXtje/e+dTwxse4bN5LQdDVpnlXIeYjt/qk6Lhuk
	 ziW02G6yvHytQux0Qfk06MJ8uEI1YmngtL9f5qbw+uGzMEwRAv6xhBlZ4TUBm8EGFY
	 qkkMNMviYPPgQJ3GYrkYaUwaNZKRlWm+eDt4NsnynJ3GAFqnpN8JSrKTuBx6CmwmeK
	 vrMmJAURMYrBZM0Vbfg9m/bIiw0cvsjkeUHXKKSddgpAq7xT4zID50tyImZj9oEsVj
	 ZfoghU3I4SIRxfJ0YXqk/x2VKBsv9pDA9F0XnpgmNRloxfe5GFJFT+MBpQRXcah/m3
	 YqcJ/4T8EmBfA==
Date: Mon, 11 May 2026 12:25:12 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Vernon Yang <vernon2gm@gmail.com>, akpm@linux-foundation.org, 
	roman.gushchin@linux.dev, inwardvessel@gmail.com, shakeel.butt@linux.dev, ast@kernel.org, 
	daniel@iogearbox.net, surenb@google.com, tz2294@columbia.edu, baohua@kernel.org, 
	lance.yang@linux.dev, dev.jain@arm.com, laoar.shao@gmail.com, 
	gutierrez.asier@huawei-partners.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	bpf@vger.kernel.org, Vernon Yang <yanglincheng@kylinos.cn>
Subject: Re: [PATCH v2 3/4] mm: introduce bpf_mthp_ops struct ops
Message-ID: <agG8e1U-fNbtIOoF@lucifer>
References: <20260508150055.680136-1-vernon2gm@gmail.com>
 <20260508150055.680136-4-vernon2gm@gmail.com>
 <5987cdee-9174-44fb-8e2b-41e6ad969612@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5987cdee-9174-44fb-8e2b-41e6ad969612@kernel.org>

On Fri, May 08, 2026 at 10:54:58PM +0200, David Hildenbrand (Arm) wrote:
> >
> >  #include <linux/fs.h> /* only for vma_is_dax() */
> >  #include <linux/kobject.h>
> > @@ -296,6 +297,11 @@ unsigned long thp_vma_allowable_orders(struct vm_area_struct *vma,
> >  				       enum tva_type type,
> >  				       unsigned long orders)
> >  {
> > +	/* The eBPF-specified orders overrides which order is selected. */
> > +	orders &= bpf_mthp_choose(vma->vm_mm, orders);
> > +	if (!orders)
> > +		return 0;
> > +
>
> There was some discussion around this in the past: where should we hook into
> (e.g., deferred shrinker?), which information should we provide to the hook
> (e.g., vma properties?).
>
> We concluded mostly to "we don't know". I know that Rik van Riel wanted to look
> into doing this properly, but seems like he got distracted :)
>
> I assume there will be a lwn.net article covering the "BPF in MM" session we had
> at LSF/MM just this week.
>
> Conclusion: ABI stability is a headake.
>
> The simplistic approach of deciding an order for the whole MM is very likely not
> what we want.

Agreed with all points!

>
> --
> Cheers,
>
> David

Cheers, Lorenzo
