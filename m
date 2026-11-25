Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795568373;
	b=4BXjLtggzBkR7nxOrJ0qlkSOJMUKP1i9aZWAZ/4rYd9gTgfJiJoK7uSJXxLXuarAMPAZ
	 ElQ46uTRmOUQFVbx8oQOXMoUd4/wjCgQyUL9ADdOtIq59Ksot5xnzX2RuvEnS0lgRpvOu
	 1ji2izvN8kD0Jk6+RoSvDbFX5Yc/Bnqr8evY0WWJCkOQfJoYkiKxZ2y/M8oLB/JXaFTRX
	 FN1fGsLtO5TOGQA387Dp17WKOiasoBpXVapoIXZa+tA32rv96O35Z3ewU1594oIKVI14l
	 D9nz68TuibvJ7p2NeNLPYs6FcnZ1sqw6hVo6gUN8rVln2aAJKPcProvhfei3+jdqwlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795568373;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yMFwO+V1XWujeM3oFekBMFinmt/WjV6V644sKcOynU0=;
	b=wzUVR5JVGdTJzp7ibMaBId22OrkNCpFN9lMMk3J5YEzjXG2zanivq58E5Belxm0bIzFi
	 SxcPf5PA+eq3HTXs83V0fYLqUazjFMzEIXv5EooboneaE4XXVJWOpnMyRc1ncus3b1aVF
	 cluDTJwRKV871XcsIyOjI8iDJhInpA5nJ8+yWT82m6UapyXaWrlmjQaknXk4hKEZhvXU0
	 zvec2DCjmZ2X5Jo5FeemIODR2vE9731KogEVzPaROLj6M3+RTyj25RJ9EmQS6cMv8yK4e
	 2Zy14n2jD9i5vXVQXTDZ25Za2998tI7mz7vsfVLCghLEIQM2zUa92g0VGotwdhzJjJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OJOW4SWN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990F1606A31E
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 00:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OJOW4SWN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1220B1F000C0;
	Wed, 25 Nov 2026 00:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795568373;
	bh=yMFwO+V1XWujeM3oFekBMFinmt/WjV6V644sKcOynU0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OJOW4SWNoedQnfV3CevbHRsFEMvpmoPUVjySvTe4pLSZUCrEcGrG0KwbMUKqvWK5z
	 +Drgn1VXaD7tXrrfdJGO8xqUFUe932pS9L9t95qcVAX2FTgjGYP+NkoXOYEFPgagB1
	 A4OJT1f8xZXCh42PxjOPOGzn2DJ6Ub6PwD3YJaLzm2FYP66KY2kuzWUe9F6LYFHzUi
	 wEDpPFLvHKF4BQUVxrT731M6z30dpGcsD/+Xx/7a19WhEEW7UG05mEGzd1yIUedOlm
	 hgloXnnEs36U86T0zfk8JVMQiNEkOR3mnzg9AQMnpVDnYvAoTRCOmW/RLgZyBPHJEx
	 IvXiGqtgBspYA==
Message-ID: <sashiko-outbox-232309@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf 2/3] bpftool: Reject non-autoload programs for light
 skeletons
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VGhpw6liYXVkIFdla3N0ZWVu?= <tweek@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261125004911.3937193-3-tweek@google.com>
References: <20261125004911.3937193-1-tweek@google.com>
 <20261125004911.3937193-3-tweek@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 00:59:32 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] bpftool: multi-line comment style in do_skeleton() violates BPF
  convention
--

commit 00c1d9ac900fa5925fd4c2012a8926354bce780d
Author: Thi=C3=A9baud Weksteen <tweek@google.com>

bpftool: Reject non-autoload programs for light skeletons

This commit moves loader generation and object loading earlier in
do_skeleton() and rejects BPF programs marked as non-autoload when
generating light skeletons.

> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> index ee680f7c21160..edb6f7ef508ea 100644
> --- a/tools/bpf/bpftool/gen.c
> +++ b/tools/bpf/bpftool/gen.c

[ ... ]

> @@ -1316,6 +1301,29 @@ static int do_skeleton(int argc, char **argv)
>  		goto out_obj;
>  	}
> =20
> +	/* If we are generating a loader, load the object early (before
> +	 * validating programs and emitting skeleton struct definitions), as
> +	 * bpf_object__load() may update a program's autoload status (e.g.
> +	 * for struct_ops programs).
> +	 */
> +	if (use_loader) {
> +		if (sign_progs)
> +			gen_opts.gen_hash =3D true;
> +
> +		err =3D bpf_object__gen_loader(obj, &gen_opts);
> +		if (err)
> +			goto out;
> +
> +		err =3D bpf_object__load(obj);
> +		if (err) {
> +			p_err("failed to load object file");
> +			goto out;
> +		}
> +		/* If there was no error during load, gen_opts is populated with
> +		 * the loader program.
> +		 */
> +	}

[Severity: Low]
This isn't a bug, but BPF coding style places the opening /* of multi-line
comments on its own line with the comment text starting on the next line.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125004911.3937=
193-1-tweek@google.com?part=3D2
