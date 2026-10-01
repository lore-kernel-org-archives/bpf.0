Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E7428CF4A;
	Thu,  1 Oct 2026 04:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790828675; cv=none; b=dxa88Ms6A++w6cCxnWQ8CMyNEaquiCw1Vvj+Wxc5ABwJkH2m/B9EmOI+GU/i3LLRgBReOLp6vuWcoaf4RKxygMPeyU7PYkPwi+4HlBvnXxLhTdt+SsII7OepCZybeuwRZbV4B3x5vCtNnb4iq1Q/BWssjmyw7YT7Me3BUh7sQR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790828675; c=relaxed/simple;
	bh=O71I7Sd+UVgF+ricRHOXozqdt+rTYHriJWMGJ39H0lo=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=mY/oSAJuBUbjlt6icPERlvknxKJnV1eFdxz1sVQzjesYlhRgRUl6hpg2sVrcrnQR3+RlNCoFnvvqwbSRdlqwWQWLeZqnF3s1U0CeLoJd8rsQrVVfIPudhP5IjT0WoZoQIxo71Slaf59Ka3CbltrOQOpOf92QOpVWmL7Vuqx2npg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=blQvsOzI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="blQvsOzI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF84A1F00899;
	Thu,  1 Oct 2026 04:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790828673;
	bh=WsfUU+gE2evcY+s7/YBmSj0bnF8yeYgv9vmgU5mDu+U=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=blQvsOzI67O9A2yZLm8jpSFzvqmim9KtOw9HFtRhVKc0ykLp+72iwyD+f61Pn91OT
	 qs6OgQ+mEl3qGnJei4P2V3dn6qaWUvOBc0E+2vPRe4GtzYwA9aP14PLBltA96YCEiI
	 3M61dbJsXn+jOHC1oSBGskWGRtkEXdyauSLSVyZZv2GUsiFt4lA9dryAe1GmGxI7zc
	 PKfUJGH6rYkWIVrmuZengGzqqQloXAC83eHnIJW+RxPTQ5V6BdrDGGn7t9QawIXU8S
	 qkXwP2U06ZTFgQbWXJh47vvuM59/giuMfRAg5fVJydBDOiOV2dLky1OvV/9etB+ppS
	 fqzwQorUoR5pw==
Content-Type: multipart/mixed; boundary="===============0581563529611211921=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <949432be604253c161dcc398a00cb8268d0f0781e9a8566064d855fa9478918a@mail.kernel.org>
In-Reply-To: <20261001-libbpf-btf-enodata-fix-v2-1-89f6e8a0240e@gmail.com>
References: <20261001-libbpf-btf-enodata-fix-v2-1-89f6e8a0240e@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] libbpf: Fix struct and union zero detection in BTF dumper
From: bot+bpf-ci@kernel.org
To: luisflavieira@gmail.com,andrii@kernel.org,eddyz87@gmail.com,ihor.solodrai@linux.dev,ast@kernel.org,daniel@iogearbox.net,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,shuah@kernel.org
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,luisflavieira@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu,  1 Oct 2026 04:24:32 +0000 (UTC)

--===============0581563529611211921==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> libbpf: Fix struct and union zero detection in BTF dumper

TL;DR:
- Fix may read past the buffer end when dumping a truncated struct, since
  later members are now scanned unbounded
- Missing Fixes: tag

>     libbpf: Fix struct and union zero detection in BTF dumper
>
>     btf_dump_type_data_check_zero() uses -ENODATA to indicate that a value
>     is zero. The array path handles this sentinel correctly, but the struct
>     and union path compares the return value against positive ENODATA.
>
>     As a result, the member loop returns after examining its first member.
>     A nested struct or union whose first member is zero can therefore be
>     treated as entirely zero even when a later member is non-zero.
>
>     Compare against -ENODATA so zero members are skipped while looking for
>     a non-zero member.
>
>     Signed-off-by: Luis Vieira <luisflavieira@gmail.com>

This looks like a bug fix, but there is no Fixes: tag.  The faulty
"if (err != ENODATA)" comparison came in with the original typed data
dumper support.  Should this include:

  Fixes: 920d16af9b42 ("libbpf: BTF dumper support for typed data")

> diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
> --- a/tools/lib/bpf/btf_dump.c
> +++ b/tools/lib/bpf/btf_dump.c

[ ... ]

> @@ -2564,7 +2564,7 @@ static int btf_dump_type_data_check_zero(struct btf_dump *d,
>  			bit_sz = btf_member_bitfield_size(t, i);
>  			err = btf_dump_type_data_check_zero(d, mtype, m->type, data + moffset / 8,
>  							    moffset % 8, bit_sz);
> -			if (err != ENODATA)
> +			if (err != -ENODATA)
>  				return err;
>  		}
>  		return -ENODATA;

Can this now read past the end of the caller's buffer when data_sz is
smaller than the type?

btf_dump_type_data_check_overflow() only bounds-checks base types and skips
structs, unions and arrays, so a truncated struct still reaches
btf_dump_type_data_check_zero().  Before this change the member loop
returned after the first member.  With -ENODATA, the loop proceeds to later
members, and the base type checks they reach never compare against
d->typed_dump->data_end:

  btf_dump_base_type_check_zero() does memcmp(data, bytecmp, nr_bytes)
  btf_dump_get_enum_value() dereferences data directly

For example, with:

  struct outer { int a; struct inner { int x; int y; } s; };

and btf_dump__dump_type_data(d, outer_id, buf, 8, &opts) using an 8 byte
buf, a != 0 and s.x == 0:

  btf_dump_struct_data()
    btf_dump_dump_type_data(s)
      btf_dump_type_data_check_overflow(s)   /* no bounds check for STRUCT */
      btf_dump_type_data_check_zero(s)
        x is zero, returns -ENODATA, loop continues
        y: btf_dump_base_type_check_zero() reads 4 bytes at data + 8,
           which is data_end

The outcome then depends on bytes beyond the buffer.  If they are non-zero,
the struct is treated as non-zero and the later y member fails with -E2BIG.
If they are zero, the struct is skipped and the call succeeds with the
truncated data.

The array branch has the same unbounded scan, but the comment on
TEST_BTF_DUMP_DATA_OVER says overflow checking should trump "is field
zero?" checks.  Should the member checks in this path be bounded by
data_end?

I don't see a later patch in this series that addresses this.  The
follow-up selftest commit (f1b0479c0af4) only exercises a full-size buffer.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36812677691
--===============0581563529611211921==--
