Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6084D3B42D9
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 19:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792178692; cv=pass; b=Yr6omgJNKrxhK9V9J3PTQzk7jbx67JKOAeDBI2/+wN8KT+pyeYGP2dj0z4YPBzTgvxamdDEsUGMnadU19ADO5jHrs/xw7fq0oKQAgnvZuWzPfUxJQrZblIGkKqK8iyQbp5SosV4kLyxVKRyK2zvY81g+OW8Esz8FlOaYeAj7U74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792178692; c=relaxed/simple;
	bh=OptZ1g1rhFI4TFl9dVgrNFG1bzLTJjCPpHPpfOnHqAc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ctJw6AKbba8JHt/ktVw8FidIZEkAQeIefAEd130e8EqTH1vGjQvAfv5MdWCppIxOgIeHaIsFRLtI+MKWqKYL9ReFBzM53U8eO8e1EPyfjqEbMyheBm5KJaQqe5Soels4px1sd139sQKXyeKvRuMW0u1f+IaUx0YToYVVKLH7L6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NBaFDcJa; arc=pass smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NBaFDcJa"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3a4cdc9025bso279489a91.0
        for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 12:24:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792178691; cv=none;
        d=google.com; s=arc-20260327;
        b=lkhzXPamBrqQ/CLRkgCP28G6iIzZTcRA7DU7ITbcSBaFayLRbEA8q6WdrZJC/zHoPT
         NEqYAZjlhUq8wHbiyrNWirath9niD1w0LQCQrOzm7HNiMmWV59gl83+VLOyJx1/LIuJl
         RcO6QciMsdYIt3pok9oLZEJ/+CTCvTA8Vw5CHexINSJqbS1vbKCMmX3075jrDB9axJk9
         A5ESPERj1qmpmLevqnKsZDvNzFiX+MW4x23TvcLBZoYRm9hs7J/QAxCm3VA8EE/5sIka
         V+blXk1HjKIcLuzsdV8uVW1cp3ld3Vh/FeoGRbUoNwqBwT/EPwecko4N589hrCcLsLhe
         cNNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xJkVVnZeLFp18Qfc2BkiLF1nl+E8hBTJmCjKZUmYZjE=;
        fh=hxRZ/yxzH0mnIMeGpQd7Zzze8yONgMQRyPM05yvEJ80=;
        b=SXHdgkM0Weccv+OaNWxSi4/l7Blsc+aKDakudP+q34aXyIisYDVGUcf6c9zwf60qk3
         rLc8N/mX8+qsYu5E4ogHmPtXFKjQxkC+mMTlQpO+I+EcFluIVD8KLu/pvxlGOecxSeXt
         /AcE5YgzNzfPmXPmwQq8CtbuiKfA2Istn9GKrN+U8CNqze2RuakyzXd6bu7Rrwe2BMoQ
         Gty1x7MLLYNxc6daI+U/1emrjwaxZ92PUlZNB40rYTfsceWpX9bcNnFOe1FM8ul7UUlJ
         FnAYbik+vh/HlaaC+okIhQUEJqaBmmyW1gJevDZcqQy1V3pBMiUZZsQyjepvwpzsJpg8
         joDA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792178691; x=1792783491; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xJkVVnZeLFp18Qfc2BkiLF1nl+E8hBTJmCjKZUmYZjE=;
        b=NBaFDcJaqbkiZkZpWHIMyYT81mP1XPlGXDthyTl0Y6PPPSEgj3EGWSQJFwI4rNnIeD
         3ckxCFalf8MIhzgoBRroZZF4+xLrXGYDud/3zrjm/ucKUTbuZTFfAxXQhIk0n1joJiXU
         y4Ma5qcZYjY1M94hWgrn9Sp1hIK/2kHnoydu7Exvy0rhhIzJGyBb5EDodgDuPjKdyqt/
         Zhh5otDvb42WnDkNxjblTYpGJKtgLgxZl/LgZ9hOcfViFsPsE4QVRhBuDhCWCbpFZabk
         cmM1YHQvTSeL5m7pdHYVcE/nf+8fcoeDjgRunnMBP+2qjrq5CMLdMOOHAWzwdqVVFjGK
         qZ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792178691; x=1792783491;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xJkVVnZeLFp18Qfc2BkiLF1nl+E8hBTJmCjKZUmYZjE=;
        b=sQTPG0NdlSidVsv96C7beJL/vQNNsUNSJPiD9x/HMXCJB3tzdVZjtdAvv9mKUMAHWG
         H13xWpI+fp+oUyP6dvHB0428lEq4tF3frwahzk3i2AtnfltWQIGGAdqNBuZzzTZHqUwb
         U+wQYc9ofkbizyXBqeolaNx5jhi3UHaEgv32blWHfOX32hNHaJtWUOpVvh3RnftKyPep
         l2WfaMcJsRk5v3/zcTzm6vN/SFiPD9TUTcdZvyX0SqNY7Okl/MMBryYp6eU2cNptnbSy
         7WZfYAfewe5QriqAaww6YiR8XAEtWHr3YK/m+ooGSWGMjBEo6js7Mq/cbJqHlycrVdxT
         8k3g==
