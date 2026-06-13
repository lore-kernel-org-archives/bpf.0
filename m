Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D477F1EE7C6;
	Sat, 13 Jun 2026 17:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781373457; cv=none; b=CWK+QJ0j6cuvySJyaczGY3r0WYNTftCHNTbdKG9XLNjIvUNr9iAcLOeA7bHOIpCBzp4yEqD0q4JdbhkvjL6Fc8Pw1zTipHGcMC6OAFNgoD5CRM6nNlPB26MsgzFJemj+BQSPykVDviMYZbkjo9P3y3wZGsBcV3uAm7+AfGGikQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781373457; c=relaxed/simple;
	bh=0I3ayv6ho7ohDsu86MiInZfnNSI36midO4rP1U2RRFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pync1FiX8m7k7syQRwCqjdZYoYBah16ZoB1zQibqSjQE6ff76u3XknWxlCmQwA8kmnLRUpa0pj2wRbmAypu10FQ8XPbTMxEPj3EQMI2NIaCNQMukT/N9wkjTQmR61+dkEBEVpLlRhFkftGOIeCkv4EdRmguBGm1xetdSTOjm95o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/qMNSnh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/qMNSnh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 212F41F000E9;
	Sat, 13 Jun 2026 17:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781373456;
	bh=BUkI9enXuk0j6Qx21MiFpOjmemi5aUpGoG7sEJMhKYA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=J/qMNSnhSN6gIJDL4xadpy+V2774Tz3PqKZwY5facwaJZEb6I/0hu9HQjARW7BT4m
	 evnnqnF3EHQek1O3uEK7VbOTnEdQHTk8IH3ulcRBuOcKwNDF1DZxxQ2u0QZAfr+g0C
	 gQkHtqjbhoW3Rg3LJn1Z9Quv9GzIT7/1A6OeKyoJ7SHC4Wle+8GaiJpER549jFD90k
	 EYAis9jmh6Q/LqRF6vZF6SM1C6d4uds1YOzMlIQ/lBW8hwTg8xBf+qNmKDbXaI7TiN
	 n4bLrpY7v131GFX4EP1D8x7nRFaQ3+ldnEPmg6GhLYCW+mRRLMjn2A9rYDbTR8viWB
	 YKoTKKYzncJ4w==
Date: Sat, 13 Jun 2026 10:57:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, Network Development
 <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>, Jiayuan
 Chen <jiayuan.chen@linux.dev>, Hemanth Malla <hemanthmalla@gmail.com>,
 zijianzhang@bytedance.com
Subject: Re: [RFC PATCH bpf-next 0/5] tcp: opportunistic loopback splice for
 BPF-paired sockets
Message-ID: <20260613105730.0ca1ca07@kernel.org>
In-Reply-To: <CAADnVQ+KTNKkf_Tc-RZR-g8wEfJU4qWcOPnjDbA2=PEtZsYnYg@mail.gmail.com>
References: <20260612011452.134466-1-xiyou.wangcong@gmail.com>
	<CAADnVQ+KTNKkf_Tc-RZR-g8wEfJU4qWcOPnjDbA2=PEtZsYnYg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Jun 2026 09:01:43 -0700 Alexei Starovoitov wrote:
> Just saying that the code is free nowadays, so whether it's 1k lines
> or 10 lines is irrelevant for the discussion.
> 
> As far as the idea goes, I think, it would be interesting in pre-AI era,
> but today splice and friends are a prime target for bugs and more bugs.
> skmsg and tcp_bpf are reeling from unfixed bugs too,
> so my take is that we should not add any new features to skmsg
> and instead deprecate what is already there.

100% agreed. There are so many unfixed skmsg bugs it's hard to know
were to start :( Kernel "intelligence" to help unoptimized applications
is particularly unappealing right now.
