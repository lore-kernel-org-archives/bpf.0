Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE7B4F4738;
	Fri, 25 Sep 2026 23:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790377896; cv=none; b=gnBRcBLffGlMrirzHXa/u6bLczIo39qvpQEfv0WUYdJAskt9RYcNTRA5/5/n1+G8kjhDcqNDadQb+VVXWnvOhZRiCYKupdzx5InsTS5u0FMJ+esHHkbl+rpDeiKxmtm+79gT8ZGmA/+ZWRIp2WEhjKLZR1sHU1TofqhLrurSeCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790377896; c=relaxed/simple;
	bh=3L5YxB1KNMl6l+E8XSFgntfd4Cnewve3498oUNHM27w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FIAwFhVzEh5AS7sI3juU3pt2tQpk6lrp+hfbbyrxtnas7Lq5RGemN7IFa4JyOJND+KfLfZop6mLFy8ukHY2uznwah01RK9LtbSgzzu4UcxwiwFqaz/I7/oLKXJn6RV6hJg+SG86iWfWWN2+uD+0oLaoY4QpeeDNa4hNXiJQWOwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e2v8WnTr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e2v8WnTr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FA151F000FF;
	Fri, 25 Sep 2026 23:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790377895;
	bh=3L5YxB1KNMl6l+E8XSFgntfd4Cnewve3498oUNHM27w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=e2v8WnTrsYm++f/SvzS95tYXUFoUAZVS780dok9X6WLHa4AvmLmmQ8wFDDIeyk6A1
	 j1BfpqfizipjJSdypEj1SsGMxb/eBvrnb/05tFzXM+RJDXNC/x1VTo29bkyQk98Vs/
	 sROwGBRxpvEGYJdsKoVlTZG89taontXHZlosxdWuZ5X3+v/y3wtS/7K1bBXLA8oG4B
	 UqtwTsQ9AkDYQE/g2Qk5bsz9nd6SfKBOkAYEv2l0f+SOM8QUqkljNicEDH10mRPwfr
	 LZxPShle7rxlA4ZIKGCihV2Gp0YiPxHVm6ZOCItgCyLx2vdb7LMwGO+8wwwVp+9SRM
	 5773io3l+VQYA==
Date: Fri, 25 Sep 2026 16:11:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bochao Cao via B4 Relay <devnull+bochaolucky.gmail.com@kernel.org>
Cc: bochaolucky@gmail.com, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Andrii
 Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Ihor
 Solodrai <ihor.solodrai@linux.dev>, Kumar Kartikeya Dwivedi
 <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa
 <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan
 <shuah@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Alexis
 =?UTF-8?B?TG90aG9yw6k=?= <alexis.lothore@bootlin.com>, Lorenzo Bianconi
 <lorenzo@kernel.org>, Tiezhu Yang <tiozhang@didiglobal.com>,
 netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 0/2] selftests: Fix and migrate XDP feature
 test
Message-ID: <20260925161133.3545f2be@kernel.org>
In-Reply-To: <20260921-xdp-features-v4-send-v4-0-a0d4ec392cb7@gmail.com>
References: <20260921-xdp-features-v4-send-v4-0-a0d4ec392cb7@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Sep 2026 14:00:03 +0800 Bochao Cao via B4 Relay wrote:
> Subject: [PATCH net-next v4 0/2] selftests: Fix and migrate XDP feature test

There seems to be a conflict with recent changes to net-next
please respin
