Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009BF213E9C
	for <bpf@vger.kernel.org>; Thu,  2 Jul 2026 01:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782956891; cv=none; b=Ex/9CuYEFJkyUCFIExHdkikNlpPNLFX+G5RzUe3p2pKXxTV2fzSwFBkhR6VYaUJiOLps7NcuoehpIlHmLzh684aQ/EmxP02uOxrRgE9ihLAw7JnE6QhbBEy1ZNaAzExXzAd5yZidt9WDDYEZ9BwAaDw3r+0mQYsX56lFwGHXJGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782956891; c=relaxed/simple;
	bh=YCyf6ysQj+oURZN8z10UNZ3W521z7jrFrluCaRpmXlw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=vF7vbWyAsRNsxpVJNCpyDT8ID+SHSG5vTGm0pACU2lbbIaLDb8uw0kVEFMvIqpYnF7O/I8eczPx4wzDckbH6wjbHWkWSgN/BH1j89vxX6wJvX5jtgFUj1+iIbwrQuCWTll1xRp0V9GY+YYVl+Ht6ZezOD3kI8zyoOYNAINwDMwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TOHyi8wp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TOHyi8wp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B88A1F000E9;
	Thu,  2 Jul 2026 01:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782956890;
	bh=Ta5rg1Qu/lWMQgozZ/5Eku+/lmAIgcIilfbI/+y8Ph4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TOHyi8wptBFeZrqHMP7KlL03z6ocBlfSYwxZyYEI3jfAY53y56diDZkTPX+GeosyA
	 GC4+NCJrGseZtA9s/APpeNv72dSOVH8npJ7pXIwzVbirtvdxcBG/cQ6nYhv4FIIEZ9
	 1q009Gb6YbABtwupx/qOVimem01Et7BoA2dvOxkD+R0Ar+24hUaDyzYZQS8gd4keRe
	 hdJyqWVPMSzky5vq/G/PPglA494CRf9JMnFXx25H6oMnbbGj/T1ddaLl5LqeAM1sDk
	 3LFCaWB2J/sH9aes3+cOj5maxuoJmpLrx5M9gL/WPia6KsMyCxLEw3InnWlAQkl5m4
	 adiW8y3lBO3gA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 07/15] atomic: Add atomic_cond_read_*_timeout()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ankur Arora" <ankur.a.arora@oracle.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260702013334.140905-8-ankur.a.arora@oracle.com>
References: <20260702013334.140905-1-ankur.a.arora@oracle.com>
 <20260702013334.140905-8-ankur.a.arora@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 01:48:09 +0000
Message-Id: <20260702014810.5B88A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Documentation introduces misleading API grouping and broken grammar.
--

commit aa3c9c6efe8c1dbd47a496d3ac3a6bd26a933d98
Author: Ankur Arora <ankur.a.arora@oracle.com>

atomic: Add atomic_cond_read_*_timeout()

This commit adds atomic load wrappers for conditional load timeout interfac=
es.
It also provides short documentation updates for the relaxed and acquire=20
variants of the atomic_cond_read interfaces.

> diff --git a/Documentation/atomic_t.txt b/Documentation/atomic_t.txt
> index bee3b1bca9a7b..0e53f6ccb5580 100644
> --- a/Documentation/atomic_t.txt
> +++ b/Documentation/atomic_t.txt
> @@ -16,6 +16,10 @@ Non-RMW ops:
>    atomic_read(), atomic_set()
>    atomic_read_acquire(), atomic_set_release()
> =20
> +Non-RMW, non-atomic_t ops:
> +
> +  atomic_cond_read_{relaxed,acquire}()

[Severity: Low]
This isn't a bug, but should atomic_cond_read_{relaxed,acquire}() be grouped
under "non-atomic_t ops"? They still take an atomic_t pointer as their prim=
ary
argument, so this heading seems misleading.

> +  atomic_cond_read_{relaxed,acquire}_timeout()

[ ... ]

> @@ -79,11 +83,11 @@ SEMANTICS
> =20
>  Non-RMW ops:
> =20
> -The non-RMW ops are (typically) regular LOADs and STOREs and are canonic=
ally
> -implemented using READ_ONCE(), WRITE_ONCE(), smp_load_acquire() and
> -smp_store_release() respectively. Therefore, if you find yourself only u=
sing
> -the Non-RMW operations of atomic_t, you do not in fact need atomic_t at =
all
> -and are doing it wrong.
> +The non-RMW ops are (typically) regular, or conditional LOADs and STOREs=
 and
> +are canonically implemented using READ_ONCE(), WRITE_ONCE(),
> +smp_load_acquire() and smp_store_release() respectively.

[Severity: Low]
This isn't a bug, but does adding "conditional LOADs" here break the=20
"respectively" mapping?=20

The text continues to list READ_ONCE(), WRITE_ONCE(), smp_load_acquire() an=
d=20
smp_store_release() as the canonical implementations, but doesn't add the=20
smp_cond_load_* macros to match the newly added conditional LOADs.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702013334.1409=
05-1-ankur.a.arora@oracle.com?part=3D7
