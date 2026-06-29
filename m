Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBD134FF41
	for <bpf@vger.kernel.org>; Mon, 29 Jun 2026 17:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782755306; cv=none; b=h8YBMyLtI5JjeQ45EEMSfMaR53TnhJC5J6rDfdpUZlmerTlZMljU9jc6LMzI34zvWdpG+hv8Zia4lIow9bD8gaPl5cw8jvmoJJ/jkXMpWDK6sLeq0/uPDSLgHoTX71woNimJ/OgPvE4dWfR4oPaGSBCdIe0RMorOll5GKtb9Bck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782755306; c=relaxed/simple;
	bh=F5fr/wPd9SBUxFrkLybZT/stKUqM4fjgVXlBJV09YAI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SjGRBi6SGubhQofCDtXoX40PsSNc8uhCqxjkUDv1bO4ERXNu3YhMubv7ZJpZxzSBv3plaZGUCoZtFxmGPtNmdNMGHeejQDDGMgX2WBjTLxwyASmGyunVePvh6RvJXh4uT8l8IUllj6AGL7cAACYjSPTSTSZ4rDhU+XAeXHCmcQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i0PA3E9N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i0PA3E9N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95C2D1F00A3A;
	Mon, 29 Jun 2026 17:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782755305;
	bh=F5fr/wPd9SBUxFrkLybZT/stKUqM4fjgVXlBJV09YAI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i0PA3E9NKZ0+rN9Rv45yPg37a8KyvSUY1e7jnh2lwMKdMMRgelCJAO7tff5Di6GH8
	 bwipbXLgFPnIy7UwcCF2AByEJxEcPAmcWc5JXDv86tlgi2U94KUMAhGY5GIK9TyExJ
	 rGVHNGDckPT+bidI9FiWy3e5rHnhGkoPSUgfoMnOhklNvHcqp1fwGt8G+Dkj52VIKZ
	 gILHuJGYj9iWGu/4NVOn4RslaPqberk8AwfHh72lpxrR2aU6fh/fpTtDgF7Ranf4nb
	 +DhbxF5No+5nKBYhaC2Aw6kTB7VCdIfb/VM+w3EDRXIiQu2s/bYvq8AwN45D2EO3jo
	 XLVilhPZCqVtA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: drop
 tc/xdp/flow_dissector sockmap mutation tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sechang Lim" <rhkrqnwk98@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260629172704.1302218-3-rhkrqnwk98@gmail.com>
References: <20260629172704.1302218-1-rhkrqnwk98@gmail.com>
 <20260629172704.1302218-3-rhkrqnwk98@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 17:48:25 +0000
Message-Id: <20260629174825.95C2D1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The commit deletes the selftest file test_sockmap_update.c but leav=
es broken references to it in the sockmap documentation.
--

commit ccad6ec599cc55c0fbdeda989132b9073df009d1
Author: Sechang Lim <rhkrqnwk98@gmail.com>

selftests/bpf: drop tc/xdp/flow_dissector sockmap mutation tests

tc, xdp and flow_dissector programs can no longer update or delete a
sockmap. Adjust the tests and remove the now-unused test_sockmap_update.c
and freplace_cls_redirect.c files.

> diff --git a/tools/testing/selftests/bpf/progs/test_sockmap_update.c b/to=
ols/testing/selftests/bpf/progs/test_sockmap_update.c
> deleted file mode 100644
> index 6d64ea536e3d8..0000000000000
> --- a/tools/testing/selftests/bpf/progs/test_sockmap_update.c
> +++ /dev/null

[Severity: Low]
Does this commit also need to update Documentation/bpf/map_sockmap.rst?

Since test_sockmap_update.c is being removed here, the literal references
and hyperlinks to it in Documentation/bpf/map_sockmap.rst (around lines
352 and 498) are left as broken links.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629172704.1302=
218-1-rhkrqnwk98@gmail.com?part=3D2
