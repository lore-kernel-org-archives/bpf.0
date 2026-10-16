Received: from mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A48312819
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 00:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792108826; cv=none; b=pkr6lqXhddJOxA+uimTVqk4nJi3BJ46YLX428930/J9QbqiNcTf5nbfcxVTXLoUsrhSL7/xQmJe0V0MSwbttFG2oAMJfB0JBKLYgwR7S4aGBi9D3ZLspCbQHoKuZzFZD4XZojNF50qb8LwxVK+m+Rd5iE/tP2Ay1ab47S0yZeCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792108826; c=relaxed/simple;
	bh=7wcttBeDGig9X3gBVuBMe8N1VELonHIduUeXWIGxtN4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l5lgyqjfSWD4x+OZHPAODdwSuBc72Ywq6u1OHL0/IW/mAFcGHB8o4qVmQYvB6vjXFW6iDjNzYqqSH2aKAwECj5X95cuIMxzfN/sCecrbrt3SOlczvEmkgicyHzrkoH/A6NY19magGlZ2QdB+e0NOz6NSQXzG7vAWxn8ncIHHGiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mFUzSzUo; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mFUzSzUo"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=7wcttBeDGig9X3gBVuBMe8N1VELonHIduUeXWIGxtN4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792108822; v=1; x=1792713622;
 b=mFUzSzUoTQ348nWTaf7KsuamY5b1sjklMgkxGRqLqUa67Uxbx4xDia99pEQpPmqUQ4F2EVuQ
 wrRnBSBdnNip9PYm178wO93osRcLBBAXqg/6mI9VEMYAcRMoi0w2z6UuE/1QyA9xOOYkPUFswf0
 BY9xEE7Rgz3xzNzyQ2d4H/X4=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 26ebba8e0cd31d2b;
	Fri, 16 Oct 2026 00:00:20 +0000
X-Mizu-Trace-ID: 26ebba8e0cd31d2b
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
Subject: [PATCH bpf-next v1 0/8] bpftool: Per-record CO-RE attributes in the C dump
Date: Thu, 15 Oct 2026 17:00:04 -0700
Message-ID: <20261016000012.2232059-1-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
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
bpftool put any attribute on any subset of records, with no new libbpf
API changes.

[1] https://lore.kernel.org/bpf/20240503111836.25275-1-jose.marchesi@oracle.com/
[2] https://lore.kernel.org/bpf/20231208000531.19179-1-eddyz87@gmail.com/

---

Ihor Solodrai (8):
  bpftool: Dump C from a detached BTF copy
  selftests/bpf: Cover unknown BTF header-extension bytes in btf dump
  bpftool: Apply __bpf_core_pai per record on BTF dump
  bpftool: Skip __bpf_core_pai on verifier-rewritten context types
  bpftool: Emit __bpf_core_pso on verifier-rewritten context types
  selftests/bpf: Cover record attributes in bpftool BTF dumps
  selftests/bpf: Cover context and socket accesses through vmlinux.h
  bpftool: Document __bpf_core_pai and __bpf_core_pso

 .../bpf/bpftool/Documentation/bpftool-btf.rst |  18 ++
 tools/bpf/bpftool/btf.c                       | 174 ++++++++++++++++--
 .../bpf/bpftool_btf_dump_sorted.expected      |  48 ++++-
 .../bpf/bpftool_btf_dump_unsorted.expected    |  48 ++++-
 .../bpf/prog_tests/bpftool_btf_dump.c         | 102 +++++++++-
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../bpf/progs/verifier_ctx_rewritten.c        |  59 ++++++
 7 files changed, 417 insertions(+), 34 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_ctx_rewritten.c


base-commit: 7f34009230b796a06198da2c7204fd4efab9a2a1
-- 
2.56.0

