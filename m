Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB4A3914F0
	for <bpf@vger.kernel.org>; Mon,  7 Sep 2026 07:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788765871; cv=pass; b=bTeV0M49NAkR1RtGesrJoY/LPamzDyntj63vAKVNuWiWv1cM4kPanoHkQzGyAApYh0pK0bPN/ZvpRX8k0eUHg9/gYUXP+EEptWN8kcL4hHcZiEGeMtw4+lz/1FxcbLJ8hrVUR5GQ65nqjlUTpfJmKM3XPz9ncTlQ0MEyd0fDB9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788765871; c=relaxed/simple;
	bh=2yE2vKhYco15cq1LAqgS54dJAg4li6tJCb9pHzWm1p8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SQISh6EQ0Wc29olEHR6wCGusBhqGP+E44rWANmQ+jvCVaSqA2rrVy6NA7NagLGA7qSdyB951BOPAISrSYKoSVVrqkjPHtrxtqiHHuDhCun6pN2F3EJHks5mocnPtsS4861OdneuS22SI53mZdmB7HNUJ2CwIiIvLXGNJcx47148=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S8ZiJ5Iz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hoxd58ru; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S8ZiJ5Iz";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="hoxd58ru"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788765868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2yE2vKhYco15cq1LAqgS54dJAg4li6tJCb9pHzWm1p8=;
	b=S8ZiJ5IzRswZcAlOTqhqSg8tZTG1pVm4aNsPGvgcg92Fj6H/mjYX75htO4w9cZWz6/rueM
	J+Pt5DaG4gXkI47eWEugo5Rny+0+IVyyKcLuOpXOU3YQHfb2UeZ6e4JfqFiSwOoZrllVub
	+dG8ov1Jgf97752WqpWRCpPEn3PWpuQ=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-y6smuCBROH6tLM6ch3YI4g-1; Mon, 07 Sep 2026 03:24:27 -0400
