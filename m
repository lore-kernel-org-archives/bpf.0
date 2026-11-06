Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.225.134
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794007383;
	b=Oiq+GcbD3U0cYqxKzHyb9Pr77mq4esr0Nw6iJUesiPY6m1RllFVrTZ0JT2+3LaxdQeXe
	 qPu9I6gopU529CLEtmk/V8yUkLqqpX1BOHBCZVs+1essc1AGQyBW7lz/TDfECjFDEq8I4
	 i1uc1QG1++fG9ZTJXo8/3U0ByVBbJZX6DIli7mqNpBMxR8nxMg+v4gvq5GsPOdVkLmk6s
	 QymN0eq7bn4pNEhoFQTdgQ+HafmRWlQ5Pe08DSLSXjRqZPPNliarm2RSbZRkpurYxttnh
	 fjBKBidikQhqMGqv3I1pjZ2X1ihqa50APj0oIXT17FP4y8eGJZZ2r1mGd7EOy0xlAQQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794007383;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=VabAwN5EHMrSbv+P+zBpwr/dYRbvnw6PDPgBdp5gh4k=;
	b=Ls7KtkIz7SziyqNulRxrQaIgJa2dJaGsuQWSEnC+IilMwlKBawrz5WErMHXaf5Vln7Vo
	 FNVGEdMp0vqgccOeD6ZZRinBeZjFvaylmkGf8zIOuiXoW656/nHKute1uEJnwhbMdd6Cs
	 Cqd+q4rZU4B1649cqaa3QLbrdymBArds3mTFO5JUWGUILWPNZqHsj+HUieHdNtOTAJA9q
	 aTKzqgxt0L5ZMYI7KkuxRgeHcDzU2TdEMiYyxdRa8Zkyi9EEIHUqwCE8nTM37D7Dkh2RW
	 9ERS1BgHbIgmU97qlWUKxo7fWxPvvOGBX/tEE/ZuBtffhoBdHcjDU0XH85WE1NH68Tg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SFHUnrRO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.225.134
Received: from mail-wm2-f6.google.com (mail-wm2-f6.google.com [74.125.225.134])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D78606D826
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 23:22:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62D78606D826
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SFHUnrRO
Received: by mail-wm2-f6.google.com with SMTP id 5b1f17b1804b1-4a1d25d7d5dso4526305e9.1
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 15:22:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794007374; cv=none;
        d=google.com; s=arc-20260327;
        b=c2EdVgf5KeV4UTJcZNOuycmbt1ZofBwC6myg1ScgOvb/tiYte/PpqYzzR1MVPMI6e8
         yLIUwrquVX0SWKQkD3DPcVLmdQJ8qygfmPUW/X1cJQ65Gi3Lplp6ajmhKQzyptlOBGyH
         0XHTsyqBvnKz5yG1y7Ydbn0eazSyQpJDPMO4+uIBUR5yl9IUXJ5hNbIi49dDX1Tub3aE
         nT0qps/7VSrY6MAyOtstQbyI79h0rMkB3tMhMYgaRi+nyWWUNNe4i7SocA99VjvdvvxD
         jEWjwJaM86aKz2nzIM+PCtyY7goFDD1YMIxX7y+uZGmN6Sm0Ml6bHhH1a8GHx5iQrQM+
         BvPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=VabAwN5EHMrSbv+P+zBpwr/dYRbvnw6PDPgBdp5gh4k=;
        fh=Tcorti2bPcQ1wkcMaGVoxM9XcbbjNvXn05jKj+Vjadc=;
        b=gy9G2shtzPXh7EVh3H2dAAmtqGF0HxshUDt2x4hwSzPq1bUtfhodBLPUSSaAgH/uED
         +l1PUu9SDSrzQgZwRBQRfePAFINGJYhk2lNugqYrOowiJLriJlZOsAKXIkXFj/TNMb7F
         tZo0XMKNXKc9Jw8mqLq+MPbC3LzTEiNib3PwIgKw3Av19SXhFfrmyfbbnwsLjsFb8MjV
         Xw4TKytFjg+OK6r7fOrfnvohjyPrkll2svnWt8Hpt8pyVcBFbg6xEHft8ggTSS+YrZq9
         OeO+qv5VeZbuwwj7xHtpd7EphRfIcFWBPskK8bPR8tkozvJjNcIdSualNDS5SpV9esYz
         zjNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794007374; x=1794612174; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VabAwN5EHMrSbv+P+zBpwr/dYRbvnw6PDPgBdp5gh4k=;
        b=SFHUnrRO4HmQN7e+Q6AdBYBKl7yVEib9/QnyDkfax2tsrS/lmViMi5QKklwXxUFdG/
         +yhD60LaSLj3UkPoTaunOBXx5ZiGebn0BzmPRdvrOkTB5tnMIOyc5iFthV4o92GgZog7
         l/CQxuNRIOVJzdAgcsq2sTLOTwAgkPQu5bANdm46ndyCuEzLIcmME8ZKPS2Y2kLiqtu3
         Js0jtCimXYroSRoWxd03D6xFsu2ZeBfp6QaUiUQZgQjLOrgNvY1wYoIBNiaGaKMUvbCJ
         J+WKB8yjb9I+a6vp7aJJ6l5d4h/JU8btHlRYEgUZZxTI5O4KKURrMKCKCvLTviPgcrYg
         d3aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794007374; x=1794612174;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VabAwN5EHMrSbv+P+zBpwr/dYRbvnw6PDPgBdp5gh4k=;
        b=DYotJaoefet3MBSqIdyID4ZOKSh+HL5gkjsGa6DB6nIZP+2U3olPO+31CdITqXdmfh
         aMy1lohfchSKdf7gu/o31Fd9dKfcwRnQ6LDk+Wr+Pi5M2u8o5JV4lb94UUghQJ5IvEaX
         GcAlglybx1DmFBGKHmOzLDZ3qyjoIbJiT0ofVGSFbMFh54l1u8wwTpCd2QiT8dr+HCjW
         IVGk8F9UKABDxY7iC3+p9m8okA83Hk1uWUcZa1S5I1FcByyuOeRrHOMIWf69BcsoFaZQ
         W7DiJbywfJ8Qx4IUYKlP4xsEh9/aqXWEtffp6Gw5dT1r0LRbzQfhwuLGy4695dOsf6Yn
         Ucjw==
