Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87103845B5
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 21:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774389584; cv=none; b=LaL+0aDHmvRd3W8jOCD0WGTj3Q07/4PYwI+tfY9i2PAU4fufVhzapejLbGYQd30JKEle3V7r6MKU5jz0CW+/whOK0TZbKN9sw+G2kU9ieqZTZn/g9o3O17GZk0rgJliowI2Fj8XZjUQDHeSP9hvd5b/NmHct4yx7xN+GDzcHMrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774389584; c=relaxed/simple;
	bh=+PK9HY9pUZ0C+fawOgmlAhUP8YhbtL/lJkemA2N9ymo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MF5zgcfXKtTNKS+LUgP/xii6WC7Xp/mxUBYkF5dQxZ/SlNpQq4E0nYSsSNFLwVUzRQqduxBRTFlaz5sG8OZAef30Os7HqXEz1PLYQzWTemm39ZrBKCvjf8ZBV7WBm3mBoFwMGlFWAdtkUwtr+tHZrOwwYrxkGVQ5lb/ScQUW/do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O30tVFBG; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O30tVFBG"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2b061b6cf36so33630575ad.3
        for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 14:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774389582; x=1774994382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CmS2a+FJZOM8vZtvqJBXu1EgB8VQZ6zodtDJYGUpZeY=;
        b=O30tVFBGgDay2VMP++Sfa1gr6SOUjqRvQKSeTRham6UVUJRPXr+gwzEK2D0ZlFZsoC
         vXzfLqx/2ojCVbnweDfNtx9RPvR3FUcFoJWWuVclGgMEJ9udJo1eG/sX1JAvpZeyzneg
         GnYg4Dbd4eAZpwefi/hHg74ABKxhcVi7udf/+/XDTt8ae5ge8DDm15aKgS6sRwZqrWtg
         XFae+Nn/2Pe+ujmWhEh7Xrao0Eh0D6e3Affjih5sctol5p/gxsLCoKCK9kf0yvvWlkJR
         LEqpWzXKFOuPI+C3oFxnJDfSSekI2Xdi5mt3FJjs47H2qIP4ldlUJr+Juvktze6IvmpC
         iy8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774389582; x=1774994382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CmS2a+FJZOM8vZtvqJBXu1EgB8VQZ6zodtDJYGUpZeY=;
        b=h5DUPqv+qAZgH+HCGp3+byx7Gf5AyhaxBqZWeCGVvB02cDtg52aYIv3QeqJSszRgcQ
         vVDVNlfe9bgiX5qiIgNxAvnUsG6J0sykcKyymxKZwAGp8U+cgBgsiO1gSYtOQLzaOS6I
         mSqnkIFtOhhfd+jAQ2fx8dmQpfz3xVWa0ko+cJWFIn8S4yXLhx+pNORwm5WBdBSQgwwa
         DbdkShx3kXyXXVWhrXrOHbGo//jIt5pTBctWmdQpDiKH7T08EFL9FkxWdul0xKqn4v0r
         xbda1zgSKaRoXqfNjVSy66PLpuNfO+LRVsWetfs+Z4XvRylhE1Y0amPXoGEtPFuJVY/H
         Qgsg==
X-Gm-Message-State: AOJu0Yx9J2mhLBwJDk/VipVROVcm4nDUWeJrCZckqtX9G8959INyqQG7
	iLRmDgf6QvD8pCTkZCqrnUdvDirFCxE0IpX/Spyf31/qsDtDmuCA05+n97376Q==
X-Gm-Gg: ATEYQzzXbm993gmSQdhkj0IsvN479cdcNL57faEmZADEouztvbHXYTxZdCd23gOb5a/
	wbcRe91F0gCchFIf36uGZ14hclUO0FxbR8Bxw6c8Ib7Mn8jOM7J6+RkpusonajPvQfHEBXZUdJh
	c5JSj7LwhAE6CM1iOL01C/kELbuM2ZIba5EcAh0nll/1C3l6+x83OhRlPjoY6I5LcyHFDOt3Gm0
	FGzm6CQaPqyYFPNEoosSl9G8kryBdLOYv8gmdWUjA+L9UCMEFu1b0oUat1oitQnRCPe4Oj56lXR
	hUQNouaOE45WgU0nm6pjKbalzq/YtKL+EWs1S78WRgqbNX0O+1/WyBMfWYJmBYEZADijYJjRXmJ
	Nbj/GMS6GqprOMl0USiEt9S2RlmCQSZuJdEI/DuUagz21mYpMc+DUpOM7mR28zxpVXlkfYmOiHh
	wzQ94wmW3y/kZxj9SV+ZAO01QMxoa6nBaJLtoJgZ6GDC/BiRhb3KN9BdOmsjQrlkZBldlbwKReH
	KV9oHTwWBq5KPzWZxyH0USbIg56T8ty7pMrWLGxiTHHfQnZUrFZWNOIiMGWUA==
X-Received: by 2002:a17:902:f681:b0:2ae:4f15:1aba with SMTP id d9443c01a7336-2b0b0a9fd88mr11743865ad.30.1774389582532;
        Tue, 24 Mar 2026 14:59:42 -0700 (PDT)
Received: from localhost.localdomain ([2601:600:837f:c470:1879:8422:922b:e5d3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0836b15fbsm206885715ad.81.2026.03.24.14.59.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 24 Mar 2026 14:59:42 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com
Subject: [PATCH v2 bpf-next 2/2] selftests/bpf: Test variable length stack write
Date: Tue, 24 Mar 2026 14:59:37 -0700
Message-ID: <20260324215938.81733-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260324215938.81733-1-alexei.starovoitov@gmail.com>
References: <20260324215938.81733-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Add a test to make sure that variable length stack writes
scrubs STACK_SPILL into STACK_MISC.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/progs/verifier_spill_fill.c | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
index a2b6d99628da..672e4446181e 100644
--- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
+++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
@@ -1316,4 +1316,45 @@ __naked void old_imprecise_scalar32_vs_cur_stack_misc(void)
 	: __clobber_all);
 }
 
+SEC("raw_tp")
+__success
+__naked void var_off_write_over_scalar_spill(void)
+{
+	asm volatile (
+	/* Get an unknown value bounded to {0, 4} */
+	"call %[bpf_ktime_get_ns];"
+	"r6 = r0;"
+	"r6 &= 4;"
+
+	/* Spill a scalar to fp-16 */
+	"r7 = 0xdeadbeef00000000 ll;"
+	"*(u64 *)(r10 - 16) = r7;"
+
+	/*
+	 * Variable-offset 4-byte write covering [fp-12, fp-4).
+	 * This touches stype[3..0] of the spill slot at fp-16 but
+	 * leaves stype[7..4] as STACK_SPILL. check_stack_write_var_off()
+	 * must scrub the entire slot when setting spilled_ptr to NOT_INIT,
+	 * otherwise a subsequent sub-register fill sees a non-scalar
+	 * spilled_ptr and is rejected.
+	 */
+	"r8 = r10;"
+	"r8 += r6;"
+	"r8 += -12;"
+	"r9 = 0;"
+	"*(u32 *)(r8 + 0) = r9;"
+
+	/*
+	 * 4-byte read from fp-16. Without the fix this fails with
+	 * "invalid size of register fill" because is_spilled_reg()
+	 * sees STACK_SPILL while spilled_ptr.type == NOT_INIT.
+	 */
+	"r0 = *(u32 *)(r10 - 16);"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.52.0

