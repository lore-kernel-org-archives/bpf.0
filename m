Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C591A9FAB
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 15:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776870651; cv=pass; b=sWHdxruInBIF9PTtQh+/Di6viDR6z4//aDIwZqjlWRzvFz/gyiY9BLNo7bsf4NXglN8E8fAea6rRKIzUFcomEU5L+nwTZswKP5NxNmBlVxvJ5uDAj09jyXWNL0Kq8VPZmwYp8H9UeUtX9lVupSE2piuIgNh0xw5W2VxwTeXpCMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776870651; c=relaxed/simple;
	bh=7rhfog0QjQcYCGLyWi4Zu/zV+Xz+1PgIXxFJ+7VOryE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U63ByA70AqER4xk0A4dotIWSt1VIAQc3mOI2vQal0qRYgAMjeQmymMe0xD+u6lW9OEn1yQQIoo2itwTuRpK/I6X/WjjzEi8Dmsk4I2qPjxQh0cKzGAerr9GJPDuPSIBazjtwVjLJ+mKi3EjbrqGu+5vMtCsFsNO8LKTnf/T9qJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y1OI1iuR; arc=pass smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y1OI1iuR"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4896c22fcbaso29905385e9.0
        for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 08:10:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776870648; cv=none;
        d=google.com; s=arc-20240605;
        b=BCKTZpPxO2AeIH22O5skqckc0ZbWBt1atBFhAAFxYSovOhD/jzBsHgYCoDERcTQJC4
         WbxGmDJv/siMja0ZOHbFzx8CqfRjhJ6vhSteha0wqLTx1OuRuWmHnuifaf9wUkJDKc8G
         P67zscRPhNYslznyOWhLa3JizB7dNswYokMB2J/J+MQk9bLKiAgIC7r07vewlu2Vaphx
         7+j5ltRbNyIeYHegAfcJjk192NC2HrvEIt2S/BMJJ55WzL4nd3EfRYwNHdgWIv+Q9M7Q
         wTnirv/WTqz8KeZLa0dwxZUjQSyA5+Gk/ug23EIRo6taPiFYhhA+KsZAuyTS3niNWvjG
         9wNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wCFBCv0UWIValjobDqGb4niUzAyCJI7kTXsU6ccE94k=;
        fh=PxQg8y8+X9G8Fdf7UWomuGom8qfjF0IC1k1yuMznwfo=;
        b=h6ZieeqCMYQyP2aJEViaatADmLKe+b8B+5pxjqlZnMZIhCqAwBAo6MBl4Q0F6XyMvL
         nHz6/64AB1Q53nTFyEdmn85yfXnUSJ900Ak2YhDhI9C9Xm8v0ZdM4QmU/ggEv+I6v1qq
         v+xEIwetEpoP3pqp667vlowV1XRcZxDlGs6UTWPWFQsynd38L1tgu2L207upgnpxhjOO
         fChPcFeXyEkM4dJ9ch65B5z++qU8hraaaBli/gVDBnvqAXUDD6kd3VZ1VbBhLEeQ3T/7
         0WjG4YAtEvprRo89m74Fw19ZihVmIa+fX3nYxtSk0VoqNUcYxhf/hEDbh0UUKsWgM6D8
         3Hkg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776870648; x=1777475448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wCFBCv0UWIValjobDqGb4niUzAyCJI7kTXsU6ccE94k=;
        b=Y1OI1iuRUBLpbf40CFilGvDdEFjNs9ZNs5sZ9t0BagTqYSJGpU1ToXhxYU8wogevS7
         Jo51dMT7hZNmf8Oo3tAwO3n7llk2TjvdI9DpR3oMd2SeMYj0H9Hm0iMjqY5VHHAamsVn
         kAF8/oHsvfE2CdesCsiOKxlcz9rKek6Hek4WfgLZsFfV+AvFHiaG+u+5hTzw2MYo+ct2
         AYnsVOvMaTDJwETElsXpZKarrUziQppXtwDXUvgNMyyzun5D8YNP8vyZSZ3GjSU6zJC0
         PTMJuH4SIeScDBWTOHd1ZCVx9iCYnS75cmSgS3E2eDhAy5FmDsyBH5/u+ZQys3n/nOlZ
         roOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776870648; x=1777475448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wCFBCv0UWIValjobDqGb4niUzAyCJI7kTXsU6ccE94k=;
        b=ByvoAZswpF9dVUWdwO1X+p8wgHjxaJ/fy+LQ7Rhc3vUfZGxKYHOVgVfX2fP/dYd28z
         gmY7/zwmwrXYc8oEEmCS5v0Nz2gAn0tHQRt33xmB2VtReQkUVf2j4QUpEQQxjaxweMbP
         VXtG1csjK0vD2pL9g8EUe/VW3HOqQspZlVNxRjw+tXUAweFZCwex+X2npBOmHOnpfowd
         zPbW7CNdl3c0bDytaK9SkwVLycUNxWHasMPu1EgXa3IxbR38Oz1nY9AlMuUVihqn4QBK
         iU5vvM+m3TKPMbqq4nqBcDhSiEhB01kpQzCygvWuZSevyOnvPgtkjbtBE7l0PmfZATle
         czbA==
