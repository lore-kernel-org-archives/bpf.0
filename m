Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FE4371D1F
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 21:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790284311; cv=none; b=gX5ciHql6D6e2Df7gy4kzydSAp4gew8FxN7j6JnLMtVYk9SCDdPfz1eHkFuopSasGsX+jkXoxafXEbRQ4ScHuoiyl2hlCUiwKgw676T21fGWkiwah8NPVKDT51JdPDYvmkoKWGhsC9M09FC/UA+jPZM3tUIN5O4vqhLpp5YlyKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790284311; c=relaxed/simple;
	bh=4Hmz/aCwPxPxXQgsrAS2zMA0OKCrRCcIyPayyhnt0w4=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:In-Reply-To:
	 References:MIME-Version; b=BspdSJR6I5izd7/yicEuJPhq/RQCIRQ/pkb1625smeEJAckb8MI344aZ2snzSZVlnFKyNv3IaJFxIR/tH9G/M1AETocU/I19tiWgM9jOEsYW0/3NlHDPZSwJFEwZ+sg+bGVZxGyIXuQpVOxMUvNNeUgcGjw0ayoFf709BGeEcO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ly3TQp1g; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ly3TQp1g"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-85469f204f6so161213b3a.2
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 14:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790284309; x=1790889109; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A9yQwZzRCpiYQiJxF3BfQJ2oULkNnaltgNKkojug3hU=;
        b=ly3TQp1gNOBA/2eGU7lm83IWziJk5x34aC/D8lTKFrpibII/24kbxMGIymqM0Y2KKQ
         CgoxqgsGgr8Ues3NhZOwOG25OpgRGiacdM0tpJtuhvdHYfdk8hSFEu71b8JuinUE8RU4
         U1qZ8VQp+yp41YjA/N4daVn/ssjsMNGUZD4fmaIZUDL1q24RqA/9WQU7eW+pixppb87Q
         jN4frGRas0pJDiBjMdP94FH4ATrMjbcDM/zpu7lhqYs41922e/yzHAtg+X8FaV7tHvwj
         2BWeNXO+9a81tXb3muGVRC9nbG28gFdsE0KwCWvvddK0c4pguRO53TkjmY7Y8ygt7sWT
         osKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790284309; x=1790889109;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A9yQwZzRCpiYQiJxF3BfQJ2oULkNnaltgNKkojug3hU=;
        b=ylPePWwgLLHIyQPwZiAipkIa6pIE/QJjfUibPgB48P7WX3wwavkgAecdeqK9h6/XjJ
         7qjRhc+C9pYcKWr5EkM+iSoLge3asxVHObxazLSK1BurZ9UDxkPubUdr9IUB9dNhJ3Er
         T3t3YCOk4X2kBpHDos+167xDdccQ5ecB3MurbBKIrWC0YPBCR1eGr3IV8PAIb3TePcw/
         BHQAj4CFiVX6/Rib4QbyQADR9f8oJoV4VuKSBW0Z3FjIAxcF3+fGqQ2ylNausnT+R3wu
         zCykFTlHUcxjgBClIRe4VZTwKjb3Ohoci9gqLV1rN1D+WDboofWbhKSnW6EYn1GdsVEI
         0oFQ==
X-Forwarded-Encrypted: i=1; AKwUvBzYxYXcIG+OazBYzQr1ZDWVv/9xtfllDniPh3NjSJ/WDuf08hENVmzv1xb6Dl7kzYBtUDg=@vger.kernel.org
X-Gm-Message-State: AFuF++k5uaNeG6JkYBRXmyZjNoIvLM7wkm7Zx1qpwqeA8YJhy41h8P1o
	KIEIaLRuSd1yR8EjXu5wIEeuptxUs2AyODPxcxZEHFB8ClVq1cyWpHGl
X-Gm-Gg: AYBFou3ZVganJCLG+0HYN37BIxGnj17/P9ecnhBIsE+8s1kvOh2fErW+23buiPPsYdA
	jzHR9VR/h8W/oOfnB1NAihARP3VyPmQE7k/UcbXEUs6LkaCnXpj5L3YW+3P4xUrfXE4ngOK6Tqz
	JgnCDB0WC28H+J+wRhGwu96iNQeWFiJPs07T7EK+gFeqJbdFtwzGDg8w4D3/vPtbJ6DKpc9nHRI
	FynnjhydoGEQchEsslfj/O8NZgeHe9FOnQXg1sa+5HuvTx4i8vpVZNC8jrXdhiDh01GgjWEzVEH
	0QRHTvOHjyRM+F4dWlez8oAtaJTGi1JGFvNCBw1GAzJMWqrVrZefthLgiy2GRpTJzQUGIcVwxKh
	lFi4m5Bbn/pzW37dBpsaRsYfXhttWB/vDQPcLBYQTdOteBJec+q72sKxKnn8ljB0TAFJzFtsr62
	uJbXu9cdfd7QqmL+X6UJFgi1iUBinreygMqteiYjqwgxWr+2droK2A/LRqZU7G6Yu3OrrAdvz5a
	Pb2AooPocVkk7pfoI5v5pu2Z/wDSnOPsu54n/3Gs7ZDc5NxXOqB5trElbEGRJ2Od00u//MGF5B9
	z6Y=
X-Received: by 2002:a05:6a20:7d9f:b0:3dd:a197:7371 with SMTP id adf61e73a8af0-3de0e938760mr3627017637.74.1790284309137;
        Thu, 24 Sep 2026 14:11:49 -0700 (PDT)
Received: from localhost ([153.61.198.251])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc78791d7b9sm259426a12.14.2026.09.24.14.11.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 14:11:48 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Sep 2026 21:11:47 +0000
Message-Id: <DLNUTL0UJVKC.NN3B416MJ0BI@gmail.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, <bpf@vger.kernel.org>
Cc: "Andrii Nakryiko" <andrii@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Eduard Zingerman" <eddyz87@gmail.com>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Tejun Heo" <tj@kernel.org>,
 <kkd@meta.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v2 2/5] bpf: Add file descriptor interface for
 program streams
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
In-Reply-To: <20260924162641.1922423-3-memxor@gmail.com>
References: <20260924162641.1922423-1-memxor@gmail.com> <20260924162641.1922423-3-memxor@gmail.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, Sep 24, 2026 at 06:26 PM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> +static void bpf_stream_publish(struct bpf_stream *stream, int len)
> +{
> +	/* Pairs with atomic_read_acquire() in bpf_stream_readable_bytes(). */
> +	(void)atomic_add_return_release(len, &stream->readable);
> +	bpf_stream_queue_notify(stream);
> +}

This queues irq_work on every bpf_stream_vprintk() and every stage
commit, whether anyone opened the stream or not.
That's an irq_work interrupt per print for every existing user.
ringbuf queues it only when the consumer caught up.

The result of atomic_add_return_release() is thrown away.
can we queue the work only when it returns len, i.e. when the stream
was empty ?

pw-bot: cr
