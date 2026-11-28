Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795878428;
	b=tb/h9yjbSMG0zB3DvOtyWDStGdkLyZXmj0SEaO3rTGkwl1KksREy56Y5NZGma8e30nUl
	 QkQqnftGLEjN7ytw2U4GqfD1aTlmuMlJR/GiMHBdeD/T0bDGMwSxHUrQrzTMEHH5GH0oN
	 IiUEPC3hGZgTMt9xppWVRKnTOC2TueLWCrSa/5S3IrPC1mdzVjgM3sZOIGeEG46lsBmhV
	 EqlGrD6Esblbn7yDOW+QmKgXCbGW789IEZSyLm8ZEeuVl1+dD7jSjhvDM3S4iL+KwuM6T
	 KZhxD4oryX39fXSNKejpmsDZ6CMul2cc8BtX3d19GRabc+K1/nZpjIPSmXvIkmy8nsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795878428;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ClVtae2khtb19o1Dql7h8VoV1Wj0/r3koaDJkVoEQdU=;
	b=HV7umcEePLTdrooVoXn12ewI9Aff8WsSpUmjHWKEm1lx3fFSoxfcOQ6+/Oaited0fjf2
	 FzGOy1JhedOO3xSzvEBwhz/L6CmcT9k1LjoTCqX9Jlih+5O1yEfstMYDS8D7GHKDdE3jS
	 rUScp5tw7cG67V2DZ4V3wUc5lGSxO9RTlXW92iq69lOBakwQw51S711u+ROOhVU4ZU7FU
	 +sS6wKzAUcr3x+IHtTQO3mSi9FYBNHXkCJHNhpDF49EDv0zrhHk9I1MpZi8nno7Twdcsq
	 Lm/Ah1Z2f4Ys5iKTqgu5ceO+CtR52LCfdYRGx3rGgihxA1Yv/R7lUkKeCOSGBuxw6Tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bairaktaris.de;
	spf=pass smtp.mailfrom=bairaktaris.de;
	dkim=pass header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=aDiuxX8W;
	arc=none smtp.remote-ip=209.85.218.41
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B56606A323
	for <bpf@vger.kernel.org>; Sat, 28 Nov 2026 15:07:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7B56606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=aDiuxX8W
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c51d016c75dso291116566b.1
        for <bpf@vger.kernel.org>; Sat, 28 Nov 2026 07:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1795878426; x=1796483226; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ClVtae2khtb19o1Dql7h8VoV1Wj0/r3koaDJkVoEQdU=;
        b=aDiuxX8W2+gteVCIUPG/FgvvNkM7Mmoj0rNnHSgJohxEqQJzvIbLfTx0PT3mHW/Y25
         TGN/ChZmozRhlPn+B7zhaDuFTbXHvKf42CD6eJwr6loO/mR7PdYlwhxM993dIbsHCZBq
         kdwmOqCAmLxRKMLOsaMEio51Dne5WhDXBU4hIKxLXALE0iajF2wAnqTIKZRppecVMIZA
         hk3hpnONDCMiDFfVrV5ikOyIAdz7LZ9HerEyq2PLh2/814ahKeRlAns1VJKX8cJVZtoJ
         pv1RtKe0VPbq46RR18/HFS16DxTZrxjXRXxKz9cqwX2Se56qKRqwk8Bj4kPX14r8cDt1
         LWOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795878426; x=1796483226;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ClVtae2khtb19o1Dql7h8VoV1Wj0/r3koaDJkVoEQdU=;
        b=yMwSLDb5PgYSx9pLZ3RxEXYpR2J8WqrViKUpfuRiAhab9QwmqnhPHVNTRSwgj7UfHu
         N/FYi1wEZDJjaVgC3Z2VXv4ZD/S9nZXhZalVWaw/hPKSS4iNHQsPa4mLnHlr9kmAlt0P
         QAWxoYsrEJoHUviNvngDai1YtnJlxTOeHMbI8u+S25yn15tIx4JEVzvCR5wRTTZqHZS8
         UrZBQiOGCwOUFOJ7N/KQisklviQWbKU2APnyGLSUpT66SamSSxWq+kY9fqV1UOss3ygz
         Lsi+TZErYRzndYzE5OZgj3FkGtOHH6LkLpFe3YyY/icpTATF7TOkfWCNBhmK7B3FVx70
         tKfg==
X-Forwarded-Encrypted: i=1; AL+hErHrUdp3daBr/GyC0dNXVILgPutFrpehmIW3SBKWMBu66RTh7fppV8BDH8W+iltYIyCg0d8=@vger.kernel.org
X-Gm-Message-State: APuU4Z98PesHboXcEeJj4o9HdOx50+6x78Ufji6XmsHVeF0e0i4Jrjsv
	MMd62yif08elaNwlHyU7d/qaPuDP96wjDpeQ+2swQMMIDvducWbiaP4oneV2B5GDiQ==
