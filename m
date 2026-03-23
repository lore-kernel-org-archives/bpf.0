Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B7A171CD
	for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 02:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774231589; cv=none; b=bMHpjZId2aV1I+dNnuMoG/BmXs1LVIiiseDaoBpSboifqex0aIgQ8hUnMhd5DFLFljgNqSCz9M3k7UW9oa+3Nlbz7YDjAj1u1suQhZIOaYM1ZBqKRZXNhjsfTrVHpSHVk/N/b/ukJy1X3B9M1CPMtphq85nsA9Rx6ECELHyoZC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774231589; c=relaxed/simple;
	bh=JgipJT2wx4m+Ha9Dm9Bsg/W/X+SWmJ9xG/f6L2BmBIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GiEpvlYGRbNlGAb+xtA5E05I3WN5jbXnluwflvVYe57SldVbWl/gw491IrNWe5VBmGnFkjvYXTuETJsly2XUO3N/pUP2Yd6TbDSFNyj1JY+T0z+9yG5hKtIeDeV0DvOjSgcQQPKGjMk13pEFebS5kjdyRNeBmqZfGgfiJvcf3i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Brl7SlZ3; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Brl7SlZ3"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774231585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vV+bsjg64uKmvJ+/65HD4Kt5UvpIk0GGJfXLlviVtig=;
	b=Brl7SlZ3i6y0LCQZ4Y1WYpowsb+0VJIQZXWz9qpngS77bzin7C7c1QBMbAvNvRszaVMV3H
	2Cg1kfEbOS9MfiwuZH6KQ9DOFvF+YPFg0OBjXqe4AQVy5MkIcdBe6KrZzIk8lv85lbeivz
	aEuwxIXV6bJwpcMsYBpNzNBxIGKbs7E=
From: Menglong Dong <menglong.dong@linux.dev>
To: Menglong Dong <menglong8.dong@gmail.com>, ast@kernel.org,
 Emil Tsalapatis <emil@etsalapatis.com>
Cc: daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH bpf-next] selftests/bpf: test access to ringbuf position with map
 pointer
Date: Mon, 23 Mar 2026 10:06:00 +0800
Message-ID: <12859070.O9o76ZdvQC@7940hx>
In-Reply-To: <DH8XNPJ8LC2K.5SQUBA8FZ9YW@etsalapatis.com>
References:
 <20260320084155.288417-1-dongml2@chinatelecom.cn>
 <DH8XNPJ8LC2K.5SQUBA8FZ9YW@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2026/3/22 09:51 Emil Tsalapatis <emil@etsalapatis.com> write:
> On Fri Mar 20, 2026 at 4:41 AM EDT, Menglong Dong wrote:
> > Add the testing to access the bpf_ringbuf with the map pointer.
> > "consumer_pos" and "producer_pos" is accessed in this testing. We reserve
> > 128 bytes in the ringbuf to test the producer_pos, which should be
> > "128 + 8", and the "8" is BPF_RINGBUF_HDR_SZ.
> >
> > It will be helpful if we want to evaluate the usage of the ringbuf in bpf
> > prog with the consumer and producer position.
> >
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> 
> Once Jiri's feedback is addressed feel free to add:
> 
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> 
> One nit below.
[...]
> > +	VERIFY(rb->consumer_pos == 0);
> 
> Nit: Can you repeat here the explanation from the cover letter 
> as to why this is 128 + 8?

OK, I'll add a comment here.

Thanks!
Menglong Dong

> 
> > +	VERIFY(rb->producer_pos == 128 + 8);
> > +
> >  	return 1;
> >  }
> 
> >  
> 




