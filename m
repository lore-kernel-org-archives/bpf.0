Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A0C39B970
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 21:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779141352; cv=none; b=KTAlGO7Osm1Gs1SBKSHmdYCnXII4wgsd1h4h9/yDN7fXk3F52wnn+dDy+T8A5HgGWqpbw1h+TdyfatAilKMHcUtn5YtqN61TNh7l72UOtXu+El431mWhm+edXiu0FUXIJWzfvXCitTAfVosN9S40LxZ72MpqNdlftuTz+c7xF5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779141352; c=relaxed/simple;
	bh=WhaVFwVRm1Wf4thmzuA0e0qjOQLT9x+04R1dduxYWzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LPIUVyhvg4b/nFmMwm+ybax3d0ciGsRDD94O9xYhnTsm6ihuj4dYg4Q3Nsf8inAHPWoGhiPEikNpGKshpRs9x2v/SbqHMuhjkjRQfxxO53XFXkMJbN04OULEUuIJ2n3s+xTfvTeD7JospRXrnwoMU8L9jPSCxO40UEDlNyZCWfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IvoDbo4V; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IvoDbo4V"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2b46da8c48eso1575ad.1
        for <bpf@vger.kernel.org>; Mon, 18 May 2026 14:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779141350; x=1779746150; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eATlafWR2CpUln9HSfV3CyzBd2Vyaqeh6UVZyYqlodE=;
        b=IvoDbo4V1nj4Q9OWvBMcUPpA6eDFfBAFbu4ry1ujeKWH4fYBAFNjP7BApepEoXKgFW
         echIH2GbEhb+kGhHlHfftLXlBnHDih1oHm9UtaSSK5CAFRUvXh1PCqOj+XI9wKqJnmv9
         BdHZsxEJDc6k4l629t6bytiQfWInZt6CAKX455PJMRgqGvsL+3fHb7ubaoj1OjP5TMpJ
         apWTAqJbeutKX9DtvRx+hRvKlId5JUFry4JYzoUpiHudyEvfAoPlfnA1GOb/KpKOehgq
         VY2sjO/zadidGT8zNRrbzepfosggp1gNZrno+6RpVU2wOW8V9Y0N7qAHPHbOdQPTZ4W2
         afYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779141350; x=1779746150;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eATlafWR2CpUln9HSfV3CyzBd2Vyaqeh6UVZyYqlodE=;
        b=itzJj3c/6i69WZG8MsAnC4r48ZpHJZQ1LcwsGu+TVPdPOyIIT0dbF0PS5J0UrsQgfE
         b7wwwCEfarjcOPvg4K/1JzADxpef08QMGC/3qA0axF73WU/SOWp5Ur4HxL/8FcRcZOeG
         XGrFHYNL2TSnkSF8adJzXeT3RxLBVgwGimGIFORXWL6n5mratjknn3iboc0vrgjM8awn
         ge7MfU9y5Y07XoIpxJbtl6KqP6uIlsiOYBClUjKfp7vr4ksGVKZ2WJLGN56XmQycKR1m
         Gg2r3ZsHGPYG8SPMM3vjE4WSnH8dYbUVEmH2VcdEyRm4p8f7iSmPQ0kypgygQIQQqKiq
         xAuA==
X-Forwarded-Encrypted: i=1; AFNElJ+8Qbn+iWHc4v6SLLqWX2wS1xsRZOXoUCKcFMHVh/+xM/x+RKZjIUnZMLlL0jyj/l0+zqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQXdGzFLa6FMueQaRWXs3CyCqc0Iusrjw04bVQxPYSRzgEexKA
	0qmTjIPKXth2+dawUnHRArakKvVyxIUC3i9AKS+d68HDYWW/0f6f91Po852EGz93Aw==
X-Gm-Gg: Acq92OFg7qOwH5XKQji+7FSQ8Gfnz1ePFKAoulaK1Rv/jHVpkYJSs9u9gwI8Z52cKDx
	gk7+epVa2l1MaSIDHrLRjOSdhnrwdK9V0TiihS9XRQPEpOvBBYqWF4xJW8K1ynQZWS+138+pi5X
	jWwZpl1fgx6yKnL8SXEh3bCdMHgDbtwRFTNpH6msQ2LwF1LTTKNeb9iBccZQMyBQJJwPH5S6JNE
	4QpzVVRw6rR8qyb4NHVyC1nByOV6aUapDfhUqqnPaN5Bt49A+AheXKqq/WgfSxjOuGaqKwuzmOz
	OUbbe9eNXglPzmKa2FXx7NdSyh+YbEjK1nVd6u0xmbr8QTYI8JFCiQDrhDbmP0bq8KwO+RHHl0e
	K9pnn5knmRGetCNaCCEA2ccT0ak8Bq99iI07ASlQaDzGjNhmeLrbfTCTRQ6lq8xw7BRGeiEPT8r
	BLRATaKTwD1T3Q5EajphdnCM0tdMDO3rkcfDY80xh529w0xEzv8fqlKfLgDukpVus3+j/Z1Z/N6
	dKtr5qGpa0foXNo
X-Received: by 2002:a17:902:d512:b0:2bc:dc0b:ab29 with SMTP id d9443c01a7336-2bdb0109472mr3880435ad.0.1779141349445;
        Mon, 18 May 2026 14:55:49 -0700 (PDT)
Received: from google.com (171.46.125.34.bc.googleusercontent.com. [34.125.46.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5cfe498asm164380125ad.39.2026.05.18.14.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 14:55:48 -0700 (PDT)
Date: Mon, 18 May 2026 21:55:43 +0000
From: Sami Tolvanen <samitolvanen@google.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Daniel Gomez <da.gomez@kernel.org>,
	Aaron Tomlin <atomlin@atomlin.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
	Xiu Jianfeng <xiujianfeng@huawei.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
	Fabian =?iso-8859-1?Q?Gr=FCnbichler?= <f.gruenbichler@proxmox.com>,
	Arnout Engelen <arnout@bzzt.net>,
	Mattia Rizzolo <mattia@mapreri.org>, kpcyrd <kpcyrd@archlinux.org>,
	Christian Heusel <christian@heusel.eu>,
	=?iso-8859-1?Q?C=E2ju?= Mihai-Drosi <mcaju95@gmail.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-modules@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org,
	debian-kernel@lists.debian.org
Subject: Re: [PATCH v5 00/14] module: Introduce hash-based integrity checking
Message-ID: <20260518215543.GA1878854@google.com>
References: <20260505-module-hashes-v5-0-e174a5a49fce@weissschuh.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260505-module-hashes-v5-0-e174a5a49fce@weissschuh.net>

Hi Thomas,

On Tue, May 05, 2026 at 11:05:04AM +0200, Thomas Weißschuh wrote:
> The current signature-based module integrity checking has some drawbacks
> in combination with reproducible builds. Either the module signing key
> is generated at build time, which makes the build unreproducible, or a
> static signing key is used, which precludes rebuilds by third parties
> and makes the whole build and packaging process much more complicated.
> 
> The goal is to reach bit-for-bit reproducibility. Excluding certain
> parts of the build output from the reproducibility analysis would be
> error-prone and force each downstream consumer to introduce new tooling.
> 
> Introduce a new mechanism to ensure only well-known modules are loaded
> by embedding a merkle tree root of all modules built as part of the full
> kernel build into vmlinux.

I noticed Sashiko had a few concerns about the build changes. Would you
mind taking a look to see if they're valid?

https://sashiko.dev/#/patchset/20260505-module-hashes-v5-0-e174a5a49fce%40weissschuh.net

Sami
