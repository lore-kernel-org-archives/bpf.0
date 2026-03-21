Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0E2282F20
	for <bpf@vger.kernel.org>; Sat, 21 Mar 2026 20:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774124878; cv=pass; b=B0qQ2E8oQJZpxItevjYmv23GN/YFqAusorcMEGFbLls8c2Vd4VaInOYPbwuwe1l5Nfyrs6VuPQE5kATwdthHacfm4amyDJnTf0U7kbli36SptBwvOaM+Sga/YPbtzn/fArnLc89sFendvL7p9PapNHgkCeBjBsvwI/TINrUoHO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774124878; c=relaxed/simple;
	bh=j56MK/XmyJDAiL5ZqQ0xvam3+646CxNKcRFCHLsiF9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DDFCzHy6dkHSIaKeF7TUfeDkEsGjufhc6auY8ZwE8G6YowMWFE/ZUnVfrnkeOn6IsWm8rRwpWIfmYwwkGsenlq9TygIOyRHiOR8yTWRF4+QeZs3wf7UF5I/jWwfMa2M05CUrN2Q7+i+fgj8fMdfdMXhyhCCRsHAVS7hyE0DRC7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HVi/IH/N; arc=pass smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HVi/IH/N"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43b4f48c47cso1251513f8f.0
        for <bpf@vger.kernel.org>; Sat, 21 Mar 2026 13:27:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774124875; cv=none;
        d=google.com; s=arc-20240605;
        b=TCV5M3wKJ8uLqjW53iXe6g66joeqGwXJn60flvY88Pe+ox9Vd6o3Q+EUXSSYgGx42H
         fguN4YxGJ1Ih8ozsVhsqTjt61qNP+AWOtZvp6DytblQ8ys3/AcXT4RGyTqwMeimtaPLg
         NwiASx19XsZvTCPbd799NBdsLAl3arDSsS+2F4egXQmH/xnUT32eMccnOvBhtMZrIYoD
         2sMplTy9e4SzaV4MlMMPLlEgqrn88CwpcZTGglM6mxBKwqHM6qdG9o6fWMAR6mZxy+rW
         Sv+umnuMW9BzwAfhwhVdyoClotpDp37w8+1AoZ/uYmP6/j4vzY0U1c5gQf5+TogCfVQ5
         M03w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UooymsuDNJI7TI+G8KMVLzk/rhypV+Vl6iMfBqzvy8s=;
        fh=jqaw7lxf2oyJP5XjvVp20GQ+6DhMuIirOz0q8T7AFyk=;
        b=B9PcZo2oTgFg+Ody5oo9KYUkNet3K4HNpIDD76+D9DvDI9Exz2azkLURcnkuDAqWSG
         pE1UEPRIinx1GP/0aPCM2fsAwvoMlkdnK8gXonYza0vR/GuOnC3SAEz2LnaF1lBAzymJ
         /SUSkdroC4TH9htbF2lFGWArFPwyuFyqhYLkD2Xrym9WwdH9I/VUEqKp0RfF4gwLCk/B
         PkIfgMQu76dIIoFOz7mbZXY0w8Tf5+LQia2rN0hfuH+a2YNIEbP6hi6owAJZ+z4hxyTZ
         Sdl3HvyQXUQEencCFCG0wF952KsUcLofDQHQLH9wsJknMu/dzgevoFyfP6e3eV7E43gg
         SIiQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774124875; x=1774729675; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UooymsuDNJI7TI+G8KMVLzk/rhypV+Vl6iMfBqzvy8s=;
        b=HVi/IH/NgMlay/ysFZMZaXFOXMyfKhJ0CF3h/55ihwaqPJQRPGg3kvp9pGutCN28h0
         /hQT1fzKfH30KHLph9Qd8EDJdUsjnETABMGzUDHl/EmjvgaOgmPY/cZtS2+n8UH1g86a
         XweffKVqLkJ0sNCXROYCBAQhlvnoGX9ihpq++22fxAmv95diRxgxof9deiMFB+QhiPhS
         2dNdC+jRdRkrnBfNyJVY1rS9q6WKYX/NgkNh6Y0qD3vZJMoJPaOtASaQz8J6c1WyTeoE
         U28/ly+1NP1kMe7Xls+6LTlsBqwK6bWvXdgtmWrF66XcdXV+LB6DYg2achrj/2IPUDBi
         uHRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774124875; x=1774729675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UooymsuDNJI7TI+G8KMVLzk/rhypV+Vl6iMfBqzvy8s=;
        b=skSxhXp2lx00f3OTrK1lGX0m0/Gid0id/H0Gcds1+Oam/gOndvs7CseqTeK5Tg9soM
         uj+0hZnsxsiy0knavNK61riZuaDoTcxoR/BhGXcqL7X7Kc+z8A73NEJd0EZxZZ62moMB
         PrHNDCfqS62KQBUMbROT5JtIChBWEkCSKg2llK5a5871elwBEt579BHT2jzWd2mLxlON
         KFhUg4aAI0CAZOVZDY0xj6O6djjkx0u4zeJvG43gAwSO+Pk/rk8wZjzkmVV3T1FFyZ8/
         u63crggIhE/lQO8QKlrNx3BlmlaMVwblatxsiV8g6c03bEDntoymUkSNrZ5zeoHoel+m
         +J8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWOs4gQNBCIlICuPI1wKeIsvodBJIfQRBQgY6LhNM1oKF5UrpOEAPJC4nnRFYCOD+ZHRWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVekh8uXk/YdqjnBturtcnK+z4nYjsekG1gpjYU3XK47m9s/l3
	J+RPJUANqTmYMrW3vUaWRkQh04Gu38p/zSNlfPgFj9Ikk84D9BMYJfNgTOAPeQnoDJjRZ+YPjt1
	fZ57y/de4Iany9Ox3eBrZJOgSaMBXdLo=
