Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795095689;
	b=MPeWhwoLAxwk6Cxlzv9jy1flDVoXe/cP3GHvd+xVkrqqe7I5cOhXcpseED2xSv6Ls87r
	 SeoVnfB7ssOLSxxjR908Pzw5sLP/uOjFUSCqDnejWt9FI8ojcj1pRlGUEXckzUrMF9mXr
	 yOfCiRtIoYQK0hYmbKhWOWQsWUaj1G9v5/SgTfpjVUpWrkJIRk0mEySwqx1N6e/g8uLwV
	 JKdWdZcnnYr5eeTVvuvqJPDpvooSA4dUtcE7LvzJdnjYkcsriIrENqf3TRNbzKKrR9WkC
	 Bg/rCJx+/Hy8hord9/kIrTeGYxKyo8DgMJ0H930UmlHao6blp2EmCanR5P1Kw4iHwbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795095689;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qWaF1wwrrhfwXNZkQZccmQCxjUs2HYMsXlKamfsz4Jw=;
	b=Q40sE1XFScIuvAoI5CwbA9umBDji1AlYQgVowfzePTdkThF1GhqJaHUpimK4XzVZC2KC
	 LQQWY5VgrOjTMNVGh968pAUzQlEfheBJgJGwMb05m6PsYarph90P/H9+7x/LmyPixqZ14
	 zJuGw5uxOwL6WNR7qMhXEttvtEr1LuUmq1eo0dirxuFQXQCwfsypF/LmGSaoeceiSsAF7
	 FWXtC0jVi6qnhaERXMlfc1Y2OfnddjN4dIhrL//I0hFA7pBs2fhGtseQdVYGZW/bMJLXk
	 xYFpga47QFxJIV1JNF/V0kTJuvhRd78rto2utNg5WO7SAlqKg5f9ScZxWvNXbL6sImw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fdzUoj5B;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF8560A2600
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 13:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fdzUoj5B
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CC0B1F000C5;
	Thu, 19 Nov 2026 13:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795095689;
	bh=qWaF1wwrrhfwXNZkQZccmQCxjUs2HYMsXlKamfsz4Jw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fdzUoj5BwfMCtJUs9s8jXf/lQkaFjZBemSbOkIeh9wNFFlME9eTgF9Uclueb14YJI
	 0+HzUF4wGS7cPhtL2zFE58b35g4RXPblglYuqS5TB60J6HluqRxDRL6eQgnLEATCBq
	 TMQeKAlVZ3klui7VQSSHUu+zYOPiJMjRy8m1SVuW47iip3WdQOrnGb59ALj5u4oyga
	 IEb9edAa8QtED6yvyGx4EIyLBZxWldcgqHlghFkfSzsbGk7MzhNRcufANjIPGt3Vv1
	 usHdENXBIfsEKHfZpxhyNl1qBM6WQyMMNMJ8YeWWuw+kgPl2/u9xkcQMxE17/okqEK
	 hRTCrS4rn2r8A==
Message-ID: <sashiko-outbox-223190@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 bpf 2/5] xdp: introduce xdp_convert_skb_to_buff()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Slawomir Stepien" <sst@poczta.fm>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261119133032.2015656-3-sst@poczta.fm>
References: <20261119133032.2015656-1-sst@poczta.fm>
 <20261119133032.2015656-3-sst@poczta.fm>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 13:41:28 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] xdp: malformed Signed-off-by trailers with trailing comments
--

commit b52c8a4a1dfa14f2b9eeae449bd2e813e860af3a
Author: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

xdp: introduce xdp_convert_skb_to_buff()

This commit factors out xdp_buff initialization from
bpf_prog_run_generic_xdp() into xdp_convert_skb_to_buff() and sets
MEM_TYPE_PAGE_POOL on the attached xdp_rxq_info so fragments released by
bpf_xdp_adjust_tail() are recycled properly.

[Severity: High]
In the commit message trailer block, the Signed-off-by trailers for
Octavian Purdila and Maciej Fijalkowski have trailing hash comments
appended after the closing angle bracket of the email address. Per
Documentation/process/submitting-patches.rst, Signed-off-by lines must end
at the closing > of the email address; any contributor attribution notes
should be moved into a separate bracketed [name: description] block.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119133032.2015=
656-1-sst@poczta.fm?part=3D2
