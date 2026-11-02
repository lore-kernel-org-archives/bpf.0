Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793599165;
	b=0Z7PcOuyQs1SnY6+6TGySTH2+KSwNSPPD+Ifss0/WAqlWiJnP8QmHMKbAt7bLrdTDMiW
	 YOHGE7gTIIiMXrphoHGhr2Mf0ymNgPDg8FxSHx5rKt/S76yTuN7t5U1fRg5rqH9+WXmLn
	 +q9Xnm5/NX5RkoejgOzdO+3HxI69FRJuUJMFFnmEFRJzb7jM8XfB+jiyErVYDEx0L8cRW
	 6pDhvjDgBhpznmVFRylZBdJ7YQEHaro5OxrKCSNSm8aaJcWFB2Xx9FJwgCEE5jSB2vwSX
	 hqzltyKcNxQglvhdXloIFh986LbOM9k4cn9o+TKKdQ2PrtRM1jJJo6BSrIAlnG16M2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793599165;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=capoWtlmSa27SslU2P9s8mNwAxpjLHmi0n79esbXy2w=;
	b=mHpAywfFwye6pZflOOKVLPQMWV4BUHQEpy82r2/OH7eLNSzY+4IaIUj5pFHZbqGNF2ZR
	 1m5yDUGjRkGG0zQaO60M6A5c7hdsrjyMWSk5zN8F7rsYe/JSd32nImCAZPtVmPXhKwOZH
	 PbvWr9OA9Ds5TdmCMvk+dFZScHmhrtAURPwSBbNINd/MTR0E92fqE5gwgkroytcl0Y3Pg
	 LJYfWWJ81JT/uGxeoA5rZXtk/30OdvxLjhUtlaJuwfpNch1+SbGceK2VQWC4J4S1+f/Eu
	 mGYeHYTz6NXQ853JBk7oCXd8hrkdrNozD9puQS/ppfOtlymRGkXHy8UcHm2kkJIVuDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FjLxz08s;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2F1606A324
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 05:59:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B2F1606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FjLxz08s
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3ab41538192so2136263a91.0
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 21:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793599164; x=1794203964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=capoWtlmSa27SslU2P9s8mNwAxpjLHmi0n79esbXy2w=;
        b=FjLxz08shyVKo3ie0Am6kPXgDg5EHyIKEuA/NhSCGZFpnPO3stIr/a/PFcN65GnfN2
         7X8pgIUAYS5pGB+GGVKseH3iUnMF/HS2dBafQM2+mLegckkJD241TZtYnfcMD7J68VBG
         PBU57qS28Rf9Uit8rvr+TLFcYfJlAz407xn9Ib8odJ4ZLhyDIpSEJjIeiwLdaWsweD+6
         z1fbqMeQn6yfyXEdkoDOIGoELKcbHCj4Yt1SOoFjlfVbXNAAFIn0539J09nnbfBtWMdo
         po7j8/Guf0yyf5/kLUmCAPCRNv+8i3uTfkBG8/JtyI4krHqa9EHpjr9fR9ePY3QGmwUQ
         KRqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793599164; x=1794203964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=capoWtlmSa27SslU2P9s8mNwAxpjLHmi0n79esbXy2w=;
        b=mPWwfsurHZndpGMAyYY6VojwbOYf8K0CSbRfFFdxW/VQCzsBJzxtIrx+nZ0sfb3n3e
         gHrlyh4WW1a3APhW8iFkOChhJsGbe5XlWz8clGVzBBbAwNKmSRX0XxY2XL24RM7BnEVG
         iMoiOgMkonG/whMiq2Dtrqb7PdFzAdreOF0wo7HDzO2uIRBcIe5bukfXNQqoz+Rmttk0
         jU9blnV1mN+jiSUfILH8i+zOPwpNsgWE/mxzVa6ZVBnyf1IdCyN98H3z5jnF/sWpax1o
         2tK9OZlkUF5yk27PpmJQDP+QA2b293sENaMzikb8jPycc3fIwqkaz7GWuvk+dn5CAxa1
         wX3w==
X-Gm-Message-State: APuU4Z+fcjDRcwoNd/SFQbcfTIlBeOzYFIBSXETOLaCMUzi8dHwG+QYx
	AODHyjLgWiwYV/0re3ojhATBbCGCaGu7Ij4/qbt1JbPNzgocvDIei7LvfiZhGg==
X-Gm-Gg: AYBFou0fO9eRowehq94BXsXv1oGcW4KYRlXRo3Z+3jshdWqKPP5HJdJPmG1BA3np9DZ
	v1f+k4z5NuEGoGq03LHFQyHu2ZMzKDPT5DmgIjZgtguZz17nxcyqE1nDmWJ0oiedLSjRO6SHCRP
	qnW/TMnpdJtkOtDazs5Yi3DdbL/n21dKc1Dpn5KIwnjDqse5PSFhsrFDkaRdYMynD4U/vhLGDeB
	SjMsac+62IThu+bvoqP+A5gFiLg+S/J1edS6y6IEZqXBUpC/SlDIKjzSbLuzNIbC1JxtF0JaNiT
	cR5tVWsd7q/ATtpOLnmEUzQlNlKPKXJlqd/NR6o1SyniMv3SzT9mz+rEu8k9BkENdojR7tdzcHa
	JHEX5bRiRV+3QAhaozxzhuRt7aozKHAkcNaIIvu329JdtgQ94achsCQA84HSLfjJ1+9dril+mA3
	ym76U347egN0XSUpNO56fTgfi8rNE08DuZnTk609nCAFGn5JGZKkM6rSS+heoGCML6k0pXYKYLR
	X5h3vV1QcdYFfpYgWx/bHDcPD0XSlvG2Qhkp37gkfkaLoHDpi+B4oy2Eftoner/yoj07T2miLOm
	oz92GTt4TsS7910thz5AYP052SAENUxSGIpbJev+S0k1UsIc0/WABzhUwxnlrCrLIyOpZEIU34P
	7wAjCmV+mzd8ZVQspy8oc+d3wTogyXyA1xS54kbi+h7hEEDRGsNK3gOOc95YxGXS5exPhFet11c
	dp
