Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFA52DCF6C
	for <bpf@vger.kernel.org>; Sat,  2 May 2026 06:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777705004; cv=pass; b=aBDE0oAA6pq0AAA5f4jpaB9HbTlucIg/a9PQaXVnsVmxsxq4MtdX46/gzRNdW5KfkNOZAVL2zLJZYCZehAQrB7gyzib1Rg8ijU003uikAej/pI9oF9s6WCMbe993tmtyfK/667SJIb7PzztMj2n8JkdKf3Kv3rmu5QTWFbioRdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777705004; c=relaxed/simple;
	bh=oSJu6qRNW36z5RoB0ajenV+etwkodjeFwBOEQo+wOpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YnYQ3N4EN9XDQJNNJIwyBySFyPX8cZfk0Pwvi9IlEItCVt8Xupj3QJLzB8OKRJavkb+J1hGsarIJtaigfPUgHSCa741S4jyRWTrBY9Z/uFzKeXDfDAj0Z/bXGp78yT9WTG5KKpCvdXt6IgV8rU/YlERblsViilexMI4nNyj9qKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dMEOWw10; arc=pass smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dMEOWw10"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-448528f4e69so1441632f8f.3
        for <bpf@vger.kernel.org>; Fri, 01 May 2026 23:56:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777705001; cv=none;
        d=google.com; s=arc-20240605;
        b=Z7i54hkdnYHqAaKQmIBVWlmGy64y4cwlHci6yItCR4S0WPtmPqfM11giJK3VaRRdWq
         rJmBrv9ER7aKdYA81MHSAx/WtckCaNP3QZRsRWOGRV4f6AwC9bzkje2vmedC36c/c2Qf
         Rl8veQAhZdRCZtUR+GBtrTKcgAO0gjiOtRXfJn9wSC00NXlQ5W0oAdHu5OMWhW8hcNId
         1qXSJxsiaqEb+EKpT05WJcen80NEdHOFzh9YCiZoqVrCBtQrdrpHnv7bk46OXZbgkkGL
         sT+PCTK0zOI9s2p/Frv1MLf1PgYMXnQxicgcRPL5WV5iEJDlzPrHUlSWjxUDPtH5UeLQ
         lBfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rqsOmE4q8CYbuftk/Yrt3ftCgKR4ea3DM+2qgJR1yfw=;
        fh=Ykvg/22wBr+6hhurmuEhGSyWGsFEoxXblrrSeLpn1DQ=;
        b=l2dLTIY6icYXQ+qdaNfzUGIVyypF8pLfxjnsmt70+qg6J+twxe4N0yDVByJEPJ1MeM
         /R9oyu3PKmGTZCAFOI8Ds0cDtSBtJmaBIFSB8+V8MNQEwbcbaCU4tE6EzV76tJbHlgCH
         ZMjm4ViR57nRPGJVYv9ibBaajrrmClWRj72KKhUwlxC5Bh0IX2LqaNGJYlibS04FANNC
         jyEwVZeiVbboijUBwr0shQqVbqiaaT+6s0UyNDJt/n0sswEMjEfv7S5PElYVMxGbE088
         Q8PYJcDRFJgQ6DsEyowWa2vfKxvQB4WHYSQ7SQ0ZMo/ySnJYC/0GX/pVeQZY0idF2CuX
         5Kyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777705001; x=1778309801; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rqsOmE4q8CYbuftk/Yrt3ftCgKR4ea3DM+2qgJR1yfw=;
        b=dMEOWw10+Wqrq8JLF7NRl4r4cpIZT8cyp5fdidypj/fp2PwwOkvbILpYZau2mJ9xHl
         DHNcGnPeOYKzhf/MB/Z1ooK/bJeKY/3d9Md14juL/Np+0HAX4gdFmF/PIK9HWDkMoBz7
         RLWLVR6Dy9MPNiwLEXcgmm0Nymf0BWtt26GSHmjnOw3WZSggZlC/Uh8blgQLA71FucbZ
         Luq4p53tzQ2HkLXJXlWWSw2G7hJ5NoxiqMN7dbFkTgC9iYi6tH6oB7gkXH286ivmP/D9
         kRxOKJwgjzZ7z3iTMb3/DDwBF1rB0IYIsCk0p0+d0b84FFp5sZ5dtnID+0ML5zwOcBE3
         N1ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777705001; x=1778309801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rqsOmE4q8CYbuftk/Yrt3ftCgKR4ea3DM+2qgJR1yfw=;
        b=Yae8tE/TN7Jq8YEITv6AwkiVmmG/88TTadLnsl+WH8zP3gkIkcUxgQDXPcVmbe+RHH
         tFI3mrQWR+zDUNFNrRom/nFF0fuTuTbVIIUxAYNTa/FcvqXyUVpsEuzq7oLo5VJHwPW3
         vOinb/Q2sPSsvrdJvMQwr36ergABkxa0W8Z6yRjHbQHPQSvBlbbQCXRkm5nRDSI538KO
         oRm/dEGCSTLXbuUoPWLHEhSQmyEx+KK8Zp1loe8MsnrCman+3UeTv/n7e7o5obt46GOc
         BqkEEF7i/T8E3cL+gbc3YMpSwC3NtoiQHcIqWmPGMPqigngpIR1aHN747HbByJbh9jtK
         npNw==
