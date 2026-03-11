Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4346B2BCF4C
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 06:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773211683; cv=pass; b=tgEvQYk3YkqTvm4fCWvZAZ4JJsbWSakBbc1r6KZ37WmOUHNg4ZRFhtb/Xx6PRjGbUeohI5o7J1lf1Ad9VkOMOo84HGbv9DpFu3CBlbNr51FXF0HNTyaWyGYmRussshL426BAcU4CQZZYkRO5EMr4pQvdr1KSklvuIw8XC0Ne8Dc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773211683; c=relaxed/simple;
	bh=OKXK+AfEjKGL373gCNOhr/hDVfV9JLNvK7zU7xw2I2o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h48939JZsFy+Gwu2kpjJ0ffbyN7bDRA4BzEOCBJU+K5GEOxsC+QHgv6KicqAnLJEiPBUN+cfCUQ6HVkbaxhZA+hum35l+xPFrIluSSwrBV7HMgkjEpsqWZQuqxN3/OrGsIyfzV3qy9+l5chclI7JlgVimlwd6Ql2Rf1bn3+02GA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P+tBFTQC; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+tBFTQC"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-64d5a7926cfso2105158d50.2
        for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 23:48:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773211681; cv=none;
        d=google.com; s=arc-20240605;
        b=lwGK6vaNJFzZ7d4cCeO584lg6ZOFT6RZISrZgb+PNkbnLhAGZTs67LaK9SpBj1xpGy
         ol3Jy0Ts6TXq8cjBow8IbFoLG4vHPHoz3gZ4l7MeHWoGYPXwaB/JMZiHz85qc8XVXI+2
         jP0+9jICw3Yb/AbJTzM6pJHGYBnUstYTtRhSs2Gka+h+2LKZIMzIaIODMBuKnXh+y9+N
         ffs1NwFJZSM5pZ7b0Cxjdyp7XZs0LTUN3u42PKbXEOI9qDD4lXeU9Wq1bLGXZrBeqTcd
         BlaOOe3j4CFndGX2gWnTHwD4SYjQSr2aiYFFgRbO5ai034BjlHi9YQUmfv+rmAYfJWXR
         +INw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OKXK+AfEjKGL373gCNOhr/hDVfV9JLNvK7zU7xw2I2o=;
        fh=Y8iohavcMVdIRaKsYhJ8PNlrq7DkeoLcKQxFuDByX70=;
        b=bae2qp6MTHZ4pb6SIdCVDc8Fc8dOTsFA3Tc8CgPHWWPLArmmjH+Z5tleMX+vwrBfOo
         Tw/m9702GJfsy78KkbgY0efdsguiShutBegJ3YpgsF4zFkGvUGkYaEm/2JMjt70WtbsZ
         xxcX1g2F98Bc9B4hBj+2m4a5CxSkk/hq8UN/DRLXIv44Zsplcnyrc22SkNGv0b3egffn
         wpBeNhZYdEIw7JJa02cZMal+70VmaY6EUPpRrXucpvTQdXvWH7MHIktEkF6BQMDMFcX0
         Duo0cZVVrPem6otS+xZfiYBUEO7Dd54SVPkaWqupsPW72bSolH6fqXow+m/lNFNH1uBD
         3OuA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773211681; x=1773816481; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OKXK+AfEjKGL373gCNOhr/hDVfV9JLNvK7zU7xw2I2o=;
        b=P+tBFTQCpXokaIBjlT19U2drGIr7a+MPdJAy659EZpYIAqqqiwukXUpqoKH0IkRhtm
         cAAXnOZjWyr3l+K+2t8aNGCMTXNjS19iXE75yVy6kA+y+vbcVzm2kJrs18z6Cxwo+Bz2
         cBsBHUhz7TA7rtGIG0dJ5ZNiofopXdScke5ipRycjmUl4AotwlAlRMMUXkgqO/UvKplz
         kTQHLzORAOuXJKqJSTjG16mm9x8FyjQSN87W0BDXtpMgFo9XWDChpP7IoMkGKhmrgtAM
         dYPJnbBf8qZnC59552MK8DuRlmX0EO6GK9yT5J0XodfXfzZJx++haQA+dDBg/t89Udwm
         Ix+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773211681; x=1773816481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OKXK+AfEjKGL373gCNOhr/hDVfV9JLNvK7zU7xw2I2o=;
        b=lom3i9jBm8fvmHoNNlUgLC2TUxzuveUJEkA8f4t6LMMUSnk5PvYlmnVWzDEQlokY1g
         nEo/0x9s2oJ0dGQaljIYrAl1pCfKcej290jbAk5YUM6iuo06gppKjRmT/cs546Jr4mK6
         iOiLAf+KQlfCPCwzm+6yhTLVTCO/45oN5Q4FdOLWe+LFvZeMbl9uLDsZLNi3KS+0yhwy
         5Yq0GbIdNxtlHuXuBHvhhaaxwLPaqOtwzSlOkc6X81XqeyRyAL5JO3qhOnTUrk42f7nB
         HTxGH01ftIAFikwR0XEZaB01wunGoVPr3KB80yn/4PsxeaO/5XbEU8OJcRZrpHHfFVbe
         TV3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUMP6K1KGXx3NV6RHEE79LAkZ9rZdct1NxQ1z3if7LFZ6KM3A9ID52Jo/h6HwyMoa2pZDY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfkGkJnF5kE4+TxwADS015hapmEC//qwfnC+dV3EQF1KJzVjzZ
	OcWbDv9gfDVKz9m0xLz5dw+S0T4zSnLE46vrC4AzvkGKyqcdU+NI/0Ts5RVYJUWG72cpSR+yv78
	XX3QjvWBFt8RFqn2EXz8N/5Qtfmgc+w8=
