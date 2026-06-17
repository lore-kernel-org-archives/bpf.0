Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6786158DCF
	for <bpf@vger.kernel.org>; Wed, 17 Jun 2026 01:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781659843; cv=none; b=bELa9YvxBWgNLbXHwNN+Ho0rzG3aMTD0DISkPNEWgiPwTEkzgBjRaUIRpO4AKe7cvgEGjNYbt8L53RsMhStFRWXQSt/FLZmtUrLWx22b4ybTl670oYQdPvQ5IUTkgwyswRndN9Ah2dQMW89EeMAolW6xM3EVuxkYsRqrl1/tg6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781659843; c=relaxed/simple;
	bh=Fnmd794AbnXpu3k3viU+pwAgaaSfmyIGqDXeEpfFxjI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=jG+HoAOuF/T51yvziSDUI28OIg/7kIe5cpVRT73NVOYaQybjqxswJCAZG5Z+U/HAp2mU6EFPMyS+nLVBOkmm1d2F/F2D2dFweBELIYiqpZaRv86VDAQkAB6/nlalWIP1XMU56ZF1w6RRN0ZAno+o8s7frJm6uX4ZQSdHrmBsDsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=h5R623+v; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="h5R623+v"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-307263ad0cbso8314783eec.0
        for <bpf@vger.kernel.org>; Tue, 16 Jun 2026 18:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1781659842; x=1782264642; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=foa9TfDTwAbcXqfmpgXrr65v3TLgk179Ri/oJcEA6IE=;
        b=h5R623+vyrd0HpXH+0XiaqttUSwHKtTR39ZM8Vs4hYrugaahvd4/SNl1+42UaszDqt
         8jJcw7djVHWcghN4EkCA8a8bRbQpz9eQMbFW8sEaqo7thZahXwq2B40gB9CffJrMHEIA
         lw9ssEBjv8YDYknvlIrR1dcz5FZ782cjE10J+Wcw99o083ckOrv1V2AZJdAtumhQEORw
         jnenK6LguPTNcaZt11sr+X2rxu8V3kFBbHnORzNZweFCV/3aCMop2/NghmmUMDeSKDr8
         YQN0Ie79r2WJct/4dvjaAGrIsr20v8IByw/BsTdbKYJ3My0y0HMS7Xnqk3dUoob41epI
         PqBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781659842; x=1782264642;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=foa9TfDTwAbcXqfmpgXrr65v3TLgk179Ri/oJcEA6IE=;
        b=rMlcsADDvdC15T8H/R8lgSkJ8YHBsdbIHBg/TMWZqX77dDpi4cKzqo+dVZlk0nrGv1
         uBKdhYfA0+qw06nC90u6ohYoZmaSPQAkpcgo1gY7KJKOgq7lTBeSaLKsfPyubmRgNXLh
         Nc2fuyAiWzRVbS6Rnq69yz6G+KnuzjwJ0AhR9J8JxGK/AqczXaw9kKOyrtmCYBDtc7sw
         ljM9X6MJ8IoRm019FL6Ey+avasOOGiPvEA/tdQnaKbH21vHRn81U5cSnAkk0yy+0t/c5
         YjjWfnOVcKYPjQMPTXYIXadqUIfoBNh+I+Tcc1hb7Y6TqKEMUQU8I7Cc16sGopEPBP6x
         68Vw==
X-Gm-Message-State: AOJu0YzbrNpcAFK9sclJgsum3I+n/lHyGNN3T7W0nFbDe4edsemrU0DH
	rPQtRAvS0R8Ab4/oUVBsgy5A4/V6tGbNAZRDU+XgYgCPwmq0+DFt/SmEu05JMG0Txjg=
X-Gm-Gg: AfdE7clyw71VYp5ZKxOqUVOYWKy9BmcaxjYy3bsNYf17lW7/DpwtMF5x2D43AP/XIcB
	LXrsWoRPkCe58tyyOMqfjFTCELiaYgWGg4yvskPY7tmqvsWm+BfeXOcAa4+1ESntX6Xh6F53f1d
	2QdHwHY+5DQ8BDn14jZEW1MJRGrLsnIq1bCJ5F48Wfpxfof1Irl1FWpvYhEHzimFboGBqykO1Di
	wYAav5hU1djt7Sl5/WWiKyYGVAGnpVD8x+8lan+iTyO0/DbVrtNoxyFUMnXpH3JhDkpi7UqPrb0
	ZbzGU/FGy1n68Ovr7RsitakiZz20T4T3PiAgn9zNArU9Unym5w8B+5pxHZQGNZ4sI/yFp0mSYqm
	tSH3e00fZnIsYaq8InFOIBOJR5hPmsgX8zi/sX00d3RLGOC7npa2/D7lXYuzVckIbBk+JJNOVSm
	oDa3xQ
