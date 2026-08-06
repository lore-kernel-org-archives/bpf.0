Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95820230BE9
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 21:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786051062; cv=none; b=CERh56g4E6dsCwrmv6ZNTPyCS8RSSp2hzfMGLThT9WSW/1X4W9HB6aI5OQIwXHO6LIe6pWzLNqiZyOfUQZRnW0gZ8EnEXMSuhLS9CYZEm5GXVk6p607TbXcccAiH8JR6SFF0tyGVjOm+YM5aZjjPEKM4LVofwDl756RYilu6uio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786051062; c=relaxed/simple;
	bh=g2E/BAxnf8LFO9ic8f4vgfoqIXmjGEabkfpOBLIS0EU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Auc/8N056VTFhntE/T+l1WQTBVHq/rhLmzKAWFQVW/lwOiAmJMNHy+CZ2Dr/nnDglqXJxMy8rrn9cmhRLaz207XRZ6/ccjsAGsjnFj/SDxS3Noe8gDtMO1kRJqGOlyqbl8m/r0BRjlROMwTHik2qAEsjiATEWUwDQFnY1fvz6R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gS87q6i2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gS87q6i2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9F851F000E9;
	Thu,  6 Aug 2026 21:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786051061;
	bh=owOUUdqYqvF5CS6VxHRA7pv4T5gHE5lovLvhYY7rd58=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gS87q6i2DHxLk8f0jHfbxEUw1PCn1abPS1lXUw0MzziShbPQB9NzFU5Df76Yi7VNW
	 gCfj+aYfXySgoGWrkJDM+qWAPC85wFbwqUEcyNiynfrqNP9BvuMV255qlVYJ8sn+/6
	 4prMrMQDe7zGPeELSqWtRj4MjJHHdytmS88PkXVAGIEzvUkUyk4HDzJCoPbNpReilk
	 rkpzsIjoYsC/hMeVKcjkgPVRCmyUOvRKjn0ljP1PIEXs+/P6jXCH0zqhDOL2mlG4Em
	 qJfwr4GPNdgOPTC7Zb++uFhhWSsKXwkyDPEHDcLChh9M1u44StH5ILhJrTpKEJQJ8s
	 1/691e8W9TUiw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next] selftests/bpf: Sanitize traffic monitor log
 file names
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vineet Gupta" <vineet.gupta@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260806211105.3307932-1-vineet.gupta@linux.dev>
References: <20260806211105.3307932-1-vineet.gupta@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 21:17:40 +0000
Message-Id: <20260806211740.E9F851F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The backslash character `\` is missing from the sanitization str=
ing, leaving artifact names vulnerable to rejection by GitHub Actions.
- [Low] The newly introduced multi-line comment violates the BPF subsystem'=
s strict comment style guidelines.
--

--- Patch [1]: [PATCH bpf-next] selftests/bpf: Sanitize traffic monitor log=
 file names ---
commit 4eb40c6024aab5f28e7a52af3fba116cbdeff427
Author: Vineet Gupta <vineet.gupta@linux.dev>

selftests/bpf: Sanitize traffic monitor log file names

The traffic monitor names its capture logs after the test and subtest
being run, replacing '/' and ' ' so the result is usable as a file name.
This patch replaces the whole set of awkward characters in one pass to
fix artifact upload failures in CI systems like GitHub Actions.

Link: https://github.com/kernel-patches/vmtest/actions/runs/30710914503/job=
/91399011388 [1]

> diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testin=
g/selftests/bpf/network_helpers.c
> index db935a9d9fc1a..3818cec354a0d 100644
> --- a/tools/testing/selftests/bpf/network_helpers.c
> +++ b/tools/testing/selftests/bpf/network_helpers.c
> @@ -1142,10 +1142,13 @@ static void encode_test_name(char *buf, size_t le=
n, const char *test_name, const
>  		snprintf(buf, len, "%s__%s", test_name, subtest_name);
>  	else
>  		snprintf(buf, len, "%s", test_name);
> -	while ((p =3D strchr(buf, '/')))
> -		*p =3D '_';
> -	while ((p =3D strchr(buf, ' ')))
> -		*p =3D '_';
> +	/* Test names are free form, so replace anything that is awkward in a
> +	 * file name. Besides the path separator, this covers the characters
> +	 * rejected by CI systems collecting these logs as artifacts.
> +	 */

[Severity: Low]
This isn't a bug, but does this multi-line comment in encode_test_name()
conflict with the BPF subsystem's comment style guidelines? The opening /*
is typically expected to be placed on its own line.

> +	for (p =3D buf; *p; p++)
> +		if (strchr("/ \":<>|*?\r\n", *p))

[Severity: Medium]
Since this is meant to cover characters rejected by CI systems like GitHub
Actions, should the backslash character '\\' also be included in this
sanitization string?

If a test or subtest name contains a backslash, it appears the artifact
upload could still fail.

> +			*p =3D '_';
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806211105.3307=
932-1-vineet.gupta@linux.dev?part=3D1
