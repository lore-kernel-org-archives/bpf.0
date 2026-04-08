Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BEC3D9031
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 19:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775675568; cv=none; b=EszzvQbxjXnaz9OzRHnxpEKCImWxPZFCmiZgsukVE7Ll88NLvAcgYieWuvQ7q6V7XsEWs8vBfbAkz3EWIMc76zLZQBXiEwPkGKpPNu8TFJzlA/7d6A6VCT788rwRPtN0JjHOR044E+EtQ639NhxPGM7ltf6gB5q04bQlZOF20dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775675568; c=relaxed/simple;
	bh=5uFWb6tgQGjlq5k5MzsifMsMZE5ITzCM41F0b+76Zak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eDsTyAx/rixEpmopetRHJ8ZXFJVoRR0/K/s1sXDAThJq+cqkJ8K5CHPua61Noj0r7SWhsj+xDrlFoK59kfDI4KCBdYzbo9kBVKxormIVNqxw1F3gidSvYIIHIS5szXbuH+sdr1GTkK0BZgptgogTo3EYxqjDHGbd3Mdt9j6dra0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=PqeFJHwK; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="PqeFJHwK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Mf1labaxqEz40r4F6+XifaPA5svoG1rC9lPSNHgpMSQ=; b=PqeFJHwK6klhMVJQ2WODcrLKe6
	+qd5Vf+niZHRYopEdr1j0dvi/dBGoyZUHUX5IGsvf2rrHIPpFdhjzPo6p48C5xnTX3tfakUADZ4Em
	lZUbncHgm85Yc2UJSPAMJW5HNPu976u683SoMT1U0WY4gVNOGHJx0SFmhUHEOMLB/IyladZlIVpld
	q+SHSZ+93+aXtfvvGeZKBvNv0Ig/BQdC+vaR/fpjSa3vztlsa2VdunoZ6jzqYXKklt3zaN5JPR3/P
	ozx0Gd4tXZ61c776d9gx/Tm6sDOHN0J5KF3SEXqk2VoBh0xGRo4ZX6Ga4AwDEBI3z2z7SKqV2twla
	3j7Ne7vw==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wAYKT-0002OB-03;
	Wed, 08 Apr 2026 21:12:45 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	eddyz87@gmail.com,
	info@starlabs.sg
Subject: [PATCH bpf-next v2 4/4] selftests/bpf: Add tests for ld_{abs,ind} failure path in subprogs
Date: Wed,  8 Apr 2026 21:12:42 +0200
Message-ID: <20260408191242.526279-4-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260408191242.526279-1-daniel@iogearbox.net>
References: <20260408191242.526279-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27965/Wed Apr  8 08:24:37 2026)

Extend the verifier_ld_ind BPF selftests with subprogs containing
ld_{abs,ind} and craft the test in a way where the invalid register
read is rejected in the fixed case. Also add a success case each,
and add additional coverage related to the BTF return type enforcement.

  # LDLIBS=-static PKG_CONFIG='pkg-config --static' ./vmtest.sh -- ./test_progs -t verifier_ld_ind
  [...]
  #611/1   verifier_ld_ind/ld_ind: check calling conv, r1:OK
  #611/2   verifier_ld_ind/ld_ind: check calling conv, r1 @unpriv:OK
  #611/3   verifier_ld_ind/ld_ind: check calling conv, r2:OK
  #611/4   verifier_ld_ind/ld_ind: check calling conv, r2 @unpriv:OK
  #611/5   verifier_ld_ind/ld_ind: check calling conv, r3:OK
  #611/6   verifier_ld_ind/ld_ind: check calling conv, r3 @unpriv:OK
  #611/7   verifier_ld_ind/ld_ind: check calling conv, r4:OK
  #611/8   verifier_ld_ind/ld_ind: check calling conv, r4 @unpriv:OK
  #611/9   verifier_ld_ind/ld_ind: check calling conv, r5:OK
  #611/10  verifier_ld_ind/ld_ind: check calling conv, r5 @unpriv:OK
  #611/11  verifier_ld_ind/ld_ind: check calling conv, r7:OK
  #611/12  verifier_ld_ind/ld_ind: check calling conv, r7 @unpriv:OK
  #611/13  verifier_ld_ind/ld_abs: subprog early exit on ld_abs failure:OK
  #611/14  verifier_ld_ind/ld_ind: subprog early exit on ld_ind failure:OK
  #611/15  verifier_ld_ind/ld_abs: subprog with both paths safe:OK
  #611/16  verifier_ld_ind/ld_ind: subprog with both paths safe:OK
  #611/17  verifier_ld_ind/ld_abs: reject void return subprog:OK
  #611/18  verifier_ld_ind/ld_ind: reject void return subprog:OK
  #611     verifier_ld_ind:OK
  Summary: 1/18 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 .../selftests/bpf/progs/verifier_ld_ind.c     | 142 ++++++++++++++++++
 1 file changed, 142 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_ld_ind.c b/tools/testing/selftests/bpf/progs/verifier_ld_ind.c
