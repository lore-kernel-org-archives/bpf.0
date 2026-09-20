Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com [74.125.229.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A1131ED83
	for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 00:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789864945; cv=pass; b=V6HUY9WDK/QH9fISdQ9NCGInHofAo8i2+bq4iLFeNQNeatdWBMvwOWRSpa4neUuIo8hXJbRUfGCiBOYxs6RrOJKgMNOUO2amInw6Yoe1jtKJWZE1JuqJ0joT/E9u/44kJ67VjrmIEYNLEozzoiqRs6g+M8FQ5Q/adQWOI3uQH18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789864945; c=relaxed/simple;
	bh=k1f1AuHVWSX0iWaYfMIIsqYIji3cQio6kIFlfC9Frk8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sWAFudlx3sJ3g/Uvu3tMos1RaMd+f4RqGA9fDjvYr1ZECIgDntkl5APDQOP9TdT6gUrfnXHUED1b3CsNe9lbUfP0FkTB8PIYYLivupqFVWNjsXi1vK3SgaKEsqjoGg21TdQaUQjvApaN2yd08HMNXefOoYpAJrgkgpzeVJybvDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G15X1BIa; arc=pass smtp.client-ip=74.125.229.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G15X1BIa"
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b5e4f13d76so2148913e87.3
        for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 17:42:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789864941; cv=none;
        d=google.com; s=arc-20260327;
        b=n0gEqIE0cuXvPQI3h3idXEGYJlBIDfEVredLWx+Abh3DCdZebpfztBAqDc1d4pDWs/
         oyYXiMQS4m4TJr6ghApBbC4WIs9XzM05ESUskxyBWSMbCfyQom1JOpT4Lno2npcXcheR
         Uq2MOFxdSPYoaaUKvGGu5X+Ni+cAflqzG78akvuA68YecbqJc48nNC3hJyegc+uXPx9M
         XtABrqzyKZiDinY5hXNTa7W9n+csVsRu7NHPvMLIUb8NZRTWWhjOYWcqh07l5E2yYW1V
         j45/ryVQ005HfH2zck+C9flFCm8BzbphPsFKw6kNkH8a6cDdPMIp1v7PrOIbNDXt/DIc
         yVQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=cQU5d/EG0qddsCQBADuhWeJNZr869cXrSlAZdp5FiBQ=;
        fh=xPYO/w7SvJoPFx5rRc20WCBt6LwNECHNFkKPEfp+OBI=;
        b=CjMKXgCOHSJy6OPNC+rztaeoIOHimR9Of7Di4jo1sEAxnJ6Gq87lh1+mgNk2PvG1rK
         5RVmYp9uEj6IY58VJ2uZHhMzUfqIPzYs9fzLnOrrjsxcsMuZVouJLMhaiJ5Z2IWfhpoo
         PvmT8FM4fr6RR07HeSGizRrDvFrcfct9hgWH9rKaMpqOCfCvRwxUEZE8QEH0WkPGHCof
         o7t3x2NdoJNIuwxiOrTmcp1Fg9yKOcqm4BftCF7hnI+wEfZYNKZs3tVa+SRds5xsXa3n
         QIYuuQMqJozKX03ndlBsUadmYYgofDrnMtckV3+fcXCdmyGVJ7I4tmHUooXOId9yL3Cn
         9wbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789864941; x=1790469741; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cQU5d/EG0qddsCQBADuhWeJNZr869cXrSlAZdp5FiBQ=;
        b=G15X1BIa7k2omih1uE+9lk16ugNl5nCQuESWh32/Hvhzw53+085LfFGJo6y8hbgd+4
         3ySbpcF9UoS0oMpx5+3lFHwNvVUqG8+236TwNjo4PG+uLSCt+71abEHz2VmT6n4mrfee
         HzJyaUkzbG/1P2TGlQ1YEwKFlsyQolrnLAHwUqYS2XPEnGrK4nbwF+4VQZQC20KxO9Gh
         e9nfu606eDVYzZGoNNMav8vYaYmDYO/SVYtgujqpoxi5zcLLIf8ewB8wjp9pR2Q3UMiT
         6Z0HGft4DDsv0DNlT45wI3VgThTRwE4sOyxcqgcxiqpNPshtVK6Pg9cAWEb0PHXOprFR
         aXgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789864941; x=1790469741;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cQU5d/EG0qddsCQBADuhWeJNZr869cXrSlAZdp5FiBQ=;
        b=KJbXTPuh3SSEMh+TAlzatKttok3Eg5sXEkBpg9Utn3IlgP77r0GOy+zwM5DQpAeP+a
         e0H/Ubzw8NYF1/vkarARG37U+UqgQaHFoxcmdkHT7E1mvrLWqf5mTItIlEPqlOfcHORh
         3m91bsUyI8BnIpIdA0ZifzX9RmvQR76GWpTfHHQQbzUpLkgCgPj9U+IV/fsoEzOJdCLm
         Zs6/8YiXFyxqZVqbL/o/n21QxtXeJDT8BC5e9/sl7RyUxdrUW2TS3CHkHbSXHO2JYpkF
         rlpfZ5IaqMT5S2ekJ9tKT+/NcAtBTmtBZFmqdsQLGDyr1pGKIcLlmnWEUPYAt1tIija4
         pUrQ==
X-Forwarded-Encrypted: i=1; AKwUvBy3LKDrzvF15laAEZOjJaItEKnWVZrT8+KaKlOwW32D3CZXtEnDuK4CBdtP93+Lbc3hW5Y=@vger.kernel.org
X-Gm-Message-State: AFuF++n3CS0+G+6YRf2zL3m3BqwqHf9PXHWqisQACM3q53YBwVhBsHlF
	UMhpEsB9oRB9h/m7qoI/jbYS2Dbr1hb9nZMWAPXyfmxwuSVfhDzawmY7LFJFo/Uz8gaTGCyQLdR
	gwwrTSr5RdoBnpo906zyJYzzxodMwnkPM+RLQNvUJSFOd
X-Gm-Gg: AYBFou1g5Uh4SRClgnx9IFnylPC2iBJ5BvHSvKQMzdenCsFEljlc7vl32odK1egAcce
	7DDOfvnFvm/dhtHjV5mG8GIUuKD4+usTS5Y4CnWfp8go84GMfkdyYWALPPC02l+1p4/VnmjLF/b
	0WjLmx3bg/Sk6yrodHo4pvYhLqYHw7Mo+sAkn8FB/SBZcOcWPqWX2kdmY6ztpQq5ObKBRxOeuoI
	EIKd0pP72u+eT8myJ/CM/te1e46kK3SIIfORSaa/knmJR77+9eRoFQK2Px30Ny0+Fc49FpKKnMk
	quivHjJRlWUNicOwuSHjQlBGYkcaBGs1D3a543zESSCg1QtIqbTquTteXNFOz7fedAqEyJbRgnu
	E2lU1sN2ZqM7Ojn/Jm0lIo9NlJb7h8ehVoA4o9qqfnsI9n3Zm0EAJ1yZVlu8prpFCnNk5gQ==
X-Received: by 2002:a05:6512:3baa:b0:5b7:61d0:ab80 with SMTP id
 2adb3069b0e04-5b8c184e3a4mr2293459e87.31.1789864941053; Sat, 19 Sep 2026
 17:42:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260919143732.11772-1-kerneljasonxing@gmail.com> <DLJHVEYXMZ6R.1YX59HGMRMYO0@gmail.com>
In-Reply-To: <DLJHVEYXMZ6R.1YX59HGMRMYO0@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sun, 20 Sep 2026 08:41:40 +0800
X-Gm-Features: AcwNN1Uv0TdypWH05EZELvNYl9FBDjJSLrTBlPKhVyGR2K_fHkGpIZTzX6tqiJU
Message-ID: <CAL+tcoD36zA=TYSzKSNWV0Ypo_HRBRU_Qh6rQtPL51aXR54p7Q@mail.gmail.com>
Subject: Re: [PATCH RFC net-next 0/9] net: BPF Timestamping 2.0 for TCP
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, willemb@google.com, kuniyu@google.com, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, 
	Jason Xing <kerneljasonxing@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000000208ba065bdf6849"

--0000000000000208ba065bdf6849
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 20, 2026 at 2:12=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sat Sep 19, 2026 at 2:37 PM UTC, Jason Xing wrote:
> > From: Jason Xing <kernelxing@gmail.com>
> >
> > Greeting,
> >
> > It's BPF Timestamping 2.0 that aims to observe the packet latency
> > more efficiently and simply for different protocols. The current
> > series is only focused on TCP protocol.
> >
> > At Netdev 0x1a/Netconf 2026, the history, background, motivation and
> > rough implementation of the feature were exhaustively introduced[1].
> >
> > History
> > =3D=3D=3D=3D=3D=3D=3D
> > - In 2009, Patrick Ohly implemented the basic infrastructure
> > - In 2014, Willem de Bruijn enhanced the TCP latency observation
> > - In 2024, Jason Xing proposed its lightweight BPF version
> > Detailed slides from 28 to 32 [1].
> >
> > Background
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Even though BPF Timetamping 1.0 is comparatively low-overhead,
> > transparent, it's still complicated due to a few points inherited
> > from the design:
> > - Inflexible/fixed reporting phases (qdisc/driver/ack)
> >   When we confirm the issue arises from the kernel by using attribution
> >   ability of timestamping feature, we need to further minimize the scop=
e
> >   until the issue is fixed. That means, we then have to resort to write
> >   a few complex BPF progs with the similar functionalities (like skb
> >   level tag) which should not happen.
> > - Not enough low-overhead
> >   Serving the sensitive applications, an always-on latency observation
> >   platform should mitigate the self-impact as much as possible. As we
> >   can conclude from BPF Timestamping selftests, there are some blocking
> >   and time-consuming points like where reading/writing BPF maps happen
> >   in the extremely hot paths.
> > - Minor flaws
> >   There are a few minor flaws inherited from the initial design, like
> >   missing tagging the last packet[2][3][4].
>
>
> All these "issues" sound minor and on their own do not warrant new uapi.

Some of them are minor, some definitely not.

Current BPF timestamping 1.0 is not perfect and __doesn't support
container scenario__ which is a big thing.

Besides, performance impact and unflexibility are real problems when
we're trying so hard to deploy the platform. The experience isn't
limited to us; several of my friends at other companies widely deploy
the version 1.0 feature.

>
> This RFC don't even have an example of how it could be used end-to-end.

Sorry, I should've uploaded the examples. Please see the attachment.
# make && ./bpfts_v2

The usage is simple:
1. bpf_setsockopt to enable the feature
2. read out the start time of skb
3. compute the delta

Please note: my intention here is to initiate a discussion on how it
looks like in the future. Reusing hwtstamp potentially risks breaking
some existing applications, which is the point I'm most open to
discussing.

Thanks,
Jason

--0000000000000208ba065bdf6849
Content-Type: application/octet-stream; name=Makefile
Content-Disposition: attachment; filename=Makefile
Content-Transfer-Encoding: base64
Content-ID: <f_mu937vnw2>
X-Attachment-Id: f_mu937vnw2

Q0xBTkcgICA/PSBjbGFuZwpDQyAgICAgID89IGdjYwpCUEZUT09MID89IGJwZnRvb2wKQVJDSCAg
ICA/PSAkKHNoZWxsIHVuYW1lIC1tIHwgc2VkICdzL3g4Nl82NC94ODYvJyBcCgkJCXwgc2VkICdz
L2FhcmNoNjQvYXJtNjQvJyBcCgkJCXwgc2VkICdzL3BwYzY0bGUvcG93ZXJwYy8nIFwKCQkJfCBz
ZWQgJ3MvbWlwcy4qL21pcHMvJyBcCgkJCXwgc2VkICdzL3Jpc2N2NjQvcmlzY3YvJyBcCgkJCXwg
c2VkICdzL2xvb25nYXJjaC4qL2xvb25nYXJjaC8nKQoKQ0ZMQUdTICAgOj0gLWcgLU8yIC1XYWxs
CklOQ0xVREVTIDo9IC1JLgoKLlBIT05ZOiBhbGwgY2xlYW4KCmFsbDogYnBmdHNfdjIKCnZtbGlu
dXguaDoKCSQoQlBGVE9PTCkgYnRmIGR1bXAgZmlsZSAvc3lzL2tlcm5lbC9idGYvdm1saW51eCBm
b3JtYXQgYyA+ICRACgpicGZ0c192Mi5icGYubzogYnBmdHNfdjIuYnBmLmMgdm1saW51eC5oCgkk
KENMQU5HKSAkKENGTEFHUykgLXRhcmdldCBicGYgLURfX1RBUkdFVF9BUkNIXyQoQVJDSCkgXAoJ
CSQoSU5DTFVERVMpIC1jICQ8IC1vICRACgpicGZ0c192Mi5za2VsLmg6IGJwZnRzX3YyLmJwZi5v
CgkkKEJQRlRPT0wpIGdlbiBza2VsZXRvbiAkPCA+ICRACgpicGZ0c192MjogYnBmdHNfdjIuYyBi
cGZ0c192Mi5za2VsLmgKCSQoQ0MpICQoQ0ZMQUdTKSAkKElOQ0xVREVTKSAtbyAkQCAkPCAtbGJw
ZiAtbGVsZiAtbHoKCmNsZWFuOgoJcm0gLWYgYnBmdHNfdjIgYnBmdHNfdjIuYnBmLm8gYnBmdHNf
djIuc2tlbC5oIHZtbGludXguaAo=
--0000000000000208ba065bdf6849
Content-Type: application/octet-stream; name="bpfts_v2.bpf.c"
Content-Disposition: attachment; filename="bpfts_v2.bpf.c"
Content-Transfer-Encoding: base64
Content-ID: <f_mu937vng0>
X-Attachment-Id: f_mu937vng0

Ly8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAKLyoKICogQlBGIFRpbWVzdGFtcGlu
ZyBWMiDigJQgc3RhbmRhbG9uZSBCUEYgcHJvZ3JhbQogKgogKiBzb2Nrb3BzOiBlbmFibGUgU0tf
QlBGX0NCX1RJTUVTVEFNUElOR19WMiBvbiBuZXcgVENQIGNvbm5lY3Rpb25zCiAqIGZlbnRyeTog
IHJlYWQgc2tiIHN0YXJ0X3RpbWUgYW5kIHN1YnRyYWN0IGJwZl9rdGltZV9nZXRfcmVhbF9ucygp
CiAqCiAqIE5vIEJQRiBtYXAgb24gdGhlIHRpbWluZyBwYXRoLiBDb21waWxlIG91dHNpZGUgdGhl
IGtlcm5lbCB0cmVlOgogKiAgIG1ha2UgJiYgc3VkbyAuL2JwZnRzX3YyCiAqLwojaW5jbHVkZSAi
dm1saW51eC5oIgojaW5jbHVkZSA8YnBmL2JwZl9oZWxwZXJzLmg+CiNpbmNsdWRlIDxicGYvYnBm
X3RyYWNpbmcuaD4KI2luY2x1ZGUgPGJwZi9icGZfY29yZV9yZWFkLmg+CgovKgogKiBicGZfY29y
ZV9jYXN0KCkgbGFuZGVkIGluIG5ld2VyIGxpYmJwZi4gRGlzdHJvIGhlYWRlcnMgKGxpYmJwZi1k
ZXYpCiAqIG9mdGVuIGRvIG5vdCBoYXZlIGl0IHlldDsgcHJvdmlkZSB0aGUgc2FtZSBleHBhbnNp
b24uCiAqLwojaWZuZGVmIGJwZl9jb3JlX3R5cGVfaWRfa2VybmVsCiNkZWZpbmUgYnBmX2NvcmVf
dHlwZV9pZF9rZXJuZWwodHlwZSkgXAoJX19idWlsdGluX2J0Zl90eXBlX2lkKCoodHlwZW9mKHR5
cGUpICopMCwgMSkKI2VuZGlmCiNpZm5kZWYgYnBmX2NvcmVfY2FzdApleHRlcm4gdm9pZCAqYnBm
X3Jkb25seV9jYXN0KGNvbnN0IHZvaWQgKm9ial9fLCBfX3UzMiBidGZfaWRfXykgX19rc3ltIF9f
d2VhazsKI2RlZmluZSBicGZfY29yZV9jYXN0KHB0ciwgdHlwZSkgXAoJKCh0eXBlb2YodHlwZSkg
KilicGZfcmRvbmx5X2Nhc3QoKHB0ciksIGJwZl9jb3JlX3R5cGVfaWRfa2VybmVsKHR5cGUpKSkK
I2VuZGlmCgojZGVmaW5lIFNPTF9TT0NLRVQJCQkxCiNkZWZpbmUgU0tfQlBGX0NCX0ZMQUdTCQkJ
MTAwOQojZGVmaW5lIFNLX0JQRl9DQl9USU1FU1RBTVBJTkdfVjIJKDEgPDwgMSkKCiNkZWZpbmUg
RElSX1RYCTAKI2RlZmluZSBESVJfUlgJMQoKZXh0ZXJuIF9fdTY0IGJwZl9rdGltZV9nZXRfcmVh
bF9ucyh2b2lkKSBfX2tzeW07CgpzdHJ1Y3QgbGF0X2V2ZW50IHsKCV9fdTY0IGRlbHRhX25zOwoJ
X191MzIgcGlkOwoJX191OCAgZGlyOwoJY2hhciAgY29tbVsxNl07Cn07CgpzdHJ1Y3QgewoJX191
aW50KHR5cGUsIEJQRl9NQVBfVFlQRV9SSU5HQlVGKTsKCV9fdWludChtYXhfZW50cmllcywgMjU2
ICogMTAyNCk7Cn0gZXZlbnRzIFNFQygiLm1hcHMiKTsKCl9fdTY0IHR4X2NudCwgcnhfY250Owpf
X3U2NCB0eF9zdW1fbnMsIHJ4X3N1bV9uczsKX191NjQgdHhfbWF4X25zLCByeF9tYXhfbnM7Cl9f
dTY0IHNraXBfY250OwoKLyogU29mdHdhcmUgc3RhcnRfdGltZSBpcyBDTE9DS19SRUFMVElNRS4g
QSBQSEMvaGFyZHdhcmUgc3RhbXAgaW4gdGhlCiAqIHNoYXJlZCB1bmlvbiBpcyBhIGRpZmZlcmVu
dCBjbG9jazsgc3VidHJhY3Rpbmcga3RpbWVfZ2V0X3JlYWwoKQogKiB5aWVsZHMgfmVwb2NoLXNp
emVkIGdhcmJhZ2UgKDFlMTUrIHVzKS4gRHJvcCB0aG9zZS4KICovCiNkZWZpbmUgTUFYX0xBVF9O
UwkoMTBVTEwgKiAxMDAwICogMTAwMCAqIDEwMDApCgpzdGF0aWMgX19hbHdheXNfaW5saW5lIF9f
dTY0IHNrYl9zdGFydF90aW1lKGNvbnN0IHN0cnVjdCBza19idWZmICpza2IpCnsKCXN0cnVjdCBz
a2Jfc2hhcmVkX2luZm8gKnNoaW5mbzsKCglpZiAoIXNrYikKCQlyZXR1cm4gMDsKCS8qIHNhbWUg
c3RvcmFnZSBhcyBzdGFydF90aW1lICh1bmlvbiB3aXRoIGh3dHN0YW1wKSAqLwoJc2hpbmZvID0g
YnBmX2NvcmVfY2FzdChza2ItPmhlYWQgKyBza2ItPmVuZCwgc3RydWN0IHNrYl9zaGFyZWRfaW5m
byk7CglyZXR1cm4gKF9fdTY0KXNoaW5mby0+aHd0c3RhbXBzLmh3dHN0YW1wOwp9CgpzdGF0aWMg
X19hbHdheXNfaW5saW5lIHZvaWQgcmVjb3JkX2xhdChjb25zdCBzdHJ1Y3Qgc2tfYnVmZiAqc2ti
LCBfX3U4IGRpcikKewoJc3RydWN0IGxhdF9ldmVudCAqZTsKCV9fdTY0IHN0YXJ0LCBkZWx0YTsK
CglzdGFydCA9IHNrYl9zdGFydF90aW1lKHNrYik7CglpZiAoIXN0YXJ0KQoJCXJldHVybjsKCglk
ZWx0YSA9IGJwZl9rdGltZV9nZXRfcmVhbF9ucygpIC0gc3RhcnQ7CgkvKiBzdGFydCA+IG5vdyB1
bmRlcmZsb3dzOyBQSEMvaHcgc3RhbXAgaXMgdXN1YWxseSBhIHNtYWxsIHZhbHVlICovCglpZiAo
ZGVsdGEgPiBNQVhfTEFUX05TKSB7CgkJX19zeW5jX2ZldGNoX2FuZF9hZGQoJnNraXBfY250LCAx
KTsKCQlyZXR1cm47Cgl9CgoJaWYgKGRpciA9PSBESVJfVFgpIHsKCQlfX3N5bmNfZmV0Y2hfYW5k
X2FkZCgmdHhfY250LCAxKTsKCQlfX3N5bmNfZmV0Y2hfYW5kX2FkZCgmdHhfc3VtX25zLCBkZWx0
YSk7CgkJaWYgKGRlbHRhID4gdHhfbWF4X25zKQoJCQl0eF9tYXhfbnMgPSBkZWx0YTsKCX0gZWxz
ZSB7CgkJX19zeW5jX2ZldGNoX2FuZF9hZGQoJnJ4X2NudCwgMSk7CgkJX19zeW5jX2ZldGNoX2Fu
ZF9hZGQoJnJ4X3N1bV9ucywgZGVsdGEpOwoJCWlmIChkZWx0YSA+IHJ4X21heF9ucykKCQkJcnhf
bWF4X25zID0gZGVsdGE7Cgl9CgoJZSA9IGJwZl9yaW5nYnVmX3Jlc2VydmUoJmV2ZW50cywgc2l6
ZW9mKCplKSwgMCk7CglpZiAoIWUpCgkJcmV0dXJuOwoJZS0+ZGVsdGFfbnMgPSBkZWx0YTsKCWUt
PnBpZCA9IGJwZl9nZXRfY3VycmVudF9waWRfdGdpZCgpID4+IDMyOwoJZS0+ZGlyID0gZGlyOwoJ
YnBmX2dldF9jdXJyZW50X2NvbW0oJmUtPmNvbW0sIHNpemVvZihlLT5jb21tKSk7CglicGZfcmlu
Z2J1Zl9zdWJtaXQoZSwgMCk7Cn0KClNFQygic29ja29wcyIpCmludCBlbmFibGVfdjIoc3RydWN0
IGJwZl9zb2NrX29wcyAqc2tvcHMpCnsKCWludCBmbGFncyA9IFNLX0JQRl9DQl9USU1FU1RBTVBJ
TkdfVjI7CgoJc3dpdGNoIChza29wcy0+b3ApIHsKCWNhc2UgQlBGX1NPQ0tfT1BTX0FDVElWRV9F
U1RBQkxJU0hFRF9DQjoKCWNhc2UgQlBGX1NPQ0tfT1BTX1BBU1NJVkVfRVNUQUJMSVNIRURfQ0I6
CgkJYnBmX3NldHNvY2tvcHQoc2tvcHMsIFNPTF9TT0NLRVQsIFNLX0JQRl9DQl9GTEFHUywKCQkJ
ICAgICAgICZmbGFncywgc2l6ZW9mKGZsYWdzKSk7CgkJYnJlYWs7Cgl9CglyZXR1cm4gMTsKfQoK
LyogVFg6IHNlbmRtc2cgLT4gZGV2aWNlIHF1ZXVlICovClNFQygiZmVudHJ5L19fZGV2X3F1ZXVl
X3htaXQiKQppbnQgQlBGX1BST0cob25fZGV2X3htaXQsIHN0cnVjdCBza19idWZmICpza2IsIHN0
cnVjdCBuZXRfZGV2aWNlICpzYl9kZXYpCnsKCXJlY29yZF9sYXQoc2tiLCBESVJfVFgpOwoJcmV0
dXJuIDA7Cn0KCi8qIFJYIElQdjQ6IGFycml2YWwgLT4gVENQIHJlY2VpdmUgKi8KU0VDKCJmZW50
cnkvdGNwX3Y0X3JjdiIpCmludCBCUEZfUFJPRyhvbl90Y3BfdjRfcmN2LCBzdHJ1Y3Qgc2tfYnVm
ZiAqc2tiKQp7CglyZWNvcmRfbGF0KHNrYiwgRElSX1JYKTsKCXJldHVybiAwOwp9CgovKiBSWCBJ
UHY2ICovClNFQygiZmVudHJ5L3RjcF92Nl9yY3YiKQppbnQgQlBGX1BST0cob25fdGNwX3Y2X3Jj
diwgc3RydWN0IHNrX2J1ZmYgKnNrYikKewoJcmVjb3JkX2xhdChza2IsIERJUl9SWCk7CglyZXR1
cm4gMDsKfQoKY2hhciBMSUNFTlNFW10gU0VDKCJsaWNlbnNlIikgPSAiR1BMIjsK
--0000000000000208ba065bdf6849
Content-Type: application/octet-stream; name="bpfts_v2.c"
Content-Disposition: attachment; filename="bpfts_v2.c"
Content-Transfer-Encoding: base64
Content-ID: <f_mu937vnq1>
X-Attachment-Id: f_mu937vnq1

Ly8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAKLyoKICogVXNlcnNwYWNlIGxvYWRl
ciBmb3IgQlBGIFRpbWVzdGFtcGluZyBWMi4KICoKICogICBtYWtlCiAqICAgc3VkbyAuL2JwZnRz
X3YyCiAqCiAqIFRoZW4gb3BlbiBhIE5FVyBUQ1AgY29ubmVjdGlvbiAoVjIgaXMgZW5hYmxlZCBv
biBFU1RBQkxJU0hFRCk6CiAqICAgY3VybCAtNCBodHRwOi8vMTI3LjAuMC4xLwogKiAgIHBpbmcg
aXMgSUNNUCDigJQgaXQgd2lsbCBub3QgcHJvZHVjZSBldmVudHMuCiAqLwojaW5jbHVkZSA8c3Rk
aW8uaD4KI2luY2x1ZGUgPHN0ZGxpYi5oPgojaW5jbHVkZSA8c3RyaW5nLmg+CiNpbmNsdWRlIDxl
cnJuby5oPgojaW5jbHVkZSA8ZmNudGwuaD4KI2luY2x1ZGUgPHNpZ25hbC5oPgojaW5jbHVkZSA8
dW5pc3RkLmg+CiNpbmNsdWRlIDx0aW1lLmg+CiNpbmNsdWRlIDxicGYvbGliYnBmLmg+CiNpbmNs
dWRlICJicGZ0c192Mi5za2VsLmgiCgojZGVmaW5lIERJUl9UWCAwCiNkZWZpbmUgRElSX1JYIDEK
CnN0YXRpYyB2b2xhdGlsZSBzaWdfYXRvbWljX3QgZXhpdGluZzsKCnN0cnVjdCBsYXRfZXZlbnQg
ewoJX191NjQgZGVsdGFfbnM7CglfX3UzMiBwaWQ7CglfX3U4ICBkaXI7CgljaGFyICBjb21tWzE2
XTsKfTsKCnN0YXRpYyB2b2lkIG9uX3NpZ25hbChpbnQgc2lnKQp7CglleGl0aW5nID0gMTsKfQoK
c3RhdGljIGludCBsaWJicGZfcHJpbnQoZW51bSBsaWJicGZfcHJpbnRfbGV2ZWwgbGV2ZWwsIGNv
bnN0IGNoYXIgKmZtdCwKCQkJdmFfbGlzdCBhcmdzKQp7CglpZiAobGV2ZWwgPT0gTElCQlBGX0RF
QlVHKQoJCXJldHVybiAwOwoJcmV0dXJuIHZmcHJpbnRmKHN0ZGVyciwgZm10LCBhcmdzKTsKfQoK
c3RhdGljIGludCBoYW5kbGVfZXZlbnQodm9pZCAqY3R4LCB2b2lkICpkYXRhLCBzaXplX3QgbGVu
KQp7Cgljb25zdCBzdHJ1Y3QgbGF0X2V2ZW50ICplID0gZGF0YTsKCglwcmludGYoIiVzICAlLTE2
cyBwaWQ9JS02dSAgbGF0PSU4LjNmIHVzXG4iLAoJICAgICAgIGUtPmRpciA9PSBESVJfVFggPyAi
VFgiIDogIlJYIiwKCSAgICAgICBlLT5jb21tLCBlLT5waWQsIGUtPmRlbHRhX25zIC8gMTAwMC4w
KTsKCWZmbHVzaChzdGRvdXQpOwoJcmV0dXJuIDA7Cn0KCnN0YXRpYyB2b2lkIHByaW50X3N1bW1h
cnkoY29uc3Qgc3RydWN0IGJwZnRzX3YyX2JwZiAqc2tlbCkKewoJX191NjQgdHggPSBza2VsLT5i
c3MtPnR4X2NudDsKCV9fdTY0IHJ4ID0gc2tlbC0+YnNzLT5yeF9jbnQ7CgoJcHJpbnRmKCJcbi0t
LS0tIHN1bW1hcnkgLS0tLS1cbiIpOwoJaWYgKHR4KQoJCXByaW50ZigiVFggICVsbHUgcGt0cyAg
YXZnICUuM2YgdXMgIG1heCAlLjNmIHVzXG4iLAoJCSAgICAgICAodW5zaWduZWQgbG9uZyBsb25n
KXR4LAoJCSAgICAgICBza2VsLT5ic3MtPnR4X3N1bV9ucyAvIChkb3VibGUpdHggLyAxMDAwLjAs
CgkJICAgICAgIHNrZWwtPmJzcy0+dHhfbWF4X25zIC8gMTAwMC4wKTsKCWVsc2UKCQlwcmludGYo
IlRYICAwIHBrdHNcbiIpOwoJaWYgKHJ4KQoJCXByaW50ZigiUlggICVsbHUgcGt0cyAgYXZnICUu
M2YgdXMgIG1heCAlLjNmIHVzXG4iLAoJCSAgICAgICAodW5zaWduZWQgbG9uZyBsb25nKXJ4LAoJ
CSAgICAgICBza2VsLT5ic3MtPnJ4X3N1bV9ucyAvIChkb3VibGUpcnggLyAxMDAwLjAsCgkJICAg
ICAgIHNrZWwtPmJzcy0+cnhfbWF4X25zIC8gMTAwMC4wKTsKCWVsc2UKCQlwcmludGYoIlJYICAw
IHBrdHNcbiIpOwoJaWYgKHNrZWwtPmJzcy0+c2tpcF9jbnQpCgkJcHJpbnRmKCJza2lwcGVkICVs
bHUgKGh3L1BIQyBzdGFtcCwgbm90IENMT0NLX1JFQUxUSU1FKVxuIiwKCQkgICAgICAgKHVuc2ln
bmVkIGxvbmcgbG9uZylza2VsLT5ic3MtPnNraXBfY250KTsKCXByaW50ZigiLS0tLS0tLS0tLS0t
LS0tLS0tLVxuIik7Cn0KCnN0YXRpYyB2b2lkIHVzYWdlKGNvbnN0IGNoYXIgKmFyZ3YwKQp7Cglm
cHJpbnRmKHN0ZGVyciwKCQkiVXNhZ2U6ICVzIFstYyBjZ3JvdXBfcGF0aF1cbiIKCQkiICAtYyAg
IGNncm91cCB0byBhdHRhY2ggc29ja29wcyAoZGVmYXVsdDogL3N5cy9mcy9jZ3JvdXApXG4iCgkJ
IlxuIgoJCSJWMiBpcyBlbmFibGVkIG9uIFRDUCBjb25uZWN0aW9ucyBlc3RhYmxpc2hlZCBBRlRF
UiBhdHRhY2guXG4iCgkJIlB1dCB0aGUgdHJhZmZpYyBwcm9jZXNzIGludG8gdGhhdCBjZ3JvdXAs
IG9yIGF0dGFjaCB0aGUgcm9vdFxuIgoJCSJjZ3JvdXAgKGRlZmF1bHQpIHNvIGV2ZXJ5IG5ldyBU
Q1Agc29ja2V0IGlzIGNvdmVyZWQuXG4iLAoJCWFyZ3YwKTsKfQoKaW50IG1haW4oaW50IGFyZ2Ms
IGNoYXIgKiphcmd2KQp7Cgljb25zdCBjaGFyICpjZ19wYXRoID0gIi9zeXMvZnMvY2dyb3VwIjsK
CXN0cnVjdCByaW5nX2J1ZmZlciAqcmIgPSBOVUxMOwoJc3RydWN0IGJwZnRzX3YyX2JwZiAqc2tl
bCA9IE5VTEw7CglzdHJ1Y3QgYnBmX2xpbmsgKmxpbms7CglpbnQgb3B0LCBlcnIsIGNnX2ZkID0g
LTE7CgoJd2hpbGUgKChvcHQgPSBnZXRvcHQoYXJnYywgYXJndiwgImM6aCIpKSAhPSAtMSkgewoJ
CXN3aXRjaCAob3B0KSB7CgkJY2FzZSAnYyc6CgkJCWNnX3BhdGggPSBvcHRhcmc7CgkJCWJyZWFr
OwoJCWNhc2UgJ2gnOgoJCWRlZmF1bHQ6CgkJCXVzYWdlKGFyZ3ZbMF0pOwoJCQlyZXR1cm4gb3B0
ID09ICdoJyA/IDAgOiAxOwoJCX0KCX0KCglsaWJicGZfc2V0X3ByaW50KGxpYmJwZl9wcmludCk7
CglzaWduYWwoU0lHSU5ULCBvbl9zaWduYWwpOwoJc2lnbmFsKFNJR1RFUk0sIG9uX3NpZ25hbCk7
CgoJc2tlbCA9IGJwZnRzX3YyX2JwZl9fb3Blbl9hbmRfbG9hZCgpOwoJaWYgKCFza2VsKSB7CgkJ
ZnByaW50ZihzdGRlcnIsICJmYWlsZWQgdG8gb3Blbi9sb2FkIEJQRiBvYmplY3Q6ICVzXG4iLAoJ
CQlzdHJlcnJvcihlcnJubykpOwoJCXJldHVybiAxOwoJfQoKCS8qIGZlbnRyeSBhdXRvLWF0dGFj
aDsgc29ja29wcyBuZWVkcyBhIGNncm91cCBmZCAqLwoJYnBmX3Byb2dyYW1fX3NldF9hdXRvYXR0
YWNoKHNrZWwtPnByb2dzLmVuYWJsZV92MiwgZmFsc2UpOwoJZXJyID0gYnBmdHNfdjJfYnBmX19h
dHRhY2goc2tlbCk7CglpZiAoZXJyKSB7CgkJZnByaW50ZihzdGRlcnIsICJmYWlsZWQgdG8gYXR0
YWNoIGZlbnRyeTogJWRcbiIsIGVycik7CgkJZ290byBvdXQ7Cgl9CgoJY2dfZmQgPSBvcGVuKGNn
X3BhdGgsIE9fUkRPTkxZKTsKCWlmIChjZ19mZCA8IDApIHsKCQlmcHJpbnRmKHN0ZGVyciwgIm9w
ZW4gY2dyb3VwICVzOiAlc1xuIiwgY2dfcGF0aCwgc3RyZXJyb3IoZXJybm8pKTsKCQlnb3RvIG91
dDsKCX0KCglsaW5rID0gYnBmX3Byb2dyYW1fX2F0dGFjaF9jZ3JvdXAoc2tlbC0+cHJvZ3MuZW5h
YmxlX3YyLCBjZ19mZCk7CglpZiAoIWxpbmspIHsKCQlmcHJpbnRmKHN0ZGVyciwgImF0dGFjaCBz
b2Nrb3BzIHRvICVzOiAlc1xuIiwKCQkJY2dfcGF0aCwgc3RyZXJyb3IoZXJybm8pKTsKCQlnb3Rv
IG91dDsKCX0KCXNrZWwtPmxpbmtzLmVuYWJsZV92MiA9IGxpbms7CgoJcmIgPSByaW5nX2J1ZmZl
cl9fbmV3KGJwZl9tYXBfX2ZkKHNrZWwtPm1hcHMuZXZlbnRzKSwKCQkJICAgICAgaGFuZGxlX2V2
ZW50LCBOVUxMLCBOVUxMKTsKCWlmICghcmIpIHsKCQlmcHJpbnRmKHN0ZGVyciwgImZhaWxlZCB0
byBjcmVhdGUgcmluZyBidWZmZXJcbiIpOwoJCWdvdG8gb3V0OwoJfQoKCXByaW50ZigiQlBGIFRp
bWVzdGFtcGluZyBWMiBydW5uaW5nIChjZ3JvdXAgJXMpXG4iLCBjZ19wYXRoKTsKCXByaW50Zigi
U3RhcnQgYSBORVcgVENQIGNvbm5lY3Rpb24gbm93LCBDdHJsLUMgdG8gc3RvcC5cblxuIik7CgoJ
d2hpbGUgKCFleGl0aW5nKSB7CgkJZXJyID0gcmluZ19idWZmZXJfX3BvbGwocmIsIDIwMCk7CgkJ
aWYgKGVyciA9PSAtRUlOVFIpCgkJCWJyZWFrOwoJCWlmIChlcnIgPCAwKSB7CgkJCWZwcmludGYo
c3RkZXJyLCAicmluZ19idWZmZXJfX3BvbGw6ICVkXG4iLCBlcnIpOwoJCQlicmVhazsKCQl9Cgl9
CgoJcHJpbnRfc3VtbWFyeShza2VsKTsKCWVyciA9IDA7Cm91dDoKCXJpbmdfYnVmZmVyX19mcmVl
KHJiKTsKCWJwZnRzX3YyX2JwZl9fZGVzdHJveShza2VsKTsKCWlmIChjZ19mZCA+PSAwKQoJCWNs
b3NlKGNnX2ZkKTsKCXJldHVybiBlcnIgIT0gMDsKfQo=
--0000000000000208ba065bdf6849--
