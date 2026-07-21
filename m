Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C887634041D
	for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 01:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784597910; cv=pass; b=U77xU+GiNFzNZeJyRakrGqGpUR4Eo6kRGzx1R1grkA3svn9nrYTDsQs0P9h9Uk0OpY7ERIQyb1TT5ZOeYwmhvOF/myDancLN4ujehP2GDGKEo8hfxC7NDPr1Pv/Agf7phqN/+qMvk3872QB4U5qzScWCzggMqWECcgavcwMYslM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784597910; c=relaxed/simple;
	bh=e2HMnGLUsTuR+WPrwnUtmDcdGR9vbbrQRbg/wvsvaNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DfEHG5YKL+K6ZJ48EPi7vpNR1oihRQnfq/USTXIU61Gb5PBabRz2wsb5Fjjzp5Qyr5ZgpTD8TLHA4jQ+UvQPZVzgoGScBff36QqkuPOyYE+9GZPej4R9kb6CNh+Acj2i9ZR3RftiVViQ44ix6p/xSASaFtwC7eGi+4Xl5ZE6b8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GLD8w3rB; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GLD8w3rB"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-80e2cfe6918so61480557b3.0
        for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 18:38:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784597908; cv=none;
        d=google.com; s=arc-20260327;
        b=k7f++FYXNtbbl/JdfCL8blRA5xbr6jqBYVyflqo2aFFjQE8VwHeWoBtrddhinSifEx
         tWMdTBW4YnyEvYOxpTB+x616b55/qJn4AanphPht5QmjI0DMviiiwhoHFnTBXfsAdIpV
         Pe7f6zFwveM3I3QtneQTLWGCmtB4EQzzfjNvGpSMWYkYfIyiIu1vbp4JTisT6G4Ef5ZU
         Nyf83DUdIhDd/lOVDrnCM+tcD7edwIgav4saHil8ByYh6SWMPihIdgYOUh2vAHZHfyNG
         7nN6uXjFAYd4quYw3n9lH7K/FEZXoYzgm4fNRkr5wW6Zt6j7M3Ritlc8Y0vwpYmAbmWr
         1bqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=e2HMnGLUsTuR+WPrwnUtmDcdGR9vbbrQRbg/wvsvaNo=;
        fh=OFDR8b0ZzRxU+tDB2AFHGQC6J1Qv2MqBHd5URR/TRO8=;
        b=raSj7mYrFCIIKNQtgbfSHhojSfd+hyUyp+Si/W5u4saSelttZwR7ixcCxHi4vVvWC6
         uCL3HKcefM2P+lqAjk+M7EX7ICkZubMT2l06RBWOvoaUMXdq6qM5SDNNOcySeXpQX3YN
         Mk0j9zYjmZZXCC/ZC7rfAQQPyQXM5tE2yv60TYyqCbQTcEJlOhN1DDoPWYDV+55qTpJy
         CSQwMGX6hzdt5SoHxfAIP/9edYuGmK7NRL0mHQXcDB8YR2InjKLqXBh020JKIcqHFHyT
         /BLj2U/55+WgXjQeQXXQ9c0rdDiQliI/ZVaRREOUyj1lZ3t2F5NZ6B/jgnTC8DMQ0mBv
         AYxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784597908; x=1785202708; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=e2HMnGLUsTuR+WPrwnUtmDcdGR9vbbrQRbg/wvsvaNo=;
        b=GLD8w3rBEy6Jb4YZ/B9iNrAentjr/S0yvdV9g6QGubQIVmrtnSQVGbKOD4fkXdyK6w
         DxbR4XZl3W5Zj98JnQm7vKJJlt7GaXozPwjIe3HLa+R+x3lcmbY24HKzJidYZ9LFQpaD
         KO5JHGHDlADgXm2+W2w9F1AVf5KgDMkz63+Ys7M2bUCgcwTghTdaYp/RB85VnFkuN6PP
         L/RoCwnVKd9xjpAdSvdfOF5/P1O+7+iDbZE5e7p5q+0P+s8e25xYsw1X+RSmzUyiPyX2
         k21olGZ/ZQUOsrGFEcgBiUihCnWVwOhUhsIJSMsXZCMNrCQiniw+xqJFxVudfzWo3K/T
         OU4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784597908; x=1785202708;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e2HMnGLUsTuR+WPrwnUtmDcdGR9vbbrQRbg/wvsvaNo=;
        b=jj6b/9he9lnNcv4PLi4fX3iextHsTO/smI0HnF5O9NLOhvcxMIm2x4yMRUVyTICtBR
         oEfJztcrWZazOMgwIfxZx0+W+8Vk+8p2oBtM9VBcovpVtQK0EPL0p1kz6nAI+6A4ZBR2
         mCyoiCtqmY0XKeZGg5PcLUDqU5iK5jms6W9Rg5sk7ZSKmqaZCCMzplwIb1gQFImLIe5R
         dP94cR+/ZEdkt6hixUBmtw3rNvb/zrqnuCx+1mKMuYFUzzx0d8O63avFKs/tnD96oxPK
         MDRc5MkTyuCgxTYr0wup9ypSELQb4L6ayeUIV9FIiH9OpjuC9zGEAiCs1rbjgO7r0/z1
         01fw==
