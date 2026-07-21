Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0C21A275
	for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 00:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784592747; cv=none; b=rZJwHJeeFFz9Y4HZzM9pppmCWmbIgCRgsX+3nB7mWjUNnKNBFeqJIpeYU76eY019moaRED0JijlWN2MsHqja8vKGeTjm5TRp2JSfIduSaKVnlzixk+fL67zqFWDEknd52fy0SMCZ+NxbiLlb7up1eLpGwc7HZgq7+5R8b5/2pEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784592747; c=relaxed/simple;
	bh=RsxvZ2kjNpRuxeiC7PhLOyIc/slr6yzCYWGOMYLH9MA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=BA0oZBXvEZz5ixBVxlp4pfEZRImCh+cuuvXHH7lvJSk3aFL6rhzFvM95a0+JRlwqhveztcsHA3V5asw5KfBdTiO6XlpR6n13qTKCIQ4UsMGGUhPCH2dA8Z44QOvJMlxFNjGRyVb1u3hei8C7WbveT7a47PSxrcj0mlS0MV1E0a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=mR6hwAj+; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="mR6hwAj+"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ce7d2adef4so105984885ad.3
        for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 17:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1784592745; x=1785197545; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:message-id:date:content-type
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=onrnB+/aHr7Wf+QkbszHMvIqFKZqE++ytmEcsC/rl1w=;
        b=mR6hwAj+ENbCuxA17/4Y77ns/cj3Ou8n9GaV25zHtC75bcAGipdPPwYQ5RATmeYRUv
         78qHcseUDHBW2eFu7qaMa+7UNu/IkCfMBm3tn5tZjtH88X7QxNb7XrcfkbJHgwFdaSM6
         Fy3n9bMVBhU6Mc1c4+7CWNYAn80hRyBU74uK3KHTSB+ahQDi8uAMmHzYSZifiVtamTsX
         Coqedl0zFbhrcsvKlpGR5KF+++T7qdXj5X7cJyj4xAW5H3wlE8BOmUukGbmIlKJcEspb
         SZ4CSPBK6lb6+Yp0IaJbFh3GCkDndtLgEmWGK9zG1h1E9VnVzokASww0kpE0Ft6DSjnJ
         pykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784592745; x=1785197545;
        h=in-reply-to:references:to:from:subject:message-id:date:content-type
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=onrnB+/aHr7Wf+QkbszHMvIqFKZqE++ytmEcsC/rl1w=;
        b=CBg3XxY8s9RZxKWBMS9LkoPaqsG7j/7kUAnun1xY+SqvmB9InF82/6nX25DMZHiLuH
         ZZnlWcJvTUzDfC8m3C4tsPzIx0gPR2SUBQB4XBkq/VWbN31fNOHXaBSf9Q8orUg4uSCC
         9DL6h0wVrngUThwq58+AWbJoOnvoP4sV8d2mnXmNCiIf+mUTS86fb5sKYjqfC1wVYIFO
         d6DV3VDFtzm3zcrRARPv8CCEwkZJRTiFqYtN1T1RnF+s7eEQoEYmkfwhG9TBtNeeBwcD
         OJPNaDnt7g3wutoNR8JpQleTQlUZsynjM1Zrfi78HJAEjvVq30x1YVwFoiEUlV3obuYs
         Fkww==
X-Forwarded-Encrypted: i=1; AHgh+RrvV4LVGh/ZSvdTWNAjISZvSPvcdhM/PtsIfJ84TBsanyt7MY115VCa723DnrLECUiNvJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkdCvPEREFCae/Url6ZmMJWDU833amMzZmN+pn6hxxzTwchfWl
	EqbmJ6X2qHCj0947CWw7L+geEukyv4jDei7mbVNS8PQACnj6MGznv3GcaL+WZArTazI=
