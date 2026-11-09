Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794204637;
	b=nuPSbB9zUbwxUMqPQOlcyCwDQHfc5jCIb+B3hEqrNO5mFRnRwSrAZf7u438C92mGkRt5
	 lNlOBeggFuAVahMupySRUQCfCOiM4Abs5kVj/JCnVztqDzX1G4kcWVbhkDxIWlQybEeOO
	 BkmZ6cNkYdD5bjZnmS8zn977eyUeBhl8i038aqbFMTcXs3JG+hm7X5UrniFmfXQy0rwZ+
	 tY+h+Gqnah+6Ta8plZWxLtCo5QujUY6pw93SvCYTUiwXevL+riRexraEPXaqllCGBBqwB
	 H0g0RZb4ZuH2d4adcU3fgG99e84vfPy9P402xo6xB1lvjdSg63Er0In33CHQEk9n9CQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794204637;
	h=DMARC-Filter:Received:Received:Subject:To:Cc:References:From:
	 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:Content-Type:
	 Content-Language:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-CM-SenderInfo:X-Coremail-Antispam;
	bh=9T4Pu4J2hNrkYw/uwEMnWu0HaxwlCEogmij+cvo0z2U=;
	b=4pNNcaBU7ikAa9bx1a5k4GbMMT27RjjydYwm+t9+j+qDHodIQqCSYHTWiBJnDQOlMVeE
	 sQQxJdbVEJmchWh1MFXAQ1TjVA0wqDWxqPPu9SpwyEJmEZekoqJs+Px2A/HMHiDscQKSv
	 EfZOV3gc0QlrpNuheLHGYfOkberhOeCLs6hiVOIqKC0/Y++DDwTXOFAi1Qb2+aw5eZ3PZ
	 iPh0bdxzVyQyh5oueSfM4nqgTimzLFf8NwMAS37QqmRrBpRd+MrGCy+lfA3MUvZtiDtfI
	 UhTQ0GjQrbrb+UZd4EYPVSxTbBfTkpsiOly4fBvUTbf/Of/8144abSSw6JcRUrwV27g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCED606A321
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 06:10:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDCED606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8AxdvDYY_FqfbkdAA--.19845S3;
	Mon, 09 Nov 2026 14:10:32 +0800 (CST)
Received: from [127.0.0.1] (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJAx3c7XY_FqOx8zAA--.38975S2;
	Mon, 09 Nov 2026 14:10:32 +0800 (CST)
Subject: Re: [PATCH bpf-next v2 1/2] selftests/bpf: Skip jit_insns_arena tests
 if not supported
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20261109041207.15221-1-yangtiezhu@loongson.cn>
 <20261109041207.15221-2-yangtiezhu@loongson.cn>
 <sashiko-outbox-204403@kernel.org>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <488e67f5-ee17-2b4b-335a-e38268f44761@loongson.cn>
Date: Mon, 9 Nov 2026 14:10:31 +0800
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
In-Reply-To: <sashiko-outbox-204403@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:qMiowJAx3c7XY_FqOx8zAA--.38975S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoW7Gr47Cw4xCr1xZw4UGw4fCrX_yoWDWFg_Za
	y8Kr1kGFW8Za9xt34fKF18tFs7trWxAFyUArn8KF48Ja4UJwn8uFs7Crn3Ca48WayfJr93
	Ka4kta9xJw13uosvyTuYvTs0mTUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbI8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAF
	wI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
	CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JV
	WxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU20PS
	UUUUU

On 11/9/26 12:25 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Low] selftests/bpf: incomplete jit_insns_arena skip list in
>    test_jit_insns()

...

> [Severity: Low]
> Does this else branch miss the remaining subtests in jit_insns_arena?
> 
> Commit a9fee553d3db ("selftests/bpf: Extend the JIT instruction tests for
> arm64 encodings") added arena_offsets (built on all architectures) as well as
> arena_offsets_ldsx, arena_offsets_atomics, and arena_acq_rel to
> tools/testing/selftests/bpf/progs/jit_insns_arena.c.  When BPF_MAP_TYPE_ARENA
> is unsupported, those subtests are silently omitted rather than registered and
> marked skipped, so targeted runs such as ./test_progs -a
> jit_insns/arena_offsets match zero subtests.

I will introduce test_loader__skip_all_subtests() helper as a generic
utility to avoid hardcoded string arrays in test runners.

Thanks,
Tiezhu

