Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED557370ADC
	for <bpf@vger.kernel.org>; Wed,  7 Oct 2026 22:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791413009; cv=pass; b=DmQusZT1x/2/aLwW0vHHTctVljtcoTbIAMTzkFVa2tkWqffFE7fW2Bl8xpfJgk4qnp6q1bYLzaiRAc0pKiKbp+TWox7ENtUhZHo2shBs+r1cajkVwbIDnzLqSI0xOfF7jE2okoMMQMkUQiRJebqVLAgyS16NoWTA/RzB12hiryU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791413009; c=relaxed/simple;
	bh=vDZ3cTwxqjGw1b4UnPK3GokiygaHb1AoW5HXC6qbtc4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iKfR+PN4OtOlkjxogxzacRErbZwO3nAnfwjf3mEYEtvBJNumfvMyT3FKiRKbWOeTw36SkgowkQliXVR0ujIj56wO1zoZE0iLk01G8ohsrvL5yZYmi0VVxm72EWcNW0sMU3Zrs9C05VptZy24ASmuY93d/m3zK8BxZKRIN7DlFFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OigA+zYz; arc=pass smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OigA+zYz"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-81ae6aefdceso4164857a34.0
        for <bpf@vger.kernel.org>; Wed, 07 Oct 2026 15:43:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791413007; cv=none;
        d=google.com; s=arc-20260327;
        b=dY0VtPGvR4EMVTD+QlCNn2pPUTB9WE8K22YFE9DvR7KrH9tXJhLJDpQp7l5CRtpA93
         3adI5cz2dLHhrUDFVyPsolKu5oV1Bx6lVfBfslHGs79B9kXuC9z8YlG5c69+v5T2/AV6
         Qd/dLpxndv4eVj8BUzl17njnLRTxlFhWCpRgUc9G2OLPYCOvgc/yf9boXso4PshApWtV
         wI0ozl8UYga3Yyy0+qDaWnwkg0ZCBffdFSwM7IywTQeYB6vU1DyQf7S+SZMZ3znBk3H+
         z4rjOPMdazBsQltqBlSaCFeGITAjnyDy81ieku5bwqJ5R210YXqIMNug0YSBhj6c4vyY
         fsjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vDZ3cTwxqjGw1b4UnPK3GokiygaHb1AoW5HXC6qbtc4=;
        fh=wkaXIDB1Xf3LDyq4GCuokkA+wNlfc3Y8XPZe6jen8sY=;
        b=NbOeLXosABHP5cNe1TO/KauCnev/ieL/1r40sLemZOGIyE+J9K4zKW+Ddz3kJA+uBl
         MmmnRmqFys/opFRYfqciFuTSXng4tYZ8BrFWeavVQotBgT3DlSWQkyuIApED0h2eir+z
         PhpGfYP9v/swil4H+Fph1UnLqi7QCcBZ7npvp3h7Jys8dGFpEaXfx0LPGE5ZDhn82uhY
         UElcx4KRoNUCc0LCxNUjvRInbtmLTPlEthSj1P8JJri0S76M/M7c9C/JGxTooPcoyT3G
         B+didTd2P9OpYCPhbcYd+VbAvxaHY+ejoKJGtz/c2kj1/7rOKhJ5HCwYEUbGJNVoOyOL
         0FBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791413007; x=1792017807; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vDZ3cTwxqjGw1b4UnPK3GokiygaHb1AoW5HXC6qbtc4=;
        b=OigA+zYz+K9chR+C+fYBjK+k+r8ANl9R33JEU6TO5foZlA2hWZTAs1up1Vn8JmzHgk
         P6EX5FhHcKj/wpo7NdK3KOKIxPOWBBg6l6e7xnAYFllrFWwbH+sIYClZmhw4njy4VOEs
         mZ8ssXJ6FbuztDpKYv4+tqZ0QdqJGF4t2hTuDjAujm9YXQucyM02isJdwOZmFcAbMBXp
         62oES8fA5y7IIao8ULV6QTVp7dFHZlx2iNOANugOr/gAKY83udSm6ttv96tmXlzZ60Ig
         zD+NW2PcmVQLCRll16B5N3m5KjgM4xHDq4d3o6gRYC6tfhFmvWaSHGcB0oeim9NxGIEs
         86zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791413007; x=1792017807;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vDZ3cTwxqjGw1b4UnPK3GokiygaHb1AoW5HXC6qbtc4=;
        b=nVn9m6usWMvqvu6pmytYvN4m6afNuNPKAu1447mbjroyIS9uEwWJthciK/yMwOK4Gw
         3zc91CMG0ggLZa98V5m2P1Dn/yqpU+E3RTwMaCHlAuU39fLYLEMVBPALaE0OWuVccLce
         oBDb73VrUuz+4kZc+xjgyO2FfdB7gUIrgBhyWzHgaq7ahoFFykZC1dzW75HNmOUk+ONj
         K9ScOE854fh3dJXOFstILA+55DWmYdixm51hHVoScU99xxnfQOT1oxYwoc5bMxPd7EBz
         F8rGlReauvQ3Q4yKlF1HwpFZNU1YkHjwtSSP82CxVyPkUks1Odc8wq/MCf6IpbPCfiNQ
         vWsA==
