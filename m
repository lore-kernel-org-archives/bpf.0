Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704C4322A3F
	for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 22:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770847890; cv=pass; b=I1XbayrGhtdBJIjtymAez7nVCz4IugIlw6fqkk2fJ6AWMS+w2r42R5JVPZmFRegzP8CZvI1eyfqU5EkmeKLSN7u0U30gWvgbQtMUziPiHs1DcUtgggzGzdb6rCOKOZ63tns4ma+moM2GUG3QCew9IvMpGMRYzUtr/U53dWzS0Oc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770847890; c=relaxed/simple;
	bh=JiSSwWSerMjJ0lnCuuErFYRTqBQvNbw9BigQz83PYg0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VZ5JnqmSDO+XSKH8Eu+XQquLYVD0Jogo7NCFiXO//ZXWuF1G+6ulv12HN1w45ql0XPVPvgcR6Iy1nAjkBcc53sFOWMHh+7W6gS5krU2ML1E4tT447Z2ncWfCHVdBI/XDsR7/OwQdmgd51b5+xm10I73rQWKK59l0LGB7uiVadFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R8NpOVMi; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8NpOVMi"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2a871c8b171so14224535ad.3
        for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 14:11:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770847888; cv=none;
        d=google.com; s=arc-20240605;
        b=O2UYn85Oh9W/BPc6UPpUMq58j38RhuSdPh0tZ3KoOooHK6dRmDvNpPWSF1dR7/l8n/
         s8IksV5bEsS+wrq10pEWpKohwJumvBu9X0hbmMNK0OdJk1NSDphgSCWNWP9eVciJoCmr
         MUB+qHSvbY6zlEHLGFZsOhXmhDFJldEKBVWBhJvZXLfIOZaBJsfPPNTGstySYZG7oIch
         xa6qL/8VkGRF5RoY66s/5Q7kI6dUbQIN4B/1ToYu+AavNOq14Te616au5McoPeRbyuTm
         qnouBnjcGuBBSvINrJG98d47B628/SJt+Hnfcjy5gVrep6VCOEjv5t4WYzTJkK8iuWxf
         qSDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=s3YLj4yo1hdeJHDtsmSn5m8ezeqMhDQtpYJhbUhzSCs=;
        fh=iyIh3tiaN/pTCZHwzDN2Emw2Zfr0RZtTUCw7DgIPD2U=;
        b=Aq7Ae3HBc06+W+o2Bpo9STNTj4wuYtfgjmUZYaUHnRLDv3aIPp83b+GmZfvSeBOI7s
         dz+hHFY7FJq9u2ByCE/tfK1atLCWOi5Nd4c7KpWdErBH1gdZRJQHrxqUep9Qea16ucVs
         qAelEIbNOVH+i/a2IStQWgRc507TNRcXhFYL8Ykb9SREA4m8XSKw5IRtuAensKMX4A3l
         9p91qn1WotcveSL32n7gRRGCYL70wEGIBhuVe/CNovTFWJC5tK8LNqCqJzqaOtVkbX4O
         2fxLGFmT6ELgYPT9jieO3Pw3vxDXRayzT7Q+IqH/nx5LtJV4jKVjO7ILkpqQH0tpzxCR
         djjQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770847888; x=1771452688; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s3YLj4yo1hdeJHDtsmSn5m8ezeqMhDQtpYJhbUhzSCs=;
        b=R8NpOVMiMcQX0I2yd5Hb/YdZiM01zGM4AZmbXy6oaymYPCBBuVcX1C7K48P+y18yjY
         5XHaiMojiKY8Q5YY6hW4d5H05j487AphhFrV55zXO+BYZF0hiTRvZnD6r/DZoWYukvkU
         ByM2uW0uJ9CUEjehdjZGmu0fuSPQqCKVdUqjjRnVazoOjdPQoVLlgmGU6lScb1YnHOhF
         dv0VcCVT6tTDgOAz+oWqYMsdBtBWUDnyM5gSmJz3BcxK84/a4tIdGVCSUVd+ShQf9kbA
         2kNBlxx1e2NAFOR1iDW2mDAfly6cgC+P74oW/jlBhltosgkBf8JA96RxF9YE1JzXk6YP
         oCyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770847888; x=1771452688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s3YLj4yo1hdeJHDtsmSn5m8ezeqMhDQtpYJhbUhzSCs=;
        b=DK97klK6sSRY421SOyN0Sfte2kZynyelSrB3prFoYp6ivY2iRjvp6WV3eXyE+k8kHJ
         lZmQIORlIJTQ6dgO9EGDwHG2QLMt0bektcV5K2xkrCso499kNpos7VpX3X0fVkRUVYVV
         4XDTx8JiqKY0s5hhy+nvkw58WBeHgtX2fktSLRgOcVUncmAZZukzqqf4T6p+avE2o5ya
         PiIUViw6Id11mgBYP5QezSODBCC+NWHsMi7QeCzejobQ4Pmh98Kld6PLyS6ukTNHUJ+9
         PM/GfdaBu8sIC9sW4HXMnsysRlE/wR0vI1mO+vLpfrx6Xq1vmWkRrNGOROiRhFVJF+Mv
         BlYA==
