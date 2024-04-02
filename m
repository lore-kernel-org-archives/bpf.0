Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDFEBA2D
	for <bpf@vger.kernel.org>; Tue,  2 Apr 2024 02:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712023989; cv=none; b=IXymI05gPGhqMqZeuj0FkGiCMpZRm8B10cjJm/K4EFWjouExcZcGktURDW/zlZLv7rTOaalDLV6+PHN3qxArM9jeR1T5JN1PTYbjSgqAvAYekC4lmD25P3vVVZpi73V+kUwPBFt0ydXWEbPVNBORKtJKStqeMJzwWvgdhQjlAF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712023989; c=relaxed/simple;
	bh=Rq1jzFJmBYxju6C1xS2cLRaWfhn5+f6rpDPxvBG1Avo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WX1dloImzMptBrDtsV40z6N1dPmQmellmG8Xcy1sHM2Nm0qurLOuvuE1Yt78mkB0k4V0iZX6wlHjDReh9/L+MffFjAP1SxctL4WC7ngW7OeyrSIaBv5kS5ZQerHTpf48Opcip4015F5dYy4r2tCONua+eEGZyM6jpIy1MJTc1tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ot7sA6Qk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ot7sA6Qk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFE61C433F1;
	Tue,  2 Apr 2024 02:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712023988;
	bh=Rq1jzFJmBYxju6C1xS2cLRaWfhn5+f6rpDPxvBG1Avo=;
	h=From:To:Cc:Subject:Date:From;
	b=Ot7sA6Qkxh6vVcfaubM9TiLLYpyo+N1KT1UDKS4KJ5cu48Wu1lKo5N0ktHfW1IMWO
	 8aYfyPNOYu1PNRnhFuI7kdDaNC/+9i+n2WIaJ4AO/YYNu0o383drIBaftS5VQRO3CT
	 Jf/GNWm/NCL6eX8XMFXqQ9+38siE0sUAcOb81kgMrDSl5O3zWlIx0hiabOAGqt24Qg
	 hhKWTX3UZ3MMw5bpj6lFFVg3VBkCABJZYtV1SHDrVWn5Y4THFgBw+HVyRkigtc8MeT
	 e7edTnCarqbgoyICpt1a+n9fYqOLAc7BKSvpQZRYwxPluaN7fhQ9BsQsnETShtgdmX
	 zsgkOUuNT6CYw==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 bpf-next 0/4] Add internal-only BPF per-CPU instruction
Date: Mon,  1 Apr 2024 19:13:01 -0700
Message-ID: <20240402021307.1012571-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a new BPF instruction for resolving per-CPU memory addresses.

New instruction is a special form of BPF_ALU64 | BPF_MOV | BPF_DW, with
insns->off set to BPF_ADDR_PERCPU (== -1). It resolves provided per-CPU offset
to an absolute address where per-CPU data resides for "this" CPU.

This patch set implements support for it in x86-64 BPF JIT only.

Using the new instruction, we also implement inlining for three cases:
  - bpf_get_smp_processor_id(), which allows to avoid unnecessary trivial
    function call, saving a bit of performance and also not polluting LBR
    records with unnecessary function call/return records;
  - PERCPU_ARRAY's bpf_map_lookup_elem() is completely inlined, bringing its
    performance to implementing per-CPU data structures using global variables
    in BPF (which is an awesome improvement, see benchmarks below);
  - PERCPU_HASH's bpf_map_lookup_elem() is partially inlined, just like the
    same for non-PERCPU HASH map; this still saves a bit of overhead.

To validate performance benefits, I hacked together a tiny benchmark doing
only bpf_map_lookup_elem() and incrementing the value by 1 for PERCPU_ARRAY
(arr-inc benchmark below) and PERCPU_HASH (hash-inc benchmark below) maps. To
establish a baseline, I also implemented logic similar to PERCPU_ARRAY based
on global variable array using bpf_get_smp_processor_id() to index array for
current CPU (glob-arr-inc benchmark below).

BEFORE
======
glob-arr-inc   :  163.685 ± 0.092M/s
arr-inc        :  138.096 ± 0.160M/s
hash-inc       :   66.855 ± 0.123M/s

AFTER
=====
glob-arr-inc   :  173.921 ± 0.039M/s (+6%)
arr-inc        :  170.729 ± 0.210M/s (+23.7%)
hash-inc       :   68.673 ± 0.070M/s (+2.7%)

As can be seen, PERCPU_HASH gets a modest +2.7% improvement, while global
array-based gets a nice +6% due to inlining of bpf_get_smp_processor_id().

But what's really important is that arr-inc benchmark basically catches up
with glob-arr-inc, resulting in +23.7% improvement. This means that in
practice it won't be necessary to avoid PERCPU_ARRAY anymore if performance is
critical (e.g., high-frequent stats collection, which is often a practical use
for PERCPU_ARRAY today).

v1->v2:
  - use BPF_ALU64 | BPF_MOV instruction instead of LDX (Alexei);
  - dropped the direct per-CPU memory read instruction, it can always be added
    back, if necessary;
  - guarded bpf_get_smp_processor_id() behind x86-64 check (Alexei);
  - switched all per-cpu addr casts to (unsigned long) to avoid sparse
    warnings.

Andrii Nakryiko (4):
  bpf: add special internal-only MOV instruction to resolve per-CPU
    addrs
  bpf: inline bpf_get_smp_processor_id() helper
  bpf: inline bpf_map_lookup_elem() for PERCPU_ARRAY maps
  bpf: inline bpf_map_lookup_elem() helper for PERCPU_HASH map

 arch/x86/net/bpf_jit_comp.c | 16 ++++++++++++++++
 include/linux/filter.h      | 20 ++++++++++++++++++++
 kernel/bpf/arraymap.c       | 33 +++++++++++++++++++++++++++++++++
 kernel/bpf/core.c           |  5 +++++
 kernel/bpf/disasm.c         | 14 ++++++++++++++
 kernel/bpf/hashtab.c        | 21 +++++++++++++++++++++
 kernel/bpf/verifier.c       | 24 ++++++++++++++++++++++++
 7 files changed, 133 insertions(+)

-- 
2.43.0

