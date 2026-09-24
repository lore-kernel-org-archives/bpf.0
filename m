Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EDF3F788D
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 16:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790267622; cv=pass; b=HifgIcy/eI7oC+mCp6WH3C17JwcjN2KGun5MYbE4oxHAyIKpFWyUR8fmOOXOjnxUTix5UW2UPT8esusb6MLvmYcnLxdMj/2/kBBkISm+brR4syIWSvhjx29SCUAvE2nhaedShnGRIqg0r86j8DmS8g6NV0aac9iYCCroEfIrLFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790267622; c=relaxed/simple;
	bh=HsqiZkHlethsCftdDK8oINDRa01ax4a02ujCR6NVOd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VsiyBhfJYNxxpUUdp1iK09uqR4i/Yz49bl8WDyIBg7FKF3ZfjkQVlfjHgF73RV7GuqW+Kh0gRXKmUU8jubZZ6Slv3BV9xhUX1NcOwIe2uOadvzKNETPxzOWD/wZng43AXEUMpDZtwZf/Ho9Kp5BYcqqB//8+JYsdMHDLEqDIBuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sdpgpe1p; arc=pass smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sdpgpe1p"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a99391ffb2so94866a12.0
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 09:33:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790267619; cv=none;
        d=google.com; s=arc-20260327;
        b=mgXaagU2P3hwceq7Wb+GH0nWQdSe8d/vAl7emKW8rTfTGAtL9B6bVo3SpDz1tagSVI
         SUp3nEPeQsvBE+hmuzruUBhsAa/TXR3o3kka3njMQcqVx1g3dI4sZ++9lEF63pwr5WQU
         cHCufxraqjmcVn/Mn0qf4sq4JnqFwc3RA7eYpOpHMCBM9U5ZcQtzb5vVm3pp5H9kVrV4
         K1EOzujQ0yxr+KLFopbAEaJ0XEQM9I4TPnsuRvCL9t/eLSFfP4b87o6Ome209WF95ip1
         WRwsoqpTr4stDVeqcKKuccwTwWyG16g8p6s2qgHxwMRgQfmBDbTnu9z3+3M8TDaPxK/k
         sGLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HsqiZkHlethsCftdDK8oINDRa01ax4a02ujCR6NVOd8=;
        fh=C94oO6mfRpLUkg35xDzD9vsZni9tFNd7JlMcp4fVOBo=;
        b=pr5wJzWsfpFG5Y8VRnPispNyRSHIEOPzWlnMYWbwNJx0wiRMYZhuv+gEU1Baw0jXry
         Dnp5Iqjolthy+zS6HycJ+xmUrUsa2dKDDM9TfBGO8WAAdUB2NfUjBQ8VDWcycOTmtrAS
         BGF/wwdp3G6nOGX98pl0hp6hWMV7SX7JkV9b5jZ9gB3AajT8AduTSJ30Kk7eQWE9YLXL
         ubWetzngR2aeC2Y42PfPnXhKU1mWh8g5O7Qy37dkcLEjcCXT4nCHOaaiZZHtb0jJuI9Z
         PFoyOUdyXAqKXpfNmjp/esWUsoa1UbykuOu4pln9JirbP/RSBZpZ8WZ3rxZAyGeijR5c
         i6Lw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790267619; x=1790872419; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HsqiZkHlethsCftdDK8oINDRa01ax4a02ujCR6NVOd8=;
        b=sdpgpe1pEK/N/2u3pZbH/8AmptW4tt+MXk0KT3qoXiDEmrp9tvkbELBarh+8wrLs7F
         eit8Yo8JhBPxW5KBumBajq8tjIJzBrHZCDpWu2YpY+IGT+/lZGDkijZ83XMzTqOGyuYs
         z665+byecvtu+W/Oa+EbwxZSzlmkQgpACeI+IP2YUau5bTJ8tcyt/T3Nmh6QDGdY7Vyy
         9g8jLP7YazjAOgRDB3DbIShQRtJnXXfDCCMsj6X0WTKPk/YgJzzNwpXKuRDumgZJQVdN
         BY8c8OUe0L6jSf9OXRf7Dl3Tn6L1dru+9J5D5lVqKAreiQKxwnyyivuo/0frLk9xfvUl
         PMyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790267619; x=1790872419;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HsqiZkHlethsCftdDK8oINDRa01ax4a02ujCR6NVOd8=;
        b=I+CEKOmG3QZcMrt0DzY+UNnIdHSw4ohcyJDaWcDYW3w+XDnd9D4eVw/f0FpO1ecG+M
         J8CV5+0Z3e/HUGSLDrQ5FioHULhaNPWuVK9K5cTLec48sThPuwAqeH4I2tT+LQCzVU0F
         paXOdiSsMVfrmCDehz8w4lbMNw+fy4BlEsHwhwNz71e5qsZtyoTDiLvd+AmhAbz6HDz1
         VH2Qt9pEaz29jxKJqq5MoAsiEAS8tphln9lWHh2fVNpQOdkxbgb3WDvKAi4xjWOeLue6
         na1EmVU8ZPDlCd6Loz+n4d+tC62QQu1JQOzB0pnoqBB25O8HyhWY09zCtMkalpYPJuFk
         h6Ig==
