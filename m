Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1942FD1B3
	for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 06:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790489633; cv=pass; b=ttJlEYm9qLMfG8wXpN4HoIwEGGqaC8bmsXMUS85kHJUUUrRKniEvTAlnzi0oQVZGsxtUu1jYLuk9uUpNA5RgZOIm4/kkjj/NpGrE9VVMD1iJZkHXtoTGC3iikzUt+NTa+Pfqp1WDyQG8hR6QIWsVoglNJPSDgTpbyWQuATZz4Ks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790489633; c=relaxed/simple;
	bh=sr4Z3lGmEaVF984a2Rc9vpNw3cyNxpoqGCKnkWqzbnA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eTzbZhKzkjnQliTIqp5ordaOKyf+KwcKJowWl2h0P/nn3Eyj3uM5z+2wJ5bjpVHDiJrUcKOzPgvejTzDGkkJ+0iVnsKIdBjwkwbmOpqHGpeFXpGpT1e4eU76Zlhb1hMt8ot7yhhI6cHBogPH7qwx4rzpiJAiMjYK1JrSNXwWnkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BIfo6Fdf; arc=pass smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BIfo6Fdf"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-3115c4451c8so1673793eec.1
        for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 23:13:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790489631; cv=none;
        d=google.com; s=arc-20260327;
        b=c3/7Bb3PVmE6dOBuSIYJ8TGpKF2FVAb0w3mAlLwUvNgsXIyhwBH6HUgelf2q0Jv74a
         Q5iynrrNTEQU7isqhD2sUUckTM1FB70sxzf8dlhSi/7HyQvdd5BW4V1jCEJmnKvoWM4s
         nhLhJy8ZaOhhv+3efPMJxuT7ZYwDxh8NVtEqHG1tNb0NTEjnxPdRWYPXlVSbu2vVjejF
         Y/F79krhy+tev00JeImVa7hDnD0SJ2O+9lyedNtYbr9AB2tCtK9eBnHeh6wTFsvkOQCa
         ywIEJlxbIdTjZH44yrh3q0T53FXIaYhxYPjFg28S+wcxhARaAC5K3kYB5V4L3pzNyzbg
         amEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sr4Z3lGmEaVF984a2Rc9vpNw3cyNxpoqGCKnkWqzbnA=;
        fh=DLFiSZ/WBTVmOrzBD8besMEWnoG795Mc2ZYrxwtUgTc=;
        b=sOCw+YWK2t64P978FtNRxN+S4HM0a+gF0XPQmtuuqjIv717K5jqFMWztGBDQVUahdL
         ANpdYNlWF0QJQ1Ad5NAtdTYCdKrbFvuxzfBBX+h/PTDCUQPTuOCgxpvtjlLmjI+HHfGP
         au4oNTKjDOIaHe9MN1HxJhY9KVHesNSaDzZ9hNFzAGh46ZzrSmOMRW3pQDxq4ag2Ka1Y
         lx1jyJqPmSxUuWA8C/x+Oie1ws4STU+42DvUnvWjmF0xDmA50rgdaJz/B/gzHkiqevqZ
         MhPWvCWd06skeJK/IxmfbN6TzND9LrQgbkRCJVcDelw0EvA3gGCEvTV/ijGn352nZ/Sf
         LxkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790489631; x=1791094431; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sr4Z3lGmEaVF984a2Rc9vpNw3cyNxpoqGCKnkWqzbnA=;
        b=BIfo6FdfW9YzBUAJa9Bh2IkhjazzGe+0+EQjjp6qGgaX1iZh1DITClCAsvFsqSPItb
         8wBDm5wjaEaXpnuQxIjrgCwiTxh1I61CSJJFpOZ3XaPIxYPvrF3qqExFN2TvCTeRZDBy
         6D/dT0ULYH5jPQnbr4/azQewLJDbiAbkbroStRxmnwiCBEAx1WdiSQ4GEnd+lh0P0vDc
         7nKuvr6p3ok/0usRu9JxwASvwdedRH16cCuKmW+pjrIdpuOV7cYEBNBGFllg2YFWYVKf
         riuSpebv7OkVe0JvF79wIdpxuDoh4ao4VYBnash6MMhr+mZhd/yxoTMhDESzkTFIjOPt
         uE4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790489631; x=1791094431;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sr4Z3lGmEaVF984a2Rc9vpNw3cyNxpoqGCKnkWqzbnA=;
        b=s9Ik0EmqgC/PIPgAIl/itGA8GDHnachHcwFB/R4RzFhXCMi+dY2vjAuFzw+/fi5YC2
         vzglrQIz+3mzcZWBFety9jvWuoD3zodYRPSsO7mizJHDt0Cv0B4RJ8a6NeUabeqcRkMt
         vRxCkgjXLD2MJC6gccwnR/NpBZCtM44PaYXI44d+EqJNQweChnVrk0tC5mDRzyve6IDW
         zbL0H/Ak/jtSmS2WmIhQAilPpnT02JuYVoco3yKjSjBfILXoiuliROcDwVE7smCXdxt3
         0nJoh84dwQNwdv8tFwxT1Nki8YEq/aFpk3rPNnU3EMqmN2NhCJVKHZrU8rAKHAuk2Z1t
         9B5w==
