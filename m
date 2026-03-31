Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51C53321AA
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 22:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774997300; cv=pass; b=sGALYiKp3fsmXMvQPRWZb0QCgwZd5PyfgY2yGVGinpSm0YT6ipaQ04GTFC8xAdyIC3oncpn63V7CfzP1erJM9DKArbjIN+pqvKIZMEkNbbLtZu3N1H3T8M6/CeBTuAii2uX9bFUK0oKhmzHFur2D9FcVAhy4EiaBDXX7wKUfEHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774997300; c=relaxed/simple;
	bh=VNDVCGmgfviJ6VpaIw6MHjqeERBbaInH6R4FkyfJwIY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dhil/xTF2VpLs2rUoPrRSX8OgxkGRfKLVzB95Z6r+W7iQK7bzmhsveMzsVSJlAPf8kUDDz/+Yfyb4aHE6OYXOGFY19nNx41QqTN0cO8ClK5MBa5hEyQVj1Rro/5gBOV/svdjwZ3Q2nCC5CKgMm815alEXex3pCNsBJVN7xpmk5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nl/+MTe1; arc=pass smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nl/+MTe1"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c766cf593daso4342033a12.3
        for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 15:48:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774997298; cv=none;
        d=google.com; s=arc-20240605;
        b=KWm3Dl2NyYGt7FBHHCRVV/N/SZNVfjULNUfsW5FNydyGffmNb3VvRplFn3x3l2xQqE
         gISCtMm7xKw++4scluoIYYUbSZZdbsXPxfc8K0ftJ5WlWWk9ylGyR9gnJirK1w6/BZ4r
         2YH9hPKe1142w9x5wNJCst+XiI7JA/j8AbNGnrPRVwjzOe1xouzXcyswrftBvNbcK2c0
         E4I1teGWh00bJp53szZoOLyrq/zNCr1oJsRTA5l7T6LJVJ+ubc0CrU0iiANNbS2Zs5lv
         zkzYTkOGA6TR6FIa50TepKP3brmeUu0ZIQ82NQJIeDZEz+EMWM0AoK/tWHyU4+qHqBqv
         +Dbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VNDVCGmgfviJ6VpaIw6MHjqeERBbaInH6R4FkyfJwIY=;
        fh=KD2hR2DEDkb4vWd9CjDN534GQKjMTcfVeLUVjQ3CNyE=;
        b=J/ZFKRIKqiJ+8FBqIEhXrgqYYpDkQbYoHj6ygpJyNdki5DUovizrvkTWbr/pj8LtqA
         QXGzpM9lep3nhaxPMONtG6TZz/vOJGGWSkH0B5T6i2rIHnIHphCAOoWRPrMWz1yh2dKA
         i3FcMchRl101YG9UJb2c6km9ywAJ4tntyofUUf11guKA8BzP9jzxskpNiGJtgbhxQO92
         dDWJ4bpIa54Ptg+mz+dNIt7aRYWcNaC1pdiY8LXnxTHPzUlQbP/Q2QLd7ij8H+DATsD4
         pQM7vVb8nR1sFS+QR7H4Rd/ClaU7mZXHF1PpV5N6eCpVo9U9/XEmyyY85/TWpa5Dhsyz
         w4MA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774997298; x=1775602098; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VNDVCGmgfviJ6VpaIw6MHjqeERBbaInH6R4FkyfJwIY=;
        b=Nl/+MTe1osEzrfPvpXQWCZqE4buQbc9POiz9ZIRdDBV0rcvZyBladnKRJRF9ni8E8T
         7FFf87LN8p9r8vZWOSmpjXWrzIZlma0QGWdTyTuJY8zCWjn4jbm6HLJIcmhlrMVt6FLq
         YMEPYXaTUTxTkatMT3tjCim4jJeU1sAKOzNywCU74Y6q+oBB8/+qsjtieDpeNmN0AyUC
         m9HE/MphcvekdOYPjiKek09n9IT0xa/zxqZxdOSqGMbse6Dqoigda/vKjJ+x2/kS7KTt
         yriJ/11rEbmTLGdHuTlHpIOtO/B4baCwgPjCOXQiwWWR8oInHAgLVMheGWtDOpHVdhku
         kwvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774997298; x=1775602098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VNDVCGmgfviJ6VpaIw6MHjqeERBbaInH6R4FkyfJwIY=;
        b=jw7dHo4HOkJ7RA/Gze60drefGENS/uO/zxrmr/5Bj1inoTmu4kWaOQhim/+rMe7WSd
         F+tWZKJfm0+AG73HVlITmIGV4L6wFj/SMb1lOH33h2WYxM5araaFIkPmcaQDPx0X0yQw
         baBOwKlSLXr8Feo44VxeC7l/LGh9SCWZEcZjoTLt1oQfuIET26CJAZm4ltY1gRxd08FG
         zgLRFZyx1Z6ISuqjB3Q3fUNSAkjf2nnTUkwrztk3BstziPee2gkTC32sIwBsMEItWHHc
         qP4TGcP1cg9sN6/eU7D01SXPF5b6gYeF6zywhtCIpxFOpnk7+iFHLAM00xYfBeLpls6N
         la9w==
