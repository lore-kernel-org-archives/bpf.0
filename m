Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B445F4AD4AE
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 18:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790274341; cv=none; b=BzBXGlA24zKY5PpmW3xWUrqAS4mgUwkd2lFwjW44YgkswfxcRtwF6nWS/1ONL8BdxBLvNlAl9cXf8AqzHDWclUudEiZcAj5WeAtVunEQE9vlTmtgRA1e7kynPudZu/4BAIWPoCBEp6MkYGKl3XUf3Bgpi72U6Tw/7CdgQ01DJ1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790274341; c=relaxed/simple;
	bh=fMm0C6hqYdLvj1uvPciIDpSttjTan6hwtZ3EaT4qh3c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=clrAxdIRSoK3XO59hrsm1tYhUonjylwr6vHNwv7vOmjorQ0WQkW+Lbm/jtOLTqK3mrY7uFBj2I3TRHi2yZOWcO+UKsmhBHFuNYg72qW1WocoOxnWBVuuE5f0/ujY8D4LCu0MvKIy/FWJvXuP4q1Ay2JIv0QkjfIeauDKhfghjVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eo0Z36Sp; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eo0Z36Sp"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d747f0b25dso369865ad.2
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 11:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790274336; x=1790879136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=w5bi94j8Zt4cNAO3F9/r0h0YxC/cqn1bUHta1UEYOWY=;
        b=Eo0Z36Spc6rSFDheIzyHbBYMQz7oFiQ0Z6qDjCRH+Qy8rkhsKFuz1L5g/WT28N1yxu
         FtVmK3L1C+4fkTpY3N2NHC0auAMbtZFiwXxboKbclmaCS+L0slVaDah4OQ05UGkvr0S3
         DKnyoCYEBA0vSqljxgyV9m3bcM5kU1Hvq96QXrLKzxtx54do3lUsFaFCHk+6on9sUA1T
         cBcOQtEtDZA7yyZtxgjEpyOk2PBfU49rzVZPC8mTOFEYnCDP6bdipMYGgPB04sqkCzac
         9ms55hnFFVnywBduwvrAUdrer59Noh2kDvJi23HtPOcAz+dXnDI82SMAjUXPrpq6QrFl
         Ad4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790274336; x=1790879136;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w5bi94j8Zt4cNAO3F9/r0h0YxC/cqn1bUHta1UEYOWY=;
        b=WVNVLCZAKCytsZeCAVQs6zz8RHwhpQPQ6ppuze8xN+a59ZRI18tJRifoD+XXKLPdM/
         8Z6i9Aa/xvNf2aOsNJbRDvTL635Qf4MxGzcw6xOf+rI+13a7myTXZ8ZUXGZqjlpzf67a
         CcaUej+oY9zlvenbs/Ivcmqy380lKqHmdbBgYD7E7jFcTqYQSNiXUMb03cqBl+DXSMnB
         GNZ1JPZEQ77bJhmEBQXs4CmaUH5gvatJt24Ff1rBbM/Ap6pJUs/Aly2q8HG2CP/ZxRNV
         NuuANpwGr6AbvlpNNIn/Cnt0PUksykQ/xtWq3UxuIewtwCan99Mgg99J2VRGK9qpsExQ
         3bpg==
X-Gm-Message-State: AFuF++lL1C7Zpb6gGu96IsQw4rTTeiX1ibHD/1c7TgMxAdqhRGlOw1eK
	YGawsjEtnGvK7zVEQf4XEQexqjkWR6qhmeJqJFY8fQimDm7QneFTnNYqpPYbjw==
X-Gm-Gg: AYBFou20zuRmScypruolhVzdcNM6vK2g+zVyPpqcx0xADzUs2wh48hrYy8RY/VXBoSQ
	GRlFFQBk4c3MD9o1kEt1i78H+B5nhN5fujaOEbShVNc82AXWL9DEoUL5F8zc3D7hffWdVpOnfoX
	FVXMavLFM2xQD9+Sb/TdaPfomwb170esjTYSOyw6me7wv9mgZky7+VWlH0IJ1AbdRZfZSgE8/ad
	bEl3Oqck0TS37y4pSXKooAalg1Yz+y9oHmu0dzhZHHjR9vV4bGsj90j2XI6EInXKJqozc5qhI9Y
	elE+G99eDNrtHVYTQabGLnB7Q/EdIYfLXD2li09sUXQXXhL524A20b2oAseRk6nmdkAXr3OXl36
	ZAIJU9FqLjRFkyWbLlgSjau4F5QTxdGL5pGlfOUJeBtyT5/Yua/0OkTlHNiDVMyiYpn3u08I1SO
	goZX8GVoWi+dHvCOOTlPdVco+ExGcnDQDNVuhUhGDfS7grLyfonxP4w+ENtXivEVKMeGssGWFUX
	xRHQLHYqkp8NkzpQHUuDU6ciXRgNsAC+mXPPjzFhUdE6FcR+JbQPvbMLdMuCjyDHLKZT0A/2620
	jEY0ZCATDLzVGFlucVPUgqN3vjcHaFAL9mCpHS3Um07squvcoCWY/A==
