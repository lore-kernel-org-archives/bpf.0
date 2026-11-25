Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795577553;
	b=Yz5aUteCENVoUt4nyqUg341kpB79mfP1jTxoXqBmsmHwluALRsMWlqUNVgqWCUBBTLnL
	 Luvkc3DXUP5Nj5+SzIvXkMNWYM5BRjJghRVNsSCIgSJEcsto8t3E2q2caL1OvtJRtUXq2
	 coOfbovPpvmidJKQKWew9Zhpzw85vLeO+ta6sZT78D/5yhbeUTnEWnVCwbaix8nAcRsKa
	 DOd+e+oagOvMTLCDWmq7k2Crpmi7x/F0ftKVw4QZ++bC+dmzhezKsO6YfTY81OmAlVA/6
	 moJ80CmEG/BcoGoJPpvHmLXZqnRV84QFLVL/POeJJxVawpn7mDZXKkZ/+rtiGvLN3mA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795577553;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jsGvTT/YacWWQQHA+YDd4OLbVS25lDIoGagd+U7jfsI=;
	b=xLU0e6edZ4+V0hPWX19nsKln7gfqnpSpVJ9D68V3aZhgEZFB0+7j5q5nGjnrYf5fYvA2
	 AaNBSAvQFF0Q5wnZnS2Q/TCxgk67UjnSnrEumf1sscRaQcaFtouHovL0aLR9ndLm732ZG
	 9IrEz6iQ5JGzIxN4DsONX0RP/XIjFjCrMvJVUH7SzbCRAQ/DM1LidrHOeT0I3OkCj+uGK
	 jJnuq1RyKxLg7wcZcOCsK67cYbDDYwReyAixCsAXTkTGql3CvDbBnxGpTDv0VgtzS+8k0
	 pscq3em8s6DyZPbw5CTHOBbdUDMfY4KW94GVT+I3smOoiqiuRa5RxTGseQtxjxKNkbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0I8qh0X2;
	arc=none smtp.remote-ip=209.85.210.178
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70697606A31E
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 03:32:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70697606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0I8qh0X2
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8a4c72951b8so3371061b3a.3
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 19:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795577553; x=1796182353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jsGvTT/YacWWQQHA+YDd4OLbVS25lDIoGagd+U7jfsI=;
        b=0I8qh0X2cnD186Bn62tvgrc/Dvaq8YAykw6kGMIK0N8rrQhjITNhMtzBrdXbaMdlmi
         eCD8YoOXP/qqsZW8G/u8Wg4s5mQmhOAXMtSvxFrwB2r9gN5N14ZMwp2fTwepnfoIMmiI
         /Q0gqOBpjy0fAdifTdpoMesW82nBsNpEIEEEELgNp+3FqKwdUm4y5BzAAm+tvsHkVKzm
         SOIHiG7wrtJDoTldzt7+ue5QfNzutp6HwhnEI7yu52naIa0+jBZPWMS3/lgW7xWLOa8b
         keyUqUEydTiz1fCu8rG1nV8ibECgIPlqIHbmR9T9+n+o0SGN2CGrPaeJ03ClgDZ5EoHA
         xknA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795577553; x=1796182353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jsGvTT/YacWWQQHA+YDd4OLbVS25lDIoGagd+U7jfsI=;
        b=j+wCgS95717LD4lB2+sbX3hPIIFZgjJSVvfTkuh1IkzEMufLqFJDJwyMAviCn0Bbtm
         rvJ33bIfleaWVtUxzPag9XDvUyvceh/nAIsGG5FQP2wFpiEpIcIDbHA8eanjhI3ZC7iM
         hpseerzsKiD94YkngQXsuKDVHkB//7vhFJ4Az0w0Lwu3AfPNCf2fhIVxC5zkCxjd6DZE
         wYEfDX/GjfuxRLeAmwGSh5oDhnSvRtcpoHA7roIWfq91aK4xy7Trwc8ciYVd6LSofbF6
         ZAuT50MVyhI1FbSxIcQ1NE3oej5Y+7UtiR+NGajfC0Ryqd9cN6bbj66rI9q5fEg2OaoU
         u/ZA==
