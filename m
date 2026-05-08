Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCE630BF4F
	for <bpf@vger.kernel.org>; Fri,  8 May 2026 23:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778282697; cv=pass; b=j569CmX9m8Avgwh28XbLQq9/1yd+oK+eulvq9cRUSGHVXfB6PAU5TwJHCDNYjDSLD5dTSt718FNbnQV7H8rD7+LJ6x/h8HjEeHqp2VGtGAsMIB/ygKCxlBKe7dK5VtbZAgt/Hhj4ZqivPMt4ExhXRQ3JsjY4CXtyKPXTnYlRgCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778282697; c=relaxed/simple;
	bh=HlVBE1XsctgVr6b82c5k+mkRe0VoDUihGUN0wY812xo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yy8cFoMiGpNghd0Z9KbacqzWHvpMtkesAOcLEOTEi8DVUHZhEffYrZTP0nxFXxS61qSO79eNCHPBgeunWjB0oJXeJfMKng0jKrQwYQl9D1bC8WJple7MtjyAnpKiQlyvvAcrYHG7bc8sFAerLkhU4CtayvbnQddV36PQ64KYifA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fADq5EwG; arc=pass smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fADq5EwG"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-44b052142e1so1446720f8f.1
        for <bpf@vger.kernel.org>; Fri, 08 May 2026 16:24:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778282694; cv=none;
        d=google.com; s=arc-20240605;
        b=Q0cdkwIPlSn50IVy1ftHsNx2nczXGVZru2oUkq1fr2AnoG2XorT4U+JCHT7A8Kx8J4
         r+HG5XugEunjS0YhVuP+FGjfkcAIjYJGaro2oqMTNS96tTOBFWh/QiLEicBbkfLEqhQ7
         nbj+hzk5cjHqLV88lPpLU0b933dNx0+ZodTSJxcH+oOdzQiMqIblMQI9hAs2+9TB1hcK
         jxaWiDUwlXwyfbHtxBHZ/EEhwk47OPirh/KQfdc0H5SY2n5lYPcLnbmr6z3EofJtq+2m
         t9HzjM0VtR5KpFc5ktGnFn0/SlK75UhBleHZAdRzevAK5NROTuaPwUWr2BCBisOAgS/u
         NdIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3bLlnEl9t20Z5sL+HZ2tOTnJ5mpcNtk5eHN0Z9JSQso=;
        fh=YepAt3BwLPdMrOrfFEB++Il2jSHrtaeHfUxGSB1Invw=;
        b=I785UVRfQbE6ehS9K63mRY5bzb8Q7X4Jrjq4BmyYO2KzR9IysbaEIsnZjvWoT+ELpg
         eyx/ilijlr+aXC5JoqP1NaUw6jlzjLzsi4rsJb0g/mzQGywrRUy6xJHiUfRCAZhJCsV1
         IUDSAzXAg9YA0vswfOP9wuI5bRAMwg6H4MGrHHCIuPpGQ5x30TnbSE39nO7jJr/0og01
         AIKymCpnzxp8ImAV3ZiujZRLrkLUNkZUhpEGe0sTVWL4GlZs+QNEovF0TWvK9Sjq6Bn1
         ynuIB3dMI7SNukAZm2Lt1ycUtwg/lUyIzpkKWxzqHYKUxRqCMp2m8iSpcGwauicqHIp7
         gcrw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778282694; x=1778887494; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3bLlnEl9t20Z5sL+HZ2tOTnJ5mpcNtk5eHN0Z9JSQso=;
        b=fADq5EwGOhjvLvHUU5nmCnPElMTxCIFeyWZD1C/OU8e9PXdJU0v8bTThJ3t55zC63x
         sXxmDdDSyQ4e76ubfGvC24CLluddYkbC6ji2mHmdNJgNJgv7v0mmI7waIMCWQ1vZkH3U
         YUoY0Z9p8SS6zgcdUCrqHvO+c3kjQN4atATGFuXlW0XvVVkPxrslgQSWbkNu2jgW1Ktf
         6ktbrDT2vJzkXtKeakhgudWnEC44BgWSj87GAWWZfwRyVhM2FNGX6EKBqykYmLrCFy/B
         wv1S3SoFeE74MEeNOzY3fldEk7ikTBD5pGlNo6edX7+zqrGExv8Z7TbUy4opN9irvCmO
         WmuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778282694; x=1778887494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3bLlnEl9t20Z5sL+HZ2tOTnJ5mpcNtk5eHN0Z9JSQso=;
        b=rN7eI1y7SnKoXxyJJbzQHhQ5yE4gWah6NHQPzoPOPcUqVKj3GsKUR23p6tKWL3uqP9
         aNKepO/oAvIv5W3NZ0i0c49MMX/ezRgXOfShwiUHpvHxIxKcyKpqXlXmslHI+NsJd00G
         GEplreJMetMPYpd/mSzCq8sT3Pe9B5NcsXcEdPCG7+WXHedbVLjyUx8dV7VhHXc0XntU
         8De7fU71e89FhGwbj5sTLBQheW1DDA8Ec4Pf3jWlP+9TrOedN/EXzKVICmsCRvaaQn+A
         D4Th8XlVb+yn8xJyA5qmcIMNdObE58+LeNBVdnAHCNpOKI0nD4cV1ul/uSbX5Yrm2boD
         4Afg==
