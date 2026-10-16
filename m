Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8F0BA3D
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 01:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792115588; cv=none; b=TgbacxCzcVclkcxtVlAnAYJ71060+HCBQdVhUr7MXr2OBg/JdLX5YQ8cETWLXNYEXH2X1mR736+fGhX2jriGoecyKE0Am0t/wGegXVaMEJW66U5fgz2MM/wjrElPN5WK2jKGd7XNLT6d0SsGolLgqclogY8iEl2mUEKVOg5rXUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792115588; c=relaxed/simple;
	bh=9P6WM2sDuaoIyCk+md/JRPgm2JMfqLS65h7b3n50Q84=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=ZmINqXG17PmsWvSE75X5xmH5SwCbZDGU/M4jse30wTfrPjmFBnsNDxGhyH2BwgghAzsNKGiKQttFjn4H7WWXsC8BDV8FYQU0TrBXrgbAV5U5P7QqGqn1iZcm6EfsBRyIhDn8qBNqPJ73JwQvBiy0HK0DXfXk9s4PNxhhTNbQzTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SoK6x3zZ; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SoK6x3zZ"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cc147d86bebso368949a12.0
        for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 18:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792115587; x=1792720387; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=J3Qt8nSo5/myXfVfyBQVyDJYsxumHoyTi65hN8400xU=;
        b=SoK6x3zZoaRKYj4pabmrDvnt/1MzMrpAvqqBvdphQbUYZZRBjRQvkBjgdqvrjHGIec
         bqYECyZbAwQ1Hclr3Yfx6msL5+tTue9GWA68bM0FA8pib7YAFSiWqonpCoSvwWpQHbyw
         5oVYeuZwPAO9vgmnbiRIZbbuOgGm8OuFnKE2XWnctWclNIrfbGpOjFIxVVooffDPMwos
         ER9HOeoVgEuV6SV01d1VRY6yPXgiRCvvbVAJ1pGEbbm9NALJTAbh83nUA1ADN7klBh90
         Aa7x+YyVqW62Fm0V+0vppe/rNe2SCiNPOsOZxkmMU2MpPrG8ngOIzjFpT7mjGlVcltvr
         Ow+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792115587; x=1792720387;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J3Qt8nSo5/myXfVfyBQVyDJYsxumHoyTi65hN8400xU=;
        b=T9EYOK0bU3+fHjQSxD2GMxYRVd7Za0e7l7Vo0vPUZWyzb8gYaOZQC0vg1qAAf2/N0o
         PkfvbLVf8fRj36KBDGpIHMyWLM+6fpKziVO1Ucp/0/QDDAP26Gds1o1D25Y35entY46K
         myC94o4RUvwlSpe3O3I86JCuU9YjQ+enWB2GQoOlcy3Rzd0uzxLF0bY4WM9odabU9hMF
         6daU+WmblTKj0fiD/BqAursqwEmJE9pJ6/olC/c0TGztn8g+zq9Yoky/Xkth8vXuQYb+
         l2xff7olKwanuZI2gg+QHkRBrPXbmMISKKMxV+vvSYFUEbNs9A7deFL23uGM15tbdwk5
         dr4w==
X-Gm-Message-State: AFq9FYKL12p8B7EdntHU1rErXUoFYaKabfPQjEHuyhtqKNZyjszO3pSG
	Fr8YEULh47EzHMuL4opykWx3f17zYK5ugIoaavTkGUOFKutNdZgwzzgP
X-Gm-Gg: AYBFou2484UhZkCvahnwLVOkUp4lhkmEanqGR//TKjN7HPZ6SNIqHg1foK162+pxb/L
	wDypAo0j6fdcx2GTJwUKkseou23dvT4xjq7GQac0A3xzo0fqTr54Oo4AVCp9eJ7zVr3exA59up1
	jxn3yVgNxDH/CHTncgHcOHB1Vo1Z6rtGJFGGs98GDqosMMlI6aAcMRCetLUFuGpWXmTXOTQmqXn
	viGkc36X+n7aq2wrO6Jk4U2eCqi+TAfAZ48xVCw5fElpYEmSh3IWBiBaMZ9nF6eifKDDOUviNiC
	O1m9bf6Ua41GbggunBd/YacpiVVTdDAa21B5MmUx5GdAIDJ6lnfCFZG0fKAYc7yybXHFD02aa7q
	d5Gp0oRyihxvbmOo4Dip5buCzoFIJsB1NPWhU5c39C35GiwLQy/4cUx8yFHBmFBRs3y4aHJvefF
	tfWl0M9FZag1sz6l4SDGU9M9GpTP4hraQ8oL0cqcCK8d5pGjmcbecgiwnsw01gGNolAMRnGau8Q
	iTFvJ0HJemKPt2Zh+lqPMJ6SxytWssyMCdgYEobGD9lx1xQSnxDLTbB+1e4fPxntFDVSrRYMxi5
	GWpo8SY6WqP4fQ==
X-Received: by 2002:a05:6a21:6f89:b0:3e0:c961:b5ad with SMTP id adf61e73a8af0-3e201ba4c2dmr1157134637.8.1792115586615;
        Thu, 15 Oct 2026 18:53:06 -0700 (PDT)
Received: from localhost ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89f57269315sm333168b3a.23.2026.10.15.18.53.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 18:53:05 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 Oct 2026 01:53:04 +0000
Message-Id: <DM5VYE2LA9E2.28YJ11VXX558P@gmail.com>
Cc: <bpf@vger.kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Emil Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "Tejun Heo" <tj@kernel.org>, <kkd@meta.com>,
 <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v3 06/15] bpf: Recognize __nullable on pointer
 members of kernel structs
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
In-Reply-To: <CAP01T77q9Q-kj1gjsm1U2Nd7QaqjjSrNhF232-dt7cehrWw+uw@mail.gmail.com>
References: <20261015234125.3152346-1-memxor@gmail.com> <20261015234125.3152346-7-memxor@gmail.com> <DM5V1EIGVJEG.1IIPS4R40HPA0@gmail.com> <CAP01T743a5wuvP=5cc8Aqb=PHGhSFWcir0sCSWMvMT_=gk8Kjw@mail.gmail.com> <DM5VHTPNK75L.25IC5ASG1QDJ9@gmail.com> <CAP01T77q9Q-kj1gjsm1U2Nd7QaqjjSrNhF232-dt7cehrWw+uw@mail.gmail.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, Oct 16, 2026 at 03:39 AM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>> > Well, BTF_TYPE_SAFE_*_OR_NULL also enforces a NULL check, so not clear
>> > to me how using the annotation over that will break a program (see
>> > type_is_trusted_or_null() usage). The only difference is that this
>> > annotation works with type tags applied directly on the struct.
>>
>> Got it.
>> Can we start moving into this direction?
>> At least for clang compiled kernels we can drop BTF_TYPE_SAFE_*_OR_NULL ?
>
> Yeah, makes sense, I will send a set doing the conversion.

There is one more difference to sort out first.
type_is_trusted_or_null() and type_is_rcu_or_null() are called only
when the parent is trusted or rcu.
fentry/fexit args are plain PTR_TO_BTF_ID, so with __nullable on
socket->sk

  SEC("fentry/smc_release")
  int BPF_PROG(bpf_smc_release, struct socket *sock)
  {
	if (sock->sk->__sk_common.skc_state == BPF_SMC_LISTEN)

in progs/bpf_smc.c will be rejected with
invalid mem access 'ptr_or_null_'.
what should we do?

