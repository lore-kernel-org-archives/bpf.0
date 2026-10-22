Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792627635;
	b=Uk0AMNxgZ3Qt+w71fr6JyACOHgbsN9ruvCj+5mhd54xTzpRnneilDND89oeAeKtenSa6
	 GHHXXP9K+N66Flce7ZBnlMB3uHLaHFpm9ULVjAEMmqSu7boddeOxtCoTvhVOwsuao0WcS
	 I00PhF+9j0NQMiLYnOdKlGcMqQ/2J+wrKGt0ExAe76ZpX6dNsMM6JdQkK4WO8vu1ycKR8
	 78dPR6RbN+gcCk9/oBl5fjHoHAXbh0kJfdCiUlifL2Qe/ehRVea5Iu9Qlet1lhPBSWbV2
	 kVPwhyffjee6nEq7wGwcfrKjQ8gxQuWIKO+eQQuNAap8f06erWakQqLRIM6kjHOev7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792627635;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=gc61ZYx20EA+QSk3xyUIovXHoKqT8EtsnpdMOJEqrTM=;
	b=U96fHgxY+En0McEVHoJ141cAK1w8Q4nTa+x1r83E2E+0iMoaAVA03poUheenYH74tXJm
	 Sru0v04O5jwvUWhPYOjuRrHkK0J2ESWBEd+nxvStFJV5et+NWWmATcDO24BrIODWCaOmE
	 ICPUem3PL1lKxTGP92b+ExecYuRyUqQZboLJiey2qpDkWh++GEhECXYUV4vFO4NIpr8wX
	 +laMkgktR7ZJANsjVoG/iOzo7m5FpMaxokHqI3B0frcKPXG/prqgn4nRSQ5Qu7sy6eD3U
	 luN6Ra5Wi2xTM4/U1kMOlwyyxfwcc+2GjmsqZjZNkvmOTLe8QxbWPLAytIttI+XmvSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=e0Xa+JbX;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BEF606A31A
	for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 00:07:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3BEF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=e0Xa+JbX
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso1728328eec.0
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 17:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792627634; x=1793232434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gc61ZYx20EA+QSk3xyUIovXHoKqT8EtsnpdMOJEqrTM=;
        b=e0Xa+JbXc+r2wBTFx76Jsp2+eEB/Df4eeg+PIIocvDIXwS4ie7XgdRw7ZZOqKmNDrm
         +EgcB4PcSH8EkjaP/EgSrevIhsaph57Ps2V9Bvr3y/CCP6Z7vfOcAzuZJ97+pTKMFRSZ
         ECMo6QTRsq1obcJIvXU4mBt2zbi6LYOMgytlEoVHSu0Kf07l/tzKijgNPtQmQxpISzrA
         GwP8z2nU8dcqPM28bvAJjA5EOZnzNFpAIe6mF8fJ/NXLGVk6t73p8ioHh9vYfMh5RgNZ
         LSMuRN7M6wq2arEu6SHgDApKJkE1dtTFBg6UFc6TRxmFdKGTOPUpd58VB4FZeh3IONkm
         11zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792627634; x=1793232434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gc61ZYx20EA+QSk3xyUIovXHoKqT8EtsnpdMOJEqrTM=;
        b=eWVqN9j6z2Dom9dSa8H5Lb2er0i+0oZsdvGeIGkv8Q/45uu1pDGQLKdhDiuMknxkxj
         lxJlLAUi9T4JqjfdBL4zRc/gWm5iOrEtnz84MRYbWBJYBQ/FzVEaOOvCkmGJVeDWsOwD
         0/9+y5tuF898z9uW3wNatnk0x+Arasx5QI4qHcuU+AVPwNDIzUxKljyDawOSit9bJJ4u
         g2AaR6q96ueolvQ3VjNV5cOCyiA2zJTrFXjQJg7nUvMrHANqa2uH3Pm7rlc1q5aKKGRf
         y1jSuFM8uqxzcvy48o7+hcYdaQAsJZMHfxW5L2MKFb6MByGt2DnOHHc69Van0SyGNgp2
         VD+g==
X-Gm-Message-State: AFq9FYLbtcX+ipO27XJZUCuJSPDlmspBP0/F/rLKoyffsE1Vwwa/O8JN
	1Nn9M3H5gc37gqAg1N/Hmxu8JYjXa54kaIUeq8vDwBFcF/5tExe4tQ2P7itZ18PVIg==