X-Gm-Message-State: AFq9FYJOBFTY3u0Ie91PW4ysJXGYpa20wrVT3nah2i783jsukGrOgh82
	eHZOpmHoMjrPC5R2deVSfOJgd7dwD48IjdAv4PFdH9WcmO4+MG5gqZFZDse3g9Hx5ZCusy0kPXX
	+ucp61putJMta4hHfhy5GZVilu6BUF60=
X-Gm-Gg: AYBFou3oFFQh9y865YUO3+ZdDZ49GCzWfqbxNF2ypPX4yxSkO6mS5k5cQ+uSXAh21yD
	o1/7XyMOMYRpjDOE4sjuGWdb6mY5grWUdoL5HZhz1yvUkrzBu5f94wdPCAeXPMDCqVUN6goOLms
	s13/pVyM1Z5VynDueyGlNFi+0CEu2apcYpqMqMRYx2MM27jQsMmlZsrG+sBE38DcZVs/xsIGik+
	Z3wNz370r9Ij/5Oq8DOOHXIhlS1/1srPK3vj5aVOcywX/5BSzVv7issz8WogoK0+SGR3s86zC4o
	qxxL72fL0ssFb2jXQE5RkRuLcYNEacQTq5LyTEJ2wYSlv6qlprOa/Rg=
X-Received: by 2002:a05:7301:7107:b0:341:2c6b:8c97 with SMTP id
 5a478bee46e88-34270ab8e8bmr4558045eec.12.1790489631424; Sat, 26 Sep 2026
 23:13:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260926210757.2152159-1-thisseanzhang@gmail.com> <DLPTN52TGGMY.TPWL2GZA38RK@gmail.com>
In-Reply-To: <DLPTN52TGGMY.TPWL2GZA38RK@gmail.com>
From: Sean zhang <thisseanzhang@gmail.com>
Date: Sat, 26 Sep 2026 23:13:38 -0700
X-Gm-Features: AclHuK8wXN2xAfp9zc6K6pU-EYUnBl-bodxzJ1vo68HRxFJW1oVa3YT6t8_CCik
Message-ID: <CAEejd4QjwcjMNKuwDYBV_u4XJ_CfzGZGR5MXGtOgM+BoAMP23w@mail.gmail.com>
Subject: Re: [RFC bpf-next 0/3] bpf: Add PPPoE encap/decap support to bpf_skb_adjust_room
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, netdev@vger.kernel.org, 
	Nick Hudson <nhudson@akamai.com>, Felix Fietkau <nbd@openwrt.org>, Qingfang Deng <dqfext@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Alexei Starovoitov <alexei.starovoitov@gmail.com> =E4=BA=8E2026=E5=B9=B49=
=E6=9C=8826=E6=97=A5=E5=91=A8=E5=85=AD 21:41=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sat Sep 26, 2026 at 9:07 PM UTC, ThisSeanZhang wrote:
> > Hello,
> >
> > This series adds PPPoE session encapsulation and decapsulation support =
to
> > bpf_skb_adjust_room(), allowing TC BPF programs to update packet data a=
nd
> > skb metadata consistently.
>
> Why?
> Is this a research project on what llm can implement?
> It certainly can, but it's not a reason to add new uapi.
>
> pw-bot: cr
>

Hi Alexei,

The use case comes from Landscape, an eBPF router I maintain. Its native
PPPoE WAN mode is implemented in XDP/TC BPF.

The motivation is a bug we hit: forwarded GSO packets larger than the
negotiated PPPoE MTU are dropped after the TC program inserts the PPPoE
header, because the stack cannot segment a PPPoE frame. This was
reported in https://github.com/ThisSeanZhang/landscape/issues/57

The reason is that the PPPoE metadata transition cannot be expressed
from BPF today: bpf_skb_adjust_room() cannot set
skb->protocol =3D=3D ETH_P_PPP_SES, so an eBPF datapath cannot use the
kernel's PPPoE GSO/GRO support (55a5d8fca836). Our egress program uses
BPF_F_ADJ_ROOM_ENCAP_L3_IPV4/IPV6 as a workaround [1], which marks the
skb as IP-in-IP (skb->encapsulation, SKB_GSO_IPXIP4/6) while the wire
format is PPPoE. On decapsulation, a TC program similarly cannot restore
skb->protocol to the inner protocol.

The flags in this series let the helper make these transitions for
skb-based datapaths; if this support is merged, we plan to switch
Landscape to the new flags.

[1] https://github.com/ThisSeanZhang/landscape/blob/80bc43eef7143ad029283fe=
2a8d510718c22af12/landscape-ebpf/src/bpf/tc_chain/tc_pppoe.bpf.c#L38-L47
