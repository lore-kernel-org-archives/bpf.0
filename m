Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8FB42F71E
	for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 13:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785416633; cv=none; b=hvfv22Q99IcQptMGtEUNyiMLxUThre5zhPbe7JlCTHgQX4LiRvS8/l+mDOYFg1WnPFs1fKPna3WsvdxmU7trAL/4nfp+gyuaw8rcjUfsRE4WYw40LXtleJ2D+8iqx5NdgdS0xffm4GH1diDeMYwiGmU34oHy4dpdaoB2+llZYyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785416633; c=relaxed/simple;
	bh=4IhCPZlraxXt1CgM957DfuNffrzh/i4IIR7sGtQIr5Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Hoqbcw0lPMyLcgOD7FbaNyXWY6oBb7TY8bT2Wf5TjqSLm9oelqRCrqmslGvQ0L/MvDIy5qGCDZGfPdlP+TY/jNlM9iFrPsB0bixiaWxM+tAjVUpqiLz/B3lSFJym0YzcArfkXAY1/PO5nwjhAY0Vep+tJyu23YNbUt+D8E3IO88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JOwtkq3H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JOwtkq3H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 476D51F00A3A;
	Thu, 30 Jul 2026 13:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785416632;
	bh=IRMDos3FnwMNpIOUTt9+ugHAJa5BBhBzD2NVXEioDMU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JOwtkq3HVQReeMWQByF1VC+dwm9JlrOuapj4/I3T3VBQsDlvfUe/1BKp7LTCtmWVd
	 Mhk/oDsIOqfXMa2IKQmWoKL9wXs/3T8i5EvmNTR6EUGxp+WMpgUkDT2DidFxK1fLxE
	 fk+9eY6IsPcnjoMTRm1lAog84xBmYmp/hO9wC8kwPDJ97yGAZNInoEMI5qCMao4KEI
	 aAl1lq4tpZj3ji963VbrnW8/wDK7Svf9YuOxGI6XfoZ0qQt6hjoILLYtR5cKY5NUeF
	 rLqXNb6x1esG9htHVPIKKDRl0HNiDqW8ImX3v9Yqnvy0yxhUDH9/zh3uwuDnNHOMYS
	 4DyqKO8fAMSyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next] tracing: Make per-template BTF id lists
 file-local
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mykyta Yatsenko" <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260730-b4-fix_btf_tracefs-v1-1-5f10b728f51e@meta.com>
References: <20260730-b4-fix_btf_tracefs-v1-1-5f10b728f51e@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 13:03:51 +0000
Message-Id: <20260730130352.476D51F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Using `BTF_ID_LIST()` instead of `BTF_ID_LIST_GLOBAL()` for trac=
epoint classes introduces significant BSS memory bloat when `CONFIG_DEBUG_I=
NFO_BTF` is disabled.
--

--- Patch [1]: [PATCH bpf-next] tracing: Make per-template BTF id lists fil=
e-local ---
commit 49d7faf72ef8695ae45768a193f5a09e2cfe872d
Author: Mykyta Yatsenko <yatsenko@meta.com>

tracing: Make per-template BTF id lists file-local

This commit converts trace event BTF id lists from global to file-local to
avoid symbol clashes when multiple translation units instantiate the same
class. It also explicitly provides local BTF id lists for handcrafted sysca=
ll
events.

Link: https://lore.kernel.org/all/ff58b01c-3f5e-4d55-be82-609d2faaf12e@sire=
na.org.uk/

> diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
> index 09ad57ac4b73e..45ffbe04b5805 100644
> --- a/include/trace/trace_events.h
> +++ b/include/trace/trace_events.h
> @@ -404,10 +404,12 @@ static inline notrace int trace_event_get_offsets_#=
#call(		\
>   *   [0] FUNC   __bpf_trace_<call>     (the BPF dispatcher)
>   *   [1] STRUCT trace_event_raw_<call> (the ring-buffer record)
>   * Exposed via the events/<sys>/<name>/btf_ids tracefs file.
> + *
> + * File-local: the class name is not unique, so a global symbol would
> + * clash across translation units.
>   */
>  #define _TRACE_BTF_IDS_DECLARE(call)					\
> -	extern u32 __bpf_trace_btf_ids_##call[];			\
> -	BTF_ID_LIST_GLOBAL(__bpf_trace_btf_ids_##call, 2)		\
> +	BTF_ID_LIST(__bpf_trace_btf_ids_##call)				\
>  	BTF_ID(func,   __bpf_trace_##call)				\
>  	BTF_ID(struct, trace_event_raw_##call)

[Severity: Medium]
Does changing this to BTF_ID_LIST() introduce significant BSS memory bloat
when CONFIG_DEBUG_INFO_BTF is disabled?

When CONFIG_DEBUG_INFO_BTF is disabled, the fallback for BTF_ID_LIST is
defined as:

include/linux/btf_ids.h:
#define BTF_ID_LIST(name) static u32 __maybe_unused name[128];

BTF_ID_LIST_GLOBAL(..., 2) only allocated 2 elements (8 bytes), but this
fallback statically allocates a 128-element u32 array (512 bytes) per
instance.

Because _TRACE_BTF_IDS_DECLARE is instantiated via DECLARE_EVENT_CLASS for
over a thousand trace event classes across the kernel, this seems to silent=
ly
add roughly 750 KB of wasted BSS memory.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730-b4-fix_btf=
_tracefs-v1-1-5f10b728f51e@meta.com?part=3D1
