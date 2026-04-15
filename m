Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F9F40DFCB
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 06:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776233338; cv=none; b=tODSQIp5qXdBndRVtVLqPrfmw9pwFb66gVfveY1SPpqVLlPBp0ySEGttD+Yz5XgcvnM0rzMXf6n9O2C6vvjbkMGYKiZ/YsFYZzaG0PAgW3gJSrWYGW206QTSGfoxPyjdc10Odf6YhzVkTRkMnrOTtwMGPSSrcfl5K6jMBDp/K24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776233338; c=relaxed/simple;
	bh=laglfAjx6/TGzNPwU7R3Bjf98fFj5WsnD9jySMFBy/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eYDFzJYEaVOUjJzWskZCB3i6Fn1dGs/8pyMv/MZolDO+IZxmLtPEJItSBoBXASrvTbB9SzruscCGxd4mRLkqnzkq5BiaqJkWUh+sLDeFRhPvHxG0I8CiC/C9aiLx78ZjMo2/KozamcvLVf8ViRT0XgZMDKPx7paiaSyNSnmg4bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UFFzuoQr; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UFFzuoQr"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b9c3e2cf3c0so997518466b.1
        for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 23:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1776233336; x=1776838136; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2wSHEDrB2fOFgpOMdm6eaGOM9h1Tbw3+MszPYGUFbNQ=;
        b=UFFzuoQrWL/Ud6Rg15JkobbjejQr8o3OL+ZZ2E9VHwItbYRo7HYHPrBSU+pH4tfAj6
         kPANYRKmraJY9ftecg8P1icce6T1ymzhDlqtQCou0jwJqxTH26K4bJQo5/3R7MVYYTPQ
         23HQSP+kIV7WgKfMQutKB4GmYFxKz0GDWVn80=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776233336; x=1776838136;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2wSHEDrB2fOFgpOMdm6eaGOM9h1Tbw3+MszPYGUFbNQ=;
        b=ZAnthsZInmPZ6uxgO0bCm3E0m3xv6ZFjfXyLLT5Owi3XZyRpjMLXMnIdEgVhDU8OCc
         PkPE1diYvIke7OgIGTEvaXEoV4zsiOxex6CyDYEpnQmI2WcVtkZB6su36TBWyq2KxlNv
         C2wO2YFBS6WXIESJ3XeWGCqHZYcZN2zORpaH7xf6zGSOQTnEFUOSqSr0CtQuzxG1o+wW
         iOsg0hVaSAS+Dkq3GMR1e9Avv3IlyGIxPQo5OjKTezl+e7dr52jygKMdLpdk4uW7lMvW
         waFyRxQDDjw5uBDmb0w6Rn+jZAvKBFOhv/d78hr9cFU20CK4aA5/ZO3mxvjsaq0SAVnp
         RTkw==
X-Forwarded-Encrypted: i=1; AFNElJ8bnjCTLzoBvJ8Czq3LDQlx00+FAEq/P+C65RW0R16Hi9M2FTQyQMJVYBBHlbyuMq8mv4g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB5qQ0CtQE1+wTE7UXjKfN2yJxMAYu7MH+zJw+OsK2ELBEml4F
	zKOMVNvfgiX4VI3ruBcD1bNcWWSwuRF9NOdTRkOCzyea5ew1QBhXMQqVK18+5xJKK4RTjnzPy3W
	bYOGZTpE=
X-Gm-Gg: AeBDiet6SO2L23AfE4b1jbi5o5p/W3KkDaPd4woR1oa1DZG5iXic1rRn7mo4xrGRi/P
	PQbP+tAkdwI7p+zRSH0gFLYUdrFHX9VkJ+3HEGrmxHImdGFMiQS7bfBitq4RJVs0MZDlxz+hHGc
	jzDXt6dso0zZMFn/O8Zar6NWip58yeaoKuRo82bJQlTBl/ci2DyRBDnHSIP+cPPLLwaeH1y0BVN
	RUjYtZ9zfywOsnWqet7JqDJRo08wO5tatBJ2jlkPxePpo5UE74yJb01T75aVeZmFHjSKsPFKSTd
	BJuog7VcJGcUB7vVZK/npzuHb+pdSkzXovdmO9dy55cTO7zcI7UeSx192zQVvAlKPlLLdMiahXH
	V2xPgXZfnJLPUAdkl+JodCgD6zMtPKfYACq6gZtgVQSpy3ZoJuj0cXPJqkdw0tTM5vTRPZh8HYL
	h4o42oQMOdFJ6OaIevTwk5he7LTNb++PhpRAjx9gdiTo9GYChBEI+fpkrQrOwqvcmPUYJkGtZk
X-Received: by 2002:a17:907:c817:b0:b9c:80d5:f023 with SMTP id a640c23a62f3a-b9d7260e0cemr1295801766b.18.1776233335734;
        Tue, 14 Apr 2026 23:08:55 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba17392e673sm22461666b.17.2026.04.14.23.08.54
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 23:08:54 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-671ff4b716cso2398039a12.1
        for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 23:08:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8PQXGzJ16CWySiqdf0CEmoziffqECya/AsN6ymovI1lCiQPYZ+zYtlkHqnxNXIbQ7eDU0=@vger.kernel.org
X-Received: by 2002:a05:6402:21d2:b0:66e:d697:71ee with SMTP id
 4fb4d7f45d1cf-6707a475ad3mr8825487a12.15.1776233334075; Tue, 14 Apr 2026
 23:08:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <177601563477.7932.4081917600853246368.tglx@xen13>
 <177601564263.7932.2238613098642404049.tglx@xen13> <ad8OGZmCVRc1C-Ck@MacBook-Pro-49.local>
 <CAHk-=wj56cA+_m8YL-5HuHeSDsA_pvuH8Lu=K4JG82iw=G6bAA@mail.gmail.com>
 <CAADnVQK4MOCe=oJPgUXwZdwTu7ZK_WjmpO0jk87A+j0zJeaCTg@mail.gmail.com>
 <CAADnVQJ=MoiX4=guPWhL9vtnAELkpNx=GNm8RA1-aV424UFz2A@mail.gmail.com>
 <CAHk-=wj-bwQkr9To3Z_fRTYF8tZK+WMVWJ8k=ACZVenZbQfUuw@mail.gmail.com> <CAADnVQLbxLmr43kgQ-KP7QAhyOoE5Abcj3tCOu4KS-c2CJ_ZKA@mail.gmail.com>
In-Reply-To: <CAADnVQLbxLmr43kgQ-KP7QAhyOoE5Abcj3tCOu4KS-c2CJ_ZKA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 14 Apr 2026 23:08:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgf92sapt=+5G=gooeJkPbpdq87CG5YuoF8zkExOo3=sw@mail.gmail.com>
X-Gm-Features: AQROBzDo81hYhiNMLphiYkwlRIT5MAVgpaMvHF3Dlrjrh3__-hxJlXeZxUK8YEg
Message-ID: <CAHk-=wgf92sapt=+5G=gooeJkPbpdq87CG5YuoF8zkExOo3=sw@mail.gmail.com>
Subject: Re: [GIT pull] timers/core for v7.1-rc1
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	X86 ML <x86@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 14 Apr 2026 at 22:46, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> Yep. Works.
> Tested-by: Alexei Starovoitov <ast@kernel.org>

Thanks. Fix pushed out,

               Linus
