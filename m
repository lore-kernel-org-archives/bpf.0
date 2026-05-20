Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77CD3E7164
	for <bpf@vger.kernel.org>; Wed, 20 May 2026 14:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779285814; cv=pass; b=hHGvHzFUWv+N1YeJT46AmdTAe+JAXtE/c0WB9pC273ZsNG18Ayb310K5fTwbDIcQPQj33T5tYvLO8ZFlFZqinBa6jFAmT5i6tYoRkdt3R+ejf541WZ+qthxenNdnn9RbsQtQ4F/LGS6OEFxlzU5KkEPq49hx1vAPuoCLVM+kxgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779285814; c=relaxed/simple;
	bh=cudj03DT2juK0Rdq6xSzpFvvLT37HaMrnMYEadhAtbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jHqPbZVH444rmOzeASpo/k72n1yGQlgWkry7+1HfP6KsUZpBZx6f9gm2I+a5P4DPTdlTZzVD5EKvjRZGY6IjcW71lBiOmXHVIr+uIfvmk/9NqBo/uFDcoSGKrdUgi0SY6e9B5OTagGRBJllFn7puZdyT6PfZoLFkypYSNHkRUSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AEjwZKbd; arc=pass smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AEjwZKbd"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48d146705b4so54451245e9.3
        for <bpf@vger.kernel.org>; Wed, 20 May 2026 07:03:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779285811; cv=none;
        d=google.com; s=arc-20240605;
        b=NJVlj9HeNLtk1aiBK+aSbywXSNTl+g46jQ2quEivuzQFIl3iVvGqfaYh1x0WArGv0O
         vigreBygdvLxyMr/kuTbqRrdazPRZfYK2AhdUUDRbe/p5QJct82ydPCsiYmgCJyUE+3E
         dD+ufxOOiKCe9vyoAlEcPjdz5AnZYGRUhnNVE3qVWVi4tbW9Pp5dA2vAHFwWv7ONM5vi
         LcbfOlfv0XoOb+RkXdH15Y2m9Cy/Vi3bImRv8QQ6lhehR3SNntHgix51BTMdNafgyLrx
         qYwydbIjQtkuGi0M12kkDG4dkGTwBMgX8SwhHuIdWuHvivr8gmE3nIHk2lfxxTDCx5oE
         6vwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=98PW6bxbumnJFaBQ9ut19eR4UXYqwVKoaG9preHITWY=;
        fh=PmZHPFFhmdCIF4WaawyeavKVgQrGutUQpVAWIBgAVhg=;
        b=GFLHnuZ3THxagmxcLjpAX0Uwjab3Jkt3gcUKqHH5KAQwKnjFJ0hCXC8yVz+QoT3swh
         KYL6rMec70FfUJYqMt9SXQSo/wVPmjB3Vj7YAio5R/zYxK0dgqFuSGXZoeuq9d3BiEjB
         zNkdkR/wkXmCRAo5VSDjCo/CerPLestYa147WFakcQa96tA+slQRqXUqUFR4jB10uzK/
         8feXINwPEkLAnNX1D0eXir/BZnbHzhZJbt+6/bjLBJ1KX6dCWm9JJjCGekU5TAJU7jF3
         0u+kXC+zMY629ahtf4tDGHM98TRQT8YhnQP4al2YwA2zuDws2iiBNk4fVFSmMCD+J2Ou
         ogqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779285811; x=1779890611; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=98PW6bxbumnJFaBQ9ut19eR4UXYqwVKoaG9preHITWY=;
        b=AEjwZKbdk8+QfG2mHe4tY3ZcRL0uBJChJHStMb2kgqotMjW4weUNNXLcJ8r9KX6b+C
         vXNgfmTN+abvN+Uc4e4/GmZpeRkcS4OYmP4mspLtQBrESV8W5aKNUceOO/Y8kXvhk2LA
         IVDX2GTvaXzF8pAhVPGre1nhdzAJBkc1+c2GiYbkOXU66J3wfZRA8RzGw9+jcsxtK5DL
         2whUWRtHWN9qkSinzUS26uwHw+rGOK1QwJW74Ox1PNh9ldJ6nrUIgQnYZEPbgQFcmKot
         1SXcSok+ziK7OTZYvV5IpnvNx88oSuNsO8A77xa8zuOkeJg7Ai0ZD7pIQzlqSNw+8jV+
         bCZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779285811; x=1779890611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=98PW6bxbumnJFaBQ9ut19eR4UXYqwVKoaG9preHITWY=;
        b=MzF0FmePwFdpY7i45R82J71YbeSb7Zx8IeoSi0BhSs1Gtcg1uz5+XHvSwtlRsab5Sj
         7IZ19f6UCRTzqMF/RUri90x2/eKy6KPyVrH7ZY/sQvjKMujMEa7ia4ll9qvqCjOwYE8H
         qnYhAaX+pEaIcn/ZcmMQxVIvDjN9N02R9iEocDaTScBKAUVLyzU6qUuEgIJNfr/HuLzB
         PmjvwtP8/YZx9fProjyXYiojNf+Bc3qpgBU4m1CMWhVjkWSNvulTLvFJV1rPGpeXuWS7
         tE4VtvjcyNHVPT+Y/ek9/Ob9Q9TOwQ8fES4i3btrkp7aWe7iDVoaZ7b0nZP2Z7Dg0sE+
         wtJg==
