Received: from mta0.migadu.com (out-192.mta0.migadu.com [91.218.175.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514B8426419
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 06:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789626975; cv=none; b=N7L7XDGafbBsF4UPcP2s/G4jjGk4xQRqjC7dtZvQo0et8nM3uV0bmoIQAVtKh1TwmNktSFJCzx53etEguWaadBG0HICelDW8soCTVYw/VkOT7C55MAVGRAJF+s7OGG75KmXakEPeaNVsSn3dYe2W7Z8TsunGhOp7KO4jom4wz0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789626975; c=relaxed/simple;
	bh=shy21RbL4czwRTmSL+ZvaG7No/spo0YxE4VJMlyEqn4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OjnaaYBGeo7j2NuX/kAXfcSVBNCp6MVrm2m3vE8K/+DMhvJWgpzuxi8jrPz9bW5TEHNXmeI46+DPmgIrQh7bb3lJKWYwdBl1kTzI8ycKovVpWl9y4lNeLYukJ2zHMwWCwLyiTsoREYgk9VNrfTEHHRIEo4DaiVa/RMeb7G4iokA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XFLbvuCq; arc=none smtp.client-ip=91.218.175.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XFLbvuCq"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=shy21RbL4czwRTmSL+ZvaG7No/spo0YxE4VJMlyEqn4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789626971; v=1; x=1790231771;
 b=XFLbvuCq+JUYPA8Qt2sv7HLZLdPK6pWkih5067tfwJfk1cJqJS2MRUyPmI6vDDdhwi0o/W0e
 BvXSjwcIUlBWEBh/zX6SmrZKup2V6X0Ecf2QLrZuZtlpdLLcLhf9e1BjMto3bJO6m+ifjNXsQYG
 y8vghEs29FZ9RqMxkS7omoZw=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 889b2a9018d7f516;
	Thu, 17 Sep 2026 06:36:01 +0000
X-Mizu-Trace-ID: 889b2a9018d7f516
X-Migadu-Flow: FLOW_OUT
From: Hangbin Liu <hangbin.liu@linux.dev>
Subject: [PATCH net-next 0/6] netlink: add lwtunnel encap sub-message
 support to rt-route
Date: Thu, 17 Sep 2026 14:35:32 +0800
Message-Id: <20260917-ynl_rt_encap-v1-0-fbbe6e680571@kylinos.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3M0QpAMBSA4VfRubY6MwmvIq3h4JQObUsk7265/
 C7+/4FAnilAmz3g6eTAuyToPINxdbKQ4ikZCiwqbLBWt2zWR0syukMZXaJGM5iqdpCSw9PM17/
 rQCgqoStC/74f7gMSkWgAAAA=
X-Change-ID: 20260908-ynl_rt_encap-3140103b368a
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>
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
 # ip route add 10.1.0.0/24 dev lo encap mpls 100 via 10.1.0.254
 # ip route add 10.2.0.0/24 dev lo encap ip id 1 dst 127.0.0.1 src 127.0.0.1
 # ip route add 2001:db8:3::/64 dev lo encap ila 1:2:3:4 csum-mode no-action ident-type luid hook-type output
 # ip route add 2001:db8:4::/64 dev lo encap ip6 id 1 dst 2001:db8::5 src 2001:db8::1 hoplimit 64
 # ip route add 2001:db8:5::/64 dev lo encap seg6 mode inline segs 2001:db8::1
 # ip route add 2001:db8:6::/65 dev lo encap seg6local action End
 # ip route add 2001:db8:7::/65 dev lo encap bpf in ob /tmp/kself/net/lib/xdp_dummy.bpf.o sec xdp
 # ip route add 2001:db8:8::/64 dev lo encap rpl segs 2001:db8::1
 # ip route add 2001:db8:9::/64 encap ioam6 trace prealloc type 0x800000 ns 0 size 4 dev lo
 # ip route add 2001:db8:10::/64 dev lo encap xfrm if_id 100
 # ip route show
 10.1.0.0/24  encap mpls  100 via 10.1.0.254 dev lo
 10.2.0.0/24  encap ip id 1 src 127.0.0.1 dst 127.0.0.1 ttl 0 tos 0 dev lo scope link
 # ip -6 route show
 2001:db8:3::/64  encap ila  1:2:3:4  csum-mode no-action  ident-type luid  hook-type output dev lo metric 1024 pref medium
 2001:db8:4::/64  encap ip6 id 1 src 2001:db8::1 dst 2001:db8::5 hoplimit 64 tc 0 dev lo metric 1024 pref medium
 2001:db8:5::/64  encap seg6 mode inline segs 2 [ 2001:db8::1 :: ] dev lo metric 1024 pref medium
 2001:db8:6::/65  encap seg6local action End dev lo metric 1024 pref medium
 2001:db8:7::/65  encap bpf in xdp_dummy.bpf.o:[xdp] dev lo metric 1024 pref medium
 2001:db8:8::/64  encap rpl segs 1 [ 2001:db8::1 ] dev lo metric 1024 pref medium
 2001:db8:9::/64  encap ioam6 freq 1/1 mode inline trace prealloc type 0x800000 ns 0 size 4 dev lo metric 1024 pref medium
 2001:db8:10::/64  encap xfrm if_id 100 dev lo metric 1024 pref medium
 # ./tools/net/ynl/pyynl/cli.py --family rt-route --dump getroute > /tmp/route_dump.json

All the result looks good.

Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
---
Hangbin Liu (6):
      net: lwtunnel: change encap fill order
      tools: ynl: convert enum selector to string for sub-message parsing
      netlink: specs: rt-route: add lwtunnel encap sub-message support
      netlink: specs: rt-route: describe lwtunnel IP options
      netlink: specs: rt-route: describe lwt BPF program options
      netlink: specs: rt-route: describe seg6-local actions, counters and flavors

 Documentation/netlink/specs/rt-route.yaml | 404 +++++++++++++++++++++++++++++-
 net/core/lwtunnel.c                       |   7 +-
 tools/net/ynl/Makefile.deps               |   9 +-
 tools/net/ynl/pyynl/ynl_gen_c.py          |  10 +-
 4 files changed, 424 insertions(+), 6 deletions(-)
---
base-commit: bc6fe9d301d59fe5cb236d646abe792bffae5fa6
change-id: 20260908-ynl_rt_encap-3140103b368a

Best regards,
-- 
Hangbin Liu <liuhangbin@kylinos.cn>

