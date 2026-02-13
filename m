Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801D0283FCF
	for <bpf@vger.kernel.org>; Fri, 13 Feb 2026 19:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771010713; cv=none; b=EpN8QRjn/4O5QtzJ8Mf8QmvLJk9fZTXz5unMMOrwTd4VOSSCBCXwjbz5aXzIpvnZUQveVbZ9EWzsEDeBVfrfDTnnbSIrErsjdkExfpukD1S2csqw2Q78ePfDcjr38AWoQz0HpApWhYGY07c3MKBYQgMXqarVAQzPwOVppr/Ab/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771010713; c=relaxed/simple;
	bh=HxJrMbeqXcLJ7jwAcnLvGHnKT/8SD5w7KYtlEzmthjw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aZcIQCabBm9cLz3k4jWrvlGYaW131HQ0QRjq8rFtcQYoAsob+Vlj5xqYkpXqykp8qMj5Vlt5QPIK0b9/3KYu4nuzF6zg2f4ihOdOPU9akJvD5n2AhGdN/4pdnF3mzr40NABxOD+Ox4tiWKVtspAvGq/zD2GOMm12+QaAHz65tm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=FWAN02l7; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="FWAN02l7"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-45f171cb842so442632b6e.1
        for <bpf@vger.kernel.org>; Fri, 13 Feb 2026 11:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1771010711; x=1771615511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aoOSJwVyB9J1Umbf/jB9a0J8hI2uhGyBuTDAcDO9GA0=;
        b=FWAN02l7RW1EhC+6NVWRdMTquVC4hc/U0UV7RJFD2gJpaxX9s+GfYlOUuNYjODOamy
         Of5rvi8F2kmwoQkV+ol8xogdOD5PuBDUBOg19gmQjiuRJy8rRtx6T3ENms2hoiOo3obJ
         Qs8ra5R6/qVLiBDjJPwPRzNZsG88637hSesSGf9ic5Pj9c3ejzi3QfmLxqvcsFUhP/ZJ
         9MNa+k0zNTUH7XWM3aZDGJXZ2x26c3mOiTMJGUvaC3A9HHPWACGRuToCMZIKBTxVW2wf
         P+6hpjlxZUzxVfjLG/y58QdC6wtBYywkmzsCfpDYxifSsg0aEEwmlkVFFVWIb0VRvn89
         KtDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771010711; x=1771615511;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aoOSJwVyB9J1Umbf/jB9a0J8hI2uhGyBuTDAcDO9GA0=;
        b=sKRxJyjR+Wgn1zoyeAOkaLSs5dI+cCASPEvqNJsXXAhdG+xR2ZgOY3JGBgu6YXex1t
         uKK8MhpGIb7zx3883vkyPgq27sfl72/0lu0uKLtlbJg+Od/Zso+bK2yNqp9+5igoQ3tF
         +Pb4R7FkiUy8cF2lmwHFb7bZG5j/bgckrf3NFz1bQxiBXRTgKnDZv8keBqlMgGF3+36g
         Lw6XQBS+/83Vx2MHtpC+iA+mcUWELcXpyw5/PfwjRWZysRfo63prbLTpVIXm75tafQSK
         KFZzoL4sUPLJbtR9HN3Y9HmC+zxV2j70SZRMpkR6nxsSAkYCKcOnB1LrXQUiTBPkEYxf
         cMNA==
X-Forwarded-Encrypted: i=1; AJvYcCXq0ziAxhaxH4PbJUNn2AMoOOZQAC+IKkdyGkDDpt75dv8vL5Y4z1bihKoUl3ocwBiUVYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgMh6Xr+Iry9P0aix83oHQ/l1yEYEele15ovf9K5K7XYld97OE
	N/Ke3B4ckBOIiJepuW62efaoUMod9o5WWHILMVvbcTi23pLsPz+Ao4or1Lqa+b1gGvOy1jX71V2
	u52IIlT4=
X-Gm-Gg: AZuq6aIufEE3IJrCJqbUXOApj/fgRpbE6zHRL+sSawN77Ub6IsunhrTMbi526Urs4Oy
	ny8XaR47rlVFMkVoKQexMqfeYz41ojw4CVheUuLUC8afAuTjmgqoLU6M1mXP9HEjBF9L7Fxyixf
	y2O69NbALW1xjARFmDLLQxk68ZZCvDknRDxb5GyBTcdT1o3JK9dPTGSWRzVQiFh1kHBDeI1+raR
	y/cO2nwrIzYk4/zGdwLEvn6Nx6iHZ1O4/rXyYYnzSJH3xWZms6UA2gzMO0qEPvAqMwqwKho08TF
	T6vJiCKohTylDsnSiMCZPOjCPM8TofRtKM+STDvkCk3XgYqJ+vv7zgO2S/ZyQmsCrBaQKMpvQPX
	k/iow4h58Rt3qqUlbi1BQzJ8LTHqUXgzvc/uDaQq7UKmgWuEoBNSGlH2vRLHXuB8S3PubHxTtIS
	baj1gd2Iip
X-Received: by 2002:a05:6808:1991:b0:45f:103c:2483 with SMTP id 5614622812f47-463b05c9dd5mr799401b6e.23.1771010711349;
        Fri, 13 Feb 2026 11:25:11 -0800 (PST)
Received: from 20HS2G4.. ([2a09:bac1:76c0:540::499:50])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d4a76f96b8sm6591407a34.21.2026.02.13.11.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 11:25:10 -0800 (PST)
From: Chris J Arges <carges@cloudflare.com>
To: michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	hawk@kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Cc: kernel-team@cloudflare.com,
	jbrandeburg@cloudflare.com,
	Chris J Arges <carges@cloudflare.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH 0/2] bnxt_en: Add XDP RSS hash metadata
Date: Fri, 13 Feb 2026 13:24:26 -0600
Message-ID: <20260213192449.1294830-1-carges@cloudflare.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset adds the ability to use an XDP program to extract the RSS
hash of a given an xdp_md context.

For example this XDP program extracts hash and rss_type:
```
        ret = bpf_xdp_metadata_rx_hash(ctx, &hash, &rss_type);
        if (ret == 0) {
                bpf_printk("XDP: RX hash=0x%x type=%02x", hash, rss_type);
        }
```

I was able to test this with a Broadcom BCM57414 NIC and verify that the
rss_type and hash were correct for IPv4/6 TCP/UDP and ICMP traffic.

Chris J Arges (2):
  bnxt_en: use bnxt_xdp_buff for xdp context
  bnxt_en: Implement XDP RSS hash metadata extraction

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 29 ++++++++----
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  2 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c | 47 +++++++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h |  9 ++++
 4 files changed, 77 insertions(+), 10 deletions(-)

-- 
2.43.0
