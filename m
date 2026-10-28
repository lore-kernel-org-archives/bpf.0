Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793190437;
	b=A3M3P9ySkNRvfFAmpreyClC8YQBgqWrXu9X+9PDa1/U3rkaqkXYhPXhyofkxmJwS65My
	 J0r6nvDD/ghYnMQSeGYIXIJtbjeL2UindAax+bhQXUDWYQmoxmV1DW48jes38b64CasIp
	 ojYCy43xcEHkRB92pNFDbohqD6RBEUJLVmJ7aTw2ZqoyOgHbnyzCc6L+21rFHsU7HqfKl
	 grYsD1FAbCYmjFJ7SXS0XKBZWEY9jIcBfxXMhbVhsId3Duni0tKl/xURJ9FN4geaEaSYJ
	 qzJh0iSPe2oMIAPZzQLGn43Ex1Q2vC41iFUToTXKjTA1/XsqFZTAPfGVBaoweDZee7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793190437;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=5UYxKGaCGMdLxSaQ2XmYt6w2Y4hTPYmZ9ll9tXrG4Is=;
	b=uZh0yOPMOqEpsLymWC9TsCgDOs65S/RoZ8CLpVBv7iiPnrZUW/1YC/eQ3jjh/iwFgh46
	 v7Uh3DarkDyHpnTrOxk5EOYJ5MtJSJlgQbFPuybun4xV7/Q/IjqLMB/Jc5EWk3uicPN1d
	 3Iyx0ZFDyR7ocofgV844gJB+lHC49P/8ywaFbcMp/sHTYQi2UL6QYbeq22R3cPcYd7HCp
	 VBlH08xZP4WtRcHSpY7ZVrIRNi4bp9MFtlO8FNDK0YVVPOyruYcV5YalQsS9ldTzGwF00
	 YLgEYFsy02Yt8UKYydcTZdgjPOkn7qRjHoOKpueTjJL2Ew9fcmuvIqJjb0C3Lz2Ql5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mTE2hqjx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21122606A31A;
	Wed, 28 Oct 2026 12:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mTE2hqjx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 394A21F01825;
	Wed, 28 Oct 2026 12:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793190436;
	bh=5UYxKGaCGMdLxSaQ2XmYt6w2Y4hTPYmZ9ll9tXrG4Is=;
	h=From:To:Cc:Subject:Date;
	b=mTE2hqjxI5V/wXS4AH8GRcFSHH/EWrSvAk6lf5XBUzLBqhWY9qYQz1/Vb0uEn1G+2
	 k5pl1SDf5JM3qqhp/YfX21b1rO7sHvvLx2ytmf5igloG9koCpKbxwaGXe4t0gzNSTk
	 iiOkqVwsVqctr8088Co0dfHIfgrxv+Jgmyl+IrkvuH3pSnSMA+6BWf2+flOdwCDZN/
	 pRy2sEOyPXLC61F8iWY2AfcNi70c6QAO9SDxHBUf/NyYAphZrwACiVHpxH4E8QAb6c
	 EhOCAVD40TdXg27jGY+kYQGQhWy7+3LnfV7I0YC6o6r9yQkirCLnc/DGxyYrfme7TV
	 thXYYRNShBCjQ==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Eric Dumazet <edumazet@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	dev@openvswitch.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Ren Wei <weir@nebusec.ai>
Subject: [PATCH net v2 0/5] net: fix eth_type_trans() crashes on skbs coming from the stack
Date: Wed, 28 Oct 2026 13:26:58 +0100
Message-ID: <20261028122703.2093730-1-edumazet@kernel.org>
X-Mailer: git-send-email 2.53.0
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

eth_type_trans() assumes ETH_HLEN bytes are present in skb->head.
NIC drivers always provide this, and they should keep using the fast
version, without an extra pskb_may_pull().

