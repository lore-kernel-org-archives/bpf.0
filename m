Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D8737CD5A
	for <bpf@vger.kernel.org>; Wed,  2 Sep 2026 07:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788333343; cv=pass; b=X1M2BYeN8Waz0UwRmBmmTlRNX4+gy4v1pkDdldV6hrYaEYcfsWI3hq9yU9rbfuOv9RodUrScq0bM8lz9IU4r4UhrINoUi1fDSKFqgGCs46JzSY+v7fl5ph2GI+6sLQepY8DLPVAnO78qGM95OEyJGfB1XAH/QQOJHmvvRSFt5l8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788333343; c=relaxed/simple;
	bh=0G7LsLuaoP9w6YDvNw9R0iIYY3icFbQ4tzpJEWmCVMo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sWndbK7e2JvAah/mllMrJkAy9gfdifYxRbtxNQuq+VflU+XdO22Nz6KH5VYyhOP4AE8o5xyv1TRaN/78NiibAb+cIBbaQ7n/idyEP6/aqEoFUCtBW6eBDHO9h1eveK11oSImVSmZfUs/4fjfK339vsszpp/BhW9JOz9A5ExBhI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m2T4QIfW; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2T4QIfW"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-66ce4a63e17so787008d50.3
        for <bpf@vger.kernel.org>; Wed, 02 Sep 2026 00:15:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788333341; cv=none;
        d=google.com; s=arc-20260327;
        b=HsnbXKsYgEYtbgnvqw7LRphPVDDEYSCzUeFW4qFIQTS/TP8KaYUvdd4D1LUzc31y2E
         2UNok86W7iNzM3m6Yc6yU+PKspJRBhFLqnbR9DSoccVuXX0C7raqBLJtvim1otIxTpsh
         vT+qsnYX/cSeYiGyrGsM10HvwRwYv4zThfFoJ3RJ/TM2EtU9gxB8TeGenO+k3UQwBDcd
         elO9vDBV/riJ2OkFSPZjLIwShM5V3H8eNZkvxq5YymG0K4AtAgjhQK6MEKdCbeq7BKnO
         BZa/EMnMVcsXeHHMQ48DdBqKOlXsyJv90KlkX5ZGyLutIcvpcdxQsAtWF5gMYjFbaWrS
         J/qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NpXY1fG/hF2KYSdT5yF/Ko9Ye1GpyobzYyJewmIqaIM=;
        fh=cPq5+CGihBMUxyZbMNwrRON7uQ5bufVYRVP5d1lwhPo=;
        b=l4en1XRH/9/Ms38kzEdxSpEnYAKggHE90o+y4hP3tGzCHcwtsUWGLyCsIpB8459xNc
         mZ1XmasFDbBthd+TUXU4zZU5QflJ2nA6qUuq3EmFlbKIzuRrY+6Ipfmd+p+2EJjDV20o
         G/o6f2tf+SPtGZ1ZDP0/cRp+Ak5img0Z7/50rmgs7ZfaN0lEnwQT0sFYK9BElG2pZvbo
         Kkg2jyb0RAxEPXiJA0s+9KMPvfJpdTkwY7TXdtRyrHlnTFs2UhEj6IDS+L+Z8ZxC6B9k
         XP9kXnlyiC60gWj3QArTe1n7H8EPimpe9DwlJj1UCRFTyd6qN3WP/vp0W/r0pe0gFzwu
         RdeQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788333341; x=1788938141; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NpXY1fG/hF2KYSdT5yF/Ko9Ye1GpyobzYyJewmIqaIM=;
        b=m2T4QIfWz2+tqB8tCUoAb5vpjjNtIRM7tGzCrJ7vBaMX+Haob6PNTgRcaZyjOqtG7k
         zOgXNGKQSBbHm9YFeB2ZhbTR64/ZubWOb2pSrj+pE89uzuFW9pfQX2WISlnx9Vtoq44k
         h8/aplMVaQ/t/sWRsee3RcDycenNmOVuDz5qVXhx3d/FnQVJrXxiSxnUZqpLpScGEXrm
         F8YxD5XdzS3B0QDM/tDT6sulEH+GdgmQk2yi2ER3P0YRd9FzlRMtVs3PGcbR8DL7x0Hc
         dRaClwSeFXSFQ6Emr6bBL/UxJCp70aihZUTJZyS4MdYFJEekY5DI1biJDMuyYauRLpFK
         fZiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788333341; x=1788938141;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NpXY1fG/hF2KYSdT5yF/Ko9Ye1GpyobzYyJewmIqaIM=;
        b=RbhxcJnm/a8qU/csJ/4aHJRg6Tof+gWizAMgSTa1G5w8rBse8TB7h0LKpAGKxZfuVu
         y78Jucs7dE2N3VXJEaSDsBNBbDWim+A31tIX8NgBX9uR0FcNPAyqEXgMwHJJWVFOh5l+
         lLHgd3E8znsBu5koeD1kg6eGklHeWc6yufwovPXxXZ3JkU3bLzNPHpSjCJUrGYsugyiC
         bgJ8DuPwamj3IRqW6c7NYjKkV+ABI25kXSyxW4Avx7OygDsysQsdNS6c31whtTYoSbhW
         2whsdYEdZTF9q+A++XsVEEqpbHrqK0rt5vAbq2JzkU8wSn0XVzzEKzmPl1S4GxHOKVO1
         +2dQ==
