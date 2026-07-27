Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E6733A9F8
	for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 23:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785194147; cv=pass; b=UnHRRylFRNtVY1Bhj57PqTWZb3OYOTh+lbiFrVUoPgW2DkuALgmc87rCwQ4jaPbkIMxpf2REvWs1ILf9N+bhQa2ZFIdM5cH8SNAxGwuljCeBEHfxgkIZnd01DkmQ6lKSLg7urzz+Vr5jog+4HMmUtuQuGoypz+X12/EdX+/brt8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785194147; c=relaxed/simple;
	bh=aLTg5OPMRh6ua9dexXGVQ9PO77dded5PXHeBSyRdPhA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XCiiaC5XMb2Vg3YBZuIoPJuAw79nN8tttYRpoqJrDtH026ATBRfjS9dDFRK4AnZi4fDcZ343qOqp0a+BOIDxipx7VW3Ha6jLP3/fwhnVitk/fM1BJShNwBYlUYOkxbLezVdXaokZIcVcB/inAjsyROwnSpm+9V+eB40W+2BjFgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qRRWofOv; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qRRWofOv"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-69c20ba892eso573990a12.1
        for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 16:15:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785194140; cv=none;
        d=google.com; s=arc-20260327;
        b=XcZu7goA6qVMFsGXOqhebWYNyJSYsKDvdXvtIBWyhgMFFPAH4IZBGi+68w9NtcgQK8
         4KKhM3vr2yx+vy/ZiefqXsWneq38WrgduUIwc0CR8kU43SY7shioZFGAWcWywBe5PAMa
         CJK+fLPst6oQxO4Vr1QA8W9XKrl1hK+QhR1mlxw1/sP3OQF5JclvOIeu2vb/UAX3wKxY
         TwqnuKXGxcJCHFSLuJMrGl7sEwJ0Dgnu1S+q7Vh0Qe5n6Mc1epM3zBvPZGljymvkGfVW
         V3OU8nyMkCUJLiOtNJqHoASkep7okG2VZGJnD+hB0lGXpbpOA7dC80nOUo2ABPxdots/
         LV8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=f2AGBVm2zj1Ov2ifMpBlokkFi9xCsAP+uSoE4d3RJPY=;
        fh=aYWh8h/GZC2EgYNIUxXJNJP//lbEYAtK75WTuEP/ygA=;
        b=AK6tz/O/t82WUtxWIFwQSipcROQY8kMQuoT47bWOr8vuYgJaDK0p0/yUXr5ppCvp0B
         C1+WdJg/lV9zxuU4/kASUXrymgN/JAxfo6zhbE5XwuSbASYBxIpYH2hnuvBC+KsDp4Ea
         JrEhbGW1SrZMZCnBgKjlcCCpVX427gYEbwZqqlS3BTaoq1s4P7nr7VueOyhm4dyJqWuW
         jsiceYr0U56Utyn3W1omNL5zRAFMiVatRt5HBVyatWCzVhskeeOfSbmWMltILPXoHqFj
         9VIFOQMqtHC8TC2TLd/JPzVoy1pKY2OxjucCXJGdZoprGXbtJfKmiUs2AXeis/JlzsA2
         cehg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785194140; x=1785798940; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f2AGBVm2zj1Ov2ifMpBlokkFi9xCsAP+uSoE4d3RJPY=;
        b=qRRWofOvbOdyilRrtQRP9P9ILYsbBElEB5zz/i5OPUjMJ6yNSN9FlfR8ZYv9285CLg
         00wcNcBd+7s/xkRql5eG1ChKYrPFI8VHwJ0bfxPtrB/qan6zuI8asrWexkp0YBh3bC+O
         vl6HcnmByeZ6vfq7Tn7twskcwKymaugWON28P7kAIT3oFne9hECHEK+dlpqg7zb7H/Ub
         rhsu5AK0JfAUm5ExjurJcOtCiTSaoAPheNS4HNey82tOX7ljf6yvB6ITm2A01NmlqDps
         Kp8gcBGRyv8SS8csv5PlMPwKNJlKyHD8qKq5Ehf8PGUeQcpfqx15jf2EQcVKs447DFAS
         eGBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785194140; x=1785798940;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f2AGBVm2zj1Ov2ifMpBlokkFi9xCsAP+uSoE4d3RJPY=;
        b=MEzIWPEzVNglKvUmjAedySTAKxsCupK5DeamsrCZlmV27YcPCzanhRNBmuwE3RlW9Y
         FhUbgjHnaRToqrVsqn5QauGVTpsCK8B4vXCoSKNJG+bnS5hKs9HYPAMcNLXccjbrJENc
         KBQneUlgghHqMnhLyJQWv4h6e7kLBVXai0yJ9E/x+ANxmb8hQiax27OfzD7sBC7szF6r
         QiFwgyE2O8R/ZqkbC/wQXVOjE21jWpsHiuSoz75faUie8nb1r9KNqagPoh8tNx4UCiWK
         O3cH2FKHDZzy9hFU4Fk71a62WmyzjsxIfIp36mi3ZkeWkQadAWS+gJsYYNe38QdBvVJo
         4P9w==
