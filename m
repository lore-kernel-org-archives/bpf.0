Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794474461;
	b=HV/o82gpW3MwxWk48y1ISbVmecnNkSdDuzGK8Hrur8VDcpBDhMV1v7cfQY3AwH30N0Jh
	 Wg/VpnE03WKPKnnG0Iz12HIzSAP9a7KTFjPXTjbK2s/oYYHnzWayECf5MDjvGBmFy/eJ/
	 3QgOJzbauJvlT9ZIWExxWkP5Lt115Pd9etP4a2yBQRQDhuDsEk2g6CUZFjiqHou2im+N1
	 x9MBBQuY6cBgUna6p43UvtvPV/cf+NfaZEsyncBmD8KMneuBtq5UbpUsauBkVBKQlC+Ao
	 nI6R+bvJP1GHFiO5yeAz393oRyu7Gdq16bdGWDuhzNWIbM9HE/72Ub+JeOQuj3G6KXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794474461;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=RJOHiin0akz7cf0NYu9hMIx8uHfnzW8Hz3TOsh9r0Gg=;
	b=mvi91V4/lqBRJaMmSEMAJ84Kc9kbSPXSTLr85vKabnhNQcv58XXzHYVGRUpACXRxcVhB
	 qCdy2/M8RKu4uF2UKPgujox9ovo/oSFa7eH0UHO6PVYo64ILm1d69IVb1MNH9qgFDQ9mZ
	 1i9sk0J7JuqGfktG7iKey7t+tgGPJIVAauOQVB4xqMb2cmBc7f3A3MD30HB5UtJ6E/wx0
	 2XoRYCmAQ2unDtblmDchiYjAvguLioqA8FT1XEGqDuidTVVbie1kRgK6dmPd9RuWAAJA1
	 zVNZTkkI935uamd4p1Cl+RvRtc9LFoYR0mnLOqWjL9IpZ0YFSUpo5rJmyLUEv6A1pJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=SB6O+iXm;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02000606A321;
	Thu, 12 Nov 2026 09:07:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02000606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=SB6O+iXm
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RJOHiin0akz7cf0NYu9hMIx8uHfnzW8Hz3TOsh9r0Gg=; b=SB6O+iXmZP/Zhda1NdyUdZrS7x
	Fw/vd9KXhBeHb3KFbZP0lKJcnxaD+nVTr3l5nfzMEYGKWWqwGiHdBf0+QQhRz3JtbKYls5yxMwcyY
	1JvUDMdIf1LNaT0q4QpqYCNMH8BZIZgz5TFdMYuBqjHSzac6G+ipwlxgHAWGpo8R9N1kCaHOHISkG
	e4Gx///yhtK2cvLU4iMXu799KLaZvRKrXS4nmB9zaGXMFYGOxP83OsSkD+LrH4J68ATYOrjIeEgzP
	moVwBVZlsSgcl5yMn79Pj0EnofedO+w/2cjqIRdC16IkgZH3T6yF9dquFMGFY7o7lqUbHXCtrjdxd
	sNW7G11A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRQmN-0000000A6ZG-1w7N;
	Thu, 12 Nov 2026 09:07:35 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 313BD300400; Thu, 12 Nov 2026 10:07:34 +0100 (CET)
Date: Thu, 12 Nov 2026 10:07:34 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>, Alice Ryhl <aliceryhl@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Alan Maguire <almagui@kernel.org>,
	x86@kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 01/13] static_call: Index code text reservation lookups
Message-ID: <20261112090734.GH2668804@noisy.programming.kicks-ass.net>
References: <20261109194916.1089703-1-jolsa@kernel.org>
 <20261109194916.1089703-2-jolsa@kernel.org>
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
In-Reply-To: <20261109194916.1089703-2-jolsa@kernel.org>

