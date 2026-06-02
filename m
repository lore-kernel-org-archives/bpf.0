Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB91434676F
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 13:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780407064; cv=none; b=r7KGYatB6CvJ2G3+LQeDjjhOEnaxMrRqA781KsX/+fdNb4kFuUBSs2nc7gX2VYncm5G/OG/ygHfhMwRZcS+K8MVRKt0Yv3sBC1m0jscDCYhNlopNBBdRxEy0PWFXCrDpotJa8cW9TOM6v5UwQMl0tqunTaMneaiPBeqC9JUvCbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780407064; c=relaxed/simple;
	bh=Yu1Dt0+fH+ZQaKaMVg3BSOKgK8RO9y5kmkt6aOkhAm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n2i2auMfvVbYj8vH2CUxIflbnqLWRtsHb/OFdJAK88FKXLoys8pwRPg6EHohQtlUdAZ4KcN/qKCbqypZlcleDWvROYOriqbZgJnPKzYxvIjVddoVkARn1kafsE1RzUZOZNd7gaXvQQPRKt9A6WUM1HdLs/zXp2wXgk9QsAq09Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=R3tzN+jP; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="R3tzN+jP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=o/Z6htJM4sTu34MRXoSXwFCv0iYktSfUqHGsJCL2Z28=; b=R3tzN+jPLWVR5KYAEqZUwLW9Sc
	xmiR9qX+N1LeJzWz1FTeLV98L4l1Cj0m1rY5qVnt50N21o4pq0cvZAP8+LHKrx62NXpmy5srFNekJ
	N58e9g0NBXZqkJPaQk05g9up9ikXcrxG/MR5Hz6MGNrrDOoIHz33tSdkHrsV0bzGTPpaSJYGJmA6f
	dZBqy5y9srFN0OeY15lbxz7y/BUxeDu2Su+AuSk6SV9nxIrbeV9voWwNUcvC0KPPJxcCVRHgIJ7er
	oFjserTFOQYXUriOSEnJ+fNDtr+g3q5u3JpfLQoeLZ+lRX8pAxRe0vXM7J9ZJf66q92B7VUL2W3I7
	9yziFkFg==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wUPCp-0007Ik-07;
	Tue, 02 Jun 2026 15:30:55 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: alexei.starovoitov@gmail.com
Cc: bpf@vger.kernel.org,
	kpsingh@kernel.org
Subject: [PATCH bpf-next 3/4] selftests/bpf: Keep verifier_map_ptr exercising ops pointer access
Date: Tue,  2 Jun 2026 15:30:51 +0200
Message-ID: <20260602133052.423725-4-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260602133052.423725-1-daniel@iogearbox.net>
References: <20260602133052.423725-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28019/Tue Jun  2 08:33:27 2026)