X-Received: by 2002:a17:90b:33ca:b0:3ac:97e3:7389 with SMTP id 98e67ed59e1d1-3ae897acbf3mr7239697a91.44.1793599164472;
        Sun, 01 Nov 2026 21:59:24 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae845ecaf5sm12502039a91.16.2026.11.01.21.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 21:59:23 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf v2 1/4] bpf: Fix the join of fp+0 with a value that is not a pointer to stack
Date: Mon,  2 Nov 2026 05:59:10 +0000
Message-ID: <20261102055913.3598414-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261102055913.3598414-1-alexei.starovoitov@gmail.com>
References: <20261102055913.3598414-1-alexei.starovoitov@gmail.com>
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

arg_track follows pointers to the stack through registers and spills.
Scalar evolution and the removal of dead slots rely on it to know which
slots an insn reads and writes.

Where two paths meet, a register can be fp-N on one path and not a pointer
to the stack on the other path. There is no value for that. The join adds
a fake second offset, fp+0: with two offsets no store through the register
is a certain write. But for fp+0 the fake offset is the offset itself:

  join(fp-8, none) = {fp-8, fp+0}    two offsets
  join(fp+0, none) = {fp+0}          one offset: "exactly fp+0"

Then a store counts as a certain write to the stack, but at run time it can
go to other memory:

  r7 = r10, or r7 = map_value + 8 ; arg_track: exactly fp+0
  *(u64 *)(r10 - 8) = fp-24
  *(u64 *)(r7 - 8) = map_value    ; arg_track: fp-8 is overwritten
  r8 = *(u64 *)(r10 - 8)          ; fp-24 or map_value. arg_track: none
  loop:
    r1 = *(u64 *)(r10 - 24)       ; the counter of the loop
    ...
    *(u64 *)(r8 + 0) = 4096       ; arg_track: not a write to fp-24

Scalar evolution does not see the last store. It gives the counter the
range of a loop that only increments it. The prog loads, and it accesses
a map value out of bounds.

Valid progs are rejected as well. The store through r7 makes fp-8 dead, and
a later read of fp-8 fails with "slot poisoned by dead code elimination".

When the single offset is 0, drop the offsets. The result is a pointer to
an unknown slot of the frame, and all updates through it are weak.

Veristat sees no difference in selftests, Cilium and sched_ext.

Fixes: bf0c571f7feb ("bpf: introduce forward arg-tracking dataflow analysis")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/liveness.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index e657e6d95408..db01aecdffba 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -976,6 +976,19 @@ static struct arg_track arg_join_imprecise(struct arg_track a, struct arg_track
 	return (struct arg_track){ .mask = m, .frame = ARG_IMPRECISE };
 }
 
+/*
+ * 'a' or a value that is not a pointer to stack. A single fp-N gets a fake fp+0,
+ * to keep stack_use and prevent stack_def. fp+0 itself would stay a single offset.
+ */
+static struct arg_track arg_or_none(struct arg_track a)
+{
+	if (a.off_cnt != 1)
+		return a;
+	if (!a.off[0])
+		return (struct arg_track){ .frame = a.frame };
+	return arg_merge_offsets(a, arg_single(a.frame, 0));
+}
+
 /* Join two arg_track values at merge points */
 static struct arg_track __arg_track_join(struct arg_track a, struct arg_track b)
 {
@@ -1000,20 +1013,10 @@ static struct arg_track __arg_track_join(struct arg_track a, struct arg_track b)
 	 */
 	if (a.frame == ARG_NONE && b.frame == ARG_NONE)
 		return a;
-	if (a.frame >= 0 && b.frame == ARG_NONE) {
-		/*
-		 * When joining single fp-N add fake fp+0 to
-		 * keep stack_use and prevent stack_def
-		 */
-		if (a.off_cnt == 1)
-			return arg_merge_offsets(a, arg_single(a.frame, 0));
-		return a;
-	}
-	if (b.frame >= 0 && a.frame == ARG_NONE) {
-		if (b.off_cnt == 1)
-			return arg_merge_offsets(b, arg_single(b.frame, 0));
-		return b;
-	}
+	if (a.frame >= 0 && b.frame == ARG_NONE)
+		return arg_or_none(a);
+	if (b.frame >= 0 && a.frame == ARG_NONE)
+		return arg_or_none(b);
 
 	return arg_join_imprecise(a, b);
 }
-- 
2.55.0