X-Gm-Gg: AYBFou2/zaNz43JruK65ohITa8UScxLsQgsDEfi7fWxmtgmMwmE5VV0deE8sNZiaioC
	D0oSrfq6rsdjvhNWjKsJVwgn824a9h3X5p7NKjRCg0a9pwCbryhTXVsEqoTAc0sROlgnCTp+KKD
	wal2wXd7kvONRdqbub70ygomqFChRjiLYFDQmyIaxXll7KchhMbbAxFQtDY6Kl+kiQrNV7hexIG
	W3SAV2KoLeLDEnIVR21eSo2l5yMZEq8HiWaEshytzIP3Jo77whoEuGkibtYntjKmd7B7qnQxUKt
	Dnzr70PSnI9Dsqgg+tl4eDiPOXtqYuzkMHDpgYFstbFXWc+EhLXNZ7hN5pGTTT76uZxCqp9FV4Q
	hcxAQ4vFIXFiyjla1AgDLmwEWwZWlPQSBYs0sPWpK+7I1uPihs31S+dltYRyBXel/QTPUc7hiP5
	E4xbKG1M8YeGbpLvcU8ZWDvHbh9a2lJWhe2+ezXIv5GHW3P+ZdFZwXjkj+/CJTCsp2q94NM7i8U
	s9xAHpi7YfwO0s6Yv4m+HMhHPtCVuc/B+WfcnOBPvm3QGHZMBkPxtTqhmUCxJUh+EY/Fpf2GJfI
	VA8jErmXwrwP
X-Received: by 2002:a05:693c:881c:20b0:347:8d01:164f with SMTP id 5a478bee46e88-3674ec2ed1emr5069427eec.19.1792627633726;
        Wed, 21 Oct 2026 17:07:13 -0700 (PDT)
Received: from localhost.localdomain ([185.220.238.36])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36740cca3d8sm10909781eec.14.2026.10.21.17.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 17:07:13 -0700 (PDT)
From: Wang Yibo <szwyb123@gmail.com>
To: bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH bpf-next 3/3] selftests/bpf: say how to fix the missing LLVM skip for jited checks
Date: Thu, 22 Oct 2026 08:07:09 +0800
Message-Id: <20261022080500.100-4-szwyb123@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261022080500.100-1-szwyb123@gmail.com>
References: <20261022080500.100-1-szwyb123@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When test_progs is built without LLVM development libraries, every
subtest that checks jited output is skipped with only "tests are built
w/o LLVM development libs" visible under -v. The message does not say
that installing the libraries and rebuilding is all that is needed, and
the verbose-only message in jit_disasm_helpers.c is missing a trailing
newline, so it runs together with the following output.

Mention the fix in the skip message and add the newline.

Signed-off-by: Wang Yibo <szwyb123@gmail.com>
---
 tools/testing/selftests/bpf/jit_disasm_helpers.c | 2 +-
 tools/testing/selftests/bpf/test_loader.c        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/jit_disasm_helpers.c b/tools/testing/selftests/bpf/jit_disasm_helpers.c
index 3558fe10e..6162a06b8 100644
--- a/tools/testing/selftests/bpf/jit_disasm_helpers.c
+++ b/tools/testing/selftests/bpf/jit_disasm_helpers.c
@@ -247,7 +247,7 @@ int get_jited_program_text(int fd, char *text, size_t text_sz)
 int get_jited_program_text(int fd, char *text, size_t text_sz)
 {
 	if (env.verbosity >= VERBOSE_VERY)
-		printf("compiled w/o llvm development libraries, can't dis-assembly binary code");
+		printf("compiled w/o llvm development libraries, can't disassemble binary code\n");
 	return -EOPNOTSUPP;
 }
 
diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index 824e5912e..a45e6c820 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -1506,7 +1506,7 @@ void run_subtest(struct test_loader *tester,
 					     tester->log_buf, tester->log_buf_sz);
 		if (err == -EOPNOTSUPP) {
 			printf("%s:SKIP: jited programs disassembly is not supported,\n", __func__);
-			printf("%s:SKIP: tests are built w/o LLVM development libs\n", __func__);
+			printf("%s:SKIP: rebuild with LLVM development libs installed\n", __func__);
 			test__skip();
 			goto tobj_cleanup;
 		}
-- 
2.51.0
