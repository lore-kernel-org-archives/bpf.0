Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0B343031E
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 15:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783353545; cv=none; b=aOrH0hga9mxCEFjbSyqRGMzqrHI6coyn4E4Rl2JhHqTakxG8rAo+U+AByjj5bIGpCpn1VpwfhNJkkesDMQM07HbFEKD12nAaQOeFMGIuhkhILxm2zQU9IERCyIrwwAjaVZrCMgpAklxVKcUiojELxoPBnZT6XnJS2IOh2SXYFeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783353545; c=relaxed/simple;
	bh=YeGw0QmsYPIjhG9a8P98Xx40MANLGXam7XN2+wLB6X8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=A9eS5FH+cay75b6kH9/5zxqFWBs5McX/+M1sAvfV/9hy7dINv47E9FdDmXqzhzF4iMn2FPCE3//ccnfsE9qvCkDPF8dvLDA36STz86b92TQEkVIw8zdPd7gdyzbSFkB4WFNpjFv299/iWYCnQgh3uac7hg+FEsY1eUlhftC07Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=QIpe7gKG; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="QIpe7gKG"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8471013fac2so3505064b3a.1
        for <bpf@vger.kernel.org>; Mon, 06 Jul 2026 08:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1783353541; x=1783958341; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bfTNHn8nmnL90dO9UUPWhLKbfieV4dy5YrFHzXy4ENA=;
        b=QIpe7gKGNYSDsBU6JE9PlJgvpN6oiuyYPn6XYvxkRWEvVmOK4w+m3bVwbTZDmdHRxZ
         5SbGXHG34HkMJyIiczuiRBlpJY/KFO8/ALhREAzW3/ikWXrTB4bZrecYCZMfF+tJEYtr
         OJEa6BPH6waHmNUpKnOB6tazWINKEsk/JriC1ppYm+mO2CIXtpELosnKhAHm91NG6IPq
         2HoxGVrPHB64G53s/eCYen3YpbJ0xqo8k8tqOGTcazKEKEDfKqNVXbnBBD5q/5aJbXkK
         Eo4aeAEEp1+us0KUnTT816oWpx1Hhg3KQbjg/6Q0RMSTz6LaclQvXGWkUSvBzwE/dNvB
         sGnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783353541; x=1783958341;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bfTNHn8nmnL90dO9UUPWhLKbfieV4dy5YrFHzXy4ENA=;
        b=aPdbcNVVETPepT/up5EyMa/0PUY2h+IhFSNsP5M79CgMYptdNNFVL4jAndseQW0wqK
         7uBv63zEYunB11NVh8YVfMIfNpSSs6C6vBOs+vTUo9CKCzA3FWTyki9PG4w1ey34dEWT
         brnYx+9Fk2Z4pFpQ6NFFgl+YNQ57f02lYwjRmcQ+QdCi8gFQfM7DHaB+6qTmTuqL+CtA
         /+XyItFiXTvK2KCscaWfXgZw14+CO00oF75bkLbYGLQ7gxr5MPJfYuOZ4Dv+dU4rClZK
         S+NaSgMIRrCx7FffnCWX/ITC+ecNYX1UN5QTJE4M0fIsv9Ccs9v+ZFW6PXTPT4RItz6W
         QCPw==
X-Forwarded-Encrypted: i=1; AHgh+RqXcRVSeBiubUL2DPDwl3rcm9J7mRe92afh/e+y7z9wHv7N+MItKFvvR/jQ9fa3+Vxr5XE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKKVPidXbIXRcr2tFupz8X6VLV3b4w++QvkIWv2DB+6FMHkXKg
	Y5l27gf1HNRXsEYa/5rzQrdXXUNfdFWATsI+FQceIsMjhb4DDx7/7rr2w85JAbD4K00=
