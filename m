Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3681377EA5
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 17:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774890570; cv=pass; b=T+9BUNbN3VV0EuRLLKjPC5HkdHdPYi+sz7dQo1Fxvuevgh+rx/1aLryZnuM8a58lPQqPnhSllvAd+pF9WWAkQe9H4GF4dBdfpUlCxJrHpFBVXD13vo50fNiw8G193dLNN1qoKXae6CfvOoCIwfCYGC0x7Hv11OAAA76UaH0ZXmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774890570; c=relaxed/simple;
	bh=BFemXMudycvhy7VKBn3rfxUxF9xbuD2nUdXBvRpTrK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JuTYlTW2kqY5shoMKC8xifGO9UUnAcOX/yH/4U5iOMWsiiXLBjQPevyNQF3Xc8IDg3FJmisvyXkKfsaI8aN09WVa6vjxinxcIL7+HP8iiYbRcm3wHcOLTgkLdkQ+Yyqkx/bDvmuDOKcZyekQwGh6K631tr/FPHKWly7D+O6eRfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WRgTeNjs; arc=pass smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WRgTeNjs"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-486b96760easo52138975e9.2
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 10:09:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774890567; cv=none;
        d=google.com; s=arc-20240605;
        b=Od/HBTY4f9zxxnFCHYiTOJwPvxdNwaWhW6k5pLRNanOQUotm3Ca9d2mg9cUU1mbFzq
         RlZCXq6/RH4h1tSyt7TKZmnWBFY5paxMfN5VXD5aOUOCGejIbQcqLdkGCZXMhCU/Pt3P
         XkdDTGT7S+t+2MlXydkz61YhlZ7rvj4r1ttheLuMXsbbfsYvmz9qkWVH6KEC6Q50ftcl
         UP8+zKpuyNB+BxHWqiIqN7Bj/QYoutUpij3gBNSUasaw6GeVZNsKs15mBuw/wFqHnrqC
         ZQ3Aw4i1fhVKN58QlGCSF9FxhexJlxWKwpobVBiuabgBL3hk5DmUM5dHsyyLAfIyN8kL
         /IRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TwE8KztaklZBq9sKK33xBCWN9vot3XXFqQoYamj0MHI=;
        fh=vhAG/hEiesFwDPj8OSZUXnsb7iiJFswJjoIcLzjt0MQ=;
        b=lanOi8jMeH2Z7bSOf3Vi6clvvbjYmhc8+mseat/W8WbCwDmN2BJrJhFZxwDJnrSLJc
         WaHfdfqxELY/vFdA78k4+Ccvad9+VDVLigDKp4xs9/YJJy4pSmI18vGjh2EU3+HhIqSF
         UeFL9TNvtc0VyxvtiauiFmNlFZrS6YYdblOCza//A0RzoULVFt9vE7eVK2hB332JHb+m
         FRWaKgNdf8Cw9BPK0zCx+q0xVkAHoR06vF5sSCm2iaNfIHhF+qfZ6KbdN9mihMn/qHdj
         yivhV9PrhCyvT8Hr09bPm7pU8sbXFiU9/M4TDxpwuevkT0jotJqzYXFGdg+zFMucecN4
         9fNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774890567; x=1775495367; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TwE8KztaklZBq9sKK33xBCWN9vot3XXFqQoYamj0MHI=;
        b=WRgTeNjsAHA+8MVJfnLv+cHjD4elhOZdP8PrYIQUniLEdhi5H8TFpOcfTs3RD+32SG
         Bdnh1GGQdw160WSaSOtctRfUYm0SpiEykLHBEcAdR+4H19TxYp0VTvh+2ypiGVNSqmNY
         vX+XDoAnKFl2OVugaTYTkc6R221xn5asfqa6UQisFVtW4iyS3P2lZBEln2mrnoUmuBay
         fsQnRRKALyfbPDDcepxNf7t+HuJTJpc+Whsf879Jy8LdzoyUKLA9RWpnRNh15mQVN3zW
         XcoMhT97zSwIa2oe0bTTgjsuzliGsOQG4ovH24dNYo6tTkIiYO8J9VCAyH4bysGY3MrV
         2AxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774890567; x=1775495367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TwE8KztaklZBq9sKK33xBCWN9vot3XXFqQoYamj0MHI=;
        b=hCoBfF04UZO95iH46NQpepUMxeFuPBzAOp6ci3IgTm3Qyw+5MbhXnJreh/+NBctpSA
         ouY/xtjlDzczTGbf9l3F2szxeU9rA++rzwmiKq34dPEDhzFvmD+CLNMgIQ0cYvQfzjVf
         RiLWFlfK1GH+w9j7OKfoIoIsYzvXFBevM0bqooxVdwfehgJFcPchzLZh+7ok9eTfHrJZ
         up0kdm5/oiHmi1jcMKXlvxHN40h0z59/A0grYSPAios4bYUVvEh7vKGJYJBnuDtsw8/v
         8ygUfgXXWjXhlM0w3zp1O6cSIsbAUHt4WiSLpN3vI6A5d8Vt6pirb7/OQdWhfexYeY1j
         TEgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZHFdAGfAxtdXCFxtvSaafas0092tmdyUzNDeP2dbqO2kysCMMat6USN9I9WXThF5bG4o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1zmIS4otqdpkaWgumWLqOeA512r0fVPkPlOG19x125Ay4bZPF
	nzSqfy466weeAgC+8GZGKFAthRjQGw9/xvwFZ0s1STQ9XXa34YmhhLmqa9S+ytgobRcG23s/G3M
	K28HovJ89ww1CHAQgKKMHfwquigaFCgE=
