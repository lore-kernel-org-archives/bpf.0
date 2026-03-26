Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9294C34F48A
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 20:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774555615; cv=none; b=qSH2jxQpI7eK7Zpc2zJ6jQuK+lljuNgR7WzbgZ3q81V249zo7bOmkTgzZ0fiWe0Er0QKVTy1TizmRplvSin/0vvgc9HQEbVGlJfY5dCjK9oMFVSjHZ7kj22hBGWg8I4bp+VOfoW2hmdTLukWWCMp3qs3xatt/ABChcbNLhTLXEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774555615; c=relaxed/simple;
	bh=jj+yorpeEBxwk+7nym3Vu8xagBVeQ+tug3rKRqZFhbU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=io/GzTA2TGRfUMQDJ6RawJpdYbJnGz0JVfd29FGd5M0i2d2RIJelVtV9M2oZXZi5dOrnAEjHGQUzWiqItN8t8BokzrWQT1q38frSZ2XbHDmJk5CkExcnuUugPmuuxeN72oob49/SqxhZQCNkwcVy3Racz1HMTeMIDp6IBGtXWGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lZiTYQ6K; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lZiTYQ6K"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-127337c8e52so1019881c88.1
        for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 13:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774555613; x=1775160413; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q39vkXCHwVXHxLZOMIlHqDW4HE8OruDbuf0XK+bdxP4=;
        b=lZiTYQ6Kyz0T/yPpRU+2Ues0ncOW+GZ8GrSdz9B5oe/4TO36d9Ev8LUF8ozT8UsAHd
         2bjYRDZ3tiFtL7tXngPxVo8KHGLnfj9Aj3pVdD/+Xcc8IQ95oRsE7B8xRrgyQowML9dw
         qHSTkk5cAotTvdMS4d7EOVfKI1ZcKPyReHPbSanRuWfrxB/Dedsb7i+hStuMvIV3BEE1
         uE1LfztRPH3kETgM/+rYr2JyHnGu+ig1uWp2hjgJ3tYF4HUnE5XV5xlClzEO+7B3nJEA
         UlfD7isuxSZXtc6vWE7NEVDt6oCIbop+EGUh/HTcGHPuVP15IcqVfi33sCVcfIqtjh/R
         uSXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774555613; x=1775160413;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Q39vkXCHwVXHxLZOMIlHqDW4HE8OruDbuf0XK+bdxP4=;
        b=ab0WBhG6i73nS8CoLxs0JZ9yOGM5M313UOim2t0w0pxgCXYYO2Aan4WQfO2anOnydh
         M2AOvlJHXr20xbD1UnBZY/QmUPFKyDdtn2SSK48nHzNEo8GtsXpiBusUdIOuxgW8u1B8
         QhptYLS56emJ79eCg3kRwmjNX7f3ReSh9KmQTI912WvpDiwyPX2Aw6v2rMBCs7IhRcCy
         HvHl3CL8CXz0QzaaeXy0jJMjEhRgaqi1IpoGd2Qk4Mp+y1E/sgTnz6+OYUN7pFCtPl/j
         ziyhSVJkthuZJvPARcRnb4Tvpf6YJbM8FCpqcIrfzvFVA9eO5QlLVrmYAeAnKQ7IEEox
         m7Rw==
X-Forwarded-Encrypted: i=1; AJvYcCVGpGhKdCswIgxEiSQlyiFSB8p9gOAkTM+cUtYDtfYQYFQlVvlk+OvvlIlrme4Yb+9aXIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgVA00y7TEkYYlwW6BliAANsExTKX21yyFuo7KwN9+BxD26JRl
	smQevrrMXGUC06lvYMgY587+b5Etd1hRvc0js0QLm3JOtz8U7sfnKgMibRc5xUxc0Gi3eSir5NE
	2NyBUFeb1s5MXdbP3aD8EpYIcxBxgUg==
X-Received: from dleb3-n1.prod.google.com ([2002:a05:701b:4243:10b0:12a:86e5:44de])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:125:b0:128:cf5c:5362 with SMTP id a92af1059eb24-12a96e5cde5mr5257574c88.12.1774555612457;
 Thu, 26 Mar 2026 13:06:52 -0700 (PDT)
Date: Thu, 26 Mar 2026 20:06:51 +0000
In-Reply-To: <20260305-module-signature-uapi-v3-0-92f45ea6028c@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260305-module-signature-uapi-v3-0-92f45ea6028c@linutronix.de>
X-Mailer: b4 0.14.3
Message-ID: <177455561121.2009594.1781899946157697823.b4-ty@google.com>
Subject: Re: [PATCH v3 0/8] module: Move 'struct module_signature' to UAPI
From: Sami Tolvanen <samitolvanen@google.com>
To: David Howells <dhowells@redhat.com>, David Woodhouse <dwmw2@infradead.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Aaron Tomlin <atomlin@atomlin.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	"=?utf-8?q?Thomas_Wei=C3=9Fschuh?=" <thomas.weissschuh@linutronix.de>
Cc: keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 05 Mar 2026 10:31:36 +0100, Thomas Wei=C3=9Fschuh wrote:
> This structure definition is used outside the kernel proper.
> For example in kmod and the kernel build environment.
>=20
> To allow reuse, move it to a new UAPI header.
>=20
> While it is not a true UAPI, it is a common practice to have
> non-UAPI interface definitions in the kernel's UAPI headers.
>=20
> [...]

Applied to modules-next, thanks!

[1/8] extract-cert: drop unused definition of PKEY_ID_PKCS7
      commit: 137676d4482d8b8d755890b4ed29fe8223661d20
[2/8] module: Drop unused signature types
      commit: 8988913aacee82e5401bf3b96839731982dcbde7
[3/8] module: Give 'enum pkey_id_type' a more specific name
      commit: acd87264af525dba6e9355310e8acdf066a5f6b5
[4/8] module: Give MODULE_SIG_STRING a more descriptive name
      commit: 2ae4ea2d9aaf25cb74fbc23450b1b8f0a5b7aa89
[5/8] module: Move 'struct module_signature' to UAPI
      commit: f9909cf0a2dcc9e99377f3fcc965ccd93e518e34
[6/8] tools uapi headers: add linux/module_signature.h
      commit: d2d7561dc656748f592cc34d34bf5db8d5c67f7b
[7/8] sign-file: use 'struct module_signature' from the UAPI headers
      commit: e340db306c3bb85877490f33a78eb80549ac43a7
[8/8] selftests/bpf: verify_pkcs7_sig: Use 'struct module_signature' from t=
he UAPI headers
      commit: 55722b3f80377103bac6ac748554129108c75651

Best regards,

	Sami


