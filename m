Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888E142BE91
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 19:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786390621; cv=none; b=KE3RfjWet1QyVL4B+6WOMLBaUPxnH15Nsl7pPyVTljMJ96BHOZlc4OPN9Od02Wm5ib5psPD1HR6Xdnl19gTLkVgJtPSin1ffFY8Wj7Mm/tbPdYyrBQcoN1lBNpI+TmJP7iEVd3IevFtoDtoh06Yqm2VHKd5ZrNwdoWI1jZMtz4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786390621; c=relaxed/simple;
	bh=+vVAKun35hRGw+gwnIJQxOswWypKvX3Q6pgw7V+MUiM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G9AkPUETTSehPcADzKka3e7CovAI1tx1NY/i5Z2ggIIt0ladb2G99ImdYo/dVee8jiLeNpfUQ7yYlvdbOXXokh3NvYLFRFozJLPcswRQIFFfz+0xOURr8wwjWdxxqY5mt4RZ7ZyGQfGD6Dl7YTbs4OUaKk4LnQrORTN1lT30Qbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nxfi2+HP; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nxfi2+HP"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38dfe7eb825so1928348a91.0
        for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 12:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786390620; x=1786995420; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=bkxBdM9TZi9JLjzHaRgivZKf0+W+j5yecJ/UiPRgOE0=;
        b=Nxfi2+HPhcZNJ4gFpWTzauATv0sXDhYBq/zXo1Oc1TRm7nI4gRrvUMKZTIK/a4Ga8x
         NA4pbEIspWUq85ep3C1v+q34mxepxkqQbuIFRGQESmQJiJQuGSZRBZaFL+03RAGUZW7I
         /nSuxaJxVinQZdjln1SdP1pLlGZZed10JzwGR1QpWHWbGNAxfFLu5ibrKKOEZZvWZMVi
         b+143CxoUzc75ba7QmNCdpntkU4gwbjWrL9Pb7SoKr2xNCJQZo5TltenvwTXkWLmAfWW
         kfV+oHXOp14X21PcjZn2Mf3FL6bbYHtfzZx5v7L+3SWZceICFTWsMP2c2ivu4tRkXi65
         GZ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786390620; x=1786995420;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bkxBdM9TZi9JLjzHaRgivZKf0+W+j5yecJ/UiPRgOE0=;
        b=tTy0O1fMO4t9ivLM9Q2w1b8xDdHL96DWXKu2nAW4CeezTlGXEGDZ+mHTEYCFPVxNNY
         Ja853ONqZ0E6VZLTf6zUz13C8LbcObw30brcQSDZXz45/kMhiu8W8hdpCYxeuyZw2h6O
         qrJV89oBrSx5r82VlH8CeZS8OoHIFTJoKyinuCGLN0HGnnCBQDrsni9tAANti5KypaxY
         uXV935jdLq0rt1tUBfw0nrSOLjFOPVkZ7r3umgJkTdYnm208Kl8U69COBIBkRa/krPqZ
         moEnbZX/0A5ecW8tpNK8riXkPkf+n+wIbRf6J8Q+2nfwfnrFkHUlIagHXw7mBnOr3w5u
         jwKQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro5zJWlN/0P8pWR08Qi7SAhk5fpsfc9CkXQwWUCrvalrPDVm9G+vg95sd1mf00X+i9ezPg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy1zd/VbFqD1AOFcCzSefHNI5SIxQ1/nsrvFfxACJUoLgaQ1Xn
	qFniXeaHWpsLjrHzcfwPs3960M6Iy0/gQXX+fZXq4EvQx+tTV1Vj0Me9
X-Gm-Gg: AR+sD11rvC8AQqDewQ6AGbciOHYCsxVhMFfecXZqz/ufVzuTTdL9d93YN9ttx3TnouG
	EspwHxuQwT7E1eTCx7eUb53D7q3myr+Tt5Au0xfDqmP+KMuOJ1vOeJpkBkqcSyofwTfduNMRwyD
	cp2D9iGgQX1Th+/my+HDP0TVLPpxXzv9WDrqbSLXMvbfYUNz3Ud18esZlRciC6ayyjOJ/dsLvAB
	CS7IfMdabtL+nRlBUm6GXPAfvYyA/M8TIeGXoHDf+AXwMW7QzIuLE+1pDB74OOA/jJdr6cvOvM5
	eqO/yEEa2UvqBOu1Xrf5EOyY/agr7F7AA7VqBT7Pb3bpybqaC+XQyjerndf+rCxa7DSo7bVcaFu
	jPiiXzRTPEyomGfQuE2+4FuJ2TXzbDRU/X7ZL/aKhlAprM1Ao6cefKKq5Ld3JHEzjrwjQ0y8XFP
	cSmpZOGt/hQ9UC0fIo8FIHGQpuE811AEy99giPVVK8gAg56ztvgwuqT468NjcpKRiLqItXdvUt+
	b1ghx9zNC6yalKs
X-Received: by 2002:a17:90b:1e43:b0:392:7f74:58c9 with SMTP id 98e67ed59e1d1-3927f745de2mr15777147a91.15.1786390619744;
        Mon, 10 Aug 2026 12:36:59 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392d51c333bsm800057a91.8.2026.08.10.12.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 12:36:59 -0700 (PDT)
Message-ID: <394bdd5e8cd366cacaa6ced8a32e851b43e67e11.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Test RCU iterator state
 pruning
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ning Ding <dingning04@gmail.com>, bpf@vger.kernel.org
Cc: memxor@gmail.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, 	linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, shuah@kernel.org
Date: Mon, 10 Aug 2026 12:36:56 -0700
In-Reply-To: <20260807004320.134069-3-dingning04@gmail.com>
References: <20260807004320.134069-1-dingning04@gmail.com>
	 <20260807004320.134069-3-dingning04@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-08-06 at 17:43 -0700, Ning Ding wrote:

...

> +SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
> +__failure __msg("expected an RCU CS when using bpf_iter_task_next")
> +__flag(BPF_F_TEST_STATE_FREQ)
> +int BPF_PROG(iter_tasks_rcu_state_pruning)
> +{
> +	struct bpf_iter_task it;
> +
> +	bpf_rcu_read_lock();
> +	bpf_iter_task_new(&it, NULL, BPF_TASK_ITER_ALL_PROCS);
> +
> +	if (likely(bpf_get_prandom_u32())) {

Could you please convert this test to inline assembly?
The presence of 'likely' might not be sufficient to guarantee
the codegen pattern, so we usually resort to the assembly for
tests where that is important.

> +		/* Keep the outer RCU lock active. */
> +		bpf_rcu_read_lock();
> +		bpf_rcu_read_unlock();
> +	} else {
> +		/* Create an unprotected gap. */
> +		bpf_rcu_read_unlock();
> +		bpf_rcu_read_lock();
> +	}
> +
> +	bpf_iter_task_next(&it);
> +	bpf_iter_task_destroy(&it);
> +	bpf_rcu_read_unlock();
> +
> +	return 0;
> +}
> +
> =C2=A0SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
> =C2=A0__failure __msg("expected an RCU CS when using bpf_iter_css_next")
> =C2=A0int BPF_PROG(iter_css_lock_and_unlock)
