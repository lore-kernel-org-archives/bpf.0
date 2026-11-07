Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794071043;
	b=h9vkqOm5hrG9DVaMU/wIVYvayYFfzQwkIxeCCwy9FMEbIVP+SgBI6MpZttqe/QCJjCro
	 zZyp5Y2jqoKXDpsnihyAu3GwhJYJO0/M3UgXkeRG+jkJ1R8MS38j8XxWBh/OU66pXyJMK
	 nmeS/SGTJ7edygEhdEfZNIChHPxyhSK6cE3TTx2QyhmhUDpPpf1L17+lE6CAtaL6KvrgD
	 Rb6O7y4uj/LQLPanZnWWG98fSYIQ2cYUBPhcYaQomR1iQs+tC52F38T1NeMVsNi9fI78w
	 sqagYrsW6aBgvmqbzWIwdyaOzrHgsqb01KhQm8M1iMZRfSfSC+8tL4y8kDxgS4Q/9JQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794071043;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=kqhdeyKuOkovqn//VXnBgsOuPRUZHvK+ad8DLR+9EFo=;
	b=v4rKYXubPlmYdXs2QYC3+NV2v3g+wF2jlJPaCEjMythVvOOLHA61+VDrBVpJ16p0zz7P
	 Ged6VCk5rzRzh6bkapDEcPPdhypxqg2zEiPxE2rpC/UYcb/LMzgDAS7OlfkYZxc1YpIMD
	 +yBuy2eZcbreBO/feqwUb/KftnSeR5wYp7h4iijkI83mWou8W63du1bGaNTcS3P8IO2Bh
	 QpbDfGduMd1o8rUt6YhFfi3dQrqlbIxAqBhwhgnkh4XOU47++HClz5CCfvmAyBOi2aXY2
	 b0Yo6tgoFmuqEgn7n0RKP7K2fUZ9G/9m/RTR3m3z2+KZQorrtLmJzS5O0cCwZi5FVTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lwv9YRmu;
	arc=none smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C325606A32D
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 17:04:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C325606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lwv9YRmu
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2e8da6ef7ddso9143135ad.3
        for <bpf@vger.kernel.org>; Sat, 07 Nov 2026 09:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794071043; x=1794675843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kqhdeyKuOkovqn//VXnBgsOuPRUZHvK+ad8DLR+9EFo=;
        b=lwv9YRmuvth92B6hLiu1JjMN5bClt7jx5Q6xhqo5XD8BMg3V9chnycCRgA3liYyC4e
         i7Uq9pRcrc9PBSOcAZ2F5qsF8nrzoRqcaY5PCP+Pq4SjJQ7HvEcZokwxpql5NCe2Ek2O
         BUgB3UVJHV02laDIJdEntZB/P4msOy5ZjS3PsKnQCzEPfwB2vsK/ggPLd4DOoL/uM5BL
         nBL5sL92ox0sZkmo1L/uk6SsqXdciSx6hhoYZ4jEX/rxCSEv+bEE7Z7f+dwbOu+YxpAW
         x/XDE9x8Fq6nQLyf2sAVK48KAZbJJRT1BKEUs3orOM1od868xIjbdUnkQ6R0ZXdJylXn
         +cdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794071043; x=1794675843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kqhdeyKuOkovqn//VXnBgsOuPRUZHvK+ad8DLR+9EFo=;
        b=exTFovBEtQE43rvM5lqMfmQV7LWO7WoZj7jf6oXfIxdKki8+THozwdQ0Zz9OCmRhQi
         cc1OCTKUvpm1MhnFwiIru36x5kgzDx54O/qklSPYo+ja3wRBll8ZVAb9MA2DHUJV6d+R
         J1JT3rHdfdbcJc/GeR6mXHFOwbYjb6acaEyq3KcpFnlIC2YyyFrSSrrdUagNTFa0PZ4M
         UqKE0d306jUn213EXg8NtKwSUnpisVSZdi8xfsVIRGNrGqjrQECcdrSEZrrtU29EWlA3
         B0UIdmFox9GiUo5l5Hb72VJjnsNzlH7cJEpSRLOaFHsE2Kb0x0rQBTciBZ3NLqz3eZBs
         wsbg==
X-Gm-Message-State: APuU4Z8i86RxgBHUOM37Aj7aE4TbbF89RDfhOfyoJ2eFfVZDH72ZoJWv
	u808spnWWI19+7v7oPV0RpZvHKI6I0fMg6PyEj26EbHzqOM1bsXmbia1HLLnbw==
