Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E46413791
	for <bpf@vger.kernel.org>; Wed,  2 Sep 2026 10:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788343733; cv=pass; b=onx0o4uc8FLiQw650rSbSfSz1Qn0l739iTjmdb4+4bCsfazHbfcqLMrzlLeBNfgkjFyzoUZjpiKCkKOaiCZrqNv+dwRrBQOE6fJg4TSZdLUiuKCGbP6PcMZP9pyRX7fasB/1LEdSquzs8rrdRdMfXYjiHtLZO0GM9EDD5W45tXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788343733; c=relaxed/simple;
	bh=e22SUgGgIJ3poJkGI8HTllTE/j2hDqd/FF+MOcjqrxQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YyzTPq6D0IXmZcOZOweLXOxc0xW8TSnRDvc3Nb7dEqWpU5g8+fYehzSYIqeBgzUExuUDdd2PpKBDlgy3mR9iXH5SjfypozkqsQ9Q2nGoqdSDQj1vUbTUFGd/glHpLdEwb7qvsATtxzmNSEO8HXiWL4f2rW+61TxvQijDeYfqKMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dfL+csT0; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nMnUnst2; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dfL+csT0";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nMnUnst2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788343730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e22SUgGgIJ3poJkGI8HTllTE/j2hDqd/FF+MOcjqrxQ=;
	b=dfL+csT0Nr7xjunVMrWBZlNCiQt7UH7K6PChQBnNvuEuySRDckDlJ6slanlDe6FfbOf1WG
	78itl4bxceY85d3W8oPm10HVAdyTciIwX6j7zoi3tgt1m2OvVDv+2/shiuKCGQ4svhYPtf
	xh9S8YZvYeJq+V7NubwuiFxdRO1l56M=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-spJBDMRxOvKOPx3uYtjqHg-1; Wed, 02 Sept 2026 06:08:48 -0400
X-MC-Unique: spJBDMRxOvKOPx3uYtjqHg-1
X-Mimecast-MFC-AGG-ID: spJBDMRxOvKOPx3uYtjqHg_1788343727
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-5b15484404cso555961e87.0
        for <bpf@vger.kernel.org>; Wed, 02 Sep 2026 03:08:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788343727; cv=none;
        d=google.com; s=arc-20260327;
        b=j0I90zAJHVJ2JYrpbm1xAm6vOgfThToQg/kIN6RwL0qM0rUpxzmIPoKNCgrxBnoPBN
         3fsKHEWqznMwXbyY6E15MfoWaAIyBe5JBgTTePJ9hhQm6/eF01gUT/xfkuHRtkOebzOy
         jEB/J2bzBG4X4DOGv44gVpI+V9TinU4AwbNCpkG57yUOtlRjbDPaJJAjDUhQFFpXDSH8
         HiJTICrTOVOLSOZ/VEPxPqcdPaRxLv8w/LcpyF/FizQr5bTpvzTFGxmwyhZ85jUf4vQI
         5CQyRvDHCtWypMqooXwlNBRIKbpn8B2o5IlWH46hpliB1MUKNGHCr1SddDg0yPTvu9/5
         ALiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=e22SUgGgIJ3poJkGI8HTllTE/j2hDqd/FF+MOcjqrxQ=;
        fh=dpTRpo1dwbHSLuV0OPRwbDh2XtCn6qtjuM2WzDunFXY=;
        b=LK6e/ITScooijDck73S1g0c6CkUMBT78nUPxKbk+isJJVnExjn0AHcfdMiWcGcDhF9
         IQAfnVBLlvU0JY+Z8DTRPqgxfGmrp8XCjXIW4GUBh9LZf+3VbnOZRnyWFRXijfCmn27r
         w0mFD9ntzWmopruP2wWGAIhX1jgHHLbmHTK4NQ5nh7n3oj4bvUbAm4h8/LtNFQF6Y15W
         1Ea45zdOPah8AnL6w6ubARc4zk+brD/TZ9D6xhoPIgbE5841RM22almeLYe0frgV3BJz
         4rROClesDbt8q8lUsERBg0sljytsAtSagx5EqcblHVzp3Xnkbblge3N4PVn4NZGUupbk
         aF0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788343727; x=1788948527; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=e22SUgGgIJ3poJkGI8HTllTE/j2hDqd/FF+MOcjqrxQ=;
        b=nMnUnst2Yx0Msk7zIwj8FUlVvIvyw9uUohHRoadFQgmiUybQVvU7oCdIqVzEYZXI/M
         R9PlX28mc7pvtT/9xfKJzMhgP0PTJpjgWFFOywPEKu8Wb8D1RLWLQMuylGXcXThU9cLa
         3zMR9vPguuUufi079763jqFqQvHkCgS0lt0zKRclnvLZwruKDfQJ0Z+4SYN9kf1rH3vJ
         fHPqbyRlbodTVHZ1FEX5+98uxyF7o6UIKWqghYBjO+vL+AbAYkwLX4grefGEwnJmWfwT
         ufVM2IAtguMhAV95KRuQPNcoyC8LAhXss087Rf4EYTqhnLqxjE8+J+9dLI9Lei5Mzg1a
         hO8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788343727; x=1788948527;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e22SUgGgIJ3poJkGI8HTllTE/j2hDqd/FF+MOcjqrxQ=;
        b=JfMHWIsaQiq12v4jLukmbDRJ+QbpA2EsO+qs302cYkbtoQm6cdnv7OHeLKnw1Lh29C
         jU60i66K/oeNYkfGbz/YDJfk3o19cx6J3ZThTq6KA1utp4cvvMAMUjdbMm+yrvZcPJAC
         lsI5iIOka8gjZ+aagfPPRweoSthuc16uhFwMhw5n1EuxXVWLEli8GMzX04+4tsu6nnlu
         ZQenln2EdXScdKhhq5l3eFsjSmYyFlFz2wHdx0jxk7ndaOGqCBx7tjRflXpp7lphdFNw
         awDDp45ozpVVBpYwgpbrln/DnIuYHOP+xt7aq8SluoN1xTZBFYPBSaTZcFuul4UHM0W2
         Gvrg==
