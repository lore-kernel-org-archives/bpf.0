Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F08B35C188;
	Tue, 22 Sep 2026 19:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790105434; cv=none; b=d5taKvgrL4MPF6kA4Ib5QvlrTbNoXdxaHABGdnvZpwTqRyZwA53i3nQ5NCB8cJarIDE2oZCjWQoiuGdH82hhBUDVRM/X6SYgxTBq9zeWB7ExET5Acx72Y6boiME+jR3xPZz/Op/PDuZ8jtin1x4zrkdkvquZ+Htzb6ovXsXVFHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790105434; c=relaxed/simple;
	bh=NF+85lzzxGMc5DTTpwzcl8FhjD89z2OdLb/mKT0Qxhk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qS5p4rfup47jGisE8y21wnm3zfsfdwph2ktvFW/PzgoDqazCwSVgBNBeTZOpffLqxvfyq1GgPiMyzf4Oa2fg925nt6PuLQuq0zocWP0jpTtXcRo8SeQfzelecnqWyUvyBKQHXUHHOHyOhEcwqtipJ6K+xkRKl8c2hUj2RIr6ae8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fe6AU3Xm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fe6AU3Xm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DF0A1F00893;
	Tue, 22 Sep 2026 19:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790105433;
	bh=NF+85lzzxGMc5DTTpwzcl8FhjD89z2OdLb/mKT0Qxhk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Fe6AU3Xmqh8TKpvsJesqsIF8PTiQPXT5RClCxd4jt8igiQHMqXfE+ZdH/X7jPnoqH
	 jmBnEvJfp41m3OiINHBckNhLKvzhvFf+UWicp4G38Fz2+fhvGhyUoTpew/X1iO4scX
	 O5n2rx0HPGzlnbUINPmTyxsKJm3/NttapbzB1h3QBWqWqahfos3fe4I7G5h4PPXiJb
	 O4h7ow+8ONzN710b/p25Ci4vHLL1KJNyskeh+Pfj50U9U2i7UWf59TWvSq4OEQCGJC
	 MJt139Ak2e4jV2o8Fn57f8T4QNa6mjxZB33sxMoEpqehRFg++2CPKefJ7GrNuzPg+S
	 vMAqAEz20Dc6A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 11/14] sparc64: pass pt_regs to audit_syscall_entry()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ricardo Robaina" <rrobaina@redhat.com>
Cc: bpf@vger.kernel.org, audit@vger.kernel.org
In-Reply-To: <7e9a7d36bb02704cf8cbab9b4d78832536698470.1790088067.git.rrobaina@redhat.com>
References: <cover.1790088067.git.rrobaina@redhat.com>
 <7e9a7d36bb02704cf8cbab9b4d78832536698470.1790088067.git.rrobaina@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 19:30:32 +0000
Message-Id: <20260922193033.4DF0A1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

> audit_syscall_entry() now takes a pointer to pt_regs and extracts
> the syscall arguments itself via syscall_get_arguments(). Drop the
> individual argument registers from the call and pass regs instead.
>=20
> Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790088067.gi=
t.rrobaina@redhat.com?part=3D11

