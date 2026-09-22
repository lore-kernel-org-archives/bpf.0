Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F632773EC;
	Tue, 22 Sep 2026 19:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790105516; cv=none; b=stzkV3wC+BtTF5lGwHvQMmmJMOL5K/dUjNiaSh/bqtMGBE32qzJft13+33UTyeaKeVSsykRPKsak/RS/k+JmTU+yDlJ269TnarjLbJgvThusaforZUt3SlfzcqWafDp1G5k2uwyhAq2TRUixOwEH9dFtsA3rKcEd3uDHEzwNTKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790105516; c=relaxed/simple;
	bh=tS7+2pHoaiddHx52RPXOQ9CHrCMYSD8oW7fbFm5eAnY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gaYdXRJi6elT8bO45fxaBTzRuFxhodwQ3+GW3JTw/trEu0u7JjxaXuQHV5U7kdLKwp+/LY0IzKH2em0523R/PZzSvQa2p8dVK/74Mah8Hf4ix8teJA1AzaXbWPJtDV0afvYai1arukyORusw2o0hmqiDkboYASqTV59Pbhu9hl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TJv9hH36; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TJv9hH36"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8E741F000FF;
	Tue, 22 Sep 2026 19:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790105515;
	bh=tLtzaLRsDNKBy/9DyMGePwCcUjyoaMIJqz5yCgpB2Uk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TJv9hH36jpRiMgeAkrCyeJHQQJyyOMfXmZk+DrhR1hmZzKw5g9yI9yhxH2cev2FUS
	 BytiPIZ9KpwgTZi3F0tokDEpbxb2fJoUy1fq7UpxzLo9pMK17Q8gwfJ6L0Ctgg2v0n
	 if19ArYVEeNVWnVxpbboE4v4BtcFj5Xh35dpLpKaNJWzf+tnIyQRvdaJop5wclEs0v
	 N68xhpO9S28iSQjoVIWl0lR/rD2vXxhCscfdQGBtGEFi/tnebxwLq4dZp+QE64hknX
	 zp38A6m8DEBycvARSUsn4i3pmJnuF/qV8YR60l4qiAqhhuS2imqwpLxSJXzlKa0dt6
	 zZABgGGzT67rw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 01/14] audit: log all six syscall arguments in the
 SYSCALL record
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ricardo Robaina" <rrobaina@redhat.com>
Cc: audit@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <855572d1b7461e7f258547be0f11c74029755110.1790088067.git.rrobaina@redhat.com>
References: <cover.1790088067.git.rrobaina@redhat.com>
 <855572d1b7461e7f258547be0f11c74029755110.1790088067.git.rrobaina@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 19:31:54 +0000
Message-Id: <20260922193154.E8E741F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

> The SYSCALL record currently logs only four of the six syscall
> arguments (a0-a3). The remaining two are captured but silently
> discarded before reaching the audit context. This leads to the
> need for auxiliary records when audit-relevant data lands in the
> 5th or 6th argument of a syscall.
>=20
> Extend the SYSCALL record to log all six arguments, by adding
> arguments a4 and a5 (5th and 6th syscall arguments respectively)
> inline within the existing record. Also add the two new args to
> the audit rules switch case, so audit rules can filter on them.
>=20
> Rather than plumbing two more register arguments through every
> architecture's syscall entry path, retrieve the arguments from
> pt_regs via syscall_get_arguments(). To keep the series bisectable,
> add new helpers audit_syscall_entry_regs() and
> [ ... ]
>  ...
>=20
> Suggested-by: Will Deacon <will@kernel.org>
> Link: https://lore.kernel.org/audit/CAHC9VhSjEt_-Bsra4AEqWv+Daw5Ff=3Dgqy7=
dX4Ah11RVhdyCBUQ@mail.gmail.com/T/#t
> Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790088067.gi=
t.rrobaina@redhat.com?part=3D1

