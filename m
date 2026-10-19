Received: from mail-oa2-f11.google.com (mail-oa2-f11.google.com [74.125.231.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFD74F4045
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 13:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792416179; cv=none; b=hxooCou0K+YTL4A4UAnW6EsaOFiYwbUveRwgS9KD+6uHEHkSqNuG/VYDRfPjlTbaSULGn1oH6YBhbEWKXB7tLUW2N5CFpwYUIItC9ydyJdadFus+85dIEVsPU4yyhpodc3RoJJInjYF5u9Dg5bl2OMqxGq+S3HbKHEBqnw7zUco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792416179; c=relaxed/simple;
	bh=tzw+aCcv3UQYtzkDQiX9ynkaGvSmqn6LNADjaXtYzwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZPnNlwKIdP9Kd48r3WNfI9yxav2r4EHTq2nR8I2bwIvu25OlBje1N4TXh/qq+nuduzYT9dPQS51KTj3md9D77gyNJ9Uz5Qr1bwvIWMN+CUtJvoLfiXtg8E8z2w60M1TFCxbt2eO70m5uh++oq+B6UuSILiysvoPGWjFiMj96sLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tFd4lpoP; arc=none smtp.client-ip=74.125.231.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tFd4lpoP"
Received: by mail-oa2-f11.google.com with SMTP id 586e51a60fabf-462dec1c4c5so820041fac.0
        for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 06:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792416177; x=1793020977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kh+n6U5ggjpSUBE8mowdMoP3nwWk+nABuZj9uU6qz8c=;
        b=tFd4lpoPAKQMBefdsAlLco8bdbhykHBv47zUB6/rGKgWYPX7Vl6mHFsrOFh5dcl3Bj
         YQDLq3Z3iEpVVpJTrjRUIjLWoIh2eih2u+brr2ruPv8qOzOvUlhIS1FRVA9V3gn1Jc6u
         9C2CgFFJEmYKeRnKDFDWhUHFdiTBDludHetauK9IJ/Yz9T1XUn3V+NhcF7yJXWtCCuO2
         NaTH7a3cBR8UjEdIFqZ7IB2w0GpHfqjVutgS+haHV23VYRWOHEGCyPt6Bp5qIGA+Y194
         b/T81mbNo3zm4Plv7zOaa7971dyVlJCei0defA+vZjj7DxwgkQSA8h8TBpTVCDI1+6N1
         oe+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792416177; x=1793020977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kh+n6U5ggjpSUBE8mowdMoP3nwWk+nABuZj9uU6qz8c=;
        b=LCIoALAT1xRwX2UrSEaItepiUUhnsfWrPWWY/29YuQp284Yd5D8oIjxLB6is3JFLFj
         XFCh9Zj/5UX8IdahqL9wllraePLHRxkJNGCMRjzf+YylDb7Zkm8gxRm/TNJFNoku/5oz
         gVj0JsTdoAjY/gK0mYgrtmupJpJc/WIixGNTFLxNewsJPzVFBnisQruHPVTgUVh9pbN0
         iwHH0R5V9o+bFpf7+q2tnGI+uC9eMfDprx2RT5YO/NhyL0VmhzEchLzHnZxAsqTf1hnS
         mZIByoaGXKEfTBpgxFBxSW9GvkT4GFLKrRLhQhRtVnQjWyoQCOCPzvzD3CCSWXGhIIAd
         zA/Q==
X-Gm-Message-State: AFq9FYL9qcCyIN2r79GbJymGiUiIK3PILzY7igG1ABZY5uxn655yiJXj
	fBWS7fLDfOfKODQn+TuWm/Ujyww8zjcI/CH3TE6vSqiYkUFL0DAJywSW1hW1yr3Pap8=
X-Gm-Gg: AYBFou3uKeqKlu9BhSo6AC6YOtbyluEdxjHO9wIG/YgOBvYOfb3T2vdBNvGZGwcw5rg
	SpbL+wGf0OFmNp7XWOl7cHCKwlL/TXhTgKF6ns9fdAv1XhQuNuFzXpRhzOkT6qh3LnIBb9wd5m1
	tdaEZWXazS0VoG6ZFaJfeP+oRMv5TmJbb+88EqZtkexyiKS9DCvycIuawnPcYdqD1kzOasijaD/
	YQMUcsZt+1oql7mU1Y8nzllzJ30lZKrcMERSPoLjyHgLkb4BIU4j/v90xt0iAwjjQ4AH84aIgHQ
	mcRbG3GjwJ0W13vieqGh5nltIpYS679McOkXBTKSWEhdnGcefTJ7RU+NefzG2ek7gAc6g8c+boG
	72uxVpGBzR7DeTdH4AEA9EsUPz1dIV/mYTI4tleWC6r65BUmNirv51wV16cTYojhr/WfgG3G2N/
	bb48P2afu3vLmRtxElC72vLxXAVeS5VQHbMSMLrCXjeJoQm0FSSJQkTUqXP6vKm1r/P2hqBwr04
	ZNjQ+XryK53hVjQ2QNx/H5NYPJbtuWxTUnFfisgPBRpP8llcuzmPGfxd+xziLHxMYid0cMqj09E
	dte+CQ==
X-Received: by 2002:a05:6870:ebc7:b0:48f:e0f6:bd65 with SMTP id 586e51a60fabf-4a757b88c1dmr5631610fac.54.1792416176872;
        Mon, 19 Oct 2026 06:22:56 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:41::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a73b2dc362sm8863847fac.2.2026.10.19.06.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 06:22:54 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 16/16] selftests/bpf: Test an arena kfunc argument passed from a subprogram
Date: Mon, 19 Oct 2026 15:21:58 +0200
Message-ID: <20261019132203.3034698-17-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261019132203.3034698-1-memxor@gmail.com>
References: <20261019132203.3034698-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2464; h=from:subject; bh=tzw+aCcv3UQYtzkDQiX9ynkaGvSmqn6LNADjaXtYzwQ=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIeuaxDHbZ46/srNkLbYvluK67blw47SYPXXHHE0eVHFZt0hr iKl0lLIwiHExyIopspT838dkfKLyd6DtMm6YOaxMIEMYuDgFYCJlaxj+Rz3odVT2Oxui8Di4W+7m/n faQs4MkUe2vWKNN5S+wbBMiZHhR11i2vXSNg2NZdqni7numV1adf/imwLTsDd7rwl0PJ/AAQA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Call a kfunc with an __arena argument from a global subprogram that does
nothing else with the arena, the address arrives as a number and no cast
is involved. The subprogram needs the arena base set up by its own
prologue for the JIT to rebase the argument, which the BPF CI review
found was not recorded for it.

Pass a NULL constant to a nullable __arena kfunc argument as well, from
a program that touches the arena nowhere else. The verifier takes its
early exit for a NULL argument, but the JIT rebases the call like any
other, behind the NULL test the function model asks for, so the arena
base has to be set up for that call alone.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../testing/selftests/bpf/progs/arena_kfunc.c | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/arena_kfunc.c b/tools/testing/selftests/bpf/progs/arena_kfunc.c
index a049d6371d09..5d1cb1a7e8ee 100644
--- a/tools/testing/selftests/bpf/progs/arena_kfunc.c
+++ b/tools/testing/selftests/bpf/progs/arena_kfunc.c
@@ -192,6 +192,57 @@ int arena_arg_unpopulated(void *ctx)
 	return 0;
 }
 
