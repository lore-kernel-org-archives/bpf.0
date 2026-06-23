Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345A9D531
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 02:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782183122; cv=none; b=KT9kYE/Skp+lfRSiKVhR7gNPyrdPBiC+EYek58GdkqWbTpF8LCwKZythRzx5chjfCVZYJmil5BrfX5QBQCcxhS9CYWe7oUXsyoLyFfEdf55Mw+YD/YxQyidtwswIfUHErwQRKt07N8iSgK1Ae9Hvv9yzNMjHzHI2pEi983hOb1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782183122; c=relaxed/simple;
	bh=p+nffAW408DMeJGJh50kWk8zhQg2b3tHyUIep+5bpYk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hjmxGOco1sO6EupBHjbo1sFHYmP57QK/CmUa3DvHCSkHGYsiNNv9dDYGAyrzrnXyajWHgREo2EF7WEv2JxVd2q/ZtruyuHOsslJWXON6vK1pYQu+KC+5vBNhdl0ysUJVVJ71fnCGHnuAOzsO9uK6BUPWdG+5lX53xlAg5HAv4kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O/DR/nIg; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/DR/nIg"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c892a0ef503so3207633a12.2
        for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 19:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782183119; x=1782787919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KV2chNMnw+kmRFfisbGqimiQM5mDTuIEZMht/aRpHIc=;
        b=O/DR/nIgi7j9J6O+k0kOUIYS6iTDPzoPM0oac4ANwIJvAhSBE8MDbijgo4KrNuGkl3
         YZ9njHxQ2FjFEJxWkMT29p3GPI1RCFDW8IcuEyf2TyhyAX09h3+DNRRiVEwUQ6/5CqO4
         5r5z4QXcEdRedSfd05g2Y1F2MgUnCsTsBmYPfOENKvIrBgbzUOiXY9VhDqqMvuYuCQrQ
         t0gi48TCtJAUSiEjHZh3mAZMbiqiSEUO/PKKDE+cfYDWvWopfYM3PFOQTxffD8udCDiG
         OWQ/xVRktN+AqltlgENRhIn8UqCYTq9MJi9R/nSsuCQiqtLgR7MiKUibALg9xii1KwQ2
         B01Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782183119; x=1782787919;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KV2chNMnw+kmRFfisbGqimiQM5mDTuIEZMht/aRpHIc=;
        b=dYYC868uNc29d1qhrG90Mod9EeETtyf9gqfvmnN3SuZv3y1yrZeCt6f1A0X3APveer
         +n5MnmVhpozaJfbY52IJo5Ajd4wGGGNaKAbLqySe0SLbq3dVB+CHwOHoO+b0UWjZULkX
         A5AwcesemJvlxrajflhoDlp55e+doxAWongYlLr+qzM4PeirxW6HrrEuRG/qyuPoU9qt
         KvkJ8mZqsAAWlLlM9M4ClsoK4qj20wqlOwklWwg/mgGE8qD0hmUYuOn289i874TYUU47
         TSvg1dnPIc7UywUoxkHdiki9fLdb04PWHD6OV7kqS8pvgDr/783SPJOn1kU/jW4r90iL
         0rZw==
X-Forwarded-Encrypted: i=1; AHgh+Rol/uvhxJHOpJrhEDzNpcZzO10zqoDz+o/ojZZmvKihOo4z05f0XiNhXfsXpymhbIHNSyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHjbL4LPqku23bpSrqAO/h9/TbcpUjCmCJU7fwoQh/FosEDlpW
	z4kJ9JQcR4A9LNycE6MudfRUXrNU2XNAJ0CSO6vlWrlhx3B1eeyPrglC
X-Gm-Gg: AfdE7ckoWdnt7BvhEFSw1uUXipbZkrcsK6oVV01/vAxxd/QcCfRZx9w0j1VCiLwEKsJ
	SNEbVPoywuCg7jzQ7mTiruV3eqGt8jOSnc+wlpRXdzgd7ebJ6Mb/KEVJ267MExM3WZqY6wSUhLX
	XpaxIigLNMG/0dNsyevWSesULomsFbrIUn0I1vd+WO2Xj7U8Z/2Rluk9IqJUZuSUnVtYfHjGH+y
	0Lkc5l7yoGROYR//z9XOaeoUxSh5S2jWlQ4mE4FiyEAbLt0sEs7Ns4hAQpsw1ZWXN5yw552aLO3
	ukKd+f9p8UDzI3s1p/vRPktNQp4g1E9EiuAFJO+jc1cf5PgRtURidGZ2OtA7KJrr9LDio3YDXq9
	vafsj47sfXmqLEqslNvOPZIVvIuQIL++M1sW2ZDwc/lVGcu+eKfXbd/WspqZebGR4CaDfuHi83R
	ghtBKr/c8tSMxw0fOXzE2iQZqcEle2W+xSpk9e8b/WTuhX0/8ZVngx829el+rC
X-Received: by 2002:a17:902:e5c7:b0:2bf:379b:53d2 with SMTP id d9443c01a7336-2c7c995af52mr4223915ad.15.1782183119337;
        Mon, 22 Jun 2026 19:51:59 -0700 (PDT)
