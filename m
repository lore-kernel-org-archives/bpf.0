Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C45A3446AD
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 18:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786646755; cv=none; b=o4bctw8y20laAHLZmjWyWr5oXZKADobPLLcwN2Pdm+s1sCZEPjoJL+RqhQLxZK+VBZ/feXOJ2Wm4azwInPcFyVilHKVwhqsour6q8nNK1PgW76HZeMoAOXF2ihNdef0VJvdSCpQV6lPIxO6jh52RF+VKd6pc8hkoM7dNQq/X2ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786646755; c=relaxed/simple;
	bh=tBzZ10gYUzreXqwVSmgT+rCru0vFjnjGpLTOciO3++E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pIxWxPNTTCf+tVP6WDuxth4FefQjm9ahDcNjLxvMFu2lj8Prjb04MSgb60Q2BNtSu2COz0D3kuTaPpz8+09/UYFKCi7knMAYBVwcb8YUjlqDvsX9Mi2afzhjxMfMT+/FJ7kH8cbr6JWyc6lbkzDkOQawvOwWGgDMCMHJn688E9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pZk1X3+H; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pZk1X3+H"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38fdeaed181so227527a91.1
        for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 11:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786646753; x=1787251553; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=aXAuXllSqTfLGdH+16Exw28ufPwRrrrs+tMosWCyHTk=;
        b=pZk1X3+HsmExeRwyTtOJNsOGWgKaYX76GGGKwmRAhdFrAYTYRHAw6uyE9wK2hkPSpc
         z9eKG8d1Fe/7CekrSXY20FDvAj+mKY4pCvwgBqn3OLzkYjxlMjgFRWoX9pkeNmsWHbP2
         YuSAEeGOkdb7yK3kLh0S8AcDSbPnmN67Q/oDrT7E9gTBEYW8hQtAhN/EIyCOyNUGvs+S
         cxVyfxGeRCGN9b9e1c98Ltw7a/5Bo/H07swNZ69GbNclul31kvZ+OTnNQoWT0Ae8SHW8
         e0zQsr4AG0zi75A4qgWPOtfC0xnfQuCRcuOFdezsWPWBnes4xAm/rU0pOhKFeItn6B1M
         Lyzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786646753; x=1787251553;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aXAuXllSqTfLGdH+16Exw28ufPwRrrrs+tMosWCyHTk=;
        b=JqOByi80CcKpLTijrt/adtjlzsXx6g2qxOwOCeoj7WM4gBn0bTtYGmzZx+/rQfl++S
         PhE+IykWB4UbOXZ4D1OuvU4qiUFRD72QXJzxglDrxki663TUS8b2q2ETf86nyfmZGjFo
         5YVp9SYX8h8wBSwRcIcPDw11cDn4TucGGhf1P2gs5xczhBxQUAhALNnCm64Sua6zBJQ8
         YE584E7E4mBoZvFw8V5m9wRt5AmtRWttKlyoZk0B85HVnOfJ+jFXDXaSIX6VkvpOhU7s
         s0Qaj5OVA/6gSH7oJta9FXcLSyil1Dqn1SFSm3BKy7Nunr5kiB/xP6o2tiaXyJ0m98v4
         GQBA==
X-Forwarded-Encrypted: i=1; AHgh+RpSct9xPnwoWXQpaVAGsjqFWvRSnhxYccq+dmuW5MdIFA/xytE0hFXjYJDf+1Ub5tWdrrA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxevuwltOxu9HjJY+hwPX/tJ9QpH2Ur4VGVvSJHFYj9bavm6YPD
	Sa+OwrpyrAEjpq2OGQfZ0lTrFeuLVmWH+6/vYowQ8xAB4dOrSWpejIyA
X-Gm-Gg: AR+sD10WeCBEG3rZa6w7twmH5xaLcWUZlRzX1qnJhMgjw2EXuUjkJPJU3dhBZL+/2hI
	T9pF5MyUb5xoxH6AMUBnt2qeMDxyaC5OMYD3FtIn5M2PEOneCOw7Qw1QPSsBLxzwhqAoD2YJRi8
	1DKUHu5Nx9395EOjhtj5e7hsaY9D0gkFYgOgvZek/n7SywntZ14yzx8IcDt6KrTbU4RZI108CVE
	C+VRaLPNzVGu11Jo0rZ3436sI+hX1npiGCbMDWwNuzzoH6Z/A6fCZbMcDA/fx4db/fcrLZWSDCe
	xfJGHw14A7xYIRvrlHQ7QIwJgRM/1J0Wuv90ThqeoVppo1kcSmE9TueEfAzh0CgxxS1yc7gzOiH
	LyP8hC2bDfKy1tXplaA+0R1tpmU+Y0RmKI9a5R+z2NoODWE/Ek30YepwTGtEirQdKw5Xwe0n4Qo
	PZWLb/Olg4Fz9+M6axkit2f0ntiL+H6jaUDOZimIMqf8jK5k27PnuuqN38o9rHrjzJSV13KCo5r
	BF7Wx/f9tGlr/eBnW8KjP4Raha7L212XgTfU5XRYT6sRQ==
X-Received: by 2002:a17:90b:384b:b0:37f:e1af:df22 with SMTP id 98e67ed59e1d1-3933ba90e38mr17348a91.17.1786646753421;
        Thu, 13 Aug 2026 11:45:53 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:2cae:4c28:2903:b6f9? ([2620:10d:c090:500::7:1c5e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31ebcb69807sm10322623eec.10.2026.08.13.11.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 11:45:53 -0700 (PDT)
Message-ID: <e8a0bfca49b6a2c733433c2d1b3852eeabb845ea.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 03/16] bpf: Add verifier diagnostic event log
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Date: Thu, 13 Aug 2026 11:45:51 -0700
In-Reply-To: <20260812233326.3575958-4-memxor@gmail.com>
References: <20260812233326.3575958-1-memxor@gmail.com>
		 <20260812233326.3575958-4-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-08-13 at 01:33 +0200, Kumar Kartikeya Dwivedi wrote:

...

>  kernel/bpf/diagnostics.c | 108 +++++++++++++++++++++++++++++++++++++++
>  kernel/bpf/diagnostics.h |   3 ++
>  kernel/bpf/verifier.c    |  21 ++++++++
>  3 files changed, 132 insertions(+)
>=20
> diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
> index 77dcffb9adee..0e0aa3a7106c 100644
> --- a/kernel/bpf/diagnostics.c
> +++ b/kernel/bpf/diagnostics.c
> @@ -34,8 +34,24 @@
>  #define BPF_DIAG_REG_TMP_LEN 192
>  #define BPF_DIAG_FMT_CHUNK_SIZE 1024
>  #define BPF_DIAG_FMT_BUF_SIZE 256
> +#define BPF_DIAG_EVENT_LOG_MAX_SIZE (1U << 20)

Q: did you observe the drops in practice?
   I'm curious what would be a practical limit here.
   As it stands the events buffer is 7K entries, seem to be low.

...

> +void bpf_diag_event_log_reset(struct bpf_verifier_env *env, u32 pos)
> +{
> +	struct bpf_diag *diag =3D env->diag;
> +	struct bpf_diag_log *log;
> +	u32 end;
> +
> +	if (!diag)
> +		return;
> +
> +	log =3D &diag->log;
> +	end =3D log->cnt;
> +	if (WARN_ON_ONCE(pos > end))
> +		pos =3D end;
> +
> +	log->cnt =3D pos;

Should this reset 'dropped' as well? 'capped'?
If not, do we need an exact count for 'dropped'?

> +}
> +

...
