Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE762EB5CD
	for <bpf@vger.kernel.org>; Wed, 18 Feb 2026 04:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771388277; cv=none; b=Fw2GLEvHuLeRSfzJwhZbchV4khwPMBo4YRYTC08Vo4glu2kpWVhaQAhfaYSXrLkC70y5BJQb9xxKjfcIRCJMpstKhOLt3g4NXp5SIfc2OuOUffi8dbH+qZ0fEHEK0QIUiLl7fuEgDDzsZIrmgWhqUM95eeC7ypc+F3Wmr0/KbdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771388277; c=relaxed/simple;
	bh=buDniwPppzJrGVOjBeL8+qFvwMiSlPJFeI/3U5o+Z8E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VDP3XJX0bLoystYQBD+WitFSAmfcAXu79sWVBiGdLNmU4AXcKIBN7kH0ZamWH1Ph602vnDSHfJgUNveiVitkShfjEAFEtPkAVzeLvB9pBy9sEtPJPYKpi7NK6KzpemHkMBDCRoQ0ySJ5IRKOIHDSPazA/zPwiJTtGi3c6RLojGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EOYSANwZ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EOYSANwZ"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ad32708177so11495885ad.1
        for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 20:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771388275; x=1771993075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NQRKTlFA2C03Hko9lNIUE0/dQo3+GelVNiCBLYxEf+8=;
        b=EOYSANwZV6Vy0iHJw+O1iVFumT5Idl07rT6uOcESKB1y1189udF8W1Ke9beTXbzjVb
         5h18lOu5OqtBXG2zEc/V0nD44MOBv7RKPmSw0j/pfKVaStF5ARues+aZxKP4W3f5abx3
         yD+L4iK9DtNI1BVbULU6g7kgfP6xLF9feYzh3BRzOphKI6t9jSQO8fvyFQMlKmpENFol
         f9hMs9Tuo5akZQwvmn3oDsAKltvnWxtbh4hwnsnV1n4D+bj7rYNmX15fhIlkGons9FuN
         aelA+aBkzP+u7ocS15L8iVnMJ3HeaIl7zjVgzZk+HOJ17ALViqPTvRzu3iGJipsPobUm
         KbTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771388275; x=1771993075;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NQRKTlFA2C03Hko9lNIUE0/dQo3+GelVNiCBLYxEf+8=;
        b=db/+ONmfK/t/pPV/hNrD4tIq7HVli7ACRG5oUwufhevPm1cG3ug88Alimrz0x0AVkt
         bh8HFUZeNXD8Il8po7q3xo9UFGsnm4QZupbVM2nPsTWoiCBPSK0zxERQ9s8T945idUVO
         Lj2Yy1pfk92jQ44VdS5FuA6gfHwEDMGljcOZES6AMbAz5d/pu1BLnQEbq6sHFTK1LAw0
         4QCuxLD0SnniNuvXe/yasKc5r4TC9LZP188xDaHwKqfjghxytbvSAhLcGED/ONi0ROi0
         6aHPax8CKYk8XePYOdPtFXyP4cU5ZnGbtcqFOl9hVi//4AsTQMuas9qIsYVMdKPCRolk
         ytEg==
X-Gm-Message-State: AOJu0YwyGKFnCYUQ7dzE07SmuDizf3AbQN27NBSMFGzwudoeJ0hg6fdT
	Bhb/5X1LvYlby7GvcjRxsNQpbC6OG8EGe2VH1JXLoGDeBknjU3xEFryJGdn6QMwy
X-Gm-Gg: AZuq6aIgDqhGsQj4S4AEr5GM5MxXRvlOtfxyrHrpg+QsfF+mXvFrpQRIOajXny7pIIq
	aHaY3G5qkLOtWU4TVo9S+AYYY8PmJuOpbtkOejI8Mhqw6m+agEzXC+5baXCV+qB2/+dxkuua9g4
	HG+yzBrmSQaPpn3yfTUZCQA2oUMCZypiHRrvvM9BJz7W15kAeLQZG7VIXW6baiXmFeziWZYm6qC
	3MuQGTWuosMMe1vL/VBAFLt/C+qOyuQ1IcbIvS/88XkbWIWaqgfCdr3zcd64L1yetTV0oSvPDm3
	/wexvAvePz+ICynKpgGnw2KkSw6hj0RIRk+aJ5AZTFfaN7tJkW9u9+uIjQRzYzaVO1aWCHAY/FG
	mw96jfZmuw3K8FTimz+8yyttX68mbSbNeDc3OAq1LsokyFMAm6FtW4Rum+e/yoyY7xxgzFgL3gR
	ECiCzyLkaW4CMqHjrOvtFEgJB8pDmHhRPn/oBCcxHea9Au+flF975ucFLETzzmL3vwPMUdSicCu
	lsbJtdyWslCGX7/NvV6AfzDwBdgV/aCScIQALOw
