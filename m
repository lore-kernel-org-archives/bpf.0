Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E9C394E91;
	Mon, 20 Jul 2026 19:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784574037; cv=none; b=Sq6dUMcr+PAkDE9eUh7nJf8jFSBDkW2j4EFdM/Dzz3c2gBx9ytKuNox2ZRUOjsnHabW/zBSod6QsneC3/Ije8uBWbknE2dHakUWNU9BIMu76YO9IKjAurFOPrZrXI1G4/5uecI2tx/kB3rtHou4EA+mpt7U6HqAz5vTw28kFFpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784574037; c=relaxed/simple;
	bh=XYp2/FqtUlPVihTnmgip3HcpVOrwlAg33e2I9/h150Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IF26QewYPBg/LNcVYsktgfrfC455cukyrk3KerPq//Kbm8TtrudBzy4tT2Yg0x8ljfMYKyrQ0WpZvEIKcBK+P9bztmp/28EftsEBEZ/SqeXyPx9JY4MloZhM1dQDx841kbCj/16b1oLuuKns4oPp4bKHjDV9Wkl988uM4ud9jj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DT8xx8jg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DT8xx8jg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 779691F000E9;
	Mon, 20 Jul 2026 19:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784574028;
	bh=XYp2/FqtUlPVihTnmgip3HcpVOrwlAg33e2I9/h150Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=DT8xx8jgYa/1Q0uA4JwszPgIfozWwRcA4ThOyarDIp98KIVU8MxM1BSY02B53sBcE
	 Yt6d1Tfp9hitE3lKVE2LrephiZZURdsIv1DfJ5QVBMzheX1hjwtIbjVdULhf1ydpMH
	 u+crgG9Y+d5EPSL/e/V9Wf0JOBJr0FLVCj8ph1OHY2tIyjWz1yndHVCTdOuzXrVIM9
	 Q/70iUz+Qyy0gB0sbw0tsWqCph7I/QlsqGtI/4aINKRpbMfWSSKtnIIjCXFIYEsYtD
	 4yx19nthss0ROqJms6xLcPFDh4yKmiEq0tVfS5i7wPGudslObG30r7uW4Hlj72vXQI
	 /ZTMOv23mxQEA==
From: Thomas Gleixner <tglx@kernel.org>
To: Florian Schmaus via B4 Relay <devnull+flo.geekplace.eu@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Eduard
 Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
 =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Florian Schmaus <flo@geekplace.eu>
Subject: Re: [PATCH] selftests: do not preserve ownership when installing
 files with rsync
In-Reply-To: <20260715-kselftest-rsync-right-v1-1-8df6c7734389@geekplace.eu>
References: <20260715-kselftest-rsync-right-v1-1-8df6c7734389@geekplace.eu>
Date: Mon, 20 Jul 2026 21:00:25 +0200
Message-ID: <87zezllc52.ffs@fw13>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jul 15 2026 at 12:51, Florian Schmaus via wrote:
> From: Florian Schmaus <flo@geekplace.eu>
>
> When kselftests are built and installed using "make install" or
> integrated into other build systems (such as Yocto's "devtool
> modify"), the source tree might be owned by a non-root developer user.
>
> Because the installation scripts use "rsync -a", which implies -o and
> -g, the installed test binaries and scripts are explicitly assigned
> the UID/GID of the source tree owner instead of the user running the
> install command. This results in UID leaks into the root filesystem.
>
> Fix this by explicitly adding --no-owner --no-group to all rsync
> invocations across the selftests Makefiles so that the installed files
> are owned by the installing user (typically root).
>
> Signed-off-by: Florian Schmaus <flo@geekplace.eu>

Acked-by: Thomas Gleixner <tglx@kernel.org>
