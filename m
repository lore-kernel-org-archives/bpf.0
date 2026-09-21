Received: from mail-lr2-f28.google.com (mail-lr2-f28.google.com [74.125.230.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C32A4AB1B6
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 15:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790004279; cv=pass; b=gWN+6TJWpYuNe6/cG+cOP2bzj5v/BzxXQ8PFuXpEVyRLKBlLMHSEHvwVrwDFq9GflXALNZeeO3T60yRstPZD1VXeJJkeVun8V4kiUvgR7wdeOXk9Cs4GQY69154JSRorjpeOVrnlyakROqdLeEsuu5aX2aKXFhazZ8Xv3LeKEWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790004279; c=relaxed/simple;
	bh=fVkMbtrDFgg9JhiC1LwbHU+t/WNuxQvV8nWO3zEnhqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GZJrjQ4roc3lr8x1oKWB3Tv2Uws9hHxxjjboGB5gDf0b8mzOWvSGGrYzhwcveI8dcVzeeyf5CLKxCWUMVu8+HkHftCaAmQPIIhmOcAszEDw+Ek3fXeZy+dHX6B1zPHZGoDXm9gGJHt2Ph6ZnvmfgqyJmBg7ZhdWaO73Vl0xOEYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cQoRKykJ; arc=pass smtp.client-ip=74.125.230.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQoRKykJ"
Received: by mail-lr2-f28.google.com with SMTP id 38308e7fff4ca-3a2ff00b8d8so25166141fa.1
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 08:24:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790004276; cv=none;
        d=google.com; s=arc-20260327;
        b=hp9TmHfHs106Wz9Y/ZVLF1OAYuRHr9ai6yJGIom3nd09+3W9mDhl+eSBbobiLnY1Gy
         8iuT8e6XR4RLxr6jYloYZ8C5Vb/KsysuzbPtpYq27QJ1MkVHV+/MFKQhI0wgIiitiFfy
         PTBFw+WzvLQH8TuhRJQlUva1duRfyQMDWjKAIGF0Ng6nQuwCMj3dqc+YGea/hj9/5osr
         SE1zGze/uHzFEmqYeBY5l9UORu7k5Tt3ipZ2EW7l44EOyw3UjBmLqe6sBYiwxXFOjpdh
         mUIhNNxCNwvideeSrwqnVD2j9m9/qnBmfnzUjtW1029u760Q1giq99Or9y6pYbxMNcXi
         XjpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=L3IcGGSo5+j0HvIrQfCCVAwZ7s4gKZX9RwrmAX0fXMM=;
        fh=ZRfZyp19uzsbWOWOGwDDkTNDn4c+e6v5laL3zkYq+2g=;
        b=GGZAocl/x3tRlZOge/k4NcGtPN5CqPyA73TYXyfZxwxh2bUO2BTRTppYKKOEa6f9Ni
         olSqBAsyllUzGwaPyxy6xzTs9nW8b9sqaCcI1pMbMlqwqwWqoHsie2nIHS/vgAeW+Swg
         1fsoAuQ/joeaGxeDMStvO1ff2WAQYtsvxPblFpqE2dBGDPNz8jcF0o64B+P7DKMTkUy4
         eToPVSIgO3ODoYlgRxL8e2XEzqpl1FU5O10X9lXfMNCoeir9tobnUkeqkvW2KdcxhRRd
         6Xgi18hGJzgvRDS+8+xNxT59FED58DhxU69YWreoNQBOppzdX8rYo4BTtvgnBjdCRfPt
         ZWqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790004276; x=1790609076; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L3IcGGSo5+j0HvIrQfCCVAwZ7s4gKZX9RwrmAX0fXMM=;
        b=cQoRKykJFqFyI9NigTnPCxeRN1VP1Ou79d7z8LN0sQVBAb3eOJCjlisTu98bQpUjEP
         6J2SIyrGd6sKnzDGj1ylmrd1zSzIP8/Kqpdj5jyvKZIzuR39nEPXQ45vi5TDlcozpEOp
         yvkO8I1+9RFwGUQrOfXuKnEttydrjoRMXvlDrSZSZjmXec4ken4RT0S2WJg1TvM32/+u
         6cYKCBZwyDCyR8i/kCt91Nu4lyRFRK9Rq+t9VgnmFGgwkGiTeaU3M2jbQ7uQEga/8DbT
         CedNXLSET7HzY453SzdOMpT7b9jJNuQuuwrxmAxV6JaeqG/SZSPe+5qRJXI4tiimoDsg
         YV/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790004276; x=1790609076;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L3IcGGSo5+j0HvIrQfCCVAwZ7s4gKZX9RwrmAX0fXMM=;
        b=bVZyquk7h7M50B9CCu1C46XcOvC0tqBqVS1DlLkdZQKF5hC/3nES2d1QBBg5cTEEli
         hpZHIC2irxiIglHx66q5WAddqJe1E4ciQSrEaBLeCdHCXjFtkI6ntSgH3iY/8v68j8HZ
         vs6N1ifudi3aDH1LDggi++fQNAZIQQvxBlgSL776RzvpsCKy9B9cCjsxtCpuU9qwcGL/
         TmRNARlRIWTa3oM0eL2dBFSIpXsY8TfhYtHQtIuZRVH2EZumDDDBE0UTOk85fM11Yknz
         c38BRJm2T3GjaqmNqqWLViMk58C4sHOCE74nPO95nRPZ1NrKm5+5lFDJZPu1QCbharh4
         ++wA==
X-Forwarded-Encrypted: i=1; AKwUvBw4BjD8rg5YZj/nnWJ/Rkhxok/HryJzYDaiNob4XV6iRa14tIVUtAaIeOusfckl997H+FY=@vger.kernel.org
X-Gm-Message-State: AFuF++m8fVOLu07v9whotKNJuSpwf7Vl/MZAvjtUVyYNJ6qv0+jJqd5Z
	HlhcYb75FPoDRYOfbQW6Su3oIKmKJDuVpyGKyI8+Z5v9Keh00NshTxPlgjWB+p+4GL/xsgRV2iJ
	/eo/BMSdtn4GHDLWGvx5gKOGzGbTzkk8=
X-Gm-Gg: AYBFou0vgJPeynIZoeQWvoxqNAk5zfLaVB9EgeyYyyffvGoGEXWzgA1vYVijl+dQcGk
	1hk8mAsfc8jBZ6gGC0pqgiQFyzNfd4p8jZ8dh8xbpxFm7dQGHFakSqlDAWMPfh610kOiydRNBY7
	TDuneMtL5TA40tjiIMIMjuq6g4K0oAiglLgawvxhAqdQ6K6mAKmkkDZUW+g3YMw4X3uU1oswlhd
	iQeg9Jp0dWk0c8GSrzOTXAo9DNt9iDZCAi9CE9RrTgiRxIXJQ2lcrtOGPvpEToiMJ/L+Bak4K6+
	C8SRWPWv2zCa1dt7HVju8o0zuVRuikWDt2qrckTgL3YVGWDVlOjuBklh+oi058Ah/Y+kkOtDVqA
	ykUtbHd0MUrvS5u7/MHklbTBYXjxfCLNroTix9DoaHQ0u4ZU27HHzPAn6woXRmBCKceMwWt2NwQ
	3SFYJqvguzYObk77xqMCNfyweZewM=
X-Received: by 2002:a05:651c:54d:b0:3a1:8dd6:aaf9 with SMTP id
 38308e7fff4ca-3a5fbf32d5amr23385811fa.8.1790004275723; Mon, 21 Sep 2026
 08:24:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917153923.904124-3-bestswngs@gmail.com>
In-Reply-To: <20260917153923.904124-3-bestswngs@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 21 Sep 2026 23:23:56 +0800
X-Gm-Features: AcwNN1VVTW-G-tYVzMWlBy3I-0oQzwQRNZQ4azMiWAQGx7Mm8VmFuFMIZMGo3_g
Message-ID: <CAL+tcoCD9baTVJFckt8yXaTHEqU4BQ=cKCUxtyUHO2MqfLimFA@mail.gmail.com>
Subject: Re: [PATCH net] veth: manage XDP program pointers during channel resize
To: Weiming Shi <bestswngs@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, co+65e5c76b187f08b2@bugs.sh, Xiang Mei <xmei5@asu.edu>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026 at 2:50=E2=80=AFAM Weiming Shi <bestswngs@gmail.com> w=
rote:
>
> veth_set_channels() tears down XDP resources for removed RX queues
> without clearing rq->xdp_prog.  If the program is then detached or
> replaced, those queues keep the old pointer after bpf_prog_put().  A
> later channel increase can re-enable NAPI and run the freed program.
>
> Clear the program pointer after taking an RX queue offline, and publish
> the current program only after bringing the queue back online succeeds.
>
>   BUG: unable to handle page fault for address: ffffc90000256048
>   Oops: Oops: 0000 [#1] SMP KASAN NOPTI
>   RIP: veth_xdp_rcv_skb (include/linux/filter.h:779
>                          include/net/xdp.h:696 drivers/net/veth.c:820)
>   Call Trace:
>    veth_xdp_rcv (drivers/net/veth.c:941)
>    veth_poll (drivers/net/veth.c:986)
>    __napi_poll (net/core/dev.c:7787)
>    net_rx_action (net/core/dev.c:7850 net/core/dev.c:8007)
>    handle_softirqs (kernel/softirq.c:645)
>   Kernel panic - not syncing: Fatal exception in interrupt
>
> Cc: stable@vger.kernel.org
> Fixes: 4752eeb3d891 ("veth: implement support for set_channel ethtool op"=
)
> Reported-by: <co+65e5c76b187f08b2@bugs.sh>
> Assisted-by: LLM
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Thanks!
