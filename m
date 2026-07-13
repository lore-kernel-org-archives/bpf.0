Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4829038333C;
	Mon, 13 Jul 2026 07:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783927057; cv=none; b=CFuVACGImowT9dK2JMNBUJkX7a0qwE2BNa4GV9tqFZdAVKM5ZSkgdY+gIKG7XMaHwzo/zL6GdhRlmEWV3rOgbVCRuMdx+0gnA5KIueh0JULi9jcGq0zqIXOoGUxSozC0ekk/sIA5HG9uUbeihaz5aX/jpoln10XKDJ1lSVv0hqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783927057; c=relaxed/simple;
	bh=V7XXSr1TdJRrGt7usJPyRU02xjG3Q7AKnaJV6x7W3Vg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Xku5iqhbaR5GuM3IcXE7tmkEAlxtsE94ZwuPW4oU07gLOmnwHsCSwM6LMjVSnyYf9dGp66r03+vFp/utDmkfnt6iHzQ9Q465WRY70q2X9DB7J2pd3eIAWeuT/lh/pQUO99ids1VPtrSJpOQRH97Bb3CG8Rq3Y5yQqgS+k0ovMnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ACvrqW4n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ACvrqW4n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6EF31F00A3A;
	Mon, 13 Jul 2026 07:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783927056;
	bh=53ZHr3cMIylOLjl4WEN6FgAdOLZb+0qyaR+2VpwbnsM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ACvrqW4nfa+YV4T2t6H70bsB8YiZ+Kav799ogaObmItmjDNd2lGHVBcYSvXOijxsd
	 JgGnPN9XEJb7z+7EGQzQyLcTNlREzteEULMRUjXCmT01aWMHwX/0xir9WiF77x3+XN
	 mmpewK3GEvMkP83HIHirSAKBlwPMu5bqBPCcJlrlFdbfG0JByaAzHic9zVuYE407i2
	 S5FSBmvl9vNGK5kXhHXK2JjXOwUse8G3XMs3MLfz27aCzI3bJGTW9KQan/2APzLiJX
	 Dj2q20as2X2mkKnWYOZyWqo9OoYnBvghIcUhTyjIboe4RKlNEplza4r9O+i7LSbQDO
	 +XgkIDuVWK0oA==
Content-Type: multipart/mixed; boundary="===============0820187192493825405=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2cc3bdacec86e02e36a627faa455d53fabfd5333403eb629ad812717288d67d6@mail.kernel.org>
In-Reply-To: <feb30511a4b3e198253666b5ea2499d0944c153f.1783920884.git.chenyy23@mails.tsinghua.edu.cn>
References: <feb30511a4b3e198253666b5ea2499d0944c153f.1783920884.git.chenyy23@mails.tsinghua.edu.cn>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Cover helper reads of invalid spill siblings
From: bot+bpf-ci@kernel.org
To: chenyy23@mails.tsinghua.edu.cn,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com
Cc: chenyy23@mails.tsinghua.edu.cn,john.fastabend@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,shuah@kernel.org,bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 13 Jul 2026 07:17:35 +0000 (UTC)

--===============0820187192493825405==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Cover helper reads of invalid spill siblings
>
>     Add a verifier_spill_fill case that passes an untouched byte next to a
>     one-byte scalar spill to bpf_map_update_elem(). The full-capability load
>     retains the existing uninitialized-stack behavior, while the CAP_BPF-only
>     load must reject the STACK_INVALID helper read.
>
>     Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>

This test covers a verifier bug where a helper read accepted an
uninitialized (STACK_INVALID) sibling byte next to a narrow (<8-byte) scalar
spill.  That behavior came in when sub-8-byte scalar spill/refill support was
added, which left sibling bytes STACK_INVALID while the slot still reported a
spilled scalar.

Should this carry the same Fixes: tag as the companion verifier fix so stable
backports pull the test in alongside it?

  Fixes: 354e8f1970f8 ("bpf: Support <8-byte scalar spill and refill")

> diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
> index 8b166c42c4e0e..e686f6d8d5656 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c

[ ... ]

> @@ -1307,6 +1314,32 @@ __naked void stack_noperfmon_spill_32bit_onto_64bit_slot(void)
>  	: __clobber_all);
>  }
>
> +SEC("socket")
> +__description("helper read must reject an invalid sibling of a narrow spill")
> +__success
> +__caps_unpriv(CAP_BPF)
> +__failure_unpriv __msg_unpriv("invalid read from stack R3 off -7+0 size 1")
> +__naked void helper_read_invalid_partial_spill_sibling(void)
> +{
> +	asm volatile ("r5 = 1;\n\t"
> +	"*(u8 *)(r10 - 8) = r5;\n\t"
> +	"r2 = 0;\n\t"
> +	"*(u32 *)(r10 - 16) = r2;\n\t"

this isn't a bug, but could this asm block use the same backslash
line-continuation style as the neighbouring tests in this file?  The two
tests just above it, stack_noperfmon_reject_invalid_read() and
stack_noperfmon_spill_32bit_onto_64bit_slot(), write a single string with
trailing tab-backslash, and this is the only "\n\t" per-line block in
verifier_spill_fill.c.

> +	"r1 = %[map_partial_spill] ll;\n\t"
> +	"r2 = r10;\n\t"
> +	"r2 += -16;\n\t"
> +	"r3 = r10;\n\t"
> +	"r3 += -7;\n\t"
> +	"r4 = 0;\n\t"
> +	"call %[bpf_map_update_elem];\n\t"
> +	"r0 = 0;\n\t"
> +	"exit;\n\t"
> +	:
> +	: __imm(bpf_map_update_elem),
> +	  __imm_addr(map_partial_spill)
> +	: __clobber_all);
> +}
>


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/29229349078
--===============0820187192493825405==--
