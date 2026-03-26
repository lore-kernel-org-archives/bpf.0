Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87367239E6F
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 07:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774508792; cv=none; b=KyExMMXptxvzp6HApEqRwxFkvV1kSb5JLoOCfq/gpgzS/EiqxH2mlkPY7GXta4DWEflhOXgEykY7dzKnkuoiB6aDmh7NvkBox9P32SGclkzhJcfOwPVnHQpuvWFuAU+9pzGRu2Xhw1UBr80UpKO5hDoQp8XO5Ibk17JkQVVVZH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774508792; c=relaxed/simple;
	bh=MMCWhY6Y6Wmu8+GcHAYSBPuqCtMPwJnnC29Hq3sIjmc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=GH0tm//NB/KHDeXha0YLqdmkL9j020FCGR1DBskDG3GrEbfTZP/gPwBmsjeQECKHTDoxi7cwdk1kmdGEuGde4rxPtxhBOyFw0U6HH/Bs99NEMkj5bHDmycH6dSM3Gm74WrYFWjuUsSDsFdm7ZujTiS9LoUJ33IKUBXy8iuHJXro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jQBrbXEw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jQBrbXEw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB958C19423;
	Thu, 26 Mar 2026 07:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774508792;
	bh=MMCWhY6Y6Wmu8+GcHAYSBPuqCtMPwJnnC29Hq3sIjmc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=jQBrbXEwomL3VcR5v5rYkAiU0Ca0ykAhKYhT7853K63yicYTLIEALKKwc3q2qnfV9
	 Loo7m7ooXB9xe0qbBtvB7moj6ZdSPWzKn73hpXw4iOy1LrCiwDoCrLmcN6ItEPStrt
	 FwXDgnC/sghJpQpQGxEApGlouyYujuC+e0dmZPIY/5rNdz8xftu20bGvt6wsjGb9jV
	 p1WWyipAeEvC4xqXSRa1/Q0eqij8IWnGlKlbS/B/ic16SUxoGVlbFKmmkdNa3fFPvs
	 TA1HYJNixjGiQeQbDQ0K1Ap1LKkGgeukL+b638H2ZB9y6dk18vIuK6mCBJusUMjBtS
	 V6XUOnPHG93Sg==
Content-Type: multipart/mixed; boundary="===============6550496488439065114=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <95bf9dc4234190108b3cce72665855ef2e1e5c88b25c60a4df026840d75e64f4@mail.kernel.org>
In-Reply-To: <20260326063329.10031-3-tangyazhou@zju.edu.cn>
References: <20260326063329.10031-3-tangyazhou@zju.edu.cn>
Subject: Re: [PATCH bpf v4 2/3] selftests/bpf: Add test for large offset bpf-to-bpf call
From: bot+bpf-ci@kernel.org
To: tangyazhou@zju.edu.cn,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,tangyazhou518@outlook.com,shenghaoyuan0928@163.com,ziye@zju.edu.cn,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 26 Mar 2026 07:06:31 +0000 (UTC)

--===============6550496488439065114==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> The test utilizes an inline assembly block with ".rept 200000" to generate
> a massive dummy subprogram.

The commit message says ".rept 200000" but the BPF program actually uses
".rept 32765" (the exact minimum to exceed the s16 boundary). Should
this be updated to match the code?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23581269665
--===============6550496488439065114==--
