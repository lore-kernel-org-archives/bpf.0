Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793896625;
	b=SVwkPd3nf9Y0NG89bc6iIPWd2iy4SgjfjbMfaz38tQwPLEG/YaEj8bKHCmK0QPqARour
	 RZ310rBHQQ7VRwdkZqW4nD0AdebaaxvBfEv0vneIVmLOqFXtZ1FPxkmhpEpXnht+u2W9t
	 ljqopUTrh4JZUsuaqI6j/NiRwmkK8iiE4oNOxqXtuUm9+xPmUtfv7Oz9YjQ+ujTJ/+PXq
	 KuJucIn/9bcjr0HW64GpPp+4W+1NAKygz6ATEXATWesNgH6ZXACNAGCPCkS/VzIyLcxN4
	 dwB6FwV8muvldvRwgoLeW+g1IG5oum/Kf8d1npbYV+fgJYKgqerP4OmCuBxTWeQn72A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793896625;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=EMTT2HHjSkY1uGJyH89VPeEJ36kiCXEDFii0T4E6Iac=;
	b=GKly3so+jyqN0Y0Iwj65wNmoDRMmJt5y+2SQ1WKbVDw4xT9WoJsqlc6N1cCwdjLeR0Ji
	 ZaXi7kgF9el97t6qH3sPTMX7KNlmFNKn6hczJQfSfSmwxtCSZbHtGh8O1ieDGTc7GTfg5
	 UZQPGdqSU6WlGFIjEtgUzwDCdRByRF0VqzKwm61iM+1JbBOTlszOwQvwXxIVCqzYvknuc
	 rMGyXV03gbWsLhiYWoJkNjdvWPzAtXn1th/qSLjTPDEkRLEb74LACWzXxZagOob2Av88j
	 IiRVSxygs9TyU2IH+8Al/WUgWx/SQCtlQzmVlrigw7HC2bs8qRgNy+nNE+CicC9Wzjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h43CPja3;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D497606A903
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 16:37:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D497606A903
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h43CPja3
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3adac5b29ebso1236328a91.2
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 08:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793896624; x=1794501424; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EMTT2HHjSkY1uGJyH89VPeEJ36kiCXEDFii0T4E6Iac=;
        b=h43CPja397Wxk7BuUAKdbooVEpDaqJLuGmG3AT5/791iKKS5eiAU6lh7u1JbE0Mq78
         +9oRSianhKPO/HA1gBL2vrU3w6lIR7qSraYBEdVYl2uPJ65ncsS1I9I2leOVuGrcv/bt
         sAy/aUnI4dnTLwPZC2bvNsTsU3icEgBMF6UpzeBqy/b0rCnmZGuF2bDQzCh8XbcZgzR7
         yKsxt1bp1lX5qfOUdhfexth16YT+tHLrRTx2oVdFuCI2YzD+TdredLDDH/ZKAC+4wHi7
         EB/KRd04cjwrwGzxsPxdGWxuJHdoqObrQeSF2bNgnOpZueQPe7OyekDD96xtrxdjvPtR
         59nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793896624; x=1794501424;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EMTT2HHjSkY1uGJyH89VPeEJ36kiCXEDFii0T4E6Iac=;
        b=izZ9Sy30xDDJ2I3QBDnrP840TFvylb3zYt/NIb2vpHCKfBKqmtXfiVhX+Ds0GV+ovQ
         xsVY65Z8SBCL94vMPk7tZaptR8sG9dyjrmin4BUdKpdjBYN9ZmIiDXFgLNZdlPgtcpmh
         sNz4SivXDyCUggQBT5RIMr288h619Lk+DSHo5BIiqjtGUNwgjtUl7u8l297xdb+C4/wF
         8jDXR4xIz5bbuwLDWHxqL89M3k+uhXwsT4Tx56MxhnGyCRm0VFjKMuh0T3XJnspKYq7R
         vpyF+qEt/ECRMCtmjwwhU1iSu/AbnhGcyLmm4yzPw6kf5nKrV2eFySbXHgAeZqlbg9Yf
         9/8w==
X-Forwarded-Encrypted: i=1; AKwUvBwN3paKYV7uvpDdFCaMqw8w5+m9cd/ANK6sy+Bf3XgjPqOuj4k9Fr+K/zjhj6jmh1V2wY4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+VsYsn31fnrX6QG0BJmuT9MY4ES4hVlC5ZWy5M1z8KddkQvCL0
	TrbSDbARQ8YxYEG9QTbo6NLJJ6uq+RqxNLApz6iyLzO8COaVQdYfBfwS
X-Gm-Gg: AYBFou0lAYJbQUtut7K07MLPHfim4B3PGluvTGWjN5sBUMsBnJJrLxjaFSs9P5qOfZg
	ZbviMNYsJTRXSHGBwC9pOk2Hjh5Is9WtX6/q5ooVJv5+GDC05hDIg+weSGBgzmi7lh3xNA0t/dO
	mTwjpYRnbYeS1UjzqS9XaV8GGliq4nHzwqot7op+BMevygd4DJvNM5gRMD9FILKXAZpWOjNh4WE
	P2XyP6mKiRQurlQN4vS5DzXUlTd0p+FMVqFT+Bh5UvJg82kWTpHApx7AuDdQdGTN/5+N+mt8blf
	jfogEAquuoAsNCcS5cLsTb0RMERzjU8SVVmlWCJj/Hc8XpOZa+dUafK3EKmH58Wq+qRIo9Ra5HJ
	Ww9ySEOX7SIesyVImvBG0K5Ls+IFYvHQc0A/u8MnwAn6QOY4xHbQ1lQAJ0RpweL5JyIZ501NI6f
	uUWHrv4sHpiA6PLMoYONNAQl6c3GY7EAS9OrX92x4KfDkzITMF5WCicIu9Hv6muU9vqbbGvNPS2
	sUWrBTnKfi0gAPOZJuP5k8Ew0CBk7mJb4q1r7TQijdk21w7xrCjhuBmK1BuFMLVAB3Z7gWxC4Ss
	6gtKoWalxt+ncfKQhLzrpcihzUceSNqy9jdYxPde5n+PtaUpnEwGyPNu/9Pd4l2QiMybCaDfZAY
	Wtn6rXvQO/jbwuQ1A+T/0XNiRDrRsJwNtFQ==
