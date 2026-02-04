Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0515225A3B
	for <bpf@vger.kernel.org>; Wed,  4 Feb 2026 00:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770166630; cv=pass; b=aL4ygiOXt7r08GdtHWPSQ+JZDVDspdSI/nGxYqj1zR2MoJUgphXQt4CqQ+DA+FusyRKGUse9rN5p3zuVx80V0TzNlyBMrOJIv3yaykhBDU61PJh5HCgg2QfwgAXu8Cr1Ru/fnARde5U1LjGxfrtwjxBeNa7JsZY85Cmdkg275vQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770166630; c=relaxed/simple;
	bh=0i3qTIU75wOJD3Nb7FuzsXM48Oe9fM5MoLIAuXASkss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YwNftLLEeZsAWIEzB/3Rwt4f76k36TuoO2R0Q21Y4Rj9Rm7GDq9bhbkfKalRZOMziRttfWhrGRxk8MSouU8ziz/n740rBFkupKE4z0YskB9Ai2Fq8uJU9Q+/5DKplYGBVb2l91cvnH61JfBWWC8t8gLoW2mwqlyVnXMdYqj0UCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ey0auJhw; arc=pass smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ey0auJhw"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c635559e1c3so176214a12.0
        for <bpf@vger.kernel.org>; Tue, 03 Feb 2026 16:57:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770166628; cv=none;
        d=google.com; s=arc-20240605;
        b=YifM5ne++VTtfx7nGPi3JmbjkerXpgQZP418GRViAsj92iqzugwZljxtA8C7zqpQfI
         qMjm8yPvphABoO7hEVzCrECetSFAqn5zscxhkIPHu5z7tawHEt5uCjBq5reCQFavTFG/
         upE6YQC2eukp8BnglfLjsZbEtIn7uIQzMT8JArrOk4D/38+Kz64+JvshCFTeaVa2KTOQ
         4+hiOU6WNhjh1VviCVEw1YntuQpTckWOwGFqk5Ud8IgKG6udYZo60ebT6eWJCFq8h0in
         hSInD/6bs7WUrMMwWspl3E6+8asdLwdA0WQ40UM7sBudltridhOK0iOoB0B5sWANPAcS
         T/PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=I3NCHen8Zu40zcvlwTDWAV4ENkzz+uhuhaaHh/z65bA=;
        fh=F67QOCqalbsFVAGPSJigrtRkIsSjn/242asg//34fs0=;
        b=UNe0FQi3VHHdF0CFq/AZuBy1YFZ7xhu+BE9kNRyZXdRYa6zdo6lFLmRddkb01l9FR8
         yu02WxLTixCHHmvdKXAK1MidOCBaUE4zNdfR//obgnTjmuoBTG8cEFNoTWvi0oTcm796
         ojcjKiFyDJX6l/98hLH4e28tEzS3z12nHVJA9eM/MdtXu4YSlt3tpfA4ox1l/2S53imf
         EKD0qfVLuG6Oe9m8/KFFDbM3bEdsOIp2aKhRGaEzXQF/vJfvPM8JYMBKLsbOxtMJyRXQ
         YmE5KshqA/wq5LE4DCF6xUxyEOeCu4maAB2Euru6JiHqpZr7RrgCMNOB6cDepDa6FkTs
         8txA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770166628; x=1770771428; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I3NCHen8Zu40zcvlwTDWAV4ENkzz+uhuhaaHh/z65bA=;
        b=ey0auJhw767dk6/piHlzNQSoAl6egtHOrdghwtdm+IfsdSn2Q/g0q2gCxDPZTOsxMu
         3CDyUTwkJsaiasV/iLc4MDUCW0qQD+fCzl2xa4vQh0oG+CaNT6tkzeQnv9TzflR4Jxd4
         6hHsquPygjmKQRGJTqt0qPzcQzjmEnA+vsbUJ2hJrZst0RyRO/OJ9tIapPiJtYZlLlr1
         sq+NkvTDg8s0myydxBobVDvboGwKSThA6OBC6oV2iHpQvtYyOBnQD6VzVpgXMjtzUZNo
         a2QrfS0hf+teP+s9J3beBn0tv37+x00GOfQ0WrdCNEHzQjT5r10ecBSs+TuWiPkAnHzd
         uRtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770166628; x=1770771428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I3NCHen8Zu40zcvlwTDWAV4ENkzz+uhuhaaHh/z65bA=;
        b=M66REH+tTImsw/KqNd357p+oo49uM/V0A1srn5i04km8rBARYjU3AdfEkfoQla/7W4
         89soWtQW5DeUx9SOrC6S8Q2my8J3GGzI3rL0/xCp5Ewyhcabw2Q0KkQVFevcB/ypqNJA
         C4CQFMsDBHNICCyAoqO8hl6BSF1f4GKyV9Twm6rG6LNEL0W4vQUit2S3SXrIxk18hA+M
         OQkejBnk3bf6k8HtB+Ptli1Bs5PegAGfpoaOwqSjtY/P4YTMwiz7X/RrgL9WpXeXvzSu
         Dbqb1SLaoEPuXQs1vWbSLg7IBx+ycWik5LLsEkHRoYGy3o3cww94tQMwgS4l/niDbKih
         q5fw==
X-Gm-Message-State: AOJu0YzGU7o0kUwrorx5SZXZ1UdS24lHsZcMpk7btGXjQwp8K0SeoJvL
	0KmLHL5vpsRzsPmKyoPWysuQnE3PSeCgvLsReHdFi8lHWUTJ8reljE+1GdRHl4U8pEpYPGLRQJg
	Ytdd1vd2m82+j+iZApBqYY1KEpEoXZ6E=
