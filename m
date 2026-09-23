Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF61035201E;
	Wed, 23 Sep 2026 01:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790126880; cv=none; b=tWj70VZtJ32vfd8aWo1GI3clptjcQLvUhi+dh5QEdAhaKjhV6QjcJ5LDem94XwCZsEKxGOZeBBVvzcvdsff6yX9rlZ7jj8wigK2vIaeyj7RlccYuctGTAv05QVrCml7kEhDUyF/7yeG+092HZ00N+SrXfJt8Fp+7yb+Jh7b2qWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790126880; c=relaxed/simple;
	bh=WKcoTnwMJFiFv+GpNXt4XtPv6Oatkbi6NTanAKwNOGY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=jkTx83qG7VElGu/U7IH0oLevEzfp+tpuB5J5bBJU4CZQJjHCSrGDxqeHMd/CaYgTiiziD0D3n0K9Npues3T8S5mOC16QbdYlB4lTjhF7arOC6adJmyHqkG7sWrtJoUCInYCSpKQ8p6eyht09+6CVgwYP2Qvu7uvnhctmpXnrC10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jZR0OVn3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZR0OVn3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94AB31F000FF;
	Wed, 23 Sep 2026 01:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790126878;
	bh=vtTioKgjHBGaolMLsnfiP8LN2ht5fmSkFnpoSB2RmW0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=jZR0OVn39v7qAw8XLTzpHzegyFJvJflLoJJr+315bWpioWos+n3jSqMhCd/p+1yB6
	 WyN457BgC4SdLulZVvIuqtyy5jaKECIdGshXms16SR/BwI8j9J69Lvw/Jy0n2WYRwg
	 d91qvS7/DSY2N7Gk7+L8Sg4L7BtlwH8bbgllbBgKlKvX1WC2BX2ZO+xaGCG1+WJrzf
	 yAMtSZhXzhC/S98SbiQaVuTIv5cUHPXUzMNqy6nev8W64L980c693Ilk/f6wqccVFk
	 Rw7EqAu1di70FIJoEvbEWNUEPZg7Iw7/pacVFWgBnsETdBZ7f0b17NAYwBadZ3fUHO
	 z7KSyzVQvl20w==
Content-Type: multipart/mixed; boundary="===============0936865111618100228=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9552c77f5b41d3ad38b9b65ad54e5153cb959725cdf2bd19097e0021b970df5a@mail.kernel.org>
In-Reply-To: <20260923004243.969919-3-sh_def@163.com>
References: <20260923004243.969919-3-sh_def@163.com>
Subject: Re: [PATCH bpf-next v3 2/2] bpftool: Fix sparse CPU IDs in prog profile
From: bot+bpf-ci@kernel.org
To: sh_def@163.com,bpf@vger.kernel.org
Cc: qmo@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,linux-kernel@vger.kernel.org,sh_def@163.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 23 Sep 2026 01:27:56 +0000 (UTC)

--===============0936865111618100228==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> index 000774835b10..24e40dfab469 100644
> --- a/tools/bpf/bpftool/prog.c
> +++ b/tools/bpf/bpftool/prog.c

[ ... ]

> @@ -2394,6 +2397,7 @@ static void profile_close_perf_events(void)
>  		close(profile_perf_events[i]);
>
>  	free(profile_perf_events);
> +	profile_perf_events = NULL;
>  	profile_perf_event_cnt = 0;
>  }

This isn't a bug, but is the new 'profile_perf_events = NULL;' needed
for the sparse-CPU fix, or would it read better as its own patch (or at
least a changelog line), since the rest of the hunk set is about CPU
IDs?

[ ... ]

> @@ -2486,6 +2491,10 @@ static int profile_print_and_cleanup(void)
>
>  	close(profile_tgt_fd);
>  	free(profile_tgt_name);
> +	free(profile_cpu_ids);
> +	profile_cpu_ids = NULL;
> +	profile_cpu_cnt = 0;
> +	profile_cpu_id_span = 0;
>  	return err;
>  }

[ ... ]

> @@ -2589,6 +2600,10 @@ static int do_profile(int argc, char **argv)
>  		profiler_bpf__destroy(profile_obj);
>  	close(profile_tgt_fd);
>  	free(profile_tgt_name);
> +	free(profile_cpu_ids);
> +	profile_cpu_ids = NULL;
> +	profile_cpu_cnt = 0;
> +	profile_cpu_id_span = 0;
>  	return err;
>  }

This isn't a bug, but could the 'profile_cpu_cnt = 0' /
'profile_cpu_id_span = 0' stores be dropped, given nothing reads them
after either return and the adjacent statics (profile_tgt_name,
profile_obj) are left alone?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35804155043
--===============0936865111618100228==--
