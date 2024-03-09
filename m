Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22285FBF3
	for <bpf@vger.kernel.org>; Sat,  9 Mar 2024 01:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709946418; cv=none; b=H7K9I5L1vPSaRSmPYE2bI4L4icmfBZn+VTzEYfOx04bMCl/rm2b76eVEVScSZUQ0wibD0vmm5tYNbbuV//Cwcxoa9nkz4rP0qp5iBU2s55naPVEHmvJmbTgBHI33VG7iUueayD/yRhFHRiI3O3Z+udJ5KTHr9uDQ4tcR4blBnf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709946418; c=relaxed/simple;
	bh=h6J3IIQpyc5s4Kkaoq+xpd+3ArUxwMZfBtAIipqoKGo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sV9eObMlvLGVnrNDANolq9Wxw/nuu9vEVcH3SoUXPF4p9QaAYi8aqEiR6hsWcd487PMyhY7rcW4BzkdZWnIfpq5dPe04EtngPm5DqIeAj2hLrGE8X+85L3QEy9s6Gwa7mm8ohegRI5+Y8Sip3sRdVRjCfB/n8UOwmaRYhkklxUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Etky0vlK; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Etky0vlK"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a26ed1e05c7so390668266b.2
        for <bpf@vger.kernel.org>; Fri, 08 Mar 2024 17:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709946415; x=1710551215; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/OxsypZatDrT81X+70Ckb5w4FlLxb9Wav8Go9qKym9M=;
        b=Etky0vlKYH1E1DfqqRTVs0HicMkUC/+TSd9y5yXe/hxmXmI6A9Q4GAnP5NId+RDBVl
         yGZcXpr8EMJ5i8JUnueFUS55Y8b8dXQdsuD9uYkSeiLtkH1Gl2uVYJDYGfiJkjXzUzdh
         0rEFA627oE7wzkk4ORALwWSYy6jRV3QvBm/efH3TmlQaaEddaxbym0/+MyrowN6l12ET
         sjQc8j/Po6tPEhd4nbqe+K4EGnVRS8yU0bW0Gf0nxLXEL3UgS5oBOZcLuMbH3uPsMUtg
         Q5tjzJS9Dx2qkKc+/LQvWmPQu9Rk17l18nEEO3p2/A6Ar6YDJUN3ZzPpqlUKWcWUKnGq
         9HTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709946415; x=1710551215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/OxsypZatDrT81X+70Ckb5w4FlLxb9Wav8Go9qKym9M=;
        b=UCWY0EcJbMbNaH8MAS0QblyH+dowyB0Xd+jD38DtEhDddUpPSvCLjdutQCn7sKnOVN
         YQxiTUZrKzao4Q043tGDfD9LGJ8YS0tFdWtL9aI2T4hk6qFxMifhrLDXqkOEVANbS96R
         M1LgL4UTLJg6IyENNzAnnY45BIqRKmNy7nEo3ZQs8MAogqK2JJ0TS4dIhVTh3NMbX3hq
         5JAoPoBP4/NL9iej8prW62qrrrrSrqjAXz2XLk1P0uDol7AstPsZfnMBKQgnhp4FAP1b
         EH0On737NZpBXJfLg/+W+kGHFu3smMcaKLoF/lUw3NhxHxHqCcWDDefbEoj5IZhOQzK0
         wNsQ==
X-Gm-Message-State: AOJu0YwqWdDoJrXGvBwxxYi/BzU2KrFMIc4BSqKnZFlTfrf5WAHPouBP
	LdKZRaBxJaqTnbJAiVl9se7Jo+vF1VS39xKlcd3Eg0ck8gpwHFP9hjnVAArdolX5t2NVSjXvpdX
	RlbR+JHkz7afbDAYA3Zjuy1Ln3wHM88muADs=
X-Google-Smtp-Source: AGHT+IF9Tv87PtzdfhUJu4yZQG85gsp9VQ1YDnbFxoHIrUWGD659KHlb/rZZqyBYV1OFH9Reetim+oud+O7VXU7Fv1U=
X-Received: by 2002:a17:906:452:b0:a45:ab75:7628 with SMTP id
 e18-20020a170906045200b00a45ab757628mr154341eja.52.1709946415256; Fri, 08 Mar
 2024 17:06:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307232659.1115872-1-yonghong.song@linux.dev> <20240307232705.1116787-1-yonghong.song@linux.dev>
In-Reply-To: <20240307232705.1116787-1-yonghong.song@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 8 Mar 2024 17:06:41 -0800
Message-ID: <CAEf4Bzb+=OyvTtqwu_q1ouY7dcNVm=uD5rpYohAqGdjFBQntKQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/5] bpf: Allow helper bpf_get_ns_current_pid_tgid()
 in cgroup and sk_msg programs
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>, Yury Namgung <ynamgung@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 3:27=E2=80=AFPM Yonghong Song <yonghong.song@linux.d=
ev> wrote:
>
> Currently bpf_get_current_pid_tgid() is allowed in tracing, cgroup
> and sk_msg progs while bpf_get_ns_current_pid_tgid() is only allowed
> in tracing progs.
>
> We have an internal use case where for an application running
> in a container (with pid namespace), user wants to get
> the pid associated with the pid namespace in a cgroup bpf
> program. Currently, cgroup bpf progs already allow
> bpf_get_current_pid_tgid(). Let us allow bpf_get_ns_current_pid_tgid()
> as well.
>
> With auditing the code, bpf_get_current_pid_tgid() is also used
> by sk_msg prog. So I added bpf_get_ns_current_pid_tgid()
> support for sk_msg prog, so now for all places where
> bpf_get_current_pid_tgid() can be used, bpf_get_ns_current_pid_tgid()
> can be used as well.
>

If tracing can call both bpf_get_current_pid_tgid() and
bpf_get_ns_current_pid_tgid(), can't we just add both into
bpf_base_func_proto() and have them available for all types of BPF
programs? If it's safe for tracing, it's safe for any program type, so
why not?

> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  kernel/bpf/cgroup.c | 2 ++
>  net/core/filter.c   | 2 ++
>  2 files changed, 4 insertions(+)
>
> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index 5a568bbbeaeb..375b92204881 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -2577,6 +2577,8 @@ cgroup_current_func_proto(enum bpf_func_id func_id,=
 const struct bpf_prog *prog)
>                 return &bpf_get_current_uid_gid_proto;
>         case BPF_FUNC_get_current_pid_tgid:
>                 return &bpf_get_current_pid_tgid_proto;
> +       case BPF_FUNC_get_ns_current_pid_tgid:
> +               return &bpf_get_ns_current_pid_tgid_proto;
>         case BPF_FUNC_get_current_comm:
>                 return &bpf_get_current_comm_proto;
>  #ifdef CONFIG_CGROUP_NET_CLASSID
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 8adf95765cdd..d4e43303a66b 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -8344,6 +8344,8 @@ sk_msg_func_proto(enum bpf_func_id func_id, const s=
truct bpf_prog *prog)
>                 return &bpf_get_current_uid_gid_proto;
>         case BPF_FUNC_get_current_pid_tgid:
>                 return &bpf_get_current_pid_tgid_proto;
> +       case BPF_FUNC_get_ns_current_pid_tgid:
> +               return &bpf_get_ns_current_pid_tgid_proto;
>         case BPF_FUNC_sk_storage_get:
>                 return &bpf_sk_storage_get_proto;
>         case BPF_FUNC_sk_storage_delete:
> --
> 2.43.0
>
