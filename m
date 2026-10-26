Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792983921;
	b=JYhJxBLLHJs/9ORQWoMxpvVordoXm9BSlW3F1CgZX0kAs2ygeUOIBzcDa7kTUYb3ygK5
	 gKWaji7SKcnGCIEk1R581MwQG55NLw3WCwoTeOspWWsFCdNTuDkHbKIMCB2OIC3M119zD
	 Dtu9LsFV/RGqvYMR0fSb/bAA3iZuCBEWiC8NkqOMzGa05CozbEGEI1uVdv6vGf8nryYWl
	 kWbzmm/rNIl25gipWeCvyszF91fj4KcIt8MmuEKiRaSOkC1LzccHxGatjxP5bBP/wk5dK
	 XK/Rk+X8FNbcHYUy7vEZtGtuZYSPuhETTzno3LP1TRJ+nrzncnA/Z5Nwd90C7cQ9FgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792983921;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=B3e3d9Thn8bseHsVpC/9G/U0vgtBNm9MfmIERy+ZLnE=;
	b=J158bDiZYAk4KFbazfZgtSuFIAyuFpwaVMTAb6v2Gs+2SGBJrUSun/m6cg17P9lUZwK/
	 647s7CiiDHECQ9K7mNLWLxK49d0DRyFtSOVxg0FLQEwFPABkrTi+CsZHBZ94o4eUZe5/9
	 7rYkapo1xNMBWejsaxKVSzqfBbNmn/9Wvps9sH7S7KW+05FLsWtkfr00nHMYDvsFkJa+1
	 9qtgTi0RgEay3aBbzmMFyPdkKN+KTsk2/5k0FE1iSZNgnPa5qEUC+XnT6cPTTiZz1vsMi
	 wtipZrdAfx6J7aLZS6UwaU1HLTB352ijWG6t6n+QmEPdoU4dlPWU3RxxTxMN7S0kBqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gHHENuY7;
	arc=none smtp.remote-ip=209.85.210.175
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDC9606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:05:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2BDC9606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gHHENuY7
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8a05da1cc1fso795366b3a.2
        for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 20:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792983920; x=1793588720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B3e3d9Thn8bseHsVpC/9G/U0vgtBNm9MfmIERy+ZLnE=;
        b=gHHENuY7eDgB12IFjs+CP2sEJ34KJx1S7RyJxtzSq9EZnl+NfUoVtvHjgQQ0dLgwPV
         tpcMw0YwStu4vGW+bjUJxfFxH+QtU9rRrmHrFLl+bXxMLx7TDJdUVX5qwGli/sSxnMPU
         OqDwNrqPOrDC+Xm0qepPn8JooGOySITVjm+j4OnY/yS/BGg2drKO7CgMpmi9crGhNice
         +dD4KbgyUMhbAMfDB4OvKfGIATAcCM3CeMRYpn4tmIWUAcYFYcriBBUw8PGAunmBnEaV
         PG+wRbwKGUkQkAb8cPJGyyER30Q0HyuH6bebD5GBkYJgvg9fdesnUMC9tQy0SOpDuCot
         a6bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792983920; x=1793588720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=B3e3d9Thn8bseHsVpC/9G/U0vgtBNm9MfmIERy+ZLnE=;
        b=0zyhH5vuoh/x1KlbJL5ERdWJ5dIMEUl/78z72qInNBEmlXrsd3BuOHfr3C/oyuxXpP
         b1jsRJQvZV8w6q/qKqaV+hcTxIxcEyEyld3AnoqAtxfPCH0WMgEi9AEQqUPny+Cp6v9T
         qzd7nZ2755LLP53ZtRq8xNAAcpmcvZCFjmUrR9skZhcjuhj1hPzXy+0EE4mclPVf1wcF
         LMB6FHuvNPoksPBImAS2Ar3SZj0kgmWKUt7f+w+TcUv2DYk44H2dYckDseUITV2Rnj2K
         SB0fei7T09IYklRxKVhncF7SNSwxwfnmk+AaKSw0e62yYqbiemz7P3WPby9o2ukk6d5b
         D3lg==
X-Gm-Message-State: AFq9FYIGqj0iwlofo5EF9Lk9qtc1ptNRty2NuHiIZzmF2sJtsm/7wqr1
	ORuVlWoZlIhjhpjYwCgXjHCPVhTDAWJPP0KXYYWYi6+niR1DzShCKYVCjexdDw==