Devices looping skbs from their transmit path back to their receive
path get skbs built by the stack instead. tc actions (act_vlan pop_eth,
act_ife decode), BPF helpers (bpf_skb_change_head() before a redirect)
or OVS actions (pop_eth followed by pop_mpls/pop_nsh) can leave fewer
than ETH_HLEN bytes in the linear part, and eth_type_trans() then hits
the BUG() in __skb_pull().

Instead of fixing every producer, or adding a check to all
eth_type_trans() users, fix the few consumers exposed to this:

- Patch 1 adds eth_type_trans_careful(), which pulls the Ethernet
  header first and returns a drop reason on failure.
- Patch 2 uses it in loopback_xmit().
- Patch 3 uses it in __dev_forward_skb2(), used by BPF redirects to
  ingress and by veth, macvlan, ipvlan, netdevsim and l2tp_eth.
- Patch 4 uses it in OVS internal_dev_recv(), covering both the MPLS
  (TEB) and NSH pop cases at once (only the MPLS case was tested).
- Patch 5 (from Jamal) fixes act_ife decode on egress, which was
  consuming the inner Ethernet header. This is no longer a crash after
  patch 2, but egress decode never delivered a correct frame.

Other eth_type_trans() users already pull the header or never see
such skbs:
- vrf_process_v{4,6}_outbound() already pull ETH_HLEN + IP header
  before vrf_local_xmit().
- tun already uses pskb_may_pull_reason(skb, ETH_HLEN).
- XDP: bpf_xdp_adjust_head() and bpf_xdp_adjust_tail() keep at least
  ETH_HLEN bytes in the linear part, and multi-buffer tail shrinking
  only trims frags.

Tested under virtme-ng with AF_PACKET reproducers. Without the series,
all four cases crash in eth_type_trans():
- lo egress "action vlan pop_eth", eth/eth/8192 bytes frame
- lo egress "action ife decode pipe", IFE frame with 8192 bytes payload
- lo egress "action vlan pop_eth continue", then a BPF program doing
  bpf_skb_change_head(skb, 1, 0) + bpf_redirect(veth1, BPF_F_INGRESS)
- OVS flow "pop_eth,pop_mpls(0x6558),0" to the internal port,
  eth/mpls/eth/4096 bytes frame
With the series, no crash. An ICMP echo inside an IFE frame decoded
on lo egress is now received and answered. Normal traffic on lo,
veth (including 8000 byte pings) and vrf is unchanged.

v2:
- Patch 3: update the empty_skb BPF selftest. At lwt_xmit, its
  "veth ETH_HLEN+1" packet is a 1-byte skb, which is now dropped on
  veth ingress, as veth_xmit() already does on egress (BPF CI).
- Rebased on latest net, collected tags from Aaron, Willem and Jamal.
- No kernel code change.

Link: https://lore.kernel.org/netdev/20261005052249.1914367-2-weir@nebusec.ai/
Link: https://lore.kernel.org/netdev/ACT-N6N4.v3.r0.20261023200137-4@mojatatu.com/
v1: https://lore.kernel.org/netdev/20261027082604.1485903-1-edumazet@kernel.org/

Eric Dumazet (4):
  net: add eth_type_trans_careful()
  loopback: use eth_type_trans_careful()
  net: use eth_type_trans_careful() in __dev_forward_skb2()
  openvswitch: use eth_type_trans_careful() in internal_dev_recv()

Jamal Hadi Salim (1):
  net/sched: act_ife: do not consume the inner header on egress

 drivers/net/loopback.c                        |  8 +++++-
 include/linux/etherdevice.h                   | 28 +++++++++++++++++++
 net/core/dev.c                                | 18 ++++++++----
 net/openvswitch/vport-internal_dev.c          |  8 +++++-
 net/sched/act_ife.c                           |  4 +++
 .../selftests/bpf/prog_tests/empty_skb.c      | 19 ++++++++-----
 6 files changed, 71 insertions(+), 14 deletions(-)

-- 
2.53.0

