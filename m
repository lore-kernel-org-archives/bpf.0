Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B0D409103
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 19:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780686629; cv=none; b=CqDzwbQl8gwkM3K77+E5W3Tdge30R9C4GF3zheAdPWTVWq+3qBD7+WI5LpsvECs4nWo/tU+J4bcyMgB0JJo4dpToukCJl3W1x0evsLEANtJeGa8PxWyXUXv1cgRYD92ebVVxg4Hvpai4pyBKMJ16zFaOmSxk1BIH+OhleKP6AGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780686629; c=relaxed/simple;
	bh=5Wk3NWnQb1sU4CtbN0pM5LuGtaDQ8/TdFr9oe+7MUps=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dspIKvQkin/K7U/FFHbA9s+ucQDl2NaCoHoKDqJsSIBCD9zB9Y1YWGA6F+oC1ZlnabhNJB21RS0yTuc0mOBH3ZRawLfGHyUDtFPsE82NkM3KqNkveJ+BcjFRJWyp8bfSEaLIIschINWgd/KfCI2i2svL8wAQ5KdUqxCT0+eXyrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WScQ2nuK; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WScQ2nuK"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-307263ad0cbso2931095eec.0
        for <bpf@vger.kernel.org>; Fri, 05 Jun 2026 12:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780686625; x=1781291425; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BQS0s8X4lCcFIIrW0/Qz/6h0owBkfrG58G6skftJW9k=;
        b=WScQ2nuK21OaXymfNJx0xAyFKB/V0CH51iK4LQ4YrBnbRXaTaUxJZ9sX0ZaJqnFLUE
         CCtxc8nMHVBt4oRIAPmMQj6l/HXdbFyKIxNzDRtC0TxS8eXKVHDvgLPNzQGk4NeyD8u6
         +gbaMWDteONzpJ3SNbcOwm0vob6W04oNPlXO+e1vGyE3nWlcnirbjs48cQ8zoLb+HiIs
         /ZvS0+lBvrNwk6UZaAFfhx7ktTjOo9QG2xJHdcXBSiCHJLxZwOQH5WYvHH/42L7XfAM2
         3aRpTvXE/pVWm6A/gTeoJKf3F1YcAOKvzlGKuIjKaQqLWwVFAYX0pWdqndpdatb1Jsgn
         Z/qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780686625; x=1781291425;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BQS0s8X4lCcFIIrW0/Qz/6h0owBkfrG58G6skftJW9k=;
        b=Twa7u6ofJLLQs+FY2G6xAwoc982bAkHLbnPWFdrdFuH5Oh/jNCvW3D/d5w+PUr47M4
         KTu4G1y/G9emYYSlHWASVh0Xfm0/MG8A3y8JrS8sJhooO1v3B2J31Ofb++Q7k4InZgN8
         ySfSFU0GqcePRbnHi0vZlOvjzooKhQ9fktLwq0oH68BfLLJCdRYHsIYaROCZ5zLFczl5
         WypYK6hY3DYjWUGV2QK1WMu/igR0hJqiNMNJdFvIn2/L6DAy3Sg+4i0C9qJicz/U8Irl
         MlDcDoMXzrMNsHHMNMW3WbqFH52ZbPXDE005dt+WNRvXjA1kGu+g9wHaG9KHiZ6isgSm
         Ptpg==
X-Forwarded-Encrypted: i=1; AFNElJ/yOzG8IAfPl20Z5YG26V+j+qI1c4yGIKV5AQ6WsS6ung5wuLuERF0RTbwcPy6Z5sDq62A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLwLPExBvucICaylTYm1MuQfbLf2u7mWKKTqLqKBb8oVYQvrFv
	hf4ROeAEbGXVRSGPK5czy9zNaSuuizHvTTQAYSXdI9x56wiyLwfJo+v5
X-Gm-Gg: Acq92OFdxRUI2XR7JkMf22GXHrnHFnbgT2bKXSlYFlJVvx1oxFQu7G/JC6ZzFG7IsRf
	keKNWXxTSZ43oq31/fLAvUrnqGkVOdHBB5U2is44d6xc+RaDH7xTnJbFVDuQEsBr0EiqwGjfTip
	O9XHzWiRkPWiU9d7h/F+s6FMEurpSvO/uRgopqT+5kAnS1s7Y1zsOUHXLzg256/cYESbzucwC9D
	WsYyXb5ixdBtd3cU4QT4fgAoTb4GnC/AohO+nOZecQKNxZfxMVsMjOpNT4/wy5j1E02dzn01RdU
	kiMjgsYgbLFlTmZnnl81xvllNBT2UagiVgSzO2TjFlAYBA2aGiQE4YNLlBbEPNeUU7nDDz/zyZV
	6RD3s+gTdfc73dhgh7wFMozLOjjD6k/1fBRJ/xAIIOXwODCnLZk3l1jZyqm2/S642tivfTp6K2m
	ecSUk4Fa1mk9Z8ESX2GqCPAffaUClPt7F+VKUs0iGEOtRWspyRs+nKD9f3hJU+DpeKHvhZKQbCA
	QQ1JqDvzuvRY2gi4YTtJ+6b35si
