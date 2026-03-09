Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B6E3E95B6
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 16:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773073575; cv=pass; b=CwL1gvPR8XWgyW6e+YbGM6K+8pwfbxPqr9BOj96aWxr/ed1dJKw5VJ6juAz6zu4jxbZkD9hKiUwDL83pQGfv+0uYKA939XjMylvECGv153KZik2kBnZIHpNtjcOiJUMuCJDqSQAnQ5VnjXlvoymzMDnadAIWTwzJUMN4yv2tTNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773073575; c=relaxed/simple;
	bh=seDXjwe5/DD7oxH2JKG9XzAE7oPDjY61vUP31JW9kIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fhvfVo/Khzc3vNOjayOS8g/FBb4MK4hwjRSKC+5h1H6T1Y4XNuEfcAWtv+CoThBe8Betpevi7nzIExE+6jySUCvS05ZBldiarIRGPwufCP/vakYBBSMn/yUFRfXQn3WN/Jeo2esQC+VKPD09KxCHPgmbj1ZzYvVF39Y4ogMCPlQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VkN2pTOw; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VkN2pTOw"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-439b9cf8cb5so7458778f8f.0
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 09:26:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773073572; cv=none;
        d=google.com; s=arc-20240605;
        b=IVLjCYO2/QP78K4qIQ4BlTOkGoURbt5Sy62v9fs1R8TNRKXrVYfoUWGRSCkUrDco0J
         +Bh/JBFEWN4DOa3d5En9kyWtMmKbsEXDwz30fldbk8TexJCx04zhqwSji23Z+vhxM7o0
         ZXH0XRXBaRHG3rJZEScYfEjA6oBURGIMY15M06v//1REiUCrIe1n0/6Pl9UJEU/KhcKz
         7ebVbXvN+c6fn61MJvtNztgDjldMLQNeEZoF45H3tvwfEHdq3CYWm1H9EmAzX25KiQcy
         Zmjw2NlBAeLGlMYjklrkMs1I79YZ9ogGvcquD9dIZlE9A/l7k4HsHiCKTgUJsrvQWTcj
         xh7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lOitEpJZ+tpvJlmmI+ui+2hJXAfdoOExssqNbd2eGck=;
        fh=D6dnG//28Ok5IV72mq9IKXlienG+HjI/4+9/9mlCOdY=;
        b=PrQIUP6K5eBgJVs0COic664h64wTFvSwB3rqoLkcY2RLVEXoHd4vhz7LaIvjm+c/h0
         gpfXc08rAaV4ZfxoFKZNbUvYIukOd3N+Hi+N+bLFstjQ6d9836kCQGAoGXVg4oSwaoZ5
         qOpgFpPWmfcALNUcsG9mPw1QmuPEpLE/JFRHeLJU1z2t3y0O469LIj87CxW8jq1bTfsL
         l/VBandV6d9cLG5UQWiFRsE8opaYTO7TSB15U7VPTEcizKfikzHRqwqdgihld7CLjct0
         3zMYlX1fDdPFT71h9KEAgFctSl2J2ZNasmnxhbzaWA2qPgRMIbvFPNqGjhcZ8U1mYPVS
         S96A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773073572; x=1773678372; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lOitEpJZ+tpvJlmmI+ui+2hJXAfdoOExssqNbd2eGck=;
        b=VkN2pTOwL+Ule22JpfXRwEGuEYqD6ie67B7KLo0RJsFcu0Vwq5sXl81d4Bz+4wxc5I
         RO1pdImNBjTFyf9OU7aSonVRwfKzbfyQ5jwxFjUDCn1OiXl2IhHfDlZHDpXHUFi6vehF
         v4pZcwT3VIybsZzQk3QOl4uKjkzhh8XqRL27L6p56pCGeUHwE4WBC6Yqrs2UpQgCSIlb
         azwJv+xw1YiV3xmltNsQjdUGEvZvq8x0zTCuwdqjO52DqtOc/HKn0E4wPE9LudXnEevX
         hpNWTSZRCbhXbEieW5f5gZc8synoMXBrTaVCLHiRXUB4KW674DhYcXRSVYEvntV4NuHO
         NQxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773073572; x=1773678372;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lOitEpJZ+tpvJlmmI+ui+2hJXAfdoOExssqNbd2eGck=;
        b=OVKfpSmTMtqXqSs42KHtcEzDdb+LlD0bhmj7UU4y8OMeux9gZ/ws2x0mO/Mr5C31+U
         qT71Yh2Q6Fcnmjrm1KuElgaBevOsrMyekmr1Lcdea2B8itWb2n86FnfKk3A+JS1FujI2
         uhdG/Pklz3CMY11nyOM1O/FT5EnqJy0lFDPjZQnyumyfmDgERjnEqjja6JwX5h9HaWxu
         OY0L36WbzDYqIKV9CmTaWls0LbqZ+B3mLsRvWMzL5KVtx9myJ+jxF9XTAY3yyTDGI0N8
         PjFm7XGj51uk9v6z7wCNp06/nX8TmAsCZs2VRImxS1IgYJnSIGELhjoIXiGdTgzaCt2l
         BlCQ==