X-Gm-Message-State: APuU4Z+5NStgkqlEHPjlsGmrApWuEDg4Icb5jnAZkVFTGAZyjJ7EqI5z
	4p+RO8Qrv2a9RzajlsA9sNgyvmVj4T8mwkxS/wFqJHotSAvotdllqeqS2EHmhdzS
X-Gm-Gg: AZFdTZfDxFVD6rEWFBXs+wlk5uYBz6kZf+Jz2G52wPnvOAH03ZyK4gt0RMUaVDLnMbT
	nyxMktXVRuDrnD5ZtPGovqSKORRPH5oYbeb4OM71aQwmZ8KQjae6H+dcMbUG5xjd/OMmLUKBSgF
	A9LN+x2f5w3ILIZyVzxz6fgNnVCA+ovEvS/LmatTM1TOUMcxCVc8Pz6mM5K8LOJWGseRRGR8Ar6
	T6aa9ThiQGOVO7nrFdtXmFlzdt09+CzSgp+noPWxur0kbdo4rTtHfJ5qS1TKvn41dTxbBoOm0hv
	PffCDAuqAaczbD0zWnBXo6yxoMztdgavJIyJBWkwhS87B28fIcafvHH0vLRPftBFQ7xUltELC4j
	RmyPA7SdfEpRyEN0V3jwG+MFZ+FgeYVsGJ2570ynYdA7hH70poVxt8W8GVC9buiTMOd4GrM2clh
	IJQGoHlS5w5O9QKlnNLBYRLgdKUuU7HO44pApqWk8vRT/Wy+84mDyNWuq5ONHGEeKXKVczRbMy6
	s2cyP59i5NvwtW4takpwJVrPt8mQe7VXQhMcpb/R6lNQuNOTEcRdirFi8UJ98Dg5r5uQXjppv4S
	wlWpsz2Sgt0+P64as7ElI2FeCxEahhWIJIny4XlzBybBk7Wpmu6cNg3noYixDNFMyp4jfVJtKIh
	EwqOT1TsnG7iyZIFpuwxHvmg7SN4K9OpUlU/FReGPnKdqGlBHfxlwDUh9UqKN1xVKjc+awH/pTQ
	==
X-Received: by 2002:a05:6a00:4391:b0:899:5183:acdb with SMTP id d2e1a72fcca58-8c8796a7efemr13670715b3a.1.1795577552858;
        Tue, 24 Nov 2026 19:32:32 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c872e457d1sm7778159b3a.30.2026.11.24.19.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 19:32:32 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 29/47] bpf: Require CAP_PERFMON for dumps of xlated insns
Date: Wed, 25 Nov 2026 03:29:20 +0000
Message-ID: <20261125032938.670542-30-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261125032938.670542-1-alexei.starovoitov@gmail.com>
References: <20261125032938.670542-1-alexei.starovoitov@gmail.com>
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

The verifier puts addresses of the kernel to insns: for ksyms, inlined
helpers and hidden arguments. The dump of xlated insns hides the ones of
maps and calls only, the others look like constants by then. Give no
dump, as for a blinded program, to who has no CAP_PERFMON and can't read
kallsyms.

Fixes: 2c78ee898d8f ("bpf: Implement CAP_BPF")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/syscall.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index e82ae48c0bc0..7e1085d6a67e 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5261,7 +5261,8 @@ static int bpf_prog_get_info_by_fd(struct file *file,
 		struct bpf_insn *insns_sanitized;
 		bool fault;
 
-		if (!prog->blinded || bpf_dump_raw_ok(file->f_cred)) {
+		/* The verifier puts addresses to ld_imm64 and mov insns */
+		if (bpf_dump_raw_ok(file->f_cred) || (!prog->blinded && perfmon_capable())) {
 			insns_sanitized = bpf_insn_prepare_dump(prog, file->f_cred);
 			if (!insns_sanitized)
 				return -ENOMEM;
-- 
2.55.0

