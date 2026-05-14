Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D83279355;
	Thu, 14 May 2026 14:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778770506; cv=none; b=Pvzekc43AuXdseLI6IIs1oLwIcwH3P7M1imhhu61tUuvCZDQBs1mnvGCO8+s3W7PjXiKGHrvCOO7Pop4BhTe6mKKOv2vE8744Y51wi+e7U2BeP6QO6ijndUDA25E3TSa+ZmMhWh5+Bst6201gnTSXEeSmEQ5yOBdp3ZbGgOnWCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778770506; c=relaxed/simple;
	bh=KMJYcsDN/ILEdkaCmGhA6PNYrlwot1ntuWO9OSDO7DA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pwgYMyjk2PvtlJfgkCcNq+T6H69ethRMgsw3Ypih8yz2joE7zfEVqIZDLnpHd4GjMuiLGSJNvxVtwbpfI+z4CjgyeyxAt3h39ln3SXdKp32tJdlTMEoX1TRXBdNeUNvK1kCYe3sYKE9jySTsfdXGacSXPwXX29ohAK8kBg5pzHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pgra4TSo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pgra4TSo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB6C8C2BCB3;
	Thu, 14 May 2026 14:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778770506;
	bh=KMJYcsDN/ILEdkaCmGhA6PNYrlwot1ntuWO9OSDO7DA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Pgra4TSokdGc+W7SQbaqjua+3K7zkrw6ofZX1ZLvnjU7VBZs6o8VPGjzcsksnygSr
	 pxVeaK7XAndR5DWcU/xAlNy1W2gMKLmwAWeLbuQjvYU+xABBziiCQ+0vUyb5JOy9cU
	 YJ/vu6j871DYmeVUeI5qGTNto4q1Sfx3XGUGo5peYSdBwAwy4sfO9zj0ib49e8GvMZ
	 ml1uteQNgKeY7KmOIQJMT/hkrL90MKAKwZnNX4K6DDHD7WSpzlWEFStEdHO8JFgGkH
	 YBBKmDzjWKYoaONYnBHQDOKnnlv8sJoNlNYPj6VNne0DxYzuVJBHp84YG/0GJ5YHb5
	 c0Nnsr3iXcGzA==
Date: Thu, 14 May 2026 07:55:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net,
 netdev@vger.kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
 horms@kernel.org, john.fastabend@gmail.com, bpf@vger.kernel.org
Subject: Re: [PATCH net v2 4/4] net: tls: remove bad rollback and UAF on
 ENOSPC
Message-ID: <20260514075504.1790a187@kernel.org>
In-Reply-To: <agXGJ2v-Gnf5trWX@krikkit>
References: <20260511174920.433155-1-kuba@kernel.org>
	<20260511174920.433155-5-kuba@kernel.org>
	<a83d79d1-b932-458a-b5fa-1cb623fa03f1@redhat.com>
	<agXGJ2v-Gnf5trWX@krikkit>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 May 2026 14:55:03 +0200 Sabrina Dubroca wrote:
> > The sashiko report here looks like a pre-existing issue that could be
> > handled separately.

Or not, cause frankly TLS+sockmap feels a bit hopeless at this
stage.

> > Still let me play safe and merge just the 2 first patch in the series.  
> 
> Kind of. We had agreed that #2 could be fixed in a somewhat better
> way.
> 
> @Jakub removal of the content_type chaining can be done in net-next as
> a clean up now I guess

Oh, TBH I also thought you are okay with the patch as posted.
I'll follow up in net-next shortly (once Linus pulls).
