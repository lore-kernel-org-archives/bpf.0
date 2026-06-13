Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEB63385BE;
	Sat, 13 Jun 2026 13:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781356749; cv=none; b=QPgPn9XkXpRDwsPOdqXiOo4Yl6hSxZSB3KlNe6euNilqEOb3D6x23Q9XOKZBFmiqNLHtxxnPcdOLcd0eg0IrrBOW8vY5n4mtIpMQqar1OK1l2RI4DXAr+wJyCrwyTDzmv0OEZvnM4IbumFxgStoynNUrgNz1tPjEPMEo6/lXwH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781356749; c=relaxed/simple;
	bh=Je9mnpo2iJQK1ZavRpDv9+ntBJkhMsgtNSFGSh/Cagc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=KAGcuPUFn0aPEybuZFpOOGMe42V+YZ7SaKIoLD+Ys+rXq6ZLVqiYSwN0P1An9+Q/4uQz/mACZYoaZ+yl2TAvJzrpj4LgNZsz/0XobvDkyAV3jU+CQcpPsvoFWN5DzDAEzmmsue5Ms5hLcBSHZdcuIQE9F9hBOWKpX/FrGDK/WkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XCUYzeFh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XCUYzeFh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E3FF1F000E9;
	Sat, 13 Jun 2026 13:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781356747;
	bh=Pcv+tDLnl3RDVKfKClvYLK4JyN6vPpKaR2OvJizXI7U=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=XCUYzeFhC19/G1cc+WMia0px/YQkDhHE6Adw17/UfGPnwanbX3BZ5+PBjbFtd0dcG
	 sZW8rVWK1bKMVjlJanHOAw7uBwVJjWVMHzpxODOsHRvZSsp3SFuinclkEGVlCxa22+
	 PjJrOspmMRu0HbT4/nJrlpTh5pSROilRGWQqvx1wXd+cl5Ih9bHC/xCMdm4B9/M3j/
	 NZew33EhuTKmbooXHH2ZPSEvz9RHOprueKNxzVtKr9yDpozTqi8yyU8HCaalcSIVTg
	 Km0Q/fz4x77Yh62fr3WleeK6JlWsNDm0guKT65TalNpnwRdBd1fNp7jUREaKFWTVeA
	 gxvqFOz0fqL7Q==
Content-Type: multipart/mixed; boundary="===============3119736226609335315=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <761cbcacba01d6be7fc7d0d606a08b979787cbb531d0002fe9a7e656e4ba5de8@mail.kernel.org>
In-Reply-To: <20260613-f01-03-scalar-add-bpf-next-v2-v2-2-ce07bec3f72b@mails.tsinghua.edu.cn>
References: <20260613-f01-03-scalar-add-bpf-next-v2-v2-2-ce07bec3f72b@mails.tsinghua.edu.cn>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Cover scalar add from rdonly untrusted memory
From: bot+bpf-ci@kernel.org
To: gnq25@mails.tsinghua.edu.cn,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: eddyz87@gmail.com,memxor@gmail.com,john.fastabend@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,shuah@kernel.org,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,gnq25@mails.tsinghua.edu.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 13 Jun 2026 13:19:07 +0000 (UTC)

--===============3119736226609335315==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Cover scalar add from rdonly untrusted memory
>
> Add a verifier test for scalar += rdonly_untrusted_mem. The program gets a
> read-only untrusted memory value from bpf_rdonly_cast(..., 0), adds it to a
> scalar destination, and then applies a bitwise operation to the result.
>
> The addition itself is allowed, but the result must be tracked as a
> pointer. The verifier should reject the following bitwise operation instead
> of preserving stale scalar state.
>
> Add coverage for scalar -= pointer and scalar ^= pointer as well. This
> prevents the early return from bypassing normal pointer ALU rejection.
>
> Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>

This selftest covers the early return in adjust_ptr_min_max_vals() that left
stale scalar state on the destination for scalar += rdonly_untrusted_mem,
which could let a later pointer ALU operation be accepted. That early return
came in with f2362a57aeff, and the companion functional fix carries a
Fixes: tag, but this selftest commit does not.

Should this include:

  Fixes: f2362a57aeff ("bpf: allow void* cast using bpf_rdonly_cast()")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27467222513
--===============3119736226609335315==--