X-Gm-Gg: AfdE7cnbNyDlh3k9ZiinJGtLCPt4qwBt3I52xKHYt+O29fY94hvrtSm7/63WK64/ZKD
	BpVpUuGDXJhXBm/2vnMOytZiEScTPctI0bgfVKCTVvb13RyTlmHKjXGF3tthXhdWkWLv0+by33A
	Soc/qSiEeheOvqxYnRjYYwm6PoIuLspQW8imZovpZCqKII1gbHzq3rplLciJYmC7vSXTkQxfyuw
	XS+f0Wii91rZUSZ+AkLdexwkfOfmc6PbZEDQ2+fAjojgyvmn71GZWX+8v3S8aeYS3SQy3umwVZx
	z7HJLmwHinClnNUETD7u0ElVl0Oct7VyR4/P1FA/9l7dFxI7QoQAiJ//pPzSMNbbnegA4cT60uj
	ms87vG8Xkqsw0m3l4I5Uf9Mn4rOrg3Gs/kdImke/PiZ2nsfJApx2i+6z+vIOPfbguW20oRsUYoj
	74XCHtJ3wqI1T4CA==
X-Received: by 2002:a05:6a00:f94:b0:842:5b63:6116 with SMTP id d2e1a72fcca58-84826bb3a1dmr1207945b3a.7.1783353541199;
        Mon, 06 Jul 2026 08:59:01 -0700 (PDT)
Received: from localhost ([2605:8d80:5c40:4f71:1131:e194:34df:ee9e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6b9a832sm4069020b3a.18.2026.07.06.08.59.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 08:59:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 Jul 2026 11:58:59 -0400
Message-Id: <DJRM2I1EFNCS.2GMT8JFORLO0T@etsalapatis.com>
Subject: Re: [PATCH] HID: bpf: Fix signedness bug in hid_bpf_hw_request
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Guangshuo Li" <lgs201920130244@gmail.com>, "Jiri Kosina"
 <jikos@kernel.org>, "Benjamin Tissoires" <bentiss@kernel.org>, "Kees Cook"
 <kees@kernel.org>, "Puranjay Mohan" <puranjay@kernel.org>, "Johan Hovold"
 <johan@kernel.org>, <linux-input@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260704160703.156298-1-lgs201920130244@gmail.com>
In-Reply-To: <20260704160703.156298-1-lgs201920130244@gmail.com>

On Sat Jul 4, 2026 at 12:07 PM EDT, Guangshuo Li wrote:
> hid_bpf_hw_request() clamps the return value of hid_hw_raw_request() to
> the size of the caller supplied buffer before copying data back to the
> BPF buffer.
>
> However, ret is signed while size is unsigned. If hid_hw_raw_request()
> returns a negative error code, the comparison promotes ret to size_t.
> This makes the negative value look like a very large positive value, so
> the error is clamped to size. The following memcpy() then treats the
> failed request as a successful transfer and copies stale data back to
> the caller.
>
> Only clamp positive return values. This preserves negative error codes
> while still preventing oversized successful returns from overflowing the
> caller supplied buffer.
>
> Fixes: 2b658c1c442e ("HID: bpf: prevent buffer overflow in hid_hw_request=
")
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/hid/bpf/hid_bpf_dispatch.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf=
_dispatch.c
> index d0130658091b..b13f911e5944 100644
> --- a/drivers/hid/bpf/hid_bpf_dispatch.c
> +++ b/drivers/hid/bpf/hid_bpf_dispatch.c
> @@ -446,7 +446,7 @@ hid_bpf_hw_request(struct hid_bpf_ctx *ctx, __u8 *buf=
, size_t buf__sz,
>  					      (u64)(long)ctx,
>  					      true); /* prevent infinite recursions */
> =20
> -	if (ret > size)
> +	if (ret > 0 && ret > size)
>  		ret =3D size;

I think this is making the code more difficult to write. Why not add a
label right before the cleanup at the end of the function, then
jump to it on error like so:

	if (ret < 0)
		goto done;

	if (ret > size)
		ret =3D size;

	if (ret > 0)
		memcpy(...);

done:
	kfree(dma_data);
	return ret;


>  	if (ret > 0)
>  		memcpy(buf, dma_data, ret);

