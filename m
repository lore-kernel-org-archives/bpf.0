Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7491040DFAD
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 00:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776989060; cv=pass; b=hkBg7pGo6CoELXgAN2X/6Vf2U0VFAJTJVVSZxEv6ZdO14MN3jmQtX5/mce4XKQh4vsqNgNrxkY7+Xybj+adoLBmP0ypd3U1SODAA/FzHJSp2lQjZCrXtE4clBAMr1E1UUHN6fPRtyKh27JhX7VqvzPPON1AjwML+m6kavRe99ok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776989060; c=relaxed/simple;
	bh=/0xK6tYxs6xHgM73UL+O+BarcRKEYLje82iXuY8DgkY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TOb+N/MBi0sqK9ZtT7p3piahQWGbKGwTprIGZ02rWAd4Om1qt30+aWPXrdjQBgds7PLzz0YwBpuJ0nyLLrSEuPg6qhUvjw9Uc2Fn/lZdK3g9ac4u/2aBf7LluUFGp/G+HyK8+Si9PKl90Ko66t60tNvP7hIFN2AOQ22MPW8Rh5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jQTd6Oay; arc=pass smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQTd6Oay"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-362bb3260f1so2724381a91.2
        for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 17:04:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776989059; cv=none;
        d=google.com; s=arc-20240605;
        b=MGX4ZnPpxCKq6g+Jvy0rXRElkCsSSeO9sDbjxxE2jNrVBmvPi7eaxRDI6TBmpV1B3z
         G6zexs4a/jc5kkO+URWQSRSGkvii8u8FUFAn4Fi+pHQyZB17zBBKhJivj5HVVFtGIU2v
         hMjNOePXneVN/3CkDUjxciTfZOsq/2+v6tfpJOs17Qt7vLv+Hb35PBaGx7GV3esMzQ19
         uqgNN34HACKCw7APFyFOy5yXiGvd5nazpCxSicPJuan++oeHNuxqHVLKbDEQZFF3tEw2
         CJye/o8H2dEHrb7RLNx/9bIxaTB43mcdMCWNN5fPxSwqkSnXvuyWgQOt1W/wOxMvxyJw
         js4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/0xK6tYxs6xHgM73UL+O+BarcRKEYLje82iXuY8DgkY=;
        fh=zJ7odwitiZ4Go6vwe9A1wHagnO8NzvH3mQM+pdfOTPg=;
        b=eGy0zvX0qQLFdPOAZj8zpw2LPyex2uVQ1gxkYInikS7P6eOZoP1RODf3G9EuD0bpVG
         4+jTi0zHP2rjXof5JoYdcNLG9Pi6H5yjL5kFGNVZRtoTDvC3w9H8imyLBwr/gW+BrU8H
         UlQwiXdk6DgIkMFUr0fdKnO/v6nkCT7Lfu6ocrudeNHYJVe24RueKMGmGvFpSsRKY3PF
         S42yPvL/kdKTNof4X5taJhFU5pauNjfKebOO94ST7OOKqHw0aKzat/8GRMtqxr55RJa8
         L/D2mvnc3rWNZGp4Z8wPujc5h8rD/Zrke7LrquB6xdjAKSSjOD1RKl38lUECP4ToxIpv
         UvHQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776989059; x=1777593859; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/0xK6tYxs6xHgM73UL+O+BarcRKEYLje82iXuY8DgkY=;
        b=jQTd6OaydKPjLazAEMVEqGPFYC8m9dw+0N2AiCuBoPoBbFHONF+4H8jPWCiNUJNv/8
         KscQoSpBIRn19O6ALO7yBHb5XzE8zn3bPecFKVqAstWOAqjpLw9kiZMV7A+5z47zbPdb
         cYnE1oWrxuR/QrjOV5Pn7Q5lXcKnExo9Wj24vptkZC7IKBCn9rVUoAMCVQS5MK4LOf60
         IoEx/h4g47f2C9bj680pir8L4W9BcG4QA68q/6CHh16cckAPIR18i+ZWBkND+2QnlqDX
         8qghM2my7gllhhLvYbpm2Bb1OlncXP+nnzQpaNVFDXfItQydSz+pId3XvDfeeGEUqzQm
         8DMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776989059; x=1777593859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/0xK6tYxs6xHgM73UL+O+BarcRKEYLje82iXuY8DgkY=;
        b=MCFRwWQGR8jtn97D6H8O3F5QntHf1q2pDKq2SDOmG/Ej1R06C2U/cPE9EjTo7wK8Zw
         F6cZoo0E4INGf37ZqyVEZaQ2R1a/g73m5zBh4JZaWgWMObFOK+D14PTr5yUTk6aPJQAy
         YCTxGsSHHGqF4Uv7+3g+N1ZE17wuXfjenFIW8Lf0Y6/1e6FGhUKozqVNHMmYz/ALiF69
         Y2OR/YA7D+Cj1EjUR0At8wRZBDlflbxsr0iwnc/uwx7xidR4fWw5H6U2Ul1gweRtzyPp
         uvVFMYXMWMdncV+TrBkRhXNt1aFlHYuJ+UqARHcvUbtCT3WsnRQ4O3woZ/Kl82Uoynwa
         m2yQ==
