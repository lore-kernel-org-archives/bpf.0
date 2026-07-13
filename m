Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BEF233704
	for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 16:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783959801; cv=none; b=aJLKUVKgP+qwYghtYlGrZn3ApvQXPMaTE3L86c2sIaJehTrzdOiZP2ezDugnyVpwi+mbbsQvkfK7K+Zp8cdf+m7n8FlxPimTaymVZKPF5ygdqhhLZNOk/ByVeW1CMjemesXRDL6JEEKs1EUasW3O2I0Xokl0e86gu5wctPagNV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783959801; c=relaxed/simple;
	bh=B7kjpC2G00xRZiwpS45deuXBg70rScBz3ZVyNCPDYfg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rr8ppc9as4FxpBevZSz7wWHO0bXi56S5y/m21uB5fDeLb8HofafMR3lpH/ULMFEDBoim/l72EabQ5TwwPFEQzFMeWsNNhFQaBiTSLlXPdJ1gL/PUwHvoHufuM6g68bMD9MFh25FcBenrSzcIeiLfI5W3kFPmS/UK5XRTZ+P9eaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PgP0dTjX; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PgP0dTjX"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cab973140bso38276745ad.3
        for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 09:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783959798; x=1784564598; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qLsS+LiJOOGjNompP9VG70BhV07yJqBPnV7nhWUrazk=;
        b=PgP0dTjXzzEMgL55AI1+a/kNuAZSv3efznTsu3jVfGwbnEW21BVhxW7svYTEiFsiPK
         YR3OoUcnoMuhj2Ww/QfUYdkBeCuvHrFv72+CWWxOFnwBBtPIJBv69YeTuzj2oZGqNRB/
         qdaNTv9NcdDrEDVYV4NyDTDc1hGx1kDPql7PeG0O+vS7xl1SAlW9DSku/jPQ4KCYcqxt
         03LtVxbSYKEACJTw+E57UOri8yeiK6+XrS84Q1ApKZa77jA1uVV3aGb5Hms1gZlUJlr3
         9vY2Cvcs+jnqEaGG/x6BpfKhDkU3LZRDvudLEPMM0D3thSXmnhZl0G/Y2EJkAf89I5ht
         m/gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783959798; x=1784564598;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qLsS+LiJOOGjNompP9VG70BhV07yJqBPnV7nhWUrazk=;
        b=FroIwvLRrQgrp+Fc+XpNy8bA2WHZjJjeJNC24FbVMIGEfEQ7//589byRFr4yGH1LkH
         KukdACZ14muVTfEpkIap6FgsRimjHVid1WKTHwjnkNdkojhqMdiG9WiPQ78PCDmZFa+u
         aQGB3zd3Bk0EZhkoSepGnmKCBYD3UYO0KeoYu5ZY9t21bUAPcMryHM/gfTcBhNQXV7Cs
         FmVn0yzXOoMfXu5U8OJHGXObsWvE27DKAKalYiDUmQVmUcne8Bh/vfz9WSy7/N+sDVLm
         vpJ2wosVTs4S84GGLhWaAgPFv2+ZLWnPJx5907be2Su6xG9keuQX7bkSk3V/UtKny6fe
         jqzg==
X-Forwarded-Encrypted: i=1; AHgh+Rq2I2F0wggbsr7Y5VS0ukEKmQHenymgBTnkFtzVv/eh0gNziHmzYW1QvSUceOd/Xs7Nsvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YySfXy2C+fSwEbq+g/1sjYMBex2dyhbrPfYgPY2Zdj89G7Tztdw
	gAxJQK6XiyBR7edUEnVHFFUIg7tCdY71yBN74HNCNBpDE1wHi4yM+sLdDbaLR8Jp
X-Gm-Gg: AfdE7cnLs0gLIkjzisw720aYu3wPqidzTrcPh94uFg806HgSh9Y7iDHWHsRKwKs4oBh
	J41BzYZvgoyLGMcAap1CS0dZmuP9wPHMDl5mxy1aS2RP/MvNSy6DJ6/U0r7nXvgPOpJUlw+3F8D
	PTqnwXbg1/8sqr07iNzrw1k4LhSxJD9Lq5Z4Qt1ipduq/COhDOEjCvm+ZF0gdQ8RyaH2l7OUqd0
	v9PIPgAvqFNtWWa4etOF+En21fKdaUSJhWHWx3dJnx1CGp0jV8lVcKBtBt7JeSNr7Jz3y6EAYyZ
	OaDnZN5F429CC/bIFnOQlpKKI99zBjlzK1N2myn8bEYa7K6B2pRSMbXwAmLT189ejQ+E5iesiov
	AnRDUDp6woUuKqtBDA4FUhMYm+s07ZWmaUkSmmcZ+/e5L3HsJ6AbtLclNQIjMl/znmlcVRs6AeN
	Er5L+sT9MfXPiQ1p0ieUXEamMsspjW5rAdp2ZTwEoeArmjZNLtoFtY0uT6303+8dNzq9VAhg==
