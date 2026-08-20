Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E40411A10
	for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 15:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787240210; cv=none; b=cQfORclBZ/l2I7bbO9ZqeFqk8CzhUH4/xFV0no3ORGB4BHRyVxHboDSzPR3ia4iswdr/FcjwQRIF16MG0JNRP1vxlvEAB/EPV977U5RCbvzq0vspkQzN5EsUUQ6DgpLWGQcAtQlHt/Pq7xCRYpX2N7sug1kLY5HuuNbtlM7SzwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787240210; c=relaxed/simple;
	bh=XVoAvJe2Kj54DJ/t1lw2AkENK6Y+oUH6ExQ7xyMUgUU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qT1rYViZXAoQXFcXY3QvC5PVwuAPKy04Y6ydd0lmw3PYhPG93vcRcZrn27Nfn6I5NvLT2GEJj/ykjtvsGf69Cb0XNkIX6uuOrqnksWMMaZx4HGIOjysApiMtE5XxZ7kEwyYyG+n2NzmheZ3JrXtgaMRvrw8o5A53/NTGXlTZqgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ea2+ZKVa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ea2+ZKVa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 282E51F000E9;
	Thu, 20 Aug 2026 15:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787240209;
	bh=rpxdsNtElvoQ3FkzVTjYsjsq0kx6D9sMZP7ee4fOnFk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ea2+ZKVa6HoxjhG2fnMNwqf85dBbUCF0cKP2SmWjvWbOehFKUdc2+iw1miusKncfg
	 mlmmZmMhCMH6D46pdwRQZ/EuaqZA9jwCCSMGgC7k44YRidFexTF5V4dwWh//Ppxaan
	 TXSQwT/Iuc3LwTQixd9jONhGoZLbnZTcKyEJUrTaD/M5dghLD7S65jpHUTQXXHOtjR
	 2B+3PoU1gGpWn+gjzidIfKexjGANas3Tm5bDx58XvZd/oilbC90Q0K3W5D3TjQbRBn
	 qcic6RqyAHTjM15nykIIMf6PUDjws2YMHw/wFIcB7YBdWbRjG+nG9I7c5sMq4+C+sG
	 9M46ff273ZysQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/5] selftests/x86: fix Makefile dependencies
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bill Roberts" <bill.roberts@arm.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260818225428.1983328-2-bill.roberts@arm.com>
References: <20260818225428.1983328-1-bill.roberts@arm.com>
 <20260818225428.1983328-2-bill.roberts@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 15:36:48 +0000
Message-Id: <20260820153649.282E51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The target `avx_64` has its extra files dependency declared twice c=
onsecutively.
--

--- Patch [1]: [PATCH v3 1/5] selftests/x86: fix Makefile dependencies ---
commit d009708fbed1c85db2f909f2fe20cdcff1a21a01
Author: Bill Roberts <bill.roberts@arm.com>

selftests/x86: fix Makefile dependencies

This commit updates the x86 selftests Makefile to track dependencies for
compilation targets that use EXTRA_FILES. It uses the extra-files macro to
ensure these dependencies are correctly evaluated during the build.

> diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftes=
ts/x86/Makefile
> index 434065215d127..a9a229f83b771 100644
> --- a/tools/testing/selftests/x86/Makefile
> +++ b/tools/testing/selftests/x86/Makefile
> @@ -124,6 +124,10 @@ $(eval $(call extra-files,test_syscall_vdso_32,thunk=
s_32.S))
>  $(eval $(call extra-files,fsgsbase_restore_64,clang_helpers_64.S))
>  $(eval $(call extra-files,fsgsbase_restore_32,clang_helpers_32.S))
>  $(eval $(call extra-files,sysret_rip_64,clang_helpers_64.S))
> +$(eval $(call extra-files,amx_64,xstate.c))
> +$(eval $(call extra-files,avx_64,xstate.c))
> +$(eval $(call extra-files,avx_64,xstate.c))

[Severity: Low]
This isn't a bug, but is this duplicate declaration for avx_64 intentional?

> +$(eval $(call extra-files,apx_64,xstate.c))
> =20
>  # check_initial_reg_state is special: it needs a custom entry, and it

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818225428.1983=
328-1-bill.roberts@arm.com?part=3D1