X-Gm-Gg: ATEYQzwDOfy0niTo5ZSaTdwxANmbOCdTyoa/YnAcMkWa1YUvVCtx5xoV7FS72G5iiU8
	QsjtyAQkk5TxXEgZvqZwaVTt/cLU2dtMvvip+HXowwMTK1yassAu8AOV5pVKcW/ap6hHZuZ8R0M
	/tKiHRLuRnhmAbe9+w5Ri9vtgRu0tNGI0XRO0uOFEn8y9aFzTcO6wWdLg8TJTlXx4QjHOmSlvPb
	+1uDXBwaVG2XLuqLEyL1YjcF66F1sdTPTMvnY0tWNZbs2FAjSibzEbiBywDCMNf2JOOCuxLGGl1
	G3SyAIGf41HlDkFfc6M=
X-Received: by 2002:a05:690c:ec5:b0:798:c347:ccfd with SMTP id
 00721157ae682-79917e7d546mr14270177b3.11.1773211681221; Tue, 10 Mar 2026
 23:48:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310102145.857810-1-sun.jian.kdev@gmail.com> <6a914824-178a-47c3-98f7-f3c3086ab831@redhat.com>
In-Reply-To: <6a914824-178a-47c3-98f7-f3c3086ab831@redhat.com>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Wed, 11 Mar 2026 14:47:51 +0800
X-Gm-Features: AaiRm523CVkghIJYxcXd9XHd57e_PPHvDTlrJgjOm0NBjaIeqf5GatFWIHLuD-k
Message-ID: <CABFUUZG+fDw2eETsmEs1RZ-vSZ07uuxLuZDYp0KJqTX_6via0w@mail.gmail.com>
Subject: Re: [PATCH 1/2] selftests/bpf: Fix read_iter buffer termination in test_bpffs
To: Viktor Malik <vmalik@redhat.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 8:28=E2=80=AFPM Viktor Malik <vmalik@redhat.com> wr=
ote:
>
> Does this fix any real issue with the test? I can see one very
> hypothetical false negative when the uninitialized memory would contain
> "iter" but that seems very unlikely to happen.
>

Hi Viktor,

Thanks for the feedback.

Even if the probability of a false positive is low, the current code
is still incorrect:
on short reads it NUL-terminates only at the end of the buffer, so strstr()=
 can
scan uninitialized stack bytes. That makes the helper potentially
non-deterministic.

Terminating at len makes it deterministic and ensures we only inspect
data actually
returned by read().

Regards,
Sun Jian
