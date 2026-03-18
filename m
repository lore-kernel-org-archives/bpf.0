Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2819D36F438
	for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 20:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773867326; cv=pass; b=Ompcl72HhkbTmgZs8Bq8r7aJ7396WYh2yS1LHR5BDvv6iACxGEs0gvmI57alFMuta9pMw77frcsHDdX+hx7OuCv56z8/Cgi2k6sho7h9//EovkzY+DHm7HjxOnzdiXOEmtUSlMyDB0ANDWDCeTwpEqlDMmodcSFLa8cY4TAncug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773867326; c=relaxed/simple;
	bh=0J3SkYkL8InsjHVxmNLBnTxY8cGVPE4s4gsacj7fW+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EQBbTO8JDqudi+8EJX84lE77AxO0tnAPfxl6lsEFP4Fiz4lToEODWdrW7jZHECXqioyN6ATL43OSBwI8QfZ0TnPlbb4wZ5237+wGy9h1p6zU7vgQp382d2YlugifwUopti+QTrK+GHj4RZ1k93r41mD65Csj8gpuoKtf6Q2Yl7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j8LJKVM7; arc=pass smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8LJKVM7"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48539d21b76so2170165e9.1
        for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 13:55:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773867323; cv=none;
        d=google.com; s=arc-20240605;
        b=kgeYV8sH0Sk03ERYudGPIz/eaS1giwPxcuR/lkAfVflLH/KhqR/br47L9rCLnojnNR
         vpM+w7vEp3LLR9QWctI5YFV/BGO+th+xkJXQzgnRLGX0Vec/WV+8LpSWyDbkTvrmpc5w
         h2DWimGcfwryZFsJv0MrYUGiZmXQV4qw0JFMlSBAOL5IP7xPhTQxwy14QQ2bDpvgZE76
         zmCJP1TfztvoJJ5PN9BG60SaYXfMLn5uyB9mPlJC3nDHm6eoPp+3hPsr/mPALbiSilza
         fkxVvoEutxCRJBJw/qlu5x89tZ+4F3XuwMFCF0CFQ6/NWpQU7ClM+VlECib7qezf1v49
         HAcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0J3SkYkL8InsjHVxmNLBnTxY8cGVPE4s4gsacj7fW+Y=;
        fh=QKPEgaeCO8R7EPKmb5lNrOA0ODqH5Aak7C8A145Nyps=;
        b=X8mvXFRwHRIt9dH3iu5uwDrOufcNf9j6KsApk9RUwUuhxlIFHuM4cL+UcSGBo4Ogdt
         yLACzl83QgFvQL+seT32Yt3RfbBJkXKFUCVG3PZSEyZNtVWCsFu7YxsxexXeCqAVNKj0
         QG0FlRx3hXJsACC5PMnimm/BR+bQi1Z9XKW5+sxII+ccSSQtXIzAXDTjYUgRpnDLRPo1
         0kiPGEM0oT8BPv5/hIUgdSVboKnXIbLnIV8MMEjaeApMA875EcGck4ueWi1OMk0VxR1r
         G15TUTg+RMbEGFDeQQDh05OF55db+wgmpjkEODgSkR4UolC7VFMMV/BJBluvhMz6AVN6
         geuw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773867323; x=1774472123; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0J3SkYkL8InsjHVxmNLBnTxY8cGVPE4s4gsacj7fW+Y=;
        b=j8LJKVM7f+xyj0bLAmUHN3o6UGd5S76QQBs1GbDzIh3gzq7u3wNKaijkLom30QqaRa
         t8bzygh40P/SS2d3EYc63SL3W7yYcLbgEHTRFNPcnQ7/KcKonBguxs8ru8Yy2QAfk4Le
         GwNbvNbOMrk+qbkIKadQMr9dQIIAAF/vhqQQOZ+SHQztR1Ubl9VnKWbiUKNVQqxnwUkR
         bSblbLaZ24hT0toaeSW9sWgStYF7mjaI2u9+933c/fdnSQGjBHI7Uw2wK/Vk73L3HL40
         Dv2QT25gY18aDrNu26ZyHOBp/aoc8wf9CT7bdRJxIq416XysNt07Gk4r60GO9jViz0Sl
         hyTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773867323; x=1774472123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0J3SkYkL8InsjHVxmNLBnTxY8cGVPE4s4gsacj7fW+Y=;
        b=E1i2F/9bJTJxcb/FClKYlN/vuoQ0a88S6GSVTW/0HKyr2/pjUTX9eUC9XgV7vM8I5n
         jZEn0uWk7jipkGpyCxw9HM6AYHxcjZjh+5DUPoh+N28do3Y2R++ezg5LCOeZTbJrMJIY
         nSZlTGf9MCX8BWRAqATXSfgR7krjC1AAJ0M5pJNVxZ/ExedxkoBwNKg41weYSlH+EvVz
         pUC/cwJLtA+TrI5d4G+yiLmIhwpBxxiHgGxJK1zIEN68ruN3jPeWgQrlO9y/dGscFxix
         zNUoAwm1SCSQ4zrb6IC5eFFuopmIspf0COiMDLFddcMEzUO2xTJcc0t2OcvJ9TjexSz2
         TBPA==
