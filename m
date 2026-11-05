Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793901693;
	b=wklsbsMFpkS3Tc57ybuTAUt2CGa3nvuBdEyLtHpGRx7GwZ9Sz68+bRF6DZoMCQMziWJx
	 tt5Pq7/IcTU8iFJNgydsVGrHMbOQwsQ2IDl5bma4xj49TFK8TwS/Go0OA7BgPI92yy+B5
	 Xr8dgd1QsbuI3itvIpOpc+3tTTKiCcIRnBeITy2sYRFK5l3muPf49nPMGhyRrEwScZlxV
	 Z7zfW8JU5SmysxwZLZ1X8EIQn42Wee8nQ4DAM1KcMdJCwPwFUgVaDjVIUn3hLXVsxE7hK
	 NlEXvEYDPtHOQYI+yvk3yC6JD7Q7+O4j1ba3WCd/5WqYJ/DDySnjrzanmEL5jEJ4i9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793901693;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Qj3J10VY5miBS5hBnjDoDxTo09SRQd61+QErZepy/2s=;
	b=Cy8VsVB4tKOc9eh9n5mviX5qRBqexkYEBkhvjtE/kDCbxli1H+JaFwA4fkjSYaO1jNkS
	 YUyXlVqCbKWbRqVCgdCbDK3KPPXK6+4CwXGmbAhqlbvC5dV0qp7PaZnDdrdj1HJf+TAfY
	 h58bjl7wmRVrYlN9+nUTSRFeE4rBMK/VufSYTKks4xm/cL+YKA0lo+kN+drWXWXrQwoX7
	 Rf97FcXU4zF4ZZAGDgNpvSj/NH7O403GukIzkZV2i841wWPDu5y51lctsCFzAWNri/+Z3
	 6UzgylPGcPSL5zse2MVPHUEw3YRzDngNU+7E5LASsCkQtv1+BU0FJRamyoALk6xl9RA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=wsyHf1XG;
	arc=none smtp.remote-ip=95.215.58.152
Received: from mta1.migadu.com (out-152.mta1.migadu.com [95.215.58.152])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA45B606A326
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 18:01:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA45B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=wsyHf1XG
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=hl9NNn/Fg51cdvxSYWBb0P9KwxEzjC/UIt9GiYlBgfU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793901690; v=1; x=1794506490;
 b=wsyHf1XGc6kMDF4/HjpNdWrREjFnPloYklP2/T3GdoJf4vr5XgdIYkx58/S78WJ2kmbLDZPm
 2YZfiKKHFHnjuUKQEt28XtnvfmzAn+Ybi/6TDjEopHm3XToNOIOSSHV1cW6OQm+XqMLHFyqct7M
 f7aApNrjCS05jSb43nTRv5gM=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id acfab565e3b6b5ab;
	Thu, 05 Nov 2026 18:01:30 +0000
X-Mizu-Trace-ID: acfab565e3b6b5ab
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
Subject: [PATCH bpf-next v4 15/17] bpftool: Document __bpf_relocatable and __bpf_static_offset
Date: Thu,  5 Nov 2026 10:58:43 -0700
Message-ID: <20261105175845.30357-16-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105175845.30357-1-ihor.solodrai@linux.dev>
References: <20261105175845.30357-1-ihor.solodrai@linux.dev>
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

The C dump annotates record definitions with the __bpf_relocatable and
__bpf_static_offset macros, which programs can pre-define.
BPF_NO_PRESERVE_ACCESS_INDEX disables only __bpf_relocatable. The
bpftool-btf page describes none of this.

Describe both macros in a new GENERATED HEADERS section, including how
to avoid the Clang crash on CO-RE field-info builtins on types
annotated with __bpf_static_offset, and add an example of the generated
header.

