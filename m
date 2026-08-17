Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52A63BED66;
	Mon, 17 Aug 2026 20:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786999751; cv=none; b=A0c6QzWW53yYOrBOO30M07INdTsVTMBQ1w8ZRLqomfUWAwLhT0LRsdyP8arW4Z4WcoDT+xFHrkVxIjfiowlU8ZER5RPdzOn9gDDAeQ4S10GXWMcqHMXdYuD3im4YHvtW8Ln3vftXdSLBM+tkNk/NF7LynaIr7yHyurHuF24KGQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786999751; c=relaxed/simple;
	bh=VdcqnYm7JVNF16OfORqwSK1kOqEDwhN/fmsdMp33CaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EyCmFJnVF7Cb3liAmiypVuMYwjr1YHSRylqPV2rtBQpxu9kLZrOCvaU/baWZJIDaZlDnjKaOYWLigLiK5JOSunQ++Vg/40i6rT0Qnl+a4TUOqVkQt+L8atQrNoKPMhRZ+KTQXN7TpJK40KK+RqP2F5O31EoABA9UWamrWLIFWpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=OtWxUuWl; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="OtWxUuWl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ixMF7r8hV0lzYA6CsB9yjlSEeIxuTJm60sYPclnVrsM=; b=OtWxUuWl57d2kgc/pmTQKXH3K4
	OGh7+wbS5MfnewwXt7EnqLr+FOk8MOP4Zi3bn2SmzkxGFtoHN0IyinkgtzKbe1gr85XL6szxq+4w3
	SaQzzxPG1ss0fRBU7P0EEeQGnHtavfS+7CGKXaIyKbHM3AIHL1qO5FRoAAlgIQTaaXeEQ8KWDPcvV
	MLaANPsO9oxzNFRf2Z9XXpbCE1B39fZmsN8iLeHWZsItEmfnL4xxCK9HPIMkVPAriAReqfGjPpo7v
	NHxJjnpkyLYK3ZltPL5Vfqxyqxb1B1am8WvXibZaKHDmpySujZW5ElcQfDeXHKJLKbgtyjKcCTdDh
	0daSGDWQ==;
Received: from [151.115.150.205] (port=43084 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1ww4GS-0000000CoBp-0XNY;
	Mon, 17 Aug 2026 22:48:59 +0200
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
Subject: [PATCH v2 2/2] selftests/bpf: add callback stack-argument rejection test
Date: Mon, 17 Aug 2026 20:48:12 +0000
Message-ID: <20260817204812.1637171-3-Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260817204812.1637171-1-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20260817204812.1637171-1-Jeremy.Jean@oss.cyber.gouv.fr>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Add verifier coverage for callback subprograms that declare incoming
stack arguments. The test passes a nine-argument callback to bpf_loop()
and expects the verifier to reject it.

Assisted-by: Codex:gpt-5
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
---
 .../selftests/bpf/progs/verifier_stack_arg.c  | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_stack_arg.c b/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
index 7e0ce5db28a0..50b276fc2c3f 100644
--- a/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
+++ b/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
@@ -27,6 +27,13 @@ static int subprog_7args(int a, int b, int c, int d, int e, int f, int g)
 	return a + b + c + d + e + f + g;
 }
 
+__noinline __used
+static int callback_9args(__u32 index, void *ctx, long a3, long a4,
+			  long a5, long a6, long a7, long a8, long a9)
+{
+	return a9;
+}
+
 __noinline __used
 static long subprog_deref_arg6(long a, long b, long c, long d, long e, long *f)
 {
@@ -79,6 +86,31 @@ __naked void stack_arg_two_subprogs(void)
 	);
 }
 
+SEC("tc")
+__description("stack_arg: callback with incoming stack args")
+__failure
+__naked void stack_arg_callback_many_args(void)
+{
+	asm volatile (
+		"r6 = 0;"
+		"*(u64 *)(r11 - 32) = 0;"
+		"*(u64 *)(r11 - 24) = 0;"
+		"*(u64 *)(r11 - 16) = 0;"
+		"*(u64 *)(r11 - 8) = 0;"
+		"r1 = 1;"
+		"r2 = %[callback_9args];"
+		"r3 = 0;"
+		"r4 = 0;"
+		"call %[bpf_loop];"
+		"r0 = 0;"
+		"exit;"
+		:
+		: __imm_ptr(callback_9args),
+		  __imm(bpf_loop)
+		: __clobber_common, "r6"
+	);
+}
+
 SEC("tc")
 __description("stack_arg: read from uninitialized stack arg slot")
 __failure
-- 
2.47.3

