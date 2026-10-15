Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775F9541E67;
	Thu, 15 Oct 2026 17:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792083978; cv=none; b=ZATuJLRA1CFfFPMtcNjhTtlnVRRMJaydLLdOLsNG6s/VbChsHMiwdx2LJXOqt4/dRdLiSHYMKxbPJZiHH5Tbs+xJXjFgLRYPrHEyRiAsf/cHg0Z7TeAig7DGMbiOIqPtjW/V/38OoTms2TEUHVxRsTx+FzsxpOprKMSQpfodID0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792083978; c=relaxed/simple;
	bh=KjodMYbnA9m91a6xcSvuCss6trwsthbdX+Ns66ZfJnk=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=rPE2rVJW+opjAfL6iXIHLKa/HprBSFL/vS4uqyu1caVqV4PFJNbiGmUpmNSi9yLgMFyUQda/dbcED5TAm+WFIXlJ1E8rOTo7gsWllwHUl6RpmNZfueVlfJihB6wHWS5Bu48+i0oit5uChvUN1CkSui/rUQVq2NfnZyoehm8xRLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZRo7Ui4m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZRo7Ui4m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A311A1F000C4;
	Thu, 15 Oct 2026 17:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792083963;
	bh=FW422e6T9ArO/ZaeXBPKkSsp7mQcTXDZLhUpxnq/rR4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZRo7Ui4m/YEGepM7LywTBGD+o4zs/G9QI1IqfXPGubjhcONWu6XaavQ+fQ7lV3RFC
	 GfpcUmL5FU0itzz/xywHZwZabQi5aPev1/5CP2EWak1YFAZtqd+pnNMEi/LxZyzvzl
	 Cjbb+jy7YiGJi2GzbFrOkR6Cnt2y4i7eVScLna+EJn1mMSU9lZeUufQ+/X7RZXfk3/
	 Kb6u1z2PZax11nH2m6x0anHUeCWhpOCuYcFH0i2aClY6/iD8GssMyKtzeNZbIzQewF
	 80B9XXZax042ureI26vypWTnoECyBKdx089vwikNhyKHZbCm2QZFdMuzg+bXyh3bcu
	 dP+ivXuFUUuVQ==
Date: Thu, 15 Oct 2026 07:06:02 -1000
Message-ID: <4e063370a5b974364587fabd04c1aaf7@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v4 0/3] bpf, x86: Support fetching AND/OR/XOR atomics in arena
In-Reply-To: <20261014125017.1426212-1-puranjay@kernel.org>
References: <20261014125017.1426212-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Hello, Puranjay.

On Wed, Oct 14, 2026 at 05:50:10AM -0700, Puranjay Mohan wrote:
> A fetching AND/OR/XOR against arena memory is rejected on x86-64:
>
>   BPF_ATOMIC stores into R1 arena is not allowed

- 1/3: A fetching atomic through a number now fails to load with an
  empty verifier log, where it used to get the message above. That
  seems problematic. Can that case keep an error message?
- 3/3: sched_ext/for-7.4 already synced a cid.bpf.h from scx which
  probes for the fetching atomics and keeps the CAS loop as the
  old-kernel fallback, so this conflicts with it. I'll pull
  bpf/for-next into sched_ext/for-7.4 and we can do the modifications
  on top.

For 1/3 and 2/3,

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
