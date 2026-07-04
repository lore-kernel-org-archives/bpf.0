Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242E1330317
	for <bpf@vger.kernel.org>; Sat,  4 Jul 2026 09:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783156933; cv=none; b=V0P2z8Yl4kl9efEXsIctNtcJ1/kBvS+X83DPdF6R/3alRpTMLfngQ8pPUJr9qPzk6ru5Jg6z8TJPnf13UAWy7u5AIfUWjrAhpXfBMn/Cpjtx9NwnCdW63Csv0NYA7vSL++2cB3nr/OEqmWbZ9lfuuDwC4fM1V3qYLWp3d2Rq0To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783156933; c=relaxed/simple;
	bh=dllSngM0zvxO1v5ssnhzMkLAGt8xboxcd17Ii9VCYBA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LNVmo+kP9B/o56xVeBNfYBA7+YSSj5G7b2kBT/vH4f5c9wKpi59iEHIKBLjmjzrAc5goEJafROxI1ENAc9OTHWtcEo1PqkTsNpjq0rzhL7pb50fPyBV0T0ZQmOuPJQ8h2FzGze8ItdQuF4ChhR5pJ39gvDcFLHs3AC0gfGfpduM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oZoHUO1v; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oZoHUO1v"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-381ed661712so774427a91.2
        for <bpf@vger.kernel.org>; Sat, 04 Jul 2026 02:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783156931; x=1783761731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UzWJONpzkCdirFiS8VKHmgg9vJNeKiCmuT7IeyhNbw8=;
        b=oZoHUO1vyfgJsHrlj7jXnac8Y7jFX6bNCl/ftdu8IISRsqEME/uJE0/A83H8yVsc7t
         WHgiurXdOrn5zlM1oRmm50BegFEyQ30S9GgqWiqVNfBlZCJQTJa5VQNo69nm+H7NfZYu
         YV7LX4d7GySYMkDpu6jqNh/99w9z/nnf8U+XYOA82KAuEcRIyC8k9f73l1anTQNO2sqF
         2G4pKU0w4aGPSLilKQcC4Wye+w0Jr/D0Y3XqqEHJMcBtSJ0SbP+sfhluMMeIHDF/3K0D
         020XnE++zeBtNcH7tXs/3NllP9rf6Lf27nCIx4Fqm3mSJwZPSBrVQGerPUYMMvwHMHhN
         8fpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783156931; x=1783761731;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UzWJONpzkCdirFiS8VKHmgg9vJNeKiCmuT7IeyhNbw8=;
        b=p8qiHL2+Y72HL0qKdZAm8Fi4GcRpvIxPNtmc1/ftdLiDR36HfsggfudCCESHjeTnyE
         n7wf8arZ4Lgssb1/svtCjY1XIrUZAeM6PHqdzbpYcqlI2z6wx6rI9n5a0j4YQF/TnTmC
         l8gB3Onl6RKS8tbfoTiwMZYbZfOnfi4lwG8am52Ieg4xaLd56oC6akkLFgUGyRBs5Ywv
         HDvtUcM4m81rBhAfY392uy18Hr1s3m8zwHnVfiw4VtRGnfhb/+LwMJ2ufQHpmLgBeolH
         f21NUTgUQ4T1d1ajZWXqAlaiomVBhbIfa2fY/MAuq2vB4bjM8A/ftzmfEWIJgmeBRQ+1
         UXJA==
X-Forwarded-Encrypted: i=1; AHgh+RrxKpXpJtmXRGm+U0WDdpwd9cuBrmQYwNEA0cWTG4S/fzcf3cX0jgh6K1+1AUXHihtxV1c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLmS7WxB3F3gLtsEfhLCAGyj4VaJbzSpZH/EaVkoF1mIUQOtCm
	qZnrEXDIYMPPirOplpI+X0xjpncpT3dasuxkZAq+mebP4yX7HfOqwHc5
