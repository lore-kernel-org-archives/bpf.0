Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81A43AAF5F;
	Mon, 31 Aug 2026 11:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788176898; cv=none; b=BSscMLI4vXf+od8KnQ0kk1fVQNxAFc5yBWe+6mrtzmUP3PoBUNktw7nuCfg7+BGn3QpAoJ16VBkOD5r5tUFEGHUEXDFHF+zh9WAP2O+u/HhXIsNsV43jMRaFB418R0/TkNCyMLu4qgRCdGyJMIrhRPMOX8w9IlXHcEfhmMDIC88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788176898; c=relaxed/simple;
	bh=nAsKj7RDFagUb9c54TOrB72tNP37+TItHxmHnwLjhwA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=scGGVt7roWEEoSyS8zREezOCF09sFdMD4uNUrqVkGVaH4E+orOkeM2++84iOF+eoV0JkhUZ9gZA2mFT0Qv+rcZ238kHEAMYCUcLtzd7oRWfZ2467Z8UH7MQnXfr3tPAHP2C3UGXLJOCMbUHZGIM2HdxaRlINEVzIMEMhWxO5UQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mIx1QBU0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mIx1QBU0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 654881F000E9;
	Mon, 31 Aug 2026 11:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788176896;
	bh=8cPGrdC5iQSukZPvGkaUA/Tt//q9nwqGNfvO10ofzmg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=mIx1QBU0cgDpz6lJ7dfTz3V0gK2HllBGDnwiO4OoelgjZqJQm8xDuXtxtK7BRU68D
	 szUt/noLW8PFa1rmFoXns7Nn0cr69wJ3xWwLeExutoykzAXaXbTIjK57c1FPBbfFKe
	 DvUvZksKzYoYHVPz8rxBTbFug3w/xVElJ6zSwWTm7wCskX2AvNniEBKVBf293wVSqt
	 Q+C54k4ma1Lh3pSg8ineI5Yo9SblZ2Gxj4FZSwS3m/QZVS/lHoLPbwbo/UQsqdFf8X
	 JpDf8EJwLsIRAcyG0h0aJj7+MwRC4ZgClj7luzQfJ9Phc4nV+BsE9Y3iADujmnry69
	 /ojE0UesOOFwQ==
Content-Type: multipart/mixed; boundary="===============2535200794614647358=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8b93223f148b0771b79336d636e7b6ddff030ffd2b3ffb264a51af6082149c01@mail.kernel.org>
In-Reply-To: <20260831110314.150870-5-jiayuan.chen@linux.dev>
References: <20260831110314.150870-5-jiayuan.chen@linux.dev>
Subject: Re: [PATCH bpf v3 4/5] selftests/bpf: Add test for key-less BTF hash map
From: bot+bpf-ci@kernel.org
To: jiayuan.chen@linux.dev,bpf@vger.kernel.org
Cc: jiayuan.chen@linux.dev,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,shuah@kernel.org,yatsenko@meta.com,alan.maguire@oracle.com,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 31 Aug 2026 11:48:15 +0000 (UTC)

--===============2535200794614647358==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_map_keyless.c b/tools/testing/selftests/bpf/prog_tests/btf_map_keyless.c
> new file mode 100644
> index 0000000000000..a7d037f57a7ef
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/btf_map_keyless.c
> @@ -0,0 +1,82 @@

[ ... ]

> +	/*
> +	 * Positive control: the same map with a real key type must be accepted,
> +	 * so the -EINVAL below is about the key-less BTF and not some unrelated
> +	 * rejection (e.g. an unknown map type).
> +	 */
> +	opts.btf_key_type_id = val_id;
> +	map_fd = bpf_map_create(map_type, "keyed_map", 4, 4, 8, &opts);
> +	if (!ASSERT_GE(map_fd, 0, "keyed create is accepted"))
> +		return;
> +	close(map_fd);

A subsystem pattern flags this as potentially concerning: the positive
control turns "this kernel does not implement the map type" into a hard test
failure instead of a skip.

BPF_MAP_TYPE_RHASH (used by the rhash subtest) is new; on any kernel that
lacks it, map_create() rejects the unknown map type and this ASSERT_GE fails,
reporting a red btf_map_keyless/rhash that has nothing to do with the
behaviour under test.

libbpf already provides the probe for this: libbpf_probe_bpf_map_type()
handles BPF_MAP_TYPE_RHASH explicitly (tools/lib/bpf/libbpf_probes.c:312,
including the BPF_F_NO_PREALLOC requirement), so the subtest could probe
and test__skip() with a reason instead.

Two arguments in the patch's favour: (a) an unknown map type is rejected with
-EINVAL, not EOPNOTSUPP/ENOSYS, so the errno match isn't literal; (b) the
comment on lines 26-30 shows the failure is deliberate - the author wants an
unrelated rejection to surface as a failed positive control rather than be
silently swallowed by the -EINVAL assertion below.

Both arguments are about the choice of signal, not about whether an absent map
type is a capability-absent condition, which it is. Does the current approach
fit the test's intent better than probing and skipping?

[ ... ]

> +	if (test__start_subtest("hash"))
> +		check_keyless(BPF_MAP_TYPE_HASH, 0, btf_fd, val_id);
> +	if (test__start_subtest("rhash"))
> +		check_keyless(BPF_MAP_TYPE_RHASH, BPF_F_NO_PREALLOC, btf_fd, val_id);


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33385673160
--===============2535200794614647358==--