X-Gm-Gg: AZuq6aK5mX13JWD6QEADTUjJB2nVIp9UotH0FUJXgJasW3BvFrwBx3bn4UZlbFqqMD0
	UK1lG/kTQopQKaytfUZ9p3vrnMygQAt6XmvGYthSCbmVGrJ9myXpBQYN1H6ZdSDgM9l2XKVuuug
	N0aPZNQSYsWfEJJ+4m3C1P4ZNSUw8sGbbLhTD/Y2WdwN5gR0VXluNo7F+84l8bWuFF5fund9/IG
	xtXgwkvwzcmRMCOqbZqCF06mouU0by6Dwi6Yoe1+6JKtRxSth6D3z/782yXSbpPsFQIkt3qk8W6
	sUcO3G602hF4WaP2akFCCw==
X-Received: by 2002:a17:90b:254c:b0:34e:6e7d:7e73 with SMTP id
 98e67ed59e1d1-354777ef744mr3875057a91.11.1770166628108; Tue, 03 Feb 2026
 16:57:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260201025403.66625-1-alexei.starovoitov@gmail.com>
 <20260201025403.66625-2-alexei.starovoitov@gmail.com> <CAEf4BzZxWzntugOkbPLC=yy9TZ4v1YVaALR25-rOqF6xezVW-w@mail.gmail.com>
 <CAADnVQ+c26Ff14vni7iqaZ71s3pw0AgABk81QSZ+5o4brBnoqg@mail.gmail.com> <CAEf4BzbNR1n6=t3m+gJdZPq8giEHim-FeFyFhya8n9ZszR09xA@mail.gmail.com>
In-Reply-To: <CAEf4BzbNR1n6=t3m+gJdZPq8giEHim-FeFyFhya8n9ZszR09xA@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 3 Feb 2026 16:56:56 -0800
X-Gm-Features: AZwV_QhWY6h4CDOejJjUm_QX661xrcQBkTZTnPWSFEgTxXHdeDWCg6UQqgZlPBc
Message-ID: <CAEf4BzZNXQ7V8jzq1SKYf0bANfmZjJHwz5ODZ8r6_S99Mx5TDg@mail.gmail.com>
Subject: Re: [PATCH v9 bpf-next 1/9] bpf: Enable bpf_timer and bpf_wq in any context
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 3, 2026 at 4:53=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Feb 3, 2026 at 4:32=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Tue, Feb 3, 2026 at 3:53=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Sat, Jan 31, 2026 at 6:54=E2=80=AFPM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > From: Alexei Starovoitov <ast@kernel.org>
> > > >
> > > > Refactor bpf_timer and bpf_wq to allow calling them from any contex=
t:
> > > > - add refcnt to bpf_async_cb
> > > > - map_delete_elem or map_free will drop refcnt to zero
> > > >   via bpf_async_cancel_and_free()
> > > > - once refcnt is zero timer/wq_start is not allowed to make sure
> > > >   that callback cannot rearm itself
> > > > - if in_hardirq defer to start/cancel operations to irq_work
> > > >
> > > > Co-developed-by: Mykyta Yatsenko <yatsenko@meta.com>
> > > > Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> > > > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > > > ---
> > > >  kernel/bpf/helpers.c | 408 ++++++++++++++++++++++++---------------=
----
> > > >  1 file changed, 225 insertions(+), 183 deletions(-)
> > > >
> > >
> > > [...]
> > >
> > > > @@ -1456,10 +1493,20 @@ BPF_CALL_3(bpf_timer_start, struct bpf_asyn=
c_kern *, timer, u64, nsecs, u64, fla
> > > >         if (flags & BPF_F_TIMER_CPU_PIN)
> > > >                 mode |=3D HRTIMER_MODE_PINNED;
> > > >
> > > > -       hrtimer_start(&t->timer, ns_to_ktime(nsecs), mode);
> > > > -out:
> > > > -       __bpf_spin_unlock_irqrestore(&timer->lock);
> > > > -       return ret;
> > > > +       /*
> > > > +        * bpf_async_cancel_and_free() could have dropped refcnt to=
 zero. In
> > > > +        * such case BPF progs are not allowed to arm the timer to =
prevent UAF.
> > > > +        */
> > > > +       if (!refcount_inc_not_zero(&t->cb.refcnt))
> > > > +               return -ENOENT;
> > > > +
> > > > +       if (!in_hardirq()) {
> > > > +               hrtimer_start(&t->timer, ns_to_ktime(nsecs), mode);
> > > > +               bpf_async_refcount_put(&t->cb);
> > >
> > > any reason not to use bpf_async_process_op(BPF_ASYNC_START) here? you
> > > are basically open-coding it here (same for bpf_wq_start). For
> > > bpf_timer_delete() you just call
> > > bpf_async_process_op(BPF_ASYNC_CANCEL), so it's inconsistent...
> >
> > I didn't want to obfuscate the call and to avoid tiny overhead
> > of switch (cb->type) which won't be optimized away by the compiler.
> >
> > bpf_async_process_op(BPF_ASYNC_CANCEL) is there right next
> > to bpf_async_schedule_op(BPF_ASYNC_CANCEL),
> > so I wanted to keep those two consistent.
>
> Same as for BPF_ASYNC_START, not sure what's different there. I still
> find it inconsistent with the synchronous bpf_timer_cancel(), but
> whatever, I'll apply as is.

ah, wait, that BPF_ASYNC_CANCEL I was talking about that's actually in
cancel_and_free (which is asynchronous), I keep getting confused by
that large block of removed lines and bpf_timer_delete in between.
Never mind!

>
> >
> > 3rd reason is in bpf_timer_cancel_async() kfunc that
> > calls hrtimer_try_to_cancel() directly to return the result.
> > See patch 3.
>
> yes, I noticed this one.
