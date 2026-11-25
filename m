Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795597675;
	b=Swz+Mk9xqd0kK7uTgRwzqc3PteHFGuzuOl7OPD05NsHWJwYgyBUMlYiv64meIPa7564Z
	 oCh5YWO51R+o41+H4h3cLDsjNR5G6I/MiWwTh0YJR5mNtXqkqjE6v3H/oyFEnSq2MQrMq
	 DE1ffkPEKysPM1Ij3z8j6pLR1DS/+kcEt7+aLaBwebQ1R0BijrcYSK1gpCV76eRaiOKpt
	 YdwG/+IhSQlzVPF/A/S2uT+LF9Jnlrq5Styocfr/nZZyu61FBN/8noptZicuYyYoMRC1/
	 SKKFaqDNOK4kE5DKjtVtN63LY1AcluPKgRuHnjn0DQXF5wiP/5R4ypp+Cs/7jzs384g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795597675;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=2SrnLqwi6obns0/0mQLix36QghF6a+1nH1591GRlSFU=;
	b=cW/GeFD5n6aTYf1rJJST5Dq0KNkFpP6AkUd/qtH7oq/OJwtVw4ldPhHX6eKE3LdwYH22
	 Q2wAv5xbXkT0U6z50lg5+0fwrWHr3CwVOqla9AM3LR15pwcvpFRauLHe3rDjG+VsYS109
	 OE0Wp93wHXDC64fvAIasaZBDEIEzW6AMDUhQlTdS39eVhfQv8sVFykqSAt7J+0Sb/DG8n
	 hl2XIScV9p5fllBte4s379Y++CyOo6oNVr5p+o2/NltUR1apH/pbDwBCXOB5nhSikXdRB
	 QfZRca1WdG4R+YYXXjmOm6kIfz31ExqxHNipEnv585g34dIZgB6ccpHve2sKrJKgmLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=SHQExxKO;
	arc=none smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9AF606A321
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 09:07:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD9AF606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=SHQExxKO
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6bb06dc1fd5so2030621a12.1
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 01:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1795597673; x=1796202473; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2SrnLqwi6obns0/0mQLix36QghF6a+1nH1591GRlSFU=;
        b=SHQExxKO3kd0BSeOrE8wPd0NW5hm98ifht3L5i9Vu0gdWsCXJ/lcHQC/3dtvJS11FI
         xCYWMwidXSdTpVUHLz9E3lqPM7/T4U/xjMDeA0B7n9InVibiXxcrgScS/dREwiwzk0zR
         uy2Qm+ZY/B/sFU9lMxFBhZ7KwpBOiCiTAlWWwaLMBWfbzcZcLJLtWQL5/eJgP0TxfOQE
         iUTUXUjRqgQ7NXXVwNOz/jGweD/r8FmL3ngoibz0+vTzKY5MLsdZ7iQRuLtyYnr6J88a
         FL3eeFinwL2VZFA8WXkIY3DWycA/t1cNl/Nv1YIwwIk3ygsZEDYc46hWlFcxZA6rUKv/
         8/Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795597673; x=1796202473;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2SrnLqwi6obns0/0mQLix36QghF6a+1nH1591GRlSFU=;
        b=YdYMCzJLKbynJp81uZTA5bwNnczlJTaPIRRHdJkcbWEk5ueHm1Mw0YUBUycXrB1owE
         /vj2Wzi4pBBSk8zX/6N/3ZbwL7tNWzCd4A0ARv5RqCOnwoocvaNBhP0zAEMdBqNPRA7X
         06nxNmRkc4Kq4N4JDSaSY5hnZ77RmkP5K98Rxpbd/AnbgYk/XLUBFVNhBggHd53LaxUX
         n+Sh1GVvUNZCCOHYyRyzkXu4wmKaBk+DhDLzbhMSm5IoTdqUdfwdkP20O2fHI0tYEPHF
         0Ux64uAGM2FxSyqPkCD1emGZbnpvMQEYWxsLMfvgbSI64MDc2DW7jKbmFgOtnE4xMRow
         0iUA==
