Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A1E3E274D
	for <bpf@vger.kernel.org>; Tue, 16 Jun 2026 06:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781592170; cv=none; b=m7/1AZ3t/sTT8m8cBd0pO2ZDrFp7lXdi43PibUQyuACfQ8uAXFon0a+m4/HEpygqIMwVTbliEIabZQzY+UQQQ550uozWTyfuMdWDtCPZePqdXalvYTlmyRrMfBpRpf4H8MBC4rG6tfUSAuq9QsjjE9HjhDfdDDxN/wGD7icSM/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781592170; c=relaxed/simple;
	bh=p/GviRum+NldwkOqmdGWGksATYrGJYXFipm0x0K6OdI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=gRa71cDYj1B0l/5VKdpmNJvpEyY9yVvxiCkbMxb9PH60rX9f2U64ZouX9xQUkZOGsY0o4jUai1Kha3zaf8w3PvnH/MusKOSxxnLAZG+J2lMU5oTIy5umgj1ScaqB6uRtErN8a07TlPkpGi5yvEXTPdw3u+sLdFceZWKdEa1gLxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VFz4jvty; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VFz4jvty"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEBA41F000E9;
	Tue, 16 Jun 2026 06:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781592169;
	bh=FQZTnnDT3tUZsrw+xeJ9oAqnn2cE9oJNK5D9pnk0A3I=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=VFz4jvtyUZxFen2XPwX06QzJdIoxswNMf5J78NcTgjUId+IPU0c2TVewQqCd1OkJ6
	 nKqDxBvoPTHuNqG4EOOjLopOKivb2XSK0/t2QOqLWnXjQUUG6hm7IDSN/nlDvbeldU
	 8LGw09Ep0MqjB/yHVS7L65xqQnTjRMqBzlAjoOwV2kpDeMXWk4NgjR2VEBigmzkjbl
	 dfm6qr140ASULtl1uMbneTCBdoEf9XWl9hlaxzs9nrrfrqUupbm/OdgCBKQpAfbOk+
	 2G5Az1sNAi5r3T67xn9SEgDXKZtL+FnNAo2noOKJpqppwT6OSCLbo+xNYRggcTY5nE
	 e27407eVhdwfw==
Content-Type: multipart/mixed; boundary="===============6765501996543046390=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <455ee1eb3aa70bc44f20e6adebe80905d2c63b17d8d3bb44e8eefc01870299d1@mail.kernel.org>
In-Reply-To: <20260616061454.7869-1-emil@etsalapatis.com>
References: <20260616061454.7869-1-emil@etsalapatis.com>
Subject: Re: [PATCH bpf-next v2] bpf: Allow type tag BTF records to succeed other modifier records
From: bot+bpf-ci@kernel.org
To: emil@etsalapatis.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,memxor@gmail.com,daniel@iogearbox.net,eddyz87@gmail.com,mattbobrowski@google.com,emil@etsalapatis.com,yonghong.song@linux.dev,vineet.gupta@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 16 Jun 2026 06:42:48 +0000 (UTC)

--===============6765501996543046390==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

>     bpf: Allow type tag BTF records to succeed other modifier records
>
>     As of recently, Clang is able to attach type tag records to modifier BTF
>     records. This is useful for using typedefs that encompass a base type
>     and a type tag, e.g.:
>
>     typedef struct rbtree __arena rbtree_t;
>
>     Modify btf_check_type_tags() so that it allows this sequence of records.
>     The function now only checks for record loops in BTF modifier record
>     chains. Rename to btf_check_modifier_chain_length to reflect this.
>
>     Also expand the BTF modifier traversal code to take into account that
>     type record can be interleaved with other modifier records. In effect
>     this means traversing all modifiers to collect the type tags.
>
>     Also modify existing selftests to now accept modifier records (const,
>     typedef) that point to type tag records.
>
>     Cc: Yonghong Song <yonghong.song@linux.dev>
>     Cc: Vineet Gupta <vineet.gupta@linux.dev>
>     Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>

This looks like it relaxes a constraint that was added earlier.  It
removes the "Type tags don't precede modifiers" check (the in_tags logic
in btf_check_type_tags()) that rejects valid BTF now produced by Clang.

That check was introduced by commit eb596b090558 ("bpf: Ensure type tags
precede modifiers in BTF").  Should this carry:

  Fixes: eb596b090558 ("bpf: Ensure type tags precede modifiers in BTF")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27598443532
--===============6765501996543046390==--
