Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48DC3ACF1C
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 18:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776709195; cv=pass; b=bz+hjZXxk0bHDuRHSEriEgeC5RVt5l5YZTlqbT58p425ACdAgpZSdhGs7GwYejTnMiA9DFzbeWpasN/izD5FoqNahDcxwE92cxvu9UACnqpxc5oSARdocHap5vvAKEd18N67xtLvidQcdy68TIfDyjDqoDoH8Vv6EUqXFQhNslE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776709195; c=relaxed/simple;
	bh=6CcprxJ6h8zJRK6p0fT3lMKJplcjqv9CSgWcbdXmhhI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MsoTpqf1GJy25oTwIXu5XwWrgs6wIHzv547i5C0POz0ZZMYBvmZrqsX/egYtsA9iLu/FKFB1aaAxTRCa1BdxCfg9zGGRlmTOmsCx+1l30rPA3lllIK0Nse0pUnEMBH2hg9mbGPrMpBHlvWbLQ5d+DWPVdI14JR1fcDueojvVBmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aI8mA4hl; arc=pass smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aI8mA4hl"
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-4891b0786beso12553035e9.1
        for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 11:19:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776709192; cv=none;
        d=google.com; s=arc-20240605;
        b=RBHFcqvzRO2gjsWznwmH4vxpK95ZaCRH43R9gVx51tBarcv3gLdZuPaHs6sP3LbNEX
         z55UQku8zuDoARwK8dQEMorSeBZvvHAJqrj9ZpTpIxc1AZiQqKHeB9klemvDU3tRT/A0
         aE0YwDXINPqebEdbx0NtA9gnWdpPANkljWBe5oqOQowRAAN9bfJSZMQnODosMkbLixYe
         yr7lh9TLpD9nHjkST654zzcBZx3Al9TLp+ZnHAKVFpQcYx2r0a2y9bkAgM7T/mMZdln9
         JnFtDr1rQRGNCWjvYDL/SfTneeIRlvQ59XAAbS0mVQKBGdn1QsoQUS78ae3M5lvdCvbn
         UcRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=6CcprxJ6h8zJRK6p0fT3lMKJplcjqv9CSgWcbdXmhhI=;
        fh=d7rlhyN/Q2x3jSDaI/pXs+ahy8tQN2AeZpJSpGrunZM=;
        b=RWU6oLNoNCRv/3vkOCUURmq+QgPxuyAtEV8Qaw7OszkEogAq9xSTS5gB7DOoiYccMm
         ZhZJHajidpiXs8oMCOk92/urDogiikh031z9ZHJ+1Ys0t3SsJiqyjY+WFp1l0QQGwZcj
         X1yvLD8nFwsd0B7B/g6hvmxu4CzhiWYgKwa4DpuAKU3TfgvQoJw5KVt9Fsl5hNtX/wDd
         A659/MIdatWbfmRLClz4fqNk8NyHbD9a+OZL9PDm+CSy/hztjRU9UfeaZtQDR04ZEumo
         HTSX8TLtviWLbRiJfVfvM8djSA4CSxxiKDEOx1IuOFAFHocQEGqr5oRRljjeVZ2lU3Oq
         V+Zg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776709192; x=1777313992; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6CcprxJ6h8zJRK6p0fT3lMKJplcjqv9CSgWcbdXmhhI=;
        b=aI8mA4hl8pIsVL5+eEf1saMwC4B9+jVPHTMGyl17ly2bx3LaT5I/u/A4CRUJsy48zE
         uM7Px6Cgo82S6MmqUSd4w0jXv6PF2O3CdFWVfvhOnVP2CyYnJCWn+lUImOiuSLzXBxD8
         DOFThqunXAutWxyBEjy5amhHb9y2DyRGJOxOXz2ZU4rMQZijY5y94CPJF7D6gXRdaxjV
         f6VZi7BCWTrsm9QWeby0NW9ZV7erJbOi1dLCyBJWpb2go1WufEP45UvTJ8Ncp0dfw+Xf
         3XNDvtOIP4aj4nUrR2OPU8RsZl4elPx3V8a1uPG2p15QjDS0MfMzm24cC3/E4dMTp25d
         SBuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776709192; x=1777313992;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6CcprxJ6h8zJRK6p0fT3lMKJplcjqv9CSgWcbdXmhhI=;
        b=a2xpkEAbkuGUTKfPBHHikJLCGkN7Kfb1UMx6dgrxFmTC6ei9cbl76EkrBVUFZONT72
         Uma1rWcvncPMnf7xiM7pW16vXeMzxgT6efz26NpwrfQ6XzpZHauvdxV5btQgQ475JUBl
         If68xOxrB2ObJ2BI2W+dqWV8ands0RBAoqLedFWmSsOURKctd22i2BVMgOYezC3vynOG
         /hPXHmj1KL35iov48WyY5q4XGD8jgoIg3re5pcryLyzDsSo3IhjGhYLwbH5uAo3Nt92p
         WpzsY9dkg4XyeWGigKZWN8gkw7Z2YZajV/SAEMC7sb2BtHu/MlzxHqSJ2qAbZ7OeOoid
         sxyA==
