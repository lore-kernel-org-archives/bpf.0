Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3287C3B14A5
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 18:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783362743; cv=none; b=haMaZg+Ri258mlJ0LLDjZm+MmabQCpnBcXILtUbKsVuAUtT4kcUnvRbrkM7e91VDnx6ZtJ+kY10GjxaXxV7vQwscAXmaHhSHx2d33NyysXgWxtgwZNUcyCBKOHFQsmccrWBUEY7DcpWyvm4mY+t0NR2ng2HTdLopBcMcnoSfaAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783362743; c=relaxed/simple;
	bh=MAxD6Z933c52eM9gAA+LFQlAFbeieFsLP70PzEkb0DE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LUpi5kKCIcw1H4+7pdy/ocimb0IMVjeWaL5bkvUWte6G216/SXjbt/p2ha7BEa4HZYlsZkAGofnCPw8UhYVu63YXZSxHhQTK5CnFz9HO0BVRhs24xDh40TI6FVFcB01QV1cuYZMOXV4l69egELXr/u/t2tOiOogZO64i2VBE0pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MdjNf0av; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MdjNf0av"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8548F1F000E9;
	Mon,  6 Jul 2026 18:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783362741;
	bh=Mg71YAeLUMe9ywm//QOpX7gL4ZqVh7qX4GrG1w0h7yI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MdjNf0avktNiWuzEElb7ucBGo9sY1MWGqLhrUo9/kJF0GEUWRtk5BK62uf7cljIY7
	 S2bgc6GJ+hOGQMetWlFteulJDbXdFTfDmF+1OjxCZVcLX5KVdFgyYwK0ogFo9VxUKM
	 Qf/hTpKXIfdFfWkLK0TsTt/w2urk6fTe2XuQtT8YnUW5ISPEWvjfEbyqb0Nz6ijPQP
	 Ms3Ji4FsXb3N9iVH7h1xYYorbYjd2gY8ASSFoxE3hj0ikHi9LM612AI7VfPqV3SHq3
	 ygFP+ok/LfSYUFKSFhesXV1syU5N0McqH/VX5xG1iDD72adl8ddyw8Sutg1smJuKa3
	 euxsMW1poaH7Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND bpf-next v3 6/6] selftests/bpf: libarena: Add
 parallel bitmap selftest
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emil Tsalapatis" <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260706181730.21731-7-emil@etsalapatis.com>
References: <20260706181730.21731-1-emil@etsalapatis.com>
 <20260706181730.21731-7-emil@etsalapatis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 18:32:21 +0000
Message-Id: <20260706183221.8548F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Spurious test failure due to BPF instruction budget exhaustion d=
uring atomic operation retries
--

commit 03c6a4c41937c3d9d257316bef5f1cacfa40aa71
Author: Emil Tsalapatis <emil@etsalapatis.com>

selftests/bpf: libarena: Add parallel bitmap selftest
   =20
This commit introduces a new selftest for the libarena atomic bitmap
operations. It spawns two threads that concurrently modify even and odd
bits to verify that operations do not improperly affect adjacent bits.

> diff --git a/tools/testing/selftests/bpf/libarena/selftests/test_parallel=
_bitmap.bpf.c b/tools/testing/selftests/bpf/libarena/selftests/test_paralle=
l_bitmap.bpf.c
> new file mode 100644
> index 0000000000000..eec2871e2b0d1
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/libarena/selftests/test_parallel_bitmap=
.bpf.c

[ ... ]

> +__weak
> +int bitmap_test_bit_sequence(u32 bit)
> +{

[ ... ]

> +	if (bmp_test_and_clear_bit(bit, bitmap))
> +		return -EINVAL;
> +
> +	bmp_set_bit(bit, bitmap);
> +	if (!bmp_test_bit(bit, bitmap))
> +		return -EINVAL;

[Severity: Medium]
Will this test fail spuriously if the BPF loop budget is exhausted during
the atomic operation retries?

The test executes a high number of iterations to intentionally run until
the BPF loop budget (can_loop) is exhausted.

Because the two threads heavily contend on the same bitmap words, cmpxchg
operations in helpers like bmp_set_bit can frequently fail and retry.

If the budget runs out precisely during a retry inside bmp_set_bit, the
helper will exit early without performing the atomic operation. This
function then unconditionally asserts the outcome by checking bmp_test_bit.

Since the bit was never set, this will fail and abort the test with
-EINVAL, rather than cleanly terminating due to budget exhaustion.

> +
> +	bmp_clear_bit(bit, bitmap);
> +	if (bmp_test_bit(bit, bitmap))
> +		return -EINVAL;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706181730.2173=
1-1-emil@etsalapatis.com?part=3D6
