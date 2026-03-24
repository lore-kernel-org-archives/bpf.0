Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576543DCD97
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 09:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774344103; cv=none; b=dMwQ6sOSipI6wMZFHLfYeZpU1nkhFol1TzdwkANXYKPOTAl76wa6GtZyJcvCoQFB1qNv91Xcx2Guez6heGT34g4qSnIMN9U7cA8IXqNB5RF5EyEF+5XsOksivyN0hywGbE0M72TdEUIs5IZzZkKXT4C9v7STw1k1MftyTMD2OWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774344103; c=relaxed/simple;
	bh=Rwy/ambJpugBR7Zk3XRFWcpR73v2mOl9hZZamgKdr10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qeas9Oo4CPBlwebIOTqOvL0JNnS6TERfOySBlqB2RVfk5lO2fwVp6A/JsknhwaYERTTkvoqEIdvZElbn0j7VrSE5jqZH1aKFgJYu2GWxx+GVRZrb7GtNVTe9uZtQznKf494BCU0zqGb+GZrT83IZB93e1pTs4AY777dI4IQr0+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=icGUaB4R; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="icGUaB4R"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774344081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A5UfZnO09ge+rFC3O4Es4Atn2NT6/ruQMykNK9CnK7A=;
	b=icGUaB4Rh4IDCwNnFO2BBvZMCT70fimGl9f4IV9tZ3pUkFZZtxWRKTZPkRGZB0aqqK0u4R
	ANnrVLpISEArYw3sYMXgD4QuOGcjS2Or4kDVa9BiSzymSDb0JjWvnnSAFwjNPhTz9Qw9ci
	ljI/TkiwEjCeB8tsslMuN5xBUCEyaVc=
From: Menglong Dong <menglong.dong@linux.dev>
To: Menglong Dong <menglong8.dong@gmail.com>, Jiri Olsa <olsajiri@gmail.com>
Cc: ast@kernel.org, olsajiri@gmail.com, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, shuah@kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH bpf-next v2] selftests/bpf: test access to ringbuf position with
 map pointer
Date: Tue, 24 Mar 2026 17:21:07 +0800
Message-ID: <2403281.ElGaqSPkdT@7940hx>
In-Reply-To: <acEdFlYd4UHmknEU@krava>
References:
 <20260323021839.101316-1-dongml2@chinatelecom.cn> <acEdFlYd4UHmknEU@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2026/3/23 18:59 Jiri Olsa <olsajiri@gmail.com> write:
> On Mon, Mar 23, 2026 at 10:18:39AM +0800, Menglong Dong wrote:
> > Add the testing to access the bpf_ringbuf with the map pointer.
> > "consumer_pos" and "producer_pos" is accessed in this testing. We reserve
> > 128 bytes in the ringbuf to test the producer_pos, which should be
> > "128 + 8", and the "8" is BPF_RINGBUF_HDR_SZ.
> > 
> > It will be helpful if we want to evaluate the usage of the ringbuf in bpf
> > prog with the consumer and producer position.
> 
> lgtm, question though.. is this related to some kernel change or
> some ongoing work? looks like basic operation that's already
> tested indirectly by existing tests

I wanted to introduce a kfunc to get the usage of the ringbuf,
then we can wake up the user space lazily if the free space in
the ringbuf is big enough in some case. Then, I found that we
can do it directly with the map ptr. However, I don't see a
test case that read the pointer that come from the map ptr, which
makes me not sure if it is allowed to access the
ringbuf->rb->consumer_pos. So I did the testing, and I worked :)

Thanks!
Menglong Dong

> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> 
> jirka
> 
> > 
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> > ---
> > v2:
> > - don't set the max_entries for the ringbuf map
> > - add comment for the producer_pos
> > ---
> >  .../testing/selftests/bpf/progs/map_ptr_kern.c | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/bpf/progs/map_ptr_kern.c b/tools/testing/selftests/bpf/progs/map_ptr_kern.c
> > index efaf622c28dd..d7611e7018ca 100644
> > --- a/tools/testing/selftests/bpf/progs/map_ptr_kern.c
> > +++ b/tools/testing/selftests/bpf/progs/map_ptr_kern.c
> > @@ -647,8 +647,14 @@ static inline int check_devmap_hash(void)
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
> > @@ -659,9 +665,21 @@ static inline int check_ringbuf(void)
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
> > +	/* The "8" here is BPF_RINGBUF_HDR_SZ */
> > +	VERIFY(rb->producer_pos == 128 + 8);
> > +
> >  	return 1;
> >  }
> >  
> > -- 
> > 2.53.0
> > 
> 
> 




