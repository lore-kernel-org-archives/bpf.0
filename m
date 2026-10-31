Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793471620;
	b=OVjsBgmzgOb70EutCKKfLnyYh0tUInflfiy7HJq3rIAxiaQSRru00gYQlovZfUzC8yiN
	 m6Oi3meH3Jd3o6Y4L11gBUzGb/Y6jrqxhIueVV4+yEIMkszO9++VMd/hRP8yTGEP8s5B5
	 FG3ZiBcEdXHStco3oXNtwLH3iWs1kJ0g4juu+9kjVYmHHKebTag1EftVF17NYMhkLBkrd
	 8Y26iBJ88AbCDcX3a5YwOU47Tm4MVPcjsXMXisavdSjgFyZQFKRNQza4J6pjb7X1VmhXH
	 8+XD7U8Svu3ujxjjIOXCAVgNOCIC63IggqSXD65WHMqW5oKMIKygjT1FspADvlJuH8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793471620;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=gUXelQFoAaI5jynLT5aPVvI7AsH4CRynYyPjzWgjXdA=;
	b=AyOiORPFu1UanZs1PynYYB50J7By5PKvVGGX03610g041uQJi5eCY/600Ry0cm1N+by4
	 tvHz66mdz99YXDT0DCCMdANc28XyJFKrqyp7gJ0id7ELjKixhqUqCBxQQ5nBxt4kf6LjC
	 DUG4860d81PKygXIscH3tBIghtAJ7Ln4xnr2UuR/2nozUHeTX7iSDRi4VEItRjlLRjOWv
	 lF0Jb9n0+djc97DJ10KcuCdTO3XL9DKZtdLU6KE/vNED8tftup1/sOiSF/I9oE79PhWJ0
	 63yQjDZlUjDdOo0id95DhF6o+yTxOArC0xAxwF2nOK4ZktN4sFfVwPulzDhVGOHIEmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="FQmseRQ/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC9E606A31A;
	Sat, 31 Oct 2026 18:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FQmseRQ/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E11DC1F000C1;
	Sat, 31 Oct 2026 18:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793471619;
	bh=gUXelQFoAaI5jynLT5aPVvI7AsH4CRynYyPjzWgjXdA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FQmseRQ/55r3aD8bUbHhXMhbIjAQq301If/WSd9+dxS25rJJw3yGCnUKDAEEaIE7x
	 0eGFWM1fbfy0gYJ0MtZFIqaDeXGXq9ELbUgIRFD5Rv8TdSJvukY2HmH+VNpHwjheLH
	 wyCOo3mcHHIuDcZENu/bK79hgDW+V339LQLmmPLOyAn6lYY1U8wh7IzS+/OPmn4KsT
	 J0VPbuwnt4KfRC8pzR6s91z3MgWMoxaBNR5POfn/kKCwlxPUnZl52Ds8mJb8K1g0Zk
	 imDcyyerGXwK4F4Hax745BrGejU7lYPt+MOanBPUeFuhQgXj3p0TZhyK+InZS6lTDI
	 4EyWW2Xj6KYag==
Date: Sat, 31 Oct 2026 18:33:34 +0000
From: Simon Horman <horms@kernel.org>
To: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net] eth: fbnic: Report the logical RX queue to XDP
Message-ID: <20261031183334.GX257209@horms.kernel.org>
References: <20261030141452.1173282-1-bjorn@kernel.org>
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
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261030141452.1173282-1-bjorn@kernel.org>

On Fri, Oct 30, 2026 at 03:14:50PM +0100, Björn Töpel wrote:
> fbnic reports queue 0 to XDP on all RX queues. The XDP RX queue is
> registered with the header buffer queue index, which is always 0,
> instead of the completion queue index, which is the netdev queue id.
> 
> Any XDP program that reads rx_queue_index gets 0 on every queue, so a
> program that uses the queue id uses the wrong queue. AF_XDP has the
> same problem: XSKMAP finds the wrong socket, and redirect to a socket
> on another queue fails.
> 
> Triggered on fbnic hardware (50G, firmware 25.08.05-004) with AF_XDP
> zero-copy: sockets on queues other than 0 got no packets. With this
> fix, a socket on queue 43, and sockets on four queues at once, get
> their packets. On the QEMU model with two queues, a kprobe shows 0 and
> 0 before the fix, and 0 and 1 after it.
> 
> Fixes: 894d4a4ea6cb ("eth: fbnic: move xdp_rxq_info_reg() to resource alloc")
> Signed-off-by: Björn Töpel <bjorn@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>

