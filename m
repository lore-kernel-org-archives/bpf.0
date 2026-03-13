Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A512282F04
	for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 21:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773436498; cv=pass; b=U6UEHzlcUCOda6fL/qUpSjfIr5C8UNA6zyywbpWQKND6lq0eC+TuGy5xsdCmB32qxCIvkugOhtapUYaIHzU6bfvmguH8FSaToVtanl8Eazx0yN5P98C4SO6KYsd8jRvoVvEkAv4l4veWIDISrnhsFX1dhjyOHv975IHlhEQSzP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773436498; c=relaxed/simple;
	bh=6jm5LLuesQBJ/G6hU0fm0QD3cDG/ka7OEt7yvUXm11M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ny1k2/SCEEtEou3Uk8Wxx/T5vTDlik8RlooDD+RmSdnapdxIB3pjQwzwJCJ72Q1sBufLVLUOrbszw2rIrQyEcoKqHWLY1pLTBxOw9xpIXwLcFq8Ls7sYtucYh+F7PYxGIOc8ZVvNN807iGaRUcJ43ByjCXf5/IVZ+f1StTQCMU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BK9xLv9K; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BK9xLv9K"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-64c31ca77b4so2864003d50.2
        for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 14:14:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773436496; cv=none;
        d=google.com; s=arc-20240605;
        b=FNWwjgdRRe4ntp9yg7Z3Y/wfG1orrh6S97qEMEvIId7PhIc/nwt2+AjGiLx4NFLIDY
         fKPm8S39RIZycSZc6DXsKqEBi1dEIjBSAtd3Yqdov09T97JKFsGlBbxHn1psM+gKep1B
         vqy4oqIO5tY2qPGfvu2vVbXCNtaEwgXTCO2L0Qgc7TEQr7vZz+1irCn689iiqEScIY3e
         EGSQG7sTfcadnWsOIL1r8IgmtIDmuUrO1UVyLsI/pPgYiWeH96e8FScCmZF5cy/rf4K6
         UQkrcHmJz9oiWfdkJ7KCzp5YLb6dkV5BuURCIZlOkCu3AKYo9CqvyVhvAj9s3PMooOGq
         wbCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=anccHqeYppIg8GJqXhmJPCH4JP9yUf0+wyqWJsiQcDM=;
        fh=5WNbLMzUIJSkT/c9iz+xFtbu/ra9gd2MHn/Koc3qUo0=;
        b=RwIJMnPFfAO3TqyElb0rJ7VBvwSeVzlK11uIXHcChPXS0ef+GfIrUpX0v6pJfsN2rN
         NOPNqW2bLvQBJRhIHe3sK5somsZMGXh6tmNq+GXS1mmOPfvYmNllM3SxeP0Pm/6v72vf
         E4SXt4vVzBNET9lnWkK+AADnw4QU/hhSDTXbZJ+lXLeGCKmUkPs506C2go34oh7F0fzG
         TZUQQazR9anpcJnEbo8uH3s448N6J7IfC2W12zzRf1OuWCM1/JSuYlCgRyOcCLlwQ0Ux
         E/ctmslSubUxioYyp6xBbcYxW5UPJEqfuVC2zCDgBNlRfKTdgqxYPRabeRaTdfhO7IQy
         hiDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773436496; x=1774041296; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=anccHqeYppIg8GJqXhmJPCH4JP9yUf0+wyqWJsiQcDM=;
        b=BK9xLv9KrhMPmIRPW0TuEzBCLRUeR1BTInRhjcvW1RXo8xz36EUXkM4dxltts1bFUS
         qelcaAX4PPJD5Kp/t2ncz9gU6QWbUe7lU9gdb4SrTXv6XUSCPUS4eFU3OB9TmCFHaQcN
         zYhhY4A3eJ/YL0rfC/IJ5RbtV/wjkNClVQKOiNapRhcFTjHyz9/T7URL0ykKEOrbzNy+
         NtsJBjo6npno5pJt7uukFJ9BWcwyVzLIKO1KFB6ZAOtSbgyYloEcHgu14YIeVFKJ35Jp
         lBjNDoW6asLa258mazl6AcX2FlQkLOuzQ8Y+1hexml/Pndk187OrgCtCDkWpVnTfA116
         ESgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773436496; x=1774041296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=anccHqeYppIg8GJqXhmJPCH4JP9yUf0+wyqWJsiQcDM=;
        b=IiaLR8OAR+uM+zJLNElAXQjmAYt5zYeWAATyDTEKbCEN+Uk2aRAmXYD1+5BrgNhCOF
         NmZ9Gw84rND2JVo3LoYjESwa1BGXItONuM1fxzbtnmsHABPEcO85itgz6KfxmM2idmMK
         1VGc1/RXFLeoI52KNBDkEy8shhwkWGULsdiTLYr1BRJyK4/NKHEXZngPdHk5aTJlUh+S
         HyYwuGyQU6JFvt7KADU7NoR+kcghytyHYlFYKULSwkTdAWak1L4hYN1W4tt/9Kg09qqx
         1VT9CAVOKwTpfmiQTJXvjhdPkQaGbNg6HMI6Vk/zbecK0HuaP1ZDpUOaHPcBKRvlNypz
         VwBw==
