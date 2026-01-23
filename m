Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D653EBF37
	for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 19:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769194941; cv=pass; b=e1cPGy12OF34Gcq5d+y05y0+hS4ToJD6p/LU0+2WCAtFBRyBVJCqCcLvJAzXqALcH2DHxnPnm0DJqAM5GmQuWGj0ok0nTwzW4gsxTwpuy9jsz3mcp5UCzpu0Ek/MB7VtNHI/xJhKXAKIDhq/U9V4nmaXpN5TCWgay2IS4ojSNJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769194941; c=relaxed/simple;
	bh=l09cWGwWXlQfaj0an5P8RF1uKt5ECmmx5jQtw+Ktbbs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N3oT9SfWlNg2mWcR/7PPZlXXLOIHd3/nPFTWCw+4/YdhHCiZNqzxI9UVN7JT6nRXLnus8APvFnJ8OKK1pwwP7z3PT4dGtjxqtSz7ux3v1vn6F7m6wo6W9OSErZDymeIxkqMrrJxaQFLjMxH20Nf0LQpCOiBZtW/eLlktO76kM24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z5BIHu6o; arc=pass smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z5BIHu6o"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42fb0fc5aa9so1570917f8f.1
        for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 11:02:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769194938; cv=none;
        d=google.com; s=arc-20240605;
        b=Xs4pyfunaneeUb9MG3o5xl5LG6rgrv4cArnpFVNz8T1gTGF3pRqN4ZVgn/sbp9cCHx
         haCT51/kECA0So8/onSFHhq7Bs65o2R1CJNTSwKYJ59u2lz9Nv+9Yy6Uk0FW8/1n/s06
         TmOrhE1dycytUSC+gkIEdqzeNaacXDUziTGFcOXacWcuaM2AfgdGA8Nk1El95jKfhmCh
         ui3qE2YBvs0cKOUYIWTYj2S7AFNQtPMkT70htkyFlpf8ZMODBxjlbfckM1gpt4QCCC9J
         7Eh0wSIxdwHDfbcJUGP9YW8sRF8LGkofZz+vg68cq8Tf3FukhEuTjoy5c+Yj82X6txHb
         EAzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=l09cWGwWXlQfaj0an5P8RF1uKt5ECmmx5jQtw+Ktbbs=;
        fh=mprX4inn6pBkI3qLrj1OQgqReolxH2E45h9uv0Pv4X4=;
        b=C2T9Mcf9zu05BLFU3OLRxR36aY+cXbCsdmf3xgF4SZNPS3rYZ7+MlHgVNP5I9OEALf
         C9n1Fn4doz1bGvrmmP8vBmGohvk14ls3gJDbCSbtzQgkuuU2AGZDhQ+Ih99Ke3TIvOm7
         eJV0338qQOp7NCWYpVk+6YRjeIjn/OK8gVvtwJv4hLD32IXjHU1QZO7QPmlKlL44mxsH
         /wOO0lgTn/3EwWED5FkL2SisQzjj1Y4FCpr9MxQzZvEdr87/YCneldvKaLIUdp/Jogke
         xOROgg5a8MYYiAgbsr2rUO3xaI8tYrASNiv9o0cwGvxdNB8YDZWM9k+gZVP4QYVVRc1D
         +/+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769194938; x=1769799738; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l09cWGwWXlQfaj0an5P8RF1uKt5ECmmx5jQtw+Ktbbs=;
        b=Z5BIHu6oBmjgCj0Z9Uwf1HJmbIeO0TONxfkS8BTzO1LVPGEEjgK+feVC5071wsKjaT
         80NOkfJCOJff9lF9Ki1jaJD1qk5Z6kNjeuFOXPoxjllnM4l4cYrHMXQAqsm5nbWmas5p
         oTsUrfgQHUWdomkN5U+D/TPHP8FjkM6ObUVFF/5R75v6uO14uvnBXDFpUevFVEn+48sV
         rJyxTGu49OP/gNOvIwtQCOdOkKzDNZiGA9r0bwBA7kvzWEMAeNe7WmG67oOW4XUMK7uc
         lfzfdaKNcvrSXR90jMZCUwsMcJTqWgIXbGmx5PYGn4+FFjWHLmPgLl9Pk4lUnFnEGV5B
         nuQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769194938; x=1769799738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l09cWGwWXlQfaj0an5P8RF1uKt5ECmmx5jQtw+Ktbbs=;
        b=oKNh/7eM9n26xGRfaKWD9aw7mJqEcMY5NnMr0PldsHgBugIXeyOgytKb3hEsZ7C9V+
         wVHQ4FQmLYjU5HYKqNPzngahPUGXOLG5iYl3JEphn8p3vwsphQxjHVaLOrf+muVdhOZU
         7ObOkvlmfhqFv3Fboz30y3OtCr2I6JurVcxJ3pL51tamCSYkiWpF3s81941HRoENb5x5
         xEi0BIYZ5hHH4lJglg3zKfzJ8sHyyRahZ+w38rmj47tYKUtC341Br7b4qVwxglST8Lf5
         NyV4em7x5Ah28zpLiIUoJ7A943B4S7jAdDxHyIGVXh1p0DOT7Wczji0l+8BMzboP0JZE
         vXig==
