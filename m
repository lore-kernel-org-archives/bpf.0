Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793078888;
	b=j8f1CmhisGY7rz8UrXkZwXY1KbYO9VGj3+CQmO1jKOcgpJ6bC/+4iMJlpYzIHjFSxUy/
	 aoE/56/nN0X6ZoAHEx9V4gPS4aU1dQzOVSWgb5IeYJ8eJbjFI4mCFcAGcnfH7JxPd7zwK
	 m5Peie7MYJL4K+xKLpXQ1hqsNJoYYOLeAqx9xqq4mIVyXKRZfo5k0IfwAjw6kWcbw0O6e
	 8F2Wef++6n5/4M2CWrwZr5ZeOhvGpM1TJhHUIJDQHqPn2pGhsjHL6sWcjp1pbD48YInDM
	 2YLvbJIDYKG3vdd75UaqzGB4uUtuDvLehXMQpJEA1uduhCP7EcMrzoBWmS/ZQSqYaHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793078888;
	h=DMARC-Filter:Received:Received:Subject:From:To:Cc:References:
	 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:Content-Type:
	 Content-Language:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-CM-SenderInfo:X-Coremail-Antispam;
	bh=fQSyvYLZFxUoDKEOy74wvi3r0I0nAyT1z0Pd+GCk0Bg=;
	b=tp/uD8N2vg4A0fGvCIz0vKaej98xqCk8Z8+T0aoWFx7WmkTunWfC2/jelpVTwbHctmRH
	 9wVvuE/+OW4wia8/d223OO4yQOPjfha52uXoniMmKWAOnzVQ5UJjegWTit0JJHPLEM7ub
	 HppiElmwgjmJ1Mw/E3RoLhX8v44TL68IiHtJZD9iyfKvEsAAEqaLDV3c/uHG7VuFZ/Kkj
	 tNOMrpcd/dIN+gurMEQMGVYEdpC8/oE/t6vnMAteOILt/q1u1vtWOi35z7gLew6pRzZmV
	 dOGhqHv6Pd6sAFwqbadd6KGyYRbNWfF7UT4Pq0bUaXBLnU8YN3KkUZJD64IlL20tV6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D387606A320;
	Tue, 27 Oct 2026 05:28:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D387606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8DxC9JkNuBqZbUZAA--.9269S3;
	Tue, 27 Oct 2026 13:28:04 +0800 (CST)
Received: from [127.0.0.1] (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJDxg8xiNuBqKJEwAA--.8197S2;
	Tue, 27 Oct 2026 13:28:03 +0800 (CST)
Subject: Re: [PATCH bpf-next] selftests/bpf: Enable signed division and modulo
 overflow tests for LoongArch
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20261027041627.20792-1-yangtiezhu@loongson.cn>
Message-ID: <f9eaf0a8-d5c2-f0d9-afa8-73343d7da514@loongson.cn>
Date: Tue, 27 Oct 2026 13:28:02 +0800
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
In-Reply-To: <20261027041627.20792-1-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxg8xiNuBqKJEwAA--.8197S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoWrtF4Uuw13Ar43Zw4kXFyxJFc_yoWfAwb_C3
	WxKr1DCw4Yva1SyFnFq34rA347ZrWkWry8GrWDWF1Iq347A3s5Wrn5J34ruryYqa1Fvr9x
	Gr4jvw12kwna9osvyTuYvTs0mTUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbI8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAF
	wI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
	CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JV
	WxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcVc_
	UUUUU

On 2026/10/27 下午12:16, Tiezhu Yang wrote:
> The LoongArch hardware divider handles signed overflow boundaries (such
> as INT_MIN/-1 or LLONG_MIN/-1) natively and perfectly well on physical
> silicon: (1)for division operations, it naturally returns the dividend
> itself; (2)for modulo operations, it returns 0. Thus enable the signed
> division and modulo overflow tests for LoongArch in verifier_sdiv.c.

Besides the 8 signed overflow (MIN/-1) test cases, I noticed that
there are another 8 test cases for small value signed calculations
with negative divisors (small_val/-1) that were also masked by
__arch_x86_64.

I've tested both blocks locally on a physical LoongArch machine, and
all 16 test cases passed flawlessly (Summary: 1/144 PASSED, 0 SKIPPED).

IMO it is better to enable these 16 test cases together in a single
patch, I will send v2 later.

Thanks,
Tiezhu

