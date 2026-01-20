Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DC5426D1E
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 12:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768911098; cv=none; b=DqnfUFrNu0sSBBg8HtbOIqEVGZQL0WKbAfLz2eMAwW76pJ+JQGHl7ohOdCb7Hw7Mges/uhpiWmoUGHuMKz1WDEYHfz9BGiwLoKeWjUzi8IXVgqBEtFA3ryiNi+V3gBUDmssfCIWcO+suvkr1lptY6hftTtFGsklIQ6kLH10scm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768911098; c=relaxed/simple;
	bh=pEnfeULKBhJxNamTxUnPO+8JkY5cm0XWckh3IDcPkGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uaLIEBUh5DcF0GCaJv6dolPzN2L43iZgaiWoFXUFPSAU6ydW5g/YAdLptzBKxOOqqkDHQKZzWqjuhxmcU2ONSMM/CwG9GDyg7U3Hk0jdyNDfwh+VrjWo9MCfyrfGlVDHeVUf5rhLMTBI2V+Br9h18UBcxPIlMvWa9kGuHHUo1OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=q4pTiUAf; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="q4pTiUAf"
Date: Tue, 20 Jan 2026 20:10:55 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768911084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ft4cfnsazH2fqh82dag3UKKoVEEmk8hPCPptOiIZ6Ls=;
	b=q4pTiUAfOIKpOsCaPxK7ufMZNY66q32D+T6qXJJExTNSxwJ2okdO2ymUJknkUzAKiW8yBq
	Q/y0CluMbt79RShE0/KvxS79Bl40SYaVHrdvCs22+iNKnaLsmI+uSrZOev9JWGfCrKcY7O
	h+6Ys3n0CeZTFZDrSjJWfpDJDu7UQRE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Li <hao.li@linux.dev>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Harry Yoo <harry.yoo@oracle.com>, Petr Tesarik <ptesarik@suse.com>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, bpf@vger.kernel.org, kasan-dev@googlegroups.com
Subject: Re: [PATCH v3 11/21] slab: remove SLUB_CPU_PARTIAL
Message-ID: <3vjyq6wpkvaczzgl3r2qhwi7zdluh6zldejjxnki2hft7vxr52@g7gn4lqbdi3c>
References: <20260116-sheaves-for-all-v3-0-5595cb000772@suse.cz>
 <20260116-sheaves-for-all-v3-11-5595cb000772@suse.cz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116-sheaves-for-all-v3-11-5595cb000772@suse.cz>
X-Migadu-Flow: FLOW_OUT

On Fri, Jan 16, 2026 at 03:40:31PM +0100, Vlastimil Babka wrote:
> We have removed the partial slab usage from allocation paths. Now remove
> the whole config option and associated code.
> 
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/Kconfig |  11 ---
>  mm/slab.h  |  29 ------
>  mm/slub.c  | 321 ++++---------------------------------------------------------
>  3 files changed, 19 insertions(+), 342 deletions(-)
> 

Looks good to me.
Reviewed-by: Hao Li <hao.li@linux.dev>

-- 
Thanks,
Hao
