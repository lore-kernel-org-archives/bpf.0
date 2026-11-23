Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795458053;
	b=dWYziEVxS16GB54s+YgivIPuwjL4iojrebRgVdyzP6vX2gqTrjdV748EXtCy3szLV6j5
	 bfW71O3cHSrFWAhBf/Cw2tXfZwVtHwy9/Fo3fptbQiUcc/IP3h5XmdS3gIBFTBcei0K64
	 7ZpM9Qbxo5S36Hf6xulGR0/8aQ5Vh7oUzAwc6R1CB9oZ2Bdv1Aw2mXknO3BLWHVnMscSd
	 zCKzhd89G7LCxtRziY5DXbUiKDDF2sJ3jB1pkhq1iVlDwxQQRxOLTBimaZjWNjevi56fB
	 eZFDufVli2PkdCNmBk6aupVY+WlcKUHJHwcOn3jw4D8ki/IefDiGx/qfesCV4rDyH8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795458053;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=SYRtQaK9bBhPzxGCpD6OlN2FA/DLdvIovLXNdKDkqAU=;
	b=fStQxzllieatQIAbmcKGBa1ZEiZ0wPRZBxmSRDMT0rX02K+4Qn64m1saknZgrsAdOMiQ
	 TQok/HYTGWVjItIYEb2s5gezOrqDahz5iFAP/wQ5IeIs0RUIdzTlb5NIPFqAr+FlCwEAX
	 fTgSCuM9KynUzM1mdmzybD5dJ0O+bralXnN59FLYisQ/tINGbDjZ4HapZ3TOYYrry9VOO
	 zL88GVu8NaQjjQ85a2G6doT0cUv2CGd1HogMjgFBhQockZW9asKO9M+P59+1+c+aQ9mtx
	 g4fyYOU/U6Z3nAGA2imKi+MLZ3dDmwQ3P6FsVfnBCP2d7yloKIChNuLd2rU/YaXMq6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SjCQaFgT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6C2606A32E;
	Mon, 23 Nov 2026 18:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SjCQaFgT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 255EC1F000C6;
	Mon, 23 Nov 2026 18:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795458053;
	bh=SYRtQaK9bBhPzxGCpD6OlN2FA/DLdvIovLXNdKDkqAU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SjCQaFgTP82giEwzzRMCNkCKr1aBuGc55jIzcXhhf6L2LHdB3bycCzFw/6VSOosCo
	 8lMHNZ0FDAhSKCjIN081TsjiVg5q6x540scSa/1KRCy0jin9IUbMmB77b4tq4oWVSS
	 SO6LYSWR/LTaiaBff/ln4BwltXdC/OMVGl4lMt2qCcLZCeOXYxaQ+Qc+HVpBYo9bCj
	 iFFzF51j3DjiWM6dRf28k108y+s41ZDYRyWiA2Ar+/mABpD1ToyWTkYQ1oYXFN9DcY
	 6JGQ+MLRoy+KuJCZjoPbwUy2NZ89HcXtbngE0NwHSSIlOOcdLFdshMFrfKyD6gMgrn
	 x21LP9Q21GvUA==
From: "Harry Yoo (Meta)" <harry@kernel.org>
To: Vlastimil Babka <vbabka@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hao Li <hao.li@linux.dev>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: kernel-team@meta.com,
	linux-mm@kvack.org,
	loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm/slub: Genericize x86-specific cmpxchg16b comment
Date: Mon, 23 Nov 2026 18:20:48 +0000
Message-ID: <179545803368.3865273.2843095802985514919.b4-ty@b4>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261111011108.29311-1-yangtiezhu@loongson.cn>
References: <20261111011108.29311-1-yangtiezhu@loongson.cn>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 11 Nov 2026 09:11:08 +0800, Tiezhu Yang wrote:
> In __kmalloc_nolock_noprof(), update the comment from x86-specific
> "cmpxchg16b" to generic "double-width atomic cmpxchg".

Applied to mm/slab.git for-next, thanks!

[1/1] mm/slub: Genericize x86-specific cmpxchg16b comment
      commit: edfe1515dd356af6f6d7b124cbf90ae79cb6b9f7

-- 
Cheers,
Harry / Hyeonggon

