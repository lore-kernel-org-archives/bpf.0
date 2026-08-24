Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C907B3F822F;
	Mon, 24 Aug 2026 15:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787585046; cv=none; b=agWBZLVIz7Mug87VlIhkBb0UtuYvKerZZ6sp7SY01NB9bbQs3kRFXAV8r9NMh3OKB1Z6FjKh+rAnDH7klF5ewT5R2+kZZJeFZyaxIR3WkN7BHtH/dsfjJkgvonztqwWQdxODca/Dg0YAuYwdYC6MqFgapJt08Sd0L1ALkv+UfLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787585046; c=relaxed/simple;
	bh=5I9Ea/bCjozSolIxniPcMiLSBZGm6NwguA/7bdgtJpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HebPPcG2/ByuzVti/HhxLHKyCUuMfuNgVUNOogO4tF+zbpcvu+3aF7p7SO9Mr6z4iu5NwoLXrUHFSLcJ8u55zuo9E8c+LlhUP+w0Q+KFL/z75T4Rk0wQljfLRMrrYtxaWf8KpRiPUvjKBJOyPeYKbOPazIxPnfRpvD10KAlJsUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DJGSGg/b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJGSGg/b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 257291F000E9;
	Mon, 24 Aug 2026 15:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787585045;
	bh=mcw1FaqpqN1fC2wyOxEQI80FG3a+BD9XUeXDJIlvzec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DJGSGg/bjUAW6H+yCzR0IePkcLMVg6lpFFuJzo46rAW9B3BtEaYUULCpInzdAqUWe
	 vcaRx1Jx/UhRpu0qLAKSgT9KAXEfeHIYrGC3WJnOuIh0A/TMlfm8IX60QgW5rBZ5Ty
	 z9KkznHNyo2VPQefi824jviu+tkLIvtkx4cP9AVQo3KjdBGZuWvSxrRT/HYTOmcr6I
	 i/nvI+3bJlAFq7uflyCBPdUTUwprHSmujalKrwNengBMSmDtqO+FrvFDTJvP3W/RUC
	 MKGbfsbxI/S0F52UNWpLbSvgbh6CsplJAXRLexTykf7z9DvVxUimeLEHFzko/qLNE+
	 d6LlExTi11C6w==
Date: Mon, 24 Aug 2026 16:23:57 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, 
	akpm@linux-foundation.org, nico.pache@linux.dev, baolin.wang@linux.alibaba.com, 
	baohua@kernel.org, dev.jain@arm.com, hughd@google.com, lance.yang@linux.dev, 
	liam@infradead.org, mhocko@suse.com, rppt@kernel.org, ryan.roberts@arm.com, 
	shuah@kernel.org, surenb@google.com, usama.arif@linux.dev, vbabka@kernel.org, 
	ziy@nvidia.com, usama.anjum@arm.com, agordeev@linux.ibm.com, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, jannh@google.com, 
	willy@infradead.org, pfalcato@suse.de, rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [RFC PATCH 03/57] mm/collapse: add collapse.h for the shared
 collapse state
Message-ID: <aoxhUy6198VLCryN@gremlin>
References: <20260816224609.308019-1-kirill@shutemov.name>
 <20260816224609.308019-4-kirill@shutemov.name>
 <3113ac8b-c1ce-4577-9e93-449b70818918@kernel.org>
 <aobglSY5L1KoIqxF@thinkstation>
 <65433d1e-95ca-4434-828e-8f381d3384b1@kernel.org>
 <aow0Z6mrG2esKpRZ@thinkstation>
 <e1c8c6f5-1b5a-4cad-a52a-f7eff00997c3@kernel.org>
 <aow6J1i2G7U0spjH@thinkstation>
 <aoxPzKTVRmZgmBKg@gremlin>
 <aoxe92BxF-5xaScD@thinkstation>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aoxe92BxF-5xaScD@thinkstation>

On Mon, Aug 24, 2026 at 04:18:09PM +0100, Kiryl Shutsemau wrote:
> > Even this reads as AI-generated... Consider writing the replies yourself
> > please.
>
> Seriously? This is border-line insult.

Sorry that wasn't intended as personal. Text is a bad medium.

What I meant to say is I agree with David re: the use of LLMs in replies, it's
not helpful in that it leads to the usual issue of very large blocks of texts
that are difficult to parse.

So put in a clearer way - I meant to say that writing them yourself would avoid
this issue.

My experience is that the series as a whole is overwhelming to review in its
current form, and adding more material to get through this way makes it more
difficult.

Hopefully this clears up what I was trying to say... :)

>
> --
>   Kiryl Shutsemau / Kirill A. Shutemov

--
Cheers, Lorenzo
