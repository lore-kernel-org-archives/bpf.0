Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87542DC78C
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 06:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769494019; cv=pass; b=HyebYAkJrnmnPogEruj/epj8Iu00dt/CnSUjGRcULX0pDIQ4rO3+8qpAJtGE4PEsVdn7tmDBHjEZVfkzExF0cTLO13Ym9g1z/UOw4URYFejbjaez+PilsgOaJErcn3jEMyYrxIN0nE4Qmeaa0oGBFiEV4z+LnTb/f/46zgjRFM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769494019; c=relaxed/simple;
	bh=RYHk+YfzCONL5++WYOMEIJZvZU6vl2ApeArHBEVOj8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=odRFehfgpIAQIPtDyx50vqtTnCVYaRAh+c2Q8ffZSHQO2SrGLADJCw2eXHoQH/AeTSxx8HkwDbouLIoYG9pAMCJf2J22Q9e9qdZ32XaZ70DsgWLznm/eZMOc1AmKweuHAclgSdsxrSo7vUQdIbcx6jBwE6KVmcmkKdQPACBbYGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RbaOSsrC; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RbaOSsrC"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7947072d0f6so10110827b3.1
        for <bpf@vger.kernel.org>; Mon, 26 Jan 2026 22:06:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769494017; cv=none;
        d=google.com; s=arc-20240605;
        b=IvTmWc2Qn1wwzGfhu27PwjcmAGMCdxJO37IAPaoTKu7EKrNZGlRtN5hS9TCCWeIY4P
         we4k8TvAUALxKat9aKiYMfTqm7zMU7iUd+4JqC8Xusb8Rmhh1oLZmR+nfrpx66yiktx8
         1i22REN1xZaLJSEWTor23uW+hdCEQm2RHxQwWGBscV3DAs0eaOwmb8B0+4c0QsKLwus9
         aCoy5MWpWJxJ6WJSvo4y+Wu0+e4Ii2KhTOKFX48eoMx5tAq/LpNg2DcOnP/0W1mtR9jb
         MIymk/LArDYQ6v7T+r9TWHkjV/QaDTEj8e2pCGMy2ASZBVa+mXt/u91j/YgMRjAkUJgG
         H/rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bJWAZY6LKfo7RbXkh5+gjEfMAbkq0ijn5lP4/KwobQ8=;
        fh=AfLu3hU0uPp0xms6RcH3hSwVEX3OGNBRzNt0qrmzFnU=;
        b=dLzd04DI25w/m+neMwEoRgjURFAHjjcBowNh67xupnMlFkaFpMKJQF7MUoPIbbcqS1
         4ACgg8n1bjEOSQAlk0FBRhu7UfhBvEWsB7YsmdrgOBPsPkw3KZt4o393zN7aNHlZV4RL
         dDoGPreAz1s26gIeV0H1KyJEM9qIOcTR9Dq+STzrjhghs/oLFh+W439ZQY3jnx1wHJ4d
         9WevxiX4rjPMnJCbNwbzwGC34O4H+lnrZIll9uW5DGDfz0T+Gf0xSr+YQJUw7l+hSSJx
         ZRqFei3qQOeEeZwG23E/fHqUEpYf4e4C0+FpFg8LTz5R+0nsGM1/q6MhXcbElweYQ/LE
         8f3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769494017; x=1770098817; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bJWAZY6LKfo7RbXkh5+gjEfMAbkq0ijn5lP4/KwobQ8=;
        b=RbaOSsrChU8DRNfyFy9O8WPl1jo3oQXWYs9UD/G7BuY5F1myVbBQPrZA8uMAhl1siV
         ggb27e/GzFIT4B4jNxhcc9XzoPAFhZ5cfMHpa+j3ettYSOOsQ8SZtx0gp9tDsVCVR9Ba
         AS0eBxcaApqGzGHXGNRMU45fYjp+x+hOX3p/apZHJfZEOHX4ESMrWl0S5uKlFfqMFxXc
         PCJ2wPIWQZKq+k3AYr1CvyN7g52z0wW4m15nt4hU5Akvxw5DzOuuRhTO2ekpkNVEFQ/4
         L0Oc8tTK/ouRDJd8392oxr29MePnQIFAKA+OYgbdE/VebFcWMZRsCSfYWcHSNglkjVr1
         SCpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769494017; x=1770098817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bJWAZY6LKfo7RbXkh5+gjEfMAbkq0ijn5lP4/KwobQ8=;
        b=RAWOVYbTaUhLsLUq7zn8Zv3x6k9mLRLoultLiC2jKzrfXKZb2I9Qoxlx3+jHxLcd/P
         GhjrwUgKPrL9y+RDiblFyHRg0fhjRu86Dme7SNcdvhq44m9kxpu2uEm2fibYuSEb0eyp
         1wl+foqKyvBetw/wli2BvBnUaoSl3LX2HLuzv4y1e3CdMKy5ZO7JEB0DWOyorNmJy2VU
         ciJfCG/yf1hEZCdV2BK+wC7qqymJyrhmseuoZOwsEl70TQf3dRzSlV5bYIzE+QdLrUVJ
         B+ndWvwbJIvB0gMo57qiPlCjWIDMkNNIpRcTcndxr5XeODgrohUMwRH3SHlskUufQmv2
         nquQ==
