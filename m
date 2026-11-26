Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795663797;
	b=YBmLnUAhaw7+0ZvEg4/6EsZ8LBRnpghms93XEJuZUZGbKpcRuMMeREX+NBlO+QmWMJvV
	 MT0c4BWagHlV8rQIgXOB5nmXaB+dw+ToxnXFzVjeq986zzez7H4GLt7pvuTULsAh7CSla
	 61ePaZR2TvhXK5mdXOHw5zqbA0cl5HFmyTGYvqsNqd5szox+upETLtL5Um8joGTBv9jtv
	 YTk7Lw9w9QlOoH8Q1AkEao8KGUpFFLVkk+2zY31K1czrjlnJdal9E7VCX2O6WVXcCUM56
	 /HANCcsicjkrbhlw/zxgpc1v+2ekI7lH7dfm77FeWKcb/lB8EPe8VdzQOs9oTMPo7xQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795663797;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=IpBPoqnT7XRaUUtao4GwnTNrNP2Jb9pC0p7vG2cG0EM=;
	b=LOeHHyeueXkrzebEwcU36tj3TkvbFcg2Rm1fmHWU7MiD8lf2kJUXJjyGlwcM6hOHemIV
	 bVwIOE8cu0z7GZifoV4HMJz5p1D+iw1FtvcQNB5kPiccQmRO1bGtJZxZaUpC9rXhNN0I4
	 nzucwhHqDbshbp783Y5GkWxWnYYjsBYAvi15/3ZAl9EMrysXQUe1F2Wq62WSDMIuOr5cq
	 k+KzyMXXSnX92gdr3dBB0/+etOKfrWxoLjjdhNMON5QwXcwwUaqQri3QmO6RxDxPY4fpr
	 X4sYjPQ4iMv/+Ae/KBNlDQvuXiI9cE+dTsWNBYV9DjRQ+nELcz1iRD1gCUUSfrtmqdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ge74aeZ9;
	arc=none smtp.remote-ip=209.85.215.169
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41155606A691
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 03:29:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41155606A691
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ge74aeZ9
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cddac941ed1so2935755a12.2
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 19:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795663796; x=1796268596; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IpBPoqnT7XRaUUtao4GwnTNrNP2Jb9pC0p7vG2cG0EM=;
        b=Ge74aeZ9dydOcRkiioTsqEpJtsFEIaP6vYCZeCjABFSs7FcbSagrDKjdNDqExJ2OHc
         lMlLqUIv0U6OJHLrfjihR7nT2vs1FRTjZjYNJK7cwbsmjp3WyTU5M/P1hfAwjqbb/1Bf
         uAKeS+uvL/l+4lOvI4wqObv935uvCp8kcqszPQQvA/m3bGbb4e109JkdYuIr4oOHdb3y
         y67zBtmUukRrJ64tGN6gG93dMJvuE7KnrGAgl4yzXfXGKgPRCVLffLCNkDP1yahMniA8
         41HMs4QhGiHaW2V9kzfQekghes5I7HYCD8pHKPRNQusAh0c7QmzvFP3Vgtx0HKo3nJAs
         DMDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795663796; x=1796268596;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IpBPoqnT7XRaUUtao4GwnTNrNP2Jb9pC0p7vG2cG0EM=;
        b=aSlzAYbrSBCbwTVbxPKXf/D4ec23siMqD714gtdR6oIfzwj423h66M6DTQRsg/sKAq
         nt6chheb2vdoKckZjkE0uPSXsyb3buOmen/aIEixvpsR2KM8hLptAl7+LmZ7G3rf6/Pk
         cesHY8R/zWG6qKitd5nvCNoDLRTIdLYWVCWiorUvbfe+EAzUBjfg4GNjMApW7PkEwH+o
         I+LTC7aWBhgzd8AbkIzLSy7N/lw9TAzuJG4ZDrcY0BxUL2//f7Yz6V6dtu2Bn4HXzzCp
         BK3ZUBIqkkvLCKY4rmXjHky2Nb+cbeyyS1YgS+L6qKLaoWw9/eZI3RQ5fhDFcAZKl6MA
         1S1w==
X-Forwarded-Encrypted: i=1; AL+hErFbTQPXfvu5qZ1TKmoV/KbjBGnT8C7Y87zpulH6j4ZqDYoKDgKvJ7YhDJT6WLZmFmK1NNA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/z5NlKgATlmprz7DRo1M81HVrVgIslgKum+bnTcfhQ0qlXwFCx
	qiXKgKrIJwvezNKgAgulzKvI/0vF9qh/Rn6H04dhVBnoy3B9VkX1YspL
X-Gm-Gg: AZFdTZcS3BDHgOwpOCQRDyQquSE4dzvAESVg/3fz9TX0DxbKIYGRsoYtK1DYqWxJKQ/
	5LMQ+mF35duN5UR4saFGHeCPUSUYXGxiPtV+YIgYppNB0THF59T4yKpS9390Q9VHE1+AwFQix0e
	JAWEvov0EaDJ5ZwzAQO+CbY39hqc2kgbKp0h7E6lJyznYBV0jZ1Ll4NlpXPYZKb3mRrxTzntwXR
	uWKsgfumOY2OBZrceHIZdJovdZx7gICv9PFu30RQnLyEmWp0dvLOOGW2S8Sh6VHlOUv18iOSYHz
	QOtIyylqEvgEB5xEYh+IP/D25t8l9PfX/2yDdwHzIDZrf0q95FC1Vo63PyxhtSeB5t4gJUpNKaO
	0sgoutookBCTp94nFfUarX5KVU/YOvUWHRsQtuqBKa/tVcnTBLexalGUJflW1Ii0lnaILn4R7Op
	BBuRlXfYPrq4nBkJQqP0iTqxToHRPh2pBH6iB1tesZMYeZBoFYQfJPXM+Uffwrf8TEjzghTJycw
	+YFSbMv66ebE9p54r4Ssb4684NjEi5zzGfL4T6lpUKDr0JhSM8mXqPuAKAUVmdYjTHB1RdnaecG
	KnOpCl6+lX2pxQwF+fd1zyfmC+LD+SCNDO6sumcyPEBrxZAnenHkepsl7T4oTDsHLmO0J/3ekcz
	3/pE4R5TlzWxiBrGY4zPpFxd4NGPEiDUUvg==