X-Gm-Message-State: AOJu0YwytmTKSlGp4H2+EwnAhusPeyDTsKX3elOjEboTal0b1vAeKywZ
	1teIGwyW3/fLdE6llueMU9oIGngjgdCg/R0ir3a+kudk5+BuBewHUjV9GX7V941GMLCRj9Kgw8M
	FYlA9XExBQhgCcNRwOoInvzAVxgQ2IBU=
X-Gm-Gg: AR+sD12DJWi4klKLpx6YrOYcs0vxTIQYY8Tl2y0ODg37/H6LLteVbFD8AvqBmG6n/2u
	6P5E2lPSaqG4iFdpyjExonOFY/0oBrbQgeuMGuLkxtUN8hMj6ETxN9RRPN/IedmSazsmS/Q+A7x
	8VoiqDHzpW1ZK4TJqy8XVikk6fA+Eln62Hzknca6XxIWkGK6Xz00g+gkcK02W/r2oonZbuXzyg5
	mpLrZoiTjkZY8YOaQ33Z0Qy99Lw2teSnA2FQ5sme0i9yfblIPv43sv1ZHIItU+A7GSbSXcs4iOv
	xwYk10C3q50U33Lsfq+KvyUPlFI/d9MfDg5v22z7Q/PTZJ7FgQ04UwBfClFrAVxVMpht
X-Received: by 2002:a17:907:c0a:b0:c1f:2cb2:c448 with SMTP id
 a640c23a62f3a-c1f6b8ccce8mr29339366b.7.1785194140322; Mon, 27 Jul 2026
 16:15:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722072326.1545677-1-pulehui@huaweicloud.com> <20260722072326.1545677-4-pulehui@huaweicloud.com>
In-Reply-To: <20260722072326.1545677-4-pulehui@huaweicloud.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 27 Jul 2026 16:15:18 -0700
X-Gm-Features: AUfX_my7LVVjTtdEZok3CYe1muSNAMA5LTxn74HS77l7hL5485-8FJcHpEd4ArM
Message-ID: <CAEf4BzYFQ6wiDwz=3pyvDpr_UcSAOTygMq9pPVsJ=15CaGbA2Q@mail.gmail.com>
Subject: Re: [PATCH bpf v6 3/4] bpf: Fix potential UAF when reading bpf link info
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Amery Hung <ameryhung@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, 
	Song Liu <song@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Pu Lehui <pulehui@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 12:19=E2=80=AFAM Pu Lehui <pulehui@huaweicloud.com>=
 wrote:
