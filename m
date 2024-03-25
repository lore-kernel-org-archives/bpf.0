Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D7B82D69
	for <bpf@vger.kernel.org>; Mon, 25 Mar 2024 23:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711408806; cv=none; b=lF1SS25WHSQBNPp5548GOfM6dToK3130qox8iBIcgHsGMgJ5NFQoG9cX3QykzgyRF9YlmKubMx1n4pLLoT9qNVEQHt71HV0BpL2zEDwdWh3KQXOPF+rdoW50dJRdfhyXppbvYrn/e+qyhfp1s0vORnxytSZJ1ulck8AaTS8ZADM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711408806; c=relaxed/simple;
	bh=EAB9kqs4DVTZxHf3pT8YJygMcmIsZZt7COQlFXGh7YY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lu0VRztYm6/3bhQRg/zNlzQUnZx9T9DvAGuE8iEb+0hWwdBJCZARQQSxVdowAF2FwAS1tfpVjNl6BBcq9DFnW0ugOyRQi9PIqlILRtReTWmilwt+XpOqW+RA2VuOVvCfkv4CHFQ/1nnS7ngq7dQ1glExXpQlqWim6488kv/g3GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hfVgJur+; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hfVgJur+"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1dee5ef2a7bso35336585ad.1
        for <bpf@vger.kernel.org>; Mon, 25 Mar 2024 16:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711408803; x=1712013603; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LGQ58VgfOIH3h7dVznDl74Y5tKoIt2fxmUy53cbsSws=;
        b=hfVgJur+5NrKHbaoxyjNORH+X3UYkPocmt7oa9jE6I4rJXXmjj12MnK6mW4huWaOX8
         E/w88nzoyqrwgM0CrAWeiI6T+MttmErjLpX18Dboj6I6PApujKztRypwLGBlIwHMRruM
         RQLXaU39sS3gtcE1GGdBqvRyCbqP+UPK2okwO/sNiecxNlztOEFHgV7nJKKvqowB7SK5
         5Kwh/Dk4laoKu7vOrQOsv8HGkfIGjtGlyg4PjWxpXnS7wzhba6UF/qQNLrzv8omdeg2x
         ABsqoGOiSakocBcalfieySeksYcMDnQACW693oKIqKc9uyb+hvrp3QVRNk95033ZQhIX
         HcqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711408803; x=1712013603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LGQ58VgfOIH3h7dVznDl74Y5tKoIt2fxmUy53cbsSws=;
        b=IKJTLj6ni/2KOXfDWZwe2afYnXWqIo4WWaEuYKKUvDi9p3p1lnMV3GER/CoFYa6wNB
         uee+BwtH5GX/1uHui563zdvWxscqC3AOy2Kg9YtMe5wAZsGr2LwW5wDVAnZW1WBfjxde
         1p3etkKM4IIqsbnqrEW25i56Q/xjWfKdZ5EXy2I8Z2Ers3yo14QWLJKBvJP3I2iwQ8yt
         N7CIS3a08rif0nqcrAyVGye5GXmvtKZbr0PcxJI+xAqPUBVunqPhDBw4BWPxvmgItIbi
         4dkDlMTwuI6vd0PtqR7vzWfmcTeeCQ0TYkwQR2SE1qJRSNC4ODwZYHSoIyHTwnmzhPmO
         bbyQ==
X-Gm-Message-State: AOJu0YyimhCjHA8gQA7rV9DDvv3vFJ1whkaAET2pnzDwDWHUeEq6H/qT
	ZjjL1D6qIdS/a8U7NAjTN3UPBrvL9fuJar2KRrWLacQBnkovzLi76yvbV30Ghx2mgkJDzNL9tid
	oD6BdZMh6ZgYQlH5YnVXTxAVjUG4=
X-Google-Smtp-Source: AGHT+IFOdk0tQQcH62IdQMRql212dRFAyV1x7Ks6bLigtfzFKrdz2T1HbErlcxM8nrr4b2fVmC+v70qYg1nTK1hh48U=
X-Received: by 2002:a17:902:650a:b0:1e0:cd8a:581 with SMTP id
 b10-20020a170902650a00b001e0cd8a0581mr2302960plk.23.1711408803615; Mon, 25
 Mar 2024 16:20:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325152210.377548-1-yatsenko@meta.com>
In-Reply-To: <20240325152210.377548-1-yatsenko@meta.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 25 Mar 2024 16:19:51 -0700
Message-ID: <CAEf4Bzb_3d=+PfaBFCDDOSnU3jwb_W1BaVkgZsF-UcVefysOOg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: improve error message for unsupported helper
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 8:22=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> BPF verifier emits "unknown func" message when given BPF program type
> does not support BPF helper. This message may be confusing for users, as
> important context that helper is unknown only to current program type is
> not provided.
>
> This patch changes message to "program of this type cannot use helper "
> and aligns dependent code in libbpf and tests. Any suggestions on
> improving/changing this message are welcome.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---

"unknown func bpf_somehelper" is one of the common confusions users
run into (and I had to explain multiple times), so this more
meaningful message is definitely an improvement, thanks!

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  kernel/bpf/verifier.c                                     | 4 ++--
>  tools/bpf/bpftool/feature.c                               | 3 ++-
>  tools/lib/bpf/libbpf_probes.c                             | 6 ++++--
>  tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c       | 2 +-
>  .../selftests/bpf/progs/verifier_helper_restricted.c      | 8 ++++----
>  5 files changed, 13 insertions(+), 10 deletions(-)
>

[...]
