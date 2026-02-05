Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBC735E535
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 07:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770274949; cv=none; b=Qtq7vvRyJ3DuXULgdWzf/731lJH/sAT3hn70tcv1s2JF16QE2YlqDLfD0GRv/XyeZtxa6GCL+pkjsVyehnKo0wMVlsyeL7b/Iatmn0ZnVSrk9yM2mCoNOU1kjVjx0QP552n+tP2J40zTrhzThMwbGc7s7UZwswDKm+JtYNhKrUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770274949; c=relaxed/simple;
	bh=exa/YP9fyICJ77EYEDHbnzjy54eXhqjQuSP7ACG5gVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nyDFVEWWNkQumFBU5cz2bzRYCerUG3VfVvFo4hwuy4IFzvKw3w+N1Xq8gXCMOZoxZswqhO5xrmH/ngii6TmvPI7PAxXHOpFEI7CuqKPVuYHaiP+CL8O9PHkm3BuUBk8iJ1YC8eluiz0C6M3pZGSBssAbp4cONWYLOutvoCwTlFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G1Ut8yYc; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G1Ut8yYc"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a9042df9a2so3432375ad.2
        for <bpf@vger.kernel.org>; Wed, 04 Feb 2026 23:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770274948; x=1770879748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uRf+SRIGQU8su06GPIQHkqNg5txYSi+urlSE/fCNWGY=;
        b=G1Ut8yYclMd5WzKdknYqLSv8BWylu+GScCux98c2vF5aIUvcrMR3e5an0M2DPXz4OP
         MF5/kO3D0nx/N+iuNJGQyZ6GGVwu1/XlmI0W0DfXzNvo5pmofkHXS7FqcxD4f+9s2MDE
         iE1tjVq/hjsrd0kocqX+MW3T7ZS56XZagHMfm9Zk7fyxPqHA3TNC7+mJgk4Tj8fPvQIA
         7ccMxfTSjPed2RCqISn2/qIfwBGq7o+p2LKzzbMR3E/jfYve+GkgtI4/YjkWggIybLz8
         qd9oB437SdKyNEuOyosdUNXmBxn0HUZjC0FtvrLOIBDS/HAFlS8PtXXBXZbdppZh8cW3
         1AHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770274948; x=1770879748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uRf+SRIGQU8su06GPIQHkqNg5txYSi+urlSE/fCNWGY=;
        b=tP8NlxBSZm9XTxuwaeQ0RFpVLpOAhJSm0stSeA3ydstVMFHO5n5MLSH9OBmiptJL9G
         hVgCNeO8bEoK6l233ofufrxWF1P18C7GjahKWZe7qCUDWbjKd5GQ2crj8Sg4kkF0zkSz
         U0DxjUXBKndaEvBa5+kbfG5dKnVzdqcdmX+IhQSO8B6Oum3x9BZcz1ce9mnGpntydZMh
         n+qUODeaucRbxtR/3xxKEk+FADv8N+GXU+HoCJnwQKJr/taNx+wNV3y3pomk3O5oJgq+
         NIMQncGpfA3Eg1ZeXdTWF9THe2kkxiYzQMXmZvLlqSBZS9GJ6O2tnDoSUSSTIiMwZFao
         /Szw==
X-Gm-Message-State: AOJu0Yxuql3xAwQ+sCXQRfpqN3Cmy7Pd1i40Frm149XkaLPkmuTbaZA6
	YsktdMueqTRmg0lktvZekZFPD8cLe4lNa6JSZAfWFmtmC7DXoHv6lhIzX/S8SA==
X-Gm-Gg: AZuq6aIk2ZKlYVJGQohhzmtpqWYNDI0NdMwIZ19cAbxSqc74qxVRgvIVPdz+cJ+XdpW
	bNKecFSlX2GgIajUZuSaw/Vw4b2Cm5us/jjViJoJhr1nF3VkyXTApy0vv0RpWHOnyy1IbmWu+Ga
	ZEYHFjHX0npzqsKgynGFa7LlBtoJEANRH0QUtL9wTm29uuZtzcHrniN6inj9dAQBtJSJMUhGzFX
	hiV09LsrvvmepP8UtTX3cvdoSCRw+aI5nl1N+/s8AdHwXXAimcRNyZSFZjc16PGlpV6DGCLMZMz
	JgsANticK78fv+Nk/NYzEkRIB2lsJYttHvvIq1nDQ+OsyYZ4A5ASWm85ZDE6GPpaePMNf1l/XG6
	nbIB481b/+efzXCbHjOWdJLLPyNjF6ib8O3gF6NGvingYMhZZKL850dN+C6Ue6OYCUBsJD5QaGk
	4CVfHGjviLtG0=
X-Received: by 2002:a17:902:9888:b0:2a7:73d1:b2a1 with SMTP id d9443c01a7336-2a933fb25bdmr34435875ad.33.1770274947997;
        Wed, 04 Feb 2026 23:02:27 -0800 (PST)
Received: from localhost ([2a03:2880:ff:e::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a9338b71acsm48072095ad.45.2026.02.04.23.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 23:02:27 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	martin.lau@kernel.org,
	kpsingh@kernel.org,
	yonghong.song@linux.dev,
	song@kernel.org,
	haoluo@google.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v6 16/17] selftests/bpf: Choose another percpu variable in bpf for btf_dump test
Date: Wed,  4 Feb 2026 23:02:05 -0800
Message-ID: <20260205070208.186382-17-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260205070208.186382-1-ameryhung@gmail.com>
References: <20260205070208.186382-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_cgrp_storage_busy has been removed. Use bpf_bprintf_nest_level
instead. This percpu variable is also in the bpf subsystem so that
if it is removed in the future, BPF-CI will catch this type of CI-
breaking change.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/btf_dump.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dump.c b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
index 10cba526d3e6..f1642794f70e 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_dump.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
@@ -875,8 +875,8 @@ static void test_btf_dump_var_data(struct btf *btf, struct btf_dump *d,
 	TEST_BTF_DUMP_VAR(btf, d, NULL, str, "cpu_number", int, BTF_F_COMPACT,
 			  "int cpu_number = (int)100", 100);
 #endif
-	TEST_BTF_DUMP_VAR(btf, d, NULL, str, "bpf_cgrp_storage_busy", int, BTF_F_COMPACT,
-			  "static int bpf_cgrp_storage_busy = (int)2", 2);
+	TEST_BTF_DUMP_VAR(btf, d, NULL, str, "bpf_bprintf_nest_level", int, BTF_F_COMPACT,
+			  "static int bpf_bprintf_nest_level = (int)2", 2);
 }
 
 struct btf_dump_string_ctx {
-- 
2.47.3

