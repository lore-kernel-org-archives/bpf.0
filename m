Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BC339B4A3
	for <bpf@vger.kernel.org>; Wed, 17 Jun 2026 22:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781736463; cv=none; b=H8ptRwaeOoDMmpHwp59qlldCy25W8PA7Bk98pN5DaPPEXl1rpUKNOpLKr/HqOGcCa3qv+V4ItWJOrOajBfJpDTT04O11ZC70Najz7sgTQnjnCwVVxPWWzuFldWTbzAYD0T3POfc/1RiA/m+utJZndlnpv6T9+IMGvnIz8bcILkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781736463; c=relaxed/simple;
	bh=0Pw+svSWJOtjmDDewpriaF+GOGAm5aaXJWRfsX8EmrM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oJE95M8o9xWF4qeJ9lvYkn5/XwL6L2EgUdVfbAyfcFjxmggBEn8pXF3lR+oKInxYYyUxBEz8UexGCeXQA1q/XsJ5FkQrCZ+ySZG2zio9B9zaUrxKAthFYMdwRx+XY8HFocyh53n+W7DJHnW28ABNfCj5Duj62EfgsRGVqEzMG6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lfoltrSG; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lfoltrSG"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2c6bdb8a8bdso1899525ad.1
        for <bpf@vger.kernel.org>; Wed, 17 Jun 2026 15:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781736461; x=1782341261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P/y/t5Vl5iUpYZm6pqLSniaJaDjD3Clg3KVSkarvnkg=;
        b=lfoltrSG7grlGoSqXQOM8cA7fEB2pkJWPdj0rviNxZXbf1iNCDkcxf134Fpxxdi9TP
         4cu5DW+9Lz4WQ8Ru7iTb18vIcspmrDX9JSZYGvRmnMIaMsTtslw1IMh0NOKDTa+6VAHF
         +BPdgpCVWJ7fTJI02n7mzQenErqYXP3rebLuLbTAMPtgDLuvVx0aoGEuOGo6oI8j0BKn
         cWEhnbxE1dtUssdEqqhnOiCC4N98w8djbsNwS1ODd2tutOjPYNxPntimVglerCXnQjkW
         WDheYs3UpjSRMBO8TNeP4KsG55KIu4N/pvqTxhdCgns5mQ86C/dp0dcXZ3h1WsyIWGWJ
         STCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781736461; x=1782341261;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P/y/t5Vl5iUpYZm6pqLSniaJaDjD3Clg3KVSkarvnkg=;
        b=DdFJzvbqIzCzGAut6x9mgVQOTtvJyXmcQpseAFsg5/vVgcS2K1zK4i1v8Xkk6C2Muw
         D4VxXyq21NPc+PpZZtfyeop+O42JO7q3ULz0CkMsOV8jwIK5mE23+U/4aQEttbZMF4Dt
         u1jCWWtFdVL5uBagIxuAY1TUBYQRKMSviRiY9LaPWZBtzK/25gNshY0VweCQmNrmpy9j
         IwLGzNlHl2KfSO9egSkUHWwpkrO3BoRRYI77WOkxLzLRz1EY8S6S6XmehM0QktPm64lN
         yLtZwTRC41Q1i9ZZhPCKbey9nKhC7Tx79pRad0dY1Cf5EN42M2biNT8evpa1+hh83e3I
         lVLQ==
X-Forwarded-Encrypted: i=1; AFNElJ/o26aEr+MEyFlVG4tka3iown1hmp8z960UETU3k35tPj0hGt+kJzO13v5bdtnJemBc2iw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKAOFAwf/UTD4JvmnM2o6N7jybRy6/bUmwYBJel42McYO+o0+q
	CZmp3/rM+X/w7//4sg4iAtBKzL4e+CFum1tyY8bdqZDhFvLFGnpw1LBY
X-Gm-Gg: AfdE7cnas6YVNS1RWb5mXzxc6/NaGABpCVvAUlnT3qmnBKHCtkrtXfKCequtjJsu6Ex
	MAy9ARldcanE0dIiNTUCpclhLLmEHzkFh8z7g53wi91iJcUZj8bJM95OSi/R4yZHJbMvO/yuY6H
	dKtkMNlgWZ/dgLwpzdZbZ7X7Bw+yhj4ReXKa+kxScIe2WwWgqn+MtxBEjYlPH/AJsTibnSpG8AJ
	8XwsbRCFoI3FjaTqrfJbub9uPbNtMAobJZGo77lejaEV3sGxlWXXAzlmpwnTv/i/xWnrl+N8AWE
	sbShAXYbNk82a3qCzbFq6DHKaU3L2NvXbehEtf7pBiALqqYhsluvXQYuxvLEMA5el2ZieuZ2Qtk
	WFLNAKK4NjHB4XoKDuwhR2UmDAfbHzN9soS6KLHnZIBuAgXv3AVCR8NeXPJPM5upfAAaqYqIiWI
	iyaPLnpTWzCxzITqdDGBCOl9JFj0sLUKG64iZrYMjmzPsOqqpgKWTHKr/ehZgnfu57pTa8G4k=
X-Received: by 2002:a17:902:e945:b0:2c2:245a:3366 with SMTP id d9443c01a7336-2c6bc24a8a6mr55669695ad.27.1781736461349;
        Wed, 17 Jun 2026 15:47:41 -0700 (PDT)
