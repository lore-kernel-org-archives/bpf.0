Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB0F3F0ABE
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 17:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774372972; cv=pass; b=DX7u1Y04EMI+GPkklBvbNQE9K5yuAyEFZeNhkK0NcmhtS+wh2A4ddFscx/4OThgi5aamh5RBgLz5PNdmbzso1Dmqp9ctwHeBeFznzjV7u0pFaQEHx3bf8i+gllkhS1w9BDvvx6ByHyV4Ok9Ov6cbIti42M7IUSxQXaQ34PQOAx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774372972; c=relaxed/simple;
	bh=sJTuFUb4Ti4T0ymAsKlUQeLVVOJZlG9wIVy/H/OOj+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jvVNOCtLxbsghGFSSkqWJW8w/T/2hxC2VyrBbEspZ8zjLO+iDXyhEtKG7gZJyg/ahCLKhTPH/jEVicMubG5WmkPwnTCkq969anBzgxdXJeKU01nt+3KhejzsAzQphE8f16LjI14UFpSy5PLrKYTu9p+Vl7xgOo6FY0a9w6g4V4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mFGboR1c; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mFGboR1c"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-439b94a19fdso3930367f8f.0
        for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 10:22:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774372969; cv=none;
        d=google.com; s=arc-20240605;
        b=SnnACmXzm1HMed9L+rfRbJvzD6aC9IUfq+v0J6eX9Dau88wZXxvGPaUPTwwPdKnVMN
         rtbsYKfw0KahXBvqgyyDA8tWv9j837G4Sn5vSfISTpnpoilYAk66Q8iM3mucgxdr749v
         WY9mn0xjai+teOSYmq75KKnBrFdNcYMKb0eKrYHah6fXn/ootPJ5YJREwlCt5bXmXMiO
         RvXsPLlYUrBxkY5Fmpd2npGT6xwZszxPJe1cpaf25CtGddYopJUCg7/tAjsN3P3pWJK3
         pjHRQ9iQELrjTQE8bB5ATmJkAxDdLNfGArSj+f4gNJqmcOwa1vUq2MQIx6cOaOzMBOmO
         DuxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1VXABupr2OCC3r+y5hHZyFvWeGtGdJxX2idEJ3H2Vc4=;
        fh=41RIQVPJg28AetiCgLusTNrQmR8ad3DXhDZUPFQgUmQ=;
        b=b3rqFeD2Tn+DrHcmYb12q7x1/u2/lA3iBt6WB9uLDqc1pL+ySzb2NxZxu/pzDwuOr4
         l/SQcMipckF5F8be92/KXzb/FhodZOxSIj5KQksW0DJw3etIb54athX+KrlhaMGWDUJK
         vngc1DphsRDiYA4RwnVDKG585iJ60zW+5itmLU5q+1j1Y/TutN59Rh149OpInbOfCjbd
         Oe1zyJNiDHCTFMANqmkNg3/w4lQ9X7ff33Gb4zBNs3Iu40iPLOSOdtaO8Zu+Z2PRPj/w
         +Cq1rYY+0QPlTbl8G+vDsQCw0+Dp80E7LferfObzao61E615hSITf/5UZLOv3PnhL554
         pDPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774372969; x=1774977769; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1VXABupr2OCC3r+y5hHZyFvWeGtGdJxX2idEJ3H2Vc4=;
        b=mFGboR1cr+4HLMJqdxLItGMQO3oxEICPxSa+KcZbHs8lfyShpG84NdhF5ZDsvNzikE
         qQR2ViwKTn402QfxvAWuT52U1m6GMfarr/J1TKyWRqYYxoBPK00DAvE4tLML8PEBpnLl
         8XCXhCl9iZdTyknSUL7Hs4HgVZa5ujMX2L1VcmGSr/vsdNeBQ/DEUnLXntg4mclOJxJZ
         c4u3v37IMOsHHuawq1EdNBLKXicPbyR9glLd7q84vCLR9bGkoBaMphYArNXxl4YotXAc
         F8jhpFCQ6ocSkR/iTB3uTkWwUbgM5HlEzQmG1uzWPk0V49cyZuOjSZhA54o7ujCeP1NE
         9n3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774372969; x=1774977769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1VXABupr2OCC3r+y5hHZyFvWeGtGdJxX2idEJ3H2Vc4=;
        b=KB0LCtqnRRt+2AsKyIpeMRsLBvZSeMoFFBGxkdxSiDm+JUQLxu/r+1uJooeFytCBEm
         PD6i/KWfkRyegKdKR/p2Kkx+JwHzo+ulSoyvULFHUXrHTBBU7Y6PkjztRrnZv+mC6hcO
         FhWR4rIOUIVxm4oHyalgVHe9Gs2CzkPYuLgjdFZNR+KNb600TqxG3t3AX6ObDk+zURGp
         64WPSD5b2ETCIDNyuXejNQML8lwKkW7xUCIrpTonLMrBoiZoy+DUsCOHTHuDfDi+6+Da
         ZNIsKsfqLOIHdXcNhXWphl+OFlR/i5bpQ7A65Rktdb36tlozsMZUOJKR8nj6Ja/BTKGz
         SGMg==