X-Gm-Message-State: AOJu0YyQCSL/0H5EvRiV2IktGSn3tP9HU1an+sNyy/2lQU8FXp+d+Ci6
	dC9gYDiSb4Mbal79xavxQEn8t2lcbrbEBcoCRKuivZRs/by7d2PX1YGgBBgeofmH1J4ODwnEMUn
	YDQjetAY6n8CLPCTMhDsXHMgwzhOMc4hNJADe
X-Gm-Gg: ATEYQzz31+Bj/DlmTdYGH8597KNTjAXpTE+JT4sse9d0QZS6/iougsrEu8fSRa3I+e8
	3ZOs8JtMGa0FiQGNCjy9ul0Et8R8PO3xn5mGM2D6W4Cm94s1PFJjxpA/KtOo01B9QF3tukum7Ql
	cIj02QpSUs7pbx6XHfT5IoGTXt2QAuMPYq/3fKRQ71SeaDnh4HqjNVguuu9iPW7hrzPzGzFO/no
	a0zIZYlvUOzDcX/JIWNb5r++8X5hcfLyA+IwAqAETpPj5ize9jHmjpQKZHPDL7ZwSF55M0yFo7I
	vfb3LHc6n1o6DOYy6A==
X-Received: by 2002:a05:690c:7242:b0:799:8c6:9ccb with SMTP id
 00721157ae682-79a1c20e520mr53791647b3.62.1773436496350; Fri, 13 Mar 2026
 14:14:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260313075318.11847-1-danjwade95@gmail.com> <20260313075318.11847-2-danjwade95@gmail.com>
In-Reply-To: <20260313075318.11847-2-danjwade95@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 13 Mar 2026 14:14:45 -0700
X-Gm-Features: AaiRm51maWSR1Nq8dJpyVn7Vvonp5xz4XfFS2VGvRKSgCMlDpIY6gmC9NABHaMU
Message-ID: <CAMB2axP6SbmKQH6Q+7jGehi=8vKm_-McJXhGvjB=eHbFwSJYxw@mail.gmail.com>
Subject: Re: [PATCH bpf v3 1/2] bpf: Fix unsound scalar forking in
 maybe_fork_scalars() for BPF_OR
To: Daniel Wade <danjwade95@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, 
	ast@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2026 at 12:53=E2=80=AFAM Daniel Wade <danjwade95@gmail.com>=
 wrote:
>
> maybe_fork_scalars() is called for both BPF_AND and BPF_OR when the
> source operand is a constant.  When dst has signed range [-1, 0], it
> forks the verifier state: the pushed path gets dst =3D 0, the current
> path gets dst =3D -1.
>
> For BPF_AND this is correct: 0 & K =3D=3D 0.
> For BPF_OR this is wrong:    0 | K =3D=3D K, not 0.
>
> The pushed path therefore tracks dst as 0 when the runtime value is K,
> producing an exploitable verifier/runtime divergence that allows
> out-of-bounds map access.
>
> Fix this by passing env->insn_idx (instead of env->insn_idx + 1) to
> push_stack(), so the pushed path re-executes the ALU instruction with
> dst =3D 0 and naturally computes the correct result for any opcode.
>
> Fixes: bffacdb80b93 ("bpf: Recognize special arithmetic shift in the veri=
fier")
> Signed-off-by: Daniel Wade <danjwade95@gmail.com>

Reviewed-by: Amery Hung <ameryhung@gmail.com>

> ---
>  kernel/bpf/verifier.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index a9e2380327..68fa308520 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -14206,7 +14206,7 @@ static int maybe_fork_scalars(struct bpf_verifier=
_env *env, struct bpf_insn *ins
>         else
>                 return 0;
>
> -       branch =3D push_stack(env, env->insn_idx + 1, env->insn_idx, fals=
e);
> +       branch =3D push_stack(env, env->insn_idx, env->insn_idx, false);
>         if (IS_ERR(branch))
>                 return PTR_ERR(branch);
>
> --
> 2.43.0
>
