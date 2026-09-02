Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5660440643
	for <bpf@vger.kernel.org>; Wed,  2 Sep 2026 23:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788390415; cv=pass; b=nxk0csO3yaWU8inpgct8mKrf0qtCz1pPLvRGgOtNQWFPqishGj7VrXkFlpRdTl4ofLGOfyGLrr6UKjnmscVXABYSo/94hA9TSJOwvmrAUDWf+CN47ogreD5r8xGWsFi/5SyNR6wLdp9APir9AgzaBCEjOpWVuAb+F9Y5jbTF/zk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788390415; c=relaxed/simple;
	bh=QXO79iuzD6hxpf2i+Z0dPQolgpr8pZk2dfjP1ELM1rE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UXGKdOzTXflREOTgaCulANEBlTDLdaYQ5Ze6uWw6beuL39ZmGBkZVMwTT5xTBqZDGe4V0aDKj+WBG6g1AR8aEdXmTy1SAa7sUuD+VQNiYcLdyJb6Af7W7VSt+/eBmIRHy86SfSkUqpEAReDKtSDKefjjgCTDL1KNgBx7O1scO4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XitNxZTJ; arc=pass smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XitNxZTJ"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cbe827e3cb4so2031790a12.3
        for <bpf@vger.kernel.org>; Wed, 02 Sep 2026 16:06:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788390413; cv=none;
        d=google.com; s=arc-20260327;
        b=qLvoGoX+svoK38UoyJKuQF2/mqGCN/EpLBIs9NoiHV1SwgWPJ6y/UMoAInxe333GyK
         1Vaa4zaqOYoj01BublpsPh1qVfNTA3DfeYWLhAcqI02qtSA70CStASN4/O6cALR2cd/k
         0Cn8f7jUv/FTHLAvcJTQGS9+wGVNQ3Co9IQb6+YCYW8s8yzBSh5fFq2toRst+tH3C76J
         SUf+eU2pKvIxGJpy53UptHekrHkc1FM0W7QgVx4yuI/4XGG6FDadWGEdWe0kuaWTdNWD
         8D4UCLwsePEGOIllSEqiTcg5vxUW4nogEouljvpNAilVwksNAZtsF+GE0U68YM1yhKp0
         0H2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QXO79iuzD6hxpf2i+Z0dPQolgpr8pZk2dfjP1ELM1rE=;
        fh=JOoxbDQwRyu1Z179np+NEqMf8GKLH0QtE+zGRDgzqCY=;
        b=Gxjnok3jt8tmZXu7pO3C98GxadYL9CqA/Q93l/iG9RL14iVZKoyNTA8t+WFr/lhUfO
         i4uzScjnXANrIHGTXDc9pdf/1NLt2vYtJII+v8tDSGVCgDPJxfI4jbnQTQr23ibMtGqw
         JVqy8eaZYXdkkLCb7Sn5ZUXXlndFd8LxO65Q9LL+sq+Tn8EiMA/wiLcR+FW628zQnS3U
         AWFHqO19lmrSe+cOY0xukurNe5ESVEwhLMrB9BtzxWmFuomjGRiiewogUlpkvqD+3WMO
         zSh7BVzSwFXxXOnk8t0e/+kbY/qflV8f6br3tORiTD5fbSVnaXtjrLc4jBRvOh2noV1+
         bjZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788390413; x=1788995213; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QXO79iuzD6hxpf2i+Z0dPQolgpr8pZk2dfjP1ELM1rE=;
        b=XitNxZTJ09uvzoUwOzTftYhHODsEy6nLHo46uZbaIONoDW/z8eo5dJmoVuw1Wv7VXO
         JikoTn+0Xwwed0w9GgbXl4YipeoTlB/mZ2IFYGbPqgUpBzNWpJUweZOjWQ7pWus8rq+c
         YQYn2ltbPZkQ7wR6P4A8F7Q2NLAuRmhwJrTm+d4xmC1EEenqOld9yaxGOFmO3f5SmLjI
         52L08G1/pdooVZ++CucMGIj3vUHptDpZUHKyxPPs3c76/7EfmMNRmEY5iqkmg3PAN5xn
         ybPJD/DwG9Bb+2QxC151wb7nOiq/jZMivMW4/VmpxbV6Ls1GxjhuFowL4jTxG7hLxhVr
         yD6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788390413; x=1788995213;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QXO79iuzD6hxpf2i+Z0dPQolgpr8pZk2dfjP1ELM1rE=;
        b=isPvsuGvDnnnWP8xcfNrfKLOJSwZURkmvFHQyHnZwy3d7lMmisr8rRoA+7elrKBKfH
         2R48T6mpv8W3TaX6u3TmM4c96K78VmMArpBszXHjoFtiGb4Keunh7pd1EY4FzPqRKRZf
         yqtJVqpCZJVbp6rMQaBc2GEDM3+P6oKjTAen7Co0VW6lECBm1TkqFuj0ZWBxMf6w23qj
         DJLVIczO5o+j5g/iqFtBoOvD/1zyHXtzLJHKgJcBdB6OXBxMe3ydUXbaD23VML28RTXr
         3fGb4PlEzaHX8kphyIPBNnAmpR1xayFJJqpVt3tiCeoc5ZKBXXux82k5DzFObleNPz0B
         XDUA==
