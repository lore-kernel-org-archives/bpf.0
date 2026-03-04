Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C067328B61;
	Wed,  4 Mar 2026 15:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772636932; cv=none; b=bB+Dy1TC74nLt0nOx72PkYcCnCErRW/x0+/qUy2gDmkIjMyPAABAiQSotfcachzW0cnM79cquTGo9ye0TrztbaxCSLlxHG1boInx8l9O03QBryIdXB0shnWBMUGJJueYU8pBvw9TJx6bP+H0O4s8+tuC8Pnnhx0BljS0Oiwei9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772636932; c=relaxed/simple;
	bh=wMj1sW4BggLr2JUxa3DMVobMm0AQerjF7/tANAFiez8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=AQeg2CMPAYlbR6CDGtIyy9R9Ut/KoF3iyhEOb0dnSKXz82LNNlCyIfylnosofBpWV+FyVlQHk3yC+8zvZs1j6hQrDUyhufXbQNdje2Rliq1Ql+hhQb/K+ifaU+EHNwQoMiVrNhMh4kD4Bs0pLdvxmeZTpDmo2WK491UEuEaDkbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AYYaw4+B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AYYaw4+B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1090DC4CEF7;
	Wed,  4 Mar 2026 15:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772636932;
	bh=wMj1sW4BggLr2JUxa3DMVobMm0AQerjF7/tANAFiez8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=AYYaw4+BeIXSBj9JHUiEl0m/+wq5w03rik7IPLeDGyw0pclhahfQGXathcbQ/c8rJ
	 cAkB7A8Pt/Pu8NraYlGdaGJk/IbxzK4OMPCl5w5+7jfyuCswJYiwlFqXJuU/Tazcd3
	 6vyx5Idruund6H1UiAXPZZ5frBtqp/X8FB1LuCBMRl9SJS7qb0o2HDl6Tcz/soDjS/
	 UUwdJfTTAi+LoC6zARxi88Mzo9NMqax0pIfmoHs5gnA4cGXTE+yC8QFKeosSmeZUa1
	 VwxawluYhrCWphkuojGp3pN04hhgVMRD62yF4+0XYF04dTnjAXWSlngfT4Y3Ljt6p1
	 A1+hGrt54UjdA==
Content-Type: multipart/mixed; boundary="===============6208074141407502198=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <39625108dc3e179cd05df6e35a9e83717b1066376ab0f1aa868ced89abf1d677@mail.kernel.org>
In-Reply-To: <20260304143459.78059-4-pilgrimtao@gmail.com>
References: <20260304143459.78059-4-pilgrimtao@gmail.com>
Subject: Re: [PATCH v6 3/5] bpf: Add bpf_list_is_edge/empty kfuncs
From: bot+bpf-ci@kernel.org
To: pilgrimtao@gmail.com,martin.lau@linux.dev,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,chengkaitao@kylinos.cn,linux-kselftest@vger.kernel.org
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  4 Mar 2026 15:08:52 +0000 (UTC)

--===============6208074141407502198==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Add three kfuncs for BPF linked list queries:
> - bpf_list_node_is_edge(head, node, is_first): true if node is the first
>   (when is_first is true) or the last (when is_first is false) in the list.
> - bpf_list_empty(head): true if the list has no entries.

The commit message says "three kfuncs" but the description lists two
and the patch adds two (bpf_list_node_is_edge and bpf_list_empty).
It looks like this is a leftover from v5 where there were three
separate functions (bpf_list_is_first, bpf_list_is_last,
bpf_list_empty) before they were consolidated into two. Should this
say "two kfuncs"?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22674350640
--===============6208074141407502198==--
