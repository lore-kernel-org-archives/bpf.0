Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E37E2F8BEE
	for <bpf@vger.kernel.org>; Thu,  7 May 2026 12:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778156533; cv=pass; b=Gpffr2oDnhOtPr+pOHo6P0Q8rXe5S3GyaBvq4Vf50QvicJsIo/E6Y26YzYDnuXMyxe9o/Cf/UnV7T8JG90xOa9G4P1v7Jr5HDr0Kt2K31WaAAYWuq0LUc4ZWzIpiCJ3lIC5m7czaFi6NRplDYj9TxQAxtbwrOA0Rz+g5HoysdZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778156533; c=relaxed/simple;
	bh=wBCXvaC9j2yg7DoEd2kvgUs5d80TdpoB6a28GCmXr0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lkj80gL5XctFJgxTvtMjOyXwOQQLJnX48nIeZWQxeYfrwfNoD2GPQvRCCIvTmRDLDbAYjq2Onhj2iWIDf2Pa6SneMZeJ1HXP+QFgfk5NmsVmXYLrgL4QuavZgk60naTLpSi2oJS984iFRKHok7hjVt4Pw4SUNVniOjde6iui4so=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=koVOEb/+; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="koVOEb/+"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7bd87e5d8ffso22335947b3.1
        for <bpf@vger.kernel.org>; Thu, 07 May 2026 05:22:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778156532; cv=none;
        d=google.com; s=arc-20240605;
        b=jTH9Q+eSnrfMfSjZ2HMJ6OzjsmBMQckEZu7S9jmx/KbxMHmQ9x2h4Pmen+EiEZHGj9
         GMp8dGzHqaC27zq3irGT/F1veVU+sSkaNf+IR16GRqx3WC/uLIDPJWBKUU2OXBUR6ltA
         gg5Yh3PTRETKRDdbkuRDMBGhLtwDWCLVusvRttftqmLHPB+wr0VruGytLlixj5D8UCAW
         mvLwjpzwbDRdxuSOW48gcQvHzuJY2bnGvI15jSXrwoyZgLTGmqR/1DyYgC/B4KtfQBDW
         hsevvLVPqCCYIVYkkmKbMVf/AK7pU10W8BopHW5LM3Tpc/rS1HsLrQyeYzZUzTzqh3Vu
         xlZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eqVrUrpja/dD28nHYBQb9LLVSkiT4AuuC+bBJBpxEs4=;
        fh=SS7tT0KC3jLZdfo/Ptau2hbovOS8lxj95BG5rgPZ6kI=;
        b=EIKSdg5BmY2RWgjDdX/p0//jfSs24eXwfsgvmGRzPgcgi2/64Ea8khviZsLGb+kf+y
         /aTs6fFbMzc19rzOe3NIjMgMLTD8UpJtZDWaMDhF6LrK9ihZ7NlyU0q0S13gXpcFRnc0
         M0d0H9D+2SZOMS8EKU4MnIusbZbGifaftBeT0rBijMrQvwgCC6Ak05zMf9fM0QltwSVV
         td/Dvox59S5A5C5+qsmBRvoHgjBNnvLF789V7+QesVSXeJvZDUrzGQkFQQ/mhNqTLcYx
         AXKCg07Crl3lFiOoxcSf+zwx9M1EuIg77rt2nsVvgFRrytLdVMgmeAfwdYF70dpAMhxd
         vJRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778156532; x=1778761332; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eqVrUrpja/dD28nHYBQb9LLVSkiT4AuuC+bBJBpxEs4=;
        b=koVOEb/+uC8o5LsXjLLxbQTf46NAwXrUQB4aWluKL3an/ZUZi2zhjCU5QbnP8CrmuE
         rp8NsSPzRMRteZO29xJLFtDH1XLSPSwH0bd2U0aD12idq9/iqmxOc+XB7d5hpcGi/w4z
         ZeT4iaiV1p/f8sZUUXq4tprhB4Vb/GUexx7msgSw8kTig6Wo922XYfmK5x4+Hw7m1i3u
         E4E67TiVSz3Y8IIjCNbzvqU7BTfM7/TBgBeTJmfL1yPnBdhP+bLtKQb4NmgMUMKWOiMU
         qy4dxBk5ONoEe6vmOysL6MgOSOqsseCtevvjldLMBWtkfaFrY3ggKn9RT4TRIhxahNMv
         i9LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778156532; x=1778761332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eqVrUrpja/dD28nHYBQb9LLVSkiT4AuuC+bBJBpxEs4=;
        b=leQzKweDeznODLruNSRFnGII7VHmyB3TRpq5iltvilANWW32rpRGEV08ovy1ADF5wo
         LdPsum5q4vGWaKtRGSCfyuaBtfM8j8J8TFoL2339Xj9+5my2P0oia8IHd59Yq3dGegWo
         Qgq2nMuW8af/vWVZK1FbeS6ELqLUwqCHlJqZMnzGyaJPWvso/BVQQISt+FPuuVFiz9bg
         tF3tnrNvz928f8+nhLhm19plsxvDFv2alCnaQJ+Rn+bPnjyWaZRII0KtBETXTp9C8lS/
         8FO4s4aolU6AdyD46pAqX9rCcc9P4/CgRQjvt2d4HTd5BjGuuvED3jIQ+jIZZcCjLI40
         KqYA==