>
> From: Pu Lehui <pulehui@huawei.com>
>
> In bpf_link_show_fdinfo and bpf_link_get_info_by_fd, link->prog is
> accessed without holding any locks. If the prog is concurrently replaced
> via bpf_link_update, the old prog can be freed, leading to a potential
> UAF issue.
>
> Before dereferencing the prog, both normal RCU and RCU Tasks Trace read

no, either one is enough (and that's why we wait for RCU and RCU Tasks
Trace grace periods, to make sure that both kinds of accesses work).
This paragraph is misleading, just drop it.

> locks would normally be required, as BPF_LINK_TYPE_ITER supports both
> non-sleepable and sleepable progs. However, as commit 57b23c0f612d
> ("bpf: Retire rcu_trace_implies_rcu_gp()") clarifies, an RCU Tasks Trace
> grace period implies an RCU grace period, so holding only
> rcu_read_lock() is already sufficient.
>
> Fixes: 0c991ebc8c69 ("bpf: Implement bpf_prog replacement for an active b=
pf_cgroup_link")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> Reviewed-by: Amery Hung <ameryhung@gmail.com>
> Signed-off-by: Pu Lehui <pulehui@huawei.com>
> ---
>  kernel/bpf/syscall.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 6db306d23b47..cad986807d53 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3471,9 +3471,10 @@ static const char *bpf_link_type_strs[] =3D {
>  static void bpf_link_show_fdinfo(struct seq_file *m, struct file *filp)
>  {
>         const struct bpf_link *link =3D filp->private_data;
> -       const struct bpf_prog *prog =3D link->prog;
> +       const struct bpf_prog *prog;
>         enum bpf_link_type type =3D link->type;
>         char prog_tag[sizeof(prog->tag) * 2 + 1] =3D { };
> +       u32 prog_id;

can be read uninitialized (if link->prog is null), initialize to zero

pw-bot: cr


>
>         if (type < ARRAY_SIZE(bpf_link_type_strs) && bpf_link_type_strs[t=
ype]) {
>                 if (link->type =3D=3D BPF_LINK_TYPE_KPROBE_MULTI)
> @@ -3490,13 +3491,20 @@ static void bpf_link_show_fdinfo(struct seq_file =
*m, struct file *filp)
>         }
>         seq_printf(m, "link_id:\t%u\n", link->id);
>
> +       rcu_read_lock();
> +       prog =3D READ_ONCE(link->prog);
>         if (prog) {
>                 bin2hex(prog_tag, prog->tag, sizeof(prog->tag));
> +               prog_id =3D prog->aux->id;
> +       }
> +       rcu_read_unlock();
> +
> +       if (prog) {
>                 seq_printf(m,
>                            "prog_tag:\t%s\n"
>                            "prog_id:\t%u\n",
>                            prog_tag,
> -                          prog->aux->id);
> +                          prog_id);
>         }
>         if (link->ops->show_fdinfo)
>                 link->ops->show_fdinfo(link, m);
> @@ -5535,6 +5543,7 @@ static int bpf_link_get_info_by_fd(struct file *fil=
e,
>  {
>         struct bpf_link_info __user *uinfo =3D u64_to_user_ptr(attr->info=
.info);
>         struct bpf_link_info info;
> +       const struct bpf_prog *prog;
>         u32 info_len =3D attr->info.info_len;
>         int err;
>
> @@ -5549,8 +5558,12 @@ static int bpf_link_get_info_by_fd(struct file *fi=
le,
>
>         info.type =3D link->type;
>         info.id =3D link->id;
> -       if (link->prog)
> -               info.prog_id =3D link->prog->aux->id;
> +
> +       rcu_read_lock();
> +       prog =3D READ_ONCE(link->prog);
> +       if (prog)
> +               info.prog_id =3D prog->aux->id;
> +       rcu_read_unlock();
>
>         if (link->ops->fill_link_info) {
>                 err =3D link->ops->fill_link_info(link, &info);
> --
> 2.34.1
>
