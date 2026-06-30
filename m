Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B56369D7C
	for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 06:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782801982; cv=none; b=dfTc2if1LzKcXJG+6sIIuwYbvCPNDrCWmRwKBu24EhSuKSXlY+aTwYhaIKxPPbAERIC5pq+iJrvTO2cVgWlZ92j8O9yLtxDIF7tdmUhPLoQiMX0FPLiMuY5ZP5MV1ALl8iEH4lqGmyhKGxICoiAaVFYYjej5qb3ai8B63t0OYno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782801982; c=relaxed/simple;
	bh=43aAmcC8a833u877+dsnQX/T6JjTmGvPuhk8kLG9VFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QLyR9hwnhabOgZQaLzRY6zcpao9lpsjewlttxTEgXKuhc/NrzmPaMvPZOWlhoZRmKOpw0MkUxSBsVwkZaRV1D/ahbmm+I3J6X9XBBtsh0TJlQ9m58Z/jdMXFBtnSU0OFzvQXLlDfhSblQQLLWYPulGkc8ic1K7rOT+l9SBSiQFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=dD+0gv6o; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="dD+0gv6o"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 8003227622;
	Tue, 30 Jun 2026 08:46:15 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id exa0CaWBhhSg; Tue, 30 Jun 2026 08:46:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1782801975; bh=43aAmcC8a833u877+dsnQX/T6JjTmGvPuhk8kLG9VFA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=dD+0gv6o/5d2EE0pEEgUf00UEvCsLAwYJWsn9+UfU20BGi/0oV8yUkAt3Wv8JVBvi
	 CFfSpIFJ3OUSC9fXKmha9zrqAKV1fceRcBQE7dfO4WpCiMg5zWaOOFMFVa8DOud4Ai
	 fuwJBTRDHPlzo0K6ITkqN80NzP1LcG+9x9OHAlEIulKi8lEMMu8YZBrx1A5xWySUAP
	 lQLpTGR6Qg6PTeILUuZ8YSRD5P5PxxJRW7NoLcZffy2rO1CHWwp+NamXwqD9UxLHOr
	 O5hbWstVlkUE0F4K+LvVAuzZgG5Fdnif8qQKFEIC+RsR3alIOENKSld1ImGP2Wq6ce
	 Y4msfwBJJa9Dg==
Message-ID: <87da609e-ff8a-4f26-929a-338399f75288@disroot.org>
Date: Tue, 30 Jun 2026 07:46:08 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] libbpf: Add length checks for path parameters before
 memory allocation
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com
References: <20260629122559.3828469-1-maghasi@disroot.org>
 <DJLQR3M9S62V.2FYC7QDSTU3DJ@gmail.com>
Content-Language: en-US
From: Masoud Aghasi <maghasi@disroot.org>
In-Reply-To: <DJLQR3M9S62V.2FYC7QDSTU3DJ@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/06/2026 19:23, Alexei Starovoitov wrote:
> 
> The code is fine as-is. We don't add defensive checks.
> 
> pw-bot: cr

Thanks for the review.

I'm just starting to contribute to libbpf, so I'd like to make sure
I understand the design philosophy correctly.

Is the following understanding correct?

Since the caller and libbpf share the same trust boundary
(same process, same VAS), libbpf generally assumes that API arguments
come from a trusted caller. If an application accepts input from an
untrusted source, it's the application's responsibility to validate
that input before passing it to libbpf.

I'm trying to better understand where libbpf draws the boundary for
input validation when looking for future contribution opportunities.

Thanks!
