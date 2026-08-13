Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9523A44683E
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 08:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786611170; cv=pass; b=AipDMma7UFzPgkkd5Cwg8MjmUFe17tdLnVl8SJXOar2+DED/2Qa0Fj47ajgoiWlvA72u49r1jNzMWQpeVepDoJZSLg4U99d4E2NV2S2xzbCY0z5Ho1xzgN4Q8/COjKi+vyXqIiYdsaX700W6ycDMlwaFhMoOkIAjvTvLdH8awZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786611170; c=relaxed/simple;
	bh=OuHmCFJxSVJBidCXfFZYNZ0poOvLesgUedmmoEQ/ihE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MbpPcSI/6vqBnAj9QUKpzSPDrHYN4UgNr+1fP05XQH/nLmICeq9UMLasyoJOa7OMziXbF70Orj0GM9InmEWKn4lIZHOTMWyX7bXKVHpVpl9VOcT1n9FIA5TX/d5GBill0dnsj9OU1olIKfyM4DHtFCUvLgxGPljMfp8uI83vY38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=Ix45WXuQ; arc=pass smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="Ix45WXuQ"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-84eb992a881so1530285b3a.2
        for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 01:52:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786611167; cv=none;
        d=google.com; s=arc-20260327;
        b=iulj1GPNmyDrNw5cGhLCYtIQZzNlVALem283uH1I2UuTCVv9tEaRQ6Oy2MK5ymsdxr
         Wzzbey8+kCfrJUE8h1xXZ1CBF6PqHCEygI4FOV20CYRAdhLBbVVTeHHMRBJPGyf90ioR
         ZJ/GbxdAmu+r5lXH7WbGbpLrlapgl+OphvkJSWO6XXzu1AnRNbKGM3C2/fNbc9cgZLSc
         GHXT4v2RUoAHlftodZRc9HyknQrh/IvEP1zItLJ/MiT3rD4HHmXz7MfjO1Xwb94WQv8G
         Y0St0tNChp+vwlqzrgat3JM0xY3Nz7I5SZax3bGsNs4fJCKuQJe8fAqKy9Ja9yEVBaaK
         lV3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eB8qHCkBqgdg5x5zWmXJ5QxdIBLGKfO7Oht3lf2tkAU=;
        fh=LtHBe70SlIkNmWMMHzcnctvzm/Hf6YLzR43izAnAxiU=;
        b=OGIkUoAJxYDYHLkUZDK+Z1Md9oihAxuIlL33BRmijEVLhD/bDNWZEEaLvHz3+BpE5v
         +Ky4ZEwj/k3piKz+cMst2mnCL7r8aJzG0ElIq1YiGHoqkrLWThMZAaPwRiMDHYF+Zhxz
         tu5Uk1wmDO8B+eSXmYpFXHvy0+B6gmjhPgTyFsG5gDh+3ddzLZDp1fXpfzLL/ffJgrcf
         2alX6DdwTdHXXLtWwknq5EIO6WRz5JdhC7QH/+goYTv7lee/3/NhbZM7K22A3iGEiWKK
         BVr4EuRyD+LDJpi6bmXQLh6wEoo6agBY4w21EkVUPqK1n1W5cp0W3PM1/TJucCc9tJ4q
         rPyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1786611167; x=1787215967; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eB8qHCkBqgdg5x5zWmXJ5QxdIBLGKfO7Oht3lf2tkAU=;
        b=Ix45WXuQi1B/KzBzQq6pZrj+eyHx1usm9lNuBiLKjFNvbDFoTV4xcj4TbNeo8S2ZTG
         n+lufhzd4Rw7YfYrFHqdPxqBuRp/bWVJUN2IV2gtv1msTmY3ZNOg4MfAkzmAqjFfnlSE
         WqdoltD0oru+cDYDom9AFu8VNuOCeQrPAXUUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786611167; x=1787215967;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eB8qHCkBqgdg5x5zWmXJ5QxdIBLGKfO7Oht3lf2tkAU=;
        b=GGmOLQYlTCKo+kGi+1FOsIDNFW+cKFFMpAR80uqdwELqd64bEMdIk8xnZNlfHUBspx
         1Kfd1FQxgNgVKPRcH3qLoCeYk2ilwhxvhQPqucOvu/tW4WnpJn9aZ2b/964DbWsqt+Bw
         73DhyK9HlNBQXmEb5ajUW9mZDzVXjy/x8e3k6ixb9roUJTfgUpLb3ZSXn3wVQ/98zF5H
         pIDd6YGl/xNv+R/h2gIbwPn27nL3U5SbLXyBsbOsIJqMSmoMbks8+ydynSyELWwPy6jo
         aWXM1Fv8ZfCqG5rjU/oVRemTxKDOrrj6e4+ebdoIxb2+R8Ou/Iv9mtUoFc29cfL03FGW
         S1KQ==
X-Forwarded-Encrypted: i=1; AHgh+RqLlgqkKhgYeQ3Ko5mFaWY7eoWq2xfBVTceg4f3VDD30WxJRRNUBNX219X61coPTkNlAXw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq3lJJVCY0SnGJz1x4J/ST9N6ne7vG3XaEGPgmRHzEImN1fyYv
	UgU/e1FYvOpI361GIOw/wZzYq06JFqK4sgSxxYU518vOClFWIcffOfZoVZVxZccvs9yD8rTLGsZ
	GuMTa5kjQ8QE4RD0Jwn+Iu3ZslU/2N/JCXsmS746z
