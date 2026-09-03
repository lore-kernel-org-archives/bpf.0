Received: from mail-wr2-f11.google.com (mail-wr2-f11.google.com [74.125.225.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24CF4BAA0A
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 14:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788446693; cv=none; b=OtuzxqG4O9JIJgW7P8pngwbw+vXya6K4RJvAQePOQmCj9P5t9XnPON5bSUurRSMOkg1vCQPnLakHCGbxaCns/iv16bQsPgxyPgF+73Z6wdi9Lg0ij1O/j7Tg1SmgIU81O3ZuuVboSGBD1z66gPiHqGQGThFw1yJE5vgRdw+IVlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788446693; c=relaxed/simple;
	bh=znNSuUrZpExpzNPsE2AnVH4U0e46fPjr+cGpz59xuzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s+QNCk02Z7v5fbcSugsfza+WhEH3WC6yCtsGO3sSMprTKRS6L6mqeo36Y4V5tqJGViXYESwikgTcijQsIgChFCZ0VMBg6noZB61O8L5noRvmmeQcIsrCFZsobbAXZQ7ddIf3EzhML3OPhL6namGdcDcj/Go9HWsTuGHG+VNcWmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Irep71ct; arc=none smtp.client-ip=74.125.225.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Irep71ct"
Received: by mail-wr2-f11.google.com with SMTP id ffacd0b85a97d-482e61db882so556828f8f.0
        for <bpf@vger.kernel.org>; Thu, 03 Sep 2026 07:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788446690; x=1789051490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MvP/S1My067lRHfc9pJ9h8O1yHFnPqUWVKKTZsqCgz4=;
        b=Irep71ctt8qG4uPjapswpZS2P5GQcyPojeXH2QciDXqt/7N5gbYqk3/BG5e3qbHgyB
         LZCOtzbRw1+iOwAEpNN/i1VM1DFEELMN6v5cywrTFhhCga/d8FAT4BgDSXOznya1JIBo
         PXV48VrUvhBJ6i0/CiSv/xMDw3OVTxqIfC3v4YrMR6S0NyA5Vh3asQZXZnIZGZlPuDAh
         JNVIH1HTYSXI/vvNZAX1mnbMjzqmiPaXUqSARPdFRAm6ZOfg4hFf/YSO6Cht2Qi2xwAA
         3s7t7Snr0HVlZ3kmj5l9puht8hLfxNALMy+lSahHSsg5TsPTU22YDjisRlKoS6qR4vOp
         h5lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788446690; x=1789051490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MvP/S1My067lRHfc9pJ9h8O1yHFnPqUWVKKTZsqCgz4=;
        b=AKVy0hjq1fY5n1vU4lrdC9fo/QUfQGCziVKp5gA/AMvdo0lZs+7C3BVyzHUUTC0YOi
         Vy0g1hqyR3cTKzTspbH3vYAEYycvz7T5eLa0AutfkpgVxfjgSCNVg6TH0phrp6/3NIYf
         ziQ3kxyHzbRu9sAzI0DduzxrMlwTdGtdniL8G4+4PZ+FBU9Wgv4lPklhufhpVnOQUeHL
         X7sYBuz+uD5ZlmO7wtXKnGkFicfeN9/Lj170NwnOOi6JdxpJ8DhCtgr0QjxHFmekdsCH
         ghSwSUXIUCHFVtkSgCQOap9yuF4EMMaIx6lV4TdAEkbVfBMzIRjC0Yj4FV/L+F2udjCA
         CIuA==
X-Gm-Message-State: AFuF++k14tBAf7J0bCAhv8bmyaGq6jZOkzBT1pQzYXRwSSB+vq3NLAoP
	kUt1k1uEQSPDNZBe87u4OvxQ7UGATMP+zvcUyKTwMtQ3z+uewAsK5sYLBKHV2fe7
X-Gm-Gg: AYBFou3ypq3P9jWwFvcqoifTynlzBJzT7ANSgb+Ih2Be8E8uXY84oYTKMR4l7DQYQqG
	967XYmXYzGVpsw0Daljto2t7n3n+tjTsppQR6u36hqjiqwKch0mk2vkfk2ooAZah6czXDjNWys5
	dslE5ekFo402zk1rAw4uBMUFFQMvlwHMwKadSnTXQLiBlSyVPPZm7ONQbMaDHf4weOtjRbXzTaE
	UYQ01MpslNMtM5vue8Kz5XzirRv1ByMOwf47+6e118iNwCEHB7r3VT9v6RmPdMhCUYJpbO6tb5i
	mHExGrI6IFH6Gv7lFKAuIasYiNtyj4BCPIsSxZyWwGZEGJnMTyywV37F9BTrkjqz2RE1oHvve2c
	+uEkIx2D9b1OBO64ka7m4PezAprlHVZAEY+dHoV4hhdHqVhoWpvTMh0UPk4I0lC8YrifdoprT7x
	RqBvhLTQVgr/qkyXBTZDlLWHhB1HwXqGUk/7LmyKee7EtgQH6KjIWRTfZs9cQeMm7ny4aMcaMiq
	lVPRlsMDewQNqjH7JIPt8roGPlQ/6dNlmJ3Yn5opj2CD/CVyPgHDBD9p7s6PHTzPApT1ONjsxih
	6jKdsdkqbEcybCYKDQORaiDvQlNMbsX0Op01pw==
X-Received: by 2002:a05:6000:601:b0:484:36c8:ffb9 with SMTP id ffacd0b85a97d-48586022058mr1772005f8f.4.1788446689324;
        Thu, 03 Sep 2026 07:44:49 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448ee9cf7sm15184911f8f.25.2026.09.03.07.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 07:44:48 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v1 08/10] selftests/bpf: Test sched_process_wait nullable argument
Date: Thu,  3 Sep 2026 16:44:26 +0200
Message-ID: <20260903144433.1716731-9-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903144433.1716731-1-memxor@gmail.com>
References: <20260903144433.1716731-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1616; i=memxor@gmail.com; h=from:subject; bh=znNSuUrZpExpzNPsE2AnVH4U0e46fPjr+cGpz59xuzw=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWtm8ySL4CubMtr65pUxWvCurQg6p/1EcKq78cEs37O3P StfbprRUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgIkUnmH4X7s8tM+u9oRulkBq 9dLPvEVH74av3axypivn7r7dJUZzGhkZZstGT09WF/Oo3rpDSbp9oavk4zbfz2ebtxfLt9/4bmf ADQA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Add a load-time verifier test that dereferences argument 0 of the
sched_process_wait tp_btf program without checking it. The test expects the
nullable-pointer diagnostic, so it is accepted unexpectedly before the fix
and rejected as expected after it.

Add a successful control that checks the argument for NULL before the
dereference. This ensures the nullable marking preserves legitimate access
to the pid when the tracepoint supplies one.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/progs/raw_tp_null_fail.c      | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/raw_tp_null_fail.c b/tools/testing/selftests/bpf/progs/raw_tp_null_fail.c
index 7e8842bf9000..725d73c9ffe1 100644
--- a/tools/testing/selftests/bpf/progs/raw_tp_null_fail.c
+++ b/tools/testing/selftests/bpf/progs/raw_tp_null_fail.c
@@ -58,3 +58,20 @@ int test_tp_btf_signal_deliver_info_no_deref(void *ctx)
 	asm volatile("r1 = *(u64 *)(r1 +8); r1 = *(u32 *)(r1 +0);" ::: __clobber_all);
 	return 0;
 }
+
+SEC("tp_btf/sched_process_wait")
+__failure __msg("R1 invalid mem access 'trusted_ptr_or_null_'")
+int test_raw_tp_null_sched_process_wait_arg_1(void *ctx)
+{
+	asm volatile("r1 = *(u64 *)(r1 +0); r1 = *(u32 *)(r1 +0);" ::: __clobber_all);
+	return 0;
+}
+
+SEC("tp_btf/sched_process_wait")
+__success
+int test_raw_tp_null_sched_process_wait_arg_1_checked(void *ctx)
+{
+	asm volatile("r1 = *(u64 *)(r1 +0); if r1 == 0 goto +1; "
+		     "r1 = *(u32 *)(r1 +0);" ::: __clobber_all);
+	return 0;
+}
-- 
2.53.0