On Mon, Nov 09, 2026 at 08:49:04PM +0100, Jiri Olsa wrote:
> --- a/kernel/static_call_inline.c
> +++ b/kernel/static_call_inline.c
> @@ -15,6 +15,18 @@ extern struct static_call_site __start_static_call_sites[],
>  extern struct static_call_tramp_key __start_static_call_tramp_key[],
>  				    __stop_static_call_tramp_key[];
>  
> +struct static_call_site_index {
> +	struct static_call_site *base;
> +	unsigned int nr;
> +	u32 entries[];
> +};
> +
> +/*
> + * Index static call sites by code address for text reservation lookups.
> + * The site table itself is sorted by static-call-key address.
> + */
> +static struct static_call_site_index *static_call_site_index;
> +
>  int static_call_initialized;
>  
>  /*
> @@ -41,7 +53,7 @@ static void static_call_unlock(void)
>  	mutex_unlock(&static_call_mutex);
>  }
>  
> -static inline void *static_call_addr(struct static_call_site *site)
> +static inline void *static_call_addr(const struct static_call_site *site)
>  {
>  	return (void *)((long)site->addr + (long)&site->addr);
>  }
> @@ -301,6 +313,79 @@ static int addr_conflict(struct static_call_site *site, void *start, void *end)
>  	return 0;
>  }
>  
> +static int static_call_site_index_cmp(const void *a, const void *b, const void *priv)
> +{
> +	const struct static_call_site *base = priv;
> +	unsigned int ia = *(u32 *)a;
> +	unsigned int ib = *(u32 *)b;
> +	unsigned long ca = (unsigned long)static_call_addr(base + ia);
> +	unsigned long cb = (unsigned long)static_call_addr(base + ib);
> +
> +	return cmp_int(ca, cb);
> +}
> +
> +static struct static_call_site_index *
> +static_call_site_index_alloc(struct static_call_site *start,
> +			     struct static_call_site *stop)
> +{
> +	struct static_call_site_index *index;
> +	unsigned int nr = stop - start;
> +	unsigned int i;
> +
> +	if (!nr)
> +		return NULL;
> +
> +	index = kvmalloc_flex(*index, entries, nr, GFP_KERNEL);
> +	if (!index)
> +		return NULL;
> +
> +	index->nr = nr;
> +	index->base = start;
> +	for (i = 0; i < nr; i++)
> +		index->entries[i] = i;
> +
> +	sort_r(index->entries, nr, sizeof(index->entries[0]),
> +	       static_call_site_index_cmp, NULL, start);
> +
> +	return index;
> +}
> +
> +static int
> +static_call_site_index_text_reserved(struct static_call_site_index *index,
> +				     void *start, void *end, bool init)
> +{
> +	unsigned int low = 0, high = index->nr, i;
> +
> +	/* Find the first site after @start. */
> +	while (low < high) {
> +		unsigned int mid = low + (high - low) / 2;
> +		void *addr = static_call_addr(index->base + index->entries[mid]);
> +
> +		if (addr <= start)
> +			low = mid + 1;
> +		else
> +			high = mid;
> +	}
> +
> +	/* The preceding site may overlap @start. */
> +	if (low)
> +		low--;
> +
> +	for (i = low; i < index->nr; i++) {
> +		struct static_call_site *site = index->base + index->entries[i];
> +		void *addr = static_call_addr(site);
> +
> +		/* Later sites cannot overlap once this address is past @end. */
> +		if (addr > end)
> +			break;
> +		if ((init || !static_call_is_init(site)) &&
> +		    addr_conflict(site, start, end))
> +			return 1;
> +	}
> +
> +	return 0;
> +}

Looking at this in a little more detail; I'm confused. 

You're literally adding an index, so that you can find the
static_call_size, while all you really need is static_call_addr().

That is, you could have just created an array of relocated site->addr
and sorted that, that would safe you a ton of indirection all around.

That is:

	index->entries[i] = (long)static_call_addr(start + i) - (long)&index->entries[i];

That will make your lookup take at least half the amount of loads.


Also, you really should support modules, there is no point being fast
until you load a module.
