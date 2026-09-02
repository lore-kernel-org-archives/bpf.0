Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9B04A4832;
	Wed,  2 Sep 2026 15:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788361296; cv=none; b=SEDn4okrS9CkB7S9Z3lUXVSxvSXL5hNFFbBjwJZXumL5p/ZDXOwGCy+cDEfiSvckvH7OBrABEquoM29Y7xp+skhiFiD3/UiD8nz8atfjh6WVQ7U3VJB7d89cCDyTJyQA40bl4wvZCj/rw59L5u8RHnh5+kdphkrsm0gPdh1HVcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788361296; c=relaxed/simple;
	bh=uGMuJl6pFOdqMJuR5jnrv80kTunYAta/dXyIVb6Gb0Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oL1U8ouqJFfqhWHOgjCzm6FgpQ+5eDm6shjFFtkJ0RgGM5OVl1ogzq7fUPdSvRPeADqgT65AkDYmKUoMqU3tOlxK4vlB1qyySmoAE7mmJllUsR//XQy0irpyTeb6EwgBiaKkqj4MYCVZWhKVQ8NNE0Q412MExS7fsBEzO3SbdRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a6iwXJAD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a6iwXJAD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07A181F000E9;
	Wed,  2 Sep 2026 15:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788361291;
	bh=uGMuJl6pFOdqMJuR5jnrv80kTunYAta/dXyIVb6Gb0Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a6iwXJADTFyXMJw7bDLN75/9P8pDr9ik5wEhaVIkO1awz0igJs07+4GLlqQQ+CFQj
	 OEbo+sr01JZ9wq9LWfMTPFfqjsLGGdiBk/2JNQLMUOcKUsjvUKDCjehz1sfuNwdc8R
	 g6+MKTNyCgp+ky2u5F86ZJ17G08Vxj0AawdLvpPei8t86vt9qJlt3U7iMaOWw/L/5e
	 z6itqYL9Uchljf76aJT48n4oWF64Hd68rgNN3/NRjChjfraEwKuDyJxO63OeMm9A9X
	 RzAzOFcPTz4CDvV/THqcnB2FgnVF1MzfWdHsdkmpyTBbzGblyAQIWu3vbE7PX0rkWC
	 sN/SnMUKG3+Lw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 11/13] sparc64: pass pt_regs to audit_syscall_entry()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ricardo Robaina" <rrobaina@redhat.com>
Cc: audit@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <336fa8f8d896ca7989bc483b53fdefe2152a16f9.1788351089.git.rrobaina@redhat.com>
References: <cover.1788351089.git.rrobaina@redhat.com>
 <336fa8f8d896ca7989bc483b53fdefe2152a16f9.1788351089.git.rrobaina@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 15:01:30 +0000
Message-Id: <20260902150131.07A181F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

> audit_syscall_entry() now takes a pointer to pt_regs and extracts
> the syscall arguments itself via syscall_get_arguments(). Drop the
> individual argument registers from the call and pass regs instead.
>=20
> Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788351089.gi=
t.rrobaina@redhat.com?part=3D11

