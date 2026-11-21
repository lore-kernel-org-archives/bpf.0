Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795288469;
	b=TUNMtnqoRNz4FPm58atMeah2FnRW8uZ3+46FwfcYlsf+pwsm3ndhK7vAa3AGp5AQPG/y
	 Z1sHa2nQzBhQ8J3gpizlwK43o2szbfLwvyj9nK6SxCAyLD3k819ZijBDiOHTbM5sxkilo
	 UJGx6PfCHeCaACxPxBxBSb3jGyXeD6Qt/FmtaXtl1mT5z87pYJucXEBQKkZne4LSPLHWP
	 NEh+KMtvCw4jZQYKIIee8GC4HZEPGN8lMjWjelBwqwh4SqTtfVajmMYk2Vefa7/tJnFd0
	 XPn2vRX32EIcdGpzjV9luEFYD5ynfRVvaJgejMNIbp0//AJys97V9xBU0XXbb09kgtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795288469;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=h5d3YWTFGvSB866WO3GvchKOrHxsPDiKYwlAlJXvIKs=;
	b=qe6c3Np0qFnWSWH0ZHslUN/wLqWTJYGa5xdj/0BPygLfBc4jR9lvV6Svz+AcgZ+YOUcZ
	 petk5Th4pPI/HPH56Fxy4WJDbhqicWOQTCzPBiMT+74zPzVJEqSOaaAs8X3tWiG3P6/8p
	 Kcl+f4d4af/WvvNzXXVsjueZtrjHpevSs/ZFVTB/kiS3XXtcOzBx35eAUglOHySAUgP23
	 nOa2LiJfFKBXIsj0UvHeHBfa7LlP4+CwgadRfoyWtFvfjJK1cHBNrvVtPxexyHYGt0B2M
	 rrDL4+9Dce2B5AZb8bn8itkRPG1B3wUZk0QKpyuzJW5MWsHw2u5hT2f0zTzZeYJ13mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AhT+ZVDt;
	arc=none smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AE1606A320
	for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 19:14:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3AE1606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AhT+ZVDt
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cdb15cd8558so891453a12.2
        for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 11:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795288468; x=1795893268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h5d3YWTFGvSB866WO3GvchKOrHxsPDiKYwlAlJXvIKs=;
        b=AhT+ZVDt+tH+y4q1MJgo7b9z/nMmAMpElLlWCUO3SsUxNnKVn9m38vOOYr37zmCPqe
         QIz2/PjPf6BvHcTs4XDpn25MdblAxaYaAQv2fDIZeytVtglpmwJ1u6vZO7SUrYp3mGwJ
         mGq41Wc2ivdfis+5+J2hAfMIWQI3EY3WAo5nTYDRexxivLbATkW6DQAaQzyB4jIZ3UEA
         X2xmmKwS3e3cS3ruCgiFBN7aNu7FStV3zBMOTD7x9cbTZeRVyF4c/ycRDbIaXN/UsYdw
         MkMupzDLPATnBVljThd1kA7k7+pTI7gHA90/N6bF6NKWIo3eEuJ/ug/Mh1lW/wvPhm9D
         OR3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795288468; x=1795893268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=h5d3YWTFGvSB866WO3GvchKOrHxsPDiKYwlAlJXvIKs=;
        b=GPpeXIxKa3KN/pkq3EHj/QpcMlLDPbF7iwt8PDcq0uB9GA9AxtiU+WEJwZAMmbycSp
         qBwjzzcsl23pUvSL8RboB4IYRNZwdDRPK9156d0M1MmFsgUruJnN7b1lrDtpCRAOo3EZ
         LigH7Nh1r7qpJd9oVpELCs1qBSguXikt35ABF2Hx5MrYTryJ9TSDSquajHTQOSohu6Fo
         9HR9JiK3Sg9K4kZj1sSfmibw2ARz/xBjyJiJN62lFa7pLTL15IPPMQF81OHPkysp4fjq
         CVWdVmQtobTqCtpiyy0M85mqJX/paee1Am+ExJBeCeFu0nAMWpZ0OpeZ8GWwTDulOx0e
         ID3w==
X-Gm-Message-State: APuU4Z8TM1almJu4Z6KNMlb+ZjvpGdSgW0tDlPc9x6cXpTXZi76JagsQ
	MtfCLqs58WB5Dj57/Bei6KMcPTFKq6ozgQIMy9k9fGfILhGbyj/3FRm1zpNzHA==
