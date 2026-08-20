Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA3841A4F7
	for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 11:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787225196; cv=none; b=Vs+GIRwYKK/t/RfdiXMKFOqU85TqYz5Fwy/6rh5oWK/YOKIzbTDLnEv4QgCL8SQph0POZ+1J5BZ5VYJYvZl2yclOotzRjyl3Q4Jf2ymX9Zm7049vYF+Ro8waSdv3KH4By6g46UChVe6GdWQdGK0xlWCrwPYkDPGIuolAh7+S0qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787225196; c=relaxed/simple;
	bh=xYMGG7jOeW0EbFtF/SqoaANUGBr79YAfp3KJfUlNtPQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TpvfK81W+PaC1loUjWyvlITn8gKuVNjB1l9icfBOnaop4clxgDVl76Im2YhHPcJOhp46EBL8KDtPUPIpLwE0/f7r8c8ZmXwncSIw3X1cpB2802uNDcKAurmAQqCKyIOz/YODflmYXG5hOS1x2BFyt9ODzED2NUV0Vbk9KLCnTig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AavNR1o1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AavNR1o1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC5881F000E9;
	Thu, 20 Aug 2026 11:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787225195;
	bh=lzcH51jZ4P7pdXcEtWPw8ZDPVsGlMrqq+muUrHkwRF4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AavNR1o11m++HICPsPU3IigMYLp7Oke7Gl+PGDD2LEUTyfWDfPmdEj23z0N1pQYhO
	 cX6MoIuA8XepGyuUWB5n2CStQHcIoE7uE4uNeB6M1v57UuljP7FtcD8obAp+xdegiF
	 GeTf9rnfllX7zeteAVP1h12UDIUsYXX9lEtQUFBu7jdAqf1+mm9zHchq+1Cx2vsYaU
	 hqKSCwzB1mi3zftKN5M6M1AYk+of+wFJvnBMTaavWjbJpxssvY0QITFJLhNM1fD/gZ
	 Fp4tc5LzhoLaJ4POieHUjjvAPm3UFlVEAHxdA0q/lvPV/h/StyloLNTqoBdVrt2MaZ
	 +ILFBIJoXRxDw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] bpf: Annotate bpf_obj_memcpy with data_race
Reply-To: sashiko-reviews@lists.linux.dev
To: quanyeyang <quanyeyang@proton.me>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260820-bpf-kcsan-obj-memcpy-v2-1-672517a3145f@proton.me>
References: <20260820-bpf-kcsan-obj-memcpy-v2-1-672517a3145f@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 11:26:34 +0000
Message-Id: <20260820112634.EC5881F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] bpf_obj_memcpy() ignores the long_memcpy parameter when a map valu=
e contains special BTF fields (rec !=3D NULL), leading to data tearing and =
uninitialized memory leaks.
--

--- Patch [1]: [PATCH v2] bpf: Annotate bpf_obj_memcpy with data_race ---
commit 1f96f25bd23990e4a6c598225059cbcbac9898bf
Author: quanyeyang <quanyeyang@proton.me>

bpf: Annotate bpf_obj_memcpy with data_race

This patch annotates the ordinary memcpy() sites in bpf_obj_memcpy() with
data_race(), matching bpf_long_memcpy(). This documents the existing
concurrency semantics and suppresses KCSAN reports for intentional races
without changing behavior.

Closes: https://syzkaller.appspot.com/bug?extid=3D44044637ef892e79ca2b

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 7719f65284456..10d1186ef3b44 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
[ ... ]
> @@ -580,10 +587,10 @@ static inline void bpf_obj_memcpy(struct btf_record=
 *rec,
>  		u32 next_off =3D rec->fields[i].offset;
>  		u32 sz =3D next_off - curr_off;
> =20
> -		memcpy(dst + curr_off, src + curr_off, sz);
> +		data_race(memcpy(dst + curr_off, src + curr_off, sz));
>  		curr_off +=3D rec->fields[i].size + sz;
>  	}
> -	memcpy(dst + curr_off, src + curr_off, size - curr_off);
> +	data_race(memcpy(dst + curr_off, src + curr_off, size - curr_off));

[Severity: High]
This is a pre-existing issue and was not introduced by this patch, but does
this code ignore the long_memcpy parameter when rec !=3D NULL?

When rec !=3D NULL, the loop ends by copying exactly up to size bytes and u=
ses
byte-wise memcpy. It ignores the long_memcpy flag, losing anti-tearing
guarantees, and fails to process the remaining padding bytes up to
round_up(size, 8), leaving them uninitialized.

Could this leak uninitialized memory to userspace?

For per-CPU lookups, the destination buffer is allocated without __GFP_ZERO:

kernel/bpf/syscall.c:map_lookup_elem() {
    ...
    value =3D kvmalloc(value_size, GFP_USER | __GFP_NOWARN);
    ...
}

Since bpf_obj_memcpy fails to overwrite or zero the padding bytes for maps
with special BTF fields, the uninitialized kernel heap memory in the padding
is subsequently leaked to userspace.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820-bpf-kcsan-=
obj-memcpy-v2-1-672517a3145f@proton.me?part=3D1