X-Gm-Message-State: AOJu0YxU1BmY540KmVJJqJVUQBsAW+z5bHfyE3MMr01K/u+VTz9IZNgk
	/h6PoCOlrJWL2Bp4hAv+N3+JGH4E9A1/BDlK8pOwxZ/2hq6ITpGgZtAFunDluJd9nm/PSn7UR1F
	OPpLIEbaNpvX8e+aNEOtAJqGXxME/IN0=
X-Gm-Gg: AeBDieszBeLbeKnKIc+eKBee/2TjuTztDZ5UekWx/T9gAtrpSdwSJm1MybUzlECF4tJ
	Mpks/zZu9OEItROKmuJrxjz6hWeECwQF1yjdxsT7wzZnt43hcvBvo0OSN2Ge7oU0Y4uuQlVjMFl
	+3ebODWsPxaeQsUXixrHDDKBROwlKJmDXxuNFw0GfI1MGqBJJfXOK036dTFX7S9GA+bVF4cQV73
	AK6tXn7oDIbAQQ8SgWI5JeO6TKv5o8RewCxrI4g74wq3JbdmKd6zTkh4V4unqMMnRAPCYyT1IeR
	WPqJz0DXDbEuLla6iI3tA7NZmo9f7DnMiQ==
X-Received: by 2002:a17:90b:524c:b0:354:a57c:65db with SMTP id
 98e67ed59e1d1-3614047a5d4mr30952884a91.20.1776989058743; Thu, 23 Apr 2026
 17:04:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421221016.2967924-1-ameryhung@gmail.com>
In-Reply-To: <20260421221016.2967924-1-ameryhung@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 23 Apr 2026 17:04:03 -0700
X-Gm-Features: AQROBzAzWb8jjj3asOdXVai0jSu2V1BCVstpKnZgbcFIf2Ptc1J8ZRzl2HlK34A
Message-ID: <CAEf4BzZASC15LwVTTA+A7xkp94BQLZjxQa0GUnsXr8T9w-bAgQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/9] Refactor verifier object relationship tracking
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com, 
	martin.lau@kernel.org, mykyta.yatsenko5@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026 at 3:10=E2=80=AFPM Amery Hung <ameryhung@gmail.com> wr=
ote:
>
> Hi all,
>
> This patchset cleans up dynptr handling, refactors object relationship
> tracking in the verifier by introducing parent_id, and fixes dynptr
> use-after-free bugs where file/skb dynptrs are not invalidated when
> the parent referenced object is freed.
>
>
> * Motivation *
>

Very nice and approachable cover letter, thanks for improving it!

> In BPF qdisc programs, an skb can be freed through kfuncs. However,
> since dynptr does not track the parent referenced object (e.g., skb),
> the verifier does not invalidate the dynptr after the skb is freed,
> resulting in use-after-free. The same issue also affects file dynptr.
>

[...]
