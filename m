Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741FB2F1FC3
	for <bpf@vger.kernel.org>; Sun, 30 Aug 2026 08:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788078886; cv=none; b=Liq8ErAYQov74TUJpCmWDsuz4DdeUocFj3yvVX7dbxzLfyDA03cohJqpRnfVgHf1u6SDLzeDonZEm7zqlCSF72c/sGnEtNWj2GKvRKNDYgcF2Hbf1S8i9tVkg/NePyDhNh/r8k+NdW1Htb3SoIZ/ONi72e2sp1GeW43YraLruCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788078886; c=relaxed/simple;
	bh=w3r5SZSPmoFCYi06KfN+/gBT8uZn4C7/MEHe9DUGgwA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=FfL02G6rD+41vvU/5gJ8YGVbG9OsQhOuKAGeR5i/+IAk3lb5SuhKHpysSbhk8cDRFaVBLG7qw2OIgMFeSZIlIyfn+XE8ELPFcolqIxnjh8jaNklpodXV1NDJyJJSqJbYGi6CmJDjymcpJtVZDxSOzW2tS483mMOwkFDxHioMNkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WUusxLI1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WUusxLI1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9710A1F000E9;
	Sun, 30 Aug 2026 08:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788078885;
	bh=FAh7UzWOEvKIqbEW1bP575mwP3xcmo9nI+BbgBmdhLs=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=WUusxLI1SeaS1+dfnhYbJfg5A96ThBDZcime5m4TPOTj1cHe/A5urWqXsOjTRuKUS
	 HsZ4Lhp8qPLmBhw1i3HtUQfSt9X8LfaEC8fA1MbWKLScuRlR6M1Idh0bMSsSICjyZt
	 5DVpnMNuCU86PBsadbwsDo1x+dyQmDdMX0fCM3b0DxVBOYX9X6n0e86sfQKRz68RBA
	 GDRQPgOjJFPlF9bno5bL4RP0KHloFjZplvfU/U0TwocuvZERClL48dL7Xl6MFf7KDX
	 XbIhePzYASqWYJDoNw20TSNIoa+TEJDXzYNacVHo/C1qqC9DK2lKIChCyBEA/JefaL
	 ARADok5x7p8Eg==
Content-Type: multipart/mixed; boundary="===============1819792611318794131=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c9b3051a0712ca0fd6e74cae61c37d79035c0faffaddc1e8e906194651d583ea@mail.kernel.org>
In-Reply-To: <20260830073125.360934-1-sidchintamaneni@gmail.com>
References: <20260830073125.360934-1-sidchintamaneni@gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: allow terminal gotox instructions
From: bot+bpf-ci@kernel.org
To: sidchintamaneni@gmail.com,bpf@vger.kernel.org
Cc: sidchintamaneni@gmail.com,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,a.s.protopopov@gmail.com,puranjay@kernel.org,rachelmenge@gmail.com,hargar@microsoft.com,apais@microsoft.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun, 30 Aug 2026 08:34:44 +0000 (UTC)

--===============1819792611318794131==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: allow terminal gotox instructions
>
> check_subprogs() treats gotox as a direct jump and validates its reserved
> zero offset. When gotox is the final instruction, this produces a
> synthetic successor one instruction past the end of the subprogram and
> rejects an otherwise valid program.
>
> Skip direct-offset validation for gotox and accept it as a
> non-fallthrough terminal instruction. Its actual targets remain validated
> from the instruction-array jump table during CFG construction.
>
> Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>

This looks like a bug fix for gotox instruction handling. The bug was
introduced when gotox instructions were added but check_subprogs() was not
updated to handle them. When gotox is the final instruction of a
subprogram, check_subprogs() incorrectly validates its reserved zero offset
as a direct jump, producing a synthetic successor past the end of the
subprogram.

Should this include:

  Fixes: 493d9e0d6083 ("bpf, x86: add support for indirect jumps")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33300101433
--===============1819792611318794131==--
