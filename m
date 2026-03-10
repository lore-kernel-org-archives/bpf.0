Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECC039C007
	for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 12:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773144046; cv=pass; b=t86C2M4Zh5bXkoRBr6OlWghVqZkzuWxQWrPH9wKCU9HbRpIJRXWoh3iCMPDgx4rXnkhnXXDA/hJcE5IhJKvl8W6xY8JiKk4p5h1I3uZkO31qh5KzXqzb1ZZrdpeiP3fdvNOTZkG5jel3pFgx/SHry+Rz6SMHVt9kpY/VQhPcDLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773144046; c=relaxed/simple;
	bh=tUzR/Nakid06crM4rvRZ4qf7nSgbgsUvkFMtzxj2kjk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y1SrqutDXIx61gHtY0OxFW4qslXPmBSp/7qevIN/MyqS28SEuPtiV9yKDemg2fqhzE8ZzndnUC7f51BRlyVgw/JHzNcMMceAob1lb0espaGm5kmydGb8yLoaJDidq1vVU0Pu1W5D4ZkyJIdVFD7pH08ZQh+PQix4YN108D5w/NU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qwj+tuCL; arc=pass smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qwj+tuCL"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8cbb6d5f780so1288837285a.1
        for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 05:00:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773144044; cv=none;
        d=google.com; s=arc-20240605;
        b=fx836Ek95Ukn8TQhmzFvmd6bKcoiISzX0JfvyY3hWxkGin8l/ogBTeykIRfl+ND9Gy
         j/V7+r4gi56cNpBCi/J+Ttiomk9/L/u3BBHBMTGPBPbVCki/aelSyMMgI1RcmM6uYsdx
         4z+9xODckc8B3humzzjdlC4x0wBuPB3n974STNrW4n2xup2tk/sMa3C7wgQi24kNBcyn
         wzg3qeGhjrp47kybE5OukenNFDwLIWa2rMG8MJkdH6aZd+/xa2jr5kdiwak/Ub9JmlCm
         W7a9tXtWz4tuieO+S5v4vjPRIFUcCG4VuHnNrcO7aLBpnc/GpEGU9iZonbUu1kuXWOpX
         q3Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+KiPLCC30cbrBmI3zXpnvU6YblX0b2+xRJJpwJf5O1Q=;
        fh=4NP7FjKmEpbNXtYvj36biTL17g+KZn8Y/AvOJj0DYB4=;
        b=NWNuvZH98CyxtY0ibtyPx++G7LYtgWJnfQXN2cVZEisgyHKLOzUzWumiOUL6tvMFk8
         gOB77wZOixfnMHo57/18pLwzuo381xafLIHKg7BtZG7quHyT9hINx/jiBXdzFOJBZfM9
         Z+bQSC9/ydQIf2UE5tU8mXk0ILZmyGTzzXk/zthIgBwSEPQcewgvAezFsYMJQsf6104/
         CE4yceVjq1xwGZ7UTNOqc8IGWT0NKlnPUVhW5Uk0sinxMaMF3C1GdUGO6Yi7DHzjYtTz
         MPRQCMMKLZBdd2jcpkVpa02C7HFTFIOs6UAYcYcc9gcXjJpnOzUEm1DO8X0J9jU0bFaW
         DB4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773144044; x=1773748844; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+KiPLCC30cbrBmI3zXpnvU6YblX0b2+xRJJpwJf5O1Q=;
        b=Qwj+tuCLktJKd0NoRvrjoLMdfDN9uUn5J69tYo/ziS4U+8A9ezz8TvdBX2SWtr+1o0
         oVrumKUp0Zr06B6f07CBVqtxVIzVUHFpLnBrQ/iWqvCkNT/HPvlN1O8vOWrhEypQU8w4
         IWUQ4EpYm62MLVZun2Hqw7gFQSF06mk+wJoEu988bT3cb/S+/CkaYRoil786ZN+JHmfG
         nRdHS2JGd4v1x/ir5L/8ofnKCgwYyqtv769MzCapTxmDlXq5OoTHqgF06GbfTP5YpnZF
         tTtjQKbU9lAutMiUPerFYih1jbQIYxYNuOvmU25VyyIEIzuV6D1ua1CnW3jyDK41LJPm
         LpRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773144044; x=1773748844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+KiPLCC30cbrBmI3zXpnvU6YblX0b2+xRJJpwJf5O1Q=;
        b=RBDsXdCw2Zw4QNFqWMz+0EC4Wq9ygVfLYyZy0dTQsTTPMSNWCRTCBZj9WXc5QwB3ls
         9NFB4Ayey7QwXtbWbmP7GOiisxe+8mLN9RHF0SmZof5FCuNR+NO920UUKFxtyw6d6DcA
         8c8Ouh08kGSnbSoSBR4oihHLO96zJjd/gZre1o0EZd+k4YQ9+9JtFOYUHUStpVNQKumY
         NPljoHDlOPXSK3kaquWPim4oi1U/th8isxXA7YATP43AQnQ7dltozszexBwTApDjJylc
         Qx/8qnItsi1EdFcM/ZeSNSSZJ73Ej6rbQtTQTPdc/AXDU0YZyTyMDo1qxydzkIo7acIv
         7zmA==
