Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563B323EAA0
	for <bpf@vger.kernel.org>; Sun, 31 May 2026 03:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780197192; cv=pass; b=IVrgUeLZyp7VJiJnbDr1S+2xb6T2nCjFJcTpEMa0bfTe3IPYB0BWv81IX6BQinBwSAndFLYcNnbbRRBFP9A+h4zTrWcvKyAA7ZE+pIaIopEGUTpJcNgZkqjPs5byXNa4EntagNBkID8BeenXRBFP3shDQnBh6gLvtBwztRRhPQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780197192; c=relaxed/simple;
	bh=CfucBwsLdVcr2ve0/amm3ZlavMN74u3y39FiocnxyvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VEpNY8pjjhEZ2AG7/K3stSINuH9eVdJ1VpcgVq/XjHXcXEACHn7HXifqf8w7W9wpLVdKjvwVixRTFl/1kCwfaLolp59gjcvATCwW8inNAnxR9uQNjC2bvp5ejsQUyOibuU/hBqaHwZd4zxi/3ipsMTxLP9q5R5QslnDv5AMilwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mJs5ueiD; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mJs5ueiD"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-50e61648f10so2891cf.1
        for <bpf@vger.kernel.org>; Sat, 30 May 2026 20:13:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780197188; cv=none;
        d=google.com; s=arc-20240605;
        b=AinsxYdYJB6xip7M4IqONyQcOjQhBsXcnwbaPNBPzhyF0iWxDldURsLs3V7rVxHL6H
         ZRIGS0l/KluWJEsL9nRkwCiWDt45XQ/2l5BC06PnLWlWXUmFWUsQVXodFBT89TmZP4HY
         qLoCKLmNnx8Dc2es+goDYe50NwSa3fkhUnX7JxefsIiTZ6jz0qMo6uzvDQnKCx76f6Xy
         GlE20jIcvODU7DRd0RH1sg47zOWjCwKA31hoxVJPWSI4176vlE1/KwjJm6docCMLHrJF
         m720XQVkG7DXGtnLQelmlrUpGWu2FlH8sHU8JcJhkBA+f2tBLqj/3SmGqMTIALTr1QTh
         idlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=t0aKFbssi/3YPxEE0KQ6RqqdiyefgKuZPgHY0IdlEzs=;
        fh=yiOb8/xJKmN9wj1cWf5vMhT01VYWo/CGPWOEaEvkKVs=;
        b=Pgk/4z/HlQikqVfgyxMZS95Jx+3yGRVQrhx5O2snwW55PxkL9B1lbXkmdOOAakvbna
         6X+gJHsqkXcE2QhgVGAl5ZPscAnR0j5yuKOWrKyoLcTaFCHdOmm7apzXakuwuHAtZKDH
         Hx2QhLYM6XCknvkr0p9+jsMN18tnbxMjPiNnNCIcFbdMU94V7AaYRatdLTM8g+qC4tUH
         nTSxYyqauIFF+QrwpxVkqp3kb20l9sk+KBesWBrG8NjpaWKLWXquEqLc3hSbmr3+Ymbk
         KHzYrlm4yzvcZokWMUFeP6POA2b2R+Gy06L30yClFUc6XXgGy4oHEKyYLQi25gb9bj98
         zsqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780197188; x=1780801988; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t0aKFbssi/3YPxEE0KQ6RqqdiyefgKuZPgHY0IdlEzs=;
        b=mJs5ueiDd5kBqqbtcpI3rToopFNGzv+OWAxZvZfCbx+RnGVkQB80OeT5WiKsN3JiiJ
         qt8l1dHibKbyj/BBpeLihhj77RRfiIgGj5O6y5IzM9pCJv4OCR+m+k4H7cdUWFdNfXVj
         F82VqGEuD4huwwAowf3Pe31raXuRVxvPFhd9O8IkrHYiW+wc7InoB4K0VLES4VsRiDDM
         62P9V40ZUvPWLsrFSfABQcgs2kWgvkHRkvITkaUnQWjKAQqFKy9+nvKcDFFvZYBWjat2
         sTrRsY49Dn4zab6Xyu+JUut2kpYOMk7oDeIGjXQ1j3VrYw0ISRpCN9aGwM96bu+8qTPI
         Vm6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780197188; x=1780801988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t0aKFbssi/3YPxEE0KQ6RqqdiyefgKuZPgHY0IdlEzs=;
        b=dluWqTz+o4ConBwk/RcYKrdPcI0eZGDE9YOCwiQAr7QdnK18X4m4d/qYJmrDY0GjlB
         LC6pgi/Cc5NoETGSWI/inJCtmh/35F0o1BH8RYOveqHmm+45TyNWGcpMwshqhN4HfEJK
         KvynapHr16Ii+BDXUKEqpZYwDlnpmLHThvH0/2vly7ovHwz7hGLfZfc2tAfQwihx9U7A
         sxfDJC2L1HkVjnZEknMsumtoT93LY3Qrg1De/DjwEz8smYTSefKDK7So/z2ifXJnSJVu
         mS+BE3RZh+Oe23p0Z4GwZgHilVRGlF317b0K/YndtbPSlJnWklO7Ov4CLAtoK6iiPORs
         CJtQ==
