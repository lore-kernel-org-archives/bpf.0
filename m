Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792983816;
	b=lSs7IHbZ3Jb2Nodw24o/oyDSdyDmLRl+hI/lNBvZ3eSUtz6V+rOaNxaPIG7SW86L/NKe
	 BVbXVZnNBn3sc3ctpoRo/Z6PbrkCyG8kLUE7/nPxMqHNPXLJLck1EkL3FcKiHZ3OElf8e
	 eNW1qoaqgDFGfnGyHi8ueoiX0/ZoBfuw2Ipa+FvbvAinSsdQtE0E2zHmpBPTm2MLHel+f
	 lFzNFyEFfrTbxBoKcZDhLgrxCHd1HmCB3XaCvtLGs8rEaV/hy4sh7iL7KZmEWlMzrVU3t
	 hYq//TcOBaaeBA47QLpnHhwHogwaf+KZzQUpLqVRx5yzqzEsmOrxXPKF45T3sEsfRVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792983816;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=brW7gDOo+PMeivDLZWVgGTU/T5u/gDbmm2VD/2RDByo=;
	b=Y1V5LyONTrd8sSn8pcXCh64zvSt04kWt/O8NHCod7v8x6GjEpIF5Hk86jGucXtXvhX7w
	 v4VukqRH7FMeEFGFfFBXdUev2lKLQyqNmengB8LBJ4n/vb8qXUJpczRKb0R2tHxi1qFbt
	 IkwIMAKmTw9uwJsNM+kyXWdkYQrj0i4JOJ2u+IuMTkGXHiTQqge9zwSjx6L1ID6gkAnET
	 Pku5JGpPB/jIfA0R85ThpAbFaFBd4GYUqoYEPQ8IP6oyaDfGCRJ3HpiVhpiXeqiR6onjn
	 g4+o4oZ9gsuVn34xdgYh5yqoSfPFZdd1Di5OFcu7r38vKfq1TX3xKkSMmk5S5WuwoJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jOA0Q7fs;
	arc=none smtp.remote-ip=209.85.210.169
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E98C606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:03:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E98C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jOA0Q7fs
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8a05e3f0d23so918973b3a.0
        for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 20:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792983815; x=1793588615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=brW7gDOo+PMeivDLZWVgGTU/T5u/gDbmm2VD/2RDByo=;
        b=jOA0Q7fsrKKLoGfUCbFD30hEQdTdG999Y1Txp5Gol4IyMcb4i62Y3xOiwWOZsCNVz0
         LdyTwY0c5upcmiz8AgitRpII5R0StM5RZy365ini3T6i688IcHUzi8isHeoR3/M+WGPh
         /f4aMGQ5ETvmIaxR4qSYwnPG4rkel7BMEfapqncNM7yEa/XQAR02P9cBxRP70tycMPV1
         R5xzZtId0NB90OIQnD9fLwiXVpWFKYCGJKl6h/ec5vQ0rqMSgfadpyyLruRcbER91A+9
         Ex679ukX5nrJatg4I/KvcdhRwmMsZJ5LjSGB06kg4gVkhkNwXUOpDkTbjNG9+Hxlra05
         gwig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792983815; x=1793588615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=brW7gDOo+PMeivDLZWVgGTU/T5u/gDbmm2VD/2RDByo=;
        b=gDpM83cFdrpZf1/CJXU+8EVyh3b1xqTp6qDhI524BDToGo1WzpmqGCMz0oZSOTehj3
         7021KvLR/AqWmMwiw4kcForMDEswujeN5RpNUc0Nld/f/USGo71iyYrK8xIbQ/hKBdTj
         9Zr7S3LB1x70iJHlkf0xm3qbEA7yX2p0GSNEOMfPt9QDGhyJeFrL39z1c3gh1D5e0Z8W
         PGEwRN7xrPax2X5DgEpox5QA8+g9cdNGMQ2JpUHkigxhVAaK5Q/yXbf5WiBvPJ4KyvSS
         DpPgG94slGjGivMva+XbufU9dYc2AC310+ay0v1rXM12FGk19o89u6UrlurG1WUH6ZBH
         +/Sw==
