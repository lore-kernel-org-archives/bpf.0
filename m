Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C86A27441
	for <bpf@vger.kernel.org>; Tue,  5 Mar 2024 03:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709610307; cv=none; b=XuVVbgpqbuZ+Ai9o5Na8UYKPKWZZ1w/2LiYf0vE9m8azJnjWYLh0TLjpMZOg6evCEIWbXw+zJi1wL4G7TWQKnuYq5K69ngcWMm1lmXxROJtnoW/WE9mBCsRFVZlm8+xQcuPl80Eac8PBvbTD506UW+muTHIIxQZfm/5kcyujJvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709610307; c=relaxed/simple;
	bh=sdrQno3o1kVg1Faen4nvZ12ryVrdPFXuThqxDYmb8Io=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ib+XsDL9B0wB4bjTxjx5Eh4QqBFyQfrFCTh0AX2tDQXidv5m99gmYoCDsx5glT7op2/z95GF7knlUSoTJ+/rb1mGelzA4BEZ1R1I9KE4fkQNu3uurmut8RSaR2MUpnW2Ys6PIRCuuezTx9ElcfJjiAHW5sC1+lziKI5pk3askL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V+20CX3D; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V+20CX3D"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33e383546c1so839152f8f.2
        for <bpf@vger.kernel.org>; Mon, 04 Mar 2024 19:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709610303; x=1710215103; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x65LKIvzu5VeHJKqViZoIBW1f0SAuGvBnghYX/iuxXg=;
        b=V+20CX3DbOpfmGtB0GMgiHGke8DMGAh85Afu7F6y0QfMzHAREvnZN/MWo6doTeb3TD
         f6r2io4dBLxK8WXHeu4ScjzgaH9GdYC6QuIzDYXKZdKDq065fOc2L0c9JSLq3/iL2nvV
         tI0+a5qGsZ5wb7EycyDKyHCZrq+hx5SigAZiDR5rIz6n3eb9euTLOUut2fozt+n2OxnD
         TuBIdYC/Nnhn2x3GtI4+b/YHymAivxW8eiqjfwUTVuLXm35Z71JTr4QCKSBkzNp8VWcs
         b3I91ZRmHv4EbJ/rCbo3EFTNkLFq8N7Ck7mWQr4dkZkdY4ewgdfYCrfGzNYIv4jn47uu
         /R6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709610303; x=1710215103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x65LKIvzu5VeHJKqViZoIBW1f0SAuGvBnghYX/iuxXg=;
        b=rggaMOhJGZvzuwBoGTYCILUq02v2Ex+IJEuE4tBr0Wlam8CoESBFoSHTteBK+RpOZy
         rFaokWzucovGp/zZlpAHURVIVOLtNVayBu7tmnKVX0iIQAuvP3KsjZIWHDOUSBLVuyTU
         Q6MqouL6o48SEACR7OpxQu1c5krrKovKuxftykEZHK+NIngDZqA3fegnyShpu5FYJywe
         Lw1JKK4X0ha+3HUQaUpSjaqV79PZ6elMpts7+JNAoQ6JflaAkpgPud6phUC64MfAlYaw
         RXfmAbIYjW9auRsNvRsgy7FHzuhX5RS4c0IdIZlY7kKaV4eYekblPCtdabdibXumwCLJ
         Sgtg==
X-Gm-Message-State: AOJu0YzQ5j7c0zs6bryy1gUjluZtiqwHAf0qwhB7kUUvZY49mMZkrrYx
	5DbyCMQQGc4KZk1CVvu34R033OfzjZkYtFCmkKgjcO3OFF3zPac3LXdh4DgKD6oB7nsY3aWi7UM
	gZZXlCsv70mYJe0kNxTcZgOot478=
X-Google-Smtp-Source: AGHT+IEA99/gXoVfwvbBBodE46xa86URrOMK5VmRI0Dd9CvTS1j/IU3wVD1ZgP+Eq04S5P9OAy3giSQM7TlHFqw/hRU=
X-Received: by 2002:a5d:5084:0:b0:33b:187c:4ca0 with SMTP id
 a4-20020a5d5084000000b0033b187c4ca0mr8505824wrt.62.1709610303287; Mon, 04 Mar
 2024 19:45:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240302020010.95393-1-alexei.starovoitov@gmail.com>
 <20240302020010.95393-3-alexei.starovoitov@gmail.com> <136a8fbc350dacbb8b8a4a4c0236c11f1c49d4cb.camel@gmail.com>
 <CAADnVQ+AeSkSovp_4wDztNhGKMF0X4+k+36_9r0DUZD5horZOA@mail.gmail.com>
In-Reply-To: <CAADnVQ+AeSkSovp_4wDztNhGKMF0X4+k+36_9r0DUZD5horZOA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 4 Mar 2024 19:44:51 -0800
Message-ID: <CAADnVQJQYyHv_2vwi+A=FGqiqGAj5FLh6kNsGTHR2hy_H3viFQ@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 2/4] bpf: Recognize that two registers are
 safe when their ranges match
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, John Fastabend <john.fastabend@gmail.com>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 3, 2024 at 9:21=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> > >               loop_entry =3D get_loop_entry(&sl->state);
> > >               force_exact =3D loop_entry && loop_entry->branches > 0;
> > > -             if (states_equal(env, &sl->state, cur, force_exact)) {
> > > +             if (states_equal(env, &sl->state, cur, force_exact ? EX=
ACT : NOT_EXACT)) {
> >
> > Logically this checks same condition as checks for calls_callback() or
> > is_iter_next_insn() above: whether current state is equivalent to some
> > old state, where old state had not been tracked to 'exit' for each
> > possible path yet.
> > Thus, 'exact' flags used in these checks should be the same:
> > "force_exact ? RANGE_WITHIN : NOT_EXACT".
>
> Good point. Will change. It should help as well.

While working on that suggestion realized that this patch
has a bug that I'm fixing with extra hunk:

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 410ac8423cf8..1e823c40a6d2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16471,11 +16471,9 @@ static bool regsafe(struct bpf_verifier_env
*env, struct bpf_reg_state *rold,
        if (!(rold->live & REG_LIVE_READ) && exact !=3D RANGE_WITHIN)
                /* explored state didn't use this */
                return true;
-       if (rold->type =3D=3D NOT_INIT)
+       if (rold->type =3D=3D NOT_INIT && exact !=3D RANGE_WITHIN)
                /* explored state can't have used this */
                return true;
-       if (rcur->type =3D=3D NOT_INIT)
-               return false;

Kinda obvious in retrospect.
