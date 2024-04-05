Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEA9171657
	for <bpf@vger.kernel.org>; Fri,  5 Apr 2024 17:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712338862; cv=none; b=iC7qDcwRdyH1AAboFldcQAE1gtO9Amc7pcRyvakSX2+BbiUcE8KF4DHUiM7a1pogPxU2l74crYh7OgsqxL5mSZloRC+jOgfD3Vxv7L6l4HCDHK1C96Gc6feMXgPebPM/t1ftH1plB7fmvNoc6zPQmfJeTSNoDuPrBgAK2MOFlJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712338862; c=relaxed/simple;
	bh=VV4/WsIw0bjyvw7kkAcl0orY+3uhEqN5npfbyUmFwcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DHg+bSH678xJBmMuhxNTZzv6omPfDPIa09AGxBiwQliG8zenPx+J89WX35UVorJRs3Vk1lrA+E1CNHqXz7fVGtpNtr3lAbb3t06E9ZBSNoGMnajfZa3YI1PtpxAoqxyGNn/vGmd/hfuJMtEjF1+SryuhrUmJ+cH3QYHvJQPljmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7d5abd91ea4so52911539f.0
        for <bpf@vger.kernel.org>; Fri, 05 Apr 2024 10:41:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712338860; x=1712943660;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VV4/WsIw0bjyvw7kkAcl0orY+3uhEqN5npfbyUmFwcA=;
        b=A7yk2u4cAtalIbn8Lk6KKNZP9u6RmVfm1RNZuw9TWEKbpTe/d3UM5a6TfOQNrtYuUt
         UbLmiET7QoPXswTnWOtoms5pEXnlHp1rnQ8ZhGYG/3FIvAvTpVBSMryCk68rh2An09yT
         y9Xbz3sZnZGQnY0vhOF6vJSML7MbXgq9scKYyu7dfa8nwM34m/nk/Jcx/m2azWwWyvm3
         lY6jU6EmSHxZu+4ou9BY0/U2e16bm4SVRZKG3/8dBaGzQOeRVgaXYg2VrEpPXXTEoc1z
         RwfmQ4VW4i+8vMPWQ/EwZ0lbYWE6z8Hr8+osNnNFmSsYUoyyRwLjmX1Nzuibu2Pr7OFI
         mprg==
X-Gm-Message-State: AOJu0YydL6bqiFOhIOip5ugyxoTeePWdS+55dd1Is71Pp9fSd/5IZVlF
	DH9TbViBIr48xcTIS4jw3WJBhaRFCOy/Jrd0/GeZcTGez8G/ycS1VSGxsdc4
X-Google-Smtp-Source: AGHT+IF+ljzQYwGcrc35Ddph03ruUQB0OlgeOO0DesC8YfCHNSyuudE6WE4/sWGSULHY01CzSg3uSA==
X-Received: by 2002:a05:6602:884:b0:7d0:c0e2:d0d3 with SMTP id f4-20020a056602088400b007d0c0e2d0d3mr2292565ioz.19.1712338860019;
        Fri, 05 Apr 2024 10:41:00 -0700 (PDT)
Received: from maniforge (c-76-136-75-40.hsd1.il.comcast.net. [76.136.75.40])
        by smtp.gmail.com with ESMTPSA id n8-20020a056602340800b007d5c94c4b9csm35499ioz.25.2024.04.05.10.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 10:40:59 -0700 (PDT)
Date: Fri, 5 Apr 2024 12:40:57 -0500
From: David Vernet <void@manifault.com>
To: Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>
Cc: bpf@vger.kernel.org, bpf@ietf.org, Dave Thaler <dthaler1968@gmail.com>
Subject: Re: [Bpf] [PATCH bpf-next] bpf, docs: Editorial nits in
 instruction-set.rst
Message-ID: <20240405174057.GA19691@maniforge>
References: <20240405155245.3618-1-dthaler1968@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+YnSGq4SeLXWNs7r"
Content-Disposition: inline
In-Reply-To: <20240405155245.3618-1-dthaler1968@gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--+YnSGq4SeLXWNs7r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 05, 2024 at 08:52:45AM -0700, Dave Thaler wrote:
> This patch addresses a number of editorial nits including
> spelling, punctuation, grammar, and wording consistency issues
> in instruction-set.rst.
>=20
> Signed-off-by: Dave Thaler <dthaler1968@gmail.com>

LG, thanks

Acked-by: David Vernet <void@manifault.com>

--+YnSGq4SeLXWNs7r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZhA3qQAKCRBZ5LhpZcTz
ZBsPAP9dp9lzNrQOY0PZvp9K/Td5Gzq5gkkQzhz2Zll/lYgJhwEAm8WRmoxzevQn
3nLXwfuI+Hk0j5dM6ZB9nUljchTrEgU=
=v+fi
-----END PGP SIGNATURE-----

--+YnSGq4SeLXWNs7r--
