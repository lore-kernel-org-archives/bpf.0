Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BC41F16B
	for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 05:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789794166; cv=none; b=YDWTKyMM/LUW3EQSaA70H2iDnkH6lIwR1L5yLoQB3PN/E1WkLyHtOcIc94y5mH4tv0TtnzvgEjUuGYNkhtINfN4OA9hBCPWAmux0YrIPoA88d28/9bX9DCXnoA7EMGcRh4bS47Nn5L/oGMpofj/v/xke4jeIXhjrfsb1PXTNnt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789794166; c=relaxed/simple;
	bh=1sENM9QEgWEI/W1aviqR5sRKG/7frXHUFGihPN6qk1E=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:In-Reply-To:
	 References:MIME-Version; b=NZ1yz3AmTDm4YiSGA88pwSsbKWEv5Ng+cMZnvdRCrS8u/K0juqUSyD6kMkjRZrznncY7E1yCBMzqIqETKF6u7bWDqOuBkbY7Lsl8964emzzbEkXQRLrR28Jl5LuOhXquRdshpDdchzqN4LlZfgqnU2XRSAL7KlrUqdMy83xZL9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jDZOh1U5; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jDZOh1U5"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2db1ca069c8so14278795ad.3
        for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 22:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789794165; x=1790398965; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gvEXQ3WHOqHFHlBb7c3qbklVuKDGkOVju2kotJywXt0=;
        b=jDZOh1U566X6ohBf6jGX86jemKz8ru67Ab4mc3LjcM7r4Hy1D5JqXQJwpvqcIMRk9l
         ESbTc68BlcyUwVQpG2qGn0XT9MSpun016+FPP9UnMjpb6bjQmz581gF2mOCFxR5AYlof
         X9V2swI1NMywt7AzKHknEscALx8RT8NuqyaHiadoCuKkbYKoXTyLLcJEGklQBErjv2Bo
         w1b50ZMyHqLVX5UnqpJbDjejheT13Uwoi1REuUlFNpI+UivI/ZhBGdic+YJRsrty45Ju
         52NbP7OpQ4RyoLdT3FwKew0T4EgqiKPNIMZLtwNWUADlw/7oByoxwf7qIKpp2KaNCSxz
         X7dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789794165; x=1790398965;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gvEXQ3WHOqHFHlBb7c3qbklVuKDGkOVju2kotJywXt0=;
        b=lAAVsf8wR3jJpkjNRs/Wmw9BL34BRXTNDudX8lNVLLr6uar3MjQ4qkZSCxkSS9jT04
         n0/li/j7RA/qSjBfvxeCRuzolL8wpIQ1E8mYKZJ7eofJl/C+9zBzBBoSf3Z4O2GEn1ov
         i+3K+SFX4CZHjjww1Vwm8GjX3cnkygMom+BMkVPChMz5v97LJSzFxeZI32qvAzcciDa+
         hTqPOOM4nsu/OVE7Fn8skdEM4A+w1KA3pr3aIVHATKpnLlZV5pfJ5a1LqKakXFkH7X7K
         QJ5GD3rbgIPMd7fPcXy6g5bl1kl29y+yqy4xJY7ypN00CRWnDzjb9a8vXlQbyAGxhaVD
         StDw==
X-Forwarded-Encrypted: i=1; AKwUvBwkim8lFBkxt6eCNLI8A6T8Ilc6JXPOhYjefxtvkBfxIqQMNITH5zm6no6qDL2/P7yaDy8=@vger.kernel.org
X-Gm-Message-State: AFuF++k/5JywAbjnaMcgoJTO9rBMqzy72uwDdln6C25/49PO+zfAbgLg
	3NFS5B3/R3+SlmmtG/ukZsrSRT4EH0hU3wANPN5xre5lWU4ZI9WpxNda
X-Gm-Gg: AYBFou2bdCDnxDD4gQsOFGBBNFY/Ie6UBOx3Z99W5CR1PTA7kE1P9tiBZdfIo5IZPDc
	Rq0Rhbxt0X+VZ/lx9/mqQMOoFoUJi0XAieQLQFJckTVy33Nd1AcPb03HRjRPwn+Rvh7KcFvG/ll
	5bloC5/WNXwOEu6pLojVb6dYDPGygSioF2AlGs9TX2gr1RELHVg2nAfyTbw7GuznpgIk0dOFbmB
	wUQc+ezbtSSWAK2KOwoV0ptYWPPHR6uc+h4qVxfZbFULM0OOkU6uryevUt4iT3qW4wAfykKUQ1G
	FZzpegBaIhk4Xi84EUYpshox8x7zVyJL7FZhCMUqOxZhF6VmslnN0A51PQig0u/HPPj3SiKac20
	mlD3BD1VSUNeOoGGlDzNTCCM0MVPl3xQiG+WsKHyzNGObebaKI0u5XqcP+say6kYiI1FT2OzgKu
	YrUpSkDT72OlqQLdgpfUJV1xb6ek6DTMovfFRc2J3mfYqqCyBU1pXfeDTzsjYV3LUn0IN80dIuW
	Ujhe1xPk0knF93IBOMj1z/pLP7Y6LiBr20NvpCvyf1orc430QbYs+BwJCln7Xm/3bgItsqKi+bP
	OBXJ
X-Received: by 2002:a17:903:1a88:b0:2d9:3850:2741 with SMTP id d9443c01a7336-2ddb16d6a6bmr93034015ad.0.1789794164871;
        Fri, 18 Sep 2026 22:02:44 -0700 (PDT)
Received: from localhost ([153.61.198.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc18031c5sm5083795ad.77.2026.09.18.22.02.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2026 22:02:44 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 19 Sep 2026 05:02:43 +0000
Message-Id: <DLJ12W1FWIT3.3GC1GC68Q1ANU@gmail.com>
To: "Yonghong Song" <yonghong.song@linux.dev>, <bpf@vger.kernel.org>
Cc: "Andrii Nakryiko" <andrii@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Eduard Zingerman" <eddyz87@gmail.com>,
 <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 11/20] bpf, x86: Dispatch exception cleanup
 pads at run time
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
In-Reply-To: <20260917055742.3932170-1-yonghong.song@linux.dev>
References: <20260917055645.3926444-1-yonghong.song@linux.dev> <20260917055742.3932170-1-yonghong.song@linux.dev>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, Sep 16, 2026 at 10:57 PM Yonghong Song <yonghong.song@linux.dev> wrote:
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index d4a980140b48..9d0dd54773e8 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c

[...]

> +			if (bpf_is_unwind_resume_kfunc(insn)) {
> +				emit_return(&prog, image + addrs[i - 1] + (prog - temp));
> +				break;
> +			}
> +
>  			func = (u8 *) __bpf_call_base + imm32;

bpf_is_unwind_resume_kfunc() matches imm == btf_id && off == 0, but by
now bpf_fixup_kfunc_call() has rewritten every other kfunc's imm to an
offset from __bpf_call_base. A vmlinux kfunc that happens to sit
btf_id bytes after __bpf_call_base gets JITed as a bare ret in the
middle of a normal prog. Looks incorrect.
