Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C803537D8
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 21:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774387648; cv=none; b=MY9ukQ6JvuNvuKJYMIWSoV2Boh6WPB/sqbXo8gp6nX3pz5v6OekuoIPkKb6yWkB2ulEdSXTFNKttlgiuufW2eFcaD3wIcM230sr1h/y8mX0NbQjNJJkeLTqxrgbwE6ftdq8Pzo4DLIgla1PRgpjaZHY7sMFdRSXxZN+VBlPfzG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774387648; c=relaxed/simple;
	bh=+PK9HY9pUZ0C+fawOgmlAhUP8YhbtL/lJkemA2N9ymo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RaSzLFWAsGUbMCZyVcqds2ZJQ661SVLyJkZsuggIQ7AqlGxqmL7vbEwhfBl80pwqLteNeD0U5AFoUU4+bOkix31iHtJ3S42BwoXMQ/vJ3x3zb90vBcVWOKf2ObsrjLjeL5nSg96R0AsMq6ZGeUNDeB9XIm1fB6tXnqFy3crhb7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BNBEGdA1; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BNBEGdA1"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-35ba749f441so1494675a91.1
        for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 14:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774387646; x=1774992446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CmS2a+FJZOM8vZtvqJBXu1EgB8VQZ6zodtDJYGUpZeY=;
        b=BNBEGdA1iov+NaGTRCl5BJlPyaYGGyNg9igwdtBOTl2nxskqqB7CUrH3ijBA/IqqdH
         1ha8CEpf2g7ZVUjQgixpEs/SEmeWc6uWuoR5Sejz7/l7O4sHdNnLNAavIdjdAkptSovA
         7x8rrkNZngpBmdqhesnm/+hdWJG9H8DKEpFa/wWiA+OuYhD1uiMt9Nn/s2Pv1pTuYOsM
         nD8GgQQgXx5W6MtO5Pf75KBa708qfGb47GXXgYl7l9aHZUa9E10DJ0FKNbgI97ymOgBc
         PHhs7MuoxyO5OnoHRcG/xWhNGtnrUOMPM9+qu9r/Edx13WTes9qWD+hVUteNLRhwySJk
         tTlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774387646; x=1774992446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CmS2a+FJZOM8vZtvqJBXu1EgB8VQZ6zodtDJYGUpZeY=;
        b=k9vYw/nrmtJSEvNyPk3spckb7ZZnMZSxaV3hHtUb4jj0gg9sJ75xd2hbW4m3v4g4+L
         7Y+yR9JMJTgWdI9hlpuxQysH72awHJdaS9YndX02i+3J7mHdS/AlCPS/NLPT7/IG/PfL
         34AdwXEvCVk0dK5H4jDwG84oaYpzYMyJ6I7Qfw1/r2RdKGrNmORqy8hg5VyijwxJ9HXO
         i5eS1Qku7tLbzm8asiNGWrpgNI9braKT21yVfLWrnbTrj/Bexca4gfeyFJbRF3sruJWE
         UKAJZq/HHpnrl3VCikGMZJANs9FJzyrA9di2wx97VkaxrB1PpvP/j+Z3fAJOTYR9jYQg
         Z45g==
X-Gm-Message-State: AOJu0YwmcO6QLGWJFrtZjoofJ77U2h951PKs8Bxw8/UTI8Hcr7NN/His
	rVu/NPoCw5695At1OpUblobCkWcRCy6UNgYlSWjzPMbOvWqDAmL5GHdSV6rDKQ==
X-Gm-Gg: ATEYQzyGe5QaNR5+nUKE+x36+YvQhZmgvwfHCbzXWDGKSsjRzgi6iSEz4Tx5xuB+FpC
	zjQw8CV0TaNG0hYY/YP8b8XNu4xEdcviXj6jtYDH8Wj3AJH4HhmuVisX6YIIpjUaYNYMs3aULHE
	eTRcuWavuBHQ8evGfY0H2mawqJNzukKK0Tm41JiIQdpmDngBNRWbELZDSVtXiFxCfukJkpFwcOU
	vH8cjrqSwudElgrlSIzbdmuVXQiAcv8XzRe8IGuN/3nQa9O2eez0SnZqaCiIcW6ppNol3uw23vo
	c2HE6fR+rEcONnoiHfpsXud4JljAPdDfd2AIBNMvhes6au31qy1+Mckl/KKIFt6ys4Q/TZWWmLs
	pjx6l7MM5VvnG1j9Jt6H4m7ljNK0bL35TsTflAKZ2UoczZ+zySPFqomqwvpP84fGNMnkDseHunu
	o94Laoo5gNME50VttFKPkroKiELK8DV2N58k9DP7sQHvT7axBSSyG1DAWG3BxCxEzPGqGsdAAZT
	2BDNOMpIZnrAkiGFuDwtvct7I0BvzEY/FTYbb+frM2AF0yHnmq/730f/aOs6g==
X-Received: by 2002:a17:90b:4a4f:b0:359:f22:8879 with SMTP id 98e67ed59e1d1-35c0ddb253amr845847a91.22.1774387646579;
        Tue, 24 Mar 2026 14:27:26 -0700 (PDT)
Received: from localhost.localdomain ([2601:600:837f:c470:1879:8422:922b:e5d3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c0d6060b5sm604151a91.17.2026.03.24.14.27.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 24 Mar 2026 14:27:26 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com
Subject: [PATCH bpf-next 2/2] selftests/bpf: Test variable length stack write
Date: Tue, 24 Mar 2026 14:27:21 -0700
Message-ID: <20260324212721.71245-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260324212721.71245-1-alexei.starovoitov@gmail.com>
References: <20260324212721.71245-1-alexei.starovoitov@gmail.com>
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

