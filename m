Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792983792;
	b=YdK7hcOvO99G2PPUeN/A7Qkaw3M77hjjm/juSyz4O7wpMXgeBtQ70fNiz1EG4dEHkcmV
	 p8UW/gQ/oHDGVlE7MuyL3VuGQew/8AkqQQVw7H5qUkQmj/dyrCJL1/P7FwG6MYVz8df47
	 eryZKOIfU9pYGFmJsx7IgZ2u735pOlskUTNgSb5ixX4ohQ4wia76fRYDYyf4pMr5FSfQe
	 4Ndmasnos9CRLn+39JYR9uDIdHHmekdJy83zRpBuJEx5RaCQOtkofGF85TyzTZbAUinsy
	 xAyATjJ0g/zwIRwXoBeOkZ1YTGad7fuxDRQxF6ifTwF/vDZKOskkv08RdVPRbHdb0CQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792983792;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=VkxrVmebMxgFbej3ZfdH6SHe5ULw8TQfczZIRNHd+D4=;
	b=JS5rGKemcsRSWoq+KTuOQkShuH5HEyWNmKNCnofzXzYReDsRS4Yzf/h5gpgYQg6R3qfZ
	 XHjPkOsQWNt00q3g0t3aqR2Qbf+3Vnxvc/H4R3IYPH2dQArxfEBUm0ITKSBSEv2nwF+K4
	 aomJ84XWquhkvOV46idtcg0yLjfL5LVZt/0BN0YkcbnctU2dofgBLxDtGdaRGXvq8ryOM
	 U360N4zOOy68DOXaoR8IHoD9z605mTNGZyg/XTI8IgOt72/OaS4RYTuwiTzhnf8YdQ5Ul
	 QxAJLZ9OlPEG0y3ycZ805ws5S+TSNflLYDXfSMZvLH1wyDtu8BmvEOopTZSU37Y10Rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HAMQSpks;
	arc=none smtp.remote-ip=209.85.215.173
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8066E606A31B
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:03:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8066E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HAMQSpks
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cd6a7e1f4e4so812636a12.2
        for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 20:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792983792; x=1793588592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VkxrVmebMxgFbej3ZfdH6SHe5ULw8TQfczZIRNHd+D4=;
        b=HAMQSpksuKdAX1JejcR+5b/f0Lrx51ObKwUTQPs43jaybYxZRthtTptc8atm3tv4+S
         vkwnKossbdkfTDR1vscAl/jhLURPYhbjiEFShW6adNLcm0Gy4u4iwkjue3gXQUfQgVuK
         KybmKhdpkqrNQcvcTnkTvV5bDrD5lI/Q4v6kF83oAclpPRI8D2cCk7GFoEwJ0n1FNx6C
         iH6/Rs2uV47f5D+rXnL4sHdD/J8fqPHAgDIWBYQ88/dGkVW6gAoDXkQZaic7Y7ycXrlJ
         hlCObTrT6ghNK8WZLR68Z+ByFR7TDClIdKoG+iUu8AH9b6deTu8djJtDNYXen+KNDRP0
         HOUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792983792; x=1793588592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VkxrVmebMxgFbej3ZfdH6SHe5ULw8TQfczZIRNHd+D4=;
        b=fwjl5qYH92jbKlHdQRzX0efoNvL9QncJoT4aYVB4TBNBoNyhI2mo8rcqxVEmOgkvBs
         /lrnEFbEeNudQdfqFuQgJqzF1Brj3L0qAe2NOmK73uSw308yIarDSUOD3edNpwiVGuIl
         wQWuVctHXuym29K9v7kLR3gNN1ePDCAvd4UtTsEsILAs5YTeEW2p6HLNwnFTW1qppO+j
         vu4TCllmB2TSORk0wUv2Hw+XSgSELjWYHYizQz+PoULq9bSV451hk+5e0zATFgaMM0VZ
         xDu21ZWhEopCoB6p6s/J39zGImqO+G4Kuduz9iUjRMya+4d9yMeczE7yNG9WZ7j0DYd1
         lqHA==
