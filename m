Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1350228CB8
	for <bpf@vger.kernel.org>; Tue,  7 Apr 2026 21:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775597264; cv=pass; b=kRVst8L8+YbBPkMTR/knTrkX7imv6ys/Cs+rabMFrRSGiZzZQn0i//D7P8GoDvUzF/gQldTM17iDGvueQAa5RcrLYaMS1Vo8j4s++bj1Fd4P06A+DyfXIYyRYZrk9vz/PDUxzlyFHlv69J9azd9l0BQ8Tq7f3U44sd3Tp1p7vDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775597264; c=relaxed/simple;
	bh=yiLdSkbH/CHg6BhW/vPOFQ4w20Hf9g2Qy+clJ0Vmetw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D1klrtsqmsO2YxbThOFqtxLxahoPtZ8xqVYvMq6JFQ0pGYW3LZEeqteyof3huyVwVIDCP6xQ1f4XYNPBqTruyqYaj10HeM+uf21HuExNpvYO++BGDuDi5XikY5mfFjthSx83JYITf4uOf+39OUHXdgMIFY0ybTlTKGJsDAs/2mI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wl/7+Mvh; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wl/7+Mvh"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43d0deb7ad5so4902358f8f.2
        for <bpf@vger.kernel.org>; Tue, 07 Apr 2026 14:27:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775597261; cv=none;
        d=google.com; s=arc-20240605;
        b=CTlAzeWZMoNq7qpmLYA5/JIFtJ4x9N/8Kcd0a8pLBSJAxv+Wo7JF2W4XJOH8J33iV3
         w9nII7mmQIVGvOBdgp5S8mqXj1VyltcRN45vB0YMfIPkwT+Lu7SWKocPuaQM1SITKWzN
         mBBP/2ux0WzJbkc1CIQx9k27XX96+sJTj5haHAgm0gf9LTCaKiQA1QTCtm7qvYdCd+oU
         kCnQ/19qZCWyoc24FeQXv8EqH6xg5gzR96cwAP1UyCdC3l6vqFflzOCv9IMvBugD59mw
         cJoBk+JUZFPIgzAYknMamxIxBk1DjA1eisCMJJx6IyXyiLULJRjo0BxENsWI8LVdM1Kg
         Ez9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1k2WHM3CJ2L53xy7s5H9My2ZMD6O6L/Be39rmda+zB0=;
        fh=RIEJ/L8PbzOVI7qB4wWRH7dM69A53oOTX5pA7/vDROM=;
        b=H3PuAR1GBDF3pZ2e9U2aI5iFl4LJcTaUrvK2Xx06SVFIe8zJeIk2sw045gEGwbXvqT
         ypSc2vuz0kuGI4qTOcEwJ4bwDeVXWzOD6CaSGZgg5/9R/J3WUekJauLvo/qUz6TLyyz8
         Wsng4beFjZ5oLv+slrMjOXgEbi2f7UvcFz2LbX50TZx7n96Z4R1IkCuecsFOzBpVPktX
         659HQNWgG+18C/Ai+cm1TxVhb3syPN5cdNZz4XKrHi5Jle2HUd1GyAG1dq8qtMrAvCSi
         As4hT07Xsxw5XqPfZReHTw3lY65uzJzE0Z8e8C3zhbs8YCoR45ZGuK/ZOlEb+AlT9TwE
         5BCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775597261; x=1776202061; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1k2WHM3CJ2L53xy7s5H9My2ZMD6O6L/Be39rmda+zB0=;
        b=Wl/7+MvheDGOB9LI9Z+uUexPcLnlYvvypj/N8Rhzs2svQfLOJgfZ4YJ8YGLI4OD78h
         RxoJTl5+hzLkF1MoRYnTb07Q6zbmUcuDYk5QvGZRH1fEyOH4nC1FFzSOoUYvptEhzABc
         tDAOAMXF+NatGvgyScD+DmYabgmfetcQj3btHtci45otDdu1nwFGBG2Ai3IZeoSQiEsd
         6gsvl5o8XeI0P2u4MqmOleJjk2KjGstYmcu9OsAQjWBAnGKB9v9YmvQfTomrjGiq81JA
         w+VOYnWmWRGYlTXWIfzAOV1Jit8FDTZALFEopLNwgCDSTGeRk7jClhHk08g/F58jwrud
         lDRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775597261; x=1776202061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1k2WHM3CJ2L53xy7s5H9My2ZMD6O6L/Be39rmda+zB0=;
        b=AmruLmvnjtUx2xSgao+76KhmhtZi8SbM5g+bMc2kLKQK9eyeACdZ70IHPWFM3fv+kL
         r//towMPl1G2qTmUlad20bHtkdi94Pio+X+kJ8Ou4kWWdmG0GamKoZZUBNcXIEZEzOiJ
         KtJpJZDPJGG6frTBF4hDm0MqIkQ8JPx7V8oPssZrnJoWpZOiaLDM81z1tBAxp8GaJaX4
         fE5oQ0QU5um56eXlbHeHBjX/wBdYINLxfTQ7zgOiGVVc+vJM47UU2sXdQrJEl+cQP0Oa
         jo6uSzHAP5GZWbtrIhug43RQ2va/iQk6r3CPrCDoyOc5Fcxj7BZQM4rA55Y8hXasVEyK
         UAoA==
