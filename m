Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03CA1C0DF7
	for <bpf@vger.kernel.org>; Fri, 29 Mar 2024 16:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711729152; cv=none; b=jVuUijhidgkCl25TSh4FDodgfw7fxQibsd+voLDhBhOm+Xm57uqPNpqZMYXs0LeCjhuJeY6zTWh/0bSIg9sHFBaNQ70M5TkqGyzHEWyZeuxKYlczQnJhKVmbo+3DwR6WuyrR7+AnhlZVoz6BMmbyI4k/pmHkySBGnplU6FeAVNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711729152; c=relaxed/simple;
	bh=bTCgDf8v8hhAMB+7Tw2Bogqq+WrRGKIfGkYPxT2mQdA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FgNJjsKRp54V0laPK12m6K4c8AKL5oRmuRxc3sFQSw49s8cp48gIgI6qBNIuG9+D4ZkZDn+DDZuJiaNFKOM5Rq3BTU/t10M/RQ8lXipWB6x2kLO+K938fAhrwjoMROjEM7WuUUrHGI4ebDw6M4F+kKrOUzKKWhMC1Lmz3nCUCAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VGXfsgw/; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VGXfsgw/"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-515c50dc2afso2263586e87.1
        for <bpf@vger.kernel.org>; Fri, 29 Mar 2024 09:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711729149; x=1712333949; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qCcj23TZnRBGPjU25RXJ7SbidW38jwXoEo4zR3aU1c8=;
        b=VGXfsgw/Vz9cNxrs4SH7Q1hlM+PHmijpBcjQL+nFoz6orsm9+uYf/4dtBq4+lWtVXH
         p/GQPTBuoA6eS43uw8eu53abPF062tUeCvH9haavEMe/cURJ0wG3bquRXsUryBTck4kC
         C+mmVYc9mRXuWnllpg8AJcAXpSnUnc1+9iXHaaJCiKCAakqvzsjB0IvxwbO45r1o/OJc
         M/llpc7BtQFIdVFKfWtw1wFLKgGGbdJycSkd0Pwpi7UMQ7n0MZmFH58Z94OUT1ccwtsz
         r3FyzHRrJpXErO/4YovHynuXbWtRA925FFFcscZVh8bB5lH1gT18+HAbnISmcuP+Fmlh
         1V+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711729149; x=1712333949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qCcj23TZnRBGPjU25RXJ7SbidW38jwXoEo4zR3aU1c8=;
        b=qj1bD+gAqczCEv5jFNvZqceOLy5LluTvkGQhnkxesQbnvn3qZ2ZU3sc5tRYCaYE9qL
         cUUpv4jSDvh7CAiGrUhSsW2u56R/CgWAcMvXDAtoJtEwAteaJHpzJMDCczY4CSC7qJww
         UJVV0h2cWaECt9evfUMCg6IzicgwFJz9Er1ec0yNU10Die3Db7eYjfGM54AXMW2wny/m
         MgNegAWjq8B/AWCkyF/47iQByMaXClkbqx9psWF2ivF32bOD24LSgANzEv6Unv+rhxBL
         GGAYEBDxXS5CPsuvzEJpfe52teP1CDiMjPe4RFLctf5b97VudyykdQsfmHJWohrL7tM9
         guXA==
X-Forwarded-Encrypted: i=1; AJvYcCVHlfRBuBFfwlUUDXJZDAzbD42ePNjz7RrzKu4QUW0EfyJUbJpuwq1sWMfVAihRoI6Ofna0PimGx/KA6Ch5rzWj8sBx
X-Gm-Message-State: AOJu0Yz6xJb8CrPS1zU0jGsabnTdj48H+eFPNdW7gvqiH9pLBGVHcdsf
	m1hcSyCu6NT9EWBgJDHk0/ozPzXbXzBwTpXHperVCmW/obHF8/0vcZuRrvWNtPkX4PAyspFXl2D
	wluj3MHF2H8icgY/XB2XxUtcQZOk=
X-Google-Smtp-Source: AGHT+IExi4M/fDiCdJVE2h2sY3+SR7fOtdBidtZB2Fk0VYvVncQgxQGoY7zbKGqBSEfK0dvioUWGhleTyL72aP/EVpI=
X-Received: by 2002:ac2:544c:0:b0:515:a799:604e with SMTP id
 d12-20020ac2544c000000b00515a799604emr1892099lfn.41.1711729148716; Fri, 29
 Mar 2024 09:19:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329072050.68289-1-aspsk@isovalent.com>
In-Reply-To: <20240329072050.68289-1-aspsk@isovalent.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 29 Mar 2024 09:18:57 -0700
Message-ID: <CAADnVQK-3seajJ072N7Su5dyZ5va48E9X9Gps3Y_j-7r3oDOgA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: add a verbose message if map limit is reached
To: Anton Protopopov <aspsk@isovalent.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jiri Olsa <jolsa@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Stanislav Fomichev <sdf@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 12:18=E2=80=AFAM Anton Protopopov <aspsk@isovalent.=
com> wrote:
>
> When more than 64 maps are used by a program the verifier return -E2BIG.
> Add a verbose message which highlights the error and also prints the
> actual limit.
>
> Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> ---
>  kernel/bpf/verifier.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 58952f040761..fa73009d05bc 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -18348,6 +18348,8 @@ static int resolve_pseudo_ldimm64(struct bpf_veri=
fier_env *env)
>                         }
>
>                         if (env->used_map_cnt >=3D MAX_USED_MAPS) {
> +                               verbose(env, "The map usage limit of %u i=
s reached\n",
> +                                       MAX_USED_MAPS);

"map usage limit" reads as "number of times the map was used".

Please make it clear that it's the total number of maps
used by a program and its subprograms.

pw-bot: cr
