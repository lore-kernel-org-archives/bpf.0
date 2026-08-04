Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E635B36E468
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 05:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785822099; cv=none; b=Dqh+0QbALoCD8A5uGrWmMbNopoqT9gFXKp5EEemmuThShY+z6xIBWGA5Ej0d0T+EAOB9mMwpiTH7dyOp9m18xZI8YhTMyNn3J7QLIMUgm7aojT/hRbKmRzN06HLNyvASqXwoPHtjCdSC9KNYJ+gnI8MCKS1H9Fe03SXdc7N9eM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785822099; c=relaxed/simple;
	bh=o9TpznHEP+mULVgqgdAUENNtI8edpUMa8ub34DChYkc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FRXK3rgG3LH39vIikhLqE5YBTO43ufFkzaQS2doydYkdyDDMydwxa0x5GQXgEc12khGdELHPgsQh6QYeldJlATlALm/3zioQ81pzgV3ieQptcOYe4rDMi2Y6ehAQvwEyv/zD9rvn3RI0Qt0Ro+2zRnOwJQTPvEnGIY/Whc74Tws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KBrmLpzY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KBrmLpzY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19D4F1F00A3E
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 05:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785822095;
	bh=2YkazKmUrLOhbL023icX4qsz/H9PHNK5zkIGmoZj/fI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=KBrmLpzYVbFU87p3b4iqieu7G5+NSZj56qIK4eu0IlGxgqtIuAF3YLh/l0x5T0cRk
	 a867TosMVaLEhcd4fP8xB+U9U4qoLhVXRPk55y4DP37LaLnRO/xtcaUsKx+UryIVQp
	 4OSfVjnlqXIkFW+LVT7Qagt0FfZL6Nx4LFbiP8vTgEHToZzeM5dlnWWxk8rcc8xJsd
	 GVrsvJ9yrqrZE2tiVTS8T2uk6rukUd65mAAevd+Ns53qQaVDLkoh/ydFghizie27nd
	 lLmvwjUOCn60y7E4kbE5wb1mA1j6X/c1bcUpWKhJjRCjMwnlW/56+LAcYSLGLD0m7z
	 +HdHsWrHRq1lg==
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-92e53581361so217602085a.1
        for <bpf@vger.kernel.org>; Mon, 03 Aug 2026 22:41:35 -0700 (PDT)
X-Gm-Message-State: AOJu0YyhBolnpxdRTpIUlIWKpd9iEySs4t1N0sF9ZkQ+TZpN+kozA/Lg
	VIuDK+MsC5jV5Z6pLnkzhgaEPJveihck8nPkvqTavfAYJxzJoqpekUQg/ZkUAMuUBc6CUlsQjrd
	zYPgtCs7n+IkQIYEvnkVYvP2jMd6lKpw=
X-Received: by 2002:a05:620a:2602:b0:934:ab73:ac53 with SMTP id
 af79cd13be357-934ab73aceemr1838213985a.0.1785822094146; Mon, 03 Aug 2026
 22:41:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803181232.14743-1-ebiggers@kernel.org> <20260803181232.14743-3-ebiggers@kernel.org>
In-Reply-To: <20260803181232.14743-3-ebiggers@kernel.org>
From: Song Liu <song@kernel.org>
Date: Mon, 3 Aug 2026 22:41:22 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5HJbh0LP3FW6-LjYJHvKXYAYuQsvxAX8VuemXS+CAi6A@mail.gmail.com>
X-Gm-Features: AUfX_mw1dd5UVIBtzqf2jWpfr06Ke2mXq4cnaMkv6N58qAVrkhjOup45SME4mRQ
Message-ID: <CAPhsuW5HJbh0LP3FW6-LjYJHvKXYAYuQsvxAX8VuemXS+CAi6A@mail.gmail.com>
Subject: Re: [PATCH bpf v2 2/2] fsverity: Fix silent truncation in bpf_get_fsverity_digest()
To: Eric Biggers <ebiggers@kernel.org>
Cc: bpf@vger.kernel.org, fsverity@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Jiri Olsa <jolsa@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 11:13=E2=80=AFAM Eric Biggers <ebiggers@kernel.org> =
wrote:
>
> bpf_get_fsverity_digest() silently truncates the digest if the provided
> buffer is too small.  This is a footgun, and it doesn't match the
> semantics of the equivalent UAPI (FS_IOC_MEASURE_VERITY).
>
> Change it to return -EOVERFLOW instead, matching FS_IOC_MEASURE_VERITY.
>
> Fixes: 67814c00de31 ("bpf, fsverity: Add kfunc bpf_get_fsverity_digest")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>

Acked-by: Song Liu <song@kernel.org>
