Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8332C375E;
	Fri, 23 Jan 2026 12:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769169787; cv=none; b=Bfa+3nfyam/i9cNcf5i7nV4O5FVu84ryIuUqmBdn+bXBh2wlwYXUgBL61ypW0GautvcAnA85T7i2nP07a0jhEQGiCqFNXhQPcGllhz32vfuaxj3F2ZApT9aAhRwu1js7tti6kutkS8+wuyTST6oBFm7xgSxlkpTtSMIeAdiy7cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769169787; c=relaxed/simple;
	bh=bXS+Zs9pCIXBb5gqkVSOwk2VgarD8vq70BgHZ7jR1bo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sDump21R7d/6tvydW8kFuYUGSlKuUo5PJ1NIJAhMi0qD6XB+TH/ZNrYcR2Bh3a4g/O4C6ZR9zTMZXyje6rfQIiuxdJG65Lw4rR7WSZ5Fmnbl6oTcNDb9KzHXOxBHCRQyZ8eDWvf9QxLjOWbjz7JaoZRqt8ZBmVrhCZdE6wH3s0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a2TXmIgH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LWu1kPfD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a2TXmIgH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LWu1kPfD"
Date: Fri, 23 Jan 2026 13:03:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769169784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d/X5EsI0mvP/S5uf20Pvy9T65z0CIjEe5oCCyfrYy4k=;
	b=a2TXmIgHE5csJ7d3yjab3MQF2OzNvARYue91SHvMZtiYkscH5h3i/iPwuYxBhtq5ss2Z7g
	OWiOuvRRMR3HWqKIFLIzwayeWIjRhquhTvAi53s0CE87H1xyrUV6uC9uDq/16Etmet9U9o
	rGZo4gUwgYgMlA1aChYnYhgf0eCSUoFrrfupJ0YZkzT3spI4FpNrT26Td90MtrM67h5Bbc
	zUl8yquLCrwWKdaNjoJ6hUbUzI0UslyY7+BZ1W+fuZAIt6qoqR1oQ3PQfy6FuFLb2QrBF2
	qKeWbCQm0kYj1EKwDeLsRLMhGYnCzHZrWlkMhkiQu/OAoVye0CNA/kzGPA0Q8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769169784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d/X5EsI0mvP/S5uf20Pvy9T65z0CIjEe5oCCyfrYy4k=;
	b=LWu1kPfDeQQ9VCICNNdwrVE1s6nQxcJqf2a0hPTg4+/K5d776xHUVR0Kpka3InbF5u6jp9
	KmKxHfVUWlAqrqBA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Harry Yoo <harry.yoo@oracle.com>, Petr Tesarik <ptesarik@suse.com>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hao Li <hao.li@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	bpf@vger.kernel.org, kasan-dev@googlegroups.com,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v4 02/22] mm/slab: fix false lockdep warning in
 __kfree_rcu_sheaf()
Message-ID: <20260123120302.TsiVMAQb@linutronix.de>
References: <20260123-sheaves-for-all-v4-0-041323d506f7@suse.cz>
 <20260123-sheaves-for-all-v4-2-041323d506f7@suse.cz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260123-sheaves-for-all-v4-2-041323d506f7@suse.cz>

On 2026-01-23 07:52:40 [+0100], Vlastimil Babka wrote:
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -6268,11 +6268,26 @@ static void rcu_free_sheaf(struct rcu_head *head)
=E2=80=A6
> +static DEFINE_WAIT_OVERRIDE_MAP(kfree_rcu_sheaf_map, LD_WAIT_CONFIG);
> +
>  bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj)
>  {
>  	struct slub_percpu_sheaves *pcs;
>  	struct slab_sheaf *rcu_sheaf;

Would it work to have here something like
	BUG_ON(IS_ENABLED(CONFIG_PREEMPT_RT));

or WARN_ON+return? The way the code is now it relies on the check in
kvfree_call_rcu() and tells lockdep to be quiet. And since it gets
optimized away=E2=80=A6

> +	lock_map_acquire_try(&kfree_rcu_sheaf_map);
> +

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
