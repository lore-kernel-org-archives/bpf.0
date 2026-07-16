Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590523CA4AB
	for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 15:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784215657; cv=none; b=QQqQbtLmmZy/8Ov9WVsTeneOtyzApwacQjH03bXm2LGq2X15kOhifLvUdlVxk2ROL2SKxSfOAvB2xmC3pmvb0XnrKBl9sHoN0cfcn1DaAg8Tj5VIHCMX/dSBF4N5PSP/TlKxCvJwpyinozV9YJpGkUGK2/ARn2QoalBU0JQ1fPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784215657; c=relaxed/simple;
	bh=dgS/tQFfRzvNfjUwJwZ9lkxaDxCsUJGqb2ecu530vsU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IKpnIoO1lTxKcfh4GbY9qWZ7bxskd0W4WhNxlS5sIXP97oq5hEpbrF/dSuUdJdHH00P8ajO8E7A8/sEOcbE5y/1OsvlANf28RKRC/RVQ/FaGtnvT1pOnU4vw8N03+opSJ7AyGc/bWEtQnOMu58m+0vKs7C8siZ5DjIk6sCSe86E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fkRP8Mvg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fkRP8Mvg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBC631F000E9;
	Thu, 16 Jul 2026 15:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784215656;
	bh=8ogGyO/ZDH/4HZ9Pk5RROyNvtknNo6kO+744RQq+i6o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fkRP8Mvg7Sb1nsOWH46JUP6oZ+mlTudOzxuXlI0afbd5cfaEp5oovE+XXzv0mP5yr
	 PnHNb3UY2A1WzBUu6buj9ziFCf7fbhveGjQ19br51vQx8PfKFTvJjFOBlwakEXWx91
	 xEQ/D4HvXbtRk4o+PRgR1ua6OW/8bRCU4cdf9S+wiX1MQigkNib81hFMWMR4YepmVk
	 eHI+zNFPe4rXAOPn7IbTARoPC2Z3ABGQGznQm8YZJrmeQmP00uy4sp2wvEm0gUriFD
	 zaEehW/g8+Q6rbjnISNld9D8ztjpXLcmsPgJBZMPxB+djrpYzoNLS3MouqnvhK2a/U
	 DJqBeueLhgvEQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 2/3] selftests/bpf: Run arena tests serially
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260716142746.8794-2-jiayuan.chen@linux.dev>
References: <20260716142746.8794-1-jiayuan.chen@linux.dev>
 <20260716142746.8794-2-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 15:27:35 +0000
Message-Id: <20260716152735.DBC631F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incomplete serialization of BPF arena tests leaves the CI environm=
ent vulnerable to OOM.
--

--- Patch [2]: [PATCH bpf-next 2/3] selftests/bpf: Run arena tests serially=
 ---
commit 4661bf4c3b39723c6187b74928c316a1e721ac60
Author: Jiayuan Chen <jiayuan.chen@linux.dev>

selftests/bpf: Run arena tests serially

This commit changes several BPF arena tests to run serially to prevent memo=
ry
exhaustion during KASAN builds. By renaming the test functions to start with
serial_test_, the selftests framework ensures at most one arena is alive at=
 a
time.

> Make the arena tests serial so at most one arena is alive at a time.

[Severity: High]
This is a pre-existing issue, but there are other tests that allocate
BPF_MAP_TYPE_ARENA maps which are still running in parallel.

For example, in tools/testing/selftests/bpf/prog_tests/verifier.c:

void test_verifier_arena(void)                { RUN(verifier_arena); }
void test_verifier_arena_large(void)          { RUN(verifier_arena_large); }

In tools/testing/selftests/bpf/prog_tests/stream.c:

void test_stream_success(void)
{
	RUN_TESTS(stream);
	return;
}

In tools/testing/selftests/bpf/prog_tests/compute_live_registers.c:

void test_compute_live_registers(void)
{
	RUN_TESTS(compute_live_registers);
}

Since these remain prefixed with test_ rather than serial_test_, won't they
still run concurrently and potentially exhaust memory on KASAN builds?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716142746.8794=
-1-jiayuan.chen@linux.dev?part=3D2
