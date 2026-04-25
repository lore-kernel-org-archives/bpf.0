Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFB4381AE5
	for <bpf@vger.kernel.org>; Sat, 25 Apr 2026 03:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777086826; cv=none; b=Ei+Jdv8TZTrr920vVRz97sAsgDXMyUUmAftvsGrXQL4b8hmaeBjgpGbXJTnRQel4Dbry5qi1F74KU+dUPWFH3h0GVK0nAUDHagUPrQMv6llGfcevIh1BDgM2U7BrcU8wdUiWDqFCNm7FMpzvFyoFIrmEhI73foRT5Z7IVNVkllc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777086826; c=relaxed/simple;
	bh=8Pbd3YScrt6ac6BWHpBNKGk58ven/oZAQehwHfdmG94=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AlZiquyJKQ7Yhhd+jMWWsZi/Y9LKQzgIj4T7ytF93HTGQszHOT8HlS1MVEGl2HqLbpR30uHJy/ALlu09YoBn33N52trdLqxJhpabtMnA9ffevnW7Vc0ccN4M6LINWpco+6VmovAdGeVMh8QENGSZ9FBonWAcXuRG57FEuLcaF2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ymqbr1Ok; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ymqbr1Ok"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74F4AC19425;
	Sat, 25 Apr 2026 03:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777086826;
	bh=8Pbd3YScrt6ac6BWHpBNKGk58ven/oZAQehwHfdmG94=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Ymqbr1Okx2Nq+aD4xKySEpKkjp97cWWdYWE6GWsku3VbKZMtPnuUEHW5ieEYoFCr3
	 PBc99nAhWXArJMfebsboApZ+CxqM86nnJEbvPAeze3gKH8HX2Gn6/2UvYB+Cf00Wv5
	 Ej2kquGHqctJfh40QGFM3C9FNL2j1/adA7D6RvP2j4W6A/DNDym7SOyrZel2tjOXZ2
	 kee5n2b1zpCNYIHdO9OCkbSsFhM3yQBE5oOUWJqJN+gSLW38wOvNMFMiQ6WX57B5T+
	 5ChA8wUYy4y7s5UgmRHjhAfTA/arPjVRLrj0MPUq04G3fwVbYa7QbdSTOYRD6+XQ97
	 y8CpKhjSyEvPw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC bpf-next 1/8] kasan: expose generic kasan helpers
Reply-To: sashiko@lists.linux.dev
To: =?utf-8?b?QWxleGlzIExvdGhvcsOpIChlQlBGIEZvdW5kYXRpb24p?= <alexis.lothore@bootlin.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260413-kasan-v1-1-1a5831230821@bootlin.com>
References: <20260413-kasan-v1-1-1a5831230821@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 03:13:45 +0000
Message-Id: <20260425031346.74F4AC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Low] The declarations of __asan_loadX and __asan_storeX are conditionall=
y wrapped in `#ifdef CONFIG_KASAN_GENERIC`, which prevents callers from usi=
ng the standard `IS_ENABLED()` macro.
--

commit a639759513c522c95441b98d740390daf692c6e3
Author: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@bootlin.com>

kasan: expose generic kasan helpers

This commit exposes generic KASAN load and store helper functions in
include/linux/kasan.h. It moves the declarations from the internal
mm/kasan/kasan.h header to prepare for their use by the eBPF subsystem.

> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index bf233bde68c7e..587b25d170f40 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -710,4 +710,17 @@ void kasan_non_canonical_hook(unsigned long addr);
>  static inline void kasan_non_canonical_hook(unsigned long addr) { }
>  #endif /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
> =20
> +#ifdef CONFIG_KASAN_GENERIC

Does wrapping these declarations in #ifdef CONFIG_KASAN_GENERIC prevent
callers from using the IS_ENABLED() macro?

If code attempts to use if (IS_ENABLED(CONFIG_KASAN_GENERIC)) with these
functions, it will fail to compile with an undeclared identifier error
when generic KASAN is disabled.

Declaring these external functions unconditionally in the header allows
callers to adopt the IS_ENABLED() pattern safely instead of relying on
#ifdef blocks in C files.

> +void __asan_load1(void *p);
> +void __asan_store1(void *p);
> +void __asan_load2(void *p);
> +void __asan_store2(void *p);
> +void __asan_load4(void *p);
> +void __asan_store4(void *p);
> +void __asan_load8(void *p);
> +void __asan_store8(void *p);
> +void __asan_load16(void *p);
> +void __asan_store16(void *p);
> +#endif /* CONFIG_KASAN_GENERIC */
> +
>  #endif /* LINUX_KASAN_H */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260413-kasan-v1-0=
-1a5831230821@bootlin.com?part=3D1