X-Forwarded-Encrypted: i=1; AFNElJ/zQ2VdiwqoQR4T+7B69tdEEhG0Tu9XjUTE7VOA9VcOZv3QDWvVrdReisZzUWo6ytEQxQA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcuuiwIHaieOzsi8QT0GcGNq7lwW65THxzvptTZqOHuTLJFvlN
	+MxcVGCP2eMkNbvgaDkaBgbfW9JqZELuFhDtxxr6dyf3ZGfxSCDcxh3BA6iXxdf2q79qG3Subzm
	sSvgQ2krr74kZnk7jWFjkD3UstADiqMxC4uf8HF5i
X-Gm-Gg: Acq92OHVPECNcMVdKEuv2vOb23qNS4h/u5L1zhGddBOLTKJF3BHkqWKWtdjr5U6cgrO
	EcMVzn/+XSn37oxycGoyinubTeuedYc75ImufNjUJwjLpZLlvk43sWiGWaxSo5ZLFC7732s9wlE
	cAkhwTbKsYbnMXfsxowqMIlZn8s9Plngim22zfqrOrS0IdhV8ZfMkSuEWqA8edOQ0YTul9M7xdG
	tx8qtsZOIhOBqKA5fx0rBPMNpPZPdcdMvOPm3oONvjt9j+VuhnSgEOzUxWqvStYhuh4KqMm1njb
	RDnGrld20NvEaY1WbHUlAvYd3UEck2n2lwcIRA45Bqf584pxjN8kD8C+9HEQ97CK
X-Received: by 2002:ac8:520a:0:b0:4ff:bfd9:dd31 with SMTP id
 d75a77b69052e-5173c7d3720mr9449371cf.5.1780197187595; Sat, 30 May 2026
 20:13:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260531004748.3567875-2-yuyanghuang@google.com>
 <20260531005931.D4F201F00893@smtp.kernel.org> <DIWIZY7U8VDW.Q0HWZ5FCLRLE@gmail.com>
In-Reply-To: <DIWIZY7U8VDW.Q0HWZ5FCLRLE@gmail.com>
From: Yuyang Huang <yuyanghuang@google.com>
Date: Sun, 31 May 2026 11:12:31 +0800
X-Gm-Features: AVHnY4JQ5t76RoVa3pXrRg3PNKC88_9EzRITct__Vizlg10yn0vREj3y0fpWg_I
Message-ID: <CADXeF1FsR4UKRtNT=vCP5zTLqzyr9_smNdZto2+uBnYP6998Ww@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: reject BPF_PROG_QUERY with short
 uattr size
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: sashiko-reviews@lists.linux.dev, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 31, 2026 at 11:02=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sat May 30, 2026 at 5:59 PM PDT, sashiko-bot wrote:
> > Thank you for your contribution! Sashiko AI review found 2 potential is=
sue(s) to consider:
> > - [Critical] The patch unconditionally rejects BPF_PROG_QUERY requests =
with a smaller attribute size, breaking backward compatibility for older us=
erspace applications.
> > - [Low] Returning -EFAULT for a structure size mismatch is semantically=
 incorrect.
