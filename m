Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F159B37F324
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 18:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789409957; cv=none; b=ZQeJ0R6rEWdVmvHNVY/nAxXqpR1X0Nco/JbEHZRoNKII0FTQBMpmlBNSprD0tq4W3j+lNN/svDc0LNVm6GR/Xyi/pcCNXwa5mr9K/LDYAgXjB/LH7vywD8crzWmCedpshvuzyNSKN1ZWKN0zwVf1Md1r6WiKJXXYutZyrOIF8Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789409957; c=relaxed/simple;
	bh=TgWrvcnhyvjhOqNsrLlzN5NeEfnqJjCfDYF3Lv7tQBY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=gV0NAKUg+9d2GyV6TlYY30bpgqdHuXuO7R8Y/v0O1eDiPk9UKuv2mtJGpujdxUTU7tcRhjWh+OfVZdVX5acFdTPNZW72N2rt2tfCOWq68WP9L0IuAIyOHI/XgcmsBVQ9UA/RTZr9/M4bNm8Ry1fjimcmKB3gUK3zdX4sNN7lQeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IFGBEhM9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IFGBEhM9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 127891F00893;
	Mon, 14 Sep 2026 18:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789409955;
	bh=TgWrvcnhyvjhOqNsrLlzN5NeEfnqJjCfDYF3Lv7tQBY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=IFGBEhM9eYR/L008H3NEw9EVCac781CA/vIhM6q3/f29WGfwfd2ddLNHwMhiVs+Xk
	 YxphpmGOC78kHhn/SYtY33Um/pxj5eAdrBPqxFKped4U6eFz9PNRvMfgUHL5PhT6rx
	 kfBndhSEG+GV+b+ax/5cT9LQq78eAOdgTqNs3CZpYWmo/Se3sAk5mFcgKwvrT4uIwo
	 IQsA/lg3Rf3jBZwmQZH0uK6JQz08+ZHLK4H+/hFDJ+9YYeVBHowXKTHuHsOApJwXwG
	 VoIOYl1vc554JYgwW6x976td78bG4hF2LmErIkzOtwt5SuNBFsDKwJ8kwKywVHlo5p
	 YOf1xCxBu2aTQ==
Content-Type: multipart/mixed; boundary="===============6467856775520387655=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <fe0e3e0ce333ddf27240d7582cfa5399298d6a9d420bb7b68998197cd13e3be5@mail.kernel.org>
In-Reply-To: <20260914170326.249953-7-daniel@iogearbox.net>
References: <20260914170326.249953-7-daniel@iogearbox.net>
Subject: Re: [PATCH bpf v2 06/11] bpf: Clear insn array jitted pointers on map reuse
From: bot+bpf-ci@kernel.org
To: daniel@iogearbox.net,ast@kernel.org
Cc: memxor@gmail.com,eddyz87@gmail.com,a.s.protopopov@gmail.com,info@starlabs.sg,bpf@vger.kernel.org,saroy@redhat.com,jamesburton@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 14 Sep 2026 18:19:15 +0000 (UTC)

--===============6467856775520387655==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Clear insn array jitted pointers on map reuse
>
> An insn array records, per entry, the xlated offset, the jitted offset and
> a jitted target pointer in ips[]. bpf_insn_array_init() runs when the map
> is bound to a program and resets only xlated_off; the jitted offset and the
> ips[] pointer are left as the previous owner set them. A program can be
> verified and JITed and only then fail to load (e.g. bpf_check_tail_call()).
> By that point bpf_prog_update_insn_ptrs() has already filled ips[] with
> pointers into that program's JIT image. Thus, the map is handed back for
> reuse with the stale pointers intact. If the next program reuses the map,
> the stale pointer survived the now active program's jump table, pointing
> into the previous, freed image. Fix by resetting the jitted offset and the
> ips[] pointer alongside the xlated offset.

The sentence "the stale pointer survived the now active program's jump
table, pointing into the previous, freed image" is hard to parse.
'Survived' takes the jump table as a direct object, so it reads as if
the pointer outlived the table rather than persisting inside it. Would
"the stale pointer survives in the now active program's jump table" be
clearer? This is the sentence that describes the actual security impact,
so the wording matters for anyone reading the changelog to judge
severity.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34875126886
--===============6467856775520387655==--