X-Forwarded-Encrypted: i=1; AKwUvBy7Omk+xlu6CcxiimYDL7iynYt7Z47ghGV250T2vx4yVwCebTuGr77u5dDT+akpyaXYHDc=@vger.kernel.org
X-Gm-Message-State: AFuF++lbRP9o2fUXT/beaGbfaxAc9GEZKAw28iNG7GUJjXlU3qBxwYBg
	V3MKfpWzEfh+B9Prwbo2+QDuynPZYMrrY+zthCRpckjzEuYdERMiZeYo3vItrNZCSmjNYUdbvLr
	jBHUl/ryiW2LnemtNzqHWtzUqdY+UPvg=
X-Gm-Gg: AYBFou2FoB5p3qOzFzfM3RBRxs+YJF3ASEqs0GFZ3VxHG3mI3n503bOySRbpQvlGx/L
	9/ijaSHLcY+x1mZih3wjV1aLkt9u3O2n6ea8tx+mmHNjJBEFBX086Y+1pJSDF07LQJI28tBDuuQ
	xvVeQUmv7lnpLPEMnUWV7h3dzzk9tJ7d0pWMBM2TXiHFABw7qaPCDv25139iRSpWyViZk6iT8+W
	zwnddcEI4r2DmY+M+W2T07vLHOqlyvD4BYr1CXEDR3qWnbaAGLKdzPFGRa006ymNtk3nVx2iG8h
	WpNDFvUYnRUchqsKZxJmF8PGI939SHCw4dB7xXvLsFG3APuXTO1cHYQ=
X-Received: by 2002:a05:6808:3091:b0:4d5:27da:a496 with SMTP id
 5614622812f47-4fc46578fc2mr3900133b6e.48.1791413006632; Wed, 07 Oct 2026
 15:43:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261006192601.1875100-1-kuniyu@google.com> <20261006192601.1875100-9-kuniyu@google.com>
In-Reply-To: <20261006192601.1875100-9-kuniyu@google.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 7 Oct 2026 15:43:14 -0700
X-Gm-Features: AclHuK-zqLiAP0MMvI13NtkINGyxCDygzMNTg_OOEX6e6HDhK58LW_vHwrQA4lg
Message-ID: <CAMB2axPT7=34UkvddgK-dqvUsagpLWF5pkWp6Xom6PgHd3AP7A@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 08/10] bpf: mptcp: Don't support BPF_TCP_OPS_FLAG_RCVQ.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@meta.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 6, 2026 at 12:26=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> The next patch exposes a new kfunc calling __tcp_set_rcvlowat()
> to bpf_tcp_ops.
>
> MPTCP has its own sock->ops->set_rcvlowat() / mptcp_set_rcvlowat(),
> so we should not allow calling __tcp_set_rcvlowat() on MPTCP
> subflows.
>
> Let's disable BPF_TCP_OPS_FLAG_RCVQ for MPTCP for now.
>
> If needed in the future, bpf_tcp_ops_set_rcvlowat() could be
> extended to properly support MPTCP.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Amery Hung <ameryhung@gmail.com>
