Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EDC43031F
	for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 23:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785194294; cv=pass; b=P+RYwpgS6/P1kSc0fN/nCVJnNN0BYdzZ5ecWDUkAheuH2V+abKEs6vcyLVEsS5+EzbKe9SYNce/kS+mdvJLX8U8VXT3sA/om68sYwSMWGT+S3GB+OZEZRoehiBDMiBEXcdmp//B0Dyv+EwRouppxDKVnKXuX25+ptl9EkpGsC0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785194294; c=relaxed/simple;
	bh=a9m3MsCOA4DwS81XNzg595jmOt94UYwmyMEjHgZUyiA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mwhYydjjn8pFO3Yjum/Z7YfqjhX5Dg9ELjE0WdhtD6jSyzVtScvmCX3PiSpWNqx3jech5bn+1Sbqcz3gJKy+NELrlbIvp9i+/gDzd3KvZ9X6nn2joZFHWvZo0uunG1CmPc0KIrUcqsDdZUcidfz3yXU5rdE7MTMiPpZcWJbG4rs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KLjVXxbL; arc=pass smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KLjVXxbL"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-848479c9bd5so2496528b3a.3
        for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 16:18:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785194292; cv=none;
        d=google.com; s=arc-20260327;
        b=itThLaIOLMIrFl8ofVfsleNZxQuz3vYEeWDAxKoIYous4G5gUZOtoVdc1UZDQkK8QI
         rKwbLXDpCmyjjrwVjwW5wBW2X0TSpHVs0pb/KVS1fHoKyF1CCg53pXw3BXazuwSp03MW
         HG7hST1I4MDpAhX3TisiybGZ8iDPH4hYKhZ6wiET5gH32uOyZNlTQfALjKKjXh2SsiBI
         NuH5odIIbVD8e/i6Sh9n74xLLvaahrW92+9MJsclWTRnxf6q9jSyiHS5T4xm6vi3p8iF
         gTrQC+wN4OH+9I2BR1f2o2Im3oCkybL1inFtWH5nWnXCgd5T+FthMdtGX3EY/PPVxuNW
         tXMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CMRr8ODvBzEBfaC7I68mEUYsIki5Ldiyoxu2ywck1fY=;
        fh=aYWh8h/GZC2EgYNIUxXJNJP//lbEYAtK75WTuEP/ygA=;
        b=cl3vjnkMchpO4ic7YRp9PmpfrgdUy0AjmhiQkRs4TvW2E0tJQaTy7xzxalw8SUlr+U
         qOn8CGDTt27hNWkWxVgFSTNIxGFR1ec9hs+lN3uhR7W0nZUTWiuZ3C5E7gvZTLmrpAFu
         pOcPTZDj5/Sq2gdvj1vazXlH+gTpq1iI9GnxZfWYwAGinG6hi+1QZKC79C2wWo2O2Kq4
         NRqgOoA00a8ekfBhEuxFaNIWVmVFwypBmTHi1PkyvqCb3fSG4abecuPrKPopMEbgOWiK
         xtGCl38lP/rxEJF09TfugAUneaQTXaFUFJl1FZTTqoSxVWP9BuzSIueKSkjTu7CvxZpm
         NnSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785194292; x=1785799092; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CMRr8ODvBzEBfaC7I68mEUYsIki5Ldiyoxu2ywck1fY=;
        b=KLjVXxbL0WHbI5CSmXKc3so0TtZcFLNfVlLdPQpO0GmqJNse2QsIUGQHUHvvME8jim
         MH+MQGhT6FtiMEWE832UzNJQwOQN+tEYbmmMtQF0xlgTjybQ+UREoGwSIdtS2YGfBhSf
         Ptq50ss3SIPS7bcdwFbL8YJ749d9F4NWQBpTTPxS+5IM2u3JX1LYoiypxXu3LpxXjT/A
         fX8nUcjqpZnGKXkWJiQVQZEOdXp40xhgJ/tynKFK1VSJWWjow6htwJ1M2tgKR+MQIL/H
         En63LokkZIMXVfQsH0m8m4Yk3RfJs9OHR0UHDD0MYN4mh3SuGTeufLjax6e9VXcp7eg/
         4//Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785194292; x=1785799092;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CMRr8ODvBzEBfaC7I68mEUYsIki5Ldiyoxu2ywck1fY=;
        b=pgo5YJ5MGO++AWdMlbYVGS8sGRf0XET2UeIlcIhZAIt6unoBWzRbQDvzbGgRSgz9WH
         fPU5c9Y7BE5xj8tZEa3o9OrPFeNuZhkXgrFXCR/vQB5pZeweNxT4uG4IbQSJlsiDpotm
         5J/Is8jlpUQb8kCX2OXDg432+o4AuPUWCsZeI2F7wdsEAO+yZDHHZGH/nlWbfbg8uHv7
         TQ+35/A/PP4U3CrjGb6O3RKEcG5MuLZ7eythRuP7OlKkSjSuObEfRe2Hia346yHVdD8o
         uPBmfVkCiUXdcPcA4zNIrL1BMZam4tIkRWgQ5kZxeZabauF+f1cCyMwn1YyGhDOUIWvZ
         LvVQ==
