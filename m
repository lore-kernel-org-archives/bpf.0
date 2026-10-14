Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E022A2F12AB
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 06:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791959098; cv=none; b=gCx0CRmJix70oqU7Izm666Vn2Jw8ZTTg1VQfuC1+pfXSlsOwVPozDJPXm0gDMlrXdqHmD75P0W2Q2LvnUX/xdD7m/z8lkAlPHHwgoZgC7mtzXBFKSS7wPAogRwgxzSLGzd21/ZNr7SM8peBxQ2OEIegsSC4Vorrw2fQvYBjSvXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791959098; c=relaxed/simple;
	bh=fKdB/WsnGY6uK1jttDMIVi9j4zZ7OwHKe8Hz+d44YwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ru7ML7Rm8l8OlvUcAXnZfijYiQvyYAO41mreFXLmfjOvxj/mNKwUW0dXiCB0mkzyEaCrOj9X+RwuQw46smSZEPzQLzjPwWxhgsJ+4AzeASOoaedNgectxHZPERfpgyaG/YmO/yWtAax4YcIu7jYyUn7gqiMCnWHIqS6SojyfpeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PFUbo40A; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFUbo40A"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cc4aa18f9afso287193a12.3
        for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 23:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791959096; x=1792563896; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PY4Zk91vI98NdjrFu8Uk9ZUTtzPjF9UNkOxHbrgeurc=;
        b=PFUbo40AWfk/iwKnflTiguLwLW17VSJmERCHrV2Ch+rJiUs44Ln281yu7XBwQnD/z8
         0HpGwHKHzHH+s5jTv7EEpaGK/fZdGH0FWJgkxcm+bFhmoHXPn2ego/AjpffS5z2ft0ra
         tkh63RVR6vLpF182OSIyl0NS8WOPmMMUgSGDbU3/7GBfF/KK28hVHWFXNeGWpHsBXRgh
         1AIqz/YiAGoMzeC5GjLEKqxts6KivJ6t4Q6oQzn22lEDY2/9fmgDiRIqAJQD60JvYFCu
         kYy+/5n7MXye08Ro4eIy32ZlaDjdG3d4sSzVafp+oP0RgCOThFaNjhXQ3mIQhvu9RG21
         5fDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791959096; x=1792563896;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PY4Zk91vI98NdjrFu8Uk9ZUTtzPjF9UNkOxHbrgeurc=;
        b=RSgOI5r27YobCYP7Sz2h8BI4JCzE06ZCEO3VRMLaN7dOvykclEluB/5JRgK13Og8EO
         2qFyC1svjml7PY7cc6QDS3hLdPEqJWiZe+m2KYvsoE5GOrLTQfpn35iWm8v4CmoIL439
         wVf5nlp21tse+w+iOeuQo/ktPe9fo5QsjhPfiulN2J+1dyzYLrydrsVy59vwaiB4VBtP
         JBPCTLSFipTyOdywBQfG3c9t1QKzikPGPjb3kqgeAr6VdDAag1ggYB+lBWj7GSStghAa
         RdRks5M6owfcx4hZPXMULQmT3fvlRbV9xV7XaDmu7fOMUpjnukRw92D0jXXQ9jTaWTSK
         HJhw==
X-Gm-Message-State: AFq9FYJE0wlm5KegjCpUEGa8MtUg5Aa4llaGPRkkn5FEWzBppPKiw4wm
	h1zCFnYtiW9PCGsIklYXSoayh2lrixJaAc8hk80V6nNmFo1X2iZ/JloYTFpcoA==
X-Gm-Gg: AYBFou376hLQVKyJ+K7agSgYREM+auCeV0PEQ+B13R+aKRShsDVzw9MHf5+0nKgBmea
	RuxD16m7ds/gdoy0Wux3HFxJH8liPXA1qNjZFN0NA5VEe21sRtqBdSGacnuqMPQjY4mZCgVagWC
	xi2DyWnzREoX/0qX4dyWHGP8KkNqiFyUpW6fWcfRf4kyeWfml0kFyCK5JYX2pqz0rQRoigJV8w0
	isr1HtPrS/AEd8mgiVfVXaqKfAOvo/ifhVoFzujmo0vMRxuJpinq8EkS2ReZ040HqmLmqN/98yS
	g7hWRFmSYAmgiqQ+bzMMXdiEhh65jq0t7KXEoWWkk3h3N/5+RC3nkC4Rs4BktBqVsNjakRGcJts
	gjjQYS2Z3wekvVJy4uSiZJnHUqk5SCMg/7DMR6TXh8Lg8JSYpro9bIWrQhoRovzcd2dGjTDn9LP
	X55x/qcWyZKa8uOQ40hZHWkyqftVOzvbgxc5kWBZOC4QbOR90QUCOcsGHoNoF9GAtwF0V3zmwge
	ZhrSvQOjylgGpDRJvIP6HWadQ==
X-Received: by 2002:a05:6a21:32a0:b0:3e1:c6e6:d101 with SMTP id adf61e73a8af0-3e1c6e723a1mr3805199637.29.1791959096229;
        Tue, 13 Oct 2026 23:24:56 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd3d9e41126sm6614238a12.23.2026.10.13.23.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 23:24:55 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 5/7] selftests/bpf: harden __msg pattern for global_callee_btf_arg
Date: Tue, 13 Oct 2026 23:24:40 -0700
Message-ID: <20261013-scev-minimal-v3-followups-v2-5-6d9d61965486@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013-scev-minimal-v3-followups-v2-0-6d9d61965486@gmail.com>
References: <20261013-scev-minimal-v3-followups-v2-0-6d9d61965486@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The original pattern:

  __msg("3: (85) call pc+{{[0-9]+}}\n")

Is ambigous, as this line is printed on the main verification pass as
well. Harden the test case by ensuring a __msg_next sequence matching
the stack use/def results specifically.

Fixes: 063c85f5d8c7 ("selftests/bpf: Tests for BTF-based global subprog stack liveness")
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/progs/verifier_live_stack.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_live_stack.c b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
index d2fdc65c84c5..5f9b11a81260 100644
--- a/tools/testing/selftests/bpf/progs/verifier_live_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
@@ -249,7 +249,11 @@ SEC("socket")
 __success __log_level(2)
 /* Untrusted BTF pointer arguments need no caller stack state. */
 __msg("stack use/def subprog#0 global_callee_btf_arg (d0,cs0):")
-__msg("3: (85) call pc+{{[0-9]+}}\n")
+__msg_next("  0: (7a) *(u64 *)(r10 -8) = 0{{.*}}")
+__msg_next("  1: (bf) r1 = r10{{$}}")
+__msg_next("  2: (07) r1 += -8{{$}}")
+__msg_next("  3: (85) call pc+1{{$}}")
+__msg_next("  4: (95) exit{{$}}")
 __naked void global_callee_btf_arg(void)
 {
 	asm volatile (

-- 
2.53.0
