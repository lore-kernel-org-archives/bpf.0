Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792983804;
	b=fV2YY74hcQ2HVleg2FbI1IRiObTs0W8KSjbCA4AcuLbNZkrs9BqvjL1bFPfsOzRFbK9a
	 YDVUvZIDc4zHnje7f3h8DEbbaLKhQvZqZKbsIgtxXlkK7YSMnjR7ktzc7/H3lncx3rGUY
	 0j1uzIlCRwVUmNzJwGZ0xDSE9c8e2N5l4EkNuJCJwE/llWiGGK0atPwTyBpLpstLocC/4
	 dkLlxKyL1VJxZi5ANAUH8GtbseIJHGRglZgtGf3tK0cnMtooa8tTrsgKfF1/97GdAYWVi
	 iFmw6wlXaOSRNtqaQ1WHa7gnrnP4aFNtjfZOr+IgRlhjsEx7cbAjWapUn4dY+JkGK2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792983804;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3r/y7vdt1rRdWMqpiQMGkprFQpOZn7RiEh6f3Sr5TX8=;
	b=sYRRJpiq/tvs7yGp+0/CEi5U2u27K7SuYRdSppAlfdt566m/v6qKvi9gU9D0bWrAalpd
	 vAl8iVPu1BODR3uSotV+BMZLzDNxKsA4iFHh+wg85vWASwyf6lbIig0CJ6uQu83VkTaA4
	 7+2EvIJq5kWEaT46QRPaPNkpfwjRL7e7tzDrJ0fGzKg6553mMep5V7V+VB11Ed1TyUgr4
	 gT9SubJGG5Z2B1evk2qoX2s0WHaagW1Y5emOHhT9UKTxHgjz5TvpphOfwsR8ifalIgLmp
	 i3iBZZTt/PbZCoy35smm2fV/v8WzHZ2rLTjDTOi4sccQahAPF1XOgW3rcT7PL5Axsww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="bnn/ZTgH";
	arc=none smtp.remote-ip=209.85.210.180
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D166606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:03:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D166606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bnn/ZTgH
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8a4c72951b8so557328b3a.3
        for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 20:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792983803; x=1793588603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3r/y7vdt1rRdWMqpiQMGkprFQpOZn7RiEh6f3Sr5TX8=;
        b=bnn/ZTgHNwcjaSTrljEO/KbYsnKymcdIx90q/jJ+CIzAKWcSVmq8LPKzqYLEJ8GyEL
         i/ake5FAaTPPVlzHsmLjizASkIzrT6fvoSMyGpj/gtQtogmKwKrlcKufarvYyoZ2yRbr
         Jzx0CLCr41UDCVkjfhfOUGjYbtUYUG7WIOVv3NHCkSt/urVPl60Emb0dLcRdLFZowlor
         1rYMhk8uQ9YuCMGY9O2OazkH0XlCmA2If9v3RtI7cGerA+6UpzqLqB8e+73S8Snt++9y
         CP2Zx0kamentao9YHTnhI8DsBJmOLpRRbDe2dZXrlSStnmPOW40UUa6oO6BQg1a0Dk03
         LjTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792983803; x=1793588603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3r/y7vdt1rRdWMqpiQMGkprFQpOZn7RiEh6f3Sr5TX8=;
        b=nneR0Yfd7voLoyAG4LaLYC82PsFXQ8BQgZnN/yt2CrQknJv+DpeGBZfY5+CIdpFlru
         sSukTtrAyQDNPjIvaKz5XkO37yxohluKPY4WY4aAL+6kAb9GdBswJYOkXu9ayywXC1F4
         BMZesO3URDVX6HmMQR1qlQT/5nU0VyGNH/5s4B9DnQoKzAgA+Kf+EO4B2NaMH5S0cmYT
         pzm+m6XLm9k+tnOVsHHFPxND8aEBtkPChDL/T3Wbzk4Z6VayeThxy7yd5cIZN0lfgZo7
         H7gcHWBCy+ScuoSO7twnFSkSuiKNH14VxApyEciJK7cczcBWSCMgXmn3Ot2eDLw+JT1j
         nkWg==
