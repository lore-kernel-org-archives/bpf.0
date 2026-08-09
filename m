Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA908369207
	for <bpf@vger.kernel.org>; Sun,  9 Aug 2026 15:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786288476; cv=none; b=nJv/bQv2EHsp941tPHGOHLDyXGtbDekM69JlykZojO6VKCE6i+5deJvaF27qrQn9iiLayYnhjC7o0pakfx0wssFhHRESxmFvmzT+ZQk+kj3eZnRXW83JAYRNwazX34yV/cTzk5ZH+7wt2+imPLFHW7wLy0VrTgg5FPJp/lilq+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786288476; c=relaxed/simple;
	bh=tJXmDm0Sc3hYqeYeYl93k54HMsbcHzMx+VcSMhZfwgc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=X0uIyHwakqS8/68Tdeq9xbu/nJp753ykRpK7xAJ2kANY6qaagUVwpm7rwALcjsHpV8R7UYaBO4uUywh4CmiU01XMHJ0r2tfMF9e+X+g4nc3bGyK6qlfWZWu8pLA6T41NdhCfEaC+2C3aYWevXg2bKNJps6SuCJQ8qSfd9bRiiKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JwRKwWmq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JwRKwWmq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 627C21F000E9;
	Sun,  9 Aug 2026 15:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786288473;
	bh=hFxasITjDJTIohRWAEMDKxijqGms+4NLeHBWY0m4LmY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JwRKwWmqPlx5I+RVEYom97k++3rRRv/ErjppM85gL5lCTwvFOdRP3HkZAhxj1w4xW
	 OT/+yrmC21TzSct/zk1+1DT+aIvy3oTtcpstc4Yby55G9E/QXNn1rUxPsQI/y70+GO
	 8+FBSs1WS45s9N4qr3PX2fJQpzfZtlHfqKHaGA1OXvsCbmvBgQJ9WZLvynnhtXmysq
	 1qZnXag84gPSX5KVXTvK72M9Pc6n3xo19gNdQXYngWQ4+0Y17xLkCIvTzjNDEN5dKR
	 d9vQYObV+myaP36CgIBXJLwQMRfSzYg3grwVnwePzDyWSwIokBEt6GAkyVTQ1AbEgo
	 mUNKGXfffzpuw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 02/13] bpf: Factor out update_fentry_multi
 helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Hwang" <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260809150111.45000-3-leon.hwang@linux.dev>
References: <20260809150111.45000-1-leon.hwang@linux.dev>
 <20260809150111.45000-3-leon.hwang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 09 Aug 2026 15:14:32 +0000
Message-Id: <20260809151433.627C21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The `orig_flags` parameter in the new `update_fentry_multi` helper =
function is unused.
--

--- Patch [2]: [PATCH bpf-next 02/13] bpf: Factor out update_fentry_multi h=
elper ---
commit c90e2dad924e48bb1043b67addb36ec916a663d1
Author: Leon Hwang <leon.hwang@linux.dev>

bpf: Factor out update_fentry_multi helper

This commit factors out common functionality from the register, unregister,
and modify multi fentry callbacks into a new update_fentry_multi helper.

> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index 8c2c1d1b90941..6e1898e1b200f 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -1568,47 +1568,41 @@ static void ftrace_hash_add(struct ftrace_hash *h=
ash, struct ftrace_func_entry *
>  	add_ftrace_hash_entry(hash, entry);
>  }
> =20
> -static int register_fentry_multi(struct bpf_trampoline *tr, struct bpf_t=
ramp_image *im, void *ptr)
> +static int update_fentry_multi(struct bpf_trampoline *tr, u32 orig_flags,
> +			       struct bpf_tramp_image *im, struct ftrace_hash *hash,
> +			       struct bpf_tracing_multi_data *data)
>  {

[Severity: Low]
Is it intended to keep the orig_flags parameter here? It appears to be
completely unused in the body of this new helper function.

> -	unsigned long addr =3D (unsigned long) im->image;
> +	unsigned long addr =3D (unsigned long)(im ? im->image : tr->cur_image->=
image);
>  	unsigned long ip =3D ftrace_location(tr->ip);
> -	struct bpf_tracing_multi_data *data =3D ptr;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260809150111.4500=
0-1-leon.hwang@linux.dev?part=3D2