X-Gm-Gg: ATEYQzwQzJbIaNm43yqx+gGTLEQqHvMjDb0vQMTFu2d8/0o/Slg3pXUY4YhCWE1BOoG
	m9k02ntVpSz3ZIatSaegGm9xfrbEZSTPp7c0sVrxEN+NzkdO7MWLlN+0v47bZxWpfxocf1biIcY
	j+be9TVYn3IlSjlmZlzekBmtyOr/sMkbPXKAlWT3ROtjxt/8H3Gfzfc0tEoEg2MjJKywKh1EIGy
	RFE0DJGQx7GIHMoMELA4tR78WYVsyPTKvjOzaPrKTgZ6s9Ak3hn1amjd6qJa4z6Pv/Un1s9ksIz
	Eftqdmo0Q21WhKBNb3RXBARQx37Byw6H5bpnjTCUG9liUofDI0AmfE5NsH/y5nM93f1hadeMNLL
	DSWv918QKEVzPOaolvK6su47aWQ==
X-Received: by 2002:a05:600c:64c3:b0:477:6d96:b3e5 with SMTP id
 5b1f17b1804b1-48727d59bb9mr221663405e9.7.1774890566910; Mon, 30 Mar 2026
 10:09:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326141718.17731-1-leon.hwang@linux.dev> <20260326141718.17731-2-leon.hwang@linux.dev>
 <CAPhsuW7vwp6pW5RntKC+Gbn5gTcVg3vsm6LVc-y2ssTeauZayA@mail.gmail.com>
 <d19336f5-5373-483e-81e4-326aa9c7801a@linux.dev> <CAPhsuW5LKnuZ=wReS+_VtGOs2sefd73a=WUCdaZPho99JBaqJw@mail.gmail.com>
In-Reply-To: <CAPhsuW5LKnuZ=wReS+_VtGOs2sefd73a=WUCdaZPho99JBaqJw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 30 Mar 2026 10:09:16 -0700
X-Gm-Features: AQROBzDRpUwtx2yU1MijSbP7LENp4KbHkTJu9H9iib-WKuc4m0vP_JzIrbkUgx8
Message-ID: <CAADnVQLVEoytOJT4kVAcnzKqEJk0AhGxPCK+tMTKwpK_DJ32sQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Fix abuse of kprobe_write_ctx via freplace
To: Song Liu <song@kernel.org>
Cc: Leon Hwang <leon.hwang@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Feng Yang <yangfeng@kylinos.cn>, 
	Toke Hoiland-Jorgensen <toke@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2026 at 9:44=E2=80=AFAM Song Liu <song@kernel.org> wrote:
>
> On Sun, Mar 29, 2026 at 10:38=E2=80=AFPM Leon Hwang <leon.hwang@linux.dev=
> wrote:
> >
> > On 28/3/26 05:39, Song Liu wrote:
> > > On Thu, Mar 26, 2026 at 7:17=E2=80=AFAM Leon Hwang <leon.hwang@linux.=
dev> wrote:
> > [...]
> > >> @@ -3733,6 +3733,11 @@ static int bpf_tracing_prog_attach(struct bpf=
_prog *prog,
> > >>                 tr =3D prog->aux->dst_trampoline;
> > >>                 tgt_prog =3D prog->aux->dst_prog;
> > >>         }
> > >> +       if (prog->type =3D=3D BPF_PROG_TYPE_EXT &&
> > >> +           prog->aux->kprobe_write_ctx !=3D tgt_prog->aux->kprobe_w=
rite_ctx) {
> > >> +               err =3D -EINVAL;
> > >> +               goto out_unlock;
> > >> +       }
> > >
> > > This also blocks uprobe+freplace when prog and tgt_prog have differen=
t
> > > kprobe_write_ctx, right? Is this the expected behavior?
> > >
> >
> > Intuitively, yes, this also blocks uprobe+freplace.
> >
> > However, how can we distinguish uprobe/kprobe here?
> >
> > At attach time, uprobe/kprobe is recognized by the target perf event
> > flags instead of BPF prog's expected_attach_type. Thus, we cannot infer
> > the use of prog by prog itself.
>
> Maybe we should introduce an attach type BPF_TRACE_UPROBE in a
> backward compatible way:
> - expected_attach_type =3D 0, it could be either kprobe or uprobe.
> - expected_attach_type =3D BPF_TRACE_UPROBE, it must be an uprobe.
>
> With this flag, we can allow uprobe+freplace when the user space sets
> BPF_TRACE_UPROBE properly. WDYT?

New uapi just to fix a narrow bug? Not a good tradeoff.
