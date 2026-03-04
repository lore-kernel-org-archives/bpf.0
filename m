Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E45260592;
	Wed,  4 Mar 2026 15:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772636931; cv=none; b=FkhHVLvKQ0s7FhNK+gH1sTzjeWCTduIHKY2j+NBw4WpoUACqVzEhOifvi1nDWfeetsJ69EPxUcrrocwoRXNjtLA6xD4EYq5wdf0KH1GF6dNYS+PJQo7YqBPblRv325+Kr7UTj+z3GzBF0ZA8C/D5xohxTvOYCF6XVmX4VHMP+HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772636931; c=relaxed/simple;
	bh=phU2mDR7qUT0nY9/X1sSQ6Xvlau9+OsTUrDS/LNizQg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=h0nAb6R1p/RMBYnko4dgk8WRoiyJdL/atgC8dLON9OsQeoI8dOTQmOXFAHFd9l4XWMhJky8DR4/BbZMVfdPsxSa2qC9FlyGU7jFJDQnAM2jxA7/jcrRPM/yu7Sts7rxzP/pEjgLfYpRUrGrhsgmhvnVTMSs+R8VryD8tORCDL8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U0BIrEl1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U0BIrEl1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36AE0C4CEF7;
	Wed,  4 Mar 2026 15:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772636930;
	bh=phU2mDR7qUT0nY9/X1sSQ6Xvlau9+OsTUrDS/LNizQg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=U0BIrEl1RSIVkyQI6HLPTF02N+/AmD3qjmcg6m6kW4fFfc2nNlI4r1Fgd8BBwXCJt
	 l9Iz6YzxAkekqMejURb+4L2N8tTqWOFevPZ+jSHsUmcb73eCAVffbgHfKvDyAgIss7
	 ktsWcmkHoBklSNjMf94gzKHo2OC3V8rxqoRUm+NaK763q6rSxdQoqUgEyE1jRgHy1h
	 VXsjuVgkxC1sR6e/LVB2i+5efGNiJDtlSwfiwtJh7MZ5bGYkmO0F5MjCHSiSZOwFMT
	 UyZw/IqtXMaHqyhqb69zqIMc0MqjD4dHLlVxp6ocjuCRP4IcO39kR0epiqJ7ZTo8fM
	 mBlGvsDmeIJjQ==
Content-Type: multipart/mixed; boundary="===============0108356434971100759=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1930dcf1fee8f4ee2083797bebd2ffead5d0588d6f3d8137fa099da85a5a005c@mail.kernel.org>
In-Reply-To: <20260304143459.78059-6-pilgrimtao@gmail.com>
References: <20260304143459.78059-6-pilgrimtao@gmail.com>
Subject: Re: [PATCH v6 5/5] bpf/verifier: refactor kfunc checks to table-driven approach
From: bot+bpf-ci@kernel.org
To: pilgrimtao@gmail.com,martin.lau@linux.dev,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,chengkaitao@kylinos.cn,linux-kselftest@vger.kernel.org
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  4 Mar 2026 15:08:50 +0000 (UTC)

--===============0108356434971100759==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> static bool is_bpf_res_spin_lock_kfunc(u32 btf_id)
> {
>+	return btf_id_in_kfunc_table(btf_id, bpf_res_spin_lock_kfuncs,
>+				    ARRAY_SIZE(bpf_res_spin_lock_kfuncs));
>  }

The continuation line here has one fewer space than the other three call
sites (is_bpf_list_api_kfunc, is_bpf_rbtree_api_kfunc, and
check_kfunc_is_graph_node_api), so ARRAY_SIZE doesn't align to the
opening parenthesis of btf_id_in_kfunc_table(). Should this be aligned
to match the others?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22674350640
--===============0108356434971100759==--