X-Forwarded-Encrypted: i=1; AKwUvBwORQT9cuXzAD4qUvTXQha+YSoNVxZO59eSeD+6Fq04mzLiwZcmjYD3/rgl0wdHzz79Tro=@vger.kernel.org
X-Gm-Message-State: AFuF++kbn7Rt28kvcTlM/18B9yc/UHhFVGYx5GqUhO6iyYrhxEYcA2Rp
	p4O/bHYdwWxvGa5hoYoVxxrTikhVIl7/vrgRlsQMpbAqzA/HWIdt5Kdnl4Uof1OX2padhIf9gGv
	vOBUp9oyH9zWxQX5RjrrcrAIMcx7ZKyZ8zX9j4evR
X-Gm-Gg: AYBFou1O1ANWnA8UDEZaL9atoyBsmKnuY171Ubm08MYcm44RH5qaVw1I/oTKNFYa8T8
	TOsjVHjb90i+hBvkyuTHBcdVHEo5dP3FMDeKSRa9GsKqax3olIfHo0nRG1Q3XnCSuNGRo8w4D3i
	w7QDw4kNRHCENINtFVjXpSa67SzQV71jzxUdeWUztgsYTGj4ypEBOATNaXlh9ogxEyq1c8R3CKl
	0LkI2i7adoIoE3XvMsbmvy2YAy64ONXy/I3zCSA1jMo/ewgY0z6H9aT4SED2C7JUTNz1B7MW33y
	ibi/NaNl+yCZf8CYFbLEMb7eJe19adyMNKdTH5dtPfybMonX7CLRo/hAmfV222V8liY3GVM19Hd
	s4CMKIrNgtyIkHAKpBj8YxjSOFmk75wmOn/Jp/Kw1L0FWWO1Lpm2GFe/Qke9/LVqT+TdWesLqZE
	juB4D2qVRzrEn2TJSRTcN2kwc=
X-Received: by 2002:a17:90a:e7c9:b0:398:9bd4:d12 with SMTP id
 98e67ed59e1d1-39aee219f45mr11238909a91.17.1788390412505; Wed, 02 Sep 2026
 16:06:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902-sockmap-lookup-tcp-leak-v3-0-b998b3d49d07@rbox.co>
 <CAAVpQUC==6KEBs3XgFjZ536mJ23cbHma8HuiWMu1DRc_=YYOHg@mail.gmail.com>
 <20260902155216.4fa23444@kernel.org> <CAAVpQUAWjBuF1Rgze0Vt_XvkUT=Ajw-F+Kh+s2iHk38c8iAapg@mail.gmail.com>
In-Reply-To: <CAAVpQUAWjBuF1Rgze0Vt_XvkUT=Ajw-F+Kh+s2iHk38c8iAapg@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 2 Sep 2026 16:06:39 -0700
X-Gm-Features: AcwNN1WMA28CGWvKALBaFm1vrr9aTSS6G_YD085NjQpsHnEJcUtVs3PqmfzqfQ4
Message-ID: <CAAVpQUATOCCc0N1jnfy2+tkD_zj1su-a-4+bV6qXOSzR7y_iQQ@mail.gmail.com>
Subject: Re: [PATCH bpf v3 0/2] bpf: Fix socket leaks around connect(AF_UNSPEC)+listen()
To: Jakub Kicinski <kuba@kernel.org>
Cc: Michal Luczaj <mhal@rbox.co>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Jiayuan Chen <jiayuan.chen@linux.dev>, Joe Stringer <joe@wand.net.nz>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Pablo Neira Ayuso <pablo@netfilter.org>, 
	Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org, Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 4:04=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.com=
> wrote:
>
> On Wed, Sep 2, 2026 at 3:52=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
> >
> > On Wed, 2 Sep 2026 11:58:49 -0700 Kuniyuki Iwashima wrote:
> > > > Several BPF socket helpers acquire a socket reference only when
> > > > sk_is_refcounted() =3D=3D true, and release it, independently, by
> > > > re-evaluating sk_is_refcounted() again at the time the release runs=
. TCP
> > > > connect(AF_UNSPEC)+listen() sets SOCK_RCU_FREE on an established so=
cket.
> > >
> > > Due to several bug reports, we are now inclined to forbid the
> > > buggy transformation.
> > > https://lore.kernel.org/netdev/CANn89i+px52TtJy3S9=3DuHxGj3s-WueguRo1=
Z_4FxO=3D02KLmwmQ@mail.gmail.com/
> >
> > Kuniyuki, would you be willing to send a patch to do that?
> > Not sure if anyone else is planning to, I wasn't..
>
> Sure, I'll post one like this with s/synchronize_rcu()/-EINVAL/g
> https://lore.kernel.org/netdev/20260804015349.2353056-1-kuniyu@google.com=
/

and cover IPV6_ADDRFORM.