X-Gm-Message-State: AFq9FYI1g6n46WCNrGBrr/WUTVcIQBuclwHZ/LxzfF1HkcsR3Ek5v8dM
	ZOr5Fnehl7ZxyTlapHywkIPCPXImOR3IlDNusvciKePkoDSlWAYOo/dtqphlESQbVL9C0nFUyMX
	efql31rvDq/ZqDn34Db8yx/QiFcelJiU=
X-Gm-Gg: AYBFou1uHLifKrsQsBAUss0g+wgDTNuU5iY5dSz+uVxaXha4pFBQpMQqP7/3NJsYPKW
	Y+qzb/rU4mZcUOx1NLWSxdZ6s++Q7c2jpYrm+Hf4PQmdZh3gDAREeK7ednTzyeQPjjY/mAk0TTM
	KL4J+em7PNkQaedteIhapOnDT+d3UCTngYD6YKTFIgIzikpQcPiwZ3285lbXcivdfE7DOfM9k0p
	iX96XboSw7pXndvtSpEcyThs9AL5H1Yorr66dyd8PF5tWrU7M7SI2r7XR8MvbuV1R/ZlcRZmthy
	SFilKck7F5896pieqaO/CCTnAz49L5qFhQeAXBaP74oZIZ/hdkYQQKG8W/dYe0bDVOzat0iAH+3
	aje/3rjf68J0ZU2Oc5KQZikDQQDRhyAi8sIV8
X-Received: by 2002:a17:90a:e7ca:b0:3ab:f38:2b3c with SMTP id
 98e67ed59e1d1-3acef13eb0cmr641560a91.28.1792178690593; Fri, 16 Oct 2026
 12:24:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261010143156.379864-1-andrey.grodzovsky@crowdstrike.com> <20261010143156.379864-3-andrey.grodzovsky@crowdstrike.com>
In-Reply-To: <20261010143156.379864-3-andrey.grodzovsky@crowdstrike.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 16 Oct 2026 12:24:33 -0700
X-Gm-Features: AclHuK_0DerGlfzwX_2U0KDODWXug-8PETUmtXClVVOpSrWr8uEF9Qx2O8TrVWc
Message-ID: <CAEf4Bzas_XCmyTOF7UhDiSAzp8gc3xTgBrVHFv_0t=_kKUfrWg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 2/7] libbpf: BPF program load strategy enum
To: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org, 
	martin.kelly@crowdstrike.com, slava.imameev@crowdstrike.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 10, 2026 at 7:32=E2=80=AFAM Andrey Grodzovsky
<andrey.grodzovsky@crowdstrike.com> wrote:
>
> From: Slava Imameev <slava.imameev@crowdstrike.com>
>
> This commit is in preparation for the next commit that introduces
> manual program loading. Currently, the bpf_program structure defines
> the autoload behavior using a boolean field. This field is now
> replaced with an enum, allowing new BPF program loading strategies
> to be introduced by extending the enum value range.
> New getter and setter API is also declared for this enum handling.
>
> Signed-off-by: Slava Imameev <slava.imameev@crowdstrike.com>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
> ---
>  tools/lib/bpf/libbpf.c   | 53 +++++++++++++++++++++++++---------------
>  tools/lib/bpf/libbpf.h   | 33 +++++++++++++++++++++++++
>  tools/lib/bpf/libbpf.map |  2 ++
>  3 files changed, 68 insertions(+), 20 deletions(-)
>

[...]

> @@ -16218,3 +16217,17 @@ void bpf_object__destroy_skeleton(struct bpf_obj=
ect_skeleton *s)
>         free(s->progs);
>         free(s);
>  }
> +
> +int bpf_program__set_load_strategy(struct bpf_program *prog, enum bpf_pr=
og_load_strategy strategy)
> +{
> +       if (prog->obj->state >=3D OBJ_LOADED)

This should be OBJ_PREPARED, no? Preparation step is where we do
relocations, subprogram appending, etc. And we skip doing that for
programs that are not meant to be loaded. MANUAL affects that step, so
we can't change load strategy once we went through preparation.

Preexisting code was checking OBJ_LOADED, but that's wrong,
bpf_object__relocate() takes autoload setting into account, and
bpf_object__relocate() is happening during prepare step. Please fix.

pw-bot: cr


> +               return libbpf_err(-EINVAL);
> +
> +       prog->load_strategy =3D strategy;
> +       return 0;
> +}
> +

[...]

> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index 53b7b591325f..689de28fe436 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -464,6 +464,8 @@ LIBBPF_1.8.0 {
>                 bpf_program__attach_tracing_multi;
>                 bpf_program__clear_flags;
>                 bpf_program__clone;
> +               bpf_program__load_strategy;
> +               bpf_program__set_load_strategy;

we had v1.8 released, please move these to 1.9 section



>                 btf__add_loc_param;
>                 btf__add_loc_param_value;
>                 btf__add_loc_proto;
> --
> 2.34.1
>