X-Gm-Message-State: AOJu0Yw53pLMH3pykkC89MAqtpPK+yYlEnzGNlh/1kzJQuCwPoF/Y/KL
	M7IffeURfLv7Gr0nHoTfgcd6mye/W6CfQsEvZX52mXljfMGgB5Tcq69hbYXpyOdP12lBWZZ7vve
	85xX/n6lp3X4vJeiu9QCGVv4R45Pu4YU=
X-Gm-Gg: Acq92OH4Aw7X5h/1n5TPL8A1IqrOIwKOYO7MLfcfv8yrq+BBwxzi3sx4DXIlab9On69
	gOzP4ELuCbMwGVrYNiZXHqRazbGapxeiD39nmPALPnU11WJanLWw3ovEz8N7AllQL0DQoldDXfO
	5Vujj9OIPWuqfUq32tUwNdePMxC5Osqt32wQ/ezBrLN8yWEjpxyLPF4aMgqHTdtaXBT5S9VSVOR
	FX/O2AS9+puAKkO4Cuq6x6S7IT1mJMqLF7AmUKUavpOvhKrnYR6OkC9s7IQI+GScjgPzy6Lkh/g
	hj88RAFfIxItMU7JCAR5ZiRX57v1K1L9EgRsampXN7ieptGDug965RtG2azQipHVKPsmvJvhkNO
	OwcAKstgKiOi8DE0EZwDrO8Pgag==
X-Received: by 2002:a5d:584c:0:b0:441:1c18:f779 with SMTP id
 ffacd0b85a97d-4568e70690amr500656f8f.37.1778282693753; Fri, 08 May 2026
 16:24:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e4d7b53d4963ef520541a782f5fc8108a168877c.1778176504.git.paul.chaignon@gmail.com>
In-Reply-To: <e4d7b53d4963ef520541a782f5fc8108a168877c.1778176504.git.paul.chaignon@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 8 May 2026 16:24:42 -0700
X-Gm-Features: AVHnY4J_ZhxnvNrnlMYmyfLTUcttZ54EjQJtfdY1PwrOVkYRbWcmDQu-FRwvnBE
Message-ID: <CAADnVQ+kM=Zg_pcY30QHFPu_16L8wa+DbgQqnidqo-QZphihFQ@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Don't run arg-tracking analysis twice on main subprog
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 7, 2026 at 11:22=E2=80=AFAM Paul Chaignon <paul.chaignon@gmail.=
com> wrote:
>
> Because subprog 0, the main subprog, is considered a global function,
> we end up running the arg-tracking dataflow analysis twice on it. That
> results in slightly longer verification but mostly in more verbose
> verifier logs. This patch fixes it by keeping only the iteration over
> global subprogs.
>
> When running over all of Cilium's programs with BPF_LOG_LEVEL2, this
> reduces verbosity by ~20% on average.
>
> Fixes: bf0c571f7feb6 ("bpf: introduce forward arg-tracking dataflow analy=
sis")
> Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> ---
>  kernel/bpf/liveness.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
>
> diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
> index 332e6e003f27..505250998f36 100644
> --- a/kernel/bpf/liveness.c
> +++ b/kernel/bpf/liveness.c
> @@ -1914,15 +1914,6 @@ int bpf_compute_subprog_arg_access(struct bpf_veri=
fier_env *env)
>                 return -ENOMEM;
>         }
>
> -       instance =3D call_instance(env, NULL, 0, 0);
> -       if (IS_ERR(instance)) {
> -               err =3D PTR_ERR(instance);
> -               goto out;
> -       }
> -       err =3D analyze_subprog(env, NULL, info, instance, callsites);
> -       if (err)
> -               goto out;
> -
>         /*
>          * Subprogs and callbacks that don't receive FP-derived arguments
>          * cannot access ancestor stack frames, so they were skipped duri=
ng
> @@ -1934,6 +1925,8 @@ int bpf_compute_subprog_arg_access(struct bpf_verif=
ier_env *env)
>          * each subprog is analyzed before its callees, allowing the
>          * recursive walk inside analyze_subprog() to naturally
>          * reach nested callees that also lack FP-derived args.
> +        *
> +        * Note the main subprog is also analyzed as part of this loop.
>          */

Thanks for the report.
I guess the fix is correct.
This part of the comment needs to be adjusted:
"they were skipped during
         * the recursive walk above."

I wonder whether something like this is cleaner?
-               if (info[sub].at_in && !bpf_subprog_is_global(env, sub))
+               if (info[sub].at_in && (!bpf_subprog_is_global(env,
sub) || sub =3D=3D 0))

This part of the comment:
"Async callbacks (timer, workqueue) are
* also not reachable from the main program's call graph."

is also not quite correct.
In here:
                } else if (bpf_calls_callback(env, idx)) {
                        callee =3D find_callback_subprog(env, insn, idx,
&caller_reg, &cb_callee_reg);

they could have been reached, but find_callback_subprog()
will ignore timers because FP-derived args won't be passed
into them.

Eduard,
wdyt?
