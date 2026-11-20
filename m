Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795189394;
	b=chGhKhr9xB8Xw3QOqtZZI63T3cu7M1yN8vC5lWhvQzb2lDPduQZzzpb/tRcxldXCHQdp
	 16pY8tIlgrbpFg5YRtu/mms38orjU1+RT5E/Ky+s+IGLxfSWcEry2vxW22Jpab/dz45On
	 eSPDQfhPlVCPuXZXLVIq3tmDfYpLiPXw0gjOyKN2mop59htBrokgVUPX9r4lf1tlLbecv
	 GcqYJU5omOTe3+yoSqvLjKtWNiYay7gszdQpzLOsirNDpy498+nI1KZjNI4C2cmPx0AWp
	 nZOrOqiwS2WZkEiRgVQI3qZFtsc6BX4iSt8MhJVvt86g2hL8vqR/HUlLx+Y/WAfhh1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795189394;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=DaLfAeXgRE1oRE+vSokADhq/gV2tFW1OuyRH26+hvIU=;
	b=DmSiatraTOX1gVG29zoBK2njeh92vGcpt3SNMROLIhTBiL3kXmYhsRUTg7bpqDUsX1SS
	 excjjcNeiy/KAkmSVbUSddbQn4vRk/EkIAuzyQFDpPcItuyxcch1M28evT6FIGQC2LXlm
	 XoE4Im1JIYjWrBkgz1FpnNNKreEABf/Oqs7EQDd2bHxfHjrOeuie4fztewELtUfmchYR6
	 OCMj0QeF39IFOffGbDWFqHBeQ1ihlIMtpRr4+TpPaub5P7tqbtZZJaR/21Il3nKx8bzPs
	 bs+FapsbQH0VHtB+aowka/VRRt1EldrYRwrC3B3SnhjpeVAD3erZNrTj+gbg0iC7mIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=W6XQi2J3;
	arc=none smtp.remote-ip=209.85.160.182
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD43606A325
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 15:43:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFD43606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=W6XQi2J3
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-55c4e670fc6so11015261cf.0
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 07:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1795189393; x=1795794193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DaLfAeXgRE1oRE+vSokADhq/gV2tFW1OuyRH26+hvIU=;
        b=W6XQi2J3So9PWrR3p/SjUq34lOOkZdWEJTXtAhYZ/t3jTUlYPd9PZ41ffzWsxjAAeJ
         RoNxcuOsufqJwLGfsU9QbPw0D9rjKCvD9uYukrGzz90uWO291ztuTiWKqwqLKnB+I87q
         PJcv3U9+YWFzTGOhydiETrHsDFLNIWtQ7HrtM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795189393; x=1795794193;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DaLfAeXgRE1oRE+vSokADhq/gV2tFW1OuyRH26+hvIU=;
        b=iJDAmmqtMAEOPa4PUlFVNKTQCtyj0cokAcCcNey1GVIV52SS/25dejYxL3N4v4d1Og
         UgkTl6MJR9NT9JsFqggtdIW+GyjQR/HTPfLAfrkYdH9vYEZRe22OwbxUehTexzT49h7p
         HRo6s2V/BLSLohywXWR856Bb7HQz7rSEv5jWFHolSvw78glYhfDRV6rrD0XHCorih4v1
         bOSP7ME5tKjpAhoEy9aOiUnFTT8U3pXclmhoEs5PHtwBFxz7jarCuSeTr3sRcZ35CBwk
         kc5Rcw4qtcSG/w8eTAg1AY/tHJSjz2zx7leGkh3gpINN+xGDMP2fmpoz3Ty9aezsq4j2
         Jh/A==
X-Forwarded-Encrypted: i=1; AL+hErFaaSwbGnIIZb5SG+7nVEQXmMOFOThAn6FFMeNWU2/d+c6lawCeW3hIlFAE/XDcz2mR0Oo=@vger.kernel.org
X-Gm-Message-State: APuU4Z9vRJN0jSvQ/JkJeNPKURTu7nj2l2ybOvuwvjxB76Q5NsNMt1Uo
	yrbpn3NsK4OiQ2g643t40IC1N3ujYs4oR2/IjA+vW3/3qJKuSTtZRczx9Cw7w/e+0A==
