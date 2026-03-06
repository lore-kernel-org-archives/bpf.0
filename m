Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147403EDAA0
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 16:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772813638; cv=pass; b=OpwpPBsNxbVoGwAXrwRq3jslHDZgRx2bbg+N2y9WYoqoyHufJ1ZYneATrTBGjb4jVPYJAYlAgWQgUYcOUme4gGKA5cW0vwtSoMrf0+kU6YE6JofLcTuGIGtVt66bW7S2WCGomOyPul2EQjykx3vb3z8/2iNe0bIFOWOK7OTCgQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772813638; c=relaxed/simple;
	bh=uHwmZaso1Kk+C6IDbrWGhxeGeRiawuc2Z1PSYKvnkCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sOW40LAKJLGp2w7ssOHcnL0bdfrdkxQZ8L58He97xyPoyOWok4kb12gnxhcojl9suBOISBJp9GHBgVFiN/ZqY6EOUbvrUHWgIjTEHkZAjqZLqZ9oqd/Rzzn1ibi3/2Qb6AnBG2XjjTU2dSIJiIBwz3Vy0kL1qaXIL+NXQdvfYGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l5qZ9oNx; arc=pass smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5qZ9oNx"
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-439c6fc2910so2362464f8f.0
        for <bpf@vger.kernel.org>; Fri, 06 Mar 2026 08:13:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772813635; cv=none;
        d=google.com; s=arc-20240605;
        b=C8OvGLmw7mLyOwK8qglVGC7ceRD6WZZ3Lii+fbZWD+4duuXOi+n4NOEIv9nJTgTd9W
         Lf63W+I5CnnxkEAEkK4AJWP57V42/7nPGjjz6xZLGTa/oSA9bPev3u19L8uttcJC/n/B
         3mjcSzHoqO3dENFzisDU5tSCTGeHP8/oMR2NjOMNE2fUD8dytlsFyBEYp/jRTT/X4xo7
         w3UVmw3oXxefPi501eEP/qjCcBdo4Ahim6hrw1jAr5qKqXoDgM2bQyGqb+YBjGwmEqIb
         +HcB4j0iPx09udgetnS+vF0n1bljSyUOvcEnqQbZpI7V9HA/jGul1waMN8vDtmQU9a1q
         zMEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=uHwmZaso1Kk+C6IDbrWGhxeGeRiawuc2Z1PSYKvnkCE=;
        fh=NTE3CgXhsJQhCFjLsoDxCfZc/0OsKIw8WG0v+NskoE4=;
        b=I6grXdeZ17876Qt1+z6lIEjUerMtzw5f52o3Yh5FjW3M9qdnxN+P5OIGVucOHr3E3G
         8L9uK64vyBQtif5HQB3cQayxHYDUQ3YUl0Ge0PZ8Hu15shJuuHcpN8pNXwcKd4zFu92H
         GDNDrinPKGswzxdiTv3cWL47z6Ka3ZC1O7GrNi2+Wlea5bjABwJ3SPbTD0xdJ1y8FzdL
         zpm7VApCHgjvRgcD2Ja1rKSTBmjTp77AjVg/xS6D7QMmvazABcHFVSf+1I6jYXhUzKlj
         Oic6y/Ng97OVziht+uA6b5/5z/ZJAacAJlImcYESSPyrBLsvy82wFLsZgImY7/RUoV7R
         9rsA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772813635; x=1773418435; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uHwmZaso1Kk+C6IDbrWGhxeGeRiawuc2Z1PSYKvnkCE=;
        b=l5qZ9oNxDe0julHKsve3jE5CNNyBzNsCLtV0hnzgVUqtdQoCs27Srx/lPki/d+KmbO
         9LtG33dlNLve+M61+riSfGdV/kmWI+EzhYdSeL/QWSU9AK1xgndnK3xbBaqXDAXV5jBF
         T7aJWi2xokV5kZXYaiJJc2Vxw1Z/Zwatn/hWvRlOCNTF5gRy2N2fY4MHhgmhBJXPXKZm
         AjMfh5hVAw7vvRqpqVu0FhC8/qTo51slKGP7pHSdKef/vyxxj9E1OAeEDvLUDeLn4IlS
         LgiHJYzztbDNHOlb9gk0wAUFN4EUSc+3odaGCRL7W7ZyBXy6ygvhd5185hze663EOFP4
         WwnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772813635; x=1773418435;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uHwmZaso1Kk+C6IDbrWGhxeGeRiawuc2Z1PSYKvnkCE=;
        b=uxMfsbdGJkGj5TRAanSxCLaL4VhMiCzGQfL1pYpW4AiA/RLHKo9QMcRo0th8sWwVUs
         ag95fLBOeLDdktmkl71v7y0SvFPLCLfuPiLXrC/ceyjdct9zlUesd18HmbscUahU8Sw1
         yphIxXGYsJYnrfGS/adq5POIFsshUnDviTkJJ0skHAmtZnaFxPiMIfnT8D7BZXgHwlfy
         2zkaGZ0XSgnkRJ7dtOmHhcc4yRSxTlNZVmfTRbDNZngVYCyrt7Inj7eOCDRC9R3almu1
         F0eGlL91UW5NTVHauT6sC3bshHQIKC4HfrJvRmNKmaFiygru/ZW9HS9Bku5rkrvfZIjd
         iJtA==