X-Gm-Message-State: AFq9FYKe28ZGn3G2V/bNDKX4N3cTYVwmA368qtm3MymYcPmdl6oZ5jDJ
	c8WyyRwDkDCArhDuoVFZqmmsEm6Qazk0RBipIMSRTQPhDfX60dP3M3zmC47PsA==
X-Gm-Gg: AYBFou1gmT1P1De9xaksi5gJ6HWdbLiED7GS1rpGm54Bl+yRbmSY44876hJlB8QPe4+
	RjYma3FaftZXzomjff3QNYpyjihSvVa4BpFdpOF2yDT21KNtZw2wRtyCNm8RA0hO84ojbfohvaL
	VKfsRnZf8jPAQyccCoRwfaTK5Wcvjrs1y3ckZ7zSGE9qKJrrrLoSNdPNBDI4gsfY5L3u+fwDX40
	TYNFSrKG6rrn4EqekMkZ+ETlevUyiPf8QDySIl1Oglgc7aNWGw8trWuyfWJnKibOzeEOgq7mJ/E
	C7OxKBfOM1qS99KwAlgVqhIJJEgivO91sPcUr6NWdtntKJSifiPk+HaEVpUlPq8J2OqaUO1Tv9o
	HZ9mVRhNnfedIubpXlA9eqjythfXHJ3Jo093PAcQzDGYiQvX3pWJXCSEUbg4Jj8hkKZyl7FIK1g
	aTONN5YTIti1vfNIiq48txVsxpEUfqAKcjVEuYmro2VJxDlxeGU0GE3Eh/FwumM9UVGX+VLbzdM
	iXtYgrSOLl+kkCs29SCI61ZA+N4O+28E6C6iTnGAipnAZgJ4P5YFXUb9gKHu5L1ASU3h/T4zBjS
	s+vTgTyYT6UfZsW0s4etTnhNugUrAePYxS6C4Jxpn/EewCHAds3OIzhzS+WGWvi5qNYgRrHNdZN
	N9xOBgQI+R6FkgssnaQj7KY5h
X-Received: by 2002:a05:6300:4093:b0:3e1:3a2c:8d21 with SMTP id adf61e73a8af0-3e7bfa6d034mr4393372637.31.1792983814885;
        Sun, 25 Oct 2026 20:03:34 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd8ccc45a19sm1056970a12.12.2026.10.25.20.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 20:03:34 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 39/81] selftests/bpf: Test scalar evolution with a latch on a 32-bit copy
Date: Mon, 26 Oct 2026 02:59:00 +0000
Message-ID: <20261026025943.404450-40-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
References: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
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

The prog is what clang emits for 'for (i = 0; i < 17; i++)'. The latch (the
jump back to the loop head) tests a 32-bit copy of the counter. The prog
makes the copy before the increment:

  1:
    w1 = w6
    w6 += 1
    if w1 < 16 goto 1b

The test expects 'header_count is 17'. Without
"bpf: Simplify (zext32 (zext32 x)) in scalar evolution" the message is
'non-linear latch'.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/progs/verifier_scev.c       | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_scev.c b/tools/testing/selftests/bpf/progs/verifier_scev.c
index bd632951492a..5a7c32ce1c6c 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scev.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scev.c
@@ -1411,6 +1411,27 @@ __naked void widened_reg_is_not_linked(void)
 	: __clobber_all);
 }
 
+/*
+ * for (i = 0; i < 17; i++), the way clang does it: the copy that is compared is made before
+ * the increment, all in 32 bit: (zext32 (zext32 (linear r6 1))).
+ */
+SEC("socket")
+__success
+__log_level(2)
+__msg("loop header at 1, header_count is 17")
+__naked void latch_tests_a_32bit_copy(void)
+{
+	asm volatile (
+	"w6 = 0;"
+"1:"
+	"w1 = w6;"
+	"w6 += 1;"
+	"if w1 < 16 goto 1b;"
+	"r0 = 0;"
+	"exit;"
+	::: __clobber_all);
+}
+
 const volatile __u32 rodata_bound = 10;
 
 /* for (i = 0; i < rodata_bound; i++): the bound is loaded in every iteration. */
-- 
2.55.0

