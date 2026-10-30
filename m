Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793403254;
	b=ChzI+e72oIC57mKj33rBKZEnX4Lzaj2DIxUEreVLQzBf1hYQI+ceORFy36KN6xD01Dtl
	 sGQu28TXr/RXaM6nt231/HWw+nYPQuiXQ95aLHml+1dep1FF7L+znRHtX1ZLl6f2CTONe
	 MBquPICZbiupy0vcZHhn0p2QKzQyfhQVkWxKtF/Xvw0TGJhphNSqZuutdUbnbmwnlz/hh
	 1EH7rBy1Y5c+Y7CGiqhlFoj5AKiadcNcQn8vlaiNFYJputAF8vj4OqfZ0LVlNybO9nnBc
	 kbHZ8UXgJSyju3WnvzWTTnx2SlCokVIMwlHb+s254s2LtVgIblzRUABN+ooiPQAbB/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793403254;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=nXlePuNX/aHKNhET7caWGPRxDvNjWk2+tSos2Fry/uk=;
	b=nLKv2E9w/TjZxzhmyjyQU3nutdAyPoDIFDHWRSP4dBKctBRrREnzYvlD//unYtkEi/zE
	 9mXie16MPCyWRAYlWZ1FDBWDrKCsaF2+CUiI+CQfVku48joF5BQKWAsZDKCWQXQDDxC3S
	 O+L4vc/OWFhYRKCRYgP2HB21wiSKmsA+xishypBIA+KPcjVnC3Q6vxv4osnhNfvX2Y7oB
	 +kU+VzlMSVN35aADNIH/7SU/LlvmW7wo2Q4urUDvGTdNUH18rZOtfg5nEkgXALczKSv0O
	 j30FtQ43MbVUb84FR6DWczbd+3pnn32GmcnDb44IpZPP7xlld1+UAhRXyHiIFoPWe2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ancqPh3I;
	arc=none smtp.remote-ip=95.215.58.225
Received: from mta1.migadu.com (out-225.mta1.migadu.com [95.215.58.225])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2690C606A31A
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 23:34:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2690C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ancqPh3I
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=JgQB6eQyJeOLF0EbOq6HesW51HXnBkikKOZnGecsjCE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793403247; v=1; x=1794008047;
 b=ancqPh3IwR3rm/Xkv6Xu1KM4qPM64X3u2A4QT6z9gtRHM8ykxWjOXQ4og0iBBCD1jZcihLdu
 tAxm1gwnkxPpZXNT8lciJzj39TSKtiyWG6WNEwqsSOnzV8J23SKdpdrMkTFrQYX8sMPEo6mavw7
 OipvuaVodtof6asR2sM8P0Tk=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 44c884ca5602a9f9;
	Fri, 30 Oct 2026 23:34:07 +0000
X-Mizu-Trace-ID: 44c884ca5602a9f9
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
	David Faust <david.faust@oss.qualcomm.com>,
	Ian Rogers <irogers@google.com>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	Vineet Gupta <vineet.gupta@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH bpf-next v3 00/13] bpftool: Per-record CO-RE attributes in the C dump
Date: Fri, 30 Oct 2026 16:33:42 -0700
Message-ID: <20261030233355.1836749-1-ihor.solodrai@linux.dev>
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

Patch "libbpf: Dump kflagged BTF tags as is" makes btf_dump print
kflagged tag strings as is, instead of wrapping them in
__attribute__((...)). Record definitions then carry plain macro names,
which the generated header defines. resolve_btfids, the only in-tree
producer of kflagged tags, now encodes the complete arena specifier
__attribute__((address_space(1))), and bpftool handles the legacy
encoding correctly for backwards compatibility with older kernels.
Old bpftool emits invalid C from the new kernel BTF; this is accepted.

[1] https://lore.kernel.org/bpf/20240503111836.25275-1-jose.marchesi@oracle.com/
[2] https://lore.kernel.org/bpf/20231208000531.19179-1-eddyz87@gmail.com/

---

v2->v3:
  * Print kflagged decl and type tags as is in btf_dump, and encode
    the complete arena specifier in resolve_btfids (Andrii)
  * Define __bpf_relocatable and __bpf_static_offset as complete
    attribute specifiers, so record definitions carry only the macro
    names (Andrii)
  * New patch "bpftool: Normalize legacy arena type tags before C dumps"
    keeps C dumps of older kernel BTF valid
  * Rename the no_pai map and helper to non_relocatable, and use a bool
    array instead of linux/bitmap.h (Andrii)
  * selftest refactoring: build bpftool_btf_dump fixtures in
    btf_to_tmpfile()
  * Commit message and documentation rewording, other nits

v2: https://lore.kernel.org/bpf/20261023222652.3927736-1-ihor.solodrai@linux.dev/

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

Ihor Solodrai (13):
  libbpf: Look up BTF strings without making BTF modifiable
  libbpf: Dump kflagged BTF tags as is
  docs, libbpf: Document complete BTF annotation strings
  bpftool: Normalize legacy arena type tags before C dumps
  selftests/bpf: Build BTF fixtures in btf_to_tmpfile()
  selftests/bpf: Cover legacy arena type tags in bpftool C dumps
  selftests/bpf: Cover unknown BTF header-extension bytes in btf dump
  bpftool: Apply __bpf_relocatable per record on BTF dump
  bpftool: Skip __bpf_relocatable on verifier-rewritten context types
  bpftool: Emit __bpf_static_offset on verifier-rewritten context types
  selftests/bpf: Cover record attributes in bpftool BTF dumps
  selftests/bpf: Cover context and socket accesses through vmlinux.h
  bpftool: Document __bpf_relocatable and __bpf_static_offset

 Documentation/bpf/btf.rst                     |  14 +-
 Documentation/bpf/kfuncs.rst                  |   3 +-
 .../bpf/bpftool/Documentation/bpftool-btf.rst |  26 +++
 tools/bpf/bpftool/btf.c                       | 188 +++++++++++++++--
 tools/bpf/resolve_btfids/main.c               |   2 +-
 tools/lib/bpf/btf.c                           |  43 ++--
 tools/lib/bpf/btf_dump.c                      |   4 +-
 .../bpf/bpftool_btf_dump_sorted.expected      |  48 ++++-
 .../bpf/bpftool_btf_dump_unsorted.expected    |  48 ++++-
 .../bpf/prog_tests/bpftool_btf_dump.c         | 194 +++++++++++++++---
 .../selftests/bpf/prog_tests/btf_dump.c       |  91 ++++----
 .../selftests/bpf/prog_tests/btf_write.c      |   4 +-
 .../selftests/bpf/prog_tests/resolve_btfids.c |   4 +-
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../bpf/progs/verifier_ctx_rewritten.c        |  59 ++++++
 15 files changed, 601 insertions(+), 129 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_ctx_rewritten.c


base-commit: eaae576c34d7e001767b6845a5950b0b8db3e68a
-- 
2.56.0

