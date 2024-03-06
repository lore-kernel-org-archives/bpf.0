Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD306089F
	for <bpf@vger.kernel.org>; Wed,  6 Mar 2024 10:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709721960; cv=none; b=SbdbcEV96yi4kvhEn7b4RXJAqneODZbJXD5bNiI5SFA0G9o8vD0SH6tkTyI7yOKLcaOcnLnX9V0wZPmMCCTP0U2dI5cVfsXc7Rr7225VaUP7SrGTgtWSA2p4PwQBtN2ub4+xuEVCpv8+AQkTO6XDT6D01XYtz0nHOp1YjEKZWJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709721960; c=relaxed/simple;
	bh=qq8YY5adS+/Dj50g3xdUaXj0dVPqjGcPBsacABXu0nA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oV+b2BxOnQvGbcceLiMO6sAOeVJeK7MTY75QNuP7S81WFsAV5/g+1vLvkIbNlsi+fcUJI0gnxmAykcsChgqjYgvA7z/4iutEb4EAQW95IzSgv0Akt7n+R0bZb6elmGwIM6Jfd02APHHKfDYYOdkhy4hTioaqJCwzSo/Njw/RJKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X9/5xrti; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X9/5xrti"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d3b93e992aso43270041fa.1
        for <bpf@vger.kernel.org>; Wed, 06 Mar 2024 02:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709721957; x=1710326757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zV5iorLT4bPhioadrT3z62waasJmp7yXKBZpS5NIkKQ=;
        b=X9/5xrtiybAt3g+9wqQSJ79XgBQhj33yhfYqXSZMF6RZ9/GxaYtYcaGAF0kEW8sz5w
         YlBYeVxJV69XYOEV5Uzd9Kq5x2Hh5BT2WMaQU/sw3pcrYp6nNJw74hgCjws+dU4vo+h6
         cKjHwhsDllc5PLUEAPkWQKSxZjAfhFm5d2LW7Z5dWnosCArAEyZKR9+IxRXx7UWUh8Ik
         CMIY+4YKx1Zg0s6HSYkOXVa9pbl2AUWeUDphUJZd6JpkYFIoGfNsGV9s449hsJqkcWEH
         V2AKZ1gfCD8sep0w4AXGPlmpJJPJG+ccp5G1uBfUV+e4olD4HjawgMO0Y8/j+W+rrf7u
         PhoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709721957; x=1710326757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zV5iorLT4bPhioadrT3z62waasJmp7yXKBZpS5NIkKQ=;
        b=ay9Ukvgh7abJj5aeojy1C+c5VmMQ4LMt8/Yr29ZmkLBrC/zvkPRIc8PAdcoL3thudG
         jgmm8mXZB2Lr2jzKz7CaRaS/BuSTR3xgKbOv3THqJVnlArcEhsTm+Qyy19WaZgPPNK4a
         rPxixsedtRjscIzZ+/bOEO2UU+4DCwW/fL73fKzuoWuC6151v8YOH8KR32VY5cMOtOkm
         DkLI+jsmMKx9FafdWuVOAIopm7J9umtIBv6PqPJt414px5cILiTtYxFx19o/MtiGENGh
         ddrt+WIptO9JjtjFW0PiZhR2JHCKAnOFun9+eigLpuBgsPhBmhDavQWM9b4uaI5Ve25L
         BpIQ==
X-Gm-Message-State: AOJu0YxcNquH8SPlt7SfkV3sz2jwm9zeXJHwPWFs9u0ME8d4IXIT4LOg
	gwmVqY+FWtUzHPDQOJ5Syk7DT5s0DREN4NewLJoujpciCJrfAmBCHz5A8dQp
X-Google-Smtp-Source: AGHT+IE4M9KzztvTNKt/DJlHSfxkT37cNtdjM/4inIWBHQV/hkXDC9Q8dlNyRiW8jVvqe3ynfIyX4w==
X-Received: by 2002:a05:6512:3593:b0:513:5541:e5d9 with SMTP id m19-20020a056512359300b005135541e5d9mr2103567lfr.18.1709721956841;
        Wed, 06 Mar 2024 02:45:56 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id h20-20020a170906591400b00a3d5efc65e0sm7002450ejq.91.2024.03.06.02.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 02:45:56 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	void@manifault.com,
	sinquersw@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v4 15/15] selftests/bpf: test cases for '?' in BTF names
Date: Wed,  6 Mar 2024 12:45:29 +0200
Message-ID: <20240306104529.6453-16-eddyz87@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240306104529.6453-1-eddyz87@gmail.com>
References: <20240306104529.6453-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two test cases to verify that '?' and other printable characters are
allowed in BTF DATASEC names:
- DATASEC with name "?.foo bar:buz" should be accepted;
- type with name "?foo" should be rejected.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/btf.c | 29 ++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
index 816145bcb647..00965a6e83bb 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -3535,6 +3535,32 @@ static struct btf_raw_test raw_tests[] = {
 	.value_type_id = 1,
 	.max_entries = 1,
 },
+{
+	.descr = "datasec: name '?.foo bar:buz' is ok",
+	.raw_types = {
+		/* int */
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),  /* [1] */
+		/* VAR x */                                     /* [2] */
+		BTF_TYPE_ENC(1, BTF_INFO_ENC(BTF_KIND_VAR, 0, 0), 1),
+		BTF_VAR_STATIC,
+		/* DATASEC ?.data */                            /* [3] */
+		BTF_TYPE_ENC(3, BTF_INFO_ENC(BTF_KIND_DATASEC, 0, 1), 4),
+		BTF_VAR_SECINFO_ENC(2, 0, 4),
+		BTF_END_RAW,
+	},
+	BTF_STR_SEC("\0x\0?.foo bar:buz"),
+},
+{
+	.descr = "type name '?foo' is not ok",
+	.raw_types = {
+		/* union ?foo; */
+		BTF_TYPE_ENC(1, BTF_INFO_ENC(BTF_KIND_FWD, 1, 0), 0), /* [1] */
+		BTF_END_RAW,
+	},
+	BTF_STR_SEC("\0?foo"),
+	.err_str = "Invalid name",
+	.btf_load_err = true,
+},
 
 {
 	.descr = "float test #1, well-formed",
@@ -4363,6 +4389,9 @@ static void do_test_raw(unsigned int test_num)
 	if (err || btf_fd < 0)
 		goto done;
 
+	if (!test->map_type)
+		goto done;
+
 	opts.btf_fd = btf_fd;
 	opts.btf_key_type_id = test->key_type_id;
 	opts.btf_value_type_id = test->value_type_id;
-- 
2.43.0

