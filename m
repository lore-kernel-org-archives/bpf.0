Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FF33DA5AF
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 15:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789485370; cv=none; b=eaYzRQoxUnlu6xmr9XPnH77NyETIIwzYIOpfCLowJjklzEuk2TDKR3ejX7WxNNcNui0KbGheCDZ82ipfC9a9QwO3nvy+6j8wwMadIs3sFfH6oiSaWFMCByzH7ZFAuU0Ms3I/G8PPQhMCkbvhxMxiveO3lTwlztF63TkdiJ+GTys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789485370; c=relaxed/simple;
	bh=VsMUDpdoNZJulHX4bIiBk+TLTKrd7GdJvOwiUQL8k1M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DOuWmrKgLUB35zciN1e/pELrl/S3befG+cvHebPoyuUyV0RNMvvTTikjIJoxGL2eWy33y5/Xc5eHQ3K321Py1jbf/pzRdjvj31vmE3xO5ImEEWbCWM6KvFPbwglbyxONdood6Upz1pJ7MFzYZGXwI8tr9D7FkXruUa+BggOKzRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PnZE2tAZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PnZE2tAZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 481C41F00893;
	Tue, 15 Sep 2026 15:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789485368;
	bh=VsMUDpdoNZJulHX4bIiBk+TLTKrd7GdJvOwiUQL8k1M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PnZE2tAZUpdh4fyo1Mt2/msyoI4ix5WymU0vn76b+edGuOMujAFOun8A+jcopWAih
	 c1t5gPq+B8qvHLLd8YxdqCOqUzBNdd9g1S53e16AyRkYsBn+rGAHUEfhoB3VoFI6Sz
	 NDranMS8IipyGIhnygHgy+19fM1ODO2RTZ6jnLg1ZyEo1iOe/1t/cWqCgME8rTUU0h
	 GP9LchxwSiJtLTy6sTU4tg37djWE6db9r6yv/hdrPsUWg18R1og8KNyIlNoQbOqSpn
	 fKZdGusm2NfMDWDgUe3k/MXNVVAfoTcwI3JEscTt8BlWNDAqvnOGeAkuT/3cKkxL3Y
	 GTIgEMHRTPNMQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 1/8] ocfs2: Copy the xattr name in
 ocfs2_initxattrs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Borkmann" <daniel@iogearbox.net>
Cc: "Joseph Qi" <joseph.qi@linux.alibaba.com>, bpf@vger.kernel.org, "Joel
 Becker" <jlbec@evilplan.org>, "Mark Fasheh" <mark@fasheh.com>
In-Reply-To: <20260915150739.284189-2-daniel@iogearbox.net>
References: <20260915150739.284189-1-daniel@iogearbox.net>
 <20260915150739.284189-2-daniel@iogearbox.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 15:16:07 +0000
Message-Id: <20260915151608.481C41F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

> ocfs2_mknod() and ocfs2_symlink() ask for the security xattr up front
> through a struct ocfs2_security_xattr_info, so that they can size the
> transaction before setting it. ocfs2_initxattrs() duplicates the value
> since the array security_inode_init_security() hands is freed on return,
> but keeps the name pointer as-is, given so far every LSM stored a string
> constant there. bpf_inode_init_xattr() places the name in the same
> allocation as the value, which security_inode_init_security() frees on
> its way out. Copy the name alongside the value and free both together.
> This is the only special case wrt xattrs in the bpf_inode_init_xattr()
> context.
>=20
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915150739.2841=
89-1-daniel@iogearbox.net?part=3D1