X-Forwarded-Encrypted: i=1; AFNElJ/VvpUoyxQbp0g2X0ZVpJiSJzKHbh9Y1QVEwmVgeBMj64uCG0KIKngAxezotoPCixWgML4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyNu/DSLfIZ23vTrgO/XbgknHn2KMlOK3Cj0r88FoIT2rNtOWQ
	rC1dW2Ga72U6vmBhasgZWfIWQiriFcdONDoLrlNyprmlpaN0a3hW2AWfdWGZwREhPd4APFAk8mq
	5IpWcckmjbxa+uuVJxVG13uBL0li+C2I=
X-Gm-Gg: AeBDietBlhJsb2cf4a51XjVxVEgO65VSLVwdupy5nnhQauUN58mOBcRZ2SPfczu4JJf
	2u6YdbQ/48JZko12Y3IVmeqW4QHuzCen7e9+OKmQDk19CgsIGxIR2xGyaklxlUkTbd8ka0myfIG
	T3RLGjWnEI/YUplRraomlGVb36uZV7q5zRz9pdFmHZtNFJy66qU8/sxrXn+CVvZFVoti2eGjB8S
	fx2rWm/+yDX39ayUY2jKBbbQCZCE7L4pD1nDuLFWkuAaWd/ProN3/2hMdJAjl4VK0v5uAMuWy4u
	jKr/EH6/qdW3tBHtNpIFVdxeCHA93W9M4lU9kTvwyPZBQM2L1bkMxTwRMZns+dVms1u34ByJ78c
	Lnuv8GcMZYKJyacltiAp4MtYHXbbB2oe0jsZN
X-Received: by 2002:a05:600c:4e4c:b0:48a:58ae:9938 with SMTP id
 5b1f17b1804b1-48a58ae9f69mr87984845e9.19.1776870648179; Wed, 22 Apr 2026
 08:10:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260422103206.533695-1-alan.maguire@oracle.com>
 <c2e8527a-0cae-47a5-8c43-2ae2c08bc1ab@gmail.com> <f2b3e9c5-c896-45d6-bcda-58c9634f61ab@oracle.com>
In-Reply-To: <f2b3e9c5-c896-45d6-bcda-58c9634f61ab@oracle.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 22 Apr 2026 08:10:36 -0700
X-Gm-Features: AQROBzCJQ9YcnRMVZy8dpRHxoLjW0BNj5xFU2NEn9s8d759qK9Kq6mE2tbXLn2o
Message-ID: <CAADnVQJ8=6dpUnUeDgja_v-fzX0nC-TxozmsRbDKym_Z9j3EHw@mail.gmail.com>
Subject: Re: [PATCH bpf] libbpf: Fix type size overflow in btf_type_size_unknown
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2026 at 8:07=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> On 22/04/2026 15:19, Mykyta Yatsenko wrote:
> > On 4/22/26 11:32 AM, Alan Maguire wrote:
> >> A layout section with a large elem_sz/vlen can lead to a 32-bit
> >> overflow in btf_parse_type_sec() at the point where a large
> >> type_size is added to the next_type [1]; a sufficiently large type_siz=
e
> >> on a 32-bit system could lead to the bounds check
> >>
> >>     if (next_type + type_size > end_type)
> >>
> >> not triggering (since next_type + type_size wraps to a value low
> >> in the 32-bit address space).  This would lead to a bad value for
> >> next_type when we add the type size.  Avoid this by ensuring that
> >> the type_size we return from btf_type_size_unknown() falls within
> >> the range of <current type, end_type>.
> >>
> >> [1] https://lore.kernel.org/bpf/20260417170712.74E77C19425@smtp.kernel=
.org/
> >>
> >> Reported-by: sashiko <sashiko-bot@kernel.org>
> >> Fixes: 2ecbe53e0e991 ("libbpf: Use layout to compute an unknown kind s=
ize")
> >> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> >> ---
> >
> > Beginner question: how does targeting bpf tree helps libbpf patch, it's=
 not available unless we sync to github and release a new libbpf version, i=
sn't it?
> > I would rebase this on bpf-next: it does not apply cleanly on bpf-next =
and dealing with conflicts for this change does not sound amazing.
> >
>
> Sure, happy to do this if it makes things easier. In this case the bug di=
d exist prior to
> the vlen expansion work, but only for a short period of time. As I unders=
tand it bpf fixes
> are resynced regularly with bpf-next, but that does require merging. In t=
his case the merge should
> be straightforward I think, but if maintainers would prefer a bpf-next-ta=
rgeted patch I'll do that
> instead. Thanks!

Mykyta's point is that 'bpf' tree is for kernel fixes.
We send libbpf fixes to bpf tree only when they're part of
kernel fixes and they have to go together.
Not the case here.

pw-bot: cr
