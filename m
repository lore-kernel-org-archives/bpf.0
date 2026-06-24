Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B903E559B
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 21:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782336089; cv=none; b=TO+78b2iMCfSgQtndmk9j/xPA/fhgd5t/+b3AP4hTXuxg8rC/0wAin+YqtjBfh/7SONSZRips1k/+1RI1iZYzCAHaaX/ubMINOC9WWxY1KlBb8xSuKkV82PfqdV2rT2ohk3B1XRez71JGDmAoery3WMXMj4u1ddlh/9gaCMVsg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782336089; c=relaxed/simple;
	bh=qLNdIIj/JvVaNBCTqq+YG15H3trBnTJQi92dfAZg9CQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RnWBRwjEIKjxfK561jxC0Hq+RYCEUGuOrEAh0TtMYkdXiUwmkbExC99BsIBWrbSzDn+W5MDY1I6mZO/pvm+WMDn9i1fePhhmFjkMmQ2KYvENkAq8qJ8fmUW9jkRdfJ9MogtfGCwOEDrbQkxsjs4tiHh0Oeq37CRBn0rmP0/u3Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gG1yDttX; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gG1yDttX"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-84532e3dbf7so1071923b3a.1
        for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 14:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782336087; x=1782940887; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=buNDbduFwbOUAFrol7dKMbEVeEkYFIdGPoeEAIPuuDQ=;
        b=gG1yDttXcYmj1pgJ7tZz1AP6ot4cq3cdVPSzMfe3ALvKm5IkqguNJpP8QcVrGZUZau
         U2yCbzyzCBywjNO1b0PyUR2P9vkfJrGH3Ij3EWzxK2WYKO5VffEpd68yUgQJGeqEQ/zV
         McvCTD2vHxFfnzYAyDKMlO7yae8A9/DaHQQAIyNs0ph7UCrgNW5HLglfRskTv6v2i6eW
         mCKJLTThXkUa1tUbdFQZ6PcR5dLGyulELeF6JvdGIRZprCRA75R6ieDlVnIHvuMcPwj3
         ZBOECjbgi2w//CqyWLNtpSTMgbQBunKaZvg7SlKXa0KEk6Dr5frSLXbgITjlQ/nSVCv5
         mZ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782336087; x=1782940887;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=buNDbduFwbOUAFrol7dKMbEVeEkYFIdGPoeEAIPuuDQ=;
        b=peGWICsPjqa8spvXMa0IkPKMq45ideYUIW0YwbGNzy4cqt+Lh7j0K6OJqxtmTzV4eu
         nSgxk+a+Ih0lX9ffXPhfBWD0JGTtq0VIiGqwt05AxztUzen3yoj9TtAIiTXcoqmJe+0N
         l+ULrawYMk8XhSAmMBEl8Prk9nALvz0bMFZaLwnP+FfIiV3sj2/qZgnnZMi6eCCj34Sj
         S6QF8xqaYXY5dSL5YN1p0c2iYr4b9Rq7PHF8sHMfl9/7iKoZgAWlyBImMZ08RdkxVWY+
         cyeC/NM/mm6/DqJXbZqNtPtIS6nvPkMVePuosFpBgGnUYogVjqvkrGPi43xqB28SybNv
         kTMg==
X-Forwarded-Encrypted: i=1; AHgh+Rq5jckfx+ogCvTV4+AJbu0mDu4oW+f7Pk6/W6PDJTyWdZfYNVdRhHz2MlktgmfrXLE7Fgs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLnYaAPadOfJNoMiTJfcL37nJc/pZ6MzAfaWeSw6vTLnkLynwq
	zelOnILllZ4Wir1FrGiStCsKSsD95FpwUx3QnNb0llQpzWZd6TenE2G6
X-Gm-Gg: AfdE7ckOEqfC0eevtvEXQvs+I5EPufpy/q5ZL/K1bc+XAhuSyrEcra+Va+gXjVC5Xhd
	T11FV5stH3K2rnJ9UUT8jh0aVhgqgrjRQ4j4jlVTd1x+oiS4LLE9dKoy4r6yWjXVT+1fbI6sR6K
	y/YszwUmXaCTTGpDK9hnEo48rMDVWOEQzerS32WFjEG/VJMW+ScK1gZUzhLm3zc1BKExoIxZyde
	uTZfRGnl4Kozafnu6HGCvUH5HuYEGFMrsTPQCDjJgHw6jOvTmiBMCwvU9WfHJvX+PTi25gr1Za5
	igpmD6P42T/+d6YH36i3jgaoMHEbtEMP5qJwl8RqfPUG6uLh+jIoDYwWZnEvVWL+u3OOXmVdgE3
	NorIKjL4cqle+onusS8mZFKvnIorDY0MnbYqOPMKp2r9GSm19xx9n9xwRLPC1qYbS3hMw1e2lfH
	B5rORGVfOxLCh9tWartpgYJJvztXMwENMGQ3TYGMP9c5cUGrWWjV1Y
