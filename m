Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEAD80033
	for <bpf@vger.kernel.org>; Mon, 25 Mar 2024 13:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711373596; cv=none; b=mGgFGdsK+dCVd55QRyY+7X/34dRy447Tu5VpJEENfat16l/JVc1TP0zg1cdwDySxF5MDBFrwfnQpf6sGqV9l6OLBwMauPpsImEQsgnmK+5X1bNeSw82vHCRxZAbH9AkKANYal8ky0VAudVfiDZxc+LxRTEMd2L08apb84Ok9MWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711373596; c=relaxed/simple;
	bh=PZ2b5uDrLchGLseW3tLESEPk08Ndqt3Gfo+ADY+bNH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JqnAiYJ+sVWi8xkGE3GwSgWWC4RJTz9GNApLI+8zBHdr7cAYpwsWzSS9/h6o29b0V3RmEhXiyGNvC+0rJlSp3pcbS32kyhCgyTnkYZREF/YZHH48VXBNRr9KR9ybJ+q7/jgzMP4xbPc6FORd8xYjtu2zIuO7BuVfkus+L0L2Qio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MZFie8KJ; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MZFie8KJ"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56bde8ea904so15399a12.0
        for <bpf@vger.kernel.org>; Mon, 25 Mar 2024 06:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711373593; x=1711978393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G9TDu4EJT9P9RuDeozlmDMQWaelM/ItTcO1/ff08eR4=;
        b=MZFie8KJ3TqmrhQ2KqGDBV1OLrndPBzJAZjn8xLIzV6tDQXJWLNQCE7K4ZZGz2/2jh
         dDRopIU0I19IiB0IS8ODGH7hE1TockGBwX61NgvkFyn5Fu2e9pqz2tvB4ANbX5aE2OzM
         Q7BiN4dhl2iSuuuBSuN53aUHpPPdnoQEjumB9TdHKm319boYH5+NfPTO7fzQfHp+dpDZ
         vCIOmL3PVb9TmU33zz85f+xvarFmvO9OkU2U85ZAHgHVfSEnHZ6ipsCM8Ynu0AF5/TK9
         hx9/3KOJmSLfhXZZRCG/OI02k4vfLK514OV/uIbkgUeI0xXhmz41GSs8GroRzeadmI75
         fKdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711373593; x=1711978393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G9TDu4EJT9P9RuDeozlmDMQWaelM/ItTcO1/ff08eR4=;
        b=cj/lgHNzJGNtHwzz85teq8Ceqd3zSYi76pmgDpx+nViX7LBlhWd6j84diZyR/jjm48
         nXIKHNN6bgjjOD1pHiqS+DOxHwmcIT6UfBx8u0aVOUkhaTNs1v4V16l+4kPTsFjjFp4R
         GhGt3R7WTG8VlXKP2DH90n2oRvN/MXur4t/OVAxltoBPPMt0kumgSMlEVP41Lqjuztyb
         XIy7x6C+RUXZu/Trux4i+umw9A9iRAZFszReWcUnA+nc3VYlWMJzgu4EMeq+n+qle2O7
         zMRiT7Xzip/4MQsBNL+6pxRc55MaM/YnG9iSBHF6ogJT5XBtMgxOhi6vGeRd8lJ7kbBL
         90Iw==
X-Forwarded-Encrypted: i=1; AJvYcCU9khVVOu66OhMrJ4tTp7h2HeBuycRFkHNhUpCHwDgBMIqEivHUI28oc9e6CkBosxfss7VvSfZcgEE1faG24Z1FpIMJ
X-Gm-Message-State: AOJu0YwpgOGVhTuCMs2PPu9DhIdCLLEaQ2gAvsEy3vD8+JIVsTVtklic
	u0IOwAoOwpYmBH940FeoIulDEhPY/QiYVX06knLly7wZK1davPsgSt6sjpJ5PKFQcsDqCxLJzse
	tjcXIvA2TNz21ZIO4Gwf+6j2VSBgshSpfAyuM
X-Google-Smtp-Source: AGHT+IEmBXEEGOIBB06ODeA1YAB7dw+8QWAHNDrJsBFBPzpflN0dddEyqAWZXjUyqs9WxFTvovIDODyg90yr5vB2i/g=
X-Received: by 2002:aa7:c441:0:b0:56c:d96:8db2 with SMTP id
 n1-20020aa7c441000000b0056c0d968db2mr124982edr.6.1711373592528; Mon, 25 Mar
 2024 06:33:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322122407.1329861-1-edumazet@google.com> <171111663201.19374.16295682760005551863.git-patchwork-notify@kernel.org>
 <CAADnVQJy+0=6ZuAz-7dwOPK3sN2QrPiAcxhtojh8p65j0TRNhg@mail.gmail.com>