X-Gm-Gg: AZFdTZcOZpaRA+ukmm45WA4ubMc/zNZy6cKCVA2+emE4NW8kUJLcBU49nz3dypS9VrB
	IQ2M8ql+nkHfuI0nIk5aIU7NuYgR2XV8hlZ3ibOW0QP9NgjtkXIXReS0I2B+cl6fdfXcjF6I+Xj
	0gC4LWe7O18Q67VhPVs/ewP/2mb4VQjHY+RY074vlzbLj+fFupR8gZrYrlaRjKCaOcSwVt0gCon
	3bnYn9vgXYdYIzPOuwqOaDyNZ+R7l3wAM/eAfXS6GkZ47VcflSG8/FN7hy0kvtiEwYXG/CgxcNh
	Ao+p04Cl0RKclDkCEEVcj+/U2N16r9I5UUoJbQo1tAJwixN0DfmSXQg5DdRKeF4ReY06fD4a5fm
	oKHh9xoPMEvkWAnMQ8WFIlg1T7kyUkRAVioZQ9FrHdMj6foQedQQCwdvAdT3yL3zZmlb8wRpdS3
	c1juQwesQzHPYR0Oi2nQe7IM2mkfgsMG1O3yHoOyJDl/3k4G86wqGfA5ccj+R4FQpkIwbCBhz3k
	PLwOBsx2YFCVLo/sSG1LJ0YgkyY2fKIZW4g+KTA2BsmpaowvlcL3IE/iHMEigWVGasN0DuxSv5S
	9mwGMnqgZ4eEkwhnKQUQVYLNed7oF/fqOO3hlVpu3+0KoPxUaAmQ1RdtKDvfYl/WwYl+aq/hcAE
	JrUqB
X-Received: by 2002:a05:622a:4014:b0:535:a5fb:6459 with SMTP id d75a77b69052e-55d76a97e34mr61051721cf.68.1795189392660;
        Fri, 20 Nov 2026 07:43:12 -0800 (PST)
Received: from majuu.waya ([184.147.180.207])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d78451407sm25429451cf.2.2026.11.20.07.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 07:43:11 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Victor Nogueira <victor@mojatatu.com>
Subject: [PATCH net-next 0/1] net: neighbour: skip the stale dst lookup for a redirected skb
Date: Fri, 20 Nov 2026 10:42:58 -0500
Message-Id: <CORE-J9UK.v1.r0.20261120103344@mojatatu.com>
X-Mailer: git-send-email 2.34.1
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

This replaces the four-patch series posted as [PATCH net-next v4 0/4]
"net: drop the stale dst when steering to another device":

https://lore.kernel.org/netdev/CORE-9NOG.v4.r0.20261116135311@mojatatu.com/

Patches 2/4, 3/4 and 4/4 are withdrawn, and 1/4 is split out into a
separate posting against net:

  * 2/4, 3/4 and 4/4 dropped the stale dst at each producer that steers a
    packet to another device. Alexei Starovoitov pointed out that a route
    for one device is a normal thing to find on a frame that leaves
    another one, and that the xfrm, tunnel and lwtstate consumers further
    down still need it, so they are gone.

  * 1/4 is a regression of the xfrm interface helper, so it goes to net
    on its own.

What is left is the drain guard Alexei proposed in his review of v4:

https://lore.kernel.org/netdev/DMX7RM93TMGR.AXFN4YJ55REF@gmail.com/

It is adopted as written: neigh_update_process_arp_queue() skips the
re-lookup of the neighbour from the skb's dst when skb->dev is already
neigh->dev. The parking neighbour is the top-level one in that case and
can reinject the frame itself; a dst that is a route via another device,
which is the sch_teql shape, still takes the lookup.


Jamal Hadi Salim (1):
  net: neighbour: skip the stale dst lookup for a redirected skb

 net/core/neighbour.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
2.43.0

