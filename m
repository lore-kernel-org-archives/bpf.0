Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E122A3B2FED
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 22:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776724138; cv=none; b=C9QD0Z7MlECm4LPNdY8j4sgNcwu0xbvBAqr3sajl0RWjRTyaZukT27dkV0zmpuvgHj2f57KY9nqHd+pamluUoa5jzk83YDL5ZvD+dRJ9MLt+92LVV6c0Gy2hTxw0xQcULe8JXMoI2+0kASkZXU/yAdci48d8TO5O2ra8Aa+yNmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776724138; c=relaxed/simple;
	bh=wJhs2Lbicy9aDSVO1+854TqXxNpUkhWijKOaY4DlzoE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IPPMeR0PKEhikMWjUrZMu33mLbGK5R2IXEqZmJJO/IM/ca3PKrPlk51uO6gCWaSVdbB2++Upps+KelZHAJ53qk5zYDjEEK3InmewKXmSjEGH70Vfv0pOhCK1KMWor0Lbi70Ua/bJHpJEdMAW2eZe71YFYjLk8nZrnsOV21d2Gwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d36gL9I+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d36gL9I+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9895CC19425
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 22:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776724137;
	bh=wJhs2Lbicy9aDSVO1+854TqXxNpUkhWijKOaY4DlzoE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=d36gL9I+Vaw5EUAqIlgv2ardFdWQVS5BY9ojthwdtsE0i6v/d/ouL5w0HIMv7Y2jG
	 GIr7P/12A4qWukobXaYSP/ouY3wBaGLmyC5Di6kYnIHOs6vUx8noxcKtM+QcbLQQcN
	 r0zGaLVYSnM3bJ717PL2+FTyunPN+PRwljEQT1+tC4/Oik1vDjQZ9qkHh/m0m0ncgz
	 QlZFmNKDS5R1qaKhsjF7HmulpJ1GK+C4hO0wx/NmDwd+p0Y0Wskeg6GGyZqBJmWvJr
	 zmLU/ZYkI1dtn1TaC4vHtzINsStuOP1fIazq0ivaslTrC+nmk5guKiNVpPOC5PP2Y9
	 B/7m1r9TH7IUA==
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8a3b0242631so45496606d6.3
        for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 15:28:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8vUt3rCtDLdNjYoBVmH+XGL4taAYPvNuCMH+KtA56Xwzx4azrMm5BE0XQr99Ldl1AydbY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEjGpu/e/A0fzIVxsHK+3g9mmZ0Sn+yYGfMzXmeZKpKjDneji5
	CA8f2GVts1eyiCaLmtWRyRYrfc1JlTjUzt34NvcOcKBkX450FDDLuEJZ06UNGVaRpXDpYcDzZrZ
	IRnbjY7pHbNUDEUklQSVKtijyS9DoeJ8=
X-Received: by 2002:ad4:5d45:0:b0:8ac:b48f:9fa4 with SMTP id
 6a1803df08f44-8b0280f0e02mr260694556d6.35.1776724136836; Mon, 20 Apr 2026
 15:28:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420203306.3107246-1-utilityemal77@gmail.com> <20260420203306.3107246-3-utilityemal77@gmail.com>
In-Reply-To: <20260420203306.3107246-3-utilityemal77@gmail.com>
From: Song Liu <song@kernel.org>
Date: Mon, 20 Apr 2026 15:28:45 -0700
X-Gmail-Original-Message-ID: <CAPhsuW74Cq2W9-7OHZA_XEuHv8iXsQfoFb2=kdnOxui15RFxpw@mail.gmail.com>
X-Gm-Features: AQROBzDN9jB0SQheYEfF4ukpBUNhT-66zSq8tJ0Tjw3D4sEFvvRFZe4jx-tkLQk
Message-ID: <CAPhsuW74Cq2W9-7OHZA_XEuHv8iXsQfoFb2=kdnOxui15RFxpw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add test for map-stored
 struct file kptrs
To: Justin Suess <utilityemal77@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, martin.lau@linux.dev, yonghong.song@linux.dev, 
	jolsa@kernel.org, bpf@vger.kernel.org, mic@digikod.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 20, 2026 at 1:34=E2=80=AFPM Justin Suess <utilityemal77@gmail.c=
om> wrote:
[...]
> +static void close_fd(int fd)
> +{
> +       if (fd >=3D 0)
> +               close(fd);
> +}

Do we really need close_fd()? close(-1) is allowed.

[...]

> diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr_file_fail.=
c b/tools/testing/selftests/bpf/progs/refcounted_kptr_file_fail.c
> new file mode 100644
> index 000000000000..7adfa6645801
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/refcounted_kptr_file_fail.c
> @@ -0,0 +1,35 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <vmlinux.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +#include "bpf_misc.h"
> +
> +struct file_map_value {
> +       struct file __kptr * file;
> +};
> +
> +struct {
> +       __uint(type, BPF_MAP_TYPE_ARRAY);
> +       __type(key, int);
> +       __type(value, struct file_map_value);
> +       __uint(max_entries, 1);
> +} stashed_files SEC(".maps");
> +
> +SEC("lsm.s/file_open")
> +__failure __msg("R2 type=3Dctx expected=3Dptr_, trusted_ptr_, rcu_ptr_")
> +int stash_unref_ctx_file(struct file *ctx_file)
> +{
> +       struct file_map_value *mapval;
> +       int zero =3D 0;
> +
> +       mapval =3D bpf_map_lookup_elem(&stashed_files, &zero);
> +       if (!mapval)
> +               return 0;
> +
> +       /* ctx_file is just the hook argument, not an acquired file refer=
ence. */
> +       bpf_kptr_xchg(&mapval->file, ctx_file);
> +       return 0;
> +}

We can add more tests, just like task_kfunc_success.c and
task_kfunc_failure.c.

Thanks,
Song
