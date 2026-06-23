Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7ACC331230
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 20:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782247830; cv=pass; b=DbSW43lfOGx3p1qyhEjFJcZB+b/m2uVD/GlSdU40mGEP4T7HW6kij355C0j1XjcCc4b17ginoZYD+G9NmoOHjO4TRkrbQYWeoWyKB0JYWMk9dMVcd0s7xaQvUIY+ReMmK/09TIaMdzaqZOIAqiBzFof42sVXEmBnZZSMzWF+iZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782247830; c=relaxed/simple;
	bh=SWG1DJHBDEjCyZknwyDj0xLhKFC1DozOFUD3UvSjANI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=roxHCvKx8Jab2pawujLRTKl6LWO/8Hmiuc/DlJ3F2ssk0XkQoWw0dtGht3m9Bo1AYsZvYYPs2c0r1jjtpw/mFrGouN85XyEXXDPHFUkz278svmOZCxaNsLrzR/umlmKLKh2E3FFt0pFrZ7cOWhGDYmhNd6nVgfWTd9cQSL9XzF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UF0cMojc; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UF0cMojc"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2bf20f6be6bso1856025ad.3
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 13:50:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782247828; cv=none;
        d=google.com; s=arc-20240605;
        b=CNwRDMHnZcWxgPFCbsz8aj0U467De+GcjMhmJ5wvw1+QRiwWYI3wu6uP9YY/TTBU6d
         sQhBdqUkOhnE/qI5REmEzaO8CH90LKI32Zhcf8UQm+hUlOyE6uH8vCz8AptJd+vtonnI
         0kkFMOKIYzFmj6y48AG8mYdb0EWeYq03668pvF3XduIFHgsPImzQJf725HKooGpc2EBG
         h/uriNeYCtUSfATYsOX6SJWYC7k9QU4/E/MCMVE3Wvwjn6oDO3x1m8Q8OzlwNYHnPOaZ
         hRpZvkewFfCWQErXcnwcFWMpPSsq3k+pA6vI82emSqEZDZ908FmxByfUXgei4Ck/mYF9
         kORw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mlXueoxJUSE3UyMTbl7BQ+G7RoqlW1OH46LcPWs+CSY=;
        fh=PpPw9f5xmxYqzv1jXPmqvP0zAU4BDAUCj2fmX8rhJ0E=;
        b=LQHvXiHjgHnDXAM1r5a/XSvY9l1YOajJ4FgfmdByvBal8AjFMuD0inKWAk38JKvg2e
         bb/tdiBY01EmwMdD28J+EE0OCtNhSmG7zLAETpeWPBzagnJmgYdh0Xv4d4/+SgL5ErEq
         tQfIBAh4jMDD7NFICo0ZbWByGg1tMB/2VedOQcdR4dt8VFr7Y7aqrCA9DZI9FvalFK5V
         nYIrmElNh5cZdpeFXFZlP7fP/bYQSnJT2+rphOWDPZM10HZcCIIwQlb2y1Hlin012aLa
         DiIhmXdZSSwLVeWY1MtzkqQ7sg7ud7W2BwVjueS5EOGvkEELYTBz0B3u7WIomv4NMlqu
         opYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782247828; x=1782852628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mlXueoxJUSE3UyMTbl7BQ+G7RoqlW1OH46LcPWs+CSY=;
        b=UF0cMojcX0qOI+80lKnLT2SHPWDK7tzUQkM6byAj77XAougRLgRoUQ2n+Me8F0vSxi
         +tNuG/+Bh1OmDceNQVbQ3ewRh8VUIiTtPMqsetrr+KwQ+S3FxESeoPGxISkMw9cprxrh
         cL0Rp7ZJXCe+9Juj+aXe/owhAEWUScLWW3W41Hqo08yZZxZcPuLTHs6A/cnsOjpijqfD
         gfx2mrcYH3CntP4CliEK1TW79lf85awaQY2LbImRoJx0Z8MTD68UJ1uhFSvit/h1UcFp
         KfzB4kb/yf/h9uMRwLS9g+MPgtn6UIQs65o2/Zu5XCmLohF1a34GdI+I6YqJc7x/wozw
         VskA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782247828; x=1782852628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mlXueoxJUSE3UyMTbl7BQ+G7RoqlW1OH46LcPWs+CSY=;
        b=o1VYTL5YO2UZ8lEcUvxdoh43vQQCjhtcTVvBX4Ou51kH4eOUSilXJ09OBcrnt1oQSm
         WqnEaW0rTkTTfLsb7ryuHjvRWypFz9QGNk5KXQMPrqJwmvkjA2VSuHC9Clxpk7lpLwsY
         4URl1H8tgjyFulBd8LTcygM1kvbbRSQ8FGe5kKQc6X90rG5FKtAffHmvAZxA2ZA+FnHU
         fTJxw4JpPPkVbe5rhNaqn6LKKo4qwJX7VIC4xhM+MIvHwGqr0KclXBy6k828nAvkQmEZ
         KtMP3r/vt+Je37NLGzP5Gx5O56CQliKUy6YKriv0btcz9BWu4SYznpo+P+1KWu2VDfMl
         qujw==
