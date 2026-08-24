Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917A12931F5;
	Mon, 24 Aug 2026 21:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787607348; cv=none; b=kbRlr6Mu+A11a+zHsWjiM8NH36DH3Ff3OqDRR38ALb066S6isANxmzMaF1OfcHDq8hYjndQ0KcIsfbYaxkTn8Qjqd2MgO5bLTLEjfBHZhiBJjvgakNAzw4vUk0M+GRL1SjehOCg2I2aBBg7hY9iNfGAZjSGGmvQV5z2PcB01Ky8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787607348; c=relaxed/simple;
	bh=or5/Ign9Tx8uUQIxKHT6UljtUhHg5mUD+YdutTct/jU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dIGoLqMSWllbakW5AItEd+D3/LuCRnaB03bgsbGaJ2dIP04l81lblZwCHYEwmUl4xBiiyt80VpO+Ow6DXFFH80Bm8TqhhteYY2sPI9kTzzKzEcuvzA4EfkYspNW2VyrUUbkQWm9uuNq2vY2GU7IGd2z4IDR4W9d5j/mMUB0MX+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=JSydmGU9; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="JSydmGU9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=or5/Ign9Tx8uUQIxKHT6UljtUhHg5mUD+YdutTct/jU=; b=JSydmGU9cQwNrA5hEXrc2ZQEqV
	lUshVT43Z5ZNvereW6ocyIXx1ohlMv2+CAy43EnVenVTMNLdORWP6vYpl1W6asBIyjcSzLaZqoYmu
	jmurHlHBJ/U0FWHRB5fqpHHwJBHMrRSHAwy4BWqyWwBLD+nNp9xgDgjjPa1JXLKtN0vT1loYAxzWz
	KNGxiWKriHj5Ny6wczu4kokR1PBYYc7TP07Kr4Z4BQbSaMO2nIwnCc/uHvzcxZoEc7w+SbsEcTeu+
	e2N1Un5mmG7jk6QtwQfGNyFf4Uru4O9nOccpCwbUdLzaT6dPQQfIE5BhFhPOPMR8ppr558o2PyaDI
	wpS9OgiA==;
Received: from [151.115.150.205] (port=54026 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1wycKX-0000000EQJy-0JLt;
	Mon, 24 Aug 2026 23:35:44 +0200
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
Subject: [BUG] bpf: x86 timed may_goto corrupts private-stack JIT state
Date: Mon, 24 Aug 2026 21:31:57 +0000
Message-ID: <20260824213158.3755932-2-Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Hello,

With the help of AI models, I found a bug in the x86 timed may_goto path that
leads to a verifier/JIT state mismatch on private-stack programs.

The root cause is that timed may_goto fixups pass a stack offset in BPF_REG_AX
and the x86 trampoline reconstructs the counter pointer from native %rbp. That
is incorrect once private-stack JIT mode is enabled: ordinary BPF frame pointer
accesses are remapped from %rbp to %r9, but arch_bpf_timed_may_goto() still
uses %rbp and ends up reading and writing the native JIT frame instead of the
private BPF stack.

The bug was introduced by 2fb761823ead ("bpf, x86: Add x86 JIT support for timed
may_goto"). I reproduced it on a KASAN-enabled x86_64 kernel based on v7.2,
however KASAN does not trigger because the bad write stays inside the native
JIT frame. Yet, the saved-register corruption is observable.

I have not included a patch here because the fix seems subtle to me and would
likely touch many files for different arch.

I can share the minimal reproducer and other details privately with maintainers
if useful.

Best regards,
Jérémy

Fixes: 2fb761823ead ("bpf, x86: Add x86 JIT support for timed may_goto")
Assisted-by: Codex:gpt-5
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
