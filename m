Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793728233;
	b=oG6kGwSuqmqDlKjNs3o/wWwPaa2z+BLzxpJt72yq0Zld82joyLRc+kb05+jaR7xJsuaM
	 k0+xK4XiO/sy/X1bGyaLZnNFrHl+fThwHHN9gREA1IhC3SlyWs8wOoAHs1D8IG7Hw74bH
	 /xwyibqzl/wha3++fcoj7zumumx0Q1MP/n3Xsa8hLBbanyF/MpVKXB4cA1RSoD4LpEh9D
	 IeRDKCS8lYspHdHPf0G5H1M0cN6wq5pgJFNIIPcWzrViC3zd7LBSjO14HzNKCfz7Lnr4C
	 CDuQNoKhHHmcsWJO+UWVS8k4YcuPQf3VTVmH9Qfx4ayhWrCWGLWbAPKnsY23hfyax6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793728233;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Cookie;
	bh=Fh8hKPEmfpfH08+CBHMiDGbs/Ucm/feTU6t/Oc0vPbQ=;
	b=S6d7z1+q4Vkf1WC0em7msoHpOWdOT+Nr/8ln67gtkvLjFXyUIUt6qbW8f+RE6XgE7t4N
	 Sb/fKaTrIDwig/O4C/Oxg/f/o2C5nf1XYCaOhFPX/sITDqyYMdzrlZV/yzvdgR/gUUTGC
	 lgaccFu1MShLXU1/G7qTQAnWpUjlQyjOQPFn7MoTTbgB+VBX9yJHPsOjy3VHX569Ca6qp
	 m+pKPfmrWL5JtHcJ3xkXcsutwxDNY2LFrc7S9KoSrpz3LOTJr5Rw/oXAXNsoXirMwfVJs
	 zClAHSvC3d4ssdhN8BFTnDhpcBy/M7UYbgu+F0MmimzBe5IYsBNjkDA7xy3Sm2YljGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gmFnJEpx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74715606A31B;
	Tue,  3 Nov 2026 17:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gmFnJEpx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7CDE1F000C1;
	Tue,  3 Nov 2026 17:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793728233;
	bh=Fh8hKPEmfpfH08+CBHMiDGbs/Ucm/feTU6t/Oc0vPbQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gmFnJEpxZO9WYoOlsaDnsBE3CyU3esz1uI+3ZbQPNbsTuViqN9+b91du2KFHUWJwc
	 Xmxa5l4OhotJ84bWOCvhh8pLnJm+khNRvDegNQ9+R+NAh5ME5Ser9/10ykWd1QDiYJ
	 5Yffcg4ioC9ZNROPNax4sWE6r0cQWPUNGn01S/oH3J0QAKlcQl8zV8/5+GNLc2jMQj
	 OaJSOQBuosOIYQGJX7VL+XpH+EBH4uSku4BGlWbewq1yrLlXuVVMIzMwUadnOCofd/
	 qkdRZRZKXuM2sS5QGCDtEmugS6IwqGNPl3vhWXXNBkYtgpwkQ57hehHOBR0xktbfj4
	 URQWXM53UYF0A==
Date: Tue, 3 Nov 2026 17:50:28 +0000
From: Mark Brown <broonie@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Networking <netdev@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Qiliang Yuan <odys.yuan@gmail.com>
Subject: Re: linux-next: manual merge of the bpf-next tree with the bpf tree
Message-ID: <b3685e93-ada9-46dc-b359-e9457f32b3c8@sirena.org.uk>
References: <aunq4v24N-Gzx_n3@sirena.org.uk>
 <DMLRD9KZPGMA.17182J5DEZ43B@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5CQYsZ3VpxExZq4F"
Content-Disposition: inline
In-Reply-To: <DMLRD9KZPGMA.17182J5DEZ43B@gmail.com>
X-Cookie: Small is beautiful.


--5CQYsZ3VpxExZq4F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 03, 2026 at 05:40:04PM +0000, Alexei Starovoitov wrote:
> On Tue Nov 3, 2026 at 2:08 PM UTC, Mark Brown wrote:

> > and likely others from the bpf-next tree.  Given the nature of the
> > conflict and my total lack of familiarity with this code it seems
> > vanishingly unlikely that I'd be able to do a sensible merge here,
> > instead I will hold the bpf-next tree at the version from next-20261102.
> > If someone could help me out with the merge here that would be very much
> > appreciated.

> Yep. It wasn't easy.
> bpf tree is now ffwded and merged into bpf-next.
> Conflict is resolved.

Thanks!

--5CQYsZ3VpxExZq4F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmrqHuMACgkQJNaLcl1U
h9CpUQgAg1CqeadP6VK2bdsf5Z3sX2CCyoCIwUBWxPz69i1bdh11cMbFq55g0IKR
Q4TeFJZnjDtOLEPmUrHXeLOuFeMRLdAdteabjbyUYgoTdhACPBwA5zIzHxtIepRM
IPtv940EyHzwcH4rXjbR3TjVg8NnNzQEK+Wm5dcuSnzqRCdKf35hS+8kPqtrnVcu
dSPIPLZrqCVeUW9vdPd8tkfvJVoEqbyz+bCwZQeAncHZpE/9CdDxgOvPe+dbQHDA
JqiY7lCqOteP2DN3aMeP0Mznfk4lHAWx44rsjcaG6gcRP8vva8NzHUYaESadD7RD
Z+oV+aDE9Gi2x4I8KRhRNIMf5bLCkA==
=IWXd
-----END PGP SIGNATURE-----

--5CQYsZ3VpxExZq4F--
