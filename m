Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061493AAF55
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 18:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791571569; cv=none; b=tpfkz5479zIKTSm+HQ/IJbsOGp9Z/8ThvgZ2sLMQNslxhcXjLKiQyiUNsGgTljlDSoYQcSCWW+U0o60YHb2SRASEzF2XSH6R7g5V08QqB8A3NWTYR5uEKp/SJIMxzJT1Py5MfQitzx4TDJE/gviivlQ7OSbK93Gdl+H7sK66/tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791571569; c=relaxed/simple;
	bh=wZod1qP4w1aqsDdgDezPpakELxIm8vqk6zVUSsSiTGM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Fp7Fd0Xm1KxlwrwlEPPZg+8sF+Pk0V2RxvIvQJj5ByQeGMoI46+TFGlE8xzZSYBaJOzlnV0aefktdthmBmT4XZVmHFOKYDeFqaRjZfvkuN+HDfu3lPjro72fm5SWmXXWeU4PDRYG5mw+7suQFlMhbwLKlLqfNAvZQFVOWOLmPHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DFlS9Ny5; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DFlS9Ny5"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-3516c82e96cso18363eec.0
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2026 11:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791571567; x=1792176367; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=RdnMVkZ01fdHhx2FatP4rLX8DB7tZD+RKSIs68YHMRI=;
        b=DFlS9Ny5y6aDe8vv6uJz5ElOx/U+XRmaVT2sGuBYnZLgdN3YCt9fO9V4o/63T7etig
         VqGFu6vfY33Ykuw90FD6P118X7R0dSsRkh+P1N+g+bxoApjxc37RYVHnmtuGXWStmhLP
         lcPhme7uNRnnbOdyHj4FrGDqRhCNnZ4SIGeno1Q6OcqAyifRLucwMibsmGky/Xcg1FlE
         uv6koNg4kj5/8jFZWzYTXrEtrkeN00DSqz3x9+Ucs8RCqt01lVP0vhPQLwiVKfLe1dMa
         N62qDNNzMbVw/MqLqpDmqODmWbzafhy6JgPv0cgTCCsRNa7Wzh28QT0oxFzZBrq2TmDX
         DLcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791571567; x=1792176367;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RdnMVkZ01fdHhx2FatP4rLX8DB7tZD+RKSIs68YHMRI=;
        b=E8a6fhu1NFb2N8fUJItc3+5X/u6NTh7e6Qu13AVIbP9IsC001A12nu5XO9AAu6WTjQ
         XXtEQYrxEYkwqDSvEKUTc6U1RD/DokGz0Ntc1yj2gH2UHKZJWMWz6wpZWhmnqqXdGhyq
         0UPPxlogBEVfqVRmcGwsVZWW9xZJZjgAqRdaB4p2SZjW/lQK01vLgn1Bl2QJhQJZDO1+
         3tTXTm/nejn7PJx4Q7YGkZTDxeqLGtdXTFOsuw9A8AaxT0QgBaR6KyDma4g5EK/xX4AC
         7xMc8l83rP0KQ7Ld3B5JGudp/WFKQyxfgRHka5uMRxHzkt1rGzJf7CGjg47CfFykO5SL
         f2XA==
X-Gm-Message-State: AFuF++ms6tSgi6lkH7/cHdlbNiVe+spBrHpZkoojuQuA3frRrhHumilI
	YzsJ4CynNNMilndRyXiJhG5fkh7g26a/BfoJdDCm3R9wsAoCIsj77WXk
X-Gm-Gg: AYBFou2IAuGodoiVQMRxAiSGwvYXNX36JobPyYn9132VlVTgxJi+fEfPSrcPo8Ug/45
	KvzCKFAvP+YDwxZdt8swR3tLslRbM+bEC+8cdNF8wRYMjwjrCOvNKBRZL+hrM+kbKmR5jykNCdi
	5Nl+wbxG9RRRySAlBJ/TdOEVoT5gNV/kdBJOBek21eEmQeCmSsU+j21c3kKJfbt0cCmaxKu9+at
	U5+ynDhYyNtrFjYt0L+t8fo6otzWGj69oiIzNlweu/KkpRhMI1K4dAPYrl/6EvcBBZjvwUudHgX
	Tg6EzafWC0y41s24O17UgTExE2XG9bOo0QqWXITkKEjw9UPm6Bcnou+uylNdRbtvWwI5iEnNymk
	pV4cNkVI6lYqGEXd75Z7IeHL29F3gGncsqRO9nj5reSeYzZXUmP6fU8WYqdZv0ZETWa3StxmD5M
	tqo8EmePw9h+FPlFPLZoE316dqGzyYDy8CMe3MM0X++3DF7NoXxcOPXeaH5fEa3OGFsx53hUrZG
	gyZ6Epeahe4h8pd7lV7X1tU41BFb5sbZBNnMvC/lY8Bv6cVmac9mEBG
X-Received: by 2002:a05:7300:f3c5:b0:351:7c99:c239 with SMTP id 5a478bee46e88-3537ddd42f9mr3791541eec.5.1791571566660;
        Fri, 09 Oct 2026 11:46:06 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:26fd:a5f6:5f7e:c6b7? ([2620:10d:c090:500::4:66bf])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cb1e02asm8437400eec.27.2026.10.09.11.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 11:46:06 -0700 (PDT)
Message-ID: <147015d9dd64f4dc1bcb01b59c027f34a41cadf2.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 11/51] bpf: compute parameters liveness in
 bpf_compute_live_registers()
From: Eduard Zingerman <eddyz87@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Date: Fri, 09 Oct 2026 11:46:05 -0700
In-Reply-To: <sashiko-outbox-165368@kernel.org>
References: <20261009-scev-minimal-rebase-v3-0-bcba9bc53ac9@gmail.com>
	 <20261009-scev-minimal-rebase-v3-11-bcba9bc53ac9@gmail.com>
	 <sashiko-outbox-165368@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-10-09 at 11:26 +0000, sashiko-bot@kernel.org wrote:

...

> > @@ -10939,6 +10940,15 @@ static int btf_check_func_arg_match(struct bpf=
_verifier_env *env, int subprog, s
> >  	meta.fn =3D fn;
> >  	meta.func_proto =3D func_proto;
> > =20
> > +	/*
> > +	 * Check if all register arguments declared in BTF are initialized.
> > +	 * If they aren't the BTF is unreliable.
> > +	 */
> > +	if (!bpf_subprog_is_global(env, subprog)) {
> > +		for (i =3D 0; i < min_t(u32, sub->arg_slot_cnt, MAX_BPF_FUNC_REG_ARG=
S); i++)
> > +			if (caller->regs[BPF_REG_1 + i].type =3D=3D NOT_INIT)
> > +				return -EINVAL;
> > +	}
> >  	return check_func_args(env, &meta, env->insn_idx);
> >  }
>=20
> [Severity: High]
> Because unused arguments are no longer marked as live due to the change
> in compute_insn_live_regs(), can this NOT_INIT check be completely
> bypassed by regsafe()?
>=20
> If the verifier first explores a path where the argument is initialized,
> the subprogram is not marked unreliable. If it subsequently explores
> another path where the argument is left NOT_INIT, this second path
> will be pruned before evaluating the BPF_CALL instruction and hitting
> btf_check_func_arg_match().
>=20
> Could this result in the subprogram remaining "reliable", allowing
> fentry/freplace extension programs to attach to it and potentially
> leak uninitialized kernel memory via the BTF context?

This is a valid point.
I should OR live[subprog_entry].in with BTF type mask.
