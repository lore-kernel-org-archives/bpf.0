Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795459016;
	b=WbEvLncNryGiSJrmCndkS6zMDxrwFBlmvwi/q4KnMAg4chDu8WrN/vXbdUXEGpNy4q/z
	 evFLNcR5r2a+rTeZUrJRLzFVSI0a5tYKl2r1Vbtqe/g+i4qowxQRF7l5fUtmBJG23LiId
	 ydet70dflVoA4OfFibHb+vcydGmn8+FB1pzAs7x6Yt33AeryXrC40oeHJE4TzY6R6HaCI
	 J1ybtl55JKinCwkw6UuTJ7+rcLmk2yemHXwpXBE787TKll90XhwLanzDl0Xcn0MkbP+iA
	 DKaCaywbQtQcyBNNVRxT61tqLjHFwQiNJSzHLJ1rVE5GxYdQ8QsUQAbTQL+zbPg57JA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795459016;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=YhTGAVymGoABOYQ9LrlduPrSmhBuyrBLKJwutC/evWA=;
	b=QPWtPj6qcinqDM40jkdL+S1rmwljhwfOAAGKMoGpgpPvWbW060av748hY4EMpck85u3z
	 KcqHXZ/pBD3eAqF8rINqDIXldXd+5se/K5SJtwrXb+YclOKlCiRuiwgG645R2BSQQbOAx
	 WqJ7Ii07Ii/n2+9kNs+s2bnzXuQhs8tzd6QEGemAwoTChoc1E9RT3sAjpJONaeunEDeLJ
	 BoWaxObnuCsjxyExlOSXlPyWCx6wEN4QPeqThoGa2itmXLhPqezkTfR5YykxQWpQpdlYz
	 bVRkehoXdUNs9+gszVVvgnNwMfJpeJxTTIwZv3/4npoXxoQ7FDnvusjce9yO6LiOKKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JxX29fLd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE655606A31A
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 18:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JxX29fLd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CB4A1F000C4;
	Mon, 23 Nov 2026 18:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795459016;
	bh=YhTGAVymGoABOYQ9LrlduPrSmhBuyrBLKJwutC/evWA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JxX29fLd9EXO/WvdhYKs3bWauBVI/JHVUlFYP22QwMpVKLZ2Oyg21Maw42HszfR59
	 jrfsZhmH+ZgrO9SThZxEwhI5Q81bMjS8uiIoLWNlC8f/bgwPXUXkP2lg/gHC7pPSVt
	 Bu76maG7W1ustwp0zLiS5Np2kcxrw+qf7mNpPpF8jE6turwr47AblmDmgp3IFJkjII
	 LMIrenVjQj7hOElBEfCpveWr1tWQWgpIIgZrsbQM66nOg5deMgOQ3nExlqXbFnoVtA
	 /HZ+J21K36imh7DtOsObkPorA/QLTBMgS+6htZl2z5cimT/852YbnIIc2x2y8qO1jB
	 8eJmLE5Lmz17Q==
Date: Mon, 23 Nov 2026 18:36:47 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org, 
	Puranjay Mohan <puranjay12@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, kernel-team@meta.com, "Liam R. Howlett" <liam@infradead.org>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Pedro Falcato <pfalcato@suse.de>, 
	David Hildenbrand <david@kernel.org>, Jann Horn <jannh@google.com>, linux-mm@kvack.org, 
	Chris Mason <mason@kernel.org>
Subject: Re: [PATCH bpf v6 2/3] bpf: switch task_vma iterator from mmap_lock
 to per-VMA locks
Message-ID: <awSELWmIo2LA3bM8@gremlin>
References: <20260408154539.3832150-1-puranjay@kernel.org>
 <20260408154539.3832150-3-puranjay@kernel.org>
 <awGZWsCp6v63H_py@gremlin>
 <DN267JUKDRNS.2VMV07CQ58R4X@gmail.com>
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
In-Reply-To: <DN267JUKDRNS.2VMV07CQ58R4X@gmail.com>

On Mon, Nov 23, 2026 at 12:40:32AM +0000, Alexei Starovoitov wrote:
> On Sat, Nov 21, 2026 at 05:40 AM Lorenzo Stoakes (ARM) <ljs@kernel.org> wrote:
> > This is buggy and can result in deadlock. You need to revert it or restrict
> > which contexts it can be called in.
>
> Yeah. It's a bug though very much theoretical.

I'm not sure it's really theoretical. Especially given your second possible cause.

> A revert would bring back an actual deadlock that people hit in production.
> So here is that.
>
> > I'm a little surprised you didn't cc- or even ping mm or the VMA team here, we
> > are always willing to help and it's clearly sub-optimal to write duplicative,
> > open-coded VMA traversal in BPF.
>
> Fair point. Will cc mm next time.

Thanks!

>
> > It's not really sensible to alter core mm to accommodate this at this stage, so
> > probably the best course is to disallow this code path for softirq context, or
> > you could look into patching the x86 code.
>
> A softirq check is not enough. A tracing prog can run in task context
> with pgd_lock held and irqs on:
>
>   pgd_alloc()
>     spin_lock(&pgd_lock)
>       queued_spin_lock_slowpath()
>         trace_contention_end()          <- pgd_lock is held
>           tp_btf/contention_end prog
>             bpf_iter_task_vma_next()
>               lock_vma_under_rcu()
>                 vma_start_read()
>                   mmdrop(other_mm)      <- last put takes pgd_lock again
>
> Equally theoretical deadlock, but since we're discussing hypothetical bugs...

Yikes :) again this seems like something that can really happen, even if it
might need you to be rather unlucky.

>
> can vma_start_read() use mmdrop_async() like free_signal_struct() ?
> It changes only the last put of other_mm in err_unstable.
> _destroy() already calls mmput_async() from the same contexts,
> so the fix costs nothing to mm afaict.
> We can fix it on bpf side, but below fix is much cleaner.

Yup this is the suggested AI patch also :)

I'd want to do it slightly differently from that however in some of the details.

Sigh. It sucks for core mm to have to retrospectively address this, but I also
don't want to cause unnecessary horror in the caller.

Probably then mm doing this is the right way to fix it, so let me have a look at
this and send a patch.

But yeah, let's also revisit this open code and have the VMA API give you what
you need properly as a follow-up.

--
Cheers, Lorenzo
