Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.134
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793155837;
	b=HFeqM0yDwafsAtbV71owTvZdGW08rdgRWmMQw3X3elOWpm23fqtm25TJ/Vpo5vBi/dw6
	 h/miMT/AjRCocI9QwORA2V9O+YcNluF4gNVo3kPPMujgCYuPfPeEuOazYfVoJ2XD7Bt6I
	 IC6UvbDDf6DvTt8iaHPFBtKlZWfvJ96J21je35j1bvpuqP1mQeMKNMla0AxRCVNQ58tCD
	 k8q+QueVvfMk9lGJRaE0k9VPQ9rG96DtGqPtAAAjXsc3PJne/gujeLEZYnfEW+2WX9BaU
	 7bNzIIA/zQY8Un7+N8TDOti43gtlYcos8p+XSmABHdH3OMC9XwYRZNSwXN3ddipsVpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793155837;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1dzXShKALUyaZeixBnjjH+DrrZjfaru5HO9W3ebDULU=;
	b=HXWIR2Ff85ifcJKJGaBfi7yqMkUWDKeZVxBL58woSj28zi89zYAD5K933yvvDowXcf0a
	 rOzJaLlqwNksW2biYtUar4KSZt8/DxxH//6bL5xEe95LNfWw0AmoqLfJgUNCYB9BZ5k6W
	 li9dFjlr1i9DSVtP/RDsZpH3oBpKYWztAPmd/mtzNGSCSoxFWlNKDfabqwSDRIMJ6xy/4
	 lgxsXQnAlcN/R/Cy2rCI/mnPzdVyAi6wpaPX9a9YAsRCeQQ2SLl1OoUDRHT3WYO7u0ElD
	 f4FTFuTKrwNGZtx8hT9grdVyeOX44gU6XNRQ5IhXCTbZN2dWpDghcMeblGSc92jQRJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="eyx7f7/Q";
	arc=none smtp.remote-ip=74.125.227.134
Received: from mail-pj2-f6.google.com (mail-pj2-f6.google.com [74.125.227.134])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB2B606A31A
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 02:50:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BAB2B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eyx7f7/Q
Received: by mail-pj2-f6.google.com with SMTP id 98e67ed59e1d1-3ad211ad92bso156413a91.1
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 19:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793155836; x=1793760636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1dzXShKALUyaZeixBnjjH+DrrZjfaru5HO9W3ebDULU=;
        b=eyx7f7/Q+fC5WBU+omNKOxO+4BfKSrMYmI8hYrJpclwUOEoA6wTu7EeAmY7Z94v2oI
         M2TY42zmspkcu6VNsxBjAE+aF4d7IfbfAvfA97oHKZtIeEsT6eInGiG94FMu1Cn2ev7/
         Fszu12V9BVBTIMIahHLC97qq0zzHjq9XpWGOvDUNFrPmjxkCT7wpKB180sqCNkYD7ryB
         eUWUPZVUN5qMpZYuwf/1KjMQpJeVFpWVHh3uDsxU6Wn5FeL8hY5sByuXW7AGfbxKz3DD
         HTubBCzRUHy7MA2t5uuYNN3slB9JE+NzyjvZwmX7KN6tS4KhIhFId4YKXcelvnKIL8AI
         1cQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793155836; x=1793760636;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1dzXShKALUyaZeixBnjjH+DrrZjfaru5HO9W3ebDULU=;
        b=IwRM5uUlZ3O3G52E1L7wNpufmbtJbK1JHk99BsDREH+Y5YxebzP7ar7rU4O/zL/Dy0
         P8oS7IrP6m4H1u1Yj0wrO9f0HP/a8hEN4+jG+U2sF9IGiUs/+lR4V4xyvsQ9MWCDpqUU
         TWeaAi9JVOeSsx9lglL6HkkAkI2hkpdivGlN9VrvXd+NPpk7rcI83KJPLGEUiRXJCqAm
         fKyoATxEdDwglB5r6n9U9dH9Q4cdHl5h3qhTjwb2/HelxrQEthCWXCHG/HUZYLBrUUhK
         c+9XCJQozHWsx53/ZNIY7xp0kuiJ+2LunckxR/9Q+xE6MuvA1lQ7m6k2O6FlDmt/TLS8
         u+wA==
