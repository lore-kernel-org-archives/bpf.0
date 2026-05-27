Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4203644C3
	for <bpf@vger.kernel.org>; Wed, 27 May 2026 14:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779892480; cv=none; b=IdaJomhgjRvavhvm16SEwouvOhmxG8EsNpt+r6HW4tzit+nlxZrhgMZzhIO562P+ga43n2FrwWdnkLjUeqLbAQo+y7DGsBG7lCz20mo0Id4ynfOBuI7EUoICynKao6kYA4uVjOgMYiQlnUN4D5kAymWzWLUKgou8gi/rUEmn6QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779892480; c=relaxed/simple;
	bh=DzU6Z6CX/Wd9J+plkLRKW2hpcGZqI6GLcYTu8IEtcEc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JPheSJSzQAEBGNwCico/jZ9qfqmJHxxbrzijp2jU5F+W1IKe90+P8zWsncvbmRD2asArwOTb3ZvexQeJEzMqVNWrF0/CrnKvzXei4T1Moygjb+LQFB7p1gElr48VaJWcPR8YGENBakgzaFoltH1q+u9RphTpwGtojRllK/EKC4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cdQq46Pu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cdQq46Pu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB7B71F000E9;
	Wed, 27 May 2026 14:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779892478;
	bh=DzU6Z6CX/Wd9J+plkLRKW2hpcGZqI6GLcYTu8IEtcEc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cdQq46PuyzPEWTjLPHplt+T8dKzSJVSZbr6rwltWFBYujWJTtgs7GmiNO+uvfGq8h
	 28J77NyTV5yo/ax0BfOnm+81sFbSBdcrOsR8BbdL299w7uaFQVVxDNvAyw0veMwzkv
	 z7G3DfJZk86oz/U0ZMjPSTXeo9ZGlshF6VHIzUogqHpBzOrW6QDqSLeCei+gF9tfhH
	 FGknAEvTVz3bRDytPcfUqFenvgW7F70XEYK9C6GbRp6iYh9cBT0uy5Kt0MdjMAIsSF
	 Pfm3xvr6xPJCSwDuzxyENpvSt6V+1UVPdbT12WUMExm3qkWPPZkGLbHJhr/FFBksFD
	 ACQZyDkbB8GdQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv6 bpf-next 13/29] bpf: Add support for tracing multi
 link
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260527113951.46265-14-jolsa@kernel.org>
References: <20260527113951.46265-14-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 May 2026 14:34:37 +0000
Message-Id: <20260527143437.EB7B71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] check_dup_ids() uses kmemdup() to duplicate an array that can be u=
p to 4MB in size, risking allocation failures and kernel log spam, and then=
 sorts it without yielding, which can trigger soft lockups.
- [Low] The patch relies on undefined symbols and incomplete struct types (=
`is_tracing_multi`, `struct bpf_tracing_multi_link`, `bpf_trampoline_multi_=
attach`, `bpf_trampoline_multi_detach`), which will cause compilation failu=
res.
--

Note: The format of this review has been altered to provide a free-form sum=
mary of the findings due to recitation restrictions. The original patch cod=
e is not quoted.

commit 5f2896efaf9a14c18ba8b610461b77f1dfabba8d
Author: Jiri Olsa <jolsa@kernel.org>
bpf: Add support for tracing multi link

This commit adds a new link type, bpf_tracing_multi_link, to allow
attaching a BPF program to multiple function BTF IDs. It introduces
new fields in bpf_attr::link_create for passing the BTF IDs array
and its count.

[Severity: High]
In the newly added check_dup_ids() function, the code uses kmemdup()
with GFP_KERNEL to duplicate the IDs array. Since cnt can be up to
MAX_TRACING_MULTI_CNT (which is 1,048,576), this can result in an
order-10 contiguous kmalloc allocation of up to 4MB. Could this cause
spurious -ENOMEM errors and spam the kernel log with allocation
warnings on fragmented systems? It appears the caller correctly used
kvmalloc_objs() for the original array.

Additionally, check_dup_ids() calls sort() on this potentially large
array. Sorting over 1 million elements without yielding (such as using
cond_resched()) might hog the CPU. Can this trigger RCU stalls or soft
lockup watchdogs?

[Severity: Low]
There appear to be undefined symbols and incomplete struct types used
in this patch, such as is_tracing_multi(), struct bpf_tracing_multi_link,
bpf_trampoline_multi_attach(), and bpf_trampoline_multi_detach(). For
example, the nodes_cnt field is accessed on what seems to be an
incomplete type. While the commit message mentions that some functions
were previously added, are they missing from this specific patch, which
might cause compilation failures?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260527113951.4626=
5-14-jolsa@kernel.org?part=3D1
