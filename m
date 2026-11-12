Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794508401;
	b=pB2nMJrhQFU8iIZSI10q1G7a0jZO5k+wFQ6VgBRua+kbQF4VYzXih2ZPulZCPC83Bbl4
	 SBziLkJQ/F0B15KUMok034dxcyAwvQ/opWlw0yBqEguvNXuQwsW9w3E68D3Ukfyw6Ingj
	 LJ8hrvxLe3f93wL/Ll12GVcvSXmaxgSWpDmLdvlYXasLAltFu+QsrzD3ZsxDZb+jn/RHq
	 d/Ku4FnmDvkvky0JSGfdRmRaLDhSz1ezVc4sd6haT2OzmD1vRAM36Z9rLGglHh49fc86I
	 YchopLeJqhiYOqwmzC/4SOfiVz6fWOrelCZIWFuEBe6qEomcGJ9CpsyDucF7y4CoAwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794508401;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=+0890/1KdBxvDOFaG5+6Gtq1sFZ3f+/3xUbaBwJyo30=;
	b=UzTxuFNPwJvipBHHEAp+chqyabga+1ArHiuDfFYXnpswqA+kgnAdNetNcjoRpgBzbhc0
	 zsno3aR/DV+r3Hy2Tqc+P1iFZgjoWDA41wpDNn2n3zw+7VSH85Vhb6CZ5I+6PXrZ31eHT
	 6oW/Cae6T8qMfHgHiU+G8+gmpE3SpdJOGStUmWz/AHAwt+QmyXm6By7YGVje5IrlnXdO6
	 z1mIxWYLYeDbHbPP/Ih04efBv7115pYPTS6NOLjxRwTMvgZTQL5vSjKpt6x8G+Z3LuH+s
	 byiStIl2DHD4yj2J9q/QdTTFbNgC9ykHSjl8M/+3DBUh6JLOeP6MkEWi8hdTgrw+nFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bpJb013w;
	arc=none smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256DD606A337
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 18:33:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 256DD606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bpJb013w
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6b7245ab5e2so1881033a12.1
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 10:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794508399; x=1795113199; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+0890/1KdBxvDOFaG5+6Gtq1sFZ3f+/3xUbaBwJyo30=;
        b=bpJb013wg86TqxRRlt4sD67lUpI5p2+GLIho39k7oCu3QGTMGi+VmybFlQbzbYOvWa
         TnZ2bwWfbluvwDTDSUeNSX+b7jc4Lt6Zo7P1EPak/SThQLr7vtt0X9DHs8IqAKxVDdjN
         g5KbnjYEuuYMYhMMw1wUa41FWtu/T5h8r29aCpnwpsIvqF9xt0gVlLDJUM2x9pwUjy3R
         2XnCBtztXNRasQLxA1HL+pN/n77Tk+Gj7idiZOnJCKOk4HOTKBadsMG1mqQrCDYruHN6
         IANIFSepZ5jOz2SDRsvUfch8m7CLPqfCmxRZ75qu00DNEDZpWs7nqlhFeNLlpGutHtrc
         crxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794508399; x=1795113199;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+0890/1KdBxvDOFaG5+6Gtq1sFZ3f+/3xUbaBwJyo30=;
        b=ju7bM9bj5XD31z4rDWukIW8nqy33A5XeO/nvS7/fKJ+DpLT/jQZorxSPYEBeqO/p5S
         KyXIJvUTu0ozdVzefWMJeNO/0HP44erdsTP/HjF2VK7wU/fGqUKo1G0/ecJalfrDMOD+
         CVrXQbHfrL3NnddBSly+6kaa+LyCEbF28RhPjjKNE2KI4vEmnuEUEWTConv5guaJ5sQe
         JHX0puWGX3bIN12OkjTrHshOnknG8geTTt5Y7fmTBextlJ8Pwj3tPtHkyRUDZsxsZkN8
         4fjqtAa6NKF71+gBqkjV5Znt2lROILnVg8mOXKB1lu0dkTXQhUiI5WkWbrWShH+3Tpmt
         XWrg==
X-Forwarded-Encrypted: i=1; AL+hErFF4Ui7Tz0ujLeclwAZmIfFiK0UgQoKnScl0X2BVnNk6eYMaYVuM15ZGA/hq8ylIVAZOa4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/pSlH/FqmLdra1/3tDkDm0YgPbzIDXad0w2hzQisBbpw1s37Cq
	CZsscHJb8wjcZaHKdD0U8Bf9mV/XldyyDPx1cMR54Jgwwhehw9Y6Xdk8
