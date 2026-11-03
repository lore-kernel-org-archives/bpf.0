Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793706731;
	b=DwaO05+4p8SLWDOUkJUk38zJrD+bTVa5Kj+iBA14MM5s1B98B5oqUPnDjEHVn+fM1zr/
	 FwcmIGLm80BAOAxa9gVqEavwnz/ggxgKcJc87wREyzfZgJXu/YYPS3RNb3UYZkfIC89fE
	 V7Nyt7FcaQqte+klaq8iyevLIB6BApO7DjA7wqf3k/f7F/Y2b9zPtq2/nMinrs7tCuAym
	 sakXoGHO1p5cnw+nragMLx34lY+oLfSVg2F3HNaS1bv3etlhXCO7ADNpJPLC59RiPsjsm
	 TovRUeZFRREGQcNd6h6roB+OXD60+Y2t3KkHFC9OQA0w9Foapwvix1CnjgcY1lB7Iyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793706731;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=eI4CVv+ydIY1wa3rrW/Odp3qY0sHcQj8Jj1GQUapMZo=;
	b=e0E0YuKVwn+gHtx5DHbDRs0VweYuVzaN/1IPvPM8bQP8IH8NdLSK/T9Dqpvd8vfrWwv7
	 90AcVAKJ/6Gqw4SwgN+vSbBf076vte5OkxRWnR1FVNWC7gqS66zuvDFj5tHZ9HLNm94tp
	 3V33uzTh7ONhUXj0QVgjdEqn3nD8LMBo+HPP1eEc9n062R9RNAnqsFRB6/hXl5WyOpY39
	 Gzangpf53tVeQUpTUjonCUC8V65D3GluJcy57KIj2QTXDOypLJUZOxijlS3RHjWLCaKRb
	 RmVX1aE0hcUL/ICXRJ65G98nShCH+mGZU9Wey0A2GPR3ycsM7ipMXXl1Zoet/8zPmng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=r26bKKjz;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44210606A329;
	Tue,  3 Nov 2026 11:52:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44210606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=r26bKKjz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=eI4CVv+ydIY1wa3rrW/Odp3qY0sHcQj8Jj1GQUapMZo=; b=r26bKKjz1RxbYOpykqB9PYTHT2
	RrsgjuOIdrXMvpVMWJNvYLrdz8gy2PEpCUs5b9Sjl3NcHHlWNfLz9Rf5D6lZjf4krWvMajTSihUOQ
	lMLqmSzi59qhLI17XqMtmPOSU4mcVOjOrcnBv63pa4FK6J6wZnivAUcW7DqYQ/gGMsZbBRw+Q0HTe
	/yswu39KjLyquVmUnrjlrA8kYQ0V/sGP5q4tFiIjAR5ghbIQG3ZGAoCJoJ5P5p8Xh6sX1lhCVAjRF
	zXUWRWolS0rMreglj+beiVoiC26YySEdsW3joRAtJmwnWN1Fdn/rcH/Lh0rVEOf9Beb5+WDLHqyOr
	Lj+2z3kQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOD3Y-0000000Bt6e-2ENh;
	Tue, 03 Nov 2026 11:52:00 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C62F9300322; Tue, 03 Nov 2026 12:51:59 +0100 (CET)
Date: Tue, 3 Nov 2026 12:51:59 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Nico Pache <nico.pache@linux.dev>,
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>, Waiman Long <longman@redhat.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 3/5] locking/rwsem: add down_read[_killable]_nosteal()
Message-ID: <20261103115159.GK1813469@noisy.programming.kicks-ass.net>
References: <20261103-khugepaged-latency-fix-v1-0-a07ab16ac860@kernel.org>
 <20261103-khugepaged-latency-fix-v1-3-a07ab16ac860@kernel.org>
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
In-Reply-To: <20261103-khugepaged-latency-fix-v1-3-a07ab16ac860@kernel.org>

On Tue, Nov 03, 2026 at 08:27:44AM +0000, Lorenzo Stoakes (ARM) wrote:
> Since commit 1a728dff855a ("locking/rwsem: Enable reader optimistic lock
> stealing") a sleeping, queued writer whose handoff timeout hasn't expired
> can have its lock stolen by a read lock issued before a woken queued writer
> was able to acquire a lock.
> 
> To avoid write lock starvation, this is only permitted if no other read
> locks are held.
> 
> However, this behaviour defeats the purpose of a reader periodically
> dropping the lock to allow writers in, as doing so only works if the write
> lock is acquired first, another read lock is held, or a queued writer's
> handoff timeout has expired.
> 
> Provide a means of indicating this intent via down_read_nosteal() and
> down_read_killable_nosteal().
> 
> Implement it by exposing a steal parameter to rwsem_down_read_slowpath(),
> update the starvation logic to modify this parameter and modify the steal
> branch to check it first.
> 
> Also drop the duplicated RWSEM_WRITER_LOCKED check and remove the
> goto as the steal condition makes this redundant.
> 
> Exposing this function is safe as it only makes the lock more pessimistic,
> so does not impact lock contention.

Not generally a fan of this -- can't we tweak the steal thing to never
steal if there are pending writers?
