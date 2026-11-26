Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795726061;
	b=5Ahkysss8afoqSTvYZ5bDeBLMyzXSQ7mZjEKQgvO1Sw7aeT5npzfwUJUmL8LNp/p36Sj
	 +dIprZCIuw2ywxJX5b9+oXR1DxdtJoR5pFmfQ5QuN6aL3Dy8eaz3HhdOl5Ja85czZcfJ4
	 qmSTEslB3lzCzlJkVCFAPgVqd41uh2NB4KjzPW7QpOcPe8J37FGEqLG+uB6znXLJl1LBQ
	 rMGTJl9G1Ufk1Qju1HseWyJArJkjRO0TRxDmUTZwOgjcw/ZVGN6S3/kbZ5Bthz3gLrsGp
	 +IErS/NDtw8d9kirZ1rPSEWf0w09DyoVlPSaPxCEBNQBVQuFcMaoWHnoe6VaKHoDmSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795726061;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:Date:
	 Message-Id:Cc:Subject:From:To:In-Reply-To:References:
	 Content-Transfer-Encoding:MIME-Version;
	bh=SR/AburNxAUCmUNTJKXfpF56nBtKEZwAoNFv2gTiT7U=;
	b=CK4CEAelDh6N9Rz5+xnNuNd6hNh6I5a3lp2dbSw2AsPExjTTvlUn/3P+eHTQE4ibTgwh
	 2XHo/K1u08LqM9cKH2Q/5n+uR6k4muAJfD/sWP0B4b4Jw6AcTQafNFUw8lGv6fWZQSqXT
	 /qoz/Q2HJAXpy8yUOqpPr+NXkozicmI5ObgTtMydMQLurPF/nNkbbitEbJIG8vuTp2aHW
	 jh8i69/Uz0XAThudeAIArVSn4HlgZesIMNQdiUePtJEbe3YtAMylJE1Zwr0HNpqaSFWH2
	 ttk8CoNjjcpB0B4WV06auHPLHyS5v/yUxVuJPj7YtTBEsV+VC1e1dY2rn7sGLuB2TOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yMZleQi6;
	arc=none smtp.remote-ip=209.85.210.170
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C65F606A336
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 20:47:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C65F606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yMZleQi6
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8c5ebbc5150so5081698b3a.3
        for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 12:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795726060; x=1796330860; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SR/AburNxAUCmUNTJKXfpF56nBtKEZwAoNFv2gTiT7U=;
        b=yMZleQi6ph4KHNFEIJ5ju/BHODTOW3zjrQtMdDRUa7E74VniG6wfkWAWs3nrqUVNsa
         +2b1Dnb1Tq8OMNC3qdoxxS11KNZrzSX1werpMh4SrjaVz7PZnTkudMBsAyBRsNQ4oKhJ
         YjsFqSwR+TXBIlZ2iAxS2H0F2d0pAB1AhrNcXFFNO1jN2jMbVnOeTNsSY5vmWDTkxANK
         b9TU9p54wNDRh30PcNePJys284zAPIxHuMXpd3uyaZj6ZsXYKh4Y8hbVjWXY3h01Hvb0
         cUTTKi6/6KNngek2uV96QeMXTHnB2qewBdsJGcBKRMvC4iM5on/tQPxOGm4VdGm6r/a7
         VHag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795726060; x=1796330860;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SR/AburNxAUCmUNTJKXfpF56nBtKEZwAoNFv2gTiT7U=;
        b=JF+X3Q3xYyhkXK305lhaikaW9z+z6Tbb7Oxa09SJR0BY/lMzi0rPISjnTd1xYCMUcM
         At5eMqCZvN0b7Ac0cbugH3mpvqAMrjHWjdwbVIMYPzNftTW6Jv1Zyait7QnqIxOSheJp
         XFzE3IvMthZoAs184/R9NgfbbZZgaTWzGwmeJaKJpwo7+1mKqRoxT6s/NHDXxkIYq5Pz
         /2cbJU9JpW7sbzWrSzEl6BIZnAM8gpIgD++ckCqN+oQs39vdlNbs0G6gTM2DZgVlWLTE
         TNZCZUtEMU2Ok1ROTPP32+iDISdjPZnY8HcNDNw2tUie1mh20vSMyU1Oa34Etslp3ML9
         tSPw==
