Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B904DE702
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 11:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791546368; cv=none; b=snE7lxST2T45MEjHiozlul/ZQtXXLWcuS/XwCcF2zaON1UWH4o2ckWhQsbmHZnuhwEYKCxGNNd9MF+qhRYxB0x60WE20ATa7MQLm54n5E+mrVQUMnYyjtYHG6AK9/mODmes4OTIimum1RBsiFUcCD6uXAvG4fj4Gwu7KuDt9bYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791546368; c=relaxed/simple;
	bh=NVPaqSDIXSTjy8fxRkeSMAdK+zG0lBRDo1RFRH1yotE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=lIPfYjRpBWhZavCQDH8XOgs5QJuBFWq/3DPL9a/5ITZyatVbB1efftQe0BP3hX36M5E1zCmPo0xrfGJOcl4DcY7skeSK/zLrBbZa+o7ttXz5Jvn0JuWY910zNNqKGP6bXFYxrSdkuxS//NSkKNqaPKNmxyvdWXemRjjizz7sw/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j/9VbafY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j/9VbafY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CFF41F000FF;
	Fri,  9 Oct 2026 11:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791546356;
	bh=cNt3RcynQHus0N86hrMSjPweI0aptdlWhaUg7CB8GfY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=j/9VbafYay+M0CB599ZyvoQH8nak5vOGKHJB8ryus55fGuuGZN9Eo/pWqaWeY182a
	 cdih0qz4zvxrfru3nPQbczDNAW0mUmHd8rWV3ZH3AXYQABN0LF9643zuhdv4XeIVaL
	 xnB4R2ZZNaO9OOaEugNJR3e+f3m+IsCq8Ey/AP1rqT1pVwtsn9vQDl4Iw4CefwnttT
	 eyg0uuHrWdNChtiu02lO8CumtoHiTKskvPGtC8DT3+m0AWPH0y8ARtZHxAeOvVyR8q
	 uDC2kGIwQHUVZ9bERGb9m/JDtJbwiatzBQQmlkW+aTZYDJth16dDagSL9Fnbq4rVAl
	 8iQsyMIg3ooFA==
Content-Type: multipart/mixed; boundary="===============7849088717470891536=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <032678d06a32de910489f24f09b23b7c9bbcd523faf3f99af3beabe27bc95758@mail.kernel.org>
In-Reply-To: <20261009-scev-minimal-rebase-v3-31-bcba9bc53ac9@gmail.com>
References: <20261009-scev-minimal-rebase-v3-31-bcba9bc53ac9@gmail.com>
Subject: Re: [PATCH bpf-next v3 31/51] bpf: record basic-block ends in insn_aux_data
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org
Cc: andrii@kernel.org,daniel@iogearbox.net,kernel-team@fb.com,yonghong.song@linux.dev,ezingerman@fb.com,eddyz87@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  9 Oct 2026 11:45:54 +0000 (UTC)

--===============7849088717470891536==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: record basic-block ends in insn_aux_data

TL;DR: Commit message only: author email (ezingerman@fb.com) doesn't match the
Signed-off-by (eddyz87@gmail.com); no code bug. Reset the author or add a
matching Signed-off-by?

> bpf: record basic-block ends in insn_aux_data
>
> SCEV needs information about the program's basic-block structure.
> Piggyback on compute_predecessors() and set
> insn_aux_data->bb_end for an instruction if:
> - it has multiple successors, or
> - its sole successor has multiple predecessors, or
> - it is a jump instruction.
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>

This isn't a bug in the code, but the commit author is
Eduard Zingerman <ezingerman@fb.com> while the only Signed-off-by is
Eduard Zingerman <eddyz87@gmail.com>.

checkpatch.pl reports this as a "From:/Signed-off-by: email address
mismatch".  The other commits in this series use eddyz87@gmail.com as the
author.

Should the author be reset to eddyz87@gmail.com, or should a Signed-off-by
for ezingerman@fb.com be added?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/37923187511
--===============7849088717470891536==--
