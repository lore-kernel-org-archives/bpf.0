Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC323D413B;
	Mon,  9 Mar 2026 14:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773067657; cv=none; b=AUyslSfNMo3CP3vB+VMp/jPOJoozRsYykY0IQ1p8FZdjxus3A8pWIjWP1MOq110K5m/TmKFV6Rvzg6YpkIu1/AVnCdx9FL/srHnh/0Bd3ixAAMMqw1xh16iwM1uuq1u+v/y6m33Z17mVRud/995d2qSYSz4utC4dO3RdEPpJVEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773067657; c=relaxed/simple;
	bh=sdEHiDK+W/hF4X27J1GHcjyD6Z62npf9pOMCF61r9wU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UOCz5tZIVjwMYwzOtsVDsPDjFoG2y3Es0aexo8R0n4v/jcgmVhEYApEfvy3/zqAGqHRB7O4VOVxVH/YSodsFCe+jradru43o0wrfokoQxDrIfWFtct3L0a6RmT76Rwv0/7NYxAheHTMAn43uo2rIsGdbqkvBvem3KSlGQSvj+8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=Sl1YzcOf; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Sl1YzcOf"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A8E6F40429
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1773067655; bh=d8NcYng2sN1DCPkFUwB5WJS1bDEq2XrCazyT9C9vBP4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Sl1YzcOfy6IL73uEBNtDkTPyUFAK98iwgPRooZHq3RsFukmc11GiGCknTj1Lrmt4f
	 f9THq+IaE0pExHWyuhi/dgPWCXzFV6BGN6292poWML9ZV2DqhibpywWnK6WLSn1Y/k
	 Jd8NSoWzw0mH1IG2YKzSCnpaEg8OrZgu+oYQRazL5qWhznTbXknyLsZBKXaUUw9GwY
	 zZizCN7K3l4kV2BQEfJYnlDpEb9iIM1t7nildsMpQFsg4bJTQV84Wzv6L+sKWWr4jc
	 BQ7tP7hCukuiIcSWhvWcTHNnAqMtGz6q4g9c1bCJ0+ta++orodadWh+gO07KniCsk3
	 gnRZaYazdSkPA==
Received: from localhost (unknown [IPv6:2601:280:4600:27b::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id A8E6F40429;
	Mon,  9 Mar 2026 14:47:35 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Burak Emir <bqe@google.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: Burak Emir <bqe@google.com>, Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong
 Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao
 Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 bpf@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/1] bpf, docs: structured overview of verifier
In-Reply-To: <20260309134630.2638181-1-bqe@google.com>
References: <20260309134630.2638181-1-bqe@google.com>
Date: Mon, 09 Mar 2026 08:47:34 -0600
Message-ID: <87ldg1xdo9.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Burak Emir <bqe@google.com> writes:

> This is an RFC for adding overview documentation for the BPF verifier.
>
> The existing verifier.rst has detail but IMHO it lacks structure and
> background. Here is my humble proposal to make the verifier docs
> more helpful for newcomers.
>
> Finding a balance between overview and detail in documentation is 
> never easy. The idea here is to describe abstract interpretation and have
> enough information that anyone interested can learn what is going on. 
>
> Please let me know what you think. I used Gemini 3 to get a first draft,
> which I then checked word-for-word and reworked.

I only got the cover letter for the second version, so these overall
comments are based on the first.

- Please stick to the 80-column line limit for text material; we want
  people to be able read it.

- Why split this into five different files?  It is not a massive amount
  of material; spreading it out just makes the reader work harder.

- It is overly heavy on the markup.  If nothing else, function
  references should just be function(), without ``literal`` markup; that
  lets the automarkup code do its thing.  Same with "struct foo".

Hopefully the BPF folks can take a more substantive look as well.

jon