X-Gm-Gg: AZFdTZdQtwt/n5zloneQQrBHfpTfqE9VlbSRqoE6ev2eRoJN6unIofVFDIzgG+M8mlX
	e0WhFwTVxL7MMhLtnV38NP1Vk8SDXAzGPOeB6JXbL9SDKeKhK/7CIlDUIReOF28Ilb3eCJ0yBwF
	IK0A0+370IvEoHtruBq7eVW4j03QLAm4LuRLso588d3tSCCF9JkRtIdjsGroPeM3E8ZrzWpg773
	3E6VY5cFdD9rrK+G5xNKzRgVE2Kl7r7JUEvAdf2jIA0+OF/D0boQ7At8qz6A2nelBMeD60UA84D
	gqb161Yn8n5485L9ExmQ8gw8jX5VvF5ZQB7JkrpSaO/HH4r/jL47n1+Mu2ez+tpezAMFyI+RFew
	cqoatAEg8ubdMPEFZsB4YyJ6jph+3PxKLi+QQ0V81uh2FOc/QdSkEwJPziKkzgQtAmNHvS3LMNt
	UbM9Ty4ncnC0YS4m+WyvXWE2synk9VMYjf0mhyN61VMNYYe5Mifp6RNEr1rsLn4stokGzgFGZDu
	0edOJ4IUiifKMtTfq419MxdPtYhsQjnIr9D8Sray0pgliTgKgKl51zNFY2eqEf1PLzveY5WWNdj
	9wrKq6uTHF0tVOjZq6uUsKEsmiDtAZA7VnHf5U94FxAaXk8I76SwoFxKjmnX3WEXlRXR32WK9H4
	on9fSHO8ikooSdGok2n6cw6qTqPySf7YovmNagDX4EiXswjBKzBqBvzDXeOSoejBSWmf62OZUCx
	ZIMNCUcGsPEZOyTIKr2JGQrXdbFd5ZcJ2/yvFBrVu7H/pMOn85qG5ixj5UljbRVXWiESuZTU8me
	y5r2IPnVkbnTZ62ClXNtVqAQAhsVQyHqV48LxbZqEQKwhyEIBUTG0P2B4qIgRYCSMMkl9SegKTA
	nBJg/wTClTTaMQ==
X-Received: by 2002:a17:906:f8d2:b0:c50:bf14:8eb1 with SMTP id a640c23a62f3a-c513a84d84emr1751678766b.14.1795878426093;
        Sat, 28 Nov 2026 07:07:06 -0800 (PST)
Received: from Desktop.tail070c67.ts.net ([185.152.145.248])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513ae8ce16sm965372266b.37.2026.11.28.07.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 07:07:05 -0800 (PST)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	willemb@google.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	dsahern@kernel.org,
	idosch@nvidia.com,
	ncardwell@google.com,
	kuniyu@google.com,
	steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	richardbgobert@gmail.com,
	ecree.xilinx@gmail.com,
	andy.moreton@amd.com,
	alex.austin@amd.com,
	linux-net-drivers@amd.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	leon@kernel.org,
	linux-rdma@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	izaiahsun@gmail.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	shuah@kernel.org,
	bpf@vger.kernel.org,
	ipsec@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 2/2] selftests: net: check TCP IP IDs across tunnels after GRO and GSO
Date: Sat, 28 Nov 2026 16:07:08 +0100
Message-ID: <20261128150708.2702219-1-julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <e07adc3e-838a-4c46-a56c-eb47bb9e77f4@redhat.com>
References: <cover.1795284858.git.julius@bairaktaris.de> <2f75527eb49d7d4ffec32a61fd7dd080673dc57f.1795284858.git.julius@bairaktaris.de> <e07adc3e-838a-4c46-a56c-eb47bb9e77f4@redhat.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/26/26 10:51, Paolo Abeni wrote:
> This test is very unstable:
> https://netdev.bots.linux.dev/flakes.html?tn-needle=tcp-fixed

Every failing run reports missing segments; no ID check failed. The
receiver read a plain AF_PACKET socket with the default receive buffer,
and packet_rcv() dropped the frames that no longer fit when a burst
arrived while the receiver was not scheduled. v4 reads a PACKET_RX_RING
with room for all frames of a case and fails the case if the socket
drops a frame:
https://lore.kernel.org/netdev/cover.1795869698.git.julius@bairaktaris.de/

pw-bot: cr

Julius
