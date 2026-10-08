Received: from mta0.migadu.com (out-145.mta0.migadu.com [91.218.175.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF943456296
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 08:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791447857; cv=none; b=kU73TK3g1JG5p9QZgfxWoa7ynEJuCJWGFqiOXAwbU7CzyAqfa5Gc7zgEqP3xP9O8ft3cOSSFliaUjcBiQExePFU16WQn/Q1O3XBanco/TAaS8plPAdfYU6E8J5VWhWcWm1KRLqwOn/oWf7uyPpkcJOtLl3Da8/jbQQiqTwNqDI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791447857; c=relaxed/simple;
	bh=RMx7jFiL65ZDGqd0DZ1v3Z2cM1AED/E0YCu2i1HQI2g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=t0TTnHYKZ4qSfe6S8q2BHktEO9UYRPUh7ocUofLU+MQ+z2MnCP36FEVfjOptME9TDcdwe0kmARbqYSpc5SyDZW23a6Hh/r/RLCK7DMj89/r5/Ur19Q9aIDWbwl0vvctGKUCC9bE/7TGvtbHfg54MqfS6pnLBXvk7fk3UBC+ayHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Z5PWxaKo; arc=none smtp.client-ip=91.218.175.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Z5PWxaKo"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=RMx7jFiL65ZDGqd0DZ1v3Z2cM1AED/E0YCu2i1HQI2g=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791447851; v=1; x=1792052651;
 b=Z5PWxaKoUGC06vBDipjkB1hzJU599uR5aNvbDcZNRB8flcIZVd0xVGne2xYUkhmfnsZRNI9+
 wWJLjhYJ7M4FK0rDRhun9W4mrBaOuHfKo0e4MlMvLDZBEZ1VQfPf7YPx6qRDF4LB04RLUu1TPHu
 VslM51st0uHq/Ov3EtUqsmFw=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id e009485256980d37;
	Thu, 08 Oct 2026 08:24:11 +0000
X-Mizu-Trace-ID: e009485256980d37
X-Migadu-Flow: FLOW_OUT
From: Hangbin Liu <hangbin.liu@linux.dev>
Subject: [PATCH net-next v4 0/6] netlink: add lwtunnel encap sub-message
 support to rt-route
Date: Thu, 08 Oct 2026 16:24:00 +0800
Message-Id: <20261008-ynl_rt_encap-v4-0-4ed2ccf7f949@kylinos.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2XNQQqDMBCF4auUrJsySeyoXfUepYimYw2VKEkQR
 bx7g92oXT6G75+ZeXKGPLudZuZoMN50No7kfGK6Ke2buHnFzSRIhBwyPtm2cKEgq8ueK5GAAFU
 pzEoWSe+oNuOaezBLgVsaA3vGS2N86Ny0/hnEev8lRbpPDoIDr6uKkDCDayrun6k1tvMXbdfSI
 DdawkHLqDViUipKJdb4p9VGq6NWUScCUEtR5UTpTi/L8gWfnqhaLwEAAA==
X-Change-ID: 20260908-ynl_rt_encap-3140103b368a
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Donald Hunter <donald.hunter@gmail.com>, Eric Dumazet <edumazet@kernel.org>, 
 Eric Dumazet <edumazet@kernel.org>
Cc: Hangbin Liu <hangbin.liu@linux.dev>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 Hangbin Liu <liuhangbin@kylinos.cn>
X-Mailer: b4 0.14.3

This series adds YNL sub-message support for lwtunnel encap data in
the rt-route netlink family, and describes the tunnel-specific
attribute sets that were previously opaque binary blobs.

The kernel currently emits encap_type after the encap payload nest,
but YNL sub-message parsing needs the selector (encap_type) first to
dispatch on the correct attribute set. Patch 1 reorders the kernel
output, and patch 2 teaches the YNL C code generator to convert enum
selectors to their string form for sub-message dispatch.

Patches 3-6 extend the rt-route YAML spec.

Tested with ynl selftest and checked with following cmds

 # modprobe ila
 # modprobe xfrm_interface
 # ip addr add 10.1.0.1/24 dev lo
 # ip link add geneve1 type geneve id 1 remote 10.1.0.2 ttl 64
 # ip link set geneve1 up
 # ip route add 10.1.0.0/24 dev lo encap mpls 100 via 10.1.0.254
 # ip route add 1.1.1.0/24 encap ip id 1 geneve_opts 1:1:1212121234567891,2:2:1212121234567892,3:3:1212121234567893 dst 10.1.0.2 dev geneve1
 # ip route add 2001:db8:3::/64 dev lo encap ila 1:2:3:4 csum-mode no-action ident-type luid hook-type output
 # ip route add 2001:db8:4::/64 dev lo encap ip6 id 1 dst 2001:db8::5 src 2001:db8::1 hoplimit 64
 # ip route add 2001:db8:5::/64 dev lo encap seg6 mode inline segs 2001:db8::1
 # ip route add 2001:db8:6::/65 dev lo encap seg6local action End flavors psp,next-csid lblen 32 nflen 16
 # ip route add 2001:db8:7::/65 dev lo encap bpf in ob /tmp/kself/net/lib/xdp_dummy.bpf.o sec xdp
 # ip route add 2001:db8:8::/64 dev lo encap rpl segs 2001:db8::1
 # ip route add 2001:db8:9::/64 encap ioam6 trace prealloc type 0x800000 ns 0 size 4 dev lo
 # ip route add 2001:db8:10::/64 dev lo encap xfrm if_id 100
 # ip route show
 1.1.1.0/24  encap ip id 1 src 0.0.0.0 dst 10.1.0.2 ttl 0 tos 0
        geneve_opts 1:1:1212121234567891,2:2:1212121234567892,3:3:1212121234567893 dev geneve1 scope link
 10.1.0.0/24  encap mpls  100 via 10.1.0.254 dev lo
 # ip -6 route show
 2001:db8:3::/64  encap ila  1:2:3:4  csum-mode no-action  ident-type luid  hook-type output dev lo metric 1024 pref medium
 2001:db8:4::/64  encap ip6 id 1 src 2001:db8::1 dst 2001:db8::5 hoplimit 64 tc 0 dev lo metric 1024 pref medium
 2001:db8:5::/64  encap seg6 mode inline segs 2 [ 2001:db8::1 :: ] dev lo metric 1024 pref medium
 2001:db8:6::/65  encap seg6local action End flavors psp,next-csid lblen 32 nflen 16 dev lo metric 1024 pref medium
 2001:db8:7::/65  encap bpf in xdp_dummy.bpf.o:[xdp] dev lo metric 1024 pref medium
 2001:db8:8::/64  encap rpl segs 1 [ 2001:db8::1 ] dev lo metric 1024 pref medium
 2001:db8:9::/64  encap ioam6 freq 1/1 mode inline trace prealloc type 0x800000 ns 0 size 4 dev lo metric 1024 pref medium
 2001:db8:10::/64  encap xfrm if_id 100 dev lo metric 1024 pref medium
 # ./tools/net/ynl/pyynl/cli.py --family rt-route --dump getroute > /tmp/route_dump.json

All the result looks good.

Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
---
Changes in v4:
- patch 02: include check `not self.selector.is_external()` for enum selectors,
            return error when enum lookup failed. (sashiko, Jakub)
- patch 04: set geneve options to binary due to the different format between
            request and dump (sashiko)
- patch 05: set max-len for lwt-bpf-prog-name (sashiko)
- patch 06: fix seg6-local-flv-ops type and name prefix (sashiko)
- Link to v3: https://lore.kernel.org/r/20260930-ynl_rt_encap-v3-0-4106c21b9ee7@kylinos.cn

Changes in v3:
- patch 02: return local_vars and define new helpers is_enum_val and
  get_enum_name (Jakub Kicinski)
- patch 03: alphabet order for header files in Makefile (Jakub Kicinski)
  set byte-order for ila-attrs. ILA_ATTR_IDENTIFIER is not used, so no
  need to set byte-order. (sashiko)
- patch 04: add multi-attr: true for geneve opts (sashiko)
- patch 05: remove lwt-bpf-prog from seg6 local, add a seg6 specific one
  in patch 06 (sashiko)
- patch 06: add seg6-local-bpf and seg6-local-flv-ops. Set enum-as-flags
  for seg6-local-flv-ops, set max-len for seg6-local-bpf-prog-name (sashiko)
- Link to v2: https://lore.kernel.org/r/20260920-ynl_rt_encap-v2-0-c664a3e726f6@kylinos.cn

Changes in v2:
- Patch 1: Check ops->fill_encap before setting encap_type_attr
- Patch 2: Get string in generated sub-message parser and check it before reference
- Patch 3-4: set byte-orders and max-len
- Patch 5: include lwtunnel.h
- Link to v1: https://lore.kernel.org/r/20260917-ynl_rt_encap-v1-0-fbbe6e680571@kylinos.cn

---
Hangbin Liu (6):
      net: lwtunnel: change encap fill order
      tools: ynl: convert enum selector to string for sub-message parsing
      netlink: specs: rt-route: add lwtunnel encap sub-message support
      netlink: specs: rt-route: describe lwtunnel IP options
      netlink: specs: rt-route: describe lwt BPF program options
      netlink: specs: rt-route: describe seg6-local attrs

 Documentation/netlink/specs/rt-route.yaml | 430 +++++++++++++++++++++++++++++-
 net/core/lwtunnel.c                       |  35 +--
 tools/net/ynl/Makefile.deps               |   9 +-
 tools/net/ynl/pyynl/ynl_gen_c.py          |  34 ++-
 4 files changed, 484 insertions(+), 24 deletions(-)
---
base-commit: 8df0638138d3e0344fd1fb36cf2d1ca1cf5028f0
change-id: 20260908-ynl_rt_encap-3140103b368a

Best regards,
-- 
Hangbin Liu <liuhangbin@kylinos.cn>