X-Forwarded-Encrypted: i=1; AFNElJ+ZC2bK6NwCU/wO/EZ4vNm5+3iq016xX0ylTNVU0G1nUXba2xIyHJPXYiocmCwxmR3UB4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTSDRh0IOHvi8re55n4123WT7xSnivOqmq6U9zFIYV+O+mrg1F
	m2g6wC4p8KNx690rJjX1urgzuKbq5lC9cs9EAuvNhZKjWcXeHypj6X9VJudHp4H2gz6h68987kF
	LD6c70AGCHcLpSCGv7Xij6EzamtwFhoY=
X-Gm-Gg: AeBDies6G+do57x0Jk2fbcM+ka76WkM/ad+ek4U206Zttry5oJTAQuJ+N7UEctmthEW
	HuhPaIzqEy9f57S2fk5ZK99RkzTS7oFfay5s47YuoBQj9AXP8ObdfrXPW49gtbeQe/e5/c5iZs2
	lX+LpvkgHyg5qQS9q8KVafUo6yCEzyZuI6/jwIOLM9o90BpZqn+xAnndPbD651cn5P5yS4CtN+u
	dA7kuBviRSVvzwCI5bwwi+qSNp74XqqRp4wBlkBzb7C1H1Hi6TVzvgkUZYeVk3MKjSxRjsa4dP8
	w0fadvHK/xf0gfOgkIwpa2gdTseRCbK4S70O2obBhODKmwJCbTWd/frhFmg9vtSXK4GdkrbpIAr
	Rx7w=
X-Received: by 2002:a05:6000:288b:b0:43d:7a97:78b5 with SMTP id
 ffacd0b85a97d-44bb5e2deb9mr3228296f8f.33.1777705000845; Fri, 01 May 2026
 23:56:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGdYFN3uXA6gqW0yrsCcfx2pY5An0V1PQm1YBL5Zt63RaEAy8g@mail.gmail.com>
 <2026050112-gumming-overcrowd-a945@gregkh> <CAGdYFN1Z9xtOk_VP6OsZ8mcpsw5pZEk0VB_CrtKDk-AxhcuYKg@mail.gmail.com>
 <2026050112-hatchery-tidbit-3420@gregkh> <CAGdYFN0BdcM_QpsCh4YVD7S=7MeG+AgM63ZuUfaZS2gSUYHqPA@mail.gmail.com>
In-Reply-To: <CAGdYFN0BdcM_QpsCh4YVD7S=7MeG+AgM63ZuUfaZS2gSUYHqPA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 2 May 2026 07:56:30 +0100
X-Gm-Features: AVHnY4KSX28W869pxdI4xCchakONyBbQW6sC1tDOJIXccsy8bw92w-d7h5NXG-I
Message-ID: <CAADnVQ+M2AGCNU3f=1XA_bG=_KUUZTjZmpu5sVy70Bi0H_=BWA@mail.gmail.com>
Subject: Re: [PATCH] mm/bpf_memcontrol.c: fix refcount underflow in bpf_get_root_mem_cgroup
To: =?UTF-8?Q?Caner_=C3=96ZDERE?= <cnrzdr.dev@gmail.com>
Cc: Security Officers <security@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, bpf <bpf@vger.kernel.org>, 
	linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 1, 2026 at 3:51=E2=80=AFPM Caner =C3=96ZDERE <cnrzdr.dev@gmail.=
com> wrote:
>
> bpf_get_root_mem_cgroup() is registered with the KF_ACQUIRE flag,
> which causes the BPF verifier to enforce a mandatory paired call to
> the KF_RELEASE function bpf_put_mem_cgroup(). The release function
> unconditionally calls css_put().
>
> However, bpf_get_root_mem_cgroup() returns root_mem_cgroup without
> calling css_get(). Every valid BPF program using this kfunc causes a
> net css_put() with no matching css_get(), producing a persistent
> refcount underflow on root_mem_cgroup->css.
>
> A previous attempt to address this removed the KF_ACQUIRE flag
> entirely (commit e463b6de9da1), but that was reverted because losing
> reference tracking semantics negatively impacted usability in practice.
> The correct fix is to acquire a reference in bpf_get_root_mem_cgroup()
> to balance the css_put() in bpf_put_mem_cgroup().
>
> Link: https://lore.kernel.org/bpf/878qdx6yut.fsf@linux.dev/
> Fixes: d0f5d4f8f328 ("bpf: Revert "bpf: drop KF_ACQUIRE flag on BPF kfunc=
 bpf_get_root_mem_cgroup()"")
> Signed-off-by: Caner =C3=96ZDERE <cnrzdr.dev@gmail.com>
> ---
>  mm/bpf_memcontrol.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
> index 716df49..3e8721b 100644
> --- a/mm/bpf_memcontrol.c
> +++ b/mm/bpf_memcontrol.c
> @@ -25,7 +25,14 @@ __bpf_kfunc struct mem_cgroup *bpf_get_root_mem_cgroup=
(void)
>         if (mem_cgroup_disabled())
>                 return NULL;
>
> -       /* css_get() is not needed */
> +       /*
> +        * BPF verifier enforces a match between this KF_ACQUIRE kfunc
> +        * and bpf_put_mem_cgroup() (KF_RELEASE). Since the release
> +        * function unconditionally calls css_put(), we must acquire a
> +        * reference here to balance it.
> +        */
> +       css_get(&root_mem_cgroup->css);
> +
>         return root_mem_cgroup;

Please ask whatever agent you used to produce
this patch whether this change is actually needed.

And do the same in the future for all other patches too.

Really folks please learn the basics of agent hygiene.
It's not ok to spam the lists with AI slop.

pw-bot: cr