X-Forwarded-Encrypted: i=1; AJvYcCWB0Yl2I/cn5wDA38FjZp0XIe8SxWq8nLPoYA7rcoIm6ggNl1ETmjELhZtURlZJWK7yb6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbisXob3MIwg6jAOsmiuyqLC9WPF9D54oJ9y34jeHoS3bDvojR
	FmSqOivxJ6iY+widVTGL179nnkym0eh34w4pA2dPjyb60uwRuWebi/7B3n9Jas7aVvYLtqn5Ixc
	rJ9D+8QiiVWhGr+YkMwoveav/hcGcgVs=
X-Gm-Gg: ATEYQzze639kwyRZX/vxpFbX3fd3068euoccY5Ql++WzVLS7OmpiGzXY8fY3zbcKGcb
	f0u9rMYLiKz6N03D3/htzZ/pFlR/2bGLIdbSSXhFGrDEANYRjNW/zQaBLCFV7Ag1pTJCdkhDLN/
	c4UmWWeGuVOlQpm2/ulQLd5LBA5iHqlC+kYOmKXlnlTGgkQDB/3l91a2COfPY3dVeNzRgSusfN7
	Uig+QperVfDFjhljP5yHqwnQgvNeVVMnxcUodVG2lP3SwPwqRCoHtEK14rKjykVzFWJbaX/3xkR
	8Th7CDljHZguqsmgTH+LWpE+vskOJjFOzypdy2WALtAoUF5ZtVdt5Iwb4rlmqyQoB75Y+5hc7Se
	4MKWBG17KK3AAl56aTm0Cf8jsqz8BeOI48gTb
X-Received: by 2002:a05:6000:2204:b0:439:b62d:be86 with SMTP id
 ffacd0b85a97d-43b527d2d87mr8541610f8f.47.1773867323192; Wed, 18 Mar 2026
 13:55:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311-bpf-auditd-send-message-v1-0-10a62db5c92f@cloudflare.com>
 <CAP01T77VyW=5SHDvM3HXPNHaxRdzs8H__MOh2zx1dQ6STeAUtg@mail.gmail.com>
 <CAADnVQJCJaLjGCwjCX9VtT615c4kn7v5bxviUmGFVj=uTtUHMg@mail.gmail.com> <abrlvEjQKUdAOcw5@CMGLRV3>
In-Reply-To: <abrlvEjQKUdAOcw5@CMGLRV3>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 18 Mar 2026 13:55:12 -0700
X-Gm-Features: AaiRm51tc55ib07MZtLJnTRuXxmrfDK1FJuMhF5fp5fXwEvfz5MooV7eUnvCNQI
Message-ID: <CAADnVQ+hNWY2Xd85xHySLN1gJD2paxPne3fAzeXx=De9tA5JNQ@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 0/4] audit: Expose audit subsystem to BPF LSM
 programs via BPF kfuncs
To: Frederick Lawler <fred@cloudflare.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Eric Paris <eparis@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	LKML <linux-kernel@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, audit@vger.kernel.org, 
	bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026 at 10:49=E2=80=AFAM Frederick Lawler <fred@cloudflare.=
com> wrote:
>
> Hi Alexei,
>
> On Tue, Mar 17, 2026 at 06:15:59PM -0700, Alexei Starovoitov wrote:
> > On Mon, Mar 16, 2026 at 7:44=E2=80=AFPM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> > >
> > > On Wed, 11 Mar 2026 at 22:31, Frederick Lawler <fred@cloudflare.com> =
wrote:
> > > >
> > > > The motivation behind the change is to give BPF LSM developers the
> > > > ability to report accesses via the audit subsystem much like how LS=
Ms
> > > > operate today.
> >
> > Sure, but bpf lsm-s don't need to follow such conventions.
> > audit is nothing but a message passing from kernel to user space
> > and done in a very inefficient way by wrapping strings into skb/netlink=
.
> > bpf progs can do this message passing already via various ways:
> > perfbuf, ringbuf, streams.
> > Teach your user space to consume one of them.
>
> Audit provides additional functionality by keeping messages close to the
> syscall, and in-line with other messages for that syscall. Aside from
> that, BPF is arguably too flexible. I'm sure it's already understood,
> but the idea here is to reduce bespoke logging implementations and reduce
> attack surface for violation reporting. Audit is already provided by the
> kernel and a well leveraged pipeline.

Sorry, I don't buy any of these arguments.
Nack.