X-Forwarded-Encrypted: i=1; AJvYcCVHGkdlnb0B9HAAUwUFNy/xTCYsj+r9RrHA3fsD457odEeFjFRdgkpbU1w+XVwm/1t/71M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzljfedJFwQLAMfuyWN1HUmCYs8JJAoio9tP+G4yqBKDjpwLGV
	+t9VrOHMdQo9tEr/+aYFHdGec5aUfPXZulAqfwdHy34cRPT0JYMfmeZhMgwhDFq4ZCB0gGquw4c
	daq9W+7LjFs13TxAizVCcFWkXI5cz56s=
X-Gm-Gg: ATEYQzy/VtqKkMD3b7L1Pjeo67T6uc0QWxsu77Ogx0dY781Iub+xx+oso9CFekF1+pl
	ovAqAcRaO2iS6R7Gz93UduKkSepLuvwB0yuxz8Dv1H8PdYO7Or/8hp8twUwzMQDf6+7kqdwVxb6
	xeU5MOK82s8BkRq22YX8u8tCJweIM9YJnaoDRpzJyFKfVdcFBtaIEFMUVhUyd3CwRJvoB9kFy+n
	0gUWyTyL5wpfIPVkzXjAYsO6tLG4NLPpZgNn43e/kvkdltJzkYVJf44spdxWgjHzl8we1JOnlWr
	pKsS1u0DjenWl0crSiCdE/5bKhtRt4IJKtPClklHR1EJGJq/jJ09snIaTXPVTSj2T9O/ZtkmQA5
	le8PdoqW8Iy5kfOMUUCh2+3PoKg==
X-Received: by 2002:a05:6000:40ce:b0:43b:5b25:67fa with SMTP id
 ffacd0b85a97d-43b889aba29mr469553f8f.18.1774372968584; Tue, 24 Mar 2026
 10:22:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318234210.1840295-1-ihor.solodrai@linux.dev>
 <CAADnVQ+iXJK46cFcGN-Ta8KGxe7Y+m_DxgWNS=QC-gOWT=WxCw@mail.gmail.com> <b040711c-0fd1-475f-b807-e4e0b4324f6e@linux.dev>
In-Reply-To: <b040711c-0fd1-475f-b807-e4e0b4324f6e@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 24 Mar 2026 10:22:37 -0700
X-Gm-Features: AQROBzDUPzJFhYcDqU0IBWFIIDbgL2-nVc2flV-287M0NYk6NQquNwWOKEzf6JY
Message-ID: <CAADnVQKVEYhFXGXJ0u6TWQDe4t=zmq_tLpGKe2n_pOYT-J58qA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Support struct btf_struct_meta via KF_IMPLICIT_ARGS
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 12:58=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux=
.dev> wrote:
>
> On 3/21/26 1:27 PM, Alexei Starovoitov wrote:
> > On Wed, Mar 18, 2026 at 4:42=E2=80=AFPM Ihor Solodrai <ihor.solodrai@li=
nux.dev> wrote:
> >>
> >>                                         const struct btf *btf,
> >> @@ -12594,6 +12620,14 @@ enum special_kfunc_type {
> >>         KF_bpf_session_is_return,
> >>         KF_bpf_stream_vprintk,
> >>         KF_bpf_stream_print_stack,
> >> +       KF_bpf_obj_new,
> >> +       KF_bpf_percpu_obj_new,
> >> +       KF_bpf_obj_drop,
> >> +       KF_bpf_percpu_obj_drop,
> >> +       KF_bpf_refcount_acquire,
> >> +       KF_bpf_list_push_front,
> >> +       KF_bpf_list_push_back,
> >> +       KF_bpf_rbtree_add,
> >>  };
> >
> > it's not an uapi. no need to add them to the end.
> > Pls add them next to _impl flavors.
> >
> > The whole thing needs a full refactor in a long term.
> > special_kfunc* thingy got out of hand.
>
> I thought about this a little and tried a couple of ideas.  Here is
> one that looks a bit better to me than KF_* enum: BTF_ID_LIST_NAMED()
> and BTF_ID_NAMED().
>
> I vibe-coded a PoC [1]. Essentially, we add a set of macros to
> generate source-level stable symbol for each BTF_ID_LIST entry. Then
> it is possible to refer to the associated value directly by name.
>
> It looks like this:
>
> +#define BTF_ID_LIST_NAMED(name)                                \
> +       __BTF_ID_LIST(name, local)                      \
> +       extern u32 name[];
> +
> +#define BTF_ID_NAMED(list, prefix, name)               \
> +       __BTF_ID(__BTF_ID__##prefix##__##name##__##list, "") \
> +       extern u32 __btf_id_##list##__##prefix##__##name \
> +               asm("__BTF_ID__" #prefix "__" #name "__" #list);

...

> [1] https://github.com/theihor/bpf/commit/be38dde0a027d7ab84d8d20ac266251=
fb938ceb6

too much claude in there. It talks about everything except
important bits.
How does the above 'asm' magic work?

Just to clarify. This potential cleanup is not necessary to land this set.
