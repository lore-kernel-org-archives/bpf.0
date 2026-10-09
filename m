Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7524CDDC9
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 11:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791545722; cv=none; b=p0jCZy/VCrvf+dNsfatVD5xb/yVO2cVChLTNoWGQTTND2l/XjEX6tnrLqlGb2Oto6J/Krg9ZgoW7Uz5mLaLJcSxDmtmXxJ9HjhRXqNYlY1yk/3A/SFbUA2PzT0nrHUnlA6ZHI9FTm2fblTVcRlyUC6NlrLG8FdzwYXnpC0Hdr7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791545722; c=relaxed/simple;
	bh=2R2FAHfjSDMObepA1OdjpbsG4zBRUy4e93IUDKml36g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pqX0Ei+78DbA1OTaNJL2dWMv8GiIwNOcGr35svBt8d+4JRWvjb3r6UbMRpSVmPmJGgkmrynVme6nFPE9X3ve8UosXAhlFyjLpFwm9rK16kj3OqmJp2XWDIdS1JNKFK99zhrB2SKQAAKgNZBQtGdChSQ/ijyNwpAWDNfwBBaPNlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HO2gQITE; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HO2gQITE"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-48ed0b68895so2388245fac.1
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2026 04:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791545711; x=1792150511; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=q8+wh/N/g5AwFI5ghv77Z+PvaYgxRtZHcThuJwPsrFA=;
        b=HO2gQITE6M1SH9xUCNzNQJmFKHcCDtSeBKmKu45Dg9SGlPa+718IEjjg/aP4uf4XZ0
         o3WQLWzTAlJ6TsN71f7APaoYDH+0o1RX8p7bdHLjvjPtgOxkBFllEu4wUYKDrI2xCswi
         AV3EiFtx0wsLzloyqgptEPzQbfgamq/lquZBSR8KyZ7PxQSAc2U/HFG+I2tP+MEaI/cC
         UZH5sGdQhxvvo21Ls6xEAIhG6dizoj3PC9dvrr8k+ALc5qkzF5ldppdtMd9o+B1YFJpV
         vpOSiBak8qySBJfz8ul6zhgUlQEC/tD+bz/NGAsecC/Nw/OYedNQo/hOKGWEFIAj97B7
         Yk9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791545711; x=1792150511;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=q8+wh/N/g5AwFI5ghv77Z+PvaYgxRtZHcThuJwPsrFA=;
        b=QPsAS4+kq2nEI+ircRHoTgxrmYr6xg35FeXA1JWxuvgiuPsnPvG1Qpvb5fDumUIR9p
         AMoaL7BdHb4yXdobXcT4DtzD9qzsLCa11f2gTHLvc7SWgmJg3efrbSUF34wreUyI2mmc
         cGXcqLy7dc/EFntrY/VboGg6uHrCvtNl7sZ6s6IL4BIpLmpsWZBwAWaNcHXrwgBxUVer
         FTJFSTzgTyNUbH3j58lHYXB3lLv4XnJ8Hfs2ryXofY3iQjL3NccAqyrET3EPefYW+bvP
         CerCVR0+Qy/bJ8GqJT6uE1HhSian6250Es+pjs/ckO+vO1GviEK0ayHrq/Ly0ppEZ9Jj
         pl+w==
X-Forwarded-Encrypted: i=1; AKwUvByoIbeKQrQh3TmuO5t2Ni2BNLv0DthJ6UucU+a76lOyXl01gxdCUz6UGZR4TYb5KT25OpE=@vger.kernel.org
X-Gm-Message-State: AFq9FYL8p/IzNsEDpAVABLDkw4V8v4+NBLWCx2FwkhDXeETmlVWBgpRj
	nf08quAN75cgeO4pF/5nWkz4VrfhiMHBNGUddbTupkthLkW7/nnmn+Lf