X-Received: by 2002:a17:90b:35c2:b0:3a8:c0cd:57f3 with SMTP id 98e67ed59e1d1-3b41c8e0c7emr16856091a91.18.1795663796337;
        Wed, 25 Nov 2026 19:29:56 -0800 (PST)
Received: from localhost ([153.61.198.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b40578d771sm32691589a91.1.2026.11.25.19.29.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 19:29:55 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Nov 2026 03:29:55 +0000
Message-Id: <DN4TOVIA1HK7.HEPNDE8WF6HZ@gmail.com>
Cc: <mikeba@sentinelone.com>, <bpf@vger.kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 "John Fastabend" <john.fastabend@gmail.com>, "Emil Tsalapatis"
 <emil@etsalapatis.com>, "Ihor Solodrai" <ihor.solodrai@linux.dev>, "Steven
 Rostedt" <rostedt@goodmis.org>, "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>, "JP Kobryn"
 <jp.kobryn@linux.dev>, <linux-trace-kernel@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v3 0/4] bpf: Check recursion per task for
 preemptible programs
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Andrii Nakryiko" <andrii.nakryiko@gmail.com>
X-Mailer: aerc 0.20.1-355-gf870624f6c37
References: <20261117-bpf-preempt-v2-r2-v3-0-586376ec3672@sentinelone.com>
 <DN38312WXPDJ.2KLUTCWSDFL3P@gmail.com>
 <CAEf4BzavErcSOZhGobqEo68d+2bCnJ8vFxxT_vqb+oQw1j1d7g@mail.gmail.com>
 <DN3X5OIRXSWR.2Y70DWFMPDXQF@gmail.com>
 <CAEf4BzYxBM3R1s6XDSpN5htzMho4Jp2uBsx9ZBKTPNBvmEffxw@mail.gmail.com>
In-Reply-To: <CAEf4BzYxBM3R1s6XDSpN5htzMho4Jp2uBsx9ZBKTPNBvmEffxw@mail.gmail.com>

On Wed Nov 25, 2026 at 5:35 AM UTC, Andrii Nakryiko wrote:
> On Tue, Nov 24, 2026 at 6:00=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>>
>> On Tue, Nov 24, 2026 at 01:47 PM Andrii Nakryiko <andrii.nakryiko@gmail.=
com> wrote:
>> >> +       for (ctx =3D old_ctx; ctx; ctx =3D ctx->saved_run_ctx) {
>> >
>> > do you mind checking if unlikely() around ctx improves performance?
>>
>> Mike,
>> pls try it on respin.
>>
>> > So basically to opt out from this behavior BPF program would need to
>> > stop using any per-CPU maps and just implement its own poor man's
>> > per-CPU storage?
>>
>> poor mans's per-cpu with bpf_get_smp_processor_id() shouldn't work
>> as an opt-out. See section 6.
>
> it's hard to weed through that verbiage in section 6, are you
> proposing to mark "needs per-cpu protection" if BPF program is calling
> bpf_get_smp_processor_id()?

yes, because it fixes real prog (falco).

>>
>> > And even using SEC(".percpu") would still be detected
>> > as per-CPU usage, right?
>>
>> This one is pretty much brand new, so there is no data to make
>> a decision. I can see arguments both ways.
>
> .percpu is backed by PERCPU_ARRAY, so we don't need any data to say
> that it will trigger the protection, do we?

I think it's slightly different vs normal percpu-array.
.percpu is pseudo_map_value
map is pseudo_map_fd.
So we can distinguish if we want to.
What I was trying to say is that .percpu is likely only in Leon's tool.
So this one is easy to fix is we do _not_ want 'needs_percpu_prot' on it.
I'm fine whichever way.

> Still, choosing between handling all events and having bugs (fixable)
> of handling per-CPU data in my BPF program, I'll choose the former.

but with the diff I proposed you get both:
per-cpu maps work and there are no missed events.

> Even if we don't want to make that a default, that's fine, but please
> at least give me a way to opt out from the kernel's
> over-protectiveness :) and not using per-cpu maps is not a way to opt

I don't follow what opt-out you're asking about.
Out of implicit preempt disable when you're using per-cpu array?
Why? How does it hurt your prog?

> out, it has its valid uses even with preemption. Think about simple
> per-CPU stats/counters updated with atomic operations and aggregated

wait what? per-cpu _with_ atomic? who does that?
bpf gained _local_ atomic just weeks ago.
per-cpu with full strong atomic is odd. Why would anyone use that?
The only case I can think of is nmi-safe-counters.
When we introduced per-cpu maps 10+ years ago the use case was
packet bytes and count, so that bpf prog can do
map_val->pkt_cnt++; map_val->pkt_bytes++;
and that's what everyone was doing since then.
combination of migrate_disable and preempt=3Dlazy broke that accounting
pattern, so implicit preempt_disable unbreaks them.

