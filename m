Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8064A6CEB;
	Wed,  2 Sep 2026 14:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788361051; cv=none; b=lWb/SQYyCFXWz6qO84l8XJ5yDftFIIpWPjJgrW1PF5B6uxDTP/7r55837CzI4u1xtQfhfUXCPsGqEnq2KdViFjWrWk9C3jBhNl4Vzqpt21g6yhcsIP/IMUGkByTdPALI6mIQ3viqLhnigT4c6WPHl6M66GJU9bAU4PEYHa4gn9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788361051; c=relaxed/simple;
	bh=i6QbnixJF3SVMTrVsaMUNMVdvXvz6T2yt+zojDtwEmc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NhfFrV+dSZu233ZWSLSVLJeUz8LgG+fkxv/9Jg97ABu07FxEBtt8OoSir8VnVTHTcXwPpj/8+PeROm0LYLLDoUUJPPFgkTlw0ofLZSw8rZfz/c+ObjRRfqIWnB1o+lA7+81wSzHjMkdiszGc61L8uNOstfazWATp4E1Qt25dkOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ixQqwefC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ixQqwefC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB7B31F000E9;
	Wed,  2 Sep 2026 14:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788361041;
	bh=i6QbnixJF3SVMTrVsaMUNMVdvXvz6T2yt+zojDtwEmc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ixQqwefC7hXANzcp7kUMaNDz5T/oUcXW4ajChC9vuTDUu7u7UG+Vi9ct94CeNuO/9
	 yjGECGACMWoGNHyKdvZCzuquWsF+heAfYYaTQoRKdJfTWlQdImkH3/uBWkNl51WYif
	 TjjzaY9YdhN1PL0mIGXfHZjLC5MuW1ehAu4tJMOqyLixMeiEsdcvMVI666EZymrIDV
	 sUHuNhQh2+Yf8cwsHEPhtAtSQCReHQH/10vdsMalUljeYGeruhK/4ihDAaP9ymb3Rg
	 mnwOKRSK1K9aXmxMNjzzlJBTjl4F6ISJuXPfghXIgWUUk0N6mL8LrJR8UKcEP6eFmY
	 OEUTQE52pbNkw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/13] mips: pass pt_regs to audit_syscall_entry()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ricardo Robaina" <rrobaina@redhat.com>
Cc: audit@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <153ece40b540f100ab436549b8e5819d52cd4f92.1788351089.git.rrobaina@redhat.com>
References: <cover.1788351089.git.rrobaina@redhat.com>
 <153ece40b540f100ab436549b8e5819d52cd4f92.1788351089.git.rrobaina@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 14:57:20 +0000
Message-Id: <20260902145720.EB7B31F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788351089.gi=
t.rrobaina@redhat.com?part=3D7

