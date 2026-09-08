Received: from mail-wr2-f9.google.com (mail-wr2-f9.google.com [74.125.225.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E465111B8
	for <bpf@vger.kernel.org>; Tue,  8 Sep 2026 10:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788863050; cv=none; b=Hl6b+zbHq/oP+1sb/S6xY/P4GC+y1vjIjxIKkEOli5yb1gSRJJSedHQxTpAlF01knr8ns8zV8bNdXnDoa8/rMTkos4wYXNXSTkbdA2lKVl7S6Z6U88qUTvV2O+CUW+AQsyH9kuKDhx+K0M2H0UzxUDywU/eDigRTM6XZF4xPGzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788863050; c=relaxed/simple;
	bh=7QsWDOvRIVcKWQN6AjiUMToSowjA3/ius6pXM5piGjU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=dQywxaDqavXDBVkUMS6u/oEMGbPf74dGnKUwmsC5hC0PFNXFFKa5MS+Npx2c6TAaXS91Qlhitrr5O3Hpbsc5QgsCR8Qp6DokIjXsHZLJEe4UppRHQagmT5xT5lgi4UqupWp5lH80yr3XI8MVriPHWbBANxu8LXjw6wrTpGJKtjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HKYiLaKk; arc=none smtp.client-ip=74.125.225.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HKYiLaKk"
Received: by mail-wr2-f9.google.com with SMTP id ffacd0b85a97d-485850cf4deso1950791f8f.1
        for <bpf@vger.kernel.org>; Tue, 08 Sep 2026 03:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788863047; x=1789467847; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GN5oe+Yb7QbWSaMIabzdcqrqYrF+b3TvzNzha4X/Tls=;
        b=HKYiLaKkmCOS2yriyMLsD+7wVJY7qw7N3N/Y4FhL9Tntyk5VmVPpT9wICDSCv/6j7l
         auVC5QqNyGMWD9Q/ZjQ0NaNUn+AuQHs/Sud1tjJT1soI+WPDjx9fQiE/ZXHdgZOlSd3K
         YbuEdsi/03zLucTr25K6KGrSroLigCxz3ew0lNLGb9toyNYOFYiDJcdYFUqT84GP+HCT
         pjkJVQ/F0uwxFubh8UZBidEbmu7TRuuIRO3wGZ4qQu7P5v/mMBTICkX9sfdFpoqLb8GQ
         HMAyBCVcdICKo6aWGWW7C2ULUxBHbhJpDT+eC7hc7RPVRFk85z3Ax9BWWHKkrDjnIQqM
         Ss+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788863047; x=1789467847;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GN5oe+Yb7QbWSaMIabzdcqrqYrF+b3TvzNzha4X/Tls=;
        b=IkrnNfDn2wXHUX646BeJ3Pbu22ymNM/tZmbLMjC+UnC/NmYMA32boRQ2eyIpXt5Q8M
         wryf/MZU8riRoOUV2AgP2i3EjnkLIKOaWew5RjXc8tTGuX2EWkMQyK95tkv2CtxY1C+G
         t4TUr3qF/rPJ0EDC9s63kPXUAKdx5v6buzXQvkYCDWYSqx/k53ZelUNRw38KdLIxwywt
         H9ush/pa0MF+Z0ZYhqhjHhQwSjdgz+rPJyEXScbfu310sB3A3tUQ2otbBPaILFeiLB8C
         5M0rXoxXT72zfL86hYhctCGwtsqyCqHLW4DOPYAZxaZ27isVKY6HkewaMQUUgRITGmde
         +D/Q==
X-Forwarded-Encrypted: i=1; AKwUvBzwEJLng+2CP663GdXWY3FIzz9zaqe88/xMyCwlXTx3eXx01Y95YIo8Vv7hWFxSz/S3u5A=@vger.kernel.org
X-Gm-Message-State: AFuF++mvjv/aI2/i+Z9pzmVB4SOqEeC29i5BebFb6wz8JfZDrgnKizKx
	rjBwKQoEaxdl1lxlHukmrJAr/ijXHTMFjW2SynCPwzxwba43Mzkbjwnb
X-Gm-Gg: AYBFou31LVpvNleVYx1vAlHI6uuOmS6jpGLwPA2m4Qpthx/q7gaK6oEuZpGwKCBKPuc
	DsPQa/aNfa3OYJDLOjPf08Z8MDYjJciLJfm9fftdi/OdJTMxApzUKcIO5jZTHjTjJnk58N7S971
	6lhJOGo0o/O5JAGO7C7lGnXiDG3uSwuGM3aAoaa0nmL4ch0wklPvQwjkfB7YXXv9yf9SRVaZX3y
	vMB5Zfl4huiNtlj5p3rBGL39PhQSZtlyTzK+ToZjTOinqpxBl2L2UEwYcfeMKxyl4PzIk1h8rbp
	aEZzP3kNHm5b7iFlRZkaEk7ezsetBzbAO/o7Vtg05k33KQwQthe9TZXjsu2I/rDrTQSPfVd19Ze
	CSCTJwfbW1/Z3K0FABZV4xAqgzy77F0ogX0rXPm5AP1MYpztrBvwpIneA04P5prP7xgKu2aH39B
	zETd76MH/5r823thAWWvmSUp4zPxu/wyUxJWEn3f1wkw6ONXWsdc3sLaRV+VkCA1Gmlk5tpTOrf
	m8lheRUnHW4wKiAEmA3yjFvG9itDpk2blZhIxfnDR0sbr6G9+xmfiV/xZvp4TAGRbzSbxUdhScM
	Rt0lpyNo1Ps5e6TkVKW/mdiSRT4=
X-Received: by 2002:a5d:5f51:0:b0:485:8a46:704b with SMTP id ffacd0b85a97d-4858a467215mr25183611f8f.29.1788863046836;
        Tue, 08 Sep 2026 03:24:06 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4859207c28fsm29714859f8f.5.2026.09.08.03.24.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2026 03:24:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 08 Sep 2026 12:24:05 +0200
Message-Id: <DL9V0Y6BPZSY.3J1EXVDXSHRFO@gmail.com>
Cc: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-mm@kvack.org>, <david@kernel.org>, <akpm@linux-foundation.org>,
 <andrii@kernel.org>, <ast@kernel.org>, <brauner@kernel.org>,
 <daniel@iogearbox.net>, <eddyz87@gmail.com>, <kpsingh@kernel.org>,
 <ljs@kernel.org>, <matt@bobrowski.net>, <song@kernel.org>,
 <sun.jian.kdev@gmail.com>, <utilityemal77@gmail.com>,
 <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH bpf-next v5 4/7] bpf: Allow reads through
 trusted-or-null BTF pointers
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Anastasios Papagiannis" <tasos.papagiannnis@gmail.com>,
 <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260907165220.52431-1-tasos.papagiannnis@gmail.com>
 <20260907165220.52431-5-tasos.papagiannnis@gmail.com>
In-Reply-To: <20260907165220.52431-5-tasos.papagiannnis@gmail.com>

On Mon Sep 7, 2026 at 6:52 PM CEST, Anastasios Papagiannis wrote:
> Currently, a trusted-or-null pointer
> (i.e. PTR_TO_BTF_ID|PTR_TRUSTED|PTR_MAYBE_NULL) has to be checked
> for NULL before it can be dereferenced. Marking a field from
> PTR_TO_BTF_ID typing to trusted-or-null can reject programs that
> previously dereferenced the pointer directly. This is useful as we
> need to mark new fields as trusted in order to pass those as arguments
> to kfuncs.
>
> Allow reads through pointers marked as
> PTR_TO_BTF_ID|PTR_TRUSTED|PTR_MAYBE_NULL without an explicit NULL
> check. Treat these pointers as potentially faulting so the reads happen
> through BPF_PROBE_MEM. If a read produces another BTF pointer, clear its
> trusted flags and mark it as PTR_UNTRUSTED.
>
> This applies only to reads. Other cases still require an explicit NULL
> check. After such a check, the pointer retains PTR_TRUSTED and can be
> used normally.
>
> The unchecked read path has two consequences:
>
> 1. It uses BPF_PROBE_MEM, which is slower than a normal load. An
>    explicit NULL check refines the pointer to PTR_TRUSTED and allows a
>    normal load.
>
> 2. A faulting read returns zero, which is indistinguishable from a
>    legitimately zero-valued field. Programs that need to distinguish
>    those cases must check the pointer before reading the field.
>
> The next patch updates current tests and also introduces more checks to
> ensure this change does not break anything.

We tried doing this before in
https://lore.kernel.org/bpf/20241104171959.2938862-2-memxor@gmail.com and i=
t
got reverted, it broke all sorts of things and made everything more complex=
.

I would drop this hack and just fix the program. Given your earlier change =
to
annotate the field correctly, I am puzzled why you added this, and there is=
n't
any description anywhere explaining why.

Anyway, regardless of the reason, it's a bad idea and shouldn't be done. At=
 some
point we will also tighten conditions around normal PTR_TO_BTF_ID and only =
allow
trusted pointers everywhere.

pw-bot: cr

>
> Signed-off-by: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
> ---
>  include/linux/bpf_verifier.h |  9 ++++++++-
>  kernel/bpf/verifier.c        | 12 +++++++++++-
>  2 files changed, 19 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 9727df5af83a..4f032ad83c67 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -1339,6 +1339,11 @@ static inline bool bpf_is_ptr_to_mem_or_btf_id(enu=
m bpf_reg_type type)
>  	}
>  }
>
> +static inline bool bpf_is_trusted_or_null_btf_ptr(enum bpf_reg_type type=
)
> +{
> +	return type =3D=3D (PTR_TO_BTF_ID | PTR_TRUSTED | PTR_MAYBE_NULL);
> +}
> +
>  static inline bool bpf_may_fault_on_deref(enum bpf_reg_type type)
>  {
>  	/*
> @@ -1346,7 +1351,9 @@ static inline bool bpf_may_fault_on_deref(enum bpf_=
reg_type type)
>  	 * protection, that is, the ones bpf_convert_ctx_accesses() has to
>  	 * turn a BPF_LDX into a BPF_PROBE_MEM one for.
>  	 */
> -	return type =3D=3D PTR_TO_BTF_ID || (type_flag(type) & PTR_UNTRUSTED);
> +	return type =3D=3D PTR_TO_BTF_ID ||
> +	       (type_flag(type) & PTR_UNTRUSTED) ||
> +	       bpf_is_trusted_or_null_btf_ptr(type);
>  }
>
>  static inline bool bpf_prog_has_arena_ctx_arg(const struct bpf_prog *pro=
g)
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 9e79750e2480..b5186e664aea 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -6168,6 +6168,15 @@ static int check_ptr_to_btf_access(struct bpf_veri=
fier_env *env,
>  	if (ret !=3D PTR_TO_BTF_ID) {
>  		/* just mark; */
>
> +	} else if (bpf_is_trusted_or_null_btf_ptr(reg->type)) {
> +		/*
> +		 * An unchecked load through a trusted-or-NULL pointer is
> +		 * fault-protected. Any pointer derived from that load must be
> +		 * untrusted, as a fault produces a NULL value.
> +		 */
> +		clear_trusted_flags(&flag);
> +		flag |=3D PTR_UNTRUSTED;
> +
>  	} else if (type_flag(reg->type) & PTR_UNTRUSTED) {
>  		/* If this is an untrusted pointer, all pointers formed by walking it
>  		 * also inherit the untrusted flag.
> @@ -6644,7 +6653,8 @@ static int check_mem_access(struct bpf_verifier_env=
 *env, int insn_idx, struct b
>  		if (!err && t =3D=3D BPF_READ && value_regno >=3D 0)
>  			mark_reg_unknown(env, regs, value_regno);
>  	} else if (base_type(reg->type) =3D=3D PTR_TO_BTF_ID &&
> -		   !type_may_be_null(reg->type)) {
> +		   (!type_may_be_null(reg->type) ||
> +		    (t =3D=3D BPF_READ && bpf_is_trusted_or_null_btf_ptr(reg->type))))=
 {
>  		err =3D check_ptr_to_btf_access(env, regs, reg, argno, off, size, t,
>  					      value_regno);
>  	} else if (reg->type =3D=3D CONST_PTR_TO_MAP) {

