Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D4D3D7D83
	for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 23:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772233929; cv=pass; b=tr1iQHQkn1eM5u1n5M9EDWTB1QqxSD6IsYr4XIW1dnjQsApDDJxL9EoNF/KkUt+wZ6KHKsoz+8ZfpziSSzgn53pilwY9GU/Gd8qjzBuz9yH8l8kEwYhFe4z1/ia06WZ6pfcdFzZ3L1mEn10QEG/o5MDO8+HPQufEav5xTmkvHfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772233929; c=relaxed/simple;
	bh=V5qCzTsaOJWbI8bIApMpk9pkO68rB+P9FzJgy77rz7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=riDywcYCfgq3HVoqLrYiLjrua91HbN7xymGSmOW9Ms7wVE6MG98spZlhSvtfdG4YGJ9BxEPXArkpp/7Y+TReArWzslyyY6Q5z3EzMDp3LNORM2Fv43WOaxNEpP1A6GWyc8YU8bxh0M9+c1BrwJr0TMs1hbyuOFQ6tL8DYmRNBO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dkq7OMed; arc=pass smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dkq7OMed"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-483a2338616so15878335e9.0
        for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 15:12:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772233927; cv=none;
        d=google.com; s=arc-20240605;
        b=b8c4W4pApxZOwpEgycViINuCXnzPb6rxQ89H8t4ZCYPnYBT4ftM2RaOY3KtjKV7l6l
         kWtHPzwsv9h5nVyS6IrOk/DJm66cnKC1PCYlbmKFhc+vR8AIhkqtdmyyxzNt2dAgdK5p
         Rhv0yKrHgS/NmHzdgyVSvRbvF1MX0WtRgklQkv0ETumXz6FVpR0ZdpFQEmc6Pi2r9tYe
         yWmhA0paYfUr5NW2AkoDGbaKVHUXAZ44q5W/Td6nNIqt4Xv+hHEmMi8If5AXTbtAfoa8
         FYlGCqaFIiTAhKGjXxBy8aiqB1izS5MQVKJ8IlLfuOzKkGlR1YlGjHNy+z3HTO4pVdmx
         ABPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cfiGTap6WKsl2m5t2cK3AsLCB7wpzSkIUOVFSYi5LCE=;
        fh=kuxYuv+1Ou0MeIkbAsqhNiABWTLb607EiKHN1bGUL08=;
        b=UThR/gWmjlzojNNpTQJza/a8YJicBlJ17CkKVkgFZeALvu1iWMC1GfnW1ukxqwFgMP
         odkE6VvqQeAvZLVoSvZ6OwuIx6/9KvY7+dUdYHL//00M1qHhUoXazofDKSUYcLqWaFy/
         D4tEA85ZXfT8g24quYQa+jhr/Zn0Jsql5RyIJ/Ow3FlIYackMkWZ0lxAcrXujKHLuu/A
         2IhDOcfbShTEU4XgmKaBCJYqcTECWE+0tJi/RgtLRRfcCBgGg65dJo8lM/gqaWf0FFhL
         opITk735v139K/XbYMQAXw7taYELYKwxlxrnQrJMPd/ATcRK5bYZY1r6Qk/KyXC+MmsH
         xnXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772233927; x=1772838727; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cfiGTap6WKsl2m5t2cK3AsLCB7wpzSkIUOVFSYi5LCE=;
        b=dkq7OMedQy//LIJK+gYkjWnwFgfZy6eJgW+ok36WuYjM/Ea1VUoYSSDLbIs7qiNbY0
         UKj1OaBixaUysc+L3MQC/QkeX7LRyO6+wNSlcAI7Z5MgM7NDMSVdW1S7tEbsNbx028I3
         QCRTac/lWoq1ib5KokF0DWNgRsaA7Obz0y32tKkk9kx2Z6DmBtZen1sRMNlmvLdReDdx
         qd/8ffDphR9hE7UeV7IqPGiIEshLqMZeCN20Tq+yU5ZEx719d+xRRmGSLQ6CoPsNKIil
         0Tv+ocFWvkpEnHfNBXbo9M0CQeDTrrusL8QPVYvstCubAMQPCNJiv396oiXoSJWwy26x
         +MGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772233927; x=1772838727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cfiGTap6WKsl2m5t2cK3AsLCB7wpzSkIUOVFSYi5LCE=;
        b=inl+I4p9lUa8xG/ga1wlNPdg51i00PXGEvL2Ca0IUSjSh2BnCsegoR6oceBaEf9jG0
         KS96D65DW1w58u9Xylc/GmT8zdZMWBp9z4xQO5QFvq6qiP/4cOLU860161dGyzw+Cl8E
         YlndNqP0B6qyHLVhnAI2mRKMD7faX+y9UAF7eI9JOqOZ3c9UkiUVP/kvJ2sHCz2YNBJj
         eyw+9eVFeBJrD69Ji5o9iSuDxc8LBGlHruigkbNT/sM1SW4dramKgIuzCRK+ihYPHXHN
         fnt0wvOq29G7T3GprqqjZbVmkO0tGqCuU0BkxEMw5WU1+8Lcsl9Su/R/LoLoBCrTDF11
         N/dg==