Received: from r912.tailbb6e1e.ts.net ([182.70.116.80])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c433844a70sm170772265ad.84.2026.06.17.15.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 15:47:40 -0700 (PDT)
From: Avinash Duduskar <avinash.duduskar@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: ameryhung@gmail.com,
	a.s.protopopov@gmail.com,
	bpf@vger.kernel.org,
	davem@davemloft.net,
	dsahern@kernel.org,
	eddyz87@gmail.com,
	edumazet@google.com,
	emil@etsalapatis.com,
	eyal.birger@gmail.com,
	hawk@kernel.org,
	horms@kernel.org,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	kuba@kernel.org,
	leon.hwang@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	martin.lau@linux.dev,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	rongtao@cestc.cn,
	sdf@fomichev.me,
	shuah@kernel.org,
	song@kernel.org,
	toke@redhat.com,
	yatsenko@meta.com,
	yonghong.song@linux.dev
Subject: [PATCH bpf-next v3 0/3] bpf: bidirectional VLAN support for bpf_fib_lookup()
Date: Thu, 18 Jun 2026 04:17:26 +0530
Message-ID: <20260617224729.1428662-1-avinash.duduskar@gmail.com>
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

The l3mdev/VRF flow-init fix that was patch 1 in v1 and v2 has been split
out and sent to bpf on its own, since it is an independent Fixes:-tagged
fix that routes to stable on its own schedule. This series is otherwise
independent of it: on the default CONFIG_INIT_STACK_ALL_ZERO the VRF
selftests pass with or without the fix. Only the one full-lookup VRF arm
("IPv4 VLAN input, tag selects VRF table") depends on it, and only on
INIT_STACK_ALL_PATTERN or NONE builds, where the uninitialized
flowi_l3mdev otherwise misses the l3mdev rule and the lookup falls
through to the main table. Applying the l3mdev fix first closes that
window.

Changes v2 -> v3 (all from Toke's review unless noted):

- Split the l3mdev/VRF flow-init fix out to a standalone bpf submission
  (it was patch 1 in v2).

- Patch 2 (VLAN_INPUT): bpf_fib_vlan_input_dev() returns a
  struct net_device * with ERR_PTR() for the -EINVAL case and NULL for
  NOT_FWDED, instead of an int return and a **dev out-parameter.

- Trim the BPF_FIB_LOOKUP_VLAN and BPF_FIB_LOOKUP_VLAN_INPUT UAPI doc
  blocks, and drop the in-function comments that restated the commit
  message or the flag doc.

- Patch 1 (VLAN egress): on the skb path without tot_len, the deferred mtu
  check now runs against the resolved egress (VLAN) device, not the parent
  params->ifindex was swapped to, so a VLAN device with a smaller mtu than
  its parent is no longer checked against, or reported as, the parent's
  larger mtu. Found by the bpf ci bot; this was an open question in v2.

- Patch 3 (selftests): re-run every case through bpf_xdp_fib_lookup() as
  well, since the feature targets XDP; and flip the no-tot_len mtu arm to
  expect the VLAN device's mtu after the fix above.

Open questions (defaults chosen, noted here in case a maintainer
prefers otherwise):

1. An unmatched, down, or foreign-netns tag returns
   BPF_FIB_LKUP_RET_NOT_FWDED, matching the DIRECT path when
   fib_get_table() finds no table, rather than a new return code.

2. BPF_FIB_LOOKUP_OUTPUT | BPF_FIB_LOOKUP_VLAN_INPUT is rejected with
   -EINVAL; restricting now keeps relaxing later backward-compatible.

3. The name BPF_FIB_LOOKUP_VLAN_INPUT reads oddly next to
   BPF_FIB_LOOKUP_OUTPUT. A pair like _VLAN_EGRESS/_VLAN_INGRESS is an
   option while nothing is merged.

4. The egress flag leaves a VLAN it cannot reduce to a physical parent
   plus one tag (QinQ, or a parent in another namespace) as SUCCESS with
   the VLAN device's ifindex and the vlan fields zero, like a plain
   lookup. The input side instead fails closed (NOT_FWDED) on the
   cross-namespace case. An XDP caller cannot xmit on a VLAN device, and
   a zero h_vlan_proto does not distinguish this result from a physical
   egress, so returning NOT_FWDED would be safer for XDP. But the two
   cases differ: a foreign-netns parent is clearly fail-worthy, while a
   QinQ egress is still a forwardable route (tc xmits on the inner VLAN
   device), so failing it closed would reject a usable route. Should
   egress signal NOT_FWDED, for both or only foreign-netns? I left it
   best-effort, but will change it if you prefer.

Taking the tag as lookup input follows the approach David Ahern
suggested in the 2021 fwmark discussion:
https://lore.kernel.org/bpf/6248c547-ad64-04d6-fcec-374893cc1ef2@gmail.com/

v2: https://lore.kernel.org/all/20260616223426.3568080-1-avinash.duduskar@gmail.com/
v1: https://lore.kernel.org/all/20260609172052.81613-1-avinash.duduskar@gmail.com/

Avinash Duduskar (3):
  bpf: Add BPF_FIB_LOOKUP_VLAN flag to bpf_fib_lookup() helper
  bpf: Add BPF_FIB_LOOKUP_VLAN_INPUT flag to bpf_fib_lookup() helper
  selftests/bpf: Add bpf_fib_lookup() VLAN flag tests

 include/uapi/linux/bpf.h                      |  41 +-
 net/core/filter.c                             | 125 +++-
 tools/include/uapi/linux/bpf.h                |  41 +-
 .../selftests/bpf/prog_tests/fib_lookup.c     | 554 +++++++++++++++++-
 .../testing/selftests/bpf/progs/fib_lookup.c  |   9 +
 5 files changed, 741 insertions(+), 29 deletions(-)


base-commit: e771677c937da5808f7b6c1f0e4a97ec1a84f8a8
-- 
2.54.0