X-Gm-Message-State: AFuF++k1t1Lo5YgsWLYJq3YXnbquuLBxJs7zgy2K5GaXSsJuPphqmxR9
	1E6x8zVDbpY9zLUgiFI2EIkhDjgzITF4A7UGNUyS1lxTcg0ss/brJYFxylaek3b5XcNmfdEKwsS
	Ht+gYR88NqlafP2HEquEIrYzjHO9erWc=
X-Gm-Gg: AYBFou06QNCXUtIhvD716AWg1J71bLLEEg+/hbE1ZHJ8w4FvCKYmdbzKDpz+1mB9Mt+
	RAGf1At2GAAiV6m6PCVilI9iKWg8j9qto5zAE+p7Uyj1QhkEtUNtPRSIjhbcL5RVm+xfEfY/xai
	6kykBTt9BuL52Ibl8AOKco5GbGhPVcdZ/vy8oY3CRUI6+x/6tF3nFWz8hVcGkSnWWhodYLTGNG5
	uEex/1sVCfuekSFQmW9Yozl3Duz1gSHR9ji8GmgVNWNIcsyPXrv9WhQeidWrvtX42HozpSwpIUW
	UHuymhNKUw2qNs1sFasjtYT2GOvlubJqfVyhaSN1bHbtRNvBs4PVHv0t8Xz1/yG5YQNZI3r1
X-Received: by 2002:a17:907:d508:b0:c29:d96a:2ea4 with SMTP id
 a640c23a62f3a-c2ac22ab96amr266478166b.26.1790267619222; Thu, 24 Sep 2026
 09:33:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260924160354.531101-1-puranjay@kernel.org> <20260924160354.531101-4-puranjay@kernel.org>
 <DLNOU1DBG2W4.1SHS4ZHDHYUM3@gmail.com>
In-Reply-To: <DLNOU1DBG2W4.1SHS4ZHDHYUM3@gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Thu, 24 Sep 2026 17:33:25 +0100
X-Gm-Features: AclHuK-Bi52AMA6s0SIbXQ-XgYBFzCwxroPYIyRACpcI4-gdKpMP3dj-AloUdrM
Message-ID: <CANk7y0gNO0xrZKyX8SafRU_r_-4jo5oQGvTzdKhJ5JuRyMbbuQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/3] sched_ext: Stop citing the x86 JIT for
 the cmask cmpxchg loop
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Tejun Heo <tj@kernel.org>, 
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 5:30=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Sep 24, 2026 at 09:03 AM Puranjay Mohan <puranjay@kernel.org> wro=
te:
> > - * x86 BPF JIT rejects BPF_OR | BPF_FETCH and BPF_AND | BPF_FETCH on a=
rena
> > - * pointers (see bpf_jit_supports_insn() in arch/x86/net/bpf_jit_comp.=
c). Only
> > - * BPF_CMPXCHG / BPF_XCHG / BPF_ADD with FETCH are allowed. Implement
> > - * test_and_{set,clear} and the atomic set/clear via a cmpxchg loop.
> > + * Not every BPF JIT accepts BPF_OR | BPF_FETCH and BPF_AND | BPF_FETC=
H on
> > + * arena pointers: arm64 without LSE rejects every arena read-modify-w=
rite
> > + * atomic. Implement test_and_{set,clear} and the atomic set/clear via=
 a
> > + * cmpxchg loop so this works everywhere.
>
> arm64 without LSE rejects BPF_CMPXCHG in arena too.
> bpf_jit_supports_insn() there returns false for everything that
> is not load_acq/store_rel, so the loop doesn't load on such cpu either.
> riscv without Zacas is the other way around. It rejects arena cmpxchg
> and accepts fetching and/or.
> So the loop doesn't make it work everywhere.
>
> After patch 1 can cmask_set/clear/test_and_set/test_and_clear
> be __sync_fetch_and_or/and and CMASK_CAS_TRIES go away ?

Yes, I thought of doing that as a follow-up
