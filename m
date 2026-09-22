Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5D14A2066;
	Tue, 22 Sep 2026 19:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790105763; cv=none; b=IpBEhvWoW6sNwrDAkHOsXXTaWlPnoHmbvlsgo8L1z9y/EE9/W0x7WHu4QdcP5vmaYo0LKZ8OJx7A283BfNRg3zjzYip7ow0nv1O40OqItMm2ggUA+pycltZAl2wpQQG8EysF0SPTqvq9yfzwZANsqaaLtMTVWTj7BZ6lTYA0hfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790105763; c=relaxed/simple;
	bh=7TnJlGr+Rl3T2qEcmU9MR1+bKEw42NQ3vWSHai/Stcw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=E2AZKRxNU/sKIIofXyg6cHwM0e/rLU2OKZfSdvqUajeocROEdpBNCA6UeggYgHsVNxTYWH94vfaTgigRKhxKUeXOmas7OTzPREq7JRbDUZ/jbRknGLwgID8q5gK/xLBgLU7S0IGffezz847VmDCp14weUWCJymRm+HOo+B7ajwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UAbug2cm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UAbug2cm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A13271F000FF;
	Tue, 22 Sep 2026 19:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790105761;
	bh=7TnJlGr+Rl3T2qEcmU9MR1+bKEw42NQ3vWSHai/Stcw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UAbug2cm+ScMlsJODrz55HbZzdB4+BKtorAh2wyghtEdG2jOMjrgdXtHEFsZqHEbN
	 JDZDc4xg/zVS3G6rC+Rxk9rvIXHdYwCDhRL1meWLmmiFGTEkJObZTWbr00oeSjpQ7c
	 H0UzvPw175bE12ItJHTqRyPbPmHEbcIRC6H+0mq+voqfr3FXE3wOK3bViuUTTrvyyA
	 dcLETuwtkkkqv87Bwc8KIFXGA9O5v83KJffn4w5OxIeafKxgACR416M6sPg8K1riI8
	 rrLZObBeWQ1aRc+5Wgg0ttJjbCsPCgKdgDiNwHu2OHyVtoQCJ0PlxJq9+w7Ea06Ktn
	 j7sqOzkoDQJ2w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 13/14] xtensa: pass pt_regs to audit_syscall_entry()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ricardo Robaina" <rrobaina@redhat.com>
Cc: audit@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <84d1ceabecaa1ddb22600e1b58ea9341c612680b.1790088067.git.rrobaina@redhat.com>
References: <cover.1790088067.git.rrobaina@redhat.com>
 <84d1ceabecaa1ddb22600e1b58ea9341c612680b.1790088067.git.rrobaina@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 19:36:01 +0000
Message-Id: <20260922193601.A13271F000FF@smtp.kernel.org>
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
t.rrobaina@redhat.com?part=3D13

