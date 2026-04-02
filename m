Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD6C382392
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 21:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775164271; cv=pass; b=YHFDcAzfYTWpP6hGKNCpgipUGH7ikeyie7fAPCc+ZYUDjhd7YA+Bi9gWVWcSxsTWkuJMwr1AorOezNXDa121Xo5n8PQvaC9zfmnRSGiG4LK/5gfsZ+Pzeg+uOOydkmF65Bb6GjoTCR3ptQ9Cj3XviK9lmO3BWgs/iS1ZCTclxdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775164271; c=relaxed/simple;
	bh=Kcq2ZuIeVtf8iu+ocYSqW2K0SbYErKxn3lJ6ZNgMT1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y3EfNiE57kN1nmi2UTuDsVj5xzga5qdwQba4CNuV0LKgRIFq3i+KRgF6L+hVfeyOq7br7YmSE0V6foYOkUm/0cd4/s5V91qiCNBnMXkpmlBvtyMQvVo6K+d7gmAjAdeOJ8bNkgo+zgL55URNR6sxwjrZe5j9CkgbaMhCBIDFbiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CbfcBTs7; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CbfcBTs7"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43cf3ee0fc1so1747478f8f.1
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 14:11:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775164269; cv=none;
        d=google.com; s=arc-20240605;
        b=VuFq8JuzdGQCTFfFwS2yPNX1QJvtpLDARuVttgrBkBRlfRGyRYgXZHHPNjnk/79R7P
         n6deo1wjjnQOkpegmExXmbUudxdyFI+VwzO9sPTKzKQGA2fGQt5odWSzj1cw9wtKkpci
         k+qjYi7WgVP5dDSfR+M4gpUgvvN3yvyB1S1slqd6+HbFRjImNlaAXJ841Irub5hfmkow
         Ecx3eCYvTpkcmj28r2/cCwo2UVChyhweRp5wUYtBHshhPeaH9eAtjPrlqsuS+hd7inM1
         Kq1N6Y0h9K2YH+e6/6SpkXFKIeVmPMTTxhxjGTHpM7HEDGaocKXfLl4FDNcF2nSGowEr
         uJCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mOdqeQtdSXyHFkNeAIW9Lbat/XKIq2f4x+md1Hp+dyM=;
        fh=UcZqnkcPYPCJuBeofOOObWQTYZ2DVO/Q2yzEycpMUlQ=;
        b=OyOidALeCCf+hutek7wG2GzM3mEwpJVc9P9xv2QIj4l2pMH2wBg4u2x74AyQEkXes7
         AUnwcZcEggL5oDdj+k7JQKHZgDHWzlo1RJ6w/drNVwje5kLLPEO1qxJkelaRFxkB0g3q
         uCaOdFfZx7o5dzDTzYLrfXMPHaOBnA4lW9OIRUjFwW7kXD2zAUHc11xYi2ZWYjDS0sDG
         ioeDTPsvDh7Ap6+Cky9tNz5yAMZrKuK+hvqu7xYNGHTvWQ0abH475ZrW1oIirIC0fF1M
         UIGjstRik8yqOuyPg4hXkOEEpDTyVKPzF94o7D2K7xTZSfQvI7b3CrRjl6pHwjMFgsrD
         lT2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775164269; x=1775769069; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mOdqeQtdSXyHFkNeAIW9Lbat/XKIq2f4x+md1Hp+dyM=;
        b=CbfcBTs7yswCqx6iC75g35LZP2rE1q5ai4l/ipRLEZVLFb2cvIp/uDgh34Ygxfabcv
         tX/5OiYqIhCtNwMjC9hTSm/atvURR4fWZgabT7NzhJYJXSmbyD2s5OQZ1x3KKWYAzcw9
         qic4MAISMyCor7ZNqRMgz3nF2Nin8YkhlAXzZtT5+HEw1o4M7gQBfEp+Gmz5CZJeEbA2
         +s059n1AYB0r1E61ZC9Xl9XT67/7z1iP24Go+yhUyQ3GaeT4m8wCunL89PYTg9Z+uw5u
         MYc7br4ZmrcCTvVoLK3WuqmgL7Jbu0IJaS3pkwi/DA0N9BdTEXjUvuCJRQxf4mCvHonO
         kqHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775164269; x=1775769069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mOdqeQtdSXyHFkNeAIW9Lbat/XKIq2f4x+md1Hp+dyM=;
        b=q6TQhmFtjpi1a8DeUFl7x0Aq+H1QvRzcFrGWl39YeflqaMluboX1UwX+Pq0lh+GM+2
         ujAwhFX4jof3MxTIxluWnIfbvShRw5nYkfCoCiy7qGjdOaOiRnga8ZXTEcj0/JEVpvZg
         xn5GRt9QB1FYuDgsFlGyxt3JQibN8zTCYMU4uiWF6DhlZZCyonvbQ5L01Avw9sUYeG+H
         ccq+Jc63AVcQaJARBWXiLEujTgJrsg7RmElgxvsOSrNhqrUxiii+UCPbaoNC+y981e9c
         714aREvOkkVgeIVKQGVufmFCIYr7xnNlJjtgRaOtNaUzljYI3zpVSeV2xegkvv6r4CMP
         2x4Q==