X-Gm-Gg: AYBFou2IYrCAh0caNIsbB7Urf80g9Pd9pT6Tv6ASVNu5myIsT1t+eXvoYY7T/YJRp6g
	CSlUYvUqqsESg6gRwemG3eZxwsOQFPT6/dHhN5DArUAD73E1xgn3PGxNjAUqesc6Buh1y1OX+Ar
	YqDCBs1hXB63dqzXQDm3xmm3rSBd58bcCJoc/zgnxAJ8gaSVPOTAIjmTcZjcgtrhyFcoXT5KDxd
	RVLcevPdTSiRTt3+gzuYgtGiMjLcoMEsGdEkzE0qz1PRg1dYFi3J8sIjgSg+q3TcDCAC1t7t0F5
	6QaVEDne0PXNI6vYlqG1s8ajJIJQoRj7Uoadsc8Z/+AHjid0fseahY0pGJc93E84ju9prcm4UQQ
	353hdDWoHHJKaep3qmIvo+g3u9XXvfyDbB4yYyaFNe+xry77+T62m+Ok9+Z9L0DmsSAMup8r/Q4
	E4fcDJ6r1dOUCB5GC+aJvyU2XW+ZVn40NU4rY4QLwWs3eMaB/5MOEIm/GSYnCvLz9QPO8F
X-Received: by 2002:a05:6870:2803:b0:49d:6a41:29ff with SMTP id 586e51a60fabf-4a2a89b4321mr1308706fac.51.1791545711234;
        Fri, 09 Oct 2026 04:35:11 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:71::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a2a84a1457sm1374829fac.4.2026.10.09.04.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 04:35:09 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
Subject: [PATCH net-next 0/4] eth: mpnic: add basic netdev statistics
Date: Fri, 09 Oct 2026 04:35:03 -0700
Message-Id: <20261009-mpnic-counters3-v1-0-7dc7644cc500@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGjRyGoC/x3MQQ5AMBBA0avIrE1SbUK5ilhQg1kY0pY0EXfXW
 L7F/w8E8kwBuuIBTzcHPiSjKgtw2ygrIc/ZoJWuK6U07qewQ3dcEskHg7Oy1pqprU2jIVenp4X
 Tf+xBKKJQijC87wd+6+YgawAAAA==
To: Alexander Duyck <alexanderduyck@fb.com>, 
 Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@kernel.org>, 
 Eric Dumazet <edumazet@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org
X-Mailer: b4 0.13.0

Add basic netdev statistics and report them via ndo_get_stats64 and
netdev_stat_ops.

Track per queue netdev statistics such as Tx/Rx: packets, bytes, drops,
etc. The driver keeps per-queue state for statistics that is updated
mostly from the NAPI poll and ndo_start_xmit paths. The stats are made
available through the usual driver APIs.

When the netif is transitioned down, the per-queue stat counters are
folded into a global per-device set of counters, and then when the netif
is brought back up, the per-queue counters start counting again from 0.

Extra care is needed for implementing ndo_get_stats64 since the instance
lock is not taken. When ndo_get_stats64 races against ndo_stop and
ndo_open, the reader can attempt to read per-queue stats while the queue
count is changing. To deal with this, the writer publishes the
aggregated base stats and the active queue counts in a single RCU
versioned object.

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
Daniel Zahka (4):
      eth: mpnic: count packets, bytes, and drops per ring
      eth: mpnic: report per-queue stats
      eth: mpnic: count Tx queue stops and wakes
      eth: mpnic: count Rx allocation failures

 drivers/net/ethernet/meta/mpnic/mpnic_netdev.c | 182 ++++++++++++++++++++++++
 drivers/net/ethernet/meta/mpnic/mpnic_netdev.h |  29 ++++
 drivers/net/ethernet/meta/mpnic/mpnic_txrx.c   | 185 ++++++++++++++++++++++---
 drivers/net/ethernet/meta/mpnic/mpnic_txrx.h   |  30 ++++
 4 files changed, 408 insertions(+), 18 deletions(-)
---
base-commit: d8674294aefef02266c4d47ad10131f1bffbe534
change-id: 20261002-mpnic-counters3-d08883b96372

Best regards,
-- 
Daniel Zahka <daniel.zahka@gmail.com>

