Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1BE466B5E
	for <bpf@vger.kernel.org>; Mon, 29 Jun 2026 16:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782751099; cv=pass; b=ZCL2hq30B28+gj9V+Krhwm+oM6hzkPgv6yit+7x8bbh4R8QCC1y+Frva8FNZMwfQMvO+s9I10iV7UrtpfZKkEaZ1sjEMIKTo7nyhOp7aJkZPBRYlCLphattw2G/hEHDzW+nVr239BUCtA78kTcv0Roz0flxPTaA+hmfiP9rdjJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782751099; c=relaxed/simple;
	bh=gEaNQuxalrEbaejYXNUjXkTf07wYYe3nFnrB61R3T4E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MYojJPG7/IMEAncVNnWO6J8W0BmAJC0KoerLJ59uzrmuCpmVwVnYIbxLuW9aNhZ8bL1dDDNMJjMTiynwWrZLxt1TB3rZv1Ml6Irc2Yzd1CNr4Y+/VFY5EER2X19tcemoHPXAgsDhRnxpJgxz706qruXZTqeI8WoYsTgSmQXfIik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vnah7aXB; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vnah7aXB"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-664d910cc75so1283728d50.1
        for <bpf@vger.kernel.org>; Mon, 29 Jun 2026 09:38:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782751097; cv=none;
        d=google.com; s=arc-20260327;
        b=iROZbWlP3Q1e1QLRjd+30nDmKDhF8k8oPdQ+w55WQK9RwtMiMbtMR53a8sab/ZecX1
         EMKGMrgF/wi0tmQpWlo6GbaUT8NpcLffUCa+v+h2xajFiYT/nKic69ChVtKHmJj0hfTl
         c3XeTzJzpX/bHkygt1cOHlY6/AvgE4+5I/sg7GO5hfEXNcWUtak6gZNjX5YgOT8Z9QR+
         lepJhsL6IWCqzOZ08Vd/agvJU7m+8YNQcsyuTGsJHsEZm/MLZZVKp4eTAA2p94A2G67y
         74hNFJHXuId6BydJcyDN9U4vlm+OtuUOeWVb1q8bdyim6hwEi/SZtSoqGJcWuaxB0Qd5
         YlqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=haO4vZrpMtuqtlW+X89rpFuMlePW6Ji0BG7p7a0BoNY=;
        fh=9IP+r0+dU0hNDa/wMd1fRq+UJGaRo4+7w1wHjuC2pU4=;
        b=ax4VUh9b2rkgp3d2aaSQtieWT8va3kBeS/3+5+W+WdskExDGuNF1VjE1fvVU27lvsW
         wWi8Lz9/Rjj9NY/5y6w5Pt/RwcGMRLwrB3Pe1FjyH8uFUAdS0Tp9B6SsqEf7nQUbtFyZ
         kfar4FVCOkRYezaHc0Kf7MTeUQFvkQE27pNQt2QvtIAy624ZNvSi3g3rqUzFN0ICC/Xa
         unhu4CFxGwkhZJ3IXQeeJbMPcQNurgZdI3ped5PjtQzwH5MSNC14k4dc9d2yoiNE/wmL
         L+Qmne6RZBvVjM7R3+qTZnQ9HjM14dF3gTHbW31D1ycJ+rYGJ0ILJfgXOWJgD9SNSyXI
         jW/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782751097; x=1783355897; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=haO4vZrpMtuqtlW+X89rpFuMlePW6Ji0BG7p7a0BoNY=;
        b=Vnah7aXBQsEN+d7QydTxgNr5ByeHcR0FmX5TfiEkA1z6l+TGqq1aWzJTbCq9UbnDpB
         BgKXBclKsFM76dz8NRaCGGOPYgULxdltJ2ea8uqJRG4Z/FhIcBLWqQHRllqWsTv7VSG7
         e8/7GeSajdU2tGmad9dlyHDclvd+SqM/6QjxFlbqoCy0DIIDCKtY40CXYssJMg5NRmFd
         /fgzeF0tUV70dTPOAEE4RQgGiTTZMRRXw7EFeJK990Aoj3yJfBXrPJVe52+4pwgwnFVb
         gSFuUXZdM3U/L1Q0OIsqnM76jap0oWwNGh5JALDeAZQhGaBliWxGF9rtSR+Ytu2eQYd9
         qU5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782751097; x=1783355897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=haO4vZrpMtuqtlW+X89rpFuMlePW6Ji0BG7p7a0BoNY=;
        b=A7azvZ3y1NccMG98nI698mN7ZFDcZEhUPlyAoT5bNEJm4NczQeagu+TUdJLlBYr+xf
         RId7Qh13FtJvEVn+84SGGJtsBnRE9XkNsZE/w961MXAbO9LOaksEEmVCKC6ksj5Di4+3
         bcGojKUoLoApoPtStNpLnJuDcxsqO6Jr1mpE4zRVMwbBRKbZVO9p3EUIAhQaBywY8h7t
         37YtB8ybDRUlQk3yRG8rXgPDyGzxPcyHmYP+/TcQyFDIGZlIG0t0/molKNS5eVy2GvVV
         JAXzix/D6A8Djkc/94lwBAB0oVonjqEBMW+RGLvLxu6HwBCMb54bhfLF9zLjn/Mt25Sa
         KZjQ==
