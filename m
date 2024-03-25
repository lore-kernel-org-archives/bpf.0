Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2185C8FF
	for <bpf@vger.kernel.org>; Mon, 25 Mar 2024 17:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711387298; cv=none; b=UZGdUxrq/oB6kbNRG+/IYKKOTsQY96d4HMe+6t28H7S/WiB3rdJWjO21K0Ucgynrw4ySHNHY446Gok/hijuPnbU7OF+rKHG0jrbr/QzuEMwphWHxF3LzJn2sdj6BsPlfTE8lXxqVUHpvngYHHu7VAgpf65jHuTnC7OuiZIHH/BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711387298; c=relaxed/simple;
	bh=0H+MvSydGiSEO3ytRVXDd82d0wGg5Be97El9yqwiTGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lxm86xlyxYzNEw26IVfe9g/ZSeLzr6gohjE3us9kkWbgHURWXi5BdcR4KLmq35LBuuFA1SrrEY02/uhTT7zSnmozLy/RVflmE5tuBysovNwqiA1Bbs/SgFeU36aluZ6b3gP+aOM+oaZd3QAdiTw7iRqfp79lUZF3gN1480xea3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aVyQnV6K; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aVyQnV6K"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33e285a33bdso2540800f8f.2
        for <bpf@vger.kernel.org>; Mon, 25 Mar 2024 10:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711387295; x=1711992095; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YvWUmbB9X45q2JWxyFPcnJvsoPnMSCjnd0QA3FVbJco=;
        b=aVyQnV6KOo7TNrLGbt/XgZmKPLOC1TOSVGph+WKLmlYxaquQ7fzVaCPn6h1ODJgCy9
         VYFTbW97HjJfAOs4UtCdU2lHL7moEqPRP0Cjwq/vs6233CzmsN1s/mYwK+KmpkmaOf1C
         23uOVauX7jLdkXDu7/5W9j4YmzPRZQ8Twfa4xBwE0gidg+YqbJWQtDAfGqInjIwThzr9
         ejrqrVIWyD5nUuabgp8SUtCrTay+i2dmluiLh4O7TMQCTISc8RnhifX1PdymaPveR0ov
         U9VGqQyfqwcJXqOpLE+NS3Oy0hWw+bVrsZmV/W1ETFoEC2j9LF6UxrudUh+asjITz+v/
         /GHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711387295; x=1711992095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YvWUmbB9X45q2JWxyFPcnJvsoPnMSCjnd0QA3FVbJco=;
        b=FxWjJ94LIQcFXrjAYwZAG6+91XRW3HbDD8n+hxlsAbsMX5BlsjeX/qoUfdIKyWq4bP
         7Ox55j1zDXeZeA89YQbfvvXNIIot1WOiX7kicQWAP31w2s5GFdRURqG0V7uCMPn4nHdI
         GYKLWAuqbjBfsKEEeDGzcSCr1SyIwGEODGjss7qssUB5izmcsoglz6Oz1XBSZsxu+55O
         c75u3Xj+OO0/aWC3dHLYprrOCA0exo1ORRwxjG0EE7gGcdqdNPZmYUuIkcon0YgQ6iiw
         g+/9oSMm0wLK+sfOCL12xZv1mVQKnEJwLxH9qeELj8mm3/3AQ9wDaE1XOQlI5vV3dHje
         TfPw==
X-Gm-Message-State: AOJu0YxNWDtJ5LKxQ9hPhLKQOSAIWuopUDpsdzP0iiI5NkjoBmX94zQ+
	RO1uUINwcCwz/F19Cf0+vcFM1AwPjn/HSPTjHiFq+WMhtmhemdPx/ZXr1rJJIxrfLJ/17W7B2WS
	7vm0eHZ/hgjFKX38E5fd9PLRM7d8=
X-Google-Smtp-Source: AGHT+IGwQUI6bQagClnRHJq/vJwUustoygc9tVO0nvdpgtlKo8ZPwz7sbHub+wbjimCLTygmhM/lFYBtpw50JUVjobo=
X-Received: by 2002:a5d:47c9:0:b0:341:751e:49b2 with SMTP id
 o9-20020a5d47c9000000b00341751e49b2mr6639142wrc.32.1711387295542; Mon, 25 Mar
 2024 10:21:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322000041.2919948-1-andrii@kernel.org> <20240322000041.2919948-3-andrii@kernel.org>
In-Reply-To: <20240322000041.2919948-3-andrii@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 25 Mar 2024 10:21:24 -0700
Message-ID: <CAADnVQ+pTK9_BF-wPyQBuzK4wUtraEg64Kee33w0d63iqQuiHg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/6] selftests/bpf: add batched, mostly in-kernel
 BPF triggering benchmarks
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kernel Team <kernel-team@meta.com>, Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 5:00=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org>=
 wrote:
> +
> +static error_t parse_arg(int key, char *arg, struct argp_state *state)
> +{
> +       long ret;
> +
> +       switch (key) {
> +       case ARG_TRIG_BATCH_ITERS:
> +               ret =3D strtol(arg, NULL, 10);
> +               if (ret < 1 || ret > UINT_MAX) {
> +                       fprintf(stderr, "invalid --trig-batch-iters value=
");
> +                       argp_usage(state);
> +               }

...

> +const volatile int batch_iters =3D 0;
> +
> +SEC("raw_tp")
> +int trigger_count(void *ctx)
> +{
> +       int i;
> +
> +       for (i =3D 0; i < batch_iters; i++)
> +               inc_counter();

so it's passing the verifier due to bounded loop logic, right?

Then let's limit cmd line arg to something small instead of UINT_MAX.
Otherwise users will be surprised by the errors
coming from --trig-batch-iters 500k
