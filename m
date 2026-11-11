Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794374074;
	b=tBpQxHVjYDh3dQmNOSmeg6QMNQQqP1vbkSiBnD9YIpSbQ/AH2CJhmi88zRcZLaVRqWdj
	 mXuZ/Cvghnvxh8Xag5ABF8+hGstAn7k5DOSxsJC0o4gVG0ZieOkOBvZnSEvVCSEMHiwzW
	 2GR71j4tAPUdisU3JWJgKKEOXICTQFRWlut7/nByu70F6OyTyqyJtLZOdA87C5GnvUf7c
	 brbW8SWglGTYQykQ4W0q9xGVS3a50W4KtDj+2iQ1BWV8/a2CG0vZz7mCQp+bWnVhe+mDE
	 h8252mYXPe0CTiNPfb/RmNTZv9IazOvbk3JCF6wxa665u4WpKT6bqm08rvJJn+Z5ihA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794374074;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+NBoOXcaos3ErxZvdIIKho9Gh/ViSTW2Pnfs6yLB/Sg=;
	b=v6w2mi981/HTOWuvnDhV7pJzASvtVbhfsio7fAKuAy+EdqH8zG/u57XOa4NAUaCajyUV
	 0KytF4rDpcalUDNNSp3lGzLyFfcT/pM5btbAbwP5L6Pa6YVa8Gxl+DVQzyyL8E2HiXy1T
	 lOOrrzazDRavQtsm0SN7Ff2aSKcbr0rQlm1+1t46E9zSJlLukfqqSBCnjoh9MgQZbthlw
	 EawRoA4ATE08OOO+nRwwxih0sPTeS8c3iw9tLKDD8bhDvZELcn/R6tMRtnchwOOrvP2HU
	 Bs83LIB77OAYQRaptPq1DhSGs7XPwN0Gr5kzC4bifHdeRO1nFQ1yr/xOU079fEMA+7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EF4Fk1sn;
	arc=none smtp.remote-ip=209.85.210.178
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEA8606A320
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 05:14:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BEEA8606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EF4Fk1sn
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8a06cc097c7so1638076b3a.0
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 21:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794374073; x=1794978873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+NBoOXcaos3ErxZvdIIKho9Gh/ViSTW2Pnfs6yLB/Sg=;
        b=EF4Fk1snHME75Je+SpQQzOgslEdnjTO3CF5xW5POChZO9KiNgEbQOPJlK5ijD/xdT5
         g7SpMNZ9thy/RH4ga+cwpKY/7UKiMPio1U1W9OJBqg3JqN5pYq+KprAVOLf3sVTM3/E+
         BnZa8bgS2f4pcn+wV5MnjuMe883RijjfcdfpZtdBpo/ZCZKL0OhgnJyscCXgSyxbyN6s
         M0RoryJlkYNoMLppzseAMhLHCdXGDHHtZVdqrSqOYzambN8gg62uGCok/2ZyFp9/rpGH
         Apy7AaIL/88rS5ntAHll+rcUcktRmau9iQ8Id6fCJrg4NiJx8ZOVO6FjtfIwZDBXgyEA
         +tVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794374073; x=1794978873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+NBoOXcaos3ErxZvdIIKho9Gh/ViSTW2Pnfs6yLB/Sg=;
        b=0QN2tH+pMNLZ5VCxcGb/ghCUELJVdIq7L35dIskNvxI4xuXovfqtqUhQnuaJEu45w8
         DTfpA+qR4kBNOQ1xPWJrIqwcCgPHwlMQf3qjMnyW1eQMD2ZDFoja+lj9sGY5CjKaSIZF
         xdBaGA6SJM54QeLVgK1hjcQFcvaw7L5svYQUNM9ol1Jpq01r3p+MPdBaFGjxE35LKhyb
         OxVIP2GxEy0zBKjV3FOGPG+c8HvZmZKG1wUfodnStTQdhum0E+QRZVAyNePVJXr/yN8k
         4nlPBb0Wbzq+2PE3gGMNI0wUINsoTAISAOaN33GT5boK5L5AlrK4US1m04GQvlmi/Jvo
         cH8Q==
X-Gm-Message-State: APuU4Z9yOwELwKcDBbdZLfyBwAIj20fJ0SK7lN6zXm0IrjkJjFDcmCWP
	AomdeKcklTOIe5V/hHTizP3FxG6KDvjjeirsa9edFVzYM3k2TN+tEgdgsIBMVQ==
