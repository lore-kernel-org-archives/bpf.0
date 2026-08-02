Received: from mail-wr2-f2.google.com (mail-wr2-f2.google.com [74.125.225.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42C034041C
	for <bpf@vger.kernel.org>; Sun,  2 Aug 2026 22:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785711135; cv=none; b=nCie8lLk0TZ+/i+BH8sZlUOZG2hghX+QingXq8JbuzAj4xD7W1rQkTqC2hvEfVGhRCzeUiWlAQi2foIfQMgrkz3uB5HqX8edS3d9aEr4Z/PGwgmlMAOzTFb2yVhgwfOcxbWNgE7R2XFocauXl4n1yxw7nifvIpDphqEc8HRelnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785711135; c=relaxed/simple;
	bh=SSwH62uP7FFKsLnFKVxc1vWrKwvCtDR9F12D3XwOrHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QTyPYESfD4KCG8m260O019Yoj38jz4lygM2bSAbd0CzaMnFUYPqoMAPnHfEDBJ8pRlXAFV4Vip7Yenbklgbo4YlAzhXMKMfz5iEm08FjsgB5b7YHotZNcAajUCcTZ2UcyPiKY7onNnhS9mH5cJCCPl6VwMw85kd1fy6fnrBNeeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SwTPf+Lm; arc=none smtp.client-ip=74.125.225.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SwTPf+Lm"
Received: by mail-wr2-f2.google.com with SMTP id ffacd0b85a97d-470713a9053so799035f8f.0
        for <bpf@vger.kernel.org>; Sun, 02 Aug 2026 15:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785711132; x=1786315932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6Ic95oExLe9ayad89sDmH7iqZRyaDDbTl0bVoXaSRyU=;
        b=SwTPf+Lm5Sk9UYiE4UOlbv7I/zytRpbFbIqOb/t2RsFpgFOX4L32f+VkOYYumanWdh
         3ImPNKkKGfdj2EzmBUog5adpl+MdP3HL1IWR8BuMl+4NJsrTCmRrFnzGLZhrbE6DtFN8
         K6jVk+zUK0advG7p8u0/5bIqVn9ljG0VRmY56QYVt6m+HfpWU8TNpDBmYDT0GOKrwoaf
         Scusdy0OpycePLlshWlDkMsCKgr121WLtPr59hT+O0vh2MLbH61gEKKkLlLw+9JH5LCJ
         fqIiR1luCiPMON6mLhA/DMfU0puF3L6TENCXjgW+DnC+erXfYb2qegz95VEpuTb5MJNI
         IqWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785711132; x=1786315932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6Ic95oExLe9ayad89sDmH7iqZRyaDDbTl0bVoXaSRyU=;
        b=gA+mHc0TRPttGGC4/IF5sZdxgk5F+nvZkMgJwRgZy6kc2Yrqpg7yoKyYaA6FS4PT+n
         hH9J0+U0mgcL3AU2NEDrAckax1CKhIg/S1oPDDzaqEbpk5I1wsS2C5PpdF4cgktRB+Zb
         HICPsC5OJMA/mvwoTgd+/5l6hBnk/2ogHPcxMwAQf410KGZ9Nv8tsZHkUtlUMwGoDfSU
         CwRxvWs9JPk4UnH1S7BVMWACXejFxEysAm9V/63VeGOZYek3Duwz+m6qLu8702nEVdO5
         7RUOyF5b2PjxHivqQW/oAJJaAXO3T9yGBbkPHN0tLbo974bGVVXyHInvftHz2CvXF7Qm
         a29Q==
X-Gm-Message-State: AOJu0Yz2hy1YbjIWZZ+a0exqQo1P3DkMlJYBNQ4mGF/WumrI/R+MGu2P
	9RruFKdE/4OwGXeNVUQlKqS24G8cs+022+E9ri/EQ5LhiALJhHVpRweRxs2m+qMk
X-Gm-Gg: AR+sD13A3eiLwXJA8prjbyFDdy3X1Up6FOG7Z7mCZ53Qh2cZH8Cx/vXlNM2Yx0aC1L1
	ZiwE9lIv48CVFpHe/rz54IJrsnGJll8GPpIl685DqHeJSnjagORJ0PAMY+/5DGnUSrf4QlDMXsD
	vQWORnHgjqexaWBHNQV4ccRDucjyxJKihLNoFu0MnBycj/KACa/GBbjpspKOcoLEpY4PSCOBXco
	Y6aTI1WxadY2ZnpSdM9zB5P916UFPAlDk6R3drkBmErlsmCvmEkj1FKx1L9HWDqbRxWq+oXH1y0
	4w9LCAZ7jJLCRz2GVxxBcRLh0SKr80k3F54Ue7AxxocVtMqUDJ4SN/6NKrtPR0lo45qIixCPWec
	bBXNDkZpBdmc3O1u3v5KIKxrHLeS25JZIxZEQftDPeAFK4xIEibnnhEVKHZb8Otmnxk5s/GsdnK
	fayWRsOFqqAC8epQK8zUV7x/i0sWQ3O/QNme+LUaXSmj0qfqBSllnTyV2dZ+nZ3P6xRr10mMpNg
	vx4EmrqiIRzPUyHLr74M4V3jaDEqkD93n5RHpa3m2YE8H8wIpE3P1OGs4lg75CGX4E5NO8zcTgx
	/D6ZzZ5NnKcuUNvyW0GEvMHIMU0=
X-Received: by 2002:a05:600c:8b48:b0:498:261:dd93 with SMTP id 5b1f17b1804b1-4980c67ab9cmr163369975e9.18.1785711131964;
        Sun, 02 Aug 2026 15:52:11 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd456a6d7sm27662981f8f.19.2026.08.02.15.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 15:52:11 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 2/3] selftests/bpf: Adjust veristat stack depth parsing
Date: Mon,  3 Aug 2026 00:52:06 +0200
Message-ID: <20260802225209.2511758-3-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260802225209.2511758-1-memxor@gmail.com>
References: <20260802225209.2511758-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2035; i=memxor@gmail.com; h=from:subject; bh=SSwH62uP7FFKsLnFKVxc1vWrKwvCtDR9F12D3XwOrHc=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JISv/FMOXN76bBFx5191bl1uaXz2Z1afW6sOe7IOJUcvvB XaI8zN2lLIwiHExyIopspT838dkfKLyd6DtMm6YOaxMIEMYuDgFYCLBNxkZ9vDOWlf1RVw2aR3b Ms7IqnCBqo7omotln+5pLDnWL927kpHh9gbV5pXPhO+9ymnOeeT7sNEzIErwRv/aTp4YuYgHa6O ZAA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

The verifier now reports stack depth statistics using one record per line.
Teach veristat to parse the new maximum and per-subprogram records while
retaining support for the legacy one-line format used by older kernels.

Increase the bounded backward scan so it can include all 256 per-subprogram
records.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/testing/selftests/bpf/veristat.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index c9c257784ee3..97397b97745d 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -993,13 +993,15 @@ static void free_verif_stats(struct verif_stats *stats, size_t stat_cnt)
 
 static char verif_log_buf[64 * 1024];
 
-#define MAX_PARSED_LOG_LINES 100
+/* Keep room for all 256 subprogram records and trailing statistics. */
+#define MAX_PARSED_LOG_LINES 300
 
 static int parse_verif_log(char * const buf, size_t buf_sz, struct verif_stats *s)
 {
 	const char *cur;
-	int pos, lines, sub_stack, cnt = 0;
-	char *state = NULL, *token, stack[512];
+	long sub_stack;
+	int pos, lines, cnt = 0;
+	char *state = NULL, *token, stack[512] = {};
 
 	buf[buf_sz - 1] = '\0';
 
@@ -1025,11 +1027,17 @@ static int parse_verif_log(char * const buf, size_t buf_sz, struct verif_stats *
 				&s->stats[MARK_READ_MAX_LEN]))
 			continue;
 
+		if (1 == sscanf(cur, "stack depth max %ld", &s->stats[MAX_STACK]))
+			continue;
+		if (1 == sscanf(cur, "stack depth subprog %*d %*s %ld", &sub_stack)) {
+			s->stats[STACK] += sub_stack;
+			continue;
+		}
 		if (2 == sscanf(cur, "stack depth %511s max %ld", stack, &s->stats[MAX_STACK]))
 			continue;
 	}
 	while ((token = strtok_r(cnt++ ? NULL : stack, "+", &state))) {
-		if (sscanf(token, "%d", &sub_stack) == 0)
+		if (sscanf(token, "%ld", &sub_stack) == 0)
 			break;
 		s->stats[STACK] += sub_stack;
 	}
-- 
2.53.0

