Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795067844;
	b=Pc4MlIjFCufHNmQe3ZIJqXQGjjUltkeQXC2Z211yo9v9Q8QTNLG1nmjnE4mW71abEWW2
	 t2xAR23nPpUlUJXnsgEj/ZkS1L/L4JPFbNU4R6bd4zsQ/1E2albmgda9TaxbRmkngoLXU
	 1QUXV4iHzWyw9VgklcuAqk8uxHGz8CKV/O6r/hNR0b7hQdxXjXjr/8qMC+Rg3frs+EEct
	 6l0sMINsHRMPaggY7tcC0Kw2uaYKXonDgdXGRSkdVvDcGvcT3oYOFhSK4HULlO5Jl3CKv
	 svDXROgS/qks4h2JESkCNCVFu1l1wG+POGLsIEGSNmp6er6MabS74MBHVSsYnCFLimg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795067844;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=H5rRbzlaJI2FRetX43N3+DnSZ6B46YSoULdhiw/cIvY=;
	b=cWMeGulgSlI0xOCFexztFbvLy1aWJ36LhqMPRMV9EZ69GGJdXgDMg2/g1A1+CZluoFR/
	 M6AB727+rCe8bI7maX7/Aj81zBqmh2S8iHExjXwZDlG3dDGTmFYO4FL8LYu7ZpflPRk7x
	 BFWIm+Iz0qMmB4GqVemYAeOrWtToyB4WCczxeOQFRptDIK1Qfh+OtvmVhCTSFwGBoiiVM
	 F71jYxbuUiTILx+7V/t+ddjr5rfQvHRGkduw0B61hy93w3rIZkPgSXah25pg/dS5YK0bs
	 c/5ff893XyL/ZEf05L0Ni/sn9LPhEqb1lQFH2SJi2fwcuPR0KmWAo+TjTUJyamL1wXQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="e3ly6p/V";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.51
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3DD606A325
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 05:57:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E3DD606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e3ly6p/V
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-91eb46044c4so22172396d6.1
        for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 21:57:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795067843; cv=none;
        d=google.com; s=arc-20260327;
        b=U65XToQ++WPtbZJT4zY4kfhZSFPV7w7bUg8AwFLvl9hnDalvN81kHbk6/MJzTsCBw5
         2U31DaWzrmxdZ7BpD6LG+gYGY9BxMJjJHWLrUwXFZk/0oVY4qtbHu2vjegmNd2HUabqE
         QC7ij2erKgAkq1wxWLQ1v2MUYlo7PMrM9SwSLa9iGe5HkI+Gygllnu9hVnQ3V+OQUfke
         LrtlxZlPyJpYvIgmiDiwkhSUoMBfs18tiPjhzc3PsjuYAPgljgRfr3X+ot4dF0aZjJlV
         DQdv3rx9f0eg/jkUv0inH3Jjb9W2wPUswdAk2aJvf8lariYzwi4NMIWPCRuUjKdoLyJE
         NF4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=H5rRbzlaJI2FRetX43N3+DnSZ6B46YSoULdhiw/cIvY=;
        fh=hh64WXw32xDCPRIwo8kqdpPDKtEO7rcNvFi6kTS088k=;
        b=IR/SARh3hOgfx9TcBW0+46Umt922Y4DeyIbNxsUOKL5B2tUK3LlhnMeIjI3HFQUCjb
         9+QoYwwRiE37JfJsPc+kcdgYL7TJUQMpd1R45LOd+KYWa2WPKmpBxRUeA/+mEz8iwqUV
         O2veVGRHzDOm/sJTzaQ8rVVin1kCimCaKBkG1Kbaat0SfETkI+8Ag9Jp/Pm9aRqhOC6l
         aqobzkfLSmoaWRcAMsaUdZbN4NUfOh4r5ucuwJKjMFuP6wfLtdDFg9ng3eI0W929eQZ7
         GK1te0+OyCxpvuv+Hi+Y1DNuaKuwmdgcalJRZFk+2OlIGwkqmIxoRxTo7DZ19BmmhtBh
         OzQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795067843; x=1795672643; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=H5rRbzlaJI2FRetX43N3+DnSZ6B46YSoULdhiw/cIvY=;
        b=e3ly6p/VcMbkz7GHnwA+DDMsgb9+xTUT4V2CfgVlyxvGaXn2AYPfAKTMnW0AW9j+tM
         8ZzwsU0R51MlnyXwZ1nYh4fP2dp3LSskwQQH7QRiNgfoHjb6R8qg/iX9d2mRy1ErMrqz
         AbggOFE65ExeyEWgmiZ9i5aOUH5z05zO2j3eBiwxX7aw0d+qJRN/I9ROtcIo73B6obF2
         9qvGr7a/baD9+IpUykV26ZFKiP1ESAWDPVsbk7VDDPO1gpWb+8d3eyvTObeNZ939W2Vs
         MJUvNeWcFzZ4M9g7d5+RG0WCpdCMeqG5fyc5ZEIeB2WC9ZAHroxUW0HhFr35+hcevbtk
         VI+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795067843; x=1795672643;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=H5rRbzlaJI2FRetX43N3+DnSZ6B46YSoULdhiw/cIvY=;
        b=EHK/4Jwr+RrRetN0QgAuqXjq27mf9LbGQPHxF6tXauOU23uI/TJY048Y1VW9Y3OIz4
         +yKIF0KAVKq6V1NkKSPZZMchpL35Yr9h9rRz33LlWBOo5xqhctt5ZcROci5QP05KTe11
         EYIMOjGqFSNaRnymoc+Uh0K2oZBq+lAgCR8R1nrggVJXZw+Wz4k5yhcmM6J/vOpFzi8/
         RfmUtvHc2JyHv5FiCjqgYaeo9dR4WgE2wUY1b4qTWvywtqGT5y5CYSuPSmKpIOjidHtz
         slcCxYbKiQOMtCzEAJ/TE2SVlzdJxvDwsErKPPvSAk77nwHpKchu0baopbAd6zgSS9kt
         +Bng==
