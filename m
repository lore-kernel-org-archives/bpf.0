Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795608634;
	b=IT4J060VruZdnyjAK7mD7pn0pXRnPQR/JEK2z1cJyQTH6+To4gSY6Csmi/UYv4k5VCPi
	 +1bOnAhRHmFOwzSbZUceb82qB26qMmhCxuktUQtuzPQ9NRHzOXVm37+Z4a6V9bfFhL+6a
	 thlvwDMqW+ynDfyMS67+oXaV2LNqh7pPeIZq3itGH05EFwKXvfuEdLpcaQhQ40hO/3d7c
	 V+gYH6KR6D8h5z1ejL9ZEi2nReNaZmGt8oAA4twIcPmPcPbDQeVYGaUjtm6MbOkn05FCs
	 Mig925XPfzuNb0vuacYY8f67xTfCMgQ9v5HJia5zt0hVTnan1Z/vqmJCEFQd9t9XQCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795608634;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=lwSVIkf4H5DLmHZtAVdmdeInMPNEa97LYtHNs6tNosc=;
	b=GnLBw7BRWSNNhyisu9VDYxrt3lBYeEijeSuaZ9n09K85Hr7VrYs9Wvnr+lANjoaN32QC
	 2OFyTCfmM8BCDtYaIL3wHGXDl4XDM8PBEO3Ah9JHAn7FrwnpcxRnmwp83vWOt+A44nKog
	 /TGq/tQOefazh9rzR6eHJgL97ooLjZN/Q7anJ6IK6RCoajDhy7wopY0eNwuJAIpcdRqs1
	 6AI75fiYtI0M9g8wUdPmlpws31fGOdm7Ec4paQAbC8MaDq/FkcWKunlvQY6gibRYgf/DZ
	 e5DWksuTg2wDR2ZpN5c7XRjqKmY5Lt+2KLSJPXo3LRdpQCQVPw3y633N4GcmVw1k+xQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zvtvl9bg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867FA606A321;
	Wed, 25 Nov 2026 12:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zvtvl9bg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F3701F000CA;
	Wed, 25 Nov 2026 12:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795608634;
	bh=lwSVIkf4H5DLmHZtAVdmdeInMPNEa97LYtHNs6tNosc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=Zvtvl9bgrWc8ubcSi6DKWZ980FQrQMLOyDC8fjuSOaa8vFx2sWdZDNsxmsk4ufmTt
	 bqaY1kiN0Xzbi59rROhKsCAT03CHk5IrJLeZuyWMRn9lS68gl7dcG0PjfNQwE8KGDx
	 A/NzKx9wIddutlkFkTVVGJBBO+x/l0rGUma2ob7ajknXwhhvK3Zfe7rhTeUSP2sGD3
	 Na254HfDnwACCz95R+RDmaHc785HiG9xfxOn80BVCkvuHyRsXvsYOBKYhc898dXuAh
	 /iM18DYBVjkKh6osIjPJ9Fnh/HpX+Xmh/2hILRcMYGQ9eUt9nzMHEsk9nOBSxKVfI7
	 RlrjJzZlUrPkg==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Kyuwon Cho <kyuwoncho18@gmail.com>, Magnus Karlsson
 <magnus.karlsson@intel.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn
 <willemb@google.com>, Simon Horman <horms@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard
 Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net v2] xsk: keep the charged page count when pinning a
 umem fails
In-Reply-To: <179556786851.2007362.7849536379916971930@gmail.com>
References: <179556786851.2007362.7849536379916971930@gmail.com>
Date: Wed, 25 Nov 2026 13:10:30 +0100
Message-ID: <87zeuxnmbt.fsf@all.your.base.are.belong.to.us>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Kyuwon Cho <kyuwoncho18@gmail.com> writes:

> xdp_umem_reg() charges umem->npgs pages to the user's locked_vm before
> it pins the umem. When pin_user_pages() pins fewer pages than asked,
> xdp_umem_pin_pages() overwrites umem->npgs with the pinned count so that
> xdp_umem_unpin_pages() releases only those, and xdp_umem_unaccount_pages()
> then gives back only that many. The rest of the charge is never returned.
>
> A short pin happens when the tail of the umem area is not mapped. With
> RLIMIT_MEMLOCK at 16 pages, three registrations of an 8-page area whose
> last 4 pages are unmapped leave the user able to register only 4 pages,
> for as long as the user has a process running.
>
> Unpin the pinned pages directly and leave umem->npgs as charged.
>
> Fixes: c0c77d8fb787 ("xsk: add user memory registration support sockopt")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/20260421172951.A7052C2BCB5@smtp.kerne=
l.org/
> Signed-off-by: Kyuwon Cho <kyuwoncho18@gmail.com>

Nice catch!

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
