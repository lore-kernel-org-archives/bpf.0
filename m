Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7261A238F
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 00:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788566838; cv=pass; b=n8Etp3bqsBJQvv7JYjUpLrTvNR11xYMOJ8rRTMYMnMHviZESt7OA/K/480GRt02cfUPU5ZLCooMGrTDqDpZAfFgaxkqzdbkih55HbTinaoqOJynPXx53gFFv0KZPwZKdg0weqgdlb4Pg+CjI50NDuEYrqu4xzi1e6acQbUnPDpM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788566838; c=relaxed/simple;
	bh=6invxGq45BfjlUUrgPrcmaU+Va2qzk3Qq7Se2XD8ceE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SvNJpKwMAkZCI6gD0HVq6tgGIOG8uWu0t2kOOF+IDUVBVth+eEox1f5hF2/MN5ngMiCm6RaVaD3iiJH+DJeQP2VXLpEY9ude6bhrWj+KJCXGzDDRttxDgcd+N5O4rd2f7JKB09nkKkH/X/tbYLHeQ7HzkmwgMMxVOEI7Sv/TpQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=owPd5DT0; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="owPd5DT0"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-66fc2844f0eso1162262d50.1
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 17:07:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788566836; cv=none;
        d=google.com; s=arc-20260327;
        b=GHV9kNCZNlv8YSikFXgYtqTJdQFeQ080ryS1ViZYxGXm5TUnpqji0bSCQ9JKaEgO7C
         AIb+vxPO6t/qtB13O+1oH34powYbbIf5BBwOUQSuRo79gzcXlCUr6El00KiTk4gb1MhY
         dH/L2flHYMv9LCt2I68AxliLky+fQiedm1sTsL+Fi7QuZ3tiW7eKOy87TaNvDTi8bVuK
         EIlNSAQt/htOscbEccUjCSve/ml9Bxposhgymk24h3wAW+M3RG8wBcW4vAMaIhhBJuHL
         AtI0J72pLf2EAt3hGBjGjtJ9aIuAIJTRl5nm4DsVsByJsTY3Wzcjxh892GCYpA8OyBNN
         mUBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3ei9uO3GSaCXYN7d6SFTWTyT25jHIYnylKB63RpHXgQ=;
        fh=U61XmCnmm56/j9zNjXfBYuXT86lDe/l5HYZOCOe5uhM=;
        b=B78E/PXh5DqgO1aLVMmZLJ0YlpnUpIto9h1vlUqeQxyRcB+GeS+dmCfpDWLXtIfgIp
         P0VmIuHOG/fMBHSyFh9OalUP0hon89gyoqsGg4ryPC8lt+6E0tZHR0P0SpeZWhFX/Ydx
         b1LZSVJQiDjfcm4qEddu1v2a+9MgIRLJ/rAk/AI8dm2F030RUxdTvXp4OjPl6f8r5Kxj
         GeKMmsTryPiWiwT/QjT0fLBTCY0i0ynqIKZSkx9bXuqY7LGduPZGsC3jR667UIGhHmSL
         X3QWkrK1YwU/PPkayjnG7jO2etFPFqUPJNPCyidZIdCN89N0/tcLLLNbfx1SEf/vYKzD
         Q2gQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1788566836; x=1789171636; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3ei9uO3GSaCXYN7d6SFTWTyT25jHIYnylKB63RpHXgQ=;
        b=owPd5DT0Q0ZfqWBJ1d/cMQYkpkPzNEYiGhz++L9cO9cXDHesltWLZD16RZdMTfb8Sk
         jfwjEbQbwGNn7f4qVw9GfCNgKT/Scduzsc+/EuJB4csPHVpvEW0rOMtJNvcUPYinbHKw
         4wfkOq2zo/Xbdo4Lg93ciRgVJQpZUkeTWCSh9J8nSN+iiBApyULcAoslUuACK6+3Bv5P
         J8ecEDIGMQHJ74wtHP1fZH/Wxe/8IXpYMxUECv8o0hZ/DOmbQO6syoSLOF7Bao0nQbxt
         giUFsmGiJFuqTt/IyqTjON6goLYLp3ykINr2fHb3aEaVxIZ8EziDYs/0/LRt5tGIz/Bw
         LC+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788566836; x=1789171636;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3ei9uO3GSaCXYN7d6SFTWTyT25jHIYnylKB63RpHXgQ=;
        b=ASaWR1Q76Q8rhXlnkJLfaUKEDguMMWgHNmg0Z8BltbAfJyRNysr34fnSpv3420Z10z
         n0CT1Iae1WBRYNRt38LI42X5BLj49VIAJixS05DbAmagf/Gu7hFdoIcg3vHS+57zXPz7
         i3EJ7ehOGOip7xYjnXWgOpL9KNZvPnU5fVjj4lcf9XKtpdBc1OYvVzFWsDA8GXl7WAmD
         G4ZJzcBnJZ6KIlK2aeFd4+VSbuLshrNbGTZqc4eix2qHA/mawx5T8mmbwUjiTYVNuGij
         HlNLPhd6/lxZfGzDEcL1XSMkbWoo72jRFCnj3WY9XX9HIpjH/UaBpOhqXs6AtuIoWjk7
         l2Mw==
