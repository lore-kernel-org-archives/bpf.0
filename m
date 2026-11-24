Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.71.94.104
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795506945;
	b=VfKEvDGVt1qiHoxm9pgQh7On0lD86/Y0g4IijWXXrlwROGxfJF6nUM8PzyHAvEE/+hsS
	 eAp3Bq1wt7ZfZE/Guxb5R4RB2ER0+DnczRrgsmFp71k8xi7OJO2j4mSp/r8dsk3GP5bqi
	 91NOXa9HZ7o+8TNaD4DfCFC67NcqQEzKi6KkDFgJlIcRUgQe9BZWr5VUBlViOlwor6BZM
	 rFTBHwdFRgYmNX3tPfKIw9ikP4oltFFWISGBO0ATUrX9D4/6cgtG6asovqSr6WG/8I9UB
	 qt/ZyHhsLCXDGCZ1Hs1c9jAlHTzjhi7FIt7BsQJWmzD2vt4eqXLybm+X73gt1Yf+AtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795506945;
	h=DMARC-Filter:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:Content-Language:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo;
	bh=2OT2Av+5ktz3B/b0MrryY7AUvz1y/j4aP+AaR1BxIAk=;
	b=PMFDuJ/hdD+r/TgFaxZT3S67ru2AWffep8w+YQROdmW6DBTVAsmY+qgAzRcSDi90GwRN
	 QtqXh1LFAd/PLSy4t4pKuyuuEhwgmced+w5oI4t66f3aLzb0FYIdYm0E7QnBxXZO8rrR+
	 bFIjJAYu4l5kyPOHQIOPIXX4B9KN1SFcu5zUPFGS/SruyJVcEwfjZcZLLA+XeXQrHDNEf
	 XPRH1Bx1Fp4xMMT8gqknI50sOrrQs21KK5kH2bzcufpZ4S5LgGTPA2crO8pg6K5xikkYW
	 1UMrcBPVhtC1E/Cx7/3phCplFP8WvV//iLgFNrD026ukFbkB+/CpSNppGDsAZpltg8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=none smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=124.71.94.104
Received: from dggmsgout13.his.huawei.com (dggmsgout13.his.huawei.com [124.71.94.104])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2B7606A31E
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 07:55:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF2B7606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggmsgout13.his.huawei.com (SkyGuard) with ESMTP id 4jYZqS4wDzz1rqbK
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 15:55:32 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id CCC434056B
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 15:55:33 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP1 (Coremail) with UTF8SMTPA id cCh0CgD3R830QgVr1JkPFg--.22414S2;
	Tue, 24 Nov 2026 15:55:33 +0800 (CST)
Message-ID: <6cc5e9e2-c650-49b4-9489-d823457b51da@huaweicloud.com>
Date: Tue, 24 Nov 2026 15:55:32 +0800
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
Subject: Re: [PATCH bpf-next v1 02/10] bpf: Keep an overwritable ring buffer
 readable while it is overwritten
Content-Language: en-US
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Tamir Duberstein <tamird@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, kkd@meta.com, kernel-team@meta.com
References: <cover.1795467315.git.memxor@gmail.com>
 <5663a3dad6f78e6e52ad468d24579b0dee662d1e.1795467315.git.memxor@gmail.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <5663a3dad6f78e6e52ad468d24579b0dee662d1e.1795467315.git.memxor@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgD3R830QgVr1JkPFg--.22414S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJFWDJw17urW3urWUtw1fZwb_yoWrJF4xpF
	s8tFy5CrsFvr4fuw1jga1IyFyrAa1kJw4fGFs3J348urnrJF1FvFyIkFyavr13JrWvgr1F
	vFWq9Fyqy34UCFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 11/24/2026 5:13 AM, Kumar Kartikeya Dwivedi wrote:
> ringbuf_map_poll_kern() reports the ring as readable when
> ringbuf_avail_data_sz() is not zero, which in overwrite mode is
> 
> 	over_pos = smp_load_acquire(&rb->overwrite_pos);
> 	prod_pos = smp_load_acquire(&rb->producer_pos);
> 	return min(prod_pos - cons_pos, prod_pos - over_pos);
> 
> __bpf_ringbuf_reserve() stores overwrite_pos before it publishes
> producer_pos. When the new record overwrites every record in the ring, it
> moves overwrite_pos up to the old producer_pos. A poll between the two
> stores computes prod_pos - over_pos == 0 and finds the ring empty, although
> the consumer is behind the producer.
> 
> A consumer that polls at that moment goes back to sleep on unread
> records, and the commit of the new record does not wake it up, because
> bpf_ringbuf_commit() only wakes up the consumer for a record that starts
> at the offset of the consumer position in the ring. With a ring of 4096
> bytes and records that take 2048:
> 
>    consumer                            producers
>    consumed up to 0, epoll_wait()
>                                        reserve and commit R1 at 0;
>                                        consumer_pos is 0: wake up
>                                        reserve R2:
>                                          overwrite_pos = 2048
>    woken up, poll looks again:
>      over_pos 2048, prod_pos 2048,
>      nothing to read, sleep
>                                          producer_pos = 4096
>                                        commit R2, at 2048;
>                                        consumer_pos is 0: no wakeup
> 
> There is no wakeup for R2. The consumer sleeps until a record starts at
> that offset again, which is the next one here.
>

Good catch. Since the producer does not wait for the consumer in overwrite
mode, a new record can span across the consumer position. Should we also
wake up the consumer when the consumerposition is overwritten, rather than
only when the new record starts at that position?

> There is something to read whenever the consumer position is behind the
> producer position, in either mode. Compare those two and leave
> overwrite_pos out of it. bpf_ringbuf_query(BPF_RB_AVAIL_DATA) is
> unchanged.
> 
> The missed wakeup follows from the code and was not reproduced, but the
> empty poll was. A user space loop that polls an overwritable ring, while a
> program overwrites it with records of more than half its size, found the
> ring empty in 25 to 59 of 1.1 million polls in three runs of half a
> second on a 4-CPU VM, and in none with this change.
>
> Fixes: feeaf1346f80 ("bpf: Add overwrite mode for BPF ring buffer")
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>   kernel/bpf/ringbuf.c | 14 ++++++++++----
>   1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
> index 5806a5eb5d16..1334cfd90f2a 100644
> --- a/kernel/bpf/ringbuf.c
> +++ b/kernel/bpf/ringbuf.c
> @@ -336,12 +336,18 @@ static u32 ringbuf_total_data_sz(const struct bpf_ringbuf *rb)
>   static __poll_t ringbuf_map_poll_kern(struct bpf_map *map, struct file *filp,
>   				      struct poll_table_struct *pts)
>   {
> -	struct bpf_ringbuf_map *rb_map;
> +	struct bpf_ringbuf *rb;
>   
> -	rb_map = container_of(map, struct bpf_ringbuf_map, map);
> -	poll_wait(filp, &rb_map->rb->waitq, pts);
> +	rb = container_of(map, struct bpf_ringbuf_map, map)->rb;
> +	poll_wait(filp, &rb->waitq, pts);
>   
> -	if (ringbuf_avail_data_sz(rb_map->rb))
> +	/*
> +	 * In overwrite mode ringbuf_avail_data_sz() can return 0 for a ring
> +	 * with unread records: a reservation can move overwrite_pos up to
> +	 * producer_pos before it updates producer_pos. Check if the consumer
> +	 * is behind the producer instead.
> +	 */
> +	if (smp_load_acquire(&rb->producer_pos) != smp_load_acquire(&rb->consumer_pos))
>   		return EPOLLIN | EPOLLRDNORM;
>   	return 0;
>   }