X-Gm-Message-State: AOJu0YzexKk5Q5xBC05Yc3b6TNnXrbYin21OeHJtMVVNAf4/iiwqkJQF
	As1i1z+JHdGvM0zERUNQoKPjjvl5PIgWyHigaEThu52lqEFqH8JMngeHDO9uviVHAZhn/HYC2Ju
	KcCdGbzV2IoiDcsb2Sgl4ubw26TBZyoM=
X-Gm-Gg: Acq92OHhfHCQFIjnCae3DXlJ5aaHWsFqNRVTDGtmN9fsW1DLSnTz1aa2bOIC7cOFUdc
	x0StQIMhG3DbFJ9Q2sgF7bOmRjklYzlwLCiQkvgrWB6svcmUudUoX3CJX1xxQaU8MvGuEtpuvSG
	1o0UHkS0tXp3myyenEv1d81hYj3mQy9j5Pn365SjtOeXvlk4D/umeGCIE6mCY1TWQKWl7iwqWzr
	qM4IccTHFy64+N21eHuwq6RO8e26PngpCjC6vW4okEH++WUysKY/UKns6DMs7ZNFAqZhoWrZPgp
	CSdKW2xLjDD7IHI3/C0=
X-Received: by 2002:a05:690c:e:b0:79a:b49a:cb4e with SMTP id
 00721157ae682-7bf04b521ccmr20042847b3.6.1778156531553; Thu, 07 May 2026
 05:22:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260506142709.2298255-3-ameryhung@gmail.com> <6083c00dc3cc6e72f6a4d0d2ad6632f0950bf12b5c09e873d614128db8758cd9@mail.kernel.org>
In-Reply-To: <6083c00dc3cc6e72f6a4d0d2ad6632f0950bf12b5c09e873d614128db8758cd9@mail.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 7 May 2026 14:22:00 +0200
X-Gm-Features: AVHnY4KRzprocfoIf_8o5-0HrTPDqtdJopWL7Wzb2Cy4Qo-gmzSBtTTtTpSDNgw
Message-ID: <CAMB2axOg2CzkQxeJ5D7Q5YKji9sJYL6c16ODa4Y5nh1FNBfAwA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 02/12] bpf: Unify dynptr handling in the verifier
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com, 
	martin.lau@kernel.org, mykyta.yatsenko5@gmail.com, kernel-team@meta.com, 
	ast@kernel.org, yonghong.song@linux.dev, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 6, 2026 at 4:27=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.=
h
> > index 976e2b2f40e8..f330e9cf297e 100644
> > --- a/include/linux/bpf_verifier.h
> > +++ b/include/linux/bpf_verifier.h
> > @@ -1376,6 +1376,13 @@ struct bpf_map_desc {
> >       int uid;
> >  };
> >
> > +/* The last initialized dynptr; Populated by process_dynptr_func() */
> > +struct bpf_dynptr_desc {
> > +     enum bpf_dynptr_type type;
> > +     u32 id;
> > +     u32 ref_obj_id;
> > +};
> > +
>
> A review comment from Mykyta Yatsenko requested that a comment be added
> to the ref_obj_id field explaining what it's for:
>
>   https://lore.kernel.org/bpf/87ikb2tkta.fsf@gmail.com/
>
> The author mentioned in v3 that comments for id, ref_obj_id, and parent_i=
d
> would be added in a later refactor patch. However, should this struct hav=
e
> inline documentation now for clarity, particularly for the ref_obj_id fie=
ld?

For the meaning of id, ref_obj_id and parent_id, keep the
documentation in where they are defined: bpf_verifier.h

>
> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/254424=
56702
