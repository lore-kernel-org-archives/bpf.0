Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795674844;
	b=di63E9wW962GUNKk4Bx0mebzi38OU2lrrhXf5zM+hYktsj3HI9612+3I20f7sPr0EARd
	 k/KCqhLPxQoxrTPdmbB8jVt1OCXxPl+H/ACp7eYhjjMF1kh4I4agoQADM2lCH/KaomSuP
	 I3wfqDIBfd9IgcPvaZOzVmQdpKz4x4F6dCjw28ViJmbxfrZrHJp67v5K96lWic//vEjfb
	 gs4iKmUi44YxpHVFDiFgEnDQUAPRlkZuuKbAfG6Uzz7mZi2H3cGt4FivQ/v65lxLB0tPJ
	 tU+2MF4iaR2f2Zq7LlbVYNRIIfCxJadraQhj/gQNmm6VwdW64gCz3YqGiR52WeSoKvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795674844;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=SpzMlBQ6E0qeoovmK+Ns/SvzV6ItCpXh4pQasNnZw/0=;
	b=TYr8ZTsrRXQ/umLB81iKkQDiMCgqkk+lfk3JsFKC9f4AxxuUeqTTzifgthcVQjGazsCD
	 ZmO4zIMCaJKq6xXAk/6Cv/sGuLAci4kEhOajaU2MkMu3GKR682n9cmk2rVQek+i2QAkip
	 nBA2TSVMcpIzjlbfliT3LwXJLZcZP1ZRE34aKr3Y8gIrrfXvGkSUbbGOi3cQZrET+nGJz
	 t/NCzW2PWky8Fu9WPB+DOw0DlaM/xUgCNRKrHxMBBrrX7vdpagkA3EqagjTXRtoNud+E7
	 5PzvFXY9UQ/01yzcoGioa+fREYMDrHHM/lybeZRACZQOtnUFCDU4Q3E8GGYFl2vI3ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FdIC0Dsl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0346E606A31E;
	Thu, 26 Nov 2026 06:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FdIC0Dsl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E75011F000C0;
	Thu, 26 Nov 2026 06:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795674843;
	bh=SpzMlBQ6E0qeoovmK+Ns/SvzV6ItCpXh4pQasNnZw/0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=FdIC0DslktW3eOK8vnFSfkj7/wW/GOESlp0KIGjikm9I2Cn0fsuWrb5cydRGPIl5h
	 o+eP5RV4JvVzYTM2wmgoYBsGvECa6Dw9wJr+PDRDVZlMsg4VkY/2WBeB6Tb7G9kumZ
	 u7MsRoimnwzzZdS1oo1bFTxRmccsyF3fhT/pbwMSgWtYw23h9BrumDf/bfYQ1cJl3z
	 rT98msGu7IK4IU8P+DLhPUOWTHnReUNUVg83aX06Lq5uR2D3VfACB5P+LiZCTuyTXa
	 E/+kY6YABM58EYuqK0Y6MteG1yZEvZwKTaCzyhBPrlgFiRHkqX1rJo9+Q5EMt/v/rK
	 WYtoybQEkByYw==
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
Subject: Re: [PATCH net v3] xsk: keep the charged page count when pinning a
 umem fails
In-Reply-To: <179562059260.3381969.13546710565371160648@gmail.com>
References: <179562059260.3381969.13546710565371160648@gmail.com>
Date: Thu, 26 Nov 2026 07:33:59 +0100
Message-ID: <87fqwokso8.fsf@all.your.base.are.belong.to.us>
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

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
