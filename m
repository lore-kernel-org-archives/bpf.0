Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73EA367297;
	Sat, 19 Sep 2026 12:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789820755; cv=none; b=hUhAX2V5U9GrvQzz8rTEoDWV+99JvgL4Q0yGhaOVgQO3aXp030sorTUDxo2Si9nHjP0wSfP6OVoikhmhg9PMRWChCUNE5Q4HDwWx1wxDGQ6Tt4pIuEc4CQyfRQxpl211b+xrjaaJsxhzyNjpvG8zxXioKbaXVyCGs8p+gfd9160=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789820755; c=relaxed/simple;
	bh=jAdvaKq2NuRmO6UDKQWMuaXhgF97GXdABGHPPT2jhXE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Xu9JRiyDyKRDlZV9CSn9b+GkvMtbKpusgsp5H3QUX6hXbnweYr4NCwCk3+soHhEag70Q36/8bEH9XyIBH4uMYI4ZbyHoFc2bOy9TWMhJJbyuICdbudyR3A6TCSjtOnO1EbqgeREG1o5gyMtQg+WscIF5mjpOceuXhzSc7yuZc9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iJDqmG2e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJDqmG2e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE74F1F000FF;
	Sat, 19 Sep 2026 12:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789820754;
	bh=gcIIEpm9cUOc46Z54P7LEvi3hmp7FGhZsQ+tISlD4u4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=iJDqmG2eGfdDgIENj9iMtWSULUhztLSBdGRqd+3TzPZwrj85y43SbUV5tNro2f3TA
	 PVIN2gUg1HLmgRT+ey25BvbWkHxxEdcDAj8fT1ZESrfq/aHRUXrwpkVd2JY7R8hqsE
	 yOOPAdqSHQvIUW7wuk6CTxEVsgKC/mffGIP9lgMNRW+w8q4j8ttN2vz+OwDRT/J4rU
	 FqLdwUtkO7OiAgsnvO2z3XbzXKUUVBDYS7gWOInsiS2gcb06GqvA+ujkDnGqaDWcaL
	 5slVSIbeM5D/0WWUQGySdI4jxTZkSYUhaLQzyFP56V+4sl+SpP7wF9IqNA78aeg20n
	 m+I+OCCySmwbw==
Content-Type: multipart/mixed; boundary="===============3856022841713210179=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a89e2e325b87c215e0fb6e4a24284922d7656cfc0e2a247f0c8c1cd823764c23@mail.kernel.org>
In-Reply-To: <20260919110721.1230756-2-hi@tychen.cc>
References: <20260919110721.1230756-2-hi@tychen.cc>
Subject: Re: [PATCH bpf-next v4 1/2] bpftool: Read ring buffer maps with event_pipe
From: bot+bpf-ci@kernel.org
To: hi@tychen.cc,bpf@vger.kernel.org
Cc: qmo@kernel.org,andrii@kernel.org,eddyz87@gmail.com,ihor.solodrai@linux.dev,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat, 19 Sep 2026 12:25:52 +0000 (UTC)

--===============3856022841713210179==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
> index 75cbcb512ebae..1396083c4e67d 100644
> --- a/tools/bpf/bpftool/bash-completion/bpftool
> +++ b/tools/bpf/bpftool/bash-completion/bpftool

[ ... ]

> @@ -878,11 +883,11 @@ _bpftool()
>                          return 0
>                          ;;
>                      id)
> -                        _bpftool_get_map_ids_for_type perf_event_array
> +                        _bpftool_get_map_ids_for_types perf_event_array ringbuf
>                          return 0
>                          ;;
>                      name)
> -                        _bpftool_get_map_names_for_type perf_event_array
> +                        _bpftool_get_map_names_for_types perf_event_array ringbuf
>                          return 0
>                          ;;
>                      cpu)
>                          return 0
>                          ;;
>                      index)
>                          return 0
>                          ;;
>                      *)
>                          _bpftool_once_attr 'cpu index'
>                          return 0
>                          ;;

The event_pipe completion now offers ring buffer maps for the 'id' and
'name' cases, but the fallthrough '*' branch still suggests 'cpu index'
via _bpftool_once_attr. Can this cause tab-completion to offer
cpu/index keywords after a ring buffer map identifier?

Looking at do_event_pipe() in map_perf_ring.c:

    if (map_info.type == BPF_MAP_TYPE_RINGBUF && argc &&
        (is_prefix(*argv, "cpu") || is_prefix(*argv, "index"))) {
            p_err("ring buffer maps do not support cpu or index arguments");

the command explicitly rejects these selectors for ring buffers, and the
follow-up selftest (commit e12bcaa3a4d8e, subtests reject_cpu and
reject_index) verifies that error. The file already uses
_bpftool_map_guess_map_type() to make completion suggestions
type-dependent for other commands (lookup, update, push, enqueue), so
the mechanism to conditionally suppress cpu/index exists but appears not
to be applied here.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35440280049
--===============3856022841713210179==--