X-Forwarded-Encrypted: i=1; AHgh+RrMH4DWGpGVV64EPPDg+3nIPv99yuIFfX+g+Xyy8VDRSACAbDrrzkVww3h6WVhbilBhONk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz28jZ/JJMjyzugJB09pqmcWidXY4wRxmmo9g2WtCQtu5R+bWi4
	NQyrnZczDRG7OyBWMnld+BkdTwKzF86PBUL5ZlLX6MnswLfYt03rLxjHkPDyYZIfQZoe2u8OWoU
	N6RbWyumxefWBeq1pGDD0Mam3C+sFh6g=
X-Gm-Gg: AfdE7cnvK+WdjuiFotEY2R1XXfALKW1CSxsfE4dklFs9ATclBLoE91civZJos5inN3t
	XCEOF7YEPK8uufEGxyVEpMQQ7DEjJdjBQbccuYHYRa8TFI/PrZ5VZAi0P8wb2zvKE8e31QskpT+
	J5MeTPoq25tjoY4SRcFM1UnXOFf5UzFGtlwu+rRPvH1SbiFknHcDPFNFPVDJ4sl29mxwTJyB68X
	zsVxaqnCU3tBZRduHSZQCGIj0cw0iZxN3Cm/NTaWE/My1un6HMZcW9POomNQ3Op8HSxV/R4gg==
X-Received: by 2002:a05:690e:134c:b0:651:b86f:3657 with SMTP id
 956f58d0204a3-664f97b64a8mr475040d50.36.1782751097001; Mon, 29 Jun 2026
 09:38:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629154112.1164986-1-rhkrqnwk98@gmail.com>
In-Reply-To: <20260629154112.1164986-1-rhkrqnwk98@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 29 Jun 2026 09:38:05 -0700
X-Gm-Features: AVVi8CeIipXEtbZbSv-5oex_d1rzw4sFw-6Q7PYGKe29UI-pb6fsxIRxFlbWnYI
Message-ID: <CAMB2axNzh1bWG8Jz4Trp4UTcu29d1v8eqtukiGyZU9L+DHe3uQ@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: act_bpf: use rcu_dereference_bh() to read
 the filter
To: Sechang Lim <rhkrqnwk98@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Simon Horman <horms@kernel.org>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2026 at 8:54=E2=80=AFAM Sechang Lim <rhkrqnwk98@gmail.com> =
wrote:
>
> tcf_bpf_act() can run from the tc egress path, which holds only
> rcu_read_lock_bh(), but reads prog->filter with rcu_dereference() and
> trips lockdep:
>
>   WARNING: suspicious RCU usage
>   net/sched/act_bpf.c:47 suspicious rcu_dereference_check() usage!
>   1 lock held by syz.2.1588/12756:
>    #0: (rcu_read_lock_bh){....}-{1:3}, at: __dev_queue_xmit net/core/dev.=
c:4792
>    tcf_bpf_act+0x6ae/0x940 net/sched/act_bpf.c:47
>    tcf_classify+0x6e4/0x1080 net/sched/cls_api.c:1860
>    sch_handle_egress net/core/dev.c:4545 [inline]
>    __dev_queue_xmit+0x2185/0x2c00 net/core/dev.c:4808
>    packet_sendmsg+0x3dfa/0x5120 net/packet/af_packet.c:3114
>
> The other tc actions and cls_bpf already use rcu_dereference_bh() here.
> Do the same.
>
> Fixes: 1f211a1b929c ("net, sched: add clsact qdisc")
> Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>

Reviewed-by: Amery Hung <ameryhung@gmail.com>

> ---
>  net/sched/act_bpf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/sched/act_bpf.c b/net/sched/act_bpf.c
> index 58a074651176..09d46e195e33 100644
> --- a/net/sched/act_bpf.c
> +++ b/net/sched/act_bpf.c
> @@ -44,7 +44,7 @@ TC_INDIRECT_SCOPE int tcf_bpf_act(struct sk_buff *skb,
>         tcf_lastuse_update(&prog->tcf_tm);
>         bstats_update(this_cpu_ptr(prog->common.cpu_bstats), skb);
>
> -       filter =3D rcu_dereference(prog->filter);
> +       filter =3D rcu_dereference_bh(prog->filter);
>         if (at_ingress) {
>                 __skb_push(skb, skb->mac_len);
>                 filter_res =3D bpf_prog_run_data_pointers(filter, skb);
> --
> 2.43.0
>
>
