Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794616073;
	b=wvNVQAdvUqBIxC7eDIMFAyOWsKrsgKQbJHFbMzbRg5/+UkZdeRzdJydMlk4NEu8GcrQX
	 wS1K63W//RR12MHgV3X7AMpFjKljEDARSHSpxxfiidZnMqpxj8TXjfgK5Vg7MxUExe6uz
	 aMe7cHPzsTxdYkr5xQ+oytnDJdZcOWrew4N4T07E9C1TB3SQZuqbR7IbLXmTxU1bUT1sG
	 W7H0vwC8E6wK0byeLG71MFHb14DuJ5QXoeBGbUMctdPK9eicNPbM1g1755IPsGJ5lC+l/
	 4Tm88xkaB9Wig64XVf7B7WbWBdTh0QQ5WK7Zour40rmKnAo5bi6eo6S+NX+95dn5URg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794616073;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=8VtpjmTn3wqQW8+lQGF/+aFhwtLY/atYEAi4XzigoEU=;
	b=JRF39KsWNqEh/Cw/lG4EpSjZ/LN+jZ0Ku+NezL2+F/mR7SPY2SqbPfzLOpy+6/r85Nsr
	 Rq5g2PpUHMtyUgPhIvyI1krgFwaDRJJaOzHnwEW87xUyw9SNGTu5agfoLcGwgVdX31HwU
	 +09G7WIQLMsSD3CNTV/3PjdcRmfJ7aXLZz0TNCmg6wi+9UuiFJnv/oQjVQ6ZgKzqzV1Z5
	 7dznrb2zn+fmAggk65J/NKNV5mvQ/R5O45zyPTqmjEBbYVqyUzq+CeBC1cjdCCd4NlOd/
	 kQqn6J44ttBIUVm+iAMsHs/rdqRRYFXbrYmjeriB7OrkF1P9KtGTYfHivEIXyx+uKoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O1ZnhA4G;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F274D606A334;
	Sat, 14 Nov 2026 00:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O1ZnhA4G
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C8241F000C7;
	Sat, 14 Nov 2026 00:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794616072;
	bh=8VtpjmTn3wqQW8+lQGF/+aFhwtLY/atYEAi4XzigoEU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=O1ZnhA4Gf6XHFSoVcP2leA2BfRqbuucL65quSHe903vyNZTdDf+UydkrjQLZLNfnb
	 3o4h/0FVyKoxpJGOdOr3B98SZZqWZhoKZXI8E/nKrVfDfADY+OMnw42UAhAUfzfH6i
	 YzGc0KWNe7uDXBNl7Qy/e7iw8Q503jBMqyOfc7n6jOkdtVWj5o43nQx23/IfajRJJl
	 pDsWVk0dnUuGQPyhHyY4/iM8EC5+jM5MLe8yozS6Uvz1h3zsOW4NLeuzwnobZgNrDI
	 l9o7+5vAyYUx9WgahgYtU4/8rJREloEY8CAV8jGigcX/6ljKMa1Rqrrp9kmEa82lTm
	 IWcdv6ZKEaNMQ==
Date: Fri, 13 Nov 2026 16:27:51 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: ast@kernel.org
Cc: Rongguang Wei <clementwei90@163.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, willemdebruijn.kernel@gmail.com, jasowangio@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, Rongguang Wei
 <weirongguang@kylinos.cn>, Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net v10 1/2] tun: keep a kernel copy of the socket
 filter program
Message-ID: <20261113162751.309d3544@kernel.org>
In-Reply-To: <20261109023848.59575-2-clementwei90@163.com>
References: <20261109023848.59575-1-clementwei90@163.com>
	<20261109023848.59575-2-clementwei90@163.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  9 Nov 2026 10:38:47 +0800 Rongguang Wei wrote:
> TUNATTACHFILTER copies only the sock_fprog header, so tun->fprog.filter
> stays a pointer into the address space of the process that issued the
> ioctl. tun_attach() reads it again whenever a queue is attached to the
> persistent device later on.

Alexei, would you mind glancing over this one?
Nothing stands out but the net/core/filter.c changes deserve a BPF ack.
(Or feel free to take it via bpf if you prefer.) 

https://lore.kernel.org/all/20261109023848.59575-2-clementwei90@163.com/