+/*
+ * A subprogram whose only arena use is the argument of a kfunc needs the
+ * arena base too, the JIT rebases the argument on it. The address arrives
+ * as a number, so no cast marks the subprogram either.
+ */
+__noinline int arena_arg_from_subprog(unsigned long addr)
+{
+	return bpf_kfunc_arena_arg_test((u64 *)addr) != 41;
+}
+
+/*
+ * A NULL constant for the __arena argument takes an early exit in the
+ * verifier; the call needs the arena base all the same, the JIT rebases
+ * the argument with a NULL test.
+ */
+SEC("syscall")
+__arch_x86_64
+__arch_arm64
+__success __retval(0)
+int arena_arg_null(void *ctx)
+{
+	return bpf_kfunc_arena_cap_nullable_test(NULL) != 0;
+}
+
+SEC("syscall")
+__arch_x86_64
+__arch_arm64
+__success __retval(0)
+int arena_arg_subprog(void *ctx)
+{
+#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
+	u64 __arena *val;
+	int ret;
+
+	val = bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
+	if (!val)
+		return 1;
+
+	*val = 41;
+	if (arena_arg_from_subprog((unsigned long)val))
+		ret = 2;
+	else
+		ret = *val != 42 ? 3 : 0;
+
+	bpf_arena_free_pages(&arena, (void __arena *)val, 1);
+	return ret;
+#else
+	return 0;
+#endif
+}
+
 SEC("syscall")
 __arch_x86_64
 __arch_arm64
-- 
2.53.0-Meta