X-Forwarded-Encrypted: i=1; AFNElJ9n1QFtkH6qJD8S7uUyL8e23AbKOoYWQYHjus+ola2GpvC5xRTqpr6HUs5qzgUVTmFh/6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9SMM+gpGN9as7uuGllJGJpIV51C5X/ZNLtEs6ZImjKxHdlowo
	1pQ+ax+ave9sKvSIQdVaCTWZYojYNNMh9h9xZNmv+bXOxyZsS34loFhwstzAYanxUTFj5mk9PFd
	CwtSCUmjT7CIe1u0SXOk6Xx0fdM2+hfA=
X-Gm-Gg: Acq92OFxjCCpAdt4LHaExzI2k+k2cvF3WX+/rgiGzLwAm2naPFZBM6wnNkGU4Pr1fIU
	tuqV49prW3+kKzmwnHoQjpwEHDias8SjL3GdItY6Awt/mi2XCpx7WBmpiOJFlaeO0d10Ul9fmY8
	f7s7DaVpJF9BmiN2NlkcUQrU/66RGO39oAYFnug4g7VFaT+/x8jA0DD758YJGPKD+YXUhafGj4i
	HJzy81ZdCkgEFU8dFbM/wZWwweP+Q8k6L/vA9eKKE2eW2bf83baHOJO9QYYzOSU2HLe4vl4biEO
	XbT/yvQYp9J9PbdAoXj2WNcDRqJZyghCJs9yx8nF/nOwI2gCj05SxLjqmqp/rinHj3fP
X-Received: by 2002:a05:600c:3b21:b0:48a:f18:ece4 with SMTP id
 5b1f17b1804b1-48fe6514dd6mr354476375e9.24.1779285810661; Wed, 20 May 2026
 07:03:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519203858.1342507-1-arnd@kernel.org> <9eecfab7-afac-4144-b544-ac715b07980e@linux.dev>
 <8e9cdb17-83c6-4287-91eb-dd6d3a457f28@app.fastmail.com>
In-Reply-To: <8e9cdb17-83c6-4287-91eb-dd6d3a457f28@app.fastmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 20 May 2026 07:03:18 -0700
X-Gm-Features: AVHnY4Ip_xXiNMAu2ZFk4u60R-8PxSz4rhlaQqqKJfVECP9Q7moIACw16qOv3j0
Message-ID: <CAADnVQKnc6JTObEPUqh-EBY7+_GJ3TPfetxiWYE86UAiiMn-AA@mail.gmail.com>
Subject: Re: [PATCH] bpf: avoid padding in struct bpf_common_attr
To: Arnd Bergmann <arnd@arndb.de>
Cc: Yonghong Song <yonghong.song@linux.dev>, Arnd Bergmann <arnd@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Leon Hwang <leon.hwang@linux.dev>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 8:39=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Wed, May 20, 2026, at 00:17, Yonghong Song wrote:
> > On 5/19/26 1:38 PM, Arnd Bergmann wrote:
> >> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> >> index cc4c0b62cdfa..0f0ec00cae4a 100644
> >> --- a/include/uapi/linux/bpf.h
> >> +++ b/include/uapi/linux/bpf.h
> >> @@ -1507,6 +1507,7 @@ struct bpf_common_attr {
> >>      __u32 log_size;
> >>      __u32 log_level;
> >>      __u32 log_true_size;
> >> +    __u32 __pad;
> >
> > Let us make it as
> >       __u32 :32;
> > ?
> > This can avoid people to use the '__pad' name.
>
> Sure. Do you want me to resend, are are you going to change
> it yourself?

No need to add a pad.
The issue was fixed in commit f05ddc6771c4 ("bpf: Check tail zero of
bpf_common_attr using offsetofend")

pw-bot: cr
