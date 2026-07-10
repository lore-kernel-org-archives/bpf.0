Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6344361DD2
	for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 04:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783658630; cv=none; b=ZeHMypR9cs3xkGD3wvlTzqQYNCY9uFhBzi2HozBhHJCaicnfr49mtcsboOEswb/vP3gt+UVuEbmsUHzkVd+w3t2ni+V7UmbW0H51bWdWhF61hSWjwmPq+NdYVUWdF212bjjUUmmoY7ywYmCqwSQSTgeVVnQyP5V6uRlT6hhvi9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783658630; c=relaxed/simple;
	bh=+8xG5YsOVk2I8w8C+nRPKbEpaNbDCsWOUqGxUi/E2YI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=r3PPKTyN9LqF/4CV+5cddxLdFzRAHVX+DpQJjvLeaMRHgXPRXf/R3fV/xab8RAjjtVIc4edK+L+g3MfeV3fIuB+Gd2qIdhgIDI3BgwpJUXPZ8+8ynUN8uOME5KjoYxB6PQ2W5Exa5QoRPUGBqqMj16E1wpybuQQcX6mj+PujkPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=To2nXWhx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="To2nXWhx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D4F51F000E9;
	Fri, 10 Jul 2026 04:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783658629;
	bh=fAavIS64dU/GH5nnda53PfAobASLqlzoZGICE7Y9H7A=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=To2nXWhxjOloLePwkyRgXmu1lcojIM8ErVOlSFGYgtruSYgfQWhU6JiqtDyH18EmT
	 g1BEaGR6Js1WrL5YQVPNpdJivdOQKMcL69HZL8l2JzO+Ydw/Z63lgWWtBeLCuXOWHU
	 ahjAAWpEVeaxStZdrRSzE8WDpkRREQE/c433s893J0HkBKCkE77PQSQwDteLZcG5C2
	 puLSNoPlDNc/E1VEme5lGJdeZpLjIbcIRCmH0vvpv/tPa2E+RcMcGeudfkQYEmk3ft
	 pgFdSDq1YQvWdZ8wdSSGIBaENDe3ZOjPxMKb59mvrm1IlM3z/C+9wck0oHKt6SLdse
	 wdyHksjCeCmUw==
Content-Type: multipart/mixed; boundary="===============7725993388947368145=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8e34f732e9d144675a636a07bbadb138afc3089bdbbaf155695736e890ab9fac@mail.kernel.org>
In-Reply-To: <tencent_39A7924F2A472D74FA6AD444744E57027905@qq.com>
References: <tencent_39A7924F2A472D74FA6AD444744E57027905@qq.com>
Subject: Re: [PATCH] bpf: return -EINVAL from bpf_ringbuf_query for unknown flags
From: bot+bpf-ci@kernel.org
To: shijianlin11@foxmail.com,bpf@vger.kernel.org
Cc: andrii@kernel.org,ast@kernel.org,daniel@iogearbox.net,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 10 Jul 2026 04:43:49 +0000 (UTC)

--===============7725993388947368145==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

>     bpf: return -EINVAL from bpf_ringbuf_query for unknown flags
>
>     bpf_ringbuf_query() returns 0 for unrecognized flags, which is
>     indistinguishable from a successful BPF_RB_AVAIL_DATA query on an empty
>     ring buffer. Return -EINVAL instead so invalid flags are reported
>     explicitly.
>
>     Update the helper documentation accordingly and document
>     BPF_RB_OVERWRITE_POS, which was missing from the description list.
>
>     Signed-off-by: Jianlin Shi <shijianlin11@foxmail.com>

This changes the behavior of an existing helper for unrecognized flags,
which was introduced when bpf_ringbuf_query() was first added.  Should
this include:

  Fixes: 457f44363a88 ("bpf: Implement BPF ring buffer and verifier support for it")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/29068374717
--===============7725993388947368145==--
