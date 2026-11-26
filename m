Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795658531;
	b=S6GIEsbQpaw8Pssa9uK8e8MIJ7njmYqXop3XS+YySSshmYZ6cThOoB94tHl6+7CfD5Ri
	 ka1RCgUUEAUARWTSuvocLmWYntplmhAwc0zAhOMIeg8NWSQfPI/YIkNrB666OWLqY7cBp
	 bC36VYPlShD85JS+IFvwnKNUJbbB4wlab4oiYgcFD7c64aIhecm6jQLDwNfoTdmLN3RFZ
	 PCmAS79O8JOxklMrxZXqNLJnddQcp5Jq7oN95ZtGa5FtfAvxnowFeyNad8tauvEzH0Qlo
	 RZsu+NDCoHwcSxPFtLr7i0FF4CQ3LeIeywXzVWEp9nnfNiiEDXJu8OXyRsZqLvdOrvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795658531;
	h=DMARC-Filter:Received:Received:Subject:To:Cc:References:From:
	 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:Content-Type:
	 Content-Language:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-CM-SenderInfo:X-Coremail-Antispam;
	bh=F89I1g6d8xmtBB7mY85xmIJWfFhPXLIxLjU4qL0HIPs=;
	b=pP/CJNBP5QP6v/CLN+LQZtd8IFxWOpF0yRbvFGZb2VQzMdEcMB864yk4TryQbdtaeyW1
	 VDkIpfgrymJFHd/6UxNElV8bTn9NgjFNhoHEPz4YfSoIQbMkCjLW/pUo9l4+pJ+4p/3tW
	 7LOsgNYFg6QQ/e9Hji3nW9RwfhmqqLZzrkgPDtkC762bD7mhh5E5WnaW1Ae0b0Ck7YrN7
	 gTI1RsRQoSxpNAF7/pxoKXreSTPqHZZYZedGT3P0XCQH/2fY6vxvtAOOrVN9AQ3X9xZ4V
	 RV6HtIjO0NppwCn+vsF7wKZ+6Rhu1yEkIZ5KtRDXupaDCTRSpXEZO4G+wNdcbXuqduQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F79606A321;
	Thu, 26 Nov 2026 02:02:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21F79606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8DxpvAfkwdr1RsjAA--.34150S3;
	Thu, 26 Nov 2026 10:02:07 +0800 (CST)
Received: from [127.0.0.1] (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJAxFs0ckwdrMGk3AA--.52566S2;
	Thu, 26 Nov 2026 10:02:05 +0800 (CST)
Subject: Re: [PATCH bpf-next v1] selftests/bpf: Restrict JIT tests to 64-bit
 LoongArch
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20261125103208.15242-1-yangtiezhu@loongson.cn>
 <DN4QVSWEI27E.32PRRHCUBAZFK@gmail.com>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <d308dec5-a310-344b-7ff5-0e67e118d9b8@loongson.cn>
Date: Thu, 26 Nov 2026 10:02:04 +0800
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
In-Reply-To: <DN4QVSWEI27E.32PRRHCUBAZFK@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:qMiowJAxFs0ckwdrMGk3AA--.52566S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoWrKw1kGr1ftF4fGFykJFyUtwc_yoWkJrg_uw
	4xGryrCr1UAryqy3WFgF1FyrZrJFWDJ3y8XrWfXrZ7uas3Ja1rJFs5Gr1fXFy7JrW0kFn8
	Gan0vr47XF1UXosvyTuYvTs0mTUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUb3AYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8
	JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v2
	6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
	vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v2
	6r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIev
	Ja73UjIFyTuYvjxU7XTmDUUUU

On 11/26/26 9:17 AM, Alexei Starovoitov wrote:
> On Wed, Nov 25, 2026 at 02:32 AM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>> Now that 32-bit LoongArch support has been added to the kernel while the
>> eBPF JIT remains 64-bit only (HAVE_EBPF_JIT depends on 64BIT), limit the
>> BPF JIT-specific test cases and architecture macros to 64-bit LoongArch.
> 
> Most of them are not JIT-specific.
> The interpreter runs sdiv, bswap, movsx and gotol.
> The default build of test_progs fails against such a kernel anyway.
> dummy_st_ops_success.c takes struct bpf_dummy_ops from vmlinux.h,
> and that struct is under CONFIG_BPF_JIT.
> raw_tp and kprobe progs can't load there either:
> 
>    select HAVE_PERF_EVENTS if 64BIT
> 
>> This is a cleanup patch, inspired by Sashiko AI review:
>> https://lore.kernel.org/bpf/sashiko-outbox-228693@kernel.org/
> 
> That comment is about the new guard in bpf_insn_array.c.
> Nothing is broken. I don't think we need this patch.
> Pls don't change 16 files because a bot said so.

OK, understood, please drop this patch.

Thanks,
Tiezhu