X-Forwarded-Encrypted: i=1; AJvYcCWE5szNnh9UCrn1n5ft3J5Mjuf9PhstwjBv5E3DFwc6seBpE7U0jf2/kYFRT/QBSJJMgtc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQYrjwEcFqALfMkTOo/sAgN9uwW+BYhxMYq6kpA3kOTKrG21FP
	TAo50ZJhssjkF5msvBteb65YaOHh66fDBNBap+Erv6rE2LOIXuZHS33v0048UPmmcniUZ0I/Rw5
	hSpGYh3emn2hpm7eYdZaLChe+4gyHDks=
X-Gm-Gg: AZuq6aIEmQJG0sIi4o8yuCABxSlsny2FwXMz2rpAUsFct/lWHQXWXEaP6n8K0rHfJLY
	HF1SwfuOyLR/3QfELmHaD7sjyzINlj+gJtS3C9DeeM15bfiZOJcqMKof/lTERl+xZJ2DlL+k8hM
	nSo5h/8M1zanuUlWZ3U2PEdUenU+TN4i7MowYnOzXKuxJpVbFwDqnFLjOJrb4/KPpF+7leqW6ut
	yJsx/Fr3nq0rwnSV0WPC2XrWkin1dbkmG1LIfpSNYdO++8bHtaZ0ne/xRa0pHsJkGn98U9ay0VI
	F++0gnbrbO6editH+qsk0srIXLRbgu1TAoWmVxp6KRmPIg+TV1q1fHqlQJL+CgTIOax1Wka3
X-Received: by 2002:a05:6000:2512:b0:431:a50:6e97 with SMTP id
 ffacd0b85a97d-435b1604d4bmr6624055f8f.34.1769194937942; Fri, 23 Jan 2026
 11:02:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122115911.3668985-1-memxor@gmail.com> <CAMB2axNB=v+rM1548vU_anUGj-p_hmA5_jSxGzmeUzKS-4W0XA@mail.gmail.com>
In-Reply-To: <CAMB2axNB=v+rM1548vU_anUGj-p_hmA5_jSxGzmeUzKS-4W0XA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 23 Jan 2026 11:02:06 -0800
X-Gm-Features: AZwV_QhKlOeto5iAooVIh1h7WT8zJXzZTTBjija6JuJ6DwrZkBbxNt-fxVyxBK0
Message-ID: <CAADnVQ+GBwzJbdzskfCXtHw9r5=8gzSeTtB_nEOf5oHd7xQjSA@mail.gmail.com>
Subject: Re: [PATCH bpf] rqspinlock: Fix TAS fallback lock entry creation
To: Amery Hung <ameryhung@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, kkd@meta.com, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 22, 2026 at 10:04=E2=80=AFAM Amery Hung <ameryhung@gmail.com> w=
rote:
>
> On Thu, Jan 22, 2026 at 3:59=E2=80=AFAM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > The TAS fallback can be invoked directly when queued spin locks are
> > disabled, and through the slow path when paravirt is enabled for queued
> > spin locks. In the latter case, the res_spin_lock macro will attempt th=
e
> > fast path and already hold the entry when entering the slow path. This
> > will lead to creation of extraneous entries that are not released, whic=
h
> > may cause false positives for deadlock detection.
> >
> > Fix this by always preceding invocation of the TAS fallback in every
> > case with the grabbing of the held lock entry, and add a comment to mak=
e
> > note of this.
> >
> > Fixes: c9102a68c070 ("rqspinlock: Add a test-and-set fallback")
> > Reported-by: Amery Hung <ameryhung@gmail.com>
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

pw bot either slow or asleep.
Applied to bpf-next. I don't think it's that urgent.
