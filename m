Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2F237F012
	for <bpf@vger.kernel.org>; Sun, 16 Aug 2026 06:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786862166; cv=none; b=IJoEfBC7xYhhqR7ZudYuBXp3SKrbYNFtTXMaMSMDJx3EJVFVhNMVREOFk22/P+IFt3fceUJzQAKC/V3vrYnNToXioa/Ea6x0cX2WdYrdeIU3ibzNlvHhIda9iGqGR3chIxFeUHSjfQkE9xFoccEypknDsr9HaBsM54TKJy6HcvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786862166; c=relaxed/simple;
	bh=IZc2RFb2o9lZx6oLfog9CpKKGSIFJArYZO/tHSeUxyA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NmujI1fglXjKUddiz7Kn+US3rAuSj2GtxD2tq2BAQBhNZB41TiQhlLuHdnuxqoS5nlYKr7HWPsDq09y1AYLZkeCs9pYRsBESt/Ov+hEDtli4axwuq4nOYk2dGUmmPYtOT6SRsnr9YUoD4qTkH3+1X1FmQnDNROSrWr35iCM6OPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I2gR76IC; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2gR76IC"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-84e507b079dso1459370b3a.0
        for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 23:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786862165; x=1787466965; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=IZc2RFb2o9lZx6oLfog9CpKKGSIFJArYZO/tHSeUxyA=;
        b=I2gR76IC3QBeiAZbb6V5/g2QuHxk3Pb7dFBb12WqUXHx6Hki14Wb9lEOmKYrIERZ8U
         PIeEE9WIdLQBHp6lWlOaneXbfTGbu0eDfZUcxq9M9ZWYV4T7eYtcxD5OgaFQ8QtmW9YK
         FM4gOmh9KmX90IkUMR4FIIhPWJDTMq7mxPF5LQQcKk32HB6I+/l2O6tgZgLU6zU3SJtJ
         +QLcPDDq8a5SkAhS4sMeqvcti94QjoCM1N5sWfr5I6VRiy8UW1BlxrsAhI8WcuYxKkNk
         +3fBRG0uZq4xn5ajzMUbuA0FCePqbNtoORoCm/hmMB1qpVVDEmKAvOhSMSAf28meET1+
         jaRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786862165; x=1787466965;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IZc2RFb2o9lZx6oLfog9CpKKGSIFJArYZO/tHSeUxyA=;
        b=YyXma9tuLjDo7FMeVA+Wyk4yGkBxGvv0kTB7RHYN982b/nQG7xfk9hPjLxjixvMyei
         RfW8snH2rRi1YLwqObV7g6LLM05cAByMSaSfrua/+TTn6tfNLVEom4FtgZDCZwg4Rm9m
         v3H11NmwDj/D562qk00tuLZMX7JwjDkcdr/puqT9t70U0H9NbcykHuN0uQ9UDmf5R8j0
         7UXSx7GgftyTpiLZ9ch0ckOmLFOAVoqXV5HMnVLpIt5RGy9WaoGL1m9X12hBRQ2PHhQR
         9l5V8BnDEt4JPEjMvNW8suYEAP7BheqzUAAdS0DjNHNuLoG27xU94JcrhEOkhtJI/Ern
         MR7w==
X-Forwarded-Encrypted: i=1; AHgh+RoX01ZIuRBnAmsDkbONEhtMynUZhSdanJKyjTSIJyLZ1X3ykiPdLcCYZlR9qA8Phyz7dDE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhxe+Htp5nZzwsVavc4UsQvcBqFiqWGHNZz5CSSg9qrMqzq4dX
	EI1o4pXR9k4wl72TONhsbsg5DHPpc2wIb7dUaAXSnPUv+cigOpdgwGkn
X-Gm-Gg: AR+sD13UY7XXQINRQLGRJ2UyrgB0FvHDevqC7KLt7d5gez8Omt3Rk24l+LZjRSACT5v
	pFEQIlKgNjt7UlVgn7IcmUy6uvaVguZrB4Igii/nQUZDUaBxXA/jarovGklHcx9mov9YPH2fe/u
	jl7dtI68yEufSUaeBhgoiXSx6KVOgPOhXk+4Yvj3RLZ081BGxTePDrbZGMBUnWXehv+nfmTlZL5
	HXNWsk6i1r3aQfhpKXRQZgpMJq/Kx82AkeNCrVZSNX8x7fMl0y1ecIKRG/FAX6TU5Q9yq1kKoSG
	1kR78H5erwQ2TASrWyiInibFyWQaG7GAlwJQYC2GMkX1kbQOQrQ0dP5QX/GiDZ+x3l9yZy/J6BW
	/n3g8ukmXXolKHIxX9mhJefW3DYNgMDayeD0RUqFpkl+rRiOUx6ksp8G4JCUdtIoWCtnn/I5Qdg
	dUNkB5SWgxRQcBIv0yi3Cdt2kmJMc00ZfmzshUxndD/U8wDKLRSVsxcM+5CjEJ4qn3bMpTJzY+n
	2mvfFQKDJxhCTd6
X-Received: by 2002:a05:6a00:8086:b0:848:7731:d95a with SMTP id d2e1a72fcca58-84fde47a4c8mr18583764b3a.37.1786862164915;
        Sat, 15 Aug 2026 23:36:04 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8517d01f2f5sm1711433b3a.22.2026.08.15.23.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 23:36:04 -0700 (PDT)
Message-ID: <8b473da1bf04294626e74e8e0cd94e3b70f14df3.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 03/14] bpf: Preserve R0 lineage across
 helper calls
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Sashiko <sashiko-bot@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Emil Tsalapatis <emil@etsalapatis.com>, 
	kkd@meta.com, kernel-team@meta.com
Date: Sat, 15 Aug 2026 23:36:01 -0700
In-Reply-To: <20260816015746.2632990-4-memxor@gmail.com>
References: <20260816015746.2632990-1-memxor@gmail.com>
	 <20260816015746.2632990-4-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2026-08-16 at 03:57 +0200, Kumar Kartikeya Dwivedi wrote:
> check_helper_call() clears all caller-saved registers before taking the
> diagnostic snapshot of R0. This records NOT_INIT as the old state for eve=
ry
> helper return and loses the lineage of the value held in R0 before the ca=
ll.
> bpf_diag_record_caller_saved() deliberately skips R0 because the paired
> modification scope is responsible for it.
>=20
> Open the R0 modification scope before clearing caller-saved registers,
> matching the kfunc, ld_abs, and subprogram call paths.
>=20
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://lore.kernel.org/bpf/20260815073833.A93A91F000E9@smtp.kernel=
.org/
> Link: https://lore.kernel.org/bpf/48e6f021b89562f68850fe21ef8c78719819b04=
cf9c4e4f50bc791937d37ace8@mail.kernel.org/
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
