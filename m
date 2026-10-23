Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.161
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792794434;
	b=BznTnKhFHGr7EJDvm/a2f6IRjwalSMrTU/skyxXxAvpEvhHPESumJGKUFQVbfFKfrZbd
	 b5HP4UiVr2EaqIVAYG4LdvgSLW2WM/Q8jkUcEFq5oeYVdOPjRcCFr88Gxc/z7nuQwkBce
	 YP06X/gsbR1/2LBuLF/o0/+dDm21xMDQccpVxA68qkbpRbkGy0A/Y87PBIujqW+uC8Wr0
	 1vCqmW18ptTYxX48+PgfkiTXhJMvRJe3qF/vsD8iTdGO78IWquTTYP5H+I2AvJvUbMlaz
	 4BdUMosWm+4Mg7x/TI+4C2b/N7f7LGInzACYJk2WDaVfohHFHXMnuuKG1l6h/V7QJQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792794434;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=AbAHZKfUQpA6bzh7TYVSAsFo5fqdi23Q8Ys+/JaD3no=;
	b=p+E/4UJGd32huaOPkxL2urhznvSLomOGTMnHaELdnV39XX7an+d6wn7JHAKbp8zlbU5D
	 0Czubz3ZmioU+Ju8t8E7VmyDGfe2dC4TvPgYDe8c/ZRtuOBs4I7X5DBwsn9G/T8uRgICD
	 eQbP5GuHSFYoy3M2oBR6Z+7DJSypxg8OvFRb4qMEmogEp8enL3bdnnN3InMr/VOqYSncz
	 5vy9SwPkD5ZCraOkJBslCHbqNiVnCV9eXlpzORRHBiYxUEssHlOFYsM10wtt37EZcuzqD
	 z8k5OzI07ZgYKJXeDRZVeNClex41jQfOMgfqlCYM+3EyeTd22IxYxBGmh5dMBTu2gEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=fE4zep0Z;
	arc=none smtp.remote-ip=91.218.175.161
Received: from mta0.migadu.com (out-161.mta0.migadu.com [91.218.175.161])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7701B606A31A
	for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 22:27:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7701B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=fE4zep0Z
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=FEM8Z8CckJbut2J68T4Rn/KL/5uyCqRbiGw8dArNCXM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792794431; v=1; x=1793399231;
 b=fE4zep0ZRMDKlElaM83no6tz97rLp0Nqp2gVw11hUnKKymW+0xv9gny/FXmtcMqP/3LlUMKF
 GBT2aPoiiqH4e3MPaGPpTVx/wx7+a6PbfESdKFt0Rl0jK255nXTsbhBPWliu1DbB36ACOM6Gfj+
 tfBtWfW876GTZ9M548SMoieA=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 4cfcf17e944d03dc;
	Fri, 23 Oct 2026 22:27:11 +0000
X-Mizu-Trace-ID: 4cfcf17e944d03dc
X-Migadu-Flow: FLOW_OUT
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Quentin Monnet <qmo@kernel.org>
Cc: bpf@vger.kernel.org,
	Alan Maguire <alan.maguire@oracle.com>,
	Cupertino Miranda <cupertino.miranda@oracle.com>,
	David Faust <david.faust@oracle.com>,
	Ian Rogers <irogers@google.com>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	Vineet Gupta <vineet.gupta@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH bpf-next v2 0/8] bpftool: Per-record CO-RE attributes in the C dump
Date: Fri, 23 Oct 2026 15:26:44 -0700
Message-ID: <20261023222652.3927736-1-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpftool's C dump wraps its output in a clang attribute pragma:

  #pragma clang attribute push (__attribute__((preserve_access_index)), apply_to = record)

GCC-BPF implements preserve_access_index, but not the pragma. Since
the commit 675b4e24bc50 ("bpf: Temporarily define
BPF_NO_PRESEVE_ACCESS_INDEX for GCC") the BPF selftests build GCC
objects with -DBPF_NO_PRESERVE_ACCESS_INDEX, which drops CO-RE from
vmlinux.h altogether.

This series replaces the pragma with an explicit attribute on each
record definition, and uses the same mechanism to annotate the context
types that the verifier rewrites with preserve_static_offset.

Jose proposed per-record attributes in May 2024 [1]. It stalled on a
requirement from preserve_static_offset (PSO) work [2] to add
attributes on selected types only, which a fixed string cannot
express.

BTF decl tags can carry an arbitrary attribute list since commit
51d1b1d42841 ("libbpf: Introduce kflag for type_tags and decl_tags in
BTF"), and btf_dump renders them on record definitions, since
76ea31239021 ("libbpf: Render decl_tags in btf_dump"). This allows
bpftool to put any attribute on any subset of records, with no new
libbpf API.

[1] https://lore.kernel.org/bpf/20240503111836.25275-1-jose.marchesi@oracle.com/
[2] https://lore.kernel.org/bpf/20231208000531.19179-1-eddyz87@gmail.com/

---

v1->v2:
  * Rename __bpf_core_pai to __bpf_relocatable
  * Rename __bpf_core_pso to __bpf_static_offset
  * Use a split BTF to add decl_tags in bpftoo instead of a detached
    copy (Alexei, Alan)
    * New patch "libbpf: Look up BTF strings without making BTF
      modifiable" lets btf__find_str() build its string index without
      making BTF modifiable
    * Dropped patch "bpftool: Dump C from a detached BTF copy"
  * The Clang crash on __builtin_preserve_field_info over PSO types is
    fixed in LLVM. PSO stays on by default; -D__bpf_static_offset=
    remains the documented workaround for Clang 18 through 23
  * GCC-BPF gets __bpf_relocatable from patch #3, so its narrow loads
    from context types fail verification until patch #4 (bpf-ci bot),
    left as is
  * Commit message and documentation rewording
v1: https://lore.kernel.org/bpf/20261016000012.2232059-1-ihor.solodrai@linux.dev/

---

Ihor Solodrai (8):
  libbpf: Look up BTF strings without making BTF modifiable
  selftests/bpf: Cover unknown BTF header-extension bytes in btf dump
  bpftool: Apply __bpf_relocatable per record on BTF dump
  bpftool: Skip __bpf_relocatable on verifier-rewritten context types
  bpftool: Emit __bpf_static_offset on verifier-rewritten context types
  selftests/bpf: Cover record attributes in bpftool BTF dumps
  selftests/bpf: Cover context and socket accesses through vmlinux.h
  bpftool: Document __bpf_relocatable and __bpf_static_offset

 .../bpf/bpftool/Documentation/bpftool-btf.rst |  24 +++
 tools/bpf/bpftool/btf.c                       | 154 ++++++++++++++++--
 tools/lib/bpf/btf.c                           |  36 ++--
 .../bpf/bpftool_btf_dump_sorted.expected      |  48 +++++-
 .../bpf/bpftool_btf_dump_unsorted.expected    |  48 +++++-
 .../bpf/prog_tests/bpftool_btf_dump.c         | 102 +++++++++++-
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../bpf/progs/verifier_ctx_rewritten.c        |  59 +++++++
 8 files changed, 423 insertions(+), 50 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_ctx_rewritten.c


base-commit: b116ac6087541d3d98031e786adbe9c733cd6df3
-- 
2.56.0

