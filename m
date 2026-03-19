Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAD5330D43;
	Thu, 19 Mar 2026 03:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773892694; cv=none; b=mM3pxNFXUU4N9N2Sr1gBd1mgS9x6bbh7odj0YmutqYB8i5za88ftvtKL7LaXBfsuCjhsnFTHncyMwuDaiaYEnfSj8Fh4pcrMApB3pryfvCr0vE1PeMXFwhGvpcBU7jnidIRWMJqs1/56O/nmx7SaIkgpJJroOQsdyVp5vHsxg7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773892694; c=relaxed/simple;
	bh=aXK622JtSXQMEp2SQnA+NHyhFJ4PVhCIymapKPSD0Rg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=X3ZqDz4JT5peZPqpjPOKzqU1bDsGYrl/awCidZv4Y3cpKe2l+6hepeLDMfQhD1YFp2MoSTJtMDNUnj0haGyRydHcseqkfLTDX6mHEUUcGbqcPppZMjkJkpEJzP/J/CBbJqf4n7h5/Sb+wEsqr6Ni5wY+1bCq7MxwL88JU2C9RKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YiwD485g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YiwD485g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D695C19425;
	Thu, 19 Mar 2026 03:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773892693;
	bh=aXK622JtSXQMEp2SQnA+NHyhFJ4PVhCIymapKPSD0Rg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=YiwD485gnt+mCG7h1Y9AKnpNjYKVyxfS3SMMrD4T3fGbjlNVWQLj94WbNAOR6PvEj
	 KAk4svngxvkMXBa3Iy0EDApza4mpm7doAkULGOMSjdNOR/dFIMVjVyRTS/QdCksPZB
	 DQfwGNiB5SnyAjvR6M6KxiwCHnzfUc2x5335HM9Ibf9LHvL8hr1ER6m0tRkZCdRu82
	 plgBBs7s30wSfXHdA1Xc3uI5sgu8CGlAqS9QOpsLCJ8ZybV+k/Ld0aMg1oR3DwRNok
	 8gdw7tbI4URAqc4PjpmX/pJSeD1aeOrLpnn0cSOthPJjpmEh8ts7Koqn7Xt3gaQlto
	 Fnwzu+l3Air+A==
Content-Type: multipart/mixed; boundary="===============7791003114239354641=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <87c4c600b8e7bbfa2f924701996532378d20c89791083f7c10886498177c614c@mail.kernel.org>
In-Reply-To: <20260319031227.330505-1-sun.jian.kdev@gmail.com>
References: <20260319031227.330505-1-sun.jian.kdev@gmail.com>
Subject: Re: [PATCH] selftests/bpf: trampoline_count: use dedicated bpf_testmod target
From: bot+bpf-ci@kernel.org
To: sun.jian.kdev@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,shuah@kernel.org
Cc: martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,paul.chaignon@gmail.com,bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,sun.jian.kdev@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 19 Mar 2026 03:58:13 +0000 (UTC)

--===============7791003114239354641==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: trampoline_count: use dedicated bpf_testmod target

Alexei Starovoitov asked for the subject to not use
"trampoline_count:" as a prefix, since it is not a standard
subsystem prefix. The preferred form would be "selftests/bpf:"
followed by a description of what the patch does.

https://lore.kernel.org/bpf/CAADnVQJ9HZTHKCzwmqUwhePbCQ5qPQrSd=yejUS17eHbMm0fuQ@mail.gmail.com/


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23278379564
--===============7791003114239354641==--
