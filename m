Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.71.93.112
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795505941;
	b=TYKruFTCMMaDUX2MDvMZlgsUxUy3gCpm/MHJ+2ef9jLFQ3KW+Kgblvmf0HRR0IoDxGD3
	 Mh+JI2eRE9DOHwQZj6eHLt54C7MSx4G9yQjaKlckVq/gEFJSYOYY4AkqKzo0mVRIVQdV3
	 eNOXc0wWwQxnBdvL0fwEnXKoNRH/s5TTeEpGaZ1noUlzfuGi76TAhM3Xnk+1nG50jQy70
	 zVi1Ev6eQ1AylWt0/PlBhwh6NLydDJcWsf4ryiKgn44Dk38V5NwWSatCzinGdoDoHS6G5
	 9LO8ZB/omJIX+eGDr0pagAx5s8FTmKDg1FdMm4CT6yfRr6SQD93HGccMfVzFTPUls3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795505941;
	h=DMARC-Filter:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:Content-Language:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo;
	bh=rTUs9cdMrkQJSvPhgpTzpH6qN4pZLCV58+GX4xxpvzw=;
	b=Hb4KsqrfeA50cYNxHPw4nUsHRfGNgFdt9VuTPPNPcFELWZqeuQ4Q9n1gDIS9R11YS+Zq
	 edlTLgi074118YZduFf+vxgbIFT+FxTzxiEc6xWOHV0NeRCfQ7/FLzOdvWlbyVVMYi9JD
	 8WuUjz3s2JOR8U3gQqOulMBNg4zMGNuSMnmyo78gGFRMovx1kDarlG8FW9snGw9HRVGUG
	 TKZ4uDtaRwtTCrLxXFv941D02vrnXPPqyLvuBYzpNG6/41gnVzAJu+Z+B/wjINxRQGZNf
	 N2CZ1o80r7J/BZ+5Ha125MMdYGI0ZGqEB3ZtQ0UG22uCPM6jjopG0UmJNP37TzRlcTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=124.71.93.112
Received: from dggmsgout12.his.huawei.com (dggmsgout12.his.huawei.com [124.71.93.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B46B606A321
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 07:38:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B46B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggmsgout12.his.huawei.com (SkyGuard) with ESMTP id 4jYZSG6YByz1yDW
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 15:38:54 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 52B744056D
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 15:38:56 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgDXWvAPPwVreygiFg--.20480S2;
	Tue, 24 Nov 2026 15:38:56 +0800 (CST)
Message-ID: <ded3668b-b122-4cdf-ac87-b1aa321910f2@huaweicloud.com>
Date: Tue, 24 Nov 2026 15:38:54 +0800
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v1 01/10] bpf: Order record data after the
 producer position in overwrite mode
Content-Language: en-US
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Tamir Duberstein <tamird@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, kkd@meta.com, kernel-team@meta.com
References: <cover.1795467315.git.memxor@gmail.com>
 <8a47c80b9a3dfa8ddd4788781b854357a15717b9.1795467315.git.memxor@gmail.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <8a47c80b9a3dfa8ddd4788781b854357a15717b9.1795467315.git.memxor@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgDXWvAPPwVreygiFg--.20480S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCr48WrW5Kr48trW8Kr4UArb_yoW5Jw1rpF
	WftFy3uFZFyr4rCr1xuFy0vFyrC3ykAw13G3Zxt34xuw15tr1rZFy09a9IgryYkry0qryF
	vrWqga9Fkr98Ca7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AK
	xVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UAwI
	DUUUUU=
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 11/24/2026 5:13 AM, Kumar Kartikeya Dwivedi wrote:
> In overwrite mode the producer can reuse the memory of a record while the
> consumer is reading it. A consumer can only find out by reading
> producer_pos again after it has read the record: if the producer is less
> than a ring buffer size ahead of the record, the record was not
> overwritten.
> 
> This only works if the consumer cannot see the data of a new record before
> it sees the producer_pos update for that record. __bpf_ringbuf_reserve()
> updates producer_pos with smp_store_release(), and the BPF program writes
> the record data after it returns. smp_store_release() doesn't order the
> stores that come after it, so on weakly ordered architectures like arm64
> the consumer can read data of the new record, then read the old
> producer_pos, and take partially overwritten data for a valid record.
> 
> Add smp_wmb() after the producer_pos update in overwrite mode. It is only
> a compiler barrier on x86.
> 
> LKMM litmus test, where P0 is the producer and P1 the consumer:
> 
>    C rb-overwrite-data-vs-prodpos
> 
>    {}
> 
>    P0(int *prod_pos, int *data)
>    {
>    	smp_store_release(prod_pos, 1);
>    	/* smp_wmb(); */
>    	WRITE_ONCE(*data, 1);
>    }
> 
>    P1(int *prod_pos, int *data)
>    {
>    	int r0;
>    	int r1;
> 
>    	r0 = READ_ONCE(*data);
>    	smp_rmb();
>    	r1 = smp_load_acquire(prod_pos);
>    }
> 
>    exists (1:r0=1 /\ 1:r1=0)
> 
> The outcome is allowed without the smp_wmb() and forbidden with it.
> 
> Fixes: feeaf1346f80 ("bpf: Add overwrite mode for BPF ring buffer")
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>   kernel/bpf/ringbuf.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
> index 447863ece26a..5806a5eb5d16 100644
> --- a/kernel/bpf/ringbuf.c
> +++ b/kernel/bpf/ringbuf.c
> @@ -532,6 +532,16 @@ static void *__bpf_ringbuf_reserve(struct bpf_ringbuf *rb, u64 size)
>   	/* pairs with consumer's smp_load_acquire() */
>   	smp_store_release(&rb->producer_pos, new_prod_pos);
>   
> +	if (unlikely(rb->overwrite_mode)) {
> +		/*
> +		 * The consumer reads a record and then checks producer_pos to
> +		 * see if the record was overwritten in the meantime. Make sure
> +		 * it can't see the record data that our caller is going to write
> +		 * before it sees the producer_pos update above.
> +		 */
> +		smp_wmb();
> +	}
> +

Good catch!

Acked-by: Xu Kuohai <xukuohai@huawei.com>

>   	raw_res_spin_unlock_irqrestore(&rb->spinlock, flags);
>   
>   	return (void *)hdr + BPF_RINGBUF_HDR_SZ;

