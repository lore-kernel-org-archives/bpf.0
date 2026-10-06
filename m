Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7F5547053;
	Tue,  6 Oct 2026 00:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791247671; cv=none; b=gVgHgFum7VjbL/I7n/xG810y1VNTzFZmLM31wQieGmEhU7gD7nViRF4F2MC1yFPHjuM69jyA/0mUB5Z1bLBdjmXPm/yjj3aP5fUn1QxkmnwwbFh/cdUf1obumPDfN+kDh1s6IlFAlN/y5RuqBeRWyfT8ODY6cG7zj/NSF/yh+IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791247671; c=relaxed/simple;
	bh=1uyx2PR9FyJhmgfj8hhMJrQtMzybWNZgsTSOHcN9jv4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cd0GMPl3OByyToI7G1ljzLA/yrVi2jdHbgqAwaEj070zDZgXkFKmFmOII0Ku515no7FZKL8Oj5tDDBw+i8iT8ZBoD1WedBKYuDNlzvpqhJCHFpb237sCc5yQzZCh5LYS5ZLG/2r68g1h47TVrczRueLcOxh/OQMMn3UaYZUpZIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EXt7ULwM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EXt7ULwM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFF1A1F00893;
	Tue,  6 Oct 2026 00:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791247669;
	bh=nsnozgAjynyhVztQP/dM0tRkd3Fkc3G+sIfOOXdNP2w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=EXt7ULwMXOTOARddnKoEWxMxuvnK3M8gmK9uc4bNxAQnp6W+EiiUql2muNkyZG9KA
	 /Nm9N58bk2VyGOWkhsYG9H8aNHzDQoUTPNqENe3VPOcemqeQj2VxVX/zy/d//zZFGT
	 9yZItD6+07nInBz1B8GFim33Y9ohyLmKPVd+QK0k/LfUafDrWc4VN/g3cEg9yvvz37
	 c0pz4/mg1Os2u8w9Q6u0OlN7Ko2DGHizoAw/0fZ04JQibWxGYhIfJvPmglkxcl52tF
	 c723m0FfqyZmGyzw1BzswH6wqQi5U7K75yMtg+bkvN8dOSzK6sjbzn9B41zNzxOb/U
	 mxMG1Z879+URw==
Date: Mon, 5 Oct 2026 17:47:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: <sashiko-reviews@lists.linux.dev>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, <bpf@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 1/2] idpf: add flow-based XDP fallback for FWs
 without Tx FIFO support
Message-ID: <20261005174749.0edcc263@kernel.org>
In-Reply-To: <e967306a-0505-4f14-9041-5056d00bd8bb@intel.com>
References: <20260929231305.1515873-1-anthony.l.nguyen@intel.com>
	<20260929231305.1515873-2-anthony.l.nguyen@intel.com>
	<20260930231331.1E2051F000FF@smtp.kernel.org>
	<e967306a-0505-4f14-9041-5056d00bd8bb@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 1 Oct 2026 17:43:50 +0200 Alexander Lobakin wrote:
> > Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> > - [High] idpf: data race on pending_mask and last_ntu in XDP Tx finalize
> > - [High] idpf: out-of-bounds write in idpf_xdpsq_poll_fb due to unvalidated completion tag
> > - [Medium] idpf: mixing goto-based cleanup and __free() in idpf_xdpsqs_get  
> 
> I think this already appeared earlier and I replied to these a while ago?

Please ignore the sashiko.dev reviews at the moment.
netdev isn't even CCed on those :/

Reply to the netdev-ai one, until the systems converge and netdev-ai 
is deprecated. 