X-Gm-Gg: AR+sD11V0mtE09HsuJD5v6zrtN4YfhFxQcJcwTNM0xOSmKrjbDFgTxXpBN3g6EY0tgY
	WR58f8SxU6S60n1W92LNPOM1SFRjqPoFcKeS2pYpvoDT80+2kKrkPqyErPgRHq49mcto+8zE9+7
	FpCr+keh9Qh85euVNlWRC04oTR5FaYupY5v6DClxOKj9zyONncQLQ7jnUKeKlKWwLsCzpnQgx7u
	Rtk+l6HGkwLWJ5xBiiA3HRwdz8f3J/0OdP10rWzisRRDM6VeHtdYp7tzq0FFbAz0jxtD/yJSQD3
	YUJ8mmU+KRUpet2l2sNCtJ11BfGh9mjxfTww5HUL9EIKjx3GdVHZj1wC+OcHo1S9TtGuZ8GcwNr
	lBVeLokV+3bZT6yH2ypykJYuOOuOGlin17tJ2PmImIu82KTMzDFqZdxEv8EvCfnJdswLa9QhLR2
	g7o/pQijjwLINFLT8jlvcsc8ZJ7vr/dS4=
X-Received: by 2002:a17:902:d486:b0:2c9:ceb9:865b with SMTP id d9443c01a7336-2cf34878da9mr176347675ad.21.1784592745086;
        Mon, 20 Jul 2026 17:12:25 -0700 (PDT)
Received: from localhost (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf74b60b29sm17937985ad.32.2026.07.20.17.12.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2026 17:12:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 20 Jul 2026 20:12:24 -0400
Message-Id: <DK3TBWQUQA87.1W5VP00KA1C7O@etsalapatis.com>
Subject: Re: [PATCH v2] HID: bpf: Fix signedness bug in hid_bpf_hw_request
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Guangshuo Li" <lgs201920130244@gmail.com>, "Jiri Kosina"
 <jikos@kernel.org>, "Benjamin Tissoires" <bentiss@kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Alexei Starovoitov"
 <ast@kernel.org>, "Johan Hovold" <johan@kernel.org>, "Puranjay Mohan"
 <puranjay@kernel.org>, "Kees Cook" <kees@kernel.org>,
 <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <bpf@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20260713132608.1265541-1-lgs201920130244@gmail.com>
In-Reply-To: <20260713132608.1265541-1-lgs201920130244@gmail.com>

On Mon Jul 13, 2026 at 9:26 AM EDT, Guangshuo Li wrote:
> hid_bpf_hw_request() clamps the return value of hid_hw_raw_request() to
> the size of the caller-supplied buffer before copying data back to the
> BPF buffer.
>
> However, ret is signed while size is unsigned. If hid_hw_raw_request()
> returns a negative error code, the comparison promotes ret to size_t.
> This makes the negative value look like a very large positive value, so
> the error is clamped to size. The following memcpy() then treats the
> failed request as a successful transfer and copies stale data back to
> the caller.
>
> Handle negative return values before comparing ret with size and jump to
> the common cleanup path on error. This preserves negative error codes
> while still preventing oversized successful returns from overflowing
> the caller-supplied buffer.
>
> Fixes: 2b658c1c442e ("HID: bpf: prevent buffer overflow in hid_hw_request=
")
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
> v2:
>   - Handle negative return values before comparing the return length
>     with the unsigned buffer size, as suggested by Emil Tsalapatis.
>   - Use the common cleanup path for negative return values.
>
>  drivers/hid/bpf/hid_bpf_dispatch.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf=
_dispatch.c
> index d0130658091b..520b8f56a514 100644
> --- a/drivers/hid/bpf/hid_bpf_dispatch.c
> +++ b/drivers/hid/bpf/hid_bpf_dispatch.c
> @@ -445,12 +445,14 @@ hid_bpf_hw_request(struct hid_bpf_ctx *ctx, __u8 *b=
uf, size_t buf__sz,
>  					      reqtype,
>  					      (u64)(long)ctx,
>  					      true); /* prevent infinite recursions */
> -
> +	if (ret < 0)
> +		goto done;
>  	if (ret > size)
>  		ret =3D size;
>  	if (ret > 0)
>  		memcpy(buf, dma_data, ret);
> =20
> +done:
>  	kfree(dma_data);
>  	return ret;
>  }

