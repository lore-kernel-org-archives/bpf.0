Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E547081A
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 00:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775089077; cv=pass; b=NXbv5HB0wg897uQuNoW+lC8EQgi+KVm/zsaI+QiON+lHstWm5kAmIG0pX/xi85AH8Pj+k4LZquCbriVkx3ht5oB2a9m3/qgkmUM5Zk6xYpej6CaEBISUKdp9n1Frpb1zRHUoHi0JUxygLDLath9QTY4OKhbxs6mupmTjP7WO6Q8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775089077; c=relaxed/simple;
	bh=DSim5KI2t2HD4O7QrTR9N48LJ/Lqef8VdifIwSv0UB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=naU1iy97DxZ/n87pbXl1/ZPYUPfWjrUKcvjLR4oXWagJeczNG32YPAGbp3G9TETwWBm75QBeA1cpy+f901vRf8LZnXtSQbvj5eSn2V21fQG2nMLrRtLagcBr4uS0yfKoDHVaJYHDrA+kTHkZxC93bXedI/qBg3d6ctalrNhkxQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TI8TBQwn; arc=pass smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TI8TBQwn"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-486fc4725f0so2579035e9.1
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 17:17:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775089075; cv=none;
        d=google.com; s=arc-20240605;
        b=HgZmfpbCoLbDj7XpYmQH5iTUY21iachYqWzljUrJI02WuSCaWKERKxvNyta3e+cEV6
         eWvss3K1Seq1iFMf/R+DSKR8pR7HbzlHnst1Pf2VLZT4G8NOEp9XOCniK8+q4y8cRMTI
         TGSv64g9CCD4GUOxfziwVJzD9W3sNd3lSuzvhWg56y2jVuzbbeE/h3sjhFQEf6x1Q7KR
         GC7kk+MtoNnuHOp6gKe1DUKwpx0lsw+uOdyVQC7hbY3YA/TeT/fj76w2aNOwpMACFmEG
         qlPQwHRH7f0P2fNJnb7qVji4e+pPTnRaMA5sIkuH3neQxJ8rhquUcXnX6gBKsZRuDOJ3
         b8gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=81kI3vM+bo/cI7umAjTcjBXuovnv88tr7V91Sll+9Jw=;
        fh=+iGPRDHGaVyPX6HjRLMMAe02denQwnBEndsM7iuzqyM=;
        b=HxncBLlQ5qLM133SMG1qx41S20Af8JLAhS//DGl2Vrf4etoi+naM8MHteLJPuI0hVK
         MK1jPA3LP6H2L8L/ksZDtNDZPj3o1iAgILEVsN6KrMRm9r+J+ot+ELSGaeeeSIZoT7hM
         Gs1sulIOWzj21E36KJk81dwmDRkLfg2UjEO/cyOFEI6iTQ4iLQYwHFveL21Qo5BXHEnE
         Ub2NDNQap44gEPjMbvkP7aNMsEyC7Ud4cCXS9tumAqisYocsUyPR/pA8pS65U0MaTj/i
         lLU97SZ3KjMrkvo7tOF1izlVuZlIgxLDKDqJJFvLtwZdAkDfREivpeD5HTINN6O5Akty
         CKRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775089075; x=1775693875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=81kI3vM+bo/cI7umAjTcjBXuovnv88tr7V91Sll+9Jw=;
        b=TI8TBQwn3wHWfpM0iTHd7jyEX9tI/f3RdcBkgTh1eK3sbIPRIU7cd/wTkzBzPAePUl
         63V0FIgEFPp1781/R8xXev8ET8+KhXc11oBNji1lU1c8UaF35lg2f6Moyq4Auu/3Vf3K
         B+NwX7siiLFe6fHcO2XcfZzjCS6u/6xmzromv6t9EEungUajQ4Phqp5KFDZa85lCcVS4
         4Bdlt46sj0Yj1iOD7vkTWswqJsER/38DYZAK52pBfAWAETp7yMZ49nJ5kkyuTu6kLmI2
         HKY8wEKZmphSVK8eeX9q+FSUwMCPzGvD+VzdZAK5nV8sx1uYV0Vv5n+r5GrRIv4Pzrqh
         wWMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775089075; x=1775693875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=81kI3vM+bo/cI7umAjTcjBXuovnv88tr7V91Sll+9Jw=;
        b=c9bMoFzxzolpQPxutJ0YQioncCuf223enJE/HTEUkKG+s7+Mwygo6kZws61U8OGIwM
         vOZvB6O78vVEZDyGcPkyzrmj9VBFfBhHoIC0vtoH5ZUFLlH5tdqRBJWkDp3L8MyeR9wP
         BUm5l/wjw9yWyJzZuR+YUWxJ33xI8RiOYBx4C0FJ/0F2d4fV+BlwEb2cI5htZcaGUs7H
         KMdv7zrpIOqgvFavsScZoNmJeSooRFnqSzyMCjDHGXYmdeE5kg3SpEtsRzrJ5PtK7xzr
         xHYTyHmFJCl0Q68trYkjOJDwAqCaaEGhHilLlxwPP2AVjbu9EQz9OEiJH5h/D/e799/N
         3r3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVfKXg/MP56qtEhs11vKjsFVo+pjAf+nzs6ZO7R/NYSHKAPUjAcuF3mLYYkwbqnsC0w+P4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5Yy1tk4C8IWlnbiY8NJdayHwYHadtDWsr4cjQ8Z1EIbdijkuG
	imv84Vexn4bf+arvZq5Ua4hplhohDWvDKJcTMYFEDZmUEs1HpnHyblwmiAilgmVBie8r0+qmBc7
	F34mLS5RGy0vVHA4c9HmL9TuHHMynALc=