X-Forwarded-Encrypted: i=1; AHgh+RoTm1kDMKO60ysp3BQJRvXV+UpCKUPaIb9JZLr2+5zYVwNkY4KkEkq/sWFFeGX8O+5Jv/4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8zNFukrNT7EW6gIv7iysqon9DwgZhIQkX3BGnisGgtBsOkQYu
	cCQX/DrJo0i+X+P6Y8tbTdmWVDMKLZOiklaS9O7iKIo6BBifyHNSIjOnDk592/y93e2X3SB4SlW
	rnUYYDqsasMpFUGjDg0fu7adoxmbttNQ=
X-Gm-Gg: AfdE7clutGpXIJWa59yqZ6oLJPHx0nBphaNLbJ5RzqT2mNV3WXJ7Lnowq/D+OJM47mR
	4jfZy877VZTt3ZFDZcDvafCRGm3h53StGmlmJ90kTw8hgVuaFAwSRre7dEWeqg1ufUvWP+0SIe4
	pUKdXYWR5gTGmY/GGrqKbKjbSTLuIl3DFEXS8zPuYpNorkdsYegzFAS5dOgqJW+ev1BzFoRdwbL
	94cQz+U38p12ipPRSzHk5RL4pv4XCS5oyqD0LkOhf5sghWNovj60lOMX/SapXn2GmEEGLRgenX8
	TfRgyWNe7OggeWN9lFSxAq0qvLSpF2RtJZ1qAWfTm8anYiL/XiYK4J+JPiwReo3ZjI4FyQ==
X-Received: by 2002:a17:902:d4d1:b0:2c6:b87c:e5a3 with SMTP id
 d9443c01a7336-2c7e13fe844mr4813955ad.15.1782247828026; Tue, 23 Jun 2026
 13:50:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623-bpf-lskel-fixes-v1-1-90600b40e7cb@google.com>
In-Reply-To: <20260623-bpf-lskel-fixes-v1-1-90600b40e7cb@google.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 23 Jun 2026 13:50:11 -0700
X-Gm-Features: AVVi8CfLJnKTK63gk_D9SBD0xvkqGDQ8X6Rn4VljPTP9xeBGbV-iB6w1YHcVTQI
Message-ID: <CAEf4BzYBwi5V0XPMEczdKxjW6N7xT0wZk1Q8cvH6UceyoJP+gQ@mail.gmail.com>
Subject: Re: [PATCH] bpf: allow BPF_LOG_KERNEL from kernel space
To: Siddharth Nayyar <sidnayyar@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Giuliano Procida <gprocida@google.com>, 
	Matthias Maennich <maennich@google.com>, Tiffany Yang <ynaffit@google.com>, 
	Neill Kapron <nkapron@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 8:34=E2=80=AFAM Siddharth Nayyar <sidnayyar@google.=
com> wrote:
>
> When loading a BPF program or BTF from kernel space (e.g. using a
> light skeleton generated loader module), the kernel module may want
> to output verifier logs to dmesg by setting attr->log_level =3D
> BPF_LOG_KERNEL (16).
>
> Currently, any attempt to do this through the standard syscall path
> (kern_sys_bpf -> bpf_vlog_init) fails with -EINVAL because
> bpf_verifier_log_attr_valid() rejects any log_level bit outside
> BPF_LOG_MASK. This prevents in-kernel loaders from successfully
> using BPF_LOG_KERNEL, causing silent failures if the BPF object
> is rejected by the verifier.
>
> This patch modifies bpf_vlog_init() to accept a new 'is_kernel'
> boolean (propagated from uattr.is_kernel) and allows BPF_LOG_KERNEL
> to pass the validation check strictly when invoked from kernel space.
>
> Signed-off-by: Siddharth Nayyar <sidnayyar@google.com>
> ---
>  include/linux/bpf_verifier.h |  2 +-
>  kernel/bpf/btf.c             |  3 ++-
>  kernel/bpf/log.c             | 17 +++++++++++------
>  kernel/bpf/verifier.c        |  3 ++-
>  4 files changed, 16 insertions(+), 9 deletions(-)
>

This feels a bit dirty. We already have BPF_LOG_KERNEL which is passed
through log_level, so wouldn't it be better to just make sure that
BPF_LOG_KERNEL is not rejected when program is loaded from inside the
kernel, instead of passing along extra bool everywhere?

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 39a851e690ec..eb9d2a556c0e 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -1059,7 +1059,7 @@ __printf(2, 3) void bpf_verifier_log_write(struct b=
pf_verifier_env *env,
>  __printf(2, 3) void bpf_log(struct bpf_verifier_log *log,
>                             const char *fmt, ...);
>  int bpf_vlog_init(struct bpf_verifier_log *log, u32 log_level,
> -                 char __user *log_buf, u32 log_size);
> +                 char __user *log_buf, u32 log_size, bool is_kernel);
>  void bpf_vlog_reset(struct bpf_verifier_log *log, u64 new_pos);
>  int bpf_vlog_finalize(struct bpf_verifier_log *log, u32 *log_size_actual=
);
>

[...]
