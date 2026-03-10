Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F0038AC76
	for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 12:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773144449; cv=pass; b=Q+Xf7gQqT5ZuH/ydGXV9z3ZK0/tLJZIwBUBET6SvRyn8E6ZDrHliU9N8JDvGz7evcQjelKajUEZTm55VKQVO6Q+Xrvs8O9FXcv1HRGD9bZkLTJBSyJz38A4PEUk1GXb8xymJwsX+YMpSDLv0uFtsXUyN+n88d4AAPWr8z8+Jo5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773144449; c=relaxed/simple;
	bh=u4ggnB30E8m47pn9MW6ki0gYz6mdnItwTDOiGvmjL+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jbK0ayJfYKW9k8+B8Xcf6Vogi/Ffrn3cTFmg+nB8IRDz/1/eutkiWai2ZuJWxDc0wXwQr/LRj7x94eWd5WbFN22+0iPhIU7/z1cfYslUJH5fZdvJEoBDBMsubdRaUkwjSK8686AqnyluD2h0rtZBG1KaYtsP4QOF4AJlWPjgiXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r/XGqYvo; arc=pass smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r/XGqYvo"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8cd8c6e365eso181585485a.0
        for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 05:07:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773144447; cv=none;
        d=google.com; s=arc-20240605;
        b=P2pEye8a7VsCseURlLBom8f/Erfw3EiFV057RvJvKCNRy4wObKKd0hsRbeCFaJrka+
         wY6JpwPkpHcO85U5Mbq6pM0HUMGV3TKO2D5zqc5vhjDN/+Tw2u5GBlfOQCdvXgBefqrQ
         1G6NARMfFGcewoUotbN335pC6Uw70WqXRNw7SGgRg54LHif0iCsqjdpzcPKmgf7cPERb
         AXSEuEkysWxc4QmNXiS4Cp42mZwWdskqgi5ZyYczuGQiiPsFVh/gt8+BS67n99LXrCnS
         DGj6XJQzfI2zK2rGOZIdeBcWFFlbemTLYtPaUcUjvAGIfRe7IxBlOM1iTUje8n4FokFQ
         hisQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=T8dYRLYkwn5kBNWo/bm2c1XHhtT3zdHO3dRrnUAcL10=;
        fh=8TklY6sOj0cTRSMB6+7CWXG9wt1UmT4QfFyEuzpDbzU=;
        b=O/MhxfIojrQ5g3aSjzP2XhzRL/ld+aeUdiBuKSI2xdVfXtGeWWd98TlVcAGeJtDErc
         /UDU7SweYcbh/LzSvEZt1wU8xYdG9ptFCEH0gzLJA9+aYGPeqA/2LI9XVUoIy1VlZKLT
         58WqhRMjTfAJhcPi/4w+j/BIfyKIIT7Z5Nb3PhCRSQkEm3b+s/a3e1xvmHY6JrFWTsFc
         +X/UX896GM2tRPvEZYbOxtHOE2YncMhSxJog+Pal9wC8CTZhjf17O6CUdmavRogJifaC
         TXIPjfw8oVAqGpea34l343hCiASlIgoh+HtEtt0yGMMXobCgNzP2xk8zU6kWG26R/t2s
         +M5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773144447; x=1773749247; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T8dYRLYkwn5kBNWo/bm2c1XHhtT3zdHO3dRrnUAcL10=;
        b=r/XGqYvoXIEViqUB4FEx6KRzS3P4ToiYqPYoLeein27DTdBwQzGrF62wHYjwTHG/WY
         7vS2DeNOA0aZnrMIwsInalrXS6/GAct271oPH80Ht7oYLGESH1SImfgQCFDlbs2imujD
         8Vavr+Pj9up0Vv1Yg6nTaAVh/Ub2IfMswu5nzjGX3DTeqPyun5ydH6XMpOjgdHQe+OWJ
         C1Gqbr/HT1VtKAUmLAjHGOLKbAo8qT6oAlyXY1MhL2nAG1qn5keQMWs2qSBpTUbUuOZL
         Tqse109HWKddniYA9ZJWlyHU+e6i9mxSD+17GLpe2kUkfVDwqJaXXoQph5Fxyti19L7K
         oMdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773144447; x=1773749247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T8dYRLYkwn5kBNWo/bm2c1XHhtT3zdHO3dRrnUAcL10=;
        b=XnpzYoeE0aALgsqeR2SORX0kOuZo7gpdSBns0nSas4v2bvqM45Rj1AI8DIelRJP0Ub
         czkPwuMuCxsKFri8lYAcxR8IOMvhSgTzUFJ9PT45gRz62veGKCbtLd6YALVFZTw+lUpy
         tQK8OumsHolQqJL8xdtxOvMQd6LFidwmGgnkDC7LtCoI5CpVN/BgOrpV8tFcCUuR1vnb
         4oCrt3jBkRR52NIkqWeYgoTWmCVm/+1C5XRnEFThO4rKfMbuKU5o4HorNvI7PbKLgsq8
         z33WOL3AKUHi8ZhTlYiCTpBvkAgqL7cj1lwegNwSyaFrefVuslY8D7D7+GnR1zRrMsao
         PNIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUR4KTFBhiigQX9Fr2fm2GMKruN+MvzPpAVGKvC7keh17sNbkEfaIcvkOcvtNV5gsHCmsY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3qkG0XMNQCRBtZrrEW2U32s7N0ajHaXEbatC2616PXmDjnm1B
	2kjmVtQNAmlZuX4X2o3ZFz+nhM1Yg8yDV+aPu2NdWtrCHgazvBjEe3tMUGJqYiBlmKAt8f2XIXQ
	NyKNfhWRmrSPWMJ9VnIlkZjjuED0GceMJnrKr0oWw