X-Forwarded-Encrypted: i=1; AL+hErFRJfczgz9Oa2Hr+hwCibquG13yPosN87UVdMX6CVrLDrpaqac9MjZ0GcTGmbkOpAhYjqM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+IsMyE4KBcEv6C625RDfJUfPcACLjucOGDQj5VbocXRLh163yt
	ewFlUFYiPfFGs9frBlSmEvi3B3KsJqCm1dwjzXCVWKtQmkwMl8blsmf3Y4yS2jHGNr+ouYoDgSn
	K1pAMAyJQPdAzj3D09f/wXV6mk26X8QE=
X-Gm-Gg: AYBFou3Z7OCLrgnPBL5MoDfEkSKHKWaQ4zIvW7KHCbXjWO35NsvG427DZXdA+h0bn7e
	AejqSDEKWWCYjlrL+WsYLJHZkAsZmfjMse4o37wf/N7mblJ25x/nhvOo2WzO3AApvelhxGccxMX
	8RxIWLwvmJGuNEBeoFxzy+nSuNDndzqK8AIC5YcBR/k7EX4fvmSpn0imVb0XR+hcM/cv9QBFWPW
	IQchvnQLfk+1F2oFuFzPq2ZyemNItca2tY2F9/hV6OoUjZv4OBRQRUJVEdJOnKkXCNvM6fAS7st
	ytLMF8bVlcKmtTxTSAXZOJ1pPRsBb9uvJc/MzNEbTAdnQLd1tfXSkTO/FK3HzOpXXfeUfLxTyQe
	K/WAKw+nPjxabGttQPSzGLi7K+MRD9ilSiT3aWB7B+62XrvAy7G5EU6U+2mJ+3Tp5yLh5KwxwVH
	tA1g2PxmUtKATnvM2mm8eW32eczS2h211kGjTUKltVMwDFe0YAxFFlkbEPuR7idxrv4LE6iYmC6
	xOFzvwsBtOiYQ==
X-Received: by 2002:a05:6000:186f:b0:486:f907:ebec with SMTP id
 ffacd0b85a97d-492776e6a45mr8476161f8f.31.1794007373491; Fri, 06 Nov 2026
 15:22:53 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106231157.2840635-1-ihor.solodrai@linux.dev> <3702b4e9-bda9-45c5-8fac-392db6451823@linux.dev>
In-Reply-To: <3702b4e9-bda9-45c5-8fac-392db6451823@linux.dev>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Sat, 7 Nov 2026 00:22:14 +0100
X-Gm-Features: AclHuK92sCiOAM7F3CpWdELzSinaVfoDskRhbPUSka9xmnk_bR16skNVIAILzSc
Message-ID: <CAP01T75v6J-8u7QV8hNJiUS95HHayEzjNhztSKiC-bN4R8kHfA@mail.gmail.com>
Subject: Re: [PATCH bpf v1 0/4] bpf: Scope callback arguments to their frame
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Amery Hung <ameryhung@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Nicholas Carlini <npc@anthropic.com>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 7 Nov 2026 at 00:15, Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>
> On 11/6/26 4:11 PM, Ihor Solodrai wrote:
> > A callback-calling helper can pass its callback a pointer that is only
> > valid for the callback invocation, and the verifier has no way to
> > express that lifetime.
> >
> > Two helpers need fixing:
> >
> >   * bpf_user_ringbuf_drain() passes a CONST_PTR_TO_DYNPTR over a
> >     sample it releases as soon as the callback returns. Saving this
> >     pointer in callback_ctx leaves it pointing into reused kernel
> >     stack and allows arbitrary kernel read and write since v7.3.
> >
> >   * bpf_for_each_map_elem() over an array or per-CPU array map passes
> >     the address of a u32 held in bpf_for_each_array_elem()'s own frame,
> >     leaking four bytes of kernel stack.
> >
> > Give the callback frame an id and make it both the id and the
> > parent_id of such an argument, so that slices and clones descend from
> > it. Invalidate the id and its descendants when the frame is popped.
> >
> > ---
> >
> > v2->v3:
>
> Sorry, I forgot -v3 when doing git format-patch
>
> Should I resend, or is this fine?
>

Should be ok, can be ascertained from the cover letter.

> > [...]
