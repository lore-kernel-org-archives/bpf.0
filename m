Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E851C2324;
	Tue, 22 Sep 2026 02:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790045207; cv=none; b=PyBGaRyXkFgUutSbmZ2xazqLTRd7z1tjfEGjl8kKnm/1yS9aN/eIKQ/EXkTj7Vi7pT2MUaq7icffY70PNMbJ/698GRQtMN8E01M6PwzreO1IOUxlfWIMSR6d70YRPr7EBSGZvzF/4pzp/wAyB4SUqnDcAWFAnPX2rC160hnduVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790045207; c=relaxed/simple;
	bh=OXEWaNDjzGTksV7cNFYTonPqUP/XiFeUvgjFF2t/SZw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=K8g6OgxGzWKkoNoouGMtpXaAX8xEKpvOoqxtMinK4MlIe+QAIyttbjjoOLs0CE8xrcEULW7CYqeKlZUGhCN5BqPae8YxJWDcfVMBAypB5lAelHD0RMOJXZDDbGfcdlndGVPvACBj03PJcYT0tJZay4px6NNpSxM1YdiD23DQAQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fqqWGvkK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fqqWGvkK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8D961F000FF;
	Tue, 22 Sep 2026 02:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790045205;
	bh=MOzDwy6eO8/blUPkxP2vb6lYBtsThXRvf8h6GqiRrsM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=fqqWGvkKP5R4H4IDzDQLhHwjS8qf98iTqGjnN5klxZksBGyg9RIM0K1IMeI+zOdT1
	 WAW0aPsU49Y0W6gxe3rj6zh8n2VBCDwUFgTVCNtXN9QvfuBXD0wdvJ7kI60h/TLMaV
	 FKkC2iOAaANbDJY84faspyLJIEkbhIr6dZu1VqS7s81IZbtDfozyJkfSdqZGUwgbeL
	 wWQw+B2T9h+q9ZeA1OXjS9RaNlfYAoU7Etb4ThIYyqqxfYFJNXcnwC0n3wob0ZN2rn
	 66oqIcMvj1j3o7E9nwfcOTscSiQWL0XPTkb8JRFirk0wwAaF8z+S+E6+Jjsaa1efEy
	 lTqPV2/D6qoww==
Content-Type: multipart/mixed; boundary="===============8280890974195556375=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8dd3c1cf39ecece85de180fd63a78ea52684202c66ea329fb08d9c444365b1ca@mail.kernel.org>
In-Reply-To: <20260922015417.130869-2-yangfeng59949@163.com>
References: <20260922015417.130869-2-yangfeng59949@163.com>
Subject: Re: [PATCH v2 bpf-next 2/2] selftests/bpf: Check bpf_skb_output() tracing restrictions
From: bot+bpf-ci@kernel.org
To: yangfeng59949@163.com,kpsingh@kernel.org,matt@bobrowski.net,song@kernel.org,jolsa@kernel.org,ihor.solodrai@linux.dev,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,yonghong.song@linux.dev,emil@etsalapatis.com,rostedt@goodmis.org,mhiramat@kernel.org,mathieu.desnoyers@efficios.com
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-trace-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 22 Sep 2026 02:46:42 +0000 (UTC)

--===============8280890974195556375==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> commit 586c31fe079529e232f3760545b476754b91501b
> Author:     Feng Yang <yangfeng@kylinos.cn>
> AuthorDate: Tue Sep 22 09:54:17 2026 +0800
> Commit:     Kernel Patches Daemon <kernel-patches-bot@fb.com>
> CommitDate: Mon Sep 21 19:02:48 2026 -0700
>
>     selftests/bpf: Check bpf_skb_output() tracing restrictions
>
>     Add verifier coverage for the bpf_skb_output() tracing policy. Verify
>     that an fentry program can still use the helper, while the equivalent
>     fexit program is rejected at load time.
>
>     Signed-off-by: Yun Lu <luyun@kylinos.cn>
>     Signed-off-by: Feng Yang<yangfeng@kylinos.cn>

