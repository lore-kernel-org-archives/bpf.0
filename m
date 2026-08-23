Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A332726AC5
	for <bpf@vger.kernel.org>; Sun, 23 Aug 2026 20:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787517677; cv=none; b=a8osHtJOiCQlA41ycQaqogDZn6uFvnx0go53N/NlYZ3EKlENXQr9Nqp6zKVR8Rr8xPJKLapk3yrcBLfuLOTTW/KloZLlOVvsw6LIOUISn2qWlssSf4laJd1x030huSn2Tqfng58f1sBJdJZYwiuTxasMTnTK0lhLeKViVXGW6J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787517677; c=relaxed/simple;
	bh=cr3WNCr252mepYevRKxT4LbWZ5FtNdS+lyW6gG4Xhjc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=jvOV9ago8KRdQXTpEX57DbSvD40hcJhNK2em3guQkglOMkftt/T6Osjr6mPkUGbMTHvMB1GyxyEx5pJaeiZaWJyxBvxVGcknoe0RvMSPXkFNbpk1TShkFadapVKe2sVbMX8gQxDcl2X+atNw0D7azFF/SLEhggdVsXwodFxTgxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J69IGGVP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J69IGGVP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9E361F000E9;
	Sun, 23 Aug 2026 20:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787517676;
	bh=qJqM+/FyXTlVMkPliV6LdRYGSxDVYsPfnBTw/LG3soE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=J69IGGVPud2lfqppq7WF//32cpQrpvsYEXvYEwtijIEF2hW/zCcLGMnZIUEPVidFL
	 cEmia2FbT+Xw/SaheDK3bW9NP1K1zWyExGhE88GLcq0ydanFYVtzaRSkgewwMnMbdD
	 1FcqsZuXCAMBRHRumQD4BEAiFgGCv4PurSYCoQYVzQYFcYkwLUJjqo8iAVP+M8hAyE
	 +8+ODIeI+1kLov2kaWEpf4hegKzmGIdcy49lhLCLEJG7TQDgE1ubvatVNLqc6i80PO
	 4jzLa4+KnPBvQmlYY+P1bch5Zp/l7ICz6EVTVsa+CK067HmgwqeihwiAaZ+wXDvB8M
	 +78mXdTYDt5tQ==
Content-Type: multipart/mixed; boundary="===============7024829023512290416=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <baf68874e21b823ef6bef5bd2d9d8e5d8b487007b0ce6b9590c4a7bc20d88047@mail.kernel.org>
In-Reply-To: <20260823194241.3415152-3-nickolay.lysenko@gmail.com>
References: <20260823194241.3415152-3-nickolay.lysenko@gmail.com>
Subject: Re: [PATCH bpf-next v7 2/9] selftests/bpf: drop stale lines, restore two header dependencies
From: bot+bpf-ci@kernel.org
To: nickolay.lysenko@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,memxor@gmail.com,nickolay.lysenko@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun, 23 Aug 2026 20:41:15 +0000 (UTC)

--===============7024829023512290416==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 118a7c356e26c..c7c7f27dd8605 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -4,9 +4,7 @@ include ../../../scripts/Makefile.arch
>  include ../../../scripts/Makefile.include
>
>  CXX ?= $(CROSS_COMPILE)g++
> -OBJCOPY ?= $(CROSS_COMPILE)objcopy
>
> -CURDIR := $(abspath .)
>  TOOLSDIR := $(abspath ../../..)

This isn't a bug, but would it be worth splitting the OBJCOPY and CURDIR
variable removals into their own small cleanup patch? The subject and the
bulk of the changelog focus on stale build rules and the two restored
header dependencies, while these variable removals are unused/redundant
definitions that get their own paragraph at the end.

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32662817569
--===============7024829023512290416==--
