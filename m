Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794174243;
	b=pAH5C7E47Mv/o9AgLU71XKZ2sFMDBitN4W33fNbSThy463cznzzAA0Lr6e8AkPl73jFq
	 hcQmj9kmvg1Vc8gDliujCFd0XZUYGpQQ6kbO0Bx9zO+T3fLVTxGIh1YnpTg1HcWBKKFtx
	 8dq4frvcJUBuTezdbmCrnrUbJqR67fzPnxQI1JdBpzgEEMJ8z9PKfDh6gUtwctEB1zvXc
	 /NKT4oDiRuXQvpBxilRYjtTO1ANiJJofqII7jfUT26wjxXaz8J6ylzFAkkWuBKTM0La6V
	 LLOChfBifAoG7EPKprYWJIlzhZoRt3UWExTMG8J2ALFb+GKMJA6Xg8iWpMjMTNJ10OA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794174243;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Y10z5AzD+i22lo7RP46fqtgjpar7IW8k2qpztw2GR18=;
	b=IEmnzLoMInNkWWHCbPlVsE0w5zRBlx9occxTuGRnoEzWaeQOVpLQPGcz3bFYC8GMmSx7
	 EBm+Ax2nRxq2XPG3ceJD8W4uiIIjnMCTFREQWgpSxX/Mkqa/61EadEMNDK0UwYsFX3pL9
	 rzFTsQsefwEi6I+pd9hZCNisd2ScwNE/OW/3gIbVXg4s/7AI7EC4Bcbe752jYAwDnyx68
	 JPmCEqiHz538HbFr+V7MN8OnETzwHhI1uAnyCEpetRBtBPk+4thVZCBsq6f+NOjrUMak6
	 kwQwc0u2STCCzVjLLwfxGPlHTIyB+5D8tughVDPl4kQ+eFZtxxXUki1dauKuvjmjbJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=Sr6yDk4d;
	arc=none smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558B0606A31C
	for <bpf@vger.kernel.org>; Sun,  8 Nov 2026 21:44:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 558B0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=Sr6yDk4d
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6b596569640so436001a12.1
        for <bpf@vger.kernel.org>; Sun, 08 Nov 2026 13:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1794174242; x=1794779042; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Y10z5AzD+i22lo7RP46fqtgjpar7IW8k2qpztw2GR18=;
        b=Sr6yDk4dtttSFsLiVpGOBa/SdwfLyad+WndTtGDMVrwbwUEW+v4mm00fVFKu8yDnA1
         wyEAr4CEHKEhS4ndIll1qHxbwFVo2TxN+nmDGCFHY8qB5YowQ2Jy9/MDh9R++vG8hSLu
         dYgy9bSDHQdFELf+JSbTYNm6Wtc8/KjFWI9Bx44NnX4P27EMTEIoy82G3n7SmpOS8uk6
         G0wQ2kVsR2nI50m4XPIz/XgRU6EVhs+dHpMPmSoq4+9Nb9FOPyE45NjRIK7hn4kNIZ35
         ely+fNVEv+LDHnYkHb31OSzYzWJ+2qBHkUJHLNsLM5eYuE4UjEhWOexgb+un8vvBTp7D
         9qfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794174242; x=1794779042;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y10z5AzD+i22lo7RP46fqtgjpar7IW8k2qpztw2GR18=;
        b=tpQ1TQdDZMMG3q+HFHWSYtVmJ1PuQOFT4aiwVT/snnlo3a8Gk/HICBGQLou3F88Lip
         x5iNwIRs9SRuQLJ4/piHIQHazNiozbhp3PtCfpvLK4KbZRdhb2UPxZGVEWT1VHV+uNRN
         +pYneDBDW8eKFM3Mg9Rsv8JXOXV1K1EpJK0uQB6s5TOxIHm/HE6Wt8RHDYO7GNR3v/30
         g263cTanOr38nrV+Xx6PINnSHKvVrsP8NDiBLykzpI+mWZI7/HWSDTykBpkH6lYcz8Xq
         IuRGhkmo2tXbgUWUyqJGGH7A+C9+uvl28wUfgKuo3kr8K64TFmL5bPGgFLCg4FJmYsa+
         HF+Q==
X-Forwarded-Encrypted: i=1; AL+hErHzi7+5ZDmgS+wGnWf7psAMNIV82EEsoJV6zvLIAGkl5qPJpSM3R2gj/nSGCB2ZYBrXWr8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9L2rNpGsCtcHsx9EYt22+ecZEkBsuyThni/n0Xcs4u3PYIzxTL
	XGYDoOAdIApudJXrA9i4kQh54OFxS3FMFccZ9EM8QjiNqFCTzR1Lw1UeeG89pPEefEk=
X-Gm-Gg: AYBFou0NyJHouCZTysCBfgj4j7Iiq4XUbxBzyleSXDt2SGECYnxvLi8lAqN37LFDegQ
	St+D6ZBlGJFTtn+jvT25cn6s1JYLpJtw+j6iJSACxSrsVJYxdMVY/88HF22fDdXais36x9DKTIW
	LOTrTLArJ14CK2i7HcqyCC3AuDkqTvSyVUJZUpgItU1Ajt6UzCIOJmhO6IuF/w949mZJ4iqM9dI
	lR/X3BLQo2zJ0OXba+AFNjzS5azgYT/0lvAFarEDtHntgayzTq14Hp5WRTSZBGInECqUQscS5oZ
	wr61fDnRaLJzz2ZNP9ls18Wma9uvaIa4a/8CDxvTX19rH1ERIiAE8+3ATt5dbZMr+2fPppKCFSV
	d/zj/FE16APRyl0LwHrDFsqQHaY4hIu4Qy8RfoEFH0Prpn1JTLn1WRJix3h0XJ+4CoMfDQeltAv
	4gFTcnS5cjcmKS4jPX5XPdl/EuDd/fT+5tQ4rmaNKQ7eeIG7e4lKcPdZ/ysRtjVk+aLrBq4JmUt
	Hc+iFVSZVb0G3NRxyZEhhT0T/atVGE4FkQeNZFP3jDQ8ccmnV6U/y76IF2ALy+PXMaZXIXEPTdw
	1muS63YOGa9e6s6YZWlB7lCNnlUFNF3C2oRS2D7/vR3sKqxovybmWsVH5p/Q3oBKUPpMqB+Adf4
	t4vGXKle3
