Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730F7289824
	for <bpf@vger.kernel.org>; Sun,  1 Feb 2026 19:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769973982; cv=pass; b=qC7bNViIwxT9TVy9eLLUbGSwyA74hExDhKXIMtIx8QGIGZof24NAEGLFzZFZ6hxcjq2AgeVVCs0HqQhbsLwq9lIkjXZspRYrZgvt0N60UHHt9GiVCCZ9wOPkpiTrvCePtxwxNgJlfuViSXWsdzdEWyWSGOnn9UzMJI94Egj1XfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769973982; c=relaxed/simple;
	bh=p8bLIrBx6kv+n96MpAC+4i+uibsOKlLDSvQEb2xfiiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dQdv5jcDTao7t+v7UpDsxyak30bJ+lRwCZdNp8xgM+Cq4QLXYSRI2/YibJQvZ4zzN5Du1qykpw4Vua2MIBtE4h2hLJI5+QY0bzKeZTL/dzVvF+S+Y58EdAhIJFhrvu4AlqJ21Uue4C7mEVI6SpkFvxPzVP/CClOfGl54MP3t9uY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AYNSB/pp; arc=pass smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AYNSB/pp"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4801bc32725so27399265e9.0
        for <bpf@vger.kernel.org>; Sun, 01 Feb 2026 11:26:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769973979; cv=none;
        d=google.com; s=arc-20240605;
        b=IJdvM9HZaG0W0b6boSmHYDWLn6Y1aQkkNboaW5UMw1gvwT3pT0I4Y6nQMQWTKkvqSd
         bAB1bcJSIAr+buJ39PVUEb156FKp4TlocMevrT47YyRDkzpR79Zjxdm+MnPheksNMdUX
         9dgkwZ2kLWgopGGIeLFAad3d6V4QFJ8vGFQf/t/fEo76psmxGPkh+xlaR0K3dBIT44Ac
         Iso/PQ1omrY897jg1C5fBS6WTO1uYxDlZc+u1oi8mfshrs515eRIbGhP/gu9PvzaZvnb
         loQBAoK8Wg038GBRE7R9h57/uEBK36baCPPBAvwCCLQdz6c1CQBgyT+CQWgyjx94V+XF
         X4FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6U/8WpOu1MpAFYAYPVkk7MHYRqo5kmK7sjLK0gmV+QM=;
        fh=bmcT8YpiIIQfZlTkPn2nphL4UQ+G3p1wMlzJxY+Capk=;
        b=LWqKlKfuOgDYfysnh10mFMEue5Adklp6/K8RqaVBXcx84qsWj4/QwjFtyd1tDxUaMi
         OcnznqCpZj25sa98yIMmUlwG/NQtWkuqFbm1X5Q52o5mn11m7Ovba78qLBAPyQb+3ckn
         Yv0TG9T3W56b4uD744v+1xmAcmUFNALkiLzETJ0tc6uMxZJOJrhmp7fZUvXsBj6nAPxc
         NY3pV3OXiAH7OSN7xHa+lN8a5po2V03wsxku/vnTPANSrOhfgzhPPFax/slvlL20MIDy
         UvLGOKnhw16xUdlAgozVUclX34GDRnrZxs566z/jU63DT7Lob6zeM9uscCbdhTwiAKvb
         2k5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769973979; x=1770578779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6U/8WpOu1MpAFYAYPVkk7MHYRqo5kmK7sjLK0gmV+QM=;
        b=AYNSB/ppe0+Jhd5qCKCeUo6HTJMHae88v0ZGvjWY0X/hq8ysL562I1RfBiEU8W3R3N
         MPmJ1fKhFVlEdauvnW9yFXme3GFJ9oowYjrCySWIup/5OrLFvroX4O+dKkVP2O14id7q
         jNBo2z9zxDY3XEfo4LGqNKmePlZ2fJwMfJIO9xUToZMytyI2nWqcs1vyTIUGxAzXvXD9
         /pBvymBNG35WT939XiOSoh8LxBvLbzYWBvtvEQ9tUahexJ3Pso9upyKXYniP1izskEn4
         Y34AWNx7Otr3DkKZoNfL6p1/J3etD1S9KvrG54vg8ZyUZA5JP+ZKbX3dRo7ffwc2q8Kr
         3tXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769973979; x=1770578779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6U/8WpOu1MpAFYAYPVkk7MHYRqo5kmK7sjLK0gmV+QM=;
        b=WcQroyJ42ymPWmiUV3Smhbxm/RdXKqQxSXkX1G0GJOUaYIG3UZufCfVlimYo70qNYG
         ThhZiJ5q7Bvv36t4OPRrXPzc1ZYHQpFucUgNHBfo2qaLaPeslH6MGPMa5zGUd9SrsFDP
         J3E6NVQ8E0dUzYk5a7b3RHLyDdEPmWbOWws0mvw2N2ZJ0IRxjjQwneBHvmRCeJUdgp9R
         s7JsXMIOCSN8dGGsovxk2OFCQvS6JvJkxTql5SZmoZ2bevhIqAJ9OGQ2w1raT+D7a2x1
         s/8nzco4m7SqVOVl6k+v0YYTJP7rKibXcSLpPUmhuXaA0nQaKw4sY4LoDabqT1S9UDQB
         qTQA==
