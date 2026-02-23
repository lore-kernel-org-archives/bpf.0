Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D3D30148C
	for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 15:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771861636; cv=none; b=XewkQPp3fG2nVDH0rk4T3GPoTNEg4Fg/WBQm1y71kbNNccw2CNZ/0dZxQTvqf66pb/k0sfZOblwTDHI9nIcy0x+Njm0fo3mtSPgQ3ge/7qyLTgjJJv2i8n+HYwUEDWd+/lwazuX2E7RnQhydTDuQPQQQOZPtDSF+NZagoQ6n2UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771861636; c=relaxed/simple;
	bh=c0nyUek6XngwBcngRXOLG+sC35+BhxbRusJXFp7/xuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kA5Z9LC3gzTUuFKhD7tDisFmbSczOClnkuSEMQu/0kU2gzl2wGH5VqRUlHzihC1SMh2dIspJCNUv3zISoZB3QAf8EH/IeBW+p62yG8B4/xe73XqNSglOap935wYal16Ff7Ee3NQ4qEbNrDVsTfGXhV5f7KADx+HZ0I7I5zEmZnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=g/oOi0Rq; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="g/oOi0Rq"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4806f3fc50bso51131095e9.0
        for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 07:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771861633; x=1772466433; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c0nyUek6XngwBcngRXOLG+sC35+BhxbRusJXFp7/xuA=;
        b=g/oOi0RqoAlO3Z46H3kTAU97REQETAqZMSHBBPNZGCyxrWXXX3JW4R1xlP8mnkftAT
         b1Pj1IIU/TpoxpKumpDuDGc+o8DygE9ULAGQ8Zba3J8+mLqgsox9+KG3AsZ6IqedG8Mf
         qEB3CUIMZuWmsdOK3ihGFi3+vFA/4E5P0DW56QktJp3PdEWVCdorrts1zHoHGGHawVpr
         kgUFM8zY+oXqwJJt9PzHhA/obyYcMlgdzwjWI4Zheimwoq07FaUahA2NSqeuBkte4nOL
         tIbhVGdh8o/72L6AeS/rJzTZaR4B9mY3VZaYScL09lXLG/UD7BCbCJmwo4NBJKqS/HXm
         Bz0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771861633; x=1772466433;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c0nyUek6XngwBcngRXOLG+sC35+BhxbRusJXFp7/xuA=;
        b=C5Da69vTaLDY2N1B8SmPTxGDfGe/6XQk8k11+WOMncEX+oacKS+2DSkYy2kPhEoLoK
         y7GpvFhXoCtjcERDJMxvCmT7rFD2IH4yPdyjiDLjx9TitmsCef0Bbunf2IhUqbcEJ3aM
         YEM9U/j8MgLCrbc0gzIxVK9JyanoccdVN4YfU5IEQxTNTfiCIz7zVanJCCQP+l3PRMdy
         +CL3OIf0O1oXikCCdqKLuxhW2m2AUrRKU1zmKwNoU8qJSpv9guqcoFiOSRo3feOHNx5U
         jhLDrqgI9PJN7gMsIqljb66f/uDAsi3+R9yW83V1gFgiVPEZ/PtBdjToa/rERKj91UdE
         55Dw==
X-Forwarded-Encrypted: i=1; AJvYcCULhlVVQoxzXkXFL323MKxP85FO7A1IyUeFWEW8UgQGKk2/k6DzU7FVZDbT4o8I8dWSen4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUpXE4+cVrofROr0L47L4ejB26b/7dT2tl6Kr8lv58+aOzykc6
	XlmGT8wNkoXjsWUK5GnFbAbi1/Fvpq4prtR6SoBVLEck/MsvSXp7NIsroD4DHbH1Jhs=
