Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2993E1693;
	Mon,  7 Sep 2026 02:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788747657; cv=none; b=p7heLycVNZTUX62ofrphjADCZjWB2fWaHvgRRjU4sjbdUUHRcYU1psqBy2YMHcZntPK4tv9/OUoDwekSRzsuwtb7lME9J82d5Jbsi8Fvogd4D1JTCeaYkhDBNqBER6IOtUmvAyJpsb+EgpSmq/dXC4VtNJJXJdQNQNK4kB1qUM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788747657; c=relaxed/simple;
	bh=xEPJY0Xy2R6hVl9OJ+pvt8jh1tU/gwGch8H96sNsGX0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=hubp6NfXtVfaQ/mfas837Nysv2I2EzKp4HPnyj9EN+mEry7gwNp9hn5PImLWduhK7uth7Db7owDLVQyzUHmaPaGgIu+ezxOv1tXUQByesojJRTUqJOW139pbgA818or1rDBmynsGBtSdojwdFLIku/h7XtwYKZaQI8uMiTnxHF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bfSivRSt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bfSivRSt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C92781F00A3A;
	Mon,  7 Sep 2026 02:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788747655;
	bh=t365erqQSDoE5ipiV8It4X0KNt1LMeimohJDD30xFy8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=bfSivRSt7jNxuS/Db3JUBS6IfS1sPubQoUloUuj7hI9Nw2awRtwo20pI3tjn+5EQs
	 dPo43cs0brAsXX2lGfINWM9AGqe+Lc9O4Juxs/dc4bdLx2dllBXS8Pw6/LZfOTSeMO
	 kxP1+8mU8NlrloMUwxxB6fwnYq1ru/o2+voJ6cumYmKEpWa3/juhH4tCF3jgxQx+45
	 GoUl9dgelbYa6n2wmUVyJ6skixOxcPYxoGiLy18JNTQ6SLUD15SaHl33+nigb3Utqd
	 PTuIQE/jLKVgkj0p3P3GSzaPHEFVLIo2NtPfiJ0C5AUj81T4KLQ3OzIpbUiXfjvT3K
	 Jl0KKe3qAR+WQ==
Content-Type: multipart/mixed; boundary="===============3433593942401381302=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <7a2ed42e006620d35c7112f2828f37e97b13f77e71d242c121c2641e88ffa3d8@mail.kernel.org>
In-Reply-To: <178874362960.1415955.4802953891665661440.ringbuf-v2-1@tychen.cc>
References: <178874362960.1415955.4802953891665661440.ringbuf-v2-1@tychen.cc>
Subject: Re: [PATCH bpf-next v2 1/2] bpftool: Read ring buffer maps with event_pipe
From: bot+bpf-ci@kernel.org
To: hi@tychen.cc,bpf@vger.kernel.org
Cc: hi@tychen.cc,qmo@kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon,  7 Sep 2026 02:20:54 +0000 (UTC)

--===============3433593942401381302==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Allow map event_pipe to consume BPF_MAP_TYPE_RINGBUF maps using
> libbpf's ring buffer manager. Print each record's size and raw bytes
> in plain or JSON output, and flush output as records arrive.
>
> Reject CPU and index selectors for ring buffers and retain the existing
> perf event array path. Keep signal handlers limited to setting a stop
> flag, reset that flag for each command, and print the stopping message
> on stderr from the main path. Close the JSON array on poll errors and
> preserve output errors returned by the ring buffer callback.

This isn't a bug, but could the changelog lead with why this is needed
(ring buffers are now the common output channel but event_pipe has no way
to read them) and keep only the parts of the mechanism that are not
obvious from the diff, such as the -EINTR return from the callback? The
second and third paragraphs walk through what individual hunks do rather
than explaining the rationale. A reader can learn what each hunk does but
not why the feature is wanted; the motivation is only reachable through
the Link: tag.

> diff --git a/tools/bpf/bpftool/Documentation/bpftool-map.rst b/tools/bpf/bpftool/Documentation/bpftool-map.rst
> index 5daf3de5c744..c44e6f797e57 100644
> --- a/tools/bpf/bpftool/Documentation/bpftool-map.rst
> +++ b/tools/bpf/bpftool/Documentation/bpftool-map.rst

[ ... ]

