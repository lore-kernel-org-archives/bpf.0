Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9CC38AC83
	for <bpf@vger.kernel.org>; Thu,  9 Jul 2026 16:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783612807; cv=none; b=AwRbKrxbdxMXjYjGnrM30VOvex5PFGvppjX/9kcUAzN/Ty+86MPcpsHY3iM6XdL/nM45VOs6mxDeopB6An0M2G6atiVF3paq2AX1QrUzp3dBnRPPOHIR2wNUtx15sQ7/St67A5dAEwKPkbAJDNtzGoggt0Ab7bamTaZxdc0Z7gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783612807; c=relaxed/simple;
	bh=unl8gIFmPjZ2No8KhcHQLnF1P2mjbnpOKccrGfhVVeQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MvXV5fDGgEuLvS4W4TflKVQRMwKzkb5MvBs9RNY6QC3YV0UWf7EnRJjHee09dwV9Imxow4wT8oyJLQW9A9u0XML8L/mAYPdi2NIk6Gv4xi+nEPe+FE8owXDgyyamiwrwhCrU1i75+dd3Ma1drINjGwQYbCfsqStMHHQF5/X+45Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sXJh+5on; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sXJh+5on"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8eeadbc5e21so353376d6.3
        for <bpf@vger.kernel.org>; Thu, 09 Jul 2026 09:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783612805; x=1784217605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uUixcX7qE5LF2nW38wznUsqSUXSa5Nl6efJ4djqvgFo=;
        b=sXJh+5onDj4j+z6aDzdPPn023YllmckZzDkh9gtOvN66l/r2bjbbHY+kSpVfSd70KA
         8s5hhyPY1/5EYEyasWTM5ZX6vKAOsqvt+sZtNti1rmrSrzn+Qnd63kHYNdm4L9OM6eZp
         ysIC6unTGXd6K173adNHXHkqw81tb+VAoBbFlcxbNZ2swmDcd7wPi+gGFsTOFcJFO/JO
         lOW1nPSGXtsnqaT2PIrqyCMSD7QLcc7v6WGdNH3il16pE3wx+MBFZcOGPDglgyOvZUHF
         KWYR8tmCjLGGHXUJXUL7oVI5M0w88gtIHT8khvB5TESTnMqwyWhaAPFQvdVnH62fY+a+
         mOvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783612805; x=1784217605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uUixcX7qE5LF2nW38wznUsqSUXSa5Nl6efJ4djqvgFo=;
        b=TRklmK1EHNhnPeVqCa/VBIGaOR3PKQSoPXq1Gxxu9u1GyB91pW4he+4CqBXViuEc0E
         YkTgOUhoW7ECqda8EhH6br2J+J+D3YRDlMmNwd5qAgPvXRUwLvK5aIiz219nudc6WHEm
         e3WtoyU3r0d4yMMfWqeOc3U1gPFbzdaAX5zujd2QUGIPg5pJ7PAULreEB9dBYfDo65jV
         86KgV8TCXktZwPqhncp9rPccrVq9FWurYXyx/HxUWwcOkPU/o9FUbcUt+mFunfXJ0iBI
         mJJEba3MYO8KbqZuTuOtYR+slM3QoAg9Wj5D8MsHYP1do+hXsSikLe2074IPkfReDvcL
         Vrkg==
X-Gm-Message-State: AOJu0YxqVVQgk1PHyI4JOFr3WmBHsJcvV6HMgHrXuovkjbLRoBiVBaTh
	9PnRa7rNW+AgoRnmM827O9uuclzxgDTBc46WzYhm+sbpoJc5Ld32iecv9nAR5g==
X-Gm-Gg: AfdE7clcSht8PIU/RVaXwnOsKcfDqOGX8pp5esDOLfnuGkhDPuLuq3IbJg1MiVTuykE
	BxXFKeaC7fjOMKMrGyeCozsItNTqdXnIWI/X1R6YYCiUtuIbP4z65QXuS0/QXc/ohwDW/tcdWME
	sy/WBp0B4g6MMY/f9TJ+PmMgezFJOsoELuv0FiX4bTC59pIaUvTpQ+jsXM7VnRPv6l0TMIE8wyV
	LYxpDYQB6CF9Ms7O8tlM6TWwqQZ+GOFa/3jPgVs94yQYiL3ZiTo1KQ8cm5BBOBcDS/rOOXVnCmz
	DrvtbPC7FCOO/mLUXiDHmkpccddoVXLlJrPgcVLZyKz9Fs1lp/rLtjhAZCL24kWKXjgRJJoKC2r
	P5/LQv6nsta12Tr/SNicKDNr2fkb3xdMumf/JIfPQl86eL/E1ZcOOFezjJRqwsN1kNL6SAhJHrc
	5lKS+7qEmFOKUbTWobLDZVvt/lBWnsyw==
