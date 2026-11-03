Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793749392;
	b=AwN8wwilJafJIZ4JYXfxvW/yvKznsP4zgJDpeDhxufJNPwnzVU6pr5GQOtrYWH4ENlyR
	 CCk0IDURmtV1p9RAiXA6YdKbZPJ4ClNeDAnIH14pJQ31cxM87lfU+UShWaJAZdEdgGwuf
	 LX6vfSItNP8Kb75g1V0nc+NJ/alX0I41F8InZevYj78sjJIeCTVO/K8ABBaGT7yJa1c93
	 xAfr3X/rySUhahRgN5XDSVzivRj37+yM8/PQ72OyFxV6w9rJI4cl+X66saXyxVWcNr4Bu
	 xUKOEFKTRRBLtRjH5x4FcBTT0Vdvg35O/otYAeUNGARfTcb6Pb63IZEKNx+KCEOmarw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793749392;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=QegSc/wcoBZa70IWsMViHKtlaHl5ugZvdHMGid4vM0I=;
	b=sHK3RJdRax74YUZs/W3zOHby392W7S2n5AT8H0lj7I1NX/SoagxcbdzH2f34Hpgi46c8
	 KvkVS2VSn3N+diY1JRqtCKIfX3MuBxtctKdCbERWKPxy1+XRHWlZAJXrJjIaNwQAFg1Ma
	 +QhhPLjWbX2A0YT2vmOad1pZWVwJZ3Msc5h6uensefuWLNUVidlnguHDWGuZH5nAouHfl
	 IyjJt5dLFweF5CGYdkyyapaFrWKn5H8L/r5AWbB5LmxfqiPMNFVFyo8DOzTEkI8o2LPkv
	 uNwijsFgvfly3CDloHShVFaLGWLyIVjpao/IOn3hNvkmlt2S7O6Ka4lB/QhT4RAtYqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="fbM1VN/2";
	arc=none smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB84E606A31B
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 23:43:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB84E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fbM1VN/2
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2e60f9af6e6so834325ad.3
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 15:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793749391; x=1794354191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QegSc/wcoBZa70IWsMViHKtlaHl5ugZvdHMGid4vM0I=;
        b=fbM1VN/2F9ae7D7zWIDOLHSEC8i2XnC9duUDrPQwjDpE8eazv6ILtvUR+kO3Y4j3hW
         ZRg1jKWI7zqgGM2OcFAhCpkLGiAA1DM+YIvNVMkWX8lMsY9D5HcOH+kNVMkGoe5FncZF
         jlBjiA7laajC27LHW3C+jqgDC5DJCg/IHgv5PrlcE0+Y6UP62E73cvworJK77mA9daQp
         Np61pJZsmVXUO0sflDnXhleeXUjWKJZL8FJA9bULzgy9bNDzF7PV5DD2wRHQyVO/2hVv
         pvtQojZvrpK/CtVTvs2HsUgdGaQ9o2Hm14fgmob69HP1niBz95oUgG1kJDOkvsCBQdbc
         c+Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793749391; x=1794354191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QegSc/wcoBZa70IWsMViHKtlaHl5ugZvdHMGid4vM0I=;
        b=1lGt9Aa9Tz4BvBxkKGXoyOi164DaGi5ZivdjLLuf/XwCYZh1kreUgu1cHnurgEy32B
         gnMC1vyz2Ht1w9LF1mfB7OxZ4gYf/4jOuSUNFnvOml/ICYoMYmbr7kYyjWZM8MzmrUz/
         4fM+2LeblTyrwGgXcwaqzj+qnI0/RiE2DrRcxpQTnB0HOXufz4+Wl1LfYE8Xk0E7Xsbl
         z3BV4KHB6Z5zzl9iXHDypozNLgDZPd6ceDpapDw3WKqem+88hhw9G/BY3ouATR2+yoRF
         1yMkYDWjdBuG3zJF12i5f6S7oGtBweyYE+iLyx6DaD8Y34ebgz/ORr4wJRPTZkzFiuTv
         npLw==
X-Gm-Message-State: APuU4Z9wF0F9TcR7ImhhEtgqA2JC00zL57zsqAEGccize+NmCalMfEKX
	2k/0Yx0fsClZQz50BJLzVEgZUtF8xsZ3ey1bup+JHnCi/ZPNAlNBOLBXI54MQQ==