X-Gm-Message-State: AOJu0YzFrjNnbfUXPQh1Ndqw2+Z2QulSotRzX3dMQIo2CQBrGS67bQNp
	zBokSNe+A5YUW1e+e0UKCiy07V6JhehwoRx7otol9fRuvZtwM7Ys4+Q4w/BuHM+PtGdgTfsP+G5
	o007+ijWB4OP7TZ+4MHgZhUFhznaUHto=
X-Gm-Gg: ATEYQzyt5D8JWipS1GMmHVGfTtyLqkGwmX9UGAUiJ6QGXdTvWOxi1b9V9aKtUExIWn8
	CCL1hJYJtq/Xv14TB7LtQiyUHnD0w4JwfurAUhWKHMxYp8npD6N35fNKPs5MBlU9ujtpN/SZX7b
	wvFIplJMebq4F74mvo+lTl/nVO90ef3MFaNBmVbJz2JazYttpldk5sTycbMU3Dzt9znAyf3vJYp
	JiK8yEVbkxuYYXuNgMpwTdSHNERWKuPG650c1Y+zpBMXA/fIRjA/ABqU82kns8UZmea7A//llJF
	mlfhL2OFXdqWLp9gT8xA63DZESlSGJa+CC3pVu5T/T+ads14FfK2LoW+TEUHGT+Nqc+6N8my8C0
	rn9QZ1pc1IDcnYlzkDvec+chHjA==
X-Received: by 2002:a05:6000:228a:b0:439:b6c0:ea86 with SMTP id
 ffacd0b85a97d-439da5553eamr21453361f8f.1.1773073571685; Mon, 09 Mar 2026
 09:26:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309131635.302424-1-mahe.tardy@gmail.com> <20260309131635.302424-2-mahe.tardy@gmail.com>
In-Reply-To: <20260309131635.302424-2-mahe.tardy@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 9 Mar 2026 09:26:00 -0700
X-Gm-Features: AaiRm53TnTsIFxZ0fLcj_1fJN4XwWoH7kI0aVxg8gmJiDnXOHcMUrshEjlSaVgg
Message-ID: <CAADnVQLyTjCk2xSdvT67kofCJS1cDOMpHdCFfNHrWg9nQMSUSA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 1/4] bpf: Add netpoll kfuncs for sending UDP packets
To: Mahe Tardy <mahe.tardy@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 9, 2026 at 6:17=E2=80=AFAM Mahe Tardy <mahe.tardy@gmail.com> wr=
ote:
>
> +
> +       bnp =3D kzalloc(sizeof(*bnp), GFP_KERNEL);

AI generated it and humans reviewed it ?
Sigh. AI does a better job at this.
Think about this line again.

Also, don't bother with RFC. If you want the patches to
land don't use RFC tag.

RFC means "I don't know what I'm doing and I'm not asking
to land it in this shape".

pw-bot: cr
