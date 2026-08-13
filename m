Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BFA4A2E17;
	Thu, 13 Aug 2026 17:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786641356; cv=none; b=EsCa62xIiZzH4dduoLR4nWo8zuAmcNAlNycoBSpUDICMkTlnSiANSiHEqpjEz51tyaDNm2P6qbFWankSmGE1hlTJbptDytayZJMFvnktfQJ3Q1bgG3GiOeSiQz0xDth0PwEG9ySQ7IZ7uXnwP1XvUAYqd2fDryYdR22mVz/xlbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786641356; c=relaxed/simple;
	bh=EIhbd+WIg9Vj5dmkl+b+Va7KkQ5nKe68jfzd0QjJSMU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gceBMmpvdTwZTPdx7u3aB8RsMiDhMFmieccsGTGWzznT/kSKynb5A8m88Dw1h82YERTVU95aAIPZFUCOQMwbxpI/RVWonqzjGTLimKlxyriIQDlEUhLZqXnyMAOYf2bRNdD0BIwNEpzGrGXGoOPfMvpbJsurMXj1cqCl3OwOFp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KKWRCN0A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KKWRCN0A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8A731F000E9;
	Thu, 13 Aug 2026 17:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786641353;
	bh=EIhbd+WIg9Vj5dmkl+b+Va7KkQ5nKe68jfzd0QjJSMU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KKWRCN0A2wr348IMzqcYotc/Z2hSo8SHk6u0JxSwA28vFhsMQgPR4ti0fuFpa4r5k
	 pQ0xWbU7QYM77exNnbJUGCAaoIMe7ZOi/veq8dYVg2msnNfrBcBWCtrM0lLJW75S0J
	 CR+DlL7bzSs/GGIwwWouRGdA6/NverlWodXAjTdbp3B1cdq1vAe1XoElEgbn9v1IrY
	 TqsPDPBPkHiVC/N9n0TLnsi4hTTo9JIL5iygjqM+4pW2k38NLtgrevGoItqbX64zNe
	 3pqeXxCbEkjJmNuziG+DFRn1tGXvY+LmkeSTEInBmPVHK+Drmrjq4FTg9nfXg0G8kA
	 1bpbJbF+oMaKQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/13] mips: pass all six syscall args to
 audit_syscall_entry()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ricardo Robaina" <rrobaina@redhat.com>
Cc: audit@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <212ca026f8a19f564f3b37b03d1d3e09e0de3e47.1786626275.git.rrobaina@redhat.com>
References: <cover.1786626275.git.rrobaina@redhat.com>
 <212ca026f8a19f564f3b37b03d1d3e09e0de3e47.1786626275.git.rrobaina@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 17:15:53 +0000
Message-Id: <20260813171553.A8A731F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

> Use syscall_get_arguments() to retrieve all six arguments portably.
> On 32-bit MIPS (O32 ABI), arguments 5 and 6 live on the user stack
> rather than in registers, so direct register access would be wrong.
>=20
> Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1786626275.gi=
t.rrobaina@redhat.com?part=3D7