X-Gm-Message-State: AFuF++mBS4TTgQyvmzgKZ9Mut6w7DycDdIM+mG4ieIHe6eJk33IDxNBq
	3mr7Sz5xOHsHyR9B4pByVtmhhqyqWuTsa4oNp62JJfp5uNltGgc+zJyuHv8B5+TFJWqs1tpoyd3
	TGqY5DLKHGalMXuMXdnHvn+GQ6uE2az4=
X-Gm-Gg: AYBFou2lRycsQJjcKIbGXNS5otdlfpiam0NLaoh41vpeY+EOFaMAfS9YiA8GqlZ/c1N
	8KjMyYlPH6sORMOOrUl500MoZxRMm16PivlR5DN9dwOOotxMYLS8fgTqPpMMwN/5ct8976TKuki
	HvSmzh/6GmJFyWxwpAFHgYNmg6Rsx6WQ02sAeZq0nWySPyVwBTZ3zIAWov1ml24JRmTwiUuU24t
	mEC5FECjkEt/DSTg6Zw0SaYtlbBbWgcXjoLNK/tB+aq784/XSGTf3p3Ae8nvVvSKQENzSj7A3LI
	G0iGZdQRkSXrwuO8+ZgaHD3U1NCpCt8q9U0yV5h9X2fvOi/2tOkZ+y7/ezCoq1OvQIPKKt2P8kX
	aUKUMI0L15Mo8XcgHWhAsuVFXqQN3hAhwj5U=
X-Received: by 2002:a05:690e:428c:20b0:66e:53f6:14ed with SMTP id
 956f58d0204a3-66f9b8e8ef4mr813726d50.11.1788333340929; Wed, 02 Sep 2026
 00:15:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260901014829.3504342-2-sanghyun.park.cnu@gmail.com>
In-Reply-To: <20260901014829.3504342-2-sanghyun.park.cnu@gmail.com>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Wed, 2 Sep 2026 15:15:30 +0800
X-Gm-Features: AcwNN1USx_9Bx2w7VYwX5R4OwFihkl-WbQLEy5h86ML1H5yODg3TCGcOdS_e28k
Message-ID: <CABFUUZHSLiNg4rMtATXeNoCju899huVsf-LMjtyDumYk4nHZcQ@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Fix program BTF use-after-free in sleepable programs
To: Sanghyun Park <sanghyun.park.cnu@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 1, 2026 at 10:06=E2=80=AFAM Sanghyun Park
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
>
Reviewed-by: Sun Jian <sun.jian.kdev@gmail.com>