X-Forwarded-Encrypted: i=1; AL+hErE5pXQkmC5HLi3p/hWF4mdKO+KFw42SOSo7dTivQA/GXjnHsBfcRTAwfFATGBZ5rIbvH/I=@vger.kernel.org
X-Gm-Message-State: APuU4Z9SScz4zV+YdvzbLfatw48tDhx7BvlXhYn5YRCyr0lcP3MjAA7N
	8N7R/r2KttgRU/fjdGP1iMmHyDvGn3udz00KxSYq7PAK5baNTAC0HCvaq/Tg5C16S/0=
X-Gm-Gg: AZFdTZfbShcGul7SqjMyUvlXjhLuxA1iR2cvEJVLq0Z5YTO7wYZ2CWvPV0rapei4C+4
	dwCCU0PuZ15a2nabrX513BaEzRoOtib2ihI4K0zZporFsb9uvXWsiXuqPBESWMR4O7/43s2Gsrr
	A6yW0TSXo6xInOHjTl7aZ9GEeEXUYhhzqG+OC0fe6rKfUXfildyHcH6MDV2QD+WEfwArKbPu1qu
	NFRcEqxhOrNg5O6CRjUFWcaMyN3FLl4NJeQ2U+z7U0B8/h+/UqKb1h2mcjNT19fMCYl3bsoJJaZ
	4GSU1YSclKBwWK5vl7Z6z3EIh5evjzPloRWqHCnDwJkwDVbJwb164J5K9wKpcuGebDC34HLUgSf
	ood7Kz6d+/IpWRj1gNjjgp/D0U9b5sFqPKz4t21qmnFuF6HQhSLLYsyryA20zvTyHT4G+wf+RKV
	LPJDjM63D1URJfp2PYZuNHrwPyVsHuYnxaNTBZCftpVzue3ftvFRra+R9Zwr1kt14ZQgMmdo/r/
	3YQNm+MATOTCYIWpFYRLhYyU5VDV+FihUcJkrUnaRGSgzSm2ME453DjGG3mJXQoAh3zgaL/pyLl
	jX/iwFzPYtrD8o5oAtLh7vhtTo5t8rvOsyeWvu2YZF6RmHUIoWA4voDCJg==
X-Received: by 2002:a05:6402:51d2:b0:6ba:6f75:9d44 with SMTP id 4fb4d7f45d1cf-6ba6f759e80mr8443781a12.9.1795597656119;
        Wed, 25 Nov 2026 01:07:36 -0800 (PST)
Received: from L9JK9NPFH9 ([104.28.20.55])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba7b9570e9sm6152930a12.36.2026.11.25.01.07.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Nov 2026 01:07:34 -0800 (PST)
From: Tianyi Gao <tianyi@cloudflare.com>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Paul Greenwalt <paul.greenwalt@intel.com>,
	Alice Michael <alice.michael@intel.com>,
	Eric Joyner <eric.joyner@intel.com>,
	Jesse Brandeburg <jbrandeb@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	bpf@vger.kernel.org,
	kernel-team@cloudflare.com,
	tianyi.gao@linux.dev,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: Re: [PATCH net] ice: do not report CHECKSUM_COMPLETE when an XDP program is attached
