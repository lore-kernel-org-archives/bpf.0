Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6581B39768A
	for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 09:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776072409; cv=none; b=SM8FJhTdyONQuIqYgx241Ckp+6bbEaUc9rTKma7NulLFe9wnnCHu+/9R8XkNwybLfwT+4+ntNQB33Gmq3bLyFfcCZ+pqB7WaLFdG8MRxnbG7lMii7Bl+JEBEEBCfL0yvxzcNZMojWWrCQk52RxVQchHyfHgAH0jipnrS4UPAwQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776072409; c=relaxed/simple;
	bh=Eg/GO1Nw+bvN4928nzvC38EbG/CogGe1l3878UhOTwI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=skVyTYWcr+YlPxeUneZdBoNxvlva4DWY9Xb7GlO9UqR4EaPgtnBVKQfzvq/6XIU9vH2GV0/bi1g8XPCsh/pXSsmRq0BGqVen1Zhkc5eesvbzYSamwjbL+iaY+FklKzoOaYZz0uDLicJ6wMHSpH36zJ1rHakzLlX6FIs6f5wiaHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gn6rEryy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gn6rEryy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E42FC2BCAF;
	Mon, 13 Apr 2026 09:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776072408;
	bh=Eg/GO1Nw+bvN4928nzvC38EbG/CogGe1l3878UhOTwI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=Gn6rEryywkjoGfp5QEtwirmoCwVTT5pdju6E2hH5NznZFMu4wyAUjBsyqYE++RH9u
	 A89c6Lz8r7zebh/f6lSah5coZwg8fZt9WBWZXXeb/6XLiZveat43MmtPwJGTI1gcBl
	 bApylpeLtz6fDMJRj2VIAVUzCQemVDL8yL7BwWGVe+9eQtEJ88xZIC6WkwuAQo+SWU
	 JEc3F5tdP8qBlCY8QE5kub5ChTHpV6EfO2xt2nSLJdvanKlle6fe7M3b+SIhEmRLI/
	 F6Q2VO5Jw/2x9uEtYd6zDArpndUaUKNiIyrKkybpZbva8eakuhzqzLBgGUedkxR1ho
	 kQGi8328rFSbQ==
Content-Type: multipart/mixed; boundary="===============8174809552616561653=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b33a500484e976977e6b56d0e1fbc6053c8f2723247eb5d890fe4b2be7242fc1@mail.kernel.org>
In-Reply-To: <20260413085033.71952-1-phx0fer@gmail.com>
References: <20260413085033.71952-1-phx0fer@gmail.com>
Subject: Re: [PATCH] bpf: btf: reject division by zero in btf_struct_walk for zero-size flex array elements
From: bot+bpf-ci@kernel.org
To: phx0fer@gmail.com,bpf@vger.kernel.org
Cc: martin.lau@linux.dev,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,phx0fer@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 13 Apr 2026 09:26:48 +0000 (UTC)

--===============8174809552616561653==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Fixes: 1dc92851849c ("bpf: kernel side support for BTF Var and DataSec")

Should the Fixes: tag reference a different commit? Commit 1dc92851849c
adds BTF Var and DataSec support but does not modify btf_struct_walk()
and does not introduce the modulo operation that causes this bug.

The vulnerable line:

    off = (off - moff) % t->size;

was introduced in 9c5f8a1008a1 ("bpf: Support variable length array in
tracing programs"), which added the flex array handling path to
btf_struct_walk(). The Fixes: tag pointing to the wrong commit could
result in incomplete stable backports.

Suggested:

    Fixes: 9c5f8a1008a1 ("bpf: Support variable length array in tracing programs")

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index a62d78581207..2365d9b1ef27 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -7152,6 +7152,13 @@ static int btf_struct_walk(struct bpf_verifier_log *log, const struct btf *btf,
>  		if (!btf_type_is_struct(t))
>  			goto error;
>
> +		/* Zero-size element type (e.g., empty struct) would cause
> +		 * division by zero below. Reject the access.
> +		 */

This isn't a bug, but the BPF subsystem uses the style where the
opening /* is on its own line for multi-line comments:

    /*
     * Zero-size element type (e.g., empty struct) would cause
     * division by zero below. Reject the access.
     */

> +		if (t->size == 0) {
> +			bpf_log(log, "zero-size type in flex array\n");
> +			goto error;
> +		}
>  		off = (off - moff) % t->size;
>  		goto again;


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24334874776
--===============8174809552616561653==--
