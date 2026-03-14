Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22581EA7CE
	for <bpf@vger.kernel.org>; Sat, 14 Mar 2026 02:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773456151; cv=pass; b=bJ2z1O18yBO6KzukwFNTUJ4+X5+lzV4ZsNLW4GSm/D3kqgdSddTR7dLk5oJUCkonFF5HES92Ct0q9E6TZEgWTPpzmvQLy/ZbMjGn/cUu0Ae7TFpchDBj+V4kzto8jIB2/2oSYebNSnpSPs+x6eeXLnlUoYS52Sr9iB365ZUyYVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773456151; c=relaxed/simple;
	bh=5efamlu/6h5TA6qznlB6+GKsMaEIxOQX+VH0GW13OvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=izMi0Kj2+HyhzJeLfy8NyMG9rHAJzTvbXhXq2ncvR24LuNgmyjAV8zF88BYfkeLiwrKprguw61wT3GrRhHrtIK6o38npldVnHGKCsaK9inkAdyZuIBrSc7MJLsHr8qKgQd1w3KTFM5A1bQ14wahYm0fb/cPBWrx5Z5v6dGhcUeU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dBDdoy8q; arc=pass smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dBDdoy8q"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4853e1ce427so31262855e9.3
        for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 19:42:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773456147; cv=none;
        d=google.com; s=arc-20240605;
        b=a3kT0KjiC0qdatDn1IzpXRvYph8mMzQF317zSyK2mRo8oONCy34UDQpyXh4kGk9G/2
         IratHYdfYuD8iygtnf5wak0/a/rnvG21Qj/IXCVNPwzYd74GyeebydwUIKkJGXNrkHZt
         NpTbxeTs/Talbq8edTrp79zv2PwySJaZ5xGLUwIXk0OGjjEydd0Mnrq4zOJ8x2VYwfk6
         D51hWe2b3XNQPiEJ6gh8h23LrHWjgoc0pxyDY7dUT1tKS+Pb+PYfRBnuS9JAk6UXk3dD
         vm4XL7BTq6fy1MIFCEWWv0FkbISov8OtsZxHzFuQf937cf19TaFNOOD+lU4sDDLT3Pw4
         ASfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oJ/4Kkexba+G7whq1UxwvFb4fZjvu7eByDNhfOE+P3I=;
        fh=1xKJTFGHE7egQ5db5R3zmxkKwDnjxmqBS1OJfbAT+C8=;
        b=PcPcQuzV9jqnK18WlbYYj/4ZMUKNxOrZZyUTcyjqWiEK1DKix5O9Gc8dq28WR7bPrD
         O7YNYHBgkKX9Hnak0t6Cy4i/BXbKlwC8nj8Et3oxINzhnuWUuES3aNGw60DklDwossf1
         JbCysgRYKA2h1gci9g2NAQOHI23+GlV/s/HJsi+Cf5Gl70l2i4yWoUMmViJPw/AjuptA
         opbHBrbyQ/ar2hGKX3fSamKl2UgBMkBD9tv/TvTgkS0smFv9dogh2VanY0ZSLlPF6rUf
         ItR+pwEaroXD3cZdB5l5D5SjVkjjJZzNTWlSD8EuUVG/xPqc3RmA6exsxpUtBOV6WPQX
         Vh4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773456147; x=1774060947; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oJ/4Kkexba+G7whq1UxwvFb4fZjvu7eByDNhfOE+P3I=;
        b=dBDdoy8q0iJvGD9DRshvqHzTKrCkIeDLjXaA0Nj/NLEXkjC4nOdWR0BRHIIV8mbth7
         NLt65FIhJ7aTQRbaAqhCa1wTrGefv77M2N4dTAATfvdLUPggaRbqavOG2FOrJXQIBqiG
         +442WlXBqZv3TCIKerGiyT0MkAwCp70g53NX23vjoXb6F4lMef0IRNmuEr0pp5r5dCHN
         tpgabsWd3UB6I5JxI3SJqk8bo37Z3kV7qd2keZRAzfZitds4geOTssjWy6DFPTDSgma1
         yVI3vRBIADufOx0RsywAWH6jUiGoPhpB+L1q47dZ6ecYwNEjc7FmdzlW/q1PZ4QBwR5Y
         H6KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773456147; x=1774060947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oJ/4Kkexba+G7whq1UxwvFb4fZjvu7eByDNhfOE+P3I=;
        b=fblm5kPitjLlHNwTWeO3HcD/7jsHwBhrXR5nw4Ri7pDPKtFS98AavuUe6WaooZ2ZU4
         bjGhOqb6mrv7/NZ2wh8MxuE0rUUCmm1i67ndDN2JMLG8FVH6gJEKLes/tR8L/GrEMdo2
         SfMb2U8wxE+tVlmDuW0U9FImmp+AjHGj5BxxEhPxhdD39jWpB5gpKa3k9s31GLUyDc5t
         hKN94EsJ+i1MjvJLZ0SHTWIdmZuDS8Rz3+978Vq3fUnIzWWWHTfJkfNs1Mz8LujZDsrU
         OMeOuAU1aCMhCxbVcO4V96jwTYbHZN0KKZ3XaBzwcBHm52Z/FvMTwcEEWcCunvElb/q3
         8tiA==
