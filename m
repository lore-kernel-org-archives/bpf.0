Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3873C1084
	for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 21:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781903971; cv=none; b=cTkjZQzKrJPyASj5Pwwp44OLrPLb688WswjoiZwqaaT453tkpxYqv6s3PFPo80tXDKC6r6GpdCtpCjOO2Yl7MSf6W8QSQ5pgTFD1uWccGXp9nKiFSvFclXpVg3FfFn1j+Dw4jHj245snlJegI+73P8UwxyekL6JOSkudqpoP6E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781903971; c=relaxed/simple;
	bh=3MSIEaHZi3+n8bDzmt3sGWk6//IkVaNnxxICKgcHt6k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d40fCN5/yVWLXLKgkJ4BsmWRhqPj9xP3BiM7me8dBd0s84fRdkQMStVGIGqVi/Wesi5Ep7TlttQOBcls2WgizyRBi7wLvjfStpMWg9+hUuq8FBnmqB+5jdOYyRrYVajfHyQFeFpHybhr2mkQZSPeKkvnwNdyGbDrUH11IZb5Jz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g7QDIqRv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g7QDIqRv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AFC51F000E9;
	Fri, 19 Jun 2026 21:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781903970;
	bh=sW7KbnyBLmN/er6fLbZX6zEj+rdz6ZlzXElP+s6BkXU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g7QDIqRvg7Wh+BdHtUZJzXF2cDHrvoSnavjmDCFwBFNtZESQ+5roxJBYHZmqWk9Hd
	 k7I39arqa7T/5J9A1DU0A2f8hiq3ZFQhjlCY2hB/khbUcxKaSOF9KyOPu4tp+7yf8Q
	 /7xm0LfPCU+VjspKQohFKrw33tBeo5srKKQyZI9Ha9N5gWQQpRC+ZOYaM7tW/B217I
	 ZJwUJMC0Eoohgo3+eTVhCD9/gfO/g8q3CZq4b6qHoOX2gfhj0NVbAK7b0tMq6SP4Al
	 XueCgM85+PmSV9XVdGZi8fAvxWfy3ppj1yUatroyvCJHz2b3I2PiIYgOkIoo3XlH4I
	 SGxESODqVkyFg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 12/17] bpf: Report Execution Context Safety
 errors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260619205934.1312876-13-memxor@gmail.com>
References: <20260619205934.1312876-1-memxor@gmail.com>
 <20260619205934.1312876-13-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 21:19:29 +0000
Message-Id: <20260619211930.5AFC51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Integer overflow and out-of-bounds write in `bpf_bprintf_prepa=
re` due to `snprintf` return value mishandling.
--

commit 9da2a659fbd6ab09232d9dfa84f7ad227b09b2a1
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Report Execution Context Safety errors

This commit augments the BPF verifier to report Execution Context Safety
errors. It provides source context, path history, and suggestions for
sleepability and critical-section failures.

While reviewing the BPF codebase, I noticed a critical pre-existing issue in
kernel/bpf/helpers.c within bpf_bprintf_prepare().

> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -818, ... @@ int bpf_bprintf_prepare(const char *fmt, u32 fmt_size, co=
nst u64 *raw_args,
>  			u32 num_args, struct bpf_bprintf_data *data)
>  {

[ ... ]

>  			if (fmt[i + 1] =3D=3D 'B') {
>  				if (tmp_buf)  {
>  					err =3D snprintf(tmp_buf,
>  						       (tmp_buf_end - tmp_buf),
>  						       "%pB",
>  						       (void *)(long)raw_args[num_spec]);
>  					tmp_buf +=3D (err + 1);

[Severity: Critical]
This is a pre-existing issue, but does this handle the snprintf return value
safely?

The snprintf function returns the number of characters that would have been
written if the buffer was large enough, not the actual number of characters
written. If the output is truncated because the remaining buffer space is
small, adding the return value to tmp_buf could advance the pointer past
tmp_buf_end.

[ ... ]

>  			/* hack: bstr_printf expects IP addresses to be
>  			 * pre-formatted as strings, ironically, the easiest way
>  			 * to do that is to call snprintf.
>  			 */
>  			ip_spec[2] =3D fmt[i - 1];
>  			ip_spec[3] =3D fmt[i];
>  			err =3D snprintf(tmp_buf, tmp_buf_end - tmp_buf,
>  				       ip_spec, &cur_ip);
> =20
>  			tmp_buf +=3D err + 1;

[Severity: Critical]
This is a pre-existing issue, but the same snprintf return value behavior
applies here. Could this also advance tmp_buf past tmp_buf_end if the output
is truncated?

[ ... ]

>  		} else if (fmt[i] =3D=3D 's') {
>  			fmt_ptype =3D fmt[i];
>  fmt_str:
>  			if (fmt[i + 1] !=3D 0 &&
>  			    !isspace(fmt[i + 1]) &&
>  			    !ispunct(fmt[i + 1])) {
>  				err =3D -EINVAL;
>  				goto out;
>  			}
> =20
>  			if (!tmp_buf)
>  				goto nocopy_fmt;
> =20
>  			if (tmp_buf_end =3D=3D tmp_buf) {
>  				err =3D -ENOSPC;
>  				goto out;
>  			}
> =20
>  			unsafe_ptr =3D (char *)(long)raw_args[num_spec];
>  			err =3D bpf_trace_copy_string(tmp_buf, unsafe_ptr,
>  						    fmt_ptype,
>  						    tmp_buf_end - tmp_buf);

[Severity: Critical]
This is a pre-existing issue, but can this bypass the out-of-space check?

If tmp_buf was advanced past tmp_buf_end by a previous truncated snprintf
call, the exact equality check (tmp_buf_end =3D=3D tmp_buf) will evaluate to
false.

This would cause the size parameter (tmp_buf_end - tmp_buf) passed to
bpf_trace_copy_string to be negative. Since the size parameter is typically
treated as an unsigned value, this could result in a massive out-of-bounds
write. Could we use a greater-than-or-equal check or track the remaining
length more safely?

>  			if (err < 0) {
>  				tmp_buf[0] =3D '\0';
>  				err =3D 1;
>  			}
> =20
>  			tmp_buf +=3D err;
>  			num_spec++;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260619205934.1312=
876-1-memxor@gmail.com?part=3D12
