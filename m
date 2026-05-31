Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29BB211A28
	for <bpf@vger.kernel.org>; Sun, 31 May 2026 01:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780191485; cv=pass; b=ArKCzUj8C8d8WJKlSkUf/VIs1hgiLJV4dsOvBOLKtA8zpt8skfOWqY9rl+E89gXeGVVHFVFfAz3GxjfxQst4iBaxci7cK/Hm1aO6SppyDUCgRD5Mn2fMgntRedlirG446I1pl5UvJ1lMhK9gcySMP0Sa1g5Gg4r2kaaMTQwzQBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780191485; c=relaxed/simple;
	bh=y3gLTJcDJCDzE/sfnkF6XTrsBFtj5BVc/GJwrhbKPok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uvo+RQHXuezQytvR1ex/gbrSQIVCwIygYGWTkdUntqnDGzQc4mBy5zShJsWpgPfFkha6UmV4lRqUyJZYKhmdw4qQrE+S+a1tLIuKXI3YdUDQFkBXCnBb3OMJk5C79jZ60u+juZVM8Z7kIgNWxQQYBqdAoIajl09Cs854/riT8I4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gSxq/TDa; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gSxq/TDa"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-516d6009380so31cf.0
        for <bpf@vger.kernel.org>; Sat, 30 May 2026 18:38:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780191483; cv=none;
        d=google.com; s=arc-20240605;
        b=WsCIY73EFHOJH+omq6KDJiFYNMahstXOjDauJY/ZWeh/pAQSXhuezMF30LZRjLltb9
         rUrsAJfrN37QnY1N6rTLjATlm6AtLIgSVzWceVgtGuaV/SugYFOpZcMdc33XVP2ldJKj
         oWjsDuAYGQRkUF/ehK0A6yTL618D/9zKSgh08f+psfyirJSHEqNl0+XElrwsWVtQFXXF
         OuqU5LUaxVWjhIHJfL2xtRTnZO9Kg8UyNiJEnX2zr2IqmiazGp9ZenDfH4rQ2R+9ossH
         eZu8mJ3pKQOf2AuxZZGCDbZ6D+DlG6MIctl2DKbQO3SP0Uh2gB20tqw3KxbEnl4nbQ1/
         2AtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7KEWFe5PI5fZtcQJyeW/bUVH7eGb4JFji1z5+4lcemo=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=kZfJfdXE63SU5qINOAc2Lf53PO4RFQ1Pxd1j1uJMzxeYd82jHqcYhbQolc7hewLGvU
         1VUI1sNdWaV+/LAA0zoxPdeh/+DHq1l/SyE2SAHQkDCwE0LVooHhBm88QG/+ohir7iX2
         9RR0FiRByAadmi7ttYauf7c/DPMS0CCtus9EDqr89Bf+OTMWiQGsvVIT++7IlqL4wQP9
         mB5tkxgJf7K+sQznyCLCswOFHUvQaEFGXSTv07mF16S4PSH4/Ihep1uCdftJlLfd3fck
         /1RdUogYiNpM6vw7QZrnFDCvZnpw7d4jIaAkA0dVkrB/WKidoG/RYgLGrgvpTzk99IIr
         macQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780191483; x=1780796283; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7KEWFe5PI5fZtcQJyeW/bUVH7eGb4JFji1z5+4lcemo=;
        b=gSxq/TDamRysYhsrifv0pVItipmxOM/PnRDYCffDHGy4OBiqA6+/N9awfJ3yyGBaCg
         6+ntiOhOP5W/PB1dE321nFtHCklrcQ0ORlnimcrhEFxaryakkMI2jfIrUsvzS9hqAcbf
         uUZXrnTGUHRO27MUfW/4yWhT08S/euxztXL3nD7cRmJzh1ZMjEdp/PuQI+IEOUOif9DK
         ZP5B0BggZni9SEI7iMbnrKhn8qlg9pxwfTvWEuVas7rVo3A3sh7TD1BGyDh1mrQ1klhp
         eHqQwwNN6Ihnm+jLMPpEppftyTsTCuEqsIHDWMPAW45Sr/EqCWZpYHTP2JCCI3VKzcru
         g8lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780191483; x=1780796283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7KEWFe5PI5fZtcQJyeW/bUVH7eGb4JFji1z5+4lcemo=;
        b=V4gpW0b1ZQzg1SNlsr4GE605Jp1t58fMiMPdPTtQBIqf0ioGBFLsvqIvk99L1F+2kx
         dI/xN5J5/d9CI/32HF/VNHIxOYaliZ2+8/eBDy++jEs5gNxFMP6P1nbX4v/vuhBa2KIf
         LgBh1nIvGdwcvtfw9FMjHz6CriLltgIJwtQwLt3sDTfEpkfY6P4R/vybx4ef+r9k2NbT
         sX7n0/A7u3CRDIW/wewIt+Tguc+HpFzRKz0AvvbLuZj047uJ8jNIPWyj11YJILjRnsWO
         EKTzoY/xf+DIQOiYaWob+FwyzgPbiaEfv9F2ZlgawIZq3c4r+yW7GOhKbZwb3qX7CxeM
         w46A==
