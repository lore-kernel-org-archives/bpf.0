Received: from mail-pj2-f40.google.com (mail-pj2-f40.google.com [74.125.227.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE2C468C2F
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 12:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790945262; cv=none; b=RykS+qsPkI4oH7aNFgMo/FVenGoQvAbF0vUaC1m3Eiyh3IneSVvpDP3kq5Ku3ekqPeR+SE3y406A7RU4qQz239QHL5XsQbMTPQmBCVzB8m0dalX9OyKs+XahYXYDneq09+OpPvWd57OeusncA0FLyCo0S81djUyVVIj7k+4U4iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790945262; c=relaxed/simple;
	bh=7J3ugRCRGKYuMR6xOr0bLmQBBn3P8HFWCX8gRtgaaxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JCVb/xHdOAK3/XX2EZOZ05u+eA6EARJCvGdU9ZDFyUuxKZUOEOvWyf5WBdZLd6TAFczUieajo1AAjsZnXkLZPDUrjA/5xZ0PNbHUKgqmZive46AegbFQNguXA9BRw4YCGreYfGJDrVtH2ppGoHe3GyHSpyJtNDIL5iDmo/Sio1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WWh2LFz7; arc=none smtp.client-ip=74.125.227.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WWh2LFz7"
Received: by mail-pj2-f40.google.com with SMTP id d9443c01a7336-2e494adf48dso7063835ad.0
        for <bpf@vger.kernel.org>; Fri, 02 Oct 2026 05:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790945260; x=1791550060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+H7dDg+VjKEy03nAKa1G4ZyPKSG2FvhZXWUH21ZzuiQ=;
        b=WWh2LFz7LP2Vv4h6mRh5rIaUkvbzjNA85eW5punVKOckqGin1wLQxp3kQyEDt9On11
         J49KSJ3M6ukGG6QF99Nu5fMMlgfFYDe5WtHEdBm9GiyZBBXIXEznoJpd5d9tZQz7zmgB
         ZFUqMRzCQF6Wt422546RYkiFXI9gWlQalu3Rl/kiRQUAs6r1IF/2cuRGnhvhoAjYtAMe
         8dfy/tKfu29RyL+cmFNssdwQcap9G9Sf80zS83YsFzSrNgDJ7Z5wBs5TNFoWqZQ57g2B
         9B9gkNgW7zvqlvJMzpZ1j9URWjylt1lRhNqiOUBw2KSg44uUB7bADQH/Sw2k+bXmxmPs
         5H4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790945260; x=1791550060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+H7dDg+VjKEy03nAKa1G4ZyPKSG2FvhZXWUH21ZzuiQ=;
        b=xU9+bEbsjHzYsepnId5/I5ONoDhJ45RNaHww+n3w7rd/Kdg4C9fR/mRR/2kJtqsFHp
         qrqs52PIknEiIE08UgzjHnkgOwGaNbfEoh8jIfNC94b+kjmGUSFJqZmH+1pl1JkZMHek
         Eu5mQ59NSpTzHN5lOPXukLxJU2/cm2s2wTteMaomoS+MLsC3chIxZAY6TVCerWTyBWz1
         L6+imf8TCOKSnxvbqZeu20FkDfhQzqmES8A8DB0Ki+ZDfJJ3Wm3XXOrunwzc+yporpck
         EuAoqGKag0UWFTV/i1tq3VLd6cFew4GJHoDbkRzMKba64fi4u5PU1ky8FaJtwoKsoTBz
         kzjA==
X-Gm-Message-State: AFq9FYI8n3NN1CwOWHGC6CNbXNjp+OQX9cTG8J49C6HbKYHbBsOFYM/a
	AZtcteuEUQmrOUNlzv5MsQmn41FRNC3he+7a08Em3WoZ3liGMiMeAVsm0qBxrz9YNL8=
X-Gm-Gg: AYBFou3JmZd3W/ogbUHK0j7FFGre1qPerb96k/mjtvtkJVZ6osSm6xhe71bSfQcBCOg
	ErCS+9BoaGf+zVM+HYq1g7yhEshhz4Giak9H3TRZWI9bVxJZvoINKBjyw8xUygg9+gZ+8gQFx6h
	xJlDWQlkCe6R8bn/9fR0evFfWivS/4AN2pNhn/9DCqfRq8Uu/BNbdt3P1JpqIJNxUb/AX11j4zn
	RDUEpFbq2faIo9iHQ/+wqZi7+xHwXf9BSiMrRKZcKCx3ZgffDV/Z8svgGrSR+a7mKZYKmXTk71L
	A7qAMGS8St1xO89IhyFsDS+uMsbPifWryTfS+A4PbkLcq2kNSK0+0URc/soVJB9nC0NAyKJo/UN
	MMAII0+MfpIEyjtZ+aLiHiabvSsij9WBSvXBibEUOQDoW0q1RYINh5kjAoWveOHa4FAculxmh3u
	EpRaKzbPEcwq7iYTnsnpKbKOYkMUxIBcdbPiPDnb8bs++qeK16QUAlFhM1TCM4OJN+cLW9E+6KY
	p8Nbxlwcdpt64DyaPWFHfjE8afwkijxRipO2ECENNtdkQhTLB6WtMCIrU/izp0dbInazPeew13M
	QCozgi3Qy5bwQ2ZxxZ+j0cIaXRpPbSFf7yTataz6RneY6GHNq1Q8bg==
X-Received: by 2002:a17:903:2f91:b0:2e2:d989:c273 with SMTP id d9443c01a7336-2e49b659e6dmr24182135ad.53.1790945260030;
        Fri, 02 Oct 2026 05:47:40 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e49f67ccf3sm7224895ad.13.2026.10.02.05.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 05:47:39 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 08/15] selftests/bpf: Add test for arguments without names in static functions
Date: Fri,  2 Oct 2026 12:47:07 +0000
Message-ID: <20261002124714.180012-9-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002124714.180012-1-alexei.starovoitov@gmail.com>
References: <20261002124714.180012-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Check that BTF with a static function that has an argument without a name
is loaded. Vararg has no name too. Check that a global function with it is
loaded as before.

Acked-by: Alan Maguire <alan.maguire@oracle.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/btf.c | 51 ++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
index 21fdeeb23405..642800b80c74 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -2819,6 +2819,57 @@ static struct btf_raw_test raw_tests[] = {
 	.err_str = "Invalid arg#2",
 },
 
+{
+	.descr = "func (Some arg of static func has no name)",
+	.raw_types = {
+		/* int */
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+		/* unsigned int */
+		BTF_TYPE_INT_ENC(0, 0, 0, 32, 4),		/* [2] */
+		/* void (*)(int a, unsigned int) */
+		BTF_FUNC_PROTO_ENC(0, 2),			/* [3] */
+			BTF_FUNC_PROTO_ARG_ENC(NAME_TBD, 1),
+			BTF_FUNC_PROTO_ARG_ENC(0, 2),
+		/* static void func(int a, unsigned int) */
+		BTF_FUNC_ENC(NAME_TBD, 3),			/* [4] */
+		BTF_END_RAW,
+	},
+	.str_sec = "\0a\0func",
+	.str_sec_size = sizeof("\0a\0func"),
+	.map_type = BPF_MAP_TYPE_ARRAY,
+	.map_name = "func_type_check_btf",
+	.key_size = sizeof(int),
+	.value_size = sizeof(int),
+	.key_type_id = 1,
+	.value_type_id = 1,
+	.max_entries = 4,
+},
+
+{
+	.descr = "func (vararg of global func has no name)",
+	.raw_types = {
+		/* int */
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+		/* void (*)(int a, ...) */
+		BTF_FUNC_PROTO_ENC(0, 2),			/* [2] */
+			BTF_FUNC_PROTO_ARG_ENC(NAME_TBD, 1),
+			BTF_FUNC_PROTO_ARG_ENC(0, 0),
+		/* void func(int a, ...) */
+		BTF_TYPE_ENC(NAME_TBD,				/* [3] */
+			     BTF_INFO_ENC(BTF_KIND_FUNC, 0, BTF_FUNC_GLOBAL), 2),
+		BTF_END_RAW,
+	},
+	.str_sec = "\0a\0func",
+	.str_sec_size = sizeof("\0a\0func"),
+	.map_type = BPF_MAP_TYPE_ARRAY,
+	.map_name = "func_type_check_btf",
+	.key_size = sizeof(int),
+	.value_size = sizeof(int),
+	.key_type_id = 1,
+	.value_type_id = 1,
+	.max_entries = 4,
+},
+
 {
 	.descr = "func (Non zero vlen)",
 	.raw_types = {
-- 
2.55.0

