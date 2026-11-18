Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.74.67.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795009647;
	b=3W+lS+yw53TTNYDXAvSj1oWUhSN5lQq63XNorjDeEgUy3scKtB9g8dy1JaeDPK2sccTi
	 rNDxlZ7W9WqYizRXYFN283Q1rOUnkxgwdOMiO7Ri1YEL58PgG1MvqGlEQlIERfZz9B5Sm
	 fqEQMnhF3G8VAROHVwE2tKWFG39+kaQxmQGom92rVLMB8bAnC4+zHQd3pUI+y9JQdW21h
	 B2BZrEUd1RJrbyF3Ar3sIlExd9BEXW3GQnXRrmweznv6u1X5X40E7I6q89s0BI3p6fljl
	 FmiuSj+/6UoC4cCHEhNmNuAPjlKMfziQ6WC0K+lmwHLJHRp0KgbZTqxKgPcTHyRULSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795009647;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 DKIM-Signature;
	bh=4/ODT45glGpVts+HhR52SLxZS1RNaASLefRBRlHkmHQ=;
	b=wFfgJNJ3J9OEZZFtbBAX0TPqE5VxMC6YTyYYobQuJoO1zEbwgf8KoXsi426yO7Hff4fJ
	 Xpa15WEZybYW849mkZGL+yzidxI6tqJ6ghJTYJQinjpclfODwookxvPzDJCIEVNL/wVPh
	 NQ5YOKg29buXP5t/PdsJbex3n74+OF9hGLWvSJwfa+HjQ2UK4z4S6dozgbR3NZm06B8aW
	 cZQGv14uIOwWj9rpG9gIgVCAiyYPBcaIHeMCu3QS5v956EFEzW6R+gBZsfDB/eqBFnXtM
	 J0JEcHNTA23n1pb18gOaPSeGKdajIOM/IDB7Lm/BLBtxWe17CeRKkB+avGkuXApa7yQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=poczta.fm;
	spf=pass smtp.mailfrom=poczta.fm;
	dkim=pass header.d=poczta.fm header.i=@poczta.fm header.a=rsa-sha256 header.s=dk header.b=ovf5mrMc;
	arc=none smtp.remote-ip=217.74.67.49
Received: from smtpo49.interia.pl (smtpo49.interia.pl [217.74.67.49])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1A2606A31C
	for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 13:47:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA1A2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=poczta.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=poczta.fm
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=poczta.fm header.i=@poczta.fm header.a=rsa-sha256 header.s=dk header.b=ovf5mrMc
Received: from nr200 (unknown [80.68.231.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by poczta.interia.pl (INTERIA.PL) with ESMTPSA;
	Wed, 18 Nov 2026 14:47:13 +0100 (CET)
Date: Wed, 18 Nov 2026 14:47:11 +0100
From: Slawomir Stepien <sst@poczta.fm>
To: Tianyi Gao <tianyi@cloudflare.com>
Cc: bot+bpf-ci@kernel.org, ast@kernel.org, daniel@iogearbox.net,
	davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
	john.fastabend@gmail.com, sdf@fomichev.me, netdev@vger.kernel.org,
	bpf@vger.kernel.org, magnus.karlsson@intel.com,
	aleksander.lobakin@intel.com, ilias.apalodimas@linaro.org,
	toke@redhat.com, lorenzo@kernel.org, ihor.solodrai@linux.dev,
	tavip@google.com, maciej.fijalkowski@intel.com,
	syzbot+ff145014d6b0ce64a173@syzkaller.appspotmail.com,
	andrii@kernel.org, martin.lau@kernel.org, eddyz87@gmail.com,
	yonghong.song@linux.dev, mason@kernel.org,
	kernel-team@cloudflare.com, tianyi.gao@linux.dev
Subject: Re: [PATCH v6 bpf 1/3] xdp: introduce xdp_convert_skb_to_buff()
Message-ID: <av2sXwW83oI4SLx-@nr200>
References: <20261104121316.1155680-2-sst@poczta.fm>
 <9b616d465e6f88aab813a79cc84c51ed358861e201bfb23921864e62fc9dc023@mail.kernel.org>
 <20261117161602.62553-2-tianyi@cloudflare.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261117161602.62553-2-tianyi@cloudflare.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=poczta.fm; s=dk;
	t=1795009637; bh=4/ODT45glGpVts+HhR52SLxZS1RNaASLefRBRlHkmHQ=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	b=ovf5mrMczfFIQ+lDnzpE8bQrz8XBJef5ryzlnwG1fAYmc07ySkp0VDYFREhWzRuYl
	 SsMyc2AL+WJ7k9HVoA49B4CpVkn+KBcGHAPlLyvAqucb8cUEQXGzfziSKR1CrnA83P
	 yo/qCuUGjvf9r4D7IlWjGVSvdxO8QPGZb/2mi0ck=

On lis 17, 2026 16:16, Tianyi Gao wrote:
> On Wed, Nov 04, 2026 at 12:53:35PM +0000, bot+bpf-ci@kernel.org wrote:
> > Could mem.type be saved and restored around the program run, or could
> > bpf_prog_test_run_xdp() set the mem type it needs (or use its own
> > xdp_rxq_info)?  The later veth commits in this series only touch
> > drivers/net/veth.c and do not address this.
> 
> I think test_run should just use its own copy of the rxq, which is also
> easier to backport.

Ok, I will go with that. Also thanks for the review!

-- 
Slawomir Stepien