X-Gm-Gg: AR+sD105llRFj7R3gfstdZ2lxXEjfWPwOSlAU8JJK5V43wKZYiM1F8UUpqB9juzcK9p
	ox7MNRGMrkLj05p3TN/QcKm8VQPbmyOqbtXGZ21NmY1KhyjbAxSLTKwVvF1M7JUWVJ76byafMpe
	w5TmIDz+AbMERY8JeK7Pknv3e60O3876DNacq0J1AgIdTjSwXBnDt1kOOTack4VWkGfk3MUpGZc
	Y5qRjQtRHvaWqgUknT/S3s05dYj/TCFVMuCjKtp2toTUrVmfVoBbrB0HBcnrZuFGJzbdjQEHrp7
	AutMo1J0o2bphIHhEK23gjQhmzaXMb8zw1pMd+6qTQ==
X-Received: by 2002:a05:6a00:1891:b0:845:c6fc:2821 with SMTP id
 d2e1a72fcca58-84fc6e04476mr4296840b3a.22.1786611166640; Thu, 13 Aug 2026
 01:52:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260809094418.901607-1-jhs@mojatatu.com>
In-Reply-To: <20260809094418.901607-1-jhs@mojatatu.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 13 Aug 2026 04:52:35 -0400
X-Gm-Features: AUfX_mzYJSHQ81nk6K5CQtHRiM8w99otSWYBW2UKmO4T55DkFo0ZHPMcwhj5DCs
Message-ID: <CAM0EoMm0xj=R4c+3yoBJyEDgNAmsaCospYT9jxVTTihJzSnvPg@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: cls_bpf: reject dev-bound programs bound
 to a different device
To: netdev@vger.kernel.org
Cc: stable@vger.kernel.org, vega@nebusec.ai, 
	Victor Nogueira <victor@mojatatu.com>, Jakub Kicinski <kuba@kernel.org>, Quentin Monnet <qmo@kernel.org>, 
	Simon Horman <horms@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 9, 2026 at 5:44=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com> =
wrote:
>
> cls_bpf_prog_from_efd() obtained a SCHED_CLS program via
> bpf_prog_get_type_dev() but never verified that a device-bound (offloaded=
)
> program's bound netdev matches the TC netdev the classifier is being
> attached to. This let a program loaded with prog_ifindex for device A be
> attached via cls_bpf + skip_sw to device B; deleting device A then
> destroyed the program's offload state while it was still attached to
> device B, triggering a netdevsim WARN (panic with panic_on_warn=3D1).
>
> Mirror the XDP attach path (net/core/dev.c) and reject the attach with
> -EINVAL when a dev-bound program's bound device does not match the
> target device.
>
> Fixes: 6c8dfe21c435 ("cls_bpf: allow attaching programs loaded for specif=
ic device")

Fixes: 2b3486bc2d23 ("bpf: Introduce device-bound XDP programs")

cheers,
jamal

> Reported-by: vega@nebusec.ai
> Tested-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> ---
>  net/sched/cls_bpf.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/net/sched/cls_bpf.c b/net/sched/cls_bpf.c
> index 001d8c4ebfed..6d19155becc8 100644
> --- a/net/sched/cls_bpf.c
> +++ b/net/sched/cls_bpf.c
> @@ -374,7 +374,8 @@ static int cls_bpf_prog_from_ops(struct nlattr **tb, =
struct cls_bpf_prog *prog)
>  }
>
>  static int cls_bpf_prog_from_efd(struct nlattr **tb, struct cls_bpf_prog=
 *prog,
> -                                u32 gen_flags, const struct tcf_proto *t=
p)
> +                                u32 gen_flags, const struct tcf_proto *t=
p,
> +                                struct netlink_ext_ack *extack)
>  {
>         struct bpf_prog *fp;
>         char *name =3D NULL;
> @@ -388,6 +389,19 @@ static int cls_bpf_prog_from_efd(struct nlattr **tb,=
 struct cls_bpf_prog *prog,
>         if (IS_ERR(fp))
>                 return PTR_ERR(fp);
>
> +       if (bpf_prog_is_dev_bound(fp->aux)) {
> +               struct tcf_block *block =3D tp->chain->block;
> +               struct net_device *dev;
> +
> +               dev =3D block->q ? qdisc_dev(block->q) : NULL;
> +               if (!dev || !bpf_offload_dev_match(fp, dev)) {
> +                       NL_SET_ERR_MSG(extack,
> +                                      "Program is bound to a different d=
evice");
> +                       bpf_prog_put(fp);
> +                       return -EINVAL;
> +               }
> +       }
> +
>         if (tb[TCA_BPF_NAME]) {
>                 name =3D nla_memdup(tb[TCA_BPF_NAME], GFP_KERNEL);
>                 if (!name) {
> @@ -492,7 +506,7 @@ static int cls_bpf_change(struct net *net, struct sk_=
buff *in_skb,
>         prog->gen_flags =3D gen_flags;
>
>         ret =3D is_bpf ? cls_bpf_prog_from_ops(tb, prog) :
> -               cls_bpf_prog_from_efd(tb, prog, gen_flags, tp);
> +               cls_bpf_prog_from_efd(tb, prog, gen_flags, tp, extack);
>         if (ret < 0)
>                 goto errout_idr;
>
> --
> 2.34.1
>