X-Gm-Gg: AYBFou2WxbbgzS3XfqgSGUTcj75go3gwl87rF4WhBmauUcotgeljwVJUEQQDAjYx35Q
	5LN9dyGGEgezRbTyuzyMNmH9lDXyEoonqqkitN4r9dSySOF4bDstFDUHUhuCxzUHrckQI3LGWzE
	B8rj0GrTSy+ngPvXRcIYEyjAAF6iMhJi24cw6QE5bWvdW28WneRxCv74bsVjyRkB1aoQ/EgZDho
	KgBwBOAIDRGLYUEx4eKP771val+D0vw9ANvNAvQ1XRTqgew5PbqxVDhutK+CDa4M2T6W6JTj6+P
	T6MzSyuouGk0+tXkBmY6cMT8QVMeDqJItV2RVjww27iDbv+6Wt6MBDl7YFB87JdtgLHauXYCxu8
	Mfd9aZU/dZpa6nNIXRer6e3WO4xRnXUff5unH3kmyiKG00YcN/Q/DA6hqdrZrBEDocPUw5RQ9vA
	OkoXT5D06yImBHnwH0YSQgvqKx5AuMloOddCMWfmCPDvckCgX6HxM7aVflKaOKfzieGI29n5WrZ
	BuMzNWOMzMxxPFn+XOxPkbLvhkYprnaBjvxV5dYSpzbHFfZk+xrVvVqMjRs8ubqGclkmhT9b0tH
	M8/YQNvedW1Zf1V0
X-Received: by 2002:a17:907:608f:b0:c4c:a409:5aa3 with SMTP id a640c23a62f3a-c50963879c9mr11899066b.17.1794508399520;
        Thu, 12 Nov 2026 10:33:19 -0800 (PST)
Received: from krava ([173.38.220.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b68dbbsm5890066b.61.2026.11.12.10.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 10:33:19 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 12 Nov 2026 19:33:16 +0100
To: Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <avYGbCrfomowKKiH@krava>
References: <20261109194916.1089703-1-jolsa@kernel.org>
 <20261109194916.1089703-2-jolsa@kernel.org>
 <20261112083413.GE2668804@noisy.programming.kicks-ass.net>
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
In-Reply-To: <20261112083413.GE2668804@noisy.programming.kicks-ass.net>

On Thu, Nov 12, 2026 at 09:34:13AM +0100, Peter Zijlstra wrote:
> On Mon, Nov 09, 2026 at 08:49:04PM +0100, Jiri Olsa wrote:
> 
> > +static int static_call_site_index_cmp(const void *a, const void *b, const void *priv)
> > +{
> > +	const struct static_call_site *base = priv;
> > +	unsigned int ia = *(u32 *)a;
> > +	unsigned int ib = *(u32 *)b;
> > +	unsigned long ca = (unsigned long)static_call_addr(base + ia);
> > +	unsigned long cb = (unsigned long)static_call_addr(base + ib);
> > +
> > +	return cmp_int(ca, cb);
> > +}
> > +
> > +static struct static_call_site_index *
> > +static_call_site_index_alloc(struct static_call_site *start,
> > +			     struct static_call_site *stop)
> > +{
> > +	struct static_call_site_index *index;
> > +	unsigned int nr = stop - start;
> > +	unsigned int i;
> > +
> > +	if (!nr)
> > +		return NULL;
> > +
> > +	index = kvmalloc_flex(*index, entries, nr, GFP_KERNEL);
> > +	if (!index)
> > +		return NULL;
> > +
> > +	index->nr = nr;
> > +	index->base = start;
> > +	for (i = 0; i < nr; i++)
> > +		index->entries[i] = i;
> > +
> > +	sort_r(index->entries, nr, sizeof(index->entries[0]),
> > +	       static_call_site_index_cmp, NULL, start);
> > +
> > +	return index;
> > +}
> > +
> > +static int
> > +static_call_site_index_text_reserved(struct static_call_site_index *index,
> > +				     void *start, void *end, bool init)
> > +{
> > +	unsigned int low = 0, high = index->nr, i;
> > +
> > +	/* Find the first site after @start. */
> > +	while (low < high) {
> > +		unsigned int mid = low + (high - low) / 2;
> > +		void *addr = static_call_addr(index->base + index->entries[mid]);
> > +
> > +		if (addr <= start)
> > +			low = mid + 1;
> > +		else
> > +			high = mid;
> > +	}
> > +
> > +	/* The preceding site may overlap @start. */
> > +	if (low)
> > +		low--;
> > +
> > +	for (i = low; i < index->nr; i++) {
> > +		struct static_call_site *site = index->base + index->entries[i];
> > +		void *addr = static_call_addr(site);
> > +
> > +		/* Later sites cannot overlap once this address is past @end. */
> > +		if (addr > end)
> > +			break;
> > +		if ((init || !static_call_is_init(site)) &&
> > +		    addr_conflict(site, start, end))
> > +			return 1;
> > +	}
> > +
> > +	return 0;
> > +}
> 
> FWIW, we do have bsearch() as well.

yes, but bsearch() returns exact match, but we need to find first entry
after start even when no entry matches it... I'm not sure how to do that
with bsearch

jirka
