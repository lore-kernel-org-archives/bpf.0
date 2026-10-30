Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.228.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793327581;
	b=RHIDyqJzBogBTPU3hihEJ6t6EoS4hYQn4JNXbio4G+na0okrwI9nAKEDeM4u+tpLBzjr
	 WLPwGGapKsogMYLEIlYUhQXFzmuMIWTBVLTWzSE18a1wJBG+CrtLj81R5XCG+Fk8XYYbr
	 SyPikWFdR2GDW4BnuqQUzpZrop2pTNENlc/+iIXBt5KIpzGn0LmGO7qSAH593Ta4+CtzZ
	 QD8xg58/Lm4SAaj6U+FW1L2NeJ3zOavVH8zPUfjT7YUL2ETDucHvw3EQ2arhhg4PV3jGv
	 jo44DHbLKUK0AHL0z16H6pld0J2AoVN2kVrdrnzoucAq0xynNtfZUhnSMw9tYsVvF9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793327581;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=pcgb/vipsFKI93zItJdvIwVM2kRByvoCBd5I2lEqCew=;
	b=1FKSYT9qCBT+ADeZxqni2CKvtZ2eT9QOftOsGvqN8dTWLfrP8nhj8XOSGOfRsD6/lGG6
	 fUkYGCRkD2Vjv2mr46WBHlJCajMuOagMh3XKmOWzWRHoxlMvJct2vdtJzVjDfEnJUU7na
	 MJ9c6Hi28a3rKb7hiJ5xNn0sJLF0J8bwCqUKmyLbmioeWj1l68oelaRDn2DAayi5tcIDG
	 vmi7dU8MyDJ171X1Erm0M1tWCt/0/GNxedrOahmCQ17AbCxNS6FdZWk5fz5ofqhW+Ic78
	 LU8IPCcaa1kIv17/jpN7WBxhIy6A/g9EQFq59FKngxFTiwTSU/blQdP8S3+ekpUgrfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I4cVE3zN;
	arc=none smtp.remote-ip=74.125.228.5
Received: from mail-pz2-f5.google.com (mail-pz2-f5.google.com [74.125.228.5])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF765606A31C
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 02:33:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF765606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I4cVE3zN
Received: by mail-pz2-f5.google.com with SMTP id 41be03b00d2f7-cdac0ac5f19so101738a12.1
        for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 19:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793327580; x=1793932380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pcgb/vipsFKI93zItJdvIwVM2kRByvoCBd5I2lEqCew=;
        b=I4cVE3zNaa166lxyWLucLPwYv+KKUvcJb2782h1+tYmj2lVTSPBnTdH7SA9m7E9MjF
         0opo8avjoUPnItlZu0TYg2a1aVmH7OVIHTMN9HDYSVB6OTsM+uzbXx5oJMSmRtRxDgQF
         Psf7xF69LvGaOsj8RTjjMLfwRyOAE17xVsMKWn67GPX6PGAQQADemFAaNfTmHs3G/uga
         24/DqDEdEZbMqcql04HYUY8Mabl+kRXlUmp3Aq4hzHPqCDpfDigrJEXAjWyr7+pwGU4Q
         9gJSjAfD5AGxdLhscnnIyTuY7pH3wocg5//cRWle78FoXGuQ4ZLJP094+OwKCV6FPTWi
         i28g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793327580; x=1793932380;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pcgb/vipsFKI93zItJdvIwVM2kRByvoCBd5I2lEqCew=;
        b=G2LVbc2qiNhIa9nWragtXaVsJAoASZsbDe7rxGWFMMUxK8pNgkdMRd4GuX30R7YAwY
         y3DiEqfPPhW4EfoVvu99+R4gCBFJN3hnEVKYCg1xAj813E0zv8WTrpqYzSvcnHvPVPY9
         ncjIKW+K+u5ooUeb3F38g+nwIGDXrAbHUh9D2avr3AsJcbj4I83/6qj+w9/NKxpwhk4E
         QNN69i2aFHhZBkyie+4x7zehnWRW8yFCgIUhrpt1cgEpo4T7BS+kkshS5cTgZA8op98v
         Tvakik4RcZ/UWpnzoaQqjufEIiyxmGixR0ob1689bEQRAEVEpNOJbqj/u/OwamBVOGUG
         Uk+g==