X-Gm-Gg: AfdE7ckiO6827Jywkw0WUqEOWKTD2g17V+a2jCRT2ooYhj3MBWnL6clkTdKgLCq1xW4
	GsbMlwlj3aj1NL/+XWZLHvzz/acAHNb9I9UWFdC7jMk+emJ9f7ocPyleWUA/RxjQhtlOtDpRvwm
	/rDQSKB4sNj6N/f73vY/vSrJBHIoITtmTjfQlV09l3oAOVieg6bxe7/CTfOi0N5P6JRv1ZDkLW8
	1cJAsDA9XMWTMSjmAXg20M18MxeG0amLoUJD+vQg/WlSbbE5+zEX9zlkjHKA7rRzi3GaDfBv3US
	DloOJ6tyvVWE1zMxLv5RGEbJtM7Sr+iPdAndE/FT7xlXT6gpsIrMxVrPa/I9i/xP8df8oxPlxbA
	UZfv/s4S7Kpud4/FjaDWQZ8DIyXennPO6Uo8HzWURkGGN0Udh3NFUc0AYqD+blFXsGuDSlVJpcI
	R8RizoxLH6yzh0MNEGe1DJ6VpFHU9Rcc8ZBSLJo8sGpBMLyd+5UtjDX5RaBjtjgo04p/mlRvk=
X-Received: by 2002:a17:90a:e703:b0:37f:9ce1:736b with SMTP id 98e67ed59e1d1-3829f9ea9dcmr2672536a91.33.1783156931264;
        Sat, 04 Jul 2026 02:22:11 -0700 (PDT)
Received: from r912.tailbb6e1e.ts.net ([182.70.116.80])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0bc27ae7sm28006464eec.26.2026.07.04.02.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 02:22:10 -0700 (PDT)
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
Subject: [PATCH bpf-next v6 0/3] bpf: bidirectional VLAN support for bpf_fib_lookup()
Date: Sat,  4 Jul 2026 14:51:56 +0530
Message-ID: <20260704092159.1256823-1-avinash.duduskar@gmail.com>
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
re-issue without the flag for the VLAN device's own ifindex. A VLAN on
a bond reduces to the bond, which picks its egress slave at xmit.

The new return code is appended after BPF_FIB_LKUP_RET_NO_SRC_ADDR
(nothing renumbered, tools/ mirror updated) and is returned only when
the flag is set, so no existing caller can observe it.

Changes v5 -> v6:

- Patch 1 (BPF_FIB_LOOKUP_VLAN: resolve a VLAN egress to its real
  device plus the tag): no code change.
- Patch 2 (BPF_FIB_LOOKUP_VLAN_INPUT: run the lookup as if the tagged
  frame arrived on the matching VLAN subinterface): no code change.
- Patch 3 (selftests for both flags, tc and XDP paths): comments
  restyled; dead skb.ifindex write removed.

v5: https://lore.kernel.org/all/20260624030530.3342884-1-avinash.duduskar@gmail.com/
v4: https://lore.kernel.org/all/20260623025147.1001664-1-avinash.duduskar@gmail.com/
v3: https://lore.kernel.org/all/20260617224729.1428662-1-avinash.duduskar@gmail.com/
v2: https://lore.kernel.org/all/20260616223426.3568080-1-avinash.duduskar@gmail.com/
v1: https://lore.kernel.org/all/20260609172052.81613-1-avinash.duduskar@gmail.com/

Avinash Duduskar (3):
  bpf: Add BPF_FIB_LOOKUP_VLAN flag to bpf_fib_lookup() helper
  bpf: Add BPF_FIB_LOOKUP_VLAN_INPUT flag to bpf_fib_lookup() helper
  selftests/bpf: Add bpf_fib_lookup() VLAN flag tests

 include/uapi/linux/bpf.h                      |  50 +-
 net/core/filter.c                             |  97 ++-
 tools/include/uapi/linux/bpf.h                |  50 +-
 .../selftests/bpf/prog_tests/fib_lookup.c     | 712 +++++++++++++++++-
 .../testing/selftests/bpf/progs/fib_lookup.c  |  36 +
 5 files changed, 931 insertions(+), 14 deletions(-)


base-commit: a975094bf98ca97be9146f9d3b5681a6f9cf5ce3
-- 
2.54.0

