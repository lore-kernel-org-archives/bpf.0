Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC393B14D0
	for <bpf@vger.kernel.org>; Mon,  8 Jun 2026 22:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780957481; cv=none; b=cw+UQzFGXT/vXT3Uopo+Dp9s1oCB5Jxp5hRZLfQlTeKrdKUAicAZvAMkX2qzpWTnsDTTpfwdETbNyA60Wa/dU94IJpv4dWCbRMal6+1D49OmqggXA0yuWiie5MJ5hG9UMTUiKVm4PYAXfjJuHpC+NGSvVmh2kS3VfoRP1/4Qrzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780957481; c=relaxed/simple;
	bh=uUc5tycOuJcWwXRCFT2WWyKUboCcS/UfRKpSMpCvNRc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JXAnWaycn6je6X0MJ0d9kCucAe2XlTKN6fpFYB5w4pmxnTZWSe9O/GbTQpkdIn76idwUp6QHsmC37DFxjAToupyof6nuHW9+NivEvQt9ahpCBx3xzwBMpFVNsnPMouO8Mq1cKy3ssLxBEwCiLl+8hg+Mup26yV4lnwtr4w0PEuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EjzIkyNW; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EjzIkyNW"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-304d8362a58so2902605eec.1
        for <bpf@vger.kernel.org>; Mon, 08 Jun 2026 15:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780957479; x=1781562279; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=u3cPP6Jtg5zWqMu37J3HKvJnAezJCj6GALf0vbPVnkc=;
        b=EjzIkyNWBFc7ZaHQVrNewFCPVPse+RLPMyfR7mYiHfQt3zIRnB0jjqqQHmgXLVohwh
         7HbtM8Cf7VHwQXABnLSORJ67EeEJNdeQSmAjt2g44oomVYhazQGgVzfb771kAFYTmrtB
         +D1lbVrz4lPJLba0QUv2lVMK/ImbM4pmF6SH8qukQbjhSK3KHKmYQRk9yT3kNxhFTszr
         k6SKs8h+pSTAK5k89Qs56pysYAv94OJ53UmCaxDCmTxZ/jvefXZ5yWOrUJ/ekU9p2IFB
         056pxUXz7xk/pPFQ+CnxNjCGcUbmQk1nX148WhKaHFv2NP57+vowA6X9LX6WgyK4uqnI
         Ef/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780957479; x=1781562279;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u3cPP6Jtg5zWqMu37J3HKvJnAezJCj6GALf0vbPVnkc=;
        b=JhyhCUI/fOLTIaVC4Wr8gEg8qP8HfgphUjxb7dk7zxU2qc+QsIs7in+YtkA9itoXq+
         nXkt04u2EG9LtL0w34n8NhvCBroYbL7A84lpRnAW2SZW3NLNHO7E5kmdMm9yU8uK9A39
         sOG9Hf+/tF6k7O4KgGtycy636FqBFqAZZux+Zj9CZ9PxFotoPv4Zt9v1uHd8Kpq6BQWp
         Riu7k1m3JY36wfejFbVBoc91I9ggy2BAR08TBn3Y/fUlxml0m/6v7ECMjXB5Ck/JxB8c
         JVaNnde/d2WPoeMdtgPOFlL/ee9TmBRRV4IVoQp7Nvl226XHRdQoiGmHJdgt4wPRvEmW
         rzqQ==
X-Forwarded-Encrypted: i=1; AFNElJ+VJQuDZRXjZ+DCDAtSkXdpE3Q9CAdnQ1S38mxeD8AZ+jsjXGyxtbAt2wZ/Cr9iPFIADvw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpOcQhbWP4XAwKl8JxcLRs+ySxZCPUK0N6nRce9/IfdmYPeC3z
	SHxROtg0Lm+lWA5qj7LjaI/UOetSq4NTM4VJQUbxNdtIA4vi+lSEcx1l
X-Gm-Gg: Acq92OF6z9wcZg6gA/fNBhR6cEIBmDbgV3vbIVzi69H29hMYoySA5KSZXq5dEEj4ikU
	7+cG5zVDRAXoKBPE+y1NQ5yKvRuVXqJqhkaGeo9GxeO2NQONm+e1qOtTTNAgthGnWRPCt15fFFu
	zR4/QfyTofhRldEYNE34nupgTEjrATnmccvfobMW2YzwzgUd6re3Ngk9igFS5ZJrF9AuyLElAro
	pFpRgFEOe+P3wdOdSKkMiBiIAKw055mXIO0U9dCPlYy3EPcqNPntmoIKuKePwmEO6mQQGx71Ft9
	l8bhc8NLecDu70BPK/ml4+MiRDzfcViqXQj0B+e/4thghRiNiCrGgZNJmLIc3KlKtYnBnTb4j9g
	Ecw0LyulBBZhTCgtwo17c5bWEv4p1Iw2k22McATSOfgO7JmEvhmqWU60Mfb5rAzhO0FeGzCq2Zu
	dUePv3Sb7g1xQ5p6KUQb981b7/zN9Vs2cUteSnUeM5NEH2E2r6gkkdkcEmVyHkbNHlTmsgzWtpI
	BmXNYODOJgPsft7BRY=
X-Received: by 2002:a05:7301:1504:b0:2f9:1004:b2cd with SMTP id 5a478bee46e88-3078011de63mr5710766eec.20.1780957479348;
        Mon, 08 Jun 2026 15:24:39 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:cde6:fb53:a1a3:a385? ([2620:10d:c090:500::3:b685])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074db560d7sm26318462eec.5.2026.06.08.15.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 15:24:38 -0700 (PDT)
Message-ID: <9758e4f7f4497d081b386ab0a3cf8fd9f56f9dad.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 07/17] bpf: Track verifier context
 diagnostic history
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Date: Mon, 08 Jun 2026 15:24:37 -0700
In-Reply-To: <20260605063412.974640-8-memxor@gmail.com>
References: <20260605063412.974640-1-memxor@gmail.com>
	 <20260605063412.974640-8-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-06-05 at 08:33 +0200, Kumar Kartikeya Dwivedi wrote:

[...]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 9b9ffa57b95a..7bb2a81ee353 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -1060,7 +1060,8 @@ static int is_iter_reg_valid_init(struct bpf_verifi=
er_env *env, struct bpf_reg_s
>  }
> =20
>  static int acquire_irq_state(struct bpf_verifier_env *env, int insn_idx)=
;
> -static int release_irq_state(struct bpf_verifier_state *state, int id);
> +static int release_irq_state(struct bpf_verifier_state *state, int id,
> +			     int insn_idx);

Nit: insn_idx can be inferred from 'state', no need to pass it directly.
     (Here and in release_lock_state()).

Broader question, why track release/unlock events?
Reporting these only makes sense if there is nothing to unlock/release,
but that information would be covered by bpf_diag_report_resource_state.

[...]