X-Forwarded-Encrypted: i=1; AKwUvBzuz9FpqZCOhL79ZoycxFqjgKrV6SjLdD/1ySSFXAlWOuDV7nPsYvXH6stoc61B16ufBgo=@vger.kernel.org
X-Gm-Message-State: AFq9FYLY0RPJwbBEaqf0nbKOe/gH3T66IECurFxQLaaMnwrYUXdLrPqY
	n/p2khCrelxhE3qL4tNA5ZxAgssUAanDxjy/mB6QzEkphmlLori8/n4R
X-Gm-Gg: AYBFou1Husx4Biec9YLYmwm/nEVOix7yvZtlslnTLkRR0SLjBU86V21XvX7wFerjzyr
	l1GuzBBT3BT1/TFz6WaSJI5i6m4a6t6HoH80RtKNOQJnhOytkiey464SBLB8E5sYrZdrLXZjdma
	p5wFdaZ29GAkEcbeQJd8pwhQSJsswaxzrBrSdAXqoPtzM/ywolzi0NBmOjlm899+hCpJ6eedCug
	bhMbH1TzMBaFV0IumqagxhKNFlElHgtp6SVnucvT52c11i3S0ClxSlht+O5FaJDithi3RJWCcin
	SIR63zXIRZZaS0/vxPJg+SPlUp8lqFmTGAJ7T4s+99oWiTACJvz1nE+TwDpIvmdOk188cr8jX9R
	NgA+3HgAVKDhPaAV3ag0rqnl+pxlU5KxX2Hp39dPaOVOl/ZMq1RXtBC9NlXYTbqbGG7XA4trUik
	hQm+L1td5j8MKYIygpJ6Xb5OjEVJA2y9GNQkX59jZVTWudPqjHy7ZIvgpQA5D5MDKyBvi4+S6GN
	uDrN5udIFZUO68JKkx0QZZTdw7fBU8RXRch2UM/7eWaf3bDsO3BE6PPFjzLB00X/GQWWRgNRfxJ
	BQkkUVYIk2U0N90C9pfCNYvaFzP7EDMNyKqbN7in8q/Tlyqh0JENcQ==
X-Received: by 2002:a05:6a00:140f:b0:89e:f8e9:205e with SMTP id d2e1a72fcca58-8a9bf71c0f3mr783776b3a.40.1793327580059;
        Thu, 29 Oct 2026 19:33:00 -0700 (PDT)
Received: from localhost.localdomain ([58.247.233.220])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a9eef95f2dsm152216b3a.10.2026.10.29.19.32.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 Oct 2026 19:32:59 -0700 (PDT)
From: Rongzheng Wang <testwrzwrz@gmail.com>
To: netdev@vger.kernel.org
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	stable@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rongzheng Wang <testwrzwrz@gmail.com>
Subject: [PATCH net v4 0/2] xsk: fix multi-buffer TX software checksum
Date: Fri, 30 Oct 2026 10:32:46 +0800
Message-Id: <20261030023248.78802-1-testwrzwrz@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
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

This is v4 of the AF_XDP multi-buffer TX software checksum fix.

I found this while testing multi-buffer TX with XDP_UMEM_TX_SW_CSUM: a
two-descriptor packet had a bad wire checksum, while a single descriptor was
correct. There was no production or syzbot report.

Patch 1 moves the software checksum calculation from xsk_skb_metadata() to
the point where the last descriptor has been added to the skb.  The old
code calculated the checksum after the first descriptor, so multi-buffer
packets only included the first fragment in the checksum.

Patch 2 sends the packet using every descriptor count from 1 through
MAX_SKB_FRAGS + 1, and runs the existing metadata and checksum verification
for each case.  The last case is the copy-mode frame limit documented in
af_xdp.rst.

Patch 1 is unchanged since v3.  The updated selftest passes in a local QEMU
run.

v4:
- exercise every descriptor count up to MAX_SKB_FRAGS + 1 (Maciej)
- keep the last descriptor within the packet length (Maciej)
- fix the local variable declaration order (Maciej)

v3: https://lore.kernel.org/all/20261028025026.11401-1-testwrzwrz@gmail.com/
v2: https://lore.kernel.org/all/20261024141157.59301-1-testwrzwrz@gmail.com/
v1: https://lore.kernel.org/all/20261024091256.17918-1-testwrzwrz@gmail.com/

Rongzheng Wang (2):
  xsk: defer software checksum until the skb is complete
  selftests/bpf: cover AF_XDP multi-buffer TX software checksum

 net/xdp/xsk.c                                 |  23 ++-
 .../selftests/bpf/prog_tests/xdp_metadata.c   | 147 +++++++++++-------
 2 files changed, 107 insertions(+), 63 deletions(-)

-- 
2.39.5 (Apple Git-154)

