Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A76D28DC4
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 18:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776708767; cv=none; b=AFSrfzWRSkrpsW2kZ6niL7O5tTbwUm1LnrYtkSBG7WU4IVix2RAewO4bbnEqrl6DsftV9xk6mhA67A6zIj89vNqgLSw+HYJg/v3fXFM7PisYonhfhTRYSdDA7bq+X4fmXV45h2Dei2PY4lJ6XW3ZW0FQL7l0uYWtPKV1pxeirU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776708767; c=relaxed/simple;
	bh=KdMLvFF62T8w+rP0pIWodgECrAbY0fE5MU19Z5O6gVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o4anqhsS+qyIBiCEG2fkFUezqxVSKonfVkq4Zrxd6I+acp5qNV4P2ys/KSBfPuNu5wdwlVxmNMSN/PEU9ZCtLbPU10X6eEHc14peTBhXTxZ/Ttqdb+4hYlWqz1wTP4DQ89XRNzGFSyjyrJA5PDRanoERNd/ebFotIisVvsyvzOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=COKSeVUy; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="COKSeVUy"
Date: Mon, 20 Apr 2026 11:12:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776708763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ix7/zhoRL3r2Dqp79NoWxKpttMDWSed3uFUeVh5uGCE=;
	b=COKSeVUygLQul+0PeIfiKpNkjZsb+sokS5/W0sk9kETlA3RXnNc7N5eydZzZgzu3P5X6lk
	IqiDDJBNhNcltXl/lI9WRF5T4/weOosp/Qs8EwRE4r+7vUSYjLjywwJwwle+meoSDp2XcR
	AtPrLRlC36Mr1yrskhtunH3sKNVwu3k=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: KaFai Wan <kafai.wan@linux.dev>
Cc: sashiko@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH bpf v3 1/2] bpf: Reject TCP_NODELAY in TCP header option
 callbacks
Message-ID: <2026420174537.e2om.martin.lau@linux.dev>
References: <20260417092035.2299913-2-kafai.wan@linux.dev>
 <20260418092235.98444C19424@smtp.kernel.org>
 <0e5602f1ca92074cbef0554a7a399ff8b1cc8a1c.camel@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0e5602f1ca92074cbef0554a7a399ff8b1cc8a1c.camel@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Mon, Apr 20, 2026 at 09:41:06PM +0800, KaFai Wan wrote:
> > Does this same recursion vulnerability exist for BPF TCP congestion control
> > algorithms using BPF_PROG_TYPE_STRUCT_OPS?
> > 
> > If a BPF congestion control algorithm invokes bpf_setsockopt(TCP_NODELAY)
> > from its cwnd_event callback when handling CA_EVENT_TX_START, could it
> > trigger the same unbounded recursion?
> > 
> > When the kernel transmits the first packet of a data train via
> > tcp_transmit_skb(), it invokes tcp_event_data_sent(). Because
> > tp->packets_out is not incremented until later, tcp_packets_in_flight(tp)
> > evaluates to 0, triggering tcp_ca_event(sk, CA_EVENT_TX_START).
> > 
> > If the BPF program then calls bpf_setsockopt(TCP_NODELAY), it would result
> > in this call chain:
> > 
> > tcp_transmit_skb()
> >   tcp_event_data_sent() -> invokes CA_EVENT_TX_START
> >     cwnd_event()
> >       bpf_setsockopt(TCP_NODELAY)
> >         tcp_push_pending_frames()
> >           tcp_write_xmit()
> > 
> > Since the outer tcp_transmit_skb() hasn't finished, the send head hasn't
> > advanced. Wouldn't tcp_write_xmit() see the same SKB, attempt to transmit
> > it again, and re-enter tcp_transmit_skb() causing an infinite recursion?
> > 
> You are right. I can reproduce this. 
>  
> > Should the restriction on TCP_NODELAY be enforced at a broader level, such
> > as inside _bpf_setsockopt(), to protect contexts holding the socket lock
> > during TX paths?
> > 
> We can check in sol_tcp_sockopt().

I don't know how it can use the socket lock to single out this case.
All bpf programs that are allowed to call bpf_setsockopt should
have the sock lock held. Maybe I am missing something obvious.

In bpf_tcp_ca_get_func_proto, it checks what ops can do bpf_sk_setsockopt_proto.
Right now, it rejects the "release" ops. One option is to create a new
func_proto, bpf_sk_setsockopt_nodelay_proto, to reject TCP_NODELAY.
Instead of checking cwnd_event[_tx_start] in bpf_tcp_ca_get_func_proto,
I would return bpf_sk_setsockopt_nodelay_proto for all ops. We can revisit
and be more selective in the future if the hammer turns out to be too big.
"release" ops will remain disallowed from calling bpf_setsockopt.
