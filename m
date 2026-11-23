Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795423391;
	b=Rzke8bAH/QPawi5+h1s2FPbrSQBk9QwRBIL+RMT21iRILluPQOk8qPQlQcximEHIQrua
	 BZ2lHK+aqcnGXOt//quDWPVGbAv7VMfGfgzNFkQYdJrK3ynN9dSpJRBtaRk2M/KmXRxeE
	 /TrR6VmngKEUVtACMKG1boqDPCVd5cU4YJXcxZBL5lS06dyU5AZZ2KVW9eJlCYuKALRrU
	 nXecOiAwyVvS9VPnQR5sgemY9+jgsbgylX8Gb6CGCcxexrSk77GIgD4dSoV7J90Zw/jK0
	 SJb0oHV3TTFVUIzJUT5SHm+1wgQYaThEFz0mqRm1U20wq4A4noIGKu6IZVX4ThacLOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795423391;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=7dhioJkfIn8Rp/kl8bWOUoycB6YEQMQ+40u14yq/8cM=;
	b=cOE+QFEVrykkonIIGf+r8oRB936tpJJ9Ha5gZyP8W07Db+QwFfUxkjNkv/uVULc6z8uT
	 STACV3eevrzHqH2SUbK/WB1dT3gnkLTdmHeMSbbXvoxPnA2YaXXi6apmyEaBsBr8oqJuL
	 hwjdmk38vubJOxlh4QKiE09h8QVUL1v+iHqgJ/hsWDcMSI/3srEW2Q1h2tzUel/zsbKOr
	 VD+LrX9nbBoDeLPrxDjKXVIoL74Cp9ZHe5kepqpA782VBgY0mus6Nq/IJRdHDN6PLOvRa
	 Inr7UmTmxdrCgeb0nplT3sCbgci+caeDRRsEyge9uNRjDuIfiQNYY2nS+YO5gy5qmyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=blackwall.org;
	spf=none smtp.mailfrom=blackwall.org;
	dkim=pass header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=MznjcAqB;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009F2606A68B
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 08:43:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 009F2606A68B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=MznjcAqB
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4ac109a8a12so1643608f8f.3
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 00:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1795423389; x=1796028189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7dhioJkfIn8Rp/kl8bWOUoycB6YEQMQ+40u14yq/8cM=;
        b=MznjcAqBGuBrzDtYHfSXAoUm+3W6oteZDRgJz5YyrNT0xTtbYHFpGPjdoDkEAXMN+/
         gPu9Ln93VX3609Xiz9F+sYL4Pf87TlXCWLkB+AvYzldal2Ipcqj0C0GuXHIxLSN9jdU1
         l1CDFeTEEqzWZLxfO1l0gah291HBJ7rH7QO2PJ1MJTKXkmc7x++cIiyuXtvHWW8mdMdi
         GyuokDyNP/Mvvcd+Ye0SaCnlgeYOwH/yYcobRyUGT8psI/D99uvqgRrrXFZrYwacjWqS
         ktfi7Q2Jxt1S2bNgLPD55Eo8oKo89Te2hVel2XPffYcsXmZSryTQHZNHDcW0ryg4PVnp
         0j+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795423389; x=1796028189;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7dhioJkfIn8Rp/kl8bWOUoycB6YEQMQ+40u14yq/8cM=;
        b=lnFO0emoiKj2j2sbmX+7ZZuL/HvqSnPoy3BpZCUGZSe8rYh1ffZblgEa3Lw2fB1kZh
         q/I0gOd5joxiIgiJFyF8ug7RZeq3BfYGWSHNo3MYOgfnqvzVqDrBn2vI+LrIo/X8j4qB
         HFGbIL5KZpqVrB/hFpsiX8YnGT94825HbFsjsuy1W8MOivRLW92VRw4DihHGaft4PyRK
         gsR+0X46snKspYdHsTFQXYjZlnACQOSrZAfhNisZhYA0d0J9Y4Hj368uOi+APRsq4N2U
         g5AxA4iHIG4eENnmHsyw4JbRP17VUNmyng0v1ugWGTjHbCI2y1fMgoz7wBzBHIHDBok8
         OeGA==
