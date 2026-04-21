Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BA9384249
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 08:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776761726; cv=none; b=g+yurDMoNrjz1toRZa+UqYw8PFu4+UQ4ryrNDZ0kkSVpvwgMZsDP28ZWjS6mcvWchftl5Sinj+FroCEqR2c301gDC7baPMk+mYPQmykJlZgJixa7gDG3rwqnlVtemCPIz0j71Np6PA7Mj3g3VMNgtBy2pVrCeDITqCUsfZsvygQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776761726; c=relaxed/simple;
	bh=1D4wmwML28Gdk216ZBGZCjFPuBFFNvefSx3CUAO9YHU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C8jzKIoLGHIzn+k0Hui0kOiMlXSgF2DavSob1qmT3Ns8h0M0dZnUMalW/B2490K/S/oiMd069nbB9ajF5XeDIBYdpHWsUNQlNhIHCPYeOdBP3rG5yBcUwft8v1MFR5k1gzvxprwu9Danv4kL5gaOS1PuqNkEoxp/HnBc5E6E5c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LHSVhWKP; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LHSVhWKP"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48a563e4ef7so3262585e9.0
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 01:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776761722; x=1777366522; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MxBreWlPHPo3iYaW6fEd9W7BKIlXix7jjXchq/o+daI=;
        b=LHSVhWKPNlRuIrRJDE4SvY3awaQbfBYZKxuz0QWJVoAQKJD9y+jjGN+DVJwXGxJoqk
         2iFka2kCVzENmis05SHmllqe1GJNTTdgzwx7ArBvihDm1dFlBsfW2MDj3VuAcKFyTy1c
         sD4Fm0shdoFtJiv52Mgsb9Qh9tqVNMHt4mLANx4kLuIxJMbR8Kr36y0MLO/9+OLbhXJk
         oyJ6GfOSJ2MjTRouauHQv8OZb3gU0kx9/Y5ZxrFUZMAXmG7LmCTu+Fk1zwhRw66i/jCO
         sUcWlEEyHHB65r69ByRRs+zCrwR5NvsfuYok7YWonqZl4WE9waRXl6pPiiqQUla4+2Cm
         78lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776761722; x=1777366522;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MxBreWlPHPo3iYaW6fEd9W7BKIlXix7jjXchq/o+daI=;
        b=BP3JnqtH86/jZ63eaCJczabX1mOO4YLTN+SWshQP/P6jkUp3YkeynrFvWed3hfGzxJ
         who5VFbPpE5DrNBTeTrPyD6OITqrRTk2vvUF13mTXZVnZD4o+7YbdUpyrt8tt6V9cfuC
         gJkefmRo2wUugzHNqTuacqYA9gGHNdw6i2uNxVN4U9prAy/nbI3Rm3Fny/j6dLfdSm6P
         QnCNnbYY4hijqPR5WtX2Hkc8mSLYUmMwYU+2iDTKbpOkQe65G4/DyZExFxVPxsLnfVHB
         n89bFw7C9q+MZMe0GForYg2N8bQFsN5sx815/ugHwrKdCVGYqSpE/5/G214ZeSmTYSFs
         DHVg==
X-Forwarded-Encrypted: i=1; AFNElJ9IAGLvzWu6Lj/pgQ38+RkuvUlfyzaTOWAG1EwI/0N8VvTs2VOAO/TClq85v1IxiFfmXI8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKmv+I6xYhUSD98EWqBOi7GoWCzu284/elsyIx/XG71zrJeKyo
	qdEvxhO2CHBAhYr/rMuWekP6V0d7H774pxk6G0t1vIm4MWH5vbw3YpYD
X-Gm-Gg: AeBDietQ4S7wjnTQs9moxByZlKHHWdpCNb96AiCa1PzdCW858XLxN3My5uxWcPuVcUx
	ktdq1BZPMGtM1NCqo0C/3tzwzXJSAp+mI8zAwhXjsweRqsbR9qnfP20PUaao8MNW4HgsZwuGFYu
	Eq/kcWN/LmHM9cwshtuXJSRu9QQZM4lH3+HA5ZUBjUzapIVdt6ywzJ3OYA0FBW53eUVG3avWYOZ
	D3IWgAynE0NVbRXkQZseR01EXZi7Md9xEDX8sCUKufKRBTqxcYrZ+2KkYz1Y0b615ktVe1WlJoJ
	yRohFpA+woaTfjVxMXfa7Gh5qfC1Fl4hZX9bMgOqDXgem02gQeQz9mVQt9ZkYmudRM5N2YNyt12
	QOZscya4iKmDkof3pHcCyO4+9CaLiSROIUlDZKJ4pwl2QQ731cvKKDLU75+mJBwU0eVhjxjz8Yb
	MPlYZgwN8=
X-Received: by 2002:a05:600c:a08c:b0:48a:563c:c8c0 with SMTP id 5b1f17b1804b1-48a563cd176mr20770175e9.7.1776761722104;
        Tue, 21 Apr 2026 01:55:22 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::d99c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48919f54572sm63317395e9.26.2026.04.21.01.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 01:55:21 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 21 Apr 2026 10:55:19 +0200
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	kafai@fb.com, eddyz87@gmail.com, songliubraving@fb.com, yhs@fb.com,
	menglong8.dong@gmail.com, rostedt@kernel.org, martin.lau@kernel.org,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCHv5 bpf-next 06/28] bpf: Move trampoline image setup into
 bpf_trampoline_ops callbacks
Message-ID: <aec7d0Z70WKqC1b4@krava>
References: <20260417192502.194548-7-jolsa@kernel.org>
 <8a315de2e20505875006c4e32af33c0838000a79484f7a2e44b1081187a01379@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a315de2e20505875006c4e32af33c0838000a79484f7a2e44b1081187a01379@mail.kernel.org>

On Fri, Apr 17, 2026 at 08:10:25PM +0000, bot+bpf-ci@kernel.org wrote:
> > There's slight functional change for the unregister path, where we
> > currently free the image unconditionally even if the detach fails.
> > The new code keeps the image in place, possibly preventing the crash.
> 
> This appears to be fixing a bug where the image was freed even when detach
> failed. The bug was introduced in commit e21aa341785c ("bpf: Fix fexit
> trampoline.") which unconditionally freed the trampoline image.
> 
> Should this commit include a Fixes tag? The suggested tag would be:
> 
> Fixes: e21aa341785c ("bpf: Fix fexit trampoline.")

right, I think I'll send separate fix for current code,
to have this fixed earlier

jirka

> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24583317711

