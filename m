Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E673A1624C0
	for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 01:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782091704; cv=pass; b=Wbj3MEGsKRYoZknmQDgZZyInGAEpIIMwHx1XCxC334zfCuxD+embxbzlcKks/h5IVk6eab2Ob3eEnR5Y/h3r++/kxJ+rhM8VWegS/VBy17xmtF2FIgtHQf22i4ejduIdUoVNu/yWh844haZmUPr6UWD7tBIaKr52QR7nK7ft2A0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782091704; c=relaxed/simple;
	bh=tgh+VzXXlhm0LYKlwIeBR1BDOYHFLT8CHRa+H/14YHA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oZBoaf5JUMaooaV6o5vgAB4uiuojya3dt+LeDwmHIL5WceKyVO/rcagfEmX+TnY7oMzee0R1VMg3kia5bAjS9qU96QEOuB4AAE5cOimRqjMHl2ErDdlOtnfbc9tdCD7HudUDNkJdKNstYKkJDgWVvQwwN7HD/VEnfk/v35ZwvXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=W7KCNSx6; arc=pass smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="W7KCNSx6"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-36b9ec98144so2563865a91.1
        for <bpf@vger.kernel.org>; Sun, 21 Jun 2026 18:28:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782091701; cv=none;
        d=google.com; s=arc-20240605;
        b=N5AHkJBudSTK32Ti7fwcnLsHnYt+UmjytVMbdKZjmK3mElqKhI4z/Cw61aEkzX0jzc
         rYBQDO60IHHcme93AvZRZvOHJSvZVOUvQt3yfcE011lsFthuL92W0ZUOG3ncye2Ctsgv
         MTXkoEmK1OpqSCYa3oXVHYuz9dgUfVH4QUBD4CEEADCuSx59br/tjzchCctDj39njJAV
         GaoD9sEy3ZpxPpRk16ll0NXUNxVONs14Ta+6IjD675kA5yImr24R1i7KO2tv75GlvdR4
         61+uS8q22U52UDQRiV0DtP0LboJWqH5QvOtLciEFcXDs+0ExUqE3FkPbEsfPS+mKPx81
         J8bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=beBTWQSBCFVdWZZAOBgHCAquwbN4DDYp/feIkLNumIo=;
        fh=oVXbVZCoo7fnc5tS+mlk6FvrIhxZxvdGBdH5N+JE8YE=;
        b=CKLsjA++PaBfXLn+48PCObppu3mTuXNTcNxYqppn9Snq5TTeruvpQl0znY23bFMA+O
         QazZ1nAjZ9fiNOFU6sizrs8VUNeoGtbu/GJLywhzACspTQPXBCrI4NqjfGsd6BWvsdaU
         dlIRzMsqBGKJJwaKmNugW2o0CiaKE6K0svEM+d9N6QxYDBxfg1dvsMEMUU4MEeUiGe8Z
         vN486m3VZ/46xepX4inVHdOUEYxl1NNcV+qCwC2hBTx5tsySWKxMMgJ9x5no045mZcX1
         DoIrOA74TO66TtQW/WHULbl6fjIJFuH8uj2vW9p+SBgk8CA8vdeuarwA7QnGPmNOcmWU
         mGwg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1782091701; x=1782696501; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=beBTWQSBCFVdWZZAOBgHCAquwbN4DDYp/feIkLNumIo=;
        b=W7KCNSx6kgrPOHUEJjHc8N8Uf26ixl0I55qMY+1NBbtmy1w6oKsaeCy3bnawKTDTHl
         GsRsLZW1sqwF9e9dbo/oNLM8m9FY7cm5+4OldVdBSPOHcBsWl/BSmtfApvKRrLfULvRZ
         f6ptXltI3OkvwA1VRs408NykxaK6yTHxqVp6S8ztGwv/J00H/0lL2tBglDwiostVv1ca
         LXLjvoGYv7G9NiXRySdA7tlCZOys03Gr3Tnpn8H4Fs1XLENFoQLkVP4WDnqSacRg1rsZ
         1vvBguwIkcEqjLFw/pnpiNw0/mIJXnQx3V8zIebZqywK7QOoI+qnHNjVBVuXBNeFgOaK
         tzFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782091701; x=1782696501;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=beBTWQSBCFVdWZZAOBgHCAquwbN4DDYp/feIkLNumIo=;
        b=oFKV8/JY0eygvd/D0idsbDriPUhx94n3t9jORmgEpWAWDBZ9iaKjx8p+w1L0j/F8ba
         fS7AiLX2jnVKMmPBIjsmmQilK1iYE+QJ1fjH/BhhNuWMo8DQDv2zN726StDRDA/JcHrw
         z/YT4urohuOGP0WtLpsB7FxIgJHNUuxaK/smKZGpsRsgulAiVxNsX1TxkznyMas1FPWD
         MMqg50Ea28VNYVjGV2SCWtcKUO4UzemVNUO0Xz42CJjsGnQgOQmR0H4tqheqwf2cKXGc
         cMYsyA4VYl0ZGwdxZgfIiAO46MLqG5qoW4MGoLLXHIJpfR8MshGo4C4pAgpnG3OMdhrt
         kzXA==
X-Forwarded-Encrypted: i=1; AFNElJ90eVkgoy5mAyTWpTbxTVgvyOF6DhLQVIwDjOAK2SmqGodmswB3Ds/mwEWBBPpUj9Lyvqk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yymd/DW+AlhJ5m/DIY9YYg1G2rPfzO72t/RxU2yKpFhBoAPjalh
	CLj2YGHJca2Z88FH06s8UsTIMK/w2kXn2kurRjfh10lQM1t/VGQXqpbL6iGRKorvPwWQKqRY2vy
	gaNQMIZM3Xmzq61kXfbeZAc3WCLbwb2zsawi8Uoy1
