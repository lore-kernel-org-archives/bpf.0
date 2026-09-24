Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA9746AA97;
	Thu, 24 Sep 2026 16:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790268965; cv=none; b=ofJbEVi9Vh2kMnLfPnuZ4u+1pIFm26o6XkXGbdwHkLAHUqcIiDh1rwFMJGmk8rdPBOVwNbxjTqHbwNvxHKrwW7eDGLh0dhHhLd/akoOEoirfu3VZ8LiqArb7bh1Z8rN2WQzDTgz2VeNU4A6rF/Yd4XRLhaMDGkv+iFeEOWQutt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790268965; c=relaxed/simple;
	bh=PjfJ0ue0L/Fwv2lfDHNCKePCnYI7bDrPSAwvuunf03Y=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=I5uBvfge1SeH2yh04CgDz4nRu7R3x6elRIAGLFGRU4aDY63Z7G8b3koSnPWTjICgs7auL57fpkMJTlzKUsQJlDdiCuCdISftyb3IVPk9AzrUjNPfS90mJgt3gcgHnVxfzWEr+UGLSCUMCv5Gb53ac1wnrDT6AEfOUWbs+wRVcP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C3V8L7/u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C3V8L7/u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30F171F000FF;
	Thu, 24 Sep 2026 16:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790268964;
	bh=2e1H4luwvM5uVJfFVg3YVPz7E6wyzsE2titR7H0JxM4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=C3V8L7/uZBReeF0DAR5Sf1FR1yWh4Y7n5NAmFjRjUEmMQ9O8ffJGKbyckkUMxaUhe
	 7dmYJdDwKu9k8kHCQXGuakv27vH1n4cmTcEGPojlmHwpv365wqqM1inFoqHD7mXSB1
	 WgAinQSq9FW3kwmwVxjxCYRGVU0JCB7o1ZVjQMSAJ+6lZeu1K82UJJ1JT082rBNPkZ
	 Bg5IUzukECZRTV55elQYqNpyJBu2zVYe4JEeIptSBJyIT7gwqLmJ+vohwU9NaVIYub
	 YorVTRpR0JC8o1+96JU3kheLRa8Xc2U8A5hcQtERrjiSxvmU2R/i5V9lRySQe6+5sx
	 YJOdVi/g2UQeQ==
Content-Type: multipart/mixed; boundary="===============5472941901154960394=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b5fb457e16a434d457a136a5d9286b1163fccaac99804e0f88a370a1a3b06805@mail.kernel.org>
In-Reply-To: <20260924160732.485650-3-skokovmaksimevg@gmail.com>
References: <20260924160732.485650-3-skokovmaksimevg@gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Check that bpftool reports a map it can't dump
From: bot+bpf-ci@kernel.org
To: skokovmaksimevg@gmail.com,bpf@vger.kernel.org
Cc: qmo@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,kuba@kernel.org,shuah@kernel.org,linux-kselftest@vger.kernel.org,skokovmaksimevg@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 24 Sep 2026 16:56:02 +0000 (UTC)

--===============5472941901154960394==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/bpftool_map_dump.c b/tools/testing/selftests/bpf/prog_tests/bpftool_map_dump.c
> new file mode 100644
> index 000000000000..56283e3f1e60
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/bpftool_map_dump.c

[ ... ]

> +	if (!ASSERT_OK(bpf_obj_pin(map_fd, PIN_PATH), "pin map"))
> +		goto out;
> +
> +	/* Socket storage can not be iterated, so the dump must fail loudly
> +	 * rather than print an empty map that holds an element.
> +	 */

Does this multi-line comment follow the BPF subsystem style? According to
bpf.md, multi-line comments should have the opening /* on its own line:

/*
 * Socket storage cannot be iterated, so the dump must fail loudly
 * rather than print an empty map that holds an element.
 */

Also, "can not" is typically written as "cannot" (one word).

> +	ret = get_bpftool_command_output("-j map dump pinned " PIN_PATH,
> +					 output, sizeof(output));

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36027992199
--===============5472941901154960394==--
