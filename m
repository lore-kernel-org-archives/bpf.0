Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793874608;
	b=IvXvUdBgQJIYEtJMNGq5KZ4FaiHHQK2piecTqo9e0r78w0kaIPwPXRTkFExXCHIr+N5G
	 SGIEEV6BEMBckJPZULRd9aKRrILvJZfU4lQ/o+sQlmdjvmrs/hsDnhPh7uDAQckPbkfUE
	 PiUzWMWN1dKtgkDuyYow6m7ztzDaouOiE9/PxUpzcwuKKilzhraTQfaCUhLWQuHOFfLmh
	 ltWZN6rYsay0MXEB7MnbsnlKinY+mJxoOYWpMn6WjgyOuJCebezfYSsewKy5PCeoBO27m
	 Tbd/Y0zfkYGk/Kc/+MEng1V6jhXTZvxXWec5XrRSh7dr8IweF0lv1G0oQrZHmFJcoew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793874608;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=n9zGelRzeR9jm80W8T8wv8FzP08CSeK9Ddixf5lP1vw=;
	b=0J3Q0tMNb3btNd40nE0z2bJK8IIUaSRG5mYXXAiGRXmEqDxyfRhVGLzlhannKnjDeqnH
	 4G/EvuoGwXonF/HULPQoIzSoMiPtEeY8HL0Od+lwS2mykShFQPXdB/HsUFAGc9goqD4jQ
	 Mk7+pSPgoguyJoUFz4TbyR0U8J72ukOR+J4LM6RxEdYZmmojK2nq9D8IdB1pTfnkGDPC2
	 h6tZIDGDUEr4Mtf5JOzq5cWxtDTjmVutrcGPggDMhKFVL4ZoxP0rPkK9o3EXUeYe79Qyg
	 SX+ddRH+ik6AEyGTVHt+/VzB4IfE/7ynXr3dpLqDUSxchBhDcxxA2rptQODAAvT5m9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="hqTmKQ/q";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47D5606A329;
	Thu,  5 Nov 2026 10:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hqTmKQ/q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04DCE1F000C1;
	Thu,  5 Nov 2026 10:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793874608;
	bh=n9zGelRzeR9jm80W8T8wv8FzP08CSeK9Ddixf5lP1vw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hqTmKQ/qNd9AeJgNq91fZYaBkT1aP98v69T7CblGk1hbHSSV41l03zI/1/gLM3P39
	 gr2TpxhJt9bX3ruuedNEVPDI3PC/uwQke8cG8mPbP4N1aS6QHl/CzhSema57b19cM0
	 FcavNSTFKDWdhBUABl23/UCdpe7kfj64O5K3lAHwlxA85029NxyrZ8hKOPWx6HmMO3
	 74/lcRV0iMzpQuYy95W6qJ2QC4F+kCiMDOwcAIa/BvYHSZYnL0kbfunbtWKVHZRZpp
	 +nRyPjoeSUj1qwEc8FYLCLEGra3P9X0mm1jCPybRdUbf+Cq4XXo/GbUcnmsAao7Akl
	 m89HXXZCO1PEg==
Date: Thu, 5 Nov 2026 10:29:59 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Waiman Long <longman@redhat.com>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 3/5] locking/rwsem: add down_read[_killable]_nosteal()
Message-ID: <auxaRUi4h4a4tfUk@gremlin>
References: <20261103-khugepaged-latency-fix-v1-0-a07ab16ac860@kernel.org>
 <20261103-khugepaged-latency-fix-v1-3-a07ab16ac860@kernel.org>
 <20261103115159.GK1813469@noisy.programming.kicks-ass.net>
 <aunLcWto870swo38@gremlin>
 <9c367177-1822-4b6d-8bee-d283eef7b895@kernel.org>
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
In-Reply-To: <9c367177-1822-4b6d-8bee-d283eef7b895@kernel.org>

On Thu, Nov 05, 2026 at 11:25:25AM +0100, David Hildenbrand (Arm) wrote:
> On 11/3/26 13:24, Lorenzo Stoakes (ARM) wrote:
> > On Tue, Nov 03, 2026 at 12:51:59PM +0100, Peter Zijlstra wrote:
> >> On Tue, Nov 03, 2026 at 08:27:44AM +0000, Lorenzo Stoakes (ARM) wrote:
> >>> Since commit 1a728dff855a ("locking/rwsem: Enable reader optimistic lock
> >>> stealing") a sleeping, queued writer whose handoff timeout hasn't expired
> >>> can have its lock stolen by a read lock issued before a woken queued writer
> >>> was able to acquire a lock.
> >>>
> >>> To avoid write lock starvation, this is only permitted if no other read
> >>> locks are held.
> >>>
> >>> However, this behaviour defeats the purpose of a reader periodically
> >>> dropping the lock to allow writers in, as doing so only works if the write
> >>> lock is acquired first, another read lock is held, or a queued writer's
> >>> handoff timeout has expired.
> >>>
> >>> Provide a means of indicating this intent via down_read_nosteal() and
> >>> down_read_killable_nosteal().
> >>>
> >>> Implement it by exposing a steal parameter to rwsem_down_read_slowpath(),
> >>> update the starvation logic to modify this parameter and modify the steal
> >>> branch to check it first.
> >>>
> >>> Also drop the duplicated RWSEM_WRITER_LOCKED check and remove the
> >>> goto as the steal condition makes this redundant.
> >>>
> >>> Exposing this function is safe as it only makes the lock more pessimistic,
> >>> so does not impact lock contention.
> >>
> >> Not generally a fan of this -- can't we tweak the steal thing to never
> >> steal if there are pending writers?
> >
> > Oh, well, I had assumed I couldn't fiddle with that behaviour across
> > rwsem's in general, so if I can yeah that's preferable!
> >
> > I could send that change separately then and drop it out of this series.
>
> Just so I understand correctly, this patch here would be gone entirely?
>
> But #4 depends on it, so now I'm confused :)

#4 would go too :P see, making your life easier ;)

I'll try sending the rwsem separately, then respin this one.


--
Cheers, Lorenzo
