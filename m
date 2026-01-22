Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253FE450913;
	Thu, 22 Jan 2026 08:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769069197; cv=none; b=W9nHoo5oCOU4yKYHyMPGxNFisZieg0GC+Lez/Q3H/7cFO1kGRBdnkNeL2tSYHR5dS0zZkeeUZNhlCg9LqiLJPEmsrAMufhpMzzbrTFGYOtWwrrzVIfULcAk5+XnNY3+lU7kNUNfY1ow+aGd/A8iR7xIUdEStb5OcrDMYYe6lfTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769069197; c=relaxed/simple;
	bh=VzuAhwfhV4IpHSRDFDuglHqWjuUAI7nbBi5fqE3Zqng=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=eh1zW41jV1zS4cf/L9JVspOHubTW9KnHFyyORBLjdYzqPV++CNQ9+h7+Ar3DyCXfcAzILvEelM+amqXyTw/XF63tPnlt5OQgkrc772Jt7PCuKeYOkOEq85f7Yj1NBYo83gD1AOqxnYGn9bF+fwmRPwkXBBFOiUCUAfIRS26I/B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gKsexnes; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gKsexnes"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 27EA31A2A0B;
	Thu, 22 Jan 2026 08:06:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E7224606B6;
	Thu, 22 Jan 2026 08:06:30 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 520BF119B0956;
	Thu, 22 Jan 2026 09:06:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769069189; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=l2Ds0/FVi18Z1llnTvx9khlgnYJNwhiqJVrlq2E5f18=;
	b=gKsexnes513VEkcffDW0lQNeCgQoqmix/XoXeNC9oDpdiUrxFdzAPtpjchBTb/tUUtZEbF
	EeiLF68h3VG1bEQ3PzfGf8BXH9GZ1dJaJ34Oa5HZVHfGztFEmeXapEnQDP+7KMDfSEVOvz
	fTWZJaJSfzUvrbS3QVLytv3Uog7I+diUQ7AbT03esHoudSbFZ2naOkUdCZMfu6f4dziS2l
	EQLpWIJliqAVkxT0QxGG/fL/7BlmOeHA1LD8zDwXLNkniNaiWIQP5oI/MWoIDizL6zvPVm
	DD3lY8R+5Z2SbFwdxSU1Nq2R9I2XQWz/5sqq2U/HZJsfcxUy0EX7Cj2nvfLSkg==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 22 Jan 2026 09:06:24 +0100
Message-Id: <DFUYORZLZEX5.T1T4UT063RRM@bootlin.com>
Subject: Re: [PATCH bpf-next v3 2/3] selftests/bpf: convert
 test_bpftool_metadata.sh into test_progs framework
Cc: <ebpf@linuxfoundation.org>, <bastien.curutchet@bootlin.com>,
 <thomas.petazzoni@bootlin.com>, <linux-kernel@vger.kernel.org>,
 <bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <martin.lau@kernel.org>, <clm@meta.com>, <ihor.solodrai@linux.dev>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: <bot+bpf-ci@kernel.org>, <alexis.lothore@bootlin.com>,
 <andrii@kernel.org>, <eddyz87@gmail.com>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <martin.lau@linux.dev>, <song@kernel.org>,
 <yonghong.song@linux.dev>, <john.fastabend@gmail.com>,
 <kpsingh@kernel.org>, <sdf@fomichev.me>, <haoluo@google.com>,
 <jolsa@kernel.org>, <shuah@kernel.org>, <qmo@kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260121-bpftool-tests-v3-2-368632f377e5@bootlin.com>
 <ad4c694cdb5ec78a78956b2b397a6052d4d0ef426eb85769781ce2a0baddf08a@mail.kernel.org>
In-Reply-To: <ad4c694cdb5ec78a78956b2b397a6052d4d0ef426eb85769781ce2a0baddf08a@mail.kernel.org>
X-Last-TLS-Session-Version: TLSv1.3

On Wed Jan 21, 2026 at 9:50 PM CET, bot+bpf-ci wrote:
>> diff --git a/tools/testing/selftests/bpf/prog_tests/bpftool_metadata.c b=
/tools/testing/selftests/bpf/prog_tests/bpftool_metadata.c
>> new file mode 100644
>> index 000000000000..b5598741a01c
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/bpftool_metadata.c
>
> [ ... ]
>
>> +static void run_test(struct test_desc *test)
>> +{
>> +	int ret;
>> +	char cmd[MAX_BPFTOOL_CMD_LEN];
>> +
>> +	ret =3D snprintf(cmd, MAX_BPFTOOL_CMD_LEN, "prog load %s %s",
>> +			test->bpf_prog, test->bpffs_path);
>> +	if (!ASSERT_GT(ret, 0, "format prog insert command"))
>> +		return;
>> +	ret =3D run_bpftool_command(cmd);
>> +	if (!ASSERT_OK(ret, "load program"))
>> +		return;
>> +
>> +	/* Check output with default format */
>> +	ret =3D snprintf(cmd, MAX_BPFTOOL_CMD_LEN, "prog show pinned %s",
>> +		       test->bpffs_path);
>> +	if (!ASSERT_GT(ret, 0, "format pinned prog check command"))
>> +		return;
>> +	ret =3D get_bpftool_command_output(cmd, output,
>> +			MAX_BPFTOOL_OUTPUT_LEN);
>> +	if (ASSERT_OK(ret, "get program info")) {
>> +		ret =3D check_metadata(output, test->expected_output,
>> +				ARRAY_SIZE(test->expected_output));
>> +		ASSERT_OK(ret, "find metadata");
>> +	}
>> +
>> +	/* Check output with json format */
>> +	ret =3D snprintf(cmd, MAX_BPFTOOL_CMD_LEN, "prog -j show pinned %s",
>> +		       test->bpffs_path);
>> +	if (!ASSERT_GT(ret, 0, "format pinned prog check command in json"))
>> +		return;
>> +	ret =3D get_bpftool_command_output(cmd, output,
>> +					 MAX_BPFTOOL_OUTPUT_LEN);
>> +	if (ASSERT_OK(ret, "get program info in json")) {
>> +		ret =3D check_metadata(output, test->expected_output_json,
>> +				ARRAY_SIZE(test->expected_output_json));
>> +		ASSERT_OK(ret, "find metadata in json");
>> +	}
>> +
>> +}
>
> The original shell script also verified the map listing output:
>
>> diff --git a/tools/testing/selftests/bpf/test_bpftool_metadata.sh b/tool=
s/testing/selftests/bpf/test_bpftool_metadata.sh
>> deleted file mode 100755
>> index b5520692f41b..000000000000
>> --- a/tools/testing/selftests/bpf/test_bpftool_metadata.sh
>> +++ /dev/null
>
> [ ... ]
>
>> -bpftool prog --json | grep '"metadata":{"a":"foo","b":1}' > /dev/null
>> -
>> -bpftool map | grep 'metadata.rodata' > /dev/null
>
> [ ... ]
>
>> -bpftool prog --json | grep '"metadata":{"a":"bar","b":2}' > /dev/null
>> -
>> -bpftool map | grep 'metadata.rodata' > /dev/null
>
> Was the "bpftool map | grep 'metadata.rodata'" check intentionally remove=
d
> from the converted test? The original script verified that the metadata m=
ap
> appeared in bpftool's map listing, which tests a different code path than
> the "prog show" commands. If this was dropped on purpose, it might be wor=
th
> a comment explaining why; otherwise this appears to be a test coverage
> regression.
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/212250=
32840

The bot is right, I forgot to port this specific check. That will be
added in the next revision.

Alexis

--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