X-Gm-Message-State: AFq9FYLHwMOtrx5M/SSoNjX9eBwyF8xhESr3z1L/+W9FiyPzX73EkFEK
	3LL4wHSsfiAKFfvU65MoXQ3AG2wohX5TUDykvj4tV0oiM00DGACKwUrMLQ8Djw==
X-Gm-Gg: AYBFou3N5Qq1a3YxRAShVZCbmGa7vGzby6wNm7mmgGF593KJO65cmamXttjyy0h9+2k
	2GJ177P6O/JCbXHGv10ayKysI2oAcStutjVQV9RDzdJE1+eBW0JFFQF9sg5BmfmJ2/lKbwlhChH
	zReQXJPi2t60gUSnlWvKwdnWa0E3P4RABw68lvJ81KNmhqLfbbsZmSnRgV2TxhfRSfzMBkZstRW
	h4C3nkGLmPM4W4NRoWe8PjloyBmDyO1TqD24OQIG/XDRKhHpvtWlcTqLouil7XAudFZKJiVt0Br
	WtPD4pPSbYf3ZZSpXamyq4K/Fu9QJxHgxI6YV8MezGjM3oYa4EGKPdKsGzMxEDieR7OEFyqo5IG
	hVmyFqwp1QT+H0MSQqFEYES2WZyHrqURyZs1J00A4SAujGaSY+YWDz+GbST/dvUxBYjvJ2I2ML9
	wp6Atog8YArCUpzIExTY1fyNLyDJHxDRft9a3ds22x/mBMNB6iDRei/YMm1W6ya2hc6XuqdZHiH
	899ncReXV1n2zbG2QGY2P3SI9qQepnuEWDP3IeCLnEH97WVucQvOBu8zoN/9Qko5sXDa3G6rF32
	IbAqaO8znrRCHX1uCadBEwfDsJafRp5mGQvOHbwJYaLo/cpJR8KcBeqSJjimjfLbI8PF1KOxIBC
	BZDSUykfiyLuWvJjk+1kk3yuc
X-Received: by 2002:a05:6a00:288f:b0:890:a3ed:8a57 with SMTP id d2e1a72fcca58-8a36983087dmr4078883b3a.49.1792983803300;
        Sun, 25 Oct 2026 20:03:23 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a36c1f5091sm764680b3a.54.2026.10.25.20.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 20:03:23 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 37/81] selftests/bpf: Test scalar evolution with stack address as ARG_ANYTHING
Date: Mon, 26 Oct 2026 02:58:58 +0000
Message-ID: <20261026025943.404450-38-alexei.starovoitov@gmail.com>
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

The loop keeps its counter in fp-8. In each iteration it calls
bpf_probe_read_kernel() to read from the address of fp-16. This argument is
ARG_ANYTHING. The verifier assumed that the helper can write through it,
and thus can change the counter.

The test expects that scalar evolution calculates the number of iterations:

  loop header at 2, header_count is 10

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/progs/verifier_scev.c       | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_scev.c b/tools/testing/selftests/bpf/progs/verifier_scev.c
index c242724686fc..bd632951492a 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scev.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scev.c
@@ -1434,6 +1434,37 @@ __naked void bound_from_rodata(void)
 	: __clobber_all);
 }
 
+/*
+ * The address of a stack slot is passed as a number. The helper may read what is
+ * there. It doesn't write, so the counter in the slot next to it is intact.
+ */
+SEC("tracepoint")
+__success
+__log_level(2)
+__msg("loop header at 2, header_count is 10")
+__naked void stack_address_as_a_number(void)
+{
+	asm volatile (
+	"*(u64 *)(r10 - 8) = 0;"
+	"*(u64 *)(r10 - 16) = 0;"
+"1:"
+	"r1 = r10;"
+	"r1 += -24;"
+	"r2 = 8;"
+	"r3 = r10;"
+	"r3 += -16;"
+	"call %[bpf_probe_read_kernel];"
+	"r1 = *(u64 *)(r10 - 8);"
+	"r1 += 1;"
+	"*(u64 *)(r10 - 8) = r1;"
+	"if r1 < 10 goto 1b;"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_probe_read_kernel)
+	: __clobber_all);
+}
+
 /* The unknown SCEV of an unbound STACK_MISC slot must not prevent widening. */
 SEC("tracepoint")
 __success
-- 
2.55.0

