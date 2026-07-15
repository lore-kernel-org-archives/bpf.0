Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE172D6E64;
	Wed, 15 Jul 2026 21:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784151660; cv=none; b=GdjAPSwAar+hAbSJaWmSOU/TWjr3oL/Sl2aRKSho105LQpqzKdjEnW1LiVTvcXQWpaNl/H0qzneHTlC6g2yVYrHZQ54GA3ZKGKrO7yIn1ELYAQ/8JFhnz0NMZp5pGSDLDPMuUb9fghT8v3cYGp2S3A242ljQEeXSKW+fEzDsNr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784151660; c=relaxed/simple;
	bh=+wRx/2cZl1CRjeNc+LZxEILml80uHsfQzvBknjG31C0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Q3aQFHkc3IEPnjc2sDdhBtTE66V9p5SdOi7b7w8peOuMmJTaXD9KKlAu3KWAvW8kv9Aw0b+lLp7mTT7ty0EG9lRUhWh0pMb1rdqox220i9qNIsLbo5lradYNW71HIn33aenqal982IQIUJYqUvKye0dk8BpCOx/4I7eiRJcehqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nM5Zby8I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nM5Zby8I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4766E1F000E9;
	Wed, 15 Jul 2026 21:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784151659;
	bh=beMvsMOYV/35qvC4uNSHGPgxhMwJhGYCp9bcZZ4egZU=;
	h=From:Subject:Date:To:Cc;
	b=nM5Zby8IovOatbyak1vT2rmYnjz/8yyWs1oXOT7zbxv73sEFKBa+H1gPrkdx28+Sp
	 YIkDERxUSsq/tnZdjX26mEfidhyzojKK+6E30lHjgbgGLqgOC4/kesGpjK0JvjGvUu
	 fAbuzIjtoqila0/bQ0TSJDHKaZVZSGtWzKJGd9QHLLAFBvL3a9E67R46fM8IfnbflT
	 lRtufK5+UzisSaPAOaCniTW3Srnfl1E0I5dJI3JuY7yLBupLyNxWEo6JbD0fGkqzDE
	 4b33R+4uxrTZ2x9p3sT93WkehSHfqZn7dyShngFIDD1lk0XUgrWJe4hAjd0dt2aJZx
	 4YTUlJfbieWCA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH bpf-next v5 0/8] Add the the capability to load HW RX
 checksum in eBPF programs
Date: Wed, 15 Jul 2026 23:39:40 +0200
Message-Id: <20260715-bpf-xdp-meta-rxcksum-v5-0-623d5c0d0ab7@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33OwW6DMAyA4Vepcm4mx8FAetp7TD2EYErUFlBCE
 VPFuy8gTeo00aNl/Z/9FJGD5yhOh6cIPPno+y4NdDwI19ruwtLXaRYISGCQZDU0cq4HeefRyjC
 7a3zcpQHIS2I0YGqR0iFw4+eN/RJr0fE8inPatD6Offje7k247d/TE0qQeaUbNmXh2KjPK4eOb
 x99uKynUp0DKv2mtiW6rAS0TcWv9frPpH5/WBXYUVRSmGoiZy1Qpv4p+lUpdhSdFA2AmSOobPF
 XWZblBz8K4ZaNAQAA
X-Change-ID: 20250925-bpf-xdp-meta-rxcksum-900685e2909d
To: Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Emil Tsalapatis <emil@etsalapatis.com>
Cc: Vladimir Vdovin <deliran@verdict.gg>, 
 Jakub Sitnicki <jakub@cloudflare.com>, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.3

Introduce bpf_xdp_metadata_rx_checksum() kfunc in order to load the HW
RX checksum results in the eBPF program binded to the NIC.
Implement xmo_rx_checksum callback for veth and ice drivers.

If the hardware detects a wrong/failed checksum, it will report
CHECKSUM_NONE in the packet metadata. Moreover, CHECKSUM_NONE will be
returned even if the NIC can't parse the packet (e.g. if it does not
support a specific protocol). A possible use case for
bpf_xdp_metadata_rx_checksum() would be to implement a XDP DDoS
application [1] combining the info from bpf_xdp_metadata_rx_checksum()
and bpf_xdp_metadata_rx_hash() kfuncs in order to filter packets with a
wrong/failed checksum.

[1] https://blog.cloudflare.com/unimog-cloudflares-edge-load-balancer/

---
Changes in v5:
- Add new kfunc to Documentation/networking/xdp-rx-metadata.rst
  documentation
