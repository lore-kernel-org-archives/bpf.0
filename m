Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9552B3A7F5D
	for <bpf@vger.kernel.org>; Mon,  8 Jun 2026 22:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780958105; cv=pass; b=ulgNHC/qTO4AsmEdjaKit4hLTK1s0YWMJCp16y9gCwIFI9GXo3VO9qIYQ0ooJbZTeQmTsFVUH3ajaNiXLcU8q/kVnxcx4VfYW6w8/c/sC+U47RLQopS0+X2zoyntnXpSfo975N9Ocj2qlEe5t1VDcj+C/h8kso4KTw9/rymCM08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780958105; c=relaxed/simple;
	bh=/rpv0hsisGb3nHHvAOO3ELylrxjpXbdj4HzmBdxPovY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gE5+Q5Fdi9a9RR2tytHTawrXttAQJjmjCqhtdSr22IFPqWx7gwJJJO2WuQ6Y6LbwBMjcFZpUwfoB3SO7Y9xY8kwAqDsupginpPttqjvVJMctuVc5nmhONFtNln+SaVRwT/D50VQT7Vid4fUJTfXV4lM89/XC1ZONTZcjubvvtVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UZNxa8s+; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UZNxa8s+"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-137335bc3caso5994272c88.0
        for <bpf@vger.kernel.org>; Mon, 08 Jun 2026 15:35:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780958104; cv=none;
        d=google.com; s=arc-20240605;
        b=QLImADUG2sAMIzInV15tw0gyaQxH1JqTZc5MHCRaboQPpS4wsepT2jSedCSuk71yZu
         oRzhWAmWSWdaAAIGS8Z/QoECfp87b5Z3Cv5T7/HF9I17tY/u5eEgevmmBIRAe+5rhC/w
         bAWIljUabiAQy/6DlyxYhfrm3fFOAM1kpbEzoMbJqcn98wr9YtB82GcX68dITGUGxKPo
         ZtqLvTc7iHhyQq/zbAwSAIVUVbrSAnc1/0nCYDC/6H63f/D1uihQP4+AoO4TKU1B4WIv
         /zb1vSXotxbwGSZn5kOYjJuD+Rp5aWtcUBAuThZl0+tyLSGX8CV+vIhk6Y2mcthLrT72
         kG8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/rpv0hsisGb3nHHvAOO3ELylrxjpXbdj4HzmBdxPovY=;
        fh=kmRvHxmDLs5pbKaJdQTavgS/zJ6Y323XsJ5DztoZt50=;
        b=jXDEdT/CUQcCAXpwiXRssWVkBrOJbbnNgP2E6CIfoH1QZRdDUQXWFiUfBTpPyXfKR4
         bLRZeFnzlMXAQVLv5yEuEt3LI3F0Jy3g3fYKUdJSkEdr6+T5H3LK1/XYUtpYVy94/Hcz
         EDYqt3IxXrD+daQAVkUECBONcu+jFW6h62d6Ww9xa7NwLmR3Hjf9veeJUw4Rby5f9Mqx
         4iCGhjuAY1ufTnMANbtOczyAKYjM2g5QC3c5R9nUorSmgAXlVoKv7dMqck4OEBb/rGTh
         9A6BEyeUalgAgH2Ol+Bldym+x9YCRlBo5yDBXptdkMME2ETuUT+quOJ1pq3f6iGJEvt5
         EToA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780958104; x=1781562904; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/rpv0hsisGb3nHHvAOO3ELylrxjpXbdj4HzmBdxPovY=;
        b=UZNxa8s+iZMlCKqqQ1SbxK57Q3Mgj26fl1kt8gO1WwVaxYIsXgTmnrv1WnNIVI21Ef
         53r3p7KPeaiGY7+oDsX+jn1SYPyV2AxytFPoKSKpBFXhlmbWMgBejk7hWBeYAX8Bxxky
         sv1VD8HA3ebiW20l8NaEhreYlqd8yveMID1vmkZZicG0Uco3a6+BVHIi2S3B0WUhxbcL
         KQ6Tfhdo+fNHMKiK+EHvWTJD/c3K4A0C9cA1keoGi8QfjbhMivN+m6ymqIvHLl/NYfx4
         KDF8qzEC6dBWSXSu7ns3YVGCCbVIXJXO0PhK02RIleXx20QbMSJwB+1FPda+HlamrJm7
         AVkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780958104; x=1781562904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/rpv0hsisGb3nHHvAOO3ELylrxjpXbdj4HzmBdxPovY=;
        b=XdLKVo+kXRTPzrsqK9TeG0ar0/BH6PyW/d3Wb6vpdkbQeZ70NN0YORFZ90R/aXL1DZ
         phtlfmH2SzdKJHdpncdabdIGtFcV9uBv6IkXMvOpp/ZMh4qkMQD9Qmkzo8CZ17g1pbvN
         euIz6U9OafNlxeXEBRq6PF00U/lASlpmzYFQfHImA4yUFAIPqSPu+PTlc7gN/nK3t/vi
         pgFIxmlo3fV+Isy1dBv1sxx5xS3CJddI2O4n8gGsmDRf5okk/Z8eIRTU8rhv2sXUDfKN
         UUF2YPXw3qJ0eul5XpFNhPvSCCrM8Ykp33HZH1ZEnrKELk+ryBcw/Ta3sRhhwWaNdE4t
         R7TA==
