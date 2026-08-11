Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F69439E177;
	Tue, 11 Aug 2026 11:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786447958; cv=none; b=PpJZhsRqhHeg3FCZLL3zXqCtpYBDBQFYNbcbY0lvBehenGh4e4I3AXIIBcAR/wPgWw1dUSOywIKQYWnffPiwi2h2thW0LwtPqmpqgmB2SSTKCrqQCZJloQkM+4DGcU3XINFpzGDbWSQyMEHktgvmmHD1ztwvbiSfa/Jf44310qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786447958; c=relaxed/simple;
	bh=Q/2PNw3k54G7yhnzeN8GwfxpaM2vg4FzqoSxER1+j8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZMUIXtH3v1qzGghUBwD3W07CXz6YQSA2B54+GSYqHlcro0FdPoKVPnj3va1Fj9ehn3suhyIER3b3GDQfNZNmCv10gXuHKoziv31+The6OkbraxLcZFQUKIg9+Oi/+W4oCvAbVZDhlryPcnnuwqnPt54fNV0xhCqkRz+0V+ETwFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FtZ0oRpT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FtZ0oRpT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C891B1F000E9;
	Tue, 11 Aug 2026 11:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786447957;
	bh=X0GaSqrZjtJqni0HehADXGcZDJyuXMD/e6cLg2mh/9A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FtZ0oRpTL48XZfZhHGIv1UGjYWqM7t8ZFXbwi+t04l/Ngs9bTm4Sce5R5RXkFBzxf
	 NGjiSH1xC3S+505KU0Rj/TaF3P/YYKWJL+kr4PEYTcCiy3XujX8IzNEC7I5oXMad1r
	 Dzemzunpf9jz4kg4Ju5iNHtrEYQpxZvWlL8e3LBzPvS2xyWIIR3c2msUbt3lhQgM7n
	 YslsI0550zUp9fsfdb5NU5WVuPP0Ce+3e9u3QjgkMnoHPuQ13s9Tl1AI5UN+Gvescz
	 GY2r8XSrgQNyegodcJ4PH7oV53TUBp8xPvuLWY0hv9Y6zMc0TabXOrzPh20scRZvBD
	 sYdV8sWKbX2zA==
Date: Tue, 11 Aug 2026 12:32:31 +0100
From: Will Deacon <will@kernel.org>
To: Vladimir Murzin <vladimir.murzin@arm.com>
Cc: Breno Leitao <leitao@debian.org>, Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, rmikey@meta.com, kernel-team@meta.com,
	Ada Couprie Diaz <ada.coupriediaz@arm.com>
Subject: Re: [PATCH RFC] arm64: entry: PSTATE_I_SET is leaking on pseudo NMI
 mode
Message-ID: <ansIT2PCHq_EKuTE@willie-the-truck>
References: <20260807-arm64_fix-v1-1-d069ccf9d71b@debian.org>
 <anXkO8YpoadRzm07@J2N7QTR9R3>
 <anXqMsJ14r3BAbMG@gmail.com>
 <anYHjvJ1_4dDjuzw@gmail.com>
 <anm5T9FazACqOWXF@willie-the-truck>
 <2a97f777-d33a-4b3d-8c8c-6f6894f04c29@arm.com>
 <annoxlkkq1NpujsP@willie-the-truck>
 <9b06f274-8db1-48e4-839e-e387c050d328@arm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b06f274-8db1-48e4-839e-e387c050d328@arm.com>

On Mon, Aug 10, 2026 at 05:39:52PM +0100, Vladimir Murzin wrote:
> On 8/10/26 16:05, Will Deacon wrote:
>  > So we could probably hack something as you suggest, but maybe the best
> > option is to take patches 8 and 9 from your FEAT_NMI series? WDYT?
> > 
> 
> Whatever you prefer, tbh :)
> 
> Patch 9 codifies my understanding of how things are expected to
> work. That said, I accept that I could be missing something, hence the
> RFC tag.

Those two look fine to me and I already took the preceding changes.

> In case you decide to take it, we probably need to:
> 
> - extend the commit message to cover Breno's report (right now, the
>   commit message makes it look like a refactoring)
> 
> - add Fixes tags if we want it to be backported
> 
> Alternatively, I can respin the patch separately with the suggestions
> above applied - just let me know ;)

Lemme have a go at picking them up... I'll yell if it all goes horribly
wrong!

Will
