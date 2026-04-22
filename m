Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17853CBE70
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 18:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776880971; cv=pass; b=ez8YMdNvmtmC4Jlz4HXkDwyhdc0+VaCfG7oszdJ80RCnHSNrLpvjRYoI9jrdMv2yIHQc0TQlrD7yf5ctMi/posKKR234EVs9Ut5CJ1pOW6rw50TQBnZHZ5A7al8FI8pnb8kkaF2GrZhzIbiMrRRFJwHOWCvKkmeTHveGcPqfEnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776880971; c=relaxed/simple;
	bh=a+3JDhdhwMhJYREte0wEA+1u50fphUJgOeMwKzWpQCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SpgjNX6tGAKtoeWWxMkhLpF60cEBjLoPcymqudztlU8KVpmWTjLWh4bIkIG5OTz+UE+k4+q7Iob7OWONGdvV3nTshFs8NsxspqxMvY7nyNAvIllTifStjeyNv1CgOArYYip0DxRp3gixsevcNRKzHfyUB4u3kzM2eOzKmaWHLGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ahnDQvA/; arc=pass smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ahnDQvA/"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-48984d29fe3so50684575e9.0
        for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 11:02:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776880963; cv=none;
        d=google.com; s=arc-20240605;
        b=MHk3jOpp5wbWJUm/P4X0MAK4qmeshowwuT6l8aLOLcLpbQpNPI8NfPahztftcHtuvz
         2qm4E+U7FkZ2RllIY9zLGmFlMaOFDlvQsd6s1xMlQlP2KdZMxypHjvc8SlNC3k+NVFni
         qRxE+QbHIAYQCnZGVO0dGOM6BzTTruybRwcfWF3l4HErzdvXudxdOB3IJtGkoMVneW7K
         Vv3GB3UF/MsmFb4aG6B7zBjTWOamJ0sgh3T4ZItdmHsqjloeZYoSe0kzCrp3iP6hFgXF
         kfl8Z9kCd+HGBcVaicy8U2Tpp2VeMQOZZj0C+tnVgtARJGy1nZrypVQJWTcKZhdNPpQg
         F1Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oUoucSIjSqtoUAST+U6xAMZMlzaPRwgI7LwsyACV2HQ=;
        fh=jM87FaDn6dc6F3Fi3qb63fh43mOx21gYcy7kNI8YGM4=;
        b=C7Xua9j1N0t/nfWnv4gvDRz52wUTiV0LIeJuzdFSp6rQ71q4b2lhEXpe5ub/U5oqI3
         qNBgEBiRjBpBj3JwsZ/brZBaytt+veuQA9IRPkOV8UuNk2tfJIdTESjJLqaQnbOv8fMN
         /ZLBC6cO1hfJosLMNxCsiCXQ36kcNOAuKHPjvULorZGpejumZfj5tS7ktbaBduMP50AL
         5EVsO32eBKuholL1llJeoEjj6t8ZLa++0OTMPmY7bVUHO5kPGtSKkzw0ApvW8juue0kK
         AQ9X6GWgbJO9WVNb3T7WUO6xd3C/p5le59M+SV7uywXZzm9ci9t2VG5tmPXmRuMQ1idK
         CiFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776880963; x=1777485763; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oUoucSIjSqtoUAST+U6xAMZMlzaPRwgI7LwsyACV2HQ=;
        b=ahnDQvA/jD+eYu6ajBRSx2yxB9c39FW3jgOq40y1aiV12Q5e6hswbXbXUDdyCKoyF7
         VbWPeZyH8P9Gm8vyljWrRGquyRZXTN6l9N+jUDx7N5smbXb44zUcagHFp0HzlwgbG/LK
         qUC+ayXzwRVto1CCRtQMacOSkFvAHVSnOjKIzBLb+YB75EObVs7uo64MPmwbzgv0GhXn
         Jxh1Tyer/tmrXkXJPKqdlecUH0HBhz3+UvRQF2ewmaP6LvvQgcgbymV4KgnaJzwUCCHr
         yhbTtX02E7kE7VmA3Xkv/55B/Ord92O9dD6cqrzUr5vfr911hkzjlQ00024kTeEYPkRa
         8Eig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776880963; x=1777485763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oUoucSIjSqtoUAST+U6xAMZMlzaPRwgI7LwsyACV2HQ=;
        b=bvM5RRy1o1H/GZfHnpUtfgwuETOFf5jwkdf91kkFKD8hDpoD7fa3GqePDoGls73l/o
         u9o5lCaQEsWgrkt5ZlEbwM7pLxCedANH8a/SHVap6aA9bvMjFD/8lT7KQrTH0+EN3KvD
         f1ZF6bxT9wlHNdaQsrkYnhZrRSbNxjCL1ZUsxc7WUA/5OkqZMccAKpwRPTkBJSzC5mVD
         ikoRAa12cGQJtwRr6a2OBBCsUjKpC8OBgqhmxTvtJqYH72x3k33l5ATfWue60lXet+J4
         OvUxrpGNcrwRkSuZIkcmRCxGfe0RyEecUvEZLiyyewREfDIXT7akQfVgIicNrHCPDevb
         +psw==
