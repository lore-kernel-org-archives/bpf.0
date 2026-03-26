Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF973FF8B7
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 14:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774536853; cv=pass; b=E1SURK+uOgU7Qyad/xAMKzsxCWuiJO5ZuBA6kvpa6P3hxKKs/4Skx9NuVJMOQ5YJSnp+tAactp2QJ7QxfMJzGSehLI8orEnbwCtkawrx/2cXlsFsc4CHEb74Drrxb7DfQbllkL4Fbk1ZYBhu+7kCK4Bvt7Zn5R/y7UYYGnv+38g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774536853; c=relaxed/simple;
	bh=SEhU+8FyrhCQphBxGSGzxRvEz/UtCwkE8r71m2dkSA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pdKDbVoC4Ur+ykTFu3vS8HHV/NlW6FIlVCaY0Tk9L/Ws/3B/oRgPP7LTFcipghfaBGcjvqaFA4ZqeBYiSTRbDMIFzYtZZM8tBI/jf1sydlvheMbp1i0TCIws2onU1qOhn97SRmguYPcsf04AvelKWFnFiEQVUkGYl8kVeUseM5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ANTjrajT; arc=pass smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ANTjrajT"
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-439c6fc2910so697349f8f.0
        for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 07:54:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774536848; cv=none;
        d=google.com; s=arc-20240605;
        b=L4yizs3YES5UB4Y1cexFlp+pn0TiD2luFDUFuVFvSeFFhV9F7JNKEMvQsm+pZq9BqU
         vU/qdyVvui+E9930Yyfb9jsmjB23z8nVvKLFG36WmEYvqc6QUPE7+7IvGe+NM8O5OTO4
         iYXzgwstg8uvbVXCnnx5vOeE+GZWrbAZ0EPcZ6hj+UiTVEX7qtCwxAQgySZbV4j6rgYL
         YPIfIxJKe6OxhEYSUlDWCco2TEnBG0qUy7+1nQGMTtdanZBlvwotMkuDSQmabBV4hxyX
         dn5UzZ3RBai/3QOxjcE+NUYiz9FBU4oExMtTT/qDmGp3VRT12SJo6ZnP9QyOS1eipPgA
         QSPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=FhuoiHNS8EWtKNqoBDqtr5VoGO7JWS8fa9w/yw4hw+U=;
        fh=lKjcAjJuhZsoQyLRrLtdCq4ij/25c78CZiLAA8dNYQQ=;
        b=Ig/hdb1hE2LdZSCpYa7tPYnXYA0nuHMTnIIv4IOOUxCfrxr970Dgdhea/3o+tOmXWm
         7jaqQ/CP1/B8/lsc3WuUwM2+1sOOnB/6m3mdNPG/9syjejWzIhw6S8lFVCZfJ+uRmDe1
         frgy5lb27dhc5ppFDlGj5FcjnOWegsnpVasrdqqCHUW4iN5jOFTwGW9n6Y5d5qeWqJAr
         DdNFkAFXcnYcfuBmsyJYVEjamLrBN7c6JnY/FZNfVWGiw15OmwxaTYw+pDV6X6XuqrTJ
         kDEroHZWB+6EEyuZkIuWtYk9n29Q7Xrp8nN67/+88WxNAN8gb6LJ+utEDp+D26rvDrbd
         MftQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774536848; x=1775141648; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FhuoiHNS8EWtKNqoBDqtr5VoGO7JWS8fa9w/yw4hw+U=;
        b=ANTjrajTdtniA0nBU8OjHqIcldHr1GCIgWI/hsvwXRB5zfqpUMWfRp3nKH+PepEetO
         olB1FaXbpRAx9YtsCcA1iVOgZvwNkX9DSlf99Ob2VeQRJObDby0uo67p0w3H/oX7tWhP
         2prIYefx1ZoLBwURQht385ZSGEOEKjHH/uUQ3WAu3IIC0t5QYe11I8RiiPGzUWJsJ9D2
         PcfzGX0qxfoICT/Td/re3agibSrwoANjQPaLZwuo6XsjaX4QFeGsIfwrf3jZ7JCIWhnJ
         KoPQXwvRdo+Sqwm/8YHnh3r2o1qeTI8H4RtL/fncOZU6Orw6aE6SujmAaAZoj9mgZgb5
         ARJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774536848; x=1775141648;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FhuoiHNS8EWtKNqoBDqtr5VoGO7JWS8fa9w/yw4hw+U=;
        b=V/aqJwzCi9GyZY5tTKqnF5NVTqpEEPgnaEGZ+XWamAsTJfbYIY0wNzC68cgAIFyWkj
         lW2yQxOE6yyYpx+96FLyRPlCIno8eFDFzTeCNUBb9MgGy+fM0FtvBMc+ghUb53Kdkkor
         ZtnM2CXKafZhzfdfULOMg3gNc/2mXRYreqOBl74kjvXiP8hYYQ/OjNCADeUcSjrC+2Wk
         JZXrAJ7Q6IOeWvan5wsH9JMurpOMcmx0mY8nS4rzgfBRqbkCv0h0tjWmC8csdtYz/X+A
         O8G7qwrzm9L37o/fY2Bzxw0Mf1lrhl96V2DzZ2/5NSRl3IV1EeNYJAYqkknMquJ/gbUK
         HGnw==
