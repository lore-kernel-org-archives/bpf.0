Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792764835;
	b=jfVqgkrNviKmmki7iInBzrZlDGky+64zzJxbsL7lS7I6RrB5l7pGf8XDzHeYK/W613cY
	 Rj/n9SxqdikmtyLPQ15AD4gIObXNEnbdVjMfLkLD31PHNVBnm6wpsVHRTmj6U7nrUT5Dp
	 XUkckSU6xZnSlg8AgxzAXSJiKwXqL1n2viAuHqQ3oI9yTn/Ve9F9rwiY3jp5cuISMBQwY
	 Bunrw8bbUg6aHBQwdAUwlijF3e7i80gqdWF/mfal0mdq6zlaxePee7S+5mQ5lDTVIOD2Y
	 AbWQJ3WlnffL0rj8W3YsavgiHsth49XVgwaobduB1fpxU14mRc5HELhK2yfohf33sYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792764835;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=J1uVLXrP2VUfLCBDBnXOa4nyynN6pF7eavsl/v/DnRE=;
	b=etVhPOPGtahi1TCH/NPhF64PSbcuxiHY9yMNxcW8za+0IKHy92wMExsbhm/PVUDR0Zaz
	 bZAwzTUHbArp3un+l/s89Y9hhF6bHEbA4ZUnpANydJJ5zA3fLNpb3JQH3BflpGSa6jMcJ
	 e6q6E+Oh68sKDfBVr/u2lXCRpT+b7Uo2DZC4jBDc9n3+GJfzdaKeBclKKTTs8l+WxcLa6
	 +sspWDgChmfTN3jWWn6b5Qh6SsQjYuREAbeAopDfKiXCCyeb2QDKRibblU6nmj9CxICFL
	 ztPT1lyVmVVEIQvEkEqmtDxefgAgLA3CI26TUHD4lvUhRrK2S/aSLgaZVpqa+r7yepg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=1g4.org;
	spf=pass smtp.mailfrom=1g4.org;
	dkim=pass header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256 header.s=protonmail header.b=qVPRVx2K;
	arc=none smtp.remote-ip=185.70.43.20
Received: from mail-4320.protonmail.ch (mail-4320.protonmail.ch [185.70.43.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FBB606A31B
	for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 14:13:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90FBB606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256 header.s=protonmail header.b=qVPRVx2K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail; t=1792764832; x=1793024032;
	bh=J1uVLXrP2VUfLCBDBnXOa4nyynN6pF7eavsl/v/DnRE=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=qVPRVx2KJkZqgOoqwCznUE/sIAqy40GAvv2BXne7a6FOwy/56svtqOm9ImLSjAv/y
	 EAOsuS/qfOortQd770yPKCNa6PAPsr70i99AxFWyrn74gFYOtXmf1xrM9InmPe5XEj
	 H6o3nf215g9rCjB253xkI7bOZW1isqXveguCK+5qRQqQy3ZVfQVLxBUlS2b1ecK0Yw
	 NGcy3TBr0HeRwoIHVRA01YonRSyzMykOCG6rO0/SZfL8LWq9qvnnxlvLvaTqAmBZPP
	 Sj0k/5BirM4GL1vmfEpayLjLh0UyHAxzAql2LsPDOygfKnk2g4ZC0l3zLH/636zEO5
	 y26YegaRSz0kA==
Date: Fri, 23 Oct 2026 14:13:42 +0000
To: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com
From: Paul Moses <p@1g4.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me, intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net] igc: return XSK frame copies on XDP_TX failure
Message-ID: <20261023141317.3904442-1-p@1g4.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 459190e83447046727bfe621ed78266b52582fb8
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Converting an XSK buffer to an XDP frame allocates a page and returns
the original buffer to its pool. If the TX ring is full or DMA mapping
fails, igc_xdp_xmit_back() returns an error without freeing the copy.
The RX cleaner cannot release it, so the page leaks.

Return the copied frame on TX failure. Save the RX memory type before
conversion so native frames remain RX-owned on failure.

Fixes: fc9df2a0b520 ("igc: Enable RX via AF_XDP zero-copy")
Cc: stable@vger.kernel.org
Signed-off-by: Paul Moses <p@1g4.org>
---
Tested on Intel I225-V with baseline and patched kernels. Physical
pause-frame backpressure caused 46 leaked copies on the baseline.
With the fix, all 72 rejected copies were returned once and freed,
and all 192 copies were accounted for.=20

 drivers/net/ethernet/intel/igc/igc_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethern=
et/intel/igc/igc_main.c
index 1fb5f3cbe93c..39263fd04aa9 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -2487,6 +2487,7 @@ struct igc_ring *igc_get_tx_ring(struct igc_adapter *=
adapter, int cpu)
=20
 static int igc_xdp_xmit_back(struct igc_adapter *adapter, struct xdp_buff =
*xdp)
 {
+=09enum xdp_mem_type mem_type =3D xdp->rxq->mem.type;
 =09struct xdp_frame *xdpf =3D xdp_convert_buff_to_frame(xdp);
 =09int cpu =3D smp_processor_id();
 =09struct netdev_queue *nq;
@@ -2504,6 +2505,10 @@ static int igc_xdp_xmit_back(struct igc_adapter *ada=
pter, struct xdp_buff *xdp)
 =09txq_trans_cond_update(nq);
 =09res =3D igc_xdp_init_tx_descriptor(ring, xdpf);
 =09__netif_tx_unlock(nq);
+
+=09if (res && mem_type =3D=3D MEM_TYPE_XSK_BUFF_POOL)
+=09=09xdp_return_frame(xdpf);
+
 =09return res;
 }
=20
--=20
2.56.GIT