X-Forwarded-Encrypted: i=1; AKwUvBzu3Fo4hzWofDbYJlO7Cvusvn/IeoptTAf1zIZoT23SA8VrveQXpnqpItsD5O+BANJt+K8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJtJgNyB3RKLAmNOV3UTYeXiJ9bpLFcqDxXhaWVfdRtKoM5iJk1
	pu0cCfATakZujQ3Pe7HmFKHu2C4kcF1S4R4eHeZkFcGz6k7dqTdVv3nq
X-Gm-Gg: AYBFou2E/8W8JJqU/xUecGoE8cro0NhNZRhQQyUrinOkTakBHNTXQy31dLL+7qen5Af
	kq5EpFjMgV8LifQpCTL1OsmS9Vh+CVBs1iV1HgRQ5G64bA+HsthOwPHDEtDW3N8OFLe9Xx9TOP1
	w6iC44Aj5CtzaWvnEdwJoZ2RYhUfgG+KqoezRxEtFHLdehremBDsqX4A6KkFqzEtketYsuIuiDO
	hSVVMBnOCBdlhsIh9sOydGicf1YFUcG0OGUbtpPENvvwq7A/wqng/55PMmuU4iahPcMPTln9P/Z
	nXd9TlXofzOjVXuWJI7qLiuUD4G+Odo9rw+7vQuE5+73WlraHurWCgvFCOBh92hBXkDxzei5+q9
	RcobqCpI+QijuhuJALnnU/IwpAZr1jg1WXm4HO+uXTblqpds7lrzZGjHOpuRBBpiiyWw51+j0w+
	cOdNr/i4PnaiuqzDF5irNKHAqkpFUxLe+g58xzKrXJ2NypyYGyfeNoFaM0fl7hT76gx+opcWGRP
	nHBFD1ZrcAMrV7ZjE1+p/W5j37daophzo0L+4Lm8PZAKWbdeczHWOBJyQG+vbJ9CwjgNu8Qv7GF
	jEli4NKC1gEv4YhbV/Booy+vSWSr4jaxDJQ+oS4IpKk8k4mbhaeNEn7i35Fmt4B6IEn/RTYqynA
	uTj09nomd
X-Received: by 2002:a17:90b:3eca:b0:3ac:a203:e092 with SMTP id 98e67ed59e1d1-3ae57e078a3mr731546a91.1.1793155836154;
        Tue, 27 Oct 2026 19:50:36 -0700 (PDT)
Received: from localhost.localdomain ([240e:46d:1d00:2b84:48c6:402f:d1c5:644a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae55d64c0bsm812447a91.1.2026.10.27.19.50.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Oct 2026 19:50:35 -0700 (PDT)
From: Rongzheng Wang <testwrzwrz@gmail.com>
To: netdev@vger.kernel.org
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Stanislav Fomichev <sdf@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	stable@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rongzheng Wang <testwrzwrz@gmail.com>
Subject: [PATCH net v3 0/2] xsk: fix multi-buffer TX software checksum
Date: Wed, 28 Oct 2026 10:50:24 +0800
Message-Id: <20261028025026.11401-1-testwrzwrz@gmail.com>
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

This is v3 of the AF_XDP multi-buffer TX software checksum fix.

I found this while testing multi-buffer TX with XDP_UMEM_TX_SW_CSUM: a
two-descriptor packet had a bad wire checksum, while a single descriptor was
correct. There was no production or syzbot report.

Patch 1 moves the software checksum calculation from xsk_skb_metadata() to
the point where the last descriptor has been added to the skb.  The old
code calculated the checksum after the first descriptor, so multi-buffer
packets only included the first fragment in the checksum.

Patch 2 extends test_xdp_metadata to cover the single-descriptor and
multi-buffer TX cases.

The updated selftest passes on the v3 kernel in a local QEMU run.

v3:
- preserve unlikely() around pool->tx_sw_csum (Maciej)
- restore the binary MAC literals in the selftest (Sashiko)
- keep a distinct malformed-packet counter out of this stable fix; if it is
  useful, it can be added separately for net-next later (Magnus)

v2: https://lore.kernel.org/all/20261024141157.59301-1-testwrzwrz@gmail.com/
v1: https://lore.kernel.org/all/20261024091256.17918-1-testwrzwrz@gmail.com/

Rongzheng Wang (2):
  xsk: defer software checksum until the skb is complete
  selftests/bpf: cover AF_XDP multi-buffer TX software checksum

 net/xdp/xsk.c                                 |  23 ++--
 .../selftests/bpf/prog_tests/xdp_metadata.c   | 122 ++++++++++++------
 2 files changed, 99 insertions(+), 46 deletions(-)

-- 
2.39.5 (Apple Git-154)

