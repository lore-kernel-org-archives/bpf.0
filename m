Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AEC3CB919
	for <bpf@vger.kernel.org>; Wed, 17 Jun 2026 11:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781695219; cv=none; b=SfmJe86P8BAzUqo81PLMUqoiDDsp5/KmAIi5pQjlnCHxnRNVPHG+V2MQZdVZbX+oRERpXLVS6gMrTrZFhh3o1ih8Zk2+W7al2qRj7H8jSwTK1FU/xMLgjHXSTJ+BXCLMktMSp/4TR1SiCGwQIwylZqp9bp17dGpkCaaRXQBkLxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781695219; c=relaxed/simple;
	bh=CN3hTnHGTzcazerSqLwxWW1GpSBEGf3IG1NQptlmTJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BzR56MMl03lb+20V6S4VawYs7pSxJb3NUDC4lV27R581oBv3kEsT7jknODAoi1pTVX6n6ckgjMUv6UTdyrYxolfRnm+F7hUA/A255tQjtm5qQS4SXCggIT4fNIU9YuRFLh7gkldmCsx3X/wsaludSjYDzXJVLr5l3TZDS5ctkeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ecEorMHW; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ecEorMHW"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3996f80800bso4239061fa.1
        for <bpf@vger.kernel.org>; Wed, 17 Jun 2026 04:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781695214; x=1782300014; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fEPBS2XQIGG150Y2esIPhsZu4HIK10nFbPjkifBbsWY=;
        b=ecEorMHWxYRrFshldT4/9/HxINnrxEwiWHKpjj6NiVHDowYEgdGiP/kEd7VTQZF28F
         ySgjjBkQYPSPB2u6Hy+r+6kvnJqRsouiSykcEf6loKSJAPbLZCufdjF+GMEtO48Oy+8M
         2G3N0maccsgvVmClYCSGeoNm1f+HeAEfVP9Fr3Ewm6l6g5KrV/fpz2Ix/Mxv+cnE23EM
         CFLz84P3IhH4iJjQDYvOb2l9LtKxU0u4tyzbgaWWJ9v8uvEuCsTIeSb6INi1R7NM7+GK
         GJUN404Z7BvolbDAm33V4jvoi/zdw/V0YQoMkIV1kOAps7YMrE40RRpOAc9hadzs5m8F
         rtCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781695214; x=1782300014;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fEPBS2XQIGG150Y2esIPhsZu4HIK10nFbPjkifBbsWY=;
        b=cD5pcqYEPKJ/+hMjTsKTHRGs5tNkpVs5XswJHoiEWYqVDmCyA3+w0PPUNbfZE4ksNg
         RIVFmof3kNHcAVTlZ5wCdBCZ0l7xV1Te2B25sRIfg6oIJrHICYYqAfsNvNgbZtWBG1OU
         iFg+d/7zus3csMMrij3q9rK+5kZcTozKCxAs5w2od5+kwb8sdYeaVSxakz7lqnQ9II46
         SgHaZqi0IFx/rhBT8TMqCbVAnUditLIVNGRudFm+CKm36PD4FmSeXiG1R5YA92KItYnS
         IOQyIIg+iUIj/6Zmk5hnfrCWmq+6QjMScHwIdMYmAAlWCwuB8+EtP0shAvBMcOmF+hrc
         DLCg==
X-Gm-Message-State: AOJu0YyQ7UINAEVVQ0BbndLxk32AGQAmRzSS5MLDFWh8x25xPfJOXYFV
	QuSKS7BEJcTWy0fo62U0pRnToPT6NaDeJ7W2B6eDHEiptfXIpBdY9nuR
X-Gm-Gg: AfdE7clVxvGPDB3HzbiZDtozhAn996ViWMstb6QYwETHXvWIrAC+pnljTvbNk7AovhQ
	wEufRgRCzxDjDbGsqo2k3B7lC+g3g4KWLWuEbtHv1I5fIzWhFO5hoAqg+JUPZeHjY+nh6TU+f7L
	wAlcyWVT8ev9SwhjBSehIQV6scyyj8gVXgxHE9+5igwr9fGBS9AhtRE6Y7DGUtqi+ehrfFAxNYy
	rNhICB2h0YSaK/J0vha7U9kA3I+MS0A7tKSLGK3hX1BwaU5f+rDkO7C+/0XRLBtR8dwO6lE9Kcc
	GMacHZQR7XRiIL/Lub66zETP6pgwpXdertQ9WzvDC8c5qDImZUIB/lsJo+BndgwON9WNlA8FwHA
	qXsAIJ7JYL6i4w++KSy6hRTTBReXBZcePISQQzdAIdNE8cvkWkBDN0nv12swMmz3/8VgTumnWon
	pKPaJ73CX4XLrcPyOazPnohe1jmv/kMuCLiBADHUgN5Ky/324vJXC7B2VeCHwH6dQekqOdJ3Hvp
	RaItC5N02GTEhZAr+WgL6E/ngVr01CEpqqaF1SGfQrPutUzlw==
