Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794341577;
	b=JPXIt93ZTqtCu13yRzjMycVt3vwWYBYjulpTbp/3hYx/eCBe1EQ1zJG3UcsuMj+UrnvV
	 yIPb4xrl8MqR7PAGn0stuMB4NQFj7bDlAyRqA6fgsB/fljVlctQYy45r8RMVncWsV480v
	 cYZwNMjCmDU16vUiv+z71UE6qHPpy/pJ+2MShSUBcsfLomqxxcOZsIm3D4w39D9bTSF3G
	 grOFSNEFyExmr4EW3JxcTHOttrCFehqsXIoc/l3LgX28sNVWqLAmsvfprBwjeQwNl6D+o
	 ny7ldyg7m2Al3kPat0quXkSTIAA+NeV454VoHqbCLKpXuCYk/RaTPfPyOVFAjrf8Lkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794341577;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=9n69V8b7Pe2NPaZcaKQrwJeF3R2bLATLLqxFGsyCFFI=;
	b=fChT1M8SuWliI2591DqOvMh6hJQT+uMY2tK4s1HehUUn9tEkKjSxZhTIaVauwWRWoDc6
	 971gHCkkakXh8FXrqwQ2Ejcy3qGOsPkHo95FgRIQP437Ke1KG0Po+ub0KkAAof/fsWyEl
	 0HlCu6El96UKWcQtmnTKoFquvE0AgXxa62jG9DxbG0IpperF4vvbJOWKgTKrp9RvxmH+m
	 o9yghwjqRsyYJhx0K5H8dqbnGcfUYQ4u+kpmnzNHGxoVYq6OtDaCEodE1kS1eiT8UgXdR
	 cXRhu+9xJVl1IvKnaSVc8Kv3yExNcSU9PgpvjsCV+GFKGt+ih+TCLDhrkTzyvIL6hQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	arc=none smtp.remote-ip=209.85.208.51
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FFB606A320
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 20:12:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81FFB606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6b429f71dbeso2709677a12.1
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 12:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1794341576; x=1794946376; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9n69V8b7Pe2NPaZcaKQrwJeF3R2bLATLLqxFGsyCFFI=;
        b=NE2PBex7Rs0touJTom+dyOe1TmNsfFoaHxCxKlpOG/+gHzLaP/iKyzTWgd91PFtkB+
         Ojpx36AT+I0a5WgU8/ImXtBkmp7aHrJPjUhHL616LcYqoYlLMcE8IHpHnanZ+a9ev1pn
         0gUK4G2VQU3RGuBdtcWDXKIrreS6hmZiJcoXey94hZjiL2hQPezuA5K5JuS0xaWTKYLT
         Ef8G9QtVX236KIyo3T6J5FAcY6eEtNKuA3L1m23F3i7L/vPLcVMpCYyAwLKpJbgxAh6S
         dkxHZr/4CHG7FsJjqu0CGYDhGLyR6GKrvy9lo7vHlzHTR3DMlc/4NFzM7lfrG9OqfPaL
         ucTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794341576; x=1794946376;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9n69V8b7Pe2NPaZcaKQrwJeF3R2bLATLLqxFGsyCFFI=;
        b=ciaIkw1ZPObeD/6J8S3R3uvwkyJpNnxer05vhti8KPaI1ARObSMZAJV7kxwtA/1bXV
         SA5z0U5smnW7omDM5vuwuNOMzaKCQaV6HAAdyKQZZeWI62loHxIf9G7PzM/lWQiHqeAE
         2SaJlYMKDUH0EVmKHgtJx3uzS/VzE7IRMGkmHaNJ2SfpwJTWy4aFVS5iDaC8c5bkspYT
         9ylM8E+indDG/ycd9sMYL3TWy+9Nu/lUKGWJfqQkjztY+txp2w+ldB3wLfwpOpLfA+Wk
         bET08F5jWZ7eUcU9u7dYJ8DHXI2FzVOg5HHT95B1o3RFMlT9oqeF60sV3u1FRdXMoBP0
         6qig==
X-Forwarded-Encrypted: i=1; AL+hErEA0PUiOLHcd/I2jd1aRxj+uAzktKO1kztllpDlpjbcUD3Uf3R28wHLtooFuWz1Gj0DemQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+eBDBXlStlCDNahOD/uBIpHZyzZ8Z3KUdZv62DNWfR3YczwgPo
	Oy0tJwfK/IpUT48I+yPyfzhXkrMgZqorludOL9qV5lzmsIGNtdTfNCVmijfAuoAgCc8=
