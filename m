Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90FD37BE6E;
	Wed, 20 May 2026 21:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779313260; cv=none; b=biZdKQwSMnO/Fw+zd8zrDZ4AQGdZ3EZM3mKpZ4lV0yqda75DECL5wNxFpY1CYn3eWV2tA8e4I55KIEgnz3P1qoduwir0qo0cfWyegCOTOGC5KSBOqqMARsA7NF+e7g1cAp8toaX5oxgVzubm/CxZG0Enwynrz8UMmrDefBOpf1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779313260; c=relaxed/simple;
	bh=9seufv8THWEq9UNvU+ASZOlTFZquZrw6C9S120RkteY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JAq6r4JuzJQxywDd2FTVM8m+TnHu1xbTFx6ZiehCYpjPl2rVqciaHNjlIF2PGfaUiFxeUVbcslAexC842a+8boExs9987yEHOFrFThqo5xtwu5dt6pn5/VnOVJEZO0l+87ENCHd4iXDpY4dt8E1rFeYN5eBngbquAteaWOA4vw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+iesas8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+iesas8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B20FF1F000E9;
	Wed, 20 May 2026 21:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779313259;
	bh=9seufv8THWEq9UNvU+ASZOlTFZquZrw6C9S120RkteY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=B+iesas8QX+kIgYNx+Tpxs3Y673kLpk/MCWZ28sAZ8zD4J4PnlQbdVu4WXM9Y4W5J
	 CzXuFmhuaK634Bykf8jk9uukTaxkwujGAt4ISz305TDe/9epyQvub5UgT76bYXADNH
	 Dl82oZnChNciS3cgO5FCwTtkTpVRIvU+gdJrMy0Lsv5EXcmiLMlRiUowiJ2J+8qk0n
	 QL6fTHogsrH9QJJQCcBugpuYlTG3D2I1PZYdz/eEoaIZxiSkC/sqIOR1SF58AJog4Z
	 F4zlbvVt4livETcXv9pOhN+zeFSDT1heFmkCJVn7FDJl9mhSgyjiKCa0slNgUONeBw
	 fHr/ew0ElIu4g==
Date: Wed, 20 May 2026 14:40:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Neil Spring <ntspring@meta.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, ncardwell@google.com,
 kuniyu@google.com, davem@davemloft.net, dsahern@kernel.org,
 pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, bpf@vger.kernel.org, martin.lau@linux.dev,
 daniel@iogearbox.net
Subject: Re: [PATCH net-next v7 0/2] tcp: rehash onto different local ECMP
 path on retransmit timeout
Message-ID: <20260520144057.1ab0e15e@kernel.org>
In-Reply-To: <20260520064310.4154268-1-ntspring@meta.com>
References: <20260520064310.4154268-1-ntspring@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 May 2026 23:43:08 -0700 Neil Spring wrote:
> - Check post-rebuild busywait return status to avoid silent false pass

still flakes:

https://netdev-ctrl.bots.linux.dev/logs/vmksft/net/results/655182/43-ecmp-rehash-sh/stdout
