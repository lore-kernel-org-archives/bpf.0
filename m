Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415567;
	b=cO1RiHIbPOGyKWayLnFNGLPKRkW1SfQ6G0jYV80huEYhSHwvQJKvziWkpIzFliuX7l3P
	 IvorsH7bG+tdx1LsfSBwD7qMxJb/C1itmQWDD1pvRIKJQjTWzFAg10B1qC0PUebJruBDg
	 4jogrY0bWFEp5UAflpJ3B5zrODzQZrBgTVHrgXCcsVXpcMfyMt1Chv3emXtCaP7iiXBoT
	 yDjE1dasi3dR4AKpCEcX/gaMRoVbmDKs1Q5Z/3mzvyLsUAbMJAyqCSpwT8fW9fgeo0qV6
	 HK9RJP53E+uR5YgPQ64z0SLNiUxK1lKTrMvDQ9hmeSbRfxrgv6Idwrq+RCi0FGPW40g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415567;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=W+wFrqTn6TpSzq1GtCMNbpHfih/1qK8FVl9ONJGTXVY=;
	b=RSyxSQa1vWSbmW/d59WaD4O2zi2HHjqr2mNUIIllr8VEOR+dHghuzCUzyTxPd9t9bboF
	 3JWwLpUoY65KRbnroDYVForq+vM9VCNFgAl1LklnOnqHr7fehcBTXyBX+1hhggofGxRQG
	 j08gmhdMDOFA8Ee72azSiPGQp0kUQViOh7Nj4dr3npuFuzWcfwTmVDyliY9MT6sS3cCFj
	 VFJq2JJJJmIDlBIgUXom/h9viremNJ3wsnidVsb5nyvjYGoX+iK/bdpAyB4eGSltODZVw
	 ddKwcplH7HuzMq+vPAOlrLX7tYbwd0w7jYxcBte0WK4d9yA4fiI3aKSCz0jFgg1UzDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZphycQYZ;
	arc=none smtp.remote-ip=209.85.215.170
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1726C606A326
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 16:46:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1726C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZphycQYZ
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cc147d86bebso18083a12.0
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 08:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794415566; x=1795020366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W+wFrqTn6TpSzq1GtCMNbpHfih/1qK8FVl9ONJGTXVY=;
        b=ZphycQYZmbmSQTa+Fvc2bIa3IPBYXi1inCvRNPOKTVxruuxOt+DH2wjItSJDQaHOxY
         GAbF3cEIM/b3KrSQ597E1Mz5Q7VCY3URyp18ZAJ6KPcGL/GzYeYiIA8SE8vBiWONcSpN
         3bpId/RTM5ZuXcdJhikUeEKG2mkOMIffl8xO+AuVKllErg5RQrbamlG978nHvM6Cepzv
         ZRqKkS4Z4IuUXZHDV+LCySWOgv+7D27hhZyB16jgo7DpaCG90RnER7kOt9iJSk3NUrST
         A+kjKejOIB0HHqjD5ScfJWT75CjM4lsalUS/RpcWl+l0kmZ6oUZi47NCYvzW+PFQd8wG
         P/Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794415566; x=1795020366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=W+wFrqTn6TpSzq1GtCMNbpHfih/1qK8FVl9ONJGTXVY=;
        b=csVszhDQVuddFAMjry9EsTVxbS63JhRAZx+Hvcbn0j6EUzgHPV7gL5LoXufEzZMGIs
         1ROxF+mMyilQIUyXNWs/O4wc3WEimIGrFXtt793D8J9h11Y/80hI910FoAtQoCv3GxkC
         ei+iSFk0lFY2ilhSNVcSYHdsWc+jmw5zbpnShnJ4Lo1N+z5w/6hkK4xPs5Ztx75GcbpG
         EZn8CX+KcGn7aB8DlVtDZCQiee4NdrG8RnaOb+Jw+BX1UvpnBeTZ67WF0P+/RLV3jyPO
         jQHv4rMulbopqWVbPDrqIAQOjoc/oNfq485LVW3jGWVfafCPNKTu36u6kPxSLUDbhSWV
         xy5g==
X-Gm-Message-State: APuU4Z9Rm60DmaLTl686B9uyfsXH0GrfGpl8NyndXXp/aEaR1hwyOXTA
	tTnmlPuFal90wVmBvB4WvBW0BnUl0WqGnAXtU5MU8mtfi4WQRp30kZJiR7/RPA==
