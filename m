Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F463E9290
	for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 20:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773173489; cv=pass; b=hzT3Cr5sTsugk3uA7ydTuxwYEvTVzViio3rtBjcfwcVA/uf3iTunDwpuxdeFcFy5wb5ItZpaQRr3Ilw2a1w4GHtRWcbnFliUTPJWuiTLQCiWFTEEw/Rbb9gVs/7rbfVyanhBgc1zpvj+RtPBzJdB7E1pA2H5e8uVoivpigQH/5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773173489; c=relaxed/simple;
	bh=ibUs8AJ/dN5iUBOGd4EoUhQ0y6ATrIvVnV6MMEAOtus=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gYrqf4/FGaJi0lcMe1VvBCbzBJzX9FnVQiw7dLAeB1GMr+Hrtbnd0SEwogjUSnPrAUcPov/SJPI4H+0sfAZaSq8U0czCG1wtIWPrd47uYVn5Q4pGKmZz9MaieD7m8VN2SPNEywzeGunrfJ2pZ06imzsv/9MSLVCw7yXDaz8zOFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B5OBdHPg; arc=pass smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B5OBdHPg"
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-439c9bdc1eeso3815923f8f.3
        for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 13:11:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773173487; cv=none;
        d=google.com; s=arc-20240605;
        b=AvVP+euk7ynTRG6KbMrPC9/rc5Jc/HTX2hJkGRCDB256TkDnY9pKjRBcz+UKsdWL6/
         Mq5y2P5nT3A1R1UfbkNvehThaLhYaFHgsDBirhRJ98oxMdgyQ1+HW4W3dsFBUA1Sq45g
         YusB+hKvPcTAJvexl2ahwZxBGNf0mkROuAbX8TOXWxvUaxcMFcWDkbTukNLskbipgzul
         oFl02S+TLw85DEcsVjSOZJ5UgeqOBmxu/4ZhXbfi8SdX5kH0BQS6uX1XgAcjPGVwESpf
         ddWOOpvMflHhEytILHwz3EUF6+JTeQadIPCRSqvxLi1wBlepCaCUlXO5sUptSWpKtVzp
         ndGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ibUs8AJ/dN5iUBOGd4EoUhQ0y6ATrIvVnV6MMEAOtus=;
        fh=RuIN8zP8gAdAD7gvAYgToXalcSeoxY9brfNd7bx991M=;
        b=NjHIvVDNHeFH4wOoeld4zkV2LbRFSpqlyCvas48+dkydhZdRPvwHsnN4KRN1DIfI7E
         8up079yIBGPn+djP7ZI/xDwHTMkh9FaG1yq0GENmm2HeYpmLtD88NHZtWKgLdVZ96W6P
         pvy1iLnZ7BPFU/HdZzZ+tXHmPCZqKYPo/rlQRZBUw5hVuTpDXZPXasuN2VmX4IvYMdbl
         BczwMxjDxTQ87uDZdBmjd5EQ0bzxaq+B6v8mKVGEgMx3PNewF7ebri3t331RlSccDI+v
         x5E4AnXvHtqPuBM91UeZ8XWyd9Z922p5Zc+heqeexxiyPFQdcBJVZFNZZNMS4GwBlTdw
         62bg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773173487; x=1773778287; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ibUs8AJ/dN5iUBOGd4EoUhQ0y6ATrIvVnV6MMEAOtus=;
        b=B5OBdHPgs334r7x010aTA+1AX+DYvyPTwoA7DyjzbwGHT+TxAvEC+sjrJMWcyib3+3
         HhqLdst9LU9ONQFGD3FiFmu76KEWGXEj+yYPiXWFZks1heFcFtJXsexu02J5gzAdNxlC
         T/1XhRVRfP6icaPC9gUl8muH6jxYLDDdec28R9m3qOD+JVtYyHuRZs3jgk8qWnCIvgR9
         zY7oh1U4d2JTMmFEvLfomp713jXcUJ0D9b6dDR0z6i8qRH1FgyUvLWBuwftbUAbL96/B
         q6r1E0hWV3gZOyMaO1R6rVz0cfVHsVT3n5C0jjVk1JZFuI2sd32RYfolOxIW448qsAHc
         5z8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773173487; x=1773778287;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ibUs8AJ/dN5iUBOGd4EoUhQ0y6ATrIvVnV6MMEAOtus=;
        b=P3gIPONDIquCqMpZ0VmVtW02S8H/J5Bx7br8pWIEpbV1bj2oFZz6V+7Yfqww3tuleV
         Y9gTwnSU1uSDf83OXMaczGeSUfGnucpM813K23QcX5hdkmEF5Ui6g8sXWBCmnp20OkvQ
         fMo//QZlRH5BeLFFAGOFEJ4S1YVTnLfpYO9yKSuGWlWELvhMM0ori9lk1Wm1rDXZT7DT
         2jfwknC5cYHcB6AHTGw5j4sxfubo92bkjVDQ8yXwkXl5bKE84Q+0p1maEOQ3TXO0OB9Z
         Ng22fBxEvkippPuMmFH6pMuII3SlI7DmRngHTDzi9euAwyPz19G1MbUTTb1nqZCWZPo3
         VSZA==
