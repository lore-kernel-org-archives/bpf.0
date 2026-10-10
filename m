Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAB33C3BEE;
	Sat, 10 Oct 2026 10:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791627782; cv=none; b=OEPTjbbLDozIorFNInDcOHNNsg+o6/QdoZ4arGZgBXXlQnYN4GXkl+t4Yd8LNRnNCZFmtMjdvwt8YnDZZqoJY1263bUEasSveeUZ30T3nDCvrSv23HDLXtsyVyo6MOtI8SRRXyA44a8qztnn53BnD5BxgiCIHDmOu4JZsLE2XYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791627782; c=relaxed/simple;
	bh=sxbs6liGrD8ZkSrOdf49Ao4U0SOekNl/dLfGqEVKcCk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=asFCuBCNi6vytQo/5xxD6DRH21fsOpsvzTtpPuqEImzeV3yJbHUAXz0fIEyYYhB3rcrNyfNIlPouBqSqXXrDUG6GN+vO7W93Td8dngvTRumRVY/eLFKrRuoaLYDG8WjpcTj1EAYHWVytn7HWMoxlxpj3lMFsWycLZ7mrYoX2FtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gs0tndwr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gs0tndwr"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DFCB8C2BCF7;
	Sat, 10 Oct 2026 10:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791627782;
	bh=sxbs6liGrD8ZkSrOdf49Ao4U0SOekNl/dLfGqEVKcCk=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=gs0tndwr1td1hV6leDSDwDKwu+mQ1DfGToqf6YHR1c0j9SOzywr9b0eO7nJKJ7D/o
	 RMnrGXF40kbQQJOcEILLsNGXnzra2gpxXf/jrqPJDi/fdPSK0hjtu5ZXg0wJp6Z4sj
	 CU54bJ1m4Bi38l5t9QThja2ABT1ibS9feZIsPl8BQlW2D4WNriRbHyQ8FH7cARHlS7
	 ZKBJMC4Vgv9UYh0jSbwVuKpj95gu9Xfynuf97ov2dSlAZ0bk5JSmlX1JPUpVuYZMQu
	 Bi/LXSZ3m0DFKaDMjRidVOALi2wiuPfU/DRsKu4NcMn5s/3NQebASm/xcebKAVPnUL
	 tPayo9kAqJIyg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4260CA6004;
	Sat, 10 Oct 2026 10:23:01 +0000 (UTC)
From: Bochao Cao via B4 Relay <devnull+bochaolucky.gmail.com@kernel.org>
Subject: [PATCH net-next v5 0/5] selftests: Fix and migrate the XDP feature
 test
Date: Sat, 10 Oct 2026 18:22:44 +0800
Message-Id: <20261010-xdp-v5-send-20261008-v5-0-de687cb67c40@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/z2MSwrDMAxErxK0rsBOcCi9SunCH7VxF2qw3GAIu
 Xvs9LOcNzNvBaEUSeDSrZBoiRJfXIM5deAnyw/CGGqGXvWjVuqMJcy4GBTigH84KB0U6TDo0UC
 9zonusRzaKzBlZCoZbp9G3u5JPjdr2zorhC5Z9lNDX/9Bf37Yth2U8ST1qQAAAA==
X-Change-ID: 20261008-xdp-v5-send-20261008-301d0e1d3165
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 Tiezhu Yang <tiozhang@didiglobal.com>, Bochao Cao <bochaolucky@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Petr Machata <petrm@nvidia.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791627780; l=2823;
 i=bochaolucky@gmail.com; s=default; h=from:subject:message-id;
 bh=sxbs6liGrD8ZkSrOdf49Ao4U0SOekNl/dLfGqEVKcCk=;
 b=Y1DNpURTWdp6/AqlI8SUI4jn/kNsdcLd5oOS93OWZL1Aw3m7y7Wg9pVAdyDKCZtgd8IsKv8/Y
 DJnbVIOdMM1C8Vpn2nhSOgjJLS3A7b6WhZzFrLYQph9lHED6wLfcQ3K
X-Developer-Key: i=bochaolucky@gmail.com; a=ed25519;
 pk=ZYp7O2eXSIrJ9YmKrl0iHDoulPYSG+1lzICsicAvld0=
X-Endpoint-Received: by B4 Relay for bochaolucky@gmail.com/default with
 auth_id=1042
X-Original-From: Bochao Cao <bochaolucky@gmail.com>
Reply-To: bochaolucky@gmail.com

This series fixes the XDP feature test and moves it to drivers/net/hw.
The tester uses AF_PACKET, so the remote host does not need native XDP.
Existing remote XDP programs and offload settings are left unchanged.

Changes since v4:
- Rebase onto net-next 8df0638138d3.
- Split the helper fixes, packet probes, build rules and framework move
  into five patches.
- Move the common BPF rules, including %.skel.h, into net/bpf.mk.
- Use installed kernel headers and register the helper in TEST_GEN_FILES.
- Handle short control messages, EOF and helper timeouts. Use XDP links
  on the DUT to release the test's attachment when the process exits.
- Skip unsupported native XDP and veth XDP_TX without a peer XDP program.

Tested on x86_64 Ubuntu with Linux 6.8.0-124-generic:
- headers_install and the xdp_features build passed.
- Three veth setups: 17 PASS, 1 expected XDP_TX SKIP, no failures.
- Nine error and cleanup checks passed. Existing programs and offload
  settings were unchanged, with no helpers or namespaces left behind.
- Patch 2: two concurrent runs passed all six cases each; repeated TERM
  also left no helpers or namespaces.
- Protocol framing checks, Ruff, pylint and git diff --check passed.

These tests used veth devices. Physical-NIC testing remains unverified.

Previous version:
https://lore.kernel.org/all/20260921-xdp-features-v4-send-v4-0-a0d4ec392cb7@gmail.com/

Signed-off-by: Bochao Cao <bochaolucky@gmail.com>

---
Bochao Cao (5):
      selftests/bpf: Fix XDP feature test setup and teardown
      selftests/bpf: Track XDP test processes and isolate namespaces
      selftests/bpf: Send XDP feature probes with AF_PACKET
      selftests/net: Add a shared BPF skeleton rule
      selftests/net: Move the XDP feature test to drivers/net/hw

 tools/testing/selftests/bpf/Makefile               |   11 +-
 tools/testing/selftests/bpf/test_xdp_features.sh   |  107 ---
 tools/testing/selftests/bpf/xdp_features.c         |  719 --------------
 tools/testing/selftests/drivers/net/README.rst     |   18 +
 tools/testing/selftests/drivers/net/hw/.gitignore  |    3 +
 tools/testing/selftests/drivers/net/hw/Makefile    |   15 +-
 tools/testing/selftests/drivers/net/hw/config      |    3 +
 .../net/hw/xdp_features.bpf.c}                     |   42 +-
 .../selftests/drivers/net/hw/xdp_features.c        | 1003 ++++++++++++++++++++
 .../{bpf => drivers/net/hw}/xdp_features.h         |    1 +
 .../selftests/drivers/net/hw/xdp_features.py       |  137 +++
 tools/testing/selftests/net/bpf.mk                 |   25 +
 12 files changed, 1212 insertions(+), 872 deletions(-)
---
base-commit: 8df0638138d3e0344fd1fb36cf2d1ca1cf5028f0
change-id: 20261008-xdp-v5-send-20261008-301d0e1d3165

Best regards,
--  
Bochao Cao <bochaolucky@gmail.com>


