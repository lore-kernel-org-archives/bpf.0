Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D71134752F
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 20:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782245722; cv=pass; b=smkQYYEN5eiS91zQIEQH+RsDVYJiDOkH3KcPSlSdqb3jaj9eviDQDMq4iR6mvvrnfZ90AmA9zzHhE38NWk+83KzJqjB2Jjj6IcSUOvvJ9OCsYDJyzU6CQKrzB5SW4nzQHHtCRj8Qlfq+rJXiSVxbVQpj7GEAweCk9is3FqD+cTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782245722; c=relaxed/simple;
	bh=VyUN5kc8pY9zeZGfxVG9I72IM00S38DsQj8XPbrh/jY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WfphmyLMEpmYbW8SsMwFquFC+18ysh3bySKHdOG+XbkBCS3up/Vilz8Ta2Ezu2XhbOiUyx9cW3sQp6LewNOE7gXZPUNKhqGXcwisiQyODaVfuXPwLZGSxoN/R72qgmiLgixq2BjuPhkBroK2sqS1+4OTUoEuzR+lFRCT2fba9mg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GjLLGfF4; arc=pass smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GjLLGfF4"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-37c8e7c8185so208176a91.3
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 13:15:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782245720; cv=none;
        d=google.com; s=arc-20240605;
        b=j0J1uZXmuL9Lbumoqh5lXcWTUeyNHOneshgaszRw7HOJG8j1n3rZqHe2v0ysnyphPW
         L9AQUAnzy7O+jvve7g9n6bfNGSwqMxRgDDWc58ztrH6XMCbCZi8RmBhQ2l7CoEDxBU16
         KUSMmIvgk/iMFRo6mhbZSsviNkJs4P5dZt4t0jvMHYZV6z8tpJBjFEPZY51kFTMcn4cr
         J2zjmih8B3qoJD+nHN7eHE6uXln5aWaqaxdp8GfRJ60el7B96+kaF/dTaU0VLZ6qo2M4
         liLOGdvVGLetuWb/DMwAkkxS5p3u028mL4vqQcCK+Bd+owc9Cp3lQJp5zafC1X4ujZZG
         KY7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=j+Z9M3ZKDsrVtD4vMbDb1w1q1I4K+UTdIQhD7+XfBGo=;
        fh=m8bICFzORG+5bBA8erOyyJH+XDBj7WhxueYcLPZHrXo=;
        b=BvKDxGIdmmN4mvLutj+ISdSOOrSJHXy2rUF/x22JkQfd8Autl+W/PW1vevDEPk/8hl
         hQc6LWzo4wb4GpJ75J2Zma0CTz7o7kZ3gt8WrnEmr1ViLG15TOFtzxe6kfL0GyGKS7HF
         zBiifn0k96nomNFQs9q59QwNE2PisPT2ypTBOhXSnAV4vvs6DYTySAu16TwEJ0kGTN3I
         AZ+dWEneEna7GOeIi5nT5i138YsOtAmt5SHchBYARbU8OIhnLkmLpjJnFodeXkScXfOY
         rhJBh4gYdTaRyesYR3rpY5PgeMxSPaNyiXAArNEeto/Cml8LNjaRGbLBfadqAB7+qz7e
         jIuw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782245720; x=1782850520; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j+Z9M3ZKDsrVtD4vMbDb1w1q1I4K+UTdIQhD7+XfBGo=;
        b=GjLLGfF4L8j+VK+0ZoajA4d5fc7wimo/cHSiWRUdfXvZ6mN15oM3m8zKhWoXu6MM4L
         aYWtEM+Ecp6k9hFolJ+RPTzOffw6rGvPkeKXs8LV6zwpVSZsBD86dtLB0wm4x89lLXUw
         qUYtEcZ+vkWEEZ2cVGyjD+q9a2YcqUOHRtPDFQTEgcxMNjFXBcydRqaX3Hprwn/WqWAE
         THdgXuT/yQ3vFD23cKbIqm0Thby5m4fE9SjAJxBhlF8kZqItyfiXdL53gXOolhLJdikE
         f048qFRZ4tkVkRbd1TDjdR3nw0v0G/QSZcl0xYnkkChHHzPxKODs5N+CUiYkOQp4oIg+
         X0SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782245720; x=1782850520;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j+Z9M3ZKDsrVtD4vMbDb1w1q1I4K+UTdIQhD7+XfBGo=;
        b=q8MCiZGyVd6w75i4EMqQdMytZ8NoWv3nLDsIXLvSQ2t0mJjAIcvpU+nTzrjlHy9Kxq
         sL7uXyxGe8gB/ibDs8MblrTPXaGLyPPUMgkxGozx1PWDfxRAn4+bGYZoOWfwmEIQWWox
         5Ge2DZbYFnE2kw82xEGGohlc0cMahkI7ZDcHWs0wEcx9jAr0ZzsPbHxGqghtF612SZvt
         GYnDJU7bG078pjhYT6eHuUFizMRY0+dj6WvaPLVy9CPGklsmupyYlozHB1fxtWxsxlHN
         CnjGskhjjoXhky92N/55JvDsT6dObQUZFQ/hgWkwcQO1DOvfYzI47ibBRB7CyDI5D3js
         5EjQ==