X-Forwarded-Encrypted: i=1; AJvYcCV0NQ5uh0R7J8ylPFxa8FQWYuUtoAZ+wC+Iu+3PYyLGfkdmEldEtIGZBiDf+oTtxihbg70=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYOCc/cWKVJo9JcGsaaO3IXeNiaDMBX590yynEP5eeDoS8rTyc
	C5YWeqivR2id4TL+xXwPDotTB/LHNzTV1fl6PGkhWBnBzDBaTx4KDPDXoS/W/RfCE+48/exWY/z
	M34OTlH2n3Ce1rW23aoU6cyBs7X2sV3Y=
X-Gm-Gg: ATEYQzzk0xMaQNwuSxwqF6rYZX0gXpacQujKJLjyVkQtbwzyptCRSPK2XFC+GGz/Mmj
	Cs/633NqME10CqueeS9YFVjrJQAmtkMrTHZVf2GIp8I/8n430M9NgH5vkb93f5zpJ2nIEZgOS5C
	XC7ylbXozis7FnXZFYOcqqwFidkvTWGWPAh4Eoh+OcJdfLpD4FbggcluqMWsVB6QhUeHEKIOWtu
	31ehcz+iJuYX3voql2ouusvEIQj6IkGOi3hmW9p3HAa7F3EGmI5UqbYSP6ksfCPBIrlJbEukFwq
	Fx7sYNmSV85NzXgrsYzpARrkvhKpTI6y91e6a3cRg6QRomcnl+eBLtxBpDpE
X-Received: by 2002:a05:6000:186b:b0:439:b046:2044 with SMTP id
 ffacd0b85a97d-439f81f2334mr391642f8f.12.1773173486625; Tue, 10 Mar 2026
 13:11:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260308134614.29711-1-pilgrimtao@gmail.com> <20260308134614.29711-6-pilgrimtao@gmail.com>
 <4f18c782-a09e-4584-8abb-0c81265840ad@linux.dev>
In-Reply-To: <4f18c782-a09e-4584-8abb-0c81265840ad@linux.dev>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 10 Mar 2026 21:10:49 +0100
X-Gm-Features: AaiRm52Oyt3zkGMAr9n346T0E13x1SZHHeDtnD6VAx-Cd1dkPohpqM6MF5aLI_M
Message-ID: <CAP01T74Xbg9HiGA6qwPzkOnaq5XfGu_MA+bKX6g-OE9UwOoboQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 5/5] bpf: refactor kfunc checks using
 table-driven approach in verifier
To: Leon Hwang <leon.hwang@linux.dev>
Cc: Chengkaitao <pilgrimtao@gmail.com>, martin.lau@linux.dev, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, 
	chengkaitao@kylinos.cn, linux-kselftest@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 9 Mar 2026 at 07:45, Leon Hwang <leon.hwang@linux.dev> wrote:
>
> On 8/3/26 21:46, Chengkaitao wrote:
> > From: Kaitao Cheng <chengkaitao@kylinos.cn>
> >
> > Replace per-kfunc btf_id chains in list/rbtree/res_lock and graph node
> > checks with btf_id_in_kfunc_table() and static kfunc tables for easier
> > maintenance.
> >
>
> Such refactoring should be the first patch? Less churn. Then, update the
> list only.
>
> However, is_bpf_rbtree_api_kfunc(), is_bpf_res_spin_lock_kfunc(), and
> BPF_RB_NODE should be excluded, because you didn't touch them in this
> series.

I think moving clean up earlier makes some sense, but why exclude
rbtree and res spin lock?
Looks better to me to do them all.

>
> Thanks,
> Leon
>
> [...]