X-Gm-Message-State: AOJu0Ywfo4L1IAdcYZuvpKdADtqq+CMcIwvxMswM0i7bQDaXpYchW/CW
	pvxVxge4xU+hEm35Rc0zM6q/FtZGs+3n0nMcY90LDi1/7uhHdRBL3KrGbz3a/NwrbZ2XkgG6rPQ
	GGao71PYvQPDAljNLPhsomPPWBUmPg6U=
X-Gm-Gg: AZuq6aKyFpvXjnmeA4xVikAs162ta8nb0LICiAd4p8IAcTlJY2MZQkZ+pJbamrNofhE
	o9yUnY1E4NR60hsPUQ+g/WAz7nvFSVS//6R7vZbb3S4oSTqQMSmG1s9cWrSNSXMGHzpWo8YeL7s
	+EOiJdm4WZESBFejPoFSeO/Is2qgtqpi2OZgBxbNnqpNuYqinagcddTW2B/pLwKpSoxhDVZbpWC
	tDoMcx/jdBjNZbMM8CKRY+FJQo2s4iZHcS+A38xlcRmIsHfmDJofYG3q/oXOR3+fZGns7ip
X-Received: by 2002:a05:690c:6b03:b0:794:baf:3fab with SMTP id
 00721157ae682-7947acac299mr3946817b3.68.1769494016915; Mon, 26 Jan 2026
 22:06:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260127024421.494929-1-roman.gushchin@linux.dev> <20260127024421.494929-6-roman.gushchin@linux.dev>
In-Reply-To: <20260127024421.494929-6-roman.gushchin@linux.dev>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 27 Jan 2026 14:06:20 +0800
X-Gm-Features: AZwV_Qj0tcw7ghLMqT45W5nW3bVQqI4tEqlqFj0ly-h4dN4f18uzS8wj7Qlnsj0
Message-ID: <CALOAHbBLEqqs3iP=QFCs7BMX-YZXu6p+D-vmQg12S2Kyq12Frw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 05/17] bpf: mark struct oom_control's memcg
 field as TRUSTED_OR_NULL
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: bpf@vger.kernel.org, Michal Hocko <mhocko@suse.com>, 
	Alexei Starovoitov <ast@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, JP Kobryn <inwardvessel@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Suren Baghdasaryan <surenb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 27, 2026 at 10:49=E2=80=AFAM Roman Gushchin
<roman.gushchin@linux.dev> wrote:
>
> Struct oom_control is used to describe the OOM context.
> It's memcg field defines the scope of OOM: it's NULL for global
> OOMs and a valid memcg pointer for memcg-scoped OOMs.
> Teach bpf verifier to recognize it as trusted or NULL pointer.
> It will provide the bpf OOM handler a trusted memcg pointer,
> which for example is required for iterating the memcg's subtree.
>
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Acked-by: Yafang Shao <laoar.shao@gmail.com>

> ---
>  kernel/bpf/verifier.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index c2f2650db9fd..cca36edb460d 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -7242,6 +7242,10 @@ BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct vm_area_struc=
t) {
>         struct file *vm_file;
>  };
>
> +BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct oom_control) {
> +       struct mem_cgroup *memcg;
> +};
> +
>  static bool type_is_rcu(struct bpf_verifier_env *env,
>                         struct bpf_reg_state *reg,
>                         const char *field_name, u32 btf_id)
> @@ -7284,6 +7288,7 @@ static bool type_is_trusted_or_null(struct bpf_veri=
fier_env *env,
>         BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct socket));
>         BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct dentry));
>         BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct vm_area_struct=
));
> +       BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct oom_control));
>
>         return btf_nested_type_is_trusted(&env->log, reg, field_name, btf=
_id,
>                                           "__safe_trusted_or_null");
> --
> 2.52.0
>
>


--=20
Regards
Yafang
