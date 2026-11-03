Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793729320;
	b=l/e6kDJKmsQTjA/jZ2xhds8E2yLwoa3+8QUhCZ8iOagmFcr5pu1MlqC3S9ThV+b8/sbQ
	 ahXAnsS5SBWfxA53ZRP3k/U+IF3pN2MGlGLcRcdZF4yMLiYrWPpN1bQ4t9PwmEr+41jhY
	 G+nn5CZcUhRJfLYE5q7dglXnYRuAAbnRAyuWlpkGajDqdrHSMHv+0ITznKNbS/omQJ+9h
	 4C4tCuGK6HMTnwmH/agwZ6amNS9G1oyUKeCrbFoY1vLHlH+N5uuYkAS4cNtXZXg4FiPk1
	 9Psp1ca6QWOvYvGL++NbrpuAaoGPPh+gx9ZOv9VY+ud7Tbeg3tbUnYrgoieiFX1+f7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793729320;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:Date:
	 Message-Id:Cc:Subject:From:To:In-Reply-To:References:
	 Content-Transfer-Encoding:MIME-Version;
	bh=N72k8eF7WEmSz2BcB1uRCFB0Vfe7j02Fo65rhmL5td8=;
	b=S5EDrdzncBFaFevk840xYSGnMPb8FggBY5zJTpAGnE7W4CABajRZoi0MGS+O8tCC2nFZ
	 bAXgWRyEA1c8iDZ/wEkL+/aPiuNJL3VKS3LUNX9qQ5jovqaFrFwUlxRq1KlKaGsU4rch5
	 5ZJbFthcaylQBVBn2fNroSAF1DS/ZlfvnjI9ClKFRKZ1wBI4+jyBczIFjCw0ETicG8m3S
	 hP1VuyXKq/PGbSH7EQVwtN/HrzMsfB7oa7uJqQmnwL2C4joYExoxzL+ZFu6o0Gxn6RndC
	 bnXTAJ0hc6sZFE4f98u32sd9qv6QKOl+97GZCn07Sm7N0Bg8vP3sfdRdiyP/UO5zPuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WCU2tBpe;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D955A606A31B
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 18:08:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D955A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WCU2tBpe
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3ac6794fe45so3281298a91.0
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 10:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793729319; x=1794334119; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=N72k8eF7WEmSz2BcB1uRCFB0Vfe7j02Fo65rhmL5td8=;
        b=WCU2tBpe8S/qVZ8UZaoCHP3H3um2ZbSy+kzouC3QgRUMisrR+8rkcf59V9O8EwnGqL
         qls+rg+6t5pWzrwbZbEiGrCgdARfQbsjs5ZldifgMG7s1NaITbfNQoXUaTGEX/Imil6Y
         OOVPccJu86GZ3rvfZYiiQujiCFdA4AjmglHNE2J/ZgdUlTTMfdbXMjF94gfjXtlRf3wQ
         VmIkjSAFeghxB5fqxhrT10ccRw+s7eka1k55O2Bnl/ft0ncCM79OhvqkxENEdZXMTmUg
         Yw/4q3TsfpqF140KmmmThA/qkG+RPJAM11DBgE7YoZpSBRzY6fvL+vz3C1qqsTH8uEqH
         ix+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793729319; x=1794334119;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N72k8eF7WEmSz2BcB1uRCFB0Vfe7j02Fo65rhmL5td8=;
        b=zz3oby22ccx1j5E5GZwfLWZDOCFJDjlh+wRL5QvTpac7+T/pa9tZ75M1fI0uSyzYtg
         XIW1FBDJ5XVVpnNQ/twUTJKf7K3BrjPFuNYZEp7AlDu5vfCgP9jpyPveTPgBI7X/P6Bd
         wfT352y6mo5xldY8gyfefgGs6yO5n59Iwaf1NOz/T3LoNKP5QJ6gOw5/il+5opw5DUMW
         9Z+x+kZ2QrpBKdaw3VPuZhlCKh42U7WEvy6tcYrQxZP9gKhQ5IjND7I+MdSIN8/fpTYB
         jFgmQR1G6RtW8wHw+osbFUwGMUs/tIFrAINLUYxk/e/EPHaijf7m9rRkuUftv+rNrvaX
         dZsA==
