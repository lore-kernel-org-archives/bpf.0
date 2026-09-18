Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB6C44CF44;
	Fri, 18 Sep 2026 11:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789731500; cv=none; b=uh7bTFiCFKos9sc+yoxArrhcHIKb8FcKcccFOqYaU/camoP79ULvIAkwajOIpRz3u2a/svCLFFak7e7z3FZ57WVoUr6OGckfOo6M8Va3Vp4EoQTzWFrmde5L3ay26trNVHOf0yHuB2nF825zNSIBmEYthHBLV+vyKQi57g/LSTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789731500; c=relaxed/simple;
	bh=QIEQuR8/hNlKk4K8pKZwy0pyo6dcrALLRVIsZOfOLW0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=JhEptSTnFQ3XRk7/CyUBqDafo4oU4me5HzwZMz2bBEzxbNSrU3CvHuIB8ZychKWbas9tRd86mdpciG0IU+PzLdKydQk1xcopJkjr4C1ZLAqO9imCE3F/3lAkSRGjeIQd7H5QaYQ9ruH/EFAvqBhe5Mh6s8iwE2NK2iUH8rxbpCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Et9cxV1X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Et9cxV1X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0B9A1F000FF;
	Fri, 18 Sep 2026 11:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789731499;
	bh=DNtgAMAs7Lp05W7XXAy40ftDRTlYa8cH98i770yONm4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Et9cxV1X6MYHN0LJwaMBRdNAMBciV+/RInJFrqAeurRmiOMU3yr8m74s07Er6/FZU
	 exjQ/9tXXBGLTGq83UKFHBYmfRZ9OURDiI8dl9+hHEPUihhy5tJoBJ3pfWYZ7a4qDy
	 cnqZGUBJ/Q1kmQkSgBeX+8MGnzFckPvuesZs3gCUrtDXpLy+AAKu2UJsEDwuQFEDqY
	 Znw3tgAlngUHd6y2pIZTTeTPHlWerPMVcmmE1WuMGCkGZ4BUNAo18wuoeARjy5eCxM
	 EZy85mJpAo5F9tb1ghvAMF7AL870xQroUQhJ6QaBbFMPzENw+Vp03zvZD823mG5BRE
	 9ObigMsw3jywA==
Content-Type: multipart/mixed; boundary="===============7340898989967843946=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <bb560a0b6748ccfdf1f1f5ba5927b63c57133e5246bcaa61cc35ff2f6b92f480@mail.kernel.org>
In-Reply-To: <20260918102052.1247819-3-sh_def@163.com>
References: <20260918102052.1247819-3-sh_def@163.com>
Subject: Re: [PATCH bpf v2 2/2] bpftool: Fix sparse CPU IDs in prog profile
From: bot+bpf-ci@kernel.org
To: sh_def@163.com,qmo@kernel.org
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,davem@davemloft.net,kuba@kernel.org,horms@kernel.org,sh_def@163.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 18 Sep 2026 11:38:17 +0000 (UTC)

--===============7340898989967843946==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

>     Tested:
>     - Built tools/bpf/bpftool successfully on the host.
>     - Booted an arm64 QEMU guest with a patched virt device tree reporting
>       possible=0,2-3, present=0,2-3, and online=0,2-3.
>     - Ran both pre-fix and fixed bpftool with cycles and instructions against
>       a BTF-enabled fentry target. The pre-fix binary faulted in
>       perf_event_alloc(), while the fixed binary reached perf-event setup and
>       reported failure to create the instructions event on CPU 0. QEMU did
>       not provide a usable hardware PMU runtime result, so no profile counts
>       are claimed.

This isn't a bug, but would it read better to move the Tested: block
below the --- line, or fold it into a shorter sentence, so the changelog
itself stays focused on the sparse-mask problem and the new stride? The
block is the longest section of the message while reporting that the run
did not produce a usable result ("reported failure to create the
instructions event on CPU 0", "QEMU did not provide a usable hardware
PMU runtime result, so no profile counts are claimed").

> diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> index a9f730d407a92..bb969ffce453d 100644
> --- a/tools/bpf/bpftool/prog.c
> +++ b/tools/bpf/bpftool/prog.c

[ ... ]

> @@ -2440,7 +2449,8 @@ static void int_exit(int signo)
>
>  static int do_profile(int argc, char **argv)
>  {
> -	int num_metric, num_cpu, err = -1;
> +	int num_metric, err = -1;
> +	int *cpu_ids = NULL;
>  	struct bpf_program *prog;
>  	unsigned long duration;
>  	char *endptr;

[ ... ]

> @@ -2471,11 +2481,13 @@ static int do_profile(int argc, char **argv)
>  	if (num_metric <= 0)
>  		goto out;
>
> -	num_cpu = libbpf_num_possible_cpus();
> -	if (num_cpu <= 0) {
> +	profile_cpu_cnt = get_possible_cpu_ids(&cpu_ids);
> +	if (profile_cpu_cnt <= 0) {
>  		p_err("failed to identify number of CPUs");
>  		goto out;
>  	}
> +	profile_cpu_ids = cpu_ids;
> +	profile_cpu_id_span = cpu_ids[profile_cpu_cnt - 1] + 1;

This isn't a bug, but could this pass &profile_cpu_ids straight into
get_possible_cpu_ids() and drop the local plus its initializer, since
the helper already clears the output pointer on entry? The local cpu_ids
exists only to be copied into the profile_cpu_ids static on the next
line, and its = NULL initializer is never observed because
get_possible_cpu_ids() unconditionally does *cpu_ids = NULL as its first
statement.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35336124623
--===============7340898989967843946==--
