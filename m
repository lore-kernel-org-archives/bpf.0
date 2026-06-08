Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4730E3AC0EC
	for <bpf@vger.kernel.org>; Mon,  8 Jun 2026 22:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780956969; cv=none; b=THEKTXQLoFOmAao7Q2phe/bH+igmgOGgCwSpptkoFASvn5qYK+bfThzKa3gQG15YvRCxKNgePG2c3ptGZQpWRVRb3yg3rVRC57y/aod/Rwmo7j51Z5zTofx4lP4n+zSXs/epCrja1WtilUwlQBbJHLRFq4lTCw/67yqUlq6sKEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780956969; c=relaxed/simple;
	bh=5S9+Cq5mB6r0CsPwnBf6Bi9EBEMbdFL9VF1fFs2tVh8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=G9jyvUq1/mBCBzTbIVjAVZc/zEAyxQhpprMJpc12hQNRIlJ40lS3GjaOM9ll8ZsEZmdeEaDfCDmdBRHkh1b3ekkNHva2LnrO/9APGmxGP0Ch1QmfH+Fup3IGlXHhwy2VInt88DiuJ3ty/zVuyul0sm/wcSV6WySHICksz0LVke8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m/j6uKom; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/j6uKom"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-4865e953031so5016673b6e.0
        for <bpf@vger.kernel.org>; Mon, 08 Jun 2026 15:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780956967; x=1781561767; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5S9+Cq5mB6r0CsPwnBf6Bi9EBEMbdFL9VF1fFs2tVh8=;
        b=m/j6uKomIznvp+t9zPkrFDexHFl1cwOn80Pf/8nQUwPCopgBZ7vGWIYsmLenqujMG6
         aEGvRIunsn5WeX5DaiC5O5pAfTSwoZyK27aKXKdaNu47GUZkec61FlUpWmMuAf0pavgu
         +OnJ6yTTQJRUc42ZZO4LpzoIzmMLUuftWtMky//J3gLjKXOElPsHMkcEQk5rgbk/3sJh
         MktBkO+qCF/1lPzqvCuLeQHd4reR2kvbUEt+h7AR8bp71Ogygs4448qeaX3qdupWis1k
         ebjZiBMNrh4HgWcfMd4WWL7Q8xhUVOz543bl1b5Hz81HPaq+LEjePjFOivpfzxEqhvKP
         dTpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780956967; x=1781561767;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5S9+Cq5mB6r0CsPwnBf6Bi9EBEMbdFL9VF1fFs2tVh8=;
        b=fyASRrSpsZSjZ6VFNpwVEGYFLp9ltHe4Ku6FuW/XP/VaUtIDxMwgangKrlkX9WuYfM
         zx+gNt+6yp6CkDb8FQN5E5fkS/ErkzeeWA/BqWqsWFiVUdM0jr/MBYKl8Ey8bGZehubG
         /HxEw/tbAh8dv6ND2roOybXdG9DXU9wfAdPJ++vQWYV4gfqinARzrMqM2HVXG31KcTJY
         n9UeXSV28DHEOo80SKiXWzoDORypxXs54OJxuLMZF5eMQa/l4o6r1JJLLoNIzd1t5Dg5
         bvdjFmLnlFlBylmLPQNXnrf3XJJu/sISYAhMeGkXTWdd6MlsgWjfriYcYd+Jcm45rqyA
         mWcQ==
X-Forwarded-Encrypted: i=1; AFNElJ+fHSYoA2V9ZnLAckXht0TmK6s9o4lzskLTYlURdDVXfrynC/l5wcx+dvG4YlHpkQHSges=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGiGeyqZjZPRdRMm8kdPr97P2/R0KHgHjusW24TJfqeMew8c1g
	Qstwr7uflhgFKw0maBdRnB/1w47mhsoJeOF/92AbLVdL9+NyEinBuxMX
