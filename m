Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B5D37DE8D
	for <bpf@vger.kernel.org>; Tue, 16 Jun 2026 20:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781642980; cv=pass; b=kkDVb3nOV4N/XJ9lHdgy0J25fBu4+Pxtr6R8R09/YVVXPOGTj/Vst/tFTL30Gf5IeIPG3tb+DC20pXZIdOERQm18ERtE68E5ZWPqVGf9fws2EtyUIp60aCLv8mF5viNgdcS13mJh4BEHOVt6AWyNMt0BsEj7YRZnc1ITG4qS5jw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781642980; c=relaxed/simple;
	bh=fi9NlmpSEsgxURdIHjqA8/usrtI/7e3sTahEYTEgepE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Va2+HoRgj5PUFGR6YuwXWtiBPSDzwbY6LONukbptRSNxDfHMQ1X8uAZHiHfx2O09betQCkvhzwBPsmVW54MZxaBa10G4HPTbKF5drlF0NlJYjSnN6REia7XEqmgGbdQqPZUdyqgofm+A8jSpFkkT0n+YMhIOkO9yxFZESYVHQmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20251104.gappssmtp.com header.i=@jrife-io.20251104.gappssmtp.com header.b=xHxAlQxY; arc=pass smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20251104.gappssmtp.com header.i=@jrife-io.20251104.gappssmtp.com header.b="xHxAlQxY"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8ce9df38792so9454936d6.1
        for <bpf@vger.kernel.org>; Tue, 16 Jun 2026 13:49:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781642978; cv=none;
        d=google.com; s=arc-20240605;
        b=PxwWUzVPVxUf6zZInAc9YYQu/jCHyK6bfw+EiL6HhsSpJLp/kwlrOViGE+GSKOWFZc
         DwNtGODA6iDLzNpqoZqKdXKwUW6ZXoilVhc+4fYiiIoH90v0T1jefmdrghh3waqMAIEN
         fsh5NP3P2kyFzOf97+Yg59C3lV3calyim7MGbCP7JlLCpHnw4Wshdkf8cX8c4GZNJs9O
         mzgyzV/fnzJn0yNgzY6PpkgOYHwACCZ1uDfYNXPsF/6pWeemr3S2cQimoO5mhVqlS3iy
         A6k106D6GldvkdSWmLpVij2Bt5BYBInRM0CLPGof6/+OZ195G3a3gNiT3HNXudOZRJ14
         eV2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=fi9NlmpSEsgxURdIHjqA8/usrtI/7e3sTahEYTEgepE=;
        fh=lL1lgm+rwKE9eTsrX8oKn5U8gS2bVZZl2C6RzUuv7ks=;
        b=lzfw0pVCk4aAjIq4sJiGKQVb4qLPFd2XWS6ENPzuYH/bywj93GVcBEascSjbdneW7o
         02vdaCAHMUkmc176geFsjPLIq78/4upOY3e5cTSm/3v9qskaSghWU+GExjZso6q2MyXl
         diXRb6s0RV4LXoWvCSJH55LXx5GacyBlcIpWWFizyzyrAYmYWtjeFrKeaQA4GipZl4f+
         9YUXS0L7crhccCQ+XaP+4eh+V4G+0S2CXYykaoGAqGlPm6SCfhyBrjWzpWxFUrA5e7qO
         CjI26JTM3VvDwJXtpzgzWxnUBHRqp8lKBqJob5C6Tgjlj61y7Z9NzQSHTA1Bd1lPYgMp
         iPMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20251104.gappssmtp.com; s=20251104; t=1781642978; x=1782247778; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fi9NlmpSEsgxURdIHjqA8/usrtI/7e3sTahEYTEgepE=;
        b=xHxAlQxYxAxSkOD2tl/gJExFZiinPk/Ux69leEhIgv7g8y0PApBQRkXPhu8WJ1Ectn
         ji1j5RL2as6QqLzbATSyJ0MSWx/I+C9U0TfeFzDAhgIlY1nbpc1R5DVweEP08ftWm0nK
         2tQy9i3g/vQCoV+oQorEonjK61QDqHfuCTrs6hfv4P5YqkvvAlBs4bAaVuDskzU5t1Sl
         4/1klFfRUZPIwb38ev2jpLQQxGXaESMgpo4QCInQSd2W1hu5AN+dhYVeYersD4EDrD5i
         +h7AXAXiSgYBDTD6fHPrl+8z7rNeJGhRj6/9DDNzT9C4c57bmOAAfACZk/XTR8CA9WHd
         HpMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781642978; x=1782247778;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fi9NlmpSEsgxURdIHjqA8/usrtI/7e3sTahEYTEgepE=;
        b=sfwK9Vrhj2122HDQedfvbTHRUwYVhBeQ+NjsqzafSuNKq/J5LPoC6q9z7ZhQDiTd1m
         YD1DF0MKMQLtJqBO8KuUHknVlaUGM24CJV7QgEE8yaf67OjeZxDW9V03RuTCkosUUeH3
         PBl3yXwWE4iB9NyclIPgIHK4gnyClbzLflwNL52zrmy940jWVdLDAEVCY/3PqqyWjbmS
         6e7GSi57o/TTktd1Ml+QVcOO9FzbwI+b7hPVVzMBXAyNPu+geRHRd7KmFNkZxi142bMZ
         x8q2BdI6P2QMobO8TO/tqFZ2Kqjoo8xELAi+I83zx71kY1cavDgWP4lgfaxUmnXt3aJj
         3YwQ==
