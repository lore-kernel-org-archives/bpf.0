Received: from mail-oo2-f41.google.com (mail-oo2-f41.google.com [74.125.231.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E27296BC8
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 00:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790296529; cv=none; b=WDMVM2U/1ugCsvHzM43OAF6fvfccJcTV6skqzY/N+JJDHG4gUN6VhpENmrvWXLBL8D4wGwI8xsAuIr4j3m2MYuJf1X22eYl1OKypnqYsCfpPo0gE3CpJ8eTdPmA5k4/lhMYmjYZDEW/lmnm/53KqLVno5kuGnZwoQkKIsrCGWwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790296529; c=relaxed/simple;
	bh=4lANU3BofogRNYfE4vWKObbLjcbrSe6tKSZmwj46Atg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DetXzZ9VjM+rvTQ/dczi69jCdhs/fIvIIkqCWxnc4CtN3eRUseyOkytUglKnSm2Lg4fUmDYP9lGICJ1nPhGJKwUBbKU6BcKrXHltzm0Pmn5lil6vTJoSAt2yfbF0oSXuXLlJib7KH+5WECMOCsDn48lX3JllvMIFIS7oMOaVivc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K9VvcQYA; arc=none smtp.client-ip=74.125.231.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K9VvcQYA"
Received: by mail-oo2-f41.google.com with SMTP id 006d021491bc7-6b1ae721872so198448eaf.1
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 17:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790296525; x=1790901325; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=yGf2S7+iIEjxwnQ5sDYTKes+bw7Xvh6I4ay+/HABYvs=;
        b=K9VvcQYAunMFye/m5VZPH6bSBvvUfhlHXaBzqrjQiITIeXR95WltXIDJN7q3PsaVlu
         UH0lkJmO3fSkcVXFDt+ZHBidS3diwRuL+qbl1rRgG/ia0ihQrPYy+U873/m6OoT0I4NF
         q1Cf85fienqso7bfpQIHhPa1xH7w4CDUAbXw6Q9aOOSKgPyxexP2o6TDjy5HMtZmM6cx
         VRFJJhAlXNhU4gb1lkYVfnpv05Bx4lrSDACkELFErRxIN4tR14Hd2NmFapczVHTcn7pk
         AV7IFGldpyHswCgtY8a+5Bd2Rj7I2aN/+R4A0DwjQSiWuWwdWFGQ0E82yvfOXrxckDM4
         nFJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790296525; x=1790901325;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yGf2S7+iIEjxwnQ5sDYTKes+bw7Xvh6I4ay+/HABYvs=;
        b=WN14QWMnv+MrSU3ziPc2X4XIdAO13NH81AiSg+7/iACnowi11wzMNsokN02yHo55tB
         MAmifBxO5eb4eO4NUuHDCs+DcyK4EKi8TBVS1MJJm2Jt6WAqqfVApMaHdtlEt9Ad7YOu
         287czXvGFx4cteeLi5THW+HZhwtD3d1rm7SZ+HPYFAdS3EW0BQCUIvPT1rqrfz3TdmIu
         gYuSyYlF6XPyeMQImeIO9nWpRveQWE51aczHKFJQ4rlp/F6OWMBhf5WKNd30SUeKnfEO
         s9U3XO7hlUts9+BFsJYp7+qsyZooCdpgTyWbEbK5JTcTRuvIcClrPK7ksAR0fRo+VhpP
         D73g==
X-Forwarded-Encrypted: i=1; AKwUvBzM7I9zJCEAfvu/5O3wnXM2/L6gXiSOuvmN/BHPcCQvGhAVPJ+4+KonUeDkx0jE/7+Yvv8=@vger.kernel.org
X-Gm-Message-State: AFuF++msjV94jGdWH4H4BZz+/CEknoNm/V2NPztzoI+sJTSz3aVYVR2P
	N4EeAYVqzR59wDUZHvavpCJRABnyh32uTo7XsKEcJ0wp9u9sN8+VZnZj
X-Gm-Gg: AYBFou0FoLn/48aSuyj9OCQsU/5qVyaFGi0Bbt3gEUh/U9sHzj8Y8KCeJf30SLaCXMZ
	lkXBaqgh8W5+kMfno/sEDu17m7NRE103lIXS4i8UayUmSMnAaqXOPQ1OhXQd9Cyn5NdcA3P80qA
	12NbnMWDVSJRf8qJlxif2XsofM6sb1mLSAdwGHrYBB/eNB6SBNVDrpN8s+yNW3P30ft0au9edqu
	QMuRyvqZlZczvgmoNThZ9y+MFJhEeIkN6MH21rotuC6JArrpWfLYIcOZTf9af8R+AUlJUdM65gv
	EpJ8VRQ2kVlnjhTQiqsa2xFK+IwwMkYSLpJnNf25YWmXTWFRupE3vzsq1lw5tnUBq9q73is8Nj2
	X93pQw9aEcmWJ3GOxHnxMPllkYaQRZbd8se5bOfYM+9vm8nq4FDxKAq/CTA8F68beYVr/M2doB1
	PBfjCvlCsh8hHL/6f4eBqPBxHGmfS0qoLY/hqMhnI89tomJ8JRurQ8BQ7b7gtRtH35
X-Received: by 2002:a4a:ee10:0:b0:6c3:616d:efb with SMTP id 006d021491bc7-6d43ebf032emr4594513eaf.17.1790296525381;
        Thu, 24 Sep 2026 17:35:25 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-49335c8040dsm894146fac.11.2026.09.24.17.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 17:35:24 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
Subject: [PATCH net-next v2 0/8] eth: mpnic: initial support for Meta
 Platforms NIC
Date: Thu, 24 Sep 2026 17:35:13 -0700
Message-Id: <20260924-linux-mpnic-v2-0-4badc9b58b9e@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMHBtWoC/1WNQQqDMBBFryKz7pRktDZ11XsUF0EnOqBREisW8
 e4NdtXl4/Hf3yFyEI5QZTsEXiXK5BPQJYOmt75jlDYxkKJSPbTBQfx7w3H20qBxNtemveXKWUi
 LObCT7ay9wPOCnrcF6mR6icsUPufNqk//KxL9FVeNCikvTVG4lL3TsxutDNdmGqE+juMLPQtjs
 bAAAAA=
To: Alexander Duyck <alexanderduyck@fb.com>, 
 Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>, 
 Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 bpf@vger.kernel.org
X-Mailer: b4 0.13.0

Meta Platforms NIC is the second-generation NIC from Meta. There are
quite a few high-level similarities to fbnic, but all of the CSRs and
descriptors have been reshuffled, and new features have been added.
Since the device is sufficiently different from fbnic, and the design of
our FW is minimal, we have decided a separate driver is appropriate.

Major new features compared to fbnic will take a while to land. This
series includes only the bare-bones Tx/Rx datapath.

Our high-level patch sequence and plan for the upcoming series is:
 1. Core datapath (this series)
 2. Basic offloads, RSS, and counters
 3. Firmware mailbox support
 4. Base ethtool operations

This patch series was prepared in part with these LLM prompts:
https://github.com/kuba-moo/ai-prompts/blob/main/driver-upstreaming-prompts.md

The prompts were used to distill our fully-featured OOT driver into this
minimal Tx/Rx capable upstream driver. We then performed human review on
the output to create this posting. Jakub has made the prompts public in
case people would like to take a look. 

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
Changes in v2:
- eth: mpnic: add register init for the device
  - derive the TQS TXB credit limits from the TXB private credit config
  - program the BMC to MAC XOFF threshold (TXB_THRESHOLDS_P0[16])
    instead of the host to BMC one, and drop the now unused
    MPNIC_TXB_BMC_THRESH
  - drop L2_HLEN from the default TWD, it only matters for csum/LSO
- eth: mpnic: implement Tx queue allocation and cleanup
  - add mpnic_nv_irq_trigger()
- eth: mpnic: add a netdevice and basic Tx handling
  - trim the real Tx queue count before register_netdev()
- eth: mpnic: implement Rx queue allocation and cleanup
  - drop an inaccurate comment on mpnic_bdq_desc_unused()
  - drop the unused data_truesize field from struct mpnic_pkt_ctxt
  - trim the real Rx queue count before register_netdev() too
- eth: mpnic: add basic Rx handling
  - skip Rx cleaning and BDQ refill when polled with a budget of 0
    (netpoll), page pool must not be used in that context
  - keep struct mpnic_pkt_ctxt instead of replacing it with a bare
    xdp_buff, and move add_frag_failed into it
  - give each Rx queue only the NAPI budget left over by the previous
    ones instead of the full budget
  - sync Rx buffers for the CPU with page_pool_dma_sync_for_cpu() instead
    of dma_sync_single_range_for_cpu()
- Link to v1: https://lore.kernel.org/r/20260922-linux-mpnic-v1-0-236844f53072@gmail.com

---
Daniel Zahka (7):
      eth: mpnic: add scaffolding for Meta Platforms NIC
      eth: mpnic: allocate MSI-X vectors
      eth: mpnic: implement Tx queue allocation and cleanup
      eth: mpnic: start and stop the Tx HW queues
      eth: mpnic: add a netdevice and basic Tx handling
      eth: mpnic: implement Rx queue allocation and cleanup
      eth: mpnic: add basic Rx handling

Mohsin Bashir (1):
      eth: mpnic: add register init for the device

 drivers/net/ethernet/meta/Kconfig              |   13 +
 drivers/net/ethernet/meta/Makefile             |    1 +
 drivers/net/ethernet/meta/mpnic/Makefile       |   16 +
 drivers/net/ethernet/meta/mpnic/mpnic.h        |   66 ++
 drivers/net/ethernet/meta/mpnic/mpnic_csr.h    |  319 ++++++
 drivers/net/ethernet/meta/mpnic/mpnic_init.c   |  556 ++++++++++
 drivers/net/ethernet/meta/mpnic/mpnic_irq.c    |   64 ++
 drivers/net/ethernet/meta/mpnic/mpnic_netdev.c |  186 ++++
 drivers/net/ethernet/meta/mpnic/mpnic_netdev.h |   35 +
 drivers/net/ethernet/meta/mpnic/mpnic_pci.c    |  187 ++++
 drivers/net/ethernet/meta/mpnic/mpnic_txrx.c   | 1395 ++++++++++++++++++++++++
 drivers/net/ethernet/meta/mpnic/mpnic_txrx.h   |  151 +++
 12 files changed, 2989 insertions(+)
---
base-commit: 42a9fb3382fc2573e92f41d203b095d9a372cfc9
change-id: 20260918-linux-mpnic-8fa318d530fa

Best regards,
-- 
Daniel Zahka <daniel.zahka@gmail.com>

