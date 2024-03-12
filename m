Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C0F79C3
	for <bpf@vger.kernel.org>; Tue, 12 Mar 2024 00:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710201805; cv=none; b=Hs2Fv+D80iZsGQtupsLB6/78F3blnnNaCS3bA04sg03dQNA7p/edrHC9G37e8h1MurK3+yjPtsPkLh4CA6/mSLmz593dnyX59kcW+xQnPzGqlUQF1Oyno0MzBLMh1uD8wsnF661qOU/DKZW23Db/nI7OMON8V5rvCLb7cMURaW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710201805; c=relaxed/simple;
	bh=0rywxW5LWNrRVP+FX+TNVrdVlabVvd3j9LUwZD5sk7o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KfP9mAl2ydOpuIlIaAk2utgyuzIT9TNKNTlF6LB+XKW9T+7S+b2Fd270fcY3A//OhWzdjk4wnW4clhx1+tIdz3goK4o8uhkgIpkq3kr+80ZGl1fOXVYdcOS/arbNX5RNp4q4B9TNXlYAfAYZGyMgrOFPLLInqrmUr+nqqpWUno0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EH3I6HF2; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EH3I6HF2"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e622b46f45so2816033b3a.1
        for <bpf@vger.kernel.org>; Mon, 11 Mar 2024 17:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710201803; x=1710806603; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UWIOUWsLF0ZADEk+WoR3mQfXtcf9jq/XXR/9LhmBbkQ=;
        b=EH3I6HF2+gmWOH017Fs+PoASVXOlkZOBGagEZwYDzd9HUk752LjKE0SKL0P7zZL/mu
         gHjhSP+GOcbtkVflrob5rttFw7FyvrCBWJGsltq7wAREjSbTtX3CU83BKVFjUBT4yF6Z
         GXUVMvAjmRUGG4Uiqw4ZGbJIv4BXjbGDwvD8Y5GfoJZpqamyukselBKfU/MMBK3hu+8Y
         bs7sWgB8vV3NSH3zISwVImm/42ksIumF1MuARMLCGus5jIFAFG1X3x4OwOPt3XwJmrzA
         9gVB/kauE3JvI4FrPqyOhhdImNXTIox7JiTwOCetdWMSTUjvsxXFmZm/cvbjTudw9xSG
         bsMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710201803; x=1710806603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UWIOUWsLF0ZADEk+WoR3mQfXtcf9jq/XXR/9LhmBbkQ=;
        b=lIKSp3FY9KxlMHwYn+QnMMRhx5i9H/JcI+w95TQkdUlfPukmWKcPb4KYRPWWprIuHo
         rJlDYGF8PFqJ0gUbAlqudAr/8ax6CJlmQJnBb1ePhe2wS8UIQbn4XEsw+qFeSIZ+/zvK
         tLyepZrvcFsSwvWD0xIwmCDn5EQ+bEheLwrGbCoDcj7fVJdDKzUZqGvd6nKNGeTJSmn+
         ZCTut3/n1fNFsBq4MYJXk5QBSWhEyUO5yYt334dhVq1Zb1OQEyAWfUvNdUq3Ib9Pr6do
         VNQaHOFIEND0blPDb5HPgTPF5NipoeOPlJUIltBYbRzN2Xe8C6xr3aUF0N8gij6EEkUS
         AXHw==
X-Forwarded-Encrypted: i=1; AJvYcCWkSTR+OFEt/2VyR5dou01V03cweXcTCVgcdzeylhICIg5Q9DJOR715u0eqVBb+FKE/YuCNo1X2Z7hby/xEv5kjChT4
X-Gm-Message-State: AOJu0Yxkp2lZymTBQJ7NC1B1XMb31v7jmC6v/SPef4VV8ho7X6XXzNC/
	yiZ5VtpewIAZS+7CeXzn9ApMlDH+n7P2L5ke6w2t+2eTUvpDJ4mQvWC7PvMHTVKk2lH+Rs5JWXb
	NdRM3QhSnie6aI8im1bpzsipR9To=
X-Google-Smtp-Source: AGHT+IE22EgkCNTw+YU7McBXT/98q1uQWlVgVryuWVgf4FUuhmsvJtXkTRjy1iUDe+9zMN/kz3E8PG/ztqLy2LBxUe4=
X-Received: by 2002:a05:6a20:2585:b0:1a1:8c25:fe8b with SMTP id
 k5-20020a056a20258500b001a18c25fe8bmr6347755pzd.27.1710201803508; Mon, 11 Mar
 2024 17:03:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240309004739.2961431-1-andrii@kernel.org> <CAADnVQKpCO+kF3Bi6gzpVWr_RUq20gmr+XgmytF2Ngv+gSYnCw@mail.gmail.com>
In-Reply-To: <CAADnVQKpCO+kF3Bi6gzpVWr_RUq20gmr+XgmytF2Ngv+gSYnCw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 11 Mar 2024 17:03:11 -0700
Message-ID: <CAEf4BzZ_BE8nAHig95YFY91GTmLX4eOig-zU7bN4ZUZvE9dyyw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] bpf: move sleepable flag from bpf_prog_aux to bpf_prog
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 4:49=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Mar 8, 2024 at 4:47=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org=
> wrote:
> >
> > prog->aux->sleepable is checked very frequently as part of (some) BPF
> > program run hot paths. So this extra aux indirection seems wasteful and
> > on busy systems might cause unnecessary memory cache misses.
> >
> > Let's move sleepable flag into prog itself to eliminate unnecessary
> > pointer dereference.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  include/linux/bpf.h            |  8 ++++----
> >  kernel/bpf/bpf_iter.c          |  4 ++--
> >  kernel/bpf/core.c              |  2 +-
> >  kernel/bpf/syscall.c           |  6 +++---
> >  kernel/bpf/trampoline.c        |  4 ++--
> >  kernel/bpf/verifier.c          | 12 ++++++------
> >  kernel/events/core.c           |  2 +-
> >  kernel/trace/bpf_trace.c       |  2 +-
> >  net/bpf/bpf_dummy_struct_ops.c |  2 +-
> >  9 files changed, 21 insertions(+), 21 deletions(-)
>
> Looks good.
> It might help Benjamin too to add sleepable callbacks.
>
> Separately, noticed that jit_subprogs() doesn't copy
> sleepable flag into subprogs's aux.
> This patch doesn't change that.
>
> Though subprogs are never called directly
> probably worth a follow up to copy the flag into subprogs?
> Just for completeness.

Sure, I'll send a follow up patch
