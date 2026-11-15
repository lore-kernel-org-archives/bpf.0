Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794755197;
	b=MT6ZJ5fzjvIykw+W/YibGBTTuyWdl9T347f6evdGinnZ/yk0unoD7qu8w4tOaaSnG9kE
	 +Wba4g1hYVdQ/oi60F24rg9eXyvMVENzLUktbLCGzPwV1TpMxuzg6dHOe32E6KWu5KUKS
	 AA0SpXIbiGib+FZ2uVPlCBoHt4S84RbFcI6xM0ty/2ZuMf1tY9U2etBqUQ6QQw6F0EMAw
	 ve1s1oXbqtNUWUWTFcPqhYzc6KzAI7cfG/ARhcpT3ybdztTNbFOTbYWDGpQHDDawlCQyc
	 cmBxDXH8iA+VpXLcZcbgGlPdSSTH7DnuFk/oi8b9IVOZYlzwQDxWpFlw0q8rTCj2VGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794755197;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=y/hOIyUcvAfKlaaXm+bgaXHbjM9PJioyHvxOcCFmCQQ=;
	b=ymEUNHoNmQqsQN1NdT30HwKxVOlsLfFlf0GVOaMlobyjXxwmvfAHdQ7fTqb9+RCW/nzc
	 IPSffdno972dGfewqjPxp3+JGopebVNUbRNuhCJaCunfIWXwYphiVrjVfCIrovP7uHkVU
	 0zRggwehmxy6pyVtrc3Xx4rW0ECLKue6uP05gg4Wdt0TMsX2EH3E5sdy/4As9lzySP9DV
	 FPs0LB1XK1r2Vae1cBzDziCpr33wr0AE9CYvswvg8JSvki0b4Z4fDSEaTu03KqcBFqXG4
	 CRRiCcNHgYQMPk0HP9v22tJo+TeXF5on/aagqLS+8iJd0Y+2FedPGK8kDJFmhywcvIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A2CxOg0u;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3C5606A31F
	for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 15:06:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F3C5606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A2CxOg0u
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4bb6886d30aso5604025e9.3
        for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 07:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794755195; x=1795359995; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=y/hOIyUcvAfKlaaXm+bgaXHbjM9PJioyHvxOcCFmCQQ=;
        b=A2CxOg0u4nA5j2QwWMCX2xov6hIZN16xt8onwYD8iiyiAmefaUJoMWy7xFANfTWq3e
         b2Vw1nSe0DtU76RQo6cvDZJfosmWeIYVTT4tvIbqCA21YFldIqfypY4/lOVrBjY5f5Ws
         4fRK9yBDQMVa/LTBdWIjf4ivi1vmColGKsZo/1rnE83gpKiU/Hwvi2dCjToI04dcUG99
         5Cs/R7e51IBr6ubNPMl7niPd4VnEjeUzqhpbUDoyd1rAVesZRug/8vJFXr8RgwdKvQ8o
         L417AZpEqKuwBbhYDbV7yLkjyrKK8uoDyka2WiK/Joc7HZfWKIaZ0UcTG0SeY7b3XiFb
         kBGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794755195; x=1795359995;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y/hOIyUcvAfKlaaXm+bgaXHbjM9PJioyHvxOcCFmCQQ=;
        b=HX9HtdE2VeTbWHu+z9RbuIjSjm0SPaXkjBLTJFtkgmIb/rFxeOudZxyW958ik/uXFF
         mylc+eP3YosW2GhnFqFzK0Xb9DT423u52zLeu0m0mWUl+CaaPdABomdWrQ0ydA/O6W9A
         RHZhtKR2sN1fZMC5NkavhEFb3GTlInz197rl4YyqB3MCczKCg5ag2ycBWWR75x9Y5jeX
         1VddLaTFYbrxTsK/lm8HwnSVUPzgOD3Bs1iJuhtLbkPU8u3gtQbE/fx9r0HAC+XtXvJk
         4/uX8L0tQwSpUsxHo5vSwV1uYJfBG0R4olXBWBz3k2eeKEAnIOYSC7rqx9zBstEwHqje
         D6uQ==
X-Forwarded-Encrypted: i=1; AL+hErHbKWM/V8cYheIHex2oY3xOK1G0MfEvZLLquOxrypCCFi0cyqHup4JotfbWlulXsfeMXpg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8B4NNSHgoSzNtZoPJRAtNuXrvR/B5p6Ukw28nn856ezPAeJ8NL
	YE3fQi7Qvz5mK5UkM2AVOfLf48ZbE+IcQS/BBXiRwvk2fjda9Q86HvJs