X-Forwarded-Encrypted: i=1; AJvYcCXLyIUp8nUf2lkgMNFYS8WgWqrwSRmd+pidwj4dIhb206KTKvXF2L0YbPj+/vfh6RiuB3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW/KzDZ7AoOLtyPz5bJ854PZcV8hPXa6tZ18+ywKv1lnUZJDm4
	GhhSwASTMwuz7kTe1x7+a3+CAQEVcZkaS+ysd+6CpOSQBn4QZIFfRCkmTkWpRpP03zSVDF42Gb5
	V+04yFJO67BFlAKY5vwN1ctMiX+mAYGs=
X-Gm-Gg: ATEYQzzAR5TOoqYhSLNGUVOJ/hqqFmlsxfc6mJGmnS0FP9flYR8WOBYcPjuI81RSMQb
	H8587mrc85iFwui1u+8sCxLzpFiTHh+AshTjzsc/O2K5WuBprCZYEWqb3DcG8KrSJSpy4geeCO7
	RIiS4Cimm7OnF7tk2BZ6PbRw4QvcNdcoIkGEicgQ9i5S5kz/2jxqWafeoDUM9gzyS8KKObgcXBb
	gsJoJ0CtsW8hP4esfX3xwqXVfNRGeIo2Fch2JuV4OkUpb2SlKcZAPnnFO/CBqaGbFKd3jhH5C7b
	p2kA9GejEE0BWBK4AHlRH9wqQZZNacejfRpwnEqCPRCloEJqbtD9ly1cSpPh
X-Received: by 2002:a05:6000:310e:b0:439:ba57:5001 with SMTP id
 ffacd0b85a97d-43b88a29247mr12274420f8f.44.1774536847553; Thu, 26 Mar 2026
 07:54:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326112521.2827500-1-wusamuel@google.com> <m2v7eig4ue.fsf@kernel.org>
In-Reply-To: <m2v7eig4ue.fsf@kernel.org>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 26 Mar 2026 15:53:31 +0100
X-Gm-Features: AQROBzDA_uO1pF648ctMN48d4pwbfgoV5WCFXg2YqxbpVDNoGL1Ww4jiqtlSmvg
Message-ID: <CAP01T74KNVT2SVRR+XPbFb1vy85W=Jkp4_yD6xvTSg2avQo8AQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Support BPF traversal of wakeup sources
To: Puranjay Mohan <puranjay@kernel.org>
Cc: Samuel Wu <wusamuel@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Danilo Krummrich <dakr@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	driver-core@lists.linux.dev, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 26 Mar 2026 at 13:20, Puranjay Mohan <puranjay@kernel.org> wrote:
>
> Samuel Wu <wusamuel@google.com> writes:
>
> > This patchset adds requisite kfuncs for BPF programs to safely traverse
> > wakeup_sources, and puts a config flag around the sysfs interface.
> >
> > Currently, a traversal of wakeup sources require going through
> > /sys/class/wakeup/* or /d/wakeup_sources/*. The repeated syscalls to query
> > sysfs is inefficient, as there can be hundreds of wakeup_sources, with each
> > wakeup source also having multiple attributes. debugfs is unstable and
> > insecure.
> >
> > Adding kfuncs to lock/unlock wakeup sources allows BPF program to safely
> > traverse the wakeup sources list. The head address of wakeup_sources can
> > safely be resolved through BPF helper functions or variable attributes.
> >
> > On a quiescent Pixel 6 traversing 150 wakeup_sources, I am seeing ~34x
> > speedup (sampled 75 times in table below). For a device under load, the
> > speedup is greater.
> > +-------+----+----------+----------+
> > |       | n  | AVG (ms) | STD (ms) |
> > +-------+----+----------+----------+
> > | sysfs | 75 | 44.9     | 12.6     |
> > +-------+----+----------+----------+
> > | BPF   | 75 | 1.3      | 0.7      |
> > +-------+----+----------+----------+
> >
> > The initial attempts for BPF traversal of wakeup_sources was with BPF
> > iterators [1]. However, BPF already allows for traversing of a simple list
> > with bpf_for(), and this current patchset has the added benefit of being
> > ~2-3x more performant than BPF iterators.
>
> I left some inline comments on patch 1, but the high level concern is
> that encoding the SRCU index into a fake pointer to get KF_ACQUIRE/
> KF_RELEASE tracking is working against the verifier rather than with it.
> Nothing actually prevents a BPF program from walking the list without
> the lock, and the whole pointer encoding trick goes away if this is done
> as an open-coded iterator instead.

Which is fine, the critical section is only doing CO-RE accesses, and
the SRCU lock is just to be able to read things in a valid state while
walking the list. It is all best-effort.
Open coded iterators was already explored as an option in earlier
iterations of the series and discarded as no-go.

>
> Thanks,
> Puranjay