X-Received: by 2002:a05:7300:8cac:b0:304:ab8:f87c with SMTP id 5a478bee46e88-3077af051efmr2985291eec.12.1780686624928;
        Fri, 05 Jun 2026 12:10:24 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:de9b:77c7:f63f:9d5? ([2620:10d:c090:500::1:feb2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074df48671sm8673232eec.24.2026.06.05.12.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 12:10:24 -0700 (PDT)
Message-ID: <280afdb72418cc977341cdc39dd7cc35ab2bd4c3.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 02/17] bpf: Define verifier diagnostic
 categories
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Date: Fri, 05 Jun 2026 12:10:22 -0700
In-Reply-To: <20260605063412.974640-3-memxor@gmail.com>
References: <20260605063412.974640-1-memxor@gmail.com>
	 <20260605063412.974640-3-memxor@gmail.com>
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
> Add a central enum for the verifier diagnostic categories used by structu=
red
> reports. Keeping category names in one renderer helper makes later call
> sites choose a classification explicitly instead of formatting category
> strings locally.
>=20
> This adds no verifier call sites and keeps existing verifier output uncha=
nged.
>=20
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  kernel/bpf/diagnostics.c | 32 +++++++++++++++++++++++++++++---
>  kernel/bpf/diagnostics.h | 15 ++++++++++++++-
>  2 files changed, 43 insertions(+), 4 deletions(-)
>=20
> diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
> index a6684adc0c31..d9a103cf3a16 100644
> --- a/kernel/bpf/diagnostics.c
> +++ b/kernel/bpf/diagnostics.c
> @@ -68,8 +68,34 @@ static void bpf_diag_vprint_indented(struct bpf_verifi=
er_env *env,
>  	bpf_diag_print_wrapped_text(env, buf);
>  }
> =20
> +static const char *bpf_diag_category_name(enum bpf_diag_category categor=
y)
> +{
> +	switch (category) {
> +	case BPF_DIAG_CATEGORY_MEMORY_SAFETY:
> +		return "Memory Safety";
> +	case BPF_DIAG_CATEGORY_REGISTER_TYPE_SAFETY:
> +		return "Register Type Safety";
> +	case BPF_DIAG_CATEGORY_CALL_TYPE_SAFETY:
> +		return "Call Type Safety";
> +	case BPF_DIAG_CATEGORY_RESOURCE_LIFETIME_SAFETY:
> +		return "Resource Lifetime Safety";
> +	case BPF_DIAG_CATEGORY_EXECUTION_CONTEXT_SAFETY:
> +		return "Execution Context Safety";
> +	case BPF_DIAG_CATEGORY_PROGRAM_STRUCTURE:
> +		return "Program Structure";
> +	case BPF_DIAG_CATEGORY_POLICY:
> +		return "Policy";
> +	case BPF_DIAG_CATEGORY_VERIFIER_LIMIT:
> +		return "Verifier Limit";
> +	case BPF_DIAG_CATEGORY_VERIFIER_INTERNAL_ERROR:
> +	default:
> +		return "Verifier Internal Error";
> +	}
> +}

Do we need an enum + name function? Maybe just #define?

  #define BPF_DIAG_CATEGORY_MEMORY_SAFETY "Aaaaa AAAA"

> +
>  void bpf_diag_report_header(struct bpf_verifier_env *env,
> -			    const char *category, const char *problem)
> +			    enum bpf_diag_category category,
> +			    const char *problem)
>  {
>  	char problem_buf[BPF_DIAG_MSG_LEN];
> =20
> @@ -77,8 +103,8 @@ void bpf_diag_report_header(struct bpf_verifier_env *e=
nv,
>  	if (problem_buf[0] >=3D 'a' && problem_buf[0] <=3D 'z')
>  		problem_buf[0] +=3D 'A' - 'a';
> =20
> -	verbose(env, "\nVerification failed: %s: %s\n", category,
> -		problem_buf);
> +	verbose(env, "\nVerification failed: %s: %s\n",
> +		bpf_diag_category_name(category), problem_buf);
>  }
> =20
>  void bpf_diag_report_reason(struct bpf_verifier_env *env, const char *fm=
t, ...)
> diff --git a/kernel/bpf/diagnostics.h b/kernel/bpf/diagnostics.h
> index f13a939722bf..8bfc7104eeec 100644
> --- a/kernel/bpf/diagnostics.h
> +++ b/kernel/bpf/diagnostics.h
> @@ -6,10 +6,23 @@
> =20
>  #include <linux/compiler_attributes.h>
> =20
> +enum bpf_diag_category {
> +	BPF_DIAG_CATEGORY_MEMORY_SAFETY,
> +	BPF_DIAG_CATEGORY_REGISTER_TYPE_SAFETY,
> +	BPF_DIAG_CATEGORY_CALL_TYPE_SAFETY,
> +	BPF_DIAG_CATEGORY_RESOURCE_LIFETIME_SAFETY,
> +	BPF_DIAG_CATEGORY_EXECUTION_CONTEXT_SAFETY,
> +	BPF_DIAG_CATEGORY_PROGRAM_STRUCTURE,
> +	BPF_DIAG_CATEGORY_POLICY,
> +	BPF_DIAG_CATEGORY_VERIFIER_LIMIT,
> +	BPF_DIAG_CATEGORY_VERIFIER_INTERNAL_ERROR,
> +};

Nit: there is no reason to expose this in the header.
     And given that this can be an enum private to diagnostics.c
     BPF_DIAG_CATEGORY_ prefix can be dropped.

> +
>  struct bpf_verifier_env;
> =20
>  void bpf_diag_report_header(struct bpf_verifier_env *env,
> -			    const char *category, const char *problem);
> +			    enum bpf_diag_category category,
> +			    const char *problem);
>  void bpf_diag_report_reason(struct bpf_verifier_env *env, const char *fm=
t, ...)
>  	__printf(2, 3);
>  void bpf_diag_report_section(struct bpf_verifier_env *env, const char *t=
itle);