X-Gm-Gg: Acq92OGGUTzuIf5P5Z2j8PM+GbFIJMCBZkCTGccsP838tekTSXDKghInmBfthNcAKfa
	nd46R74kMHnflb8jzq2CckoIBWuK0SsXECoHG14lZ8n6CZeMGgKGbANGVaZM/4tXBYGdNNeWyyn
	stjKHj6G5EEUSV3M+ogdfwTMJxv/32MGGEq3oaZilWEugF0J58aYrJxgJkX1L8PKirdoY/v9jos
	mDtsQYVuPDzY+rcLa4CqR8f8GEWJyKi9alFwSSVXZ8IkAidsmYRYmBxHyrUFdU5IBKlLhlBhcMG
	eaR+kV/2T/dVoSWUteR3r8poNrFZaPP+X4g/erPJRyiEamt+mwsG1xRXJ6xpU7FzxdC4eGrUf+F
	/9y1CTgXBARZ1KRViBRN3VYe87anXKFD6Ht9/JRdhgpL3BoTr0irMAWOWqNbcMJchhwSfm/dsZd
	S6OYC0pcIQ2/pHV5YPV6hgzrbzXkXNmAgEJN3I7jMOt2meQEDZI4alvfIpI9YWOHrAkI+8ufjQk
	3zq8IUYxX3pdVyeBBFPF8dMGMTl
X-Received: by 2002:a05:6808:144a:b0:450:b249:71bb with SMTP id 5614622812f47-48692e390c3mr6568858b6e.19.1780956967107;
        Mon, 08 Jun 2026 15:16:07 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:40::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e6e79237a1sm13423994a34.19.2026.06.08.15.16.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 15:16:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 08 Jun 2026 15:16:04 -0700
Message-Id: <DJ40JYME18U1.3RA3TUXB3MH3M@gmail.com>
Cc: "Jiayuan Chen" <jiayuan.chen@linux.dev>, "Alexei Starovoitov"
 <ast@kernel.org>, "bpf" <bpf@vger.kernel.org>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, "Willem de Bruijn"
 <willemdebruijn.kernel@gmail.com>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 "Shuah Khan" <shuah@kernel.org>, "Joe Stringer" <joe@wand.net.nz>, "Network
 Development" <netdev@vger.kernel.org>, "LKML"
 <linux-kernel@vger.kernel.org>, "open list:KERNEL SELFTEST FRAMEWORK"
 <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH bpf v8 1/2] net: Validate protocol in skb_steal_sock()
 for BPF-assigned sockets
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Kuniyuki Iwashima" <kuniyu@google.com>
X-Mailer: aerc
References: <20260608125846.157004-1-jiayuan.chen@linux.dev>
 <20260608125846.157004-2-jiayuan.chen@linux.dev>
 <CAAVpQUDZoEVEX1kXok-29dzVHk=ZK_2MkZyZY8kRHCJCfAWVFg@mail.gmail.com>
 <DJ3XPJA746S5.NYKZWY1HBH8O@gmail.com>
 <CAAVpQUATP7S7OEZw4P_7fp5zmQO-T5jByxAfp0+YsjRENeWscg@mail.gmail.com>
 <CAADnVQKa2Z2HKKZMhyD1HrurQ4LTcCS0Mm0YPxtisGKwVfcxmg@mail.gmail.com>
 <CAAVpQUCJH3iknHSfNwMqvHVc_V09zNDK-YbXbqa-=K159PTqiw@mail.gmail.com>
In-Reply-To: <CAAVpQUCJH3iknHSfNwMqvHVc_V09zNDK-YbXbqa-=K159PTqiw@mail.gmail.com>

On Mon Jun 8, 2026 at 2:35 PM PDT, Kuniyuki Iwashima wrote:
>>
>> btw is earlier sashiko TOCTOU concern real?
>
> Yes, the selftest in patch 2 should reproduce null-ptr-deref.
> (I tested one in a prior version)
>
>
>> iph->protocol =3D IPPROTO_TCP;
>> bpf_sk_assign_tcp_reqsk(udp_skb, tcp_sk);
>> iph->protocol =3D IPPROTO_UDP;
>>
>> as far as I can tell past bpf_sk_assign_tcp_reqsk()
>> the networking stack only looks at skb->protocol,
>> so modifying iph->protocol will only mess up
>> things on the wire (if this packet goes out).
>
> ip_rcv_finish_core() uses iph->protocol for early demux
> and ip_local_deliver_finish() also uses it for demux.

ok. Another idea... we can keep the checks on bpf side and
teach the verifier to invalidate packet pointers at bpf_sk_assign_tcp_reqsk=
()
and introduce new concept of "readonly skb".
So after invalidation the reloaded sbk->data will be read only.
There is no such thing today. The verifier only understands PTR_TO_PACKET
as read/write. So it's not easy, but probably good thing to have
for this and other cases where bpf prog shouldn't touch the packet
once it called some kfunc/helper.

