Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40FD1FC7C5
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 08:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785746954; cv=none; b=M3/eTHOSmoDlsgd6Yk+1X0ix9wxfvnulnKYGMZRg+ztRS264MGYAnKx1rkj9hFRCYCk3MG0YU5fyQVJM1C/UbebxkF3wOcCc2xoGTHT+CzHljb/XqKkmqgEP9hiWT2B6QAtnbGNvelBxiIgc6Z5XOk/CnZr/LpFbhms0GsuZWNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785746954; c=relaxed/simple;
	bh=DE/j9qH4y45AL9P502yI7iGHisWVYQIWxWrATODlI3Y=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=HUT2Mmfkds9KYgHEK+RD6UV+Mrg0L/NCUR6vTHrz06arrUqI0cGyBbQNNCaZISKBVkV32yC4Y0BFhAKPg9PKTX34gFK9xMhZnmafY5uxKpx185Odu4i68DEGfuzau7LT2/1QLdia6BWvRZwach7/ib/B6bNOwZqLJa0sW8GaWgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BP8TJXkh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BP8TJXkh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 086631F000E9;
	Mon,  3 Aug 2026 08:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785746953;
	bh=DE/j9qH4y45AL9P502yI7iGHisWVYQIWxWrATODlI3Y=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=BP8TJXkh0NSKkp1+GLBLNDnb9Y+R7XOgUqPf2R0aBISQc5tBDCjQdNN0HeRNOCt7j
	 7mVA2FcHoKoMG3zSze33/SGCtqfJB8R4NckD9vCVt1MPEsoJG2xqziDX1/VF05p2oa
	 9Ntm0RRySwHaCmD9U9Zu+XXiz7OYqylPA5OrrQHzyYhYlRYaoq0X66xp8DIWOOUno4
	 nKROQarDHYLp4HGxyVHbhaIZeyGu9sV4mrA/h3tjHPceRsYPfZa3rGTsZDKoIYwpbR
	 B3y047xTz5FgW7uE5/z4FLFzm66Y1u3PCKZrj3BssQ/FHEX+x+VHWZDO6FhAjCTFwm
	 nz2oF5DTQY6mg==
Content-Type: multipart/mixed; boundary="===============2376386106992387411=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <94b5d9e94c85101e583bb249deb47fd5187d4823fba0f71a03832b1e5b9adb0e@mail.kernel.org>
In-Reply-To: <20260803072733.191502-3-memxor@gmail.com>
References: <20260803072733.191502-3-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v4 2/3] selftests/bpf: Adjust veristat stack depth parsing
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon,  3 Aug 2026 08:49:12 +0000 (UTC)

--===============2376386106992387411==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Adjust veristat stack depth parsing
>
> The verifier now reports stack depth statistics using one record per line.
> Teach veristat to parse the new maximum and per-subprogram records while
> retaining support for the legacy one-line format used by older kernels.
>
> Increase the bounded backward scan so it can include all 256 per-subprogram
> records.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

This isn't a bug, but would it be worth a sentence on the `stack[512] = {}`
initializer? With the new one-record-per-line format the legacy
`stack depth %511s max %ld` branch never fires, so the trailing strtok_r()
loop would otherwise run over an uninitialized buffer - that seems worth
calling out in the changelog rather than leaving it to be inferred from the
diff.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/30794340667
--===============2376386106992387411==--
