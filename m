Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75C1380FFB
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 14:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783521789; cv=none; b=higxdDGEI7fbyxXJ9gkbOvr5cYMgFzkpwMPleyHlFKitsKgfJn/rtx/7iFSzNK5S5Sg6l4gG9nJto1Jw2iDbgAw4xX7xuiPAEF8GeGNd7mZdteemTMg2+WCReQtoPg5IY8+3UO6MYU0SpRH6mbWwGVlIJA4EKgBJJeGaVQ4g9A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783521789; c=relaxed/simple;
	bh=ymnWBWxumro+2NtcWxfs5qy7LFZh7dUTwzVbxORLkBg=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Subject:Cc:
	 References:In-Reply-To; b=Oqk6cPk0PW2JXXHPjqW7w6koVacfnM8YVPLMDGrPsDTb4vTDIQqarkvRm3AJhC1dD3Y/u0cKB0YXb8dcSb6jW02k9CX5PgoibJkS7nUb+dgjyKyUJQzY7xY3j6Egf2rfaYWGEkg+InHZSzb7b9f+4rpGV3JvS9c1KBSTZll8mtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=2eT3hB5a; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="2eT3hB5a"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 59D884E40CF6
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 14:43:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2E84460339;
	Wed,  8 Jul 2026 14:43:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6946611BC16F3;
	Wed,  8 Jul 2026 16:43:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783521784; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=cbdjo5BM8A7id1YpQBFnYQBZyhD9xNPDq+ApsXtP7v8=;
	b=2eT3hB5a3mN+UF7QMVHh6IoswloS+G00iwhaAj5yxIW6G8blab0/1BhYR1MUBFxGV9RA1f
	F93O2Mowu3Nvg5rnYGfgeRqp42ummeUbqzXDYxdpCYN42H5ZXezartSBdkb+EiFpgZ0gwQ
	FW7ayjfus/0ZP3IZnNX8l+CkqdQFwmIAPEnruT4o+aLnpVBahHjwUvK9XemVMu8e72dUnF
	WgZbMht/bBlWWkOD8gg/V3ZzeoJEfUzB4B4yr0RjJfIe9gKrxLcLqCgNijy1uk/aD+CMdK
	u7rnFXyZIM9QgAyzsCMaK77fDltlklKylRzIiGU4RieKIAQzQtZeOgoWIcYaXw==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 Jul 2026 16:43:03 +0200
Message-Id: <DJT9PGET5EXB.CS5NIHIHF5B3@bootlin.com>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: <sashiko-reviews@lists.linux.dev>,
 =?utf-8?b?QWxleGlzIExvdGhvcsOpIChlQlBGIEZvdW5kYXRpb24p?=
 <alexis.lothore@bootlin.com>
Subject: Re: [PATCH bpf-next v4 09/10] selftests/bpf: move bpf_jit_harden
 helper into testing_helpers
Cc: <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260708-kasan-v4-0-d5c177ab8227@bootlin.com>
 <20260708-kasan-v4-9-d5c177ab8227@bootlin.com>
 <20260708081638.D12501F000E9@smtp.kernel.org>
In-Reply-To: <20260708081638.D12501F000E9@smtp.kernel.org>
X-Last-TLS-Session-Version: TLSv1.3

On Wed Jul 8, 2026 at 10:16 AM CEST, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] The refactored `set_bpf_jit_harden` function has been moved to=
 a common helper file and stripped of its internal `ASSERT_FAIL` calls. How=
ever, its usage in the cleanup path of `check_blindness()` was not updated =
to check the return value. Consequently, if restoring the sysctl fails duri=
ng cleanup, the test will silently leave the system-wide `bpf_jit_harden` c=
onfiguration in an altered state.
> --
>
> --- Patch [9]: [PATCH bpf-next v4 09/10] selftests/bpf: move bpf_jit_hard=
en helper into testing_helpers ---
> commit 806a4cb4e9c458805fd71ac7ae0f57e00e8af6bc
> Author: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@bootlin.com=
>
>
> selftests/bpf: move bpf_jit_harden helper into testing_helpers
>
> Move set_bpf_jit_harden to testing helpers so that other selftests can
> change the hardening configuration without re-implementing a helper.
>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c b/t=
ools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
>> index 0222a9a5d0761..37c405fc2b0d2 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
>> @@ -227,42 +227,6 @@ static void check_incorrect_index(void)
>>  	check_mid_insn_index();
>>  }
>> =20
>> -static int set_bpf_jit_harden(char *level)
>> -{
>> -	char old_level;
>> -	int err =3D -1;
>> -	int fd =3D -1;
>> -
>> -	fd =3D open("/proc/sys/net/core/bpf_jit_harden", O_RDWR | O_NONBLOCK);
>> -	if (fd < 0) {
>> -		ASSERT_FAIL("open .../bpf_jit_harden returned %d (errno=3D%d)", fd, e=
rrno);
>> -		return -1;
>> -	}
>
> [Severity: Medium]
> Since this function's internal ASSERT_FAIL() calls were removed when movi=
ng it
> to testing_helpers.c, are we missing an error check in the cleanup path o=
f
> check_blindness() where it restores the sysctl?
>
> tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c:check_blindness()=
 {
>     ...
> cleanup:
>     /* restore the old one */
>     if (bpf_jit_harden !=3D '@')
>         set_bpf_jit_harden(&bpf_jit_harden);
>     ...
> }
>
> If restoring the sysctl fails during cleanup, this will silently leave th=
e
> system-wide bpf_jit_harden configuration in an altered state. Should the =
return
> value of set_bpf_jit_harden() in the cleanup path be checked and asserted=
?

I guess I can add an extra ASSERT_OK in the cleanup path to at least get
a log if the setting restore fails.

Alexis

--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

