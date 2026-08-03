Received: from mail-wr2-f2.google.com (mail-wr2-f2.google.com [74.125.225.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6FD1A285
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 03:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785727033; cv=none; b=oXX9jqndkW9/08b4U/wT/XSZXbwIry9H4y333pV8/Visxu2pGuN0/hwiHSjuNgdfSC6VkQ/TklXNyvFDoxbc8XdKSq23fm21TQTO+STuWbneNYtRn15YJxZ4aguaCxSrYcTqzPJAiZ0OlgXtPfk0bP0V0HT3heHUrKPf1FpQj3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785727033; c=relaxed/simple;
	bh=LuBiozdJKzz5NyrtOIBZY9XOevd6/s9q15L8/MQz580=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=EZGJEpG+E/eCwq6oB9a4FgNqH1mAxYNzOs8fW2+jbvoVnFB4a+eYH0qotZgN8RsfuLaP3L05VGYaSYG4XcQDkBpeejZP+LERiwgA3rfefddtvybSQUdqP4plwzUDM5Vue+olCnoGmaWB2LfmO7JhDWQjAQMdqMr/tcUCEbTyHfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MhJe5awP; arc=none smtp.client-ip=74.125.225.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MhJe5awP"
Received: by mail-wr2-f2.google.com with SMTP id ffacd0b85a97d-470713a9053so848479f8f.0
        for <bpf@vger.kernel.org>; Sun, 02 Aug 2026 20:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785727030; x=1786331830; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LuBiozdJKzz5NyrtOIBZY9XOevd6/s9q15L8/MQz580=;
        b=MhJe5awPVERooDuzKQcqe1XhPOpFdZCjgr98X6Oa8dAkjSIEkltUSWLaJ/K8pm6/zA
         B+LPN21mwXj4DFZvtnm76pzMm2bON0MlrQEWCiO66Vnvcr7ZRKOcoqeouLz2DHJxmQkn
         Om0UBxetW23klE2q2GgSDYqSILAzmZqQupRw1rDGADUqoTPpwUtiD8Xv8cDNfvHHriw+
         P1udPIH2jQ623YGbRdvVIaGd+X/SRAOLu/a3uF4qSaQbSAcT62S8FyU64BmDtE/Fj1GZ
         Ttb5o1ArlUkD9qXwzUFvBTqQdXrow4CZeC6JMWOuJje6Jh9DkdodF0yTzOEHumE+Qu0k
         FmQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785727030; x=1786331830;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LuBiozdJKzz5NyrtOIBZY9XOevd6/s9q15L8/MQz580=;
        b=DU1UYimFy0OnWJHpt1wCWJry8GMAna0/WRpJ2xGnaSGQW9ex6R5o1/L4As9N6SuGTa
         8jXif1XFV7gHNhv3Drp+EOxxnBsumdQknd32znkUofBgKfUWKO2FPiuEpM7rx+WLFDkN
         sTw9AUizbxo1a5mK1QniI1P04hnO760hFSKISLIAnobzN4sgY6u+pUZDEsEU585rSs9T
         7J82ZgrBjNq6EyQCkOCF7RKFYAOECG4t9J2dAJPz/I22UekBw6kkBOUkmEw743os+Qzr
         imCnl7dtGsB08LtfOAshZpY2dOYduFkviHkoMJ0SIDW4uHx3HJRZwFykNfDFLLCd9g5o
         i3Kw==
X-Forwarded-Encrypted: i=1; AHgh+RqFmM4HdICHJseCaAteJIY8PfYTnZ3qAv+ME5B3T7bXmwdXlgo5RyZ7IFQXAnkqW388D1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YygptMbJ9X4FMkFs+MKJh5Vppb7Rh/G0UI2O44mlGzuMqxm50nZ
	ZeL0b3WOygGp2UgrJwfZg2kOsf5Jhw8+mUW23qlyDK1RdlqrW1bFQKWI
X-Gm-Gg: AR+sD10il8tBz1aStGV7bRAAo7sFc7ru0gYTyfOtoQTOfkm81FTNImq80l3Mb+mOvVO
	cf/hEq55V1+jtZgCQT3jbu21LPDYjKNgSF3HXMFlswR7o5nZ4kAWBpp59SwIpw0lrMOkl1YDltr
	FwHAVUMaxojTCK+QdCtoXQn8l2QAOWMG9SnJysQj5XjTpR5smSxQqM9ikTUV3I9X5lhNR5FKX1N
	Cq7/IQMJWMhu08sByvwqkiHD44Ti4L8PqOmhmCjNm6DB/fXSNQzpgOnFV5SopiQnQjOhZm6Sjr9
	HJxpIJBa434FENwfSUdV0Mf2AuKrhPIUm9OWVgaNk8bGt9UVB17tXf9C37vc78PQmc6R6ZcWrsL
	5z3GntWckMOJy7P1YVNEeW5/ElRHsso8xYAGMyIfrs4Yu5H4ssisNcgGPLGgGIJ4NH1YU27ZBts
	nT0Gj5Op/ZzpqchGNTlTRZPedZstUaS4LmgvLJtAxdxG3UsfHpRIjWUn1fJThFWoFdG/d0nfULw
	j7rOtKBcqvZcDhms2T8j5rCpYtBhrLtDAHzAJzHWGZzJvmZxdfxKVLMSTn5hVa3NMbgPQxStkqV
	bMgtJI6CUNV4f/VXFOXl0AXWu/DtlwSrlfIu2Q==
X-Received: by 2002:a05:600c:c8c:b0:493:f318:3bc6 with SMTP id 5b1f17b1804b1-4980c6564d5mr157761685e9.13.1785727030165;
        Sun, 02 Aug 2026 20:17:10 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b5f0c3sm171638665e9.5.2026.08.02.20.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 20:17:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 03 Aug 2026 05:17:09 +0200
Message-Id: <DKEZEGBMWKDX.N0LZBWMM2290@gmail.com>
Cc: "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 "John Fastabend" <john.fastabend@gmail.com>, "Emil Tsalapatis"
 <emil@etsalapatis.com>, "Ihor Solodrai" <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next] bpf: add BPF_F_SEALED flag to seal BPF links
 at creation
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Leon Hwang" <leon.hwang@linux.dev>, "David Windsor"
 <dwindsor@gmail.com>, <bpf@vger.kernel.org>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260803021643.2189641-1-dwindsor@gmail.com>
 <a68933c3-39d6-414e-b869-bb3fd1a6b4ba@linux.dev>
In-Reply-To: <a68933c3-39d6-414e-b869-bb3fd1a6b4ba@linux.dev>

On Mon Aug 3, 2026 at 4:44 AM CEST, Leon Hwang wrote:
> On 3/8/26 10:16, David Windsor wrote:
>> Introduce a new BPF_F_SEALED flag for BPF_LINK_CREATE that creates the
>> link permanently sealed. A sealed link can never have its program
>> replaced via BPF_LINK_UPDATE, can never be detached via BPF_LINK_DETACH,
>> and holds an extra self-reference that is never released, so the link an=
d
>> its program attachment persist until the machine reboots, even after use=
r
>> space closes every fd referring to it. There is no way to unseal a link.
>>
>> The sealed state is tracked by a new bool field on struct bpf_link.
>
>
> Why do you want BPF_F_SEALED? What's your case for it?
>
> I think 'sealed' should be set before allocating the FD to avoid the
> race issues reported by Sashiko.
>

Agreed, then we would not need READ_ONCE() on the sealed bit either since t=
he
it stays immutable through the lifetime of the link.

> Thanks,
> Leon
>
>> [...]

