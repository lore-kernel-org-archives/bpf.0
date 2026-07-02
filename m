Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFCB352C3F
	for <bpf@vger.kernel.org>; Thu,  2 Jul 2026 20:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783025587; cv=none; b=u8fDVSe2Wdaab6W+eZZXF/fjhh5gAw5jTKnqcBYPuc9EDMEpidHUZeK6lh30nAmzfjjYgJIS/7SCA9LFNx9Z4J6lUUco2frY/aGQccnIdOGfy0OibD3LJ6IabPTHeFtEnScsO9kyaQU7ZT1tDtubZnKrZXuQeGwk9MxONqSoVvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783025587; c=relaxed/simple;
	bh=90X6nwoMcrMyfEKMt542bHgq7hQLvNHeiApFXnkbcls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VFT6s/vYGGm2ywPHyB+Dz1V8yJ8MEPn2Bai92DWeZSEoEnYMh63WBZ5MQlNtMMHdvlqxKqhpaVtGn8FUYNy2e3AuIkBf/1vA+oGF3LnRqrwC2vqkYiOs5cA8gBtcxYqrFEOGIJOZL7EPF5WQCkwM+rxekTr/pJleWkdEJ9SZsIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ej8i8WDa; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ej8i8WDa"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-69dead44101so1537479eaf.3
        for <bpf@vger.kernel.org>; Thu, 02 Jul 2026 13:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783025584; x=1783630384; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OUUT9U/zE34DOVJLI19IRKYtBuKLwinorFscWJ3YAUg=;
        b=Ej8i8WDaiCF8QhuUucg46HRkTgyDFK4XLMMhz07Cm/BDxjqAARpU6kiy4uYGFbePiy
         13fccyYoGUCd8x8B9Wqt/mGFU2Uct7Ziqb3LYsMULCp43t7x9DBk6l8ywKglfw+X5iAh
         ExNFilcHLxiL08I/TXkUyOywfdcsFTKNtzznRLZL7CszwsLf+4mAvZ8yo+hIEEWgQ+n4
         Mj6FbJLqmvsGSR9GDc6klI92qQ45FlTuqUCt3qASMNr6q/W0R78sjlwPa33JYX+LGeT1
         4SEQRqO8RC9oxDFqol6XErRaaNvPaiys0p1oxmpG3C/LlAN1jFrevh38PtuXnK9+S+ay
         a0VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783025584; x=1783630384;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OUUT9U/zE34DOVJLI19IRKYtBuKLwinorFscWJ3YAUg=;
        b=tIW+jXj+rpdoAAIekrYdeeAuFN3RYjECfTnmL61J1/4lGJkfITOKtJy5YLiHiEtm1J
         3tsnidS7S34PAFswt12m5t46EIDrUC70ldongWTfgWuWI3eNdZifM4GAkoG40IYxYnWx
         OaHuo+rw14ksfUJg53bfzzegs8ebDQeAqO29NvuCgTorj4f2VRcAY80GqoJEnoPHq10m
         rUCM+zVPSaoNlikzlwV42ABxykjyGGDQzGdV2g/sBZOXc4gTk63KKNoyT6sGDZWV+wn6
         k8x7jsCsCQ2qgzMki3dA3BhLGhALyOss6ulsyYhs3QD510QpYKeixilvMoT/yJWLIagZ
         htnQ==
X-Forwarded-Encrypted: i=1; AFNElJ+fOQ0zoKNegMqwEYjVp/CXZdAEnun7FRbYLYrBqVRfZ0nT7GdKh3I3a6AEqfTEuHexKOM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj1PwUcdXB5DEtsprwcp94J9kw4dW2t9tgEbTwQ30M5N85xGM7
	DhA42mdwkZxs7DKtmbB/AsTpiFCbLjIOGXDtMcz5NUUJMy72DER1ktAA
