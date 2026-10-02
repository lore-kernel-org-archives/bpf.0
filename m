Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F832D7DD8;
	Fri,  2 Oct 2026 00:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790900728; cv=none; b=OFSFBPE87n/Z7sSp4XdRE9lA6bOI+wY7I2gbTC7WN7Bbnki2feoNeMSnXDK/rMj16V585QOl7sPvvF0/KrHp4BCylZKGOQ6zqC28C5xzBLJcxmuI/QQrLgHeqV9BXB6DuzNHDc8KnHktrm9YeWF6Mg4f1kLx9gPnhZZXI34PoXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790900728; c=relaxed/simple;
	bh=FPl5chksuoBzyixpln+dF5IrhgzU8uiJt33t7hQCGUA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=DOM3wnVO7hG14p0/LOy1td1frHYyUZnDiKCMTZZ1g2JFs02s/6Hy7RYQ30ULX9hkBHG/p7X2oetus8ohpDqJAJI9D+RIImlPBinAejKYDuPKjF+lECw5+sR+gECnksYzZ9xr9RC0uxbrFq5q9i9CJUmpQmJtpp0x9xnJF4dYjfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cS1OCdSz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cS1OCdSz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 705FC1F00893;
	Fri,  2 Oct 2026 00:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790900727;
	bh=aemXCgeVmHl76y1ppXY/NHMT0v922rom2QEYDMqwxCU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=cS1OCdSzHqHX6BGjF4hoX29iH4lyVR4QH4tYp/IbdnIve+uYNKpToMwzM9lHuBlip
	 X+e/TDStEg2Govx0JoZoN1jRl/DraaaFZGBq2ZahpPOxGSrTqdrmyg8WBpU2ykiO3y
	 ZAUMu45goTwSgtP3JGaqHLuGRKLIP585SV4A+T17raLx/1MtBUdxThG/Xt6QjfviNc
	 aaCfztWIMUSUuXTbTBNGOOlQc7xvKfr+FJg5eQov+G4y/U5zTzoV/TaDQHixSE8g/w
	 5M4/UvPdqZHl26CdqmAbqDug8/AfR+H93D+eVE+IOXFRHZhOm7U+eKUw3kDS+Do0sj
	 3sqoKaxlL8GOA==
Content-Type: multipart/mixed; boundary="===============6591095728840749297=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f8740d5fbee4def64fc80feb9569b81455a9432d2e5d20d38c173a114b0dae78@mail.kernel.org>
In-Reply-To: <20261001152042.124445-6-gmonaco@redhat.com>
References: <20261001152042.124445-6-gmonaco@redhat.com>
Subject: Re: [PATCH v2 05/15] tools/rv: Move argument parsing from in_kernel to utils
From: bot+bpf-ci@kernel.org
To: gmonaco@redhat.com,linux-kernel@vger.kernel.org,linux-trace-kernel@vger.kernel.org,bpf@vger.kernel.org,rostedt@goodmis.org,gmonaco@redhat.com
Cc: alexei.starovoitov@gmail.com,namcao@linutronix.de,wen.yang@linux.dev,tobias.schaffner@siemens.com,vmalik@redhat.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  2 Oct 2026 00:25:26 +0000 (UTC)

--===============6591095728840749297==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> tools/rv: Move argument parsing from in_kernel to utils

TL;DR: Nit only: the shared parse_arguments() in utils.c still prints an
"ikm:" prefix in its debug message, which would mislabel -v output for BPF
monitors later in the series. Cosmetic, no behaviour change.

> diff --git a/tools/verification/rv/src/utils.c b/tools/verification/rv/src/utils.c
> index 5677b439dc2f..e19dd65ec789 100644
> --- a/tools/verification/rv/src/utils.c
> +++ b/tools/verification/rv/src/utils.c

[ ... ]

> @@ -45,3 +48,91 @@ void debug_msg(const char *fmt, ...)

[ ... ]

> +		}
> +	}
> +
> +	debug_msg("ikm: my pid is %d\n", config.my_pid);

Is the "ikm: " prefix still appropriate in this debug message now that
parse_arguments() lives in the shared utils.c?

At this commit only ikm_run_monitor() calls parse_arguments(), so the output
is correct.  Later in the series, 46210ac84ea4 ("tools/rv: Implement BPF
monitor loading and tracing") adds bpf_run_monitor(), which sets
config.is_bpf = true and then calls parse_arguments(monitor_name, argc,
argv).

With that, running "rv mon <bpf_monitor> -v" prints "ikm: my pid is N",
even though bpf_run_monitor() labels its own messages with "bpf:" (for
example "bpf: failed parsing arguments").  The message is still unchanged
at the series tip, 3b00bc9b2e54.

Would dropping the "ikm: " prefix from the shared helper work?  The selftest
in tests/rv_mon.t only matches "my pid is $pid", so it should keep passing.

This is cosmetic, it only mislabels the -v output and does not change
behaviour.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36944413541
--===============6591095728840749297==--
