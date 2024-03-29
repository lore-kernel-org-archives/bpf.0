Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648341C0DC0
	for <bpf@vger.kernel.org>; Fri, 29 Mar 2024 18:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711738063; cv=none; b=s1Zpw4mr0kCemD3JWKHgfnNdaH15bx+Q03iGB+eaG0mYblXatTVd2Kiv0tmC8b3sxZtjdlsA8FSmSqIO6E7q3dgUuyxUBJKExM7hhZeUowwsSDjpk2PKTsam/d/HlP5mRcTiE/rVmCcfI+in+Bo25WaYcVKa3uGUMXtJ3GlVUTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711738063; c=relaxed/simple;
	bh=5Ty67EH0kEAuO0qo/J3iqT5AnAa/5Cl18ue4GH0npgg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bBmimRF91Pp7UVSTAsbGRGOAei5zT1ZkOsRY4Xe8QIXWubMkCE+uV0NeEUOkkI/5UWvSTI2xmc9UqHCFvRovC9U4cX5lv1Mqx00pAwXB5qOH9h4qIz7PI2upwjjaDZ3kc9tNNFaovKEUAMH2Q0fbyvFtC2VV6G+lYn38r5MuDag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fsIu2JAW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fsIu2JAW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4450C433C7;
	Fri, 29 Mar 2024 18:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711738062;
	bh=5Ty67EH0kEAuO0qo/J3iqT5AnAa/5Cl18ue4GH0npgg=;
	h=From:To:Cc:Subject:Date:From;
	b=fsIu2JAW4fdqq6SWlrvYKVlCfM0MdHFBdvpKvHq7LyERJpiuo7tAECFOj2gs8oHlf
	 pu/knlrGdLSyp+1KJbuKnA8epY6WABdnwYwH3B6+GVd4AsT3L7AjRL7C0n7cRfIRik
	 AgoEDd6jr8i6cB67CapgdVoaX+ZjbSGRtigBV/436EcIo0T/8TZ62vuxPivuBw25fJ
	 CJrO8QZXcrcFRR0INdrmcuMAiBTo/ybqS8p+7CQ+k+09L3LDFCmWyph/0cR0QBj6h3
	 6Nm0Y0j0hcpqazj8twMpU+AeqRe6CGTIxB0FuHTqsLvrCNuDqoIDPHN2///JjkRgqJ
	 NrZPh6y8Y8ZbA==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next 0/4] Add internal-only BPF per-CPU instructions
Date: Fri, 29 Mar 2024 11:47:36 -0700
Message-ID: <20240329184740.4084786-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add two new BPF instructions for dealing with per-CPU memory.

One, BPF_LDX | BPF_ADDR_PERCPU | BPF_DW (where BPF_ADD_PERCPU is unused
0xe0 opcode), resolved provided per-CPU address (offset) to an absolute
address where per-CPU data resides for "this" CPU. This is the most universal,
and, strictly speaking, the only per-CPU BPF instruction necessary.

I also added BPF_LDX | BPF_MEM_PERCPU | BPF_{B,H,W,DW} (BPF_MEM_PERCPU using
another unused 0xc0 opcode), which can be considered an optimization
instruction, which allows to *read* per-CPU data up to 8 bytes in one
instruction, without having to first resolve the address and then
dereferencing the memory. This one is used in inlining of
bpf_get_smp_processor_id(), but it would be fine to implement the latter with
BPF_ADD_PERCPU, followed by normal BPF_LDX | BPF_MEM, so I'm fine dropping
this one, if requested.

This instructions are currently supported by x86-64 BPF JIT, but it would be
great if this was added for other arches ASAP, of course.

In either case, we also implement inlining for three cases:
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

Andrii Nakryiko (4):
  bpf: add internal-only per-CPU LDX instructions
  bpf: inline bpf_get_smp_processor_id() helper
  bpf: inline bpf_map_lookup_elem() for PERCPU_ARRAY maps
  bpf: inline bpf_map_lookup_elem() helper for PERCPU_HASH map

 arch/x86/net/bpf_jit_comp.c | 29 +++++++++++++++++++++++++++++
 include/linux/filter.h      | 27 +++++++++++++++++++++++++++
 kernel/bpf/arraymap.c       | 33 +++++++++++++++++++++++++++++++++
 kernel/bpf/core.c           |  5 +++++
 kernel/bpf/disasm.c         | 33 ++++++++++++++++++++++++++-------
 kernel/bpf/hashtab.c        | 21 +++++++++++++++++++++
 kernel/bpf/verifier.c       | 17 +++++++++++++++++
 7 files changed, 158 insertions(+), 7 deletions(-)

-- 
2.43.0

