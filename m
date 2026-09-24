Received: from mail-pj2-f41.google.com (mail-pj2-f41.google.com [74.125.227.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FF83E7BCC
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 23:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790292723; cv=none; b=JSohVFsACrFZCeHAuooVyaiE2x3nLJF41SaM6zJBg/aCQCX+pKNcLSRePA8IAybItdCGt6muq8fJvG3/MTcfUA8ELIQwI0YkkTHbSH490cqmoLxkuMA05yeZhujj64PgJ+PITEXj+JImB6ZsqcDKQotg+MooyOCPr3I2XJzIjqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790292723; c=relaxed/simple;
	bh=J/gl4HNYCgcgN3mJR+mayUfUSdXK9C4ANdbOQNv/NFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F+wJNVImD0gFZ5mR9t5D/Zd8Z7j76cCPlQcsV0mne3wGqwjf4+TN7CUa7ApgCROs1nKKiI5NiQxgDpKguPki+R2xHWGGpon09vTL6/vfGZryOH6BMWIcuRkmdt1UClAxwnvIBx1qXJVkt4o8CnDyCQi0gQ7Dj69dh1rmNFZb6Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DBGLH0r0; arc=none smtp.client-ip=74.125.227.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DBGLH0r0"
Received: by mail-pj2-f41.google.com with SMTP id 98e67ed59e1d1-3a0abca97c0so218506a91.1
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 16:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790292721; x=1790897521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JV1G64jlM7k7FgiKfPYnBihRHbWXyo9sJN03uL9D80Y=;
        b=DBGLH0r0fU9ymvgo5USBGwsFoF3IWl/mykY3T91RuLYM6kvjh+VQ/b9Y7me8RSq4PT
         kMpeIHz79hNSQIBQd0n6/poF6WgjSwBGikNHUpRf+jumZACC6qDq7WwI9p34lJnd4BSQ
         iqQKnyEIQYH8S2PggmpdvIrpPzkQ3MvS3hQ1NNg+v3GOCqi50faEAHL5N9SyzP6sO3cw
         aEyqPmeY69GcIQU4uo0vQxU2oN6eKkCOc7pubBlajhr/iVU6EnssmInyIHHgLRPHmE9C
         A/WerZd5MVfDTvJn1zmz2bdaqjMDv9QLaDD3WXz81ziBLTxs6FvEBL8HQyrYS9kWPMQ+
         Szew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790292721; x=1790897521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JV1G64jlM7k7FgiKfPYnBihRHbWXyo9sJN03uL9D80Y=;
        b=AmGL2S4DqJ2YPMl9tKppdI5YYcn+4ZFLoCPih88svcsxV0Oq45bTPj1GaBaU2Y2LAB
         OhhFnu/itumIPEB+0EivHDupd7UQbYeqUCRsU7bABNUlzXJxKL91bjCp8jEBgoUEAnpV
         dKrAjbDtK1zv9HAUBU1wCbok9xRrFMNwZeizbWcaoU5cd5HE2sYczPfTNpXoC3LupJdf
         u9fkh2udpMPAgvhTwEORrZxII1xnSLpcN1wgI4HhxtosKPBU6QeSyBf284rJuUXdSehd
         QlL86Up5bkQYaPZo+oLMiWr6a0xUngflN6LJvI8RlYDNttcAkIPRK9aYQ4+zqqX2FItO
         LXZA==
X-Gm-Message-State: AFuF++myuCY4afNRn7fv927sBqZL4/w82n68KLzpuROrc+ZltbzCPgmH
	S3PcN2qRgDywI/QSMvDLH1+OdC6TRPuPWLI+Tj6mDI1WpHTJWHqmnGuBeCvbng==
X-Gm-Gg: AYBFou2Ovk3R/GjvccGtSy5FUabZCov1FD88aGTyKxny6yEgrZfUwdIcRiTTVsskhIi
	TzjqjX+HkV0TNkdX7Yd1DvhXfYoUtZ8aeqfPUYjqwsqhr+/1kyVkPSUrnfMQJrv4mJQC5cxIYve
	yaAVEJ+2QmKkYcTdRwLPXvCIcqbzX7Fg5elboaApgBzckIRxT8rPFbUwhn20k+D8nTwloQ+Y7qc
	j2r6yEdEahZDF1v2X0U6sqFUCd3lwYHDA9r5GPDCFlvNc6gxHtVnxrimBkD6JzNlvl95jcTJM1B
	Rfm1IBzj7Y3C3V4uk6BjwqVhVZriNMBhn2xPou5JkcRKgUD3mmzpGle4401ndPGV7w6BGOF0/Vp
	Ti0LQ2hASVGRpduRWf1S7N8F30WgxYdJPkO7WwJQPnd3TVXS8cdc5S5Jz/vlkhNZuD5oOmP8jwY
	y/Bbdb/Fh/9zkiuJCqkAGR6/OUTtfdqxxHsafpTpfFBTsk+d4QnEzsag6zdjDaceJ8zPqFgA99u
	CvC6pZwVWcvHyXdhYu65bPw9hlaLbrdKOSee59+8LPbBb5IaKoYWj5yEeyxqNLTg0yoNALw9tfd
	yFa4f2dc+qCtgyjCU5/n7yVxDJ5Nh33WJ5MoO8x+7J4pNOO+ssqakjE=
X-Received: by 2002:a17:90b:917:b0:39e:6c69:7777 with SMTP id 98e67ed59e1d1-3a0989866e6mr2428188a91.32.1790292720522;
        Thu, 24 Sep 2026 16:32:00 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0affe2cd4sm1957532a91.1.2026.09.24.16.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 16:31:59 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 8/8] selftests/bpf: Add tests for iterator created anew in its loop
Date: Thu, 24 Sep 2026 23:31:30 +0000
Message-ID: <20260924233130.1213812-9-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924233130.1213812-1-alexei.starovoitov@gmail.com>
References: <20260924233130.1213812-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Add progs that destroy and create the iterator inside its loop with
and without a prune point in front of bpf_iter_num_next(). All of them
should be rejected. Nested bpf_for() loops, where the inner iterator is
created in every iteration of the outer loop, should load.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/progs/iters.c | 382 ++++++++++++++++++++++
 1 file changed, 382 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/iters.c b/tools/testing/selftests/bpf/progs/iters.c
index 65d4c6e01f93..ae845ad747bf 100644
--- a/tools/testing/selftests/bpf/progs/iters.c
+++ b/tools/testing/selftests/bpf/progs/iters.c
@@ -2188,4 +2188,386 @@ __naked void loop_counter_precision_2nd_iter(void)
 	);
 }
 
