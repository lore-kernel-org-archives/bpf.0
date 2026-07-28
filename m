Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AF4427A1A
	for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 14:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785247837; cv=none; b=MXxNYOs7dHF+bnoppSwLCmGfRg2/dTzrJEOPOjCw3+R0lxSrt6pdgx+1aWqAcUm7Ot89DqiTtwFoTQGvdDgyJdL6zWxgZA82+iP4sO2SBD1vARacEk1AYcIEjd9GDs6zUwoAgq4QqV7aiM58qSAxj3QhKtJMZo9fJ57T99k1pDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785247837; c=relaxed/simple;
	bh=InOnZ1pHA2iVVsvxVkslAkifC1nhanKrkXE7XVcRDgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AAcVRNGbVIXvk1jdQEE0orK0v/OiTNDyBXjHrMWGWPGwE/y2lit0O2NiUCgdIHas2Oym1HRVKqcLtyLNsOGTEfShEasj5Y2nTpMcnQl4Nq249uTFNwk4jcJ+0G/gtAsJmL3oxCSr0+ys+d4vNemE0RPb4J5/47vjzf0uyfKbkO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=os+Rvwk3; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="os+Rvwk3"
Date: Tue, 28 Jul 2026 14:10:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785247823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=InOnZ1pHA2iVVsvxVkslAkifC1nhanKrkXE7XVcRDgA=;
	b=os+Rvwk3oU9Y2rvxRU16psz7g5EY3ObusC6xwcRaRGYzsqZSCDuRQsBovKwgYieKmbAMzO
	Pxv7sBW4ip7Rofx3SBXu+oOLC+Q2i8KvysQROtR65zJWZfk6HNlyFK6Xh1UHnUqekFMj+W
	hWSlZE6oAcZlNYqHkuclRsQFXqq7fMA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: sashiko-reviews@lists.linux.dev, Kuniyuki Iwashima <kuniyu@google.com>, 
	bpf@vger.kernel.org
Subject: Re: [PATCH bpf v2] bpf: tcp: Fix use-after-free in
 bpf_iter_tcp_established_batch()
Message-ID: <ami0NJ9s6ZhXVZb5@linux.dev>
References: <20260717-bpf-iter-tcp-refcnt-v2-1-8e81f0ac6f3e@linux.dev>
 <20260717025253.23EEB1F000E9@smtp.kernel.org>
 <DK4HTPHX3NL8.2N1FK8D2N9521@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DK4HTPHX3NL8.2N1FK8D2N9521@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Jul 21, 2026 at 09:24:05PM +0200, Kumar Kartikeya Dwivedi wrote:
> On Fri Jul 17, 2026 at 4:52 AM CEST, sashiko-bot wrote:
> > [Severity: Low]
> > Does this multi-line comment follow the BPF subsystem comment style?
> > The BPF subsystem guide expects the opening block to be on its own line:

On the comment-style note, checkpatch accepts both block comment forms
and the one used here matches the surrounding code in
net/ipv4/tcp_ipv4.c, so I don't think the bot's flag applies. Either way
is fine by me, whatever the maintainers prefer.

> > Pre-existing issues:
> > - [High] Double-put and wild pointer dereference of batch sockets on the
> > first bpf_iter_tcp_realloc_batch failure path.
>
> Hi Kuniyuki,
> Thoughts on the fix and Sashiko's concern? (The latter should be probably be
> fixed separately, if needed).

The double-put is pre-existing and already fixed separately by
980a81345275 ("bpf: tcp: fix double sock release on batch realloc"),
now in the bpf tree. The hunks are disjoint, so this series applies
cleanly on top of it.

Thanks,
Jose
