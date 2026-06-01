Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453EA3D7D97
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 15:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780326175; cv=none; b=LsYL/uQdTKwBGuEhH2bqykQj8INtHhYdjR+II6r60KkFeTMsXHosklLlxIZ9OQ2iqg0xOINF5wiCF9Dc88vpdy8Ax10zd3y7mOtxzcXW+fpQSHYb6P8PhiEMIILkYfSs5raR8Mydv1avEVNUxMCTwQOwAjiy3CShPi+6lYT0jNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780326175; c=relaxed/simple;
	bh=s6Zc+PlD1zhEFSBYewZtQTHzCzhcSMbtHshsJ+eGL70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=srMsJOSro4bPqdl5UUE7q39E35zvHzZ2qGIAIOgNWh2dcSKtr/UCjIGPu3c5xNpc371tk7aDsUFuE0owQeSx/Ayt2suouHfuGnZRMx0wa2kUlTygjiMC+zNQd3ongtQNFLHmt03K1ohZk5f3ocjOOLVD2/ZqbDemMMeWcm0wBoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=E9MqzmRL; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="E9MqzmRL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=zib6FRNBx6yrUUMxfX10Ehk9cC0q1xfRn50VOSLynt8=; b=E9MqzmRLfvlDT7CjEZLkss/XQA
	z4dMbPXKuQ4ci4F0xLotnqYhLqBbjs2iJ8P1Rx3M+MfeTx2igSsivO33lV6bq7qOwFyJXZd1XQogy
	b5SjoGgAO6rkMIyE2EYz5OEsRDIHIJcuRxx6eU3+mK8VGKkb9j4zpwg8zCpA49NqheijldvA+/o+X
	ex1JIcpFybWnlYtRl8Y7FaQQUof3XqO1Du5DYUYCAFoxqLQH0SLscV+WyoKt51KuPHEaY02OtuQUR
	63xe7dB4LBbNl4tUQiW046RIX+lnaX2SyQEM1S36u2B6x+4pBpIwCtpjRjHT1Bk0U+BuFfIMzvTck
	DPF1lv3g==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wU4AG-000GWr-2N;
	Mon, 01 Jun 2026 17:02:52 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: alexei.starovoitov@gmail.com
Cc: bpf@vger.kernel.org,
	kpsingh@kernel.org
Subject: [PATCH bpf-next v2 6/7] selftests/bpf: Adjust verifier_map_ptr for the map's excl field
Date: Mon,  1 Jun 2026 17:02:47 +0200
Message-ID: <20260601150248.394863-7-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260601150248.394863-1-daniel@iogearbox.net>
References: <20260601150248.394863-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28018/Mon Jun  1 08:31:13 2026)

From: KP Singh <kpsingh@kernel.org>

Adding the u32 excl field at offset 32 of struct bpf_map right after the
sha[SHA256_DIGEST_SIZE] hash shifts the ops pointer from offset 32 to 40.
Therefore, fix up the test case.

  # LDLIBS=-static PKG_CONFIG='pkg-config --static' ./vmtest.sh -- ./test_progs -t verifier_map_ptr
  [...]
  #637/1   verifier_map_ptr/bpf_map_ptr: read with negative offset rejected:OK
  #637/2   verifier_map_ptr/bpf_map_ptr: read with negative offset rejected @unpriv:OK
  #637/3   verifier_map_ptr/bpf_map_ptr: write rejected:OK
  #637/4   verifier_map_ptr/bpf_map_ptr: write rejected @unpriv:OK
  #637/5   verifier_map_ptr/bpf_map_ptr: read non-existent field rejected:OK
  #637/6   verifier_map_ptr/bpf_map_ptr: read non-existent field rejected @unpriv:OK
  #637/7   verifier_map_ptr/bpf_map_ptr: read ops field accepted:OK
  #637/8   verifier_map_ptr/bpf_map_ptr: read ops field accepted @unpriv:OK
  [...]
  Summary: 2/18 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: KP Singh <kpsingh@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 tools/testing/selftests/bpf/progs/verifier_map_ptr.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_map_ptr.c b/tools/testing/selftests/bpf/progs/verifier_map_ptr.c
index e2767d27d8aa..d8e822d1a8ba 100644
--- a/tools/testing/selftests/bpf/progs/verifier_map_ptr.c
+++ b/tools/testing/selftests/bpf/progs/verifier_map_ptr.c
@@ -70,13 +70,15 @@ __naked void bpf_map_ptr_write_rejected(void)
 	: __clobber_all);
 }
 
-/* The first element of struct bpf_map is a SHA256 hash of 32 bytes, accessing
- * into this array is valid. The opts field is now at offset 33.
+/*
+ * struct bpf_map starts with the SHA256 hash sha[32] at offset 0 (a readable
+ * byte array), followed by the u32 excl field at offset 32. Reading a u32 at
+ * offset 33 runs past the end of excl and is rejected.
  */
 SEC("socket")
 __description("bpf_map_ptr: read non-existent field rejected")
 __failure
-__msg("cannot access ptr member ops with moff 32 in struct bpf_map with off 33 size 4")
+__msg("access beyond the end of member excl (mend:36) in struct bpf_map with off 33 size 4")
 __failure_unpriv
 __msg_unpriv("access is allowed only to CAP_PERFMON and CAP_SYS_ADMIN")
 __flag(BPF_F_ANY_ALIGNMENT)
-- 
2.43.0

