Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81D73ABDA8
	for <bpf@vger.kernel.org>; Tue, 16 Jun 2026 22:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781649281; cv=none; b=giD4zyL464cmjvRNFMiwdUyWRXs/PXgGFgFQfJDWIJe1RqXGXuKE7W69FrV8geEQSlwBtYA2TcG9qhclZg24W75SKBEtNujuWqAJ9Z5hUT2xy379VY86Hz9KcXzQocWGkJJ81O4fQmZfbE1+D4T0ZOiLqRKTSQ73u4XeRp5I34I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781649281; c=relaxed/simple;
	bh=OZ3v3p89lKDikS0IfPxvKaGvXHvDdXsNQEDqB4p0bL4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ETAY3pekBRqN1G6Q1MK3ETqftwpeN/UBlHqNBt05elxuLvoW3GpuheNfdBe5d7r+Zp5XPJne/Iqe8LFHxtmqIK7/Us2o93sUKKGTtJwJDgRI0o5N2cZpC8qyChrrYri6T/AeDQvi9ZJlZ1BGGW4QTms8rtETuKVat3GSFO6Wcmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mvAJ+Dus; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mvAJ+Dus"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-36babe2c4bdso3145988a91.1
        for <bpf@vger.kernel.org>; Tue, 16 Jun 2026 15:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781649279; x=1782254079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kkSM7CRG0CC6kcvO2OHpZm+lASBIVuUwk6oCMY9xGJg=;
        b=mvAJ+DuslN49jxCqwS88LNzPldk8svqcyOSrwFQiGzkJ6sv1E3BjkVCATHaE6eNKvS
         sLkticXOUO8xW9W8vzTLwfxUjU9kjQgzPOFyF7f+qJa8MJctFYZ/8GCWyRgdehngDjdt
         kTcBihlF/kr1HDMsEqCnKKDhTVl7aU6J1v4XARWOVsPNvv/hT/AJ8XPzTCC/UxHK9dSa
         JE92gyxUqXqg4xX8+hs0nKRsz4WR/5F6NCF/7JGDdNif3wMkE8WqdD3cwCWBRf/uvS47
         tfQPKOZk/ed0j5f2JQiE9/FRutq7yTimdGXPB5CIcNAiujDv8Oc+fCnyWle7KS9/Edmg
         W0HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781649279; x=1782254079;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kkSM7CRG0CC6kcvO2OHpZm+lASBIVuUwk6oCMY9xGJg=;
        b=hL8MEcUHwWStwD+959vFe/j8A7UQpz1EwQx0Jx7ASPqI33IZZF06DdrRL9Rcpg9QCD
         qQ1G4ml+StiKuBxanot/fdXE35M2XGtWv/mG8JIIHfBABqufOYE+i3cTES0SpaSmfqR0
         rzLdogagaDw/gm7H+FAyVshHjYNPkNErWRo+ASVZUWetthVaCayvkTfRKZAQkFEgD1dw
         dASBq9wBGGZ62wT6GnmOzx8DKNOHKZv+uhwNqwNzPRzwS86vX5mL+uNYz401riBbvDXZ
         6ub/VaZjP8RFL/AwuQi1Uby6MDD/96Uqwsw5Fou4VUt+IOd0R5WNo1Q1BaIKoKq46KPu
         KdMw==
X-Forwarded-Encrypted: i=1; AFNElJ8z8QuIRLnG9b+XjC+8XD6qrFFOFBZKbmnK9X9z3OPZhuLoBZvz/jebVaj71z3trUET1UU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjcUWKeZtUFH7Nzdc3DVrnb+ggQv2FHQHf2HV/H8RTwzLwYU8u
	v1snv+FyR3WaISzrzZW646NsP7zqhRj09SS2eh8gMFjgSrq+2MJbOXjd
X-Gm-Gg: AfdE7cmpMv7RGSZj2Vu47rdIMufjrNtTnMmnGkci/lA9Xj1bsV3W6H6gTEFLFDt/Va8
	jkyiaom4x/V6u3PsJX+sS54Li1s9EsLan/JuY7ydpdkCkzzK0xhXCqwI4oy2UqENFJ2gxHAUphf
	VEcG2Z+Kf7OVmREu8L1P9EtnsjZa2kLu3kTlFEEyTzOd3kTkwyQJXPz9lNN99d5shp92JKC5bpR
	XYHbqP1CcY3Z9+0CoMN8Vr7v42OXxx62DeDZoPoH7o4FOzxbpVFxMJhHLv4y+nb+1uqgeLsQw99
	UeYw7UDV/mylJ7YtvxpAM9ToyqhEQJmCaXfzxu2mKHJ+JYJI5nUKa3fmW/xE9QXhaMi6BL6WfFs
	yrhzYovLAYO+VfrHWo7YWfTAsJARsskRP7JCqClCul62Zf37mwqGI7ry88aWlF998xzbbCJhBgM
	BkoHB1uByv3LKPjo1Yx5a34/l4NQJ3sK56BdS99AW0No9qEYze9RLAUnyAdaOAuC8ucyD6urA=
X-Received: by 2002:a17:90b:3b8c:b0:36b:ba9b:7efb with SMTP id 98e67ed59e1d1-37c92ea5ae0mr1239070a91.5.1781649278714;
        Tue, 16 Jun 2026 15:34:38 -0700 (PDT)