X-Gm-Gg: AfdE7cm7nCiO/ll9TqC6uFue01+zf47WmH7m5ASOHOrd4EFsC3sGJSHS/+GdQEKr+Nq
	+Rw6E323DiNhaU8oGj17rzWxefu9pWure+7RfnRxxNuFFhhOCVzRR08V+kle77VXuDtLUFT/y6d
	HOOcKJJj49YhyrtncSDKD0uflkyOO4Js2qrFu8mNIo02Y9do9B15v3pmp2y5uWuJIaEWYfNsSAB
	ULZSngVhQz62wVh1LvNxNJ2lOy0DQY4BPxZA4LEZxRH7D2XseqYETOXXE/6lGjdhZgtFPJnkGuO
	mOJJ/Ch8gE8cZQXkOkY7RrnZx+w+UUeOLrKonhWNL6NafB8SieBsgapV54wb//NOrPjTEAvnlEA
	fQv5v2VCL2iCetOY6tp2N4lX/0k4ed98U6UHX+euKrti5kA+bS/B/Dzk3ClVI9Qn/JVDFh4dio7
	fDlOcJS1C27FXW6NGBKDi8B4YZCL/US30n
X-Received: by 2002:a05:6820:1512:b0:6a1:50eb:2110 with SMTP id 006d021491bc7-6a309b831e1mr4672517eaf.69.1783025584368;
        Thu, 02 Jul 2026 13:53:04 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:8::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7eb54534789sm3393061a34.26.2026.07.02.13.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 13:53:03 -0700 (PDT)
Date: Thu, 2 Jul 2026 13:53:00 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: "T.J. Mercier" <tjmercier@google.com>
Cc: kraxel@redhat.com, vivek.kasireddy@intel.com, kuba@kernel.org,
	Shuah Khan <shuah@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2] selftests: Open /dev/udmabuf O_RDONLY
Message-ID: <akbPrI67h5btdI44@devvm29614.prn0.facebook.com>
References: <20260701192210.2997769-1-tjmercier@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701192210.2997769-1-tjmercier@google.com>

On Wed, Jul 01, 2026 at 12:22:08PM -0700, T.J. Mercier wrote:
> Write permissions on the /dev/udmabuf device file are not required to
> issue ioctls and allocate udmabufs. Applications should be opening this
> file as O_RDONLY. The BPF dmabuf_iter selftest already does this. [1]
> 
> Users are pointing to these selftests as examples of how use udmabuf,
> and encountering permission errors on systems where write permissions
> are not available on /dev/udmabuf. Apply the principle of least
> privilege to selftests which use udmabuf by removing the write access
> mode from drivers/dma-buf/udmabuf.c and drivers/net/hw/ncdevmem.c.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/bpf/prog_tests/dmabuf_iter.c?h=v7.1#n49
> 
> Signed-off-by: T.J. Mercier <tjmercier@google.com>
> ---
>  tools/testing/selftests/drivers/dma-buf/udmabuf.c | 2 +-
>  tools/testing/selftests/drivers/net/hw/ncdevmem.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/drivers/dma-buf/udmabuf.c b/tools/testing/selftests/drivers/dma-buf/udmabuf.c
> index d78aec662586..ced0b95c876c 100644
> --- a/tools/testing/selftests/drivers/dma-buf/udmabuf.c
> +++ b/tools/testing/selftests/drivers/dma-buf/udmabuf.c
> @@ -140,7 +140,7 @@ int main(int argc, char *argv[])
>  	ksft_print_header();
>  	ksft_set_plan(7);
>  
> -	devfd = open("/dev/udmabuf", O_RDWR);
> +	devfd = open("/dev/udmabuf", O_RDONLY);
>  	if (devfd < 0) {
>  		ksft_print_msg(
>  			"%s: [skip,no-udmabuf: Unable to access DMA buffer device file]\n",
> diff --git a/tools/testing/selftests/drivers/net/hw/ncdevmem.c b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
> index e098d6534c3c..8114a29692fd 100644
> --- a/tools/testing/selftests/drivers/net/hw/ncdevmem.c
> +++ b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
> @@ -149,7 +149,7 @@ static struct memory_buffer *udmabuf_alloc(size_t size)
>  
>  	ctx->size = size;
>  
> -	ctx->devfd = open("/dev/udmabuf", O_RDWR);
> +	ctx->devfd = open("/dev/udmabuf", O_RDONLY);
>  	if (ctx->devfd < 0) {
>  		pr_err("[skip,no-udmabuf: Unable to access DMA buffer device file]");
>  		goto err_free_ctx;
> 
> base-commit: fbb7ad31ab376c5101b2ac7205fad0344fd2de60
> -- 
> 2.55.0.rc0.799.gd6f94ed593-goog
> 

Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
