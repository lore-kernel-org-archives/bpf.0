Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8723C19CCF5
	for <bpf@vger.kernel.org>; Sun, 23 Aug 2026 01:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787449731; cv=none; b=dYgg++BsrFKAUckUv6ztEfi6ooboWirrA6Lz2PP2x62TQ4lCqG8Y34DW93ykYqP/K9GjxsQrordmPT139WglDKxjZWjaHuFrtZxcknpn3YFgHPELBamTG3jysAKyJHzbI4RSRLWhce96Vga32cM1suyN/N7l1retgJQl1pbktV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787449731; c=relaxed/simple;
	bh=biCBLiPhsedx/rJk9T4hUtaX6gLLY2r39PhCJgcJGfo=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=YiFwjA0tV83+LItpDKcvmuldccDPXxoBeeTCetQAPMOPK3G0wSeLP/HlG1VkdEnSjzO1A8eeMMO4Ms0ZWqlQAighVl92HFcbnXZ89ubJp/0FF2tPXhCZNHAkjyS+mqew8oSf72aIakziHaijfZfeHWAZ0DYkL+xcxdTfOCL2xEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LIlO6ZKO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LIlO6ZKO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D957E1F000E9;
	Sun, 23 Aug 2026 01:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787449730;
	bh=biCBLiPhsedx/rJk9T4hUtaX6gLLY2r39PhCJgcJGfo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=LIlO6ZKO/fJeX8YfzR6j4EZ1QKaL4ky0GYdFTR3NJJL7jg6cqcleO0XTsS9YIB8aK
	 4KIeTkoTB8BUSPOKJqpiyemRi9FTYOcRdhRUiMUKEbbqt16SlEYjlQnxIf3mcYBXAj
	 OEK+L6mn2I9DuJo1cca57t40PPmLCw7BlLyrgeztbbCA9CuhmfP/c2QMbGyz0LTmxy
	 QgOKz4kjwgqKyjQGu3hRf+f7ucaxn+4r3lFPcvQRIfvzwNyZ/e7S32zFN0zf9AiwKg
	 SNMltJYYSTyKoOcz3Rz4j0lbMR66m+VjZe/nNoDYmstzjxhU8U+S3HlxJ9HnCYLY/I
	 4eXGdqDNtAwiQ==
Content-Type: multipart/mixed; boundary="===============3025385057414925347=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ab63b8577423403775e07530032955abc050cb491b93173dcf56c25d10c8b340@mail.kernel.org>
In-Reply-To: <20260823010900.1730708-7-nickolay.lysenko@gmail.com>
References: <20260823010900.1730708-7-nickolay.lysenko@gmail.com>
Subject: Re: [PATCH bpf-next v6 6/9] selftests/bpf: derive the bench object list from the sources
From: bot+bpf-ci@kernel.org
To: nickolay.lysenko@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,memxor@gmail.com,nickolay.lysenko@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun, 23 Aug 2026 01:48:49 +0000 (UTC)

--===============3025385057414925347==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> The bench binary links every benchs/bench_*.c object, but the link
> rule names them one by one in a hand-maintained list - adding a
> benchmark means writing its name three times (source file, skeleton
> dependency line, link list). Derive the list with a wildcard, as the
> per-object skeleton dependency lines already imply: any bench_*.c
> placed in benchs/ is compiled and linked in.
>
> The derived list is sorted, which changes the link order of the bench
> objects (previously roughly chronological) and with it the symbol
> layout of the binary; no benchmark behaves differently. The trailing
> '#' terminator goes away: the list now ends in a variable, so the
> append-friendliness it provided no longer applies.
>
> Signed-off-by: Mykola Lysenko <nickolay.lysenko@gmail.com>

This isn't a bug, but could this last paragraph be trimmed or corrected?
The list still ends in $(OUTPUT)/usdt_2.o rather than a variable, and
the '#' could have stayed.

Similarly, is it the pattern rule rather than the skeleton dependency
lines that already makes any benchs/bench_*.c buildable? The statement
that "adding a benchmark means writing its name three times" also
doesn't hold for benchmarks without a skeleton like benchs/bench_count.c,
which has no dependency line at all.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32610372822
--===============3025385057414925347==--
