Received: from mta0.migadu.com (out-153.mta0.migadu.com [91.218.175.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC7550277F
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 13:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789738608; cv=none; b=Xxb+h5QAAQ6ElU8mCKnBuwWY7he2rWWbLNqSdU0CasdSBVqU60m+ToL+AJymAfXiDKpwLHcklPKBtsfdn+HAuunyCGGoRhWtL8GGWTdCIkaBe76vV/uQGbZqx2ywoSp3Xl3JSMhPwwGo9xn0/1brZQUGyKGuK/83tTWzYolUOy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789738608; c=relaxed/simple;
	bh=/RJxtpnY3VFIjvsJUYAM2o2Owc7T+CeSxdmnbQ2prls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=clb0VTgOa+UhZ3FqZ4pS5D+SXBKCPveTnsyL1oyLwsu8PUAK8xqAs3B/U7dS+W6cw8ZD45xA0kzP5xCHU62o4AJuTjy6UMCVLIYmPpL+xxPH5qfoPeXr5OjAJSibOGeMCNEkky8yjlHjYgY/2j1q971vHQG/O3vr1g9D72KdSRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xt1SxfDO; arc=none smtp.client-ip=91.218.175.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xt1SxfDO"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=/RJxtpnY3VFIjvsJUYAM2o2Owc7T+CeSxdmnbQ2prls=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789738604; v=1; x=1790343404;
 b=xt1SxfDOYrRyXZL3fDSqb/F3T7SjaagMgXBuuO2vIuhBTaP+fl6tLL9ZOsmdaS+PlMhMm5CV
 IRURWDKn4kW9StxNaHLg5bCCJU33/FMk3qrbJmSxjINPmIjKnVb20vkPpFruNNcYZDotQnOgzlH
 W0OcTUhx/e8G/F/Z1QtlLIYM=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id bdf97a7d395ac53b;
	Fri, 18 Sep 2026 13:36:44 +0000
X-Mizu-Trace-ID: bdf97a7d395ac53b
X-Migadu-Flow: FLOW_OUT
Message-ID: <908dd7ec-1d03-4d2f-814b-9e1c67f337b2@linux.dev>
Date: Fri, 18 Sep 2026 21:36:37 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 3/3] selftests/bpf: Add iter subtest using
 lskel in global_data_init
To: bot+bpf-ci@kernel.org, tweek@google.com, qmo@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, shuah@kernel.org, kpsingh@kernel.org, emil@etsalapatis.com
Cc: martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, ihor.solodrai@linux.dev, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 martin.lau@kernel.org, mason@kernel.org
References: <20260918040919.3402577-3-tweek@google.com>
 <b1a854da66d611f079d8ff186b9bf73845ee18b73fac2481ef468a86fc777990@mail.kernel.org>
Content-Language: en-US
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <b1a854da66d611f079d8ff186b9bf73845ee18b73fac2481ef468a86fc777990@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2026/9/18 13:05, bot+bpf-ci@kernel.org wrote:
>> In test_global_percpu_data.c, dump_percpu_data is defined after two
>> non-autoload SEC("?kprobe") programs (verifier_strncmp and
>> verifier_snprintf). If bpftool does not skip non-autoload programs when
>> generating light skeletons, dump_percpu_data.prog_fd is left invalid or
>> unpopulated.
>>
>> Factor out a test_global_percpu_data_iter_fd() helper that operates
>> directly on prog/map file descriptors, and add an iter_lskel subtest to
>> verify that dump_percpu_data is properly loaded and executes correctly
>> when using the light skeleton.
>>
>> Fixes: 4c9241bd731a ("selftests/bpf: Add tests to verify global percpu data")
>> Fixes: 1ed2294b31fc ("selftests/bpf: Test verifier log for global percpu data")
>> Signed-off-by: Thiébaud Weksteen <tweek@google.com>
> 
> Are the Fixes: tags appropriate for this commit? This patch only adds new
> test coverage (a new iter_lskel subtest) and refactors existing test code
> (factoring out test_global_percpu_data_iter_fd() with no behavioral change
> to the existing "iter" subtest). It doesn't fix anything that
> 4c9241bd731a or 1ed2294b31fc got wrong.
> 
> The bug being tested is in bpftool, introduced by d510296d331a
> ("bpftool: Use syscall/loader program in "prog load" and "gen skeleton"
> command.") and actually fixed by the two preceding patches in this series
> (202ee90dee368 and 843762e6f4665), both of which already carry the correct
> Fixes: d510296d331a tag.

Agreed.

The Fixes: tags of this patch can be dropped.

Others lgtm:

Acked-by: Leon Hwang <leon.hwang@linux.dev>

> 
> There's also a backport concern. The Fixes: tags make this patch a
> candidate for AUTOSEL/stable pickup independently of 202ee90dee368 and
> 843762e6f4665. Since this is the last patch of the series, backporting it
> alone would land the new iter_lskel subtest in a tree with the unfixed
> bpftool, where skel->progs.dump_percpu_data.prog_fd is left at 0 and
> bpf_link_create(0, 0, BPF_TRACE_ITER, &opts) fails. The subtest would fail
> by construction.
> 
> Should the Fixes: tags be removed, or if they're intended to be kept,
> should the dependency on the two bpftool patches be stated via
> Cc: <stable@vger.kernel.org> prerequisite lines?
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35306404663