X-Forwarded-Encrypted: i=1; AHgh+RoBKe6uL2XEl9TloXtUqoI+qH4EVqoFJr9vXve/FyRwXwFOlNrClV1jvgYhEjPeCK/N/HU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxDcuBXb6vtYjOY9KjSEZH6XX2Hsr7zs91XenOmh7bQg4S5K9t
	1vvKtCxl3dMzzr07I7ytNef3NKo9+eBp1gyclqksTyWz8LTHQpLWAWC5Kx9fziF0sA0t/0gUaUn
	/HhiTffld30ySA/Y7dAJSibYda3XYR3Y=
X-Gm-Gg: AfdE7ckkoudQxAEJjIQidVJats7cGfP7EdpiVA0vQOtNBanFA0z+OiHeiVYODQzT3q/
	JK1Vk2apN5gsSUGASv1yEVoAgy8akKd2zIPRLJzpCBLJzjqqYiBqianYVz2xrlN7CiFIfFTad7o
	+Mdm9KKstWNMXotq90SPwJr33aQ7+0ysuEXMf7jzWmiZYINF21d4oZ0ZjzEZAw5xPrW4yX9wlX4
	LEHJ3kE5xECACifc8ukUbD1pVwUpmv7GxaNAvqzsShso9C17M08BOcKPaNceO0so8Hn3CtF0rF8
	usSPwCIfxmqNY8nnAuzzgaQZdXG+g7gtBB0J/2TEN+Q4naVdsFddB11PFIstM8tBSkr5iA==
X-Received: by 2002:a17:902:c947:b0:2c0:c3ac:4af3 with SMTP id
 d9443c01a7336-2c7e14be9d1mr3830645ad.15.1782245720502; Tue, 23 Jun 2026
 13:15:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618-bpf-ringbuf-fixes-v2-0-33fde039ddf3@kernel.org> <20260618-bpf-ringbuf-fixes-v2-6-33fde039ddf3@kernel.org>
