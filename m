Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793749345;
	b=wkxRmfieU9snj0SRNluqqRqumzgOdWaFy/EgBuD98qiN2cq/csdZPUzEqrdzcsihoAJI
	 y/oCcJbMZyWMafm+7X2XDd+rsJvO7W0Pn6XKDPtCoP2l+wpc+PTNT4bLnxYBhRVs0N+ZO
	 18pvrVyJDbGcwd4+9DGTBsY4slU8VPYXmywhqCIQnKb030QFeotg+qi7cA748fMC6Vl3g
	 CWLTyCBJsMQlSBB3OVqz0dHbK71OTk9ycLmbpjs5CrL0kQbfyIVC4wqCi2I5bll25rZp0
	 FhC9Y/ERqeV5W1HCLMmIOj4rYvuHdMaagfplXwCaI9+FOIVbYQpE+enVEQlFqAYT1cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793749345;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=w5dZ2bmCZveKAtPcCXhaMd/vzE4KXlVYMZ8X6MQHYRY=;
	b=ZNfCXnZXJm0OexC/CEEoo2PEjKh9q60NhEAO12ihq5M0FOIC3IITz0f2ky5ghwWzCOEx
	 eDsXQ7NINs9zjI8MAg4dMCT5H8zufzzaUYfFD/y5a07JFRp7552oCBusNplydEYUcXIei
	 S03BBRnuYoysHbv2PCBuJNB3wRcB3mDs1jaiuguzvkTNe9EBzURpWed7hXYWXSgyIDFUF
	 DPvbCvCu+7BIZgTFNvJ08wjrEMGZfwHbO1lKoXBBhDzAlSivJRYbyifZ4qNM/3qclORbI
	 bFjSa1cj0kKXn1/Iiz0emUzgfO05eS2bZ4xaobZ22wBlJq3FoXJY3F+myRwtJMTxU+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aTGFilBk;
	arc=none smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9843F606A31B
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 23:42:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9843F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aTGFilBk
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2e940d5d2beso392135ad.0
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 15:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793749344; x=1794354144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w5dZ2bmCZveKAtPcCXhaMd/vzE4KXlVYMZ8X6MQHYRY=;
        b=aTGFilBkIEU6sFbRD2+zhJf0QxmWglZ2Enjo6OPtD3cOnCjduQjwb38psKcbox1AjF
         tX3adnBgO8AgTafV4l6jwX3Mk2EjVWtsKOYVWPhT02zFJsza0Ck2l3+H/m6yvU8C/dJZ
         WQO7AfjGup7EJ30StQUkjCL4h9jyOwtOfqdE/kJLY6S/kR9rpWFdqxQTOwKp7j4ievJd
         S+Hdb4CE5G2/OQuZ8KlDA6mlPdxQgFEeCC6gUS6X3AzwbpcDYIYxAgqaQ5TyYWe8XLsH
         SjOKlFZYKCXjdPCFR2GJchOGB0Ccg21ur4BR0Fk6ylyWwn6IJoP+J1CRnPHN2+r9UTb8
         mllg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793749344; x=1794354144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=w5dZ2bmCZveKAtPcCXhaMd/vzE4KXlVYMZ8X6MQHYRY=;
        b=swCs2t/5TknTGP78ZB+StT815o0RSjQoPcAaQ51Ky9RnkzAG6vZ/yCZYcCErkd/0hU
         fHOlJX3Mmj5hdBbsG/U6X6ns7UV49dfXwAwLQCLM5kITyZ+cJdhx6hDL6UOs+jVLgRtO
         GTleglbQCiRva3GqqUnQKlnGIq+xPNjVS1Jb4lfiq4jl1QxrlReWgmIBifp0qatmobSo
         cWv62PXfyk6J118CLbK8SppBr664ehbmbjcNVi32j2R3lf+WbyH9QHOVJ1PoaYgn1kHJ
         Ou1OOVdhkicYGipmThN6lEFZnfM1yay5DQPYVeVT9hSbBqxvu5WZOw3I7WXN/e/fc9Dm
         Y9fQ==
X-Gm-Message-State: APuU4Z8lQpzmVuXKZ0Hdp3Np0z6gcRGCJGBh4iQetjkf4BYlXl1NisQN
	/uT5bM+DaEMfmHoFg3MR0P5g2yPg0UBz7yT6+L9cX05Iu/CCtfkeFtvzWvj8Zg==
