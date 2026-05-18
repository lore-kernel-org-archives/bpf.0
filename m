Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DB8410D12
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 12:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779107801; cv=pass; b=D3y4CtwSEq53Jwx3Cwm0rWNyBQwop1OB7eNzMr1hU/7uEOZD5dJrRiBjxm3Kp+caZfUXSJkh9Di+tZ/ECLmeI39RqwTh3gvXAmTUnPCWcPSw1hkb+Wd53ow0ulUKLKFH1JYZvnqAWEgc2Znamsel5pvNK/dcqWVZxKyqtg0+B8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779107801; c=relaxed/simple;
	bh=UxFHQ8myRrvcKnyp2w/HbJak2/jS/38obKXyH8OshAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IIaruLHQeEauDe9aBSskK2bLoNpzBVE4TlilaH52/jLUCFx3bQjONl4tbwkF57VEJARH/LDoWyV+oLzeLsEUX/n0/qNYL9243aouN+2W1hSqtcNzo7dbCJBvkgD8cnPBqUgjvtXUfmF4lTvFijUY740iN86atsS8hKdaxY9Jmrk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D+U3xSLK; arc=pass smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+U3xSLK"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-39393c1b5aaso20771761fa.3
        for <bpf@vger.kernel.org>; Mon, 18 May 2026 05:36:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779107798; cv=none;
        d=google.com; s=arc-20240605;
        b=IA7qMxCvX8nm3j9192LoSqoox21RJZrLEzVAEW9vrfCG9wOLxuzde3iEONEES2YL8D
         /Pzw+xXbZS1Jk+CFcrlkzCnf6StiUiXKVfFJNOUwby47z/BgkC8lq69KHgoZz0aKdysS
         4WsMPl1hsJIUi+vRRE7faMbYRxwnzSkA7KgB/IJNk9qzUPrcL1PADN47CYMF4fDR5oRw
         5Vx7SX8C7ZTW9Q+U0YC8CnN33+0pCeIxEjmIi+rxw811TbaPBvcM0rfw8DagTGHHm3Yw
         xcMyv7dfcN6/KtrJRj4vwVvMKCNM8gnzZ34hvncO6AXYvXqmzibYghluVwq1W8pN1BBM
         4OxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LQLPiuOk6sV8kiLBT0hZDm0NkG6cxPfbECWJSraE7Lo=;
        fh=cTw8RuaeFjmHb6+Ze8UGmtjYQAGTIG87F9LXAYUmRj4=;
        b=L/TSWGJ6+EB6J+HN/Lo1LEo5gZ78P3l2WDxPIim87gLxbyBae3UTZ7/nQwL0vwkMOO
         MsHdH3MLC9msNz2casNZa8u+2ihXLOeoHJ6FGNxEQ7ZsHzdW249+7DuIFwqHjEd+IWJ5
         iMbXHIeCqRpO5E14zyzcV6QcXrdIrYmqZ570+lcB2UBN1VMZqui6SrGodNGh4Bo0RR+a
         fKXWjUuy/WEyPPr3Hq4Dd7zXgpp6K3EKm7/wMECwxShfnsFLa3T3Bp4KzCctmZikFQ5T
         7oEc+eSY5gSBKewbuPMBfviLUUJlmeNXCqftM7Ao8O+8SmZaALrzA9Bik7c4orHtepBi
         3fCw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779107798; x=1779712598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LQLPiuOk6sV8kiLBT0hZDm0NkG6cxPfbECWJSraE7Lo=;
        b=D+U3xSLKudhqxPnVvVdDuYrJSiOy1pbQoULBThY5Y9ZcyGjINGdi6w+9J61pKjyUoW
         i8amaWF7yS7vAJ7mi88CDKyMqFofr2MwiBYBzWIXe8x3EIlpngj2Ld3M8e8/8ZKQX5v1
         A04c3MQIEnK8Qp3OWt4tRpP4xkrMqIyY3n8uQHX70+11NxKFFjXea3rYddzMPrrM71jE
         yaH8yMEogH3/Stsv1isyZb8tYbu49YpwIv0ZxRL+6ICsMNGMX8lPhyawnyVgYRYDfNkn
         Kjdu6TLbogTiaCnEUg73OSpmgyATvkXYaQHwNT/xv321DeVgpxsv3n/1gmrOQGI5I7fI
         UdVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779107798; x=1779712598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LQLPiuOk6sV8kiLBT0hZDm0NkG6cxPfbECWJSraE7Lo=;
        b=lfTqlIv11pS1FryQRlm6CQVtH6/xiqYZsIOIuRMftI+sO6duTWcjA6ysCHehb1PzSe
         F/deuy4ebZbmcXf7Xn5GalHB0zwLjjPwlgBi6h0PP0JB6ZIJ41Tl0CW0zYP2X5Ed8y8E
         duyRbN/+X/Gi3L5szb4KEgej/t43qKhrnDXcHvRoZstl0Jnd5TE8vXNWrQJW639gf2Hr
         DKHfdyrQorTQ+JmQJkT5bCJk2EGXW1VcjHouzvnS5VGNyZg5HvR5U1xeH9ikmUeaKRmF
         QuATkEAS5cDCLdZ2FjUCdviA486YdzTUiedVE2fLrC6rEtJiZmoWvtqh6OVgj0NGv9dE
         94xQ==
