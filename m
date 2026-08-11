Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7E043CEED
	for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 11:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786448156; cv=pass; b=kkd+OTMAQ9+TI2ekoK8ZQrrLQS7n6MBU5KepKmtvL+utP5pZRkvIvkDh3jy9bU1V4Gb9MMWyrIWYgEY7PHdsTQwVtgtd81hOxLnvjaR+Yvmyya0N9jfwGFFNlfd6tEPSyDZyNMDcqEwmnHYLy6KCv+FVyQIlyTHtxq3hgocwkkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786448156; c=relaxed/simple;
	bh=sZh3Eij0Ok2+A/9ZSiA4CIhQ+/ECRnDzpFAm/U342+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bItSwDsTXei6o3slVx23UAI9nbjtQtdHcUcOmXeWHOtiNZYmKIShVnemfkPf0KV/cLze4WhyA37d/6oGFJnK79bM92k9pP8Niz516Fh3ta7Z5Vii2C+jR8vTOOe3ovmMGwo4dliPq1XODaGqjfpUKx1rKFxc/1sCy2aWZupCvu0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=sCBTq0Jw; arc=pass smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="sCBTq0Jw"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-84e0688b7e8so2455557b3a.1
        for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 04:35:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786448153; cv=none;
        d=google.com; s=arc-20260327;
        b=Z8JKGGr71iduWcBVIiy6EYh+YXQwOedP683/iUvQxs2368jfUELZOzhS8pEjtYDyNq
         /aUhd0JQaGo1ASXoXOdvv1eRXagvNDr1BtF0am1EiPTArnBPEi4iO3rPBW21wCUtJn4a
         yyqSjse69KSZLA2zj7VWz7Y5UgJFJ4TCqKcb/GiKnacEZL8SDU0wCP1/w6MmOMVheeoo
         EFByeeBRxTiXSnubR478GWYRuJ6W3WSFAlDknBnRMtpMBavnRpK2kBpfN0LzFgOow4TD
         ei531tVgpARTBrc0DBdOB3fmrKIjLp5xxY24QTtFR0nJ9XfRIES0afAwpxqo9jc+CbEC
         WvHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jp9Vd2uMaaGzynTBDdsNCfSLq5DjI8JeAUCgMVAGmX8=;
        fh=9lAaFmmpsn4IwiqvZL31tUSloipi2VktZ8EMocNG6KQ=;
        b=mbL+6j/BsBbX9YSDeNgt3imAkO1y79APasijKWqADvYl6NSb05xfqSeaPD/mhYuNDY
         nmE4fQ1gNReFycY4PpmvJ/NqpuujBs081+uU6+ZT2EEERnx2twI99naMC41yA0waN9M5
         Y2rZ4TEuAkPQf4pC9Un4JKuJgxh8KrEbS6Qbjc6hi6Epej9lFJuhI1EAAhdbylMUJf3e
         fZgxQjlrvSK9xavfQxeMurBtoJ5xaxd+9FC8Oufn3qYE2J4ckEWi3Mn/y2yuw/PITNb0
         tuGaazXdFnyZdT9eCJoDyDHydaVENh7qFxNobmjyMa31BuufDPTLKfzZtEbgw7SkXgwF
         /tvQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1786448153; x=1787052953; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jp9Vd2uMaaGzynTBDdsNCfSLq5DjI8JeAUCgMVAGmX8=;
        b=sCBTq0JwlwdrNWiEaCnUh3MHx6GQvc3QfaorCzVP/lRtKVtr1Jn571xXOZpbt/t/2b
         1gq57XvuFZjnb4pZk2UAAqrV9YvoucNpmsiSJwoL1elx+gBpnTjWEZ5iyo6JRXqMkppi
         vsuLDBLEvR9amghYYJfvCps6GYT4MLyPqjw20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786448153; x=1787052953;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jp9Vd2uMaaGzynTBDdsNCfSLq5DjI8JeAUCgMVAGmX8=;
        b=myaiyESpW+0abaf2ZxmkRSkx8bemjnQZg0yO5xW+dOfO2/5JC4ZoNG9DdiYm8LICHO
         3itG0qLWQt9Ur8UFvd0+IwhlAyvWzjLmRe7NROcibP/GpqXUmsp0UB3l+6h3poU9qZHY
         ykq3Msjv00MpaqjZ7m4TXvPFd5vZ4riKpTSBi+PQ70+YcrX5Nu2FskLf9UN9Mhu97Kbp
         8WhdpIue5sir2BnXGTe7HAdciLtQ5EuHOs292rivfGWi19oCzJUcNJtfnjxmmUW/otnY
         QqYKJzQifn6ejm0Qh91+hDWuxm1IPurJY92GBFALfoNyKqFqBJ3HPRpfcX7ECT9s+6MX
         OFhw==