X-Gm-Gg: AfdE7cnIf68wit9Emwlkm/44y4fOy/lPOUFSvD/F6YrfSU3QlCh2VCwKl686JG43FgQ
	XLUdSgDrzqdOHcuFKkxMtLbH6K+0pXfVgcIWKZC1Ij3CeNdpXSWdW+RrW9hGhmbqRNkfSA174Lq
	30EbXuKXyGy2BKzP8uoAiLR/lZzX6yD2bXDXkmBb8PrkRWyZqfv8zi2VL94lZDqbRGNUvgoZGiS
	sBO12PI2Lj5GfeEd8akDNlwRMf4yBoMgtdybMKYG7dPZBbtTPXGQSsWliN0IKog+IpSm5EQPHiW
	6YJy2M1ibcBs43HHgN7s0DUXRtU=
X-Received: by 2002:a05:6a20:3d22:b0:3aa:c964:3c27 with SMTP id
 adf61e73a8af0-3bc5420cd6bmr8405125637.46.1782091701250; Sun, 21 Jun 2026
 18:28:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260620201531.180123-1-xmei5@asu.edu> <7791b9cc-86f4-424b-aa1a-d1a869814130@linux.dev>
In-Reply-To: <7791b9cc-86f4-424b-aa1a-d1a869814130@linux.dev>
From: Xiang Mei <xmei5@asu.edu>
Date: Sun, 21 Jun 2026 18:28:09 -0700
X-Gm-Features: AVVi8CdHEGHw1ieyaPQJyikAla7flQIZKU8leUwwTjiuGepgTdWlPi30tiNX8kY
Message-ID: <CAPpSM+TRJaqSSUs6tBp_CBSVUJMiDZm01o5BK6aCNak8vuQi+w@mail.gmail.com>
Subject: Re: [PATCH net] net, bpf: check master for NULL in xdp_master_redirect()
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Alexei Starovoitov <ast@kernel.org>, Jussi Maki <joamaki@gmail.com>, Paolo Abeni <pabeni@redhat.com>, 
	Weiming Shi <bestswngs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 21, 2026 at 6:21=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
>
> On 6/21/26 4:15 AM, Xiang Mei wrote:
> > xdp_master_redirect() dereferences the result of
> > netdev_master_upper_dev_get_rcu() without a NULL check, but that helper
> > returns NULL when the receiving device has no upper-master adjacency.
> >
> > The reach guard only checks netif_is_bond_slave(). On bond slave releas=
e
> > bond_upper_dev_unlink() drops the upper-master adjacency before clearin=
g
> > IFF_SLAVE, so an XDP_TX reaching xdp_master_redirect() in that window
> > still passes netif_is_bond_slave() while master is already NULL, and
> > faults on master->flags at offset 0xb0:
> >
> >    BUG: kernel NULL pointer dereference, address: 00000000000000b0
> >    RIP: 0010:xdp_master_redirect (net/core/filter.c:4432)
> >    Call Trace:
> >     xdp_master_redirect (net/core/filter.c:4432)
> >     bpf_prog_run_generic_xdp (include/net/xdp.h:700)
> >     do_xdp_generic (net/core/dev.c:5608)
> >     __netif_receive_skb_one_core (net/core/dev.c:6204)
> >     process_backlog (net/core/dev.c:6319)
> >     __napi_poll (net/core/dev.c:7729)
> >     net_rx_action (net/core/dev.c:7792)
> >     handle_softirqs (kernel/softirq.c:622)
> >     __dev_queue_xmit (include/linux/bottom_half.h:33)
> >     packet_sendmsg (net/packet/af_packet.c:3082)
> >     __sys_sendto (net/socket.c:2252)
> >    Kernel panic - not syncing: Fatal exception in interrupt
> >
> > The missing check dates back to the original code; commit 1921f91298d1
> > ("net, bpf: fix null-ptr-deref in xdp_master_redirect() for down master=
")
> > later added the master->flags read where the fault now lands but kept t=
he
> > unconditional deref. Check master for NULL before use; a NULL master is
> > treated the same as one that is not up.
> >
> > Fixes: 879af96ffd72 ("net, core: Add support for XDP redirection to sla=
ve device")
> > Reported-by: Weiming Shi <bestswngs@gmail.com>
> > Assisted-by: Claude:claude-opus-4-8
> > Signed-off-by: Xiang Mei <xmei5@asu.edu>
> > ---
> >   net/core/filter.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index 40037413dd4e..6037860d5283 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -4430,7 +4430,7 @@ u32 xdp_master_redirect(struct xdp_buff *xdp)
> >       struct net_device *master, *slave;
> >
> >       master =3D netdev_master_upper_dev_get_rcu(xdp->rxq->dev);
> > -     if (unlikely(!(master->flags & IFF_UP)))
> > +     if (unlikely(!master || !(master->flags & IFF_UP)))
> >               return XDP_ABORTED;
>
>
> I recall that when I previously modified this code, I removed the
> !master check
>
> because this is on the fastpath. However, since this is a triggerable bug=
,
> I think adding it here is fine.
>
Thanks for the review. It's difficult to hit under normal statue, but
the bug is real.
We have triggered this bug with a PoC plus GDB to pause one thread (no
other `cheating').

(Theoretically) Race condition exploitation techniques such as expRace
[1] or CardShark [2] may help trigger it.

Xiang

[1]: https://www.usenix.org/conference/usenixsecurity21/presentation/lee-yo=
ochan
[2]: https://www.usenix.org/conference/usenixsecurity24/presentation/han-ti=
anshuo

> Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
>
