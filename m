Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A406A366077
	for <bpf@vger.kernel.org>; Sat, 31 Jan 2026 18:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769885019; cv=pass; b=S/ZpRFhawi0r9ROhHKJlQhQQwdGDkjy3+cK1/E2bCTiqvnpTpHAFJ7xqB4+H+vTGsAwQlMy5NF/4ILBWq7JCdLo2JgwCPZ5uX2XGcH9A5fIoy/XsNCYpfNDS4nvInmG5PftZ9JqocwxOwGUI9+WNV9HXoKuHXi7C8sBrZo3zDVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769885019; c=relaxed/simple;
	bh=rkBEBYuwb/JC4c8oQq2ILFkkUFeJejQiN5E98QHGepg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NSbfIy4pZHpzp1entDz6/xWZstIxtvzgsbWaDpqfDxVAWFCeWp71tvqU44wFIfuWcjn9RwPTaSvObyb1BPPTcSM7PAxNJncKbXuaysJIWbTttNvtXCy/HkinZJxdDNI+iOdHyKu/WCjmzLIhiw6Gyaq/qipuqV3M5wolVQWrn2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S4C4cc20; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S4C4cc20"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-64455a2a096so2437541d50.3
        for <bpf@vger.kernel.org>; Sat, 31 Jan 2026 10:43:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769885017; cv=none;
        d=google.com; s=arc-20240605;
        b=Dp2Kn/yLsQmdcu7kLDmtpr1z+kSPfbYT2S0Zie1kj13cRBfNZc+v+VAdliCWYiXw2N
         TU0ktUt8ZRHweZYOX+wppmCSKITMAs/tRZtuUFMwgtw+q3aLHG1KTFsUdMJ+T+L/XI1B
         9LQ03XO12AQE8KBvAnloiRejJDejPdQ8IHHkuRCuEmcqzY6Tj0njv4mXC95h4p5WC8uN
         UE2Ypiss/ZyJWhl+UDCg9R0B/TqNbodD1jWFmnm8DZPi2Rxgn+W736hdoLGrLxlCFFqF
         hSppNYFp9qhAM8uMfgQ925QbGTkkPRUy1Xf0mVn+WSNyUlAIdelAcJy7hlJQS7HAGKzW
         d/tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TfO8hD4f0LL/XaXPlEc4lGUvKKLqPmej+W+yxaxFK10=;
        fh=NTV76uWbumciG3jeF60otY9u4fM38o9+fxTjJFdrb4E=;
        b=EIKS0EgdeFfr4g+Lxnse4TjSif2LS8SKkvfbo1AEACnKt63uDxSn4m9u/5LLuIRVPv
         KlxciiK2auTMEvgxG+/l3r1WjOoMEp4hZwJ27T7A8iCl1kK0dFu6JZQvZlrB5U4TbBxW
         u4pQLzhuEapcTeL21xvaKutqlTfA6bMhi6M6Q718lik6pt/mOxepbMu0D/YMxatLdTHM
         6ld5Z5tjEWiPf1bJ+X3rq5f8nVQynvTTw5epObJoi9+PdNgpYGSdW23GeeeAn+NxwhCV
         KUCJqCek3c11VxEtG5MNjpTYthyJat8NOfMO28IuvH1uA+mYbyly/b61e4XUg5Bf1iyo
         zW5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769885017; x=1770489817; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TfO8hD4f0LL/XaXPlEc4lGUvKKLqPmej+W+yxaxFK10=;
        b=S4C4cc20kLZB+/nhWaH9zt3S+k1W7YxV23lWhKyHcj6PIMHUcnvANgMGmObYmwQwFc
         8vXKCBDNDBK1qbWdJDLNQvhmf1AhKdT7PWv0lEyBS1PjcyS4Uv2nZ6AOUR1OIuQXiQq+
         yrHIasFa88ri4TW/TUfR1f0HK5zscXk5Q0YjnXYEptla4+b5v6ne4s3oLrLM0dMkv6dv
         X3MhIQhjBaoYwV/2RPQNDOYnRPpsHfsq0YvP1H6MUCGVCOIwZLTn6Bjx6VOyLOqQS4u2
         2rPRdGnmavrfCcwsSerxeKofu/El1wcoLEwCseaJQGI7rsybCP6m56H1ALZA5Ley8j8A
         aPSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769885017; x=1770489817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TfO8hD4f0LL/XaXPlEc4lGUvKKLqPmej+W+yxaxFK10=;
        b=i5gABG6Gukn1Tz8InbqJ0rd7cSF+1tLnRze6esxMCIqurh4FtHpka2fuhC+YBEQ1T0
         WoZYmOadRMZozBupuiZlJPZ83TdhJ2yIZe5PuqMc5pRhITkB5wP3Z1uxe4Vc1NLmzWi2
         tymIzUFBf7BPZrkwIYOXW9Gkuz+faUMYz9N1/Ki+tFc4iMtKylyNXCgXJ04wwmbCI9k9
         gNzKhCSjJDM3MAHD9AUWS6cac2P7yHSwTKj08r/+Vdmgq+cQb8J0Q3XZSXP8GLahiZWX
         0iXPwZWMvWR5dYcsx/Uq5vojloqq/MSzOzOn16BMnCtcfg60tJiDhooN9vLIyQmhzDdT
         1t0g==
