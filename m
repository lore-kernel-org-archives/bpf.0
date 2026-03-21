Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E577525D53B
	for <bpf@vger.kernel.org>; Sat, 21 Mar 2026 07:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774078648; cv=none; b=ka2z9J2yUKddncAK71slEN9ydJ849nZDz9dZAace8+ErSu/Kqs8mgLciqGYumMxZKHx7bPb/moNx1DXkW3H7PwetyLeJkGuD+4EDm9co7HenckRLd4bpaLw4rsI2Gm5qFU6nnuItzaIaI0ReuYvdYZcpKw11WgkrDuIjNThsb/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774078648; c=relaxed/simple;
	bh=tQQGzYTax5ANp/HbiUvTvtRKu+lhynv+KLzdFrVjROo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XgXR8BD42nnP4T/YS6tKrgl+8rjYyRyijOQGiVMpu2uVRGN+PX0hWggGffkaw24PXiltCeg+GaiSVTas8tgM3XV0MnJFhWF7bjqnYXc08PKG20iiDasokgiLsXzgScyvR5xMI0oNw46WUmB1RSdOZ0GayCbOM93qnl+L2TfP5Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VoOMwkJw; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VoOMwkJw"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774078644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mFkAgABbL8wpYRqzhI8hIlxFLHN6DztVsz0LC9nkrp4=;
	b=VoOMwkJwUw594J90DYXmIKvhLi+7+iafCY+yETpgww75sBt0m7OTarDz+Abcb91Y854+ZT
	ZEb3HT1Mg1RQqf74ysBAHWTFGgVbHu5fdSoRJftoNsDZ6yfLyfXJrYNIT2Y6H4BuKW9yyK
	tK1lu9NyJgBlfEUEveCVOyT9nzq5N1Y=
From: Menglong Dong <menglong.dong@linux.dev>
To: Menglong Dong <menglong8.dong@gmail.com>, Jiri Olsa <olsajiri@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, shuah@kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH bpf-next] selftests/bpf: test access to ringbuf position with map
 pointer
Date: Sat, 21 Mar 2026 15:37:12 +0800
Message-ID: <2839892.mvXUDI8C0e@7950hx>
In-Reply-To: <ab1AUyefoWABRs0T@krava>
References:
 <20260320084155.288417-1-dongml2@chinatelecom.cn> <ab1AUyefoWABRs0T@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2026/3/20 20:40, Jiri Olsa wrote:
> On Fri, Mar 20, 2026 at 04:41:55PM +0800, Menglong Dong wrote:
> > Add the testing to access the bpf_ringbuf with the map pointer.
> > "consumer_pos" and "producer_pos" is accessed in this testing. We reserve
> > 128 bytes in the ringbuf to test the producer_pos, which should be
> > "128 + 8", and the "8" is BPF_RINGBUF_HDR_SZ.
> > 
> > It will be helpful if we want to evaluate the usage of the ringbuf in bpf
> > prog with the consumer and producer position.
> > 
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > ---
> >  .../testing/selftests/bpf/progs/map_ptr_kern.c | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/bpf/progs/map_ptr_kern.c b/tools/testing/selftests/bpf/progs/map_ptr_kern.c
> > index efaf622c28dd..c3fa57ec430b 100644
> > --- a/tools/testing/selftests/bpf/progs/map_ptr_kern.c
> > +++ b/tools/testing/selftests/bpf/progs/map_ptr_kern.c
> > @@ -647,21 +647,39 @@ static inline int check_devmap_hash(void)
> >  	return 1;
> >  }
> >  
> > +struct bpf_ringbuf {
> > +	unsigned long consumer_pos;
> > +	unsigned long producer_pos;
> > +} __attribute__((preserve_access_index));
> > +
> >  struct bpf_ringbuf_map {
> >  	struct bpf_map map;
> > +	struct bpf_ringbuf *rb;
> >  } __attribute__((preserve_access_index));
> >  
> >  struct {
> >  	__uint(type, BPF_MAP_TYPE_RINGBUF);
> > +	__uint(max_entries, 1 << 10);
> 
> do you need to set max_entries? there's already check below
> making sure it's 4096

Hi, Jiri. Thanks for the reviewing. You are right, we don't
need to set the max_entries here, as it will be set in the
test_map_ptr(). I'll remove this part in V2.

Thanks!
Menglong Dong

> 
> jirka
> 
> 
> >  } m_ringbuf SEC(".maps");
> >  
> >  static inline int check_ringbuf(void)
> >  {
> >  	struct bpf_ringbuf_map *ringbuf = (struct bpf_ringbuf_map *)&m_ringbuf;
> >  	struct bpf_map *map = (struct bpf_map *)&m_ringbuf;
> > +	struct bpf_ringbuf *rb;
> > +	void *ptr;
> >  
> >  	VERIFY(check(&ringbuf->map, map, 0, 0, page_size));
> >  
> > +	ptr = bpf_ringbuf_reserve(&m_ringbuf, 128, 0);
> > +	VERIFY(ptr);
> > +
> > +	bpf_ringbuf_discard(ptr, 0);
> > +	rb = ringbuf->rb;
> > +	VERIFY(rb);
> > +	VERIFY(rb->consumer_pos == 0);
> > +	VERIFY(rb->producer_pos == 128 + 8);
> > +
> >  	return 1;
> >  }
> >  
> 
> 




