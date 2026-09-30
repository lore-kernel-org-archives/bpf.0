Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D5E24293C;
	Wed, 30 Sep 2026 01:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790731054; cv=none; b=sC6SAMOo4ddjDAgFR9qQ/ZSQnDz3FC3aimSG6oHA4wzwgwV4PLxh7dhq1vKDp3EfbO8YvBTydb8UJWqM5jqgitsHZjm4tZpCdUdI3ByV8xGYe+MWsi3jPp+w51+oGsyZZSg5sBN3wLNblBZTuPyoxN0NFN3TZbuFHOa4XX/G1e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790731054; c=relaxed/simple;
	bh=VdI2m/a8nuHDN7n4LYA/dPiHQE5Jww7D4ImLctaE8mQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=qorZU07/A4p0LMpsSZ9n736hDTpbs8XIrmUnw2gBiyBr9yWqQNrp1CSUYEImOdssKvfWTEZKz7yMBW5cb1OkKTkQRR/e8dpfazO+38E2Yybkx1+bl/P4jUNZNg1wni3KaJCI9R6vWD+88R3Jq9/dEmAjh3Zuy6p4IG+vxZTuQXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MwETFjAg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MwETFjAg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A75E1F000FF;
	Wed, 30 Sep 2026 01:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790731053;
	bh=72UX9q+LRjrcmPYDrUvgInI9Dx8b61MvNOcSSkNVxqA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=MwETFjAgegF3B3DrnRWbVfYktQYvT3p8TOsnvsemm2n8pVP9BYOIpqqRpFGw2+ZdN
	 Y2jVLkD+4cjVQ0lqZMSQTwUKAcerUNeW6p0JPYHMbwPvE5GY6qFH2MnUQ/scGRg4sp
	 YaJKx7ysaPchx/WrSR/n2DFkNxThyDloh5NmvKx5mjyBx8/8asVQclb49ujcmKA2jm
	 oOj4/dMQ59SxcHCR2pg0IFBdeex0ygkmBqjSoXQj3FmO2/kBd3j29JctmFBaW+yKg9
	 Medibl5pAFZ1TbWi+zlZFQtJF4+hyOyyyjF1djs7zYi8EA8LCaBN0yOrjMp1N6XLGH
	 TRP92RJGE7T1g==
Content-Type: multipart/mixed; boundary="===============7906105332123239923=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d3222c97d0d5e3892be54f09427ee273d31f567fcd7f09274abd39d36be115d4@mail.kernel.org>
In-Reply-To: <20260929-ksyms-tune-v7-1-be568ceef41e@gmail.com>
References: <20260929-ksyms-tune-v7-1-be568ceef41e@gmail.com>
Subject: Re: [PATCH v7 1/3] kallsyms: Match compressed tokens on the fly during binary search
From: bot+bpf-ci@kernel.org
To: jim.cromie@gmail.com,akpm@linux-foundation.org
Cc: pmladek@suse.com,thunder.leizhen@huawei.com,mcgrof@kernel.org,andrey.grodzovsky@crowdstrike.com,rostedt@goodmis.org,ljs@kernel.org,kees@kernel.org,david.laight.linux@gmail.com,masahiroy@kernel.org,olsajiri@gmail.com,linux-kernel@vger.kernel.org,linux-kbuild@vger.kernel.org,bpf@vger.kernel.org,jim.cromie@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 30 Sep 2026 01:17:32 +0000 (UTC)

--===============7906105332123239923==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> kallsyms: Match compressed tokens on the fly during binary search
>
> kallsyms_lookup_names() runs a binary search across ~184k tokenized
> (compressed) symbols.  For each of the ~17 comparisons in the search, it
> currently decompresses the candidate symbol into a temporary buffer on
> the stack before calling strcmp().
>
> Comparing tokenized symbols directly in compressed space is
> impossible.  The BPE token table assigns values by frequency, not
> alphabetical order (e.g. token 0x05 might expand to "zebra" while 0x42
> expands to "apple"), so comparing raw token values scrambles
> lexicographical order.  Even sorting the token table alphabetically
> wouldn't help; "bpf_" and "bpf_foo_" do not *have* a determinative
> sorting order, because the suffixes following those tokens would
> matter.
>
> However, full string expansion at every step is equally wasteful: of
> the ~17 strcmps in the binary search, only the last needs to check
> all N chars in both strings, earlier steps will know +/- outcome at
> char 0,1,2..N-1.
>
> However, full string expansion at every step is equally wasteful: of
> the ~17 strcmp()s in the binary search, only the final matching step
> needs to test all characters.  Earlier non-matching steps diverge at
> the first differing character (0..N-1), but the baseline expands every
> candidate symbol to the stack unconditionally, before comparing.

Does the commit message have the same paragraph twice?  Both start with
"However, full string expansion at every step is equally wasteful" and
make the same point about wasteful expansion. The first version uses
rough phrasing ("strcmps", "+/- outcome at char 0,1,2..N-1"), while the
second version is more polished ("strcmp()s", "diverge at the first
differing character"). Having two paragraphs in a row starting with
"However," also makes the rationale harder to follow.

Should one of the paragraphs be removed, probably the first one since the
second is clearer?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36651779347
--===============7906105332123239923==--