X-Gm-Message-State: AOJu0YxYNyp7BCBfxz4znnK0L6LOaf0LqYwrn2Hd+zZHqRoHEVCPG/T3
	5vnUtBP6ovCGPveoYRCvnew30k1u+NJqJW9wtM72ox9supmATLgT9GHWB+Ky/hUOr5eJME44CLp
	9a0him+sZcNr7CrBPLgEiJA40ZeTx7cY=
X-Gm-Gg: AZuq6aKWvCjrELqhyCWWqaihvOZThP13ErNPpqgrIq5oIxamji0tJe153cxEGPOHzrP
	1OScS2lE/EWn57WWLQU2MFrNpPpOjMUJQo0w9EM+zg08VXIVmwzFjIkApVBHO7e+RFnuSQVmGUc
	lvhaXGE6fG/bx38Z42tPVBdqgmGvk3tj53XQPPxyLMlCIhNYGzR2u+b1357/zvqMO7pDmesGo0B
	V3zF8JpZdP3h3fsafZqI/EVEsXJluApH6FEbGUJ98kW/JakUUkwmhFhv3rGJhXYxxFwJeU=
X-Received: by 2002:a05:690c:6a83:b0:789:2be7:ae80 with SMTP id
 00721157ae682-7949e075338mr133133587b3.54.1769885017480; Sat, 31 Jan 2026
 10:43:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260131050920.2574084-4-ameryhung@gmail.com> <6497e7de7911a13edaf39f91f47719c418c67ea8918f589b7d08737790181e0b@mail.kernel.org>
In-Reply-To: <6497e7de7911a13edaf39f91f47719c418c67ea8918f589b7d08737790181e0b@mail.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Sat, 31 Jan 2026 10:43:26 -0800
X-Gm-Features: AZwV_QjsIQi24JfJzKfp91_VOK65ha6WnTVDIqndrexI5dIoypyp2tgWcMaSbyY
Message-ID: <CAMB2axNgigsCp2AYG9Smj+bRgN6eANP-yqmqUq0dQmSvxr3FNg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 03/16] bpf: Convert bpf_selem_link_map to failable
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, memxor@gmail.com, 
	martin.lau@kernel.org, kpsingh@kernel.org, yonghong.song@linux.dev, 
	song@kernel.org, haoluo@google.com, kernel-team@meta.com, ast@kernel.org, 
	eddyz87@gmail.com, clm@meta.com, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 30, 2026 at 9:33=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
> > index de111818f..9da11a531 100644
> > --- a/net/core/bpf_sk_storage.c
> > +++ b/net/core/bpf_sk_storage.c
> > @@ -191,7 +191,9 @@ int bpf_sk_storage_clone(const struct sock *sk, str=
uct sock *newsk)
> >               }
> >
> >               if (new_sk_storage) {
> > -                     bpf_selem_link_map(smap, copy_selem);
> > +                     ret =3D bpf_selem_link_map(smap, copy_selem);
> > +                     if (ret)
> > +                             goto out;
> >                       bpf_selem_link_storage_nolock(new_sk_storage, cop=
y_selem);
> >               } else {
> >                       ret =3D bpf_local_storage_alloc(newsk, smap, copy=
_selem, GFP_ATOMIC);
>
> When bpf_selem_link_map() fails, should there be cleanup similar to the
> else branch? At this point copy_selem has been allocated via
> bpf_sk_storage_clone_elem() and the map refcount was incremented via
> bpf_map_inc_not_zero().
>
> The existing else branch on bpf_local_storage_alloc() failure does:
>
>     bpf_selem_free(copy_selem, true);
>     atomic_sub(smap->elem_size, &newsk->sk_omem_alloc);
>     bpf_map_put(map);
>
> But the new if branch just does goto out, which only calls
> rcu_read_unlock_migrate() before returning.
>
> The comment at out: says "the caller is responsible to call
> bpf_sk_storage_free" but copy_selem was never linked to new_sk_storage
> (bpf_selem_link_storage_nolock() never ran), so bpf_sk_storage_free()
> iterating local_storage->list would not find it.
>
> This would leak copy_selem, the memory accounting, and a map reference
> once bpf_selem_link_map() can actually fail (after commit 3636ab200
> changes to rqspinlock in this series).
>

Indeed a memory leak due to missing cleanup. Will fix it in the next iterat=
ion.

>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/215393=
40647
>
> AI-authorship-score: low
> AI-authorship-explanation: The code follows standard kernel development p=
atterns and the commit message has technical specificity typical of experie=
nced kernel developers.
> issues-found: 1
> issue-severity-score: medium
> issue-severity-explanation: Memory leak, memory accounting leak, and map =
reference leak in socket cloning error path when bpf_selem_link_map fails a=
fter rqspinlock change.
