Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F003E3C3BF5
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 13:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774878151; cv=none; b=Pnx1yGStLUmzeg40hcd1mG0bPmD3AsI0eETncvDHkUgqzdrTihOVn65SDnUpmN4FhksMaXS/pzjzucJtclu6OdmZsjRjx9OtzG9DxI2gA8sje9ZFsq+ORp8jneAnCpefGrlFO1kpvAy2SALtAmKOT9vhAynH5RyoFlT6f59aJ4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774878151; c=relaxed/simple;
	bh=OxeMDfIOeJPo0liFSF+iS4Bsty37kddULdD/aIXYKGE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=DGD20JVL+kvCtwogqkAI2WnrxJPCK7mxyrqxGK5q6OHCU7kBtgXSGhZTLHZyM/sKt6RjmzQ1QmnEXZaRLBhz0djhwKdVgS+viDUkT5bcfzPBpaq3mGl3GV5btkj4w3XHgCaRMsImdlvfRte7kN7cpGIFh2IpP2oC4iHThK1ioBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P8f4jU1z; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8f4jU1z"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-6500040f172so4660415d50.1
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 06:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774878149; x=1775482949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dReUoPRdYJoj/PVvzy5/qVwqlhgJ0D0SdiCFOdc0j84=;
        b=P8f4jU1zWYaPeg2MbgI/MgQcMM4Di0TOPJMh+/7IXFzaq1Ve+FGzdTgr31JvePwvgX
         j4L14uLya5lWF/Bu+aQzl/q5WzLnPg5WXC1xuG6SphyaD0HH6HtXRgGWXeeE4x/SNN0S
         5OeSSorGYaonjJloIR3LOT6t89WXqT0y6W4eex8Eo86VKYJTg/ZnGSDUcNpDTGNj6v8a
         RmbOVWQccJisKLHxwG181MKNxehwD0akU6h6a+SnBeKOKmwhwjkcRjKLnLCapcokL/Rj
         4iqdNqqhoOCPz/bmy0/Bx0k/kC5sHmKXud5kKyNjjxhq9mh83zxmaTw0dYKpos8SNGhY
         XQ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774878149; x=1775482949;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dReUoPRdYJoj/PVvzy5/qVwqlhgJ0D0SdiCFOdc0j84=;
        b=inlUaI2o7gXMaJn6IkinDlgdnFNjUdhhxs7+BjpmBiSTUq4FLVOpxs8xrLqQdi10BR
         3m3qSbGgJS9z68D+dzbv7xEJZGyTckP5+cpZIJH78+PAZwzw/Maw7wBc9MNAPqBQECjp
         ZOXwpZF62qWZo3lASHkP9FGBDGkwNCKAAW5eCO+iRX9cMHrJet60S2eVZzTBOZjl3J13
         U57WlRcFM/h9nju4P7g0DA5wQShnMpBDi4PYfXiZAcyhxRETsI8Tp0LNuQdQ7ca/dKyl
         RVwLao6h1VjPzhM5xqVcCf7kJaYF218JC39OrfjXcy6ZW4alcj7N/4SKuqoXH5UZNBAE
         3gLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSkDmH2DMhERnkkpvOYbymEQDskocrPfLlCNFZ0KFVhDOwGOQS4k6GuootwTfZN8o+p0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKuUOEdm4Z1RUXasT3JNF7KeHV7MQlBhuET1I48G/l4oDGRrEN
	x+cetRrFhYDTrxwlSOGua7DWv6j21bNq3UIUhe6VbziZ26/aIO0J0vjK
X-Gm-Gg: ATEYQzwjEaNGnO+hUgKi3DKVt9Ig/grWw1ghNMq5S7j86hne05LdkASZH4wyywdGJH8
	kOi7bzyIos/CqvirLPB5TIgpEdH81KhOxL8zRFkMLpBeX4oGELB7+XFU+B9CVvOtz7i6V9hrDB5
	QOIRXljzyaQJKmbXjTnnEMRNRtna84GJPzRZOqTlkUY/DZ1Zm4l/ow1D6n9CBorNe5DAZ2TcJ/n
	dHTPCgys7UJK3uZqt68Ft0NtY2sUlHT2mfD0ArQAbxE/oAKTp4xLK7Du6TfruEW2465r032ZDWb
	NePwbFqCQIT8DXtU6mAtUDtRFnsALJ16PNSq6zgXp8TsQx1dOuNrtWYON9vYF/7hO+G/Wp5LxSR
	UjnlUPMetrN0xPTxMcd8DGhdQams8j/TTo05H/f/g1H+qjjVmkXgu9vWShVVBi64koLzUfLw7lR
	Rxs+aqP5HkN5i7+I3rK7iHU7OCwJ/Wm3Z3BJNDKASHeHkeKNjmjt6iyCb5ncnRt3v2r1ANAadZq
	rwT
X-Received: by 2002:a53:d005:0:b0:650:1bc2:7e13 with SMTP id 956f58d0204a3-6501bc286e4mr3068003d50.7.1774878147225;
        Mon, 30 Mar 2026 06:42:27 -0700 (PDT)
Received: from gmail.com (180.134.85.34.bc.googleusercontent.com. [34.85.134.180])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65009200901sm4033085d50.1.2026.03.30.06.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 06:42:26 -0700 (PDT)
Date: Mon, 30 Mar 2026 09:42:26 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, 
 davem@davemloft.net, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 Jakub Kicinski <kuba@kernel.org>, 
 maze@google.com, 
 willemdebruijn.kernel@gmail.com, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 andrii@kernel.org, 
 martin.lau@linux.dev, 
 eddyz87@gmail.com, 
 song@kernel.org, 
 yonghong.song@linux.dev, 
 john.fastabend@gmail.com, 
 kpsingh@kernel.org, 
 sdf@fomichev.me, 
 haoluo@google.com, 
 jolsa@kernel.org
Message-ID: <willemdebruijn.kernel.15a62f8f2870@gmail.com>
In-Reply-To: <20260329180428.2657785-1-kuba@kernel.org>
References: <20260329180428.2657785-1-kuba@kernel.org>
Subject: Re: [PATCH bpf-next v2 1/2] net: clear the dst when performing encap
 / decap
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> Commit ba9db6f907ac ("net: clear the dst when changing skb protocol")
> added dst clearing when a BPF program changes the skb protocol
> (e.g. IPv4 to IPv6). Since that was a fix we only cleared the dst when
> the L3 protocol actually changes to keep it minimal. As suggested during
> the discussion (see Link) encap or decap operation which wraps or unwraps
> a same-protocol header may also render the existing dst incorrect - even
> if that doesn't result in a crash, just the wrong route for the now-outermost
> IP dst.
> 
> Make dropping dst unconditional for bpf_skb_change_proto() and all
> L3 encap / decap ops.
> 
> Link: https://lore.kernel.org/CANP3RGfRaYwve_xgxH6Tp2zenzKn2-DjZ9tg023WVzfdJF3p_w@mail.gmail.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>