In-Reply-To: <20260618-bpf-ringbuf-fixes-v2-6-33fde039ddf3@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 23 Jun 2026 13:15:06 -0700
X-Gm-Features: AVVi8CfqHtnBLCweM7eX_1wpYpE6gYHvPw60CrJ-FzxF11Iv983c2apGCEnWOa8
Message-ID: <CAEf4BzattX9GherSPJ7DBeKksfxsX_uKz4y4tYNU=gUjqkJP_A@mail.gmail.com>
Subject: Re: [PATCH bpf v2 6/8] bpf: user_ringbuf: Handle position wrap
To: Tamir Duberstein <tamird@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Andrea Righi <arighi@nvidia.com>, Xu Kuohai <xukuohai@huawei.com>, 
	Andrea Righi <andrea.righi@canonical.com>, Bing-Jhong Billy Jheng <billy@starlabs.sg>, 
	David Vernet <void@manifault.com>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Andrew Werner <awerner32@gmail.com>, 
	Zvi Effron <zeffron@riotgames.com>, Andrii Nakryiko <andriin@fb.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 18, 2026 at 5:27=E2=80=AFPM Tamir Duberstein <tamird@kernel.org=
> wrote:
>
> User ring buffer positions are unsigned long counters, but
> __bpf_user_ringbuf_peek() widens them to u64 before comparing and
> subtracting them. On 32-bit systems, producer_pos wrapping below
> consumer_pos therefore appears to move backwards and permanently stalls
> the ring. The widened subtraction can also bypass the advertised-window
> check.
>
> Keep the positions word-sized and derive the available data with
> word-sized subtraction so the arithmetic wraps with the counters. Treat
> a zero span as empty and reject spans larger than the ring before
> reading a record header.
>
> Fixes: 205715673844 ("bpf: Add bpf_user_ringbuf_drain() helper")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/bpf/20260614020552.022A11F000E9@smtp.kern=
el.org/
> Assisted-by: Codex:gpt-5.5
> Signed-off-by: Tamir Duberstein <tamird@kernel.org>
> ---
>  kernel/bpf/ringbuf.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
> index 909880031fd3..19cbb9b74ee7 100644
> --- a/kernel/bpf/ringbuf.c
> +++ b/kernel/bpf/ringbuf.c
> @@ -748,9 +748,9 @@ const struct bpf_func_proto bpf_ringbuf_discard_dynpt=
r_proto =3D {
>
>  static int __bpf_user_ringbuf_peek(struct bpf_ringbuf *rb, void **sample=
, u32 *size)
>  {
> +       unsigned long avail, cons_pos, prod_pos;
>         int err;
>         u32 hdr_len, sample_len, total_len, flags, *hdr;
> -       u64 cons_pos, prod_pos;
>
>         /* Synchronizes with smp_store_release() in user-space producer. =
*/
>         prod_pos =3D smp_load_acquire(&rb->producer_pos);
> @@ -759,8 +759,11 @@ static int __bpf_user_ringbuf_peek(struct bpf_ringbu=
f *rb, void **sample, u32 *s
>
>         /* Synchronizes with smp_store_release() in __bpf_user_ringbuf_sa=
mple_release() */
>         cons_pos =3D smp_load_acquire(&rb->consumer_pos);
> -       if (cons_pos >=3D prod_pos)
> +       avail =3D prod_pos - cons_pos;
> +       if (!avail)
>                 return -ENODATA;
> +       if (avail > ringbuf_total_data_sz(rb))
> +               return -EINVAL;

hm, should we use long and then replace cons_pos >=3D prod_pos checks
with `cons_pos - prod_pos >=3D 0`, this will handle wrap correctly

>
>         hdr =3D (u32 *)((uintptr_t)rb->data + (uintptr_t)(cons_pos & rb->=
mask));
>         /* Synchronizes with smp_store_release() in user-space producer. =
*/
> @@ -770,7 +773,7 @@ static int __bpf_user_ringbuf_peek(struct bpf_ringbuf=
 *rb, void **sample, u32 *s
>         total_len =3D round_up(sample_len + BPF_RINGBUF_HDR_SZ, 8);
>
>         /* The sample must fit within the region advertised by the produc=
er position. */
> -       if (total_len > prod_pos - cons_pos)
> +       if (total_len > avail)
>                 return -EINVAL;
>
>         /* The sample must fit within the data region of the ring buffer.=
 */
>
> --
> 2.55.0.rc0.159.gbe5d7338c2
>