sashiko complained that 38498c0ebacd ("selftests/bpf: Adjust verifier_map_ptr
for the map's excl field") would slightly decrease the test coverage given
before the test was against the verifier rejecting the ops pointer. Recover
the old test with the right offsets and add the existing one as an additional
test case.

  # LDLIBS=-static PKG_CONFIG='pkg-config --static' ./vmtest.sh -- ./test_progs -t verifier_map_ptr
  [    1.672932] bpf_testmod: module verification failed: signature and/or required key missing - tainting kernel
  #637/1   verifier_map_ptr/bpf_map_ptr: read with negative offset rejected:OK
  #637/2   verifier_map_ptr/bpf_map_ptr: read with negative offset rejected @unpriv:OK
  #637/3   verifier_map_ptr/bpf_map_ptr: write rejected:OK
  #637/4   verifier_map_ptr/bpf_map_ptr: write rejected @unpriv:OK
  #637/5   verifier_map_ptr/bpf_map_ptr: read non-existent field rejected:OK
  #637/6   verifier_map_ptr/bpf_map_ptr: read non-existent field rejected @unpriv:OK
  #637/7   verifier_map_ptr/bpf_map_ptr: read beyond excl field rejected:OK
  #637/8   verifier_map_ptr/bpf_map_ptr: read beyond excl field rejected @unpriv:OK
  #637/9   verifier_map_ptr/bpf_map_ptr: read ops field accepted:OK
  #637/10  verifier_map_ptr/bpf_map_ptr: read ops field accepted @unpriv:OK
  #637/11  verifier_map_ptr/bpf_map_ptr: r = 0, map_ptr = map_ptr + r:OK
  #637/12  verifier_map_ptr/bpf_map_ptr: r = 0, map_ptr = map_ptr + r @unpriv:OK
  #637/13  verifier_map_ptr/bpf_map_ptr: r = 0, r = r + map_ptr:OK
  #637/14  verifier_map_ptr/bpf_map_ptr: r = 0, r = r + map_ptr @unpriv:OK
  #637     verifier_map_ptr:OK
  [...]
  Summary: 2/20 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 .../selftests/bpf/progs/verifier_map_ptr.c    | 34 ++++++++++++++++---
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_map_ptr.c b/tools/testing/selftests/bpf/progs/verifier_map_ptr.c
index d8e822d1a8ba..166193659870 100644
--- a/tools/testing/selftests/bpf/progs/verifier_map_ptr.c
+++ b/tools/testing/selftests/bpf/progs/verifier_map_ptr.c
@@ -72,17 +72,43 @@ __naked void bpf_map_ptr_write_rejected(void)
 
 /*
  * struct bpf_map starts with the SHA256 hash sha[32] at offset 0 (a readable
- * byte array), followed by the u32 excl field at offset 32. Reading a u32 at
- * offset 33 runs past the end of excl and is rejected.
+ * byte array), the u32 excl field at offset 32, and the ops pointer at offset
+ * 40. Reading a u32 at offset 41 reaches into the middle of the ops pointer,
+ * i.e. a partial pointer access, which is rejected.
  */
 SEC("socket")
 __description("bpf_map_ptr: read non-existent field rejected")
 __failure
-__msg("access beyond the end of member excl (mend:36) in struct bpf_map with off 33 size 4")
+__msg("cannot access ptr member ops with moff 40 in struct bpf_map with off 41 size 4")
 __failure_unpriv
 __msg_unpriv("access is allowed only to CAP_PERFMON and CAP_SYS_ADMIN")
 __flag(BPF_F_ANY_ALIGNMENT)
 __naked void read_non_existent_field_rejected(void)
+{
+	asm volatile ("					\
+	r6 = 0;						\
+	r1 = %[map_array_48b] ll;			\
+	r6 = *(u32*)(r1 + 41);				\
+	r0 = 1;						\
+	exit;						\
+"	:
+	: __imm_addr(map_array_48b)
+	: __clobber_all);
+}
+
+/*
+ * The u32 excl field spans offsets 32..35 (mend 36). Reading a u32 at offset
+ * 33 starts inside excl but extends past its end, which the verifier rejects
+ * as an out-of-bounds scalar access.
+ */
+SEC("socket")
+__description("bpf_map_ptr: read beyond excl field rejected")
+__failure
+__msg("access beyond the end of member excl (mend:36) in struct bpf_map with off 33 size 4")
+__failure_unpriv
+__msg_unpriv("access is allowed only to CAP_PERFMON and CAP_SYS_ADMIN")
+__flag(BPF_F_ANY_ALIGNMENT)
+__naked void read_beyond_excl_field_rejected(void)
 {
 	asm volatile ("					\
 	r6 = 0;						\
@@ -105,7 +131,7 @@ __naked void ptr_read_ops_field_accepted(void)
 	asm volatile ("					\
 	r6 = 0;						\
 	r1 = %[map_array_48b] ll;			\
-	r6 = *(u64*)(r1 + 0);				\
+	r6 = *(u64*)(r1 + 40);				\
 	r0 = 1;						\
 	exit;						\
 "	:
-- 
2.43.0