X-Received: by 2002:a17:90b:3d8b:b0:3a0:2c7d:eddb with SMTP id 98e67ed59e1d1-3a098fe75d8mr3271483a91.32.1790274335869;
        Thu, 24 Sep 2026 11:25:35 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0972b15f1sm5940944a91.2.2026.09.24.11.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 11:25:35 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next] selftests/bpf: Run callx prog_tests once
Date: Thu, 24 Sep 2026 18:25:33 +0000
Message-ID: <20260924182533.281399-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

prog_tests/tests.h is generated from 'void test_*(void)' definitions.
callx_func_ptr_map.c and callx_rodata_lskel.c define the test twice,
under #if and under #else, so both tests are registered and run twice:

  DEFINE_TEST(callx_func_ptr_map)
  DEFINE_TEST(callx_func_ptr_map)
  DEFINE_TEST(callx_rodata_lskel)
  DEFINE_TEST(callx_rodata_lskel)

Make both definitions static and call them from a single test function.

Fixes: b018e998e645 ("selftests/bpf: Add tests for callx through pointers in read-only data")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/prog_tests/callx_func_ptr_map.c        | 9 +++++++--
 .../selftests/bpf/prog_tests/callx_rodata_lskel.c        | 9 +++++++--
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/callx_func_ptr_map.c b/tools/testing/selftests/bpf/prog_tests/callx_func_ptr_map.c
index b58ebee9b1ef..42b33d5876b1 100644
--- a/tools/testing/selftests/bpf/prog_tests/callx_func_ptr_map.c
+++ b/tools/testing/selftests/bpf/prog_tests/callx_func_ptr_map.c
@@ -100,7 +100,7 @@ static void run(int prog_fd, int expected, const char *name)
 		ASSERT_EQ(topts.retval, expected, name);
 }
 
-void test_callx_func_ptr_map(void)
+static void __test_callx_func_ptr_map(void)
 {
 	int int_id, proto_id, map_fd = -1, prog_fd = -1, reader_fd = -1, fd, zero = 0;
 	int main_id, add1_id;
@@ -194,9 +194,14 @@ void test_callx_func_ptr_map(void)
 
 #else
 
-void test_callx_func_ptr_map(void)
+static void __test_callx_func_ptr_map(void)
 {
 	test__skip();
 }
 
 #endif
+
+void test_callx_func_ptr_map(void)
+{
+	__test_callx_func_ptr_map();
+}
diff --git a/tools/testing/selftests/bpf/prog_tests/callx_rodata_lskel.c b/tools/testing/selftests/bpf/prog_tests/callx_rodata_lskel.c
index 6a43b880d730..fc5181c5b5ba 100644
--- a/tools/testing/selftests/bpf/prog_tests/callx_rodata_lskel.c
+++ b/tools/testing/selftests/bpf/prog_tests/callx_rodata_lskel.c
@@ -21,7 +21,7 @@ static void run(int prog_fd, int expected, const char *name)
  * of its functions. The copies have what user space puts into .rodata before
  * the load. The program that doesn't have callx uses .rodata.
  */
-void test_callx_rodata_lskel(void)
+static void __test_callx_rodata_lskel(void)
 {
 	struct callx_rodata_lskel *skel;
 
@@ -61,9 +61,14 @@ void test_callx_rodata_lskel(void)
 
 #else
 
-void test_callx_rodata_lskel(void)
+static void __test_callx_rodata_lskel(void)
 {
 	test__skip();
 }
 
 #endif
+
+void test_callx_rodata_lskel(void)
+{
+	__test_callx_rodata_lskel();
+}
-- 
2.55.0

