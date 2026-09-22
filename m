Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AAD514776
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 07:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790062209; cv=none; b=Llu851rfMYlrTCAhkfzRUz7jm8Tqd7BAO1jX0M+x9mRDF0KWJvj82AVSzEx8g+TRmsFlOCcd7frUdDUsRLOiG8xdAIm4RWvWfBdZEqeFKh9O1bcgOO7oxel4bvHnb6+t5jkrB7Up9Qs3uKMAdVaAT26++/Oc0eBkRf78jb1lL1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790062209; c=relaxed/simple;
	bh=e0wwLm6GVdk/4eLZWaOk+hFka1eOw+pZRQeFcIo+OLM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mi/d6LdmY1ZRqYc7d5YBmSfpZM9BJctr8F95ZeQOH55SpaS72OW9kJXWWRrw43EUzxIj7DhZ0G0cWjm2IUnFs3vrwu6zTX1v88GxTYsWPfSZ3Ubgt9o5q1ZxuavAYBM9q6CmK6RVW1syeTIZOK7FhdJLhIkN+2td3n+c9ulVBbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=CVtscwdR; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="CVtscwdR"
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68M38xc62317724
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 00:30:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=bP6Zss+aaOzHcwIebwVFpv7fhWLwx4mxZ4iL6
	pHj1yI=; b=CVtscwdRVu42P7exdoDACeAH+rmFb0al9rSK6TZQ/LQ+cC5xZkshn
	ZshkvQmIvUJMocGI2D2yWKFvV0X8sUuoJVIzh7mjflnxlT8P1H+88kJZ4Oet9kw0
	Vi4Nz/n1mgqyWvPrJ+qiRTiQYHXYnZ5wjapj7jn9eId1MMgBYT2gicVbAizeAwHg
	KAXUKhkuIbj0soMN4ihhCfmWNFQQ5dX46Cjorz7yitVzRbXlA0KG1+SELucLoiRX
	jCZ+1IekPpH1Cy/yYvZu9OYhB4Rbi7vniAmPegu38mNDVa1GDIyzwzeoCp7bhlnK
	fkKfSQVlHik2Dk7yNfP5b9MyHhq1kd3RQ==
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4gsr4cb9ax-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 00:30:05 -0700 (PDT)
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4839fa33eb2so87735f8f.1
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 00:30:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790062204; x=1790667004;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CUwnAJCHxe3FXOwxQjHfEXhUqFJyKsr1HhIR5z/gcsk=;
        b=iuuJ6v1WbMu5IpuUDGDbisj957kBCCjLGjaKJG0xs/3d49vqdoT4N7gnrhrmeTDdtK
         GANfzO4EiMyDK8DRru/zNZUHKR3wdTP+BiW4WrIfucCQR7JVDlRvqLey2BmczV8ZmVvx
         ASysO/xy7wOgKsSqhh6n1Q1LmJh50eeT94cv7dW0cslS1RmJOYsMTmOU8q5CqCcHTIqR
         U5sO/LwEQ/M0OBxzOc9sFfWf8oZUKGyQOTyqzSsOwe1XNb7R1Ij4TVWiDrpCU2X42/K9
         11BDoOXLKXBEVLphMbZRcBJoxSn1UFiKO6YqyL80E1NF25LV1XgJ3CKMaTYvDWsCllu3
         PCyA==
X-Forwarded-Encrypted: i=1; AKwUvByxVYlogqBqPOotyCJBtvDnW6vBm64wSa8Ay4GzZBIP03rt73bHV+tZLrJNq9ZvqTH7Prk=@vger.kernel.org
X-Gm-Message-State: AFuF++nNbcT83QAH7paehlrJK5FWA8S5XO7DEy1hcfQKekXs7Q0XG/c5
	KRSWLQRpBZSQ/SGAULLUBFiaPjnKMSdzLBJpElfOBm/FZ3p+60y4UVNQ8BrZK0PLITGm7Cj5GMc
	2IY+FTENd0o4OLhVIcwtwuf1Jz+pBAyipuU3WXgfOQxreoZfYX3M1