X-Gm-Gg: AYBFou3myfbFohbK2W7dsRUTj3Zm5dlXi8pkTMOMBkb9hHSuN7YrhlkuML1knbNjdcY
	Cp/0VrP1GtHwF7F5zZrEzFhlwq97n2oTC4g9b6L3mH1LjXLkH5oWc4aB/dgu2zBZDFJRPW1z83B
	iz9sBIRsPTYbLrR9OhqffDs/9DYw6hRzPsaMl5K6/N44MUCHUXNkv4c3pn8JYXuTnpYkqg/7Cvp
	8z1tMbs1jvmG6ccTnbqvRt3TJ3Chy/KirtUm/JF8dfwQR20O+J2sNPjvNHkAeaSRfK+moEpOUMS
	N9Mz7biid7oj2ee4ul0Fns4vw9YeFxCQCjaLvaFe8LcIBt2BGyLuEKAUjGvIcVnhspI3LP+eTOv
	uqlBY8qXkBNH7vU+Nj+84+2jE7Q2S2dlDxN9P4u2pDqUp+jZdpAiinj1/u0OSDXVSli9tF2yfXX
	uI137pVnDojZ698ojlbcMcdSeg1iEwmViY7SUAZWr/LVGU2uSy9rAtzR0dG7TJvH4vO1gNZYzBO
	c2DFzp+OH6S8JIQXWHoWnfQulyUhhq6hT40LNr5HXljmQZrdtaKJDpivit6daVIUglRhKjeB+wS
	5rEVL04vh8WC5RFsEfOQPNHSyQ/HPLOxkOMb2lACfbv0ZQmxzx7+AnZ9wtR3iIKQvsNuY5uO9d1
	P/ix3bxVlk0GsIamsYtaTy0Bx
X-Received: by 2002:a05:6a00:3286:b0:89e:43ee:6538 with SMTP id d2e1a72fcca58-8a367255177mr4296618b3a.36.1792983920342;
        Sun, 25 Oct 2026 20:05:20 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a36c10088fsm804147b3a.45.2026.10.25.20.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 20:05:20 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 57/81] selftests/bpf: Test 32 and 33 call frames
Date: Mon, 26 Oct 2026 02:59:18 +0000
Message-ID: <20261026025943.404450-58-alexei.starovoitov@gmail.com>
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

test_global_func3 has a chain of static subprogs that is one frame longer
than the limit. The limit is 32 now. Make the chain longer, and add a prog
that has exactly 32 frames.

  prog                     frames                      result
  -----------------------  --------------------------  -----------------
  global_func3_32_frames   main prog, f31 .. f1: 32    loads
  global_func3             main prog, f32 .. f1: 33    rejected

The message for 33 frames shows 32:

  the call stack of 32 frames

Two places in the verifier check the limit. The main pass counts the frames
in a state. But it verifies these subprogs for the states at their entry,
without the frames of the callers. Thus it does not see the chain.
check_max_stack_depth() finds the chain, and it does not count the main
prog.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/progs/test_global_func3.c   | 107 +++++++++++++++++-
 1 file changed, 105 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_global_func3.c b/tools/testing/selftests/bpf/progs/test_global_func3.c
index b66abb350fb0..3b816afaa278 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func3.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func3.c
@@ -101,9 +101,112 @@ int f16(struct __sk_buff *skb)
 	return f15(skb);
 }
 
+static __attribute__ ((noinline))
+int f17(struct __sk_buff *skb)
+{
+	return f16(skb);
+}
+
+static __attribute__ ((noinline))
+int f18(struct __sk_buff *skb)
+{
+	return f17(skb);
+}
+
+static __attribute__ ((noinline))
+int f19(struct __sk_buff *skb)
+{
+	return f18(skb);
+}
+
+static __attribute__ ((noinline))
+int f20(struct __sk_buff *skb)
+{
+	return f19(skb);
+}
+
+static __attribute__ ((noinline))
+int f21(struct __sk_buff *skb)
+{
+	return f20(skb);
+}
+
+static __attribute__ ((noinline))
+int f22(struct __sk_buff *skb)
+{
+	return f21(skb);
+}
+
+static __attribute__ ((noinline))
+int f23(struct __sk_buff *skb)
+{
+	return f22(skb);
+}
+
+static __attribute__ ((noinline))
+int f24(struct __sk_buff *skb)
+{
+	return f23(skb);
+}
+
+static __attribute__ ((noinline))
+int f25(struct __sk_buff *skb)
+{
+	return f24(skb);
+}
+
+static __attribute__ ((noinline))
+int f26(struct __sk_buff *skb)
+{
+	return f25(skb);
+}
+
+static __attribute__ ((noinline))
+int f27(struct __sk_buff *skb)
+{
+	return f26(skb);
+}
+
+static __attribute__ ((noinline))
+int f28(struct __sk_buff *skb)
+{
+	return f27(skb);
+}
+
+static __attribute__ ((noinline))
+int f29(struct __sk_buff *skb)
+{
+	return f28(skb);
+}
+
+static __attribute__ ((noinline))
+int f30(struct __sk_buff *skb)
+{
+	return f29(skb);
+}
+
+static __attribute__ ((noinline))
+int f31(struct __sk_buff *skb)
+{
+	return f30(skb);
+}
+
+static __attribute__ ((noinline))
+int f32(struct __sk_buff *skb)
+{
+	return f31(skb);
+}
+
+SEC("tc")
+__success
+int global_func3_32_frames(struct __sk_buff *skb)
+{
+	return f31(skb);
+}
+
 SEC("tc")
-__failure __msg("the call stack of 17 frames")
+__failure __msg("the call stack of 32 frames")
 int global_func3(struct __sk_buff *skb)
 {
-	return f16(skb);
+	return f32(skb);
 }
-- 
2.55.0

