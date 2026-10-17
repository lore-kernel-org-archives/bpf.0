Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E8F36F41C
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 23:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792280505; cv=none; b=slsmapOXQAN3Cb6k4auSUlFi96SHFkL2mz7uFQtAOKiU5R9eI/sPu8aKfeROGwFTKEi7BsYTSrQKxtVnrEWxPcDpJiTGfm1xF70PLNThJRkYRI6ZxSaDCWSvAfPXhsIiwQ9MNf3QBmpNMS9HE9gHrWh8rQjLHT6l7WJjUptfwYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792280505; c=relaxed/simple;
	bh=OHbFX0mZvPkqfgZ/eJKMdzt88GSSSm12y27p9mWhGcc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=GExkAyh0qpcOJ9C4t+45yCLiKZ37p7f9utTf0SgIo1sISPbLwjvFPiTBGxvMksXTzHtQyYfyOlwagZglK42oj2qnC5+GLub3UuA85A2CBq+QW4kFJWcsxnkpDAN6kApqq+eA0anNvfpuA9TNg+laCuLbCpSdFx98EBsDXymJAzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RAznOx19; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RAznOx19"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B59A41F000C4;
	Sat, 17 Oct 2026 23:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792280504;
	bh=tQAAuYjO3b/nr6hz41zDC7EDYKMnx9YZKnBEJqQTp/0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=RAznOx19lDUaMFrJMhKDgIs3QqnnAgU4caKHH2t7C5Fscmwb9XoNCkyKqzQC4jyNx
	 q6b01HyJ4Il5HgEgXgrOUk3KbKrHG63I8pCA9+6NWIXA1wHhT2+3rkOQINkT4bsthw
	 rgbsvWuTE1ifFiIBS2ciepZN2v6BYLUDupddk9s2bDuWU+6OSHCACbwonf6fWLtwlK
	 NVkn2xVsJegY4UNv7yYQ/ubqmQWSzBZ2ZkvJF9IfkRyzgLkjSZcUlmM7JsHBvZctyY
	 GwBf1Pl1vQY0HGnirv8KOR0czcevFEWS9Q6VTIr8oH83moFhuFnUsofTz3HnN9NThr
	 DWfxUglLB+zBw==
Content-Type: multipart/mixed; boundary="===============8570596444813883407=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <07767b15f635ea35ad4ad69114b1bd1de43b40d5c359e54e96799996dfdf6740@mail.kernel.org>
In-Reply-To: <20261017230950.802052-12-alexei.starovoitov@gmail.com>
References: <20261017230950.802052-12-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next v3 11/16] bpf: Refuse the prologue for an extension that cannot take it
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,josef@toxicpanda.com,mason@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat, 17 Oct 2026 23:41:42 +0000 (UTC)

--===============8570596444813883407==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Refuse the prologue for an extension that cannot take it

TL;DR: Commit message only: the Fixes: tag may point at the wrong commit,
since extensions could not write packet data (or get the prologue) until
7e40781cc8b7, though be8704ff07d2 may be defensible.

> bpf: Refuse the prologue for an extension that cannot take it
>
> A tc, lwt_xmit or sk_skb program that writes to packet data starts with
> bpf_unclone_prologue().  It takes the skb from R1, and if the skb is cloned
> it calls bpf_skb_pull_data() and restores R1 only.
>
> That suits the main function of a program.  An extension gets the prologue
> too, but it starts with the arguments of the function that it replaces.
> If the first one is not the context, something else is taken for an skb:
>
>   BUG: KASAN: stack-out-of-bounds in skb_ensure_writable+0x84/0x1a0
>   Read of size 8 at addr ffffc90000270ad0 by task uncl/105
>    skb_ensure_writable+0x84/0x1a0
>    bpf_skb_pull_data+0x32/0xf0
>    bpf_prog_853eb1991d35e093_ext_slice+0x4f/0x321
>    bpf_prog_9eb18752b5d0959a_t_glob+0x2ac/0x2de
>   BUG: unable to handle page fault for address: 0000000082298821
>
> And whatever R2-R5 held is lost, while the verifier goes on trusting
> pointers in them.
>
> Refuse an extension that needs a prologue unless it gets the context as
> its first argument and scalars beside it.  A scalar is still clobbered if
> the skb is cloned, which the verifier can cope with.  Extensions of XDP,
> sk_msg and sockopt programs get no prologue and load as before.
>
> Fixes: be8704ff07d2 ("bpf: Introduce dynamic program extensions")
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Is the Fixes: tag pointing at the right commit?

At be8704ff07d2, the prologue could not be reached from an extension.  The
prologue is only generated when env->seen_direct_write is set, and at that
commit the flag was only set via may_access_direct_pkt_data(), which
switched on env->prog->type:

    switch (env->prog->type) {
    ...
    default:
        return false;
    }

BPF_PROG_TYPE_EXT fell into the default case, so an extension could not
write packet data directly.  bpf_unclone_prologue() returns 0 when
!direct_write, so no prologue was patched in and R1-R5 of the extension
were never clobbered.

Direct packet writes from an extension, and therefore the prologue, first
became possible with 7e40781cc8b7 ("bpf: verifier: Use target program's
type for access verifications").  That commit introduced
resolve_prog_type() and made may_access_direct_pkt_data() use the target
program's type, so an extension replacing a tc, lwt_xmit or sk_skb global
function could set seen_direct_write.

That said, the tag may still be defensible, since be8704ff07d2 is what
copied the target's ops into env->ops, which supplies gen_prologue.

Should this include:

  Fixes: 7e40781cc8b7 ("bpf: verifier: Use target program's type for access verifications")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39078926044
--===============8570596444813883407==--