X-Received: by 2002:a17:903:b0b:b0:29e:9c82:a918 with SMTP id d9443c01a7336-2ad50ecd9bemr7677975ad.22.1771388275238;
        Tue, 17 Feb 2026 20:17:55 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:c906:adbd:f506:1dbc:e3f3:e38e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1aaddc46sm118618985ad.73.2026.02.17.20.17.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 17 Feb 2026 20:17:54 -0800 (PST)
From: Anand Kumar Shaw <anandkrshawheritage@gmail.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: kuba@kernel.org,
	ast@kernel.org,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	davem@davemloft.net,
	sdf@fomichev.me,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	linux-kernel@vger.kernel.org,
	Anand Kumar Shaw <anandkrshawheritage@gmail.com>
Subject: [PATCH v2] bpf: cpumap: add missing XDP_ABORTED handling in xdp prog runner
Date: Wed, 18 Feb 2026 09:47:45 +0530
Message-Id: <20260218041745.36791-1-anandkrshawheritage@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cpu_map_bpf_prog_run_xdp() handles XDP_PASS, XDP_REDIRECT, and
XDP_DROP but is missing an XDP_ABORTED case. Without it, XDP_ABORTED
falls into the default case which logs a misleading "invalid XDP
action" warning instead of tracing the abort via trace_xdp_exception().

Add the missing XDP_ABORTED case with trace_xdp_exception(), matching
the handling already present in the skb path (cpu_map_bpf_prog_run_skb),
devmap (dev_map_bpf_prog_run), and the generic XDP path (do_xdp_generic).

Also pass xdpf->dev_rx instead of NULL to bpf_warn_invalid_xdp_action()
in the default case, so the warning includes the actual device name.
This aligns with the generic XDP path in net/core/dev.c which already
passes the real device.

Signed-off-by: Anand Kumar Shaw <anandkrshawheritage@gmail.com>
---
Changes in v2:
- Pass xdpf->dev_rx to bpf_warn_invalid_xdp_action() instead of NULL
  (Jakub Kicinski)
---
 kernel/bpf/cpumap.c | 7 +++++--
 kernel/bpf/devmap.c | 1 +
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index 04171fbc39cb..15c377fe4b0d 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -195,7 +195,7 @@ static int cpu_map_bpf_prog_run_xdp(struct bpf_cpu_map_entry *rcpu,
 
 		rxq.dev = xdpf->dev_rx;
 		rxq.mem.type = xdpf->mem_type;
-		/* TODO: report queue_index to xdp_rxq_info */
+		rxq.queue_index = xdpf->queue_index;
 
 		xdp_convert_frame_to_buff(xdpf, &xdp);
 
@@ -221,7 +221,10 @@ static int cpu_map_bpf_prog_run_xdp(struct bpf_cpu_map_entry *rcpu,
 			}
 			break;
 		default:
-			bpf_warn_invalid_xdp_action(NULL, rcpu->prog, act);
+			bpf_warn_invalid_xdp_action(xdpf->dev_rx, rcpu->prog, act);
+			fallthrough;
+		case XDP_ABORTED:
+			trace_xdp_exception(xdpf->dev_rx, rcpu->prog, act);
 			fallthrough;
 		case XDP_DROP:
 			xdp_return_frame(xdpf);
diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index 2625601de76e..aa2e929792c8 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -346,6 +346,7 @@ static int dev_map_bpf_prog_run(struct bpf_prog *xdp_prog,
 		u32 act;
 		int err;
 
+		rxq.queue_index = xdpf->queue_index;
 		xdp_convert_frame_to_buff(xdpf, &xdp);
 		xdp.txq = &txq;
 		xdp.rxq = &rxq;
-- 
2.39.5 (Apple Git-154)

