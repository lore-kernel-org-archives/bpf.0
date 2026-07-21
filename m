Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3D646D56D
	for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 20:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784664504; cv=pass; b=bORxZC4bMbo6IPTBO07j7Ql27ai/O4e1s3Q3ZWddRHXP/mar9m3Yu7yKcyDXBN/UxI8eeui1RlJCrMneNflyUXq4C6g8x8KTw2NGwZHdnfZzuC6LgJ9h/UvAo1QiBPlEwQI+bsqBYS6m4Zaktts+OpkfzLCzb9Q+4Py8TmnNIxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784664504; c=relaxed/simple;
	bh=Hci1bC3P+X3owHHYjbdKslMn9zLpOpY/3YyemZZfHDg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V90stzdCbr1/Y7mGT6oMZ4jFjlFac6gMNRZDMPcJWn216w7PulkUeaXHijtJIr9xvSH45HMEA3IgRqcv+ezrbwn6SS7rwy2YGquyxk6vV2kWt9DREl46OMvWYB0AQprbj5nErYAFArhApGr4qRy23qO7jg7pobFIlB2CELhXsIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=My0fr/6Z; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="My0fr/6Z"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-81ed000b507so63437087b3.0
        for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 13:08:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784664497; cv=none;
        d=google.com; s=arc-20260327;
        b=lTGeoQK7pJiXp/M9nxEG9KB8ZertGae4AbF5bQBj6rBxSZLi3z/gs8Nv75DNl8P1bD
         bhS1nlXfEew09J9Bk/MVXGtFln9nYueSonoUwE95IjujPMG+X/h5ZOkq0IOrJq64zo2/
         70bPrNN9kxTR07zOtRjCeWswNp7QsJTmVS0p6Zf7rkeHKqRFSRkKjB2xWb3eB50BTuVY
         Y8nkKWCnuZBpr0AkUzD425E4ZnEkieaZ2+XkHzaiPICPTe5PivxgiJ2GwQyLEdKLhtpy
         48XNUQMsWlG6/V4j2P4kvflN6VUHe4Kd0RfX8dxmE+F6WdhK32Zd5XhrXWnY/pO1dD4u
         ijyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JU9MbkLemkYABqglPrFanA0gj95u2y8wUop81+DJJFE=;
        fh=Kzg5sAIWYL2B6uXjj/8QZ/BVfLsBTjDqp0uHqA1I23k=;
        b=tDtXzHPiub+8G6PU0PzaCBBl9K12My/7N+Rn/6FNvbPn4vsXUEfndydt1YwiqLfHuC
         JirRkgUltD67JvGbyriKhLhlUBj/YMSCwQTAKHy5Jf+rIchqzFSn52UEUw21VhBlQ0D4
         jqFYq+e6AwgbizFA442t/F7pwova1LKPeXIUYw1Ax1/nHI1VNqXkJgKt+086sQNZTKgE
         LOjvNH0luxsW59af+0lSnWScMohMRSva9xd5TCAsvEx4Muo050lSqi1tKMgEsdoqVWz9
         WAkQoIcBP4nlXbzh0KohIMe1c/Z3cqpKXFgBK2VWibjU57EZH5SJMTaqXZ9ihM+wCjGD
         u8fg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784664497; x=1785269297; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JU9MbkLemkYABqglPrFanA0gj95u2y8wUop81+DJJFE=;
        b=My0fr/6Z7/BO+qyxzQx0fS3LcMICFpF9+K6LRb8tSdWGLvftXE88AwO1/4JO/L5DJZ
         2Kl6533RC4sjV7L1b4MMxi3qzoqzKZSwpzRIfHNV8W0kth5PoeAPBjAGehRLluYXBe/J
         q5L4/MJdP8TJb6APm+DrS+2JogbiVIe7YQZ0aviPJnu6vsEHh48sJ6+vZQi12x4fXcxy
         w8OMQO89iMUTVA8R1OsHJh1UWRq3j8DrkanTDWPgGhPx72YuP8FmPHkdKvALdqvAPXsF
         EdoV14IsdzG5tvVV8cCB1qkWlscYvKoND3U+TtjULVFo2r5kwPrtTGsQIhChQMsV3Lue
         Pyhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784664497; x=1785269297;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JU9MbkLemkYABqglPrFanA0gj95u2y8wUop81+DJJFE=;
        b=QTDWKvF5IqGWFAuCAISMtLnuTd740WIrYn8nD7PqC6/dxfkzLIA8+ssvvwEP5Ptef2
         xAo90dMFCSeTS9kA+C3782YwoPYS2Ch1sPSn0C+yZtt8uZvX13k3YpGwaCuLAwaKpTfR
         BN8lm4PaYdCNx/u8Idcdwo1NdUbbCyAcSdlhthrOEYnvta3B3//ygdyxMb3Ntbwd8TDG
         Ctr7w6T46U5tU8C5abbI9Lt+SnFgJDFJKYJb3Pcac8cAMnumV7q5DJp6Qwei8OMFRRyT
         +cugtbLwvHtJKlwa95t4aqkB2SNmm0wiBw9dAVbtaO0yvyaK4MXODMcIaiSRJ9aAIJv/
         Hqow==