X-Forwarded-Encrypted: i=1; AHgh+RqsHkGCOE3zzHkMrFmOIJGpuu90dZOjBgexTvL0Vw2EsfwxONhnnMetjRADeojTokbgyRw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo8ds/zy8IhCzs4NxYR0b7C0fP2luu6rFLJ4n3ULXz8bJ/bJK3
	YDe5v/VfGvxcPBRs4V9gIFEl0sqFaqhhzR/MkisONGvJdC5pRz123MszFwkXnGy4hgTiEOpyrJk
	8B5BQduN1TxFRS2wjC9ngWaSuNzboO7qfCffxj6d6
X-Gm-Gg: AR+sD105aW+3mr5FhBJUf/M0GyIjsfdn2sZ7nG6Gy/odHCeI70lYLm8LuMN1mFTqfg/
	0r859EYMbqPRLeu3lhqdSNfM6TUZ2XEnSEXjI/iVw1v74FlV5/e9VYahkMLhV9z2HBaV7uDhziQ
	9st79xsoXZoPRYvNYuSg167Ede1MmjUHYZBv1LToRMG/DnvyOaFTj7dKQKJDdgJtHxUusVIIiD+
	ixaLhXWXlQ5hW8dl5Ih7WymAv7nk6ZAB3GYaes9E/YAaCPOWI7ZybhJyKBbiJHFLg4ZZSPMqtm/
	Y/+JgB18CPF0EHfh5iO6fg6t2R3WFc8VTDf6ybwvFEFzmg==
X-Received: by 2002:a05:6a00:a21e:b0:848:34ad:3d6c with SMTP id
 d2e1a72fcca58-84fa8695cc8mr2102850b3a.15.1786448153575; Tue, 11 Aug 2026
 04:35:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260809094418.901607-1-jhs@mojatatu.com> <20260810170533.5bdc7f80@kernel.org>
In-Reply-To: <20260810170533.5bdc7f80@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 11 Aug 2026 07:35:41 -0400
X-Gm-Features: AUfX_mxWkTu9exAYFDwYL1OJAhg4ArY-lwr_Gk_ito2JtRWdYlQYdALEs9Pt5a0
Message-ID: <CAM0EoMke_qk2jJdWW0rHvZcwMNd7RCG4xGkpNYZpPtrSKg2Q3A@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: cls_bpf: reject dev-bound programs bound
 to a different device
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, vega@nebusec.ai, 
	Victor Nogueira <victor@mojatatu.com>, Quentin Monnet <qmo@kernel.org>, Simon Horman <horms@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 8:05=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sun,  9 Aug 2026 05:44:18 -0400 Jamal Hadi Salim wrote:
> > cls_bpf_prog_from_efd() obtained a SCHED_CLS program via
> > bpf_prog_get_type_dev() but never verified that a device-bound (offload=
ed)
> > program's bound netdev matches the TC netdev the classifier is being
> > attached to. This let a program loaded with prog_ifindex for device A b=
e
> > attached via cls_bpf + skip_sw to device B; deleting device A then
> > destroyed the program's offload state while it was still attached to
> > device B, triggering a netdevsim WARN (panic with panic_on_warn=3D1).
>
> maybe netdevsim has a bug then.
>

Looking closely: You're right. nfp guards at the driver
(bpf_offload_dev_match() at
while netdevsim's cls_bpf path checks boundness, not the device match.

> > Mirror the XDP attach path (net/core/dev.c) and reject the attach with
> > -EINVAL when a dev-bound program's bound device does not match the
> > target device.
> >
> > Fixes: 6c8dfe21c435 ("cls_bpf: allow attaching programs loaded for spec=
ific device")
>
> This commit in itself is fine, nfp checks that the offload matches:
> https://elixir.bootlin.com/linux/v7.2-rc5/source/drivers/net/ethernet/net=
ronome/nfp/bpf/offload.c#L579
>
> Maybe the bound-devs got extended for JIT / descriptor access, and
> that added some extra risk here. So either this is netdevsim-only
> (and not worth the Fixes tag), or the Fixes tag is wrong..

Fixes tag is definetely wrong. 6c8dfe21c435 was fine for nfp; the
semantic shift happened from Stan's fix in 2b3486bc2d23 (made
prog->aux->offload non-NULL for dev-bound progs). c0c6bde586c7 then
fixed netdevsim XDP but missed cls_bpf.

It seems a v2 may be worth it:
fix netdevsim's cls_bpf path (Fixes: 2b3486bc2d23), keep the core
check as defense-in-depth without the bogus Fixes:, and walk
block->ports for shared blocks (block->q is NULL there). Or drop the
core change and fix only netdevsim. What says you?

cheers,
jamal