X-Received: by 2002:a05:6a00:b91:b0:845:18b6:1154 with SMTP id d2e1a72fcca58-845a26dbe62mr6320351b3a.8.1782336087351;
        Wed, 24 Jun 2026 14:21:27 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845a3fcc7f0sm3003897b3a.2.2026.06.24.14.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 14:21:27 -0700 (PDT)
Message-ID: <1f2823d22e0877738ee3e562b792cdd56de3426c.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 07/17] bpf: Track verifier context
 diagnostic events
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Date: Wed, 24 Jun 2026 14:21:19 -0700
In-Reply-To: <20260619205934.1312876-8-memxor@gmail.com>
References: <20260619205934.1312876-1-memxor@gmail.com>
	 <20260619205934.1312876-8-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-06-19 at 22:59 +0200, Kumar Kartikeya Dwivedi wrote:
> Record verifier context transitions in the diagnostic history so later re=
ports
> can anchor causal paths to the critical section that made an operation in=
valid.
>=20
> This covers lock, IRQ, RCU, and preempt regions without adding any new
> verifier error reports. Category-specific commits decide where those reco=
rded
> events should be rendered.
>=20
> Use context depth when selecting scoped history so nested regions anchor =
at the
> outer active region, and fall back to the earliest retained event when th=
e
> matching entry was pruned.
>=20
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

>  kernel/bpf/diagnostics.c | 85 +++++++++++++++++++++++++++++++++++++++-
>  kernel/bpf/diagnostics.h | 20 ++++++++++
>  kernel/bpf/verifier.c    | 35 ++++++++++++++---
>  3 files changed, 133 insertions(+), 7 deletions(-)
>=20
> diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
> index 58cc7c18cf98..d6a9a2315f54 100644
> --- a/kernel/bpf/diagnostics.c
> +++ b/kernel/bpf/diagnostics.c
> @@ -1041,6 +1041,53 @@ void bpf_diag_record_ref_release(struct bpf_verifi=
er_env *env, u32 insn_idx,
>  			    ref_id);
>  }
> =20
> +void bpf_diag_record_context(struct bpf_verifier_env *env, u32 insn_idx,
> +			     enum bpf_diag_context_kind ctx_kind, bool enter,
> +			     u32 depth)
> +{
> +	/* Keep leave events so context rendering can stop at a depth-zero exit
> +	 * and show nested-region depth accurately for the active path.
> +	 */
> +	struct bpf_diag_history_event event =3D {
> +		.insn_idx =3D insn_idx,
> +		.kind =3D BPF_DIAG_HISTORY_CONTEXT,
> +		.ctx.kind =3D ctx_kind,
> +		.ctx.enter =3D enter,
> +		.ctx.depth =3D depth,
> +	};
> +
> +	if (ctx_kind =3D=3D BPF_DIAG_CONTEXT_NONE)
> +		return;

Nit: Is the NONE case really necessary?
     The constructor is never called with NONE.

> +
> +	bpf_diag_append_history(env, &event);
> +}
> +

Nit: maybe drop a comment here:

    /* search for the most recent outermost context entry or an exit w/o th=
e context */

> +static int bpf_diag_history_context_start_idx(const struct bpf_diag_log =
*log,
> +					      const struct bpf_diag_history_opts *opts)
> +{
> +	int i;
> +
> +	if (!opts->ctx_depth)
> +		return 0;
> +
> +	for (i =3D log->cnt; i > 0; i--) {
> +		const struct bpf_diag_history_event *event;
> +
> +		event =3D bpf_diag_history_event(log, i - 1);
> +
> +		if (event->kind !=3D BPF_DIAG_HISTORY_CONTEXT ||
> +		    event->ctx.kind !=3D opts->ctx_kind)
> +			continue;
> +
> +		if (event->ctx.enter && event->ctx.depth =3D=3D 1)
> +			return i - 1;
> +		if (!event->ctx.enter && event->ctx.depth =3D=3D 0)
> +			return 0;
> +	}
> +
> +	return 0;
> +}

[...]
