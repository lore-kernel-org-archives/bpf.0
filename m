Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9DA349CD0
	for <bpf@vger.kernel.org>; Thu, 21 May 2026 14:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779375188; cv=none; b=WSR2dTlFofYyXAtCpcqSmo0BHpk+63pb7Q/gkASz83H20v4q1EZGyhdtYBko4Xzk9KSfSfb7QxirPVtpJHK8qb18S+YO+rd6+oN3WsAf08JSfy/RNbFvcPuy53cCfwQNnQ650a9xpC64Ir1cuoN4wKAHNx/5F0/rVUNztjAWMhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779375188; c=relaxed/simple;
	bh=/b3NqxuX45PZivFcLAkfHLC+1QmL7EJ19NnZiq4zlIk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ISVh689R40DPohIcS0LWJonYMeu+h/cFTa+FFxvibSoqRbZGv/keazNkw0T0ZxN5vltIIZ+EW0UsvyKg00oyjMKhlM3F3/PdzYTJH6XUzNTBviVYAwtSG7+Z/nG6Fe4mqMzmsvyFkCCCDvHBosUddMEjA0mzV6RghR0zus/0rJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OX2Xv+iM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OX2Xv+iM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FB1C1F00A3B;
	Thu, 21 May 2026 14:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779375187;
	bh=1ypKJoaHZI+diafQxf/MByXjs5l9EzufGbACnTiICGs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OX2Xv+iMVSyvINBn6C6atdDWrVb8rq8En9lTg9cEDMZzRlCZ7Qgb/1r8JutX3PWYn
	 nGb50XhCXI6D34rVi0HQtTcrgcY92eVkRYS+fWCYRhBNC52uaUGcxC0cKBBNwjMlUU
	 3Djx0+HdnWBEinT3tO4E0tZQFBXnFGARyRChLoVnnevwvOLhzhz6Dx0b8qyI7WDlOW
	 c5628QOSUdBB0lcBRoBCc/+1YM6Ss9YQx0SCvbGhR5/l2laMj+hiX2j086YarwILBi
	 /4YW4H37Vz3/h5lHEmMKawwMlkvoIN3E34rGecLklar5BdTtu3h3M7lUlyoA70U6I7
	 QeCDqMddmwHfQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 07/20] unwind_user/sframe: Wire up unwind_user to
 sframe
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260521142546.3908498-8-jremus@linux.ibm.com>
References: <20260521142546.3908498-8-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 14:53:06 +0000
Message-Id: <20260521145307.2FB1C1F00A3B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Missing instruction pointer adjustment for return addresses duri=
ng SFrame unwinding of non-topmost frames.
--

commit 9e76c3f974e7ef0d88d0ca8c60fa84ef664ebee7
Author: Josh Poimboeuf <jpoimboe@kernel.org>

unwind_user/sframe: Wire up unwind_user to sframe

Now that the sframe infrastructure is fully in place, make it work by hooki=
ng
it up to the unwind_user interface.

> diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c
> index 90ab3c1a205ef..1fb2724197332 100644
> --- a/kernel/unwind/user.c
> +++ b/kernel/unwind/user.c

[ ... ]

> @@ -82,6 +83,16 @@ static int unwind_user_next_fp(struct unwind_user_stat=
e *state)
>  	return unwind_user_next_common(state, &fp_frame);
>  }
> =20
> +static int unwind_user_next_sframe(struct unwind_user_state *state)
> +{
> +	struct unwind_user_frame frame;
> +
> +	/* sframe expects the frame to be local storage */
> +	if (sframe_find(state->ip, &frame))

[Severity: Medium]
For non-topmost stack frames, state->ip holds the return address, which poi=
nts
to the instruction after the call. If a call is the very last instruction o=
f a
function (like a call to a noreturn function), the return address will poin=
t to
the first instruction of the next contiguous function in memory.

Could sframe_find() incorrectly match the next function's FDE and apply its
unwind rules to the current frame? Other table-driven unwinders handle this
by subtracting 1 from the instruction pointer for non-topmost frames.

> +		return -ENOENT;
> +	return unwind_user_next_common(state, &frame);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521142546.3908=
498-1-jremus@linux.ibm.com?part=3D7
