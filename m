Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6202E54D1
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 19:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786044717; cv=pass; b=JPDdTmiY+mSzdspIrgaYdWNRMqFNyUUSTpzusI4ZzmJsE8ZzhU52dFvKYkayWLW/ahHDZbyO4rwKJFCEGqRZuFZbAov7WucQnZP+Z+KpY8po1bXkOr67MBmUMoAcOooJvT4NIu95ADvUzj6hZ6aZ4E8FTNJkDwH5TtVJlUHcKmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786044717; c=relaxed/simple;
	bh=h34awk+LGDljGU1OLEAfwKlEXjXb/FOXJi9ZyqrqSws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W2TqoICTIOyiUSepLj8jZ1NMPZfUUSWpf/c8McLqzDsB6W1VjlO6o57Uj9SmmfUanKlS7Paflkc4AlIYqu/U38EbOIObW3Xa9SZtva8jQWwpdvTpDODMxWz/fNpj6yAUHD3cbfHGabIi0kacrorIlkp5BzYBz2cr3mAHkIVc8mc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qTE2Cr6L; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qTE2Cr6L"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-81f64e8dfbcso39878947b3.2
        for <bpf@vger.kernel.org>; Thu, 06 Aug 2026 12:31:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786044715; cv=none;
        d=google.com; s=arc-20260327;
        b=nPMR6K61WEMYYzZ8zlAOFq+jFrRq3eSiskyh/DVZrQbOoDrfn9eWI7GEXtO0lwdWUK
         TeeT//xjnU6R1mvikG5TohTF/gG6kdOjzQGjuqdRGC7lL1GupKWInTDY6OEgFdkmyKjq
         sAYZ3E9Jc4zR9VgMeHp6ER3eTVbsVs/z2zQA5VkaXr4F4rfY51RcqpPlhi+kmCpdOkpK
         GRouRdxVuZpKUCqc6pFGapGioxSta2tktRTGiEgWai8LP09vdYd0C/ce0y2dwHxLvil2
         M2KXcOzHg7V1jS0NUIBh2DYosBo7Ny9zhiUSeBgZvHmrufsxBTzCvvTcGTjhC5pKuwv6
         FTqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eSP1F/nY/wKDfVjAjiW2tAK8se6rUYfCWRASwLrV4+8=;
        fh=7K2qWJ3mUiPSelnihIFryY3l1DriTibHaNVcRL5iMOk=;
        b=aH+7sLCufAVcUfF4aATVqrf6fuxi9VrCr17dGNuprGHqb85lixkddfIqt9XiM11Hsf
         JFRC+TGO0toqqkKWK1GKBgVBV3CqkSDAGLwQges1E31y+4VGSh1jMfYzbw56kCLczQ8w
         AfJDDSnXQfiHr/hwr9LSvp7vQ0QTdO0V4Xpw2Dm9vOA695x0wUh/HkZJ3aP7HMz82bHD
         TByH7TQi+Cf11NdaJ4OmKN2j4mhtF9gKbrl5MVi0LtHV5Ki9CXjyH4MAVRgdZMMNGsnb
         KdVaS5QZDaku06tVBlgwHxe9+7W3ZCxTmZBEmaW9s28WnB2QhuxnVLBiRm8wYSROg6gO
         GrBA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786044715; x=1786649515; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eSP1F/nY/wKDfVjAjiW2tAK8se6rUYfCWRASwLrV4+8=;
        b=qTE2Cr6Lq9jbQWot6bj6zVWs1WqJx0JdAWG6SdGC/pYYvPOUqSf0pfdGn07GcvtoDc
         g3062++NVg4S9h0Bm2lyjLOEuuX7+NzUWjJ8rnS0l3oo8QRvkDQDNLHzEMuLJ8naQtha
         /wxhxO/Y1WO2RMlbnK+nrU6aKWd2J97rB1Zj45cPUGmItumBr3lcvywUhSM/qfbQcYYB
         qkXN/4S1PPx9oBWsjGNyuAE5V/QMufXNIfIDG7kKCdCf04LjWmjNrttExw6/v5O9US+q
         GAr7oW/aMSC8C+haHLciS6gRux0bQdwx4Z+LseAC83MYjRuNWxIO34vI/LR/flJDzdwa
         OZnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786044715; x=1786649515;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eSP1F/nY/wKDfVjAjiW2tAK8se6rUYfCWRASwLrV4+8=;
        b=XDlahKaGPnrt8KIiRdnAl6JBSPtw0oA7rThd9OP0ko19eVvAoamYt/5wFvlpVaL49I
         XGJptfrJdb3RX5YrH/xjW8xLxR4CbueHvwnW8enCs4L7YaF02DK3AvejG53MosGh8Wgi
         yFzfHHN+aPwah4UciwOxKMCtVm51w+wrzSEqSBv6uyxf9AmnXBU22Dd9h9gYc6cwnLgy
         B1x+1ys9qtxGLuAMYRsl78mG8tgBbYgQ/kqmoJNlz/Gsnb3gePaZDQWdq6qKiyt7WOnI
         oG+C1S9tvwRB4Qg2ZrYiUge7I7nFKS2vobgtVF+Fv8vrb9PHsunvEsbKo5HlfjYphMen
         ne8g==
