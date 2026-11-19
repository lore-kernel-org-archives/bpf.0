Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795111176;
	b=iEViwXiHd2aA93tLcu7XUkiDNMPZFfELfbWvAkvtjRNg8od+RrC4mYYw+UkzlQPxIYtq
	 0yLQgWUDni/aZkW3jZ9WREMkNdqde+aiSRyLrXSPe/c7E/XuqJE9/rsAzAFhh1w9gaWJa
	 cPHkvnoezwcYYobQpvJgVxuMBao0Sqs40S1nsPp8DZcgslDbRfEYwrpp5/d5tX7vRELRx
	 a7CCMYj0MyWHenS+qHpPfjnJkSCmOAe1K8U7UZK1xIPviVz85X0WUyLPcBeGprMrtR/ko
	 r9Nbbv/r9iOAaxozQ88RcU6cej/i8nJMqBGuWrbY8+97nLOsa/wvIMAPqh5oRKMWmtQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795111176;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ZgscMLiDCOadJrkoKP6gtckWa0KBy7jbuT5m663Neug=;
	b=x9uDKafns96YfLcXWxtqdFdwxR13x32Ny4Oowk3mqJHRqpRD2WgWnWA/9Z7alOg0Qsy8
	 gXq5aaXQM+oo/0CMQAOAvc+fbsdpUjGI6R1MsE+7bmPT+wxYEloO7MByyQlsGJw91WYrx
	 uXFPuEO6nqMO0+KTKDV9vDkq3CmSmEo8eNPgxonHeZssq+gXJflo/1kvJv9icGbmHsq0p
	 J/HHCjA/26Ns3txP+F9sXik//wJNVLSXtWkhtC/DhBHWjz0K5XkOA9ccumQ8vBh+fLTSH
	 95gF/4srf1qel50XLh+oaPC1rg0EwlGR7ve208kZaJ408Bxb+YGmTPTs1nTCUNp/nFw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gks4Fbnt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E325606C045
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 17:59:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E325606C045
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gks4Fbnt
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-49412eb1474so1646869f8f.3
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 09:59:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795111175; cv=none;
        d=google.com; s=arc-20260327;
        b=evs78Geb1jvw7HqKEd7eOx1Q1/37otT20Uxkwv7Gh9iIjrxJ6gPOPJXFROZUW7qjbW
         F+kd1mp62+9YnyY9OB2mX5uALfAYZ1RQcbp2Qy6is4T/QvyK1lT+37t49oS3tqD0/MVh
         8TXIl7MSH5LIo+jKiv3vVImhCDyndoWPsrmWv90afO3hCy94ldxJQBB3B+tyKQo40lL+
         KbTvRDwJbT3PEjStbSsHR1pazezGLqw8D1BK/3tX5j3lrrUATDhMvHU2KjdaqBc2T8Ts
         fiwL9HX4yDbGA8764Pz8LOiLCQFzBbpx2tTWPWihkUjfEHQlWdIEuN+DzlaQlzTwuiLM
         iHpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZgscMLiDCOadJrkoKP6gtckWa0KBy7jbuT5m663Neug=;
        fh=2dP5YEuOpU3lhNKpso4tyT8npP9GVO3MWQtt8DZ1Nss=;
        b=nHOkUck+2m+LrHQ1nTvEPOBJgllc88bm0lBMMt/X+4yCf2Sv6+mo6tOtJ1aVGr3hyU
         RG2G9y88F4BV823I0iRbmhshaiXrIuBw9X5lMs82WGvA/QixXIPZduQF0RUUqO8wdQIA
         L/HJ8QD+AFxd6c5m/ik4Y6H8kwP/6NGdyKc3gAjnXC+5pNMTWlQ41qAIDj99O34uZyXT
         P5GaQ++h7raMkZCiFHOTj/qKMRZamM+14b7EAuDHhI6d0HLQIhCZczzgz6ObbpJhVBwe
         eSPaFMu27+yzsTZuZvMuqJKH0/5H9ho73Ra0BRIWeitNOa28btPM9pYruKCCUZsZAUoa
         a8qA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795111175; x=1795715975; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZgscMLiDCOadJrkoKP6gtckWa0KBy7jbuT5m663Neug=;
        b=gks4FbntYhBepMkUAWOCVysyoFVCB3MxTbmyA6XQTxARUjb3+KntQakgQGz9jazu38
         5P9vRaQ5F5ArZZSBoE20WjOdCInkmX+/USedyvOg4j9sIczowVMQYD/APJv1NSH3nOXq
         1pjP8nftNohrYfWdxD1hwfczb6n5zVqQt23SYEghm3+vNETJHOIe++s2pZA5IA4F0MnV
         UwHCBTc8p55S4igq32dqbiex8ONzUvRJqAAtrXgVSrErdOTxcdYlIk4+v1RZkqY8ONa2
         2wvwEE8rn2ztEOEjF4SlG9b7Ef+ckWaZNIbrsbBspEzu41XJGRkVNirO1ZWfAQkPLX/9
         2HKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795111175; x=1795715975;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZgscMLiDCOadJrkoKP6gtckWa0KBy7jbuT5m663Neug=;
        b=tsyNI18QWc5cLZmddX15oMnmbJ99LTJebPHZbLUKVZHXTXy1124oRMpy/oSCdID/y1
         jk6dMjn8RQBF+/fmU3TAjeX3Aj3/xv8RUVWnawXUSeqqUNjnRDoT8Bp8IKsDZdbzaCkQ
         NCDklEo01RH0Rv0q4dvisxj/SvdqSY/dXVuZ/H2uBctGlsCGWNeh2oZc0zAY3l//X8qS
         636WSUeYFmkM5J/ZSB0Q5pBA3/6/1wMCcP2gUHPVPKNdzVfrjJzvxgRSQoh3eeLPk2Hy
         0PhtpH5kVJXcjc6YN7wcnp8US1JcV/1UyLkvLOt6ilIiSr121rjBgo4T5lCa3IPSMV9c
         1x6Q==