X-Gm-Message-State: APuU4Z8cg5gHBOEbdB7sI9GIsTwzmFtI/2L5IOKGUlRKONdvNMj0ktdB
	I9KnPt6MAPrjYxRx/24AmzlRXy0nV0y9FQBdIMtrj8yLybyZcdQIZz8O0avRBU3BjFwVV0eS11q
	CnUkVYDpqd/JJiBxjYCrGs8RofbId+EU=
X-Gm-Gg: AZFdTZdLIkhgZoJPcgW9nKw/fwFbZdA9pli0FoT8NCy+HH/b7K9qT7gwy1Khc8oENvE
	N9oWTULWn7a82lduq1PoZqz6a/lDw2qWlCelnR0AgSluuEVi280LVuadk6WXbHN4uv/BOnkEpW+
	E04NdMNIFD29m0JxZAHJok6CYlEh78ifZN8Pub7gJydcao8tIjKp+kOUjO7iY2AJH96YHvs919B
	lYz9oMg7HvmpxQ4dIuQd1myg+FoQ1+Fwk+hyyrk5hXe/2EXWQ9hL+rZ2vCEMBXCm3Q0dIbZTveA
	VBa+3tXZ/7N2OEgSxemBFM4M2LQZ2wQ+swtTnkMvFrFqQH+8ugfP3mQt9i9kycgxYT6JDoVWbvV
	89COXBTI4CfW2270/e8b/wpV2NBjw8Ms5D1yXyPfHBFfJnYFtAB9qkpLpG0Dz/p3SG2IUQb2Bl4
	j7R5rUB6ErFlJoPtw0JQ==
X-Received: by 2002:ad4:576f:0:b0:91f:23e5:d4b8 with SMTP id
 6a1803df08f44-92114d58c11mr78514106d6.8.1795067843261; Wed, 18 Nov 2026
 21:57:23 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: =?UTF-8?B?5qKT5bed5ZKy5aSq?= <inkxiao12@gmail.com>
Date: Thu, 19 Nov 2026 00:57:11 -0500
X-Gm-Features: Aa3M54q6Q-aOvhfX83anAAiTanDvzi-C11ngUmJob3qki4Rq7-QTM1P9d7ediqk
Message-ID: <CAMcAce8CPKNbO41hBv7MygO4kXZHkHogGgW7dN75qBjeFrsEjg@mail.gmail.com>
Subject: [PATCH 6.12.y] Backport request: c83e2d970bae ("bpf: Add tracepoints
 with null-able arguments") and 6.12.y netfs_donate fix
To: stable@vger.kernel.org
Cc: bpf@vger.kernel.org, gregkh@linuxfoundation.org, sashal@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Stable Maintainers,

Please consider backporting upstream commit:

  c83e2d970bae ("bpf: Add tracepoints with null-able arguments")

to linux-6.12.y.

In v6.12.118 (kernel/trace/bpf_trace.c:2365-2410), raw_tp_null_args[] is
missing entries for nfsd_file_acquire (args 0, 3), nfs4_setup_sequence (arg 0),
and btree_path_free (arg 2). Additionally, 6.12.y contains
TRACE_EVENT(netfs_donate)
where argument 2 is nullable.

In live QEMU tests on v6.12.118, eBPF programs dereferencing these nullable
pointers without NULL-checks all loaded cleanly ([LOADED]), leading to kernel
NULL dereference crashes. After backporting c83e2d970bae and adding
`{ "netfs_donate", 0x100 }`, all 5 reproducers are correctly rejected by the
verifier with "invalid mem access 'trusted_ptr_or_null_'".

Note: netfs_donate was removed in mainline 6.13, so `{ "netfs_donate", 0x100 }`
is a stable-only addition required specifically for 6.12.y.

Fixes: 838a10bd2ebf ("bpf: Add bpf_raw_tp_null_args()")
Signed-off-by: BoBppy <inkxiao12@gmail.com>
---
 kernel/trace/bpf_trace.c | 6 ++++++
 1 file changed, 6 insertions(+)

--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2370,6 +2370,12 @@ static const struct bpf_raw_tp_null_args
raw_tp_null_args[] = {
+ { "netfs_donate", 0x100 },
+ { "nfsd_file_acquire", 0x1001 },
+ { "nfsd_file_insert_err", 0x1 },
+ { "nfsd_file_cons_err", 0x1 },
+ { "nfs4_setup_sequence", 0x1 },
+ { "btree_path_free", 0x100 },
