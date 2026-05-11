Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4FB43E4B9
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 16:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778517587; cv=none; b=WUrOGCkgiV4s+UEmztde6gSCEodwcniQWG/W1d79Sm006Zo9istiH445BWVnQuRd6ZcUxNi0pwvgE9DPK0haufADhk8xnrb1jrXAKuO04VnqtUACh1TORlWyzS572wUny2jsW11FdUCPwF/x+93Z5LPui1ZKe928cin0YL8th/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778517587; c=relaxed/simple;
	bh=I74pkUGkKTnXWU28hOrOnFhFCscFShUOVNUJwOIUeew=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=VCXF79IXOLeS2RGdy0EgQKCJc8IoBPmkhBFeOgDtNbEVcPW/KwRpFOSiLsFJqocJ9enaVdau4qtG+qwwNtkVduulgL5VZ2/R8Nf3IIJIVkTivXmaPmrClj01ESaHdEqFvTKFEdCw2O9cslAvaqqCkMB7/xaZHf1iF9ie7tkeX6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RzlK6tnx; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RzlK6tnx"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7dbe437b072so2568696a34.2
        for <bpf@vger.kernel.org>; Mon, 11 May 2026 09:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778517585; x=1779122385; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XuCIQ8ghli2tGJzIn6xp8IYFfXlot5IknQfVcooPHIc=;
        b=RzlK6tnx3jl0EulNDWbekg9zKaAn7CCh2Uo1iO8ZKwE59lSFz5NZxE8yCORYIQt1nb
         LpJhSaU3M+WNzciDcqFfXf+37JL0FupOBZc6N8xaG+HMLd0kD2JGmqrJooV+hrqTmqdd
         aE9hybqnggxNRctPuL/0pS1L+iwHa9VA9H27Tu6JJ6mg15JjTnclPFKFiJcGDpn9+Bzl
         k1wOR3npmT2Kf2p9CPKtlimFm3VlCKy97UQarypaXKh1f7Ev0+dDdsfJ+GyHsGeIbdOe
         dCZgD5mfqW5HFF+8zvUS5h1u3JiVFHNwaxf/lCD1KoX0U9tkY7ncH5yyeqwwjpeFVf+l
         AfKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778517585; x=1779122385;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XuCIQ8ghli2tGJzIn6xp8IYFfXlot5IknQfVcooPHIc=;
        b=Dgq6oqT3NhaZPTWh4HA8aUYmsq9xfPRNrY/ohqsJCQp5W5Rd360RFvIxwT4UcJ7on3
         rz2qyozC9lsYo+sLblqLtoHzCUn3xAUGzJdIS9XUnyKsUEgnZAvT3lSkEINKsbEQKZEt
         1KKE5THaRD2z5fnqHwv3L12LgMzwKVuf86eAs8Gwg0rZAM+hRcmtTMQPtR1LqCenqxoE
         vQU0R8sSuP/OU4SQ9WJDaSTzo3nI54Wv3wWc6dQ+5nTltOniCPl4ntZDEJ5NoQlDi1kE
         2bhRQVpZzvVh1d2ZGD0o2n0HQ8wcUOoNOlXATbCrp4oYWuRRudXfw3iee9L7lHSAqoWX
         5QNw==
X-Forwarded-Encrypted: i=1; AFNElJ9ZZbdw37CwUQa7zCKWUFaqvoGDCsaR4POL2UI68yO6THd3DOSgd+XzKDbJi7abgE4tYCM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzumlZn7K8Zh0hKVhppF6vGuT0MnLQhiljobLXPWDQDL7hJXKzD
	fEX2O4IT/pIMf5k4g6xftXnwDsCMNWtZdC95+0RwX+OR/i66R7tvZt79
X-Gm-Gg: Acq92OE1SmF4i/Uvg376Q8xxgqUuqn1LIGc6ayKJBMnwtWiIhl13YnG+Y6fxdcJscTL
	lV+JHShhJGzWny0e79wYp2D28iOxvGxtu4NQQIbg9AfmiqhpKCxLo5pKVmaqBfZYAgz5po4hTwS
	IAMZKS2Ktp7EuHwTiaHSpHCcHDNKs/urYprOei9p0wAN1OHLgBddALTtKO6jQS5V120A/YltG5b
	jwO5S+OvdEhCzyoQZIypBNN2mWkbEGpOXKFR5jT6Iya25v8AaubAT3WSYP7cxW1rc4zEKvpUHbK
	U0KlVoNe4d13TGVR1riYV8rBbtXr4lZ/8Y+nlvUpmOgs4LUQFJCOcw3ipvwFRFpJh8a9aInw1xl
	5FPeHKbNnFwBFEyqhfCPXXtLjvqLBx6XVg/ohrcM+k9Zf3Uu/STXOkQS5hJkUODeO53N1Aadhv6
	3rHiILRwV8BRDGldAdpO8Xl6/txG2ZH0TwTwPnCHU7wTfxDskBB6Rq+xoJm9WFbA0vN35DA15cD
	D6cypTIYVtyMpPUjOjTQs5nIihi
X-Received: by 2002:a05:6830:f81:b0:7d7:fcac:6374 with SMTP id 46e09a7af769-7e1dee817a4mr12681894a34.8.1778517584987;
        Mon, 11 May 2026 09:39:44 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:40::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e367c05393sm7450778a34.9.2026.05.11.09.39.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 09:39:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 11 May 2026 09:39:43 -0700
Message-Id: <DIFZV6EYXKW7.220V3470QWX01@gmail.com>
To: "Yonghong Song" <yonghong.song@linux.dev>, <bpf@vger.kernel.org>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Jose E .
 Marchesi" <jose.marchesi@oracle.com>, <kernel-team@fb.com>, "Martin KaFai
 Lau" <martin.lau@kernel.org>, "Puranjay Mohan" <puranjay@kernel.org>
Subject: Re: [PATCH bpf-next v3 16/24] bpf,x86: Implement JIT support for
 stack arguments
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
X-Mailer: aerc
References: <20260511053301.1878610-1-yonghong.song@linux.dev>
 <20260511053432.1889692-1-yonghong.song@linux.dev>
In-Reply-To: <20260511053432.1889692-1-yonghong.song@linux.dev>

On Sun May 10, 2026 at 10:34 PM PDT, Yonghong Song wrote:
> -static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_pro=
g, int *addrs, u8 *image,
> +static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_pro=
g,
> +		  struct bpf_subprog_info *subprog_info, int *addrs, u8 *image,

Same issue. Do not add subprog_info.
env and bpf_prog is enough.
