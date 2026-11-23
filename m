Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795410822;
	b=ESgkqmK56vJGICfK+HXjmQC75YHU6V6tZFTlvDIZ0NSa9Ug6KMUXVtggQ1vaeOiSEBjZ
	 P9DwzKeMNIsrh3d8WCiymfnZbsFH0Njhfco+k2uEiQ6Eun1IPvCpNILmyXrnlm4wNM74t
	 /tqMAPWUKpmwVjxzDQFctg0MxQp5vHcMKKtYW1sPBUEiIWmQZvLc6dKxLKrP474KXDIzu
	 428oiyHMyvppDlZD00XIyUlDOXNKEufyNORpM1DT6NYd8GlT3XYOaZVq4LqNWk7inpE2U
	 WcHRsIaO0ibpuVC7D8oPQNRkwOTzJ9LKGALmA8Ipbi/gS/2Eiz1NX6JARJTvcXmshkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795410822;
	h=DMARC-Filter:Received:Received:Subject:To:Cc:References:From:
	 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:Content-Type:
	 Content-Language:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-CM-SenderInfo:X-Coremail-Antispam;
	bh=tTAShwwvdJomkO2Y41443wtfMMw6Md22aE5NOqml3V0=;
	b=L+OmsjUCrQXdXZCkhDYGjDa1pIeG9nbkdg3P/J2Po1Owm1peRcl7I2O5j/Utn11iiy2X
	 rv6LIKgXXtSwUP2n3jHjncWSWLKX2WnXw6G+xAlgBfPa3RyRFEeHOe0CwJJZ9YpDFp/QV
	 pB0Uhb+O4s2wQXHOCX1v4esvSH3MltwwSoWztof+nnmFDsH3+OeAIF/+O5ivjwiylW+ql
	 g/fQsHbcd0f5zHVUwIToEd7KNbJFIVPOKYKCqZ1J+wkBM8L9IV/kwKjjQkr5DpiShGu9X
	 3/A9VE8cj7Co5FXb3u53emtti1hEhccWVp6gK5zB+tm5olmOFsRkLVl4toF/jYV1XcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3751A606A31E
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 05:13:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3751A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8Cx_9KDywNrcR8iAA--.31920S3;
	Mon, 23 Nov 2026 13:13:39 +0800 (CST)
Received: from [127.0.0.1] (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJDxRs2BywNrGc02AA--.30881S2;
	Mon, 23 Nov 2026 13:13:37 +0800 (CST)
Subject: Re: [PATCH bpf-next v1 3/3] selftests/bpf: Enable callx related
 testcases for LoongArch
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20261123045008.23691-1-yangtiezhu@loongson.cn>
 <20261123045008.23691-4-yangtiezhu@loongson.cn>
 <sashiko-outbox-228686@kernel.org>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <a9f95201-5496-a844-355c-6edc6ae8f508@loongson.cn>
Date: Mon, 23 Nov 2026 13:13:37 +0800
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
In-Reply-To: <sashiko-outbox-228686@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:qMiowJDxRs2BywNrGc02AA--.30881S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoW7Gr47Cw4xCr1xZFW7tFWUtrc_yoWDJrgE9F
	yfCFy7X395Zr43J3Zaga4rtF9xArWFvFyUAr95WF1xGFyFgr18JFZ5K3sYvF1xK3yfKrZx
	tayYq3ySyw4jvosvyTuYvTs0mTUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbIxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE
	14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
	AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
	rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAw
	CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
	67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
	0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8oG
	QDUUUUU==

On 11/23/26 12:59 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] selftests/bpf: callx tests fail on LoongArch due to missing
>    JIT callx support

...

> [Severity: Medium]
> Will these callx selftests fail on LoongArch because the LoongArch BPF JIT
> does not yet implement indirect subprog calls?
> 
> In this tree, arch/loongarch/net/bpf_jit.c does not override the default
> weak bpf_jit_supports_callx() (which returns false) or handle
> BPF_JMP | BPF_CALL | BPF_X in build_insn().  As a result,
> require_callx_jit() rejects these programs with -EOPNOTSUPP instead of
> letting the test suite skip them.

This series depends on the LoongArch JIT support series:

LoongArch: BPF: Support instructions array, indirect jumps and calls
https://lore.kernel.org/loongarch/20261123043907.20225-1-yangtiezhu@loongson.cn/T/#u

Thanks,
Tiezhu

