Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2033E3C5F;
	Fri, 25 Sep 2026 10:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790333256; cv=none; b=HlO5ZIp63/fszoSH4dJtL6/DU1gntt8VPVcu9CXGoG6zVEKarhYrR8zThCxp2cRNbtN2YQWeS86ypoxDLLzpYOeEcaqBdAwpFfyhOuz/IWQTtbO5uFBTvOnV4l3cAP8MW5JE0R4Nl4WVy680kXUzjhpgFvwNI6JPIN3s95ESWYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790333256; c=relaxed/simple;
	bh=cLHAP6yJhY2EOh7ehnbK1o1QNzhB1ysd2VGtpne7bVU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=sJt+19sbv7oGosiGMNg2zpFLBZGGiOYjCgorV8cJPO0VPSScW6JrrkhrdRL1jSOznrTLISjAj2+9EuqWeobg6hWQadXPNlYuNIkb33tZtUCvRNelek70oCQT2kafyZ733eSMDaiOtE0GZxyjT3VRKz3R+s/SYonr2qZQIy84Q40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bad0H7Rr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bad0H7Rr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ED3A1F000FF;
	Fri, 25 Sep 2026 10:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790333252;
	bh=v2O03mlPJLw4y4PdkmnDseY6QjSajiXNiqwpLD61djs=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=bad0H7Rro9Xizui50SE6nCRCX5y6eadiEpIjhJMPqmBwI6/LYCmV1zaYEnQQh3QnQ
	 Sv+vhmFV0EILyPKclJKK2qUtzPm3muQstpKsKWLeDkM0wyafByDxmzQG/w8GxN7Jkc
	 DdRMXfRB9E/lO8ZUvPyaZd2ZPqVfZknR7Zsy0ktcCoJkTBnjA4VW+aQvf0NyKtRK0P
	 Pd5cNUDSupzplD4BgSxynZKkGR4yHTHszdIJBwqAiLVtQMUVYmbCqoiUJX9IvvvSlV
	 I8ehwOEH6CpUQ2PtHjK7cdEogCxPDCc/tB70BEkSfHfVtLfqPO4fTxJ+toePEMecnb
	 7axjEngICHL2Q==
Content-Type: multipart/mixed; boundary="===============8477605915641817552=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <22e95dbf944bdf6b657249657e884617f79972a92430f17abd47c472797ec4ff@mail.kernel.org>
In-Reply-To: <20260925100342.481242-2-florent.revest@linux.dev>
References: <20260925100342.481242-2-florent.revest@linux.dev>
Subject: Re: [PATCH bpf v4 1/3] bpf: Wait for an RCU tasks grace period before freeing trampoline progs
From: bot+bpf-ci@kernel.org
To: florent.revest@linux.dev,bpf@vger.kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: florent.revest@linux.dev,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,kpsingh@kernel.org,john.fastabend@gmail.com,leon.hwang@linux.dev,zirajs7@gmail.com,rhkrqnwk98@gmail.com,puranjay@kernel.org,xukuohai@huaweicloud.com,iii@linux.ibm.com,hbathini@linux.ibm.com,chleroy@kernel.org,naveen@kernel.org,bjorn@kernel.org,pulehui@huawei.com,yangtiezhu@loongson.cn,hengqi.chen@gmail.com,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 25 Sep 2026 10:47:28 +0000 (UTC)

--===============8477605915641817552==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 1d2676782d70..d4f732996b47 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1770,6 +1770,7 @@ struct bpf_prog_aux {
>  	bool offload_requested; /* Program is bound and offloaded to the netdev. */
>  	bool attach_btf_trace; /* true if attaching to BTF-enabled raw tp */
>  	bool attach_tracing_prog; /* true if tracing another tracing program */
> +	bool tramp_linked; /* true if it was ever called from a trampoline */
>  	bool func_proto_unreliable;

Does this comment accurately describe when the flag is set?

Looking at bpf_trampoline_add_prog() in kernel/bpf/trampoline.c, the
flag is set at link time, right after hlist_add_head():

	hlist_add_head(&node->tramp_hlist, prog_list);
	node->link->prog->aux->tramp_linked = true;

This happens before bpf_trampoline_update() has generated an image that
could call the prog. If bpf_trampoline_update() then fails,
__bpf_trampoline_link_prog() calls bpf_trampoline_remove_prog() and the
flag stays true even though no trampoline ever called the prog.

Setting the flag conservatively is correct for the free path, since it
only adds an RCU Tasks grace period. But the comment describes a
different condition than the one the code tracks. The field name and the
commit message both say "linked to a trampoline".

Would something like /* true if it was ever linked to a trampoline */
match the code better, and stop a later reader from assuming the flag is
only set once a trampoline image has actually run the prog?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36122863248
--===============8477605915641817552==--