X-Gm-Gg: ATEYQzyMYH6q9qO20yuM8wxjSK28U+C1S0mltgfhMH4hNZNnAzwp0IvCFAOdlBnPsvi
	C7E6PV/kopp0krW34CU6lVBCATAlAWU/knh6IxVB9UhUGRREP9XwfRxobQSVk3YqCNOnnt9EPh+
	hgf0R9PLxU9q0VEwwqwCvXkUFzXdYUgAqP8CLdC6FLGsKAIfD++nq1Dvv6KZUyvWLVFbqS/YXIr
	J/LI14azktmJZNTxjIfAd1Cn2apfBurdGerJYti7jmDkQO3VvnCY72mCARo6RQJ9y12dXOUADHR
	zjxm8md34Vy9ZAuMKh5LXVJeg8ysANMV2sKJ7gERUdqcMyUqPhdAaQSLRRpiGDRSy7t2rDpGtsH
	19PBK05dSbmyZEs3K11nCfpPJlA==
X-Received: by 2002:a05:6000:24c5:b0:439:cb10:dfcd with SMTP id
 ffacd0b85a97d-43b64286f98mr12393871f8f.39.1774124874855; Sat, 21 Mar 2026
 13:27:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318234210.1840295-1-ihor.solodrai@linux.dev>
In-Reply-To: <20260318234210.1840295-1-ihor.solodrai@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 21 Mar 2026 13:27:43 -0700
X-Gm-Features: AaiRm5087drxxz8uWjvzDYmeMSVNopMNkOHJlPgH-0c64l3gsFLSm9AxmopyukQ
Message-ID: <CAADnVQ+iXJK46cFcGN-Ta8KGxe7Y+m_DxgWNS=QC-gOWT=WxCw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Support struct btf_struct_meta via KF_IMPLICIT_ARGS
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026 at 4:42=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux.=
dev> wrote:
>
>                                         const struct btf *btf,
> @@ -12594,6 +12620,14 @@ enum special_kfunc_type {
>         KF_bpf_session_is_return,
>         KF_bpf_stream_vprintk,
>         KF_bpf_stream_print_stack,
> +       KF_bpf_obj_new,
> +       KF_bpf_percpu_obj_new,
> +       KF_bpf_obj_drop,
> +       KF_bpf_percpu_obj_drop,
> +       KF_bpf_refcount_acquire,
> +       KF_bpf_list_push_front,
> +       KF_bpf_list_push_back,
> +       KF_bpf_rbtree_add,
>  };

it's not an uapi. no need to add them to the end.
Pls add them next to _impl flavors.

The whole thing needs a full refactor in a long term.
special_kfunc* thingy got out of hand.

pw-bot: cr