X-Gm-Message-State: AOJu0YyewkY/PkAHdqrnAiJnjgLsWPY+GjZFMA9Xgsu0U7uQz5uO7/Pv
	eR5pQfE+M0+JwVmjOEGFr2dpSlv29wt23SYMU5aO11m+WDcLzU6Dn6U1NalZyZZEWmQMlsSXd/8
	qASikeFALfJwnny1AO6pJ5zAUjjSsLCU=
X-Gm-Gg: AR+sD12yKy5rJzOYfSX9qGLja/XqDa0iFRqTF08T1YqKevuSHyZP8VjLwepGFllf9f/
	+fXlviGiBhAZnv1e+qyhlGMwfCDnJAEDBhiIKzj0mDy9FzhFUtGtGRDzfuUXx4z+b6q8Ke2Kq+r
	OqH97QV5VzQVCInFFnvm/SO5MV/GaGNi5rEqukL+BwaOWCTSqPVnFn2vqFtjPftmZxvJNQI0uHZ
	GegGUeiv6hEaBEYdRFfTobFxCxG8ADPhQv9g7kQzVZyj30LDFwZ6c/Sn1iLHA==
X-Received: by 2002:a05:690c:450f:b0:7fd:e030:2407 with SMTP id
 00721157ae682-81ef2410929mr62852067b3.29.1784664497098; Tue, 21 Jul 2026
 13:08:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721041048.1394085-1-pulehui@huaweicloud.com> <20260721041048.1394085-4-pulehui@huaweicloud.com>
In-Reply-To: <20260721041048.1394085-4-pulehui@huaweicloud.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 21 Jul 2026 13:08:06 -0700
X-Gm-Features: AUfX_mwO25ftYQyg1LqqH3IxQr-FEeMc2njKxC8RQDPGpa4lwYfv9-Rp_bgKQYE
Message-ID: <CAMB2axMZxvKLbMFvt2gLeAQk75=y1-m6eRSqsL28sc0kJ=w_Cw@mail.gmail.com>
Subject: Re: [PATCH bpf v5 3/4] bpf: Fix potential UAF when reading bpf link info
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, 
	Song Liu <song@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Pu Lehui <pulehui@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2026 at 9:06=E2=80=AFPM Pu Lehui <pulehui@huaweicloud.com> =
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
> locks would normally be required, as BPF_LINK_TYPE_ITER supports both
> non-sleepable and sleepable progs. However, as commit 57b23c0f612d
> ("bpf: Retire rcu_trace_implies_rcu_gp()") clarifies, an RCU Tasks Trace
> grace period implies an RCU grace period, so holding only
> rcu_read_lock() is already sufficient.
>
> Fixes: 0c991ebc8c69 ("bpf: Implement bpf_prog replacement for an active b=
pf_cgroup_link")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Signed-off-by: Pu Lehui <pulehui@huawei.com>

Reviewed-by: Amery Hung <ameryhung@gmail.com>

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