> > --
> >
> > commit 205b70f382d21dfafc18f8275384ff0f06e59f6e
> > Author: Yuyang Huang <yuyanghuang@google.com>
> >
> > bpf: reject BPF_PROG_QUERY with short uattr size
> >
> > This commit modifies bpf_prog_query() to return an error if the user-pr=
ovided
> > attribute size is smaller than the offset of the query.revision field. =
This
> > aims to prevent an out-of-bounds write to userspace.
> >
> >> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> >> index 9e91fb2fb492c..4dbf53e81a38c 100644
> >> --- a/kernel/bpf/syscall.c
> >> +++ b/kernel/bpf/syscall.c
> >> @@ -4719,8 +4719,10 @@ static int bpf_prog_detach(const union bpf_attr=
 *attr)
> >>  #define BPF_PROG_QUERY_LAST_FIELD query.revision
> >>
> >>  static int bpf_prog_query(const union bpf_attr *attr,
> >> -                      union bpf_attr __user *uattr)
> >> +                      union bpf_attr __user *uattr, u32 uattr_size)
> >>  {
> >> +    if (uattr_size < offsetofend(union bpf_attr, query.revision))
> >
> > [Severity: Critical]
> > Does this unconditionally reject older userspace applications that pass=
 a
> > smaller uattr_size? The BPF syscall generally maintains backward
> > compatibility by allowing older binaries to pass smaller structures.
> >
> > By rejecting the call entirely at the top-level dispatcher, wouldn't th=
is
> > break ABI for all attachment types (like BPF_FLOW_DISSECTOR), even if t=
hose
> > specific handlers never attempt to write to query.revision?
>
> bot is correct. this is too broad.
>
> > Could we instead pass uattr_size down to the lower-level query handlers=
 and
> > conditionally skip writing the revision field to user space when the pr=
ovided
> > buffer size is insufficient?
>
> ok. let's propagate uattr_size all the way to __cgroup_bpf_query() and do=
:
>
> if (uattr_size >=3D offsetofend(union bpf_attr, query.revision) &&
>     copy_to_user(&uattr->query.revision, &revision, sizeof(revision)))
>         return -EFAULT;
>
> With single fixes tag:
> Fixes: 120933984460 ("bpf: Implement mprog API on top of existing cgroup =
progs")
>
> and explain in commit log like:
> "
> query.revision in bpf_mprog_query is structurally identical to the cgroup=
 case: a late tail field, written unconditionally.
>
> But the backward-compat hazard is not the same
>
> The min-historical-size test is per command, and bpf_mprog_query only ser=
ves attach types that were born with revision in the struct:
>
> - tcx_prog_query =E2=86=92 BPF_TCX_INGRESS/EGRESS
> - netkit_prog_query =E2=86=92 BPF_NETKIT_PRIMARY/PEER
>
> tcx, netkit, the revision field, and bpf_mprog_query itself all landed in=
 the same v6.6 merge window (053c8e1f235d added the mprog query API + revis=
ion; tcx in
> e420bed02507, netkit in 35dfaad7188c). There has never been a tcx/netkit =
BPF_PROG_QUERY userspace that doesn't know about revision. So for these com=
mands the
> minimum legitimate struct already covers offset 56=E2=80=9364 =E2=80=94 n=
o old binary can be broken here.
>
> Contrast with cgroup: BPF_PROG_QUERY on cgroup attach types shipped in 20=
17; revision write-back was bolted on years later (120933984460). That path=
 has a real
> population of pre-revision callers.
> "

Thanks for the detailed review again. I will send patch v3 based on
these suggestions.
