Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AAF4A092A;
	Wed,  2 Sep 2026 14:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788360991; cv=none; b=i2GaLEpCff4fV3MRxJVUS+ddJb7YvUP3P3IS2mfFH6mrSZIzQ4KYd3iAyfTV5xi+tLjsh21tSV/gtWmz5wfwEkrbm3XUjHqZsnoa3RICpIhd5NDv3ccRO8IYsb5Mg7X2o8yl4Zr1MULDlZbag+6b4djpvgX51seoZWy6wt4MjoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788360991; c=relaxed/simple;
	bh=uxkFU4QY1mnFVfyZmQ48ll0XUnBow+0npwxnAUOpuIM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=meA2IB79jhNeS82SmtMUBNsnW1qQ072fGME7LAf+TxytaEZp6gU+v/+VyOmIBGCi6O5+33TX/XKrMkIWJ8fn2NGSRfTjBlM3R6dmsOUr904PZLn06h5um23lwMb6PQaegcDa6FPQSvrnswFNp7fvmpBa2smLQESxVCZDbsAFPcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/SidQPU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/SidQPU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABA961F000E9;
	Wed,  2 Sep 2026 14:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788360989;
	bh=uxkFU4QY1mnFVfyZmQ48ll0XUnBow+0npwxnAUOpuIM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J/SidQPULCDteRaYFkE3eUYLOugPvsFNJ3AhHMxMf2n8TyPELWsmmGgl+dHAl0tJf
	 B+s1dTeZcnxBHrhVKZFEVzUtvbKObTOXc9kRw1MfAu+rVmwyWwjTZl/JsFABEqcpsi
	 wqfexy4OdWJnh1N3nvrHlDBPdg7QmLqiAGQC3Vyl2JKrs4vSZkY5tXeZw7xaymANHC
	 iEbiAaED7ghJNPCZg/nUU0RlTBWNYcle6jVwZiR/rmRWE/gC3QB3OT8XAqZdv/lsGG
	 Uh2mieMvy3JeVU9YSzM7IdZr3q6fU6dG3vpWjiRFT8a/ql46NamzGZ3lX0csdgSYj7
	 pqPq87i2Xojgw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 06/13] microblaze: pass pt_regs to
 audit_syscall_entry()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ricardo Robaina" <rrobaina@redhat.com>
Cc: bpf@vger.kernel.org, audit@vger.kernel.org
In-Reply-To: <185aac22d5afd79ef50f170332a1a808ff0a5b0d.1788351089.git.rrobaina@redhat.com>
References: <cover.1788351089.git.rrobaina@redhat.com>
 <185aac22d5afd79ef50f170332a1a808ff0a5b0d.1788351089.git.rrobaina@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 14:56:29 +0000
Message-Id: <20260902145629.ABA961F000E9@smtp.kernel.org>
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
t.rrobaina@redhat.com?part=3D6

