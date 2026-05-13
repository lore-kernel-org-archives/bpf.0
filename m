Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A4D4DB569
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 17:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778691737; cv=pass; b=drx9zzgYPRjnE5phygLy6oJmHzPN7mnePWflMepMGPXrb2CLnhrMBdy+guBtoMKJlf0SK5LArPag4XhK7A9n5P4U9DZjuD1eIm7XQhWg7C1UBcnOITS+UqZ/H2NbuHCU2s9pGb5ebhMAad1ftazPmzUmXaWwN6G1hip0VyVCP8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778691737; c=relaxed/simple;
	bh=G3BGz1JY36/f65EsXPbcHpzUvA0Vvm09vuJzP0AFG1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MlQTYhRcGSe/GeHyc7NuCcluX0zsTNkj1gYhj4V2MNxsQpyr0QCAgstHOXPvLMTqouELNjRb/17oX7baSnDuh8dTt+VxQFc0bRU+ZX6iqRSEOtImtkJrgzVE1lLowOlmXQHc+gh4SsNNeRdRQIlI8tV5odD2Q6LPBbMmFQPTPcg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j3lUhw8w; arc=pass smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3lUhw8w"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-441209fb77eso4315345f8f.1
        for <bpf@vger.kernel.org>; Wed, 13 May 2026 10:02:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778691734; cv=none;
        d=google.com; s=arc-20240605;
        b=aYowFegN7l7No7dvo3GF+HBC7AcM3C0t03ve5xFm6HaXyTl+eOkxD1q8r8p0+sZAgR
         RZDHyyZrXP08hvANXcoRN6rYQ9+D6TYx/Xsb+RvfhIhcVRm/ygnz8mmiXe9FjUPTMgHg
         JaHcyqitNBK+UdWPZvcQcdn8Ghi0PPirtrv1EMAxGvsqF1QvOJUzLkjZgUqiqQsnVFN5
         K1vB/+BACxVzZBQhEGi7ZolUtCApPQcpGbGdOvhF50FRR+0heDGNLaHyoFpkir5wepAu
         yMatNNueCGS0PwYnjjtO9tVLUErYzHQ1NhA1dighXMw34gZmawBfoKC3Vf9F37fjCETz
         zg0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Pm/7AQT70Af1uVrKb0OGWSpkbiaJBc8xDYGjxSqDigQ=;
        fh=7Y7kjDajHaTzBl/+VqUPR0YJemq5MXcAPE5C5SkvH1s=;
        b=BU4xGcg4vmwEGJrLoymjnpULk/muFp/3jetYXZtDUmat512YyFDIZyp+1LapjFcTyG
         +TFgNJOrQbWKN+fgjebBJgDoslpI7R+u1bsjLZJH1oNAwjGLek/R/0CvrlgvJOjJXKLs
         YTIxB9rMVKIcuIOOF4wo247JSzaJf9+SNqubE7Pd7qS0euHqmRg85pxZGAgVsTiwAvAS
         d4WJvdPwL7b/Gv3joJ4Gk0urM7a5S8zmBhhrSV3Zj7//JweEaTOpfrUvqJ2uxh6pYJDe
         2Lc8JmLm9msD1FaaRYOJMbNAw98VlF8SciFgGO9MhufbPJzqsCsJNM1522zQnWnaK456
         0xKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778691734; x=1779296534; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pm/7AQT70Af1uVrKb0OGWSpkbiaJBc8xDYGjxSqDigQ=;
        b=j3lUhw8wJlppQ4zed8hBb+VKcoE4PFC73vq4FcfJoW/4otVVFqOX18NXNHsV7nZ/BG
         gJya2pC2rB6178UQrlaJafZWbw8cSj0AUZ0hcAkfSP8wpdCtRA+oJf1vd66/j9kWzfQ4
         7UmvClSvmcKLbZQV0QO+Ab742Ou99Y5COXtQBtUJh4hybMcuJjRZ+kX/da1QTprNLOqN
         IHR4hIYWbydceRjOi3zgIaNIWCfs0HAIdOFxJGmj9wvFBs7T0JZPcHt692fqeYRrUql2
         HZqK1o7mcqB5rbwwOajqPG0drHk9OS7bwm0pTlSCzZk0/bYcH3Tz++zFZlQJvqLqrtTf
         Qfng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778691734; x=1779296534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Pm/7AQT70Af1uVrKb0OGWSpkbiaJBc8xDYGjxSqDigQ=;
        b=j0ExT8fLFX/pFdnSKSRPDiuJnvk38uNVq4Vy3m5UdhVeODRFD9ge6C1Vw2VwO/M5vN
         DeEVuL/Kqfv2UtBgcK/vMu8frArMLS0EEIOFFI6t6+F281cPBsHn1QDvpZoBo1NvJShK
         Chzwtlk/we1Acw09+RAdp3MioDSnHBraFE1aNowj4cJQU+8oKVtR9KLDxMKpptY91IX0
         EHCPBf/xPPQddFlHd1bvlcqhU+qOoHNGXsGjUxbgxSM1aJ5UwcVk1hkCmL9YDBtKA5OX
         tkyZdljvlhr59ypV0gMSE3mmXQ4p6dxOLms1TzeaGg8X54I52NeQ0y1fwug9MSk0HMMF
         0AkA==