X-Gm-Message-State: APuU4Z+7Yj2vSSR2ibRdS9ui9vfEzDjti3NcpxyySy9ZUb8yyaits+kF
	tcMwWGRexFYbuLR0nb3l9oDJuTA3hmsCW6FNOWU1oBF0zNnyw4fH3Pw4ak8ymnVwpVnsHeecd5r
	ie+sWH0FQJdLm
X-Gm-Gg: AZFdTZeCXelzHTdNqHU/OPLjylQS6rFCkDIUTgLsqU6OaVpuOt33VnN5qmsUd8k30O2
	45jtwLUOwskGtgXoymW/qOzrYwscvXYqrMRgMP8CHCCsdHAfu53zwjnpQRLlFzK7nQbNYfPocVQ
	mL5a+jdXwEh0OWdc7Yx4z0AaCN8dRpZnF7qxXuztM65bDfmU0KA8Ik2dVyDHkJf0+VxPv+RvyPk
	0UK7GbB6BTFUCV6JD7bbVnI2TsjsRIxih+WklHiuZuM4z6siwtyLyFCBZtLMsxXKPRYkSg2PX6U
	lIxawZrwgjiGDmj6EhYmrOdrH9mCnbkTmFaAkXH0KAGBm46sXY8xEzHuo3yHRB3HMTAhdm+MKaY
	XbK/33R4iYMmQP1O0bvKrtaGGwwkAC399qsOxgXe+ATbCIkJ7FLj8TXQSSMhm6xJDKrAufGDxMk
	bgYr5pFz42dErlAtzbppy034NLL7L215PUaz/S6g0i80b4e5zlM72l8j/8z7uGCRJs7Odn0lj9f
	7ce9edlgKolxRu39ZugTFSz+0AWMvXFW/02sfdtMpOLPI3ChQikae/a4kkSiqhvc6AFF9YvlU85
	ioDKeRxHaNqlWxPRxdYLS9602w753xYM5ehvp9o90iQIzdmN6sGVdWHRAE8Rui6sf47fxixW
X-Received: by 2002:a05:600c:4fc1:b0:4bb:53e4:a7cc with SMTP id 5b1f17b1804b1-4bb88820741mr245747455e9.30.1795423389108;
        Mon, 23 Nov 2026 00:43:09 -0800 (PST)
Received: from localhost (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4bb853c9170sm393185965e9.14.2026.11.23.00.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 00:43:08 -0800 (PST)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: bpf@vger.kernel.org
Cc: Nikolay Aleksandrov <razor@blackwall.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Martin KaFai Lau <kafai@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH bpf 0/2] bpf, net: fix assigned socket mismatches
Date: Mon, 23 Nov 2026 10:41:36 +0200
Message-ID: <20261123084138.723275-1-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,
Patch 01 fixes various mismatches (protocol, netns etc) that can happen
with assigned sockets which can lead to different corruptions. Patch 02
exercises such mismatches for IPv4 and IPv6. For more information please
check the commit messages. The problem was found during LLM review of
the sk assign egress patch-set.

Cheers,
 Nik

CC: David S. Miller <davem@davemloft.net>
CC: Eric Dumazet <edumazet@kernel.org>
CC: Jakub Kicinski <kuba@kernel.org>
CC: Paolo Abeni <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@google.com>
CC: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
CC: Martin KaFai Lau <kafai@fb.com>
CC: Alexei Starovoitov <ast@kernel.org>
CC: Daniel Borkmann <daniel@iogearbox.net>
CC: John Fastabend <john.fastabend@gmail.com>
CC: netdev@vger.kernel.org

Nikolay Aleksandrov (2):
  bpf, net: validate assigned socket on receive
  selftests/bpf: Test assigning a TCP listener to a UDP datagram

 include/net/inet6_hashtables.h                | 33 ++++++++++++-----
 include/net/inet_hashtables.h                 | 34 +++++++++++++-----
 include/net/inet_sock.h                       |  2 ++
 net/ipv4/inet_hashtables.c                    | 13 +++++++
 net/ipv4/udp.c                                |  2 +-
 net/ipv6/udp.c                                |  2 +-
 .../selftests/bpf/prog_tests/sk_assign.c      | 36 +++++++++++++++++++
 .../selftests/bpf/progs/test_sk_assign.c      |  2 +-
 8 files changed, 105 insertions(+), 19 deletions(-)

-- 
2.47.3

