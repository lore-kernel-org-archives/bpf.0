Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795416596;
	b=VH1AQbJ22IGXd676qtToZAzgEdjEj45rETgEzx3fsNKPDbK72ZVFqcxwWFcpBiU0zfCH
	 D6Bj64GCDrqA7mbIjyWXJJaGmxVxu5FaDTdMVWp6a7Hf8/qYsaihy0/6RLjWyFEWzFG+L
	 H1/TM+hbROcSAXs1iVitbpXZYOM46+2clEKESJ7PQxo0qaJQMmKL9aUB1Mkv/Kzu2YeFd
	 6AnheALIe2iHP+1qzBgXSBgZC34xjMBUJs4PH/j4Qf1YcvRXOGKzv8Q4An0clh8yDc7AQ
	 Oka9H5BO5U4YMtFSrX3t4Hb2mR7nEjs9rlqrLUwZ2YWhjKP6yB0/+MO1gLIPoJxSAsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795416596;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:From:To:Cc:Subject:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=VWkjtsN4TDl9WFd6UDgts8vNtEvBJiL0lWopiTLtRrY=;
	b=d5vvMsmmo2/V4Asy78gH6PREURTKqHwDr7x1ildDwYBdljRQYdmydS2DIIgMj6FJfGZG
	 GBWlAkOeExANUI8yr4rjOIi7zjSMQmWcMoHogIM2LOY8pvQfZm0T77rMLMZN95o0r3SOA
	 QXDMRuI7O87IJ+zqt+exe9AryeTWhSvfOOpksdeWz/3112woviTKh+ne1sVQ3nq1Yr0eD
	 radoCsCLeQuaUC929RMPLKWY/k5WJ6zgAdxzVZmwIqN5yK8sBODIM3BG4x47yVmh0rpVQ
	 8Em4pK+E43WisZiO+v3RD6k2/ZDDPRdrTed+YqL/r26z48mCGYRjX8ZLAak3kCgvKOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=La2ax3J7;
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF41606A31A
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 06:49:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BFF41606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=La2ax3J7
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2f02ee04378so23297145ad.1
        for <bpf@vger.kernel.org>; Sun, 22 Nov 2026 22:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795416595; x=1796021395; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VWkjtsN4TDl9WFd6UDgts8vNtEvBJiL0lWopiTLtRrY=;
        b=La2ax3J72api3sc3l5D6ef9MXqUpoj11DOC6hRUoS9SYad50gNOWPMNmy+7JO1oZ6l
         2wtFpzA7soMsTMSoxMtYRkpnngAvgFYTzwnqtahjGYxGZ+BlXW+zNtW2PJseHm7+6nEx
         aad4lthd+6ETGiAgMggVc/wgZsyaIpl9mwWvm0Im4Q74Tln1qTzryR11Cd+skeMKJMHV
         5gARo/qeTnZ1eE97EpNjX59K0mAC3ycB8KzxA8DOt855W8Vg4YkWUfcMNbSGbWTUgWkn
         iTblSMeGmI49TwZX1Yg3XRbQDfW0w1Ng3X71sXX3vz2ZHnh3jFINOlECOZd0Yaq16/T6
         N4Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795416595; x=1796021395;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VWkjtsN4TDl9WFd6UDgts8vNtEvBJiL0lWopiTLtRrY=;
        b=b5L1+n/ovDkkPJ+CKrbsTXZuJMNYgw59NlCzPtm5kz8SmUNcIgh+Y7Ct/j4d2uM8cj
         g59CJwLYMe5ubfGD3bYAh0Rdu/+j250mcr2O/WqCg3r/GvgDC6RTlXC1BZpUxy7BMBr+
         K+pSSKydd08fYyrgPacfMK8ezXZ3y2s9scddDCACiO+sIms0oEfpBZpbsxyeDzEnKeM4
         t2yjbmuzCRwtdQwiNxwxe99GVA3Wj2KzFjRGF6GtlI04q6LwOZ9yfxbSSB6wS/KxrGSW
         7eoA4MsKNZzJnJKMo+hLbeZPNIzrFbxiP0v0MoyIawKbBO/hGmpjmpGEYK9u+Wn8I0vc
         oP3w==
