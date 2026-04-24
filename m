Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AFF3F6600
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 18:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777056581; cv=none; b=FhzDAmrslzb8sRKobaWgRBwH3we6bwBRLK/IUOxI/aRkToGd1afzoFVi79bMlaZg90gywfUVQ6rodyWfIdW8qmFkOLXmoxVCnfrsxR6ZtopcWPG1gTPubBd8VtNsgMUn9KRWwa+GBgkPElJulz4FMuma8yw8UdwNdYSOc8UI1yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777056581; c=relaxed/simple;
	bh=6IOZ5fpZbuwuN9Ze3ZwE4QuHE/XPBHxy1JSI0V89eYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BHDpubKfxFsAned3Y1Av2ahKokP2Zjod5q4OmOvijKtBdTTzUTUb4vla44cyoya2+Kof1q53NWKePXSNobCGYthALjaa1chIbkj22Pv28ajlMShJv4ozYrkw6Cz37LtjRVuaCoB3B8hbhb/HBt1A7gacvlcBdCkim6cO6Wmxrfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mR77e+kg; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mR77e+kg"
Date: Fri, 24 Apr 2026 11:49:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777056568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BSZgyp08bC/BsjWgJ2L5WaVTAHLbGzENzzPVS9GKMN4=;
	b=mR77e+kgFV+3RQ1z3gkmr4d4Bpa0qyPIrOe6JnrjHLKcDyMgrNCpcqpgZRR8jSTQb+Lo8e
	tbdEdPTcAX0lef4UKk8Xphf3tDJEY+Mxz97XOQxtLFo3LthWAPWLg+Ozo4fD5zCh7/9OXU
	TXxdLhXqWVKwI/Pfen2rCS7HUy3ERj4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com, martin.lau@kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH bpf v1 1/1] bpf: Fix sk_local_storage diag dumping
 uninitialized special fields
Message-ID: <2026424184430.ui0Q.martin.lau@linux.dev>
References: <20260423222356.155387-1-ameryhung@gmail.com>
 <8cc73c03-afb6-4b7d-97ea-e05d9cc56c2d@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8cc73c03-afb6-4b7d-97ea-e05d9cc56c2d@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Apr 24, 2026 at 12:50:34AM +0100, Mykyta Yatsenko wrote:
> > diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
> > index 14eb7812bda4..b50d26a542ed 100644
> > --- a/net/core/bpf_sk_storage.c
> > +++ b/net/core/bpf_sk_storage.c
> > @@ -558,6 +558,7 @@ static int diag_get(struct bpf_local_storage_data *sdata, struct sk_buff *skb)
> >   				      sdata->data, true);
> >   	else
> >   		copy_map_value(&smap->map, nla_data(nla_value), sdata->data);
> > +	check_and_init_map_value(&smap->map, nla_data(nla_value));
> 
> I think check_and_init_map_value() should be moved before the
> copy_map_value(), because copy_map_value_locked() already uses
> spin lock special field, which if uninitialized can deadlock?

The src (sdata->data) lock is used instead of
the dst (nla_data(nla_value)) lock, so it should be fine.