X-Gm-Message-State: APuU4Z+c8w0Dp7gHi8HjuH4xd2MqmiKpJWQ1Q3qrttqNyAT8xExhvx0Q
	OXtvgeXViO9KxKvF999jIJpXRbmhm+P440oEpfBiO1ckj61/GQx583LL
X-Gm-Gg: AZFdTZdKW7sfFGjA7MCJ8dcP0T3zAaNhO3mqXOUiaqdYdZQFdQHye82qgfVfy/ha3HJ
	I15zPZSOE0B+h4LUaRGg9PA2u90mDSgcTWK2DtDUy8oetDXAC+ZSRoWpogkkGKX6iMUr8qbkYaE
	Zphxjl5eBj0BeRgrwKXUVRRnAgFufew57S8t1Y0rNhhuSQcBIQ3eljNBo3MnqyHxuv8k9uS2k32
	QVmjc4ltaWXC0/IpXBEWW2Z2A4CDAzVChaCvbPy18yD4dKyD4rF5i66crK0wZ5cQH5vNmAHyFZc
	PgjoTcq0JHjcsdSiychcKRCjWUoEWjkvMwkeMByjS1+GqZGH3jgrGTgOS7MresFK90I41JBqfkY
	DheSpo1HDD/2zVlnIMCLCWCqfi3xHFWHl9Zuv2GC0ahUh3kgzvfXsIVEk9ms69T2Z6R2Wqh4YRg
	M1gxUta19FnHr0EJNpoNcVb7b/aULEV0FZHqmAYMHadCml+qAVmW0kqeMyEFfn/fWvPGZ0i4HsU
	r5imhXDKAuMfNPHkIxY3t+04wAmZlkcF8UXPCYl4A4uwSOflc19/QTwM4k24hgektv85aHqwDU4
	6ErXrf9gsaPf6Lt1sT4sjhhewGvgbXzCpfZBWOuXR7b9TKL16O8EocHh5otS952KZIxkPm+XJL/
	u1QAUFWtaK7nCvGvGFrvn6O5KUpbezYAUvg==
X-Received: by 2002:aa7:8893:0:b0:89f:9da8:1b66 with SMTP id d2e1a72fcca58-8c87c389aedmr20766524b3a.33.1795726060064;
        Thu, 26 Nov 2026 12:47:40 -0800 (PST)
Received: from localhost ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87077bc47sm11459429b3a.6.2026.11.26.12.47.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 12:47:39 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Nov 2026 20:47:39 +0000
Message-Id: <DN5FRF704VPN.12EK2J9356Q36@gmail.com>
Cc: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v1 1/2] selftests/bpf: Include bpf_misc.h in
 uprobe_autoattach.c
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Tiezhu Yang" <yangtiezhu@loongson.cn>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>
In-Reply-To: <20261126051307.13170-2-yangtiezhu@loongson.cn>
References: <20261126051307.13170-1-yangtiezhu@loongson.cn> <20261126051307.13170-2-yangtiezhu@loongson.cn>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Wed, Nov 25, 2026 at 09:13 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
> Commit 8c2b5e90505e ("selftests/bpf: add bpf_for_each(), bpf_for(),
> and bpf_repeat() macros") accidentally removed this include, causing
> FUNC_REG_ARG_CNT to evaluate to 0 in the preprocessor and silently
> skipping all assertions beyond arg3 on every architecture.

It wasn't an accident. The log of that commit says:

  Also clean up a few tests that either included bpf_misc.h header
  unnecessarily from the user-space, which is unsupported

Nothing in prog_tests/ includes bpf_misc.h today.

pw-bot: cr
