Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC32332639
	for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 17:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772126105; cv=pass; b=qJclvm6OpEI2gd/F987zhg660xVYhM80k7RsGtRayaKrKkGFmEV75Bpgpv8I2PC/ATU25qGTuSadTIJsdnUidKxyweny+JmxseyDIBoyinL7srBLiHbDZ+JWQUF0ABhl+2gOSa/tAJw4X38RwIgylWeOQZVlGnglIuP4kYpa0HY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772126105; c=relaxed/simple;
	bh=SIfCk9cvHN9yqYkwAWWRrvATwyIRQa+uIK2pNU/lg08=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bOVTWG9MiAtzW2j9oOsD6T/zOKIx/PGpiPBNDaHOFbxjNwxr0GgfzEK3/lCbKLaMQ1VF/l937jjMNK43CWRe79+8uIgjtfir4gUjTxxA4kemULc6w7jCUF43yJmP0ZsBpVSVNARdf5ZIcAKWXyRGs/GdSIjQYKl0VDPi8bIchks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bzDqmFEI; arc=pass smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bzDqmFEI"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48375f1defeso8312195e9.0
        for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 09:15:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772126102; cv=none;
        d=google.com; s=arc-20240605;
        b=kX2DtnadHCNWnbG+wDWnFufngx8LTFZMJ4SVN25s+KtycuSLtHMJ968Te37/5oJW1n
         sjLA4ohSjS6LZgpkYx0XRXw4N4GI0KPIjLeJhDrk0h3tplxGvDV47NK13zQ3O5okInoA
         Po+jSmdUwRIljtbJYwn6F+AXpcXyK177BTSyMu6KO6UyXLd52hlvCZYrFGSTyoHhRExo
         jlkflnKYbO3Y3JRCxgiy23hsXCI/9uAMpNLsi2rVataxC+e+UtY5wE/hKujY03Y+u5Qe
         jOMnAOdGVVPH9Aha/L4va7P5wq+yKtXOqC48HhazikiroYjTZo+VWjl/DyEiyzkKfRMU
         42PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SIfCk9cvHN9yqYkwAWWRrvATwyIRQa+uIK2pNU/lg08=;
        fh=O9PJJ/aNeVdafHTBU7CUQhg86IlmjoijAdMclavgujk=;
        b=KTT6bcrhhs85STg954/OIPfW4Ph7oUbhK3VYuEfLogL50Ch3IdET/GNiOz4WQmDOA4
         WNp46tQlE/7spfc2JjwLhsybX42VavcCv6yslOWNGzHxMjjw9bwX8e7xUVseYzhuxhKe
         oP/gnDQObEbak9zhfKxhRiiS459zmBRg/z/b71p5f5CUN3bLzXAPZNykLoMyk/XMmBfR
         9jwwkKKQ7OKW+nPmVpNY+vRRTybUsBw6eUqqMxlonoDnOq7/gc/vVC2n446vO7Ujolnr
         UVDhPhHHo6nG/SMCmXTbrhKrLczb4cLq+KziMfgKitCL1gHZgp1FV6WxqCAR8+Pe9J1K
         tSGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772126102; x=1772730902; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SIfCk9cvHN9yqYkwAWWRrvATwyIRQa+uIK2pNU/lg08=;
        b=bzDqmFEIo4JAtG85hOHWF3FQxAybMbfFMXbhIPY33poYlPM4C040fuQjL3y7AUtzi7
         aosBytL4D9b0XwUEtNPPq0AjtaQtsDJb46ixoKS0qKFJFmEEu4N1sE5ToDCTUH1DmjYI
         F9rQtB9zc2/2pOIWWAPZMqQW3TI3X/S3LlxRJeWFDuVzGlnJx3vY26LCWLKYfBSAIBIA
         t1MxuYNcm8VzLtGtkmZMqE1HBCirvXDzjEC4gwMobKUqUkUXn+diLvW8Y61L1iKyKllF
         3Sed31d1UKY85LqOwXIAIA1mCAlEcIdsPyqgZdkZs/U3r5yLrKkKW8/g56JKr05DKUt0
         BHSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772126102; x=1772730902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SIfCk9cvHN9yqYkwAWWRrvATwyIRQa+uIK2pNU/lg08=;
        b=VVVwQiyMstXIaNexIMf9XS9Il4krFUfd1CF4EdEvWpTbrbTY4cX7sDo4l3n6wv7elL
         4BDsBwfZLzRbEwvLjs6hzbagV4kmKrTW9tyYg4kszsaVvoIWbv2rUWxiKIiOue/BSjOX
         BqDM8FcAhK5y+0l57T0qjuYI7Bw/X+kXtICvAzf96H1R+Tq23PE6+nnmwjyM81POiamx
         cPoTKyzGS37j8WAz0mkUtfbMIFTMKeN1ht6JVisFsEyghYmhWJ98WT+psYtvZLWL8YNW
         iIy6L7e6GZlDfwd55+dUBO4GatwAsHNcoyGkNpvv9cXkddafvEnq75HW6mqDFVh4h2r6
         dM+A==