X-Received: by 2002:a05:6a20:a122:b0:3bf:9cbd:9a33 with SMTP id adf61e73a8af0-3c1100308e6mr10053783637.14.1783959797821;
        Mon, 13 Jul 2026 09:23:17 -0700 (PDT)
Received: from r912.tailbb6e1e.ts.net ([160.30.85.32])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b987fc629sm25769471c88.0.2026.07.13.09.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 09:23:16 -0700 (PDT)
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
Subject: [PATCH bpf-next v7 0/3] bpf: bidirectional VLAN support for bpf_fib_lookup()
Date: Mon, 13 Jul 2026 21:53:02 +0530
Message-ID: <20260713162305.1237211-1-avinash.duduskar@gmail.com>
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
plus the VLAN tag (XDP programs need this because VLAN devices have no
XDP xmit), and BPF_FIB_LOOKUP_VLAN_INPUT runs the lookup as if a tagged
frame had arrived on the matching VLAN subinterface, for iif policy
routing and VRF table selection.

BPF_FIB_LOOKUP_VLAN opts in to replacing params->ifindex, whose value
existing programs consume since d1c362e1dd68 ("bpf: Always return
target ifindex in bpf_fib_lookup"); without it the output is unchanged.

An egress that does not reduce to a real device plus one tag (a QinQ
stack, or a parent in another network namespace) returns
BPF_FIB_LKUP_RET_VLAN_FAILURE with params->ifindex left at the input;
repeating the lookup without the flag, with a re-initialized params,
returns the VLAN device's own ifindex. A VLAN on a bond reduces to the
bond, which picks its egress slave at xmit.

The new return code is appended after BPF_FIB_LKUP_RET_NO_SRC_ADDR
(nothing renumbered, tools/ mirror updated) and is returned only when
the flag is set, so no existing caller can observe it.

Changes v6 -> v7:

- Patch 1 (BPF_FIB_LOOKUP_VLAN: resolve a VLAN egress to its real
  device plus the tag): uapi doc clarified, repeating the lookup after
  BPF_FIB_LKUP_RET_VLAN_FAILURE needs a re-initialized params, since
  output fields overwrite the inputs they share storage with. No
  functional change.
- Patch 2 (BPF_FIB_LOOKUP_VLAN_INPUT: run the lookup as if the tagged
  frame arrived on the matching VLAN subinterface): no code change; a
  commit message correction (an invalid proto returns -EINVAL under
  !CONFIG_VLAN_8021Q too).
- Patch 3 (selftests for both flags, tc and XDP paths): local defines
  for the netns subtest addresses (Emil's review); the netns input arm
  brings the moved device up first, so the namespace check is the only
  condition it can fail on; the live-frames subtest uses its own netns
  name (no collision under test_progs -j) and counts only the test's
  TCP frames, so background traffic cannot satisfy the delivery
  assertion; a stale mtu comment corrected.

v6: https://lore.kernel.org/all/20260704092159.1256823-1-avinash.duduskar@gmail.com/
v5: https://lore.kernel.org/all/20260624030530.3342884-1-avinash.duduskar@gmail.com/
v4: https://lore.kernel.org/all/20260623025147.1001664-1-avinash.duduskar@gmail.com/
v3: https://lore.kernel.org/all/20260617224729.1428662-1-avinash.duduskar@gmail.com/
v2: https://lore.kernel.org/all/20260616223426.3568080-1-avinash.duduskar@gmail.com/
v1: https://lore.kernel.org/all/20260609172052.81613-1-avinash.duduskar@gmail.com/

Avinash Duduskar (3):
  bpf: Add BPF_FIB_LOOKUP_VLAN flag to bpf_fib_lookup() helper
  bpf: Add BPF_FIB_LOOKUP_VLAN_INPUT flag to bpf_fib_lookup() helper
  selftests/bpf: Add bpf_fib_lookup() VLAN flag tests

 include/uapi/linux/bpf.h                      |  52 +-
 net/core/filter.c                             |  97 ++-
 tools/include/uapi/linux/bpf.h                |  52 +-
 .../selftests/bpf/prog_tests/fib_lookup.c     | 720 +++++++++++++++++-
 .../testing/selftests/bpf/progs/fib_lookup.c  |  57 ++
 5 files changed, 964 insertions(+), 14 deletions(-)


base-commit: a975094bf98ca97be9146f9d3b5681a6f9cf5ce3
-- 
2.54.0