Received: from r912.tailbb6e1e.ts.net ([182.70.116.80])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7439f8e51sm102704625ad.39.2026.06.22.19.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 19:51:58 -0700 (PDT)
From: Avinash Duduskar <avinash.duduskar@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	hawk@kernel.org,
	yatsenko@meta.com,
	leon.hwang@linux.dev,
	kpsingh@kernel.org,
	a.s.protopopov@gmail.com,
	ameryhung@gmail.com,
	rongtao@cestc.cn,
	eyal.birger@gmail.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	toke@redhat.com,
	dsahern@kernel.org
Subject: [PATCH bpf-next v4 0/3] bpf: bidirectional VLAN support for bpf_fib_lookup()
Date: Tue, 23 Jun 2026 08:21:44 +0530
Message-ID: <20260623025147.1001664-1-avinash.duduskar@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series adds VLAN awareness to bpf_fib_lookup() in both directions.
BPF_FIB_LOOKUP_VLAN resolves a VLAN egress to its underlying real device
plus the VLAN tag (XDP programs need this because VLAN devices have no XDP
xmit), and BPF_FIB_LOOKUP_VLAN_INPUT runs the lookup as if a tagged frame
had arrived on the matching VLAN subinterface, for iif policy routing and
VRF table selection.

The independent l3mdev/VRF flow-init fix, patch 1 in v1 and v2, was split
out and merged to bpf separately.

v4 changes what bpf_fib_lookup() returns in one case. v3 left a VLAN
egress that cannot be reduced to a physical device plus one tag (a QinQ
egress, or a parent in another namespace) as best-effort SUCCESS with
the VLAN device's ifindex. In his v3 review Toke asked for a distinct
error code there instead, so an XDP program cannot mistake an unresolved
VLAN egress for a physical one, and suggested the name
BPF_FIB_LKUP_RET_VLAN_FAILURE; v4 implements that. The
code is appended after BPF_FIB_LKUP_RET_NO_SRC_ADDR (nothing renumbered,
tools/ mirror updated) and is returned only when BPF_FIB_LOOKUP_VLAN is
set, so no existing caller can observe it. On that failure params->ifindex
is left at the input, like the input-side failures; a tc or XDP program
that wants the VLAN device's own ifindex re-issues the lookup without the
flag, the recovery path he described.

The reason for a distinct code rather than best-effort SUCCESS: SUCCESS
on an unreducible egress silently blackholed XDP. A redirect to the VLAN
device drops at xdp_do_flush() with no in-band signal to the program;
VLAN_FAILURE makes the unreducible case explicit, and a live-frames
selftest exercises both the redirected and the passed paths. Only the
immediate parent is resolved, so QinQ and foreign-netns are the
unreducible cases; bond, team, TBID and VRF egress resolve, as the
selftest table pins.

Changes v3 -> v4:

- Patch 1: return BPF_FIB_LKUP_RET_VLAN_FAILURE for an unreducible VLAN
  egress, leaving params->ifindex at the input.

- Patch 3: the QinQ-egress and cross-namespace-egress arms expect
  VLAN_FAILURE; an escape-hatch arm re-issues without the flag for the
  inner VLAN device's ifindex; and test_fib_lookup_vlan_redirect drives
  live frames (BPF_F_TEST_XDP_LIVE_FRAMES) through the native redirect
  path, asserting a reducible egress is delivered and a QinQ egress is
  passed to the stack. The selftest's VLAN_FAILURE arms are IPv4 only,
  since bpf_ipv6_fib_lookup() restores params->ifindex with the same code
  as the IPv4 path that the arms exercise.

The three other v3 questions Toke marked fine as-is, and v4 keeps them: an
unmatched, down, or cross-namespace tag on input returns NOT_FWDED;
OUTPUT | VLAN_INPUT is rejected with -EINVAL; the BPF_FIB_LOOKUP_VLAN_INPUT
name is kept.

Taking the tag as lookup input follows the approach David Ahern suggested
in the 2021 fwmark discussion:
https://lore.kernel.org/bpf/6248c547-ad64-04d6-fcec-374893cc1ef2@gmail.com/

v3: https://lore.kernel.org/all/20260617224729.1428662-1-avinash.duduskar@gmail.com/
v2: https://lore.kernel.org/all/20260616223426.3568080-1-avinash.duduskar@gmail.com/
v1: https://lore.kernel.org/all/20260609172052.81613-1-avinash.duduskar@gmail.com/

Avinash Duduskar (3):
  bpf: Add BPF_FIB_LOOKUP_VLAN flag to bpf_fib_lookup() helper
  bpf: Add BPF_FIB_LOOKUP_VLAN_INPUT flag to bpf_fib_lookup() helper
  selftests/bpf: Add bpf_fib_lookup() VLAN flag tests

 include/uapi/linux/bpf.h                      |  47 +-
 net/core/filter.c                             | 133 +++-
 tools/include/uapi/linux/bpf.h                |  47 +-
 .../selftests/bpf/prog_tests/fib_lookup.c     | 696 +++++++++++++++++-
 .../testing/selftests/bpf/progs/fib_lookup.c  |  36 +
 5 files changed, 930 insertions(+), 29 deletions(-)


base-commit: a975094bf98ca97be9146f9d3b5681a6f9cf5ce3
-- 
2.54.0

