Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795600328;
	b=Rnep6Scxq5KBGpmg4fF3MHXI7waGlhRPb1o4uu4ks4vDcwrHxj2dtMnW1jwCKiWWKIO4
	 eV+9F93qc3Rx5sQSXo8giJIBhMPg9tFZFlKdWH5uSBPeTllytvFFpnwmhfhwNPsz7JMAt
	 YHQSYFZyL+hcrzDGU/X6NVXv43XCnYzCzOF0vF7y8oThiJXAUabqT1ZShjY5z4pqAMoJU
	 HaLoCSQFzJcrlzl6tl2EYoS80v+dxKqEQyASg1lcJ9qsL10OHa3HsRGcsSzcUPOYXeI5Z
	 rmnmXvQJz97edCXYy7oU/B7sCcfTVF4JQWk5diSeZ4I1tWA/GVaU7LnYYbN2qkgcpSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795600328;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=WXzjn+vyJIpaH9gzDIVnY/hmD1MIvRpuB4YDU1U7djk=;
	b=Uc36Q4UQym+B0iZ3UXBPJavLhtXJKc3e2wV88nhDOq7XhKQFJkw3kT52vLC0fY4vD7S5
	 vGxzG86ZIDk0UbB+sOj0EvauPtzhvfwjItmPYNEHHMb5MqCsJUuX1cn+Q0qhZaSvRK599
	 T5rinlr+wWphGkdotIp2Qgq2qmrFt19TH5YOQH/ErXA8dVXtuLZz1ivZ79XspANiNhF1C
	 Qren3GJfgoczO21/HbE1Udx6VP74WG8xuYoRBw1FkoGFAI8YsJnkVQP67wJ+3cNwht9Xu
	 SHWmzfy+CYjxB+Sst7DXEv/ZStrTO9vwtF02zAtfj/WnpFvtVwDYoSyzFztBwJ0wfSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=cRtzSrJC;
	arc=none smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22658606A326
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 09:52:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22658606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=cRtzSrJC
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6b4bd3d98bfso7037129a12.1
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 01:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1795600325; x=1796205125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WXzjn+vyJIpaH9gzDIVnY/hmD1MIvRpuB4YDU1U7djk=;
        b=cRtzSrJCSlUj2okpqQ3DcQMeh8Leknwfg/4W8Kc4E/DK5JBhXwh8hyP/bimNLrbF16
         2jlmptAWPHiyUaAk4ifBpe9yJU/bjoolh2CJnJk31g9kMWjJQ4+KCA+IaPX4dhPEHR1p
         SA3EvWdR1UikAP5PjWPivK3tXXNm05wwtGmutcy/m7kVn5f2TqHkQxvHlR7oxh/Zusr2
         40jezT8iio7QbwCScyk+bK3Nl+cAv6NGlngqojXrrLdBgOOGxq98+uJImafYVzLOwvUt
         iXOPbE0R82rrmDzAGHUVZBSQW41mWGF1kg9X1E+DHtcCE6dLCX25u97CujSXnlPaeHRW
         IkGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795600325; x=1796205125;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WXzjn+vyJIpaH9gzDIVnY/hmD1MIvRpuB4YDU1U7djk=;
        b=JEU5WqJqvcXf5o+4LtJF8ldowAXHSlnpUaAEm1TQP2R7jULU5YcnpjuFm3dTU4e/dg
         Lz92TZ/eNrw4jwx9eNFg34eQFLoCLetm/frmgIZrqfhIfVFdxTdcpIxDkTNMMiv3F/7V
         2SUJLYG/e1YIn7ITXnZje9tP4YhO+LpRtD+GgobwR6kUvy5mbf4NDTmjyJrdabe/bRU8
         l7ysBMtVppKpW+99X9hL89xHyt+fft0izHb+bt0c9BZgb6GHI5SlyPaHV+jmeO/a4Wus
         25E3bXzawc/TSp9rNL8U3wvPQjmys0wjfBcHLlGQ0sqEtgrLO4U7VJjKOQywcL4Mep+6
         nWTQ==
X-Forwarded-Encrypted: i=1; AL+hErHdqARgcJo0EyaIqjm//AkLS1psIXPDpSxzT06AzA0MnNSzIR21ios5LHMfe/mLcrg/hcc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+vY5P0WDnZhOCl0kIWM14hlxY53JhhQyH+XIziOcRQG3XPP5km
	Psb+oCOxLePBUcCnwQob4RbmRv5k1Lvl7fnGB01EJgnpCPGPfv9gCcorTCe7glmXV7o=
