Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AB530EF91
	for <bpf@vger.kernel.org>; Fri,  7 Aug 2026 04:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786077541; cv=none; b=CrogMP29QCPM9cLYjITDM5H5m/Yiegc4Rhw5veTYRg5uxR+ntJDiJpl8YWFNwioNckW57cGyFQy5KGGKX+lv0PhsOLY+VgBTDshkhxfp+AmVdbLbmSTRjWGaSAxtK+Kwh9lVnbUOdHcJ13v44YFhxg1i8LFa5w80yWwPmrrYZEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786077541; c=relaxed/simple;
	bh=2jjtnQ+IK+wnPLcbVTKdg05FFnIjHsQWwceEZEjZsfc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=umnJgoYdfg015JrORL2W0YGo/fvKdFGpqWU7Kifab5ZfBUN7YDxS+NEn7HeXBrGSxwnNwTfMGvyE9GYOCP1+wCM9KvCn6xA9FZA8vz6uL60hqk5Jw2tsELidQEe3u7Pm6eOKBHVJ1++hsr64w8Euwhf7G11AaB3hyJ3lrhw2mKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fkt0VJIB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fkt0VJIB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04D841F00A3A;
	Fri,  7 Aug 2026 04:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786077539;
	bh=9PpcRYefkC31zG53nBhFiILNQfKOGpdohWF47tk0/DM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=fkt0VJIBdVr3WMb0hA5fSpCmPf0D07FjI9XqsIp5pGrEDpmooIrfxFK//7yfa6wT/
	 4YAgf6nbuCioWQQdefLPwko/bkWcB5fPpcsLOVioteCewZUnO+8RmNQkQT3lKOrjix
	 wiIqLCaMrzFWzTdEN4q1g/n7p7Id73a/l3HHVBrLNmvkWNOmMuNc+CJQ3afUuQc994
	 lLy8riGQEvEcutM4UkDGCwOOknS0DuZMHAkaMKES31dk39RVstt27JwBCOB+FGIit4
	 fmp5ZF9DNd2tPvVuxFHuQAaOS1HQkVcvPQhXnk2rxeLAsgsPsCk0wJHVPjiRF7MDX3
	 H82GbR8u1LeQw==
Content-Type: multipart/mixed; boundary="===============0055132567614077141=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2fb3b453d9246c8844beadaba758fa6f5ce1a7131dd12886658d3032e40179e7@mail.kernel.org>
In-Reply-To: <20260807032029.78092-7-ihor.solodrai@linux.dev>
References: <20260807032029.78092-7-ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v3 6/6] docs, resolve_btfids: Document kfunc BTF annotation emission
From: bot+bpf-ci@kernel.org
To: ihor.solodrai@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com
Cc: alan.maguire@oracle.com,jolsa@kernel.org,emil@etsalapatis.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri,  7 Aug 2026 04:38:58 +0000 (UTC)

--===============0055132567614077141==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
> index cbde86d082cce..021be6d93dfb0 100644
> --- a/Documentation/bpf/kfuncs.rst
> +++ b/Documentation/bpf/kfuncs.rst
> @@ -472,6 +472,13 @@ type. An example is shown below::
>          }
>          late_initcall(init_subsystem);
>
> +At kernel build time the ``resolve_btfids`` tool finds all kfuncs declared with
> +``BTF_KFUNCS_START()`` and emits their BTF annotations into the kernel's BTF.
> +For each kfunc it emits a ``bpf_kfunc`` BTF decl tag, a ``bpf_fastcall`` decl
> +tag when the kfunc is flagged ``KF_FASTCALL``, and the ``address_space(1)`` type
> +attribute on the return value and/or arguments flagged ``KF_ARENA_RET``,
> +``KF_ARENA_ARG1`` or ``KF_ARENA_ARG2`` (see section 2.8).
                                             ^^^^^^^^^^^^^^^

Should this use an RST :ref: link instead of a hard-coded section number?
The arena section currently has no label. If a 2.x subsection is inserted
or reordered later, the reference would silently break, and the rendered
HTML gives no clickable link. All other cross-references in kfuncs.rst use
RST labels and :ref: (lines 16, 27, 51, 415, 609, 625, 807).

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31144437704
--===============0055132567614077141==--
