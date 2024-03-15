Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271BA1B809
	for <bpf@vger.kernel.org>; Fri, 15 Mar 2024 11:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710501713; cv=none; b=MIOApmusS5hfNJh9V/TJefl2keNjJ0yU18KXkT+z9LpZxG7ueZxOm7PV6+ddEqdu8vUiAdCSQAY9BclVBOdxXi8XKgk54LNlQLqF4dkOEKqM7J7VymeXU8h1Zsw9X/sMaYbeOHVp5TXuCRH6BAtVzPZDHyGkGWxzhlB0DgLHDeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710501713; c=relaxed/simple;
	bh=ACaChIFK+KQQUmcosJqGNJiIbMApQZFHU7jRCzgGzGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G0ZjimOZwEwfKyw5hf3JfHutc3T4pbjXOZ9TXgqMnzwoqw+TcKPgZ0FaTNuz2Cq2M72mc7iDTRt0dkw+u5lHeC101KEOq2QDuj85AjqCe/qa/X06j5Tc/Dm+VnnD3GEDtbXzA1ouUXCKEUD62aA4vLaJUevZMj2C0+tj4iyvl/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mn9EMPoK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mn9EMPoK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 110F5C433F1;
	Fri, 15 Mar 2024 11:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710501712;
	bh=ACaChIFK+KQQUmcosJqGNJiIbMApQZFHU7jRCzgGzGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mn9EMPoKFbPIe/zqthOKrpHB/fc26+Jfz322ZDq5h1BKV/iaS27sRW4RupHEyPrBd
	 You8OIZHE2OIdfUWRiKnHnTpkqiGDniBwBIaI8T2Q/UlSmq8RncXbzzCsVNNHTyHKw
	 7r+olItQ54l/HZUZE8zajMvZ2PB/EcvVNiLZpAIj2tVVthiQufIkWuh8BPS30fcHYD
	 kwJSnNSv5PKhObjPhpMo165hxAPAKXvlMprgeKDzyeARTkMtQUYqlIijlhRpzSwPD3
	 7oa0irgjVYNlJLnQy4qq40eQNPHbbYZwghqSzQKwboiT4AupoTmcYytkBabxU41aOT
	 DMD+T6i23nwrw==
Date: Fri, 15 Mar 2024 12:21:46 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Quentin Monnet <quentin@isovalent.com>,
	Alejandro Colomar <alx.manpages@gmail.com>,
	Michael Hofmann <mhofmann@redhat.com>
Subject: Re: [PATCH bpf] bpf_doc: use silent mode when exec make cmd
Message-ID: <ZfQvSmag_v7VaOAB@debian>
References: <20240315023443.2364442-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oWO6bu1OvXyQZnH0"
Content-Disposition: inline
In-Reply-To: <20240315023443.2364442-1-liuhangbin@gmail.com>


--oWO6bu1OvXyQZnH0
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 Mar 2024 12:21:46 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Quentin Monnet <quentin@isovalent.com>,
	Alejandro Colomar <alx.manpages@gmail.com>,
	Michael Hofmann <mhofmann@redhat.com>
Subject: Re: [PATCH bpf] bpf_doc: use silent mode when exec make cmd

Hi!

On Fri, Mar 15, 2024 at 10:34:43AM +0800, Hangbin Liu wrote:
> When getting kernel version via make, the result may be polluted by other
> output, like directory change info. e.g.
> $ export MAKEFLAGS=3D"-w"
> $ make kernelversion
> make: Entering directory '/home/net'
> 6.8.0
> make: Leaving directory '/home/net'
>=20
> This will distort the reStructuredText output and make latter rst2man
> failed like:
> bpf-helpers.rst:20: (WARNING/2) Field list ends without a blank line; une=
xpected unindent.
>=20
> Using silent mode would help. e.g.
> $ make -s --no-print-directory kernelversion

Acked-by: Alejandro Colomar <alx@kernel.org>

Thanks!
Alex

> 6.8.0
>=20
> Fixes: fd0a38f9c37d ("scripts/bpf: Set version attribute for bpf-helpers(=
7) man page")
> Signed-off-by: Michael Hofmann <mhofmann@redhat.com>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  scripts/bpf_doc.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
> index 4606944984ee..c55878bddfdd 100755
> --- a/scripts/bpf_doc.py
> +++ b/scripts/bpf_doc.py
> @@ -414,8 +414,8 @@ class PrinterRST(Printer):
>              version =3D version.stdout.decode().rstrip()
>          except:
>              try:
> -                version =3D subprocess.run(['make', 'kernelversion'], cw=
d=3DlinuxRoot,
> -                                         capture_output=3DTrue, check=3D=
True)
> +                version =3D subprocess.run(['make', '-s', '--no-print-di=
rectory', 'kernelversion'],
> +                                         cwd=3DlinuxRoot, capture_output=
=3DTrue, check=3DTrue)
>                  version =3D version.stdout.decode().rstrip()
>              except:
>                  return 'Linux'
> --=20
> 2.43.0
>=20

--=20
<https://www.alejandro-colomar.es/>

--oWO6bu1OvXyQZnH0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmX0L0oACgkQnowa+77/
2zKWag/9EkeVxkkYXyxeuR1iTa+PjCYvwIACldussto8WkFjXcE7hCAA4S2F48Yz
P5JMy+2tu4yS+wJLkr/vIZmLNmnt39Wccu+/cuF5cKhO4v/fp5ktnISiMEG7A1y0
wGA3D/aS1Ekda8rKM0Na3xRzpIpQMY6SrfHo1J63q6+tpJKiireskm85Wn1XLAdk
CjdlF3b5BfhNUTiI4Y3TkOLiyFyxtzAibJgGQVx1CNDNCyrn1Hvsbk5t6te0k5YZ
XoGWFiN9cqMLrJsUeKJWBnUkEeIRt5s0P3zgvHqTaYSkpiD/KWlY8d64y++1e+Fk
2+VH8EbO0OQ2qcDwx9SkK8KFdhZDsH8sgwocu1RQQUJg5dQFVLY+3YjlMkf4KL88
LvZzEIgfZT1zHOYLH7ZZXu3Z3Jmba9Y8L/z/y7rWJNw9KC3x6vd9s/n7uNJQ0HWY
R8UCofF7BhMuujaw17zydxwf7jeaZyIV+Fi9mwSGK24N1hoipGh+zMmsDOVXvteW
kSLq+bWJn4bc17qIWQAumejOxVxUsLvE/n/zDwWuXwUYF8Lra4NFIg4ee1QeG4xg
cwkNF46Tl/QgBZ67HaTVMR9oHWJXVRC9bVoi/MgGmrgjMu5LfMbLGWArBfbeCqsJ
Tpg3OQmiACeijeLl9ZoT+RwK3s27HejcVSaTEovXlCy4RpPWvRI=
=xEqH
-----END PGP SIGNATURE-----

--oWO6bu1OvXyQZnH0--
