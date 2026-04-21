Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0527F351C03
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 20:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776802116; cv=none; b=Xmz0BAY5oOHTADd0/eY3wjcGm/auc0Hfb2HdFqgHdiba9XYpT+4toL2vubQhbWxa4uCK4FN7Jgk20zZuw6j3oEcRNPcHsjBcXU0TB7+grYt6FaZ7Augdlc84L4w9+bJ+bO96vGvCM+lXzP0fX92yR8hCq87SZGktTLcjLvLhgNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776802116; c=relaxed/simple;
	bh=NibhS0PQpmzE1P5oLC0CecxWIzXW+WiLIbScXAU36bQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EQkAdzolwSTs4lbDcPssZ2voC/DJuinS/BnoWZcKTAzHHKbMK8qNMtRIuViQvyt57FZ9bldSy9RJLwhKid65Dwm9O+0ush4zhpwR5K94QT5542bgcRIiy0LNRdRy+tYeXHOH5x1ws4psVBpE6rHkcmp5bsFrsssXNwkxcMtgwbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BNIDFT9e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BNIDFT9e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D7EFC2BCB4;
	Tue, 21 Apr 2026 20:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776802115;
	bh=NibhS0PQpmzE1P5oLC0CecxWIzXW+WiLIbScXAU36bQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=BNIDFT9eSJST7nbcIVJJjybBqApBtSSrKyOdd1dZtiC7Na2+Nnt6ZqmkxEy8p9cyA
	 w0zlaypPoy7Euzn3ZGfzqjhW40xonLBc/BP1MoKxAsw0se+DHx7BeUqnAci7CBKaaJ
	 Xt1crer81//kqcrAfh174o3yZXA/rRsC/KAXyc9aH8/bpjF+XkWBPD8O+sf3Uq9Fn2
	 PFzFrd/WNa+owrA3eW1r29Cts5CYUAcDkFmqSxUCwGKDfdkYe6MCUEVnQlF5TqDZVH
	 9mMKKgIwCfedhJEuoQqBXy3YJaLL3I3avmquu+ElUmQM5TOcA91GK65H32eXwWjPNX
	 xFVtdG6Mwqg9g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v8 2/8] selftests/bpf: Add basic libarena
 scaffolding
Reply-To: sashiko@lists.linux.dev
To: "Emil Tsalapatis" <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260421165037.4736-3-emil@etsalapatis.com>
References: <20260421165037.4736-3-emil@etsalapatis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Apr 2026 20:08:34 +0000
Message-Id: <20260421200835.7D7EFC2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Low] Cross-compilation breakage for `test_libarena` due to missing targe=
t flags when using `$(CLANG)`.
--

commit 8ad4036d8952c8f966e33882412f2b6f18aee582
Author: Emil Tsalapatis <emil@etsalapatis.com>

selftests/bpf: Add basic libarena scaffolding

This commit introduces an arena-based BPF library scaffolding, including a
test runner and Makefile. It sets up the standalone build for libarena and
adds temporary workarounds for bisectability.

> diff --git a/tools/testing/selftests/bpf/libarena/Makefile b/tools/testin=
g/selftests/bpf/libarena/Makefile
> new file mode 100644
> index 0000000000000..304197e8a22f6
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/libarena/Makefile
[ ... ]
> +all: test_libarena
> +
> +test_libarena: selftest.c $(BPFOBJ) libarena.skel.h
> +	$(call msg,BINARY,libarena,$@)
> +	$(Q)$(CLANG) $(CFLAGS) $< $(BPFOBJ) $(LDLIBS) -o $@

Will this cause a cross-compilation breakage?

When cross-compiling, $(BPFOBJ) (libbpf.a) is built for the target
architecture using $(CC). Because $(CLANG) is used here without
target-specific flags (like --target=3D), selftest.c will be compiled
into a host-architecture object.

Attempting to link this host object with the target-architecture
libbpf.a will result in a linker error. Should user-space programs in
selftests be compiled using $(CC) to correctly target the cross-compilation
environment?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260421165037.4736=
-1-emil@etsalapatis.com?part=3D2