Suggested-by: Quentin Monnet <qmo@kernel.org>
Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 .../bpf/bpftool/Documentation/bpftool-btf.rst | 67 ++++++++++++++++++-
 1 file changed, 66 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-btf.rst b/tools/bpf/bpftool/Documentation/bpftool-btf.rst
index c6dc445cd4a1..a3778f449d73 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-btf.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-btf.rst
@@ -68,7 +68,8 @@ bpftool btf dump *BTF_SRC* [format *FORMAT*] [root_id *ROOT_ID*]
     **format** option can be used to override default (raw) output format. Raw
     (**raw**) or C-syntax (**c**) output formats are supported. With C-style
     formatting, the output is sorted by default. Use the **unsorted** option
-    to avoid sorting the output.
+    to avoid sorting the output. See **GENERATED HEADERS** for the
+    annotations in C output.
 
     **root_id** option can be used to filter a dump to a single type and all
     its dependent types. It cannot be used with any other types of filtering
@@ -98,6 +99,30 @@ OPTIONS
     BTF object is passed through other handles, this option becomes
     necessary.
 
+GENERATED HEADERS
+=================
+C output annotates struct and union definitions individually. Most records
+carry ``__bpf_relocatable``. The generated header defines it as
+``__attribute__((preserve_access_index))`` where supported, or as empty
+when **BPF_NO_PRESERVE_ACCESS_INDEX** is defined or the compiler lacks the
+attribute. GCC-BPF can apply CO-RE through these attributes.
+
+Context and socket types whose field accesses the verifier rewrites carry
+``__bpf_static_offset`` instead, and their nested anonymous records carry
+no attribute. Where supported (Clang 18 and later), ``__bpf_static_offset``
+expands to ``__attribute__((preserve_static_offset))``. It is empty
+otherwise. The attribute keeps static field offsets in load and store
+instruction immediates. **BPF_NO_PRESERVE_ACCESS_INDEX** does not affect
+``__bpf_static_offset``.
+
+Define either macro before including the header, as a complete annotation
+such as ``__attribute__((preserve_access_index))``, or as empty.
+
+Clang 18 through 23 crash when ``__builtin_preserve_field_info`` is used on
+a type marked ``__bpf_static_offset``, including through ``bpf_core_field_*``
+and the CO-RE bitfield helpers. Compile with ``-D__bpf_static_offset=`` to
+use these helpers with an affected compiler.
+
 EXAMPLES
 ========
 **# bpftool btf dump id 1226**
@@ -273,3 +298,43 @@ All the standard ways to specify map or program are supported:
   [104859] FUNC 'smbalert_work' type_id=9695 linkage=static
   [104860] FUNC 'smbus_alert' type_id=71367 linkage=static
   [104861] FUNC 'smbus_do_alert' type_id=84827 linkage=static
+
+**$ bpftool btf dump file /sys/kernel/btf/vmlinux format c > vmlinux.h**
+
+**$ cat vmlinux.h**
+
+::
+
+  #ifndef __VMLINUX_H__
+  #define __VMLINUX_H__
+
+  #ifndef __bpf_relocatable
+  #if !defined(BPF_NO_PRESERVE_ACCESS_INDEX) && __has_attribute(preserve_access_index)
+  #define __bpf_relocatable __attribute__((preserve_access_index))
+  #else
+  #define __bpf_relocatable
+  #endif
+  #endif
+
+  #ifndef __bpf_static_offset
+  #if __has_attribute(preserve_static_offset)
+  #define __bpf_static_offset __attribute__((preserve_static_offset))
+  #else
+  #define __bpf_static_offset
+  #endif
+  #endif
+  ...
+  struct list_head {
+          struct list_head *next;
+          struct list_head *prev;
+  } __bpf_relocatable;
+  ...
+  struct __sk_buff {
+          __u32 len;
+          ...
+          union {
+                  struct bpf_flow_keys *flow_keys;
+          };
+          ...
+  } __bpf_static_offset;
+  ...
-- 
2.56.0