X-Forwarded-Encrypted: i=1; AKwUvByyDKcAj6oaDBRbdmUQ4veM8GiRLcjKabJuVBbX2BLiAGDMM0x6qlgUSi3T0WpxTvHGB6E=@vger.kernel.org
X-Gm-Message-State: AFuF++mD/mUhrkwlN6cNVQanwZOybjGpeiW71TkqCPcYFBJjUcPQngnz
	JYR2HzVCTq8bzGQIViOPUbkFR2PUPxSl9fuFs53kHhXAfJJGwzVBRPfCILXOiEefO8QTau6YrlX
	TifOBRQNcOpvHmVmRuBYDUyc2WYjbyr8O8dVv/5BQFvUBundcAKIkl6As9v5vbTTRimX3XkWhxk
	C+8jSUxHbuc9rn7zXjREEwdwKjjSrF
X-Gm-Gg: AYBFou13fltmHO6diLEq8bDlpVYxaT7KM6LR9K9bxfjd/pyCNiybVGI9gFMcIVIyLe/
	wqHxIAI6MXn5myZ1ljBz39R8g5JL12OuoOhNaENKkQ8X5p7Nyte0qKvQ1TC7G8xbaUSqH6r5Hgz
	uvjJL2EfDVV/ahWNiwkv4WV9KTLfYl7PtyYGOyhoH4mseCSivf02fjiqC1
X-Received: by 2002:a05:6512:1252:b0:5ae:b0f0:c217 with SMTP id 2adb3069b0e04-5b60834b9bdmr1404130e87.9.1788343727425;
        Wed, 02 Sep 2026 03:08:47 -0700 (PDT)
X-Received: by 2002:a05:6512:1252:b0:5ae:b0f0:c217 with SMTP id
 2adb3069b0e04-5b60834b9bdmr1404086e87.9.1788343726954; Wed, 02 Sep 2026
 03:08:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260901115021.50057-1-ihuguet@riseup.net> <3d8ef804-efc1-46c7-bbb4-f1a6c26fed8b@kernel.org>
In-Reply-To: <3d8ef804-efc1-46c7-bbb4-f1a6c26fed8b@kernel.org>
From: =?UTF-8?B?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@redhat.com>
Date: Wed, 2 Sep 2026 12:08:34 +0200
X-Gm-Features: AcwNN1WWjJG56_BD-BZvMi7yD139IVOfUkEJ5Q53fMWfoLWzhUAroA5GHqaqbfc
Message-ID: <CACT4oueX-g20hKft6Z1Aj3rNK2Fi7MYHZz=LdBd3RKWu+YK-0A@mail.gmail.com>
Subject: Re: [PATCH net] net/ipv6: don't route packets with unknown source address
To: Matthieu Baerts <matttbe@kernel.org>
Cc: =?UTF-8?B?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@riseup.net>, 
	David Ahern <dsahern@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, Ido Schimmel <idosch@nvidia.com>, 
	Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Phil Sutter <phil@nwl.cc>, Daniel Borkmann <daniel@iogearbox.net>, 
	Fernando Fernandez Mancera <fmancera@suse.de>, Alexei Starovoitov <ast@kernel.org>, Junseo Lim <zirajs7@gmail.com>, 
	Leon Hwang <leon.hwang@linux.dev>, Xuanqiang Luo <luoxuanqiang@kylinos.cn>, 
	Willem de Bruijn <willemb@google.com>, Kees Cook <kees@kernel.org>, Qi Tang <tpluszz77@gmail.com>, 
	Jeff Layton <jlayton@kernel.org>, Joe Damato <joe@dama.to>, Breno Leitao <leitao@debian.org>, 
	Li RongQing <lirongqing@baidu.com>, "open list:VRF" <netdev@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:NETFILTER" <netfilter-devel@vger.kernel.org>, 
	"open list:NETFILTER" <coreteam@netfilter.org>, 
	"open list:BPF [MISC] :Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 1, 2026 at 7:41=E2=80=AFPM Matthieu Baerts <matttbe@kernel.org>=
 wrote:
> Thank you for looking at this, but I think your patch is causing
> multiple KASAN warnings, e.g.
>
> https://netdev-ctrl.bots.linux.dev/logs/vmksft/net-extra-dbg/results/8045=
84/24-connect-deny-ipv6/stderr
>
> And a few more, see:
>
> https://netdev.bots.linux.dev/branch_deltas/net-next-2026-09-01--15-01.ht=
ml

As far as I can see all the warnings are in the tcp_v6_send_response
function. I guess that sk may be a request socket there, so it's not
valid to treat it as a inet_sk in all cases. I will send a v2 with the
fix.

Thanks!


--=20
=C3=8D=C3=B1igo Huguet

