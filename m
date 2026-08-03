Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C88C42CAFB
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 13:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785764773; cv=pass; b=psXa2Fk0beHsXQ3WxDlyCSB6BDzSu/qcQbErIIgwO4HCeD04jqGiL+Ru/Pjb/0NQJ1Mt5Nm1Romn2lDejwbae6ZvuCxrr507ihg9smniC4qa7WumEw5Jgqgy2PiQnn03+goIyn5Snx9cxQP4CXylFey4Sj4thOZhtRmLCVAYeRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785764773; c=relaxed/simple;
	bh=Ee4kLdXfVk2GCa9eJc5mwREr0xBuHFjtFrr8xmqcFZ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uxVhhg+iB5TLO2RBqHaMY397jAMbz7N9phXkDbngZ5meHXTCjswao0tJKGHZz3G0NhRhSkrxFT8XYvcPzF/MCQDEdR3hA54vaJtsiKBCGgQk6rU0MW17C55o2OGirBU/t1PTi9EnuysBeoNHsDzjsjneK6lmpQKaP9pk6OZ2Ay8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nXbfito7; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXbfito7"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-80814edb536so48120107b3.2
        for <bpf@vger.kernel.org>; Mon, 03 Aug 2026 06:46:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785764771; cv=none;
        d=google.com; s=arc-20260327;
        b=KvSTY5zHFkWTNFRQhvZ5BrD36moXmdx1xp66ll3C7T4JWpfqFy20zduqfhLnx9nuHM
         EDU1wc1mxh5JVD9/Flfj5aQt8PXo0mT9UpFmUWTySdJI18nPTIDBfXBXAekLsZZuE96X
         +xzwivyAVprjyiOlurvyGVfyXSIkFm6xDBFiCaQiXi3P/aqoLYGLgcwGfvieSv43CSjV
         pE+K6kx+za13rFPp1CahCb73DgYbMYa91fc68Zm7aJSQhqeJMF6CAIeB/KxVm9TK4hzi
         Mo5qvE6yW65TRwuKjU/ST0enefDavHZbvqGd+szxesFFAe4n1b/n2XTquGSSjMpebEnS
         Xg3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aFLLowd+OV3t61SPjHw+s1uSeKRn83nLQOLuHiouvho=;
        fh=tFjM1lce2Q/ffzu1PTOmuGHmBMKNr6L+5IVFo7RJ0Xc=;
        b=H0fPIzWZxCucSwQDykNZAoF8w46Pqe5ubK66cGKrKKpAYsKzVAMqv8+DsFNieJVsf5
         phG+X0zP9tSyvQBmR1YrAYREhdZfDFgsPiAsVFBp/Zgoe8+Iyk1ZIaKQfLZ1VvDCoBTw
         Pwc0Sm49U5HR9cwm+tNO6289ndfbAPABIEcsKJEqADX2vm9ZQvv4/ceNWxL77sLiMI2g
         uDYO57LF95uYmbdhZnEFK+8zcwR3oYNhzuK9bD9k10/RkcEr9hLEFLy5FmXRA+qUV18S
         nfIeO2a+QvQJ+Den5EF65NNgp5L95SM/WaBtx+OpTTM6rLLeoKonjaf+juJyTye9V9+U
         khtw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785764771; x=1786369571; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aFLLowd+OV3t61SPjHw+s1uSeKRn83nLQOLuHiouvho=;
        b=nXbfito7PDF93pQpmw29hqbkWhUvQ73zky3hp6Bha5drCbQD2XsTDNwd2Z6nwkkyvt
         vIHAIELyySxnFuG1tpS2FJ4Vo6E4yc4PcA3b/GeOn9mDkObjc135jTL/n75KY4fsW5D8
         r5b/B7u1UikAZyq54DNI3ynFsG5LPulnqi9hzJVP++qNciT52FQPvYWwOCtnQFRsDISl
         RER6C/KlN5WYjpxkePB8PCQ3g2dvxwB2zF7EwMtfYwjWRXCwTqeIzZgrsCFzsZVe1Qch
         A19qkKZh5/v/P82qv4AwDId1VFaITh3/UmBJckfPfx/T2/vXestDLyg9fdcIjsshjqOF
         CdTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785764771; x=1786369571;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aFLLowd+OV3t61SPjHw+s1uSeKRn83nLQOLuHiouvho=;
        b=SVgSHPqIiXi/mKRVfSSf3neIgfDanw6JCLO9EWtYa02As3qNH84l/77vbLEj4gPCHe
         uGxT0PcGxHdpWVXuMVwyZvRcq7VYb312l7SVRG4D6Sc8eKIKVTAS0sH0OavOOrYcwfgU
         PRfHivRlF6jKZdXvG3oHa1GBOIwYQRFLi6LFEH4tWT5PPi3U+bBKzSyMkcSFWX5kiTO8
         +7PTLCR22EBj0qdWw3E92IJURugU6TLRQwOEbUu1TDYJ9XDnoQCx0jjlZ/A9QFjXsdCl
         7AzqVoPaPiJVejabr6niRcwEpqP7R+ziIJxarUw+Ye3bgL5klT/YTigzJCuGGzpQePk2
         bMWw==
