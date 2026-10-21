Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792608983;
	b=NCpzmX83uYaINWkq62mWKFFVERPLgMnNGSZptmP1VuLbo4TQpvoBVtB+vjOCk46FUHXy
	 BUyqVsBkin6gF9d51QHavi46DJhCgwe5iD7BsJbTQ4YyE1KDu9HTw+r1KtrBI/Jv4VFGN
	 DQdSmlK1K46cbi9LCPCi8EvHcMGSwIDBnQJegXVDjwmTa3Nrim1EkaCnzEVVqF1LSnvOv
	 UhcMPqszui+92BLKG9/mKQxm5Wzz/kaUYIAQdc33Q9EwOo9qND1J76mTjdhIa/cXz0tKc
	 5u5f183f2brTRZR/Eys4SLVV6Lp/gXyDDAHmrpXXFVSbcd0b7irEIJRD+nzERI4vR3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792608983;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=CenVtrZhFlCIwlIZaOLQ1YUvfw5G1+HTcdz1Njmvvv4=;
	b=xBQmjcB/nI/vrb97vQgubNAFfOmyQ9drxxfON0YXpg+6rgtw2Pt7rb32xg2uanCAxO6z
	 vvEny/oQAX9221deQt/t7kYC2E4zcIMejII91LFQxIvRRbIIpWIhK69S1fkQxJosiELkh
	 sQNfqCkDk6S95pHoi35EI7SCVDceIH2UjpMMSCz2jb5wAljoWCMAsv083UV0cnjzJxeYt
	 mwxghr2pS/WNvTbMpPIcH8pcF9iC9YxuJBEt7rwJokBFi+Kc97PGyAmqFNIrCz8KqeQ0k
	 u9UYC6l8wEAMMLrGggJMJJGHHrJ3BDVQrtGtFaRDUp0MPq/U1YG3eF0R7O6eqi7UEgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=B7NVKPVV;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2355C606A323
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 18:56:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2355C606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=B7NVKPVV
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-35c76e9614aso1922335eec.0
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 11:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792608982; x=1793213782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CenVtrZhFlCIwlIZaOLQ1YUvfw5G1+HTcdz1Njmvvv4=;
        b=B7NVKPVVubPPA8fNOTPHEPAJ7KLNfV9HdfceaNmW8h70aCXem3hGs5m6uWKWcOdlQV
         2lv8+UqNo7Um2jT9yFOxZGIlxY1eSRnq66G+C+DgFbuCWJvcjAEvnLSICKGLNYUvirqT
         qfh9ZqFZe3XOf3uKcR8pv8/miMt16DtDxEy+3Mycrcx/z6ifXMQZHOjLGucB6uucUfhE
         4AqAkNq8V295eRhtCW8BFfRljvJVillU6+/EcKjOaCda7w2UmMIKchk/VmyhOH2Yfubd
         ELyjDQPkM0+Hsueg/DSw2Ut090Wf6qqq38nvrg6Tt0j2e4oLwY7UpW8/UT9KQmjS6glN
         deAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792608982; x=1793213782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CenVtrZhFlCIwlIZaOLQ1YUvfw5G1+HTcdz1Njmvvv4=;
        b=0/00hAhltU+S5o7zLPX1wZNG38BXk+S7dHg4XXOBCP1S5u2Ha0u8EmuEdphCw2XvX4
         uiC2SFbxKWYIWYWGmxrowiBpSVeVQgxJOhPdLJBxZLB/jXsjRY5nISV+AkFBXYOa0Amt
         R5rXIjxbQGoOcRiQnHg6qJbxaZ6KUbJDKe2GnQK1cIMXeS/dGM+VuMrIF1nDQYQ/gcul
         rvbnH4p1D0fl29K0joqdFQlHpM2AeGJiX4kNgtRkZBbrz3iDQCcdpiidFpGy+icTvHqp
         YAUp2bjCwlHOjn8TAiVsd3hVtBJJJtu4Bq78SXaOnKGx+DwEO+4wSDvmO1p7p2TgCxWB
         j+8A==
X-Gm-Message-State: AFq9FYIaclgLbtHKhgSV+XDgx/MgR+sjyppISWG6BTv682j6palBm1oo
	5mMe7qJNBFWqOWB9bG39p7YBR2uzYSsH0gld9uNoRHup3ju2k7B9mh2hPBQMyz0k
