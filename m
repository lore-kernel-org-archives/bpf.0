Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794385306;
	b=VGoIhqMBiagjDKFsQrlyvchCt5AEQDilEeeDij8WvJ6UzVFfKstl8wbjlpwdZWfUQNvr
	 EFjgXGLl5Lu+tPE/JxNnwnYKahAuf80lXGnppolwfSsIwakmQqMv/cnC6sdtPWdHTtzsr
	 th6OjRTdvh26/mW5/zWBwV5NNqWPd/8MZPDDwAdwMq2zsavNvU+4Zb7lBgFG9beWkv29G
	 ilxOkgnGT6YZtQ3jo3wSr0N/nxHn82Hvt5EFFhKQ6GnDeuLSMhEkjqYcEPto3mLdIH1MD
	 6Vuj4nXiAJm5pTMpa2TtdXUHxZA3m6k2b0I/oTtpZHTHvDOMI7tFuy8t0vtm6OYDa0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794385306;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=bc4uJgbcrW3hJFibKrpTSUGplAecbGT87lZa2sKYd68=;
	b=1Sumw13dlmz8f1w3NQ46CrOTwmOba6Wjx76TTKLxo10EYq4BlsEtMjcypuzNau5tzLhw
	 QEILCUHuqKwwJ8h/QyqJSFuElfLMxn8CKVj1/z+jNK+04Y1xyy8KseF6EEcpJ6FigqM+v
	 uVWGVhNDWHKTUcJ9bSyn+hgE7pjQvnx2JiD1JxoVgXhPOPcIyZM0KVTSRtNEUjlUWGih2
	 uPSfhVyQw41Rs02OrfRuN/ZsPFYX9ddKAYnX0DLABSrauuEL5SV2mr50sQtjccEMT5pB8
	 j8BGee+No5XcXNnPXNTmcugjD7/AlKT8D6g3umkJGXdePAh387y+FYKnzdJLgZzMBrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iO4FCWN7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA497606A33D;
	Wed, 11 Nov 2026 08:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iO4FCWN7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6212C1F00A05;
	Wed, 11 Nov 2026 08:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794385306;
	bh=bc4uJgbcrW3hJFibKrpTSUGplAecbGT87lZa2sKYd68=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=iO4FCWN7A3sfh+zdh9utiA90l7NqVofYxiV27wVFsKzIYyl53m47lecq0L3V54KYD
	 ecgx7FSdvN1/2ebuAhbWkKSmRkVbHdFrHhAI8zAXLLQ8qetPybNAFK2Oi05NPTpQSz
	 L2jcy/R2+k7ozPmE+am5SelrDfaDk32/Qk4KwwwvbKlw93A8zYoeoQKxyOuKcBJTvp
	 bnaJXp05WLkL7nyZ2ua/ofbm/I4CBFI8mX/yaFytx1eZFucUWM9DRyOlWxsbT73HHa
	 gTwKAXDyGSRiYB+DH0XqSdq51YE+U8fXpcCiNqgFNhFlqN8YKfzf+9I9ycaiKhaUEn
	 S0JPpks/CmqCQ==
Content-Type: multipart/mixed; boundary="===============7021396986543403765=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <f0cac3d0039b840d9e1cab4dffbff15923f87115dda70351043219df57fbd4d8@mail.kernel.org>
In-Reply-To: <20261110164046.454431-16-a.s.protopopov@gmail.com>
References: <20261110164046.454431-16-a.s.protopopov@gmail.com>
Subject: Re: [PATCH v3 bpf-next 15/18] resolve_btfids: Tag fmod_ret candidates as targets
From: bot+bpf-ci@kernel.org
To: a.s.protopopov@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,almagui@kernel.org,john.fastabend@gmail.com,qmo@kernel.org,brauner@kernel.org,kpsingh@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,sashal@kernel.org,bpf@vger.kernel.org,linux-kernel@vger.kernel.org
Cc: a.s.protopopov@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 11 Nov 2026 08:21:45 +0000 (UTC)

--===============7021396986543403765==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> resolve_btfids: Tag fmod_ret candidates as targets

TL;DR: Nits only in resolve_btfids fmodret.c: the second branch in
relocation_offset() looks unreachable or wrong, and record field offsets are
hardcoded in three functions. No functional bugs reported.

> diff --git a/tools/bpf/resolve_btfids/fmodret.c b/tools/bpf/resolve_btfids/fmodret.c
> new file mode 100644
> --- /dev/null
> +++ b/tools/bpf/resolve_btfids/fmodret.c

[ ... ]

> +static bool relocation_offset(const GElf_Shdr *target, GElf_Addr offset,
> +			      size_t width, size_t *result)
> +{
> +	if (target->sh_size < width)
> +		return false;
> +	if (offset >= target->sh_addr &&
> +	    offset - target->sh_addr <= target->sh_size - width) {
> +		*result = offset - target->sh_addr;
> +		return true;
> +	}
> +	/* ET_REL relocation offsets are relative to their target section. */
> +	if (offset <= target->sh_size - width) {
> +		*result = offset;
> +		return true;
> +	}
> +	return false;
> +}

this isn't a bug, but when is the second branch in relocation_offset() taken?

For the module sections that use this helper, sh_addr is 0, so the first
test already returns the section-relative offset, and with sh_addr == 0 the
second condition cannot be true once the first has failed.

The second branch is reached only when sh_addr != 0 and offset < sh_addr,
which would be a linked image whose r_offset lies below the target section.
Treating that address as a section offset would be wrong there.

Would it be clearer to pick the interpretation from e_type, or to drop the
fallback?

[ ... ]

> +static char *format_values(const unsigned char *buf, size_t offset, size_t ptr_size,
> +			   unsigned int encoding)
> +{
> +	unsigned int nr = read_elf_value(buf + offset + 16 + ptr_size, 4, encoding);
> +	const unsigned char *p = buf + offset + FMODRET_META_HEADER_SIZE(ptr_size);

[ ... ]

> +static int choose_functions(struct elf_function_list *functions, const struct btf *btf,

[ ... ]

> +		if (!read_elf_value(buf + record + 16 + ptr_size, 4, encoding))
> +			continue;
> +		stats->with_values++;
> +		flags = read_elf_value(buf + record + 12, 4, encoding);

this isn't a bug, but the record field offsets (flags at 12, nr_values at
16 + ptr_size) are written out by hand in parse_records(), format_values()
and choose_functions().  parse_records() has already decoded flags and
nr_values, and the other two decode them again from the raw buffer at the
same offsets.

fmodret_metadata.h has macros for the magic, the version and the header
size, but none for the field offsets.

Would it be simpler to put the offsets in fmodret_metadata.h, or to have a
small helper return flags and nr_values for a record, so that the three
functions do not each repeat 12 and 16 + ptr_size?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42981885558
--===============7021396986543403765==--
