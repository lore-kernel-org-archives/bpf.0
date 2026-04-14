Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A713E866C
	for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 14:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776175801; cv=pass; b=ceY0SOOKzgHmrkfzX5Zo2EiZ4Vu+EfPgOwIzkNmjT1McVFPLWOeY94cNR3jqY/1ngpUujK4mro4RsF0dRlPd5b/4ytBUiHMdHP3WWezIhXlfGupC/xCKuqs42K0a/haDK2YY7PAFuyAHYRPnHg7XjL2UjJh5U0Q3WuI4JD+UPmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776175801; c=relaxed/simple;
	bh=nvHkXaKy+A4a3zjmlxYTM7ZEfGs/MAzu/4aP88j9k0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k947CrGcVPp5YQ10Eros391dxojOUMF9I0fIyTYamCXouGEA9/+8e3u38NEpe9e2cLsKOUwudYBrIAmdnXPtJrHIAyPAogO/9tWhyrNmCL5/MccdCB2Yaro0Z6epnuicByIelZa/kdU5jEU5TBLwTkp5vdhSCjafyoic5GypSYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gswqI5Ai; arc=pass smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gswqI5Ai"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488e1a8ac40so44348805e9.2
        for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 07:09:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776175798; cv=none;
        d=google.com; s=arc-20240605;
        b=hBFPX6Iqk8jQixTvmMhauvNvaHjBtZb6BxRJrS6468bF+JLnexTLezXFT2UD5U7mcK
         YuXr0wfvQ52mHF0PLLqom+23a6Y/uBtnC6cZr5Jk+5QdTjjqEC5QURBxr2QIDyFx/viT
         PiszvCAhd6X5iuAEguzArhZVpMIR2R4XkpPCZPe8I0dEKzDbSwu8ohudQCrjS/ovQDhF
         2TO0qLJP16BZwlHUOy06Jkf29cmd74LlgwR4shlTTp76aHyG1pEHmifVnAwMdGRR39Nv
         YF9rytd+q/abFdl2dO6EZpqV7Pd98X1rytmu8jglF0oD1eDSceBrU1GKAMZPi2FZWxpL
         8C3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=n8OdkUuaCi8mFEcW4isBiQRI/EoubzWNeked/wrjNEo=;
        fh=6dnwr7ZOxhA2aZGGqirfP1GHL1bN/FI++1U+y5xkrPc=;
        b=amirQyrg42MTGiYZyRDZZCtouEV0Y1717GdwKf1ZIg8sr99w2QtO3bnUmS/98K1ASg
         l8Jl+L6KKnc8aPb5hzPTE2vdtdp4oE0KMbCB0UAwHrSnyK5OhloLwTSc3/+eth8RQlcN
         nfJWF9Vv74t9LBz/bH+UxdXvStGUi02pF95xsqNYLIz8MApWv2jVijdDCfO8jEZysuXb
         vktmlcd/frFi0yXoi2gjsfN1gxWyUqHJS4PYFoD7CN3Z+Rrc862Ag50zC0cO9rF+Fwo8
         eF4oixi9aDDUxWZzjMu8hixnUzFYqCnSB/04BFcEqp+uQIx2q/CV0RNhKaZ39UekQHPC
         Q9rA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776175798; x=1776780598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n8OdkUuaCi8mFEcW4isBiQRI/EoubzWNeked/wrjNEo=;
        b=gswqI5AiSbaSDAYRGW455cKj1KqTro3m3iqxu9ueQB5CZ1xINl91Ix/qt1oQCQDh1W
         RFyMfJLn1DuFz9plEYecBgx4eDm+z91ckMn6HsbTt5+s/nc5CMWcXsfgkLyBFWI7+8Qe
         Zp+fcsietmru03PFKldQobqh5bg3g/I5jfzgifuMP8Bg0Ifkmf//YQo9IyyqUITyITav
         0TB+8jdwDHykIJTpqwZog0LV3xXg9Q3O6hUxMPsc5a4jUV/lo/uJnWYpeX3ycZboXJtK
         vK4ZnZXAmu8z84wKPF711kZkM+b6h1pskwbFvH75NdNYKAurNJCS16W1xpyPstwH+Ukm
         Ms3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776175798; x=1776780598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n8OdkUuaCi8mFEcW4isBiQRI/EoubzWNeked/wrjNEo=;
        b=HXdtbKtdBDRhjAxeUF/wSY/IbNo2Y/jLbqFHgnWUwnqrYpSYKCsNn23TPACl0Y7/Ii
         /aek8Cl6GKvucQ9JOuFCQtqY8yg1N3YtIyEHTWttggQ8ODN+Vcu25m9EOVOGJrdYL57+
         sZMEBL+0jQn3mal3ZY5DZGwv/PlRrKrMFAolju9GFIX5nFjrCRk1rrg+AAzBM8bIshiH
         4OtjYaH+bB+4wdSXggxLLIbK3mkxP1Qi/QieT/hVyPYI2mxKth+pFfHJe7JXaL27mtB6
         2Yk+O98vK3Orj3PniT6JJ6QLa+nNuhjcwnYWAPKvksO2cCEx3NrcMfXSPGusXa4YDlZ8
         kqiQ==
