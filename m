Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD3E44CF37;
	Mon, 29 Jun 2026 16:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782749983; cv=none; b=ogvkJVC8FUQQXQT1prE2hyyBRxZ1QDTWCsaaWmhTswu3EnFE06uOd2ldTeZ8zW5bbish17MJEgGzcmbM8+vd1nt+GHwtqnqSp4fpqKB6Px94ZDRa9ICWt+O95Uzw5l8EKnhFNlm1H04t+97y+acLF3POnJ8zlRx2inzsLVSrc8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782749983; c=relaxed/simple;
	bh=23SRZQSyzGaaP+jU739gtUdoPMTFI2PuisT9R6qCj9E=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=lIuZhVXL8RYz9GMnCup/wdWDESFG9sVM5u2Ufb8clcgj45ZaU3zb2DtLVLtjJkbinerFJl7CXW8L47/BYNYjS/XLiNABJViSaIUI7wqnUvr644BNSyuWJIVh2hPSlPaGSWKoT9VCASSmzsN8C5/hfls71Zbpoo5wwAvqYXyr+GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F8jy1lAf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F8jy1lAf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DD351F000E9;
	Mon, 29 Jun 2026 16:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782749979;
	bh=23SRZQSyzGaaP+jU739gtUdoPMTFI2PuisT9R6qCj9E=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=F8jy1lAfym3ef5KbIR9DNOcUPkf2MdXovDFPnL6a8oEZeOvaDUQZVVChSNceSAbF/
	 IcwuYoO58i6KH1ftoJbZ6x6seswykmKOQTke7t+4TsaQ5anLxmwZ/9Lu4wsNXRDtrb
	 CIU3KszsDgZjs98iLN1ErM2TpRqa6WpiNOD2CQK/2HXbmPYi/VQjZI0lFbeZ4p4XoW
	 qqVjFknufP/64Og5rSxfYVYWFotTL/vmjn0EYd3iv6poRQfMPZ//fBJ2kTq0JqPOUx
	 imzV9Z2zDAZKr5+uCZLlUws+gNLWfsuBnvWUNKQoAyFuXsLUDgEnFJ/AXjE0hLjy2q
	 GwxFuf0yW0sZQ==
Content-Type: multipart/mixed; boundary="===============8484001317295672631=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0c8408eb97828eb59c171d971793a92654f8018ada812d6ac1703330ec4059fb@mail.kernel.org>
In-Reply-To: <20260629140048.733346-7-pulehui@huaweicloud.com>
References: <20260629140048.733346-7-pulehui@huaweicloud.com>
Subject: Re: [PATCH bpf-next v4 6/6] selftests/bpf: Remove tailcalls tests from DENYLIST.riscv64
From: bot+bpf-ci@kernel.org
To: pulehui@huaweicloud.com,bpf@vger.kernel.org,linux-riscv@lists.infradead.org,linux-kernel@vger.kernel.org
Cc: bjorn@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,puranjay@kernel.org,pjw@kernel.org,palmer@dabbelt.com,alex@ghiti.fr,pulehui@huawei.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 29 Jun 2026 16:19:39 +0000 (UTC)

--===============8484001317295672631==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Remove tailcalls tests from DENYLIST.riscv64
>
> Remove tailcalls tests from DENYLIST.riscv64.
>
> Signed-off-by: Pu Lehui <pulehui@huawei.com>

This isn't a bug, but the changelog restates the subject and the diff
without saying why the entry can be dropped now.

The deny-list line being removed documented that the JIT could not mix
bpf2bpf and tailcalls, and the preceding commit "riscv, bpf: Mixing
bpf2bpf and tailcalls" adds that support.

Could the changelog note that the RV64 JIT now supports mixing bpf2bpf
and tailcalls, rather than restating the diff?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/28384109028
--===============8484001317295672631==--
