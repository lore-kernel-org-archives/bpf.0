Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794317616;
	b=JuW7FaIInHk4ai8KBCQZlYj2TXjTRbtAWgkiFElBAvmFyNnKQyc5Kn6cSpQsMpAk43vP
	 kk6LJ9dn1yFd9gLRxwkW+QkS1lkLB8rOATAv+3k+7HPNphWvoIZPPGeE2MNyfvun+5ihI
	 GEBj7uKH352SrOPFxVMF/oata+65egwtLZWEABLynTNGKLwml2Rd//y2LcJ3JEU8O9fSy
	 Zw0s1qek4Hhlv/SCV020M9P4IbOB2i2nI6hhR0kt6r9eQ9GvlXmdAfnJy4Q+Sr5cu8/bc
	 WigFUiTpADbIuvgbsft4bPuv8eX2nHkKCaaLaaV65/Irjf2Q9zN2oIuGNvMZvask8wQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794317616;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=vnFBc5/3J+ldv1POK+b+j43xPTAaqz4dP0Xvyz4JmJ0=;
	b=kFETD226JZ+tqF4SrY675EqA8TtTfASKvcBsFAMkJT0ze+pRH5HNEnZkd0qtJJoQQ6Xv
	 OH0tWK8YBQdH4THuNC7pBQsUwrunEtiHHJVnudGpDNEDl95OhZZt0kyDgxlJ4OFlsFsoL
	 zLFxDEkkMFjw1Yoo0u3kPg24vAC4OU4xWK6OtPZvxUGhs/kYRJ/pN9Hh6idNMQnYglNu3
	 8T6+4T0OMhvzQoBtJVyCobfgCnbgJdhcqokQ4EvujXy2EoRp7xD47vsQV5bqzcFGolCAE
	 EQze98y2CM31G15IBIUd4LUTqq9sKN8eEW/k0vDEiOCqMFrVCWB1Bl4WMGLI5r5FSJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P9w6SBPv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7FF606A7CA;
	Tue, 10 Nov 2026 13:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P9w6SBPv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A1B41F0089F;
	Tue, 10 Nov 2026 13:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794317615;
	bh=vnFBc5/3J+ldv1POK+b+j43xPTAaqz4dP0Xvyz4JmJ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=P9w6SBPvJauunn+tf4ys4VQ74ac/ir9Wol/AAZwJaJu5GcWcbXcjTkAf/iKFotS8G
	 QscXPFgFD2ReyjJ1UjgOmo0o3u/whiAwEK3ZyU/oLtmYD82JdBx2KaVpXXoGWSugGI
	 xp/xiBmgP5Ph6X4cACvZ90BEBK/nvzanJSIehWA0pFpx+j0GZfHiXVjS/lMMRQSeof
	 u2clJWhGOlBbd7FXOWLXsE3kJ1Cdtd0hb4BpOX4nseOK/LZWVYtMa03dJcdA42vFDj
	 mdrNG/sdnLu1NEl4JDR3Dop5xb0a6bdZ5RikiC7t58drb9tlehqmeXsAcCC1j37aqH
	 UM2MbNmwDb6wA==
Date: Tue, 10 Nov 2026 14:33:33 +0100
From: Harry Yoo <harry@kernel.org>
To: Hao Li <hao.li@linux.dev>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org, 
	loongarch@lists.linux.dev, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/slub: Genericize x86-specific cmpxchg16b comment
Message-ID: <avMcw2Poqn2uk5cl@thinkstation>
References: <20261109035906.10857-1-yangtiezhu@loongson.cn>
 <DMQW32TTNOPX.24GN6Q7VI6QJR@gmail.com>
 <145c23ea-bc4d-b235-c822-df94b00a647a@loongson.cn>
 <avK8RqLl69zIkVY2@fedora>
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
In-Reply-To: <avK8RqLl69zIkVY2@fedora>

On Tue, Nov 10, 2026 at 03:05:14PM +0800, Hao Li wrote:
> On Tue, Nov 10, 2026 at 09:29:04AM +0800, Tiezhu Yang wrote:
> > On 11/10/26 2:25 AM, Alexei Starovoitov wrote:
> > > On Sun, Nov 08, 2026 at 07:59 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
> > > > atomic primitive is satisfied by different hardware implementations:
> > > > (1) arm64: satisfies it via LSE atomics ('casp' instruction)
> > > [...]
> > > > Update the comment to "double-width atomic cmpxchg", which provides the
> > > > following advantages:
> > > > (1) Accurately describes the cross-platform hardware invariant.
> > > 
> > > You ignored Hao's point about shorter commit logs.
> > 
> > If the following shorter commit message is preferred:
> > 
> >   mm/slub: Genericize x86-specific cmpxchg16b comment
> > 
> >   In __kmalloc_nolock_noprof(), update the comment from x86-specific
> >   "cmpxchg16b" to generic "double-width atomic cmpxchg".
> 
> Ok, LGTM.

Looks good to me too.

> > I will wait for a while for more feedback from mm maintainers and send
> > v3 if necessary.

Please send v3.

> > Thanks,
> > Tiezhu

-- 
Cheers,
Harry / Hyeonggon