X-Forwarded-Encrypted: i=1; AFNElJ8oPnz1ALWtS5S5VW7Gcj40xKYEu/iYkn5IS/qwkyGKACl37kmbepU6WD4moJ+O1cenTZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQldEciO5hsImiKgdfxM9T6zV1NqnSf4jGIgY4RDaPyGu6Wbyy
	77cSjy9X946rHFVo5DQ7gNKJQm08tB3bHD7Vvc2z6Ob8s0QmPp/+w87Oi0+O+vJ6ivIW+kF61q0
	ELgh6gyZR/ixi003w9+6lneIMCYaQ7i8=
X-Gm-Gg: Acq92OGjx208hGNLxK2P46EinHQQO6Z2MaRkNRDkUpwzI8+lkDo9yIMF3bMvoXDNGQO
	0qT02fgtoQj21jBR3SyImCz62QtK8sZeGYpVoRHqU4dZ2acNfdYh+TTzph9H+pgmCZ9woIy/XmS
	HSYn9M+QM/3qw0QInZ7N0ERq/mNgm7j19/F9FrdVLB3dqrHzmSAhg2Utpp80FLD/L+Uu4/oMTRJ
	yRHubhhpwW2i0A8wMaFYDL8ugsYVBHrHb1sA7OZlUpI4piKptS+r924qvB7iGEmHEEgltoKcNAn
	gvlIyiMJdQrKZzEb+PYg42n87nZxI92aEHfHITk/hSNfaKPAFyBLRiJPqZ8C7+SqArc8BKVois0
	uRYmIuBwif/2pD1nk4kDHP4VNug==
X-Received: by 2002:a5d:5f47:0:b0:457:ff13:b2a4 with SMTP id
 ffacd0b85a97d-45d8fe08569mr610172f8f.3.1778691733599; Wed, 13 May 2026
 10:02:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511152817.89191-7-leon.hwang@linux.dev> <20260512233658.CEED7C2BCB0@smtp.kernel.org>
 <3c9b4ff0-7a62-4053-83c7-23151905c742@linux.dev>
In-Reply-To: <3c9b4ff0-7a62-4053-83c7-23151905c742@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 13 May 2026 10:02:01 -0700
X-Gm-Features: AVHnY4IGmVwWcavbw6OvXdhM0kl3pI1g8o_zFUpbYMtujiX0hcFEhJgHmWBpXKk
Message-ID: <CAADnVQ+XR3kyqizGgGhtG5xiBu3oK3O+COUMfPDQDBSJbm=56A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v13 6/8] bpf: Add syscall common attributes
 support for map_create
To: Leon Hwang <leon.hwang@linux.dev>
Cc: sashiko-reviews@lists.linux.dev, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2026 at 3:50=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> On 13/5/26 07:36, sashiko-bot@kernel.org wrote:
> [...]
> >> +
> >> +    err =3D __map_create(attr, uattr, log);
> >> +
> >> +    ret =3D bpf_log_attr_finalize(&attr_log, log);
> >> +    if (ret) {
> >> +            if (err >=3D 0)
> >> +                    close_fd(err);
> >
> > Is it safe to call close_fd() here? Since __map_create() uses
> > bpf_map_new_fd() to allocate and publish the file descriptor via
> > fd_install(), the file descriptor is already visible to userspace.
> >
>
> I think it is acceptable to close_fd() here, that the duration between
> fd_install() and close_fd() is short.

bot is correct. Let's avoid these races.
Pls move bpf_log_attr_finalize() into map_create and do it
before security_bpf_map_create.