X-Forwarded-Encrypted: i=1; AJvYcCUrP8pl1qkIyFasQfB+Z/77hZuC3SE1pBpjB3exUVtpBVSgRPvGlZdcPLb9Awfe4tFRHTY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0P4SFio6fGv0iwYM56/8qwOo13dwiBjk0noiibReZWKiUHWww
	8YbsATVMvUkhLJWQYGVXCZwDBlG17OQa4dMYMzdREmcR4525LBYC/2jNMuzTJswsThEZD1wVH/p
	9D+6659gqn5Pl4stjJw41L5Gf1n3BPWk=
X-Gm-Gg: ATEYQzxCYfPNIewIivVYAAr3JGfjMDMpl0TySOgfJd5LCL5VXx+sN9ZD3Q8DvdCR8VR
	XFJODKp9kAY/XFbHPACtjmGZMJ+raL0jqRlmCMFZzQbC1vKVfN1h99wE3EzvCG8EDThb08hjNmT
	5w7R9JeiLyCNRGbRNn6mfYc+YWEgr2Ahd2oIHIhUi8SAZ6FJqnuAV4Hv+9JPlqlAB1pwfPl31uM
	nYyasCXDm2gdKLCPY9CZSlpQkT8hW0HI5IN/GJEXITPFbrwIHTXq5gABtmvT9uYsusHS2O5ujNo
	iEQ0Mtvf1VAqiTtAtIqKfWFRngK1ZjyZhAnK2Z8IM0/+PKIiEwg8KyXEhMbPBlaYgmXa261pjeQ
	UxA==
X-Received: by 2002:a05:600c:1d1a:b0:485:3d00:efd with SMTP id
 5b1f17b1804b1-485566cfacbmr93486995e9.7.1773456146954; Fri, 13 Mar 2026
 19:42:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260313130220.18590-3-slava.imameev@crowdstrike.com> <4955a2c6a7fff7f4e383149e3b699a2af5eab965e414f3f19443b1caa97ba53e@mail.kernel.org>
In-Reply-To: <4955a2c6a7fff7f4e383149e3b699a2af5eab965e414f3f19443b1caa97ba53e@mail.kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 13 Mar 2026 19:42:16 -0700
X-Gm-Features: AaiRm52oCGV0a1Sapwhi7UF0cUrBG8nmXyaBC9dXPLJgEdUbmwHD1ZVrTgnP0U8
Message-ID: <CAADnVQKcutn9QO4UjfcnPw+Tnv2pmHavXCa-BC083rrgP8w_ng@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 2/2] selftests/bpf: Add trampolines single and
 multi-level pointer params test coverage
To: bot+bpf-ci@kernel.org
Cc: Slava Imameev <slava.imameev@crowdstrike.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, 
	DL Linux Open Source Team <linux-open-source@crowdstrike.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Chris Mason <clm@meta.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2026 at 6:55=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/tools/testing/selftests/bpf/progs/verifier_ctx_ptr_param.c=
 b/tools/testing/selftests/bpf/progs/verifier_ctx_ptr_param.c
> > new file mode 100644
> > index 000000000000..b507dc850543
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/verifier_ctx_ptr_param.c
>
> [ ... ]
>
> > +SEC("fentry/bpf_fentry_test_ppfile")
> > +__description("fentry/struct file***: struct file *** inferred as scal=
ar")
>
> The description says "struct file ***" (triple pointer), but
> bpf_fentry_test_ppfile() takes a struct file ** (double pointer):
>
> net/bpf/test_run.c:
>     noinline void bpf_fentry_test_ppfile(struct file **ppf)
>
> Should the description be
> "fentry/struct file**: struct file ** inferred as scalar" instead?

Pls don't ignore bot reviews...
Do you agree or not?