X-Forwarded-Encrypted: i=1; AJvYcCXx5hMSVxyZD4exR6f/yhFbvgYiwWD4L30j42LNqQz4KlB3WUD4VOmdS5+U56swJUCIbX8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCiiFszkviDcfiVRFr4lzWF/UXznM8BwI3/+F1xeBX6qDYdwp+
	YDa193bjUm3C3nC9jWXF5CNC3H0LotUCXaeHSBdYtwdzh26qvh9KQa89onLXrJo44X6s8uef5ft
	b1DxeRkoc+8LYNzcoyAbWhK8gRh69qebwhzs7Mh2A
X-Gm-Gg: ATEYQzxjcZl1cpN0dmNcJffEov2auH5S5+lRx4x7E8Wnn6N8V1nQxSCYVM3PuqxNxIi
	xmidx1lZ/cbsGpP6QTKWL5s6sleZSfr3J5txa8Z3NH3OyXM3RGKwzgBtM2U9mPP02++c1CVmdvF
	QqwPW2eqiz1fa/In1m8M4b04YdmPrBfbnmBa9BDWbT4kFGS9CsOBfApAf7IadcbQtYaZwmv6b3G
	PlvzeaPG5CYPI+XbwKNMoB3as9Q0jC7Ig+L53vB0G3zF/+FWIgS0sWqh39j3uZ8hzqm17r3mo4k
	+g3JXPM=
X-Received: by 2002:a05:622a:1a9d:b0:509:22ac:99ca with SMTP id
 d75a77b69052e-50922aca02amr50931071cf.36.1773144042675; Tue, 10 Mar 2026
 05:00:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309030702.128520-1-jiayuan.chen@linux.dev>
 <20260309030702.128520-2-jiayuan.chen@linux.dev> <abAFRbJNinhN3O5v@penguin>
In-Reply-To: <abAFRbJNinhN3O5v@penguin>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 10 Mar 2026 13:00:30 +0100
X-Gm-Features: AaiRm509jDZ3zVYhIbanKsEufYLYkGg_h_Pmpop0SOjPwGN3a_7GxccBpHV9Ooo
Message-ID: <CANn89i+5yOzdiBTWm4ekc0UvMxQp=mhXbz0rU5WnfxEu3NrAhg@mail.gmail.com>
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

On Tue, Mar 10, 2026 at 12:49=E2=80=AFPM Nikolay Aleksandrov
<razor@blackwall.org> wrote:
>
> On Mon, Mar 09, 2026 at 11:06:58AM +0800, Jiayuan Chen wrote:
> > From: Jiayuan Chen <jiayuan.chen@shopee.com>
> >
> > bond_rr_gen_slave_id() dereferences bond->rr_tx_counter without a NULL
> > check. rr_tx_counter is a per-CPU counter only allocated in bond_open()
> > when the bond mode is round-robin. If the bond device was never brought
> > up, rr_tx_counter remains NULL, causing a null-ptr-deref.
> >
> > The XDP redirect path can reach this code even when the bond is not up:
> > bpf_master_redirect_enabled_key is a global static key, so when any bon=
d
> > device has native XDP attached, the XDP_TX -> xdp_master_redirect()
> > interception is enabled for all bond slaves system-wide. This allows th=
e
> > path xdp_master_redirect() -> bond_xdp_get_xmit_slave() ->
> > bond_xdp_xmit_roundrobin_slave_get() -> bond_rr_gen_slave_id() to be
> > reached on a bond that was never opened.
> >
> > Fix this by adding a NULL check with unlikely() in bond_rr_gen_slave_id=
()
> > before dereferencing rr_tx_counter. When rr_tx_counter is NULL (bond wa=
s
> > never opened), fall back to get_random_u32() for slave selection. The
> > allocation in bond_open() is kept, with WRITE_ONCE() added to safely
> > publish the pointer to the XDP read side. A plain read suffices for the
> > !bond->rr_tx_counter guard in bond_open() itself, as bond_open() runs
> > under RTNL lock and is the only writer of rr_tx_counter.
> >
> > Fixes: 879af96ffd72 ("net, core: Add support for XDP redirection to sla=
ve device")
> > Reported-by: syzbot+80e046b8da2820b6ba73@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/all/698f84c6.a70a0220.2c38d7.00cc.GAE@g=
oogle.com/T/
> > Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
> > ---
> >  drivers/net/bonding/bond_main.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >
>
> This is Jay's patch + the unlikely change, looks good to me.
> Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

Orthogonal to this patch  :

 get_random_u32() typical cost is around 10 to 20 ns, I really wonder
if this makes sense
for the packets_per_slave =3D=3D 0 or 1 case to haves this kind of
randomness in the first place.

Perhaps we could use a

static DEFINE_PER_CPU(u32, rr_tx_counter)

And :
 slave_id =3D this_cpu_inc_return(rr_tx_counter);
