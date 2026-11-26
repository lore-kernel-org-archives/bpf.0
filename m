Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795703201;
	b=TkwQyMXbHvfWZYQo6wYGJMgg5YkIDLRUhHleDlHtCzNBX4Jqt4AiPCm8zKkjei6608LT
	 OtLlyzsPQgTlfkafCQwChN+oID/Q78vnrDNYPPqDW/M4rZxXXBj8+eZwecXUmu/lQcOoC
	 tBXS6E+iYmRhfBTWTgElmo0ZKvhuOI7Jxh5uMpmvVr2eyEXAK694pB7v5s0+neJ+AY+Xc
	 p5mpLjquhiJn3PYK4ZjxT8WrlfucoFBxMHWp9pxZxgOYLicBxP+OKK1jD0/wqbgjSpYXB
	 389Z49unj+SPoMLBqML9LkyMA0ioTCN8jXF0MkDK2OuDOseDaluleppUYcKO5S6POtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795703201;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=LV/4NZv0L0nRk0KcmBasG/0p8pvYolxiyVU5Q93Tf/8=;
	b=jh8NMMVKLsOVCUOS9f0fFPrq5eqBhBUSxEMkCwnM0pFNolGCoFoTSSgxej5tUsK/KmA1
	 ed9nATjo7Ak5I7LQVY8WU2O6lagBDVHA4i/Cmn754Ep1j5UMzNxDF0tQj2GFuX8hjO7xv
	 450PYB7FgNqIVrnLTFNXamfIPvJOeUrumGldGvkHZ4xLsYTacVBi0XlP/g+7PSritgSuo
	 mPtl/8Cw+72SPAs9mYijTi+YuTrqeWxl5ECtyfJ8zKQIB2KzuWPU/6RutkFmLSAqENJEi
	 O7gEKuyt/N2+3+wrjv0uX2nFAxXkk9Mu0v9G1TEYBCsB5PrQLG45xLprJAFB+1gFx7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X6bK+E5j;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917A3606A31E
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 14:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X6bK+E5j
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 598271F000C0;
	Thu, 26 Nov 2026 14:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795703201;
	bh=LV/4NZv0L0nRk0KcmBasG/0p8pvYolxiyVU5Q93Tf/8=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=X6bK+E5jMxy6cw2QH4LEHQGcGj8IQYpWbVQ1jlHQm81H+koLD6WvX0YD8XsR/vcaQ
	 j1ZTxIy3z94S3VQFj+kYkBRG7BIz4A599UtCALgfe82+2nU/N+yhAzEcXTFuTcbgeK
	 JI5g8PLVo3zkG7EHQ1vkEycbEFORJBYPSuFPsyOoQRxzA1Wu/9MJnSOXwMnWZ8UJRo
	 3/BHEBSEz1IVbuvibfQnAi5fAyNEs89q1rvy6rqpCJDtVzAghR2/cdkbAWfOkIpJjm
	 IBfeOgWRczwl6RSTW2XbaM02TETcNUIIFEmN2xZFMMopveiIv7c1X3d17zxB1S6TLP
	 7bDKgGk+ERWuw==
Message-ID: <sashiko-outbox-235699@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 bpf-next 4/7] resolve_btfids: Exclude a set of
 functions by name
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anton Protopopov" <a.s.protopopov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261126142915.1106330-5-a.s.protopopov@gmail.com>
References: <20261126142915.1106330-1-a.s.protopopov@gmail.com>
 <20261126142915.1106330-5-a.s.protopopov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 14:26:40 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] bpf: missing Fixes: trailer for fmodret_tag() function exclusion
  fix
--

commit 2fc421479a0ddf21d6c174ca83ce8384475f3b9a
Author: Anton Protopopov <a.s.protopopov@gmail.com>

> resolve_btfids: Exclude a set of functions by name
>
> ftrace reads the code it patches with copy_from_kernel_nofault(). A
> program which makes it fail breaks the detach of fentry on x86:
>
>   unregister_fentry()
>     update_ftrace_direct_del()    returns 0
>       ftrace_replace_code()       ftrace_bug(), no text poke
>         ftrace_verify_code()      -EFAULT
>     bpf_tramp_image_put()         the function still calls the freed image
>
> On arm64 ftrace reads and writes the code with aarch64_insn_read()
> and aarch64_insn_patch_text_nosync(), which calls
> aarch64_insn_write(). They are traceable without KPROBES. The same
> holds for them. Two more functions break BPF after a skip:
>
>   target                         error    after the skip
>   -----------------------------  -------  -------------------------------=
--
>   copy_to_kernel_nofault()       -EFAULT  arm64, with KPROBES too:
>                                           __aarch64_insn_write() fails.
>                                           ftrace_bug(), no text poke.
>                                           text_poke_memcpy() ignores it.
>                                           bpf_arch_text_copy() returns ds=
t.
>                                           The new prog is all BRK insns
>   tracepoint_probe_unregister()  -ENOENT  bpf_raw_tp_link_release() ignor=
es
>                                           it. __bpf_trace_run() reads the
>                                           freed link
>
> Do not tag these six.
>
> Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>

[Severity: Low]
Since this fixes unsafe bpf_fmodret_retval tagging in fmodret_tag(), should
it include a Fixes: tag?

  Fixes: 4dd950adacad ("resolve_btfids: Tag the functions that return error=
s")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126142915.1106=
330-1-a.s.protopopov@gmail.com?part=3D4
