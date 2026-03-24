Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385883FCB34;
	Tue, 24 Mar 2026 13:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774359788; cv=none; b=mmB4RPBh5vesFWAcZtnIB4FqmkVHts30HohtT0mq8JEUyMUzwpCl3FI2cUZVlW478I67xdiwq8O1HD/pJ969zL2L3WxfznRANuwTtMfRjX+G2KzBJ+7p6HEzIOF0xdojVudesPOXUTwSj4RcdHo8xu4IQFqvoQd7H3rHhbSx3Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774359788; c=relaxed/simple;
	bh=tQzP56JT8kO533jsrXHMynkypbhTkn3/hPD/iDlE2C0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eFzXYMxqLdjcnykFi5RNwjPNDMdwA+ImKjdYRZvEFQHBOJAZrAUX5d9ezNBxr6eGg9taWLkbI2mpicurOtOeM6xdqQUFD3ZzotrFUY12v75BXqVPx78kpVSqc9Od20HGRQ+RdRpDnG/Xarp8zoh2ViwyN3WZCyFtusPeHx40inw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=RYS52nQe; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="RYS52nQe"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 447B640423
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1774359786; bh=8j1lWJ701yzUSlEYE6uskF2ZtMcXdWTUqSiglq8TPjA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=RYS52nQevBGg/pPQsSNoovYWD/QCJ4Re0/bfQUMmZoczo/1ccMizkfOmhQ5zsZoAe
	 PDmwUXpDPD8W3iv5nP3FoaOfK56iuuOQUgd9A7gR33ne7NSpQD+87zFMj58i9ZN8Vv
	 IWgrJ7HNI6YICetie4bCO4hSy6feQx3pvQXtzRo5laTqK895OJtyGzCchUSRl0Bx0P
	 kKcLWN1VSeNZapeT5MsTmPhdrn0QghjiJBgJ2JfNIifs9dM7OrfnSvfqDdV0sNQIBI
	 aLYK7I9DrJjN95or0L3u9rYtqK7cAgfnTg9LgIQBz81ID5yDBEl+IRD2J2fmNb6s9B
	 LP1qlvpGpKw/g==
Received: from localhost (unknown [IPv6:2601:280:4600:27b::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 447B640423;
	Tue, 24 Mar 2026 13:43:06 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: zhidao su <soolaugust@gmail.com>, workflows@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 bpf@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>, zhidao su
 <suzhidao@xiaomi.com>
Subject: Re: [PATCH] docs: Document pahole v1.26 requirement for
 KF_IMPLICIT_ARGS kfuncs
In-Reply-To: <20260324062028.2479059-1-suzhidao@xiaomi.com>
References: <20260324062028.2479059-1-suzhidao@xiaomi.com>
Date: Tue, 24 Mar 2026 07:43:05 -0600
Message-ID: <877br18hsm.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

zhidao su <soolaugust@gmail.com> writes:

> Since Linux 7.0, kfuncs annotated with KF_IMPLICIT_ARGS require pahole
> v1.26 or later. Without it, such kfuncs have incorrect BTF prototypes in
> vmlinux, causing BPF programs to fail with 'func_proto incompatible with
> vmlinux' error.
>
> This affects all sched_ext kfuncs (e.g. scx_bpf_create_dsq,
> scx_bpf_dispatch) and other KF_IMPLICIT_ARGS kfuncs across the kernel.
> Ubuntu 24.04 LTS ships pahole v1.25 by default, causing 23/30 sched_ext
> selftests to fail on affected systems.
>
> Document this requirement in Documentation/process/changes.rst so users
> understand the failure mode and can upgrade pahole appropriately.
>
> Signed-off-by: zhidao su <suzhidao@xiaomi.com>
> ---
>  Documentation/process/changes.rst | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
> index 6b373e193548..141a4576c24d 100644
> --- a/Documentation/process/changes.rst
> +++ b/Documentation/process/changes.rst
> @@ -145,6 +145,11 @@ Since Linux 5.2, if CONFIG_DEBUG_INFO_BTF is selected, the build system
>  generates BTF (BPF Type Format) from DWARF in vmlinux, a bit later from kernel
>  modules as well.  This requires pahole v1.22 or later.
>  
> +Since Linux 7.0, kfuncs annotated with KF_IMPLICIT_ARGS require pahole v1.26
> +or later.  Without it, such kfuncs will have incorrect BTF prototypes in
> +vmlinux, causing BPF programs to fail to load with a "func_proto incompatible
> +with vmlinux" error.  Many sched_ext kfuncs are affected.

This seems like reasonable information, but is there a reason to not
just raise the minimum pahole version to 1.26 and be done with it?

Thanks,

jon
