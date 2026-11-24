Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795563608;
	b=tqlcUTQhrcC88MNrkkxMt9rtrGqawgYNGftAUGTEyPlALh1HJpf5Lt32ka9Lrw9v0ekV
	 +hO8K80HJBil6hKFC3sC47zA9UJUiHMQLNNJcdovBOuoeHIoSz8DHZp8j06KZqD7bBW+i
	 08KEZVUo5NDHRW3o3+X9DlD5wf2GRjNlu1aTBHoafizj7o9azpDLegu2lLbFwMiVw8Jy8
	 v8je2KMUi4Zb2maCxFGNXH/80RK2VO4+zXTRo5CANH7wMImFc+E67Ooe2GT34oBME9daX
	 S8ULTi7PnLlbKBwyIMTmkJo0io8QFaqeC0DMiiIA7ol352MSRXPvEtD4nuX5cAYahLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795563608;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=SBWGJoxFCMNSBlxsMBbOQgyv2JUO/syC04KpwABsKAI=;
	b=KfLyLti84VwUQ9HLLIYnsR0RDWJmXgUYWLgt1C0dk3ShQlbOLE4CSlSBLCTLkDUg5rdB
	 GjU3WnxoB6cSGw6lM4k7Fbc2nLhFNb8/9SFtpxcqpPcjZl6ii4Ab05lBuTnssVdmYB8Qf
	 TIMv18irHwtws3wYreTI1muL58YwE7GaeKRoIGNBh+YQ7CeU1cFJUJwYrcjE7LpGNv/nG
	 7dm6VN6fIHbtFiSc6J4/O4NVlFflZ7i5qdDaeOP4ZKr4/8URuXAyxsYmaoWZlvqCvdOgI
	 4a16TBl6ojbUU/3siPQCBSiirX3iA+ZgZ+OCTAItmup+6ph4slUuHEQDC53SY63kJ1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Sn/iDziB";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB39606A326;
	Tue, 24 Nov 2026 23:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sn/iDziB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F93A1F000CF;
	Tue, 24 Nov 2026 23:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795563607;
	bh=SBWGJoxFCMNSBlxsMBbOQgyv2JUO/syC04KpwABsKAI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Sn/iDziBI7DrgqRHkBmAvzT09txqQ63OcjZ4o3XvJHdyfFdBjkjWDLOepckrGz+N6
	 DMO1ihNv0bRNuT4WFu4S1vTnrg/YV3vyocBzHXI954WwQhp+qXAUSQRiACHzpg/7z6
	 yZTlDzv7+mFupPJ2/A4pIdRtDf9K9nPMwKpV4ND04IHZDy10YcvEq8Jx9bILMp9Gwn
	 Lkf+308jFrwSvtjk9j6am+lTGXDRyhnAZhg+o/zEHfbNOLpkuc3O28AeQIt7J6qGFN
	 sL1IKDWcJirSF9tlKocaPfsK6KiKpsCAH3J8FnGNmQzwzbWPO80J2DBBqE2RHrIDeF
	 ICfnmJ1oHQbwA==
Content-Type: multipart/mixed; boundary="===============1807004455747823556=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <8622ee5bbbfeb7c2e4f3692775dcdf3fcf9752de636cc89b4140f2053c89aeaa@mail.kernel.org>
In-Reply-To: <20261124224811.16134-2-ihor.solodrai@linux.dev>
References: <20261124224811.16134-2-ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v3 1/6] libbpf: Separate interfaces shared with in-tree tools
From: bot+bpf-ci@kernel.org
To: ihor.solodrai@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com
Cc: alan.maguire@oracle.com,emil@etsalapatis.com,jolsa@kernel.org,song@kernel.org,tj@kernel.org,yonghong.song@linux.dev,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,sched-ext@lists.linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 24 Nov 2026 23:40:05 +0000 (UTC)

--===============1807004455747823556==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> libbpf: Separate interfaces shared with in-tree tools

TL;DR: Design question: Andrii Nakryiko objected earlier to the new
libbpf_tools.h header and preferred guarding the u32 poison pragmas in
libbpf_internal.h; this version doesn't address that.

> diff --git a/tools/lib/bpf/libbpf_tools.h b/tools/lib/bpf/libbpf_tools.h
> new file mode 100644
> index 000000000000..5c8d6d0d2fdd
> --- /dev/null
> +++ b/tools/lib/bpf/libbpf_tools.h
> @@ -0,0 +1,184 @@
> +/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
> +#ifndef __LIBBPF_TOOLS_H
> +#define __LIBBPF_TOOLS_H

Andrii Nakryiko objected to introducing libbpf_tools.h in the v2 and v3
discussions.  He prefers keeping these declarations in libbpf_internal.h
and guarding the u32 poison pragmas with an #ifdef that resolve_btfids can
disable:

  I don't like libbpf_tools.h approach, if GCC poison is a problem I'd
  rather guard that.

The poisoning is the root cause in the commit message, and this version
still adds the new header without a respin addressing that.

Should the poison pragmas in libbpf_internal.h be guarded instead of
splitting out libbpf_tools.h?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/45506767613
--===============1807004455747823556==--
