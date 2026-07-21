Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A7D4E3776;
	Tue, 21 Jul 2026 15:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784647287; cv=none; b=dl4KDArV95cmyZ2HBeFVzkLunQnoF2vE5IkcrTdRC5bagqTugPiC0Fh7G5LVsu59jvwCN5N2X4dll7QsazCfEkHb8iNKO7VXbNHFe43afy/EW/iVk59h5wwnCFerNTUo/MHL9BIytKpRVJSEJJT09sb9aNlUJAre8gXk7czH3b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784647287; c=relaxed/simple;
	bh=0Rmf+N0EMTdVuCGky14drmy18+nU8XenOdS3gncIz9k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tYTgAfgHJXZfEl1OC+hOJOammW9CFhtV5kloxdKpfWmr6KJCHYHxZa/F0w0kumuc9nIwZaVqs7sF8M7Nn3f9BeJFalgHdQKoWyFXIoWKWzFQ62C1IZb24nOLZZ8F3+w3ud1hOQAA4LJRG3yqaWW4kkZtb744AW9cJgX9tfLRZWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bxDS6E/t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bxDS6E/t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A72C21F00A3A;
	Tue, 21 Jul 2026 15:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784647285;
	bh=0Rmf+N0EMTdVuCGky14drmy18+nU8XenOdS3gncIz9k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bxDS6E/thFmxdUIU38K1fepDyvUlwG5v6zo1cHmc84NV4hPg9pG3ccERxRa2mfTbA
	 vvsX3tbh3TkNuXol0mkQvMH/48ozCWlQX0YRrdhvMWVNNibQVv0caGvLjnCBRTaeia
	 YKyQuWmmQbwuGi7hwaOZu8KVmzu3jnU44HYEjOvCsV+wNeX8mWnuuVjFkLPObT0Dzm
	 zFVsbKD+iv0DDMf4xP6f8bdFBxqSIbt81d0i/TGMlPoYviUenDEW96/p+aBSr1gaq8
	 84fBp8eb7+nSREO6ipgIpjVGZX17dOe4eLBd62mJEzqGuEDZCCjk/Y8Am/N7Unh8ka
	 +ObJa4D4fLZyg==
Date: Tue, 21 Jul 2026 08:21:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Donald Hunter <donald.hunter@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard
 Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP
 Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Jonathan Corbet <corbet@lwn.net>, Shuah
 Khan <skhan@linuxfoundation.org>, Kumar Kartikeya Dwivedi
 <memxor@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, Vladimir Vdovin
 <deliran@verdict.gg>, Jakub Sitnicki <jakub@cloudflare.com>,
 netdev@vger.kernel.org, bpf@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-kselftest@vger.kernel.org,
 linux-doc@vger.kernel.org, Aleksandr Loktionov
 <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH bpf-next v5 1/8] netlink: specs: add XDP RX checksum
 capability to XDP metadata specs
Message-ID: <20260721082124.0f44f8e9@kernel.org>
In-Reply-To: <20260715-bpf-xdp-meta-rxcksum-v5-1-623d5c0d0ab7@kernel.org>
References: <20260715-bpf-xdp-meta-rxcksum-v5-0-623d5c0d0ab7@kernel.org>
	<20260715-bpf-xdp-meta-rxcksum-v5-1-623d5c0d0ab7@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Jul 2026 23:39:41 +0200 Lorenzo Bianconi wrote:
> + * In case of success, ``cksum`` contains the checksum value calculated by the
> + * NIC. ``cksum`` is valid only if ``XDP_CHECKSUM_COMPLETE`` is set in
> + * ``ip_summed``. ``cksum_level`` contains the checksum level reported by the
> + * hw. ``cksum_level`` can be considered valid only if
> + * ``XDP_CHECKSUM_UNNECESSARY`` is set in ``ip_summed``.

nit: cksum -> csum like the rest of the networking stack
