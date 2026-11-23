Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795411288;
	b=reKgLDn+ni2VII9vRrH90u7Yw/rxPMjiKwnTuc2VVxozF4aG2SWMSewgYebGJo4osx0v
	 qRDd9OMSOn+vM/OU2bgNT62nMVZluG+MjOmXgm3UJW/8+TlOjJAeT7ladIo6lULbv34tC
	 oY1WmcgmD68NlNjKtV1YHgfLi5UmbkfUKiK9Ecpi+dGsZj/7uEgNk9SBExVxwO4J6mVc2
	 RRjXayPcMfmnDRN+iSnwXWEbcQ6iJkaj0rNv5X1uaHC6qWSjo3hFJD1sloYF7KvFdbFev
	 zt2WJj9frPh7UKTdxhxT/0fZE9S22GXJIWip5If/nMKmg9eEyNnWsPRLkxNyNVY3cNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795411288;
	h=DMARC-Filter:Received:Received:Subject:To:Cc:References:From:
	 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:Content-Type:
	 Content-Language:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-CM-SenderInfo:X-Coremail-Antispam;
	bh=MhKPy4hLEktud7DPzU2544Zryh9tYQQv+5VGX65PXXk=;
	b=hxVg+J+/nA3nZzG9H5CiFK6LcUzRBM5Fd3gOxd0G7ij9Fj4BjXJ+RSSURrixZFwoRQOb
	 8rnPhWdQDlkYBfwtszJITGZMh8cdrlxymykhHyJh4S4IlzjdCpsq8ghqcmi4JZmicTnHh
	 1FXbS66ZODbW6z6pFBw9pxnf9D2MDmb1ES58HAV+nLgJUW+KOmNHROTD3JTXAekeDAYvg
	 rUJbmHV0/ItrDPe8BcwxFTRGS5uYnzkYNbyOL6oRj2JkcwgRZujkR39A1xVaS8ztI12jU
	 yIw0OTSIwqAfvQgN6uj1bRr54QGDA5SF3JNLSihzYctV5ShIcfytc8YjsZXIG8omNag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21B0606A68B
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 05:21:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B21B0606A68B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8Cxf9NVzQNr_B8iAA--.31745S3;
	Mon, 23 Nov 2026 13:21:25 +0800 (CST)
Received: from [127.0.0.1] (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJBxpMxSzQNrps02AA--.17317S2;
	Mon, 23 Nov 2026 13:21:23 +0800 (CST)
Subject: Re: [PATCH bpf-next v1 1/3] selftests/bpf: Enable instruction array
 test for LoongArch
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20261123045008.23691-1-yangtiezhu@loongson.cn>
 <20261123045008.23691-2-yangtiezhu@loongson.cn>
 <sashiko-outbox-228693@kernel.org>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <46ffa5b6-8914-eda6-a0ee-88b2d7ecba54@loongson.cn>
Date: Mon, 23 Nov 2026 13:21:22 +0800
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
In-Reply-To: <sashiko-outbox-228693@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:qMiowJBxpMxSzQNrps02AA--.17317S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWrKrWkCF4fKFWDtFWrAw1UurX_yoW8JF15p3
	srZF1UAr4rWrWrtrnrK34fWa1Sqr1fGFZ7KF4YgrW8CFZruw4rAFWYgw4qqan8Zw4rWw10
	qFZ5C34vq3WkAFgCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
	67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
	AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF
	1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jb
	_-PUUUUU=

On 11/23/26 1:02 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:

...

> [Severity: Medium]
> Does enabling bpf_insn_array on LoongArch depend on a prerequisite JIT
> patch that is not in the tree yet?
> 
> In arch/loongarch/net/bpf_jit.c, bpf_int_jit_compile() does not call
> bpf_prog_update_insn_ptrs(), so insn_array->ips[] stays zeroed and
> bpf_insn_array_ready() rejects program loading with -EFAULT.  In addition,
> build_insn() only handles BPF_JMP | BPF_JA and BPF_JMP32 | BPF_JA, without
> BPF_JMP | BPF_JA | BPF_X (gotox), so the gotox subtests fail to JIT with
> -EINVAL (-ENOTSUPP).

This series depends on the unmerged LoongArch JIT support series:

LoongArch: BPF: Support instructions array, indirect jumps and calls
https://lore.kernel.org/loongarch/20261123043907.20225-1-yangtiezhu@loongson.cn/T/#u

> Also, HAVE_EBPF_JIT on LoongArch is only selected for 64BIT, while
> defined(__loongarch__) matches 32-bit builds as well.

I will update the guard to
(defined(__loongarch__) && __loongarch_grlen == 64)
in v2 (along with patch 3/3) to match 64-bit LoongArch specifically,
similar to RISC-V.

Thanks,
Tiezhu

