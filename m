Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4956241A4FC
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 17:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785776597; cv=none; b=hRTA4zfvnfKsucQfjKFDDeOk47FTY9aKjyAf7pjAfwyX+je9WrB/5S5VtTDa7si4W2q8v4KuegRQwipGNM0JueZnZv9MHzqcvXRp6fZ2giNvJqf688vayiYxswRalGg4NgrKVp8jy9hp2vfpj1gCkX/6YRfpIjhFBNocpPp1trI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785776597; c=relaxed/simple;
	bh=ZRg+ZYHrpKdKwv0IAMlmZLgdkJd2nb5sieMoGxIA6bk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QHBBImMLIoZD9dbu+b4DKOgD0wjG0aATXAy7vWysB1jlVzZOMKxDbd342dyQRXfAWbt5Ja5McayIMUVKhYDzSEDK3RIU5BwNtlw3ltdDJ1MwfhjY7fFkqwnb0t6kPvPSxpenN/vFIgda/uantg/9TmTVz8QACAxDyALjOSv5rf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vpeHqQQH; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vpeHqQQH"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785776584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eBlLxE+fYfxpXqzS45PMr1YuPhCVWYb35QGSfAmvVkQ=;
	b=vpeHqQQH+zpOrZAIKRwBDkswUhtMf4mVB8yuYMVpeCB9iofTGt/P7VHo+v2rI6m8FMXAlU
	cB32/nCAQTXW/KPEwmF5p8jX519wWTqLNr2R5XxwBEuwmVdOePtKD/e8DiQCw5VFatLJfO
	aTmjIAmA9tX6SLH1ZC4hCMGoEMOK3FY=
From: Vineet Gupta <vineet.gupta@linux.dev>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	Eduard Zingerman <eddyz87@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: linux-kernel@vger.kernel.org,
	Vineet Gupta <vineet.gupta@linux.dev>
Subject: [bpf-next 1/4] selftests/bpf: map_kptr: force BPF_STX for the scalar store to kptr
Date: Mon,  3 Aug 2026 10:02:48 -0700
Message-ID: <20260803170251.1898102-2-vineet.gupta@linux.dev>
In-Reply-To: <20260803170251.1898102-1-vineet.gupta@linux.dev>
References: <20260803170251.1898102-1-vineet.gupta@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

reject_scalar_store_to_kptr stores a scalar constant to a kptr field:

        *(volatile u64 *)&v->unref_ptr = 0xBADC0DE;

Compilers generate one of two encodings for that:

 1. Materialize the constant into a register and emit BPF_STX:

        r1 = 0xbadc0de
        *(u64 *)(r0 + 0x8) = r1

 2. Or fold it into a single BPF_ST (store immediate):

        *(u64 *)(r0 + 0x8) = 0xbadc0de

check_map_kptr_access() rejects both, but through very different checks.
BPF_STX goes through map_kptr_match_type(), whose first test is
base_type(reg->type) != PTR_TO_BTF_ID - the scalar rejection this test is
named for - and which prints "invalid kptr access, R...". BPF_ST only gets
the trivial "BPF_ST imm must be 0 when storing to kptr" immediate check and
never reaches map_kptr_match_type() at all.

So on a compiler that folds the constant - bpf-gcc, and clang from
-mcpu=v4, which enabled BPF_ST around v4 support due to historical
verifier limitations - the test fails against its expected message.

Widening the __msg to accept either message would make it pass again, but
on those toolchains it would then only re-test the imm != 0 path, which
verifier/map_kptr.c ("map_kptr: BPF_ST imm != 0") already covers, and the
scalar-vs-PTR_TO_BTF_ID check would lose its only test in the tree.

Route the value through barrier_var() instead, so the store stays a
BPF_STX everywhere and the test keeps asserting what it was written to
assert. clang -mcpu=v1..v4 and bpf-gcc 16.1 all emit the register form
afterwards.

  bpf-gcc, before: #229/20 map_kptr/reject_scalar_store_to_kptr:FAIL
  bpf-gcc, after : #229/20 map_kptr/reject_scalar_store_to_kptr:OK

Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
---
 tools/testing/selftests/bpf/progs/map_kptr_fail.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/map_kptr_fail.c b/tools/testing/selftests/bpf/progs/map_kptr_fail.c
index f11848dfa78f..cb84e23b83c0 100644
--- a/tools/testing/selftests/bpf/progs/map_kptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/map_kptr_fail.c
@@ -390,13 +390,22 @@ __failure __msg("invalid kptr access, R")
 int reject_scalar_store_to_kptr(struct __sk_buff *ctx)
 {
 	struct map_value *v;
+	u64 val = 0xBADC0DE;
 	int key = 0;
 
 	v = bpf_map_lookup_elem(&array_map, &key);
 	if (!v)
 		return 0;
 
-	*(volatile u64 *)&v->unref_ptr = 0xBADC0DE;
+	/*
+	 * Keep the value in a register so this stays a BPF_STX and keeps
+	 * exercising map_kptr_match_type(). Compilers that fold the constant
+	 * into a BPF_ST (store immediate) instead - bpf-gcc, and clang from
+	 * -mcpu=v4 - would be rejected by the far weaker "BPF_ST imm must be
+	 * 0" check, which verifier/map_kptr.c already covers.
+	 */
+	barrier_var(val);
+	*(volatile u64 *)&v->unref_ptr = val;
 	return 0;
 }
 
-- 
2.55.0

