Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48D337646C
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 04:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790049865; cv=none; b=nia867XNiQKc2dnsh8LBsXcRHHak5eRhlVGrI167pn481nQ6TbeG6/ozSBR4UWYxDRs4fIXCAvdhcQo2sqwIbZNEd3CsYXod1xlut/dH9eqSxs+XVHY/xkYhKDLENoxhpTAXJ6JHEUzOuXCuZIgd04D4zLi2iVuMGGn1i8qXgj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790049865; c=relaxed/simple;
	bh=2yds5wNSBrgUySw55St/bnfVFfNPOOATUlL7ZMw3hJY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Xz/UZk0TCQkLhbjORbXm2Wd9D7YEQa8UX0wUZGcPoAU5dXT6X68VhZLhxxwLzLEwG5jVlAID+ImsEGXVrIMtnmufiXCDGZoyeILhq530uND3IAknaYH/+1K1DP48jUYNTWgBMlwxM19EHJRC6MyI6nmWNcqIdrzWSDi/dCf5QTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K6x7byff; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K6x7byff"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccb1a98fso3341464a91.1
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 21:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790049863; x=1790654663; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Eh0zY0YbE6EimOoz3Zx8ySQ5kbO2KhlcLT+oImzRbUI=;
        b=K6x7byff7qBL9CUduuZE0sPnA1P7x7InkCCQ+ezEYkxodaapLehMVapibEFdV/v95/
         A/JHJyqMorI3xuwITALTsq73g0vabfnx2QWW7H8JU6YW1+EXPlgiKxrhqaS7O0M+8oSG
         JVDGJc458VTpTQW0lXGuQtLDKwLRhi91LEe5xy6pOViqtnmP9n/PZ8dTNz+4x7wDWRpP
         tTRFY2REcx1wY4M7SB9GFZBQe1hvYrIss71ssttX23mWocfoZgn3Okvy9RbDwFAARKH1
         PHobK0qjIUbQnheeRGyEjbnv5oRqpvCa6GGl3BGga2YYTLFbJs+pxItMUMeR69/rp16n
         9zAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790049863; x=1790654663;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Eh0zY0YbE6EimOoz3Zx8ySQ5kbO2KhlcLT+oImzRbUI=;
        b=URM9hcDQyqFC0JE71RUWkeLOwx7Ob3rd9OORDtqm+e0RHuIhVeZlPIMysGlusJGPQb
         ktYetvklA/6RDN+7KIXDFu/SOOuvYwjhwQxwGQykxV4J3cCNzBSGLtVOjJJ5sLmP+WxK
         SeHI9y7J9zv6LiFJ3WLKIekHv/KpNjd5fMNQx0tOwGsDEk97zm7pppwnoUHcfFCNH1n3
         C5P9GLQ/I6UOooCDs3TVN7a3Nk8AZPlREW/jZT7cWLPKgT5InqNt592EzRGauGbaeqg8
         tfDg29RhshKFOQHoldD2TN127dZ1kC2O5Rq/iSV4dCZ2U8InEgCuT/+F1VilOpzOkVMJ
         FoAg==
X-Forwarded-Encrypted: i=1; AKwUvBxkLiFYnkLPB/790J1MRNCKeZGsWDiqEe2gZHEQOraMYFhOteiEhi1TpiD6yyFXkipYa0I=@vger.kernel.org
X-Gm-Message-State: AFuF++mwSgn3KcSrKUpo5okIEF1cPZHi8c5ZyPEN5M0dw2Ufs8PpKgmw
	yIgUD20/qlSserySUG5MsaTAU8I5lEXnoNB/9Bdj7fiblJsGWVXuly5X
X-Gm-Gg: AYBFou1to15AG92X75b6ijoIMC0tjeUNk+LsgO7avlBTfeiJGV8FRQIrGayN8AaCcGi
	JYhVGTBtxZ0YTWLXB+xmEbqUCcZmsM10RyMBvoPJx7JIdQVHr/J9khDY25uy2V5y0dE8rAAH5GB
	utiyVL+vaS3E3yy71th0Mxk8xxibJefq5Poy8cz4rMJFxx/xqohPj4UtaQs91OuUUO1w+2bhc3K
	YaX0+qE+M++eZtj10jbupdYTBb3Ofp0T8wt1T6uFI4PCBmHqYETA96n/EhIzVBXJfYv8rdA2ZJt
	fdGqraAtC3ejzGTriNhd6WjhRHtGcmKTTooBzpfCsmww7yg5BU4gb9M+WfCGG/kO1JNwaTo+qCk
	XLxBaxSDz8/7ZImM5OxS9PaNLxXaMCZbTluzPSPb3eDOUr+QvkXrQM7xzBAsOePrVP2HhQiBBfe
	VmXrrK7NQa/WNID3BsoUOVXk0dR6x+5fOpW1tvd2EEZ0jjI/H+pHlXbe76nhz/kyZVcyp2pM5pZ
	/KB4fl3CS8yvazt4R4gQ2bg/VhZbjCpAh7qA+L8T5sm9sM7BvWrbemJoW7uyymMWkilRreyHxTO
	m9c=
X-Received: by 2002:a17:90b:4ace:b0:3a0:4023:bb00 with SMTP id 98e67ed59e1d1-3a04023bca4mr7107708a91.46.1790049862995;
        Mon, 21 Sep 2026 21:04:22 -0700 (PDT)
Received: from localhost ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0674a5ae4sm2230525a91.12.2026.09.21.21.04.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 21:04:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 22 Sep 2026 04:04:22 +0000
Message-Id: <DLLJPU88F1B9.1T58POQICACW7@gmail.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Eduard
 Zingerman" <eddyz87@gmail.com>, <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next v4 03/20] bpf: Add lookups for exception
 cleanup resumes and landing pads
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Yonghong Song" <yonghong.song@linux.dev>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.20.1-349-gb940a4174a3e-dirty
References: <20260921210033.1715000-1-yonghong.song@linux.dev>
 <20260921210048.1717268-1-yonghong.song@linux.dev>
In-Reply-To: <20260921210048.1717268-1-yonghong.song@linux.dev>

On Mon Sep 21, 2026 at 9:00 PM UTC, Yonghong Song wrote:
> -static int verifier_remove_insns(struct bpf_verifier_env *env, u32 off, =
u32 cnt)
> +static int verifier_remove_insns(struct bpf_verifier_env *env, u32 off, =
u32 cnt,
> +				 bool falls_through)

next time pls ask AI whether Alexei (me) likes bool-s in arguments.
I hope it's training data set is new enough to know what I really don't lik=
e.
I ranted my times on the list about the reason why 'bool foo' is wrong.

pw-bot: cr
