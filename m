Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974243D6460
	for <bpf@vger.kernel.org>; Wed,  4 Feb 2026 19:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770234535; cv=pass; b=NIKDI1d3yPaFsBbxjMDBSRRp9b6LEUoAOG2MguRbbDAiHcJeOW61cyBsF8baaSg3k5Qktknn9dRv4VD6aTKv/Nxgn+2PKmz+L1l6UK59HTvZA2yjZcxw8Ui7ttSsgcCNUrw/oywHMTc7r2QJU94kScyjT+qTPFfLTEXutdiMXiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770234535; c=relaxed/simple;
	bh=bSIrMjvVryS3QuF3cPDJgDoly4qpEwj7FUTfJRKsTHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R5YtRnT0v9KfWjI8RTvtt14ijsItqJCXWbl9WTd9INDzuGz+UgdJhpdX2PfHYfx/XxvNmPNvnOAmuuogzgkj+RaE6AoS5ATgJY3mRQuwQ+1S3a6nuQNfl8d+g5wr9dc9QJYXb8AeVXTia4nDVeJ+xB3IuoVltypyXtUyhWadxLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TnHVWCsR; arc=pass smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TnHVWCsR"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-352e2c59264so52118a91.0
        for <bpf@vger.kernel.org>; Wed, 04 Feb 2026 11:48:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770234535; cv=none;
        d=google.com; s=arc-20240605;
        b=aO4NmTp/r0IX+aaKY7LB9c6EIwUFQwn9UhfiWkazgyt/0iXAU0DuqmrwRGsYWrtQbF
         hMaIm2CHV7z+j0K9sA5Fg2ZLpqqGQVSv1LF3zC6yYgmtJYA9AuIDl09HWd3JVB473KKW
         522oGMNH4JGMGm1Zq9FnpnjSkYDjXTWaIQn/+zmtIJAtF/q0oHI772Do8nmp2DaPHkpP
         KqevDDS70G4PVwRZDjTsoy1oBDd/REtNdGgb/dUU1wt0JN9UxBbOVZ/0NufCXgoTAYTS
         M2tX9K0NcuUtLRSlj9EVFBCxY+U/mjJS/HPW0nBgUyXxbYY2oTdv1boeBZaGLkFDCR9I
         mIpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MhxIQ4idA8yZgMj8bntXp33AUjuSpj6i0GkwuCvW47c=;
        fh=iyIh3tiaN/pTCZHwzDN2Emw2Zfr0RZtTUCw7DgIPD2U=;
        b=AIr25sHk1LmMxPTE1h7nhxhe14VJ/mf64bDbtLiYQ9/U43uErKD6o/8ZVyUuJzwvAI
         sjobe/hTvG/dk0HhETdfY9PKLzmfbUmuGAEkyJef4Ujdyzx4x6vb9vhWUmL3EAWak5Qy
         mpVwRPxaYMJh/mhltVYuxnJguErPfg/imyLIRM0iRTgAe04CajM2nv5OvUxROxxJbcCv
         PBdqazQGp7KXN5c0aPc+lsF7jdNJ2yM4X1jc/UWiFoU5r2MbKPD/kZjfkh0Wv+xO5rnC
         X707+FMOzq8KMyQ3csBVkesf1vDMFkGVN5124hJeN/9I5wBWDs7fddolP7nF8x1Vnqci
         e3wg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770234535; x=1770839335; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MhxIQ4idA8yZgMj8bntXp33AUjuSpj6i0GkwuCvW47c=;
        b=TnHVWCsRX5CuO4JStAQwX9v1LRMLvYS4IZ0izbBLMbh08SU0RpvFQ30w4lAnaiS04H
         gpWmHtyvk2ZSPTKJV5k0FWbOZwbL2aEWRWMWRrdKbJw/WvtVMxunDgQ184sqPyeVAfqF
         NpYlL41FpyFwtnFq2HIADB7oYkA0iLNEBEbNmgNEm9II6NH0nMSMzOuXy0ifosmoUoQs
         0OZAaCKfD4F/XY1dTLgGtoP7nlZtjnEYjsJEkNDlpHB37DAK8Hok+zdZK+CX4DVNWWNw
         zkNXLw/VLiHk3i+Qx6Ysd1raLdeR1kQr6eQ0D0C+zwoqm/i48nQ3hYou1Px5f63qdrnx
         bWZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770234535; x=1770839335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MhxIQ4idA8yZgMj8bntXp33AUjuSpj6i0GkwuCvW47c=;
        b=BDVRldKZCck26BKgF8wzy0XwUooY2Tj5KMZWd+9Ul4hL/niIdvfm67sqQOG/mAq+th
         By56hYbRDIcDICSQVpLWaEdmME3ffT58RA79uZOxdR7ALgwT1i9+b6VbHBUixhQqJD2D
         LTi26DawRDAfOQLbzkshZ4hCi8cWRBYzqfcuvpohTSjTs5Xhokdf53cNEnvUA/m08HU5
         clCKnT547SA8SKbdbGr66nKdyVi7LxWh9xE6mf9pWWq0LxXnRVpBaDx+7vf2hp8Yn5fq
         6aErcQl9KWfMllJ+1L1n+scL8wwgTLMzcawlfh0xj8R7QfbZFCO4eYz+KD+bKNu0vrum
         J+hA==