X-Forwarded-Encrypted: i=1; AJvYcCU6b6Lj9uK1uR850Vz1Ae/a5Fs9KcIjWuJUqi0dcougZqbziv1ow0tZrXcZeCP6i/Exuog=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEGz1usSVh2OdHVo0Ji38gZHPTcB2MdJi/VAxsc/vxtOc6I2R8
	GL24QlHxJChABLt0gudN2N8Ymb+L52VW72rbGPWWuNZXbFr3JPMOtjBxHqP3dmZU2JWbCMQfKNY
	jERYWzn29jYyK+d5ZthEddHKf5JV+7Ws=
X-Gm-Gg: ATEYQzxPpqFng3gbMHWRvry364Ev6oEHmyUt5VAOpV0QqM+QlYfY8yDYLPrgh03gjgj
	+xTxiEfqFnpZdOUI/85L5d0Z0QbsOGXOqF1XUwGJ+zmG29QTzEfv8+HkUVWF4U8IsqLe11odExj
	zxCxBajudjvDTS6L7FvWrd6NrpjCAi4vghBF3KAsQN+gBu4c68yn46gW9Acvo8MPjprIlzVw7eC
	vmcOiux9c9T3Hc2ETCUzVkAlIrFI1hj0WOx1MG+M7QgjxuDVk+p5cUEs9jaykK35x/dfZCRuugd
	yZZwg3XtfYf9kYOjEFv+LIg=
X-Received: by 2002:a05:6a20:4310:b0:398:6645:6f17 with SMTP id
 adf61e73a8af0-39ef73de7d0mr962117637.19.1774997298123; Tue, 31 Mar 2026
 15:48:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331204228.26726-1-alexei.starovoitov@gmail.com> <CAMB2axPvRNJD20_Ay9NDMk8=d4toY3jFvb6hXVfdn_v02kWM8g@mail.gmail.com>
In-Reply-To: <CAMB2axPvRNJD20_Ay9NDMk8=d4toY3jFvb6hXVfdn_v02kWM8g@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 31 Mar 2026 15:48:06 -0700
X-Gm-Features: AQROBzCyWpzLhZzTdT6kJ3jE3KzbwrlovFrlW-Z3MmnNz6V7r2SivsuA6irfJkE
Message-ID: <CAEf4BzbDC8c6=YgNVaS+VGR71pfW3RmVC5TQ1c56DurcFT1Pzg@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Fix regsafe() for pointers to packet
To: Amery Hung <ameryhung@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@kernel.org, memxor@gmail.com, eddyz87@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 3:03=E2=80=AFPM Amery Hung <ameryhung@gmail.com> wr=
ote:
>
> On Tue, Mar 31, 2026 at 1:42=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > In case rold->reg->range =3D=3D BEYOND_PKT_END && rcur->reg->range =3D=
=3D N
> > regsafe() may return true which may lead to current state with
> > valid packet range not being explored. Fix the bug.
> >
> > Fixes: 6d94e741a8ff ("bpf: Support for pointers beyond pkt_end.")
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
>
> Reviewed-by: Amery Hung <ameryhung@gmail.com>

applied to bpf, thanks
