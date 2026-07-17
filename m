Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD9D239567;
	Fri, 17 Jul 2026 16:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784306171; cv=none; b=eAD2YNfOrbnDBH7Aayq/CLR+h6PNeyHNCUojgopOcPXpPgBVH5I30zmqdrmgGGnbTxiHIRFL0c8ZZO6v6/mjbI7LWRuzOv8qRE1pw7mCHeyiKexJjVW0VcWM40Q42kUInxyf0y3ZGAhbgjBRDe8cuHt6hrVG5Ulb6Gzl3p1OtL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784306171; c=relaxed/simple;
	bh=T70zMpX8M2e8+A7Q7tZSc1bpiLVh4OslRZmCJt6Q4PM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=NE3QIhiZlTgcFptGtwzXX/A7Tv3v1o5hQMRliBFjsw83K3ZHLUnt0r0NShX+7ycIsvhWIbWitaSnjG1gN9rt+o+qxnnJpqaxKQRmB+1zwFfgVEH1k0lzaZg56SUh/b2xibL3Xku43TPyr9tPx1iGWt29ekHnND7niWAjcS4F0hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iTyFZbi0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iTyFZbi0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 315F21F000E9;
	Fri, 17 Jul 2026 16:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784306170;
	bh=O4B6jZ4W/bx6pLH7AJm1oqr5Gc+g8NBqjrF0NWq/y7A=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=iTyFZbi0mUq+4L9adUnRAl31YBNdDwy+MGnqi2mDFa/m1XXVnxYk4bpB5IE/wJe/V
	 ZXlJFT//kW7vjKlOWhFQiRxjhqZOyEFyGxz5/SrILueSBAXw/al42REjD+Igo4qcNW
	 oomkyAHiLTb1lOJYt28rhPTtuS8nCpchy3Z4cl6aKdT9IGZVHVAVsm4FxkG+1y5310
	 aK7OTSuDkBA0zYEpnu8n07xsfgM/lKw/z1KmWyezsK/ojL0m54OEGC8L5aTqL17yY9
	 n5HfYqcDGc7Nqc+WHOvQTGFEhX7EYBj5t7t5IKO4ZcMUBUFGvn8zm1T3zAzE6WDW28
	 82f8B9iXVItsw==
Content-Type: multipart/mixed; boundary="===============3244169673647060575=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1cf7c388a122f5a4cc06b254460a0b1c708eef14991dd69d88ec2da4114646dc@mail.kernel.org>
In-Reply-To: <20260717155348.54975-3-nnamdio@gmail.com>
References: <20260717155348.54975-3-nnamdio@gmail.com>
Subject: Re: [PATCH v5 2/2] selftest/bpf: added selftest sockmap_basic/sockmap recvfrom eagain
From: bot+bpf-ci@kernel.org
To: nnamdio@gmail.com,nnamdio@gmail.com
Cc: bpf@vger.kernel.org,davem@davemloft.net,edumazet@google.com,horms@kernel.org,jakub@cloudflare.com,jiayuan.chen@linux.dev,john.fastabend@gmail.com,kuba@kernel.org,kuniyu@google.com,ncardwell@google.com,netdev@vger.kernel.org,pabeni@redhat.com,sashiko-reviews@lists.linux.dev,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 17 Jul 2026 16:36:10 +0000 (UTC)

--===============3244169673647060575==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftest/bpf: added selftest sockmap_basic/sockmap recvfrom eagain
>
> These selftests exercise the tcp_bpf_recvmsg() and tcp_bpf_recvmsg_parser()
> functions, to ensure that they are properly handling spurious wakeups in
> tcp_msg_wait_data().
>
> The expected behaviour is that recvfrom() does not return an EAGAIN
> error.  If the spurious wakeups are incorrectly handled, this assertion
> will fail.
>
> Signed-off-by: Nnamdi Onyeyiri <nnamdio@gmail.com>

this isn't a bug, but could the subject use the imperative mood, for
example "selftests/bpf: add sockmap recvfrom EAGAIN selftest", to match
the changelog convention and the sibling commit in the series?  The
current "added selftest sockmap_basic/sockmap recvfrom eagain" also
repeats "selftest".


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/29595053560
--===============3244169673647060575==--