X-Gm-Message-State: AOJu0YyZlSj1G1Q3sXDJ6boknJwGtLACqtJYtr9FQ1ztsz5M/jkafJ0e
	9WoxaQKy4YQG8ZRgcDoRy6RYNRp0cWzTpnQcznQdIMm1Cw0CBQ2ktqliLuCapaRVXBoCdDA+YHY
	/Eb1xxAfGEJqC8J9Xn+wkV3VQnnmXouU=
X-Gm-Gg: AZuq6aL4H0RIV/ow0Ao9LtgcGlZTSXGRzFPct67Q+5gnRbOsXBUq5FSbCSrQn7G+ATb
	dHLeeDHfxUS9Nx14yHFXYaXw4o4GeDWICCkvpQ69MXFDml0SVjm101Jkues1JiyL2rwz3hjv8Cd
	y+YzmroR9p9sG6aN5MXfXLzCc/gJ5oRe5qeA0ZmoF6nicVt1i5kU+Mxz7uGPk7M0zd+h9MBhq3/
	xHZXmt1tpwuNxKIxTRONh5+LX8IvFoDAXWzhgsK6/VCXvQlsIamQmLfWe+N508er7slRkDEZpQa
	GeEtyXhvq14=
X-Received: by 2002:a17:90b:3f45:b0:340:a1a8:eb87 with SMTP id
 98e67ed59e1d1-354871f13dfmr3876158a91.35.1770234535011; Wed, 04 Feb 2026
 11:48:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202144046.30651-1-leon.hwang@linux.dev> <20260202144046.30651-3-leon.hwang@linux.dev>
In-Reply-To: <20260202144046.30651-3-leon.hwang@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 4 Feb 2026 11:48:39 -0800
X-Gm-Features: AZwV_QidYTjvoEYC0f1oARTkbpeV2p90PM7rVpmH2nsmMkKOPAJuwbUzYyRsbSk
Message-ID: <CAEf4BzZ7Sa2dAUyw5kjaLiwtr7q4_H97uTpb2bsbqFuiy153fg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 2/9] libbpf: Add support for extended bpf syscall
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

On Mon, Feb 2, 2026 at 6:41=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> wr=
ote:
>
> To support the extended BPF syscall introduced in the previous commit,
> introduce the following internal APIs:
>
> * 'sys_bpf_ext()'
> * 'sys_bpf_ext_fd()'
>   They wrap the raw 'syscall()' interface to support passing extended
>   attributes.
> * 'probe_sys_bpf_ext()'
>   Check whether current kernel supports the BPF syscall common attributes=
.
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  tools/lib/bpf/bpf.c             | 36 +++++++++++++++++++++++++++++++++
>  tools/lib/bpf/features.c        |  8 ++++++++
>  tools/lib/bpf/libbpf_internal.h |  3 +++
>  3 files changed, 47 insertions(+)
>

LGTM

Acked-by: Andrii Nakryiko <andrii@kernel.org>

[...]
