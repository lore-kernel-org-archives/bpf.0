Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BA94A5C30;
	Wed,  2 Sep 2026 14:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788361094; cv=none; b=ZHSDP1bf6RbhQv3sHsPxTZ9I8dDHgFNRhgMoHlgkFSTS8zjfbXuWLOhuyQ+ZjFzIdd8YYFgVRRbAoYR7uoCV8g2LNcwvRhAgKMRFdwZgpdAWoBwjCCt48hM4sfbMZQC5k7jwPLV8Zhp3NBGLGhQd3/aDX7UDKv7X0BHwGi8EU5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788361094; c=relaxed/simple;
	bh=ERFBqOh23JFkD4Ywp/lwc7nWcjVw6F7GI6ncASV7x44=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DG/p6DcNSRnVoTFMg2eVy3rivF63JoeSecB56nD7EwL3QWGVHB9wHJvSN+8BpsBuIrIMZLxKV6jt4pJzwPixq8GoEp1dohHz63oFz2puncMuKpTUMInrswIyZsLNpMRNJ/ac+900orBCPRQvSKXHwrK93vpflbABoVmi7CPDHDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EuBM40fH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EuBM40fH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D22F1F000E9;
	Wed,  2 Sep 2026 14:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788361092;
	bh=ERFBqOh23JFkD4Ywp/lwc7nWcjVw6F7GI6ncASV7x44=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EuBM40fH4cvOPpBxVsBkYg1+kKPZCvaa6/KmLuZrl7W1306omf/maPR13HsJBxYXf
	 NPQ+pY+YYCSW9YeFyVGQqvrhE5P3QGUHmUerfHuOwTXI6LTKPZqwy3K0SGMLp48pm2
	 zA1Xc1ZAKKVY1gpvVVeGwtw7oLqeyG92sWrB/Gm79sWe5/8Wl9en9SykGvT0xNpMdr
	 hFlhiG/r2G2OBdf1pNoLo6Wdngg5Y5y5YNiAOI0cLqIE0gsdPganNkm4X+ygmIXghe
	 m5esmeQG89VCKhMVOkFNjIKKrQ6aj2/EjBIeFBUAGQ6/iY4WIBc5DpWMakoWm1zUY+
	 Do3VCuJOFFexA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 05/13] csky: pass pt_regs to audit_syscall_entry()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ricardo Robaina" <rrobaina@redhat.com>
Cc: bpf@vger.kernel.org, audit@vger.kernel.org
In-Reply-To: <83f97472fb90a20f84892b6686c2158027c3e06c.1788351089.git.rrobaina@redhat.com>
References: <cover.1788351089.git.rrobaina@redhat.com>
 <83f97472fb90a20f84892b6686c2158027c3e06c.1788351089.git.rrobaina@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 14:58:12 +0000
Message-Id: <20260902145812.7D22F1F000E9@smtp.kernel.org>
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
t.rrobaina@redhat.com?part=3D5