X-Gm-Message-State: APuU4Z8enPNkln4Td/WX3LiwRL5SUuyqnBSKIEMzt3kwuKW7lpKtzhWP
	AO0Oq99BhxfLO4X/l3Tzyi9tUr5zv+O9U13KtdgSyjYdKmktQkfe12yJ/T/oaA==
X-Gm-Gg: AYBFou04fyyECr7X9CsW7QTHaWNvBFiSnFhmFqME7g4KR8P5gxSmmix+00f8GOz7HA1
	hbvlOTxDiggtoAt6djW0G6k1bffNfjxM+81I+VxGMBFpnMpg8LIaBCvPjZiA+s92cF3B0EliMP4
	eGSmnwynKEyPy7KofSBQ0LIYAPG6zA5nepsHMDZXoTfdPrPlhe/gvPmaW+XDGYCMp+RVkRCRyHW
	LGctprpLN094hKyOnUNYw/nn+Qu0CHpSXjHcV6siUvD0iKylFzzFgYJnP4xd17ZnJOo5Zd8PvA1
	iYaV7FPIxQw6PItJN4u6VrzB9sUIbE3srMz7eFslLqWK/5gh4n3/c/24175MdVZ/7H34Jq1x3p7
	ocxUTDLSZqnPqJfufb4QxpMRGRdcb7iNN8yI5IbICI2HCvNnU7yuLYajlWRfmbGT17dD/593Fbd
	DriBWuFpTNDu6JJdigUFa/9W/FOw+srkq1jdkgd/zDWogEPbPPvaBTitvycvrTS+Xk/0mFiqTmX
	p76yDXvmy1DRQxIE8etUjSBS3sE8a89W8AyxBDgwZY6v/cf3mG/ZTAoM2aZF61FnLSE23TCbTa+
	ZRroSY53gDqIgmutA0J1g79E0/3PGoR/pOYRodlDYn/K9XUPrmm61IhHraoXgbwcSQ9xZopmj8K
	iCgDW2mfMXSnOMy52j8K/Ym7sc/tV+STnoKM=
X-Received: by 2002:a17:90b:53ce:b0:3ad:6090:a190 with SMTP id 98e67ed59e1d1-3ae89817b01mr11552362a91.41.1793729319002;
        Tue, 03 Nov 2026 10:08:39 -0800 (PST)
Received: from localhost ([153.61.198.251])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0945104dasm77345a91.17.2026.11.03.10.08.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 10:08:38 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 03 Nov 2026 18:08:37 +0000
Message-Id: <DMLRZ4QCSGYY.3D2G6VQA28CBQ@gmail.com>
Cc: <bpf@vger.kernel.org>, <linux-mm@kvack.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>, "Lorenzo Stoakes" <ljs@kernel.org>,
 "John Fastabend" <john.fastabend@gmail.com>, "Federico Di Pierro"
 <nierro92@gmail.com>
Subject: Re: [PATCHv2 bpf-next 0/8] bpf: Add user memory kfuncs
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Jiri Olsa" <jolsa@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>
In-Reply-To: <20261103075916.100050-1-jolsa@kernel.org>
References: <20261103075916.100050-1-jolsa@kernel.org>
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

On Mon, Nov 02, 2026 at 11:59 PM Jiri Olsa <jolsa@kernel.org> wrote:
> hi,
> we have few use cases where having the ability to allocate normal or
> executable user space memory would help (like to replace function in
> live process or change environment variables).

Too abstract.
See
https://lore.kernel.org/bpf/20261016224310.3135990-1-alexei.starovoitov@gmail.com/

I don't see answers to these 5 questions.
