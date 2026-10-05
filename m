Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69ED3E2AA1;
	Mon,  5 Oct 2026 22:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791239630; cv=none; b=T/uRtskU0aaNcKnGtYMVxRzsP87AsmFVKUwnvqIrFB6oM3CtSWpHF3iQklTPC7hI1SnPx+hZKsMGaN3CSlqQj6LM0BLSpc0zCpOWuiELyh4qkLLPh0kdrHJCZCghb98XprCUmgoiJPxJLNskf3SyBgmXNTCMjBdSYoBlZDKrQZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791239630; c=relaxed/simple;
	bh=0kL8Vh4E+juT7ScMvIpklpL9LSaiU+rUZmDpmoZYRJM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pm9W9WPAFCUrgs6tcBNq6+y8LGtiWfobSsMNf9lFkv+fzK/2d1wIPs53bSV0xbLrX3vl97IYMF0dAOBmBWqQfQAAZsSPg/AUuazaZmuOlSf8Ha747P0wwZvfryJ1G3z/mVYMyz3tTR57QrFsO6PacV4fkqTHtSsEocPfYVBVSAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EckUN3nf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EckUN3nf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98BA31F00893;
	Mon,  5 Oct 2026 22:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791239629;
	bh=1+DPFiDx4yjAUzMGMTDvokXXMAJ+mgfDdOJZn2DO5mM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=EckUN3nfP7TySa0kzXu590ANgnHoeqjJdXDie2DlMjZRLkwkv/BCQcChtMWszwRc+
	 cY5iuLO0ZAjtHa8YbW/cnlSxieqehAsVW4kVHV86pDwlvDGfjFkmX3sKR3AoxTZQR9
	 9mu13fZV3ONNqYZ0i4wACe+zmxw7JwnxhM2ZxQ4VOyQyapgpzpggZP7NmJsQ2spXFX
	 3rnYI519zFlNXYJXjz/ktf3sYDy5zotrecLRVgKcczcbo4RPQ3l2PNIbMLu363ByAV
	 5x7yXG+jkq1MoHGGHvV5HaPEOiPHtlhMrsufw6H6j9sfi3c/zzZc1mMG/yBEm3sQ18
	 rYpoaFSv6uKzQ==
Date: Mon, 5 Oct 2026 15:33:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <hangbin.liu@linux.dev>
Cc: sashiko-reviews@lists.linux.dev, bpf@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/6] tools: ynl: convert enum selector to
 string for sub-message parsing
Message-ID: <20261005153348.02d269e9@kernel.org>
In-Reply-To: <asCfefn6IADLNDtD@fedora>
References: <20260930-ynl_rt_encap-v3-0-4106c21b9ee7@kylinos.cn>
	<20260930-ynl_rt_encap-v3-2-4106c21b9ee7@kylinos.cn>
	<20261001015134.963061F00898@smtp.kernel.org>
	<asCfefn6IADLNDtD@fedora>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 3 Oct 2026 14:23:53 +0800 Hangbin Liu wrote:
> > [Severity: High]
> > Does returning 0 here abort the entire parsing loop?
> > 
> > If a generated YNL parser encounters an unrecognized sub-message enum
> > selector (for example, sent by a newer kernel), it looks like `return 0;`
> > executes directly inside the attribute loop of the parsing function.
> > 
> > This would silently abort processing the remainder of the Netlink message and
> > drop all trailing attributes without returning an error. Is it possible to
> > skip the attribute and continue parsing instead?  
> 
> OK, I will use continue then.

Ehm, probably do something like:

  return ynl_submsg_failed(yarg, self.name, "enum-lookup-failed")

? AFAICT if string lookup fails we'd error out.