X-Received: by 2002:a2e:a594:0:b0:38a:5bf2:80d6 with SMTP id 38308e7fff4ca-3996a013db5mr9545231fa.5.1781695214065;
        Wed, 17 Jun 2026 04:20:14 -0700 (PDT)
Received: from ?IPV6:2001:14ba:6e:3100:ab3:3fa0:bafe:f56b? (2001-14ba-6e-3100-ab3-3fa0-bafe-f56b.rev.dnainternet.fi. [2001:14ba:6e:3100:ab3:3fa0:bafe:f56b])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3995c191cd8sm14748111fa.20.2026.06.17.04.20.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 04:20:13 -0700 (PDT)
Message-ID: <09f69783-3eca-4318-b09b-78e6730e899c@gmail.com>
Date: Wed, 17 Jun 2026 14:20:12 +0300
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] KVM: VMX: guard regparm(0) on
 vmread_error_trampoline for x86_32 only
To: Clark Williams <clrkwllms@kernel.org>, stable@vger.kernel.org
Cc: bpf@vger.kernel.org, x86@ekrnel.org, kvm@vger.kernel.org
References: <20260617011303.3969027-1-clrkwllms@kernel.org>
 <20260617011303.3969027-3-clrkwllms@kernel.org>
Content-Language: en-US
From: =?UTF-8?B?SGFubmUtTG90dGEgTcOkZW5ww6TDpA==?= <hannelotta@gmail.com>
In-Reply-To: <20260617011303.3969027-3-clrkwllms@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/17/26 4:13 AM, Clark Williams wrote:
> [ Upstream commit 0b5e7a16a0a79a3742f0df9e45bca46f01b40e6a ]
> 
> regparm(0) overrides the kernel's -mregparm=3 convention on x86-32 so
> that vmread_error_trampoline receives its arguments on the stack, matching
> the inline asm callers that push args before the call.  On x86-64 the
> attribute is a no-op and newer GCC now emits -Wattributes for it, which
> becomes a build error under -Werror.  Guard it with CONFIG_X86_32.
> 
> [ clrkwllms: the upstream commit redesigns the trampoline declaration as
>    an opaque symbol; this simpler approach guards the regparm(0) attribute
>    with CONFIG_X86_32 since the attribute is only meaningful on x86-32. ]
> 
> Assisted-by: Claude:claude-sonnet-4.6
> Signed-off-by: Clark Williams <clrkwllms@kernel.org>
> ---
>   arch/x86/kvm/vmx/vmx_ops.h | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/vmx_ops.h b/arch/x86/kvm/vmx/vmx_ops.h
> index 5edab28dfb2e..50328be40b2b 100644
> --- a/arch/x86/kvm/vmx/vmx_ops.h
> +++ b/arch/x86/kvm/vmx/vmx_ops.h
> @@ -11,8 +11,11 @@
>   #include "../x86.h"
>   
>   void vmread_error(unsigned long field, bool fault);
> -__attribute__((regparm(0))) void vmread_error_trampoline(unsigned long field,
> -							 bool fault);
> +/* regparm(0) overrides -mregparm=3 so args are stack-passed, matching asm callers */
> +#ifdef CONFIG_X86_32
> +__attribute__((regparm(0)))
> +#endif
> +void vmread_error_trampoline(unsigned long field, bool fault);
>   void vmwrite_error(unsigned long field, unsigned long value);
>   void vmclear_error(struct vmcs *vmcs, u64 phys_addr);
>   void vmptrld_error(struct vmcs *vmcs, u64 phys_addr);

Hi,

I've sent a backport patch for this commit, see here:

https://lore.kernel.org/lkml/20260617105100.22094-1-hannelotta@gmail.com/

The commit applies cleanly without any modifications, and compiles 
without errors with gcc-16, and boots.

For commits that apply cleanly, you can simply use:

     git cherry-pick -s -x <commit-id>

And after that

     git commit --amend

to add the required [ Upstream commit <commit-id> ] line.

I wasn't able to see other compilation errors for v6.1.175 using gcc-16. 
I tried with allyesconfig and my local config.

Hope this helps.

Best regards,

Hanne-Lotta Mäenpää