X-Forwarded-Encrypted: i=1; AL+hErF7APHRtTeBffHI1PzMu5gjVZZZkYMvlFbiVvS2AWpdzFA73+hc1dlZ1pcFwPyXQzKjyxs=@vger.kernel.org
X-Gm-Message-State: APuU4Z+JnMT3KYlUsICddQrPBBgG0ajpysfub7wFovVEopXftXq9yrvT
	+Num/DKxbSjgrR6Y3AJ+DHrqWPYHDvTpTxTMdDNDc860jAmOhnJNqH/5
X-Gm-Gg: AZFdTZeFziFd8I0O6AfE1buTm1x9ZuA64DKIORn9Ri+02K3viUQBmFye6loWF+rghJ8
	w76FKINoGyTiKtOAkZ2gQgQn1lwBv3KPIctojuzDd0FvwBC8pjd+02OpnpWaxcoT+SM/A1mejQU
	K8dGYIuN53wncTS329fJEUk6p1pC8dlmb+CIGDIwmyP1gPu8F6rc5BvsQo1wZQvLNWEAr9p1FUR
	o12zWuYoOvs39FM1ScpGxOPfdG8w6VCOMJD5XYdc0A2fMf5f3Fg7tcNl77rds7ny8sui4NUSSCf
	TGc4SjqaFfITY/VHIxSXyGsROB7ow9Alf6dQ0dsY09Py+Tfvbhgi+6ft/dIcOMuKs1tVjZVS2pg
	a/2AyOLCDieeqLhyBBMEN8uCfXH8JBhQbzQVwC0w8qJv+BKJ2zMUjo0swGSmK+vigOhMeHjImgB
	Sb3UCspUecm2hk+1uU/goydrO+TG/hvf+wm6DhWPaYP6RL/sDkQk4wCyGoTFJJ1XRGQPmhBYBr6
	Eld7CWrfIt63shY4p6pZJe2CJc0KeukOModTDa37P0+8QWnZvgdE9SizaXMLmbB5Isr4BV54QSo
	JltcYQ5tzTFhAZ9MhDnttAqc8baBlWoZAOJQtxnGW2GWqXyWeKI0sPtnPHAnXwmaOiPJAoVHUD9
	fifYzXfI8lDv3ZZZ75Jzub6B6rRIxtjy4Pw==
X-Received: by 2002:a17:90b:1dcd:b0:3b4:bef:9bc7 with SMTP id 98e67ed59e1d1-3b41c7d075fmr9977275a91.7.1795416594917;
        Sun, 22 Nov 2026 22:49:54 -0800 (PST)
Received: from localhost ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad0a34asm16171221a91.3.2026.11.22.22.49.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Nov 2026 22:49:54 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Nov 2026 06:49:54 +0000
Message-Id: <DN2E2CRNK19S.3QVBNS12O2D35@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Rongguang Wei" <clementwei90@163.com>, <netdev@vger.kernel.org>,
 <bpf@vger.kernel.org>
Cc: <willemdebruijn.kernel@gmail.com>, <jasowangio@gmail.com>,
 <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <kuba@kernel.org>,
 <andrii@kernel.org>, "Rongguang Wei" <weirongguang@kylinos.cn>
Subject: Re: [PATCH net v12 0/2] tun: fix re-attaching the socket filter
In-Reply-To: <20261123054209.89946-1-clementwei90@163.com>
References: <20261123054209.89946-1-clementwei90@163.com>
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

On Sun, Nov 22, 2026 at 09:42 PM Rongguang Wei <clementwei90@163.com> wrote:
> v12:
>   - drop the EXPORT_SYMBOL_GPL() of sk_attach_filter() and
>     sk_detach_filter(), as Alexei asked.  It is a cleanup on its own, so it
>     goes in a separate patch and the stable backport of the fix does not
>     carry it

This text is stale.

Acked-by: Alexei Starovoitov <ast@kernel.org>
