Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793483771;
	b=2WElpPbR4oz5CSrMmOyuWutzia+e17bNh6Jn2CnGNQk7X3QCf/qJ3AVS5LBz/6Qe8DuZ
	 BcOoYBHK2c4a7Fal090VDrqFhF0lHGtfx+27W4R9/D1m7AaIR1zBdC/TljBKHuWclCmf5
	 AcOwMMocpUiH7XrHpLISoeJ8QAGcUX7HJOq6T0GyjraBnL8Og0cz38l6AllOMcq0p1GLB
	 aZhCUgnxnQpaqsWEMTd7aE0vGeS7F9Hb5QhpCXuwsgbJvOu2ZCQYAsULczThpMqbLAg5V
	 I63egWAHI+gKyvY0iNmZgFlvJNnEtUmzRiBm/Otj6lBRVxa1xhSBwudJ751sJ4n5FUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793483771;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=q14RjMpudaFdUjddLhv2OAVcO4AQVOykTv5dYcxhOCo=;
	b=ZUaFf5NLd+ikP6Gc7g96nfQC9oHkmfxTzV/8f/5E+wmTc6McDlyddHFI2Jz0me1w+qWA
	 82GKDT7rtCQBE5Ik38g6kp+WXC+1R5HXO+kwrXLE8BTnxAdANowWBYkFsd0OLDIT5MPXA
	 v9jNl8GtQWXrpi7m3D+q4T7Tce+HA/ajY12J9SWP+BvLolF2NUDYfvEO25+heDxveYz3V
	 2WATVcx4MQvrJRQ0g+whr/VGCLmjlh9Zi5jYlmj+CEWCzU6z9PPsL3tfyGhjxzzkAS0oS
	 Bl3zsovp1zYuetPQlonD/BCIqNpAOF1MQqpfOTLv6tXFymX3ALP0jnxDASaQmDu/UlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SnfRYEWe;
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEB7606A333
	for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 21:56:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCEB7606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SnfRYEWe
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3ac77270fbfso881455a91.2
        for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 14:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793483770; x=1794088570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q14RjMpudaFdUjddLhv2OAVcO4AQVOykTv5dYcxhOCo=;
        b=SnfRYEWeKJeL0PM5SNBJu7ova7K2xWyKEGLTMUOnpeUx0optRUWyhuZgSpJl1g2U1V
         oADdgEnBKIS7z4zC4Xcl72V7wLZNTcaIhONAe78dbL0ENndE/M0KMSp7tR6S6KKZzzkb
         m5VSSpbt2ufnc5M8c9gpllKW74DWFS24Cm46r2OtfBe4Jm5ijLD0fY2qwwIkjj7LD04H
         Xv8PkOCTPl4yqyDLwMD0jFAlJar0AYVph9e0eNU5kmJtEHULOoI0rNGre0qp1gpZGsi/
         XdcCpb4lgn1PHfq5DOefXmTxMyT78tmTkk/y0KKGLWtwi23l+VFc1G6nn1/408FJ1ZBX
         6kWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793483770; x=1794088570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=q14RjMpudaFdUjddLhv2OAVcO4AQVOykTv5dYcxhOCo=;
        b=uRABEYLZPu2Jo9MOjayWphvmnpxyst9WOU7HETZ/WCpCIOMZ5Xm87Pj2UCA8CQUTMX
         CY+D4ncxd4AFH2ng6bybGxDHM1Wxghsn/yFCGN2s0TqdBFFg/KIw1Ln9Uvx7Kjm5qM7u
         Xcp4/cIGWt1MCJIV2gApd3qgjru1f/FzI8jl+C29Qyt9bT2TmJfILOKJ5HdAPKz68Sgg
         8M4nHZ9Hq1ucDHrRty+/C7ExsibqCFC/hp9WiuPTrRxjUI2LcisRsAfaxDx96Ng0yEIz
         7CPz05NtUhQ42gCd2yY0Cr4pqmZD1dwVWEkis/FCi1SENDm5sKXkvSbxKrnfu/UFsxgL
         aFEA==
X-Gm-Message-State: AFq9FYLrE6MBoZxL7AnaC+ks+2OcpID8vYfJiKj/w3qAqbRxSknQqFa6
	qmWfTyF4hr6rmLXfbJfA2B5L0TkwHAsQWd3seZFXfvcoG28zm6Du6XF2jLzF9w==