X-Forwarded-Encrypted: i=1; AFNElJ9G8DGQSrm5KfJQA4ikPZuLg7Cgv/7XLfkD+YYVTjeNCGSnKKXcbqvdTntDCL6Rd1zWKCY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFESZqfxSbXBkwUisW7OWQyS5/tR1KPMBMZkoFz4r5Z69DBQlF
	Q1sc+tlz++43NuV/Y9E0ANDavz8/sm6603RfTQSHThCKUNkQoWOmja1XugwabvkR861s8dn3vfW
	KnuzEbmk3bNDyyaSxkAR+kQXPQFUrvG8=
X-Gm-Gg: AeBDietJ/jS6+I+4DMglLfAATU2dxtS+VjAdEnvPHSQsiFGzVrLn1wCZpGdS6COX7s3
	M/xt5V/qNwAMYYsRAR9gvxe4HHeO24CufSqRfWVhgGJK1XnYG0UNKxytz6/vWzKqkzHbCL2fgwN
	NNV50q9rTuzrOrP1vB77Hw4gDbaPmJpgnvdDK3QTS3gEdEIGNTdvwwI6102tMCxV+Q1tkwvwS2n
	eAej5fQeVdUVj9Ved/1BZzHJwxs4ADVF7M99f1yGnojTx38OityY9jju+ltEXoRXToIzNVfpQ9R
	m+WaAUYSACrbdigqxZoMoop1/X/b+0/k3O+PXR5cq1bWNq3urHc7DbHvrszfGsrJt47E4fjGdxY
	x0GIkZ7JrCxRAQ1B5vIQZ/8d5rg==
X-Received: by 2002:a05:600d:8449:b0:486:fdba:f5db with SMTP id
 5b1f17b1804b1-488d664f29emr197490795e9.0.1776175796268; Tue, 14 Apr 2026
 07:09:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ad4whCJuB-viVAae@sirena.org.uk>
In-Reply-To: <ad4whCJuB-viVAae@sirena.org.uk>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 14 Apr 2026 07:09:44 -0700
X-Gm-Features: AQROBzAq8LwGSoUQB6Tp7PVEnWgUkhAM1WnjY5UlIcDEYXRlptGcA56OQDX1H8w
Message-ID: <CAADnVQLz6-LK4+qad_XqEZXrspttpe4b49jRZ6wUCgEhJeTvgw@mail.gmail.com>
Subject: Re: linux-next: manual merge of the bpf-next tree with the origin tree
To: Mark Brown <broonie@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Networking <netdev@vger.kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2026 at 5:18=E2=80=AFAM Mark Brown <broonie@kernel.org> wro=
te:
>
> Hi all,
>
> Today's linux-next merge of the bpf-next tree got a conflict in:
>
>   include/linux/rcupdate.h
>
> between commit:
>
>   ad6ef775cbeff ("rcu-tasks: Document that RCU Tasks Trace grace periods =
now imply RCU grace periods")
>
> from the origin tree and commit:
>
>   57b23c0f612dc ("bpf: Retire rcu_trace_implies_rcu_gp()")
>
> from the bpf-next tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>
> diff --combined include/linux/rcupdate.h
> index 18a85c30fd4f3,bfa765132de85..0000000000000
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@@ -205,15 -205,6 +205,6 @@@ static inline void exit_tasks_rcu_start
>   static inline void exit_tasks_rcu_finish(void) { }
>   #endif /* #else #ifdef CONFIG_TASKS_RCU_GENERIC */
>
> - /**
> -  * rcu_trace_implies_rcu_gp - does an RCU Tasks Trace grace period impl=
y an RCU grace period?
> -  *
> -  * Now that RCU Tasks Trace is implemented in terms of SRCU-fast, a
> -  * call to synchronize_rcu_tasks_trace() is guaranteed to imply at leas=
t
> -  * one call to synchronize_rcu().
> -  */
> - static inline bool rcu_trace_implies_rcu_gp(void) { return true; }
> -

Right. I mentioned it in my bpf-next PR.

But how come you're saying it was discovered "today" ?

Paul's commit ad6ef775cbeff was committed to rcu tree on Mar 30,
while Kumar's 57b23c0f612dc was committed to bpf-next on Apr 7.

"today" is April 14.

My only explanation is that rcu tree was not in linux-next until today?!
