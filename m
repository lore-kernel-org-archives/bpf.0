Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C10920A5C4
	for <bpf@vger.kernel.org>; Wed,  2 Sep 2026 21:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788385867; cv=none; b=SJFJoGDJKJR8JTdGRYlmhy0ySuQ97mSiQAMFL50HqVEhYCBj2Hx9CrZzwzhWKUgyPztn/DJBmE7zpX1fjQ1Vf2EIHcc7KUX7mWwi85PSy+g3FcG+FKdTyUJg/PfbDgMx0csnwdqK4K22laQ728fA5hxCsS88wYUj8SjsAOgfauI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788385867; c=relaxed/simple;
	bh=/Fm+x5u8MnsW2iHtjfrxQgrMcqv/s74SR8faBfs1z6o=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=rrJCmpZ+SJUg94RJ5xcsVEJXOU8YgrzGZiC76JxlFK0ASXLTDcXCSswOM3n6lUvAEZgwFLiyvxG0KjLrKtV2JVUnkisjtG53EwT7klM7FwFekV4yuHH9BkTRxHHRtnOtukweDx9gmfTVmlXHlvHMf5AgI3p8t5oAUKloX0wY1eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZPdy3ApL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZPdy3ApL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA57E1F00A3A;
	Wed,  2 Sep 2026 21:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788385859;
	bh=/Fm+x5u8MnsW2iHtjfrxQgrMcqv/s74SR8faBfs1z6o=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ZPdy3ApLtG54SiRlkbHH3zqrNGGPbEY//TsVa1drAMPyNAa/j12P1lASvUbIw8noz
	 SKd7/CRQHbwbRkwVKtmf8Z8Qr1Vjq0BtGkG4WOfsOHl3YoxgX4DnfYaMnoMkRyRTym
	 zwjE30N3BhY1QZLxryUeJWrmkK49FUdxscBnDbZbCRKWSD65OXYnOZUt3w0TAphj/p
	 WHeTwVUgNPRrjypD9HTuDi/iDCLM7KPNFtdBDEKEKdnt3KRouiuZwa6Rg+Ed3lBGNt
	 w/fipI6oqa4/A/J+O4cWHk3KRRmAJVzfSLEJZeTeJVUobSKf1ObC11W8+gAKvPjh1R
	 CKzKu9PLw6FtA==
Content-Type: multipart/mixed; boundary="===============7787633404297070728=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <382c28145fb501893088543e193f09473779ce9858d11b0665efcabbe27d8f82@mail.kernel.org>
In-Reply-To: <20260902204439.287888-1-maghasi@disroot.org>
References: <20260902204439.287888-1-maghasi@disroot.org>
Subject: Re: [PATCH v2] bpf: Fix u32 overflow issue in map batch operations
From: bot+bpf-ci@kernel.org
To: maghasi@disroot.org,bpf@vger.kernel.org
Cc: andrii@kernel.org,eddyz87@gmail.com,ast@kernel.org,daniel@iogearbox.net,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,john.fastabend@gmail.com,brianvv@google.com,maghasi@disroot.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed,  2 Sep 2026 21:50:58 +0000 (UTC)

--===============7787633404297070728==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> This patch resolves the mentioned issues by adding size_t casts in the
> affected places.
>
> Fixes: cb4d03ab499d ("bpf: Add generic support for lookup batch op")
> Fixes: aa2e93b8e58e ("bpf: Add generic support for update and delete batch ops")
> Fixes: 057996380a42 ("bpf: Add batch ops to all htab bpf map")
>
> Signed-off-by: Masoud Aghasi <maghasi@disroot.org>

This isn't a bug, but would it read more like the usual bpf changelogs
to phrase the last paragraph in the imperative mood ("Cast the offset
calculations to size_t ...") rather than "This patch resolves", and to
drop the blank line so the Fixes: and Signed-off-by: tags sit in one
contiguous block?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33683717098
--===============7787633404297070728==--