X-Gm-Gg: AZFdTZe3MoeJ1++av5SvN69WkW9oZskItrC0Sjuz+bmpnajuqFEl7o2scGGLxC9WdE8
	U2kfatEEvnfZ05ouV+1sZkQkBV9nYOaCj5MzS1TVSJ1lBK9hYnq/NkkIYHiiWOZLZoQsDwL6bpS
	ElYPieEWV6gtBMocFDnUkqwDWtdWdlsNTb+N2PMqxzeThjSwdK5ssDVSwCEz0cEnuohzTGUMyJ5
	QLV6tmc0ocB6MZ3bhvGf1q+kF2GGOIIwNCCf40f7n6aTgyUcX9MotZbL+u5GQevjH7Rd4lVqhH/
	JMrlo5YY1+IvuYlcyy2pA1jOZ2NvmtdJylPq944qOMHPzup5/sDZ106J7XF1ewZQ//0eTB1vWSP
	6a8LQUrlele/eqjJG5CCp3w3n5YjZaFu74MPCG+auZojbV5OZAVbITLsGcIW4wfZ+ESETudTX5m
	Y71bGZyzgZxu7KIc+rsw51V4/iSAo64/xO/TlMSEJAjy6XHso/DAM3F9k5EMt15PfumZtSq/Tzb
	c4p5QDjEIUkGBlK3OR3f2R4ExI9EJLWyIOAsuuvPV7M+F942AMyAkIzT/iRW21Kgyyzzn+VBb8Z
	aCJ3OGNbqIHPtcviRAPFvT7cclSyPeqwx9DqI4kmmpJODZQcStZQygmsFVLHIwyuzIKk1Fvk4ky
	InMZerRDimZ29GLDJlXpAR+689aWGFSKnebh/otHnTiBNOxA19q4GHjoIJfFOHeM3j7HUZSV3fA
	==
X-Received: by 2002:a17:90b:4d0a:b0:3ac:ea3b:f28b with SMTP id 98e67ed59e1d1-3b41c9cd21fmr5968533a91.24.1795288468103;
        Sat, 21 Nov 2026 11:14:28 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad0a34asm9273130a91.3.2026.11.21.11.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 11:14:27 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 7/7] bpf: Replay an offloaded program with the precision of the good pass
Date: Sat, 21 Nov 2026 19:13:42 +0000
Message-ID: <20261121191343.3670609-8-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261121191343.3670609-1-alexei.starovoitov@gmail.com>
References: <20261121191343.3670609-1-alexei.starovoitov@gmail.com>
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

Only offloaded programs are affected. A valid program loads, but nfp
can refuse to attach it. No unsafe program is accepted, because the
pass that the driver sees is a full pass with all checks.

The driver must see only a pass without errors. So the verifier runs
the good pass once more with the hooks of the driver. This is the
replay. Before it, bpf_partition_for_pessimized() tries more precision.
If that fails, bpf_restore_precision() takes the precision masks back
from prec->undo.

partition_next() makes that copy. If find_calls_to_unproven() is over
the cost limit, partition_next() does not run, and prec->undo has the
masks of an older pass. The limit is low after the first good pass, so
this happens if a later good pass ends just below it. Then the replay
can join more states than that pass did. In a test with a stub driver
max_pkt_offset was 448 in place of 56. If that value and the MTU are
above the packet split boundary, nfp refuses to attach the program.

Make the copy in bpf_partition_for_pessimized() too.

Fixes: cd97aa1387d9 ("bpf: Do not let a join raise what a program requires")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/precision.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/precision.c b/kernel/bpf/precision.c
index e6dfb9f4bd..33b180b35c 100644
--- a/kernel/bpf/precision.c
+++ b/kernel/bpf/precision.c
@@ -1645,6 +1645,9 @@ int bpf_partition_for_pessimized(struct bpf_verifier_env *env)
 	prec->good_budget = prec->budget;
 	for (i = 0; i < prec->loop_cnt; i++)
 		prec->loops[i]->good = prec->loops[i]->precision;
+	/* bpf_partition_more() can fail before partition_next() makes this copy */
+	if (prec->data_deps)
+		memcpy(prec->undo, prec->data_deps, 5 * prec->words * sizeof(long));
 	for (i = 0; i < env->prog->len; i++)
 		if (env->insn_aux_data[i].pessimized)
 			note_unproven_after_pass(env, i);
-- 
2.55.0