X-Gm-Gg: AYBFou0cOcTvLrOSDW/A0XLYbO0vhYQrG7Yav4LVWJgSfTCOK2NfI3Ga6aLzDjFwwIu
	Z45VYidyDTc1VjPHsXVtrHmXJWur15F5OvOEynvQL9JKyxzVK/BcHhn1hWCcVkw9olhHIbnrP69
	Kl1w6Ggiwa5lm6W4wBwWomV9WLoDUcPLvmqClOlE/0eZwqPlPuwcAtPWWgR+n+e8wQP9Cg3umGo
	hx5N1jBKp1T39wxsSnpt8ileXrdqrS/EtT3PfwEHzRFisbmkX2INmA3naCSZM7ekzV9wjlQTb4d
	eFuZ4oBnjqnfm/LT6LPVRE2wrUTo0zpPfoJ6/3+c8CGE2MJ+quiTFwgOsnv1zrZ0MzK1e+qQ1gn
	f6zcVSDX7jydz7avuoqnHDR6LDF8qmYlAQ5htJnBrrgr+BdKrrG4EwOoTmimIqMKfpnk+hU1iSS
	a4x9LzOPj2DrA13EnM9Lx609A0Qb591JkLEEky954uJdqWO/uleVvvYm1KLfRwf7pr8zk7q/oQz
	xvPlbNFe5xj51n+T+/tpuT1esEmXvXlYweH/kDBDazsGpKRM2GEWEoUBoP0h4TBE4S7PIrQ0Vx3
	78h3aUy1zza8N6zYCcI1UUSnGL5dSS7t33jyu3zCMFSTfxOsFBAIJJjiX7X9Pam3GLA7n3/5bVV
	p3R0D9r7GuwaK82ImmVG16n7LrAQRgzsyhnuqf53J3BMFzR8x5JCtYmR03jUG033p8SWFcnFtZh
	MxBniYuuvZVM98abOenCk=
X-Received: by 2002:a17:902:dad2:b0:2ed:74a:6722 with SMTP id d9443c01a7336-2ed074a68dfmr4655895ad.29.1793749391035;
        Tue, 03 Nov 2026 15:43:11 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed0922b86asm397615ad.76.2026.11.03.15.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 15:43:10 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 21/37] selftests/bpf: Test a loop with 301 exits
Date: Tue,  3 Nov 2026 23:40:46 +0000
Message-ID: <20261103234104.208239-22-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261103234104.208239-1-alexei.starovoitov@gmail.com>
References: <20261103234104.208239-1-alexei.starovoitov@gmail.com>
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

A loop with 4 iterations and 301 exits is in another loop. The inner loop
has a count. The outer loop is not analysed:

  loop header at 1, unsupported loop: too many exits of a nested loop
  loop header at 2, header_count is [0..4]

Without "bpf: Compute scev for a loop that has more than 256 exits" the
inner loop is 'unsupported loop: too many exits' too.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/progs/verifier_scev.c       | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_scev.c b/tools/testing/selftests/bpf/progs/verifier_scev.c
index c91d178a1aed..4b9a094328de 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scev.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scev.c
@@ -2238,6 +2238,44 @@ __naked void one_backedge_two_exits(void)
 	: __clobber_all);
 }
 
+__naked __noinline __used static int returns_zero(void)
+{
+	asm volatile ("					\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+/*
+ * A loop that the compiler unrolls in part has an exit for every 'break' and 'return' in every
+ * copy of its body. How many there are says nothing about the number of iterations.
+ * Scalar evolution takes a nested loop for one insn, and its exits are the successors of this insn.
+ * The list of exits is not complete: the loop around has no formulas.
+ */
+SEC("xdp")
+__success __log_level(2)
+__msg("loop at 1, too many exits, too many exits of a nested loop")
+__msg("loop at 2, nested in 1, too many exits")
+__msg("loop header at 1, unsupported loop: too many exits of a nested loop")
+__msg("loop header at 2, header_count is [0..4] ")
+__naked void loop_around_301_exits(void)
+{
+	asm volatile ("					\
+	r7 = 0;						\
+3:	r6 = 0;						\
+1:	call returns_zero;				\
+	.rept 300;					\
+	if r0 == 7 goto 2f;				\
+	.endr;						\
+	r6 += 1;					\
+	if r6 != 4 goto 1b;				\
+	r7 += 1;					\
+	if r7 != 4 goto 3b;				\
+2:	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
 SEC("xdp")
 __success
 __log_level(2)
-- 
2.55.0