X-Forwarded-Encrypted: i=1; AJvYcCXZ2FvlZRuB18vLhYucmXCV2NCBAUrw9fei9p+Guw/ZQyrX2DLiMAfTzCPQvd3ugVguxNg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/hX5QW3JZzwGFWP4q5mX3qCXm0VJLBGGgZZL2jEGBolyYJEiq
	C4zCDPShkvsm30MbxVtnrWV1rwXRk4vp+TpKy6HE7mZIsTOMEtlbD8uOQZVkJ1w3n35gg2yAZS6
	4/yroknyUii06WZVg53TXd9URRfpM46k=
X-Gm-Gg: AZuq6aJcZoBVixblhOFzCDLgSoAzOJXssALBNdpvzQwtFzHFoUFwNO4wf0ms54C/1zH
	pEaC3qsIdsL8VWtoUKdIFsrxiBY69sD8RLtmiWsiyIy1mFksoLFvWgHzTcb6hesI+sUGR9XJPCU
	sNHz/6oWvME33/5ArWvlseiJseIvqTxWKJ3T7FEO2uwEHi/MXZTVsHjSashJpRIX+tnBgt3ozG4
	8zDKyf3e/eGn/Uf9XibYW2jf+achpJt7vHHyxAFCkGb6NSzQKQNvPgDBIV/njcI20rRGGXSobV7
	ueIXVtgkfVmS8llYMNZVT7T4b+NO3OpiC5PC0LHJNRk8M9jzHUIADXRF+59rAWlnXEIVEc1s8JF
	5Br7vV8qm9xigiw==
X-Received: by 2002:a05:600c:1f16:b0:480:6941:d38b with SMTP id
 5b1f17b1804b1-482db4a0207mr125661055e9.30.1769973978636; Sun, 01 Feb 2026
 11:26:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260201180445.664056-2-thorsten.blum@linux.dev>
In-Reply-To: <20260201180445.664056-2-thorsten.blum@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 1 Feb 2026 11:26:07 -0800
X-Gm-Features: AZwV_QixrNWMacK37HeAKJR3bQsqyVDzalwwR7LS1k_ZGc1tpS0KUvo5BTdXVIs
Message-ID: <CAADnVQ+2icTvHkt7ci285azpci42-8rZ0Air7KtSAmP+bF7m_Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Replace snprintf("%s", ...) with strscpy()
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 1, 2026 at 10:06=E2=80=AFAM Thorsten Blum <thorsten.blum@linux.=
dev> wrote:
>
> Replace snprintf("%s", ...) with the faster and more direct strscpy().
>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  kernel/bpf/btf.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 8959f3bc1e92..72fa0cb1a71b 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -25,6 +25,7 @@
>  #include <linux/perf_event.h>
>  #include <linux/bsearch.h>
>  #include <linux/kobject.h>
> +#include <linux/string.h>
>  #include <linux/sysfs.h>
>  #include <linux/overflow.h>
>
> @@ -1210,8 +1211,7 @@ static const char *btf_show_name(struct btf_show *s=
how)
>
>         /* Even if we don't want type name info, we want parentheses etc =
*/
>         if (show->flags & BTF_SHOW_NONAME)
> -               snprintf(show->state.name, sizeof(show->state.name), "%s"=
,
> -                        parens);
> +               strscpy(show->state.name, parens);
>         else
>                 snprintf(show->state.name, sizeof(show->state.name),
>                          "%s%s%s(%s%s%s%s%s%s)%s",

I prefer to keep snprintf here for symmetry with the above.

> @@ -6324,7 +6324,7 @@ static struct btf *btf_parse_base(struct btf_verifi=
er_env *env, const char *name
>         btf->data_size =3D data_size;
>         btf->kernel_btf =3D true;
>         btf->named_start_id =3D 0;
> -       snprintf(btf->name, sizeof(btf->name), "%s", name);
> +       strscpy(btf->name, name);
>
>         err =3D btf_parse_hdr(env);
>         if (err)
> @@ -6443,7 +6443,7 @@ static struct btf *btf_parse_module(const char *mod=
ule_name, const void *data,
>         btf->start_str_off =3D base_btf->hdr.str_len;
>         btf->kernel_btf =3D true;
>         btf->named_start_id =3D 0;
> -       snprintf(btf->name, sizeof(btf->name), "%s", module_name);
> +       strscpy(btf->name, module_name);

These two are fine.

pw-bot: cr
