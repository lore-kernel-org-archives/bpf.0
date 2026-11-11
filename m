Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794406611;
	b=Ec96fZQ5JOu+suF11mG36nwfPcQ2siJ8KDX97jtCWdvAc8udv00Yl9LAmDA2A5DGcD9K
	 /Qzho36jTjV31ncLb1eUMlumkxaMPInok87Uo2uLt6VKfE8uIv9LsDnMv73OJxqBg7x56
	 8zjZLxRvl5i/HgQhnqJjY3umPbFJK9kBrPgwLQm0OmFRzaX3BRC+vHZBDdYgNarlatyka
	 FKC1GUX65Bjh945TPk8nNaCno285wNW69zkTycuZxkjJ9Xto2ewAHdjyqJLY1Hfftx/Nm
	 16sbLGx55v8Cs9zBpgOzMFUYU/GAz7sMe49AZA6ErLJQLc51yCEbEfYbv+2Y8l4tvqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794406611;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=PNaQ6Q4vGpSRfUWx0yC1mdo3/cj4HJ9kzAYecFEBLvE=;
	b=NSGMH8pT3YtyQaw7tiTHWdB7kyBpW/Ty1PLuh4ghPobBT3AG2vkagu/72AK8doUJK53N
	 iP3GPzpb8n2CfxdwxFOzynJkLgNbtffJfaJrxXNNU6+s7BaNS6nbh5Ub3CSL2d+LjK5U2
	 xRsqx7YniqpBeEiUlq14TL3OZ00fsoANtFTTMIoYmo5bQBuIj0ksIXPlemXqvaITyVZDq
	 rmUQsFDu8peVgpkrkeLoOzwWm9xxUlTONBmElZKxjDhZIJkLTQyl4Im2BVaFaryBvOvrq
	 zfNEHDFawcgStcVOWyqXwCCaLAJjF00mC0KSz9h7mxBpFn0f4wCGN39KUIIQhfwVMNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=tbGrxq0e;
	arc=none smtp.remote-ip=209.85.160.172
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7D1606A333
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 14:16:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF7D1606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=tbGrxq0e
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-53cd0c8614eso22221901cf.0
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 06:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1794406610; x=1795011410; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PNaQ6Q4vGpSRfUWx0yC1mdo3/cj4HJ9kzAYecFEBLvE=;
        b=tbGrxq0eMBNGxG9ltbR1XXE91jKjw+myWSxwjepzDk+BtA4Vk/MqYrbuvBiAdF3fVP
         wTu+VHpHgpgppd8Pqu9Niy4xZHpiPmGFTarQ7iYuJCouKb+eCPgHRQ/5HNjI1ieTycV1
         gALsQuK3UNK1m2ivkugkcudeDAuQa11wn618Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794406610; x=1795011410;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PNaQ6Q4vGpSRfUWx0yC1mdo3/cj4HJ9kzAYecFEBLvE=;
        b=v/ONmro3bRP211qJqNrp11ksI3Gr+UTW8OUCLHk0jGNDD4D5yetJ8NslbZZ/P8X5vZ
         WvzZDDqdG6asekKt6MNYgjHTDKCaURsrzaaj6g6e+MO9y5r9D0Ql5ANzX5xbB87y6D/s
         IMmxyvD4xNuHUHF7ikRONOD4SkyXWTgYxx36jaH0o0oy1Jue1t+IfVIVuAGFKLJSbEtq
         8WlfFgkj7FtCawxvUlqzrhPfoDLCJjMdXD2JxtZYdhj3aIE/1x3rguKR5uETNjxPew+T
         4kbrjUEG3A9R55gpLQeDLQq1TuVAj1n06tWyJums7Cnhww4+hHMNdHq+tjjSb80Y09lM
         V6FA==
X-Forwarded-Encrypted: i=1; AL+hErF5JvGRjSxOcD8iim0dSx7pc2oyFhE3TpzkaT77dBoixR1udypc1cePbDvlBVru1KatEo0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8o2dtEwdBizAXJibOv+3Ymt645KBD55AfSJ8uVxMDUZFqTTopG
	koMM2nPmd/JZr0uArwS/LFP7JI8ZvBD2E9qVqbeKagaUrY0UNwpdUiwbo1KSOkX/+Q==
