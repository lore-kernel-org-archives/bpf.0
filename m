Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC5F3E8C67;
	Tue, 21 Jul 2026 10:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784630676; cv=none; b=FnLnhFETkXHnJzcCjFCWzj+rwH1WcaE2T8wueIuR0JK5+GgO9rqRD5k5Ai5fXd1DhVxahjYFBsCTRFEIf0y/wf7kL7ozzXKEVv/u22LlvXOWH11m2ah76T7xpeCiNwOgkIRkqv+xQ2flSr1iPm1YkAxaWuWOpLS67h9JpdZha8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784630676; c=relaxed/simple;
	bh=Ub02ok4hL2fqdBzgS/EOuWI1NzjfOJdXJ9wHFiTHaa8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=LHYo+AAYsxesDKbWlq8NmfU7Axl+0AmoqweQ81JjG+lRMj3hWgx5yF/MyA3mt+JCdeWneAsQ/67eV4Yxqn+idB9kR5kIFYEc2Bwz5StJQZLuiMPBrUe7ZII1eOJ7d9d6Wpw+n2ye1NR1EF6VFseOKtb/ULqLAWTGLkKncNjukd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IZd5w2u5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IZd5w2u5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ACB71F00ACA;
	Tue, 21 Jul 2026 10:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784630660;
	bh=HQVIS2zcQCaPjEY67so9w2eHh9PsZkvg0BMGD3K7TF0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=IZd5w2u5htsHL7kMoyTZ9+5rBovHBK8B54A13j94nJWS7xrLhpStrh96VrjNfwDP5
	 7/fJDXksNu82aq1rPs+y8G3/rHNvrHgnrMsCa8j4qauI0FxWgi+we+RPA33AxjB2Ti
	 RJqbXy0lbZ44QeyeBd+5VMBuLUTSTYffceGWDUJRGzI0OzCTEB5ZTHVkFjkBq4ls+D
	 ObC4GRMLfalIIynS3y+SGCkV55ukDJLjbU2Myh6G4fMjjcT9lcmovC7C2rJXK/gN/9
	 Vn5hX0Bi46uYal6EnADz5OSbA99qUndBJuZ2w08V/0ANxkQa879QFmX8j5pTYDZ8h1
	 6ZCtG0Jsd1WXA==
Content-Type: multipart/mixed; boundary="===============1319004730584785082=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c443b4302eb6437ab8c66b9223595faf2d3a5a8923f2881e679fac7609509099@mail.kernel.org>
In-Reply-To: <20260721094404.593127-1-yangfeng59949@163.com>
References: <20260721094404.593127-1-yangfeng59949@163.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix double free of name
From: bot+bpf-ci@kernel.org
To: yangfeng59949@163.com,andrii@kernel.org,eddyz87@gmail.com,ast@kernel.org,daniel@iogearbox.net,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com
Cc: bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 21 Jul 2026 10:44:20 +0000 (UTC)

--===============1319004730584785082==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Fix double free of name
>
> The name has already been freed in the free_subtest_state function
> and does not need to be freed again.
>
> Signed-off-by: Feng Yang <yangfeng@kylinos.cn>

The redundant free() looks like it was introduced together with
free_subtest_state() in the same commit. Should this include a Fixes: tag?

  Fixes: 0925225956bb ("bpf/selftests: Add granular subtest output for prog_test")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/29821735776
--===============1319004730584785082==--
