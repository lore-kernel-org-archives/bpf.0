Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41C51ACED5
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 02:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791512022; cv=none; b=fYjojFpOuAjWhW+IW5Grvdgds796TLNUa5NU5T8LH37LjxZYFlbvYBux9RNxQhG2CFpHX8SEp+o9kFlultoqFbC6lK5sskYCBa2cSAy2cnkxbEWTkEoE0O3C2tDVK3eySfLo16MVEeAVO93JRecuWFcIk5ptIJS9S+86K7k3ndA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791512022; c=relaxed/simple;
	bh=KIUe9EaYGEvu33yY/1sNzuyHV+d50uA5AKrc5ooyGfA=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=bDkZyaYwLQEl+MFJ/bw/O32p5DlPZX4qF2R74YuqQxxVWp7416xqrBCQi6j+yseKqCp1bzLSxQ16rNNP58DF+qjV3yf3IDlC06tbslS9Q8T10Qh9sPgUz6FJYSF2uR8TPUVnGNG22+kHh+RDZGTe95ZApAfhZ4PU2/Fiv4V6/yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HuwGv2t2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HuwGv2t2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41AAC1F000FF;
	Fri,  9 Oct 2026 02:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791512021;
	bh=aexn86OEGS0Njo2cVXQH6bp258Pqy0I6kkkvMtm4MAc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HuwGv2t24E3w+JU0MxaFytvZP02JT/ccnAxWMLee4Rcf2YAqHnWOTrJccVwJy9zA0
	 PLMJCzlMRlrAF1OMa1VFkYkZNfQA6VtjK1/roU7jS/u4poosCmEi9HOZo0pnvruHbA
	 lVU2u3VYOncsvQYMY+JQaFWU2mrR8bPEXwTZgzrKksSUH1moVenP4Q+2pKj4S5wH6V
	 s0SrlyeoQcGeqNEZI1nAjfzONGeedkdXtCwrdkgYiLWrP0TYyruXPHYvPcBtvzj5gy
	 4M1ha5bZcgLLrXVOz3w1RUEkq9R3SuaCW/iZa+ZU5S4M3KG4Cy56FojHajwDRw7DIn
	 73hvqa832mSjA==
Message-ID: <sashiko-outbox-164721@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Run the enable_stats program
 with BPF_PROG_TEST_RUN
Reply-To: sashiko-reviews@lists.linux.dev
To: "Qiliang Yuan" <odys.yuan@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261009-selftests-bpf-enable-stats-inflight-v2-1-691ee379e511@gmail.com>
References: <20261009-selftests-bpf-enable-stats-inflight-v2-1-691ee379e511@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 02:13:40 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] bpf: selftests: use of deprecated CHECK macro instead of ASSERT_*
--

commit 2195ab7af2e709db01f39a1419b8eb0dd3b3c741
Author: Qiliang Yuan <odys.yuan@gmail.com>

selftests/bpf: Run the enable_stats program with BPF_PROG_TEST_RUN
   =20
This commit changes the test_enable_stats test to run its program with
BPF_PROG_TEST_RUN rather than attaching it to sys_enter. This ensures that
counts are final and avoids race conditions with parallel tests.

Link: https://lore.kernel.org/r/20261008-selftests-bpf-enable-stats-infligh=
t-v1-1-0cb92ee2c6d3@gmail.com

> diff --git a/tools/testing/selftests/bpf/prog_tests/enable_stats.c b/tool=
s/testing/selftests/bpf/prog_tests/enable_stats.c
> index 75f85d0fe74a4..691a82a4d6d20 100644
> --- a/tools/testing/selftests/bpf/prog_tests/enable_stats.c
> +++ b/tools/testing/selftests/bpf/prog_tests/enable_stats.c
[ ... ]
> @@ -20,18 +21,23 @@ void test_enable_stats(void)
[ ... ]
> +	do {
> +		err =3D bpf_prog_test_run_opts(prog_fd, &topts);
> +		if (err)
> +			break;
> +
> +		memset(&info, 0, info_len);
> +		err =3D bpf_prog_get_info_by_fd(prog_fd, &info, &info_len);
> +	} while (!err && info.run_cnt && !info.run_time_ns);
> +	if (CHECK(err, "run_and_get_prog_info", "err %d\n", err))

[Severity: Low]
Does this newly added error path use the deprecated CHECK() macro? The BPF
subsystem selftest guidelines prefer using modern assertions like ASSERT_OK=
()
for new code instead of CHECK().

>  		goto cleanup;

[Severity: Low]
This problem wasn't introduced by this patch, but while updating the
test_enable_stats() logic, would it be worth migrating the existing
CHECK(info.run_cnt !=3D skel->bss->count, ...) to a modern assertion like
ASSERT_NEQ() to help reduce technical debt?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-selftests-=
bpf-enable-stats-inflight-v2-1-691ee379e511@gmail.com?part=3D1