X-Gm-Gg: AYBFou1C2Uwn+z/Z3ptQmJLmgkiDt4dkYEmI7YRJkeD20wK8YvIKlsRJ3U0dsfEiumY
	boiBbAPM0Vtr7t12eNG3+c/4UzGL8MXWeldM4eMATHN1r7QOsSAGjEjS4bwxt9WSDFN7wY3kTZs
	X/YiT8FMCEklD6ZBoqAANqwN3YglmE4Y9TKNkcGVPydSY7UdusBi6kIjp0RjkK5EGYUlusxmIvB
	MSbguGoCVujKvrQrVPrAgwFhN1IoB3G/5RoWNQ6rLxawTpYpcbF6MzNNfw3SzY7/ZZUJcN/7/Zn
	9K+MbqJ9mHWTZ5zLnklRBpJCF6gOhGkaHe1u1WucmqvW2It66QChzuRpkK4ib8uDVUpsRAaz/Nm
	Qa2QQN2Seoukpor4yAszxi9xKbgPGa37VKdVC5pjemU/9FX4dYhyRJvLEQWkm++8YD3cIR7WhqF
	O0KDLW+VhOnAZ7v2WuF2r4pRIKwYYUMjnpOrnLd3urQFMPSY8DMNGqdQHi+CHoSoLQVWD0V6jC5
	z3D+7mAnoZG7iVCUcJLXVIf/hUC7go/Xn7zpcIs+o8uA1JyIgxfdWbQ8n2bo1MsdVTgMTM99CVe
	OTKOPs8NAaVo8aA/kz63SOtZv5pmFIFz6FDuZb6giKRnUT9fWTpqARgTdbhhWlv9rsDfUCDtaV2
	NL3ETLiBiz39BBg==
X-Received: by 2002:a05:622a:1b1d:b0:550:fe12:22da with SMTP id d75a77b69052e-556bd708e0bmr35644631cf.6.1794406604915;
        Wed, 11 Nov 2026 06:16:44 -0800 (PST)
Received: from localhost.localdomain ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5550be2e592sm51505041cf.24.2026.11.11.06.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 06:16:42 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	bpf@vger.kernel.org,
	Victor Nogueira <victor@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	sashiko-bot@kernel.org
Subject: [PATCH net-next 0/2] net: drop the stale dst when steering to another device
Date: Wed, 11 Nov 2026 09:16:36 -0500
Message-Id: <CORE-9NOG.v1.r0.20261111073528@mojatatu.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patchset is created to address constant whining by both sashikos
about this being an issue when fixing a UAF on a teql issue (entering
v4 now), see the v3 here fixing the teql consumer:
https://lore.kernel.org/netdev/QDISC-6HS9.v3.r0.20261103062649-2@mojatatu.com/

Two producers steer a packet to a network device of their choosing and
then hand it to the neighbour layer for link-layer resolution:

  1/2 netfilter: the neighbour variant of nft `fwd`, on the netdev egress
      hook
  2/2 bpf: `bpf_redirect_neigh()` when the program supplies the nexthop

Both rewrite `skb->dev` to the target device and leave the skb's dst
pointing at the route the packet arrived through. When the target
device's neighbour for the nexthop is incomplete the packet is parked on
that neighbour's arp_queue, and draining the queue re-looks the neighbour
up from the stale dst. The frame is therefore built with the original
device's link-layer header and then transmitted on the target device: the
packet leaves with another device's addresses, and the sender never
learns that its nexthop was unreachable.

This is explicit: the steer-to-another-device path never worked in this
respect, so there is nothing here to regress. Both producers shipped with
`skb->dev` swapped to the target device and the route's dst still
attached, and the arp_queue drain has re-derived the neighbour from that
dst for as long as either producer has existed; the invariant "the skb's
dst describes where the skb is going", which the routing path keeps when
it steers, was never established for these two entry points. With no
commit to anchor with a `Fixes:` tag and no crash, UAF or lockup
involved, the series targets net-next and does not nominate `Cc: stable`:
a backport would change long-standing redirect behaviour for no
crash-class benefit.

More context: this came out of the review of the fix for a parked skb
being resolved against the wrong device in sch_teql, posted separately and
not part of this series. The neighbour code's queue drain is doing the
right thing there, it re-derives the neighbour from the skb, so the repair
belongs with the producers rather than with the drain path. Both
producers are fixed in the same series so neither is left behind; each
patch stands on its own and carries its own reproduction recipe.

The reproduction for both arms is a pair of veth devices, one of them
with an unresolved neighbour, plus a capture on the target's peer: the
captured frame's source and destination addresses name the device whose
neighbour was used to build it.

Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-6HS9.v3.r0.20261103062649-2@mojatatu.com
Link: https://lore.kernel.org/netdev/20261026160747.283702-1-horms@kernel.org/
Link: https://lore.kernel.org/netdev/QDISC-6HS9.v3.r0.20261103062649-2@mojatatu.com/

Jamal Hadi Salim (2):
  netfilter: nft_fwd_netdev: drop the stale dst when steering to a
    device
  bpf: drop the stale dst when redirecting to an explicit nexthop

 net/core/filter.c              | 4 ++++
 net/netfilter/nft_fwd_netdev.c | 1 +
 2 files changed, 5 insertions(+)

-- 
2.43.0