X-Gm-Message-State: AOJu0YxX6/a6/jlU5hh6KTkloySsJbjt/JydyhyB6dSuxEAatKIjrcJO
	eDrNXZlhkLQuJtem4p8lPDYxZ4EIH+Bhn4ah1Ohjlo6Get+bFgxYYc7yAfsPhKY8arlQL2oizIq
	+BMWVW3IyXWVVV6Dh/Lrhc+3E11cnqac=
X-Gm-Gg: AeBDieuO/5tXQMJXdExmL3ffRJeNS5TDi2VoB3jxI3H6j86fbg5wgPYuL/+Guhpx8nM
	/7dFBm2Haskn5AuZuB8aAet0B2OxezdIuYXiQZtMF0OiwhGBxuEdt/JQY+I+Ff9o4h1r+E8nYx0
	C41/PZg97zzfvsDbI8/2lP/ZgW6pHXAXygrHNFgtgj30N7jvTA3L/KBnUUpn9nA851HoFAbuagp
	of7xz3vr3lGQlA4g+QX2S+0+GveOymV5T0OO1M/x1e4NZJMh3lrhb5GsK/r3GPgoKih7QqM0oEJ
	CqTegmZm3PhqQpeuFyN9aRRQd1rx3zAExWV4A47mLfpdoqcjOYV3+hfqnOvkQcwjKm4PPTa0y45
	euQWZZtq/srti3sPGEh1vDwfdDQuf5z4lwnsd5Qd50+KQtrI1M1Z2pk8XIqnwVaBt6bPz
X-Received: by 2002:a05:600c:c4a1:b0:488:c014:34da with SMTP id
 5b1f17b1804b1-488fb77ed1bmr197526755e9.26.1776709191980; Mon, 20 Apr 2026
 11:19:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260418171701.610025-1-memxor@gmail.com> <20260418171701.610025-3-memxor@gmail.com>
 <34f9c2a7-529d-497b-9091-6e8bcbacc80d@oracle.com>
In-Reply-To: <34f9c2a7-529d-497b-9091-6e8bcbacc80d@oracle.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 20 Apr 2026 20:19:14 +0200
X-Gm-Features: AQROBzAWBN4DOHjb4ktaflv6lJ5P25btJNFVEeCpSvES-GJTcYzuIZpjATaV4nE
Message-ID: <CAP01T75ovDvfQMf5KWCTUwSLNs070bSRSHgWkA3GAQ=hZ3nPNA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/4] bpf: Introduce __bpf_kfunc_mark_deprecated
 annotation
To: David Faust <david.faust@oracle.com>
Cc: bpf@vger.kernel.org, Vineet Gupta <vineet.gupta@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 20 Apr 2026 at 20:15, David Faust <david.faust@oracle.com> wrote:
>
>
>
> On 4/18/26 10:16, Kumar Kartikeya Dwivedi wrote:
> > Documentation for KF_DEPRECATED documents the expectations and
> > recommendations for deprecating existing kfuncs. Until now, such a flag
> > never materialized. Unlike other kfunc flags, more context needs to be
> > carried with such a flag, thus we introduce __bpf_kfunc_mark_deprecated
> > as a replacement for the (non-existent) kfunc flag which takes a
> > replacement kfunc to provide recommendations to the user.
> >
> > Apply it to all existing impl-suffixed kfuncs that are preserved for
> > backwards compatibility for a few kernel releases, after we introduced
> > versions with KF_IMPLICIT_ARGS.
> >
> > Note that this is only supported by LLVM-compiled kernels as of writing,
> > since GCC does not support for BTF declaration tags.
>
> FYI support in GCC for BTF tags (both declaration and type) has been merged
> and will be available in gcc 16:
>
> https://inbox.sourceware.org/gcc-patches/f8ef5eca-4f1c-4efb-96a9-c65533e4573a@oracle.com/
>

Great news, thanks for letting me know! Hopefully, once this is out
and widespread, we'll be able to completely drop the ugly double
underscored suffixes for kfunc arguments by reusing declaration tags
there as well.

> We have been using it successfully with the selftest harness' __failure
> __msg etc. macros with gcc master.
>
> >
> [...]