X-Forwarded-Encrypted: i=1; AFNElJ/sIjOPsw9DkgTzl85LmAW6Dil/D3HC3PEbdaYdkryfqyr+1uLe8KUmFGfmpon6HBGKp1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKNhiuFhl4IYOwPLQBU3w4X9EWRZj1ZcRETy6R/Cf6Zabs060J
	idURkyRwrxsFQHOKp9gZaHxqq0eVnymUHFSF82WRLCzrWl8MI9oAN+GeCQlQA/xyFxrvAvW4q+8
	QiXjv8oLjOBQfQ1KyZZYAliydwCtzjHBZoongnx9p
X-Gm-Gg: Acq92OGiZc2tcH63CcOA2B1D9qK5BeGL0Ev7kFHSgsb6I5HOfs0J3/3I8FiFGQw2VDL
	wbbzdBHASB3+IYrTjTNu9Im0qkECweUeSm5GMpYjNEg6DBpBGTU5VqDZEfUOwYFcHUHLuSvqR1i
	IGutD/7FerAfhvKf9nwzxNli8on44P1DfvIf0mglZYOIM2dE6wsHB1ASeIODPBxtEJVbZdZz3/s
	qzVoUOcROccgWvXtVhXEK3s7CBEtcj1gWnqP8tOqUbfFWDbtcPAk2yHh12rx7aR3Zv1W3I9FtmR
	SmzQQ9f1Wll48shYjoHW2ZITHb8t2ZiMTBmDJQRyOGXkUsLeFOuizftptUfREFEQDvypyegf6hj
	C3cLkjsxFwF/V6inD0IDLUc+3U6NsZt+5QbCSfb48YlZid5ivNTryzBlLHgdK
X-Received: by 2002:a05:7022:510:b0:136:83f5:c80 with SMTP id
 a92af1059eb24-138066608abmr7982404c88.4.1780958102929; Mon, 08 Jun 2026
 15:35:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608125846.157004-1-jiayuan.chen@linux.dev>
 <20260608125846.157004-2-jiayuan.chen@linux.dev> <CAAVpQUDZoEVEX1kXok-29dzVHk=ZK_2MkZyZY8kRHCJCfAWVFg@mail.gmail.com>
 <DJ3XPJA746S5.NYKZWY1HBH8O@gmail.com> <CAAVpQUATP7S7OEZw4P_7fp5zmQO-T5jByxAfp0+YsjRENeWscg@mail.gmail.com>
 <CAADnVQKa2Z2HKKZMhyD1HrurQ4LTcCS0Mm0YPxtisGKwVfcxmg@mail.gmail.com>
 <CAAVpQUCJH3iknHSfNwMqvHVc_V09zNDK-YbXbqa-=K159PTqiw@mail.gmail.com> <DJ40JYME18U1.3RA3TUXB3MH3M@gmail.com>
In-Reply-To: <DJ40JYME18U1.3RA3TUXB3MH3M@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 8 Jun 2026 15:34:51 -0700
X-Gm-Features: AVVi8CdeAbkRwHhPre5-1lF1rzTOH3OTwg-sIWZIP8BtHCUTHJ-Y9jp0mJntayw
Message-ID: <CAAVpQUC1Ot9vr09gNoe+vxgLoqU8Wwn2DV+CQZYYpAJUATJiWg@mail.gmail.com>
Subject: Re: [PATCH bpf v8 1/2] net: Validate protocol in skb_steal_sock() for
 BPF-assigned sockets
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Joe Stringer <joe@wand.net.nz>, 
	Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 3:16=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon Jun 8, 2026 at 2:35 PM PDT, Kuniyuki Iwashima wrote:
> >>
> >> btw is earlier sashiko TOCTOU concern real?
> >
> > Yes, the selftest in patch 2 should reproduce null-ptr-deref.
> > (I tested one in a prior version)
> >
> >
> >> iph->protocol =3D IPPROTO_TCP;
> >> bpf_sk_assign_tcp_reqsk(udp_skb, tcp_sk);
> >> iph->protocol =3D IPPROTO_UDP;
> >>
> >> as far as I can tell past bpf_sk_assign_tcp_reqsk()
> >> the networking stack only looks at skb->protocol,
> >> so modifying iph->protocol will only mess up
> >> things on the wire (if this packet goes out).
> >
> > ip_rcv_finish_core() uses iph->protocol for early demux
> > and ip_local_deliver_finish() also uses it for demux.
>
> ok. Another idea... we can keep the checks on bpf side and
> teach the verifier to invalidate packet pointers at bpf_sk_assign_tcp_req=
sk()
> and introduce new concept of "readonly skb".
> So after invalidation the reloaded sbk->data will be read only.

Yes, this is exactly what I had in mind in the other thread :)

---8<---
On top of L4 validation in bpf_sk_assign() and bpf_sk_assign_tcp_reqsk(),
can't we mark such an skb immutable after the helpers and catch
subsequent writes to skb->data on the verifier ?
---8<---


> There is no such thing today. The verifier only understands PTR_TO_PACKET
> as read/write. So it's not easy, but probably good thing to have
> for this and other cases where bpf prog shouldn't touch the packet
> once it called some kfunc/helper.

This would be useful and we could (re)move some validations from
the fast path.