X-Received: by 2002:a17:90b:4d85:b0:3b0:a378:1cf with SMTP id 98e67ed59e1d1-3b0a378049cmr4183905a91.22.1793896623555;
        Thu, 05 Nov 2026 08:37:03 -0800 (PST)
Received: from localhost ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b3160634sm4692625a91.6.2026.11.05.08.37.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 08:37:02 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 05 Nov 2026 16:37:02 +0000
Message-Id: <DMNFA3D0M816.2K02S8LB47QM4@gmail.com>
Cc: <eddyz87@gmail.com>, <martin.lau@linux.dev>, <song@kernel.org>,
 <yonghong.song@linux.dev>, <jolsa@kernel.org>, <emil@etsalapatis.com>,
 <ihor.solodrai@linux.dev>, <pulehui@huawei.com>, <pjw@kernel.org>,
 <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>,
 <luke.r.nels@gmail.com>, <xi.wang@gmail.com>, <shuah@kernel.org>,
 <rgbi3307@gmail.com>, <guoren@kernel.org>, <bpf@vger.kernel.org>,
 <linux-riscv@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 bpf-next 3/3] selftests/bpf: Add a runtime test for
 private stack and stack arguments
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Chen Pei" <cp0613@linux.alibaba.com>, <daniel@iogearbox.net>,
 <andrii@kernel.org>, <memxor@gmail.com>, <bjorn@kernel.org>,
 <puranjay@kernel.org>
In-Reply-To: <20261104100411.997-4-cp0613@linux.alibaba.com>
References: <20261104100411.997-1-cp0613@linux.alibaba.com> <20261104100411.997-4-cp0613@linux.alibaba.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Wed, Nov 04, 2026 at 02:04 AM Chen Pei <cp0613@linux.alibaba.com> wrote:
>  .../selftests/bpf/private_stack_runtime.h     |  12 ++
>  .../bpf/prog_tests/private_stack_runtime.c    |  84 +++++++++++
>  .../bpf/progs/private_stack_runtime.c         | 140 ++++++++++++++++++
>  3 files changed, 236 insertions(+)

bpf ci is right in the other email.

pw-bot: cr

Also, the test runs on riscv64 only. BPF CI runs arm64 and not riscv64.
arm64 has the same combination and no test for it.
The run time part has nothing specific to riscv64.
The __jited patterns pin the frame sizes that clang picks for C code.
zero_stack doesn't use the private stack.
It's the only reason for serial_.

Two asm progs in verifier_stack_arg.c are enough.
BPF_PROG_TEST_RUN runs a raw_tp prog. No need to attach it.
The test runs on x86-64, arm64 and riscv64.
On x86-64 both frames stay on the kernel stack.

Like (not even compile tested):

diff --git a/tools/testing/selftests/bpf/progs/verifier_stack_arg.c b/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
index abf319c..9423048 100644
--- a/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
+++ b/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
@@ -667,6 +667,53 @@ __naked void stack_arg_precision_fallback(void)
 	);
 }

+/* Writes both ends of its frame, then reads args 9, 10 and the frame of the caller. */
+__naked __noinline __used
+static long priv_stack_10args(long a, long b, long c, long d, long e, long f, long g, long h,
+			      long i, long *j)
+{
+	asm volatile (
+		"r1 = 0;"
+		"*(u64 *)(r10 - 8) = r1;"
+		"*(u64 *)(r10 - 64) = r1;"
+		"r0 = *(u64 *)(r11 + 32);"
+		"r1 = *(u64 *)(r11 + 40);"
+		"r1 = *(u64 *)(r1 + 0);"
+		"r0 += r1;"
+		"exit;"
+	);
+}
+
+/*
+ * A frame of 64 bytes in a raw_tp prog goes to the private stack.
+ * arm64 and riscv64 pass args 9 and 10 on the kernel stack.
+ */
+SEC("raw_tp")
+__description("stack_arg: private stack in the caller and in the callee")
+__success __retval(890)
+__naked void stack_arg_priv_stack(void)
+{
+	asm volatile (
+		"r1 = 800;"
+		"*(u64 *)(r10 - 64) = r1;"
+		"r1 = r10;"
+		"r1 += -64;"
+		"*(u64 *)(r11 - 40) = r1;"
+		"*(u64 *)(r11 - 32) = 90;"
+		"*(u64 *)(r11 - 24) = 8;"
+		"*(u64 *)(r11 - 16) = 7;"
+		"*(u64 *)(r11 - 8) = 6;"
+		"r1 = 1;"
+		"r2 = 2;"
+		"r3 = 3;"
+		"r4 = 4;"
+		"r5 = 5;"
+		"call priv_stack_10args;"
+		"exit;"
+		::: __clobber_all
+	);
+}
+
 #else

 SEC("socket")