index c925ba9a2e74..09e81b99eecb 100644
--- a/tools/testing/selftests/bpf/progs/verifier_ld_ind.c
+++ b/tools/testing/selftests/bpf/progs/verifier_ld_ind.c
@@ -107,4 +107,146 @@ __naked void ind_check_calling_conv_r7(void)
 	: __clobber_all);
 }
 
+/*
+ * ld_{abs,ind} subprog that always sets r0=1 on the success path.
+ * bpf_gen_ld_abs() emits a hidden exit with r0=0 when the load helper
+ * fails. The verifier must model this failure return so that callers
+ * account for r0=0 as a possible return value.
+ */
+__naked __noinline __used
+static int ldabs_subprog(void)
+{
+	asm volatile (
+	"r6 = r1;"
+	".8byte %[ld_abs];"
+	"r0 = 1;"
+	"exit;"
+	:
+	: __imm_insn(ld_abs, BPF_LD_ABS(BPF_W, 0))
+	: __clobber_all);
+}
+
+__naked __noinline __used
+static int ldind_subprog(void)
+{
+	asm volatile (
+	"r6 = r1;"
+	"r7 = 0;"
+	".8byte %[ld_ind];"
+	"r0 = 1;"
+	"exit;"
+	:
+	: __imm_insn(ld_ind, BPF_LD_IND(BPF_W, BPF_REG_7, 0))
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("ld_abs: subprog early exit on ld_abs failure")
+__failure __msg("R9 !read_ok")
+__naked void ld_abs_subprog_early_exit(void)
+{
+	asm volatile (
+	"call ldabs_subprog;"
+	"if r0 != 0 goto l_exit_%=;"
+	"r0 = r9;"
+	"l_exit_%=:"
+	"r0 = 0;"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC("socket")
+__description("ld_ind: subprog early exit on ld_ind failure")
+__failure __msg("R9 !read_ok")
+__naked void ld_ind_subprog_early_exit(void)
+{
+	asm volatile (
+	"call ldind_subprog;"
+	"if r0 != 0 goto l_exit_%=;"
+	"r0 = r9;"
+	"l_exit_%=:"
+	"r0 = 0;"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC("socket")
+__description("ld_abs: subprog with both paths safe")
+__success
+__naked void ld_abs_subprog_both_paths_safe(void)
+{
+	asm volatile (
+	"call ldabs_subprog;"
+	"r0 = 0;"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC("socket")
+__description("ld_ind: subprog with both paths safe")
+__success
+__naked void ld_ind_subprog_both_paths_safe(void)
+{
+	asm volatile (
+	"call ldind_subprog;"
+	"r0 = 0;"
+	"exit;"
+	::: __clobber_all);
+}
+
+/*
+ * ld_{abs,ind} in subprogs require scalar (int) return type in BTF.
+ * A test with void return must be rejected.
+ */
+__naked __noinline __used
+static void ldabs_void_subprog(void)
+{
+	asm volatile (
+	"r6 = r1;"
+	".8byte %[ld_abs];"
+	"r0 = 1;"
+	"exit;"
+	:
+	: __imm_insn(ld_abs, BPF_LD_ABS(BPF_W, 0))
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("ld_abs: reject void return subprog")
+__failure __msg("LD_ABS is only allowed in functions that return 'int'")
+__naked void ld_abs_void_subprog_reject(void)
+{
+	asm volatile (
+	"call ldabs_void_subprog;"
+	"r0 = 0;"
+	"exit;"
+	::: __clobber_all);
+}
+
+__naked __noinline __used
+static void ldind_void_subprog(void)
+{
+	asm volatile (
+	"r6 = r1;"
+	"r7 = 0;"
+	".8byte %[ld_ind];"
+	"r0 = 1;"
+	"exit;"
+	:
+	: __imm_insn(ld_ind, BPF_LD_IND(BPF_W, BPF_REG_7, 0))
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("ld_ind: reject void return subprog")
+__failure __msg("LD_ABS is only allowed in functions that return 'int'")
+__naked void ld_ind_void_subprog_reject(void)
+{
+	asm volatile (
+	"call ldind_void_subprog;"
+	"r0 = 0;"
+	"exit;"
+	::: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0