X-Gm-Gg: AZFdTZeyCoqKsgHhS+JRQd/uuKPb6BQOuQ8XA8AHXs42xRbUUCSKA7PAz+iN+NV5mKe
	8IV1LiSH/eJfdF0VhUV8+nGXoWkmT2gvXI1ql3OAnyZDtjzMUR8QZfL0ZTUDsFd/qBAhdPuCg2S
	1djtmDZMOPPhFJXhlBatP4WrcnoRCdvZFzbyatB1Zj2H9UilBZCVRp+9M0keGpFK6J0syQmC7Tq
	ctzz3XmJ3FX/ukPyOSHjJknDNzwCPGbnfuLW2PgwVCREzB9GZL7J0idi7xVrM3/gHdVZ4nYg9x/
	E+nfmWHBuL+ypoMo12bGLyjCAD3++gBZGfAwmFcqtqvOACzfFe78mJRWEQHs6cQrGapKDSdceSr
	MP9cHrw1Qt+n4dPRdt6kGOBVu/3flNQCJUoy+A8EgZEspmTJEw+IWDd9iRCyOrnvgV9U/Un0p14
	ih6PXg3zOwVsD1cmszwv6+RDIgpvbsg6dFUi7o78obNPzkx1NNdTgAJst5JOdwBnyI/s9p+tjm3
	qE5hef/DfLt6i/QSrbKAymsx2CG07ayRhVMHmZ4eWB1aCzSytmP3JyjxD3aARF9PU8eyUlbe7lv
	VyBHfiraBJ8QQDF2DNkFmf9NyTdRM2XPJAp9Sj+tly9Fkk/0PdxChU5dBIY=
X-Received: by 2002:a05:6402:42c8:b0:6ba:90b8:6584 with SMTP id 4fb4d7f45d1cf-6ba90b86c26mr7931504a12.27.1795600325287;
        Wed, 25 Nov 2026 01:52:05 -0800 (PST)
Received: from L9JK9NPFH9 ([104.28.20.56])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba37108c8esm8147342a12.31.2026.11.25.01.52.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Nov 2026 01:52:03 -0800 (PST)
From: Tianyi Gao <tianyi@cloudflare.com>
To: netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
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
	Alexander Duyck <alexander.duyck@gmail.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	bpf@vger.kernel.org,
	kernel-team@cloudflare.com,
	tianyi.gao@linux.dev,
	Tianyi Gao <tianyi@cloudflare.com>
Subject: [PATCH net v2] ice: do not report CHECKSUM_COMPLETE when an XDP program is attached
Date: Wed, 25 Nov 2026 09:52:01 +0000
Message-ID: <20261125095201.98279-1-tianyi@cloudflare.com>
X-Mailer: git-send-email 2.56.0
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

On E830, ice reports CHECKSUM_COMPLETE with the generic checksum (GCS)
that the hardware computes over the received frame. If an XDP program
changes the packet and returns XDP_PASS, that checksum no longer
matches. The stack then checks the packet again in software and calls
netdev_rx_csum_fault().

On Cloudflare servers, an XDP load balancer removes the encapsulation
of the packets that it accepts locally. Our production traffic hits
netdev_rx_csum_fault() all the time.

