Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61B61A2389
	for <bpf@vger.kernel.org>; Mon, 16 Feb 2026 19:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771271303; cv=none; b=o989e/QUfCeVY+Fl6uZintBq+zsQXYpQXBfuXM6iInXCYXfLNPP+Odjn01Rt80PM1GPWPSiOYya0YZuAZnXlHiY60X/jRCOlYt4zlTMN6WxOSudNjeVfVLaKI2ojxtorShZJBN8H/8TGW4phmu4YiHKoibSuzLYe9uzNd1pS+bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771271303; c=relaxed/simple;
	bh=iE/senEhoxa6F/+zSepLUtgGVKbTKHld1W5C98hyw0Y=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=pnekgHB+YS4ZNYc5ujwkMGffTKtzGSMsnTLQiOHko31i0rfi8AuddxlGbWUNb2VnCyVhrz6YGTEWW9hVNdow7T42g0KAkWyHqAzOQM2gdTW/aA8Q7iJ6go7RQc+a9HExv3RTy+/4oSciTZx+FViS90Gwb0lJLfBbnnAFJqxKRDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GpRTc1QR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GpRTc1QR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7EA0C116C6;
	Mon, 16 Feb 2026 19:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771271303;
	bh=iE/senEhoxa6F/+zSepLUtgGVKbTKHld1W5C98hyw0Y=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=GpRTc1QRTd1MIKxZTZWEL9TyoPsnUDkS/cf0NS4lxl4gg1mJYMmaXpkDPZkS3Sjkn
	 gjDH8n4exbdkJO5n1PBYSBCDftYtok/d8BQH4XeV2I9mN+RKAx531DqOq3KA7nJhN6
	 YvgOYlIKjEEVav53w7ija/yz37yYFegu+HiTp7BSQEYZawH6UYv65TulKR3UK8X7Uz
	 8wivObSgOVzf2v61x0sqLQWitpxUtmg7/Hb2tKh/XHCQrLMq5qPTsXTHyw84GFCbpg
	 1N4kqKsj2E4CtKObZbf+VsV8HVm88dq8vTDyclwz+q1H+Iyqs3+r/yvGf1XIkCYQr1
	 ZHrcY+uLfvzyQ==
Content-Type: multipart/mixed; boundary="===============2541967855067606124=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2939ac8db314e2befc27036e0611d82c95706e5c73b915addf087825363e3cd0@mail.kernel.org>
In-Reply-To: <885ba23ec2bb641329efdd179a12bca14818384a.1771267122.git.grbell@redhat.com>
References: <885ba23ec2bb641329efdd179a12bca14818384a.1771267122.git.grbell@redhat.com>
Subject: Re: [PATCH bpf-next 1/2] selftests/bpf: fix flaky build_id test
From: bot+bpf-ci@kernel.org
To: grbell@redhat.com,bpf@vger.kernel.org
Cc: andrii@kernel.org,eddyz87@gmail.com,ast@kernel.org,daniel@iogearbox.net,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,grbell@redhat.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 16 Feb 2026 19:48:22 +0000 (UTC)

--===============2541967855067606124==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/uprobe_multi.c b/tools/testing/selftests/bpf/uprobe_multi.c
> index dd38dc68f635..ba0a9dcc7b1a 100644
> --- a/tools/testing/selftests/bpf/uprobe_multi.c
> +++ b/tools/testing/selftests/bpf/uprobe_multi.c
> @@ -100,6 +100,9 @@ int __attribute__((weak)) trigger_uprobe(bool build_id_resident)
>  	int page_sz = sysconf(_SC_PAGESIZE);
>  	void *addr;
>
> +	unsigned char vec[1];
> +    int poll = 0;

This line uses spaces for indentation instead of a tab.

> @@ -108,9 +111,19 @@ int __attribute__((weak)) trigger_uprobe(bool build_id_resident)

[ ... ]

> +	if (!build_id_resident){

Missing a space before the opening brace.

> +        do {

Spaces used for indentation here and on several other lines below
(mincore, the if/break, and usleep).  The rest of the file and the
other lines in this same block use tabs.

> +			madvise(addr, page_sz, MADV_PAGEOUT);
> +			/* check if page has been evicted */
> +            mincore(addr, page_sz, vec);
> +            if (!(vec[0] & 1))
> +                break;

Trailing whitespace at the end of this line.

> +			/* if page is still resident re-attempt MADV_POPULATE_READ/MADV_PAGEOUT */
> +			madvise(addr, page_sz, MADV_POPULATE_READ);
> +			poll++;
> +            usleep(100);
> +		}while (poll < 500);

Should there be a space between the closing brace and "while"?
The usual kernel style is "} while".

> +	}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22075174977

AI-authorship-score: medium
AI-authorship-explanation: Mixed spaces/tabs indentation within the same code block is a common pattern in AI-generated code, though editor misconfiguration could also explain it.
issues-found: 4
issue-severity-score: low
issue-severity-explanation: Coding style violations (mixed tabs/spaces, missing brace spacing, trailing whitespace) in a selftest with no functional or system impact.

--===============2541967855067606124==--
