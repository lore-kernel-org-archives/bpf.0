Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9E135AC1B
	for <bpf@vger.kernel.org>; Thu, 21 May 2026 22:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779403466; cv=none; b=asLo9fUujnYeh6Gp6weO4yKqzB3hi8kx6rpDLhoPFt355Zyq07HbEW3MJrkZBbv6m70yMt/463LUMqR0bFr6Z5j4RqgrzDTnW8GCsIXxRbwXFDQqmR87Fb3Y6tBOl2+gtX1sm3xkPivJxlHlG1ZwymhsJcg25kzLnlKFULJCjj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779403466; c=relaxed/simple;
	bh=WhT6RtrQwyJ4T6yzTPkt6k1pwlx4Q2w+Q+qcXmkvTcI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UWoMSbXpml1ScTZYelzSA2AA3TcZuuXnuTre08KZ9lLaChmMxJtpEN+CwX7zhfQJAXXI6w67c70ZXCU9unntHTUdrmcdhas3Yfl3SH0gUMYfhuarwuzubyHAd2CUo4UEBpFtfSpi6RxsgGg1HXKO6RdaaGsoiy9GSsk5StvZlOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C2OC90nw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C2OC90nw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1B411F000E9;
	Thu, 21 May 2026 22:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779403464;
	bh=WhT6RtrQwyJ4T6yzTPkt6k1pwlx4Q2w+Q+qcXmkvTcI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C2OC90nwNW8Y1fzUPZcn22BRNK3qx1PdEzF4KCvO7Sc0w93HyLUSUkmUXol57/52i
	 Yt7J0er8AmgAIpL/A9MaFbGL/nugy9mlnhnN5WlJMeCrcRNh8fjXVGld61XwcIBjcw
	 yc5LwVDZuchIreIM3H0WV0h/lX6HkZ3hjA3gvC6LWy6+A3K7jfKwKf7IKdGth3kjWx
	 uEdkXY8nru74PHOFb2phKv9BWMkiYmjs5QxDYfWE2BQ2vda9Sp9Kq07mbNA7r3ob59
	 1OubqGdAlSHeQ9qk2Kwd2gRf+913q6N1+1sy/f2Xir4JhSJWrcONCNPK8UiEhvW5Kr
	 rvLtzXmdfN9XQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] libbpf: bound /proc/<pid>/maps scansets in
 parse_vma_segs()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Bommarito" <michael.bommarito@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260521221712.3077276-1-michael.bommarito@gmail.com>
References: <20260521221712.3077276-1-michael.bommarito@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 22:44:24 +0000
Message-Id: <20260521224424.C1B411F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Unbounded `%s` format specifier in `sscanf` allows stack buffe=
r overflow and truncates paths with spaces.
--

Note: The format of this report is altered due to recitation restrictions.
I am providing a free-form summary of the findings without quoting the
original patch code.

commit 4f7490fd6defafa70e5f169165e4d30d7e6cabcd
Author: Michael Bommarito <michael.bommarito@gmail.com>
Subject: libbpf: bound /proc/<pid>/maps scansets in parse_vma_segs()

This commit addresses a stack buffer overflow in parse_vma_segs() by adding
bounds to the fscanf calls used to parse /proc/<pid>/maps. It ensures that
deeply nested directory trees do not overflow the path and mode buffers.

[Severity: Critical]
This is a pre-existing issue, but while this patch successfully adds bounds
to the fscanf call reading maps entries, is it possible that the earlier
sscanf call in parse_vma_segs() still has an unbounded width issue?

The function uses sscanf on lib_path with the format string
"/proc/%d/root%s" to extract the remainder into a local stack buffer sized
to PATH_MAX. If a tracing tool accepts an untrusted lib_path longer than
PATH_MAX that starts with the root prefix, won't this sscanf write out of
bounds and overflow the stack buffer?

Additionally, since the %s format specifier stops at the first whitespace,
wouldn't any valid paths containing spaces be truncated here? If so, this
might cause the later strcmp against the maps file to fail silently,
potentially breaking USDT attachment for libraries residing in directories
with spaces.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521221712.3077=
276-1-michael.bommarito@gmail.com?part=3D1