X-Gm-Gg: AYBFou1k8d/E32QwaXF5FItgEGTa2u0Gdhr5DvvUseJGRDX5ybn1uHlMUTSgLL57nCI
	8lNq42q+LNlnwWGaIfFQd9eGeX9bWdc837BiNQQvmxSYaFRmZp1lJZzLzpRLS/nWpL4KxS1LpVW
	GaYsRmy2MhRUqxAbuFEUERF84/4pqoSsuZTBQAqDQ9qoVNbjALpy1lT1J1Sg3hMlOwWoV5MlJsK
	BXSolz6ABkh+nYfugEV4vW2mkXpa3et8AnZWJ6pnUCd9UrFubr6Rdpfvaj9uncopCu0XAYFp+bc
	VZEs8FobTQTvbnjoaCv1Q937fgHKAeC44s0pN4sazIVWNQ39SzrRZvvQT80IX7ayaw3H63PL5Ua
	pbdpvGTHVf2BsRGMVq8hwCMwbMVOdKKS321mvZIqBP2zkHtwX9D9o5Hmo/jDcA1rPOEJxMt6sWX
	DOZ0ERU2soAlj7mRefEK2mDSSA8I92p62DqyHDyTYbOzkZFg9XcIH6758AW8EXS3umWZUU2U43K
	vKNahdc2GwY5lUrDbpiZAxsiVsEFJjujv8VAvMTpqO5EEGTKg7FWH2HsQONzS36KrX+crtW2A/2
	nMNprcAD6u1QlD3aLsQffYoD+kycv0s1xl1w
X-Received: by 2002:a05:7300:f0c9:b0:359:3460:bc1c with SMTP id 5a478bee46e88-3674d445605mr3747383eec.12.1792608982164;
        Wed, 21 Oct 2026 11:56:22 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::4:90ff])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36741f753f7sm9193056eec.27.2026.10.21.11.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 11:56:21 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: pointer operands for 32-bit recurrences/latches
Date: Wed, 21 Oct 2026 11:56:09 -0700
Message-ID: <20261021185609.607075-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261021185609.607075-1-eddyz87@gmail.com>
References: <20261021185609.607075-1-eddyz87@gmail.com>
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

Add four tests for pointer operands in 32-bit SCEV analysis.
Check that loop bounds are not inferred for the following program shapes:

     32-bit latch          |    32-bit recurrence
  -------------------------+--------------------------
     r6 = ... pointer ...  |    r6 = ... pointer ...
     r7 = ... pointer ...  |    r7 = ... pointer ...
  l: r6 += 1               | l: w6 += 1
     ...                   |    ...
     if w6 < w7 goto l     |    if r6 < r7 goto l

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/progs/verifier_scev.c       | 109 ++++++++++++++++++
 1 file changed, 109 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_scev.c b/tools/testing/selftests/bpf/progs/verifier_scev.c
index 661ce9ca8f93..1d6b4839e197 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scev.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scev.c
@@ -2971,6 +2971,115 @@ __naked void ptr_stack_other_frame(void)
 "	::: __clobber_all);
 }
 
+SEC("xdp")
+__success
+__log_level(2)
+__msg("scev: incompatible latch operands r6 (map_value), r7 (map_value)")
+__msg("loop header at 11, can't compute iterations count at 14")
+__naked void ptr_map_value_jmp32(void)
+{
+	asm volatile ("					\
+	*(u64 *)(r10 - 8) = 0;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map] ll;					\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto 2f;				\
+	r6 = r0;					\
+	r7 = r6;					\
+	r7 += 4;					\
+	r9 = 0;						\
+1:"	LIMIT_ITERATIONS				\
+"	r6 += 1;					\
+	if w6 < w7 goto 1b;				\
+2:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem), __imm_addr(map)
+	: __clobber_all);
+}
+
+SEC("xdp")
+__failure
+__log_level(2)
+__msg("loop header at 11, can't compute iterations count")
+__msg("R6 32-bit pointer arithmetic prohibited")
+__naked void ptr_map_value_alu32_latch(void)
+{
+	asm volatile ("					\
+	*(u64 *)(r10 - 8) = 0;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map] ll;					\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto 2f;				\
+	r6 = r0;					\
+	r7 = r6;					\
+	r7 += 4;					\
+	r9 = 0;						\
+1:"	LIMIT_ITERATIONS				\
+"	w6 += 1;					\
+	if r6 < r7 goto 1b;				\
+2:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem), __imm_addr(map)
+	: __clobber_all);
+}
+
+SEC("xdp")
+__success
+__log_level(2)
+__msg("loop header at 11, can't compute iterations count")
+__naked void ptr_map_value_alu32_latch2(void)
+{
+	asm volatile ("					\
+	*(u64 *)(r10 - 8) = 0;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map] ll;					\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto 2f;				\
+	r6 = r0;					\
+	r7 = r6;					\
+	r7 += 4;					\
+	r9 = 0;						\
+1:"	LIMIT_ITERATIONS				\
+"	r6 += 1;					\
+	w8 = w6;					\
+	if r8 < r7 goto 1b;				\
+2:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem), __imm_addr(map)
+	: __clobber_all);
+}
+
+SEC("xdp")
+__success
+__log_level(2)
+__msg("loop header at 8, can't widen r0, expr is (zext32 (+ r0 1))")
+__naked void ptr_map_value_alu32_non_latch(void)
+{
+	asm volatile ("					\
+	*(u64 *)(r10 - 8) = 0;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map] ll;					\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto 2f;				\
+	r1 = 0;						\
+1:	r1 += 1;					\
+	w0 = w0;					\
+	w0 += 1;					\
+	if r1 < 4 goto 1b;				\
+2:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem), __imm_addr(map)
+	: __clobber_all);
+}
+
 /* Metadata and packet data have different origins. */
 SEC("xdp")
 __success
-- 
2.56.0

