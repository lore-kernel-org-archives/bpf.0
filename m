Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC99368968
	for <bpf@vger.kernel.org>; Wed, 20 May 2026 16:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779294227; cv=none; b=BQ55CFFjulutuO6+nAemhGNFdOikiv4ZqWVuMw34VDVEkzoenKEBM9HaMakLPf3IhMGCyEz+6msK7wH1ROS5ahJ/dYaAUZy+i6rlyL1BtA0saabwWAZZzDALsvXwG/0u7D1//QYsZT/M7JG5YYY139gnVExizvRRx7BR+PX2L2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779294227; c=relaxed/simple;
	bh=DPLv/wpJqpQbZH7JRGRqbovSRVXNkNSX4iXVx9fdmrg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iVTr30ThZ6tNWbgIP86BGZaD1EsXe43nXt3I58V7w9E2iMqjOkG90Of6xP7JgXUmFWIJYNYkg4+8WWbxglLn3iiqokmrSMpo106fIWYeLOEQxj5nzCg3CJncByhQEsOXpHt2yNnxQv0bw5VLWbCLwqzpDgfM2oxrLiu3ZyszzKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DIYmtol5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DIYmtol5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F13D61F000E9;
	Wed, 20 May 2026 16:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779294226;
	bh=eNvJX8UOHOdT0KyoDDWH8ABxGBxaQGbUW0ZzMhm9DoU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DIYmtol5ts8hKX2gaCnO7qhLOzxMKGFliJPqCdB5f1fj7phzTvJmokIlQ/R/ygM48
	 QXdcx4UWLraQMgJEMPdiqe+Z287NQQ3DpEzNbr9+TXR1vyDVIO8H7WwPOscncXcXU6
	 TxXNewRX3pdA5n7S6SWedj5JRKX+voEmjHVX57IoNS05L+HUy8aeR+iSa+K9fG3CE4
	 ekOiSKBlLKWczXI8V1o24EQ4URWqtniuhJs23EsWEoDb8qjiL5K1olwuYiof3uTJh/
	 oGqblrZdnY1YBEmz22r95+FiowCWidFTT0ahdD+flJyvHFXvVz1Srn9SJ7YDnj8V3D
	 969Vz81W1Meew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 07/20] unwind_user/sframe: Wire up unwind_user to
 sframe
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260520154004.3845823-8-jremus@linux.ibm.com>
References: <20260520154004.3845823-8-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 May 2026 16:23:45 +0000
Message-Id: <20260520162345.F13D61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incorrect FRE size calculation completely breaks SFrame parsing fo=
r functions with multiple FREs.
--

commit 8adeb8aec136e0b90e11e4b9aa74e9464240b9f3
Author: Josh Poimboeuf <jpoimboe@kernel.org>

unwind_user/sframe: Wire up unwind_user to sframe

This commit hooks up the sframe infrastructure to the unwind_user
interface. It introduces unwind_user_next_sframe() to utilize
sframe_find() and wires it into the user unwinding logic.

[ ... ]

> diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c
> index 90ab3c1a205ef..1fb2724197332 100644
> --- a/kernel/unwind/user.c
> +++ b/kernel/unwind/user.c

[ ... ]

> @@ -82,6 +83,16 @@ static int unwind_user_next_fp(struct unwind_user_stat=
e *state)
>  	return unwind_user_next_common(state, &fp_frame);
>  }
> =20
> +static int unwind_user_next_sframe(struct unwind_user_state *state)
> +{
> +	struct unwind_user_frame frame;
> +
> +	/* sframe expects the frame to be local storage */
> +	if (sframe_find(state->ip, &frame))

[Severity: High]
This is a pre-existing issue, but does the SFrame parsing logic calculate
the FRE size incorrectly for functions with multiple FREs?

Looking at the call chain from sframe_find() into __find_fre() and
__read_fre(), dataword_count is decremented as datawords are parsed until
it reaches 0. This is explicitly enforced by returning -EINVAL if
dataword_count is not zero.

Immediately after, the FRE size is computed using the now-zero
dataword_count:

fre->size =3D addr_size + 1 + (dataword_count * dataword_size);

Because dataword_count is always 0 here, the size of the datawords is
omitted from the size calculation.

When __find_fre() advances to the next FRE using fre_addr +=3D fre->size,
will it start reading from the middle of the current FRE's datawords
instead of the next FRE header?

I note this is addressed later in the patch series by commit 9c045164b82cb
("unwind_user/sframe: Separate reading of FRE from reading of FRE data
words"), which refactors the code to avoid decrementing dataword_count.

> +		return -ENOENT;
> +	return unwind_user_next_common(state, &frame);
> +}
> +

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520154004.3845=
823-1-jremus@linux.ibm.com?part=3D7