+/*
+ * An iterator that is destroyed and created again inside its loop starts from
+ * the beginning and the loop never ends. In the first four progs the first
+ * prune point after bpf_iter_num_new() is the call of bpf_iter_num_next().
+ */
+SEC("socket")
+__description("iter: remake in the loop, jump to next")
+__failure __msg("infinite loop detected")
+__naked void iter_remake_jmp(void)
+{
+	asm volatile (
+	"r1 = r10;"
+	"r1 += -8;"
+	"r2 = 0;"
+	"r3 = 10;"
+	"call %[bpf_iter_num_new];"
+"1:"
+	"call %[bpf_ktime_get_ns];"
+	"if r0 != 0 goto 3f;"
+	"r1 = r10;"
+	"r1 += -8;"
+"2:"
+	"call %[bpf_iter_num_next];"
+	"if r0 != 0 goto 1b;"
+	"r1 = r10;"
+	"r1 += -8;"
+	"call %[bpf_iter_num_destroy];"
+	"r0 = 0;"
+	"exit;"
+"3:"
+	"r1 = r10;"
+	"r1 += -8;"
+	"call %[bpf_iter_num_destroy];"
+	"r1 = r10;"
+	"r1 += -8;"
+	"r2 = 0;"
+	"r3 = 10;"
+	"call %[bpf_iter_num_new];"
+	"r1 = r10;"
+	"r1 += -8;"
+	"goto 2b;"
+	:
+	: __imm(bpf_iter_num_new),
+	  __imm(bpf_iter_num_next),
+	  __imm(bpf_iter_num_destroy),
+	  __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
+__used __naked static void iter_remake(void)
+{
+	asm volatile (
+	"r6 = r1;"
+	"call %[bpf_iter_num_destroy];"
+	"r1 = r6;"
+	"r2 = 0;"
+	"r3 = 10;"
+	"call %[bpf_iter_num_new];"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_iter_num_new),
+	  __imm(bpf_iter_num_destroy)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("iter: remake in a callee, jump to next")
+__failure __msg("infinite loop detected")
+__naked void iter_remake_callee_jmp(void)
+{
+	asm volatile (
+	"r1 = r10;"
+	"r1 += -8;"
+	"r2 = 0;"
+	"r3 = 10;"
+	"call %[bpf_iter_num_new];"
+"1:"
+	"call %[bpf_ktime_get_ns];"
+	"if r0 != 0 goto 3f;"
+	"r1 = r10;"
+	"r1 += -8;"
+"2:"
+	"call %[bpf_iter_num_next];"
+	"if r0 != 0 goto 1b;"
+	"r1 = r10;"
+	"r1 += -8;"
+	"call %[bpf_iter_num_destroy];"
+	"r0 = 0;"
+	"exit;"
+"3:"
+	"r1 = r10;"
+	"r1 += -8;"
+	"call iter_remake;"
+	"r1 = r10;"
+	"r1 += -8;"
+	"goto 2b;"
+	:
+	: __imm(bpf_iter_num_new),
+	  __imm(bpf_iter_num_next),
+	  __imm(bpf_iter_num_destroy),
+	  __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("iter: remake after next, jump to next")
+__failure __msg("infinite loop detected")
+__naked void iter_remake_after_next_jmp(void)
+{
+	asm volatile (
+	"r1 = r10;"
+	"r1 += -8;"
+	"r2 = 0;"
+	"r3 = 10;"
+	"call %[bpf_iter_num_new];"
+	"r1 = r10;"
+	"r1 += -8;"
+"1:"
+	"call %[bpf_iter_num_next];"
+	"if r0 == 0 goto 2f;"
+	"r1 = r10;"
+	"r1 += -8;"
+	"call %[bpf_iter_num_destroy];"
+	"r1 = r10;"
+	"r1 += -8;"
+	"r2 = 0;"
+	"r3 = 10;"
+	"call %[bpf_iter_num_new];"
+	"r1 = r10;"
+	"r1 += -8;"
+	"goto 1b;"
+"2:"
+	"r1 = r10;"
+	"r1 += -8;"
+	"call %[bpf_iter_num_destroy];"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_iter_num_new),
+	  __imm(bpf_iter_num_next),
+	  __imm(bpf_iter_num_destroy),
+	  __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("iter: two iterators, remake each after its next")
+__failure __msg("infinite loop detected")
+__naked void iter_remake_two_jmp(void)
+{
+	asm volatile (
+	"r1 = r10;"
+	"r1 += -8;"
+	"r2 = 0;"
+	"r3 = 10;"
+	"call %[bpf_iter_num_new];"
+	"r1 = r10;"
+	"r1 += -16;"
+	"r2 = 0;"
+	"r3 = 10;"
+	"call %[bpf_iter_num_new];"
+	"r1 = r10;"
+	"r1 += -8;"
+"1:"
+	"call %[bpf_iter_num_next];"
+	"if r0 == 0 goto 2f;"
+	"r1 = r10;"
+	"r1 += -8;"
+	"call %[bpf_iter_num_destroy];"
+	"r1 = r10;"
+	"r1 += -8;"
+	"r2 = 0;"
+	"r3 = 10;"
+	"call %[bpf_iter_num_new];"
+	"r1 = r10;"
+	"r1 += -16;"
+	"call %[bpf_iter_num_next];"
+	"if r0 == 0 goto 2f;"
+	"r1 = r10;"
+	"r1 += -16;"
+	"call %[bpf_iter_num_destroy];"
+	"r1 = r10;"
+	"r1 += -16;"
+	"r2 = 0;"
+	"r3 = 10;"
+	"call %[bpf_iter_num_new];"
+	"r1 = r10;"
+	"r1 += -8;"
+	"goto 1b;"
+"2:"
+	"r1 = r10;"
+	"r1 += -8;"
+	"call %[bpf_iter_num_destroy];"
+	"r1 = r10;"
+	"r1 += -16;"
+	"call %[bpf_iter_num_destroy];"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_iter_num_new),
+	  __imm(bpf_iter_num_next),
+	  __imm(bpf_iter_num_destroy),
+	  __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
+/* Same loops with a prune point in front of bpf_iter_num_next() */
+SEC("socket")
+__description("iter: remake in the loop")
+__failure __msg("infinite loop detected")
+__flag(BPF_F_TEST_STATE_FREQ)
+__naked void iter_remake_inline(void)
+{
+	asm volatile (
+	"r1 = r10;"
+	"r1 += -8;"
+	"r2 = 0;"
+	"r3 = 10;"
+	"call %[bpf_iter_num_new];"
+"1:"
+	"call %[bpf_ktime_get_ns];"
+	"if r0 == 0 goto 2f;"
+	"r1 = r10;"
+	"r1 += -8;"
+	"call %[bpf_iter_num_destroy];"
+	"r1 = r10;"
+	"r1 += -8;"
+	"r2 = 0;"
+	"r3 = 10;"
+	"call %[bpf_iter_num_new];"
+"2:"
+	"r1 = r10;"
+	"r1 += -8;"
+	"call %[bpf_iter_num_next];"
+	"if r0 != 0 goto 1b;"
+	"r1 = r10;"
+	"r1 += -8;"
+	"call %[bpf_iter_num_destroy];"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_iter_num_new),
+	  __imm(bpf_iter_num_next),
+	  __imm(bpf_iter_num_destroy),
+	  __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("iter: remake in a callee")
+__failure __msg("infinite loop detected")
+__flag(BPF_F_TEST_STATE_FREQ)
+__naked void iter_remake_callee(void)
+{
+	asm volatile (
+	"r1 = r10;"
+	"r1 += -8;"
+	"r2 = 0;"
+	"r3 = 10;"
+	"call %[bpf_iter_num_new];"
+"1:"
+	"call %[bpf_ktime_get_ns];"
+	"if r0 == 0 goto 2f;"
+	"r1 = r10;"
+	"r1 += -8;"
+	"call iter_remake;"
+"2:"
+	"r1 = r10;"
+	"r1 += -8;"
+	"call %[bpf_iter_num_next];"
+	"if r0 != 0 goto 1b;"
+	"r1 = r10;"
+	"r1 += -8;"
+	"call %[bpf_iter_num_destroy];"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_iter_num_new),
+	  __imm(bpf_iter_num_next),
+	  __imm(bpf_iter_num_destroy),
+	  __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("iter: remake after next")
+__failure __msg("infinite loop detected")
+__flag(BPF_F_TEST_STATE_FREQ)
+__naked void iter_remake_after_next(void)
+{
+	asm volatile (
+	"r1 = r10;"
+	"r1 += -8;"
+	"r2 = 0;"
+	"r3 = 10;"
+	"call %[bpf_iter_num_new];"
+"1:"
+	"r1 = r10;"
+	"r1 += -8;"
+	"call %[bpf_iter_num_next];"
+	"if r0 == 0 goto 2f;"
+	"r1 = r10;"
+	"r1 += -8;"
+	"call %[bpf_iter_num_destroy];"
+	"r1 = r10;"
+	"r1 += -8;"
+	"r2 = 0;"
+	"r3 = 10;"
+	"call %[bpf_iter_num_new];"
+	"goto 1b;"
+"2:"
+	"r1 = r10;"
+	"r1 += -8;"
+	"call %[bpf_iter_num_destroy];"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_iter_num_new),
+	  __imm(bpf_iter_num_next),
+	  __imm(bpf_iter_num_destroy),
+	  __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("iter: remake when drained")
+__failure __msg("infinite loop detected")
+__flag(BPF_F_TEST_STATE_FREQ)
+__naked void iter_remake_drained(void)
+{
+	asm volatile (
+	"r1 = r10;"
+	"r1 += -8;"
+	"r2 = 0;"
+	"r3 = 10;"
+	"call %[bpf_iter_num_new];"
+"1:"
+	"call %[bpf_ktime_get_ns];"
+	"if r0 == 119 goto 2f;"
+	"r1 = r10;"
+	"r1 += -8;"
+	"call %[bpf_iter_num_next];"
+	"if r0 != 0 goto 1b;"
+	"r1 = r10;"
+	"r1 += -8;"
+	"call %[bpf_iter_num_destroy];"
+	"r1 = r10;"
+	"r1 += -8;"
+	"r2 = 0;"
+	"r3 = 10;"
+	"call %[bpf_iter_num_new];"
+	"goto 1b;"
+"2:"
+	"r1 = r10;"
+	"r1 += -8;"
+	"call %[bpf_iter_num_destroy];"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_iter_num_new),
+	  __imm(bpf_iter_num_next),
+	  __imm(bpf_iter_num_destroy),
+	  __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
+/* The inner iterator is created in every iteration of the outer loop */
+SEC("socket")
+__description("iter: nested loops")
+__success __retval(12)
+int iter_nested_remake(void *ctx)
+{
+	int i, j, sum = 0;
+
+	bpf_for(i, 0, 3) {
+		bpf_for(j, 0, 4)
+			sum++;
+	}
+	return sum;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.55.0

