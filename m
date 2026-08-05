Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88B43D171C
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 04:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785905759; cv=none; b=TjOe85dFIbm5xFC0SRVk4l2N37alJFx2Cn82AGAqE5IZkZqihVMqmWOv400rPr5kld1zKDuNnxa1CvZnJMW5d5Id+S1cC6ARo4X1BHezbjQGTDNdD9zakcClwlULAGJ/XzxD6P7Olhsy64whZi7C2MZHScebHTeqX/VTg/s4R6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785905759; c=relaxed/simple;
	bh=b0YH6pvRwiAvN3yxM37bKA6M1cV6qZFoggdUeafskKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eNS93E1SQtefHpAR6cFgu4YyyBNouDrKz4vmQJjsWKLC1yI2anREbvI1S86hltcHnF9SgWhUTHr0i9FoyAIFVNzsXq+BgqpG6/NaQnN/CG0wn0RO4yScht04lWrJZNDZkfsMVLCERFQVtaUd9s49oj7lp1UteR3hOPtGGZiiP/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dPuAh5Mn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dPuAh5Mn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B0E51F01559
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 04:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785905757;
	bh=b2kJQ3ntbJLDPSeBnJVqL9eNqq7vUJIxb35CDOYvzbQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=dPuAh5MnfdhRCFik/BpXHFBLNMhbaX/KQ+EN6duaMdv5bAV6S6geGeUkZC2YsdSgo
	 GGxKxjkk8PHQIQnJ53Ki8dX9QSyUpUFaUYmxT6WfG3WrREH6qH0zH7Oh89r+Y3XigO
	 NtsYGv9UYIGtPCkAyFLIlbEPWmBIYLGEOz1OOWQ5h6N8BUA5RtHPMLQU2RTDy4LvOK
	 NgDUZNEgq2XMfcEjtN3JucGTjaBFj34klyiTdL8NVPSODTcUtasU2FCE4MrAwNaBL/
	 rlR8Xc0Tix7BqcL+2HomVXkp/LZTkSpmI7+MaU6pFz2kE4mpTKg8bgu3u2t5xJcKWY
	 5nag75zvJMB+A==
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-930f72317a6so34549085a.3
        for <bpf@vger.kernel.org>; Tue, 04 Aug 2026 21:55:57 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz7FnvneaSpkvgROKg/P/d+4BxRniXw1BJ4Q/pXSfeCb6U7AAjy
	LsOqsSkiUAZ7qIEOANImsmwP3BRc5xF6fwRa5ymCd7QZJjTCVxOX7d7qROe8s8qzsruHAa6Ilh1
	ujuEHi47KdFKZwrFUR1JlzHYW17VcagU=
X-Received: by 2002:a05:620a:44c6:b0:934:9271:d0fd with SMTP id
 af79cd13be357-936492d1468mr353064285a.45.1785905756329; Tue, 04 Aug 2026
 21:55:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804164652.296919-1-mahe.tardy@gmail.com> <20260804164652.296919-3-mahe.tardy@gmail.com>
In-Reply-To: <20260804164652.296919-3-mahe.tardy@gmail.com>
From: Song Liu <song@kernel.org>
Date: Tue, 4 Aug 2026 21:55:44 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7=6Wy31ZKqUiwOOPJA7-39y_DtJXBO8BFj+OUfgnzRWg@mail.gmail.com>
X-Gm-Features: AUfX_mxZPZwyQ5LYjTTEbxs-6NKGPTD1OdEiu65ivfGpTddbDXpiybJ0MFYmZb8
Message-ID: <CAPhsuW7=6Wy31ZKqUiwOOPJA7-39y_DtJXBO8BFj+OUfgnzRWg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/5] bpf: Add ksock kfuncs
To: Mahe Tardy <mahe.tardy@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, andrew+netdev@lunn.ch, andrii@kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com, 
	edumazet@google.com, john.fastabend@gmail.com, kuba@kernel.org, 
	liamwisehart@meta.com, martin.lau@linux.dev, pabeni@redhat.com, 
	netdev@vger.kernel.org, sdf.kernel@gmail.com, ameryhung@gmail.com, 
	kuniyu@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 9:47=E2=80=AFAM Mahe Tardy <mahe.tardy@gmail.com> wr=
ote:
[...]
> +__bpf_kfunc int bpf_ksock_send(struct bpf_ksock *ks, const void *data,
> +                              u32 data__sz)
> +{
> +       struct msghdr msg =3D {
> +               .msg_flags =3D MSG_DONTWAIT,
> +       };
> +       struct kvec iov =3D {
> +               .iov_base =3D (void *)data,
> +               .iov_len =3D data__sz,
> +       };
> +       int ret;
> +
> +       if (!bpf_ksock_has_user_task_context())
> +               return -EOPNOTSUPP;
> +
> +       /* Early check for UDP. Exact limits enforced by kernel_sendmsg()=
. */
> +       if (data__sz > IP_MAX_MTU)
> +               return -EMSGSIZE;
> +
> +       if (current->in_bpf_ksock_send)
> +               return -EBUSY;

Returning EBUSY is not ideal. Can we avoid recursion by disallowing
calling bpf_ksock_send from certain hooks? You can find examples
check_kfunc_call() or check_special_kfunc(). This probably means
we need to grow special_kfunc_list, which is not ideal.

@Kumar, do you have strong objection that we grow special_kfunc_list
for this use case?

Thanks,
Song


> +
> +       current->in_bpf_ksock_send =3D true;
> +       ret =3D kernel_sendmsg(ks->sock, &msg, &iov, 1, data__sz);
> +       current->in_bpf_ksock_send =3D false;
> +
> +       return ret;
> +}
> +
> +__bpf_kfunc_end_defs();