X-Gm-Message-State: AOJu0YwfGdDDirXkLmIW/Jyj4oXna1A1rJzQuPyH88uln2QUFNyboq1d
	DSYf328DVcH/ZySV8OdskG5K2q4KZE7bcVBc1O3q4wqOREtHgAnnE6uU/TzOrwkIkyoBQWjTeSh
	beCrzriubRbs+zh06hze1VMjo2bLEStI=
X-Gm-Gg: AR+sD10PB6nzMMhk+sYqBV4C9UXhfk28xK1vTESKaRNgeflqGqhQVqbx2T+8hIuSmcN
	CrQTb5ad8gYHcQ8BMbYawkja5bX4XrWOaErqHDR4k0f/z0ii+0R6L0YUHCjQhdqu3OwKsOoue9x
	qgJgQ2cyRseJMtBNCrLRghpK73GoZeQgsdKZZjf2EtXlF9bjamtYePrqF2agOBqs8Py8Rr4A6U+
	+JH7Bk5LcUFK2taNcYdXu7tWTNpqLBYqRCSNNd9ArvFZIZTNc9oisxbMzfFKzSwdlWrQYZUZ8im
	p1tRfBGTjzT8wwUd6jQ35WgvEwvWYyKaYjqvW4OzyWgF
X-Received: by 2002:a05:690c:3510:b0:80d:c24f:b790 with SMTP id
 00721157ae682-8201f0b7b51mr115583637b3.5.1786044715117; Thu, 06 Aug 2026
 12:31:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805210427.3218326-1-memxor@gmail.com> <20260805210427.3218326-5-memxor@gmail.com>
 <CAMB2axOdf7jXcF2+esZqwUVXY407yu7XnkioJXnSU3b0ZsPzUg@mail.gmail.com>
 <DKI3RW4DNSJZ.3LPBJ6YJHOTHY@gmail.com> <DKI3UBTNC4S2.14C7ZDD8M2ZS8@gmail.com>
In-Reply-To: <DKI3UBTNC4S2.14C7ZDD8M2ZS8@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 6 Aug 2026 12:31:44 -0700
X-Gm-Features: AUfX_mwCBB6Jisy6qq7EZQKYOP268JrVdfbH7UU40d_jM5QoTy-XQc0pefVJTPw
Message-ID: <CAMB2axP+dm0r3U4-Wk2Z4T9+G8VmWLjMjrNKyV9CapzvPT_LqA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 04/13] bpf: Support __arena and
 __arena__nullable kfunc argument suffixes
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Tejun Heo <tj@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Eduard Zingerman <eddyz87@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 12:23=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Thu Aug 6, 2026 at 9:20 PM CEST, Kumar Kartikeya Dwivedi wrote:
> > On Thu Aug 6, 2026 at 7:22 PM CEST, Amery Hung wrote:
> >> On Wed, Aug 5, 2026 at 2:05=E2=80=AFPM Kumar Kartikeya Dwivedi <memxor=
@gmail.com> wrote:
> >>>
> >>> From: Tejun Heo <tj@kernel.org>
> >>>
> >>> Passing an arena pointer to a kfunc takes two steps today. There is n=
o
> >>> arena pointer argument type, so the pointer crosses the boundary as a
> >>> bare scalar, and the kfunc then offsets it by the arena base and cast=
s
> >>> it before it can touch the memory. Every such kfunc open-codes the sa=
me
> >>> translation.
> >>>
> >>> Add the __arena and __arena__nullable argument suffixes to make this =
more
> >>> convenient. The kfunc declares the parameter by its real pointer type
> >>> and dereferences it directly, with the JIT rebasing the value at the
> >>> call site, rN =3D kern_vm_start + (u32)rN. No bounds check is needed:=
 the
