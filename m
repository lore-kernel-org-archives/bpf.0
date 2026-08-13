Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441DE499F37;
	Thu, 13 Aug 2026 17:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786641209; cv=none; b=HgnZT2IUKfXTIDnUgf+zk32O+evfJjJbXSvuAfLf/hTj38Hb38bQBnzE374jUF4mtNz7tgIItggIeTZ60d5+Vo9stU3kmzvgmBtPw/v29uz/5OIALVmbbb560hzb9kYqEEhMUpZHE+5mWHg08fFgbizHt6pKpUgNaVyUifFKWjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786641209; c=relaxed/simple;
	bh=mj194s08tz5QYEViqgmARVm3zT9MlPbZu7Bv86MiM2Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OZ3vdZgaYxWkUKpGbXRoYne3s2BQaelizoOzzZjlSv4RX+5YecxYzMScCxRsK12WL7mJDv8M00rJ3rK7ZBqbHsWt4HE1MsT7WQvQ8PfET6nwmNsmL/f4B5V9ali2UAgEUaHr/b+XSH/pvZXKp4Yj3PPMcx/I/sUqKexDcwU2G/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RsbvoFvI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RsbvoFvI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABC581F000E9;
	Thu, 13 Aug 2026 17:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786641207;
	bh=mj194s08tz5QYEViqgmARVm3zT9MlPbZu7Bv86MiM2Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RsbvoFvIQ9fck+0rcDGqFf77BbHfbo3LyEAKFiuZc9OnUoDqXN0Kzw/8Sar5jJDqr
	 +a1Y8enO2FwTu47KNdmudrh07obUW3DpTLjfOzStHagWxOr5MLLiITSAXRe5OJqaww
	 JDdc8VR52gLQxOkH+aoAIZRK6c/wsoQqpxUC8cplH2L8SE9fwearmCIjSH/XhnebBi
	 O6xkjavWEp9ssSsZwOD8Ne9NdzD6ccVkNtSnpS6y1P3mHsCLVsJPUFs5pgC3bITGUE
	 nloY5ZfHxQvrQJQ1t8fqATuF/+0LBgj5Yvu3kkR7sTnWuox9fkJmWoMXL/iV9ruKuP
	 yQDoCFJzzZHPw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/13] parisc: pass all six syscall args to
 audit_syscall_entry()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ricardo Robaina" <rrobaina@redhat.com>
Cc: audit@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <90512a215fb9bdd39471c241057c097ed8b93186.1786626275.git.rrobaina@redhat.com>
References: <cover.1786626275.git.rrobaina@redhat.com>
 <90512a215fb9bdd39471c241057c097ed8b93186.1786626275.git.rrobaina@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 17:13:26 +0000
Message-Id: <20260813171327.ABC581F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

> Update both the native and compat audit_syscall_entry() calls to
> forward the 5th and 6th syscall arguments (gr[22], gr[21]) now
> that the audit core logs all six.
>=20
> Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1786626275.gi=
t.rrobaina@redhat.com?part=3D9

