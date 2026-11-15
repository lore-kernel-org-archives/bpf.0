Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794777876;
	b=hfQagbqbCEB1VfIVGdtlaH6YPKxm1b+pWn2dkAeDccj/S5TNGh9wvOhX2PoMbE1D6zeo
	 fTrctKNsGfd7qqM2RJaaU5M6ty+oG0AAtO5rMNxA4/YunN1BUbvTxhmtR9BjewYQN2n4U
	 nme1s5VaukmpTfLxEkpjE41yP5R+y6dFzVDzHYlfehw/e28cEwGM+GTm5VkVIYv2+lWN7
	 7z7fmLxsGznvzW7cgRrwoyDnWdB0ks67zu54ion0kpi0wnnW9hIBQ+lz4GCg3yIZjQUwT
	 qBKVLcDnE5u21gjS0OcN3Rd7977OM3rZktMI6b4hRFWkn9POS9QA5XJQUZMPChpcFuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794777876;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Tr4JIVBIs6R4qvQuN47WhJxqRDHa2hGqQFg+35xwdKY=;
	b=YsyynPM52fDmxvNrjLQOvXtZpaNWGYdprdViLzq0Z7bnxBlhSqfrah0FnXTDpgykQ/b/
	 kA0sOAxCKqncY9NIdt0FPQWM2kFAXe9Ud30rKq/EpA4Cr2qgBmc92MTo4YNBKR6h6sOoX
	 2iPziDrpFKe61StM/9FHadqC71augvCp3eIW/b+mozpsKmbj6EcLTsNBcoX0nHo9qO2DC
	 currCnFSTINWQ84cxvvSSzG3y5J/epi3r6eRWRJ6jOjlSLmSrOPtUB3m+woldBPuVbFdD
	 pQINNlxdSl1a9gusa0yMqcalkM1prXoT2ZZD/6jcXwSU3i+5Ghw/O6YN+N/q5CaPHDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jfNCPiGp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A333D606A323
	for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 21:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jfNCPiGp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EB7B1F000C4;
	Sun, 15 Nov 2026 21:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794777876;
	bh=Tr4JIVBIs6R4qvQuN47WhJxqRDHa2hGqQFg+35xwdKY=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=jfNCPiGpcfGRgUIE6rxKxq0hqvx/rP1ipNYqU8P0Na10tk+f64eryH6QsWX6YbVh0
	 v08yn/91MCh8NIaiLCz2oorH3iLjWQxldw408ATuDPp3Xguq+cOlGfT9jPTtEZOaCm
	 Y6mJmmltrmVA5pWyhUwIdIWW+aeTjAaFqNX8E0TJfTRnIq0x6FsNQlRrV8nQGoLKj4
	 IAWv02aH/kN8ZrbIWIRf5LiTZoHmuFz1zmwgctT+qRwxo4tRKzANQbq/xFYFGC6HVr
	 zmYanbUWcQgy1M1pJEPpm0anRgjve7wO2C5nDAaReP3wCla9xUgQ2yNQdjQf0WWHuc
	 Y5jDDNAlPoa+g==
Message-ID: <sashiko-outbox-215866@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] selftests: net: veth: propagate channel-check failures
 to exit status
Reply-To: sashiko-reviews@lists.linux.dev
To: "Omokefe Emmanuel Onanaroghene" <emmaonana18@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261115212117.48496-1-emmaonana18@gmail.com>
References: <20261115212117.48496-1-emmaonana18@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 21:24:35 +0000
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
- [Low] selftests: net: veth: wrong Fixes trailer for chk_channels() fix
--

commit f30572a6b8a908de83aa08afbd2a257c0b17b275
Author: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>

> selftests: net: veth: propagate channel-check failures to exit status
>
> chk_channels() reports mismatches with a "fail" line but never sets
> ret, so the script exits 0 even when channel counts are wrong. Every
> other check helper in the file (__chk_flag, chk_xdp_feature, chk_gro)
> sets ret=3D1 on failure, and all chk_channels() call sites expect the
> check to pass. Set ret=3D1 on mismatch.
>
> Fixes: c017800af5c71 ("selftests: net: veth: test peer ndo-xmit after GRO=
 toggle while down")
> Signed-off-by: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>

[Severity: Low]
Commit c017800af5c7 ("selftests: net: veth: test peer ndo-xmit after GRO
toggle while down") added chk_xdp_feature() above chk_channels() without
touching chk_channels().  chk_channels() and its failure branch omitting
ret=3D1 were introduced by commit 1ec2230fc721 ("selftests: net: veth: add
tests for set_channel"), so the Fixes tag should be:

  Fixes: 1ec2230fc721 ("selftests: net: veth: add tests for set_channel")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115212117.4849=
6-1-emmaonana18@gmail.com?part=3D1
