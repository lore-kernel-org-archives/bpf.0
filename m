Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D77A326945
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 04:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775190446; cv=none; b=k8mRWp9OTWboDhE+wOMNKEN1Vd5Gw/CZdwtGrZPd3bjuKTCH9ot5C1CdLtqEfF4OWdiTYwBVm2TGW1pKeEIJFYMJfzuGw0Rplxnf6hKhbn4aHT+T7Q3lzXnySBXZwcz96FbeQVLpogMqJpsK57ypnFlbRQL1uRQoVuJkKLjDDsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775190446; c=relaxed/simple;
	bh=Jp+qWl7MjfERqb+qv4yHqFvGnmGRSI86ZEnUNGUllTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o/2EIWzH0VoUGfB8czCRKYH6XMKp+ppnEt7ZDuc15A12wEsLYXtOuBv7ufJh8y5K6CIGhOd3fD7qCyk2bTAgd2qtqNBm6XrPVkqu2ituWH2QGzjG8xFI9RIyv+UZigQT5B+d8Gw/9V8IdczDyca3Qrupqi/7otvyLFaHCq+cJXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=GN0XnMaU; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="GN0XnMaU"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-35dac556bb2so966338a91.1
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 21:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1775190445; x=1775795245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HOtGEiNCtHMGy+Dnwx1a5ApXy3TuuqimA36tae646ac=;
        b=GN0XnMaUENqTtFFTYAKq91+gEFYfQY3/7HDkstACR+fLsiVcP2+0W7Iv/LsolDEgZP
         su2jFhJE09pMjUIwaRJkhOVd0ZWabmpGqIuIzSjozODVKhgHmOJ8PAKF3QB9G3kMWp7I
         7wM+S3vtJf4PbhQ9eo2Jl4ERwA+ipXzGdRkCDJB7+5XEabQX3aQAZWxNACmryUlbWUL6
         cfIDowflajxFe7vOSx3soibKddU7/mUoDJ1Q1Li/ECn350QkdRJT6ui1YGFNaufVDbAS
         l8PUttLCvltqg2eWciHvuiqfNQH13DQ/5VhXC+89jX+9n5icZqKJuJsb+FU0beiP8uPq
         3dgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775190445; x=1775795245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HOtGEiNCtHMGy+Dnwx1a5ApXy3TuuqimA36tae646ac=;
        b=jRRuzs6F5ztQaKJtBuJ7rK4+PfVYf9nxqLDip2z4dkhuRpxmmJqpdQWPqNBSgbpve8
         ax4uN+rdnNG8jkskmtpOL7/evlhc6kYEtGgJi5LCwKbl3YQ9jUln54pPSbPxLypfneZn
         ppNRFb0wibD4O9P5HZzNQ1psnLrUtXRvDf3LSROp7jDuihELviGNAlSWZZC2UsQwZ6Dm
         3gqG395wvNvXLyTzt95ww7n87wxUM74GAYlD9746qCEvh542e83pkjusv9ZLGsK+ywQ3
         6Vttv3dT3EEJYrNguZGatq7FL3Y31LiBfAt177eJYqT4TdE7KCE9fSy+jP8cE3Ysi1vR
         iE5w==
X-Gm-Message-State: AOJu0YydtZXTqhC/nNuyIg9E16VE6XtEJnBfuk4Je+9LkIsqr3W3jsqT
	k+5tUjkfo0zdFGBG8IWdDcqCMuCJWaEF/pbufs/dEEV19IrQ3MWOJq9/ipT2OMnDrrbqaXsZlun
	AZwHRtzn5FA==
X-Gm-Gg: AeBDietS5A7+wDa1BjMrAGXT6wyheU6EykFbrj5GJTC9xVn6WUY4jM8AklUfePwom34
	9m5ruge8hPpAwCHkr01pVbXCE7vJvcdYDloVUQbi8o7U3IjGHNfvlm1i58xnT5R6EILYuJIIGvr
	4+6FZX+zM+MMqBBu65HHGf/OexwktLZ59i01+kCEBaMWFzLkPIrvhSPHo/wV81sUCJFnIfAjEzl
	xK1YpRHJOmnRqSrNYu5ZC0+8v4yRYsWB8IXXPwDv6F2XS4J/v7MZhj9SAQ97sUs5qYapxiW719o
	3HnKqJbe01WMfkMtWSl5ajKwvAZ1Exyo2qRhOxEizcuQSYcYdhp9jUOWwRtJeFkLd3YXY9G0vCs
	WUJdmITKHfdCf99WiYq3rC/wvEkxdhFrhyqXJ5WT+cghV8vGzCoSy713eHKwBWSaudKYKpTMObD
	sGCw==
X-Received: by 2002:a17:90b:4fc4:b0:35d:a374:b385 with SMTP id 98e67ed59e1d1-35de6a1951bmr1240051a91.29.1775190444616;
        Thu, 02 Apr 2026 21:27:24 -0700 (PDT)
Received: from krios ([2604:3d08:487d:cd00::5517])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe937925sm12970449a91.12.2026.04.02.21.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 21:27:24 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	Emil Tsalapatis <etsal@meta.com>,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v3 2/9] selftests/bpf: Add test for scalar/arena pointer addition
Date: Fri,  3 Apr 2026 00:27:13 -0400
Message-ID: <20260403042720.18862-3-emil@etsalapatis.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260403042720.18862-1-emil@etsalapatis.com>
References: <20260403042720.18862-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Emil Tsalapatis <etsal@meta.com>

Add a selftest that ensures scalar += ptr_to_arena instructions
are accepted by the verifier.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 .../selftests/bpf/progs/verifier_arena.c      | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_arena.c b/tools/testing/selftests/bpf/progs/verifier_arena.c
index c4b8daac4388..450e8f1181cd 100644
--- a/tools/testing/selftests/bpf/progs/verifier_arena.c
+++ b/tools/testing/selftests/bpf/progs/verifier_arena.c
@@ -477,4 +477,33 @@ int arena_kfuncs_under_bpf_lock(void *ctx)
 
 	return 0;
 }
+/*
+ * Test that scalar += PTR_TO_ARENA correctly upgrades the
+ * destination register to a PTR_TO_ARENA.
+ */
+SEC("syscall")
+__success __retval(0)
+int scalar_add_arena_ptr(void *ctx)
+{
+#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
+	int __arena *result, *arena_ptr;
+
+	/* Needed for the verifier to link the arena to the subprog. */
+	volatile char __arena *base = arena_base(&arena);
+
+	/* Passing base here to avoid optimizing it out during compilation. */
+	asm volatile (
+		"%[arena_ptr] = 8192;"
+		"%[arena_ptr] = addr_space_cast(%[arena_ptr], 0x0, 0x1);"
+		"%[result] = 12;"
+		"%[result] += %[arena_ptr];"
+		: [result] "=r"(result),
+		  [arena_ptr] "=&r"(arena_ptr)
+		: "r"(base)
+		:
+	);
+#endif
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.53.0

