Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A145D2F8EB7
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 17:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780421629; cv=none; b=i4RICDQAHr7yCSX1J8dZjDXHtrbeJ3aJU70B3F9xPV6sfWtc+slSADwFex7yCvvKIMDN1H5aPl6pERhpzJH5ObxCFw6iFPK3eSMIbjG9Zjy2/N1Xlk9I3QDgFyMeebnAyeZGhV93cZoYJGcLxAC1lga/ZvW2THKCFEYQWf5HQqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780421629; c=relaxed/simple;
	bh=3wiQhkcA2pH9pXe+Od9aAzfs8oviUqaZ2ksbfW6//wM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Mo435/9qasLc0+0cfbd9ItSCXoLWQQuIVPt3HzwiUvC7GadvqGFF8VON1i8FlpMelZslpFj29DtHbQDZ8Id+1NVgskNJlhWN52sUQw4GYdoUnGSdYyvuXWVEq+1BlmaBICxZIFeFzkwvCdehcMlahN2i1lM9GpuSXSpWEGVvcAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FbFWbejd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FbFWbejd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E0491F00893;
	Tue,  2 Jun 2026 17:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780421628;
	bh=BvRMXQAERQFpc7TqEPw/r1sQIYgy22YHTHcCzQmt/z4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FbFWbejdTb01bp1It9Q5d8HVLP/Q13k5S6J2zG5XRWWJPcBZecq1xSv9G9u8w7xjo
	 P2vhlNw6IVsHZqDv+yGadCZZkY7A5Y/07wFi4tLtD7eajCSsVwIrLJz2/zFCruSK1U
	 0LFn1rz0uyVtyIqSN7My96H6ACLA3A6Of0TZigMDM5ds1NvHjOyeiR9wJfNizcbb1t
	 rZPPu0n30A59lH3ACSqL8gXca+aUUdOOatwEfdV7TUGKAq4ip1IJUSRwU1HqE4hike
	 4DiXlo5tUiM+X2URHBtu0jHc+r9Wzu21KMN+L5dlJZii//p/ANwJHLZk3k1F8ePUM2
	 unkmdz4jZnokg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 8/8] selftests/bpf: Avoid static LLVM
 linking for cross builds
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260602-tools_build_fix_zero_init_bpf_only-v2-8-c76e5250ea1c@arm.com>
References: <20260602-tools_build_fix_zero_init_bpf_only-v2-8-c76e5250ea1c@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 17:33:47 +0000
Message-Id: <20260602173348.0E0491F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Flawed native vs cross-build detection using un-normalized `ARCH=
` against normalized `HOSTARCH`.
--

commit 9a32865094dbf702cf09a9de14d120a1f3ca8a92
Author: Leo Yan <leo.yan@arm.com>

selftests/bpf: Avoid static LLVM linking for cross builds

This commit modifies the BPF selftests Makefile to avoid static LLVM linking
during cross builds. It intends to use dynamic linking for cross compilation
while preserving the existing preference for static linking on native build=
s.

> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index 1e47e29ba4214..ffa90674e86f6 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -188,8 +188,15 @@ ifeq ($(feature-llvm),1)
>    LLVM_CONFIG_LIB_COMPONENTS :=3D mcdisassembler all-targets
>    # both llvm-config and lib.mk add -D_GNU_SOURCE, which ends up as conf=
lict
>    LLVM_CFLAGS  +=3D $(filter-out -D_GNU_SOURCE,$(shell $(LLVM_CONFIG) --=
cflags))
> -  # Prefer linking statically if it's available, otherwise fallback to s=
hared
> -  ifeq ($(shell $(LLVM_CONFIG) --link-static --libs >/dev/null 2>&1 && e=
cho static),static)
> +  # Cross compilation must use dynamic linking to avoid unresolved libra=
ry
> +  # dependencies. For native build, prefer linking statically if it's
> +  # available, otherwise fallback to shared.
> +  ifneq ($(ARCH), $(HOSTARCH))

[Severity: Medium]
Will this comparison accurately identify native builds?

The kernel build system normalizes $(HOSTARCH) (for example, "x86_64" becom=
es
"x86"), but $(ARCH) might retain the un-normalized string if passed from the
environment or top-level Makefile.

If $(ARCH) is "x86_64" and $(HOSTARCH) is "x86", this check evaluates to tr=
ue
even on a native build, unintentionally forcing shared LLVM libraries inste=
ad
of keeping the static linking behavior as intended.

Would it be more robust to compare $(SRCARCH) to $(HOSTARCH), or to check if
$(CROSS_COMPILE) is empty instead?

> +    LLVM_LINK_STATIC :=3D
> +  else
> +    LLVM_LINK_STATIC :=3D $(shell $(LLVM_CONFIG) --link-static --libs >/=
dev/null 2>&1 && echo y)
> +  endif
> +  ifeq ($(LLVM_LINK_STATIC),y)
>      LLVM_LDLIBS  +=3D $(shell $(LLVM_CONFIG) --link-static --libs $(LLVM=
_CONFIG_LIB_COMPONENTS))

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602-tools_buil=
d_fix_zero_init_bpf_only-v2-0-c76e5250ea1c@arm.com?part=3D8
