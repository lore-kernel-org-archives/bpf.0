Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14DE408602
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 17:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790356635; cv=none; b=FWJpj9/AlzAX+e/O53Aow0PAJeodkqbc8RCNagtqOKR3HbCubfM7ZG1hgxXwmKnTDEWPVr8JI1Ku6vAYsWlLe7beDvix+NwJ/sTAycWBMhRNK76o7F/y7eYUTwsVHfuOBDkAgT258vZ+aororuwEbkacU0F1kJ3nh524Yp3DUt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790356635; c=relaxed/simple;
	bh=W3u7VD+LvCV94sRp/ERTgjWer0swTa6a177pWsAHW0o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=goYzk82MlmMCa212iitjabCgtDwFJLL9MseynjhbAzavo1BbTapxfm0axo++3V/xw6DwcvEg12BC/DPc5lp30pTozs996Qb2taisMNVq4LMzzeJE6WpxibC+lzE++gdcHXg0eYSXeiwDq97xIdO5nxaREZ5BaxgemuNFwltcBPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D3DD1222; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D3DD1222"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D9EB1F000FF;
	Fri, 25 Sep 2026 17:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790356623;
	bh=zgS/R+697P/1sbytyp5Bh90tbEHWVJAd7qfJ0iDKvvw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D3DD1222Ggjs2j2EtVXX5GO9IygO7p6mM0tmLr1cH//S0k2gYxvJLTFlDIsrT1Ee0
	 Sv7olSH8nhBpURWy4a4IHGVZ1b1VWpODJN22H9t2W3ZnRY6j7mOQ7mWDa/6yLRfetx
	 LJ9XZiBe4sRKAlhABMkeEsRauy1CBWYlNk6VgWYz3nY5k5IrSMkstBNBhb1D9Ef/kG
	 3+reRbVTo7BAPxDuIwBdu+usgmyS6v87APK27dGgpEME2ScZKnL6ByHvTHixtPrxG7
	 tz2S2mo7Hh6JnUzejX4loVKidrujB/TEJ91cWR20EnclwgASEazyHI8R7QFEJl5Fdq
	 zz1ILGCFse30Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 bpf-next 2/3] bpftool: Update func representation to
 include function signature
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alan Maguire" <alan.maguire@oracle.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260925170854.1240637-3-alan.maguire@oracle.com>
References: <20260925170854.1240637-1-alan.maguire@oracle.com>
 <20260925170854.1240637-3-alan.maguire@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 17:17:02 +0000
Message-Id: <20260925171703.5D9EB1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bpf: btf_locsec_append hides truncation marker due to null byte =
gap
--

commit 6f503008243b4dfc886859b905f8a6fa7b657ef2
Author: Alan Maguire <alan.maguire@oracle.com>

bpftool: Update func representation to include function signature

This commit augments the func=3D output for LOCSEC entries to include a map=
ping
from function signature to where parameters are stored. It addresses a feat=
ure
suggestion to dump LOC_PARAM, LOC_PROTO and LOCSEC more verbosely.

> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> index e29c8a84e224c..ce4c4036c2796 100644
> --- a/tools/bpf/bpftool/btf.c
> +++ b/tools/bpf/bpftool/btf.c

[ ... ]

> +static bool btf_locsec_append(char *str, size_t sz, size_t *off,
> +			      const char *suffix)
> +{
> +	size_t len;
> +
> +	if (!sz || *off >=3D sz)
> +		return false;
> +
> +	len =3D strlen(suffix);
> +	if (len < sz - *off) {
> +		memcpy(str + *off, suffix, len + 1);
> +		*off +=3D len;
> +		return true;
> +	}
> +
> +	if (sz >=3D 4) {
> +		memcpy(str + sz - 4, "...", 4);
> +	} else if (sz > 1) {

[Severity: Medium]
When a string exceeds the buffer size and we hit this fallback path in
btf_locsec_append(), is there a risk that the truncation marker is hidden?

The truncation marker ... is unconditionally placed at the very end of the
buffer (sz - 4). Because the function fails to copy the prefix of the string
that would fit and does not write over the existing null terminator at *off,
a gap of null bytes can separate the current end of the string from the
truncation marker.

String reading functions like printf or JSON dumpers will terminate at the
first null byte, which would completely hide the ... marker and discard the
partial data.

This would be triggered when bpftool formats a BTF location string (for=20
example, a function signature with many parameters) that cumulatively excee=
ds
1024 characters.

> +		memset(str, '.', sz - 1);
> +		str[sz - 1] =3D '\0';
> +	}
> +	*off =3D sz - 1;
> +	return false;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925170854.1240=
637-1-alan.maguire@oracle.com?part=3D2