X-Gm-Message-State: AFq9FYI2w4p5LuZijL5XBSspdkq+6iEmtcLsIjVQE2zTd+sv5uuOvIf6
	O3W1wYIbEVTq+/9jRBp8WwMxw9VgW9JZ3PPQzBQl4+m+IU4kf3WzdlYkGopRhg==
X-Gm-Gg: AYBFou0dKXp9zWxL0rubTgTHCRgfcy2rN/tDLCdAI2V2SG2ffmE/W+8f6ijPmrzCe/k
	U6gq1gAy1Ro4nVyv3SBcQChNluUuxIlDJX5ROjiQH9UbQTkvnzu/0rf8/i2b3HFMWBPcQm1Yhro
	iAihGKNfjl+OrSWiZjIQlnDldr5s/L1NevhAhECGRxC/yYcH5kmEOrJdaNHrCZMuqWlQqUbXTxG
	RA6j+DRjWVzOCOt1VN3D2CkTvxj6ITJ33zPc/2yJWwzkO5yhcrIbxGR0cm+x5cj1pQaQy8joBgE
	meGjA+Tp1K6P5CgAyTxtnKGtR84q6lJS4/Yg0jRJToq89MW/urHagUjnddXSDRyGZsC+DGocu5Q
	TJInoQGRsHmb1WZ4w11WluQdjHvOT0XVZ+flX48sAvf18SzYvHAX9Mtb/stuYpPxPSf0gFBDIlZ
	NQW50eefljeDl7L1PHB3ET0nGkSWywL2+fzGVifgFRUk2NVFeEY62sCCkTCtxz0X/JV4UlLcKrU
	DBqK3HDEO+X8DtNmOWh5P2viNPL1RJQfjkiu8ltUcWkOE3j4chrlu54fXT1QdNEoYSbZhyHH/4q
	bRQHhlR+kS0ZdjG4Z/W2z50IVD2xviHwkB+K8hMByCUTteCU9k9+w0WsaN6hrF0OBB3i6fVOa7s
	8aBNnpbKOvirR46nJCAXGWp94rf8j/j1scUaJspMwwS/UEA==
X-Received: by 2002:a17:90b:58ef:b0:3ad:93b4:718f with SMTP id 98e67ed59e1d1-3adeafcf07dmr4722454a91.65.1792983791707;
        Sun, 25 Oct 2026 20:03:11 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adec0bcb18sm6341853a91.15.2026.10.25.20.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 20:03:11 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 35/81] selftests/bpf: Test scalar evolution with a loop bound in .rodata
Date: Mon, 26 Oct 2026 02:58:56 +0000
Message-ID: <20261026025943.404450-36-alexei.starovoitov@gmail.com>
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

The bound of the loop is 10. It is in .rodata, and the prog loads it in
each iteration, as clang does for a 'const volatile' variable. The test
expects that scalar evolution calculates the number of iterations:

  loop header at 3, header_count is 10

Without "bpf: Let scalar evolution see loads from read-only maps" the
message is 'non-linear latch at 5'.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/progs/verifier_scev.c       | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_scev.c b/tools/testing/selftests/bpf/progs/verifier_scev.c
index 61bb39a12de2..c242724686fc 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scev.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scev.c
@@ -1411,6 +1411,29 @@ __naked void widened_reg_is_not_linked(void)
 	: __clobber_all);
 }
 
+const volatile __u32 rodata_bound = 10;
+
+/* for (i = 0; i < rodata_bound; i++): the bound is loaded in every iteration. */
+SEC("socket")
+__success
+__log_level(2)
+__msg("loop header at 3, header_count is 10")
+__naked void bound_from_rodata(void)
+{
+	asm volatile (
+	"r6 = 0;"
+	"r7 = %[rodata_bound] ll;"
+"1:"
+	"r6 += 1;"
+	"r1 = *(u32 *)(r7 + 0);"
+	"if r6 < r1 goto 1b;"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm_addr(rodata_bound)
+	: __clobber_all);
+}
+
 /* The unknown SCEV of an unbound STACK_MISC slot must not prevent widening. */
 SEC("tracepoint")
 __success
-- 
2.55.0