> >>> u32 offset stays within the guard-padded arena kernel mapping, and a
> >>> fault on an unpopulated page recovers through the per-arena scratch
> >>> page. A suffixed argument accepts a PTR_TO_ARENA or scalar register,
> >>> matching global subprog arena arguments.
> >>>
> >>> __arena rebases unconditionally, so the kfunc never sees NULL and a
> >>> value with zero in the low 32 bits arrives as the arena base.
> >>> __arena__nullable preserves NULL for optional arguments by skipping t=
he
> >>> rebase when the truncated value, arena offset 0, is zero. Keeping the
> >>> plain form NULL-free saves the NULL test on every call.
> >>>
> >>> The double separator makes the annotations composable:
> >>> __arena__nullable also ends in __nullable. Match the composite suffix
> >>> first when classifying kfunc arguments and function-model flags so it
> >>> retains arena semantics while carrying the nullable flag.
> >>
> >> Since __arena__nullable will match is_kfunc_arg_arena() case and go
> >> through JIT + regno check, and get its PTR_MAYBE_NULL anyway. How
> >> about just keep it as __arena_nullable to simplify the patch?
> >>
> >> 1. No need to introudce is_kfunc_arg_arena_nullable() and changes in
> >> is_kfunc_arg_nullable()
> >
> > For consistency, would you prefer that I don't manually set | PTR_MAYBE=
_NULL and
> > let is_kfunc_arg_nullable() handle that? That would be another way to a=
ddress
> > this.

Yeah. This also makes sense. No strong preference here.

> >
> > In some sense, __arena includes __nullable for the purposes of type che=
cking, so
> > it might make sense to add it to the predicate that determines NULL-nes=
s, then
> > it will acquire PTR_MAYBE_NULL automatically.
> >
> > We will still drop is_kfunc_arg_arena_nullable() though.
> >
> > Anyhow, I don't have any strong preference one way or the other, but th=
ought I'd
> > float this as an alternative since it appears to fit better, and detail=
s are
> > hidden the predicates.
>
> This will amount to adding extra OR for __arena prefix match inside
> is_kfunc_arg_nullable(), since __nullable should already match on
> __arena__nullable.
>
> >
> >> 2. is_kfunc_arg_arena() returns btf_param_match_suffix(btf, arg,
> >> "__arena_nullable") || btf_param_match_suffix(btf, arg, "__arena");
> >>
> >
> > Yeah, makes sense.
> >
> >> [...]
> >>
> >>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> >>> index b62e77949542..2b7f6f6bbe76 100644
> >>> --- a/kernel/bpf/verifier.c
> >>> +++ b/kernel/bpf/verifier.c
> >>> @@ -10909,9 +10909,16 @@ static bool is_kfunc_arg_refcounted_kptr(con=
st struct btf *btf, const struct btf
> >>>         return btf_param_match_suffix(btf, arg, "__refcounted_kptr");
> >>>  }
> >>>
> >>> +static bool is_kfunc_arg_arena_nullable(const struct btf *btf,
> >>> +                                       const struct btf_param *arg)
> >>> +{
> >>> +       return btf_param_match_suffix(btf, arg, "__arena__nullable");
> >>> +}
> >>> +
> >>>  static bool is_kfunc_arg_nullable(const struct btf *btf, const struc=
t btf_param *arg)
> >>>  {
> >>> -       return btf_param_match_suffix(btf, arg, "__nullable");
> >>> +       return !is_kfunc_arg_arena_nullable(btf, arg) &&
> >>> +              btf_param_match_suffix(btf, arg, "__nullable");
> >>>  }
> >>
> >> No need for the changes above.
> >>
> >>>
> >>>  static bool is_kfunc_arg_nonown_allowed(const struct btf *btf, const=
 struct btf_param *arg)
> >>> @@ -10929,6 +10936,12 @@ static bool is_kfunc_arg_irq_flag(const stru=
ct btf *btf, const struct btf_param
> >>>         return btf_param_match_suffix(btf, arg, "__irq_flag");
> >>>  }
> >>>
> >>> +static bool is_kfunc_arg_arena(const struct btf *btf, const struct b=
tf_param *arg)
> >>> +{
> >>> +       return is_kfunc_arg_arena_nullable(btf, arg) ||
> >>> +              btf_param_match_suffix(btf, arg, "__arena");
> >>
> >> return btf_param_match_suffix(btf, arg, "__arena_nullable") ||
> >>         btf_param_match_suffix(btf, arg, "__arena");
> >>
> >
> > Ack, I'll adjust this bit.
> >
> >> [...]
>
