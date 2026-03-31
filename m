Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF5631714F
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 16:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774975457; cv=pass; b=SWyaCveLfG7NI9ZFLDmh2BsfhHxAdp5cDjDPhIlAyRd60nPSnDrNLYy7hFV7O1fqTfTzAY2J+MAdJXIySkcPkwjP5kq4l7NMYNMBeoF3zLQ2vVWK+AI+aZhPd8SSk78TmbcKd7p9WVipkcZAoPYFH0rxLY/rUNxEHnVXEImVhUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774975457; c=relaxed/simple;
	bh=ltBDgRFacxBRou1eKvg76+HSeAEoZdE6n4vIYVTg10c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YxzejB2d+tceS2aasWV5Ev54UVo9xRWFP465eDRaB3aHXf0uyj8freNGEHW6THLi3WNZZbwnkQsTNlP8K92DSOZVkGdznTf7Ld6+BNFtS2/PkNp3OiYkqeyDydpUkz3VVGWMFzDyyfaZioqfziVfUkRaLhrLboZdmaJtrLh0pQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=abbUNpHz; arc=pass smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="abbUNpHz"
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-43cfbd17589so2569228f8f.0
        for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 09:44:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774975454; cv=none;
        d=google.com; s=arc-20240605;
        b=BrZi+lMXMiyfyszNE101xZX5US6s+d5J0hs52f2F4e+VnQsW2J4pdx6ayQx/7HObJI
         ytUHS7r81yidKSL7NN+RdvtoHXiz5ZerO33CMNnn1oB9zqhcWdLzfFCRsRhvj7ukjnRG
         7dym1skc5rpy5kHXpIklFr8KkBG+B/C334y/hvmfYLEcer4gIq8QMvH0yt5i5ZGLrIsn
         NNhalfjaEcm9HrEfvZhN3AR0xY2g/2r5tc3f+aEeQXBhbJotsd0MSspLTxmCR5ezOpQ2
         Bz3qXDDYTw31fBBoAS/pFZ8Wj7QzmzZPRWxlvo+O2Wvg9G4SpTEjz/bcQGsx2rLEZ7W2
         81GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tKpq1PwlxkS+Kiofv5/jMfXrD5ec4T7YUgeyKP9XuCc=;
        fh=4ddQ53xfGaqY60AR+Tgktx3IzGbQ7VXha4SwKAIOI4o=;
        b=Tr/3dU6IVQDJ0k1cN8gXHyp/w7BSa+JzWakLPnAAQkuPbZql/zPnTLcSjaxlOo/SUa
         YBQQgEnHRw3Iqrmc4M0Gga0QsTfieyPGyvwDhxCKBoRY7indbeSMWmguRuOlz6muTsSZ
         g3Vv5+cqUJu868fC28VOsT2RQF5tJOn72pSBaPYnEQ11FZdNk7JZ8GZXzUA9VC2/mhTG
         qvanG8ZVuJ7k8gfvLceYku+UR+YGdxhjmfqjDAWPL/4ypSBUZwE7qU+Em0OVkEOcar6B
         SPb/nQS++8i43qakO2yhE4bPKU90nIrjrYgAGuVfHY9z4u1pnM9qrmqga2O3izDCl5wp
         BIUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774975454; x=1775580254; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tKpq1PwlxkS+Kiofv5/jMfXrD5ec4T7YUgeyKP9XuCc=;
        b=abbUNpHzgor5sO1Bf3ucXTVEGw/t1b9Jsmg8jo5GgzCAFYza5Iz5a06IQlSfv/ktqo
         lB5iEjVkF66TNZmz7+28PzuLo+dpzZcvJbTEVNgJHTkteoyAhHdlKHfjY3ZYSO8Acbvl
         V1TB+hyNVRkn/3VyvowjgXsQO9sROuHK5yQoScxe9zwkKiG55wJeFo2LZokI+GsXQ0KS
         qOut30jMun9rutj7JLmX1gjDg+kJFZDeszLyr9z68H1VYbw7ooW41o/U9uWcV4WOeA4Y
         NSdGBeiPmCJwabFkX4urC+5GARY9o7t88oW4kcpbX6tqx3/kLykE9dI0g4RkLCXupFMz
         +6nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774975454; x=1775580254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tKpq1PwlxkS+Kiofv5/jMfXrD5ec4T7YUgeyKP9XuCc=;
        b=WcG2ODUMnaMGSBogw8BApHb8t2oioAUKL7zXaVx+mssKPDkJMRLeK4lYUkeQmr4oFA
         Wer7tc+KcWJYmaasLoCios6CF7Oz1aGxry0gMYllxP004IzAzoLrPZGnMa8obcDmxRO/
         jWA9d1hTdAo4wEdIsOLdT6dig9t07XJ1PoSiKefBQs/Kd7z7MDvcQpklNJ+Jip7/4AvM
         sJlLUSY3DN9ZjMrMNGspnv5kDpXZ0dTH2G3lDhE8FHyvj4iDP3idzaTZamRYItLxgmDO
         6/WF/sYQsonak4HP9F1aBY04e8GodiwXatmpS7M/QjwMRjj8AK7It6bpmVL4d/VqeNj0
         gdng==
