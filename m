Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1279F3C140E
	for <bpf@vger.kernel.org>; Thu, 14 May 2026 20:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778791467; cv=none; b=jgZcWK4FdclJmv4SE0TBwxjGt0BjhZr2CLgrNebuo5pnbbSR15rXI+FauKk+D1RmUPJBtM314ra8Iuvb2bat10MZwzWZlEplhMeiG2O2RjlPTcmY4TESxkCNnaKxJ91d0H0Dp+PCoIRw+tPjNXemSeY2jLsiTN2u9dpY7mNDObY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778791467; c=relaxed/simple;
	bh=PT+KZHkUKuH5xQ/uIUEy3gjKOuOLrDM+KkANeGmBbrc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kj8HYif7HG9BI0JtVa8j/pFONb6VZIn15ffPpg9/a3k47wHKey1lVlUl4Lyx3cwLDvB0gCnjSZu9FwD/fK/WHcyRQRTWc4/a3+Fx5ApEn6KHXVUOgjuohGG8p8ls89HkQixwPjUN2/4dex9Ym84FmZ3Iekgtcr7f//f4rABgH3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jqsp/4wF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jqsp/4wF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36E20C2BCB3;
	Thu, 14 May 2026 20:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778791466;
	bh=PT+KZHkUKuH5xQ/uIUEy3gjKOuOLrDM+KkANeGmBbrc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Jqsp/4wFB/LSGVpLk24SOUR0tkDhC1CUhY36rXg740r4ysAo7vpJM5vd8SPneFFcc
	 TxJj5WGRCy8D7IzvLZMlckCjUGvsVHxUcv+d23o1G3PJFX27Rvb+VvRvfImmZNUhDn
	 43Pd4IX7h/vDdZtT7H/lhYYtHWA2L8cDJpQ/mQ0qV6j5/Jp2yMy/e7jOxytjmfG/sA
	 +aMZHv8Eacea78ioNO32tbZzVmQ8EFW7GTFsPFgth0+DTMaaJUuG9OD6L8BsBfmgAD
	 HTJcJoJ+YIX9o9oN1fJaBSLh08Ji8HVuE7GNy4C+BbT4/R7+UtL5mCiKDymD7q5tWn
	 vwTxORTD2SmyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/7] selftests/bpf: Emit nop,nop10 instructions combo
 for x86_64 arch
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260514135342.22130-4-jolsa@kernel.org>
References: <20260514135342.22130-4-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 20:44:25 +0000
Message-Id: <20260514204426.36E20C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The commit modifies `USDT_NOP` in `usdt.h` to an 11-byte `nop,no=
p10` sequence but does not update `prog_tests/usdt.c`, causing the selftest=
 to break and introducing a git bisect regression.
--

commit 600c1890b9793e001b5d8d9027629fb122af9024
Author: Jiri Olsa <jolsa@kernel.org>

selftests/bpf: Emit nop,nop10 instructions combo for x86_64 arch
   =20
This commit updates the USDT_NOP macro in usdt.h for x86_64 to emit an
11-byte nop, nop10 instruction sequence instead of the previous nop, nop5
sequence. It synchronizes with the latest usdt.h changes to utilize nop10
optimization support.

> diff --git a/tools/testing/selftests/bpf/usdt.h b/tools/testing/selftests=
/bpf/usdt.h
> --- a/tools/testing/selftests/bpf/usdt.h
> +++ b/tools/testing/selftests/bpf/usdt.h

[ ... ]

> @@ -313,7 +313,7 @@ struct usdt_sema { volatile unsigned short active; };
>  #if defined(__ia64__) || defined(__s390__) || defined(__s390x__)
>  #define USDT_NOP			nop 0
>  #elif defined(__x86_64__)
> -#define USDT_NOP                       .byte 0x90, 0x0f, 0x1f, 0x44, 0x0=
0, 0x0 /* nop, nop5 */
> +#define USDT_NOP                       .byte 0x90, 0x66, 0x66, 0x0f, 0x1=
f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00 /* nop, nop10 */

Does changing this instruction sequence from 6 bytes to 11 bytes without
updating prog_tests/usdt.c in the same commit cause a test breakage?

The selftest in prog_tests/usdt.c hardcodes the old 6-byte nop1_nop5_combo
and searches for it using find_instr(usdt_2, nop1_nop5_combo, 6). Because
the old sequence is no longer present in usdt_2.c, find_instr will return
NULL, causing the ASSERT_OK_PTR assertion to fail.

I see this is addressed later in the series in commit
ca88e95623000540d5b706ce364d5b5abf75b4c1. Would it be better to squash the
test update into this commit to avoid breaking git bisect?

Additionally, looking at that later commit, it updates nop1_nop10_combo to
11 bytes but appears to continue passing 6 as the size argument to
find_instr. Should that size argument be updated to 11 as well?

>  #else
>  #define USDT_NOP			nop
>  #endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260514135342.2213=
0-1-jolsa@kernel.org?part=3D3
