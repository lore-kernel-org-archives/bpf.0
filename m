Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26ADF2D29C8
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 02:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792118894; cv=none; b=Z46yqPpCeepkXhPSUq2EV24VmEvHfOpuOMI2vs81nP41kVXaif1LB26/0/S0XTVk8RDYvmV/TjYx3hIqUhdyQBBOgX8twx58Dhh0pllR9ALEn2m3ZY3pWY86Znt7zDEtKQ+klCor+SFo9/f6tVd51qweMLvoWabIjyR0pxeK5xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792118894; c=relaxed/simple;
	bh=AP/s1nUiEQtbXzd8vx7BitmWViuuCSCseL3DrZhbaO0=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:In-Reply-To:
	 References:MIME-Version; b=gURrw5rmxDqqKUjOruJxNOYzmKWLJgXqOqfL2dp2hly1rO6EOXNGcc4xNj3O68uA4R5eWmxMvlEZkKJQBXCGMqECltkTpCC+B1rhFgN7JpqBPcUGpO5tfLuzjil5sy+Q8iHBoV3EsThJ3KyZQXtRIT5h4c5Pr3M17MsVBEoGY0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AVDoAf0v; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AVDoAf0v"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2e987b4a710so873875ad.1
        for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 19:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792118892; x=1792723692; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bHhtn9u3IY1zxoF1cLT7Y8LPvDqehUup4rbTAkQXe5A=;
        b=AVDoAf0vHDPo6m4pGm5xU0Vk5lARQysvzO9/EdA815DWp3mssI2hqBORgG6oJVUEQG
         WVhVBRpECBusNi6XITt6VAO45/Kg4PT7fssdmhnfnowxFHtZEJaWQwoya0Jl/S9kSJD0
         01vCyaMSnM2C8c4mZpNZtL9pBNwMD7BLy00DGrJvamHiqFoa4DuRwP5KFevwpvgzPMOk
         fyptsb59sX/Xd/J7fdGG6bev+3qc5xINLOwSwHR0lYMCX0qU6Fsw8Jfu5Eic6DPbU0O2
         6qI0pUjwLS0exFJVkXEAKnfcRwSeOlPYsQBM5A4VTEdqNSSpWcmClNkA3B5/PYwC7SQf
         QEdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792118892; x=1792723692;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bHhtn9u3IY1zxoF1cLT7Y8LPvDqehUup4rbTAkQXe5A=;
        b=vpoGOrvtg0TCjh+ZA58WqsElkP9gJm3nhn1pdgw6wjweNlJijZmf6FTAiiSZ6WZI9u
         ldnOjnnmfqNqWA5L9uv/DUWIwqSSc9lLoIZ6Ct4WnYa64k+aA0Jim7R73/D+2uFL0eq0
         8ZDETUtwRZWvfeCUgqvV7AZRkGI67YA18a5qgk4IJQrHgo5vlmCzAGJ9WXRSVfGRiDMc
         4Xcz9tfNvY19pk9QmEbAkrLkbF57x34q1lb7juUvsKrD4UWKDz7F/DNmIhIH7FH7GsnP
         16wfcXkB/7i6CiynpWC5GABqwCi1QsLPjz+6yGVLSVvG8e5jp1/ffvVh7hYrs4ftLzWm
         zpRA==
X-Forwarded-Encrypted: i=1; AKwUvBywauQryBrQJS6WyDCnZSJZL/aNVhZTgDuEqAAdgpedY7NPbgEYRZKF+F9NXQf2PF6FDkE=@vger.kernel.org
X-Gm-Message-State: AFq9FYIG/+VxcxD70abG8fRrJmc8vKrWPdwUaOpihVuP62I3mx1XTxvs
	b7kcXOl9alQtOycK/VnfNVQoRvLub4ac28+dwEkT1VRpmBXmwPsHABGD
X-Gm-Gg: AYBFou0bUxrJK3vYvQ/SDNwTYjF+gt5K/JoALbOW5T3dftNGfFtkQxieISwECkehYD9
	Fl60CawQn65V1kQWg19B2kjh9v+jVQtTeszvWzcrV80THoM6ykLe+D6pEToJ4gK9nxBrIddIakU
	elTdRmjVIzFWqytM1nRK1MjmfjCczl8eA/ydrJqT5DPG1P2g2z2MpBZ6nQcUFe0bBUjN5pTJRgn
	6uX3mTXWdnoc8LDpPAUlLQOjxh+kOBkMF1BICF1oC4QdPkGIOyuRPkXyK7bABZzklIhGB1Xt+xt
	Fa6Jga5p5FCLWZKsXrAUq9RtTzGopjhF6gMsGLmBdopqjP35wJtgrXm/6jiwGvTr49UMneEj0mo
	W0U7lj2hDLPwAZLdzA057n0wMZ9g8G30Kf2jPZWCPIFr0bcGXUjpEPcQ+xShrM5kcXpNqGh2ju9
	wSUNXcpMwZ0OE4iPVtRnuKPhMeLi5H7BNXwwPMXHUSlWcZC9w8y/dwDSfA/dCoVKV87EzwKL3h3
	btapexsZ9Wao9nclhCmnIypNqw3Dl37/JP8o55Azc+/AvJLNikOxOsOC+j5H9wzWl4eN9thSaZQ
	UrbGcib45RmCkg==
X-Received: by 2002:a17:90b:4ec7:b0:3a0:c31d:80c with SMTP id 98e67ed59e1d1-3acbb68a0camr1291719a91.9.1792118892394;
        Thu, 15 Oct 2026 19:48:12 -0700 (PDT)
Received: from localhost ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac945e7320sm6736613a91.6.2026.10.15.19.48.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 19:48:12 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 Oct 2026 02:48:11 +0000
Message-Id: <DM5X4L58MG5M.2AK0D6DRZ5ERF@gmail.com>
Subject: Re: [PATCH bpf-next v3 00/11] bpf: Follow up by-value struct and
 __int128 argument support
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Yonghong Song" <yonghong.song@linux.dev>, <bpf@vger.kernel.org>
Cc: "Andrii Nakryiko" <andrii@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Eduard Zingerman" <eddyz87@gmail.com>,
 <kernel-team@fb.com>
In-Reply-To: <20261013170910.2126673-1-yonghong.song@linux.dev>
References: <20261013170910.2126673-1-yonghong.song@linux.dev>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, Oct 13, 2026 at 10:09 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>   v2 -> v3:
>     - v2: https://lore.kernel.org/bpf/20261013003429.1853052-1-yonghong.song@linux.dev/
>     - Index the two halves of a struct holding an __int128 in ctx by the
>       byte order, so the tracing tests also hold on a big-endian
>       kernel. (patches 6, 7 and 9)

what?
This is not enabled on s390, right?
Pls don't add code just because a bot said so.