X-Gm-Message-State: AOJu0Yzh/q9/G5ykkxzg2VwThm7duzlq57Tc/vUEcXlLTFFODkdGmlFn
	iipwvSu+dsXmcu+woJGsD34B05zDMrln2ontBXUc7mNuCZJ0Vsr9nPNgiuqmY2cfFRwyaMBD/KU
	k+t8jcDBv0g/lu3q0wmISOv1yt3QE264=
X-Gm-Gg: ATEYQzyDRPsOrEnZU78ZPmuKJefSOFtK4pWI+GRY9xrr9p0/eol7C5WT1FKg3zgHn1t
	gcso3DM291JucKOfwuDRhgvzLIymIg/sJKSiYox/zQV7s3H3ps8cuSiebc7NfdD1FwgVhyKQEES
	r5GO1H3wXPBM6mzBUZHQWzjfQAQnIHZ/APH2CjOOmZzisah4qxUZPNOjBlUz3mHZEXEYQNmsBnN
	SZfDKLqPAXfuW/skkYqji2RwJIjwewnOQVO0243Gu6s7XCZ8U+qyyd4swzHgyuHT0ttqYD+De9q
	Y4gD3YedneSlktwaeiAcfjo2hm2lff/J0g4jHATp4CmccMOw6tA0mucy3rw=
X-Received: by 2002:a05:6000:288d:b0:437:73a2:2d4c with SMTP id
 ffacd0b85a97d-439da351b36mr4903107f8f.13.1772813635282; Fri, 06 Mar 2026
 08:13:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1772804199.git.vmalik@redhat.com> <710368d4559b13d2d82a47ef1fa7d70a9a038add.1772804200.git.vmalik@redhat.com>
In-Reply-To: <710368d4559b13d2d82a47ef1fa7d70a9a038add.1772804200.git.vmalik@redhat.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 6 Mar 2026 17:13:19 +0100
X-Gm-Features: AaiRm511jSlGoy7d7oIzaTzyx1Kq--xBVRRyzAQ6rtj9CgdbmFx6l0vXIaievMY
Message-ID: <CAP01T755yKNPa7P3iQ5w6D8-e9e3eNWiF6S-OVCAsH2o5Ct_YQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/3] bpf: Always allow fmod_ret programs on syscalls
To: Viktor Malik <vmalik@redhat.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Shuah Khan <shuah@kernel.org>, Leon Hwang <leon.hwang@linux.dev>
Content-Type: text/plain; charset="UTF-8"

On Fri, 6 Mar 2026 at 14:50, Viktor Malik <vmalik@redhat.com> wrote:
>
> fmod_ret BPF programs can only be attached to selected functions. For
> convenience, the error injection list was originally used (along with
> functions prefixed with "security_"), which contains syscalls and
> several other functions.
>
> When error injection is disabled (CONFIG_FUNCTION_ERROR_INJECTION=n),
> that list is empty and fmod_ret programs are effectively unavailable for
> most of the functions. In such a case, at least enable fmod_ret programs
> on syscalls.
>
> Signed-off-by: Viktor Malik <vmalik@redhat.com>
> ---
>

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

> [...]
