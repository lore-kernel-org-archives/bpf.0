Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794943325;
	b=twy5dRHie6NMY6Kg04YKBy4KnjLGeXWa/kLj7mtd9T4vNItcMCFAcsI7AeCMP/Ih0RDV
	 sIG6yuQ/WIMklcyl84esBvmOhjROSvLxIeWZ5GpjFXEsYxgHgsIgnPFiY9tFnVLEbMtqW
	 VOKVi9oQXyXyno8rFn1Hcn/FafzZoWyHPhynkhBFUuit5NCzCnek9G5rktvi1lkXBKBnT
	 vbkqxy1fpq/NYGYRmjNCtL6YmkJWIPYy2ePQ7b0GU0nIGiexqdd5IWYqL4N9L+EFS4lCX
	 9NGOpCNTZ04lpTbLQ08VEugzuxuS4MTRLeiHsMG3UTw3ZKveXrRrSChLaJGQVWVWRig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794943325;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=9J7aBELj60r07PeTpxglJaszz6bHKixvkUGAvEmKE1w=;
	b=UDfwtldIu/WJIthae4XYxTkLsgA4+q/hRkg04mb1oXMSvey7ZyQ2g1Ldq0qzfJCM4nZJ
	 PYtcauQcu32pDgQjUx6y1icahtTiLiUBbWF9twGaBsCaW0/SpUGnneg3pK6RdBXpXCbOm
	 esrUpGFLCA6L/zDJPAweGTuYybHR2pg4U3+6+I1R6Nn6AMbuv+Ja1EkDMTKg46DNIvVqF
	 9nJ/xRoPlk4rhDvyB+3sDvRwveT9+lLFT0W0ZOdf9y686m64impOEHJ13KZFl74bB23Mf
	 A7Gk/bJ1s3EfqmaR6bEQ2cVr4SGiuQnZGheBWtLrbFGjYMPh8AEO2oMTtY18W4K8p6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=sDfwqaoU;
	arc=none smtp.remote-ip=91.218.175.195
Received: from mta0.migadu.com (out-195.mta0.migadu.com [91.218.175.195])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA300606A32F
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 19:22:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA300606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=sDfwqaoU
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=pq/onNLVdm06BkPABGrLiWH2w6igbMq4jJsu4mQ3hxE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794943321; v=1; x=1795548121;
 b=sDfwqaoUTtb9rTR8UTP7dLI25qhzqdS70UMe/TY70Sq3EJRKkJ9zxYba3G8dqKlaQEwcf/n8
 dWK2tZ4/aa0sBxXLEq49rtA0C8zL7soaeWEsicnYYxfwKUBpLUjSZ4gBiyX0YwGrQJPgffBc1Eh
 mXA+tSBWxJe6fuE7O57IsHLw=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id a62ad20f2c5ecfb0;
	Tue, 17 Nov 2026 19:22:01 +0000
X-Mizu-Trace-ID: a62ad20f2c5ecfb0
X-Migadu-Flow: FLOW_OUT
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Song Liu <song@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Subject: [PATCH bpf-next v1 0/4] libbpf: Support kernel-side kfunc flavors
Date: Tue, 17 Nov 2026 12:21:49 -0700
Message-ID: <20261117192153.3384031-1-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.56.1
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

An incompatible change to a kfunc's prototype, such as an added
parameter, breaks BPF programs built against the old one. libbpf
ignores the ___<flavor> suffix of a kfunc declared in a BPF program,
but makes an exact name look up on the kernel side, so the kernel
can't keep the old prototype available under the kfunc's name.

sched_ext ran into this. cded46d97159 ("sched_ext: Make
scx_bpf_dsq_insert*() return bool") kept the old prototype as
scx_bpf_dsq_insert___compat, expecting libbpf to bind old binaries to
it, and broke them. 2dbbdeda77a6 ("sched_ext: Fix scx_bpf_dsq_insert()
backward binary compatibility") reversed the naming. A ___v2 kfunc
declared as vmlinux.h spells it doesn't bind: 56bbc91219c0
("sched_ext: Fix scx_bpf_dsq_move_to_local___v2 compat detection")
fixed a compat macro that silently dropped enq_flags because of this.

With this series, if the kernel's bpf_foo kfunc is missing or its
prototype is incompatible with the declaration, libbpf binds the
bpf_foo___<flavor> that has a compatible prototype. So a changed kfunc
can keep its name, and the old prototype stays available as foo___v1.

resolve_btfids fails the build if two of bpf_foo and its flavors have
compatible prototypes, unless both have foo's exact prototype
(aliases), so the fallback finds at most one match.  This ensures at
kernel / module build time that no ambigous kfunc flavors exist.
Documentation/bpf/kfuncs.rst describes the rules.

Compatibility is determined by bpf_core_types_are_compat(), the check
libbpf already applies to kfuncs. Of the 70 same-name kfunc prototype
changes between v6.6 and bpf-next, it finds 8 incompatible (arity,
return kind, callback prototype). The other 62 (const, typedefs,
parameter names, integer widths, pointee struct names, annotation
suffixes) were made in place without breaking old callers.

The flavors feature is backwards compatible: declarations that resolve
today bind the same kernel function. The exact name lookup is
attempted first. Declarations rejected today for an incompatible
prototype, or left unresolved if __weak, may now bind to a flavor, for
example scx_bpf_dsq_insert___v2 as vmlinux.h declares it. Older libbpf
and light skeletons don't get the fallback.

---

Ihor Solodrai (4):
  libbpf: Fall back to kernel ___ flavors when resolving kfuncs
  selftests/bpf: Test kfunc flavor resolution
  resolve_btfids: Reject kfunc families that libbpf can't disambiguate
  docs/bpf: Describe how to change a kfunc's prototype

 Documentation/bpf/kfuncs.rst                  |  83 +++++++++++
 tools/bpf/resolve_btfids/btf_colors.c         |  11 ++
 tools/bpf/resolve_btfids/btf_colors.h         |   3 +
 tools/bpf/resolve_btfids/main.c               | 134 +++++++++++++++++
 tools/lib/bpf/btf.c                           |  26 ++++
 tools/lib/bpf/libbpf.c                        | 140 +++++++++++++++++-
 tools/lib/bpf/libbpf_internal.h               |   1 +
 .../selftests/bpf/prog_tests/verifier.c       |   3 +
 .../selftests/bpf/progs/kfunc_flavors.c       |  55 +++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  24 +++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |   4 +
 11 files changed, 482 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/kfunc_flavors.c


base-commit: 32b66b94c86f009b49668de7340f2ed65aad2dc5
-- 
2.56.1