X-Gm-Gg: AYBFou0Qovus5lRtgD1xyrXCPzw2ZWl+k1vA5PkYGXkY+TksQrgbNrQ8I1YdYF8TQT7
	t0W0KDQbOOh6x/Zpj4fM5Qm/hvBjHE9sxzBrvaeQBxoJr+T3STNcZNaqxF5T3eCj3qGwzeC7E3H
	4Q28sZdH+eL+9y721MB0pN7e/+Tl2MjK+hvAoej638s5XsJaFTMsdBkRDQbLL01P6ZaL8+gf+dU
	uw3SgBveiOsgbJQtTMtRy65TR8l012SquYmXi2neqPHz/qMEi226SXYS6738lBblsVMdmtqcMUA
	TOHc5uBWhe8Ztyo+6Koq7o7BIUEwDvBgMea/P6tCQT3+ylgXO6exIoLBdvxVDrqHBTyZvtcJ5AG
	+xZ1epZhUNPJR6uf7EdIJbh2QZuZLIDWK1Uedv0lqYVCrURMjM+jstbUJImD8lbEPuyGeS/WZZh
	PLn+oneyd/RZB5BKpGLaDtiPWBBjErxVPs7HsrNRaytixUcU3bG7tWckB9X3nezsuNoCd60mwCV
	GfniRblRXkK1hm1e/uGbqA6tOr/kWTf8bSpvFu/tmIDCU18ks4aiJpwzZ1iGX8MeZmV7Ggy3seS
	A082IwPjkJaDVfPOo2czxyeoIhovAbaOQrpKv9EHYS92Cy5030lP1fP/3TuGVRAg9g==
X-Received: by 2002:a05:600c:3551:b0:4bb:534b:ada4 with SMTP id 5b1f17b1804b1-4bb55abdc18mr178633625e9.33.1794755194903;
        Sun, 15 Nov 2026 07:06:34 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5ff2be55sm17236146f8f.28.2026.11.15.07.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 07:06:33 -0800 (PST)
Date: Sun, 15 Nov 2026 15:06:31 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: andrii@kernel.org, bpf@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev,
 alan.maguire@oracle.com, shuah@kernel.org, alexis.lothore@bootlin.com,
 luisflavieira@gmail.com, ameryhung@gmail.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 1/2] libbpf: Fix sign extension of unaligned
 enums in btf_dump_get_enum_value()
Message-ID: <20261115150631.3854c17c@pumpkin>
In-Reply-To: <20261115084923.53182-2-dennylin0707@gmail.com>
References: <20261115084923.53182-1-dennylin0707@gmail.com>
	<20261115084923.53182-2-dennylin0707@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 15 Nov 2026 08:49:22 +0000
Hungyu Lin <dennylin0707@gmail.com> wrote:

> btf_dump_get_enum_value() reads unaligned enum values through
> btf_dump_get_bitfield_value() with a zero bit size. That makes
> right_shift_bits 64 in
> 
> 	*value = (num << left_shift_bits) >> right_shift_bits;
> 
> which is undefined behavior for a __u64 on both endians. The path also
> bypasses the signed loads used for aligned data, so a negative value of
> a signed enum can lose its enumerator name when the data is unaligned.
> 
> Fix this by copying unaligned enum data into an aligned buffer, as
> btf_dump_int_data() does, and reading it with the same loads as aligned
> data.
> 
> Fixes: 920d16af9b42 ("libbpf: BTF dumper support for typed data")
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
> ---
>  tools/lib/bpf/btf_dump.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
> index bbe86928b3ec..a80762a70cd0 100644
> --- a/tools/lib/bpf/btf_dump.c
> +++ b/tools/lib/bpf/btf_dump.c
> @@ -2329,16 +2329,11 @@ static int btf_dump_get_enum_value(struct btf_dump *d,
>  				   __s64 *value)
>  {
>  	bool is_signed = btf_kflag(t);
> +	char buf[8] __attribute__((aligned(8)));
>  
> -	if (!ptr_is_aligned(d->btf, id, data)) {
> -		__u64 val;
> -		int err;
> -
> -		err = btf_dump_get_bitfield_value(d, t, data, 0, 0, &val);
> -		if (err)
> -			return err;
> -		*value = (__s64)val;
> -		return 0;
> +	if (t->size <= sizeof(buf) && !ptr_is_aligned(d->btf, id, data)) {

Do the alignment check first, you don't expect the size check to fail.

David

> +		memcpy(buf, data, t->size);
> +		data = buf;
>  	}
>  
>  	switch (t->size) {

