Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795438160;
	b=wsKIyHaiGAOgDDusFqE/DLCbPAtEZurL4kT4gopJrm4dsfxx2uvk8Ehj0fRXMd3U7jL7
	 5fQt/SLNEf1tJIDKaLxGA0rZ+pFC5C67rC6JroFUAtBRwSVSYkPj9SJnCiPLs8lPba9zc
	 18zhh4d/lNaAhl3mHwBopU+hKAJB+YfIVutUAOhf64wuRJX46ymdxgFCX6Ahh7mGmUdN6
	 FeCcncgXmC2GqEe3vvYR62VQB2kV/FvcOhOSPORY3LkjOHCPO7AY2xdJQUiSF8WBBl1BX
	 4qYw9l3r0Ajz5XFNFkUJVbfU1zqT9IfX6GbMsfafdq/sLnQ9pmmdXM9u5jsPHSDkSOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795438160;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=bferII2lyA/H1hIC/5y/64FdLoV9XxlRkIiuA63uNpY=;
	b=VIyMDD1/eo/KUJT9nqcYZtfXYDC6vjHNHEqbMtQ2cA8Zb4eBwXYBS4iN7XWk1nAuAOMq
	 /gwCblN6YWfEJx7DIpx7x1XnxBWEzckPSLwwhmhQ+3ZX/cH2v8m43B5JjxABR7aHIGsjW
	 YOAe1MbRcJDZp6w1oUjgDEnCea3CWC4XhQe9A3TxlrHJNqOXcpIHjn8irUZfN4sEFKASC
	 ravUzNs/84zkkQWhhvFOAM6WIONXf/MikGvWP/TzWhkiCv2Z5Q9i0nbzSDU+vpuLR+aCK
	 +1q1UWF4hx4UkrHEGGeigqvvAXb9bFJh+oGu+Hy1mKHxWAFEw+IBilWyXre0oBP0nuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="G0nVqK/2";
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63533606A31E
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 12:49:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63533606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G0nVqK/2
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a1fbd52ab6so21921755e9.0
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 04:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795438159; x=1796042959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bferII2lyA/H1hIC/5y/64FdLoV9XxlRkIiuA63uNpY=;
        b=G0nVqK/2ApMbbi1v22uCMusPzgKZ6T7NzkA2JDYahvJcl5XsbXDnhqtOMQWHV1L2D3
         cl2c8HIlxLMLLorroXlD/cDj/oHbFa5NBG2jpfPzetQDYEYneB5V31pWBEpv5Tp/EGD4
         bzQKy/xpDsTJRo9uXfkUiY6Riqx5h5EagNFrW6LZW0AZDyp4m2CmNulNHnUWXEpQOuap
         DNk+H7ndNwxPaK07EJQS9YIoKTiwjcmQ+7y15YBJzxYfddeOTwTR/ZcZKuzzMOfK5uR4
         PznHTsPUAvR4ppyOh2vtzKhkSKSDDMbNi6Q0ZCBC4Q7Xf72fNMOqWPIGucqaEF0dTmOh
         vHzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795438159; x=1796042959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bferII2lyA/H1hIC/5y/64FdLoV9XxlRkIiuA63uNpY=;
        b=LiVWvl6ErZRhtq2p84ap/RoBUFgRcz1iAbU2+mF2sZQjEQrjGDlut8b1djBG5yuBBc
         qzAnMTyneYuJ0wNBW4nEfrsA5j+oGv8tTwoOpEl5LLOAGfn+nJ/Gmr0AuIWLKHYUmXsR
         SBmUhme38qu3iCyly1eXd+hBiVYd+IKNpXMW+LoKphhRsm5fqa2g8aVJMIBmE8yvgt2/
         ramZRolVpfn9WVhXnaQHrPVnmTbNHhA1KcapuESjyXTd2f/jX5d4sLDSzwYK6YTumXb3
         dP3x4bPT/g4IvrAsyPxntaCr/oi1yyp0fBPpxqSJlY6zciyeYRcoSE2WPDldSmXq5joN
         5QcQ==
X-Forwarded-Encrypted: i=1; AL+hErE/AfYmk+riOvxg7C7nDp3Pzeu6fzBOt+tbO4dnDy5a5YPBF7DNCU/gLLGNMFdI5ETrxY0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/ucCV0PJwTPW/z6fJjcGFvgK4GF2fQ2fETxqCmLz3marWYKxWr
	69BAaHLHY55l/Lzp88PvA9jPDC676zfVnNrmARMBdWHF62McuietdYa8
