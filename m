Received: from mail-wr2-f1.google.com (mail-wr2-f1.google.com [74.125.225.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F22371043
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 22:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787611077; cv=pass; b=OEKoAcUFStEDEjCZY3Ne5s9/fosBmq39gtQNhXl262HECHzZeEnwOsDvwrpi84WlxsVZH05+mVGafN/2yDSbKyRMZwVyue6ljSvz/f8eacOKWnyBjf86iLuSzfzXf5lpI19FqN+jYU0WMWTn94QIbTZuwqOeaoAIVLhd+fFEQiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787611077; c=relaxed/simple;
	bh=uXi+X3di5ladwn6s179JFEpL91fmtLLmfGos7XC+0AE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tBbolRPbbZY1WFqXyC8UULiaXrx+/shiSrHZpwZppOKsyYdoB2zj4fxRE45wGZEKJSzCkGnEDFC3JhCC9mHbU9GGoFtny4I/Qc8zZ65l9bjBZjCYQMHOGQo/t1c0z0l7HZcU+xnwpEDndqTrW7FApjGi5qEowmUkNm8KOZ2QJwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D6YFR3Ck; arc=pass smtp.client-ip=74.125.225.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D6YFR3Ck"
Received: by mail-wr2-f1.google.com with SMTP id ffacd0b85a97d-473913157edso1029174f8f.1
        for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 15:37:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787611074; cv=none;
        d=google.com; s=arc-20260327;
        b=SL5b8EibKo3OYL5UJ9trwREaCo2C7qYxqxqRMZBhvRK2phyRFbQ8HB94/8gKKkh0oN
         1K5mk5a7zBOM/1DSl3JdlKtvMv5/so9dqjdps1B4pa6pQTgh6MzHbWAPfTPJrjt1E3i5
         MJGCoOFtqip0rxpB6PJHt30ZcVCzr6ejJj42VrOSQxKVZ29k8ZwXe9AaErkftM+0b3MC
         T7/szhIGYL2N9AQ1STozndFO0MLMQ9Olxyu4B1fcvC6oISHBgWqG3O/VYhrkVerwzxUf
         RybSvMom6wqLOQVAC3cI1bioY59pszbqFtwTqzI7lLzz78YHpcDv/T8tn2V1cHZ2JJ9z
         dC4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=uXi+X3di5ladwn6s179JFEpL91fmtLLmfGos7XC+0AE=;
        fh=j32kraQBvGnT7sBi2cI2niS49axgMloD3RaZATMi/as=;
        b=Go2vGt0w9d6wecMcgBz5MxPuww+Mk5MkMUuTLVC04Jq3uBkb9lK8H43OWcNaacsWmJ
         8Mn8pXOckJuXP/afxFKo5c3VtrcSBahtv9TfNHXqJmWyWjm7mySkgSM4XM0gLlzGrCYr
         fF0rao1rZFs2R/VlFa69zK9Eu9BNDZrYN99eHgLkQqKpXvX8L9eSTcbt0c6ci54oMwOj
         MVdvltcvKvDZrzvxme3mtqLzM+aondA9K3yZOmp/Ih9FAHSIrnl4Bhz0V8rM4hLq3JMU
         bhWY3vkbK+xLPsWmOGvROZmVsCgR3K2yAN3jfa80oMosnU9h+ReJ49Mx7Ykez/eGaEhv
         z6sg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787611074; x=1788215874; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uXi+X3di5ladwn6s179JFEpL91fmtLLmfGos7XC+0AE=;
        b=D6YFR3CksTD+7gtSzE5mJCp5rBapC8JeughGyjaP3obaWTskK9RQLsCExuuHPeziVy
         Ty4KxUkswN+9cz1algreqK5RjJ/WCWqZA4mppB0+miZLB1163TB3Q23Dw0qGkIX8xGvH
         +SLCT+LmijQ3stUnGVf7V/0PmcXuBJche6lMEGv6y2KadpNSj2C1wWxrJ1dipsG85oBB
         K8OfcfBhe+Tx30RJBBTVyH44/nfktz7v1DkbXHxjda8VpvW0ni9PofNkhMoLiQhBL+q5
         i2zSEjwdFICEjh1HgjClrXggLlLtXbGx3qAeaADuAnw+9/IkD1Yhf7cXLxGP9MvY+qI/
         kTwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787611074; x=1788215874;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uXi+X3di5ladwn6s179JFEpL91fmtLLmfGos7XC+0AE=;
        b=StqYO15KRXi0CUgwsH8blmc2TzwsJmdps5pBG0kpWCu3kvG/12+KWDcAKhcIW0/13Y
         iQBRm4t+Zu8AuXPcKe9cvvGtve6Etx20hPieoNyk5IHZ+em8zND24MNrYVbrk8mr++0p
         tvk2+vxX89Iq/huR505Zdi/bEm+ZLP+osBQ6JeoARuEPxSDmRhh7YU28P/lKzdKqdI77
         nbGfrZCTbmPWScJxtp7TeO83tym4xxn6K2VOO7sLJEeiFC9VYm9Uqry0E2p7g/cADzuT
         w77/gq7yWEoNyjpOmQNPMkP82m+HOJf6f/rloIne+uk6x21r87HAyVKH1Ov5hKwdhP9B
         2w0A==
X-Gm-Message-State: AFuF++mOE/CoY0TkRLmrwXHzHqrRnbcu8f+Pj+DkiSOK55R+c5g7SRXm
	sP/dfcKwF6g2K6IP3rPVThmTaKcI7zPQljvM4QtTfyyjz/dIf1PsSOM9RnXmfSDrGod9/XDkJWr
	PcwIhkGjHHozmz29knpTyVlX6glPbmEw=
X-Gm-Gg: AR+sD10OwHui57zCreVh61r5AfiHGrelz6A+5BxbFV6lf0Un4nRmrM6r3CqohMVCjBW
	Xt8y6vPjKRzjAMDWNqip8oL9xLlP92hGpLQR102IjUBmS5UQepJrLwTJIVHykcvlBWMT0BD7KLW
	rA2mrvMjb6Ptq3etVfy51bdpNbslnk+FzUXQs/QWnohKmECEWCN07R3ieLn4dTnj1ZbqGQJeMIL
	a0AimYxK2EswonbFukJhNWzByiEhkUHunl1BJbd8TyRj/gdy0pKhnDo/ZQ484iN/RnkvHZ/vdVi
	neR9zZ9iQtuv/uVq+LUmsCwSDO7n9BWcS0e/EhHgxs9UizscD+jmSnQYCr0fXLbvDejF70jKT01
	PwZ8w1Z7J/MyNn+EFrYq7pdQ+VLLS6e2J+wD3i33L0u6g0b6VPMdX0VcTdciUsomHuiOchaIPHy
	RZgIaNOB5RoPHay8J04C6w
X-Received: by 2002:a05:6000:22c4:b0:481:568e:11b5 with SMTP id
 ffacd0b85a97d-482c8107859mr24496137f8f.5.1787611073956; Mon, 24 Aug 2026
 15:37:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260821233516.3426127-1-memxor@gmail.com> <20260821233516.3426127-2-memxor@gmail.com>
 <f48031ff6aa8c6f2f7e98e4111912050dc9c3fd6.camel@gmail.com>
In-Reply-To: <f48031ff6aa8c6f2f7e98e4111912050dc9c3fd6.camel@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 25 Aug 2026 00:37:17 +0200
X-Gm-Features: AcwNN1VpkDbow-iMPjQc2-wj_ZcSjA-VsGSgOfgKjK0cOiQat3Izoyt4ZAVFoAI
Message-ID: <CAP01T756aroh8r44WsYsQF_8zBQBqARAoFcKPricsBinVLuFUg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 01/14] bpf: Split arena kfunc and struct_ops
 JIT capabilities
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Aug 2026 at 00:28, Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> On Sat, 2026-08-22 at 01:34 +0200, Kumar Kartikeya Dwivedi wrote:
> > Arena pointer kfunc calls and struct_ops callbacks need different JIT
> > support. The former rebases BPF arena offsets before a kfunc call, while
> > the latter converts kernel pointers when an indirect trampoline builds a
> > callback context.
> >
> > A single bpf_jit_supports_arena_args() hook forces an architecture to
> > implement both paths at once. That ties bpf_arena_alloc_pages()
> > conversion to struct_ops trampoline support and prevents the paths from
> > being enabled and reviewed independently.
> >
> > Replace it with separate kfunc and struct_ops capability hooks. Make the
> > verifier query the hook for the path it is checking, and have x86-64 and
> > arm64 advertise both capabilities to preserve their current behavior.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
>
> I see no particular reason for this split.
> Don't see any guards in the generic or powerpc related code preventing
> struct_ops programs from loading. Hence, I presume these are supported
> by the arch. Why excluding the arch, given that all changes are
> vibe-coded?

I don't think it has support for struct_ops trampoline if I'm not
mistaken, but yeah, we can probably let powerpc folks finish the
support instead of making the split (at that point split will be
unnecessary anyway).
