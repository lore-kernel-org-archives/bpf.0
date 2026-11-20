Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795134108;
	b=AZvidjCPOZz8rsGdDHw4ry3GKHU1x/QaQi8eOLQox3du26Gaf6378c/w9s3HLbGjjvBg
	 0lCok1YOwsyZXMNXFMneQy/9FEED4exRJkyHa05CAED+NrFItyTB2ktDifC6t0dXLwp+y
	 60hrPJSxjFX80OgQA3+aJOMfgnLsYQpvq8EvgZsYuRoyfrNPek5ZG7lkG9NgVV3PzmHRS
	 P2mUuLhV2+ap8bhqwRZOduzi592vhWECt5b1/RW15UuVHm2hgxLL5r1aqeCL+ttHZQCNd
	 MSI3AxY4/V9ysWYENHutpugQP6SnDURPa8nTodrehDTukBSOTEyxmqfv/5X8dXmAf9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795134108;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=XXl5Wks0t1sgJvCYx/Xx2y8xGB7wUJF4ESZfk4A/80A=;
	b=Vew0+o5zfoYNGFCdabP9UbLNSLZSHuA7TvwJkJ9fgDxbw4ZE8b18wghbTsdff2uA5xQm
	 TfFOJkqMpiswfl3uWjag5xWyP6CLw8PGLdMoIIRYGOhFGHuZ3+OrjlF8ymIEUkdPyL3je
	 HDFaI7tfgTsOrtT9ltqiqY1Vi7Nx17WKATqRcc3wC4RI1WcWno9N/59SlEaMlqZRY8sYz
	 jVGh6tjJGgXbJMPmiYqffe0k7zk1aLIEyhrXJN8M5fGUTDzjhciCGTT/TtDgxDnnTPQvq
	 G8xFvxsYBZHWAP4c4yySt/qhIdKpzmGFYEH+AN/FyxoTCBrx1j90VtM1IWPxKUcw6Aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IvCo7sGn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F962606A320;
	Fri, 20 Nov 2026 00:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IvCo7sGn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50D9A1F000C6;
	Fri, 20 Nov 2026 00:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795134107;
	bh=XXl5Wks0t1sgJvCYx/Xx2y8xGB7wUJF4ESZfk4A/80A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=IvCo7sGnvF2S6dANWB/7N+JUxRxhcxtwq0EwK4QkWNXR7e0iJKaM7ycoF4HG6aQLQ
	 plvmUJPs6NEZ3O7jlTpvTxoNZy6MvpPMYNcIQ8btLhQX3f2waSn0Q+iwr5+42lEEEP
	 5REOiyC1uXfotMKlQFXadlqm2e5c3+db0OL+p4/q2I9KbegIFKJedBC9RXMJ2Fjy0K
	 ShMBZSuZEuWukK98HMu1A5PAFSmDXEht6bNeQ4YnOA0T+GMJD1b+axFor+aHAdmHxO
	 nuFzXXN8OgfUWISKNy++/hUB7jBiNYJX/PC0Kf9WbgYFt9RnHjEUgioVVUB2IBUv7S
	 aHzc+lzwN1L6A==
Date: Thu, 19 Nov 2026 16:21:46 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Todd Freed <toddfreed@meta.com>
Cc: <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Daniel Zahka <daniel.zahka@gmail.com>, Willem de
 Bruijn <willemdebruijn.kernel@gmail.com>, Wei Wang <weiwan@google.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Sabrina Dubroca <sd@queasysnail.net>,
 Boris Pismenny <borisp@nvidia.com>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v2 0/3] net: don't redirect decrypted skbs to
 ingress, psp time-wait validator
Message-ID: <20261119162146.28229969@kernel.org>
In-Reply-To: <20261117192411.247117-1-toddfreed@meta.com>
References: <20261117192411.247117-1-toddfreed@meta.com>
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

On Tue, 17 Nov 2026 11:24:08 -0800 Todd Freed wrote:
> The third patch makes psp_twsk_init() give a validator only to the
> time-wait sockets of PSP connections with a Tx key, instead of to every
> TCP time-wait socket. It has no effect today, but the net-next series
> will rely on the presence of the validator to check if the socket has
> an encryption offload.

Ah, I was commenting on v1 yesterday, there was a kernel.org outage
over the weekend so series tracking from last week to this week didn't
work :(

For future reference - there needs to be a path in net that hits the bug
for something to be considered a net-worthy fix. Otherwise no Fixes tag
and to net-next it goes.