X-Gm-Gg: AYBFou3o5yLj9s6u1aE336NUjjUE8F+0CVrFcjdb+WqgkJTSmMSzwIBevB9qy0b8wsi
	PrGxdhJNMjcB5djfMhx8l5ZYUptHrTkYO2zf2dSVHUewODiaGkn4+IgaCPgM169uyPzEe6Z6J+v
	CgU+T8W7ZkIlJ4vJusYI5BJyU75i6jVps7CRKN9bq+UKUkvT8x5uUyjUp3Hyx3Vf/3iidqE2wgJ
	tJM5CocKokgHg+HKz4ltgyet3ivg03+R4xJmMWmY61Xu62fya85Ij6Ya4vq5uOeIf8WkmHjNd1E
	QvrEiink/ZnoWvgr4uunIApRfTZfybOnKX/PI0NUVQXXKEOomy4l6k/KArNaQA6w7xBF4AEwdUT
	y+Ls26gUQSPYHksquXzGQDENwwWpRQ1oJepuCa50=
X-Received: by 2002:a05:6000:4010:b0:487:981:4e07 with SMTP id ffacd0b85a97d-4871fa86624mr17627947f8f.4.1790062203859;
        Tue, 22 Sep 2026 00:30:03 -0700 (PDT)
X-Received: by 2002:a05:6000:4010:b0:487:981:4e07 with SMTP id ffacd0b85a97d-4871fa86624mr17627909f8f.4.1790062203407;
        Tue, 22 Sep 2026 00:30:03 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e17:9700:3f7b:7276:a343:d339? ([2a01:e0a:e17:9700:3f7b:7276:a343:d339])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48862731429sm2278905f8f.5.2026.09.22.00.30.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 00:30:02 -0700 (PDT)
Message-ID: <f7f9f76e-5046-497f-adc1-8700701318d5@meta.com>
Date: Tue, 22 Sep 2026 09:29:58 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 6/7] bpf: tcp: Add kfunc to adjust
 sk->sk_rcvlowat.
To: Kuniyuki Iwashima <kuniyu@google.com>,
        Alexei Starovoitov
 <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
 <martin.lau@linux.dev>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>,
        Eric Dumazet <edumazet@google.com>,
        Neal Cardwell <ncardwell@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Tenzin Ukyab <ukyab@berkeley.edu>,
        Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org
References: <20260920195633.3033620-1-kuniyu@google.com>
 <20260920195633.3033620-7-kuniyu@google.com>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@meta.com>
In-Reply-To: <20260920195633.3033620-7-kuniyu@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: ldA8CYy06sdVQUAi8jYjRjQv6s-b_kIg
X-Authority-Analysis: v=2.4 cv=SKnXx+vH c=1 sm=1 tr=0 ts=6ab22e7d cx=c_pps
 a=I6ewnrIBtnKHmb6SxpX7Vg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=xtH7KyWI9dI7BmFOsl-x:22 a=1XWaLZrsAAAA:8
 a=VabnemYjAAAA:8 a=sLGjIoZK2OyoYNR-nVkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=MqNruPmfsT8GavliLQMe:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDEwNiBTYWx0ZWRfX7KM4eCadjlnE
 DoqvLQEa+Z7M0pDLeAWl9MYKpthOvppxDg2uo/XsCMqJNoAwKxMRHt25yhta1AakPVtkTc1r5FH
 D2aoC1gOtC7qK32F8Onq53w6c3ZtO8k=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDEwNiBTYWx0ZWRfX0ByzgFouTrP7
 Hrfe9mnaYINenmLMyA7pHGgU4fe1uMItTdYawkJjZyEDwVL3eYlier2rrOR/wyWhdSMvEuMwj6U
 PiiP4fBqoN0ZcjM2Dbv6iUjQxYWzeTGMOYN7BQypDP136zSWSDvwoF8qEwSEwfqMbhmwOVRpRNN
 +PpxyIOC+vylESI17yfytCBP9Qh/KlAUg9pC7SlZ/GyCO3MXWi0yJs1dR0V4soOEIS7RQ/3qXct
 n095d59gxvZY2xFkOBN8331yq7uJywSwAGV22GytdKiSxb0uP5S8jkYg0nx3dzq/clNgNwhOz/D
 hBbR2qPf97Ie2AGz+HBKeDtVFRyVDX0cMDFjefSjlL9mN/piAIHomQJdw0RLGjiD03WykwxEnFb
 CFvClkCQYiYDbLvvG0SzFisOwacP3l718RbfT97zU7fLgrU9dgisP1he0Tm8wlQ5Xrp69jnZDqk
 uOYmWraGPr+KnxVEYiw==
X-Proofpoint-GUID: ldA8CYy06sdVQUAi8jYjRjQv6s-b_kIg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_07,2026-09-21_02,2025-10-01_01

