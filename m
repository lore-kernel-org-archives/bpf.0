Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B051DB13A
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 01:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783474265; cv=none; b=BfWtUOJ4AL5FSUTVQDUvVaiq8F2uBpgZj61WZV4bOv8moVBwpTeQG1ZuJ5ik26G9pF/sAGUKBYvpvfSp37fqD0+AQzoLmltgdZlebuHOGksZ/EwAavWllWjOSfdpSPyXalwfUIRm/c2J8Tx4H0E56r8Wlyo7RGIRgDIKwKMnFRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783474265; c=relaxed/simple;
	bh=DVhOvFcYxFkTA8XhIE4R3u4hgH3PDqGHISp9w3hwStQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=K+wEXaph8rwoUWG678SPiAoVs0JIsVs+1g/bGO4G98J+dP4ZJsHxQ5UP0W2WxaI+jkpxA57/JUsQABNj2QNWEbElvlUvxkNpqwht/i1t0XAkzdWeJ39jCpPFODBw9tsKt3maVaQO8VTSnVNoStNbXM4+8eBMFPZMaIEx/cACmv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eHd9/3uA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eHd9/3uA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC0471F000E9;
	Wed,  8 Jul 2026 01:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783474264;
	bh=DVhOvFcYxFkTA8XhIE4R3u4hgH3PDqGHISp9w3hwStQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=eHd9/3uAes480G4TeabgFYEams6+n0q5XdjTkB3xCeN5z7JWCeAEF3+h9/IyN8JW4
	 Xx10uYWL1vSq/LRD4t7V+snyH9gbjzZM2Lk8vY8v5j5xA7pd4N+ly2+KIqs2hStFoB
	 6HZGOSbkezo8DBJgMa68tScSW1/FGcHVBpNVO3R+cyHg95ycD+PkKtF/H+Iy/2EZ7C
	 aJZdjPQMrEPTbKURzOL9ngZLkwDe9603d4OzUKm/pa0WUYxUtzCfrivpSdaGi+9o2a
	 ltBlYXixURTChE5DDIgX6z1g/6WqITJnFBWcY6Dn+JylCqJYR/rCVGdH4RaxWgwtL3
	 Kc9pLD+k/8BEg==
Content-Type: multipart/mixed; boundary="===============1939841513163739299=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3516affcc37014f57354a8cdee8cc55c28f11654502a4547b68012c6284a7f19@mail.kernel.org>
In-Reply-To: <20260707-missing-spillable-types-v1-1-44a92121dc41@gmail.com>
References: <20260707-missing-spillable-types-v1-1-44a92121dc41@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: remove artificial limitations on pointer types eligable for spilling
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,memxor@gmail.com,andrii.nakryiko@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  8 Jul 2026 01:31:03 +0000 (UTC)

--===============1939841513163739299==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: remove artificial limitations on pointer types eligable for spilling

This isn't a bug, but could "eligable" be "eligible" here?

> There are no technical reasons for this limititation.

And could "limititation" be "limitation"?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/28909712027
--===============1939841513163739299==--