X-Forwarded-Encrypted: i=1; AFNElJ+tTVNtLuuY24hg4koUpq1amNvfnXAhoyLr4FnzexdmAKxvP9QR73nlgUx4jtr14drOt68=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVRQkdjtZxVNvv7kwvmfVlGCfrsOUIth69/u+6Yokwgi1fZDE7
	TRYaWKBVzuXmuRIdwujE4gtsyBTzILmSDOyJV+CdCC/v3SK6YqcglVAlfzFDw6RQaNHAlhCRVhG
	mOKQn+Puevlo9sdfvjrqGSliGx8FBfxo=
X-Gm-Gg: Acq92OG+hGL2mXg1AzUHZZUsQ0DB7AW1tdCD6TWZaB8cuh2rChIZa7xOvXPuLwFbthW
	k7h5jNXlT+FZNB92+2bOAxpXvdCbLPK1t2LRrqkmRqfNy4lsbLoL1SL8DA2ErnHExCRHJSYpCuy
	VRAoOeUpcQEXcj3zlAoN+/bs62L4Im7Za8Da09vzmjlMl8P+K+n3IFj2Jx5/dFhWInyL0yi4wbW
	l9yIQ59q8Rchh45Yy1tZW/Z4juwS38QuIPxGwf7QFmru6UJZhRBsKIb3TMTXflBZn5n5Uu7iCc/
	YDfEUvRfLZ5ryIrRfofqS2ozXvv4RnQpq6VOPvS1GwGOTxlPdnQ=
X-Received: by 2002:a05:6512:3b8a:b0:5a8:5187:2e78 with SMTP id
 2adb3069b0e04-5aa0e60ce1fmr4598222e87.13.1779107797593; Mon, 18 May 2026
 05:36:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518082344.96647-1-kerneljasonxing@gmail.com>
 <20260518082344.96647-2-kerneljasonxing@gmail.com> <850e3709-2cb1-4a26-8546-745401423696@kernel.org>
In-Reply-To: <850e3709-2cb1-4a26-8546-745401423696@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 18 May 2026 20:35:59 +0800
X-Gm-Features: AVHnY4KuhWWWfQKXUCIMgTLWad_PQHq31BMxVWNlZDH5P1tGxWBXQynOnQmIOqM
Message-ID: <CAL+tcoBA0+Vspq37FtEURgM9A+Fk5MOPkhPvaq7OwP6SSpXfxg@mail.gmail.com>
Subject: Re: [PATCH net-next 1/6] bpf: Add bpf_ktime_get_real_ns() kfunc
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, willemb@google.com, kuniyu@google.com, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, sdf@fomichev.me, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, Jason Xing <kernelxing@tencent.com>, john.fastabend@gmail.com, 
	Simon Sundberg <Simon.Sundberg@kau.se>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 7:57=E2=80=AFPM Jesper Dangaard Brouer <hawk@kernel=
.org> wrote:
>
> On 18/05/2026 10.23, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Currently BPF programs can obtain timestamps via bpf_ktime_get_ns(),
> > which returns CLOCK_MONOTONIC time. However, the skb->tstamp field
> > populated by the network stack uses ktime_get_real() which is in the
> > CLOCK_REALTIME domain.
> >
> > In the series, kernel reports the software/hardware timestamps through
> > sockopt and then userspace bpf application gets them and calculate the
> > delta only through an unified time unit.
> >
> > However, prior to this, when a BPF program tries to measure RX packet
> > delay by comparing skb->tstamp with bpf_ktime_get_ns(), the result
> > is incorrect because the two clocks have different epochs.
> >
> > Introduce a new BPF kfunc bpf_ktime_get_real_ns() that returns the
> > current CLOCK_REALTIME time. This allows BPF programs to perform
> > accurate delay calculations without clock domain mismatch issue.
> >
>
> I support adding this helper, because have also hit this issue[1].
> Our ugly workaround is to use the TAI clock and adjust for the current
> TAI offset.

Right. Thanks :)

>
> [1] https://github.com/xdp-project/bpf-examples/tree/main/netstacklat

The tool is useful as long as we enable net_enable_timetamp(). Yes,
bpf/so timestamping is one of methods to do so.

Thanks,
Jason

>
> Cc Simon Sundberg <Simon.Sundberg@kau.se>
>
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >   kernel/bpf/helpers.c | 6 ++++++
> >   1 file changed, 6 insertions(+)
> >
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index 2bb60200c266..863645d096ef 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -2317,6 +2317,11 @@ void bpf_rb_root_free(const struct btf_field *fi=
eld, void *rb_root,
> >
> >   __bpf_kfunc_start_defs();
> >
> > +__bpf_kfunc u64 bpf_ktime_get_real_ns(void)
> > +{
> > +     return ktime_get_real_fast_ns();
> > +}
> > +
> >   /**
> >    * bpf_obj_new() - allocate an object described by program BTF
> >    * @local_type_id__k: type ID in program BTF
> > @@ -4859,6 +4864,7 @@ BTF_ID_FLAGS(func, bpf_task_work_schedule_resume,=
 KF_IMPLICIT_ARGS)
> >   BTF_ID_FLAGS(func, bpf_dynptr_from_file)
> >   BTF_ID_FLAGS(func, bpf_dynptr_file_discard)
> >   BTF_ID_FLAGS(func, bpf_timer_cancel_async)
> > +BTF_ID_FLAGS(func, bpf_ktime_get_real_ns)
> >   BTF_KFUNCS_END(common_btf_ids)
> >
> >   static const struct btf_kfunc_id_set common_kfunc_set =3D {
>