X-Gm-Message-State: AOJu0YyeG2x3C5rwT6FeiAqT8Ziwu4J7HgJeemNhucT2akd+o3GYyMdh
	UTZ2PIJ5NuHwgNIQVhFyS/f+hQRd3vXeEVlATCaZnHoX+QF2c+mr3x7oH1evvw3De6h29Dlzaur
	bNj2TFTQoKH0HXVjBiQkDH/E+AayhSVQ=
X-Gm-Gg: AeBDiesuxg4sldaTXkj+dtJIxR+pvwWn7diCN3Jdr/2Y+lrEpGbNjcSauTcGUY053cq
	8twy/bz1q7evYwdV/ffNOHaxu+tOTJ4g7/m1QYDd3VQadxb2Vc02YYOqMXZs+XQPVs/ZUbYP/Qk
	MbmxRm2Q1vOBlsodpLSeDidiPIQjGfc3sylLJVe2KzV5+eBvg/M5UlbmWydIVFlY567yC6S510r
	b9FnTOYf6+Cj/2OTsUY562IoNi7uYir2whuJdckkYyaa86AWGl6VLRWaOKyIEXmJhjMGgwjCH+G
	8CRbAr1IH6BYDj8LiBAWZYlBWnehSnNJYglE9vhvf4rxfhhZ5g804y0mkYRc+ZjYzxWTdiJfCRY
	6YIB5ykr8n82fzfgvZ7YsrvwbNQ==
X-Received: by 2002:a05:6000:4020:b0:43c:ffd8:e262 with SMTP id
 ffacd0b85a97d-43d2115ab5amr6840683f8f.4.1775164268712; Thu, 02 Apr 2026
 14:11:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402061744.10885-1-alexei.starovoitov@gmail.com>
 <20260402061744.10885-3-alexei.starovoitov@gmail.com> <a3e2bab6b8e74f27f779f3fae68e409fe90aa291.camel@gmail.com>
In-Reply-To: <a3e2bab6b8e74f27f779f3fae68e409fe90aa291.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 2 Apr 2026 14:10:57 -0700
X-Gm-Features: AQROBzAyqpZF12WPC05fUnYDTLx6cOlwJBT3Xm9cbAYadADdmVQc1Ow2AaNoiAQ
Message-ID: <CAADnVQKi+gmu7Zk=kUKsn4U_diSfkcaTnj5CAJP2xiPwQjVB+A@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/6] bpf: Sort subprogs in topological order
 after check_cfg()
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026 at 12:38=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> > +     /*
> > +      * DFS post-order traversal.
> > +      * Color values: 0 =3D unvisited, 1 =3D on stack, 2 =3D done.
>
> Nit: it appears that the actual color value is never checked, only `if (c=
olor[*])`.

Good point. Added explicit recursion check to avoid wasting
verifier time on something that is not supported.
