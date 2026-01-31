Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404973314BF
	for <bpf@vger.kernel.org>; Sat, 31 Jan 2026 05:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769836183; cv=none; b=F69zAhsC/4a0mCf0aN8ws89d9FyFJGBUa0xBAhtZNHUHNz8H/yqezBj/j7yz7egFrdtLjiL5aZ//jRtutgEe4X/qhI8VsiLF7tHuwvBS5fzevp8cACPc051a626lu3YohDF99Bdd35uDyJ0cWWcb4Vmxn3WZcBBywktR4wYvfzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769836183; c=relaxed/simple;
	bh=exa/YP9fyICJ77EYEDHbnzjy54eXhqjQuSP7ACG5gVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L8GSs74jif710nFgTb8z4rZAsqQaP3ZNjY3J36ylOV9Jte/KMXhWvOeibRiWLhaowf2RzrauwSZWIduePcle0Y97pZJ2ySdKojoAVwBOz3wTHiza9ag74/jhMv4QxWoZZYTiSZws0rzilUypq65/HvPbwKQNIGWyqxJAf6XhVrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PRTrQ13y; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PRTrQ13y"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2a0834769f0so18599645ad.2
        for <bpf@vger.kernel.org>; Fri, 30 Jan 2026 21:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769836179; x=1770440979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uRf+SRIGQU8su06GPIQHkqNg5txYSi+urlSE/fCNWGY=;
        b=PRTrQ13yvRCvSiQOGZaJBREANeNa/5BW6VJX2WVTAZfWN/Q+RY37RLcS3aYqDc4GnC
         Pt/5lnInWUOkWmn105n+Gr3yhBDJGrCifDskNqU9h3iscODOL/AlpWf6vG2HdZ0cg8oG
         MrYR+zwqg08ojs2PMN5tl2SM2LXnp17Q1RDa5BH0dsgNnBGhZ0ubgFo+qca40b/pl1y4
         0m2hcqIR9QHL5trIhq2bq83+GQWiuCXsqfDDmNw36N0jN//j3wv3IyhRVt4kg61Ezz2K
         jqibL4Ko0zXReousomgzWyIEbBoRD5E+uZwswWRkqaEwGOWTgZvP2mch2xuzMGnU/bhh
         V/kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769836179; x=1770440979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uRf+SRIGQU8su06GPIQHkqNg5txYSi+urlSE/fCNWGY=;
        b=AOzWr9HLvS1WnMMcX2IdrWRXuRzJfxTOG9p04iPvOcrCI00VxCBOk6Cglrkb67mtVK
         Vv1jEPf40y3/buujjvbZkA6JycuEpJpCgSHraQc2YdDvIRF7uKdKEnb/8/6WAHW2tFGD
         +TwwwklQHRlBjgcFW3RnmncYqJR9efJjkQfF8gZvAjMwLyhpjBneQ6nB3I35zB0DDgOx
         +buMy8LUSZJ2SnRH83vIJ49gYm8ScbmbZVQl9LpoB/U+kRWPGDNohX2b5hi9VMl1Ztkg
         5wYh9WtH4nzxwGV1nA8drnZf23H6pvzsAsigP9pGVNXzYjFQ94Esl5YJae8HHvEjVyB7
         oQzg==
X-Gm-Message-State: AOJu0Yz2+eMUnverzF8l6cuzHxil3tViLbacB5HdyxQkOAOi8B9qnb7u
	Tqe0eSHySY51UT31WwQ7imAjDNVa1iVbc+JfPCzXO91ypEaLApdHImHYxLurAA==
X-Gm-Gg: AZuq6aJVA+n05jVxRqAaT10s1kDf3YRotMJsv2UQZn/oBSXn5VCwct+67gZ869N6xWk
	iUsMzuexXfeEMYCwdf9DMWEAAL0kdf/va1EnzSWZhYKsHIfZV6CdFzZrkjzYbUDmFLMSe/805Jd
	rrQJUgMmOGf2w4v1EsUlWSQ01n2dn5cWQL1ycddYNXWV8kRWKaeAm3QPxN62NAQ3ijI9CXEAa3y
	nSqXw0AF+03e4So0ibiBMC0CwW4Rr6VH95KEhK4ghtDj9WSyFWuBrGOYqLvt0aGrWsYAuWJv544
	/CquTb2l6N7YOSTLnJfuEmBb4c3GH/JhdArSjUZh7ouOETu1g3gbtEz5xeDt/FhLSRdxwvt28rq
	TKr4WjFaFL38F9KNe6hu7KsZwHG9AffdbQ7kYJ8SMCloDrCpmzvn8YsH5fwzpPPXhUrdH+2iemJ
	S9NA==
X-Received: by 2002:a17:903:18a:b0:295:9e4e:4090 with SMTP id d9443c01a7336-2a8d993f9bdmr56960285ad.52.1769836179316;
        Fri, 30 Jan 2026 21:09:39 -0800 (PST)
Received: from localhost ([2a03:2880:ff:74::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b6e4ac8sm86036635ad.87.2026.01.30.21.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 21:09:38 -0800 (PST)
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
Subject: [PATCH bpf-next v4 16/16] selftests/bpf: Choose another percpu variable in bpf for btf_dump test
Date: Fri, 30 Jan 2026 21:09:19 -0800
Message-ID: <20260131050920.2574084-17-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260131050920.2574084-1-ameryhung@gmail.com>
References: <20260131050920.2574084-1-ameryhung@gmail.com>
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

