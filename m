Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FCB4343F2;
	Tue, 22 Sep 2026 19:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790105542; cv=none; b=aBxtaNmXwsQQF0aBJVoVeRYvREjeFU/Cub4rbzEEn9S9hzdmMjaTjnOg+czYER93UBBEqfLvCscnhVW4i/HGn4PtW1K9oBuMfWbIOKIVer7OUgqPGwWjSV35Sqyg/awYSvadyrydk3d3OxWMZWkjSegQbk262UgxcOZl+pvb3/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790105542; c=relaxed/simple;
	bh=DadJ3RfMFTvEZGQ2Mco9nKRmNNj2GyAJVaPAUoiIQmM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iIdMYk/WKzbF/yjaL9ckhqlyyJP20q7skRezhVwZuQCwMHBISuSFwCOF9cIWOS6Vpzzi6ogxLUgroqPcrUUwTmZmcvP4dPmS5PCgmkIDAskFCtvMlKf4VxOWETuCUrAobkXu+49hBAB4235gV5I3v8YZHFwuVXS9bz+ZhyYbOow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N7YBgpj/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N7YBgpj/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA89A1F000FF;
	Tue, 22 Sep 2026 19:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790105540;
	bh=DadJ3RfMFTvEZGQ2Mco9nKRmNNj2GyAJVaPAUoiIQmM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N7YBgpj/KPB1wujQPZTMaei5jfhZkvZSrzSrifbXQv8nDi9R6Hv2RMHKe+vYNOPbK
	 DA2C0tkJl2MWEy2fwDIiupoDt6O+Oeg2FdgM/0wYRrxFmlE1qBRjXV2a+MlN3rzsO3
	 7AfXeshhTZkZK9iA+QdqYM4CTs7tzS7br3g/Fn0w9+AY9DYVUC0HJ3mhMxLpo5+5mh
	 uxhPPeEAvSrh4QyS7pTEOi4U8/0vfVIur1BC7NqxB9ZtKr/fVOjRDX28xDV9mOeCkW
	 Vc4XmPQeasOlISXI3LS39ch0M2e9SOJDtbcZCLEaRJEOrFaLvRccjKVYBQ9+LZ7qNC
	 xkB257ACTTRlQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 09/14] parisc: pass pt_regs to audit_syscall_entry()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ricardo Robaina" <rrobaina@redhat.com>
Cc: audit@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <385724169e030185dc9e0deefb52457ba5581090.1790088067.git.rrobaina@redhat.com>
References: <cover.1790088067.git.rrobaina@redhat.com>
 <385724169e030185dc9e0deefb52457ba5581090.1790088067.git.rrobaina@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 19:32:20 +0000
Message-Id: <20260922193220.AA89A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

> audit_syscall_entry() now takes a pointer to pt_regs and extracts
> the syscall arguments itself via syscall_get_arguments(). Drop the
> individual argument registers from the call and pass regs instead.
>=20
> Per-argument compat masking is now handled in syscall_get_arguments()
> (see the preceding patch), so it is dropped here; the syscall number
> still needs masking for compat tasks and is left in place.
>=20
> Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790088067.gi=
t.rrobaina@redhat.com?part=3D9

