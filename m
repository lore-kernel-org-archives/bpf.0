Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA17384227
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 23:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776726809; cv=none; b=o/ST4sStb3/bMbsy20fnkX+yr6gzY9yLeJixAi2SkBxoJ0z3NfGhgEKZ+CwPvojvj7CputrTs0rUVKg8TdQ0mRyxgNu9ZNAT14bTe+0RAUkG0M6mE1ZQ34K2YWfmHwRppFvjTGyEVhgY5P5znDvjyC+FRPY3uo9lKOhV/9mHgsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776726809; c=relaxed/simple;
	bh=/DL2a1YiI+9Smr2FpBbvvpYrBxIsDAT+LtDzIjfvt60=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=B95Qlvk2im94pzLqNJRY9IrlyJkvl1IKnFSnYzekf63ndalyMn2yBTU4QuX1G+TvEB+e9wyU0nZPOZd5cG8kR1rTgl7tzcQX+FGVFpbI9kV2NQWbOwyEsRe2qykJVkq5hkgzJ2QzI6LUTjXz0gYoqq8p0gDbG5RzzKf3cuhyTiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJujXEMg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJujXEMg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68FC7C19425;
	Mon, 20 Apr 2026 23:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776726808;
	bh=/DL2a1YiI+9Smr2FpBbvvpYrBxIsDAT+LtDzIjfvt60=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=CJujXEMgfanYNCFxIPrwP0XLdmpwPbSXZ05ZYXUXFBK3OgC7CF0Xt6xNUJfAhxJbK
	 v+iLpH3n0odGnLIV0R+WmDuVUNrV0Hoh8lmzWEZ2ZTx6sLZhQn14w6vnU/1pV94iaC
	 Vz/3RUI5+JN4COCIKHOC1REf2x3cI4/GUruiNycfc03yPIR9Eao6AZauJ9r3ThVqdS
	 raM93i8AiJ7A5X4Kz8gNIKiWSh4/ZGp8v3pWhuq7kVjqgL8EVQfFJeCZEGniYa1Jlm
	 TdjXmzBSf+WAse9xlLtuAiYzQ5zRrpmS+lnOpa1OcCslJsEMQvP5qyCGHd6Hj+dBGu
	 zoBY628FkTm7w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] selftests/bpf: Page out as late a possible in
 file_reader
Reply-To: sashiko@lists.linux.dev
To: "Jerome Marchand" <jmarchan@redhat.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260420134637.2513867-1-jmarchan@redhat.com>
References: <20260420134637.2513867-1-jmarchan@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Apr 2026 23:13:27 +0000
Message-Id: <20260420231328.68FC7C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Low] The newly promoted global variable `addr` is declared without the `=
static` keyword, polluting the global namespace.
--

commit e2c581de007abac2e6985b4f49f6c9786c3263b0
Author: Jerome Marchand <jmarchan@redhat.com>

selftests/bpf: Page out as late a possible in file_reader

The file_reader/on_open_expect_fault fails consistently on my system.
This commit moves the call to madvise(MADV_PAGEOUT) to just before
attaching the program to minimize the risk of having those pages pulled
back in.

> diff --git a/tools/testing/selftests/bpf/prog_tests/file_reader.c b/tools=
/testing/selftests/bpf/prog_tests/file_reader.c
> index 5cde32b35da44..48aae7ea0e4bb 100644
> --- a/tools/testing/selftests/bpf/prog_tests/file_reader.c
> +++ b/tools/testing/selftests/bpf/prog_tests/file_reader.c
> @@ -10,6 +10,7 @@
> =20
>  const char *user_ptr =3D "hello world";
>  char file_contents[256000];
> +void *addr;

This isn't a bug, but BPF selftests link all prog_tests/*.c files together
into a single test_progs executable.

Since modern compilers use -fno-common by default, could this un-prefixed
global variable cause a multiple definition linker error if another test
introduces a global variable with the same name?

Should addr be declared as static to safely restrict its linkage to
file_reader.c?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260420134637.2513=
867-1-jmarchan@redhat.com?part=3D1
