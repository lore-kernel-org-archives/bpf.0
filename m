Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795673206;
	b=NU7f2dz7EbNIhdRWJX9eXwGTpSH2/X46LHPqbzTz/OB+NaOdJTHXx0dU2n+Vy1dAxupl
	 KoFr9J9YA6D0vgqTG2lPmyRRjsyzgIcKpPsRVNycKtGVWUejdG9GiqP9ZfX/OjpBkm7FB
	 mHzEi9cSeCxsZNePABDRjRu6iEjOIenrzR1lGU3jpTIGVSMmlbhXFwuGpobeZK9AxFzCY
	 zEk6F1Py8gUuIhiYl9VX1HKWjOJ595Zy1CKSTqmmHYiifoK2WPIdbRUKzJ4VtLGvD/X4e
	 Z2ufOztDIwYkhZirbEvuETJCDaC0mRmgvuNanlcZUSpeo+dyqSRE7XyuoLANXj0PT2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795673206;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:Date:
	 Message-Id:Cc:Subject:From:To:In-Reply-To:References:
	 Content-Transfer-Encoding:MIME-Version;
	bh=rgZI8bJgZuUFpcROH1WhHUr+AAZ6H3onNQ6CGieUEr4=;
	b=pCxGfXUcMQ0+T97+m8l87t/xfGTraa5M9jjsWlIOjBdZi1yDRircMJw9tvhUwjkqvz8Z
	 y9Q3IZhOg6VML6qe/oN4Zq4NGD6nsa/GJcR+V58hBkOigSTL3BzUm7G+r6E7NB4K7ci2J
	 zSSD8Hwqr7S7p24BrlH9ehFXmznQxvWV/+FSGIeK000IvE6EZDQ0mTgJ6lNPXpb6r++jJ
	 cmbJ0MteSb5HA3ZYJAM55EfO16Id23xR9TxEc0c1OkLnx4ZTvsrsr4uSkBbANNrjqPHDx
	 4xSWnu1Clvmfvu4VDkkyRtoWxDZPdy7uAzLMlZ8FrWGo2gmW4HfDfNpmYJw8kQ6Igpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=niWKuk1P;
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8CA606A31E
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 06:06:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB8CA606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=niWKuk1P
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2f07a960666so45419175ad.1
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 22:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795673205; x=1796278005; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rgZI8bJgZuUFpcROH1WhHUr+AAZ6H3onNQ6CGieUEr4=;
        b=niWKuk1PT2vuPBvZtqOiboHCy/NqOBPF6effjQvkh9munHdBOxrEWGk0m2QEULy4Bc
         h0lgnHuDtzWsJobYB0IsgQjhn4yNowB69wjs27yVSiY6pSqMCIoZjCaeeiWB9F10FnnP
         QAzLvrNNAZ7jmVGryOF9s7bV/IcBKqNkMKIW2IKViavN2Z2TksuR5/2RegJhA9+SGkEz
         vBn/oY2TXogY3zG+UlBn3/bCWwy2igmGZl1bhWvRtEiAN+VVafnIBCKPui9wql1SR9tO
         cr7/a8OcZwdxpLcS7LcYoEvfgqR+aMr1MH/eD8xkHKIFYke3lXiUFTR4xCN8fa6eGoNh
         YEzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795673205; x=1796278005;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rgZI8bJgZuUFpcROH1WhHUr+AAZ6H3onNQ6CGieUEr4=;
        b=UBCgamOC8/x/Ej8jqOte5jODoK6nzpy2Te2WsgVaEC1YA72ytk1jL4aawCPQRB4vHA
         Nrh4vZqhh5+DHwqCuHJUAk2o2SeKhJw6iqVttf6BcwzErRbE/CkcaE0S1XdO3NMXK5KG
         1k/PT5ihACHTXoAbuKqB/peg+7D79eewzkU3/u3P3JWug4P69vDJ8Pa4jw8aVikVLCds
         +HGmyFU4BeKCB8AJSGdWeFli+rRbSOhHrBkM008WEYOWuaj9TKVHnO5RoSRsuvkegZKn
         14Ip2xy+cGCharijrEkNpY2pP79dAZmlDf77Wp/dQgWxcTEMZ7vzKqrUo6uU00oWXPTU
         1NtQ==
X-Gm-Message-State: APuU4Z+iPvrxgEPVTq0Ihip5rATK8T/UmfEYfsCkQZ8aRMuaBMXXipjM
	yPehZIImN92MgHlNhMF1UFsmMMqqONDu/wr1tEK89vYw4jKT4Fhw4zaV
X-Gm-Gg: AZFdTZehwq6AiReUH845yWIR1qLwPjWAlWq0W3JeJ1qnXcvWEV5qWe48bPo6uu26aDw
	aUlnn25Hzg5bpJg/lmJH1cSj8AovoyrD46HogE5NSE6P1tLP+/qajej+1LDS5tTpplFxmDSpQR3
	hwN4wOOkxPEPx4+5kUF/NWOfUDDGMXCbqF+L1R0aojgO2+t43QZfuTJd41I7AVY1yCp10I4Brg5
	fa8B6+butGxLHeDfIiwX6rwKFQNKvDxYO3XKFR5hbgDg9Bj8R44Rl3hqUjF7GdBfh/BwKnbBG7I
	8j9twWsoB5mHFgJDVurv2Tgx7eo5rfZv0zY7DL9NZOmMH44Ydag+0JPhJic2sCOqVow2lUmGhY9
	uIUmoRUjmnd23TTCVaPMsJ8plP8GBPD0HiB3h6J8GLWKbM03KlpBVFnFLuw0qv1aNYvFuic3syI
	qCkZqpFLsJglO/c8TdKgwwZzy6JflwhT384+qhcD/b93ZPuG7GW/+6dY+qzOQXzcg9zv7ONAjp8
	8gw1vi4FG6PeNF3zVPHG9d3FByCYFkeKUGUlAqfz5HAX4bddVDLQ7/lPcFmEeOWva1byZJapmxQ
	SQAr3C0RgNrmc600ZiCaJoMHME2L5uB+B6q5w+45TTfRaP9SNWS1fmjwbr+mU9L0dIEZ74156h6
	lFqzKKKI7pdQyIE6I/Gha8E3xYp4TWluUQzJn
X-Received: by 2002:a17:902:da48:b0:2ef:d1ac:c97b with SMTP id d9443c01a7336-2f03f19372dmr200960655ad.61.1795673204870;
        Wed, 25 Nov 2026 22:06:44 -0800 (PST)
Received: from localhost ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f0b58fce71sm44555485ad.45.2026.11.25.22.06.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 22:06:44 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Nov 2026 06:06:44 +0000
Message-Id: <DN4X0XRWTM33.F4T4JF23X58I@gmail.com>
Cc: <bpf@vger.kernel.org>, <loongarch@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, "George Guo" <guodongtai@kylinos.cn>
Subject: Re: [PATCH bpf-next v1 0/5] selftests/bpf: Enable private stack,
 large stack and arena tests for LoongArch
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "George Guo" <dongtai.guo@linux.dev>, <daniel@iogearbox.net>,
 <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>
In-Reply-To: <20261126055355.9967-1-dongtai.guo@linux.dev>
References: <20261126055355.9967-1-dongtai.guo@linux.dev>
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

On Wed, Nov 25, 2026 at 09:53 PM George Guo <dongtai.guo@linux.dev> wrote:
> This series enables the BPF selftests for the new LoongArch JIT
> features, and fixes a libarena build failure with clang 19.

loongarch folks take JIT patches, so pls don't post
anything to bpf* until trees converge.

pw-bot: cr