X-Forwarded-Encrypted: i=1; AHgh+RpyqTHalyjfQka1oT0l1L6al8CtF1mgQrmBvyYcJpvkmDhxskW5SSeHbclTZRrMc5KtAIE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt/bsZVlUwr25UV/Ap9U01tIdlOlI+h4kvZaPC6UKQfiZ4Dyp2
	vPBAh3kzEpuYQa5848rcmwpvrGao5E4aCShC2ByhJql42Zazz5Y6yF/qYKhZlabztCg0ElV/PDa
	lvPfuOgnMuI5NFUzZICtPM5vA0tWJgrs=
X-Gm-Gg: AR+sD11JZXpKwtH5MwSYEGBjwF0QijuSvDmJiz4KmfLJCCdLKFSwFDrk/P4MAqM7YH2
	N5NRODCMdnL52QwFOBEgW1jQhlOEzqrt2e5WgpMV0mPjc599IS5/zvarGRJEUiSd3XIOjdBgvtK
	yOyPpohjp/vU7XavIBb7AW9cS1G0QbDW6nKz7q8GusMBCWZ5r/nn4sAylJ1BWsCbT9XWWfbIC2e
	LL9mFN01mvvEZwvz9aZx+VraZcESsoks72P5Qkne60X0dPuyHNWWWGeNWQnKx+ZxQD4Vrebm6T4
	LrKpylKQyY+byERTkVw3f2KmMaN30w==
X-Received: by 2002:a05:690c:6f03:b0:7fd:a7b6:8d87 with SMTP id
 00721157ae682-81ef251c93cmr57657287b3.25.1784597907740; Mon, 20 Jul 2026
 18:38:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABFUUZFsippcjQ7JYqtAJnMa73J9cGaa_tAbr0iqvv_pp-y6Mw@mail.gmail.com>
 <20260721010448.707363-3-sanghyun.park.cnu@gmail.com>
In-Reply-To: <20260721010448.707363-3-sanghyun.park.cnu@gmail.com>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Tue, 21 Jul 2026 09:38:16 +0800
X-Gm-Features: AUfX_mzLxaoZlYmXrQhu34vZkHXD4hnTMet9kQhRRIM3s1E1GGqyJk5UGiYXoKw
Message-ID: <CABFUUZH8W4C+j02f=72CfFAMR0W9M1KFBkFjeCwaxUzp6rSC4A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6] bpf: Fix use-after-free on mm_struct in bpf_find_vma()
To: Sanghyun Park <sanghyun.park.cnu@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Puranjay Mohan <puranjay12@gmail.com>, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 9:05=E2=80=AFAM Sanghyun Park
<sanghyun.park.cnu@gmail.com> wrote:
>
> Hi Sun,
>
> > Sanghyun, I saw that you planned to look into this after the current
> > patch is sorted out. If you are already working on it, I would be happy
> > to share the PoC and my observations.
>
> Thanks for looking into this.
>
> I am working on a patch for this race and expect to post it soon.
>
> Could you send me your PoC and debug diff off-list so I can test the
> patch with your exact reproducer? I will post v1 as a new BPF thread
> and Cc you there. If you have time, I would also appreciate it if you
> could test v1 with your setup and reply to that thread with the result.

Hi Sanghyun,

Thanks for the reply. I'll send the PoC and temporary debug diff to
you off-list.

I would be happy to test v1 with the same setup once you post it and reply
with the results on that thread.

Thanks,
Sun Jian
