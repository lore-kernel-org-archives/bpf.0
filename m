Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795542268;
	b=oAbWyp60vn3oUo4T68gHWQmvnKm7+15t68Mf7HtBeDQ26lpQo2lsgZ2r/+KLOTAVMESu
	 qPsLIrhTaXf1gfrp3bEvoxLnV+dpjWkGf/9gSwNyW0PcCWT9AMqlq8Np3QbUrhYRESbmJ
	 /xKMx/wxabDhIzfDJDyRUHnMXAx0L2mV6sQqri+17m6M+8rh7RiTt0LZ8gEG1rx5l5gQT
	 eTYKkDt0AA5a9A48c0XEhLKIUHOznG3GGRJp7dGTjefWaJFfSrPb1eAVhGV+cJeZyyVfH
	 uv1unQbxK7F/Lb/BWgrodkOuDhl6lCUimT8YKJPycA84ViZczFSnhCAOPiaaqZUrPmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795542268;
	h=Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=L7gkqXHJBPl+/Nmj94ah2S29kvziX5W9l3TLZAZj8Ko=;
	b=kmJTM12ECXdKs+t8o3Ce5Ra9i2cEbHWyvrivX9FUpEoGwAI+1J3JVJsom5gvF7YA76oD
	 R/lS6aY9DrR5oLeK2ZcIbga0wbHK+3/0KbAx8Ev6DLQjupBjcmzm3AqdHJj8V0d0f1Cof
	 0DR5eXAy8lldiZYArEkM89DA9T8JVG6s9wbar3EIVwEU9W48XE0SuD+80oD4hBg6RmfrP
	 pdqOO6TRc2Ggs4ZOX3JvRbJkOPW19OoHEHG7qIbZhQWgh/Kj8XPrm60aulHEUILti0/B/
	 WdoxRezDryeGcf7UFCuc0QtkBwocDk6OuodmQ8oyK5gDDrFd8Tms1YHcnjRPcZtv+UA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZazoShGD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42446606A321
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 17:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZazoShGD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E1681F000F2;
	Tue, 24 Nov 2026 17:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795542267;
	bh=L7gkqXHJBPl+/Nmj94ah2S29kvziX5W9l3TLZAZj8Ko=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=ZazoShGD3d0dYItBNx3v4YoiDJYfGsxaUpHOnDDfvjerDU+d9IEpHTdCRTnbXvdcT
	 EGtVrPnmb5cFflWpW8faPaC6qqXbupG66glso336uGDrp5sVLH0+1uz24LwxYdkkkS
	 IPpwaO+B7/k6NXBdi1T5KEuJ33s8xM18phNzZysLw3JkqsVD8C1QLWCuqZeeZix2dF
	 +nroZNsztqqFJiRM6y5V2GCtZ4IpUGovULdzlw8M6MEGDBIyNs43eCjDmCY3vZmThu
	 iUzGn0L1YUy2w72O6u3htBhiXxrdBKAA2K7BzrIyTpFRZTzzBK8ju9fE1qZFoljFnf
	 ODE6FA5827Z4w==
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH bpf-next v1 02/10] bpf: Keep an overwritable ring
 buffer readable while it is overwritten
From: Tamir Duberstein <tamird@kernel.org>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Xu Kuohai <xukuohai@huawei.com>, 
 Tamir Duberstein <tamird@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, kkd@meta.com, kernel-team@meta.com
In-Reply-To: <5663a3dad6f78e6e52ad468d24579b0dee662d1e.1795467315.git.memxor@gmail.com>
References: <cover.1795467315.git.memxor@gmail.com>
 <5663a3dad6f78e6e52ad468d24579b0dee662d1e.1795467315.git.memxor@gmail.com>
Date: Tue, 24 Nov 2026 12:44:15 -0500
Message-Id: <179554225568.72201.15417801662639706137.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3407; i=tamird@kernel.org;
 h=from:subject:message-id; bh=O9zEgGICws2uEQjhDGgirRrRQF/3WC4erGv1UpZ/710=;
 b=owGbwMvMwCV2wYdPVfy60HTG02pJDNmsZz7fnqjE+m5+W+gxFoWOXovU+i5lrrxrR2vefulcc
 pilOmRax0QWBjEuBksxRZZE0UN701Nv75HNfHccZg4rE8gQaZEGBiBgYeDLTcwrNdIx0jPVNtQz
 NNIx0DFm4OIUgKnm4GH4Z9T7WDOi5w6LzrQNV3sOJnTtYS+tn3M3xdpuSu+On18FXRj+Z6yYL7J
 WdUqQeObZs9vDTvXkzf9mt/mYyMLHx7+tY1luxwIA
X-Developer-Key: i=tamird@kernel.org; a=openpgp;
 fpr=5A6714204D41EC844C50273C19D6FF6092365380

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
>   consumer                            producers
>   consumed up to 0, epoll_wait()
>                                       reserve and commit R1 at 0;
>                                       consumer_pos is 0: wake up
>                                       reserve R2:
>                                         overwrite_pos = 2048
>   woken up, poll looks again:
>     over_pos 2048, prod_pos 2048,
>     nothing to read, sleep
>                                         producer_pos = 4096
>                                       commit R2, at 2048;
>                                       consumer_pos is 0: no wakeup
> 
> There is no wakeup for R2. The consumer sleeps until a record starts at
> that offset again, which is the next one here.
> 
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
>  kernel/bpf/ringbuf.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
> index 5806a5eb5d16..1334cfd90f2a 100644
> --- a/kernel/bpf/ringbuf.c
> +++ b/kernel/bpf/ringbuf.c
> @@ -336,12 +336,18 @@ static u32 ringbuf_total_data_sz(const struct bpf_ringbuf *rb)
>  static __poll_t ringbuf_map_poll_kern(struct bpf_map *map, struct file *filp,
>  				      struct poll_table_struct *pts)
>  {
> -	struct bpf_ringbuf_map *rb_map;
> +	struct bpf_ringbuf *rb;
>  
> -	rb_map = container_of(map, struct bpf_ringbuf_map, map);
> -	poll_wait(filp, &rb_map->rb->waitq, pts);
> +	rb = container_of(map, struct bpf_ringbuf_map, map)->rb;

nit: this declaration + initialization could be a single line.
Reviewed-by: Tamir Duberstein <tamird@kernel.org>

-- 
Tamir Duberstein <tamird@kernel.org>