X-Forwarded-Encrypted: i=1; AFNElJ/rDkDLu38ZzEAgrr8VFH7arbNUNVd8kqXZVWoU4V83vPiFVUqhy5a5yHtwXMlzyEei5+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZxIjy+1zO//epKYlqPPQqGxEa/uVvk8eUw/JQG+qIZntlF5dP
	1EJTkauglsE9IATpkZEk3Vz0jOJ4lYtlwaen85orrtVuu/RVUdMB5a7238jSXmqLBSbTY3RQcyz
	RdUCK8Sd0SX8SnGSYj5rM7bCo+48VEYo=
X-Gm-Gg: AeBDievjbhPjJcTDczzRi1pFjEB8mFFsUhuNYDLZ0JG9WY0blBS9JZj1Hnj5RsfoofA
	Q+dTRlJd6ghsZRp2RFdLFWKrwwXWgL426kfTRkIgwkLnASC442IYuY+JwXoLtIrWHfdRTnz50df
	ORsopBnHVP2EePCLPiMkoS9hhkt5CnrqeIV9kZF0cedgp4XNHB7KyMRZKqGe+lscNHVETGfJmX/
	w7iB+59yDcgTf0s8AUGIsAHfqngzSD6BmfxaccKTVycbsk6L0zTrKc+NyHUWh7nRzBdi4V+iE+7
	5ih9+yNMP+N2TaXiUI5iYZX/2m/rn4BgUXv1Td5kB3kSxbrWg+KLnJxrk+hih1CG+FyhfatF+fS
	UvS7JLFbVgnSxobBrUxzEgeAjGRSJ1y1VT8UGWHbnEvyix6LdU8DmuJHzSUOflp+ELG8=
X-Received: by 2002:a05:600c:4f92:b0:48a:f18:ece4 with SMTP id
 5b1f17b1804b1-48a0f18edf7mr160152595e9.24.1776880963083; Wed, 22 Apr 2026
 11:02:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260422-sleepable_tracepoints-v12-2-744bf0e3b311@meta.com>
 <e93b3ecc3e3406ac70466f8083544d896295f6fbb3f07c8e5a059fa25f8f19b2@mail.kernel.org>
 <5e93b4e4-12db-454f-b900-68ebad02ba5b@gmail.com> <CAADnVQLBk8oARVE9vZoM8Cabtov3RVr3Ezp3tG3NahoU5=6ktQ@mail.gmail.com>
 <CAP01T76Ck1u5Cj-H81ipWvMXy=O=MzZk14cMZzTOL4YK=38EeA@mail.gmail.com>
In-Reply-To: <CAP01T76Ck1u5Cj-H81ipWvMXy=O=MzZk14cMZzTOL4YK=38EeA@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 22 Apr 2026 20:02:06 +0200
X-Gm-Features: AQROBzDNd8GWKItJOeP2JzuZfPEpcTiUNOI9hlsjD_PJW4m0twkX3bZ3_BziQVE
Message-ID: <CAP01T76iSk-nBUsjpD2QEZWme+crwD9W1_A-=EQSgrLq9x8jZA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v12 2/6] bpf: Add bpf_prog_run_array_sleepable()
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bot+bpf-ci@kernel.org, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin Lau <kafai@meta.com>, 
	Kernel Team <kernel-team@meta.com>, Eduard <eddyz87@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Mykyta Yatsenko <yatsenko@meta.com>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Chris Mason <clm@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 22 Apr 2026 at 19:57, Kumar Kartikeya Dwivedi <memxor@gmail.com> wr=
ote:
>
> On Wed, 22 Apr 2026 at 19:00, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Wed, Apr 22, 2026 at 9:36=E2=80=AFAM Mykyta Yatsenko
> > <mykyta.yatsenko5@gmail.com> wrote:
> > >
> > > >> +
> > > >> +            if (prog->sleepable) {
> > > >> +                    guard(rcu)();
> > > >> +                    ret &=3D run_prog(prog, ctx);
> > > >> +            } else {
> > > >> +                    ret &=3D run_prog(prog, ctx);
> > > >> +            }
> > > >
> > >
> > > Yep, this one should be inverted.
> >
> > Ohh and CI was green. Looks like there is a gap in test coverage.
> > I thought you added a test that does something like bpf_copy_from_user.
> > We should have seen the splat with config_debug_atomic_sleep.
> > What happened?
>
> CI will likely be green even with splat, since it may not be
> registered as test failure?

I can see the warning here:
https://github.com/kernel-patches/bpf/actions/runs/24787752184/job/72539372=
270#step:7:8176
We likely need to add some post processing step on dmesg that errors
out on new BUG/WARNING lines in dmesg.
