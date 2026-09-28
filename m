Received: from mail-qk2-f40.google.com (mail-qk2-f40.google.com [74.125.230.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF22649CF39
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 13:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790601306; cv=none; b=oQMu1w6TjUdAV7rjtyC65Bp3NX2C5N8girZ1/FXsaA0tBSJa40cCSC4ovQ+DJnjXjnJh2pq6wWA5xlJWnwDhEVxPIYDiCRb9UF8d8Zcr/rR4WLW75nuZKNqou6zStncaNxQyk6esTL+Q5aYTAKaUTfZ2B6ZiRHC2NDY4sbEfZqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790601306; c=relaxed/simple;
	bh=KUBocqw5cboHcSNnT0W6/Ucblbw9xsAcwi4MHpF6L5I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qxfqN1+A7/dHQ5xwzMstJsqov081bkrYY2GykHsW0w28uVil6uQqhMcPSyf4TXjAkREljMj14JpAtCSRKQ1EhBaSNm3VqtSjh/L2PaOuVYRVTl87DWvmYcPVrePKpP2mBWcLJvWJ1gljBlxSSe23qjhfFtNUID7Dqke+EdVEaNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ozQjR7wM; arc=none smtp.client-ip=74.125.230.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ozQjR7wM"
Received: by mail-qk2-f40.google.com with SMTP id af79cd13be357-93c5a837375so93191685a.0
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 06:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790601304; x=1791206104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=X3V0idLX7JfHuxhG0y/iym7zpN4jxFLNmH6tSltjyP4=;
        b=ozQjR7wM1LJZEEDbuWhxCOptxQgXiGL6lG8Y4t81jqdi7boHroPmYTz84pDw6BaybV
         hQojzTMafsD5jVkKNwZao6NFvKvqXTcbDks3YnWZnDTR4TAgY7ExMda10LSOlTwZBJqz
         hwazNE6T+N7g/TLd0YyWaZkFjm+Ar1lr0SPjI9xKMQ1eqYzsYlOCOJtoxerDdApwCdlv
         YBM8nCqkcaKSlSU2ZtAaZVei2GMj1XnMoYkgLSMb7zIdhJ6GM4jcCrmE0zD4TCVQHBkO
         9W3KGzmdglSOfYdCqMriqzWj7auL/VL9AF0d+Jjq8+KaVEaHPoQpGiKq6FoU84Edht2p
         d3Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790601304; x=1791206104;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X3V0idLX7JfHuxhG0y/iym7zpN4jxFLNmH6tSltjyP4=;
        b=AnE8psS98igP1z2aKWWjwaCCzbKph51sPBcaT5xlLHFvknsbav4ZnqX+jht8UN0CGH
         LhW9CSibO74YD3MNLdyHTeZ5aLMZS/tGx8OPykfZ3eSPbYPd+tFPAnjrlovsGfZm1qOU
         eGnCeBNx+ATRKbZBSG/NyKLxsGniK3wK1jDbE75LKVPx1S8iNn84FYWDSbINpo5KSu9t
         sT/TqjYMCwOFx8ISldOrY4YeVoN57MCMv63H/J3OX1Zmelkygsw7GfVD1LswcgT4iEq0
         HNCPF2fu/k3wcx8LoArT5ucse1IWhSCPsfFidFXFWa3abJsdqmg0e1c4kF0mjcFKU/VM
         Iq+A==
X-Forwarded-Encrypted: i=1; AKwUvBxzp3F3gq6kX4EwobwopBb5w0pXaDqMx3bR/GHbZPhXXzezHLF+NVqmCwMSvCMhi/Nz0VY=@vger.kernel.org
X-Gm-Message-State: AFuF++lIBiTr0SBx9LsgAEstQI4WvjmTCO0o1zaSGirKfNuuhZzRERM1
	ZsjejKufb10ReFqWv0PK1MWdQo0Q6XvjQdm/Ebpj9xrwMLBLBPC7RuOK
X-Gm-Gg: AYBFou0CBODGJp+zweftkbA9NyudbozrAiVNh9vlyceS5/JpGnR6q7hlfU798fNUSia
	wcanM7Je9yUe+UilzhltpSXhnzVMZwH1PiZOPt1aoc3sUAgZCjVfmPeI28zt4JvLZim70jmLavt
	LbHRDbMipy9QyvKfCV+olVN4f1c0tX+flhdZsu5hpB6T1NqsrDk07mRRsDEmpu/fAokW4L8tIOC
	W7hmYqCvUwTUE0JTrI/A2G48x6spwbepYCbSAC8YX93y5wt7R7jgHAuYNtL9MmDmTWrzWXtetFr
	23vSCgUOZwingSQomzANpUXjWuzo1EHhvY0JIl7FyHZA9orWIc+/ZISFf5y2h/3tNtO+HmJA0ux
	+/8Q/2/9hcQ4DMEPcc3Rh4usqnEYXPjOsnOF3g6rZllq5Cpsau9nHHP9wkwRLTnYmkNwVuOF9Tk
	sjXH8JR8xLvEgfNduvikG8+cAgLmZelIQx4o6P/QY7rmk3NBPZL7hGgI30kxi2tqs0KURP5zUO
X-Received: by 2002:a05:620a:31a9:b0:93b:d7a4:9d4b with SMTP id af79cd13be357-93c43db7b1amr2012446885a.30.1790601303558;
        Mon, 28 Sep 2026 06:15:03 -0700 (PDT)
Received: from localhost ([125.16.97.114])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c813a5ae6sm145555985a.13.2026.09.28.06.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 06:15:02 -0700 (PDT)
From: Vaibhav Nagare <nagarevaibhav@gmail.com>
X-Google-Original-From: Vaibhav Nagare <vnagare@redhat.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vaibhav Nagare <vnagare@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH net] bnxt_en: don't leave an XDP program installed when the open fails
Date: Mon, 28 Sep 2026 18:44:58 +0530
Message-ID: <20260928131458.1012180-1-vnagare@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bnxt_xdp_set() stores the new program and drops the reference on the old
one before reopening the NIC.  If bnxt_open_nic() then fails, ndo_bpf()
returns an error with the new program still in bp->xdp_prog.  The caller
treats the error as "nothing was installed" and drops its own reference,
so bp->xdp_prog is left pointing at a freed program and the next XDP
update dereferences it:

  BUG: unable to handle page fault for address: ff78ecc80ddd1038
  RIP: 0010:__bpf_prog_put+0x5/0x80
  Call Trace:
   bnxt_xdp_set+0xad/0x1b0 [bnxt_en]
   dev_xdp_propagate+0x36/0xa0
   bond_xdp_set+0xeb/0x2d0 [bonding]
   dev_xdp_install+0x1b1/0x350
   bpf_xdp_link_update+0xc5/0x1b0
   link_update+0x104/0x1e0
   __sys_bpf+0x662/0xcf0

Seen on a 6.12 based kernel after bnxt_alloc_mem() failed an order-4
allocation on a fragmented host:

  bnxt_en 0000:a0:00.1 ens4f1np1: nic open fail (rc: fffffff4)
  bond1: (slave ens4f1np1): Error -12 calling ndo_bpf

Bonding is not required to hit this; a plain XDP attach on a bnxt
interface takes the same path.

Restore the previous program when the open fails and release it only
once the change has been committed.  The ring and feature configuration
is left as computed for the rejected program; the device stays down on
this path, and reconciling it is left for a separate change.

Fixes: c6d30e8391b8 ("bnxt_en: Add basic XDP support.")
Cc: stable@vger.kernel.org
Signed-off-by: Vaibhav Nagare <vnagare@redhat.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
index 9e5009be8e98..f30ce644e377 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
@@ -419,8 +419,6 @@ static int bnxt_xdp_set(struct bnxt *bp, struct bpf_prog *prog)
 		bnxt_close_nic(bp, true, false);
 
 	old = xchg(&bp->xdp_prog, prog);
-	if (old)
-		bpf_prog_put(old);
 
 	if (prog) {
 		bnxt_set_rx_skb_mode(bp, true);
@@ -435,8 +433,16 @@ static int bnxt_xdp_set(struct bnxt *bp, struct bpf_prog *prog)
 	bnxt_set_tpa_flags(bp);
 	bnxt_set_ring_params(bp);
 
-	if (netif_running(dev))
-		return bnxt_open_nic(bp, true, false);
+	if (netif_running(dev)) {
+		rc = bnxt_open_nic(bp, true, false);
+		if (rc) {
+			WRITE_ONCE(bp->xdp_prog, old);
+			return rc;
+		}
+	}
+
+	if (old)
+		bpf_prog_put(old);
 
 	return 0;
 }
-- 
2.55.0