X-Received: by 2002:a05:7301:100b:b0:307:934e:da79 with SMTP id 5a478bee46e88-30bca0aacbbmr1227152eec.34.1781659841751;
        Tue, 16 Jun 2026 18:30:41 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::2568])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081ddaf69asm21886860eec.0.2026.06.16.18.30.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2026 18:30:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Jun 2026 21:30:38 -0400
Message-Id: <DJAXPAPT515H.2W1O5R59RISH7@etsalapatis.com>
Cc: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, "Andrew Werner" <awerner32@gmail.com>,
 "Zvi Effron" <zeffron@riotgames.com>, "Andrii Nakryiko" <andriin@fb.com>
Subject: Re: [PATCH bpf 4/6] libbpf: ringbuf: Use compiler atomics
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Tamir Duberstein" <tamird@kernel.org>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Shuah Khan"
 <shuah@kernel.org>, "Andrea Righi" <arighi@nvidia.com>, "Xu Kuohai"
 <xukuohai@huawei.com>, "Andrea Righi" <andrea.righi@canonical.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260613-bpf-ringbuf-fixes-v1-0-e623481cb724@kernel.org>
 <20260613-bpf-ringbuf-fixes-v1-4-e623481cb724@kernel.org>
In-Reply-To: <20260613-bpf-ringbuf-fixes-v1-4-e623481cb724@kernel.org>

On Sat Jun 13, 2026 at 9:48 PM EDT, Tamir Duberstein wrote:
> Consumer-side ring buffer code uses architecture-specific smp_* helpers
> for shared memory accesses.
>
> Use compiler atomics instead. They provide equivalent acquire and
> release ordering through a portable userspace interface and allow the
> next commit to use compiler fences in the wakeup protocol without mixing
> atomic interfaces.
>
> Assisted-by: Codex:gpt-5.5
> Signed-off-by: Tamir Duberstein <tamird@kernel.org>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  tools/lib/bpf/ringbuf.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
> index b7adce37b519..1c24a83f59d5 100644
> --- a/tools/lib/bpf/ringbuf.c
> +++ b/tools/lib/bpf/ringbuf.c
> @@ -264,13 +264,13 @@ static int64_t ringbuf_process_ring(struct ring *r,=
 size_t n)
>  	if (n =3D=3D 0)
>  		return 0;
> =20
> -	cons_pos =3D smp_load_acquire(r->consumer_pos);
> +	cons_pos =3D __atomic_load_n(r->consumer_pos, __ATOMIC_ACQUIRE);
>  	do {
>  		got_new_data =3D false;
> -		prod_pos =3D smp_load_acquire(r->producer_pos);
> +		prod_pos =3D __atomic_load_n(r->producer_pos, __ATOMIC_ACQUIRE);
>  		while (cons_pos !=3D prod_pos) {
>  			len_ptr =3D r->data + (cons_pos & r->mask);
> -			len =3D smp_load_acquire(len_ptr);
> +			len =3D __atomic_load_n(len_ptr, __ATOMIC_ACQUIRE);
> =20
>  			/* sample not committed yet, bail out for now */
>  			if (len & BPF_RINGBUF_BUSY_BIT)
> @@ -284,14 +284,16 @@ static int64_t ringbuf_process_ring(struct ring *r,=
 size_t n)
>  				err =3D r->sample_cb(r->ctx, sample, len);
>  				if (err < 0) {
>  					/* update consumer pos and bail out */
> -					smp_store_release(r->consumer_pos,
> -							  cons_pos);
> +					__atomic_store_n(r->consumer_pos,
> +							 cons_pos,
> +							 __ATOMIC_RELEASE);
>  					return err;
>  				}
>  				cnt++;
>  			}
> =20
> -			smp_store_release(r->consumer_pos, cons_pos);
> +			__atomic_store_n(r->consumer_pos, cons_pos,
> +					 __ATOMIC_RELEASE);
> =20
>  			if (cnt >=3D n)
>  				goto done;
> @@ -406,8 +408,8 @@ struct ring *ring_buffer__ring(struct ring_buffer *rb=
, unsigned int idx)
> =20
>  unsigned long ring__consumer_pos(const struct ring *r)
>  {
> -	/* Synchronizes with smp_store_release() in ringbuf_process_ring(). */
> -	return smp_load_acquire(r->consumer_pos);
> +	/* Synchronizes with the release store in ringbuf_process_ring(). */
> +	return __atomic_load_n(r->consumer_pos, __ATOMIC_ACQUIRE);
>  }
> =20
>  unsigned long ring__producer_pos(const struct ring *r)
> @@ -415,7 +417,7 @@ unsigned long ring__producer_pos(const struct ring *r=
)
>  	/* Synchronizes with smp_store_release() in __bpf_ringbuf_reserve() in
>  	 * the kernel.
>  	 */
> -	return smp_load_acquire(r->producer_pos);
> +	return __atomic_load_n(r->producer_pos, __ATOMIC_ACQUIRE);
>  }
> =20
>  size_t ring__avail_data_size(const struct ring *r)

