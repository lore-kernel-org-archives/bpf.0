Received: from mail-oo2-f10.google.com (mail-oo2-f10.google.com [74.125.231.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B073BFAE2
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 08:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791879666; cv=none; b=REJKUitQbIXU6WHKp2ajqX8f4s7YjC8ollxdj+zKVs3E3GNHUBz3ZJOoUqR1bpqyAQuWrfiL1VZsFCX43tUXffImGYgVwyeAvF6nHXc3DSX8LX9DhBUkyQJ+PWT35nOr6fDB2tb+oAoaXGWhk+wC1Vk1WiLHLw0mQXtpEDOm9Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791879666; c=relaxed/simple;
	bh=B283ZoQ46jXtPb1nErwk7HpiFi9Vg+W7a/Xv2uVS0Yw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qmFsa1jDe45F4KoO3dzz/Wi9f8MZuzO+bYwubBeDDl+LdfgnDfxiqnYGnAkEP40AsRPyFiXrN7FunmYDSFPsBWnjDnhfjZLzjD9dD9J4HXxfN+B0dcploILajBM6CYL5g9yZEs6Hz8eASjBbKYrsBuNlplFZN8ync0QnZ9lo/OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fwLvBaPq; arc=none smtp.client-ip=74.125.231.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fwLvBaPq"
Received: by mail-oo2-f10.google.com with SMTP id 006d021491bc7-6dd3bb640bcso125163eaf.0
        for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 01:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791879664; x=1792484464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1H9q9Cb+06dGbmwf8nVRSRSWZ6oCNpSfX3dTjyQBe/M=;
        b=fwLvBaPqN2Sm9F50U2o0pAcT8DvOu1tP9g+4dsBujTv3Z8J3dkFHxvHMqVBTDQMtB/
         h/D2IavHNCv7CHqJ3zPG9+/ahVKmmNuL7vx5LVgQnuyIWipkdULWlhQ15By5HDki8cWm
         RO9TkSWN58PXIuEyAVlLxmkG0gjz4lJCTG90O/nudXm45lY89GpQaMkyOVTKd+5Fl3Kf
         dLANLpAAOExhrzsFCa2BLHflgO/tpHoVwrLJlKIGG48KbkfceJtbCW6Naxw286ZFVxYh
         1ZSzt3VztWZYsVtxjBgD1T6lRpD5uPxUeJ6JaOpjAa9s41Qi3nOUYyHHqFlQrBMZTIuu
         PsWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791879664; x=1792484464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1H9q9Cb+06dGbmwf8nVRSRSWZ6oCNpSfX3dTjyQBe/M=;
        b=T0E3SYd8ReBV3OHQaarMaXBG5cAt4J2to56LLhP8yC9WVHA2EZfxE3OnbQdpwb8R1j
         2jXCfdNDTULYF8zsMFR1iGbYgghHKMKzpVV9oNe3mJEl66dYm7V7BOz24oF7fb5aR64I
         bOFTeRzmj3N2v/FFFRA81crl6EddJwinAPQ9c8j8ABuCPi9LAkWXniqXEk3SAQXurq7p
         ZKvrDwIqI4m1LJIoVFxZQ89mCkp6XCHDYLr+dGVmeSg8IQMQBYFRDn+FVkdWHi3UwrgE
         DFulRhGGZAsvlGuZW+1kY40078GD2AZo8+rcgDvFfUUoXdXKwbELIx3+sr+8RHa4Wo+M
         vxEw==
X-Gm-Message-State: AFq9FYIH0vmb09+HcrAQ+G1qyi0UaZgho7JcV7RYDjd7H2NR89RXwxww
	3AKic8S3RW9Gyszsvv55znwR64Wj9TIuE5hlFv6KdfDr7GryPzK+bkERUjcLMi+sjxE=
X-Gm-Gg: AYBFou0Wh2sm81UmD488krYAsMBqTSdowP67+2Z1FUs0qCKTFT92360vMpyhPtj7+4/
	ERYZ25wjv+I6bpH7ulT53QfjwcL5kxzovTosILt7xwMQfhMPwiaPIrzdY2XtF8BfjZmQA8Y+wDT
	kh6mDIK5sXD45B14T5Cmzi8sK7JVCXtygmuA0EzfJ83BO7F2LssfGasdCkdMiRx8hk6kd6MGWUu
	oUniQqf+xkJsXv2U0zcns3x5gHJBHIe2vkrq42941lPQSWDz+I5TM8dpAY3I8NXIngZGpWxiYKr
	Qe5zwh//tRVXnG45RGq9lTQ1LtftMZecDnqc3dwycf4KeNS2LHNJ+Goooin/SHCFivC41IhQKs5
	+fgSYknyG9nPqXzk/xVuNniABqgJwcJXL6hTGhUg6EfANagFU1+5xSFwUhtWV2fC96h7KAiRHrW
	BJuCVtMJvEk7+rl7GH7fpbPt2ouZprqZLPJPvJWTHHQ2En6ENQ6IePha8X6VQ1lhplsEjgkQYu0
	5ZDeyd9VhNZIIo5E04s1TZAmlKuBtIVrQO5oVdruZS5PeTlJRL5IfZ2qkDXW1nO4Jux2kkbyfeF
	Yx9oHg==
X-Received: by 2002:a05:6820:f034:b0:6f8:2e98:cfd7 with SMTP id 006d021491bc7-6f82e98eea5mr2321230eaf.9.1791879664188;
        Tue, 13 Oct 2026 01:21:04 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:5a::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6f85a9e6783sm2656397eaf.7.2026.10.13.01.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 01:21:02 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 13/13] selftests/bpf: Test an arena kfunc argument passed from a subprogram
Date: Tue, 13 Oct 2026 10:20:08 +0200
Message-ID: <20261013082012.1107446-14-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013082012.1107446-1-memxor@gmail.com>
References: <20261013082012.1107446-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1766; h=from:subject; bh=B283ZoQ46jXtPb1nErwk7HpiFi9Vg+W7a/Xv2uVS0Yw=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIevsy/mBC9NM7qsGyz76d2vBCb3ouQFagsL6ds1Tmvhsg06c 0ZLvKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZQIYwcHEKwETexTH8T0mu+PpKucAk/1tisIuIYy TP+3IbtkzHhEXb37Wsm928ipFhxsvOIOdM1t8/X6yZvOkaX8CJtIts8VN41A/vz391vFCPFQA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Call a kfunc with an __arena argument from a global subprogram that does
nothing else with the arena, the address arrives as a number and no cast
is involved. The subprogram needs the arena base set up by its own
prologue for the JIT to rebase the argument, which the BPF CI review
found was not recorded for it.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../testing/selftests/bpf/progs/arena_kfunc.c | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/arena_kfunc.c b/tools/testing/selftests/bpf/progs/arena_kfunc.c
index a049d6371d09..168ae8d7e303 100644
--- a/tools/testing/selftests/bpf/progs/arena_kfunc.c
+++ b/tools/testing/selftests/bpf/progs/arena_kfunc.c
@@ -192,6 +192,43 @@ int arena_arg_unpopulated(void *ctx)
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

