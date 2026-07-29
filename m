Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E193A718D
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 20:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785355270; cv=none; b=dCZhaUOv94vzIZOH2edThJotG6dddusOCnjJjNplv57kRmcmIF3VTr8gjlXDIos03kyN1ymZKYaB6oo6RzhaFpqUOga4JQ+P91sooVHrW+hOXt3n93+LRXTboba5fqzl9F9PCn/qufdZ+JpHSOe68w4suTPHjPRIYBB3ryAm87g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785355270; c=relaxed/simple;
	bh=Z+Y/YOSR+kd9q5Wn9/lCmAtSCcqv4GyXbsz65iPG+Zo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PloNupHpJRUedYYXs64jbHXWa4SaOHJAyJvCfjENC8HdXZjv6pXdWQ5KGc2c6/nKApFBMtHazsEg6TuInlqZUTmqoEJOUQKkeBFD8dXX3DR4qjMZAgGJrwVjk8WSQ5PptXgf90sbRLE2wp9nxHDBd7aAhxf7YwJG40VbyQBqx9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EpTPQtRO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EpTPQtRO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA70A1F000E9;
	Wed, 29 Jul 2026 20:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785355268;
	bh=bU6VtXvKuHXKsjMGWfqVxVRBUQt45Jr+mSNOmzncLNM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EpTPQtROduikivQW7U9lkFkXc+JWB54zBw9BgTeFk38zy87e/M8kzr5avlfNG0lEv
	 YCqdQyIBVEXK6zm2hHV0e3mSqjM1X7WDOTveNVLFvCbPpDLIXAyuQ9M0G9M0f9hUWC
	 OXnT6CMe0zboXAVf+l51nMIT70inIRkD0e5Dwz7+lc7CqxMQn3wpzcSrt04ZN8RAIS
	 oh/2M8/+f/GKSYUjNtatzF4jfoGpLzHCFSwuoGRSVncvqIRRVaakMyOtt7e1Ger/7R
	 zw4UTPV57OgtS0L7RHOFhAwB8ON+/Cqn+6xWUKlr0+4LkfPWtbN9EhX3Uj/hwgoNYK
	 fUQce2NY/Klig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 3/3] bpf: Avoid redundant min()/max() in
 cnum signed bounds
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vinicius Sampaio" <vldsampaio@pm.me>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260729194932.292368-4-vldsampaio@pm.me>
References: <20260729194932.292368-1-vldsampaio@pm.me>
 <20260729194932.292368-4-vldsampaio@pm.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 20:01:08 +0000
Message-Id: <20260729200108.BA70A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The patch introduces multi-line comments that violate the mandatory=
 BPF subsystem comment style (the opening `/*` must be on its own line).
--

--- Patch [3]: [PATCH bpf-next v2 3/3] bpf: Avoid redundant min()/max() in =
cnum signed bounds ---
commit 7bdc1e04cfe4ef63975bb42ed60ef85f4dddcb77
Author: Vinicius Sampaio <vldsampaio@pm.me>

bpf: Avoid redundant min()/max() in cnum signed bounds

This commit simplifies the smin() and smax() calculations by removing
redundant min and max operations on the non-overflowing branch. It relies on
the fact that when the range does not cross the ST_MAX/ST_MIN boundary, the
base and base + size represent the signed minimum and maximum directly.

> diff --git a/kernel/bpf/cnum_defs.h b/kernel/bpf/cnum_defs.h
> index 09535edbbafc9..95452eefe44a5 100644
> --- a/kernel/bpf/cnum_defs.h
> +++ b/kernel/bpf/cnum_defs.h
> @@ -33,7 +33,11 @@ struct cnum_t FN(from_srange)(st min, st max)
>  	return (struct cnum_t){ .base =3D base, .size =3D size };
>  }
> =20
> -/* True if this cnum represents two unsigned ranges. */
> +/* True if this cnum represents two unsigned ranges.
> + *
> + * The caller should ensure !is_empty(cnum) holds when calling
> + * this function.
> + */

[Severity: Low]
This isn't a bug, but should the opening '/*' be on its own line to align
with the preferred BPF subsystem multi-line comment style?

[ ... ]

> @@ -57,7 +64,11 @@ ut FN(umax)(struct cnum_t cnum)
>  }
>  EXPORT_SYMBOL_GPL(FN(umax));
> =20
> -/* True if this cnum represents two signed ranges. */
> +/* True if this cnum represents two signed ranges.
> + *
> + * The caller should ensure !is_empty(cnum) holds when calling
> + * this function.
> + */

[Severity: Low]
This isn't a bug, but similar to the comment above, would it be better
to place the opening '/*' on its own line here as well?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729194932.2923=
68-1-vldsampaio@pm.me?part=3D3