X-Gm-Gg: AYBFou0R8PvwWRmuWZEUHUTxBtCO1fLQUbIHZEIS8jnUfaYoj8oz5b2ri2pTEJ1zM0k
	TC5vHwFNBO608yvV4E9gWRs4lKopCMjsROPIJx1JBJxbTn4BKp64ZvMlYqRs29LQOB82t/1AHvU
	vu59TAwpShy+5ajaFhn/p3BSr7vwPLmQbQMlZz2jCxmd6g8E+DBTM3ebeJ5yBbUp4Sf/UYf+KIz
	icc9JMq2LI7BpCYyktlobjRKLm757+CVC9D/QpSw2AaefvuBalCc7eF/ET8Uo8ROnzl35TF4E+Y
	kptON6+cs9w53TRd9JTJY62mfwnUYQZvpykh5qcV0KaFAF9C9CCP27rUAFGjFn3MAS+4sZ2rHFm
	DI4UbbIlTk8yP2HvcQ23QTU9uusiZ9k7MvlUS5YCc9CrcyHQBgDRCbrsos3lAN/xEwwu5yAffLg
	rJ/KSCSEN067mxKASdkeCKlNu973/6AgNOHvY+VMs5Sb5WzBe15q8rU8GFpw0XUhqpdi0Zf7TJj
	36+qZlndhzZgKb6UWmuj5Qne46FSNykJvd5h9yvrrN6zvYBON4KlV6BeaG+aBcN6gMElBZsX0u0
	zYnTyW6Ax/J+OJUGcZ2o1FfqgSlzwPUDqI/KoxgaVOkqGCkUQ7H7qe4HZ1CMNnb9C4STAYQWJUN
	IYj8tTTwzQNNhdMMAMducQqROh85MQ44S/PSc6WOgeNYxh8HlJLNpnMQOxyEkueY2TRf61eNE2w
	==
X-Received: by 2002:a17:90b:1642:b0:3b0:9409:6969 with SMTP id 98e67ed59e1d1-3b197caa45dmr16953a91.19.1794415565161;
        Wed, 11 Nov 2026 08:46:05 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b181f8fd59sm2488730a91.1.2026.11.11.08.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:46:04 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v3 01/29] bpf: Keep the 32-bit range across a no-op sign extension
Date: Wed, 11 Nov 2026 16:45:24 +0000
Message-ID: <20261111164557.2659679-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261111164557.2659679-1-alexei.starovoitov@gmail.com>
References: <20261111164557.2659679-1-alexei.starovoitov@gmail.com>
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

From: Vineet Gupta <vineet.gupta@linux.dev>

A fix of precision in the main pass. It stands alone in this series. Its
tests come with the tests of sign extensions of linked registers.

	1: w0 &= 63
	2: w0 -= 63
	3: w0 = (s8)w0
	4: if w0 s< 0xffffffc1 goto pc+2
	..
	7: w0 /= 0
	div by zero

w0 is in [-63, 0] before 3. Every value of that range fits in s8, so the
sign extension is a no-op. The verifier drops the range all the same:
after 3 w0 is in [-128, 127], is_branch_taken() cannot tell at 4, and 7 is
verified though that branch is dead.

coerce_subreg_to_size_sx() keeps a range if both bounds have the same bits
above the low 8 or 16 bits. In a range that crosses 0 they differ: all ones
in -63, all zeros in 0. The check before that one is on umax, which is huge
when the range has a negative value.

Return early if the 32-bit range fits in s8 or s16. A register that passed
the check of umax has such a range, so that check goes.
coerce_reg_to_size_sx() does the same in 64 bits since
commit 0892ef2a7ef3 ("bpf: Representation for intervals with steps").

No verdict of the selftests changes.

Fixes: 8100928c8814 ("bpf: Support new sign-extension mov insns")
Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 20b1b9ff574c..5bffc1e288f6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6441,14 +6441,28 @@ static void set_sext32_default_val(struct bpf_reg_state *reg, int size)
 static void coerce_subreg_to_size_sx(struct bpf_reg_state *reg, int size)
 {
 	s32 init_s32_max, init_s32_min, s32_max, s32_min, u32_val;
+	s32 field_smin, field_smax;
 	u32 top_smax_value, top_smin_value;
 	u32 num_bits = size * 8;
 
+	if (size == 1) {
+		field_smin = S8_MIN;
+		field_smax = S8_MAX;
+	} else {
+		/* size == 2 */
+		field_smin = S16_MIN;
+		field_smax = S16_MAX;
+	}
+
 	/*
-	 * If value fits the non-negative half of the signed N-bit range,
-	 * sign extension is a noop.
+	 * The range already fits the signed N-bit range, so (sN)v == v for every
+	 * value of the low 32 bits and the sign extension is a no-op.
+	 *
+	 * This has to precede reg_step_reset() below: the base/step line stays.
+	 * It is about all 64 bits: zext_32_to_64() in the caller discards it
+	 * if the upper 32 bits are not zero.
 	 */
-	if (reg_umax(reg) < (1ULL << (num_bits - 1)))
+	if (reg_s32_min(reg) >= field_smin && reg_s32_max(reg) <= field_smax)
 		return;
 
 	/* See comment at reg_step_check_unsigned(). */
-- 
2.55.0

