Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C324D1F63D9
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 00:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788566791; cv=none; b=iGAP+1C1fBELxpiqfL7DnoW9b+ru5hey2PV/yB0Ck8HYM0U2evI25UrGlzgT5LYJ7IC7zqZiFUbpIFXdE5dk07bNRpacikCaHzDecGoVyWJm//RtBRlby4Wxxnqzi/C/eaMtp3L8dhJQEyOUO3TXfbI5c+AEK+ZGPoxIhJb8OPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788566791; c=relaxed/simple;
	bh=S5yWdpxdcoC8xP6XR7CSYpzCn2QoQREwUyHV7Ezq5rM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SL1L9nf31DkpxXlXKFnl9kinl3JHzzxQPGfdBL7eSPiTU/BEzNHAOquYQDyIMe1Vy8QbtTobbRAm/e5eyBgp+SJY2PyhO/w/8VyNP+ZXu2vjDfd+o6OfJw/gqBScY2UG3vpEcW9gJjpN3yXE+bNTn7XYgHOFN+5rVbAoiwa9hI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A4jPvPjO; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4jPvPjO"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2d7195706f1so18468215ad.0
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 17:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788566788; x=1789171588; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=txaqAakfNddvYya3czBdZcai8iNS3RM9FQDzWM8dw/g=;
        b=A4jPvPjO2kWCtM0tKdYKS2Wn9TgMDBxbkBkVadeHGnWzFjY3ITndAIvFcMaihO8Apt
         1zFwHoinxLEmV82l0j4oHln5exuFmd4BlaUBFaZ5TPtEneR6W7JdhfLP0f29h0NkmaXi
         QYwkgGdEYWdRsVawqSUZok4J8i0WrFwEnMxieOGunssAbpjJV5OoMxspFMLEXN3fnERk
         H/pEQf1vBTRrI69CJohgL5gNSFcgKugPE5Q4HKYHQrkwgqMedoo363z2mDpwhwtymYF+
         GFS9tyvtMazCKRnTCGNSV0R/XfvpmbzwAlcBOCpjYrCFMeLr46lcr/yEm/Xuuj4X6eOs
         otsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788566788; x=1789171588;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=txaqAakfNddvYya3czBdZcai8iNS3RM9FQDzWM8dw/g=;
        b=CROWXx35Ow7cKo7l4aBvV8AdVstxND4ojPDRxIFMhoicfgf/jteUkuoxBICU/fxDNp
         cihuL0PHwIdn51OB+ve2oVWdUHc10IW1zNEQ0Ecb08vNxWBXD4a6lVeFKJYWu+nuO1Sn
         QIPD+KRMsHaCdLR8EhnB8FcNQeAtEz7MxVQ/IpncomDtjUfeo5DeOBOgklKIH02fxRRO
         rkSp44uWrtddv5io/TujpGK/GCuL2F40e/s0NuSeMxZOmbDExc/2GsYysg9JOCUczNpn
         eHUUn8FKpne0GdnOcJ08MxIkKfIya4LuiPLs08zSs5QQx0Es2u1y9zUQr6vwn/h/kINd
         P58A==
X-Gm-Message-State: AFuF++m0AgkpZGPgCsT18ur24rVt23pGn85K57nbc/OsSKx5eYQ1SeLv
	oTP9U2Y9F/v2eXevrFdG/yl2t07lIKaN8ThquxS6dB5bNYuXqcQl7iBRoZuQBPyAGtg=
X-Gm-Gg: AYBFou0Hy26A9c+oSZrE/gy2xM2c0l51xIUc/b0vKCU8H+gft4sOV2aLY0XhZpwyAbh
	8XC8r1vlKW8smosOL6TJX43UatIvM1Uj8xhnX9x6I5LX6WTduc+bDvI3+p9cALZ+n1Ivm7UOjYP
	QWXieGz/ruMHoaN/DLsh8jpvi5Jl7jWOf0XHWHYtnUU+/wgQoqdbTX1Ea3fkE/xNHiGUK1zBndc
	R4b3Er4oDhbTqN2LrpNZmxiMbSQvGDEA7iDHv0MvFtApDkcj7FUzOyNnItxa+lgaq9ZTpSdhVgx
	mH/shjlVMbwduCHLf39xsWograpAURrl2UBg4LWvw8Hy2vS2BEkv0mFX/oCSbw3lCQ58scBjvTL
	oOkKptKiN2ONAG/VRvBsCwdo1YLdBEMtG7dwayrAz/I+c1hpNBB8QuBXTocll48LbDqm1l+NY4B
	NtOERuPKygQ0C+al2E6o6Gy6XdiXsyGI5zaelpCy3hVXCl4mgjnkV98jnQYTcT9FdeDq600bS8Z
	Fzs/MJT/BwX9/GVV0gIX1A2PPi65iiZUxOJPUeg8Yk/dF48SfnwxCJI6g==
X-Received: by 2002:a17:90a:e7c2:b0:398:9be8:ea66 with SMTP id 98e67ed59e1d1-39b261da126mr13107535a91.19.1788566787942;
        Fri, 04 Sep 2026 17:06:27 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::5:4f3d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3356dc5c04dsm42277eec.8.2026.09.04.17.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 17:06:27 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 08/10] selftests/bpf: precision of a NULL global subprogram BTF_ID argument
Date: Fri,  4 Sep 2026 17:05:59 -0700
Message-ID: <20260904-register-is-null-precise-fixes-v1-8-0f5a360ff15d@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904-register-is-null-precise-fixes-v1-0-0f5a360ff15d@gmail.com>
References: <20260904-register-is-null-precise-fixes-v1-0-0f5a360ff15d@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Check that mark_chain_precision() is called for a NULL pointer passed
as an __arg_trusted __arg_nullable argument of a global subprogram.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/progs/verifier_global_ptr_args.c | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c b/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c
index 0bdeb7bc4687..a3d2af8dc839 100644
--- a/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c
+++ b/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c
@@ -56,6 +56,30 @@ int trusted_task_arg_nullable(void *ctx)
 	return res;
 }
 
+/*
+ * Check that the verifier does not use checkpoints created
+ * on path with r1 == 0 to prune path with r1 != 0.
+ */
+SEC("?tp_btf/task_newtask")
+__failure
+__flag(BPF_F_TEST_STATE_FREQ)
+__msg("R1 type=scalar expected=ptr_, trusted_ptr_, rcu_ptr_")
+__naked int null_btf_id_arg_global_subprog(void)
+{
+	asm volatile (
+		"call %[bpf_get_prandom_u32];"
+		"r1 = 42;"
+		"if r0 > 42 goto 1f;"
+		"r1 = 0;"
+	"1:"
+		"call subprog_trusted_task_nullable;"
+		"r0 = 0;"
+		"exit;"
+		:
+		: __imm(bpf_get_prandom_u32)
+		: __clobber_all);
+}
+
 __weak int subprog_trusted_task_nonnull(struct task_struct *task __arg_trusted)
 {
 	return task->pid + task->tgid;

-- 
2.55.0