X-Gm-Gg: ATEYQzyZUPtGFjMEA9+2Y+WmVby1JpWrrGTKnpQcnrzDCxipXinA3TDU4awGetWoGj4
	V3iU2RKY/fA2xHveUKUBrg7p6jmp++rkFOfc6GJLpBuxQsDBs+g3oAzYwtC/Tf6FR8G3j89jT00
	I4Dl5ZSaA/W3bIbwqqInxQSXZlyvQgp5KElTqLAXVfIiaD4pFZf1tt0OyQX+8ckow4LCv2s/PYs
	g66iPLmbTRkEHfl4me60GWm+ED8D0NjplXo1KKpuELGd/at2b1OKxnogAdlmMdIQKWdmueXDbHJ
	TkN2u8W9Du44xFRNfKhmlSaH0eaPzYybVLICcLoWXWcscA1CvcV4AODn9TEdfhrJoMvdrapsuf+
	/RW8M4n89uD592+xmysLX6MH9lmIFFjqMqzJ3
X-Received: by 2002:a05:600c:19d0:b0:477:9890:9ab8 with SMTP id
 5b1f17b1804b1-4888e01f5c4mr5266945e9.3.1775089074640; Wed, 01 Apr 2026
 17:17:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401021635.34636-1-alexei.starovoitov@gmail.com>
 <20260401021635.34636-3-alexei.starovoitov@gmail.com> <4e615056-b0a7-41dc-9560-8269cd3eafcd@gmail.com>
 <8c5594573cc578240d3e55874b95a9fa4ff081f4.camel@gmail.com>
In-Reply-To: <8c5594573cc578240d3e55874b95a9fa4ff081f4.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 1 Apr 2026 17:17:43 -0700
X-Gm-Features: AQROBzBpbJeIVBNZyoBuOQjNsvSwCmIGlNRsxhaMN8GklElay9RCiepAt6pAGVM
Message-ID: <CAADnVQJXf0Ty-yKpztGasMkWdMUZhLEszLeMAwu3=qEW+bHr1g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/6] bpf: Sort subprogs in topological order
 after check_cfg()
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 1, 2026 at 2:10=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Wed, 2026-04-01 at 18:06 +0100, Mykyta Yatsenko wrote:
>
> [...]
>
> > > +static int sort_subprogs_topo(struct bpf_verifier_env *env)
> > > +{
> > > +   struct bpf_subprog_info *si =3D env->subprog_info;
> > > +   int *insn_postorder =3D env->cfg.insn_postorder;
> > > +   struct bpf_insn *insn =3D env->prog->insnsi;
> > > +   int cnt =3D env->subprog_cnt;
> > > +   int *dfs_stack =3D NULL;
> > > +   int top =3D 0, order =3D 0;
> > > +   int i, ret =3D 0;
> > > +   u8 *color =3D NULL;
> > > +
> > > +   color =3D kcalloc(cnt, sizeof(*color), GFP_KERNEL);
> >
> > It looks like we are using GFP_KERNEL_ACCOUNT consistently in verifier,
> > should this be different?
> >
> > > +   dfs_stack =3D kmalloc_array(cnt, sizeof(*dfs_stack), GFP_KERNEL);
> > > +   if (!color || !dfs_stack) {
> > > +           ret =3D -ENOMEM;
> > > +           goto out;
> > > +   }
> > > +
> > > +   /*
> > > +    * DFS post-order traversal.
> > > +    * Color values: 0 =3D unvisited, 1 =3D on stack, 2 =3D done.
> > > +    */
> > > +   for (i =3D 0; i < cnt; i++) {
> > > +           if (color[i])
> > > +                   continue;
> > > +           color[i] =3D 1;
> > > +           dfs_stack[top++] =3D i;
> > > +
> > > +           while (top > 0) {
> > > +                   int cur =3D dfs_stack[top - 1];
> > > +                   int po_start =3D si[cur].postorder_start;
> > > +                   int po_end =3D si[cur + 1].postorder_start;
> > > +                   bool pushed =3D false;
> > > +                   int j;
> > > +
> > > +                   for (j =3D po_start; j < po_end; j++) {
> >
> > Is there a chance that restarting this loop every time from po_start ma=
y
> > penalize performance? For example some very big BPF program with a lot
> > of different subprog calls, perhaps autogenerated.
>
> Agree with Mykyta here, remembering the index to return to would be nice =
here.

Sorry, but it will be too ugly for no good reason.
Instead of simple: int *dfs_stack it would need to be a stack
of pairs (subprog, last_idx) and what for?
So we don't rescan prog insns? Even if there are 100 calls in a subprog.
We quickly skip them over with this loop. Processed calls
are also discarded.
I prototyped it and didn't like what I saw.
