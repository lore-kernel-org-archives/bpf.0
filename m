Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8B737F748;
	Thu, 23 Apr 2026 02:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776912983; cv=none; b=rKaoSUwZVhQeaqA4iJxH1aSAZI+wJ8+yMApeVk1DIbkShYMvOQ3cR01f2tE0+eoKmrC11JnbFWwo2rgj1fHKgTBQgirzYrM4Mrtgg/QsnK4tUEJJRNmZFtvxHUb8hNoAd6WAZXn9HT++i7/APAganhzCskGuqhnzBnJUICC4mUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776912983; c=relaxed/simple;
	bh=OBIw6ZRdLyOvYlTBzK65dsNUkHuLaKXbsb75Rq3dmaU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=JeC//+xmPYvAancdWVOqJwGDW4ZFyob9gD/+WKeIBG8UHRUvUxtiOmdi8cZ/Ctq0aAwi11pZlNzL/400nXuslqkaXN0tVju6/XiDm46hTkjGaMZRTVnG07FfI+ytSLynRW4EKVj7WAh2n5A5Tsd98lifcYuJORHSRurZlNtzFeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Cx3elLiulpfhwDAA--.10703S3;
	Thu, 23 Apr 2026 10:56:11 +0800 (CST)
Received: from [10.130.40.83] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJBxpsBKiulpJRJzAA--.53243S3;
	Thu, 23 Apr 2026 10:56:11 +0800 (CST)
Subject: Re: [PATCH v3 0/5] LoongArch: BPF: Support more atomic instructions
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Hengqi Chen <hengqi.chen@gmail.com>, loongarch@lists.linux.dev,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260413040506.26640-1-yangtiezhu@loongson.cn>
 <CAAhV-H59RuXDEqLe7UNDYssvMFXqZ2YZuW4gOUqdscPQZpqibg@mail.gmail.com>
 <4a6c89b6-72a8-a80b-1f7c-9a620ed24505@loongson.cn>
 <CAAhV-H6kL9ZY13N5pDXzQRcdO6bWso=8vaDFU_5ki1EejnvQSw@mail.gmail.com>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <de013523-6647-6e43-9093-bd0e31d19126@loongson.cn>
Date: Thu, 23 Apr 2026 10:56:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H6kL9ZY13N5pDXzQRcdO6bWso=8vaDFU_5ki1EejnvQSw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxpsBKiulpJRJzAA--.53243S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoWruw1UKF1UXF18Xw1kCFW5twc_yoWfCFgEkF
	13KrnxCw17K34rJw12kr1SyrZ2vFW3Kr95Gr4UXFZYkFy8trZ2yr1kA34kAwsYkwsxJa1f
	KanIvF12yF1fCosvyTuYvTs0mTUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbxkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8
	Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
	AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8j-e5UU
	UUU==

On 2026/4/22 下午4:15, Huacai Chen wrote:
> On Tue, Apr 21, 2026 at 9:24 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:

...

> OK, Applied to loongarch-next with some small modifications, please
> make sure everything works well.

I tested the loongarch-next tree, all the related testcases passed:

   sudo ./test_progs -a tracing_struct/struct_args
   sudo ./test_progs -a tracing_struct/union_args

   sudo ./test_progs -a tracing_struct/struct_many_args
   sudo ./test_progs -a fentry_test/fentry_many_args
   sudo ./test_progs -a fexit_test/fexit_many_args

   sudo ./test_progs -t verifier_load_acquire
   sudo ./test_progs -t verifier_store_release
   sudo ./test_progs -t verifier_precision/bpf_load_acquire
   sudo ./test_progs -t verifier_precision/bpf_store_release
   sudo ./test_progs -t compute_live_registers/atomic_load_acq_store_rel

Thanks,
Tiezhu

