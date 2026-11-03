Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793671306;
	b=LtZcE/nV+Y/vzfnBbSzQIgsbRSESbwUZbKHouszx5dmzx2BEDKFX2TszkFUoZxQVCqtM
	 8AH9BbG9Ivue+NNL73IZY5JicZNtigSQz+DbpaDYf63me8w+/XDPsYYr673Z1jMTmAFpq
	 AJbwwgRTgCO9dKgxuMilpBGdwXcnBaZj7GpS5wWI/UeZF0UFbrxM92+kj7p4TA0vi6+I8
	 NjlLTVp8cwu8HSIJxUswsAJ9D1PvavzsxBnxT/Zrn7TmGJsUAL0yWGv1hn6AxyI4R5wxR
	 Jt5F1FRYn/AAH7Z2cEyMsjQdx9vTYCS8GB/hwYNp3+60EsloG8JHQ76rmdrp/kwlvQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793671306;
	h=DMARC-Filter:Received:Received:Subject:To:Cc:References:From:
	 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:Content-Type:
	 Content-Language:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-CM-SenderInfo:X-Coremail-Antispam;
	bh=R+R/zoUatofm4R0LIX34DtFmZRn+sOpXy2WFmyfKi6Q=;
	b=3JPCApDCvXG3QQXLRb4mcK5/N8drUhIKzqVr3irSdhHjRPjTSJcH9q4iGiPW1FOWyMP+
	 juCDCDg1V/fy5ips3j0y24R+W2JmTYQLIWwuw9xllFVU632Oeuhzgm8xLyA87C9J/he6U
	 sQjW+CSBEl1iXIPWs+LQxD6uz0D0o6BR2GI8L9ya/z/W8zLTNie8npMCwpDoUleWb+2b1
	 Q+Mgk7jygIu2t7/AhhyoRyc/Zci7aefIWSSc+fDPQcaZLgMdz91gQ/bP542AuedyXFkLP
	 zJPcO1kRZ5KVBkT7iJ4vv32GEV8DFJPJLCscuqTLeVcyF9dJLa3F3xZGTS/t8l2NjjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31508606A324
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 02:01:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31508606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8CxvtKHQOlq180bAA--.14850S3;
	Tue, 03 Nov 2026 10:01:43 +0800 (CST)
Received: from [127.0.0.1] (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJDxBc2FQOlqXwoyAA--.9896S2;
	Tue, 03 Nov 2026 10:01:42 +0800 (CST)
Subject: Re: [PATCH bpf-next v1 1/2] selftests/bpf: Handle EOPNOTSUPP
 gracefully in test_loader
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20261102081230.7063-1-yangtiezhu@loongson.cn>
 <20261102081230.7063-2-yangtiezhu@loongson.cn>
 <sashiko-outbox-193107@kernel.org>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <eb86e8a0-acae-6240-0c82-98ce1c8a0a4e@loongson.cn>
Date: Tue, 3 Nov 2026 10:01:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <sashiko-outbox-193107@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxBc2FQOlqXwoyAA--.9896S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7KFWrCw1DGF1DuF13Zr17CFX_yoW8WF1kpa
	4kX3s0yFySqF1Sq3srurW7XrWjgF4UuF98Cr1rtw1fZr17Xr4aqr1xKa15trnxWrWxZwn0
	v34Ikrn3G3y8AFgCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AK
	xVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
	AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j8CztU
	UUUU=

On 2026/11/2 下午4:28, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] selftests/bpf: indiscriminate EOPNOTSUPP skip in run_subtest()

...

> Would it be better to explicitly probe for BPF_MAP_TYPE_ARENA support
> (similar to libbpf_probe_bpf_map_type(BPF_MAP_TYPE_ARENA, NULL) in
> test_verifier_hmul_arena() in
> tools/testing/selftests/bpf/prog_tests/verifier_hmul_arena.c) or handle
> unsupported map creation specifically, rather than catching all EOPNOTSUPP
> errors from bpf_object__load()?

Will use libbpf_probe_bpf_map_type() in prog_tests instead of
handling EOPNOTSUPP globally in test_loader.

Something like this:

```
diff --git a/tools/testing/selftests/bpf/prog_tests/jit_insns.c 
b/tools/testing/selftests/bpf/prog_tests/jit_insns.c
index 52bffe27199b..9c4cbf6807ae 100644
--- a/tools/testing/selftests/bpf/prog_tests/jit_insns.c
+++ b/tools/testing/selftests/bpf/prog_tests/jit_insns.c
@@ -3105,7 +3105,14 @@ static void test_helper_calls(void)

  void test_jit_insns(void)
  {
-	RUN_TESTS(jit_insns_arena);
+	if (libbpf_probe_bpf_map_type(BPF_MAP_TYPE_ARENA, NULL)) {
+		RUN_TESTS(jit_insns_arena);
+	} else {
+		if (test__start_subtest("arena_zero_off"))
+			test__skip();
+		if (test__start_subtest("cast_to_user"))
+			test__skip();
+	}
  	if (test__start_subtest("alu_imm"))
  		test_alu_imm();
  	if (test__start_subtest("alu_reg"))
```

I will send out v2 next week if no more comments.

Thanks,
Tiezhu