X-Gm-Gg: AYBFou1ilVi++Rn7YAAWtiYLYLCTC6K5/M+PqhPaohCK0chlQumIGQpSpQAfjgtHB22
	0J45KqR0MQ/Y9j/LLk8409pyGB9Wppq740JDAo2gA2Fr0yKrmik3C4z0/qad1s2Fplf6MmxpSH7
	U1y+JxhE22/hTIQaUum9FTDCDXo1rkk679KuiuoLgJkd7ZlyfU3n7NNxM94BiZ6poB1JpwTqR+j
	N8buQQSZksQda6pPtawVb0q1u5CnVnmW3UBmxN6kLFCdiSf6B8TcJXg6UZzev5Tnarsqs2PzAE8
	v6UUAeRaCsdxYEYZMePbsJsm2jU10VCsUkwSXhJ965oV4btmGvi0+VMHH29TbY//zn6KCNnKr2i
	O+3HzQLXbRp5rCbHvMLVPR3w2WVXklNOd8DXVX4YeQhJdcbwhHzvFjQovm9M+y+gawtWfcPq7hV
	MRXMUuYUB63RLf0V3BN9XYmx2xx+w/TI+wICdlbqluvOAgEBBB8SHnkOJqfeueoyqQp3DQi6ahD
	0Bz1Gk2jtQ1JHPnaVwYCb5x71302QH+WdYs1QrTIQ6GA1uE6aDh0JLnTTUCrZpUkckQccWcdMlq
	F1PHHNNNDhRf2r3d4UhZxkzQJRr4bDVObRugm7TJlvAtffZtSUKlFSVUOrv+Kw7n+zbOCIN0kEI
	0I9DvgUpHuGDyYjyZs91OLRTf8GuhCEBkWO4k5xavPG5VPuKhmKUplHGUWB5lO3fidmDL0VPA8g
	==
X-Received: by 2002:a17:902:ea0a:b0:2ed:3c60:7be with SMTP id d9443c01a7336-2ed40e78b39mr66150095ad.59.1794071042529;
        Sat, 07 Nov 2026 09:04:02 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed47d40fe4sm13554485ad.35.2026.11.07.09.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 09:04:01 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 7/9] selftests/bpf: Run the plain C tests with an arena serially
Date: Sat,  7 Nov 2026 17:03:04 +0000
Message-ID: <20261107170306.2831028-8-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261107170306.2831028-1-alexei.starovoitov@gmail.com>
References: <20261107170306.2831028-1-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

Commit a14f9ba080c1 ("selftests/bpf: Run arena tests serially") made
arena_htab, arena_list, arena_strsearch and the other arena tests serial.
With KASAN every arena takes 512 MB of shadow memory while it lives, and
several arenas at a time exhaust the memory of a small CI VM.

The plain C forms of these tests make the same arenas. Their names are next
to each other, so test_progs -j gives them to its workers at the same time.
In a KASAN VM with 4 cpus and 5G

  ./test_progs -j -t plain_c

leaves 0.4G of memory available at its lowest point. Make the five tests
whose prog file has an arena map serial: 2.4G stay available.

plain_c_arena_race has no arena. It stays parallel.

Fixes: b5ae07f77d27 ("selftests/bpf: Test progs without bpf_for(), zero, can_loop and such")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/plain_c.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/plain_c.c b/tools/testing/selftests/bpf/prog_tests/plain_c.c
index ebdcf2275dbe..6d165afd38f6 100644
--- a/tools/testing/selftests/bpf/prog_tests/plain_c.c
+++ b/tools/testing/selftests/bpf/prog_tests/plain_c.c
@@ -109,10 +109,11 @@ static void dynptr_run(void)
 	plain_c_dynptr_success__destroy(skel);
 }
 
-void test_plain_c_arena_htab(void) { RUN(arena_htab); }
-void test_plain_c_arena_htab_asm(void) { RUN(arena_htab_asm); }
+/* Files with an arena map are serial, as prog_tests/arena_*.c: 512 MB of KASAN shadow per arena */
+void serial_test_plain_c_arena_htab(void) { RUN(arena_htab); }
+void serial_test_plain_c_arena_htab_asm(void) { RUN(arena_htab_asm); }
 
-void test_plain_c_arena_list(void)
+void serial_test_plain_c_arena_list(void)
 {
 	RUN(arena_list);
 	if (test__start_subtest("run"))
@@ -129,7 +130,7 @@ void test_plain_c_arena_race(void)
 	RUN(arena_race);
 }
 
-void test_plain_c_arena_strsearch(void) { RUN(arena_strsearch); }
+void serial_test_plain_c_arena_strsearch(void) { RUN(arena_strsearch); }
 
 void test_plain_c_bpf_ma_ttrace(void)
 {
@@ -173,7 +174,7 @@ void test_plain_c_test_wakeup_source(void)
 }
 
 void test_plain_c_tracing_stack_arg_tailcall_tgt(void) { RUN(tracing_stack_arg_tailcall_tgt); }
-void test_plain_c_verifier_arena_large(void) { RUN(verifier_arena_large); }
+void serial_test_plain_c_verifier_arena_large(void) { RUN(verifier_arena_large); }
 void test_plain_c_verifier_iterating_callbacks(void) { RUN(verifier_iterating_callbacks); }
 void test_plain_c_verifier_loop_as_is(void) { RUN(verifier_loop_as_is); }
 void test_plain_c_xdp_lb_bench(void) { RUN(xdp_lb_bench); }
