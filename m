Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390C639900E
	for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 09:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772097135; cv=none; b=Dq3vjZQ+qxnB5pe20w9adn0Coox5HrPR3NcMEEyyqc1PjkGxM6Xo1O9U6ZX+03GguBk//I8kQNblsR4T6EovtU62kV0rstSpyD/L5/tar6PC2M6vNGoqZQ8wY20Sh8UwGUJeJIuIGRCiv06NhE6+WRJ7cZfKTZXBpSL67oHOf/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772097135; c=relaxed/simple;
	bh=gR8JrkKH77PwEuudsi/sFf4YxNq45Ct5YGL2dA2Gjb0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pk2TdmC3H34BZ7QppkOE1Tngbe34QYR60ZPUo7awec37UZ1fgMH1BJhp9CEaMPmxi2LSMZUQDOdpkR8MSCTvgRkVabHGSPX83XpuC5KU11JzXWoRdvWKyvDspN+oG0eMIZAHKGI9cI3IV+IyAGMMOkIlcOq98C56yT3Smd7DW2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lrgVHh3l; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lrgVHh3l"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c6e1dc5c5edso279995a12.1
        for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 01:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772097132; x=1772701932; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WfjwDtLvw60OrVaBORutYJIpW9lJUq2Hk3Pocg/05+g=;
        b=lrgVHh3lUpxh3oc08NCO5gJynQVpx8JtwWqHFnUo+vfP2h7v9uT11P2klu0CGcnNZy
         kXIkfGYznxUhzBBs3FB270Ge19qCrc9pA30UPKTuPTXSrtIvf6kIpFvCIrQT1rLno3wb
         XWPf7b6TNKXYkCE096yKoa8muyKPsd8kEuZ36En7R4Fc+j3EgE3V+IdSboBEe2nyFS95
         IkLrD/KMe9AZ/t6qDh+ptT6veNKNzFyUdJc2tLAOUaHJlnqsTKhQrEEI0HwTYJmRgX+2
         6dmYgtIsQdPnmomsEKS6bMRUTR6Bie/i4ion1W85BQlwHsBoK7gNsRjFN7lomrEyay9A
         +cSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772097132; x=1772701932;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WfjwDtLvw60OrVaBORutYJIpW9lJUq2Hk3Pocg/05+g=;
        b=UC2isyrdPGqZWRSyV32c9zmm/x/4W5PqsLBk4jdTAYi32I30q27qC6TXPUqyavAcLY
         uDN8uKubitW9Rjyr38ITh8zJCopgMDdAtRrqPuh1He43dUMD7ggry6UtxnJUGuq7zDnv
         MPax6nBWvqtefNkZWRKk/8khbIMUz9NjPQUQsRK3Gm5rq/532VvrTrK2gMAqe3bZtVGa
         noWVx3dlsNCP0Sn7j+7msfi7VesQ+kR14aySbEiKfyw2RBlaeXfe/9mmHQdBtBiVEjgd
         zPnDeww6KXglGFdAXhIzVbIp6t9WzUy0fKFkVj2e0R1luRrLdGyFALMY/ZV+0CGAlW+3
         m0IA==
X-Forwarded-Encrypted: i=1; AJvYcCXiKlrNwAivJMoVel3xDxwKnITQUl0GPlo5sJPOLc6NXwfLCecJktSppjtiGk+BD0nZrJo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5+LdHR1rYCOm76d9dI4f4UaZCjlRq0A0mG2jLdNVQigZaxgSU
	F+UmodwiwpBI3hXpKm50DgY6uCETNlByAWG3hAPvzv4p8t557UL6lTqB
X-Gm-Gg: ATEYQzz0vzmHx+lqOYfJoYwGgKMT3AEPZ355xXOwrIQmn94xbPMpgdRBC4joIUMNQ5U
	pFtgAgFYu4cEM96proj/gv1VblUjQ8Qshk3lHFbgoSHInSv7Ix1TjWRgCzBlMADDnsf9I+oxL4T
	l2sd3WLaKOi7UUpVXv7seciweji1U43w1pEuL2v9Fj47GXb57q3ODvsXpFBSfgBlxYgMCIrBuOR
	CUP2/1KN9xC0Iv49PAv90+7qVAM/6OWX0e4JMiArk6d95UJ/kpY5Tc58nt9AL+y6/rwj4WOzmcr
	x4YgT3yBxCE5+l4gm92k/FNeJsMdkwuF2GPgxd4Nzridx4JJLzpCB1VuMKlT8rLezBJpP46RFJs
	kQ8PfqmTUdUlN8d0nHtudfEOxnLgPcyKDNi6xJeXz5qiZ0d+76yg9pzaA6ZGimZmaou5HqiPtq8
	7s6Y85rgNG5iS8/z1cn9GkCycFUqZ7lRSkWFieQyLNg4rCVjzHTok=
X-Received: by 2002:a17:90b:1f92:b0:353:5595:3246 with SMTP id 98e67ed59e1d1-3593db4e1acmr1722094a91.21.1772097132222;
        Thu, 26 Feb 2026 01:12:12 -0800 (PST)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3593dda5c87sm1461686a91.9.2026.02.26.01.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 01:12:11 -0800 (PST)
Message-ID: <22c68a8ae1e415bb70bd5581f9be890495335ecf.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Consolidate sleepable checks in
 check_helper_call()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay12@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau	 <martin.lau@kernel.org>, Kumar
 Kartikeya Dwivedi <memxor@gmail.com>, Mykyta Yatsenko
 <mykyta.yatsenko5@gmail.com>, kernel-team@meta.com
Date: Thu, 26 Feb 2026 01:12:09 -0800
In-Reply-To: <20260225134950.2781351-1-puranjay@kernel.org>
References: <20260225134950.2781351-1-puranjay@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-02-25 at 05:49 -0800, Puranjay Mohan wrote:

[...]

> @@ -11609,28 +11622,11 @@ static int check_helper_call(struct bpf_verifie=
r_env *env, struct bpf_insn
> *insn
> =C2=A0		return err;
> =C2=A0	}
> =C2=A0
> -	if (env->cur_state->active_rcu_locks) {
> -		if (fn->might_sleep) {
> -			verbose(env, "sleepable helper %s#%d in rcu_read_lock region\n",
> -				func_id_name(func_id), func_id);
> -			return -EINVAL;
> -		}
> -	}
> -
> -	if (env->cur_state->active_preempt_locks) {
> -		if (fn->might_sleep) {
> -			verbose(env, "sleepable helper %s#%d in non-preemptible region\n",
> -				func_id_name(func_id), func_id);
> -			return -EINVAL;
> -		}
> -	}
> -
> -	if (env->cur_state->active_irq_id) {
> -		if (fn->might_sleep) {
> -			verbose(env, "sleepable helper %s#%d in IRQ-disabled region\n",
> -				func_id_name(func_id), func_id);
> -			return -EINVAL;
> -		}
> +	if (fn->might_sleep && !in_sleepable_context(env)) {
> +		verbose(env, "sleepable helper %s#%d in %s\n",
> +			func_id_name(func_id), func_id,
> +			non_sleepable_context_description(env));
> +		return -EINVAL;

A few checks above there is:

	if (!in_sleepable(env) && fn->might_sleep) {
		verbose(env, "helper call might sleep in a non-sleepable prog\n");
		return -EINVAL;
	}

'fn->might_sleep && !in_sleepable_context(env)' covers this case,
do we want to remove it as well?