X-Received: by 2002:a05:6402:320e:b0:6b3:e89b:128f with SMTP id 4fb4d7f45d1cf-6b722466c43mr1643975a12.9.1794174241711;
        Sun, 08 Nov 2026 13:44:01 -0800 (PST)
Received: from L9JK9NPFH9.lan ([104.28.20.57])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b721ea3b27sm742043a12.11.2026.11.08.13.43.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 08 Nov 2026 13:44:00 -0800 (PST)
From: Tianyi Gao <tianyi@cloudflare.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org,
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
Date: Sun,  8 Nov 2026 21:43:56 +0000
Message-ID: <20261108214356.95406-1-tianyi@cloudflare.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <willemdebruijn.kernel.2c6a653eb65fa@gmail.com>
References: <cover.1794020868.git.tianyi@cloudflare.com> <e90e748e0aefa7cbe1c2b31b8c7902ccf135c3f2.1794020868.git.tianyi@cloudflare.com> <willemdebruijn.kernel.1d64e7848503b@gmail.com> <20261107182526.69543-1-tianyi@cloudflare.com> <willemdebruijn.kernel.2c6a653eb65fa@gmail.com>
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

On Sun, Nov 08, 2026 at 10:13:03AM -0500, Willem de Bruijn wrote:
> Pushing back on another design choice: the UAPI change. That both cannot be
> undone, and is fragile and laborious, requiring manual admin arithmetic.

Thanks for the valuable feedback.

On fragile: a wrong value never changes the packet. If it is too
small, the push reallocates, as it does today. If it is too large,
locally generated skbs on that device use more memory. So if the value
drifts from what the programs push, only performance changes. The
software that loads the encapsulating program knows the size and can
set the value at the same time.

On manual arithmetic: user space already does this for netkit. Commit
b9ed315d3c4c ("netkit: Allow for configuring needed_{head,tail}room")
lets the Cilium CNI plugin compute the headroom and set it on the
device.

On "cannot be undone": the IFLA_TX_EXTRA_HEADROOM UAPI does not block
in-kernel mechanisms. They can write the same field later, and the UAPI
stays a bounded, explicit value.

> The RFC patch mentioned two other approaches: explicit headroom requirement
> labeling for tc and BPF, and dynamic adjustment of this field whenever a
> realloc in the stack is encountered.
>
> They are left for future work. But should those instead be implemented
> first? As said, this manual hackery cannot be undone. While in-kernel
> mechanisms can be refined and built upon.
>
> It seems to be that this series is trying to address a few related
> situations and argues that no single solution fixes all except for manual
> adjustment. But likely a combination of the above (and more) will.
>
> This does leave the veth peer to solve, but that does not seem
> fundamentally intractable.

Regarding labeling for tc and BPF: it is also a new UAPI, and a label
increases the value of the device that the program is attached to.
That is often not the device that the skb was allocated on, as in the
cases below. If we have to add a new UAPI anyway, I would prefer one
that covers all of them.

I looked at what dynamic adjustment would take. The kernel can find
the device to increase in these cases:

- XDP on a veth peer: veth_xdp_set() and generic_xdp_install() can
  increase the headroom of the peer to XDP_PACKET_HEADROOM on attach
  and reset it on detach.
- A TC egress program on the device that the skb was allocated on: a
  check around the tc egress hook catches a head reallocation, and the
  kernel increases the headroom of skb->dev.
- Stacked devices: a vlan leaves its tag in skb->vlan_tci, so the lower
  device can find the vlan with __vlan_find_dev_deep_rcu(). macvlan,
  ipvlan and team keep the dst.

It cannot in this case, which we have at Cloudflare:

- A service in a network namespace sends through a veth pair. The host
  forwards the traffic to the uplink, and a TC egress program there
  encapsulates it. ip_rcv_core() has already orphaned the skb, so the
  kernel can only guess that the veth peer of skb_iif allocated it.

Even where the kernel finds the right device, auto-tuning has problems:

- It grows too easily. Background traffic counts the same as the main
  traffic, so a few encapsulated health-check probes increase the
  headroom of every skb on the device. A threshold to filter them out
  would be one more policy value to choose.
- That growth can move skbs into a larger kmalloc size without anyone
  deciding it. On x86_64, for 1500-byte MTU UDP over IPv4 on an
  Ethernet device, 194 bytes or more moves the skb head from
  kmalloc-2048 to kmalloc-4096. That adds 2048 bytes to the memory and
  the truesize of each such skb. The IFLA_TX_EXTRA_HEADROOM UAPI can
  do the same, but then the operator chose to pay that cost.
- It only grows, unless it is reset on detach. A reset on detach must
  find every device that the auto-tuning increased, which can be a veth
  peer in another namespace.

So I prefer to keep the IFLA_TX_EXTRA_HEADROOM UAPI. If we need
auto-tuning on top of it, we can discuss it when someone actually needs
it.

Thanks again for pushing on this. If you see a simpler way to do
this, I am happy to change direction after discussing it with David
Keogh, who posted the initial RFC.
