Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05D742901C;
	Thu,  6 Aug 2026 12:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786018915; cv=none; b=KeDuPJTOymStgiGfGyHB2LXHpDzsawixSWCEMEXyaQLv67lFluSYGAemMRCedLIqukSnEo1pjhcfBidxsMvPXOajwsONOZGq8I4CLN6rhuY9KfcCxW1peHXRsd/Z2C6PDiI/zmXfF06BeHnI6fphYurPEDYGMCTP48xDGklyxGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786018915; c=relaxed/simple;
	bh=4DNuvtRJ/KRqzWG3Phg0vgIRZQXpDIPkScITOHaKLtE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ihQWvA84FzmkBbldT+6DCuaglNoI/QsRjWsBj+8MiBlk+RCwV+V2bR301N33ObJI8dyfLNoU0LiGwX1LPTwdbhBY48yBSbAr575O4zQbdLYc/xCUHh6uI5LKQ1CagWA8kffcE/wjMtCH3MWn6jntTKXZhPT2FYTQRk/1kefLpRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8Axw+lcfHRqnfsKAA--.12249S3;
	Thu, 06 Aug 2026 20:21:48 +0800 (CST)
Received: from [10.130.40.83] (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJAxSsRafHRq08UlAA--.21220S2;
	Thu, 06 Aug 2026 20:21:47 +0800 (CST)
Subject: Re: [PATCH v4 0/4] LoongArch bpf kptr xchg inline support
To: Chenguang Zhao <chenguang.zhao@linux.dev>, chenhuacai@kernel.org,
 kernel@xen0n.name, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com
Cc: hengqi.chen@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, shuah@kernel.org, loongarch@lists.linux.dev,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Chenguang Zhao <zhaochenguang@kylinos.cn>
References: <20260729022837.355549-1-chenguang.zhao@linux.dev>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <b11c0259-87fe-8132-f028-13fd6ec969cc@loongson.cn>
Date: Thu, 6 Aug 2026 20:21:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260729022837.355549-1-chenguang.zhao@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxSsRafHRq08UlAA--.21220S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29K
	BjDU0xBIdaVrnRJUUUmYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26c
	xKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
	j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x02
	67AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
	ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E
	87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0V
	AS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCF54CYxVAaw2AFwI0_JF0_Jw1l4c8EcI0E
	c7CjxVAaw2AFwI0_Jw0_GFyl4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF
	0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
	17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
	C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
	6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
	73UjIFyTuYvjxU7MmhUUUUU

On 2026/7/29 上午10:28, Chenguang Zhao wrote:
> From: Chenguang Zhao <zhaochenguang@kylinos.cn>
> 
> This series enables the BPF verifier to inline bpf_kptr_xchg()
> into BPF_XCHG on LoongArch64, and fixes the underlying JIT
> atomic ordering that makes such inlining safe.

The first three patches apply cleanly on top of the loongarch-next
branch of linux-loongson.git.

The following selftest passed on LoongArch:

   # ./test_progs -t kptr_xchg_inline

Acked-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Tested-by: Tiezhu Yang <yangtiezhu@loongson.cn>

Thanks,
Tiezhu

