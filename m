Received: from mail-wr2-f1.google.com (mail-wr2-f1.google.com [74.125.225.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D37363096
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 17:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786036954; cv=none; b=RY5KsdIDlFJLkNPxYJZsLdaN52kWPSJoAU6umskJ+IEoYVPcP0zB1+Mbn7TDXztF28zHuBP1wfgnmQOLUF3JFkorUMXVixBO9dTDTtljcy7K66wJk+qknivskqJRgqXJYn2pdt3+UDR+x9hPJCcRduzz8E/k15lkM6qUDJhcbOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786036954; c=relaxed/simple;
	bh=BnpdqNEUC/D9iCxeB45j6sHjT70Y9PrfHsmHsEPugcc=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=Vmwu2/vIsUqvNHaMQkLSZg+knvlHvbAK+tKxLg6RgdMowyEGgqZqwTc7v5yZB91AWcosBDjPI3+9hcygHtCaYegDtcN+VwQelnZP2SHBt2Hzn916TXjEbW6KJDlKlxO4UaBG7/Tq1jv6f+f6u/wibOB7YVbxg1ECJN0SXDo2v0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qRJ/AyOD; arc=none smtp.client-ip=74.125.225.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qRJ/AyOD"
Received: by mail-wr2-f1.google.com with SMTP id ffacd0b85a97d-47fe3f552f0so774649f8f.0
        for <bpf@vger.kernel.org>; Thu, 06 Aug 2026 10:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786036951; x=1786641751; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Xibh2USspb2uQVdp3Y2UuRURhPWg8PcBBoTV8f9Gm0I=;
        b=qRJ/AyOD3M6nD8ZvpGUC0Uf4jlBK5xqsIV0X37SPlQKLkWG3AeAY5rrl/cKvdHAevU
         JHZVo/SMnSZi0HJIsK0uK8SXEZEjUmwX5brIAohj/V2LwwwZLiMuopRhlMMfqlfOT8zZ
         R9E66ZR/t/6o2u58ff5ZHa7FE2R/tfQg6A36uNy0isyFJndWRB4rPpKh4g2URdpSqNNI
         UvmVPKpC+VCNIKvlUaM6/SvTaEKugOdk0INftMZp1weEsP/65wMkEHEWqVZofp7V2bba
         1DMcJB9k+//qvCa/sXF5opNoNpS6mNcYyZZ3ekES+p5lyZjeV/bqY213fgGc8q0v/3Ii
         ej4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786036951; x=1786641751;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Xibh2USspb2uQVdp3Y2UuRURhPWg8PcBBoTV8f9Gm0I=;
        b=bZ9pcldwNJxLpt/Kh8riEvL80e/jbIBlpQohFJWbJk29fDKNr4jcMa8AKlDvgaO0Ss
         i1+2UyNet+/hWDxchPMclC1Sds/yWSDQ4qsECPMBmT314OBYOF3Fyb75MlZX6QogInHc
         4Yg7+q6DyQ8AmwCCUpt6EHW1HjjCX3xZiQbMtuy1ZbZVBVT7Abz+AgUZfB02lvgWNiia
         SEhkz+mMZ89O2XtXmcmSF3hRQyyvRv3HHAmHMKPyEGaT9HaDYWa9yq1elxZ8yFQ6vYbH
         rch2eQXH0+96wxdrZrpOnF20Y5xt428LJ3NZNmzOVPdzsIeN86r/6qFs0JYTZqahJATm
         Oenw==
X-Gm-Message-State: AOJu0YzaTb/77SSOlZeHNgOwupY701m88c86BQNmsaxAisBMj+LGQXqW
	UFGhjlpaggCTxBbSdb21w+XDYgEqkUO9TEcvfqJiu3zb1IcQq6/eC6wC
X-Gm-Gg: AR+sD10uK65JAG1SzoijSQEmBZrB6fhikJnpHv5a84pmpC+Ss9/mUaWi/lA36CkQbzc
	WOIQIS7adnMdn4tBUdE6vWNeQI6/ONeIJ6AZwABr4M58VZzRI91pXdnJPlvNIvVvFVOWT3PjmiS
	5AVDDn6rJQTDIxpYtWi2PkFCfWJ1FrwE4Lt7OJY8GDXdknhQnAba45qZrz2vqPJoY1M5fGC5NWz
	ad17gnUFMmCWfrPoA0CSJe75k96PZgYepOOKvzipwE+WjpqTdJdFewWYjyxFfnusEXRvJxzdGnZ
	zAjYBkd8hGB2K/Rios2+T4/kMR4WM58O/LD/3nnFv/WJqHxXYKB5ZCG8eD+cIpu4KDI+oy5g8wT
	8OxnJ/MH7Q3nbYWzW+tKRbL0fT7mgIV1BZF4Zzd9qxKZHzNWmLdZPMwWBCrUeIMhcx58SR2CkLf
	rdtlik3uzfTks8pSAoKK/3wxWqSH0jDrJKL2aIv22d7C1gCzYz9+WL/hAlDg46hxstnzsKIipEo
	OVcRyhihm4/lR8ebdzWcxU1Lcdsxhs9jlEYS5jjyK5bBAjaIayYHz4qkXfjxBqgN3Ljly9lxDaQ
	EE8AudYeDhOei607iRpt6uR0uzAbtEsRliQhTw==
X-Received: by 2002:a05:6000:290a:b0:47f:9283:1fb3 with SMTP id ffacd0b85a97d-47fec478c10mr26653297f8f.0.1786036950638;
        Thu, 06 Aug 2026 10:22:30 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47ff7b32487sm7353025f8f.34.2026.08.06.10.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 10:22:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 06 Aug 2026 19:22:29 +0200
Message-Id: <DKI19BJDCMA0.2MURYUXG6LTXD@gmail.com>
To: "Mahe Tardy" <mahe.tardy@gmail.com>, "Song Liu" <song@kernel.org>
Cc: <bpf@vger.kernel.org>, <andrew+netdev@lunn.ch>, <andrii@kernel.org>,
 <ast@kernel.org>, <daniel@iogearbox.net>, <davem@davemloft.net>,
 <eddyz87@gmail.com>, <edumazet@google.com>, <john.fastabend@gmail.com>,
 <kuba@kernel.org>, <liamwisehart@meta.com>, <martin.lau@linux.dev>,
 <pabeni@redhat.com>, <netdev@vger.kernel.org>, <sdf.kernel@gmail.com>,
 <ameryhung@gmail.com>, <kuniyu@google.com>
Subject: Re: [PATCH bpf-next v3 2/5] bpf: Add ksock kfuncs
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260804164652.296919-1-mahe.tardy@gmail.com>
 <20260804164652.296919-3-mahe.tardy@gmail.com>
 <CAPhsuW7=6Wy31ZKqUiwOOPJA7-39y_DtJXBO8BFj+OUfgnzRWg@mail.gmail.com>
 <anTCmv1esr3CWfSf@gmail.com>
In-Reply-To: <anTCmv1esr3CWfSf@gmail.com>

On Thu Aug 6, 2026 at 7:21 PM CEST, Mahe Tardy wrote:
> On Tue, Aug 04, 2026 at 09:55:44PM -0700, Song Liu wrote:
>> On Tue, Aug 4, 2026 at 9:47=E2=80=AFAM Mahe Tardy <mahe.tardy@gmail.com>=
 wrote:
>> [...]
>> > +__bpf_kfunc int bpf_ksock_send(struct bpf_ksock *ks, const void *data=
,
>> > +                              u32 data__sz)
>> > +{
>> > +       struct msghdr msg =3D {
>> > +               .msg_flags =3D MSG_DONTWAIT,
>> > +       };
>> > +       struct kvec iov =3D {
>> > +               .iov_base =3D (void *)data,
>> > +               .iov_len =3D data__sz,
>> > +       };
>> > +       int ret;
>> > +
>> > +       if (!bpf_ksock_has_user_task_context())
>> > +               return -EOPNOTSUPP;
>> > +
>> > +       /* Early check for UDP. Exact limits enforced by kernel_sendms=
g(). */
>> > +       if (data__sz > IP_MAX_MTU)
>> > +               return -EMSGSIZE;
>> > +
>> > +       if (current->in_bpf_ksock_send)
>> > +               return -EBUSY;
>>
>> Returning EBUSY is not ideal. Can we avoid recursion by disallowing
>> calling bpf_ksock_send from certain hooks? You can find examples
>> check_kfunc_call() or check_special_kfunc(). This probably means
>> we need to grow special_kfunc_list, which is not ideal.
>
> This is actually a really nice feedback. I didn't know we could add a
> filter per attach BTF ID. This resolves the issue that the send kfunc
> calls security_socket_sendmsg so we can remove all the recursion
> protection and struggles, it's rejected at verifier time.
>
> The filter now looks like this, I'd send this in the next version:
>
> BTF_ID_LIST_SINGLE(bpf_lsm_socket_sendmsg_id, func, bpf_lsm_socket_sendms=
g)
>
> static int bpf_ksock_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_=
id)
> {
> 	if (!btf_id_set8_contains(&ksock_kfunc_btf_ids, kfunc_id))
> 		return 0;
>
> 	if (prog->type =3D=3D BPF_PROG_TYPE_SYSCALL)
> 		return 0;
>
> 	if (prog->type =3D=3D BPF_PROG_TYPE_LSM &&
> 	    prog->aux->attach_btf_id !=3D bpf_lsm_socket_sendmsg_id[0])
> 		return 0;
>
> 	return -EACCES;
> }
>
> I don't think I need to touch anything else. I'll adjust the tests
> according to this. Thanks Song.
>

Yep, using a kfunc filter should be enough.

>>
>> @Kumar, do you have strong objection that we grow special_kfunc_list
>> for this use case?
>>
>> Thanks,
>> Song
>>
>>
>> > +
>> > +       current->in_bpf_ksock_send =3D true;
>> > +       ret =3D kernel_sendmsg(ks->sock, &msg, &iov, 1, data__sz);
>> > +       current->in_bpf_ksock_send =3D false;
>> > +
>> > +       return ret;
>> > +}
>> > +
>> > +__bpf_kfunc_end_defs();

