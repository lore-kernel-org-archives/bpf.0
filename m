Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794472461;
	b=VsWan7D2/AkHmGbQNVnwwAdNuM9BiMvYJk/1G8yv2s1FEbKatFYOM2umdarYvTg5QuMc
	 5BGQOdPKQONmkCar1/jfRH5OKRK8RBsp2zfnIAsdO4wKcd+IbJoDgE2+plkfrejm8lp6c
	 u3ZvzBGUSf2EeMw8vSRXqwc+WmpETsohTqLlpXLsy6PF3ho73qzmvD4jG2lora9REmZGU
	 HCvx0+kpN2tgUuo6Z7biMViVIqFvD48Geh23U2s6BQ6JXmwc7APIX13aDdwp2qqpqsdeu
	 RoTHzjH6vG4/ht8rMraDTAiUh6uSEZ4mZVF+/LdaoJ0naZxG8l1bhHDi4nbeTtBAhSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794472461;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=NrThy40j8H9TjI4slWxEnkZ3jGHSlxkujDIEYuGDIB8=;
	b=1Z4Lh49lyxKWmbkLeP8+B8+7WQNzjkTknXTmbP0Pw6lYK5XYi84f0XbrxtGR9CnXwcF8
	 Sq+oMI1WXKEsHJOrDhVdTv2DPKKeMJhXQKPG6xybCXYpVAGy7uIq9Z6bd7tNQ+bK10c4c
	 MATOZVfhBu9WHzED7t7xsrgrs4gHuQL3KYWadZizyN9vu+/1beCYLmibt+oS53XtBqNLY
	 5zUaDUEuhJnJbI/TlYkx3CjAj0zPQ7U3L8LDPSHEHX5SCKNjc76djQIwzTj9BDqUrkZ3q
	 OfdB2ipw5mT5P91Ct77tjIM43r4lquOCQu17J0vi72D+BJ/2nuFD8W0YzAq71UIzrdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=qc+9UA9D;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D2760A3829;
	Thu, 12 Nov 2026 08:34:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6D2760A3829
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=qc+9UA9D
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NrThy40j8H9TjI4slWxEnkZ3jGHSlxkujDIEYuGDIB8=; b=qc+9UA9DiAit350/I34FLLOM+I
	aaCI/xRKfaVstQRhjsSlxS/dKou92rubCTtmaSk5/Un1UFy8VB6Bm76cDf7jbOw2eTQiJlKstNXWg
	CWULoBr393zv7jG/L5EhdaDr625gzVV5+AXg3qz5Gw4wJtBz5dNOSsdXuPfq0ghNQ4G0M0c+tvGKx
	W/YUKYOSM+sSGBAxjO77s9XEDVq/uzfwXN2grLeKWCkiz7x5r7ed+6livKia6kjHXr2Z0tHb1sSfe
	HYGhZf+SYAUATYt5qprvRIcZ+RY5H6lytclpTcSsR3diosbiVjAyqIrvUtc4d3P4hhjdufVeySwLb
	j9bREaLQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRQG6-000000053QA-3OQ8;
	Thu, 12 Nov 2026 08:34:15 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 04A4B300400; Thu, 12 Nov 2026 09:34:14 +0100 (CET)
Date: Thu, 12 Nov 2026 09:34:13 +0100
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
Message-ID: <20261112083413.GE2668804@noisy.programming.kicks-ass.net>
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

FWIW, we do have bsearch() as well.