X-Gm-Message-State: AOJu0Yx218rlKNqumVPFAZ8tQvrhow9xRMWJF5/xaYaDThcQD6B9SNMW
	JBQAevbWf/So2KCyH2amf8EgnrY0tHmqYnLgTawWINit2C01TruSDs0QJTyD361gznMDP9ppNcx
	B4ZdVGfbRjodqau6szOwN2Rt0XkZku/c=
X-Gm-Gg: AeBDieuaH5VxfYycFODAbQEiEJk8qNzQvb6ZUjl0SbFF44VE0tBvS4JVsAViTtYpNlj
	haJEQZOcUbhB3sX7GkThOTGSymKU9CUueNQcAaRbHkl0DM+2CNObtPbjFolndNhR0tN5wxhD9Xe
	cNngTHEKLI+UhY/P5sVoDN+frLlFfHtTpj/60Hm7w9YpXEeUTlCkz1ZDebjfwu70x0mheX/8n4Y
	Y0kRjALlZvaGWCHV06OoqtI7YNdNhQO94IhNyJmXHJ8yvXM/Rohf0WajLEIzKTorLzp2lrvFb16
	5/44DA37IGP/efOpvmASOy4AXi7iQlRTEombJ9wE78NeodP+EQrtm7JluFbiPRiYJSmS+byi2R4
	lr8ZUBaCzQ2udElJC2fYKyqBewQ==
X-Received: by 2002:a05:6000:1845:b0:43b:4aba:8f38 with SMTP id
 ffacd0b85a97d-43d292ecca5mr25957964f8f.47.1775597261200; Tue, 07 Apr 2026
 14:27:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260406150548.1354271-1-ameryhung@gmail.com> <20260406150548.1354271-2-ameryhung@gmail.com>
In-Reply-To: <20260406150548.1354271-2-ameryhung@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 7 Apr 2026 14:27:29 -0700
X-Gm-Features: AQROBzCB4vtovxzMUYz4lSV4TFyUy2ISs0r1vMvpr4P7Vk8BfUSEQf113lQJlzc
Message-ID: <CAADnVQKgKkyRfoFNSsCi3ykquzsO+-bZnvRO=V2LqyOMiB0ydQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: Allow overwriting referenced dynptr
 when refcnt > 1
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eduard <eddyz87@gmail.com>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 6, 2026 at 8:05=E2=80=AFAM Amery Hung <ameryhung@gmail.com> wro=
te:
>
> The verifier currently does not allow overwriting a referenced dynptr's
> stack slot to prevent resource leak. This is because referenced dynptr
> holds additional resources that requires calling specific helpers to
> release. This limitation can be relaxed when there are multiple copies
> of the same dynptr. Whether it is the orignial dynptr or one of its
> clones, as long as there exists at least one other dynptr with the same
> ref_obj_id (to be used to release the reference), its stack slot should
> be allowed to be overwritten.
>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---
>  kernel/bpf/verifier.c | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)

Why ?
I understand that it's ok to allow, but the features
adds more verifier complexity and more things to worry
about in the future?
What's wrong with disallowing?