There's a formatting issue in the second Signed-off-by line - it's missing
the space between the name and email address. Should this be:

  Signed-off-by: Feng Yang <yangfeng@kylinos.cn>

instead of "Feng Yang<yangfeng@kylinos.cn>"?

> diff --git a/tools/testing/selftests/bpf/progs/verifier_helper_restricted.c b/tools/testing/selftests/bpf/progs/verifier_helper_restricted.c
> index 889c9b78b912e..058e71927cd5c 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_helper_restricted.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_helper_restricted.c
> @@ -3,6 +3,7 @@
>
>  #include <linux/bpf.h>
>  #include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
>  #include "bpf_misc.h"
>
>  struct val {
> @@ -17,6 +18,13 @@ struct {
>  	__type(value, struct val);
>  } map_spin_lock SEC(".maps");
>
> +struct {
> +	__uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
> +	__uint(max_entries, 1);
> +	__type(key, __u32);
> +	__type(value, __u32);
> +} perf_event_map SEC(".maps");
> +

[ ... ]

> @@ -165,4 +173,28 @@ l0_%=:	exit;						\
>  	: __clobber_all);
>  }
>
> +SEC("fentry/skb_tx_error")
> +__description("bpf_skb_output is allowed in BPF_TRACE_FENTRY")
> +__success
> +int BPF_PROG(skb_output_fentry, void *skb)
> +{
> +	__u64 meta = 0;
> +
> +	bpf_skb_output(skb, &perf_event_map, BPF_F_CURRENT_CPU,
> +		       &meta, sizeof(meta));
> +	return 0;
> +}
> +
> +SEC("fexit/skb_tx_error")
> +__description("bpf_skb_output is forbidden in BPF_TRACE_FEXIT")
> +__failure __msg("program of this type cannot use helper bpf_skb_output")
> +int BPF_PROG(skb_output_fexit, void *skb)
> +{
> +	__u64 meta = 0;
> +
> +	bpf_skb_output(skb, &perf_event_map, BPF_F_CURRENT_CPU,
> +		       &meta, sizeof(meta));
> +	return 0;
> +}
> +
>  char _license[] SEC("license") = "GPL";

The kernel change this tests (538d3dadf8d0e) gates bpf_skb_output() on
four attach types in tracing_prog_may_run_after_target():

  case BPF_TRACE_FEXIT:
  case BPF_TRACE_FEXIT_MULTI:
  case BPF_TRACE_FSESSION:
  case BPF_TRACE_FSESSION_MULTI:
          return true;

Only BPF_TRACE_FEXIT gets a test case here. Would it make sense to add
coverage for BPF_TRACE_FEXIT_MULTI, BPF_TRACE_FSESSION and
BPF_TRACE_FSESSION_MULTI as well?

The fsession case in particular is the one whose rationale the parent
commit message spends a paragraph on - that fsession must be rejected
because the same program runs on both entry and return and the verifier
cannot prove that a helper call is entry-only.

All three have libbpf section prefixes available (tools/lib/bpf/libbpf.c
has "fsession+", "fsession.multi+", "fexit.multi+"), so the extra test cases
would be copies of the existing fexit block with different SEC() strings.

Kumar Kartikeya Dwivedi raised a design concern about the overall approach
in v2:

https://lore.kernel.org/all/DLLHE9PBLDU0.XQGEOQQIR4HV@gmail.com/

  "Sorry, this is not an acceptable fix. This negates usage of the
  function in all fexit and fession attach points. Unless there is a
  simpler way to enumerate in which attach points this helper should be
  disabled, it might not be worth doing and leaving this be as is."

The concern is that disabling bpf_skb_output() in all fexit/fsession
programs may be too broad. Since this test verifies the blanket restriction
that was rejected, has this feedback been addressed?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35678199634
--===============8280890974195556375==--