X-Forwarded-Encrypted: i=1; AL+hErFAf80N3LdPGCdmYcbqnYV1XJowgjokInVddusQM6GD4RiCfT1ojnMPuZT3MBiL7twzIAo=@vger.kernel.org
X-Gm-Message-State: APuU4Z8FaTAWCEEg+GR2CJcpE+Rs7njjC15qMlP0SiFZbvMZrZszvOmw
	fqKia0GMQa7j/SOVvxpyU1ihSgM4Z578eY6KuQJRAuYua8Ux+v3QX0GuPa5+XzVjpzmbQXOblkH
	S8XcfH2DZqGFRm7WmVgLgE1zcxspMzQo=
X-Gm-Gg: AZFdTZcMj/jVvjaHcyF+yhmZG0VkZa9IzXpKLd2CfBD0/TEsgyRdoTboj+Dg6GC3eD7
	6HqQlK0r3n4VSeKWg7v2xiXRRlgJm0GR+Jo+rO4VEF0XGKieESlF+LNf7zZNkCL7aUuXmUD07It
	BJHIVVeABHPxxNGLQTh/oNg80n+z3JK7McfadyyZ+y6OrX+uz2ujbGSxhoL7ImI+nv7fvDos//Y
	iYGAfCHg4tkZLRYUqJ5oK5gI1atLQwqIh22QNLtS4Wfu1xnKrK6dagzH81vsa9+/F1NBz8CyaTb
	YDdnio8uti3JGRtPv4kkhp52MrXZcvnMcyq6BsQK+GBpBFGjVVHgnm6gMIEI2zdfJKZrrZ3BL8l
	qzNSuccUBgvFCuGArXvX78MlWWKq6DKlbn6JnIb4oWnoc0hMSZPThXDif9eREnMjkgw+A8HFhQr
	dv6fKw3A4NfXYyP0AWx1kHO4wNn7CookjVVg==
X-Received: by 2002:a05:6000:460e:b0:4a7:790c:4a34 with SMTP id
 ffacd0b85a97d-4abb3b42a90mr312581f8f.20.1795111174618; Thu, 19 Nov 2026
 09:59:34 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <d85ece6e-27f9-4d9f-83af-4101bc76fef6@app.fastmail.com>
 <356db94e-f5d6-4fb2-839a-b97aef72256b@app.fastmail.com> <CAHC9VhR9sjunJRnM9gy-BkBZkapQTrr8a8FtmaK7JkAmUqTrLA@mail.gmail.com>
 <CAEf4BzZKmn6g0SK8OddjKFj_vAmZFvpZv32Hs_S+GHgT7VNfrg@mail.gmail.com>
 <9d6bdc31-e57c-4187-be78-29d82471f710@app.fastmail.com> <9695ec3d-7b81-488d-989f-0bd411d673f2@linux.dev>
 <CAPa8sAh6b5xn4rZzPfM0nZ+_kkywWj22fy8deLq+6qYews0rdQ@mail.gmail.com> <MRYP264MB7057096D13282544720793F2E67A2@MRYP264MB7057.FRAP264.PROD.OUTLOOK.COM>
In-Reply-To: <MRYP264MB7057096D13282544720793F2E67A2@MRYP264MB7057.FRAP264.PROD.OUTLOOK.COM>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 19 Nov 2026 09:59:22 -0800
X-Gm-Features: Aa3M54rI23MKqBWHsKCyo3oqXGgxsyN6jYM1v0m1--b9Se0lLJrl3D4bMloAJWc
Message-ID: <CAEf4BzZWEU24+ZC0W_20hc3t+qnEHncQA1ztTF7ZPPOf3DDPVA@mail.gmail.com>
Subject: Re: [BUG] bpf, lsm: new first argument in 7.4 inode hooks silently
 breaks BPF LSMs