X-Gm-Message-State: AOJu0Yx8+gna0fHsiuIo1la49ki8LVEXBw5SIfr73yDAqcAXMZFVUmSy
	v/7jPdmQoI0MrRv3aAoALMERzSRsLx2iGtyUKo7gxdBmRO6owkwiFpqlCh29rYmUia36EMNTIJY
	KEu8sTzjKtHkLNtS9Qii3+zXvHQsmlbE=
X-Gm-Gg: AR+sD12AYWm6idZ1iGNCZGNKJMzYHgJC1ruxsTtBOLRoq1Kj6hWFzQymeFTnlSkeVZL
	VLELUNiTddT5l/fEZFE3DPXDQgPdPgGD13T1puwocr6y6qbG+CfWFYg/BFRT3yfG4euz1KxCpUc
	yPm/mCeHVEVmCDxLklz56dxZSLcacqsuflcjL9gUYfhYsJQM/BdvcuAigoEK82x3riOrXMShQ0x
	KoUMTj8gQF5QKSQMLPORb55IxHgHRfKBhdURqNbFV8FVZ65xfKU29mWdS9biAsUGjgSI5+oyHOp
	CHlYG55uQXZx/J6dnNZX6WWtYVguJMXy/ECxbVc6mRupUV4vo+aPQnkCHQ==
X-Received: by 2002:a05:6a00:9283:b0:84c:1cd2:142b with SMTP id
 d2e1a72fcca58-84e92a08cecmr81919b3a.9.1785194292375; Mon, 27 Jul 2026
 16:18:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722072326.1545677-1-pulehui@huaweicloud.com>
In-Reply-To: <20260722072326.1545677-1-pulehui@huaweicloud.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 27 Jul 2026 16:17:58 -0700
X-Gm-Features: AUfX_mwAzIxEEQ2klw1VnFde242TsZv2rW4oRGyiwvu7r2fEkF2E3AR9SyjPO2M
Message-ID: <CAEf4BzYZ4JthZe_FZDVd8tHmVB6HDht7-FCL70M5ShFzOj=mQw@mail.gmail.com>
Subject: Re: [PATCH bpf v6 0/4] Fixes for bpf link update
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Amery Hung <ameryhung@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, 
	Song Liu <song@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Pu Lehui <pulehui@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 12:19=E2=80=AFAM Pu Lehui <pulehui@huaweicloud.com>=
 wrote:
>
> From: Pu Lehui <pulehui@huawei.com>
>
> This patch series addresses a few concurrency UAF issues within bpf link =
update.
>

each fix is independent from each other, can you please split patch
set into individual patches, please? some of them are straightforward
and can be applied soon, while others might require a bit more
thorough review and some more iteration, so best to split and apply
individually, IMO

> v6:
> - BPF_F_LINK flag set means the relative id_or_fd is a link, not the obje=
ct being
>   attached. We can not get the link while attach a bare prog with relativ=
e link.
>   So passing expected link type from callers of bpf_mprog_attach/detach. =
(Sashiko)
> - Add comment to explain that why ptype =3D=3D UNSPEC in bpf_mprog_detach=
. (Emil)
>
> v5: https://lore.kernel.org/bpf/20260721041048.1394085-1-pulehui@huaweicl=
oud.com
> - Remove rcu_read_lock_trace as rcu_read_unlock is sufficient. (Mykyta)
> - Improve commit msg for patch 2. (Amery)
> - Add Reviewed-by tag by Amery.
>
> v4: https://lore.kernel.org/bpf/20260720134547.1289964-1-pulehui@huaweicl=
oud.com
> - Add new fix for UAF due to missing link type check in mprog. (Sashiko)
> - Add new fix for UAF in bpf_netns_link_update_prog. (Sashiko)
> - Include the storage and flags rollbacks to patch4 for sake of code rigo=
r,
>   as it's hard to make update_effective_progs fail in __cgroup_bpf_attach=
.
>
> v3: https://lore.kernel.org/bpf/20260720033055.1215477-1-pulehui@huaweicl=
oud.com
> - Add new fix for UAF issue when reading bpf link info. (Sashiko)
> - Add new fix for storage not restored when update_effective_progs
>   failed. (Sashiko)
>
> v2: https://lore.kernel.org/bpf/20260717073343.958862-1-pulehui@huaweiclo=
ud.com
> - Fix invalid access for in-place update when storage changed. (Sashiko)
>
> v1: https://lore.kernel.org/bpf/20260714014659.401063-1-pulehui@huaweiclo=
ud.com
>
> Pu Lehui (4):
>   bpf: Fix potential UAF in bpf_netns_link_update_prog
>   bpf: Fix UAF due to missing link type check in mprog
>   bpf: Fix potential UAF when reading bpf link info
>   bpf, cgroup: Fix storage null-ptr-deref after replacing prog
>
>  drivers/net/netkit.c       | 13 ++++++-----
>  include/linux/bpf_mprog.h  |  6 ++++--
>  kernel/bpf/cgroup.c        | 44 +++++++++++++++++++++++++++++++++++++-
>  kernel/bpf/mprog.c         | 23 ++++++++++++--------
>  kernel/bpf/net_namespace.c | 14 +++++++-----
>  kernel/bpf/syscall.c       | 21 ++++++++++++++----
>  kernel/bpf/tcx.c           | 13 ++++++-----
>  7 files changed, 99 insertions(+), 35 deletions(-)
>
> --
> 2.34.1
>