X-Gm-Gg: ATEYQzycbGn5h3uzqPTGtnOEIN1NgXwIm6R4uk+3hJ2ZRKADHc8XK0eKaEIwqJXu7SW
	/u3DswaKKzbekbsAuDpi1VxUi/cNqSzbKZjJm9WzDDiI8yO60rOZ0WkKQFCB8v2I1HBOID24ubg
	+rK0wdnFVdJnyid5TZC39B0oYUMI7MmDWAfvWZDZg5qOcvCsti28Zgpglv7kbuas14DZJLJcxFz
	lmmVtix2dV+jBfgH3dpRA0mKsq59H1E/5vB3/dmQ3n7chTSmFWuMxdvKL9r3GiEytrebwee6wt2
	DhI7TbE=
X-Received: by 2002:a05:620a:4694:b0:8cd:8635:c04f with SMTP id
 af79cd13be357-8cd8635c58emr871773185a.78.1773144446171; Tue, 10 Mar 2026
 05:07:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309030702.128520-1-jiayuan.chen@linux.dev>
 <20260309030702.128520-2-jiayuan.chen@linux.dev> <abAFRbJNinhN3O5v@penguin> <CANn89i+5yOzdiBTWm4ekc0UvMxQp=mhXbz0rU5WnfxEu3NrAhg@mail.gmail.com>
In-Reply-To: <CANn89i+5yOzdiBTWm4ekc0UvMxQp=mhXbz0rU5WnfxEu3NrAhg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 10 Mar 2026 13:07:15 +0100
X-Gm-Features: AaiRm52YArIdW70Cdt1Zn-0xdLt1wQ__GHo4CYwly7pfLRtB5zsOkc7ncB8Yknc
Message-ID: <CANn89iLOyWzWW7w262Vsy2MOMVDXA0+UZGpEbsdLwe6e75mhKQ@mail.gmail.com>
Subject: Re: [PATCH net v5 1/2] bonding: fix null-ptr-deref in bond_rr_gen_slave_id()
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org, jiayuan.chen@shopee.com, 
	syzbot+80e046b8da2820b6ba73@syzkaller.appspotmail.com, 
	Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Jussi Maki <joamaki@gmail.com>, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 1:00=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Tue, Mar 10, 2026 at 12:49=E2=80=AFPM Nikolay Aleksandrov
> <razor@blackwall.org> wrote:
> >
> > On Mon, Mar 09, 2026 at 11:06:58AM +0800, Jiayuan Chen wrote:
> > > From: Jiayuan Chen <jiayuan.chen@shopee.com>
> > >
> > > bond_rr_gen_slave_id() dereferences bond->rr_tx_counter without a NUL=
L
> > > check. rr_tx_counter is a per-CPU counter only allocated in bond_open=
()
> > > when the bond mode is round-robin. If the bond device was never broug=
ht
> > > up, rr_tx_counter remains NULL, causing a null-ptr-deref.
> > >
> > > The XDP redirect path can reach this code even when the bond is not u=
p:
> > > bpf_master_redirect_enabled_key is a global static key, so when any b=
ond
> > > device has native XDP attached, the XDP_TX -> xdp_master_redirect()
> > > interception is enabled for all bond slaves system-wide. This allows =
the
> > > path xdp_master_redirect() -> bond_xdp_get_xmit_slave() ->
> > > bond_xdp_xmit_roundrobin_slave_get() -> bond_rr_gen_slave_id() to be
> > > reached on a bond that was never opened.
> > >
> > > Fix this by adding a NULL check with unlikely() in bond_rr_gen_slave_=
id()
> > > before dereferencing rr_tx_counter. When rr_tx_counter is NULL (bond =
was
> > > never opened), fall back to get_random_u32() for slave selection. The
> > > allocation in bond_open() is kept, with WRITE_ONCE() added to safely
> > > publish the pointer to the XDP read side. A plain read suffices for t=
he
> > > !bond->rr_tx_counter guard in bond_open() itself, as bond_open() runs
> > > under RTNL lock and is the only writer of rr_tx_counter.
> > >
> > > Fixes: 879af96ffd72 ("net, core: Add support for XDP redirection to s=
lave device")
> > > Reported-by: syzbot+80e046b8da2820b6ba73@syzkaller.appspotmail.com
> > > Closes: https://lore.kernel.org/all/698f84c6.a70a0220.2c38d7.00cc.GAE=
@google.com/T/
> > > Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
> > > ---
> > >  drivers/net/bonding/bond_main.c | 9 +++++++--
> > >  1 file changed, 7 insertions(+), 2 deletions(-)
> > >
> >
> > This is Jay's patch + the unlikely change, looks good to me.
> > Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
>
> Orthogonal to this patch  :
>
>  get_random_u32() typical cost is around 10 to 20 ns, I really wonder
> if this makes sense
> for the packets_per_slave =3D=3D 0 or 1 case to haves this kind of
> randomness in the first place.
>
> Perhaps we could use a
>
> static DEFINE_PER_CPU(u32, rr_tx_counter)
>
> And :
>  slave_id =3D this_cpu_inc_return(rr_tx_counter);

I also have mixed feelings about this patch.

We probably should detect that the device is not ready before hitting
something deeper in the stack.

Sure, a NULL deref is avoided, bu what happens next ?

We send a packet while the device is not UP, I am pretty sure this
violates at least some RCU rules in device dismantling.
