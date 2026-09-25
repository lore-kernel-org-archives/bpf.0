Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F5F2DF6F4;
	Fri, 25 Sep 2026 23:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790377495; cv=none; b=e5ta5+9PfWilDE2t/Vv21LTAJH6UDWhUZ6Q/urGzPFyHFgXkANkD4FVg0IV+vj364jGQfENdTjfWlsCVU8t1BHMlFI2J90ET/l06FwlNGzjKfUkhid8MkIYGMA8yWKNrHdHkB338mC7t55bsLWi5HMd2Yrl/61iW2YiNiE/Lh5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790377495; c=relaxed/simple;
	bh=gPgu9rnLTTgzZyYxrou4VP0kKKqtdv8uvlM7X852xPE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=NgIaVvbPkKwmE0oeQVeGTB07VBctBEd3UomR62noSi/DxqW+xjd1JmDkp7Sy6foXu2VEzwvIgjn9bKJT0z6V5OumxXT707LGXO04BTQUaTf3P3d5Cu+3qa9DU152KnffuRreKJmfiEICHVv/rGjmcVQWms2DGcRJsJ9BGsPqHCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=fv/XMh+c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fv/XMh+c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 786071F000FF;
	Fri, 25 Sep 2026 23:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1790377493;
	bh=/CbPmrir7hvxqhkoRGJquW0lh0N7NUF6YrjVn/tUNMw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fv/XMh+ciNrkinWE2uBqyZ2g/HbLC9pT6uDzbPPDf4mdTgRykf8To4g7xkYKggnZw
	 ADGOc6rhFVqm8fli9Kg6FbxUztl7iIXjjFxXe7c5uqSxWDNZNzPSwlssQE70XaQ2lY
	 E67hvMJX/ROPD8WgGruQCvgAveUmP7zQv+QdGYpk=
Date: Fri, 25 Sep 2026 16:04:53 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>,
 linux-mm@kvack.org, liam@infradead.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/nommu: Reject wrapping ranges in access_remote_vm()
Message-Id: <20260925160453.7e7561edb77b5c4152675f7e@linux-foundation.org>
In-Reply-To: <arZzn0bwWqp7xTE5@gremlin>
References: <20260909064231.18693-1-tasos.papagiannnis@gmail.com>
	<arZzn0bwWqp7xTE5@gremlin>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Sep 2026 14:20:33 +0100 "Lorenzo Stoakes (ARM)" <ljs@kernel.org> wrote:

> BTW always feel free to nag if you're not getting review! Something things
> get missed. (Though I'd say wait at least a couple weeks before doing
> that!)
> 
> On Wed, Sep 09, 2026 at 09:42:31AM +0300, Anastasios Papagiannis wrote:
> > The NOMMU implementation of access_process_vm() rejects address ranges
> > whose end wraps around, but access_remote_vm() bypasses this check even
> > though both functions delegate to __access_remote_vm().
> >
> > Move the wraparound check into __access_remote_vm() so it applies to
> > both entry points.
> >
> > This is originally reported in [1].
> >
> > [1] https://lore.kernel.org/bpf/4ef240a5bea36ff84df9589671367832860795159386a4c8fba546a0fa8b786f@mail.kernel.org/
> 
> Probably better to drop this big and make this a Link: tag.

My scripts (after much recent LLM-driven fancification) made this
change automatically!  It became

Closes: https://lore.kernel.org/bpf/4ef240a5bea36ff84df9589671367832860795159386a4c8fba546a0fa8b786f@mail.kernel.org/ [1]

But scripts didn't figure out how to add a Reported-by: as well.

> >
> > Fixes: f55f199b7d76 ("NOMMU: implement access_remote_vm")
> 
> Cc: stable I think?

Well why.

I see in [1] "causing memory disclosure or a bus fault".  OK, we care
about that.  So the changelog should tell people this very important
info and should explain the circumstances which can lead to the failure.

> > Signed-off-by: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
> 
> Seems reasonable to me! So:
> 
> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Cool.


