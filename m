Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B0640DFC0
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 01:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776303707; cv=none; b=dflrfytuc42wgPi5T+OMwU2KSbctRnRYTkyH1yQXdb9sd4NgVQV+pbdBPmJL9Iwywj9ozVURfjLiNUG0VgCGxUo/ztNHWZyw4OTfguq+XOHkh++y7NztI5PeBSwQG82N920lEpaRX6Ee9PlJu8z9jb42kEfeAImiPMhrjZ8IH4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776303707; c=relaxed/simple;
	bh=UdcHnlPAvGOm1HkySw0OYlikXtoWsiKj55xGmzP9k60=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:Mime-Version:
	 References:In-Reply-To; b=IbeqmTg35sZzkluTxXOCJwYDvJsK5nJ3hOB8AMPTXOH5pQu50KaNEhJ8ZEPFw8an+XvOT2miwQEaRy8vWNN4WOr8hi3nYc2V7uDcIfIVNxlwtrFefx6OIbFRwO53LXn8wzTdZn3uaiEXytdNP79gjelUfkKjSs3lricNAI1DRLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FZgxrjAQ; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZgxrjAQ"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-82f1dcd5886so3243882b3a.2
        for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 18:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776303705; x=1776908505; darn=vger.kernel.org;
        h=in-reply-to:references:content-transfer-encoding:mime-version:to
         :from:subject:cc:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QTTcI1dY/AeO58J3Zq5daBrJk38sfB4OoezTyHdDEzk=;
        b=FZgxrjAQUM8G2Hdh4IWJ2PBdEInht1ODfihQBhidN8nAz6paCgpuDVlz0ddlmpY8Y8
         eE1v6IeM2W4leV3xpkJC0cFPLvNvLpA710YxSAEKbhX2xF3LxeT9AFBVcaP1GU7/SORN
         tDd+EUwpxMpoYgXCxdPPpKEGxVfy20kxtlTysgAnk2NOd67+gvFZZ/uiQuDnQ3eroNE+
         6yl/w0cNQF9K8KnfOd9tNmtKgtYaiQxrQNjTCOlIwEqxukQ4Ab1gSmY9SG8oWjn2sPCU
         iU3zrKC12wkQIQi/nUtu5ayQCKHaISHMPYc9NeNfJFGMhrV67zVBUe6ae0WZV/QtqV0v
         JwQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776303705; x=1776908505;
        h=in-reply-to:references:content-transfer-encoding:mime-version:to
         :from:subject:cc:message-id:date:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QTTcI1dY/AeO58J3Zq5daBrJk38sfB4OoezTyHdDEzk=;
        b=Ukt6Are6u90m98cDZLbkld7Ilv+BetZAuvjRUg//Q7cNnBGkIviAKjyFmL8IabcbjP
         MpzlDYo0lzk1RUxCoqnqF+7dYtW6jxj1euCf2YR1C7FxQ4vnvVZ8ShwUCpgvC/pJBu4f
         c4xL1IXVGG4mN3wp0ctVzWmcFtajP/w8AYytXi95E5sVZ7lMT6h0DlQXhQm3g7qS5p0S
         25Q2ElJ+ztR4Iiic1HaF0GLqzBTwmtVB0E6JAunQQ2k3u1UNq6UTdSPMOUtx9cINJsjD
         oTs1Pq8rDMG3ZSqk6U0gDfVQndK+ZJ9fXfxhhLnV993BhR1gZORGSCTfaE6Zz9hf9gxX
         faEA==
X-Forwarded-Encrypted: i=1; AFNElJ8VauCVn72L0FsQpuvEkepCEUxSy6vFJTdI6ZyydcJ0tEfDpNwMwGnk8dgxSTFL5evjmsM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ9GB6BVFtwucs27Kp3+5E94nIDnFCk2X07RPBQwij/rV2EB0q
	4EVJ3NYNzn0E6ujyUAtYXHl+nq+2Fob+3424PLtkGKj0r3X3IxTJ570S