X-MC-Unique: y6smuCBROH6tLM6ch3YI4g-1
X-Mimecast-MFC-AGG-ID: y6smuCBROH6tLM6ch3YI4g_1788765866
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-5b60bfcb6fcso1784392e87.1
        for <bpf@vger.kernel.org>; Mon, 07 Sep 2026 00:24:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788765865; cv=none;
        d=google.com; s=arc-20260327;
        b=nlwBkL61X703fSTVi9qhuIsViNywwqJxleHb3z2hTwbI7Ll5cDFEqJq5CGqukzZm78
         3JfkHusQHAEyzC/8yZEySogs5AsaHNJD7yd+f1PH8C2mGuJtuBvTPOM1nQRBX5QHtCPl
         E6Xt/jub/y5phiHwDxCgr8LpOnctA5N4AwV20AI3VmB0BPcZ2bIMfAyA/ip1X7DE9F4y
         qne61XJ2Vkh7bRD5DMbq8frtU0NI5suaRFYnOwG+kG+YGlaTxvociAjubbwUk3enYzyi
         alqnhukT0j7uRwFjN5iDb3xPHwntYH9VlCZgfuRzelbOZyQmKDx8DakDpaf6g3xIsZSo
         FkbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2yE2vKhYco15cq1LAqgS54dJAg4li6tJCb9pHzWm1p8=;
        fh=4l/Xytq7BNbzFizHjxR3vgyk96xo4Aj+0+UQoaWNbOs=;
        b=lHzUjJmxlrOXCp+AUpMB5NENW3ZEjBEapx6oXglBRndFeGKNYveGh28Yt+jlqbq6/z
         wJGQX2Xn/OT7OvOrd62r+Z/u9tnTd697ERJd8P40N5hTiePxOP/6vLObpqIKous23Yp4
         6jJ1v4NM8A+6nEtDmhqTavzahrFkNlpkbr3fNeHKooc9ygmkQT4q6RLqicz57V4J2BDF
         ZIG9hMetzVCkQaHtE/WYblXzzaYEWitd5cGfmZUpSUSwx6VG6JUqwXJHu+/4hosWFChi
         jzvKSkFNkWeumKYdUk0BN/2BjEitVGRoFn4lxNNWoB8RyI6Jfay4j4iNF9aBXScDNiIr
         KPwg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788765865; x=1789370665; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2yE2vKhYco15cq1LAqgS54dJAg4li6tJCb9pHzWm1p8=;
        b=hoxd58rugcbos3fUy937odZlRxzHj1/bIMqMzSFELEg5KuZcel+xJEnnaDNOoOmPFd
         mDaCOhHmen42HudHsm5oNlBUTS2ZfsZNDC1l0w9SsDvV33biS37YAMuV9uFNOT5VnV7I
         8FANAlpNPHsamJX0tS6bTlM04rYJQcBAZS3Y383RZQezNPQWlxNPjcNZpjA+dRCyW4kg
         a2WVKhj38n/nii6Uk8KZmZrjvVmHlJL9cD86m5ycB14WHO89u4BF7netwX6AoAOatbL1
         lMh8FEiu1HwJEhmAOhmwX7xv4WouSrBiT1O5W9+MaMz+c8JnWkW5f5nb8XJ9Zm9cSqcO
         8kxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788765865; x=1789370665;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2yE2vKhYco15cq1LAqgS54dJAg4li6tJCb9pHzWm1p8=;
        b=rS8fRibMVa2g6Wh0FKUVd7CjrL4jf0/jvZ3CiXRUKffSV+Ap4I58Rw/hdJ1SxfTVEY
         1nTIkRKGSkopfXM6dMryTpNOjPUOay/Mhqo1vVU42DOH6OKdXaUitDdmBf99YC9dbhdt
         BQ4iqt3/E4FeOjznIU/ftSlfv1uqxjShRqAyseM4M954+/EVrKzZDBVqnIK2JfX/LjBq
         Do5IkRoT69kH7503E5a+qLKOT9QY1b1c09WrntvvOmYj7ADSuDeuzIu3nkjFvCqvCeSh
         oms8BCEPTjHMI30VGoe6uOMGhZwieyDjpj8Lsd+1OhTWeSgfnYN3BRXucUM5VO1wUfqP
         yF3Q==
X-Forwarded-Encrypted: i=1; AKwUvBxJm0NGRIM/ePZXlAspgLUIUZeoEHKZ4Dk4fj6gvRMdtqUgQUl7kw35GurJmLv0MzZrgxo=@vger.kernel.org
X-Gm-Message-State: AFuF++mG022XJDmg/GfHYs/4XEAIrgmm+kalqzDmUMvus3wHYVHP32bh
	JKgou3wyZBYi1oZHhn4mZM1Xh4V3OPBfr33NG6QCU19/UQ6gFawv9Vc2vmQWVK0G4VRxnpMRq7j
	k+4RONAMYvRTB3iCXgGO7MQ7QJukkVnfeD5qoS89c8AUjF5BjhfdlXxLKGeSfjfHcMZrJ4AuqhH
	82Tq6WHn5zihHQ+Bm3cZ/AjbsAPRnU
X-Gm-Gg: AYBFou2xG9ZsiebeMLaH+S9VtBvAfwnlMtF1tSq5Ar2er4LQ1rxGh/p/yYFlYKhYteZ
	yAmL7fknjTh74KlBM6OhI/G+DGUExd82o/UdsiuznYM5TLDWiSw9/xfLrvMWImCjttdhSBHyy/p
	SR9o415e+hHKqQHzRiFrSQfX9ZLb2YKsZqK/auXdUXH2rI7m5bbdD76hP4
X-Received: by 2002:a05:6512:3f0e:b0:5b5:e86f:3550 with SMTP id 2adb3069b0e04-5b616eed114mr3346321e87.9.1788765865554;
        Mon, 07 Sep 2026 00:24:25 -0700 (PDT)