X-Gm-Message-State: AOJu0Yy1Pyqio8qe/RwEaQeTzNwyD92rEQvqFjJ9PW0yhZsDvWBb+EAj
	JCJLyBzHRUAxxxdcvlY9KoYIEAE+qIZKWp9Tz5yue9FKGn0Z/c92S7NYmbn/4UTXuiQaIhls9/a
	ENlkbgqmhOKBmKAGQlZ0BhPqLUB9m+vA=
X-Gm-Gg: AZuq6aKnnQRf6pMTyYhgWo5aXQqareq7L1Uq2jVEnU9eFMK14BWQ4v/9/T1LMk+4ooY
	lrOSyAt4qbjLu3aYB+2kTM28E4Oz4bP6tJTupySQZo0yuXZYH6xX8k4mHI1oBawG+q6qHbvqrrc
	ON3PgEYpdecBTH+xkS3RfP88iNVNiPmelJrhIucPNpowY7V+8kS/tkJUkn9K9jHl/fw6uu39Oth
	+zHCGNoA2FdUhcy4/b3Fe/8uLCgcHNtiZExUtVnXRjJizyor1JptKik9xZ/G6MknemcjudSjYjt
	VI++TKFSosT+qBducH7FmZg=
X-Received: by 2002:a17:902:e845:b0:2a9:634d:de98 with SMTP id
 d9443c01a7336-2ab3b1a7943mr1909285ad.23.1770847887796; Wed, 11 Feb 2026
 14:11:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260211151115.78013-1-leon.hwang@linux.dev> <20260211151115.78013-6-leon.hwang@linux.dev>
In-Reply-To: <20260211151115.78013-6-leon.hwang@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 11 Feb 2026 14:11:15 -0800
X-Gm-Features: AZwV_QhJt1PQFJH8kXPiKEX8G0i2EkGRQG9mZq9x-DDfQaPpKPgqIRSO-GyXGqY
Message-ID: <CAEf4BzY3GA+860RODLaXqqO3j5AgJ24pmKU1yv3+gHJpy0DvNA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 5/8] bpf: Add syscall common attributes
 support for btf_load
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Seth Forshee <sforshee@kernel.org>, Yuichiro Tsuji <yuichtsu@amazon.com>, 
	Andrey Albershteyn <aalbersh@redhat.com>, Willem de Bruijn <willemb@google.com>, 
	Jason Xing <kerneljasonxing@gmail.com>, Tao Chen <chen.dylane@linux.dev>, 
	Mykyta Yatsenko <yatsenko@meta.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Anton Protopopov <a.s.protopopov@gmail.com>, Amery Hung <ameryhung@gmail.com>, 
	Rong Tao <rongtao@cestc.cn>, linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 11, 2026 at 7:13=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> BPF_BTF_LOAD can now take log parameters from both union bpf_attr and
> struct bpf_common_attr, with the same merge rules as BPF_PROG_LOAD:
>
> - if both sides provide a complete log tuple (buf/size/level) and they
>   match, use it;
> - if only one side provides log parameters, use that one;
> - if both sides provide complete tuples but they differ, return -EINVAL.
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  include/linux/btf.h  |  3 ++-
>  kernel/bpf/btf.c     | 30 +++++++-----------------------
>  kernel/bpf/syscall.c | 11 ++++++++---
>  3 files changed, 17 insertions(+), 27 deletions(-)
>

same remark about user space only log_true_size, but overall LGTM

Acked-by: Andrii Nakryiko <andrii@kernel.org>

[...]