X-Gm-Gg: AYBFou0pb9Id4dca2TbATmBqs4Ftl5ZI8cCo9XbMGasvPWX5+Z4dm/iW8gnWQalaeJJ
	YGXsqXI80K/tTzojKHfwGRdBRhQNXRKczfi7kar8QLPZw+kTBUkx2VURArBItaaJTTnwcol63tX
	v99+js5AQWkepfYZUaP+6YQhEeTkR6C1JKbMf7Z9P6p5O0dS/btJKpTmcDNFTQebN6BVCvuEMKG
	DNI/843jZCdO0kG+6GAMCJ0Yvksg/Hbo+B6JFIXf5wvKQjQUNcVhcrXVk4kD+YHGkF5l8ywCjyO
	scgzrDJCG/yPUWIUcVOin8yGk5q1Df/oFZ36VpdJGS5kwxDLAvNBd/OY3KDU4xl1F3Q+GHr6qsV
	8pOTneTWEZwBmZLV0nm5Kr6dpjC/R5ZklNfXj9emBneuzMLnz4DavD+32YBhF5WR1P82rGWYqpb
	db3TV14K9VwearIv/RXHTCdfN/BlBiYIdEm+yZFuYLhHp6jAjJmpVu1Aypr7JtgoTwCjO7rHSJA
	M3G8Rg7Bhn+g9BG0pgTwUhg7LJ+U1PtwOMCzPmy4+3EFw/KSIipzIWslWQLIEhfx+DYQmRfSlZu
	gqwFY6/I3ETLDDMlkKH8TtB6yIY9OQ1B/H0YXxuvPWoAVwYGRzhhkjfxmW2bKEkw3sFGDfN4Ih9
	U+xITZuO2iza5jhYsU5xwp2UYg7jErCbAq/+k1fsnzeUZKthh7J3kVs0kXpkdCTY01JX1O7WSna
	Y=
X-Received: by 2002:a17:90a:f615:b0:3b0:9317:5849 with SMTP id 98e67ed59e1d1-3b093175caamr559101a91.1.1793749343777;
        Tue, 03 Nov 2026 15:42:23 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0982e9284sm249536a91.11.2026.11.03.15.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 15:42:23 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 13/37] selftests/bpf: Test scalar evolution with stack address as ARG_ANYTHING
Date: Tue,  3 Nov 2026 23:40:38 +0000
Message-ID: <20261103234104.208239-14-alexei.starovoitov@gmail.com>
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

The loop keeps its counter in fp-8. In each iteration it calls
bpf_probe_read_kernel() to read from the address of fp-16. This argument is
ARG_ANYTHING. The verifier assumed that the helper can write through it,
and thus can change the counter.

The test expects that scalar evolution calculates the number of iterations:

  loop header at 2, header_count is 10

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/progs/verifier_scev.c       | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_scev.c b/tools/testing/selftests/bpf/progs/verifier_scev.c
index f33e5b51f7e9..495792b734f5 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scev.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scev.c
@@ -1471,6 +1471,33 @@ __naked void widen_subprog_probe_read(void)
 	::: __clobber_all);
 }
 
+/*
+ * The address of a stack slot is passed as a number. The helper may read what is there. It doesn't
+ * write, so the counter in the slot next to it is intact.
+ */
+SEC("tracepoint")
+__success __log_level(2)
+__msg("loop header at 2, header_count is 10")
+__naked void stack_address_as_a_number(void)
+{
+	asm volatile ("					\
+	*(u64 *)(r10 - 8) = 0;				\
+	*(u64 *)(r10 - 16) = 0;				\
+1:	r1 = r10;					\
+	r1 += -24;					\
+	r2 = 8;						\
+	r3 = r10;					\
+	r3 += -16;					\
+	call %[bpf_probe_read_kernel];			\
+	r1 = *(u64 *)(r10 - 8);				\
+	r1 += 1;					\
+	*(u64 *)(r10 - 8) = r1;				\
+	if r1 < 10 goto 1b;				\
+	r0 = 0;						\
+	exit;						\
+"	:: __imm(bpf_probe_read_kernel) : __clobber_all);
+}
+
 /* An induction variable whose range overflows s64 is widened to the full range. */
 SEC("socket")
 __success
-- 
2.55.0

