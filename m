Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8705C36212F
	for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 21:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784669310; cv=none; b=igFN6EfCwqIoGrw0JhAuTaPPH7Umqhd1vcQmyvv43OX5syYBrIrC6ky94MDYylk7/iu3v2jlbUZ8Up3oS9teVTFL3wHO7uMJVnX2Qy5WzkhgOKh41vR3o3ZrjsOocEEE78o0jNTr2ETlTYwLhKd8hBc7+7TEilBs123TLrRlQkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784669310; c=relaxed/simple;
	bh=HboMcYGMtnD56tcUaSlwCUoEiipjssw2OLR1zNCFDEM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=W4e7GNbvun+ROSvYfN24v0KIMebJR5/Gl5+EAi92c8WwjUgHsy2A/ATTzHu/Wq8zQECKsd1yr1287TLTAI7l8uQhpxVpKSHHVSJsxtHN0Mn9Y3U1lN2G8svGSY+dJIrAN5HV55vUr8jJm3cghhw+dXqfSKvFJqTblWEFe3J38mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pUV+NYwp; arc=none smtp.client-ip=74.125.225.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pUV+NYwp"
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-495501e57beso10920635e9.1
        for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 14:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784669294; x=1785274094; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HboMcYGMtnD56tcUaSlwCUoEiipjssw2OLR1zNCFDEM=;
        b=pUV+NYwphf9W445DN1dJ8R3tBAAlnimDF2jzWM4LFDLgMIk2coiFdwV6nOMaH/j4nR
         yRX5WTIm9cl9Lcq6LRADdGuMbB7p1ilkLzSeIv/VODL2aZmI37hOqj65yBVjlwKotPlu
         Xp/E+iOFVjjjovhtTLzn6z8bJm3miUNInYu4MiuGmA61k8C5OiatalU+pewLxnWjVbkz
         FMVTay5ZpeZnn9thVldb9Zdrko/tmVe63xZ9Znuyrl1gpNAV9uhSQc87UiuCbIbhtWQs
         Wb/pL4inyH2FY0ZFbHsC4g+Fz6PLFNQlZDDckriFnm3y3GHtrgpUu7DlCfKji3JT62Do
         jh7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784669294; x=1785274094;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HboMcYGMtnD56tcUaSlwCUoEiipjssw2OLR1zNCFDEM=;
        b=ozsLozXlm4ZiGCD7Hbdi4c3IXj4vhfHw8TkhqgDjS0pyk23ESNlG/8cl0q0zueI7uM
         1gd1pL9Ab4w2u54v/mbGW394m8GhRgobgciuTO1fmkztEHJg5vP+Bc1mF12wT1H1hexi
         jgLSiGnbbyc1JOLTzOeiiCO3KEaTqpQsrPsRtxdH/smcPNWtgIz5pR/yjR+nc7WXr1jd
         VzQgQwQbXBgE1FYlxn1cdpsY2j2g0Klt9LK3liTlpmIWX6Sv23RZTuzzB7a7Q56r1gnV
         +yoLL3VYsfkalKxZh8Wo/TdCVtVmzkDMKaMZSUtkx05PF/buwMLz3Q+Jt0M0+JzS0t8o
         uzUQ==
X-Forwarded-Encrypted: i=1; AHgh+RopKl2a1wGIcaSOfn8IEK3XWeoqjh2YSP9wMc0nHS0kInAH4aGUExWFWFEzd+KGTFa3tZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1hoqliro0IGCt3Yop6k1d36bjCv4UxSOdpE0CTA5SipZpan92
	dDEWWrKFou384OP7NLfZX7lFcsBM7MkjOh6PkuiosjaXk8lj7s+pBoqH
X-Gm-Gg: AfdE7clybqhxxyUzBNs1OgOicXna5OwgF58bu8CV+wtwGUvMdmbJSMiNItlwtQD7vat
	DcXBjIhbK48r929Fvi8cnJqqqlZeRagfgyeKZryFqHcLJSo1s13sy2VvJ/Y5TTrOnpeJUf4Yynq
	TeHB3BPPGys9hwkJLInXFsa4EaXV+EmULmQwS3hvobV603khtXem7Prb6lKljEzAwosNRH5eJJy
	5RbG5AWP09tw7MTI5FkjxUGOIr0aIJ9uhLGKhzVrXVwK6Atrx3YwV8QurvIRiIEMvI0wt/wzYCK
	vH/XAJWnLUXUOT+GBaivm+g4pYGgbv/Eo1e/evsYoGme6/W2h8FhEvlFrLri9oZRzsbJvQtUaYp
	E7nRhTC8WBQUMy9yPHmJcF60EvZUopvZ1Rxzjn0qDCLLeBy9hc1UcgxfjM5hiZorrMKLSV5VMqR
	PN3n40UhSnsTvAFrhCWFZs4kMPkYW4Ct3GhdLSyxoD5/wlGx61w23xEo6lo6odF6PR28pgC297H
	yKUGYdWqoV5FfD2z52PBDIh3nL7KQmGh6MFqR/SY9uC
X-Received: by 2002:a05:600c:4e94:b0:495:522f:d994 with SMTP id 5b1f17b1804b1-495522fda7amr177340205e9.0.1784669294194;
        Tue, 21 Jul 2026 14:28:14 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-495653698bcsm87109195e9.2.2026.07.21.14.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 14:28:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Jul 2026 23:28:13 +0200
Message-Id: <DK4KGR25SLFD.3S54RZY16RYQU@gmail.com>
Cc: "Matt Fleming" <matt@readmodwrite.com>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
 <edumazet@google.com>, <pabeni@redhat.com>, <horms@kernel.org>,
 <hawk@kernel.org>, <john.fastabend@gmail.com>, <sdf@fomichev.me>,
 <lorenzo@kernel.org>, <toke@toke.dk>, <bpf@vger.kernel.org>,
 <netdev@vger.kernel.org>, <stable@vger.kernel.org>,
 <kernel-team@cloudflare.com>, <mfleming@cloudflare.com>
Subject: Re: [PATCH bpf v2] veth: convert frag_list skbs before running XDP
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Jakub Kicinski" <kuba@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260720140545.461747-1-matt@readmodwrite.com>
 <178465260565.839953.7972365481675163007.git-patchwork-notify@kernel.org>
 <20260721141438.0b7a9594@kernel.org>
In-Reply-To: <20260721141438.0b7a9594@kernel.org>

On Tue Jul 21, 2026 at 11:14 PM CEST, Jakub Kicinski wrote:
> On Tue, 21 Jul 2026 16:50:05 +0000 patchwork-bot+netdevbpf@kernel.org
> wrote:
>> Hello:
>>
>> This patch was applied to bpf/bpf.git (master)
>> by Kumar Kartikeya Dwivedi <memxor@gmail.com>:
>
> Kumar, this looks like a networking patch.
> Also the kdoc is missing a returns statement.

Sorry about that, I had the feeling it should be tagging net instead.
I tossed it from the bpf tree.
