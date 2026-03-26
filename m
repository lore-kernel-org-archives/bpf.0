Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4704730B52A;
	Thu, 26 Mar 2026 18:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774548836; cv=none; b=AyKndWhL1KDE2ys/ZXxKIf1lBt+UJ+DB5N1gIPjHjiV0EEUZYoRj6Vb2DgrardPs3Ipx17vvmAu3mHy5ITobgpVDHoH1jiDL3y15bkQ1llfVN07TXUd21duqfrYSeHKa6cMnbp1QRjQYyEn3c4+wh14BDc8Mi68wm9gzncsLX/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774548836; c=relaxed/simple;
	bh=zWQctcShB2sKYdh6duA/6NGVzeNPvumaZlYU3M7XPHo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KumF+cg5oWmAO1tWsZmq0gRW8cWayxiYY5A/H8qISZANpsa7+2BJqrmCmed7vUMEgbXTuofge/R9A/IHWvGpDkxWXVoDTFlxLLMM3w0+/Abg+TKdU/X2zU2TmtqHc6jnCpe6G2f3xqP8cn3bsD48pKiNjdRqpiQDDy40eWUpMtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IOiU72bp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IOiU72bp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77F80C116C6;
	Thu, 26 Mar 2026 18:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774548836;
	bh=zWQctcShB2sKYdh6duA/6NGVzeNPvumaZlYU3M7XPHo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=IOiU72bpzBtvIWFfxWeRkwTxjoGe7ydIyKpdvlRKlE4wIy4jpmjl57qSoq0c6kM9c
	 6vniMYcCulA04YzKM9y2PDZ2bw/MCVT61JpAApQx+/mi4KTgRrHnqcMTKq+zLsPG0Q
	 0zQ7E07EGsefCQX21KOYKosrry14xwZmyHZ9t+jv6HNMyLpCv8ULyWhq6bCZhkHA4R
	 +ZiSKypYOhRB1eK+sBxeL/rmmEHrbDiEzs7G6CjB1yeo6aAVBscqvaVcMCJ0QqUvav
	 tMcW7osym0LONC4iOw/lX+B/RFjgXmMNeK6vr7+HiHG5uAg+YW6VOlYzMMLC2bR/N6
	 VXvo65h4jsnLg==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, magnus.karlsson@intel.com, stfomichev@gmail.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 larysa.zaremba@intel.com, aleksander.lobakin@intel.com, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>
Subject: Re: [PATCH v4 net 03/11] xsk: fix XDP_UMEM_SG_FLAG issues
In-Reply-To: <20260326114919.519456-4-maciej.fijalkowski@intel.com>
References: <20260326114919.519456-1-maciej.fijalkowski@intel.com>
 <20260326114919.519456-4-maciej.fijalkowski@intel.com>
Date: Thu, 26 Mar 2026 19:13:52 +0100
Message-ID: <87fr5mcvbz.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:

> Currently xp_assign_dev_shared() is missing XDP_USE_SG being propagated
> to flags so set it in order to preserve mtu check that is supposed to be
> done only when no multi-buffer setup is in picture.
>
> Also, this flag has the same value as XDP_UMEM_TX_SW_CSUM so we could
> get unexpected SG setups for software Tx checksums. Since csum flag is
> UAPI, modify value of XDP_UMEM_SG_FLAG.
>
> Fixes: d609f3d228a8 ("xsk: add multi-buffer support for sockets sharing u=
mem")
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