On 9/20/26 21:56, Kuniyuki Iwashima wrote:
> >=20
> bpf_tcp_ops.{enqueue,dequeue}_rcvq() were added to parse skb and
> adjust sk->sk_rcvlowat dynamically to suppress unnecessary wakeups.
>=20
> Let's add a new kfunc to set sk->sk_rcvlowat.
>=20
> Negative values are clamped to INT_MAX, consistent with SO_RCVLOWAT.
>=20
> For enqueue_rcvq(), wakeup is set to false because:
>=20
>    * tcp_data_ready() is always called after the hooks in
>      tcp_queue_rcv() and tcp_ofo_queue().
>=20
>    * when tcp_fastopen_add_skb() is called for TFO SYN, the socket is
>      not yet accept()ed, and when called for TFO SYN+ACK, the socket
>      is woken up by sk->sk_state_change() anyway.
>=20
> For dequeue_rcvq(), wakeup is set to true because tcp_data_ready()
> is not called in that path.
>=20
> An alternative would be to support bpf_setsockopt() for these
> hooks.
>=20
> However, that approach involves excessive conditionals and an
> unnecessary memcpy(), costs we do not want to pay for every skb
> in the TCP fast path.
>=20
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
>   net/ipv4/bpf_tcp_ops.c | 56 +++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 55 insertions(+), 1 deletion(-)
>=20
> diff --git a/net/ipv4/bpf_tcp_ops.c b/net/ipv4/bpf_tcp_ops.c
> index b0e14b54917e..3768b1440eb7 100644
> --- a/net/ipv4/bpf_tcp_ops.c
> +++ b/net/ipv4/bpf_tcp_ops.c
> @@ -359,8 +359,62 @@ static struct bpf_struct_ops bpf_tcp_ops =3D {
>   	.owner =3D THIS_MODULE,
>   };
>  =20
> +__bpf_kfunc_start_defs();
> +
> +__bpf_kfunc int bpf_tcp_ops_set_rcvlowat(struct sock *sk, int rcvlowat,
> +					 const struct bpf_prog_aux *aux)
> +{
> +	u32 moff =3D aux->attach_st_ops_member_off;
> +	bool wakeup =3D false;
> +
> +	if (moff =3D=3D offsetof(struct bpf_tcp_ops, dequeue_rcvq))
> +		wakeup =3D true;
> +
> +	if (rcvlowat < 0)
> +		rcvlowat =3D INT_MAX;
> +
> +	return __tcp_set_rcvlowat(sk, rcvlowat, wakeup);
> +}
> +
> +__bpf_kfunc_end_defs();
> +
> +BTF_KFUNCS_START(bpf_tcp_ops_rcvlowat_kfunc_set)
> +BTF_ID_FLAGS(func, bpf_tcp_ops_set_rcvlowat, KF_IMPLICIT_ARGS)
> +BTF_KFUNCS_END(bpf_tcp_ops_rcvlowat_kfunc_set)
> +
> +static int bpf_tcp_ops_rcvlowat_kfunc_filter(const struct bpf_prog *prog,
> +					     u32 kfunc_id)
> +{
> +	u32 moff;
> +
> +	if (!btf_id_set8_contains(&bpf_tcp_ops_rcvlowat_kfunc_set, kfunc_id))
> +		return 0;
> +
> +	if (prog->aux->st_ops !=3D &bpf_tcp_ops)
> +		return -EACCES;
> +
> +	moff =3D prog->aux->attach_st_ops_member_off;
> +	if (moff !=3D offsetof(struct bpf_tcp_ops, enqueue_rcvq) &&
> +	    moff !=3D offsetof(struct bpf_tcp_ops, dequeue_rcvq))
> +		return -EACCES;
> +
> +	return 0;
> +}
> +
> +static const struct btf_kfunc_id_set bpf_tcp_ops_rcvlowat_kfunc_id_set =
=3D {
> +	.owner =3D THIS_MODULE,
> +	.set =3D &bpf_tcp_ops_rcvlowat_kfunc_set,
> +	.filter =3D bpf_tcp_ops_rcvlowat_kfunc_filter,
> +};
> +
>   static int __init __bpf_tcp_ops_init(void)
>   {
> -	return register_bpf_struct_ops(&bpf_tcp_ops, bpf_tcp_ops);
> +	int ret;
> +
> +	ret =3D register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
> +					&bpf_tcp_ops_rcvlowat_kfunc_id_set);
> +	ret =3D ret ?: register_bpf_struct_ops(&bpf_tcp_ops, bpf_tcp_ops);
> +
> +	return ret;
>   }
>   late_initcall(__bpf_tcp_ops_init);

Hi Kuniyuki,

Tested-by: Cl=C3=A9ment L=C3=A9ger <cleger@meta.com>

Thanks,

Cl=C3=A9ment
