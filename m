Received: from outbound.ci.icloud.com (ci-2005d-snip4-4.eps.apple.com [57.103.89.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B77E2D97B8
	for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 19:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.89.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782847079; cv=none; b=f7W2qlTaYynJx9Zzjv7u3T40R5yq9VV44R89Qt3ZJLKACIAzo0Qh72t9PQw3XSZ2WjjIXOFztKepBimbf0xMR1+9fnC8dKRiauhwqzZhxJoRlmhQub1iuikOiaoyoJ4eWc6/Jj6VlCcV8RQuCFQKHuQD/LHF/AV3HSlSFSLLHF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782847079; c=relaxed/simple;
	bh=YeOE+rswRgmUNwL9mmMtmfe4KaxcCM4iLBIQrDr6lQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cVnASyeCjwbRN74PNrRO8CFnTm94OuuRxLXxL0KWb3t4+ixoTv+1EZwD2t4Sj9ooCGW9sx7h1lLMsw4WGr5BEovxoqOanL9vzx9gz+fNnkRsjJP0zOXEqKtXALFpVmLbhtuqhK2BtTQvSPfkBkIUZS2DzvTf7tZwgoWemrAN3pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verdict.gg; spf=pass smtp.mailfrom=verdict.gg; dkim=pass (2048-bit key) header.d=verdict.gg header.i=@verdict.gg header.b=jYtZzFfK; arc=none smtp.client-ip=57.103.89.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verdict.gg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verdict.gg
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=verdict.gg header.i=@verdict.gg header.b="jYtZzFfK"
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-central-1k-10-percent-2 (Postfix) with ESMTPS id 4FD5A18015E9;
	Tue, 30 Jun 2026 19:17:52 +0000 (UTC)
X-ICL-RepId: 019f19f7-676b-7c54-9d1d-29648253593a
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQhICkMGWQJeCEABQwVdEhVdRVcIWwJAEVc4RQhFD1sTTVZUChcNVk1PHUEJXghGXl4fEx9UVgNBGRBWAVhWXQVNGlwYWQ8cE1BWWg5bBEcUFxtcABcbRgIEIwJfAEUCXglWATAXD1ZNTx1BCV4IRl5eHxMAXg8PTAtIAVsHXQFACEECWAZbHEgITANfGlofFFwUWh9WBXIGXApXBFQfHBdeRhMZThtXTVoNQBlYBm0UVhVSBFk=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verdict.gg; s=sig1; t=1782847074; x=1785439074; bh=xJAfS5Jo3Txg9JzD25eVYgRDgS6FkP2PRBB07PROM2s=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=jYtZzFfKjbiTOLuaNmi3/Kjdw5v2bOzHNBoqQPcV3NxkFDtXyvNbrYm7BbSBGZEJxX2q9i3J7VW6Mo7JZoe80A7pHzUd/icbIc1I8rJnG4B0vUli4lya1a8oaUncSrLfhffcbUvkjf7XWorNd82uRfFDs2U6MmfxepmgaPNqrbNILKhw+NpelpCp1T9OYin+nuvk4kunztjuetdRiu7w4JC2M+K2TZqkNpnHMBfsGWItLohhoHLWPMJW1z4BDlYJNH+NMhNsW/TSNXo7BdAjERIW841sxa6w04qdOMqXs8uuP0L6LOS5BR885gCOI1GZTHS5j1KLc+5amx13x0J5vw==
mail-alias-created-date: 1621344842221
Received: from DelNac.mail.msk (unknown [17.57.156.36])
	by p00-icloudmta-asmtp-us-central-1k-10-percent-2 (Postfix) with ESMTPSA id 7373818015E1;
	Tue, 30 Jun 2026 19:17:49 +0000 (UTC)
From: Vladimir Vdovin <deliran@verdict.gg>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	sdf@fomichev.me,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	Vladimir Vdovin <deliran@verdict.gg>
Subject: [RFC PATCH bpf-next v1 0/7] xdp: RX checksum metadata hint and checksum assertion over redirect
Date: Tue, 30 Jun 2026 22:15:03 +0300
Message-ID: <20260630191510.81402-1-deliran@verdict.gg>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDE4NiBTYWx0ZWRfXxFkQPyif8IcY
 G0HRERC0dp/mNW7NCTc5vSzzbnOIJZlMgc5QhEOiEwBZOQ+0BudzZeC8oK3j0d/WcKiYdFn8ykl
 lcFapCyAJ30WGg2+7fAJx4iRrBdl1zNlKPFv4HsBDn+EJRDKLGr+bUAeUChZKrZVZ524vg6a736
 mG2M6tINnFIJw562fK03uZW3fe+Hme0C9y+n15Cwq54wQmev4wJDw8X1+Gd7dKiRyW10byvPnNe
 ku+EjvBsdr5X6D2qo/BjrGN3dsrKDD5Z2NZk3pYnyGpHQ5wxxLPWBremakuyeS7DM+HtCCNkhGd
 PbaAux/iOKJ5qfu7EfB
X-Proofpoint-GUID: NIOaQnsFpPjjsL_HnU7jPzjgasVlEOAT
X-Proofpoint-ORIG-GUID: NIOaQnsFpPjjsL_HnU7jPzjgasVlEOAT

This series lets XDP programs work with the hardware RX checksum verdict:
read what the NIC concluded about a packet, and carry a "the L4 checksum
is correct" assertion across a redirect so the stack does not revalidate
it in software.

When an XDP program redirects a frame to a cpumap (or any other path that
rebuilds an skb from an xdp_frame via __xdp_build_skb_from_frame()), the
HW RX checksum status is lost and the stack revalidates the L4 checksum in
software.

Two kfuncs are added:

 - bpf_xdp_metadata_rx_csum(): a device-bound RX-metadata hint, like the
   existing rx_hash / rx_vlan_tag ones.  It reports enum xdp_csum_status
   (XDP_CSUM_NONE / XDP_CSUM_VERIFIED) and is implemented for mlx5e, ice
   and veth.

 - bpf_xdp_assert_rx_csum(): a generic, non-device-bound kfunc that lets
   the program assert the L4 checksum is correct.  It sets a buff flag
   that rides into the xdp_frame, and __xdp_build_skb_from_frame() turns
   it into skb->ip_summed = CHECKSUM_UNNECESSARY.  The kernel cannot
   verify the assertion; the program takes responsibility, as it already
   does when rewriting packet contents.

Posted as RFC to get feedback on:

 - whether the read hint (bpf_xdp_metadata_rx_csum() and its driver
   support) belongs in this series at all.  bpf_xdp_assert_rx_csum() is
   self-contained and already covers the main use case: a program that
   computes or fixes the L4 checksum itself, or trusts the source, and
   wants the rebuilt skb to skip software revalidation.  The read hint is
   an optimization for programs that did not touch the payload and only
   want to relay the hardware verdict.  These could just as well be two
   independent series (assert-only first);
 - the kfunc naming, bpf_xdp_assert_rx_csum() in particular.

Testing:

 - new selftest xdp_cpumap_rx_csum drives a frame through a native-XDP
   veth into a cpumap redirect and checks, via fexit on
   __xdp_build_skb_from_frame(), that the rebuilt skb is
   CHECKSUM_UNNECESSARY iff the program called bpf_xdp_assert_rx_csum();
 - xdp_metadata calls bpf_xdp_metadata_rx_csum() over veth and checks both
   verdicts: XDP_CSUM_NONE for an AF_XDP-injected frame and
   XDP_CSUM_VERIFIED for one sent through the stack.

Vladimir Vdovin (7):
  xdp: let XDP programs assert the RX checksum over redirect
  selftests/bpf: add test for bpf_xdp_assert_rx_csum over cpumap
  xdp: add bpf_xdp_metadata_rx_csum() RX metadata kfunc
  net/mlx5e: support the rx_csum XDP metadata hint
  ice: support the rx_csum XDP metadata hint
  veth: support the rx_csum XDP metadata hint
  selftests/bpf: cover bpf_xdp_metadata_rx_csum in xdp_metadata

 Documentation/netlink/specs/netdev.yaml       |   5 +
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c |  32 ++++
 .../net/ethernet/mellanox/mlx5/core/en/xdp.c  |  23 +++
 drivers/net/veth.c                            |  23 +++
 include/net/xdp.h                             |  23 +++
 include/uapi/linux/netdev.h                   |   3 +
 net/core/xdp.c                                |  73 ++++++++-
 tools/include/uapi/linux/netdev.h             |   3 +
 .../bpf/prog_tests/xdp_cpumap_rx_csum.c       | 150 ++++++++++++++++++
 .../selftests/bpf/prog_tests/xdp_metadata.c   |  10 ++
 .../selftests/bpf/progs/bpf_tracing_net.h     |   1 +
 .../bpf/progs/test_xdp_cpumap_rx_csum.c       |  51 ++++++
 .../selftests/bpf/progs/xdp_metadata.c        |   9 ++
 tools/testing/selftests/bpf/xdp_metadata.h    |   8 +
 14 files changed, 412 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_cpumap_rx_csum.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_xdp_cpumap_rx_csum.c


base-commit: f456c1922c49e6be5ce407ddb74a6e61af5b65cf
-- 
2.47.0

