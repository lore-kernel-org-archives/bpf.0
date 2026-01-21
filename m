Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19004314D07;
	Wed, 21 Jan 2026 01:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768960279; cv=none; b=I5tR7a/zRSQSpDt/abgBkOjHSzcl4/JiDTaQVtpsEhC5lvf3JXGDR5TThMYxNdQmNOmyN5c6juTbg2xbWsha4AmSOWbxgDymIxF0JgpVMioLuHayUna19n+YOw0a4abEwv4il6eyjrWLCNDnxL0eINXrfhr3CKtCf6l43SnC1j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768960279; c=relaxed/simple;
	bh=PB1H58Qq1yo/KEkWLRv6MeXZ/f+uBAcJMyU4xF+GYjM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dy6MaXkrTikHkLC9pan2flIFnZBuFq+juFGo5zDTQy9W6c3oan06if0+9c7zbgE6J8yD2jk2pdOnjrJaEAKd9WIQh3ifU7NyJmR1M6b9xw2mQ8s4hpxQsbbw/lrgg9PF0pxteBO6lXKbcDjvS2xFZuIXDUJ0DdDPlSDoELvIVDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WJnXrHkq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJnXrHkq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96D65C16AAE;
	Wed, 21 Jan 2026 01:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768960277;
	bh=PB1H58Qq1yo/KEkWLRv6MeXZ/f+uBAcJMyU4xF+GYjM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WJnXrHkqjwsosPA2uE2fv0k+yp8vJT4A8sL5wmrftuY670Teg9a05LYvcCKG4+HXy
	 FkwC7FVjIfTbfgjaCl0pePQf97x2FnCGXCdeFa3FKxTQED8gJB0ovcnRjcT6bNcUGy
	 PBLf4Tv6xso+Jc6e0hOtOgHAzg9G03fNeaXNRlOVMRL+jXOESRC81PBC4GfRQI3okU
	 4qiA31iRk+LjjCuz/xrjMDYkSWn03JHYQWrA+35N7jDZWNwtwX7oYHhm4I2siMNjNd
	 xHhZmxdp9RY/fye1ecriCjZrcLrcS1t4CLfNO1YQfYYXj7dsMVpNTnnla+8lb+7FDH
	 a84tX/rQImDjg==
Date: Tue, 20 Jan 2026 17:51:15 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 razor@blackwall.org, pabeni@redhat.com, willemb@google.com,
 sdf@fomichev.me, john.fastabend@gmail.com, martin.lau@kernel.org,
 jordan@jrife.io, maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
 dw@davidwei.uk, toke@redhat.com, yangzhenze@bytedance.com,
 wangdongdong.6@bytedance.com
Subject: Re: [PATCH net-next v7 15/16] selftests/net: Make NetDrvContEnv
 support queue leasing
Message-ID: <20260120175115.12c9735f@kernel.org>
In-Reply-To: <20260115082603.219152-16-daniel@iogearbox.net>
References: <20260115082603.219152-1-daniel@iogearbox.net>
	<20260115082603.219152-16-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Jan 2026 09:26:02 +0100 Daniel Borkmann wrote:
> +    def _lease_queues(self):
> +        channels = self.ethnl.channels_get({'header': {'dev-index': self.ifindex}})
> +        channels = channels['combined-count']
> +        if channels < 2:
> +            raise KsftSkipEx('Test requires NETIF with at least 2 combined channels')
> +
> +        rings = self.ethnl.rings_get({'header': {'dev-index': self.ifindex}})
> +        self._rx_rings = rings['rx']
> +        self._hds_thresh = rings.get('hds-thresh', 0)
> +        self.ethnl.rings_set({'header': {'dev-index': self.ifindex},
> +                            'tcp-data-split': 'enabled',
> +                            'hds-thresh': 0,
> +                            'rx': 64})
> +        self.src_queue = channels - 1
> +        bind_result = self.netdevnl.queue_create(
> +            {
> +                "ifindex": self.nk_guest_ifindex,
> +                "type": "rx",
> +                "lease": {
> +                    "ifindex": self.ifindex,
> +                    "queue": {"id": self.src_queue, "type": "rx"},
> +                },
> +            }
> +        )
> +        self.nk_queue = bind_result['id']
> +        self._leased = True

No frameworks, please, this belongs in the test itself.
