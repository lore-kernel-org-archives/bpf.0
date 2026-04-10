Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E10321CC5A
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 09:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775815022; cv=none; b=WJs6BT6JGxJkWNkRTLUt8CTVoMLgjmdPeSB4up/OTsIr4FnRkgDGtjy/WoKOC+S5vkpL0VQb41TaDOLvwdtpWybHSc96xtKWlJw7AKc3Qmrecst3brcLaXXT526AOeULbYYieKwfpOxh5j9wZoh5em1EycdZ9AV7gW+DJHw3qJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775815022; c=relaxed/simple;
	bh=B/5ae8oXq+2kRIfmA91r6L7GTznN82iVhCDJlqq3nZw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=MA8urtUZSN8o5OKoEP45Yxuywz9PmPiEeaYSte6+D5QDSCSGgIy2ft9YmjH9HHEj/GfqmHkN4a/lcr8PgfdGaQ7fjsllHLDj53MZmwgsAADPp1TzsPjDaBz6b/PkVnjaIxwwUA4MvzHyZCTaAKdUnmZH18c6XsXiyjV6HJNOOWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bRBVBbwf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bRBVBbwf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56CA2C19425;
	Fri, 10 Apr 2026 09:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775815021;
	bh=B/5ae8oXq+2kRIfmA91r6L7GTznN82iVhCDJlqq3nZw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=bRBVBbwfPbOMBcvLdl0A1WwHqf0PebB2d2fiR77Z574MhUn6uWhV96JA+wHHvdDaZ
	 6IExMPYCJaaqnIVPoVAvmJOpi2snPt/N947BHtAuWcW8I1HPWWQCwpE4p447G+A7K3
	 M00KtxeH6zwFDiOcw/RV6+e4WQY2/fODuMwuS4Ez5gwmUtrIUjvzIXCcFausvPdDSs
	 ejsQ7ViAIIDqrE1WEO3DrOHhGyNMq+rRa6hXOMPh3hQn+aDOFwyz2vN8ypHsWPJ1GL
	 goCGJ1njkFFuyDPU+aobDFdmZ8GdSJ7lV3k1sy5z8aSFnoBFnEqj6cQObTG90dg6Hf
	 e6WiBETyTOxLg==
Content-Type: multipart/mixed; boundary="===============1820621013981176602=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9b7c425f70e14b03974560c9b9d2406f50a8903f8df538cc253bce3203839653@mail.kernel.org>
In-Reply-To: <20260410-patch-set-v3-6-1f5826dc0ef2@gmail.com>
References: <20260410-patch-set-v3-6-1f5826dc0ef2@gmail.com>
Subject: Re: [PATCH bpf-next v3 06/13] bpf: prepare bpf_liveness api for use by static analysis pass
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 10 Apr 2026 09:57:01 +0000 (UTC)

--===============1820621013981176602==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: prepare bpf_liveness api for use by static analysis pass
>
> bpf: prepare liveness internal API for static analysis pass

This isn't a bug, but the commit body starts with what looks like
a second subject line.  Was the intent to have just one of these?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24236538770
--===============1820621013981176602==--
