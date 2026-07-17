Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F97F3C9ED8;
	Fri, 17 Jul 2026 08:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784276987; cv=none; b=DQoJAHi2/tGCVMtwxScJh60YCD+YRSH6MfNnXCreNAhRz6H3qeCxujaQunep1bBVoNilvEAgfRVpRBGtIGaPECg+USFYEeFiYACAf5kIEwo5EMamvsjQ3S4dI1iOE6e27lh4W7eoNrIaIPzoDMsGjRIbLe8Q8vxbo7+O2YrW0c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784276987; c=relaxed/simple;
	bh=NeYcvDDFS3gI2oTB3Qxfeisj1GVZwzIGWMPBmCGgmzk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=pkCErjHgrckbQ545x8P0F6jI0OqcnhQNNIkTq7N09dGD6t07ohwI63hfkGY6ayQL1bZ7nuaeziiDC34wJuYaUhdE83Fnoff556x2Lfp4ZaosQstU1/nkRUsJ/wXUUeKaQUZL/kkYKXkFydLoaKwFRGSsSGrhCUb4MuBGfKo15Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JHeKGqGS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JHeKGqGS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E28B31F000E9;
	Fri, 17 Jul 2026 08:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784276986;
	bh=KVNxC63LOWRqbOTpimt93dPKGHQeblwVBPWQ17ePLPo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=JHeKGqGS5Cr9ESevlw2q6nXzM7w/M9EGlruDKp0PxOkSUiwWoahLstWewNugBJMQj
	 TfVfT9GJC49kAsnp+l28txoi40pA0DtB+mRQgDtlW27bPoOZZASWcwqglfKR9kXH4W
	 +95+9l1wAj4X39ik85j4+ol7NF2RwwGyR/K4xlJiBaaFTd84uTI1MGptv44Cq5Ecvu
	 kwyIJcSduQEAfh5uRv/jGo+yEpc8mu2NE8TBvCvQByVhQRg25nJRA9szwvk6m9YhDl
	 0SbCcFhTky26MhuPqfRyUEkBUIiuXnUFIFDMdcWqL/+jy0MeoEXAOBTTcZWo0GqMcF
	 f1OGVDwxGpqCQ==
Content-Type: multipart/mixed; boundary="===============3010414839372478109=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6c21d7ae537ee667858193d330b8b0bac579355f44a650e66de881db958e3810@mail.kernel.org>
In-Reply-To: <20260717073237.1048-1-yanlonglong@kylinos.cn>
References: <20260717073237.1048-1-yanlonglong@kylinos.cn>
Subject: Re: [PATCH] libarena: use ARRAY_SIZE macro in test_rbtree.bpf.c
From: bot+bpf-ci@kernel.org
To: yanlonglong@kylinos.cn,andrii@kernel.org,eddyz87@gmail.com,ast@kernel.org,daniel@iogearbox.net,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org
Cc: yanlonglong@kylinos.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 17 Jul 2026 08:29:45 +0000 (UTC)

--===============3010414839372478109==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

>     libarena: use ARRAY_SIZE macro in test_rbtree.bpf.c
>
>     The ARRAY_SIZE macro is more compact and more formal in linux source.
>
>     Fixes: 6c3e8a4d4765 ("selftests/bpf: libarena: Add rbtree data structure")
>     Signed-off-by: longlong yan <yanlonglong@kylinos.cn>

Should this commit include a Fixes: tag? The original code in commit
6c3e8a4d4765 was functionally correct - 'sizeof(keys) / sizeof(keys[0])'
produces the same result as 'ARRAY_SIZE(keys)'. This change improves code
style and readability but doesn't fix a bug.

Fixes: tags are typically reserved for commits that correct incorrect
behavior or address actual defects.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/29564321134
--===============3010414839372478109==--