X-Gm-Message-State: AFuF++lIkXn6DEWC8RiXx382J1aDwXVACtV9C45zG6eD+PUwEFJ4LpVs
	VZnptBF3y/fHkYYd6bFVzQmwpqGvTdc3H9KaLKyqBsdQJVqCG/oNJmZlUukhFbd6PrwgtBJMHWz
	8Muobx344tL2EHrvwcF+0HeFeTgrH9c1Bkh+rSoHyzA==
X-Gm-Gg: AYBFou3RLmZTuTy2gUKOgFa7o+cDqnWANinwW++jCpNdOT8LtiKTN9wbR3Nh0hvWgkG
	Awlt1STE9S0+dgLVgwMNy7gRHmXSfQ+MfZ8kEb4wZlVzvuJOTJgujTKH7HW7i0HIb2GaqhIuGem
	FDFi+JLrlD1czGZl9beQKUsqa4l+GDEn+2wnH2uBHbmx282H1NpOHhfUJA4MyzgmGILWWeCCW7u
	mYw4pjFcNbcvRyXW+nEjmQq/6Aq8vsIeH8DBlpi+7DKgMr8jA3/xzpuQGdHscjRbg/K/MoAzaF8
	isvgF+nIYtrpDw2t8k/VDb56NFClk8CriRHo48NRogI6/ctLHRpJ/NbrtKxCp3xkI1BSWYHEdg=
	=
X-Received: by 2002:a53:df46:0:b0:66d:13ac:e9d8 with SMTP id
 956f58d0204a3-66fb5a29fe2mr2847711d50.26.1788566836124; Fri, 04 Sep 2026
 17:07:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260901014829.3504342-2-sanghyun.park.cnu@gmail.com>
In-Reply-To: <20260901014829.3504342-2-sanghyun.park.cnu@gmail.com>
From: Emil Tsalapatis <emil@etsalapatis.com>
Date: Fri, 4 Sep 2026 20:07:04 -0400
X-Gm-Features: AcwNN1Xp7B5KDmWx5xBMbQWhC_olmcuGliCqh-GT1hjD7H_XCbb0j7_t1sXv6ok
Message-ID: <CABFh=a5u-jbYdLRwexCXt_e2gR9QkT+ndrA+920x9vS2-sJZkA@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Fix program BTF use-after-free in sleepable programs
To: Sanghyun Park <sanghyun.park.cnu@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 9:48=E2=80=AFPM Sanghyun Park
<sanghyun.park.cnu@gmail.com> wrote:
>
> Object kfunc calls embed metadata owned by the program BTF. A sleepable
> program can remain active under Tasks Trace RCU after its last reference =
is
> dropped, while program teardown releases the BTF through ordinary RCU. Th=
e
> invocation can then dereference freed metadata in bpf_obj_new().
>
> Move btf_put() into __bpf_prog_put_rcu(), the callback that frees the
> program. When teardown is deferred, that callback runs after the program'=
s
> own grace period (Tasks Trace RCU for sleepable programs and ordinary RCU
> otherwise), so the BTF outlives every active invocation. The non-deferred
> path invokes the callback synchronously, so load-error cleanup stays dire=
ct.
>
> Fixes: 958cf2e273f0 ("bpf: Introduce bpf_obj_new")
> Signed-off-by: Sanghyun Park <sanghyun.park.cnu@gmail.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  kernel/bpf/syscall.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 6db306d23b479f..3b6cf93c43c4d6 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -2438,6 +2438,7 @@ static void __bpf_prog_put_rcu(struct rcu_head *rcu=
)
>  {
>         struct bpf_prog_aux *aux =3D container_of(rcu, struct bpf_prog_au=
x, rcu);
>
> +       btf_put(aux->btf);
>         kvfree(aux->func_info);
>         kfree(aux->func_info_aux);
>         free_uid(aux->user);
> @@ -2448,7 +2449,6 @@ static void __bpf_prog_put_rcu(struct rcu_head *rcu=
)
>  static void __bpf_prog_put_noref(struct bpf_prog *prog, bool deferred)
>  {
>         bpf_prog_kallsyms_del_all(prog);
> -       btf_put(prog->aux->btf);
>         module_put(prog->aux->mod);
>         kvfree(prog->aux->jited_linfo);
>         kvfree(prog->aux->linfo);
> --
> 2.48.1
