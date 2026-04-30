Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980EF47798A;
	Thu, 30 Apr 2026 16:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777567314; cv=none; b=sSN92lQ4ZC0iifWQRzpl8asQoDhkLy0ioizlg6m9GeL8e3vYVE2Mhp7fLho8NyAS3JY1ATDN/DMJOE5yy2j1VN6dMwX+EBwgF4tf4RPhnAkqaTSRVlCCG+Uu9NNHAxEeHTV2PsLHVfeY6k8DtIAkzMzq6gX4JmStw+KrkCK8L/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777567314; c=relaxed/simple;
	bh=bweV+hs6Kqs0TVaYw7HTY4cXyIr9trJP3ovXUOJKAsw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=e9rayUi4aOsns+1vUSS9DSl2Nqa4EgJ3rzPDEjEEUwdrkRP0FPBwtt5ebFSc9sAdtQ32pjDwBi7d39IGjTtryLNdYHFX++ztlu9BNddPqYPtOiFFAYulwG+PILglLHLgNyiM5U2pyQ6eTTH4YqQOxdwhZ75pcXm7LoBpK7ZTVMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aK+N2cw0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aK+N2cw0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99674C2BCB3;
	Thu, 30 Apr 2026 16:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777567313;
	bh=bweV+hs6Kqs0TVaYw7HTY4cXyIr9trJP3ovXUOJKAsw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=aK+N2cw0vDwEUIaHNoHlnkmnzdPbY2FEQynmGu//r8ssV78myraOmxTzNGONzykuC
	 e3dBcOhi8C2/rOUQIl/8BsmdGoSnPxSj9xuGmr6LzTy8rWa1fW4i81ViF5l609mx6F
	 o/dwcMaEMiUe2B2fZXOv4y4SJ1aW01VXAGIKXlz8PpR/a7Q+eRPEdoY0aH3DLRITkx
	 Ir158PdV7Sqcm37iqzGj0Ag5q75lg35oWtwC9ON/c+J2T3Bqbm7cY/r19Ykw3LdMbk
	 wV4C95TUgQZ9b5Ov5ySfXY7S7ghAUKOeaRCuZiHJGtDlEuiwtNiV4b/hh9l8Hwj0UG
	 4hH5RHb87phIw==
Content-Type: multipart/mixed; boundary="===============6458751896961295269=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <62fa35211e90c3961079550e6b826dd1bee301e86838a03ab15cb0b4a631aa8d@mail.kernel.org>
In-Reply-To: <20260430-selftests-bpf_misconfig-v11-1-e11f7a8c4fdc@suse.com>
References: <20260430-selftests-bpf_misconfig-v11-1-e11f7a8c4fdc@suse.com>
Subject: Re: [PATCH bpf-next v11 01/11] selftests/bpf: Add BPF_STRICT_BUILD toggle
From: bot+bpf-ci@kernel.org
To: rbm@suse.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,shuah@kernel.org,nathan@kernel.org,nick.desaulniers+lkml@gmail.com,morbo@google.com,justinstitt@google.com
Cc: bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,llvm@lists.linux.dev,alan.maguire@oracle.com,rbm@suse.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 30 Apr 2026 16:41:50 +0000 (UTC)

--===============6458751896961295269==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -44,6 +44,12 @@
>  SKIP_LIBBFD	?=
>  SKIP_CRYPTO	?=
>
> +# When BPF_STRICT_BUILD is 1, any BPF object, skeleton, test object, or
> +# benchmark compilation failure is fatal. Set to 0 to tolerate failures
> +# and continue building the remaining tests.
> +BPF_STRICT_BUILD ?= 1
> +PERMISSIVE := $(filter 0,$(BPF_STRICT_BUILD))
                     ^^^^

The PERMISSIVE variable is defined here but never used anywhere in the
Makefile. The commit message claims "subsequent Makefile rules use to
make individual build steps non-fatal," but a search through the file
shows PERMISSIVE only appears at this definition line.

This makes the BPF_STRICT_BUILD=0 option documented in the commit message
non-functional. Users following the provided example will expect permissive
mode to work, but it has no actual effect.

Should this commit include the Makefile rules that actually use PERMISSIVE,
or is this feature incomplete?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25176431268
--===============6458751896961295269==--
