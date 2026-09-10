Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5D158B6D0
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 18:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789065939; cv=none; b=NcKmwODgPznDzod1L7QlrqRY/ZLy3ofMp3KbWtHJhE7DAWgjk/N+0uUNhlHKDINPNd9sPoYegQR5q0CwAwKkqAzI2tL91tMTGZ+xPbvSlJRAfyX7ojIoiirk76Xy1X1pAdB7dzAYcUFaAa+qurKX32Ij1cioGHtVbUQ6WxCdCtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789065939; c=relaxed/simple;
	bh=tRv3jEULtdOYi8WbaUBjWk/IvnVsuLC84zAFIsk2QG4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iM2+Z6N/Q+FmM9MvUkvrK5Y8KM4jQrpENo5JNhURsjreNMA8SFRiX364+M5o2WFjT1lkSwnzIWjX5D6etMQDrihLKj2q7kXAPiy0CyBwzKUFPYn1TEDzsQsetlGN1S2h6UjMnItQiQIkSNQHYe9+xIOpk1pZOV4NFhuHgLD8dBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i6oX3sAY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i6oX3sAY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14AE51F000FF;
	Thu, 10 Sep 2026 18:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789065937;
	bh=7aQGb2g92/DQwy2fFbuwC6JDgzjzBQuJBTqs+uwYTjM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i6oX3sAYLldQv6RtsnKNF12OOtBO6lQDH09e72x7JhkPj+urVXLxPvTEmMiOC5TVB
	 daFmhrlMejEoeOJP2wp5yJVg1nPTG5kLRmh4N4D4Z6QPZpnll8a4hOguYPeTytAL5/
	 pYfH6rkC2vJ1ok0VPvugzSLO+uZ4HiAZY+LTH8SlP32/DMgA3TsIG/5Ogv3nU9LYnG
	 /bThkJgl2DlEHWO5buMp/pvJVBI21Sp8smr30vBW+o8WnLmrba3AQKNhAoEdpdpvZO
	 +pkw0qpqO+k6zZHcBASi4UD6rmIXxv1WgnooF2tcZtBn1wdE1ZF5zvGjS11AdoGdRL
	 10l6yr1WoOC9g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 3/4] selftests/bpf: Adopt
 bpf_program__add_flags() helper
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260910183222.307208-3-toke@redhat.com>
References: <20260910183222.307208-1-toke@redhat.com>
 <20260910183222.307208-3-toke@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 18:45:36 +0000
Message-Id: <20260910184537.14AE51F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Missed replacement of bpf_program__set_flags() in kasan test, co=
ntradicting the commit message.
--

commit ccc6f4464177117b4b9c440f9349d856ca5fd357
Author: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

selftests/bpf: Adopt bpf_program__add_flags() helper
   =20
Adopt the newly added bpf_program__add_flags() helper everywhere the
selftests non-destructively modifies program flags (which turns out to
be every use of bpf_program__set_flags() in the tests).

> selftests/bpf: Adopt bpf_program__add_flags() helper
>=20
> Adopt the newly added bpf_program__add_flags() helper everywhere the
> selftests non-destructively modifies program flags (which turns out to
> be every use of bpf_program__set_flags() in the tests).

[Severity: Medium]
Does this patch actually replace every use of bpf_program__set_flags() in t=
he
tests?

Looking at tools/testing/selftests/bpf/prog_tests/kasan.c, there appear to =
be
two uses of bpf_program__set_flags() remaining in serial_test_kasan():

tools/testing/selftests/bpf/prog_tests/kasan.c:serial_test_kasan() {
        ...
		bpf_program__set_flags(prog, BPF_F_TEST_RND_HI32);
        ...
		bpf_program__set_flags(prog, BPF_F_TEST_RND_HI32);
        ...
}

Should these also be updated to use bpf_program__add_flags() to match the
commit message, or was there a specific reason to leave them as destructive
flag updates?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910183222.3072=
08-1-toke@redhat.com?part=3D3