X-Forwarded-Encrypted: i=1; AJvYcCUN8UXm1AM3HIoQWKxGX9IZnymHxgc6LWnxx8X5A7sMcaYuo+ipJr4rkfDqvfpuYeHbcgU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW+p79z/y31HJZXRoWeoKszeVlpblETPyhDdo6QBf9BVT85AIw
	/XCZkn3oHS71dBpBxuHi5Pf0P6daLdEpLY+1AaGRrOaj1LiYsRMZ1Nw2yyADqJw6AFMi7l1j94F
	VtWx49+Vbfa5WVDWgAyq/lqzLHRKowPY=
X-Gm-Gg: ATEYQzyixrDkkN9YBXNS4JtJ5YbPyo6r+rkcLtGxuk2VPurHD6KdUwJgesoAFq9Smi5
	OjfMOZIL1jmDRNc0U3E6afyXkKc1RuxPSBeOZKsjyGsPpr4/PYLlWgMJ5B2z6br91oZvPwMz9cv
	ICTR7qeM7AS7o7s57zlusJvBh8ub8abtS9RREEXM83kMr1GN6i54Ny4xFtxm6TKXIoYS3OX7/4Y
	kXajp9PK2zMrFWvPUw1Fb4syEkyz6eR+RYnT1/7jUGHW8m89WDJeazEYuqBQIuR9Ph0O997H5KJ
	/19brmlOjFJWwMYGYkiLR6sgOB0QjRtcPBJcXr0hykM4ofEq0cL5+AACnWhLxznWCV39rW7jnai
	PTUH5dvfZ1dy9uA5517TqjsbBn8KTIjpwR+I2
X-Received: by 2002:a05:600c:1f91:b0:477:8985:4036 with SMTP id
 5b1f17b1804b1-483c9ba7dffmr77716515e9.1.1772233926427; Fri, 27 Feb 2026
 15:12:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227100426.2585191-1-alan.maguire@oracle.com> <20260227100426.2585191-5-alan.maguire@oracle.com>
In-Reply-To: <20260227100426.2585191-5-alan.maguire@oracle.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 27 Feb 2026 15:11:54 -0800
X-Gm-Features: AaiRm51KCOJfLdsYm1FFkILb08m0Ill72NSzmMEkye0mgAEcVQ0oJxnYCifdQqI
Message-ID: <CAADnVQ+xtkQ1hDpwg+RiUaxdwQHZbtW-PjuqTrob3xEVNEY1vQ@mail.gmail.com>
Subject: Re: [PATCH v10 bpf-next 04/10] libbpf: Add layout encoding support
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Quentin Monnet <qmo@kernel.org>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, dwarves <dwarves@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 27, 2026 at 2:05=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> Support encoding of BTF layout data via btf__new_empty_opts().
>
> Current supported opts are base_btf and add_layout.
>
> Layout information is maintained in btf.c in the layouts[] array;
> when BTF is created with the add_layout option it represents the
> current view of supported BTF kinds.
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  tools/lib/bpf/btf.c      | 62 ++++++++++++++++++++++++++++++++++++++--
>  tools/lib/bpf/btf.h      | 20 +++++++++++++
>  tools/lib/bpf/libbpf.map |  1 +
>  3 files changed, 80 insertions(+), 3 deletions(-)
>
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index db13c15a0049..0c7fc0b49f20 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -29,6 +29,35 @@
>
>  static struct btf_type btf_void;
>
> +/* Describe how kinds are laid out; some have a singular element followi=
ng the "struct btf_type",
> + * some have BTF_INFO_VLEN(t->info) elements.  Specify sizes for both.  =
Flags are currently unused.
> + * Kind layout can be optionally added to the BTF representation in a de=
dicated section to
> + * facilitate parsing.  New kinds must be added here.
> + */

Pls use proper kernel comment style in any new code.
