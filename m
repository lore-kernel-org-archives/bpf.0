Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2E346AA6D;
	Tue, 21 Jul 2026 15:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784648101; cv=none; b=fmXTvr9h772YxbQ7x9Fi4MxMSEvcIb6EhcfzorrgnNwXw3KH6NGoJANBfxXT5g6aBzOyEkapuwkkCXONAYI74HKZxOAj4D9cRuEzuMb/ExjcZV77oC/aUvLg29BBXGAi3by/OH4g7FpC5I89hgNwM6A7zXzgFpErGE0U7kCHQOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784648101; c=relaxed/simple;
	bh=AzqjSW3858tq31XA/Jc7TUxhwaJDeANuhlFlXLrfm9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BdXe8TS+ZcjzD7e4vDeEICPs8s1gXLJhrqsV53YskiEuXsPg2s5y2rZt1TzKv6OnW49vRwPKQgs9gnmZj7eiaa9/KCICvLY58TAyxbdlJ3K9pW4Wti5eMrHsqhDTVg3XhswJamvb4dHifqTBw750Bv79hxc+ufDwZj/GlLl2xck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rywuf+5B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rywuf+5B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD2751F00A3A;
	Tue, 21 Jul 2026 15:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784648100;
	bh=AzqjSW3858tq31XA/Jc7TUxhwaJDeANuhlFlXLrfm9E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Rywuf+5BCmTcd/KzSNyJY8q3Y8THq41liamdnKxONUiq3us+g+U37LQFSLFjY5HBM
	 L518a0Jkq8C7v2zK2mzFchgxNuffgI5cYCeUkpX7rQ1iulQtyE2upCJ8QpE/5EDeM8
	 We+cBFA9n5YURAXUIBO8UJgq6VVYAJr6s5RkeQJkkkAIA0Y52sDY14/A1HtNQkYqY3
	 vSsdhI2BzwePiKAFG7IJvqQG16Z0oOMZOtZS9v3z0Y4uBsvyiDMdoQFDf4YqnAz4zS
	 ckOkCULG0UPQ52F2+HlF+wEDcbdfOrxn4bHa17u1tbBbJJJARo+sMGhrYTh6t/9rHL
	 cGLSLbaRcl3AQ==
Date: Tue, 21 Jul 2026 17:34:57 +0200
From: Christian Brauner <brauner@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH v2 13/21] selftests/exec: test the transparent
 binfmt_misc mode
Message-ID: <20260721-studien-wovon-abgaben-3ef4f4e1fb3d@brauner>
References: <20260721-work-bpf-binfmt_misc-ptinterp-v2-0-e57866e4ae0f@kernel.org>
 <20260721-work-bpf-binfmt_misc-ptinterp-v2-13-e57866e4ae0f@kernel.org>
 <20260721142517.2C6C21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260721142517.2C6C21F000E9@smtp.kernel.org>

On Tue, Jul 21, 2026 at 02:25:16PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [High] Insecure usage of predictable `/tmp` files without `O_EXCL` enables Local Privilege Escalation via arbitrary file truncation and TOCTOU race condition.
> - [Medium] Continuing execution after stat/fstat failure leads to uninitialized memory read.
> - [Medium] Stack-based buffer overflow in the test interpreter when copying environment variables.

This is a selftest, not the actual code. It doesn't have to defend
against obvious abuse.