X-Gm-Message-State: AOJu0YzBqK8luktKVq7yvALBi5JVi6IpmbSKL5mx7eZgjcpYCKPzGrJs
	AkmBMXBNFYrp+r80se7jLCvRUqP4i9O/HC+nHrx6gOgLJdSUYCECdWZiTNMkFnGV9r0W8cssQoY
	ErEVaY4MUZR5f94LP2NjB/fpP9b2sjxC3vzTJqASXTF7J9gEOuT0X
X-Gm-Gg: Acq92OF4rAJiCvYPkvGqpoOK8AYszby9Ul/rcueMADfw15rU9Hfr6MiFHgPSqcKGrjn
	qc6q1X6qhWfbzFuC6aTg9kd7mWthYXbcFSg7eS4rAL9dn8ivA0hHhG8MO9/5XmE85VAH19nuBkt
	9qSXYDvoqtBgrJ95Ck+kobsteJ7uY9LW0cMmEnD/NM2wk0KVas7tveqr/uwlsYtAu8slCJpMRL7
	T/DXATtJdJleJv3RbW6HruHG2wL2iNRDD6/aqbucw1atkAkrtUVsmm+ZhWNeAssHrO04YkY/O+x
	QEGGKMXf7D745/bs8Q2ut9jNMjzZb3/BDDLNDA==
X-Received: by 2002:a05:6214:451a:b0:8cd:290e:fec8 with SMTP id
 6a1803df08f44-8db8287818bmr8274236d6.6.1781642977678; Tue, 16 Jun 2026
 13:49:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260613183424.1198073-1-jordan@jrife.io> <ajAXF8Nvg91xU4f2@mail.gmail.com>
In-Reply-To: <ajAXF8Nvg91xU4f2@mail.gmail.com>
From: Jordan Rife <jordan@jrife.io>
Date: Tue, 16 Jun 2026 13:49:26 -0700
X-Gm-Features: AVVi8Cfx8fbEJTI1TOk8TlTWVB1lG2JC-U4g3T960cHMQ3Qo-FGba4ycLv-LuB4
Message-ID: <CABi4-ogYKX9T_gWcXsKSs5-y=3GA_WqwfyjobmCxexTtQ_H86w@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next 0/2] bpf: bpf_redirect_peer egress redirection
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Stanislav Fomichev <sdf@fomichev.me>
Content-Type: text/plain; charset="UTF-8"

> IMO, calling it BPF_F_EGRESS would be less confusing. It's a shame we
> can't have the same flag API between bpf_redirect() and
> bpf_redirect_peer(), but this is creating inconsistent semantics for
> the terms egress/ingress across the two helpers.

Yeah, one annoying thing about BPF_F_EGRESS is that it would only
apply to bpf_redirect_peer, so you still have inconsistencies across
helpers. Perhaps this is less weird than having BPF_F_INGRESS perform
an egress redirection though.

Jordan