X-Received: by 2002:a05:6512:3f0e:b0:5b5:e86f:3550 with SMTP id
 2adb3069b0e04-5b616eed114mr3346309e87.9.1788765865162; Mon, 07 Sep 2026
 00:24:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903121057.80006-1-ihuguet@riseup.net> <20260903145631.GA182962@shredder>
In-Reply-To: <20260903145631.GA182962@shredder>
From: =?UTF-8?B?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@redhat.com>
Date: Mon, 7 Sep 2026 09:24:13 +0200
X-Gm-Features: AcwNN1VwMZKu46IzJzKROmEYRy2rjJetX0BeFnxsi74O5FJcBryBFl6vpHj-5Dg
Message-ID: <CACT4oufRecaPSMTJPK3yJurmaEaMN5i_CArV-mHd=rAA4zOJEw@mail.gmail.com>
Subject: Re: [PATCH net v2] net/ipv6: don't route packets with unknown source address
To: Ido Schimmel <idosch@nvidia.com>
Cc: =?UTF-8?B?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@riseup.net>, 
	David Ahern <dsahern@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, Pablo Neira Ayuso <pablo@netfilter.org>, 
	Florian Westphal <fw@strlen.de>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, dcaratti@redhat.com, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, Phil Sutter <phil@nwl.cc>, 
	Daniel Borkmann <daniel@iogearbox.net>, Junseo Lim <zirajs7@gmail.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Xuanqiang Luo <luoxuanqiang@kylinos.cn>, 
	Fernando Fernandez Mancera <fmancera@suse.de>, Leon Hwang <leon.hwang@linux.dev>, 
	Willem de Bruijn <willemb@google.com>, Kees Cook <kees@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Qi Tang <tpluszz77@gmail.com>, Joe Damato <joe@dama.to>, 
	Breno Leitao <leitao@debian.org>, Li RongQing <lirongqing@baidu.com>, 
	"open list:VRF" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:NETFILTER" <netfilter-devel@vger.kernel.org>, 
	"open list:NETFILTER" <coreteam@netfilter.org>, 
	"open list:BPF [MISC]:Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 4:57=E2=80=AFPM Ido Schimmel <idosch@nvidia.com> wro=
te:
> 1. This is a behavior change, not a bug fix, and should be targeted at
> net-next without a Fixes tag.

I see it as a bug. If you remove an address or its valid_lft expires,
the expectation is that it's not used any more. Anyway, even if we
consider it a bug, it's certainly not urgent, so it's OK for me to
send it to net-next instead.

> 2. What is the motivation for this drastic change beyond RFC conformance
> and parity with IPv4? IMO, these two are not a good enough reason to
> make such a change with a huge blast radius.

IMHO conforming to RFCs is always a strong reason. But beyond that, I
think that the current behavior is wrong because, as I've said above,
keeping using an address that has been removed or expired is not OK.

It's true that it's difficult to spot all the corner cases that may be
affected by the changes, so the tradeoff of fixing vs risk of
regressions is not that clear, I understand it.

> 3. See [1] for a list of regressions that AI flagged. Even if v3 fixes
> all of them (which means a much bigger diff), I don't think such a
> change will be merged without a proper real-world motivation beyond RFC
> conformance and IPv4 parity.

I will try to address all of them; thanks.

About the real-world motivation: this comes from a customer's bug
report, who is worried about packet leaks in their production
environment. I mentioned IPv4 parity and RFC compliance because I
thought that without those arguments it would be very difficult for
the patch to be accepted.


On Fri, Sep 4, 2026 at 12:38=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
> breaks a bunch of selftests, too, FWIW
> Please make sure to mend those if you want to forge ahead as a non-fix

Sure!


On Fri, Sep 4, 2026 at 12:22=E2=80=AFPM Matthieu Baerts <matttbe@kernel.org=
> wrote:
> Just in case, do not hesitate to look at the new countainers that might
> help you running those tests locally:

I didn't know about this, thank you!

--=20
=C3=8D=C3=B1igo Huguet