> @@ -134,6 +135,18 @@ bpftool map event_pipe *MAP* [cpu *N* index *M*]
>      existing ring.  Any other application will stop receiving events if it
>      installed its rings earlier.
>
> +    For a ring buffer map, consume records submitted by BPF programs, including
> +    records already queued before the command starts. **cpu** and **index**
> +    are not supported. Each record is printed as raw bytes, including embedded
> +    zero bytes. Plain output reports the record size followed by hexadecimal
> +    bytes; JSON output contains **size** and **data** fields, with **data** an
> +    array of byte values. Ring buffer records have no implicit CPU or timestamp.
> +
> +    Ring buffers support a single consumer. This command advances the shared
> +    consumer position and must not run alongside another consumer of the same
> +    map; it does not provide a passive view of events. **BPF_MAP_TYPE_USER_RINGBUF**
> +    maps are not supported.

This isn't a bug, but would it read more tightly to state the
consumer-position effect once, e.g. "Consuming a ring buffer advances its
shared consumer position, so this command must not run alongside another
consumer of the same map", and to say "printed in full, including embedded
zero bytes" rather than "raw bytes" just before describing the hex output?
The single-consumer point is made four times in three sentences: "support
a single consumer", "advances the shared consumer position", "must not run
alongside another consumer of the same map", and "it does not provide a
passive view of events". The paragraph above has a similar redundancy in
the other direction: "Each record is printed as raw bytes, including
embedded zero bytes" is immediately followed by "Plain output reports the
record size followed by hexadecimal bytes", so "raw bytes" reads as a
contradiction of the hex encoding described one sentence later.

> diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
> index 75cbcb512eba..1750b488c9e3 100644
> --- a/tools/bpf/bpftool/bash-completion/bpftool
> +++ b/tools/bpf/bpftool/bash-completion/bpftool
> @@ -878,11 +878,11 @@ _bpftool()
>                              return 0
>                              ;;
>                          id)
> -                            _bpftool_get_map_ids_for_type perf_event_array
> +                            _bpftool_get_map_ids_for_type '"type": "\(perf_event_array\|ringbuf\)"'
>                              return 0
>                              ;;
>                          name)
> -                            _bpftool_get_map_names_for_type perf_event_array
> +                            _bpftool_get_map_names_for_type '"type": "\(perf_event_array\|ringbuf\)"'
>                              return 0
>                              ;;
>                          cpu)

This isn't a bug, but the other _for_type callers here pass a bare map
type (e.g. stack / queue on two lines). Would anchoring the "type": "$type"
match inside _bpftool_get_map_ids_for_type()/_bpftool_get_map_names_for_type()
and then calling them twice read more consistently than passing a grep
expression from the call site? The two new call sites pass a raw grep BRE
to helpers that every other caller in this file feeds a bare map type
name, and the call site now encodes the helper's internal implementation
detail (that it greps the pretty-printed JSON for a "type": "..." line).
The file's existing idiom for a two-type selection is two consecutive
calls (lines 682-683 and 700-701).

> diff --git a/tools/bpf/bpftool/map_perf_ring.c b/tools/bpf/bpftool/map_perf_ring.c
> index bcb767e2d673..7d555331f443 100644
> --- a/tools/bpf/bpftool/map_perf_ring.c
> +++ b/tools/bpf/bpftool/map_perf_ring.c
> @@ -27,7 +27,7 @@
>
>  #define MMAP_PAGE_CNT	16
>
> -static volatile bool stop;
> +static volatile sig_atomic_t stop;
>
>  struct perf_event_sample {
>  	struct perf_event_header header;
> @@ -44,7 +44,6 @@ struct perf_event_lost {
>
>  static void int_exit(int signo)
>  {
> -	fprintf(stderr, "Stopping...\n");
>  	stop = true;
>  }

Would it be worth splitting the signal-handler hardening (volatile bool ->
volatile sig_atomic_t, and moving the "Stopping..." print out of int_exit())
into a small preparatory patch? It looks like a standalone async-signal-safety
fix for the existing perf-event-array path, and separating it would make both
halves easier to review and backport. Two of the changes in this hunk are
async-signal-safety fixes to pre-existing code rather than part of the new
ring buffer support: widening stop from volatile bool to volatile sig_atomic_t,
and dropping the fprintf call out of the handler (fprintf is not
async-signal-safe). Both stand on their own and apply equally to the existing
perf-event-array path, whereas the rest of the patch (the stop = false reset,
the -EINTR return from the ring buffer callback, the jsonw_end_array() on the
error path) is genuinely needed for ring buffers.

[ ... ]

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34074185878
--===============3433593942401381302==--