X-Forwarded-Encrypted: i=1; AJvYcCVlvQj++oUBRR2U0AQZW5tJlkjKi3hyo89w12nBVNvbqzibtUrwIpmHlRSFJ33qp9UocuU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT4US+9Xw9didEi6l6nUPHnfcACSJMVDdEymeSh66f7Kvb+Le+
	MQRxiOzgQIgEEpf1HGlVxOWVA3eC+F1AQoGYdud9pEdPY3szTpAzNKx0ioZPu1F33BZ0VyKx43B
	unJ970+pdBpEl5T6uxrF8F5XTy7lABVY=
X-Gm-Gg: ATEYQzyyzAHiEhmTuTFFOnE9Dcfqmglu04C4tpg/igTj5zgarMz2vuK4NFPsr5+M4g+
	5lnQ7/gzlAutPnX9WxFz86hG8Z/XjkEhuejdh857e+K06fTZXxf2s7/oeXh5BfgdZtNLn0qfJh1
	JjRBZzJYDHDhzvfV7pqYDRLpLHXoye/Rcl9Hv02PIi5tuJgc2FuYIizaBXgEAQrqANIujtCm/sp
	lI5uaqDLQf39k6B0kkNYgPxiiuLab+V2f6jkB4QTkEg34UfDUBXdSxhmc4JIBxm2A9lLpoZuU2K
	GefHafLGlL1MN5mnAz4ziEuwWb5/1cEZ69HG5gzmH3C2rABrjfhSycvNwpp91HNvVQgU9XA=
X-Received: by 2002:a05:6000:240b:b0:43d:262:c97b with SMTP id
 ffacd0b85a97d-43d150f76c6mr554770f8f.41.1774975454129; Tue, 31 Mar 2026
 09:44:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331005215.2813492-1-memxor@gmail.com> <20260331005215.2813492-2-memxor@gmail.com>
 <CAADnVQKP3bmuDP2NzKYhU776RFVuN4fOs3y-kyQ8AFzsoK3_2A@mail.gmail.com>
 <20260331120329.7126fe6a@gandalf.local.home> <CAADnVQLjsJCyPBXdEy5A0r_es8wyDJVFXJh+PNU2dMVUMD0DJA@mail.gmail.com>
 <20260331122727.7283e589@gandalf.local.home> <CAADnVQ+d6zfXFtQ+7eiPSkrxWhh8srk_X+Cuf9=Y4D1+fHTF9w@mail.gmail.com>
In-Reply-To: <CAADnVQ+d6zfXFtQ+7eiPSkrxWhh8srk_X+Cuf9=Y4D1+fHTF9w@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 31 Mar 2026 18:43:37 +0200
X-Gm-Features: AQROBzDbOrR7k2ahLH2swdSoIR7-OgNqdTGVQRRUyCreA2xrJNR_eQL_tctIwFw
Message-ID: <CAP01T74Hs4zcOjhpzPrzn2A8JGjJe5yMMFkXBOdG2XefY40-LQ@mail.gmail.com>
Subject: Re: [PATCH bpf v3 1/1] bpf: Fix grace period wait for tracepoint bpf_link
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, bpf <bpf@vger.kernel.org>, 
	Puranjay Mohan <puranjay@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, kkd@meta.com, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 31 Mar 2026 at 18:36, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Mar 31, 2026 at 9:26=E2=80=AFAM Steven Rostedt <rostedt@goodmis.o=
rg> wrote:
> >
> > On Tue, 31 Mar 2026 09:04:33 -0700
> > Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> >
> > > > I don't want "srcu" involved in the API. That's the internal workin=
gs and
> > > > who knows, it may change in the future (like it did going from RCU =
to SRCU).
> > >
> > > so? When it changes we can rename it to.
> > > I don't think "srcu" part of the name leaking anything.
> >
> > I prefer to have a API describe what it's doing and not "how" it's doin=
g it.
> >
> > We can have:
> >
> >   call_tracepoint_unregister_atomic(...)
> >
> > and
> >
> >   call_tracepoint_unregister_syscall()
> >
> > The "atomic" describes tracepoints that can be used in atomic sections,
> > where as "syscall" means the tracepoint are safer for syscall context o=
nly
> > (faulting, etc).
>
> These two names work for me.

Just to confirm, do we want to add
call_tracepoint_unregister_syscall() without any users?
