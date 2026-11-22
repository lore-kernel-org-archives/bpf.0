Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795372090;
	b=nFHLjLJ+EPAD0MbW/9d9X6/IBzBuqqTbyK5tzgbTIXrseh9cGlsAFzgFYrj56/Kuqkid
	 0UVHkTORk8ehe69/wCub7AygJTm5egMp2kWVBG+UTtsZhOyZadlFRnuo0YbBz4gfD+4rA
	 kQFNrB0I/6LcRpToCbaz6R1Wvbs9Kj9y1plZAV0+hy4TmR6CGXqkK1l1c+z8WP96lXueO
	 75YS5fT+VRK1Uvzd8ax9O01plKwu5XT4+PjOFR2LMMYTji3NTCkm+CNgIkiP1EMEEzdXh
	 MbFIbAlXrcDYuyJqiDUbw4HbEOgO10vXiHeK0PKlYbUH023DupyctJPHUq1HHI0t7fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795372090;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=GJsMjlQ3nUUhcoFT6m9wk8JiZI2pddu/XM5lEPyVZVc=;
	b=n7ugcxUsh2CntrzKHvdxvxwwtQjKPj16eQqinZEsgrCufXkgRWNQCdygbFVWAPSJF+Hf
	 PuksgEuyXscwHrGrv3GoMAqOu6W1rXY3rOopCQRw0u5gItyFR9bypMAzMUTUen/phjptA
	 eqofRJgRWP2eNGCZQVhhmxQMDNe0sn6xeILIYN1H8UC2hqLACYRRoagP1M3kijumXO+S6
	 2bNvuF0gncs4jtFKLLIrmGHiyDvg9YtUi/qjLvXOJ7sTrytSpN/81m/A3WDfFsU9rhh8K
	 5oLzlz81n5qNvaHxz1JJ44WjZx2Vu2D0qnyrMmBVrrzjwggr/HgYGJyf79q02lSr3NA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fqYIrXVj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4BB606A320
	for <bpf@vger.kernel.org>; Sun, 22 Nov 2026 18:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fqYIrXVj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E227B1F000C6;
	Sun, 22 Nov 2026 18:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795372090;
	bh=GJsMjlQ3nUUhcoFT6m9wk8JiZI2pddu/XM5lEPyVZVc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fqYIrXVjS0Ti/iWxcNAZWb+4yw8MunhcpPmnHEuwgPOCbDyLcAqZip2hCJr7KhUEO
	 IWtKbHi6NdvJ4ZYa9pYosqgQdJkx6r9saDBHKERUT4UjN9rEN3vMX4LKW9Wy+M42Vs
	 df/KblEMKCio0lrAYVEasMCR2LwjfL7ndtDMKMx7I0alWXgzHuVa3zgPYm/FpRBlyM
	 jPzdbnPGk754tEgrlKlKZ0EjBaPKRConuBwUjaYoobtIRdGU7Md7d8DT8+DLIoRwB7
	 GOTo1I/TiXCtA+7fL5c2IqEzd+t5cfazCwgNg+GCiDAwYme4y32h9BPp7YcixNJWeu
	 x937pyhg2s/0g==
Message-ID: <sashiko-outbox-228180@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v5 2/3] selftests: net: veth: propagate
 channel-check failures to exit status
Reply-To: sashiko-reviews@lists.linux.dev
To: "Omokefe Emmanuel Onanaroghene" <emmaonana18@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261121182217.4609-3-emmaonana18@gmail.com>
References: <20261121182217.4609-1-emmaonana18@gmail.com>
 <20261121182217.4609-3-emmaonana18@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 22 Nov 2026 18:28:09 +0000
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
- [Low] selftests: net: veth: missing Fixes trailer for chk_channels()
  fix
--

commit 5d20ccb90ecdb7366b108efa1d9fec12aee9201e
Author: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>

> selftests: net: veth: propagate channel-check failures to exit status
>
> chk_channels() reports mismatches with a "fail" line but never sets
> ret, so the script exits 0 even when channel counts are wrong. Every
> other check helper in the file (__chk_flag, chk_xdp_feature, chk_gro)
> sets ret=3D1 on failure, and all chk_channels() call sites expect the
> check to pass. Set ret=3D1 on mismatch.
>
> Tested-by: Tianyi Gao <tianyi@cloudflare.com>
> Signed-off-by: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>

[Severity: Low]
This fixes a bug in chk_channels() where channel count mismatches did not
cause the script to fail.  Should this include a Fixes tag?

  Fixes: 1ec2230fc721 ("selftests: net: veth: add tests for set_channel")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261121182217.4609=
-1-emmaonana18@gmail.com?part=3D2