X-Received: by 2002:a05:6214:2484:b0:8ec:26a9:17d3 with SMTP id 6a1803df08f44-8fec2664552mr93411256d6.41.1783612804922;
        Thu, 09 Jul 2026 09:00:04 -0700 (PDT)
Received: from TurinLinux.. ([184.144.109.221])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd50e3083sm20418136d6.6.2026.07.09.09.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 09:00:04 -0700 (PDT)
From: Nicholas Dudar <main.kalliope@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: add test for oversized rdonly/rdwr_buf_size kfunc argument
Date: Thu,  9 Jul 2026 11:58:37 -0400
Message-Id: <20260709155837.1879230-3-main.kalliope@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260709155837.1879230-1-main.kalliope@gmail.com>
References: <20260709155837.1879230-1-main.kalliope@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a load-failure test to the kfunc_call suite using the existing
bpf_kfunc_call_test_get_rdwr_mem() test kfunc. Its rdwr_buf_size
argument is a const int, so the test uses a 64-bit immediate load in
inline asm to place 2^64 - 192 (0xffffffffffffff40) in the argument
register. The verifier records r0_size from the full 64-bit register
value, and the test asserts that BPF_PROG_LOAD rejects it with
"rdonly/rdwr_buf_size exceeds u32 max".

Signed-off-by: Nicholas Dudar <main.kalliope@gmail.com>
Assisted-by: Claude:claude-opus-4-8
---
 .../selftests/bpf/prog_tests/kfunc_call.c     |  1 +
 .../selftests/bpf/progs/kfunc_call_fail.c     | 33 +++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/kfunc_call.c b/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
index 3df07680f9e0..67a30bf69509 100644
--- a/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
+++ b/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
@@ -66,6 +66,7 @@ static struct kfunc_test_params kfunc_tests[] = {
 	TC_FAIL(kfunc_call_test_get_mem_fail_rdonly, 0, "R0 cannot write into rdonly_mem"),
 	TC_FAIL(kfunc_call_test_get_mem_fail_use_after_free, 0, "invalid mem access 'scalar'"),
 	TC_FAIL(kfunc_call_test_get_mem_fail_oob, 0, "min value is outside of the allowed memory range"),
+	TC_FAIL(kfunc_call_test_get_mem_fail_oversized, 0, "rdonly/rdwr_buf_size exceeds u32 max"),
 	TC_FAIL(kfunc_call_test_get_mem_fail_not_const, 0, "is not a const"),
 	TC_FAIL(kfunc_call_test_mem_acquire_fail, 0, "acquire kernel function does not return PTR_TO_BTF_ID"),
 	TC_FAIL(kfunc_call_test_pointer_arg_type_mismatch, 0, "R1 expected pointer to ctx, but got scalar"),
diff --git a/tools/testing/selftests/bpf/progs/kfunc_call_fail.c b/tools/testing/selftests/bpf/progs/kfunc_call_fail.c
index a1963497f0bf..6144ce3ff0b2 100644
--- a/tools/testing/selftests/bpf/progs/kfunc_call_fail.c
+++ b/tools/testing/selftests/bpf/progs/kfunc_call_fail.c
@@ -103,6 +103,39 @@ int kfunc_call_test_get_mem_fail_oob(struct __sk_buff *skb)
 	return ret;
 }
 
+SEC("?tc")
+int kfunc_call_test_get_mem_fail_oversized(struct __sk_buff *skb)
+{
+	struct prog_test_ref_kfunc *pt;
+	unsigned long s = 0;
+	int *p = NULL;
+	int ret = 0;
+
+	pt = bpf_kfunc_call_test_acquire(&s);
+	if (pt) {
+		/*
+		 * rdwr_buf_size is a const int, so a C literal is narrowed to
+		 * 32 bits before the call. Force the full 64-bit value 2^64 - 192
+		 * (0xffffffffffffff40, > U32_MAX) into the argument register with
+		 * a 64-bit immediate load. The verifier records r0_size from the
+		 * full register value and must reject it before that value is
+		 * truncated into R0's u32 mem_size.
+		 */
+		asm volatile (
+			"r1 = %[pt];"
+			"r2 = %[oversized] ll;"
+			"call %[get_rdwr_mem];"
+			"%[p] = r0;"
+			: [p] "=r"(p)
+			: [pt] "r"(pt),
+			  [oversized] "i"(0xffffffffffffff40LL),
+			  [get_rdwr_mem] "i"(bpf_kfunc_call_test_get_rdwr_mem)
+			: "r0", "r1", "r2", "r3", "r4", "r5");
+		bpf_kfunc_call_test_release(pt);
+	}
+	return ret;
+}
+
 int not_const_size = 2 * sizeof(int);
 
 SEC("?tc")
-- 
2.34.1