X-Forwarded-Encrypted: i=1; AHgh+RrDr79cZPfcVxyftwY9aAijwHqRAKKHfGfnzjvLYUH+Pp91Faq6WRviSgaxwniwbqysIbA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeWwOItQYL/u4ejkYg+FvHB1biVsE7siPsXZl7DZgyrZ4gYhMc
	jpFFy0a0wLRhShoV21VqeIQdjHFMmg2pf0H9+h5vRydC1+wdQ1c9+2YDXu2jqcyuRJ5V0WmQHyg
	8C5elGWM55sAFp5LsdLGQ8jAVR5njQos=
X-Gm-Gg: AR+sD10dFJ8CyK3fPzDCeeQW+S3e7fP/EZJaYedcJYvpTRbPrPjA6uX27lU3RGcLnfP
	SzdqZS2dOvcdJvl9x4rwzKMNfJkljrOAbbRE2kOYf/SM05l3TwOZgPUn8pqgb87kjeujDMz36Ka
	JGg18Pu7m4iUPPzCk48gARfWW0h+XLMOOJIUDazToX3GVtFMI5nO4tcLr+MFO3An240Q+v2CdOu
	hmj+vrLgHLcWYCF/y5dZZsmqR3KeMMwYnZ1hqBQz6KkMsHhMJL3FbCGIWN9zRDOECBRDqBIKmtg
	23xq1FXc3BPXk2awObIkxkvJ39dnqqXw/cRJ7WFW8XgDJr9D3+zsGYdx
X-Received: by 2002:a05:690c:6e0e:b0:81d:489e:8847 with SMTP id
 00721157ae682-81fd49c716cmr144522987b3.2.1785764770880; Mon, 03 Aug 2026
 06:46:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803112218.3361213-2-dingning04@gmail.com> <a66afeeafca30042408238757e166de2d5ed5bc93a4098e0d57627c63ed7efb2@mail.kernel.org>
In-Reply-To: <a66afeeafca30042408238757e166de2d5ed5bc93a4098e0d57627c63ed7efb2@mail.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 3 Aug 2026 06:45:59 -0700
X-Gm-Features: AUfX_mygFOBvWcZJpU-pd4J_Eq18s-OyZUvHm9LKyyCuB02wT2BpWLcTbEZuahI
Message-ID: <CAMB2axObnCmR91CTZjf8egdskM-DGVqaArK5n+YYmACUfSOOAA@mail.gmail.com>
Subject: Re: [PATCH bpf v3 1/4] bpf: Keep refcount_acquire nullable for
 borrowed RCU kptrs
To: bot+bpf-ci@kernel.org
Cc: dingning04@gmail.com, bpf@vger.kernel.org, memxor@gmail.com, 
	greg@kroah.com, stable@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, andrii@kernel.org, eddyz87@gmail.com, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, emil@etsalapatis.com, davemarchevsky@fb.com, 
	linux-kernel@vger.kernel.org, martin.lau@kernel.org, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 6:14=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
>
> > bpf: Keep refcount_acquire nullable for borrowed RCU kptrs
> >
> > The verifier can mistake an RCU-loaded map kptr for an owned reference =
and
> > assume bpf_refcount_acquire() cannot return NULL. The kfunc uses
> > refcount_inc_not_zero(), so it can return NULL after the last reference=
 is
> > dropped. Passing that unchecked result to bpf_obj_drop() can crash the
> > kernel.
> >
> > Only treat the argument as owned when the verifier tracks an acquired
> > reference for it. Borrowed pointers remain nullable, while owned pointe=
rs
> > keep the existing behavior.
> >
> > Fixes: 1b12171533a9 ("bpf: Mark direct ld of stashed bpf_{rb,list}_node=
 as non-owning ref")

^^^ The fix tag is correct.

Reviewed-by: Amery Hung <ameryhung@gmail.com>

>
> Does this Fixes tag point to the right commit?
>
> Looking at the code change, the fix adds && reg_is_referenced(env, reg)
> to an existing condition that checks !type_is_non_owning_ref(reg->type).
> The problem being fixed is that the verifier incorrectly assumes pointers
> that are not non-owning refs must be owning refs, which fails to account
> for borrowed RCU pointers.
>
> The commit 1b12171533a9 added logic to mark certain pointers as
> non-owning refs, but the bug appears to originate from commit
> 7793fc3babe9 ("bpf: Make bpf_refcount_acquire fallible for non-owning
> refs"), which introduced the logic:
>
>   if (!type_is_non_owning_ref(reg->type))
>       meta->arg_owning_ref =3D true;
>
> That commit incorrectly assumed pointers that are not non-owning refs
> must be owning refs, missing the case of borrowed RCU pointers which are
> neither. The current fix addresses this by verifying the verifier tracks
> an acquired reference before treating the pointer as owned.
>
> Should the Fixes tag be:
>
>   Fixes: 7793fc3babe9 ("bpf: Make bpf_refcount_acquire fallible for non-o=
wning refs")
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/308109=
49269
