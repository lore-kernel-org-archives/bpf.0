Received: from mta1.migadu.com (out-233.mta1.migadu.com [95.215.58.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30F31448E0
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 00:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792108870; cv=none; b=LD1ztPZZDzShoIqSPujieo/GH0QxB9B+blDh5s0cHF62ZZjDJc8KZyv+D92SWMisgNs8+k7CF/gCVoqzFUBdMj2Bkd+EReFtMBvWweYRyDyGqSL1VWuMGKMwM23d1z/cFCdlQIZZiSs3IdbKO4h1F7e+8c7A6j1O500DY7nucBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792108870; c=relaxed/simple;
	bh=6dv9XXc7TLlrWb0OkVCBN1GBzLvVy/6ZHKgi6b/EHAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WvR44IXdoguFeDoU/OD5rHLcDH3Xkq6KbtPBx5S2DEV/LvqaovfNqvd0r1SWZwq9TAaPaI6eQuC5Lk+l2mA7cip0w0K7AAwFst+QWXIOPOvgFFvhmagfrgSSae5men/yIN4Wvd8W4FYN3jozlx2Fm2dGn4KyVRfF9O/TrvXOSrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VMgwSSCj; arc=none smtp.client-ip=95.215.58.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VMgwSSCj"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=6dv9XXc7TLlrWb0OkVCBN1GBzLvVy/6ZHKgi6b/EHAY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792108867; v=1; x=1792713667;
 b=VMgwSSCj0U5ghqzL3kBvTUQgpcFTVlv9GNtjZUHOqjR71BmLrwDZjvi45VFdZla7JkRPPF3/
 InM9XeK6uUZZ8RfPh6maM192bR4wcRrqd6XSiISfkyxiUFrT6Rqswu/DVc3Mg96+1NuLr3jHr8H
 4LA3JTc1RSf8Bk93zUxLLRxQ=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 4724d4e722d058c0;
	Fri, 16 Oct 2026 00:01:06 +0000
X-Mizu-Trace-ID: 4724d4e722d058c0
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
Subject: [PATCH bpf-next v1 8/8] bpftool: Document __bpf_core_pai and __bpf_core_pso
Date: Thu, 15 Oct 2026 17:00:12 -0700
Message-ID: <20261016000012.2232059-9-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261016000012.2232059-1-ihor.solodrai@linux.dev>
References: <20261016000012.2232059-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The C dump annotates records with the __bpf_core_pai and
__bpf_core_pso macros. Programs control the attributes through these
macros and BPF_NO_PRESERVE_ACCESS_INDEX, which disables only
__bpf_core_pai.

Update bpftool documentation to explain __bpf_core_pai and
__bpf_core_pso macros.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 .../bpf/bpftool/Documentation/bpftool-btf.rst  | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-btf.rst b/tools/bpf/bpftool/Documentation/bpftool-btf.rst
index c6dc445cd4a1..0bd50c4fa68a 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-btf.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-btf.rst
@@ -70,6 +70,24 @@ bpftool btf dump *BTF_SRC* [format *FORMAT*] [root_id *ROOT_ID*]
     formatting, the output is sorted by default. Use the **unsorted** option
     to avoid sorting the output.
 
+    C output annotates struct and union definitions individually, with or
+    without **unsorted**. Most records carry
+    ``__attribute__((__bpf_core_pai))``. The generated header defines
+    ``__bpf_core_pai`` as ``preserve_access_index`` where supported, or as
+    empty when **BPF_NO_PRESERVE_ACCESS_INDEX** is defined or the compiler
+    lacks the attribute. GCC-BPF can apply CO-RE through these attributes.
+
+    Context and socket types whose field accesses the verifier rewrites
+    carry ``__attribute__((__bpf_core_pso))`` instead, and their nested
+    anonymous records carry no attribute. ``__bpf_core_pso`` expands to
+    ``preserve_static_offset`` where supported (Clang 18 and later), or to
+    empty otherwise. The attribute keeps static field offsets in load and
+    store instruction immediates. **BPF_NO_PRESERVE_ACCESS_INDEX** does
+    not affect ``__bpf_core_pso``.
+
+    Either macro may be pre-defined as a bare attribute name, such as
+    ``preserve_access_index``, or as empty to override the policy.
+
     **root_id** option can be used to filter a dump to a single type and all
     its dependent types. It cannot be used with any other types of filtering
     (such as the "key", "value", or "kv" arguments when dumping BTF for a map).
-- 
2.56.0