In-Reply-To: <CAADnVQJy+0=6ZuAz-7dwOPK3sN2QrPiAcxhtojh8p65j0TRNhg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 25 Mar 2024 14:33:01 +0100
Message-ID: <CANn89iLSOeFGNogYMHbeLRC5kOwwArMz3d5_2hZmBn6fibyUhw@mail.gmail.com>
Subject: Re: [PATCH net] bpf: Don't redirect too small packets
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Guillaume Nault <gnault@redhat.com>
Cc: patchwork-bot+netdevbpf@kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Andrii Nakryiko <andrii@kernel.org>, 
	Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Eric Dumazet <eric.dumazet@gmail.com>, 
	syzbot+9e27778c0edc62cb97d8@syzkaller.appspotmail.com, 
	Stanislav Fomichev <sdf@google.com>, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 23, 2024 at 4:02=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Mar 22, 2024 at 7:10=E2=80=AFAM <patchwork-bot+netdevbpf@kernel.o=
rg> wrote:
> >
> > Hello:
> >
> > This patch was applied to bpf/bpf.git (master)
> > by Daniel Borkmann <daniel@iogearbox.net>:
> >
> > On Fri, 22 Mar 2024 12:24:07 +0000 you wrote:
> > > Some drivers ndo_start_xmit() expect a minimal size, as shown
> > > by various syzbot reports [1].
> > >
> > > Willem added in commit 217e6fa24ce2 ("net: introduce device min_heade=
r_len")
> > > the missing attribute that can be used by upper layers.
> > >
> > > We need to use it in __bpf_redirect_common().
>
> This patch broke empty_skb test:
> $ test_progs -t empty_skb
>
> test_empty_skb:FAIL:ret: veth ETH_HLEN+1 packet ingress
> [redirect_ingress] unexpected ret: veth ETH_HLEN+1 packet ingress
> [redirect_ingress]: actual -34 !=3D expected 0
> test_empty_skb:PASS:err: veth ETH_HLEN+1 packet ingress [redirect_egress]=
 0 nsec
> test_empty_skb:FAIL:ret: veth ETH_HLEN+1 packet ingress
> [redirect_egress] unexpected ret: veth ETH_HLEN+1 packet ingress
> [redirect_egress]: actual -34 !=3D expected 1
>
> And looking at the test I think it's not a test issue.
> This check
> if (unlikely(skb->len < dev->min_header_len))
> is rejecting more than it should.
>
> So I reverted this patch for now.

OK, it seems I missed __bpf_rx_skb() vs __bpf_tx_skb(), but even if I
move my sanity test in __bpf_tx_skb(),
the bpf test program still fails, I am suspecting the test needs to be adju=
sted.



diff --git a/net/core/filter.c b/net/core/filter.c
index 745697c08acb3a74721d26ee93389efa81e973a0..e9c0e2087a08f1d8afd2c3e8e78=
71ddc9231b76d
100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2128,6 +2128,12 @@ static inline int __bpf_tx_skb(struct
net_device *dev, struct sk_buff *skb)
                return -ENETDOWN;
        }

+       if (unlikely(skb->len < dev->min_header_len)) {
+               pr_err_once("__bpf_tx_skb skb->len=3D%u <
dev(%s)->min_header_len(%u)\n", skb->len, dev->name,
dev->min_header_len);
+               DO_ONCE_LITE(skb_dump, KERN_ERR, skb, false);
+               kfree_skb(skb);
+               return -ERANGE;
+       } // Note: this is before we change skb->dev
        skb->dev =3D dev;
        skb_set_redirected_noclear(skb, skb_at_tc_ingress(skb));
        skb_clear_tstamp(skb);


-->


test_empty_skb:FAIL:ret: veth ETH_HLEN+1 packet ingress
[redirect_egress] unexpected ret: veth ETH_HLEN+1 packet ingress
[redirect_egress]: actual -34 !=3D expected 1

[   58.382051] __bpf_tx_skb skb->len=3D1 < dev(veth0)->min_header_len(14)
[   58.382778] skb len=3D1 headroom=3D78 headlen=3D1 tailroom=3D113
               mac=3D(64,14) net=3D(78,-1) trans=3D-1
               shinfo(txflags=3D0 nr_frags=3D0 gso(size=3D0 type=3D0 segs=
=3D0))
               csum(0x0 ip_summed=3D0 complete_sw=3D0 valid=3D0 level=3D0)
               hash(0x0 sw=3D0 l4=3D0) proto=3D0x7f00 pkttype=3D0 iif=3D0

Note that veth driver is one of the few 'Ethernet' drivers that make
sure to get at least 14 bytes in the skb at ndo_start_xmit()
after commit 726e2c5929de841fdcef4e2bf995680688ae1b87 ("veth: Ensure
eth header is in skb's linear part")

BTW this last patch (changing veth) should have been done generically
from act_mirred

(We do not want to patch ~400 ethernet drivers in the tree)