Date: Wed, 25 Nov 2026 09:07:32 +0000
Message-ID: <20261125090732.69233-1-tianyi@cloudflare.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <CAKgT0UeNyyXKARjKR4nVVxNe3UB16WuXqxSz0cf4ZvCdb9A4_Q@mail.gmail.com>
References: <20261121012402.84848-1-tianyi@cloudflare.com> <3adef4b4d528780bae31f2fb02d0a08bf9c8ebd5.camel@gmail.com> <CAG4wq-f18SHytDb39SdJYzRPk-dzECjH_HCSiMGAQ721Zmfomg@mail.gmail.com> <CAKgT0UeWWherBt1MDcPF7R7jxt6E_3peo8VuxrgY3JdseM-0rg@mail.gmail.com> <CAG4wq-dizUz-6GB8Aj1wRTQBOzbHbT7pX9gom+AhR=5OWSyjzw@mail.gmail.com> <CAKgT0UffmbELMsGi8HRfu62MfC9VRYZ+TMNKFjZMWJyrV4t3jw@mail.gmail.com> <CAG4wq-cG1bseTFczZTjashN75J1Jsrv=u1ccuRsY-N1kZ=SXXg@mail.gmail.com> <CAKgT0UeNyyXKARjKR4nVVxNe3UB16WuXqxSz0cf4ZvCdb9A4_Q@mail.gmail.com>
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

On Mon, 2026-11-23 at 16:17 -0800, Alexander Duyck wrote:
> Any reason why you couldn't just strip the GCS enable flags from the
> rings when you add the XDP program in ndo_bpf instead of having to add
> a check for every packet if the XDP program is present? That would be
> closer to what they did for the Mellanox NIC and wouldn't be adding
> code to the hot path. Then it is just a matter of also adding an info
> message that you are disabling this in the log so if somebody does
> have to figure out a regression it should be more obvious.

Thank you for your valuable comments.

Clearing the flag in ndo_bpf alone is not enough, because
ice_vsi_alloc_rings() sets it again on a VSI rebuild, for example after
"ethtool -L" or a PF reset, while the program stays attached.

In v2 I will set ICE_RX_FLAGS_RING_GCS in ice_vsi_cfg_rxq(), which runs
every time a ring comes up, similar to what mlx5 does when it opens the
RQ.

v2 also logs an info message when a program is attached on a port
with GCS. I tested it on E830 with attach, detach and "ethtool -L",
and I will send it soon.

> Thinking in terms of what the final fix for this might look like,
> currently the drivers are already starting to carry stuff for frags to
> determine if they support jumbo frames via frags or not. I suspect we
> will likely need to do something similar when the time comes
> indicating if the program can avoid corrupting a checksum or not when
> it is stripping headers.
>
> I am not super thrilled with the idea of this becoming standardized.
> In theory this would be much better if there was some way to pass the
> data out that the frame was mangled and what the checksum adjustment
> is to the total frame.

100% agree. We should be able to tell whether a frame was modified,
keep CHECKSUM_COMPLETE for the frames that were not, and give XDP
programs kfuncs to read and set the checksum status.

Unfortunately, today there is a big gap before we start that:

- [1] lets a program read the checksum status, including the
  CHECKSUM_COMPLETE value.
- [2] lets a program set CHECKSUM_NONE or CHECKSUM_UNNECESSARY with
  csum_level on the skb.
- Nothing lets a program pass a corrected CHECKSUM_COMPLETE value to
  the skb. [3] lists this as future work.

> As it stands we are probably going to be
> getting CHECKSUM_UNNECESSARY on everything even if we don't expect it.
> For example I don't know what will happen with an ICMP frame sent over
> this tunnel. I assume it is likely just discaring the
> CHECKSUM_UNECESSARY since it isn't used.

From roughly looking at the code path, ICMP does use it.
icmp_rcv() trusts CHECKSUM_UNNECESSARY, so after decap the inner ICMP
checksum is not checked. TCP and UDP are the same. This is the decap
case left open in [3]. E810 and mlx5 with XDP behave the same today,
and this patch does not change it.

[1] https://lore.kernel.org/all/20260715-bpf-xdp-meta-rxcksum-v5-0-623d5c0d0ab7@kernel.org/
[2] https://lore.kernel.org/all/cover.1794281983.git.tianyi@cloudflare.com/
[3] https://lore.kernel.org/all/20260721183256.6f49d6e1@kernel.org/

Thanks,
Tianyi
