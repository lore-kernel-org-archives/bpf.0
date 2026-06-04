Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F41938424D;
	Thu,  4 Jun 2026 04:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780545935; cv=none; b=jPazDFX1GqJCaaU6BF2mdMRw5yATdNyLdmMlPRHcLKDlAC1wqOn89atm/AKXH8AcKpKEgkP1ndypXJDwd1w3LE6KLxbOQxevgkxYFbW97C2ANbzXh+2MSW0XwDDVmvHYQ428t+n4UdgkVvxZhiknzxKRdXrDk2Kg+DbI+dm1tU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780545935; c=relaxed/simple;
	bh=6Yijwa5yKuuFRBGOjldJ4M49WmHIzxuTpudhkZ0/oBk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=IGXE+wD4ew+wuAcvtd3bxwFMSlKE1bDpTNBYi/hA3YIwcnCkTFVQ19pfY6BzdRYBlkl0KO7uDby8csesxB+Wdcw5NftA+oc1e0AS6xYoLy2K7SU673xq83760E6lEnOc8Cydb6qgBwWEmWbUkMaO8PUZGoAP+UFn1EqB++smHrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R7lw6Sdy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R7lw6Sdy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C6381F00898;
	Thu,  4 Jun 2026 04:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780545934;
	bh=XdmI0vuoEVBiuxy20ijnOIO1osu/FTfLbOU0eECfMC0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=R7lw6SdyFokNja2InU1APrhYC1FSol/VI6C8ouEAbXnlq2bmmYL9LfsY6aIYgpNHl
	 pSspV7hef4MC+/c+2+NGnhe5xjMND0VL5XN4vPU4D+Fcjz8HO09LRNaP44KuJ7GHYI
	 o0Kp98+3wCkvdipDcvq/zcMB1BmYpw31bpSttgCi4DHCGg/undurXKsJf9AXak+kaW
	 333nlM9ua7/VQPMZzhAGPLwefG4ixPP6uiB2RHL2g1Vt7zVmscecEo6D78wNfaIAI+
	 PHS6K03mvuE03wvyBH+ORRDBdRrJ416lKJRxzGNiJDRVhr9wYY8kShoTdWiYmdLrGO
	 Z1itNdbH3WIwQ==
Content-Type: multipart/mixed; boundary="===============7243867582274651551=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <dd66dde10a66bede67554fd68d9c88e3f4c681339657bb79c8c3b4ff892b0e4a@mail.kernel.org>
In-Reply-To: <20260604031033.806727-2-chenyuan_fl@163.com>
References: <20260604031033.806727-2-chenyuan_fl@163.com>
Subject: Re: [PATCH bpf-next v2 1/3] libbpf: Skip bpf_object__probe_loading() when BPF token is in use
From: bot+bpf-ci@kernel.org
To: chenyuan_fl@163.com,chenyuan_fl@163.com
Cc: andrii@kernel.org,ast@kernel.org,bpf@vger.kernel.org,chenyuan@kylinos.cn,daniel@iogearbox.net,eddyz87@gmail.com,linux-kselftest@vger.kernel.org,shuah@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu,  4 Jun 2026 04:05:34 +0000 (UTC)

--===============7243867582274651551==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> libbpf: Skip bpf_object__probe_loading() when BPF token is in use
>
>     bpf_object__probe_loading() tries to load trivial SOCKET_FILTER and
>     TRACEPOINT programs to verify the BPF environment works.  When a
>     BPF token is in use with restricted program type permissions, these
>     probe loads may fail because the token does not allow the specific
>     program types, even though BPF loading is perfectly functional.
>
>     Fix by skipping the probe when a token FD is present: BPF token
>     creation itself proves the kernel has a working BPF subsystem.
>     Real BPF issues will be caught during actual program and map loading.
>
>     Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>

This looks like a fix for a regression that was introduced when the BPF
token was first wired into the probe loads, which switched the trivial
SOCKET_FILTER/TRACEPOINT bpf_prog_load() probe calls from passing NULL to
passing &opts with .token_fd = obj->token_fd, making the probes subject to
the token's restricted program-type permissions.

Should this include:

  Fixes: 1d0dd6ea2e38 ("libbpf: wire up BPF token support at BPF object level")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26928747574
--===============7243867582274651551==--