X-Gm-Gg: AeBDiesoxY+UWwC2DUtorB6SY2xVz+ii+EFln8IGVohLYkosnazwg8y7GK5yVDJh/qd
	z9OvIXTiauUrW3AjPpSpQE0AxqdkGszFKNhgzfco0tuYGg9sDvFGSpYgdkjmb+2Afy5yaxPPUo5
	KwBYFn03ok2hfl8nPyZ25W4NaL1p1tWMCub2sdCBFxyzB86wg1RttSTe/eCdUGWS+qD8ct600tm
	p8MxYz3mHE2cFXZ40vLp0WvUxp/w0WcSlBX/JSCbyQtnIfEQGUbfzU6dbIpd5ercWwc3a4JN6kX
	pxLn6+eD7tR+A76I15jGLNWkIk55mMCYJuPLnbqwGPoD2pQlmCyY2AbtZ6CVMr6biuMwX2YOpoE
	5iKVtMVpjEeMiHvEdzB97m/7XYM6+UDTK/31nSkXJaysohbQtxsyT1mmxRaSE8wXwK8DnH4/UyD
	SCros6d36NoctabkSFOPvch3W3H/WV+igOXP5ieg9tq/y9CMenP4AgrUnL7j5nJOmt06RncuCaB
	B0Sy/zz6srkB4/hqr5QcHTev8BZjI2Ytw8nrQUf86PGJXLVOWBB1qQH
X-Received: by 2002:a05:6a00:800c:b0:82f:5e92:c642 with SMTP id d2e1a72fcca58-82f5e92cb92mr7236704b3a.41.1776303705265;
        Wed, 15 Apr 2026 18:41:45 -0700 (PDT)
Received: from localhost ([2601:600:837f:c470:1879:8422:922b:e5d3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f6744c7f9sm3415335b3a.55.2026.04.15.18.41.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2026 18:41:44 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 Apr 2026 18:41:43 -0700
Message-Id: <DHU7408DLITK.2DC76VINL2F7K@gmail.com>
Cc: "Mykyta Yatsenko" <yatsenko@meta.com>
Subject: Re: [PATCH bpf-next v10 2/6] bpf: Add
 bpf_prog_run_array_sleepable()
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Mykyta Yatsenko" <mykyta.yatsenko5@gmail.com>, <bpf@vger.kernel.org>,
 <ast@kernel.org>, <andrii@kernel.org>, <daniel@iogearbox.net>,
 <kafai@meta.com>, <kernel-team@meta.com>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <peterz@infradead.org>, <rostedt@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.21.0
References: <20260415-sleepable_tracepoints-v10-0-161f40b33dd7@meta.com>
 <20260415-sleepable_tracepoints-v10-2-161f40b33dd7@meta.com>
In-Reply-To: <20260415-sleepable_tracepoints-v10-2-161f40b33dd7@meta.com>

On Wed Apr 15, 2026 at 7:49 AM PDT, Mykyta Yatsenko wrote:
> +	while ((prog =3D READ_ONCE(item->prog))) {
> +		if (!prog->sleepable)
> +			rcu_read_lock();
> +
> +		/*
> +		 * Per-prog recursion check to enable private stack.
> +		 * Skip if prog->active is not allocated, e.g.
> +		 * for dummy_bpf_prog used as a fallback placeholder
> +		 * by bpf_prog_array_delete_safe().
> +		 */
> +		if (likely(prog->active)) {
> +			if (unlikely(!bpf_prog_get_recursion_context(prog))) {
> +				bpf_prog_inc_misses_counter(prog);
> +				bpf_prog_put_recursion_context(prog);
> +				if (!prog->sleepable)
> +					rcu_read_unlock();
> +				item++;
> +				continue;
> +			}
> +		}

What is the point of running dummy_bpf_prog ?
You just checked that it's dummy and yet want it to burn cpu?

Once again, please de-claude it.
So much unnecessary indent.
Focus on keeping indent minimal.
Since claude cannot do it, it's on you.

pw-bot: cr