To: Paul Mabileau <paul.mabileau@harfanglab.fr>, Paul Moore <paul@paul-moore.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: Daan De Meyer <daan@amutable.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	roblabla <linux@roblab.la>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 18, 2026 at 7:14=E2=80=AFAM Paul Mabileau
<paul.mabileau@harfanglab.fr> wrote:
>
> Hello,
>
> On our end, we also have already merged code to adapt our eBPFs to the ar=
gument order change. However, we would still prefer if this easily-avoidabl=
e breakage could be fixed by moving the argument to the end, even if it mea=
ns having to revert our fix.
>
> This is motivated by the fact that such a change is not made in place on =
our end because we ship our software to environments we don't control, mean=
ing that any and potentially all versions ranging from 4.11 to the very lat=
est should be supported, so the change is made by compiling and shipping a =
new variant of the concerned eBPFs for the version interval it is valid for=
 (7.4+ in this case). And that has to be done every time there is an upstre=
am change like this, so the total installation size and overall complexity =
grows accordingly.
>
> If we could avoid that, especially for such trivial root causes, it would=
 be nice.
>

I agree, and that's why I'm asking Paul to accept the patch reordering
the newly added argument before 7.4 final is released.

I do not think that the maintainer's personal preference for argument
ordering beats real user pain.

> Best regards,
> Paul.
>
> ________________________________________
> From: Daan De Meyer <daan@amutable.com>
> Sent: Wednesday, November 18, 2026 3:18 PM
> To: Ihor Solodrai
> Cc: roblabla; Andrii Nakryiko; Paul Moore; bpf@vger.kernel.org; linux-sec=
urity-module@vger.kernel.org; Paul Mabileau; linux-kernel@vger.kernel.org; =
Andrii Nakryiko
> Subject: Re: [BUG] bpf, lsm: new first argument in 7.4 inode hooks silent=
ly breaks BPF LSMs
>
> Note that we've already merged code in systemd that depends on the
> current argument order, so I'd really prefer if it didn't change. If
> it does, do cc me on the patch so I can fix the issue in systemd.
>
> Cheers,
>
> Daan
>
> On Wed, Nov 18, 2026 at 1:52=E2=80=AFAM Ihor Solodrai <ihor.solodrai@linu=
x.dev> wrote:
> >
> > On 11/9/26 8:07 AM, roblabla wrote:
> > > Hi,
> > >
> > > Thanks for the replies!
> > >
> > >> [...]
> > >
> > > So what would be really nice is a way to make eBPF code robust agains=
t
> > > kernel changes such that it either works, or fails to load, but doesn=
't
> > > do the halfway "loads but silently misbehaves". Here are two ideas th=
at
> > > have been in the back of my mind that could help solve this issue (th=
ough
> > > I understand that they may be rather large changes, I'm putting them =
out
> > > there mostly as a conversation starter):
> > >
> > > 1. Could libbpf/the kernel have a mismatch check on hook arguments? I
> > >    understand that libbpf and the verifier don't know the types a
> > >    program expects, since BPF_PROG() only casts u64s. But the macro
> > >    does know the types at compile time. Could it (or an opt-in varian=
t)
> > >    record the expected prototype in the program's BTF, so that libbpf
> > >    can compare it against the LSM hook's prototype in vmlinux BTF and
> > >    refuse to load on a mismatch?
> > >
> > > 2. Since kernel BTF has parameter names for the bpf_lsm_* functions,
> > >    could we maybe have CO-RE-style relocation to resolve "the argumen=
t
> > >    named dentry" to the argument index at load time? This way, adding=
 a
> > >    new argument could happen anywhere in the argument list without
> > >    breaking eBPFs, and removing an argument will (correctly) cause ou=
r
> > >    eBPF to stop loading. It does mean the eBPF programs must provide =
the
> > >    same argument names, but maybe that's an acceptable tradeoff?
> >

[...]

> >
> > ---
> >
> > And just my 2c re argument ordering:
> >
> > Paul, with all due respect, prioritizing code style and personal
> > preferences over backwards compatibility is unreasonable even for
> > unimportant applications. And here we are talking about apps
> > implementing security policies, which many organizations (not just
> > companies) in the world rely on. Given the recent flood of
> > cybersecurity issues (in Linux and beyond), I don't see why would we,
> > as in kernel devs, intentionally make the defenders' job harder.
> >
> >
> > >
> > > Thanks,
> > > roblabla
> >