X-Gm-Gg: AYBFou3drXt4WX7Gw+ZgCmFdNrTLF5CeC/8JJA24AZVWbT0x3vhkk+Wgm/5hStscNGg
	MuaPqUgkvxl7vp9RFHteKpTxBaSr5HcwvDEh2pD7DAid14xec7F7w5jlpni7wBaM+aPCzp4A6kO
	aPfScGW/uid5xFMSK89LGhzz6M1Vpoy/VdAZt+8YC5nS7PKLGdWTDDT4w4DgXsPn1V8QFDZFYBs
	gyBLcNw/uNKtBejyxDEGEHha4v/4SRP7PpASR7sG1LPI1VEcNSUXMOg3gYpKndC1MLk0QP9Y1qJ
	y/EZkj3qUFQiiJHoJtX5LN4hjJu+mHWlGH7gGERIvdSvrlf3vny7JbxVAj3vEeK7OVwP7ZUYvi6
	enP6/nzwyVXmle4a406ZKDaoAph7V5DUw3ioMHjYkK1x5UGaYkY0tW21O8Zf/KqGMgtEe3FH2tE
	n1ZJ+bx43SveOrKbX5PXByA1Xc6tixyTrHfzX2fMmi86S2U0WVjMVoZUw6dvDcfXf3I9PyQwQOg
	r+nMrVmK0q36yegZ4Hflz/ZtX8yiH5jsYsjwIXZ/bOF+cx7IWstOq05tswAK1avrWFSLMvdvDNP
	23X0IGS7qYHwmoUmDT8XMbRCybBnlVCz410C0/38N2fqZzUqILFhmIyOoU4JWNPR9SP4YELBoO+
	VSw0SNzHnPquAMXemTiBObwMM7xFMUOKLoRS5XpJn1PHwbHDKJjexYkfT7+UVHGfZYm/q52PuGx
	c6nHHMl47YFBBz7J0Ycec=
X-Received: by 2002:a17:90b:2741:b0:3ac:7556:8eda with SMTP id 98e67ed59e1d1-3ae897b955emr4934907a91.26.1793483769459;
        Sat, 31 Oct 2026 14:56:09 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae85e4ff4csm5039128a91.1.2026.10.31.14.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 14:56:09 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf v2 4/9] selftests/bpf: End the loop of parallel_test_bitmap after 50 ms
Date: Sat, 31 Oct 2026 21:55:38 +0000
Message-ID: <20261031215543.682284-5-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261031215543.682284-1-alexei.starovoitov@gmail.com>
References: <20261031215543.682284-1-alexei.starovoitov@gmail.com>
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

The two progs of parallel_test_bitmap change bits of the same words in a
loop of 10000000 iterations with can_loop. The loop goes on until may_goto
stops it. The functions that it calls retry a cmpxchg that fails:

  do {
          ...
          actual = cmpxchg(&bmp->bits[idx], old, new);
          if (actual == old)
                  return true;
  } while (can_loop);
  return false;

The retry is always possible only while each stack frame has a time slice
of its own. With one time slice for all may_goto of a prog, a function that
is called after the time is up makes no iteration. The bit does not change,
and the test fails with -EINVAL, in 53 of 900 runs.

Leave the loop after 50 ms.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../bpf/libarena/selftests/test_parallel_bitmap.bpf.c  | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/testing/selftests/bpf/libarena/selftests/test_parallel_bitmap.bpf.c b/tools/testing/selftests/bpf/libarena/selftests/test_parallel_bitmap.bpf.c
index ea1fac95b461..017add229bef 100644
--- a/tools/testing/selftests/bpf/libarena/selftests/test_parallel_bitmap.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/selftests/test_parallel_bitmap.bpf.c
@@ -11,6 +11,7 @@
 #define TEST_BITMAP_BITS	(2 * BITS_PER_LONG_LONG)
 #define TEST_BITMAP_SYNC_SPINS	BPF_MAX_LOOPS
 #define TEST_BITMAP_ITERS	10 * 1000 * 1000
+#define TEST_BITMAP_NSEC	(50 * 1000 * 1000)
 
 static struct arena_bitmap __arena *bitmap;
 static volatile u64 started;
@@ -129,6 +130,7 @@ static int bitmap_test_common_single(int parity)
 
 static int bitmap_test_common(int parity)
 {
+	u64 start;
 	int ret;
 	u32 i;
 
@@ -138,6 +140,7 @@ static int bitmap_test_common(int parity)
 	if (ret)
 		return ret;
 
+	start = bpf_ktime_get_ns();
 	for (i = zero; i < TEST_BITMAP_ITERS && can_loop; i++) {
 		ret = bitmap_test_common_single(parity);
 		if (ret)
@@ -147,6 +150,13 @@ static int bitmap_test_common(int parity)
 			break;
 
 		bitmap_test_reset_single(parity);
+
+		/*
+		 * Stop before the time slice of may_goto is used up. After that the
+		 * bmp_*() functions can't retry a cmpxchg that fails.
+		 */
+		if (bpf_ktime_get_ns() - start > TEST_BITMAP_NSEC)
+			break;
 	}
 
 	return 0;
-- 
2.55.0