Received: from r912.tailbb6e1e.ts.net ([182.70.116.80])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37c52092ee3sm4216898a91.0.2026.06.16.15.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 15:34:38 -0700 (PDT)
From: Avinash Duduskar <avinash.duduskar@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	Leon Hwang <leon.hwang@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Eyal Birger <eyal.birger@gmail.com>,
	Rong Tao <rongtao@cestc.cn>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 0/4] bpf: bidirectional VLAN support for bpf_fib_lookup()
Date: Wed, 17 Jun 2026 04:04:22 +0530
Message-ID: <20260616223426.3568080-1-avinash.duduskar@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

v1 added a single flag, BPF_FIB_LOOKUP_VLAN, to resolve a VLAN egress to
its underlying real device plus the VLAN tag. v2 fixes a QinQ bug the bpf
ci bot found, adds the input direction Toke asked for, adds selftests,
and prepends a fix for a pre-existing l3mdev/VRF lookup bug in the helper.

Patch 1 is an independent fix: bpf_fib_lookup() never initialized the
flow's flowi_l3mdev field, so on the fib-rules path it is read before it
is written. The VRF master is then not resolved and the l3mdev rule fails
to match, so a slave ingress can fail to select its VRF table, today,
with no part of this series. The helper already initializes every other
rules-path flow field (mark, tun_key, uid); l3mdev was added to that set
later and this one was missed. CONFIG_INIT_STACK_ALL_ZERO (the default)
masks it, which is why the VRF selftests in patch 4 pass with or without
it; built with CONFIG_INIT_STACK_ALL_PATTERN a plain bpf_fib_lookup over a
VRF slave returns NOT_FWDED without the patch and resolves with it. It is
first so the VRF behaviour the later patches document and test is well
defined. If you would rather take it through bpf or net on its own, I am
happy to send it separately. It will not apply cleanly before v6.18,
where the flowi4_dscp context line reads flowi4_tos, so a stable backport
needs a trivial context fixup.

Changes v1 -> v2:

- Fix QinQ handling (found by the bpf ci bot): resolve the immediate
  parent with vlan_dev_priv(dev)->real_dev instead of
  vlan_dev_real_dev() (which walks to the bottom of a stack), and only
  swap when that parent is a real device; stacked VLANs are left
  unchanged. The egress block is guarded with CONFIG_VLAN_8021Q.

- Add BPF_FIB_LOOKUP_VLAN_INPUT for the input direction (requested by
  Toke): supply the packet tag, run the lookup on the matching VLAN
  subinterface. Exclusive with BPF_FIB_LOOKUP_TBID (shared union) and
  BPF_FIB_LOOKUP_OUTPUT (ingress-only); both return -EINVAL. Taking the
  tag as lookup input follows the approach David Ahern suggested in the
  2021 fwmark discussion:
  https://lore.kernel.org/bpf/6248c547-ad64-04d6-fcec-374893cc1ef2@gmail.com/

- Both directions are network-namespace aware: a VLAN device can be
  moved to another netns while registered on its parent, so the egress
  swap is skipped (foreign parent ifindex is meaningless) and the input
  resolution fails closed for a device in another netns.

- Add 36 selftest cases plus a cross-netns subtest in
  prog_tests/fib_lookup.c, covering both directions, the neighbour path,
  OUTPUT and DIRECT|TBID, VRF (rule and DIRECT), resolution semantics
  (802.1ad, PCP/DEI, QinQ-inner, bond master and port), the frag-needed
  mtu_result, the error returns on both families, and the netns boundary
  in both directions.

- Document both flags and the now-bidirectional h_vlan_proto/h_vlan_TCI
  fields.

Open questions (defaults chosen, noted here in case a maintainer prefers
otherwise):

1. An unmatched, down, or foreign-netns tag returns
   BPF_FIB_LKUP_RET_NOT_FWDED, matching the DIRECT path when
   fib_get_table() finds no table, rather than a new return code.

2. BPF_FIB_LOOKUP_OUTPUT | BPF_FIB_LOOKUP_VLAN_INPUT is rejected with
   -EINVAL; restricting now keeps relaxing later backward-compatible.

3. The name BPF_FIB_LOOKUP_VLAN_INPUT reads oddly next to
   BPF_FIB_LOOKUP_OUTPUT. A pair like _VLAN_EGRESS/_VLAN_INGRESS is an
   option while nothing is merged.

4. With BPF_FIB_LOOKUP_VLAN, the tc-path mtu check that runs when
   tot_len is not set follows params->ifindex, so after a swap it
   checks against the parent device rather than the VLAN device (the
   route-mtu path via tot_len is unaffected). Checking against the
   VLAN device would preserve the pre-flag semantics if that is
   preferred.

On the bot's comment-style note: the new comments keep the form that
prevails in net/core/filter.c, and checkpatch --strict is clean.

v1: https://lore.kernel.org/all/20260609172052.81613-1-avinash.duduskar@gmail.com/


Avinash Duduskar (4):
  bpf: Initialize the l3mdev field for the fib lookup flow
  bpf: Add BPF_FIB_LOOKUP_VLAN flag to bpf_fib_lookup() helper
  bpf: Add BPF_FIB_LOOKUP_VLAN_INPUT flag to bpf_fib_lookup() helper
  selftests/bpf: Add bpf_fib_lookup() VLAN flag tests

 include/uapi/linux/bpf.h                      |  63 ++-
 net/core/filter.c                             | 119 ++++-
 tools/include/uapi/linux/bpf.h                |  63 ++-
 .../selftests/bpf/prog_tests/fib_lookup.c     | 494 +++++++++++++++++-
 4 files changed, 726 insertions(+), 13 deletions(-)


base-commit: 140fa23df957b51385aa847986d44ad7f59b0563
-- 
2.54.0

