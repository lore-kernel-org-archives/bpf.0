Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9493847ECDD;
	Wed, 22 Jul 2026 08:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784709946; cv=none; b=aNIbbiChzpQO1VgsF1kPuRG37PT97vWuqBDa+MwtZj6Q5sTbX0J/iXvGqD7DHcU9fwzyg72xI//c1Nr2iC+7jfAo+AHxBwYGc0XcyQw2r3gmOg/wih49Xj//qC4X3r3gJnLJlLwz8+NZhduKeYdlKO7OZRIfVB3UMOfptIUVMgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784709946; c=relaxed/simple;
	bh=5ULAb2m0awtWkMFXN+xQW//8SQYKQwCd08pzRR2DNrc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=jrYEsebGzODrC1mw2ujVohPcXNCXJjlVR4piEeHA6ZF5n4zTiAWSusHOtkAiMZ8w2vaTQqgni4y++3jAlBtKDp/qJDFxv2r7ORTbYjDLaIFrZcC/GvN/4b9774QoeFuYqGqNwKNpTXdWe8ELImQaTJ235qqveeU6S9FtikEgvBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eK3F+9ub; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eK3F+9ub"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1C0B1F000E9;
	Wed, 22 Jul 2026 08:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784709945;
	bh=0dN+24EZvAaO42g3z957QDx052/jYm4hXhNAAPcjKZk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=eK3F+9ubCLK81wTjP3sLM5Vm/h1vxzxnW3OWQOkZCbQhvQWsFJGYeXTDVJgQ6nVgz
	 OPPeUK81Csj4H9xSb0tUNjzRsea05trsRjfrjuPnq8fxwuIqc+5DoZ2QGE8GanMb5q
	 EGWynhtkRnZRVmDF7WHeD5K8YLYKMmJyvgVXVT7XzRNv7qidyAydkPOQ1jpLk8BWIC
	 hf6mV8ht4bet+GRDhQ3TGnX6EXGqxMTcgPq/JHBotHchnY5zsW9jROeeMxuqFdsfet
	 DTtHKA2XpzIBnL7++SpT4rogocyN4j2judr2vvZT3PP9ftuK70ouChnTDfHd0bx4Qp
	 4Ljwg8WGqh5MA==
Content-Type: multipart/mixed; boundary="===============7011108477878885915=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6c06c31fa22bf40aa0e9d28ed5ffe58232c2a9d83280f096341de44ca236d1a7@mail.kernel.org>
In-Reply-To: <20260722074748.674080-3-yangfeng59949@163.com>
References: <20260722074748.674080-3-yangfeng59949@163.com>
Subject: Re: [PATCH v2 bpf-next 2/5] selftests/bpf: Fix missing allocation null checks in test_progs.c
From: bot+bpf-ci@kernel.org
To: yangfeng59949@163.com,andrii@kernel.org,eddyz87@gmail.com,ast@kernel.org,daniel@iogearbox.net,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com
Cc: bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 22 Jul 2026 08:45:43 +0000 (UTC)

--===============7011108477878885915==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

>     selftests/bpf: Fix missing allocation null checks in test_progs.c
>
>     Add null checks after memory allocations to prevent potential segmentation faults.
>
>     Signed-off-by: Feng Yang <yangfeng@kylinos.cn>

This looks like a bug fix, but there is no Fixes: tag.  Most of the
corrected allocation sites (dispatcher_threads, data, and
env.worker_current_test in server_main(), and env.worker_pids and
env.worker_socks in main()) were added without null checks when the
parallel worker infrastructure went in.  Should this carry:

  Fixes: 91b2c0afd00c ("selftests/bpf: Add parallelism to test_progs")

The change also touches two allocation sites from other commits, the
val_buf1/val_buf2 checks in compare_stack_ips() and the
state->subtest_states check in dispatch_thread_send_subtests(), so more
than one Fixes: tag may be warranted, but 91b2c0afd00c covers the bulk
of the change.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/29903681308
--===============7011108477878885915==--