X-Gm-Gg: AZFdTZcTnZVi0Rv2lWnetdiNv8022DqXJJsZFGXqZnXqbUUO5ffUBSLvHbFC5TxlrVy
	00Igb4f+DWkJ84+lnM5JurehzSCq5Rtl0aLft2wk9w/2P7t/sndIEFVvjI7PZEF7TuW8896sHX3
	Dn1gLJB9sLtXUx1VHbSd3u5TuibesBJ9gDOI5HlkJE2KNOxOKAPOnt/V1M/MzwinIbxESOyYsri
	vahKJAF+jVf3GECq2Pk16dZxyjN/3sC2Etd3blUZBTHGK/AL5V6PTLnNPKMyxUEZIw8ehCfciYC
	Rfs2pJl3DOlcrWrui4evABfA3P+oPLLJr+4wpi5qyrK3ICjiEwJEHYRTuxjxSzmiXITiSgJ/q3Y
	dbjH/N4X9byFuUrXYoS5TM0ektthY2luV44s/C2/e+6DFn98rUoZqaSIhHHu+KqfsNb1MlGoJcV
	iVcUA15Dzcd+A0pUMI0//uwhAWjivgGykM/v9PPC22xcYhRotyoV3F6XKdGO/KefpoK00Wc/SBj
	15G7Bk45rM33yN6gquZgeYWhrg6fYuQk7aqZznZSzxvAguDxioGltRwwzkCrCsItzcvmAlqVZsq
	lkVlzOkY7jWoEFHwGWcnuWNS3C9Cvk3fLErf1C4=
X-Received: by 2002:a05:600c:4e0e:b0:4a1:da58:1ee with SMTP id 5b1f17b1804b1-4bb88938dc9mr245624855e9.31.1795438158755;
        Mon, 23 Nov 2026 04:49:18 -0800 (PST)
Received: from Philipp-PC ([91.227.186.127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb906817ccsm165097045e9.5.2026.11.23.04.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 04:49:18 -0800 (PST)
From: Philipp Sudakas <filzador@gmail.com>
To: ronak.doshi@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	u9012063@gmail.com,
	Philipp Sudakas <filzador@gmail.com>
Subject: [PATCH net v2 5/5] vmxnet3: keep the XDP program across device resets
Date: Mon, 23 Nov 2026 15:48:55 +0300
Message-ID: <20261123124855.1021-6-filzador@gmail.com>
X-Mailer: git-send-email 2.56.0.windows.4
In-Reply-To: <20261123124855.1021-1-filzador@gmail.com>
References: <20261123124855.1021-1-filzador@gmail.com>
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

vmxnet3_rq_cleanup_all() clears adapter->xdp_bpf_prog. It is called
from vmxnet3_quiesce_dev(), so on every MTU change, down/up, ring
resize, reset work and resume. After that the driver no longer runs
XDP, while the core still reports the program as attached, and the
driver's reference to the program is never dropped: a later detach
finds xdp_bpf_prog already NULL and returns early.

Seen on 6.12.117 and 7.2.12: after "ip link set dev X mtu 1400",
"ip link set dev X down; ip link set dev X up" or
"ethtool -G X rx 512", the attached program is no longer called, and
each detached program stays loaded.

Do not clear the pointer there. The program is exchanged and released
by vmxnet3_xdp_set(), which also runs when the device is unregistered,
and which since an earlier patch of this series keeps the previous
program on failure. Rx rings are then recreated in XDP mode after a
reset, as vmxnet3_xdp_enabled() stays true.

Since the program now survives an MTU change, reject an MTU above
VMXNET3_XDP_MAX_MTU while XDP is attached, as vmxnet3_xdp_set()
already refuses to attach a program at such an MTU.

The problem was found and analysed, and this patch drafted, with the
help of an AI coding assistant. It was reproduced and tested on the
reporter's lab systems as described in the cover letter.

Fixes: 54f00cce1178 ("vmxnet3: Add XDP support.")
Signed-off-by: Philipp Sudakas <filzador@gmail.com>
---
 drivers/net/vmxnet3/vmxnet3_drv.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/vmxnet3/vmxnet3_drv.c b/drivers/net/vmxnet3/vmxnet3_drv.c
index 66f6773..22367b8 100644
--- a/drivers/net/vmxnet3/vmxnet3_drv.c
+++ b/drivers/net/vmxnet3/vmxnet3_drv.c
@@ -2107,7 +2107,6 @@ vmxnet3_rq_cleanup_all(struct vmxnet3_adapter *adapter)
 
 	for (i = 0; i < adapter->num_rx_queues; i++)
 		vmxnet3_rq_cleanup(&adapter->rx_queue[i], adapter);
-	rcu_assign_pointer(adapter->xdp_bpf_prog, NULL);
 }
 
 
@@ -3666,6 +3665,11 @@ vmxnet3_change_mtu(struct net_device *netdev, int new_mtu)
 	struct vmxnet3_adapter *adapter = netdev_priv(netdev);
 	int err = 0;
 
+	if (vmxnet3_xdp_enabled(adapter) && new_mtu > VMXNET3_XDP_MAX_MTU) {
+		netdev_err(netdev, "MTU %d too large for XDP\n", new_mtu);
+		return -EINVAL;
+	}
+
 	/*
 	 * Reset_work may be in the middle of resetting the device, wait for its
 	 * completion.
-- 
2.47.3