Do not use GCS while the VSI has an XDP program, as mlx5 has done since
commit 5d0bb3bac4b9 ("net/mlx5e: XDP, Avoid checksum complete when XDP
prog is loaded"). Set ICE_RX_FLAGS_RING_GCS in ice_vsi_cfg_rxq()
instead of ice_vsi_alloc_rings(). The flag then follows the program
when it is attached or removed, and after a VSI rebuild. Log an info
message when a program is attached on a port with GCS.

E830 also sets the L3L4P and checksum error bits, so the packet gets
CHECKSUM_UNNECESSARY or CHECKSUM_NONE, as on E810. For example, a zero
UDP checksum over IPv6 is marked as bad and gets CHECKSUM_NONE. A zero
UDP checksum over IPv4 gets CHECKSUM_UNNECESSARY, so the inner checksum
is never checked, as on E810 and as on E830 before v6.15. The
discussion in [3] concluded that CHECKSUM_UNNECESSARY only is the safe
option with XDP for now, and that the decap case is a known problem.

Two pending series [1][2] give XDP access to the checksum status.
Neither of them supports CHECKSUM_COMPLETE.

Tested on an E830 with an XDP program that removes 16 bytes of UDP
payload with bpf_xdp_adjust_head() and returns XDP_PASS:

- Without this patch, the changed packets got CHECKSUM_COMPLETE, and
  the stack called netdev_rx_csum_fault() 368512 times.
- With it, they got CHECKSUM_UNNECESSARY, and there were no calls.
- Plain UDP got CHECKSUM_UNNECESSARY while the program was attached,
  also after ethtool -L rebuilt the VSI, and CHECKSUM_COMPLETE again
  after it was removed.

On an E810, which has no GCS, drivers/net/xdp.py, ping.py and
hw/csum.py give the same results with and without this patch.

Link: https://lore.kernel.org/all/20260715-bpf-xdp-meta-rxcksum-v5-0-623d5c0d0ab7@kernel.org/ [1]
Link: https://lore.kernel.org/all/cover.1794281983.git.tianyi@cloudflare.com/ [2]
Link: https://lore.kernel.org/all/20260721183256.6f49d6e1@kernel.org/ [3]
Fixes: 905d1a220e8d ("ice: Add E830 checksum offload support")
Suggested-by: Jesse Brandeburg <jbrandeb@kernel.org>
Signed-off-by: Tianyi Gao <tianyi@cloudflare.com>
---
Changes in v2:
- Set ICE_RX_FLAGS_RING_GCS in ice_vsi_cfg_rxq() instead of reading
  rx_ring->xdp_prog for each packet in ice_rx_csum() (Alexander Duyck).
- Log an info message when a program is attached on a port with GCS
  (Alexander Duyck).
- Drop the paragraph about the two reads of rx_ring->xdp_prog. It does
  not apply any more.
- Move the test results into the commit message.
- Drop the Acked-by of Maciej Fijalkowski, because the code changed.
- v1: https://lore.kernel.org/all/20261121012402.84848-1-tianyi@cloudflare.com/

The E810 tests ran on net. The E830 tests ran on v6.18.65 with this
patch applied, on 8086:12d2 with fw.mgmt 7.9.5 and DDP ICE COMMS
1.3.63.0. Without the patch, 164150 changed IPv4 packets and 154671
changed IPv6 packets got CHECKSUM_COMPLETE in 2 s each.

 drivers/net/ethernet/intel/ice/ice_base.c | 7 +++++++
 drivers/net/ethernet/intel/ice/ice_lib.c  | 3 ---
 drivers/net/ethernet/intel/ice/ice_main.c | 2 ++
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index 1667f686ff75..3c44e112acf9 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -705,6 +705,13 @@ static int ice_vsi_cfg_rxq(struct ice_rx_ring *ring)
 		}
 	}
 
+	/* XDP can change the frame and make the GCS value wrong */
+	if (ice_is_feature_supported(ring->vsi->back, ICE_F_GCS) &&
+	    !ice_is_xdp_ena_vsi(ring->vsi))
+		ring->flags |= ICE_RX_FLAGS_RING_GCS;
+	else
+		ring->flags &= ~ICE_RX_FLAGS_RING_GCS;
+
 	ring->xdp.data = NULL;
 	err = ice_setup_rx_ctx(ring);
 	if (err) {
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 977cd8dd6e31..910951a17950 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -1532,9 +1532,6 @@ static int ice_vsi_alloc_rings(struct ice_vsi *vsi)
 		ring->count = vsi->num_rx_desc;
 		ring->cached_phctime = pf->ptp.cached_phc_time;
 
-		if (ice_is_feature_supported(pf, ICE_F_GCS))
-			ring->flags |= ICE_RX_FLAGS_RING_GCS;
-
 		WRITE_ONCE(vsi->rx_rings[i], ring);
 	}
 
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 47c6798c97e8..9644b25e7935 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -2944,6 +2944,8 @@ ice_xdp_setup_prog(struct ice_vsi *vsi, struct bpf_prog *prog,
 			}
 		}
 		xdp_features_set_redirect_target(vsi->netdev, true);
+		if (ice_is_feature_supported(vsi->back, ICE_F_GCS))
+			netdev_info(vsi->netdev, "XDP program attached, Rx CHECKSUM_COMPLETE disabled\n");
 	} else if (ice_is_xdp_ena_vsi(vsi) && !prog) {
 		xdp_features_clear_redirect_target(vsi->netdev);
 		xdp_ring_err = ice_destroy_xdp_rings(vsi, ICE_XDP_CFG_FULL);

base-commit: cc7fe6e741730fef549e484379281736d32746f0
-- 
2.56.0

