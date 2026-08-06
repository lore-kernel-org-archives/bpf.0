Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3619B49480B
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 20:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786047055; cv=none; b=HgI8XBpSzjl6VcfjIlBZm6HIXZK1tXCzOwysFZWpCORaSXGSmnZXmZXDV1AVjdxBp6lzR3XugBNj2mY2ls1mp3uDGT3mUFwxdCCfx29yQGAhFb2vDuLzcb5a0dG0lCy0nNna7C4kr4HAl9TsbX4J6TTqaOocTHQX6Crdq2AUJxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786047055; c=relaxed/simple;
	bh=xMYMCsOzkScWOPX9Q+ZaRLlk7kPBK39DR/fO/I4SWQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iyosMbQGHzb6QpWAb4Vu3glhcQzQOuvxyjjSfogmMj0pwwRAzMk5AKa5d7czeoDXwvt1iR+d7v0iSK75/QZWPFf2nQwKMDSznCBSbd8ltjegSZ0sO4yltd1og9jreKtwzsCGV3ZuirbuCdbPJdsu1Z0C76Pv8NtHHuXKo/1GRNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=njGttoZc; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="njGttoZc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=cws97ArbMD5eomdnyOIWkONXr3UWpV3ckp/ubJScFts=; b=njGttoZcrJ6r3gQu11950TjN6y
	Wj4J6an+BGTke2YGw63gu5RkO4SysD1XbcWX13ZoNTdRUKHlPApYtfrOY5P+HpdNqlSXka/CkbWSI
	c03WrWGtyG0dwgVgnM9uOK/yYDK0W65MzVOMKpqVVInFW2YRNKJxneIkeM4sFk50F79pSN0fiCqSP
	f48xi9hlQnO8s2TRk+oSCs3dH1eRiC3JfrpuUJySbA9bi1uAGIRfUBIEAzjLInUlpM5Sw5zsRqc7H
	3uEUTgsk+6Jq3ms7lTP1CiDI0Q4FAXUtAjL/uXR4SWQ81kDbpS5rQsejXa7kL2dtXretaZ0tANjqm
	zBxT22wA==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1ws4QV-000DHZ-14;
	Thu, 06 Aug 2026 22:10:51 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: memxor@gmail.com
Cc: eddyz87@gmail.com,
	puranjay@kernel.org,
	info@starlabs.sg,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v2 6/6] selftests/bpf: Add load-acquire test for probe-memory pointer types
Date: Thu,  6 Aug 2026 22:10:47 +0200
Message-ID: <20260806201047.333389-6-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260806201047.333389-1-daniel@iogearbox.net>
References: <20260806201047.333389-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28084/Thu Aug  6 08:24:46 2026)

Add a verifier test that a BPF_LOAD_ACQ from a rdonly_untrusted_mem pointer
(PTR_TO_MEM | MEM_RDONLY | PTR_UNTRUSTED, obtained via bpf_rdonly_cast())
is rejected. Such a source requires BPF_PROBE_MEM fault protection which
is not applied to atomic loads; without the verifier fix the load is accepted
and would crash the kernel on a fault.

  # LDLIBS=-static PKG_CONFIG='pkg-config --static' ./vmtest.sh -- ./test_progs -t verifier_load_acquire
  [...]
  #621/1   verifier_load_acquire/load-acquire, 8-bit:OK
  #621/2   verifier_load_acquire/load-acquire, 8-bit @unpriv:OK
  #621/3   verifier_load_acquire/load-acquire, 16-bit:OK
  #621/4   verifier_load_acquire/load-acquire, 16-bit @unpriv:OK
  #621/5   verifier_load_acquire/load-acquire, 32-bit:OK
  #621/6   verifier_load_acquire/load-acquire, 32-bit @unpriv:OK
  #621/7   verifier_load_acquire/load-acquire, 64-bit:OK
  #621/8   verifier_load_acquire/load-acquire, 64-bit @unpriv:OK
  [...]
  #621/19  verifier_load_acquire/load-acquire from rdonly_untrusted_mem pointer:OK
  #621/20  verifier_load_acquire/load-acquire with invalid register R15:OK
  #621/21  verifier_load_acquire/load-acquire with invalid register R15 @unpriv:OK
  #621/22  verifier_load_acquire/load-acquire from pkt pointer:OK
  #621/23  verifier_load_acquire/load-acquire from flow_keys pointer:OK
  #621/24  verifier_load_acquire/load-acquire from sock pointer:OK
  #621     verifier_load_acquire:OK
  Summary: 1/24 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 .../bpf/progs/verifier_load_acquire.c         | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_load_acquire.c b/tools/testing/selftests/bpf/progs/verifier_load_acquire.c
index ae1dab1b0cbb..d17026d7480d 100644
--- a/tools/testing/selftests/bpf/progs/verifier_load_acquire.c
+++ b/tools/testing/selftests/bpf/progs/verifier_load_acquire.c
@@ -3,6 +3,7 @@
 
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
+#include <bpf/bpf_core_read.h>
 #include "../../../include/linux/filter.h"
 #include "bpf_misc.h"
 
@@ -221,6 +222,33 @@ __naked void load_acquire_from_sock_pointer(void)
 	: __clobber_all);
 }
 
+SEC("socket")
+__description("load-acquire from rdonly_untrusted_mem pointer")
+__failure __msg("BPF_ATOMIC loads from R{{[0-9]+}} rdonly_untrusted_mem is not allowed")
+int load_acquire_from_rdonly_untrusted_mem(void *ctx)
+{
+	__u64 val = 0;
+	void *p;
+
+	/*
+	 * bpf_rdonly_cast(x, 0) yields PTR_TO_MEM | MEM_RDONLY | PTR_UNTRUSTED.
+	 * A regular BPF_LDX from it is rewritten to BPF_PROBE_MEM, but a
+	 * load-acquire is not, so it must be rejected, otherwise the JIT emits
+	 * a plain load with no exception table entry and a fault would crash
+	 * the kernel.
+	 */
+	p = bpf_rdonly_cast(&val, 0);
+	asm volatile (
+	"r1 = %[p];"
+	".8byte %[load_acquire_insn];" // r0 = load_acquire((u64 *)(r1 + 0));
+	:
+	: [p] "r" (p),
+	  __imm_insn(load_acquire_insn,
+		     BPF_ATOMIC_OP(BPF_DW, BPF_LOAD_ACQ, BPF_REG_0, BPF_REG_1, 0))
+	: "r0", "r1");
+	return 0;
+}
+
 SEC("socket")
 __description("load-acquire with invalid register R15")
 __failure __failure_unpriv __msg("R15 is invalid")
-- 
2.43.0