X-Gm-Message-State: AOJu0YzfZxX9cki3BXa0TmtQ5ZOyQ5ypcEXIuEDkuzkhXJ8c5Gp0/yeb
	6sKPx3tStN1g5y1tAfeH2rmNBQf5De7IQg90jOTPRB2b6VvVl0fTy3pcP53FeWNb8w6o/QwItUe
	lm3NN7BNMOHupuPXXeps+W+/MgcYjsCb+x/FkOjhf
X-Gm-Gg: Acq92OEnGHfr2aedGdvyslmt9/IdKSpPJnUgSSCE8UfgtPZQ7ZPmFRpetCOGExNVvUv
	zqOkJSyrlgxVNkpQ0WFiiKyiYv+76f6BMoegdyBXPuVqi++gVQ/hZpEC0fDNG6BCEET28vQDAZ2
	877Kr2gBPsDcKN55aPDpRoGfTWOLH1xGD58RBuBEo85zShVX7Nftr8aG7hLDLqmNyQfHiR0MNZ7
	0JCL8W9aJEXvdORy5cFikaxN14M1b0A9rdysZrzmrlzcwbSBNP1C3nNcqhPctz03Talliy9VudL
	ta+RQ+UFlFyAsGG1fOrZZTpqBVqvoshmE0PdvrKu5jHY6rF8jk/5TsSMmvutfxKd
X-Received: by 2002:ac8:7f0c:0:b0:514:b17e:86f3 with SMTP id
 d75a77b69052e-5173b68d02cmr4503831cf.12.1780191482331; Sat, 30 May 2026
 18:38:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260531004748.3567875-2-yuyanghuang@google.com> <20260531005931.D4F201F00893@smtp.kernel.org>
In-Reply-To: <20260531005931.D4F201F00893@smtp.kernel.org>
From: Yuyang Huang <yuyanghuang@google.com>
Date: Sun, 31 May 2026 09:37:26 +0800
X-Gm-Features: AVHnY4JDaxYAfAHgGuWboGsrmqGbem2Csl5gpoCfrsX978gnKjtiiq7igFiEZ7I
Message-ID: <CADXeF1HwVBz3crJtAuKw_20cK4wXmoCQM73A_tZc+pc97veLjQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: reject BPF_PROG_QUERY with short
 uattr size
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 31, 2026 at 8:59=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [Critical] The patch unconditionally rejects BPF_PROG_QUERY requests wi=
th a smaller attribute size, breaking backward compatibility for older user=
space applications.
> - [Low] Returning -EFAULT for a structure size mismatch is semantically i=
ncorrect.
> --
>
> commit 205b70f382d21dfafc18f8275384ff0f06e59f6e
> Author: Yuyang Huang <yuyanghuang@google.com>
>
> bpf: reject BPF_PROG_QUERY with short uattr size
>
> This commit modifies bpf_prog_query() to return an error if the user-prov=
ided
> attribute size is smaller than the offset of the query.revision field. Th=
is
> aims to prevent an out-of-bounds write to userspace.
>
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index 9e91fb2fb492c..4dbf53e81a38c 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -4719,8 +4719,10 @@ static int bpf_prog_detach(const union bpf_attr =
*attr)
> >  #define BPF_PROG_QUERY_LAST_FIELD query.revision
> >
> >  static int bpf_prog_query(const union bpf_attr *attr,
> > -                       union bpf_attr __user *uattr)
> > +                       union bpf_attr __user *uattr, u32 uattr_size)
> >  {
> > +     if (uattr_size < offsetofend(union bpf_attr, query.revision))
>
> [Severity: Critical]
> Does this unconditionally reject older userspace applications that pass a
> smaller uattr_size? The BPF syscall generally maintains backward
> compatibility by allowing older binaries to pass smaller structures.
>
> By rejecting the call entirely at the top-level dispatcher, wouldn't this
> break ABI for all attachment types (like BPF_FLOW_DISSECTOR), even if tho=
se
> specific handlers never attempt to write to query.revision?
>
> Could we instead pass uattr_size down to the lower-level query handlers a=
nd
> conditionally skip writing the revision field to user space when the prov=
ided
> buffer size is insufficient?
>
> > +             return -EFAULT;
>
> [Severity: Low]
> Is -EFAULT the correct error code for a structure size mismatch?
>
> Standard practice usually returns -EINVAL (or -E2BIG) for mismatched or
> inadequate sizes. -EFAULT typically indicates an invalid memory address
> during a copy operation, which might mislead userspace developers trying =
to
> debug their applications.
>
> >       if (!bpf_net_capable())
> >               return -EPERM;
> >       if (CHECK_ATTR(BPF_PROG_QUERY))
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260531004748.35=
67875-1-yuyanghuang@google.com?part=3D1

The proposal in the patch is implemented based on the suggestion from
the previous review thread:
https://lore.kernel.org/bpf/DIUR88219HWQ.26T4D7ZX8CNTC@gmail.com/