X-Gm-Gg: AYBFou38Rv1YGbiLY+RO5UaHV3Ngq9eCI0A6lC8OXnldA/soEPQbZ+x3V/0ustEo7ci
	JcqIgOQZSUkzi4rGSyhdA3FMcYeJjWmJhiG1oKXwmIayJ2gJQqPAD8WwfGvGR8VQFEFZhgBrps0
	TuuXNZavtNylsuryaJCeZEfA1xdQSdy6X8SWYoPw3uz18YUvUW9/8H19aDAdsR+j8JtPVyuYqim
	8jzD7+yJ5fGuXCDhc/p5i4Eq2Kg0C4Bduoo0nDyrta8iK16Q/Nn9I2yuMTX1Fr8vZxViFuvBpVp
	5/nYaBiE4rCfCudEVFgtr5n4UMidP5ssLS01QFSDozV66gpjOqQHvzdcyxJyEQ9AP2+0H9S6DVz
	0UaQw4hT6GBSKKIHBnO/A63lIoeh+H+PVCsnuFLjGqj3WdjHVfeuoQm8Ky53O1wYOde1Ek0SPuW
	r5PAnKaxsLxO5kqmROP0NUWvVzPwc19YlqhugVPPY21HqKc59RGw/5jVhzk2mYDurWp4YnTEl2d
	wlp6EH3QG1h8AWNTHak9BBUKgzGE2fQfNSHKpqOM+jrhjzlsz0NtsYdxeZT5EreMuF31J5d0D/E
	Y9jOmF+GHVzzHmILR7H9k9AbDsg5eZE9RWNTQWyGAA2FiKc=
X-Received: by 2002:a05:6402:1d4b:b0:6b5:8777:bb2 with SMTP id 4fb4d7f45d1cf-6b777347cbbmr302363a12.1.1794341575905;
        Tue, 10 Nov 2026 12:12:55 -0800 (PST)
Received: from L9JK9NPFH9 ([2a09:bac6:37ad:1e5a::306:6])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b757823737sm1592520a12.3.2026.11.10.12.12.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Nov 2026 12:12:54 -0800 (PST)
From: Tianyi Gao <tianyi@cloudflare.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>,
	David Keogh <dkeogh@amazon.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	David Woodhouse <dwmw2@infradead.org>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Nimrod Oren <noren@nvidia.com>,
	Alasdair McWilliam <alasdair@mcwilliam.dev>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Alexei Starovoitov <ast@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Breno Leitao <leitao@debian.org>,
	=?UTF-8?B?QXNiasO4cm4gU2xvdGggVMO4bm5lc2Vu?= <ast@fiberby.net>,
	Danielle Ratson <danieller@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	bpf@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-team@cloudflare.com,
	nh-open-source@amazon.com
Subject: Re: [PATCH net-next 1/8] net: add tx_extra_headroom and LL_ALLOC_SPACE()
Date: Tue, 10 Nov 2026 20:12:50 +0000
Message-ID: <20261110201250.95225-1-tianyi@cloudflare.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <willemdebruijn.kernel.935b9bf7f1a1@gmail.com>
References: <cover.1794020868.git.tianyi@cloudflare.com> <e90e748e0aefa7cbe1c2b31b8c7902ccf135c3f2.1794020868.git.tianyi@cloudflare.com> <willemdebruijn.kernel.1d64e7848503b@gmail.com> <20261107182526.69543-1-tianyi@cloudflare.com> <willemdebruijn.kernel.2c6a653eb65fa@gmail.com> <20261108190831.3f991a13@phoenix.local> <20261109154909.32748-1-tianyi@cloudflare.com> <willemdebruijn.kernel.935b9bf7f1a1@gmail.com>
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
Content-Transfer-Encoding: 8bit

Hi Willem,

On Tue, 10 Nov 2026 11:23:09 -0500, Willem de Bruijn wrote:
> I have some hope that if there is sufficient reason, this backlinking
> to the originating netdev (or socket?) can eventually be addressed as
> well. Rather than work around it.
>
> The skb_orphan and iif issues are well know. But not set in stone.

Thank you for the suggestion. I looked at what backlinking would take.

For the socket, ip_rcv_core() orphans the skb, and after that skb->sk
holds the receiving socket, for tproxy and early demux. Keeping the
sender's socket there would break that assumption.

For the netdev, skb_iif is the last receiving device, not the
allocating one. So keeping the origin needs new state in the skb,
such as an skb extension.

Even with a backlink, the kernel still needs to know when to adjust
tx_extra_headroom of the originating netdev. This brings back
auto-tuning, with the problems from my earlier reply.

Taking a step back, IMHO it is more natural to set the extra headroom
indication on the netdev that the skb is allocated for, than to have
other devices raise it through a backlink, which can get messy.

For v2, I would prefer the narrow VETH_INFO_TX_EXTRA_HEADROOM UAPI,
following what has been done for IFLA_NETKIT_HEADROOM. I will put it
in the last two patches, so the rest of the series can be taken
without it if you prefer.

Thanks,
Tianyi