- Introduce bpf_skb_rx_checksum kfunc and related selftest.
- Introduce selftest to check the driver invalidates the rx checksum if
  running in XDP mode.

Changes in v4:
- Report cusm and csum_level separately and convert ip_summed to a
  bitmask in bpf_xdp_metadata_rx_hash()
- Fix endianness issue in bpf selftests
- Add a comment about the driver expected behaviour if the the NIC reports
  CHECKSUM_UNNECESSARY or CHECKSUM_COMPLETE and the eBPF program modifes
  the packet
- Introduce bpf_get_skb_cksum kfunc and related selftest to load the
  checksum result to the SCHED_CLS eBPF program attached to the qdisc.
- Link to v3: https://lore.kernel.org/r/20260217-bpf-xdp-meta-rxcksum-v3-0-30024c50ba71@kernel.org

Changes in v3:
- Remoe leftover assignment from v2 in veth_xdp_rx_checksum()
- Fix typos
- Fix commit logs
- Link to v2: https://lore.kernel.org/r/20260213-bpf-xdp-meta-rxcksum-v2-0-a82c4802afbe@kernel.org

Changes in v2:
- Remove XDP_CHECKSUM_PARTIAL definition
- Improve veth_xdp_rx_checksum() callback
- Fix uninitialized case for cksum_meta in ice_get_rx_csum()
- Fix sparse warnings in ice driver
- Fix typos
- Link to v1: https://lore.kernel.org/r/20260210-bpf-xdp-meta-rxcksum-v1-0-e5d55caa0541@kernel.org

Changes in v1:
- Rebase on top of bpf-next
- Test ice driver using xdp_hw_metadata tool available in the bpf
  kernel selftest
- Improve cover letter with an use-case for
  bpf_xdp_metadata_rx_checksum()
- Link to RFC v2: https://lore.kernel.org/r/20250925-bpf-xdp-meta-rxcksum-v2-0-6b3fe987ce91@kernel.org

Changes in RFC v2:
- Squash patch 1/6 and 2/6
- Introduce enum xdp_checksum definitions
- Rework ice support to reuse ice_rx_csum codebase

---
Lorenzo Bianconi (8):
      netlink: specs: add XDP RX checksum capability to XDP metadata specs
      net: veth: add xmo_rx_checksum callback to veth driver
      net: ice: add xmo_rx_checksum callback
      selftests/bpf: add selftest support for bpf_xdp_metadata_rx_checksum
      selftests/bpf: add bpf_xdp_metadata_rx_checksum support to xdp_hw_metadat prog
      net: add bpf_skb_rx_checksum kfunc to read skb checksum metadata
      selftests/bpf: Add test for bpf_skb_rx_checksum kfunc
      selftests: net: add test for XDP_PASS skb checksum invalidation

 Documentation/netlink/specs/netdev.yaml            |   5 +
 Documentation/networking/xdp-rx-metadata.rst       |   8 ++
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c      | 123 ++++++++++++++-------
 drivers/net/veth.c                                 |  32 ++++++
 include/net/xdp.h                                  |  13 +++
 include/uapi/linux/netdev.h                        |   3 +
 net/core/filter.c                                  |  31 ++++++
 net/core/xdp.c                                     |  32 ++++++
 tools/include/uapi/linux/netdev.h                  |   3 +
 tools/testing/selftests/bpf/bpf_kfuncs.h           |   8 ++
 .../selftests/bpf/prog_tests/skb_rx_checksum.c     |  50 +++++++++
 .../selftests/bpf/prog_tests/xdp_metadata.c        |   9 ++
 .../testing/selftests/bpf/progs/skb_rx_checksum.c  |  33 ++++++
 .../testing/selftests/bpf/progs/xdp_hw_metadata.c  |   7 ++
 tools/testing/selftests/bpf/progs/xdp_metadata.c   |   2 +
 tools/testing/selftests/bpf/skb_rx_checksum.h      |   8 ++
 tools/testing/selftests/bpf/xdp_hw_metadata.c      |  31 ++++++
 tools/testing/selftests/bpf/xdp_metadata.h         |  13 +++
 .../selftests/drivers/net/hw/xdp_metadata.py       |  55 ++++++++-
 .../selftests/net/lib/skb_metadata_csum.bpf.c      |  73 ++++++++++++
 20 files changed, 496 insertions(+), 43 deletions(-)
---
base-commit: f6f3b36c15ed44de1fbb44e645e4fae8c4a4453e
change-id: 20250925-bpf-xdp-meta-rxcksum-900685e2909d

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>

