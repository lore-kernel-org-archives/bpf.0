Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6803EFD07
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 21:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783545050; cv=none; b=Aa2OFm+rdZRSIgcfZA+GFOuxfVK538TX0iIA7cK778e/jQzPVhXxV2fGHS1qblsSbmtAC37wTiXpegUlys/aRFChLhQ9JbZ1sInaHZceTznADDQiMMNEQuO7L23LfrsrFuD/CRhsj5SqwYkQsdmWvdEie3rg0IfvTbqFQh5ulFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783545050; c=relaxed/simple;
	bh=vcqB4QnoiY7g9UNdAJyWdlFe1inqxdVT3G3BhyrOmPM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Ohhc7s8s2mwwbHln04bWEy5+XuYTRBsol1m2nEX4Ni7heSyac4NlXe39GAW2rYG7LJ6S93F0poKchYINN3It4FRQopvx9Z3W8CPIBKNIbTCpcwKqLbyk2vKVVJTldSWXSli8wC71e4MUZ8+EYlmnq8EJ/ar7PHA5iyRoGjIv7Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IPN3EYfF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IPN3EYfF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92BB01F00A3A;
	Wed,  8 Jul 2026 21:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783545048;
	bh=fEIZAwdimLXxDYFs9eAc4f8VMBV7EzAeeQO8FVR+bhc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=IPN3EYfFxon34HKolB28Hwsju2r4417ZIQC0xpiP1Z4J41WD2NAPNk76OGRaz9GcA
	 gvlRF+bjCZzwSEEauLH2d268BqAbzDvPt3XIJDZ7E1E0ja3Nya7bNw+cQLtrL6WSXA
	 9BUZMJtkqccI4yCs+AsgMIVW0fsdoR/La4K+iw0s7QZQ0UYPQDHhV4Z7gS6b0quRTW
	 unSeJNwuxq01Z8t2USXGXzpWCcxpBZfWBJIvFNpAY2LM6EdEJg1DPDA+amrqGxyyfo
	 +kPBZoGnbk1RkvcLT72QoyfGwxek9pDNf8+TbmqtCFz4wiOcoKr8b1O4yP7odYAtC6
	 MaklDJgUWhtng==
Content-Type: multipart/mixed; boundary="===============6204347742307451886=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <183b9ca3d36237d6c00c590958b2564323a79166de874e17e65be888b1864236@mail.kernel.org>
In-Reply-To: <20260708201005.2158063-1-yonghong.song@linux.dev>
References: <20260708201005.2158063-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next 05/12] bpf: Account R2 of register-pair returns in live register analysis
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  8 Jul 2026 21:10:48 +0000 (UTC)

--===============6204347742307451886==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> commit 29d6a87c34e27de90ba01d71870930baf27d4b33
> Author: Yonghong Song <yonghong.song@linux.dev>
> Date:   Wed Jul 8 13:10:05 2026 -0700
>
>     bpf: Account R2 of register-pair returns in live register analysis
>
>     A BPF_EXIT of a subprogram returning a value larger than 8 bytes (a
>     struct/union or an __int128) reads R2 as well as R0, since the second half
>     of the return value is passed back in R2. compute_insn_live_regs() only
>     marked R0 used at exit, so the callee's R2 could be considered dead and
>     cleaned from checkpointed states, which would allow unsound state pruning.
>
>     Mark R2 used at a BPF_EXIT when the enclosing subprogram returns via the
>     R0:R2 register pair. The call site already treats the caller-saved
>     registers R0-R5 as clobbered, so R2 as a result register is covered there.
>
>     For example, for a subprogram returning an __int128, the live-registers
>     dump (log level 2) shows both R0 and R2 live before the callee's exit
>     (insn 5):
>
>       Live regs before insn:
>             0: .12345.... (85) call pc+2
>             1: ..2....... (bf) r0 = r2
>             2: 0......... (95) exit
>             3: .......... (b7) r0 = 1
>             4: 0......... (b7) r2 = 2
>             5: 0.2....... (95) exit
>
>     Signed-off-by: Yonghong Song <yonghong.song@linux.dev>

This looks like a bug fix for 16-byte return type support. Should this
include:

  Fixes: ec219322a9a71 ("bpf: Add verifier support for 16-byte returns in R0:R2")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/28973410219
--===============6204347742307451886==--
