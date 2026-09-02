Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C101B4A33E1;
	Wed,  2 Sep 2026 14:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788360919; cv=none; b=d0UJfkhRPE1aZm1cGHw8PMTw1vSQkuMi2EJJzFJzLuh7eBXVhGvVcNe12somuAvqoZBFw3/eoyJVzUp2Z/IgfcL9bVs4oMqHMlJal2Yj0yWJQdNx9HA7Q+bb8aeQGtWBzbzsE2xE5Gg8pXpvqpXGB4GpG3dRGAJm5WPoM0QbgvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788360919; c=relaxed/simple;
	bh=gU6KB/Wq4c6PY9an3MPgba6p3en88mNjQlnZ27AAQI8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VnpZ4nMuKFFVsWDQEqQ3cuskd5OGIf5u3lnKWhcjyh4dGnAC6ZGLIBZSjKABDGhxTIex9335lxzb6PiXPyN89CoIbL/hgXe8sJe84xKSnHjqHQIFOXenKcELUoAhdD9/2t18+kijapLzij6dlmRCfzT7hYal+kaIzxmYqodSDC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n4ni1s43; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n4ni1s43"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32DF91F000E9;
	Wed,  2 Sep 2026 14:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788360918;
	bh=3q2L9UzhttkI+3c/vfT8oWBjqr9an2A8/Pp24jfCbqU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n4ni1s437HDIUwrtcGRDUNYc5QxnxzLBXlGOKcBMpatJLW/oY5Q+hTFbdP+rRy5EA
	 RdJ5pimVsF5GaBc1GB0ooK+DLzM1BN3LQBjb7Ms345Tw8XmXExYwqD1Q5dOEm4Xgme
	 aXXH7Knfgg18QJnOk7Svs9N6gnPXshTdwRdE560XvE93G9e4eUNGb6xoegAc6/IoNZ
	 QQALMjvCdLtsUxtt+nZpuWSJY/0CJQVUSc8+WTZ+iDMI1K1fr7qUMr8PTYdhxwLaBn
	 iXi7/U2sKVN278OeuXibQcpHZZyn9lR5xwrnSgn48aUEG8GT5Y1DyqHc2WEQu1a4Bu
	 0Zuve/m8RtA8A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 01/13] audit: log all six syscall arguments in the
 SYSCALL record
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ricardo Robaina" <rrobaina@redhat.com>
Cc: bpf@vger.kernel.org, audit@vger.kernel.org
In-Reply-To: <b30076994d49fa393251c836b5a57a725f218572.1788351089.git.rrobaina@redhat.com>
References: <cover.1788351089.git.rrobaina@redhat.com>
 <b30076994d49fa393251c836b5a57a725f218572.1788351089.git.rrobaina@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 14:55:17 +0000
Message-Id: <20260902145518.32DF91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

> The SYSCALL record currently logs only four of the six syscall
> arguments (a0-a3). The remaining two are captured but silently
> discarded before reaching the audit context. This leads to the
> need for auxiliary records when audit-relevant data lands in the
> 5th or 6th argument of a syscall.
>=20
> Extend the SYSCALL record to log all six arguments, by adding
> arguments a4 and a5 (5th and 6th syscall arguments respectively)
> inline within the existing record. Also add the two new args to
> the audit rules switch case, so audit rules can filter on them.
>=20
> Rather than plumbing two more register arguments through every
> architecture's syscall entry path, change __audit_syscall_entry()
> to take a pointer to pt_regs and use syscall_get_arguments() to
> retrieve all six arguments.
>=20
>  audit-testsuite# make test
>  audit-testsuite# ausearch -i -m SYSCALL
>  ...
>  type=3DSYSCALL ... syscall=3Dsendto success=3Dyes exit=3D1088 a0=3D0x4
>   a1=3D0x7ffe43518b60 a2=3D0x440 a3=3D0x0 a4=3D7ffe43518b4c a5=3Dc
>  type=3DSYSCALL ... syscall=3Dopenat2 success=3Dyes exit=3D4 a0=3D0x3
>   a1=3D0x7fffc74692c8 a2=3D0x7fffc7467390 a3=3D0x18 a4=3D0 a5=3D7fffc7467=
4f8
>  type=3DSYSCALL ... syscall=3Dopenat success=3Dyes exit=3D3 a0=3DAT_FDCWD
>   a1=3D0x557ced4141a2 a2=3DO_RDWR|O_NONBLOCK a3=3D0x0 a4=3D0 a5=3D0
>  ...
>=20
> Suggested-by: Will Deacon <will@kernel.org>
> Link: https://lore.kernel.org/audit/CAHC9VhSjEt_-Bsra4AEqWv+Daw5Ff=3Dgqy7=
dX4Ah11RVhdyCBUQ@mail.gmail.com/T/#t
> Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788351089.gi=
t.rrobaina@redhat.com?part=3D1

