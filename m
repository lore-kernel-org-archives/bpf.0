Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794607780;
	b=mjZmnjCNEDM45qjOj7EEXjfZG+pCDSGv2WymVCq9n2e/cLr6rqrKY/lwp6oCba9+Y73f
	 OSvZmCdVWxIyB70eVrusBNoFsUokvgAl4+KXF47al+v0ghn9+edGCF+8Cwr394JpKWpa2
	 mAiO+5+pA1bsRW4LUgSC8lIYZuTjGyP+5PDgJCdKojzXYxdBRTQ8l9Ru6/r+U2zd2R/J7
	 LfdHcjJlGgT/dWpL6qTigBhmsh95UaiK6jwZKzN/YjjYvsHw9Oxt5+bGvHytxcLrT6HFs
	 BfcHhI9O1guW+aaaPm6CylRpL1454uVf/6in+5glM4I2cciWoeoIhC/PDbz7Exi4obA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794607780;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=PKA+hMV7mnVUr0hIw2tQmBkgxWx2AKfmo6RBkdSQQ1Y=;
	b=aRcV/zoaFCAgtzbDYqYe72yVqEEKpXR0bEtk85+Ni0tUmLAm7ch6vx0KcIx6StxcXqGU
	 ZwtULlUGuoxU6/SSZnVmvA0UeY5GGWnJuO7fQoLz3lW9Jsn7S2KiamJydZ4Ndv3Q4/F0M
	 UkhkdhwEfg0LpUYiDyDLc7vXROi5v6W7QIsc6dBO0ODBv5z906yo4cFWADnCm3kO3Zl+T
	 U6nehX7uNC092J/Ou6iz8se+59f4s08MxHNgDlVdGCth1+N93xBPRgmNzhIARgYpT+h83
	 lPkbViOGZZzi4RChqDVkA48z+2ncO/siH6z1H4pfVhtBlnMXNALb+lOW0lZ0twcRhGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q+EFLJKo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D258606A332
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 22:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q+EFLJKo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCC5E1F000C4;
	Fri, 13 Nov 2026 22:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794607779;
	bh=PKA+hMV7mnVUr0hIw2tQmBkgxWx2AKfmo6RBkdSQQ1Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q+EFLJKonN+uOI1AFgb1qGQQBGWD5Pqy+1w5Zf3u3Srsnj6Tz79sY8BP+EW+AdlB+
	 m74TPa/2LBz6ARENLiKx7vBdFI10MgQJN2FZlwfbghkO/oWvYCSFKMalr82yf66JFH
	 kDG/QQLT8cCu17jDudMO3FI1xwkjHB2fqAl+RU/AgtANNRjZE2oSsWTxjANWgolDmE
	 YdnnGx16cf8q6XL1K2iGsYoGmK7sujPf5+ENJDwcFKqfw5ZXxkjDVjSD9xQ1uIaq8t
	 dyCIo/ML2Si2XDEVv6wvTmEHQLbWOuLdsF2nZICrcaPwGcWf55dxUIME+LRIsy6dJO
	 hKiiviYHc3vYg==
Message-ID: <sashiko-outbox-213775@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 3/6] bpf: Scope the bpf_user_ringbuf_drain()
 dynptr to its callback frame
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261113213921.1646681-4-ihor.solodrai@linux.dev>
References: <20261113213921.1646681-1-ihor.solodrai@linux.dev>
 <20261113213921.1646681-4-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 22:09:39 +0000
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
- [Low] bpf: missing Fixes trailer for commit 205715673844 in commit
  message
--

commit 3259f9f888525f719a6f09fc51c44281ce232398
Author: Ihor Solodrai <ihor.solodrai@linux.dev>

> bpf: Scope the bpf_user_ringbuf_drain() dynptr to its callback frame
>
> The dynptr argument to a bpf_user_ringbuf_drain() callback points to a
> descriptor on the helper's stack. The descriptor and the sample it
> describes are valid only during that callback invocation.
>
> The callback can save the dynptr pointer, a slice, or a clone in the
> caller's frame and use it after the drain returns. An escaped descriptor
> pointer can allow arbitrary kernel read/write once the helper's stack
> is reused.
>
> The verifier assigns the dynptr a type and an id, but does not tie it
> or its descendants to the callback's lifetime.
>
> Give the callback frame an id and make it both the id and the parent_id
> of R1, then invalidate that id and everything derived from it when the
> frame is popped. R1 has to be its own parent: slices take the dynptr's
> id as their parent_id, and bpf_dynptr_data() clobbers R1, so with a
> separate dynptr id nothing would connect a slice to the frame.
>
> Pair the frame id in join_func() like any other id, so joining states
> from different callback frames cannot link a value to the wrong frame.
>
> Reported-by: Nicholas Carlini <npc@anthropic.com>
> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>

[Severity: Low]
As reported by bot+bpf-ci@kernel.org on v1 [1], this fixes a lifetime bug in
set_user_ringbuf_callback_state(). Should the commit message include a Fixes
tag?

  Fixes: 205715673844 ("bpf: Add bpf_user_ringbuf_drain() helper")

[1] https://lore.kernel.org/r/1e8b758af3e2561b6b9d60b87866a3545432da526326c=
1ba303845f9cb1188b7@mail.kernel.org

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113213921.1646=
681-1-ihor.solodrai@linux.dev?part=3D3