X-Gm-Gg: AYBFou0Pssd/fEN7tqgPnIUgksfeUQ0f8d4aEBy3ryOb/c21WTHnHGhlu8X9aOjQjHW
	cQ0jYXKgCPoS/gNbDbkLArLU9E44Z11fC4kh0M9MBSh/ATvCvWMEIBnxYJIcPIu9xY3gR7h7eY5
	T/CWX0a/XFQD8G9UNHfCMFeZtYCCE5V/nWfRJHddHiNQV6cPYjaZ2g/08XisDPLVMCGcBnjUMyf
	gDQi/uwT54rV7HeCIaB6BKgWbN43GWlki+4ukfKA1y7A/JbcLwdzRngj/nLic+hUYu8LyJ35zJ6
	yCdiu1qfh+4UrALA9vjPXoSxKdly3+W4+haTAKSYkbh2yVmlMe10lfvY8/6xYxgHtD7tBAi54qr
	X40TDboev+paEhf8o9sBdNySV03BSKjVxbU//56EVh5Jmqj8jWRM1qNF3/Zyb1olJ9xAlCOebM3
	j9vb9z1VTLkmhkFZfivpOmDDFPLAmDdBAISLwosHkaicymKnlAi1iOdW53syYb7CZTlwOtPrSLk
	fPqt4Zezv4gBGNaQioElLomS6UeJSgFLbQ5tJAqqolsb7kiCHNRXLDqMI6u+7D55Jow1vfriijt
	/5/lKaqRaICm5OHPxNV3pIGMRNMV8QypP3XIE9XELDcZLBzjHifSGplTAgWZv4z23FAwir/Ipn7
	LzAza56yi9ETknOepapaYORbmoOaXrxnI4ULTcdWjFPzj8ES/q+sq+KdS3eEiD4vWuhbaGi3mrg
	==
X-Received: by 2002:a05:6a00:1f11:b0:891:1caa:3f72 with SMTP id d2e1a72fcca58-8bc1d91249bmr1554766b3a.57.1794374072799;
        Tue, 10 Nov 2026 21:14:32 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.251])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baaae3e9dasm1692328b3a.34.2026.11.10.21.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 21:14:32 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 08/29] bpf: Mark the attr argument of bpf_sys_bpf() as MEM_WRITE
Date: Wed, 11 Nov 2026 05:13:19 +0000
Message-ID: <20261111051341.2800252-9-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261111051341.2800252-1-alexei.starovoitov@gmail.com>
References: <20261111051341.2800252-1-alexei.starovoitov@gmail.com>
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

A fix of the declaration of a helper. This series needs it: scalar
evolution keeps the expression of a stack slot across a call unless
bpf_may_write_mask() of the call has the slot, and liveness.c computes that
mask from the argument types of the helper.

  union bpf_attr attr = { .btf = .., .btf_size = .., .btf_log_level = 1 };

  bpf_sys_bpf(BPF_BTF_LOAD, &attr, sizeof(attr));

BPF_BTF_LOAD and BPF_PROG_LOAD store log_true_size into the attr of the
caller. When BPF_PROG_LOAD rejects func_info, line_info or core_relo
records that are larger than it knows, it stores the record size that it
expects. For the helper the attr is a kernel pointer, so
copy_to_bpfptr_offset() writes to the memory of the program.

arg2_type in struct bpf_func_proto bpf_sys_bpf_proto is
ARG_PTR_TO_MEM | MEM_RDONLY. So the verifier keeps what it knows about an
attr on the stack across the call: a slot that held 0 is taken for 0 after
it. bpf_may_write_mask() of the call does not have the slots of the attr.
And an attr in a map that the program cannot write to is accepted.

Say MEM_WRITE. An attr in read-only memory, such as
a 'static const union bpf_attr' in .rodata, is refused now:
"write into map forbidden".

Fixes: 37cce22dbd51 ("bpf: verifier: Refactor helper access type tracking")
Fixes: 216e3cd2f28d ("bpf: Add MEM_RDONLY for helper args that are pointers to rdonly mem.")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/syscall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 9004f2673ccf..04a3b3c80c74 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -6692,7 +6692,7 @@ static const struct bpf_func_proto bpf_sys_bpf_proto = {
 	.might_sleep	= true,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_ANYTHING,
-	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
+	.arg2_type	= ARG_PTR_TO_MEM | MEM_WRITE,
 	.arg3_type	= ARG_MEM_SIZE,
 };
 
-- 
2.55.0