X-Gm-Gg: AZuq6aJ6KEXvVEtEW98pEr+/CT93GOhGnOmFVJ9xKI0JU2I+mZiWvfyKGNFXZalAahp
	wvhCs1B/czDhUCuc8nXuaCnglPgrZXE+B9zZ8ccHmz1qjKxb0eGPhO2KisvyaNUZUwV2Z+O5xrq
	qKUq5jUm2WPDQZD6O/aRPjNFkE19UaPRBK8Dahq7T4RF6obCzVh+Mc4QAT6hPmlJgLb/cZHoZZM
	dGGda5yGGbqFuOZGoVVGeKI9YIndMaydZcU1sFFllk34ho1WdWTmYSlH+GrBYI2wGav7dvYRmqI
	5BkgBpmqG0/4RQblEwwX0YNVvruZ+ng0eAA1rgyC4OLpJ7COyMM1j1kXJ+1nAuh1dqZkB3DIaaC
	1/OCplUxlwfsy0TbBOChNTW3cQ938SRQa/lMvmkwzl3YjwfmttrWKeCXXQ5cc9e/HsTFVVvCIbH
	L/gOxX0enhln/4aEGeBjhwjr0uHALKyprs51YPuScbeMA=
X-Received: by 2002:a05:600c:3150:b0:483:b3d7:2e87 with SMTP id 5b1f17b1804b1-483b3d72f25mr43253175e9.10.1771861633331;
        Mon, 23 Feb 2026 07:47:13 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a8df83bcsm223479215e9.13.2026.02.23.07.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 07:47:12 -0800 (PST)
Date: Mon, 23 Feb 2026 16:47:11 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Tejun Heo <tj@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Lennart Poettering <lennart@poettering.net>
Subject: Re: [PATCH 2/4] cgroup: add bpf hook for attach
Message-ID: <tmihfspwvvxv6sle27br4dgsbvepacnqj74zfscndkz722ssby@244dku2izea7>
References: <20260220-work-bpf-namespace-v1-0-866207db7b83@kernel.org>
 <20260220-work-bpf-namespace-v1-2-866207db7b83@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6ticusy7dzjxckmp"
Content-Disposition: inline
In-Reply-To: <20260220-work-bpf-namespace-v1-2-866207db7b83@kernel.org>


--6ticusy7dzjxckmp
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/4] cgroup: add bpf hook for attach
MIME-Version: 1.0

Hi.

On Fri, Feb 20, 2026 at 01:38:30AM +0100, Christian Brauner <brauner@kernel=
=2Eorg> wrote:
> Add a hook to manage attaching tasks to cgroup. I'm in the process of
> adding various "universal truth" bpf programs to systemd that will make
> use of this.
>=20
> This has been a long-standing request (cf. [1] and [2]). It will allow us=
 to
> enforce cgroup migrations and ensure that services can never escape their
> cgroups. This is just one of many use-cases.
>=20
> Link: https://github.com/systemd/systemd/issues/6356 [1]
> Link: https://github.com/systemd/systemd/issues/22874 [2]

These two issues are misconfigured/misunderstood PAM configs. I don't
think those warrant introduction of another permissions mechanism,
furthermore they're relatively old and I estimate many of such configs
must have been fixed in the course of time.

As for services escaping their cgroups -- they needn't run as root, do
they? And if you seek a mechanism how to prevent even root from
migrations, there are cgroupnses for that. (BTW what would prevent a
root detaching/disabling these hook progs anyway?)

I think that the cgroup file permissions are sufficient for many use
cases and this BPF hook is too tempting in unnecessary cases (like
masking other issues).
Could you please expand more about some other reasonable use cases not
covered by those?

(BTW I notice there's already a very similar BPF hook in sched_ext's
cgroup_prep_move. It'd be nicer to have only one generic approach to
these checks.)

Regards,
Michal

--6ticusy7dzjxckmp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaZx2exsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AhAeAEA8Aq7m0kUaH8/11aeQCi2
Kcf9qiMNA7emVmbHom+CgsIA/ArQMUoO726+PLAGwdRfAUfSOtGMOCgl3iEeMphP
OqYP
=fksS
-----END PGP SIGNATURE-----

--6ticusy7dzjxckmp--