X-Forwarded-Encrypted: i=1; AJvYcCWEL5aX6Xhf3Ymt479eqaF0KHMrSBxEz3yvLS6qyYLh7lCECJxDYVzmDUER/YHVzQbx0N4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ64eraFKT15g+lPL7+AqTXgm/KGWyPMCFF6kzyOuH95B07XaI
	mbPZ9lYiY2519VvcT/GtZ8ZlawxjaaBYLSFXb6riO7OuyVxVUkMnuSqkJ9PVrBOtLALmaJAyiWn
	H739m6/x9bS1OCLNF7mrt1sgvasRQQhI=
X-Gm-Gg: ATEYQzxw6FGdv0pG9JyyVQARIM1I66e4+k04FiEy1mk1VJg4y8xSFjMVAy51zN8qHnP
	COE+mjSAP/JVG5LeeK3gpbhMjnUV/j43L61mHHGtzGYve5dqg3Xf+PRXQ9Uxq2rqDwmeMoCQwGR
	Sup+JqjN9p0OtGBh1KXeSV7s0ECuobvxpZLdVQFNOpFCLdUzP18DciNmIZxhH/KP6HQQgyLMb18
	vxFq19COWY5G/ng8Q+OVQ9nA5pmUv271OrekKCJlTVaxRWgzTtWhnvXvuOtWQ5f7b6Efc/Ku945
	1JW2hmbahXrj4zIlkiS0OPXitGWGgGI4sqlPM1jtf6bH8is/bVVVDeg6lMqdEAuhaJD91W2F2TX
	Lyhr4SPMYmZcZsvEb6Uc=
X-Received: by 2002:a05:6000:144c:b0:437:7268:8e1e with SMTP id
 ffacd0b85a97d-43997f4145emr5805473f8f.51.1772126102426; Thu, 26 Feb 2026
 09:15:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226080003.524935-1-idosch@nvidia.com>
In-Reply-To: <20260226080003.524935-1-idosch@nvidia.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 26 Feb 2026 09:14:51 -0800
X-Gm-Features: AaiRm51PaW7hQ9Mwq2-yjypGiahmbHVvHgNerWqvNgY6P4RhUlKwJC2t3ik6HJ8
Message-ID: <CAADnVQKo9L-OvwJYwFbGSCMdXThYU8E1=jz=uZY9x8_azLZCjg@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 0/9] bpf: fib_lookup: IPv6 output routes enhancements
To: Ido Schimmel <idosch@nvidia.com>
Cc: Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, David Ahern <dsahern@gmail.com>, Petr Machata <petrm@nvidia.com>, 
	Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 26, 2026 at 12:00=E2=80=AFAM Ido Schimmel <idosch@nvidia.com> w=
rote:
>
> This patchset performs two changes in the bpf_fib_lookup() helper:
>
> 1. Patch #6: Aligns IPv6 with IPv4 with regards to output route lookups
> (i.e., BPF_FIB_LOOKUP_OUTPUT) so that it always resolves a route whose
> nexthop device matches the specified oif.
>
> 2. Patch #8: Allows output route lookups for IPv6 link-local addresses.
>
> The rest of the patches perform small changes in the existing
> bpf_fib_lookup() selftest (patches #1-#4) and add tests for the new
> functionality (patches #5, #7 and #9).

tbh I would send the whole thing through bpf or net trees.
