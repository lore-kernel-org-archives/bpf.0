Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61157356741
	for <bpf@vger.kernel.org>; Sun, 23 Aug 2026 14:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787495352; cv=none; b=HHLcUh1Y3VUg8Ojh9u0X62F+uhWufksy8jTZXZeQM4Q8XZprkSVQ+xkiKM9ElcPjMrbIkj1gtE4XTUWYUkRCeO+BESRjz760v7oxVUXjGaf1MoCsaAtWXf8PPkr7RdX49FR2aeot+Q7GezH8XigNSPyV0TZQnA29i/kkSd42d5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787495352; c=relaxed/simple;
	bh=r1xVGRXwpmbMxCxLR+XcMrQkazs0kCN2vlqQd2Hbun4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bc5TEog9SjmUpDtsMuLJIJKrmWJ5tB03TTI3BGL+p/b5R6jeAyZ9+AyNwgSZr8ineFXEqAbziq2FvHqMLwHRKiPpRyI1PsndzrZeDGiKeoENeuTiXGzE+24kym7Pin07OisJiCp/SVk2LKyl1eRPl+1PBSSBh935jTTP1xAtu3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GLULyd36; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GLULyd36"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE76B1F000E9;
	Sun, 23 Aug 2026 14:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787495351;
	bh=yhvpUjhsaYKlcOYuPLtxmAp0t1nTI5LQMt4Nt0PzlJA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GLULyd36aJKqKIX2Kto5mOCSBtGJyP4ZLoZg+YtP+ecRhhcHfUonhc6z3RARC71z5
	 740vAs5zgTdtYgAtC7nYMUsWM9MH28760tDwiXCgUqka4NBgWLRl2JkvtE7LfY0iXx
	 bKSME7TpW+6cv6n9X86sseupD7MMkd4HwWvmy45YChaeOCy+6qf+83APG0Kofs1JcZ
	 Z2xN19tzPQ8HYF6XBy7QyG5o95kAo4aGFZMjtIHz15H+qPTgMmE4VjU0ecqpwSf6tG
	 QUD8eI7PRKQFy8cGXey8bC1avrGoElrUDtep967JOMleCyk5b+0qng0Lnc+AoXkglH
	 bfxqNHiUOimjQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 3/5] bpf: return partial progress from
 bpf_stream_read on fault
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jianlin Shi" <shijianlin11@foxmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <7668c5838c6beafeea719df8d55319e2fe08cfef.1787492521.git.shijianlin11@foxmail.com>
References: <cover.1787492521.git.shijianlin11@foxmail.com>
 <7668c5838c6beafeea719df8d55319e2fe08cfef.1787492521.git.shijianlin11@foxmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 23 Aug 2026 14:29:10 +0000
Message-Id: <20260823142910.CE76B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The length parameter passed from userspace is cast from an unsigne=
d 32-bit integer to a signed integer, allowing negative values that bypass =
bounds checks and result in massive out-of-bounds reads via `copy_to_user()=
`.
--

--- Patch [3]: [PATCH bpf-next v4 3/5] bpf: return partial progress from bp=
f_stream_read on fault ---
commit 4510393da76186ad876fa17b3e2eb0055506983a
Author: Jianlin Shi <shijianlin11@foxmail.com>

bpf: return partial progress from bpf_stream_read on fault

bpf_stream_read() pops and frees stream elements after a successful
copy_to_user(). If a later copy_to_user() fails, it currently restores
only the current element's consumed_len and returns -EFAULT, hiding
bytes already delivered to userspace and making the consumed data
unrecoverable on retry.

> diff --git a/kernel/bpf/stream.c b/kernel/bpf/stream.c
> index a36fc93389677..09471a6052682 100644
> --- a/kernel/bpf/stream.c
> +++ b/kernel/bpf/stream.c
> @@ -180,13 +181,14 @@ static int bpf_stream_read(struct bpf_stream *strea=
m, void __user *buf, int len)
> =20
>  		cons_len =3D elem->consumed_len;
>  		cont =3D bpf_stream_consume_elem(elem, &rem_len) =3D=3D false;
> -
> -		ret =3D copy_to_user(buf + pos, elem->str + cons_len,
> -				   elem->consumed_len - cons_len);
> -		/* Restore in case of error. */
> -		if (ret) {
> -			ret =3D -EFAULT;
> -			elem->consumed_len =3D cons_len;
> +		chunk =3D elem->consumed_len - cons_len;
> +
> +		n =3D copy_to_user(buf + pos, elem->str + cons_len, chunk);

[Severity: High]
This isn't a bug introduced by this patch, but could this chunk size end up
as a large negative number, causing a massive out-of-bounds read?

If a user issues BPF_PROG_STREAM_READ_BY_FD with a stream_buf_len greater
than INT_MAX (e.g. 0x80000000), the length is read as an unsigned 32-bit
integer from userspace:

kernel/bpf/syscall.c:prog_stream_read() {
    u32 len =3D attr->prog_stream_read.stream_buf_len;
    ...
    ret =3D bpf_prog_stream_read(prog, attr->prog_stream_read.stream_id, bu=
f, len);
}

This is then implicitly cast to a signed int here in bpf_stream_read(). If
len becomes negative, rem_len also starts negative.

When bpf_stream_consume_elem() is called, it calculates used =3D min(rem, *=
len).
Because *len (which is rem_len) is negative, used evaluates to a negative
value.

This makes chunk a negative value, which is implicitly cast to an enormous
unsigned long when passed to copy_to_user(). This could lead to a guaranteed
kernel panic or denial of service when hitting unmapped kernel pages.

Should len be bounds checked or treated as unsigned int to prevent this?

> +		if (n) {
> +			/* Keep any successfully copied bytes; -EFAULT only if none. */
> +			elem->consumed_len -=3D n;
> +			rem_len +=3D n;
> +			ret =3D (len =3D=3D rem_len) ? -EFAULT : 0;
>  			break;
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1787492521.gi=
t.shijianlin11@foxmail.com?part=3D3
