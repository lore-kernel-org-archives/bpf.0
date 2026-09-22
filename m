Received: from mail-oo2-f39.google.com (mail-oo2-f39.google.com [74.125.231.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4270B4A49B3
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 20:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790108141; cv=pass; b=rWlrukpscXQ1l17f2iv2pwllvDiCchwbP9NdxZT2Ng1WYsXd6gCRwyXgUgCEyrZZWRudRBO322E7+I6Pw4+ZRCuSkNqp7VZTeEp9We+XORpki/dpvBaagLeF2mGaiUlVBreUyyoEsZw0MBysw5nntIej2qy3MwnQgYYb8yo3CrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790108141; c=relaxed/simple;
	bh=mCEp/0gDCFHj+udesBZqQz+WyqBpGnnRo9HeqnIVIaI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rlqMy2di6LwAy00PhX2dCL8AGonVpNPYJAFkwrpLR9L4K0tHZM4uPp9XIp3prCI3vd2d5YPl99EjDWlS6VW1z3lszZRtfYctLaojQ6LiUsl2Z4LuBz1w9NfjF18o6yuxudy34HYWVNjSobc7F4kyyQyzpCxDxkM9NQy2M/exuF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dsGy+Hxn; arc=pass smtp.client-ip=74.125.231.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dsGy+Hxn"
Received: by mail-oo2-f39.google.com with SMTP id 006d021491bc7-6bd42f1c01cso151588eaf.2
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 13:15:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790108122; cv=none;
        d=google.com; s=arc-20260327;
        b=AtW739mpVerfE6vEw2xuO2Ev1Ma4WRprlriDD8noa6kz5mx+kW3+NPT4a7VUVnR7OL
         lNNw01zywbi5SivvpIkZzZ+P+qASDresdVj7VfbNDhn1+rTdfWD4eXZWZA8JI8SAQnDI
         iM83Pxc8f5HF+5P0mhqnoQoU+xlCA38esfiCKyQz0Icv7nzTEeRR1lqbyIfwQR4wPnN0
         HXziRDZOgmBPZwz4KLkPal9KD/2Fmv2QCEobnXXJlPKPCL1JRf4l/vvutd7gK1j8WMD9
         kHxo0OutuTVa/n0wl5nciGjRDUGwzyS3duRYY+Biy5qTBNWPWIaWZk3Q1c4Ijt4wQ92M
         VSOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uVx3elEB3t8n1eAOngOcFYDzr4OwdmHXD0B/yfUjmwA=;
        fh=CBAo6MQMHgA5MRbUa815kkt+KVNLMhChIWh90PjX8rA=;
        b=EwiYi+c073WV83Iu6vQ3K/WD48Hq73QlFkgw70d3SwOOVXYUOU7Z7JegNIzsxF/+jT
         33a2y9sD3TcJ9JNWnAXSEPze482yodbt3CuMablHA1BKJxNBVL9V6yxg7Cjo9gcROHXs
         K7HYc7vj+Wzrzj1q825z6t3XhXygsw0GxMQ1bSRh1Rg2gx1KmA8KvOv+8J51lMSH7EwR
         +s62chORZZheEnIbQa5o6BVkwOIRqZfNNM9tr89RCskXsWKdU6Xr4Nz7RJkE+Tco8qey
         Jno6c3nsGaggWt8e0/fQst7DaZWHQp+Iutg8YgtC+4Kr2CI/yTmdnziLu7SOZ8kQz7Nk
         OzPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790108122; x=1790712922; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uVx3elEB3t8n1eAOngOcFYDzr4OwdmHXD0B/yfUjmwA=;
        b=dsGy+HxnaaSNCejDg0NtLQ0whRocRiavLOEGb/SGmsPw8BCZbdVXdba9lEyXK9Gozw
         3lWF2M+SvH8iBMqk3a9u5mSmgDFyr9h8jo337PdSZsNlEUbbeHfuMGBuZ36s6mZCH50p
         h8W/DyfLgtQcXJABi/liJv6tx/CSWRP0S4FO+7RddaRvecNVuVeY1okJL3AopxqXF/iX
         a9MH07tAR6dSX6qHxBFJ2UkLIaQrYd/glJA3KbubMgLD95rFM9YVEt19UhZIykwKOrni
         sKhkSKx+Icwsc1gFXjcDVFmi75MUFGbe2CUKWs0CZ6bG7leUlfzzlFqM+ElfmhG160yx
         V14A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790108122; x=1790712922;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uVx3elEB3t8n1eAOngOcFYDzr4OwdmHXD0B/yfUjmwA=;
        b=GY12aa1r78OcI66O7vWTZHwFlERf9Qbk3kSHq5UA9N/xNM5g17MIja17WfoLf9uT0a
         dbTvYzCcOzy135hhPNpxqJYxgH+XgbVNRf6Y1e2HGXRh96/B7H76uXa8GX45Dy095M8E
         n2kgNNsdrgj8KyriEQvACNH2eonBzZ/uf2/M32A3sefM9Mk4RZm0OP+sfNW1cS9BwZda
         EGXNsVBeE33aKKIdv6KEH/DkzowMZJitjsC21qYgZ2iCqhNzjloWr26MITgRlTZCkc5q
         O6ALoS9YMK7uFAOMsW9F+Q8iuHg43N9GZ/185V/0NimvWCxjFXt4oIbuzK1XXw6jy+Vo
         Yq6Q==
X-Gm-Message-State: AFuF++kpPF5wKzrrUsJwI3hI6rqz6ITVFLZKHqo6yKAA9G8HVnYqN5y7
	gQafH4cLXHzG7mcwZTysheN0U/HlKICIQqBrn9GhgpRELnsSgJqiccGvj2wmMw7zOtcxkJPWKRz
	9HTFpMZG5pw4R2OujKqlNO/UOTFQDXZo=
X-Gm-Gg: AYBFou138UPtKJkCJ0u5McjaYz/Uq8VXcqsANfOvA67DUJXaYErum2PQfJqc9Ub/JlD
	zFg7Rlpfl8nSDXe+FfjpquQcT3Y/nmhReHnK+2jOzldy1ukyntSwZO1Tn/fecUiXAch5JFUHnoj
	Ud8mkqfkbhlpZvGx6GpBIAz4Xh7hBIph/yyX/ZF9hzYVrwLuX+c2n1yW6X5LkqKKtFANrUla+L4
	hshjajOsSkQiE7Xayjl72DZFN4SAcmb1yFNG/BWKOUYYxH17olrQMhP9fqXcNz4/pXqmJWkQJnk
	Tp0CM4zJwjQbwL5eRSRsV+tr4fblrlGbI83tl+YMHLcV5mRdJaBqd0I+PTo5O3eulICQhYrAy6B
	h62q31RY=
X-Received: by 2002:a05:6820:4c0d:b0:6cd:3ffc:e32b with SMTP id
 006d021491bc7-6d2d261ca81mr468446eaf.73.1790108122487; Tue, 22 Sep 2026
 13:15:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922172028.6269-1-emil@etsalapatis.com> <20260922172028.6269-2-emil@etsalapatis.com>
In-Reply-To: <20260922172028.6269-2-emil@etsalapatis.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 22 Sep 2026 13:15:09 -0700
X-Gm-Features: AcwNN1UVDsg65rPEAMRirnKU1eEF0cNOI3a7FG5sWYjRPvHMVqk42xmf1-ryA4g
Message-ID: <CAMB2axPZSbLNMONRt1NUi7iyji4zfT9MjHp315a0Gvq22opvyA@mail.gmail.com>
Subject: Re: [PATCH bpf v2 01/11] bpf: Fix bounds check for skb-backed dynptrs
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, daniel@iogearbox.net, netdev@vger.kernel.org, 
	Nicholas Carlini <nicholas@carlini.com>, Jiayuan Chen <jiayuan.chen@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 10:21=E2=80=AFAM Emil Tsalapatis <emil@etsalapatis.=
com> wrote:
>
> The skb_pointer_if_linear() function checks whether a
> memory region of length len starting at offset off into
> the skb is in the linear area, and returns a pointer to
> the region if so. The check currently subtracts between
> skb_headlen and offset of the check, and since skb_headlen
> is unsigned the subtraction can underflow. This causes the
> bounds check to spuriously pass and generate an arbitrary
> pointer of the form *(skb->data + off).
>
> The only user of this helper is currently skb-backed BPF
> dynptr code. Returning the wrong pointer leads to the
> dynptr erroneously being backed with invalid memory.
>
> Ensure the subtraction cannot underflow, and fail the check if
> it would. Use u64 arithmetic to also prevent overflow when
> calculating (skb_headlen(skb) - off) since off is unsigned.
>
> Fixes: 6f5a630d7c57 ("bpf, net: Introduce skb_pointer_if_linear().")
> Reported-by: Nicholas Carlini <nicholas@carlini.com>
> Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>

Reviewed-by: Amery Hung <ameryhung@gmail.com>

> ---
>  include/linux/skbuff.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 421f6fc45..c8e219030 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -4372,7 +4372,10 @@ skb_header_pointer_careful(const struct sk_buff *s=
kb, int offset,
>  static inline void * __must_check
>  skb_pointer_if_linear(const struct sk_buff *skb, int offset, int len)
>  {
> -       if (likely(skb_headlen(skb) - offset >=3D len))
> +       unsigned int uoffset =3D (unsigned int)offset;
> +
> +       if (likely(uoffset <=3D skb_headlen(skb) &&
> +                  (unsigned int)len <=3D skb_headlen(skb) - uoffset))
>                 return skb->data + offset;
>         return NULL;
>  }
> --
> 2.54.0
>
>
