Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2B73E49D7
	for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 22:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785450465; cv=pass; b=jand8CV1pfcUTsiyWZ4iykmfsB6D4hx+WlB+Gv7rC266IscPZ+RZ5Ml/uNrQM21LPPbl7pBENeijk5zA+oDQH4r9vyQiI7FoLWibIXSSXk447eTTPmIUPTCvsbptFPgNIRFV+Kw+46Aem9i022LWY89lyNHTh94DcvJwI+0N4wk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785450465; c=relaxed/simple;
	bh=mxR6zo1uzVmlCvrVVTNLSNdWhxzrwV7OGrG+Af4HFoM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DBiDg4U0hvA7EtYer9fSQCAEUpsei6swV/61gmALWtBwKnFoQJkCcWRVGC69YWT69N9YXHPg/25bTDJpvhxvRH7UWZVgZodZj8JtaNoewJ1ZhaL4okBAWymU1OEIsExKsuXKGji8SmAG3XwTXhTqsxeS+joUzoVS76NVzvX4et0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kAVr1pfw; arc=pass smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kAVr1pfw"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-848d21bbaffso475596b3a.0
        for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 15:27:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785450462; cv=none;
        d=google.com; s=arc-20260327;
        b=MrUNDpcR+dyHiKZCN3fMR69HmTTS5sMRAzxajEdSpeBm9W7iE+rNiK1j9UuR/F1c+6
         S6MA5IUcDAsELUCR/7FgMCot3u7JcD0ckVlJOOPFHTBCyvVPXFpETMqiLqZCcRcLy7zW
         EUTvxhQ9+IXUsVNGKRhZOkCKB2kcE2VkP2Fg9k4ZO7DwC7eWGN1dHgGJzZb/vuK/YPvR
         WOPqL3m0b3JMutWBC5g4J37nQFnUvrzmHslnlluD4tmAimuy6uqrdniprmvbMgjVssO7
         k34C1N+Vcr7/IbmhuHvx1rf6DYHoY1sGv5IHMqFmRfKALnp8ZMDCFUb973JliDMmehBN
         dgZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5roJyEXd7zYUkj2A9s/Sahih0EpxfdZ7m3/sd8D6kWU=;
        fh=RJssssaP5cd9w5FNwIlgSNPWBVfxGRYO3u+0qm91vOc=;
        b=K5QrgK/4Jt2OtJ4SukPve0HeSDN3QZ68Ojy9PYjc8HxpA4dAef8X7M5M2u2Kazvwcq
         4FVWRJ5hnd/PnXea6z5Hxr3K4S2uZkHKBMXNVLWG2DSiknXiwMqbVDwZZ0uXwCdlmKIv
         TksXHEl+DHDcKleBc+E377BFnJE7RBMpskKzGDATMwgS85Cu923RcC6ESWTBOABgcMGM
         Az2lEbfYjO+OiA0yR3Gu7vj8VapPMkODx8VsGU0Oe77PV76W9VPMLAGKgqZK1bBiUaQ0
         F1DuUrI79Ux67asMafVrsdx5zTH2iQ3iFTHe+GQovBpC05NUE/5sfjMkMP/Nh2XnUZd4
         7cuw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785450462; x=1786055262; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5roJyEXd7zYUkj2A9s/Sahih0EpxfdZ7m3/sd8D6kWU=;
        b=kAVr1pfwLotij0D/D1LNuSSV7eWURHJKJ9ODxzZVVUGFEJkqaFm+LPBTf4faSM0vOY
         9fNS4/9fB4691cD4z+w0fTFJetWOtE6FTN5yN8WqQh5EZJIqHHKaUjatResq//qoYEN0
         hVXUQ3w/1i+6u8aipLwJZXTDPc4bFRaVFC033swyS9R18K35kYCsKyHRf95dqELAuzLT
         nGnaw3ZwL10yE7cLYjWA7+E1FJiVyucawHXoy6+aQcRsczQOnezCxO9WwqxmAsGyg3JY
         SdTHxbiujsnADkJiN+8mxrtKpubgkfZ982rI2V+9fm797IGmsaxzASE8Q9V8dMHNI+xb
         s9Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785450462; x=1786055262;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5roJyEXd7zYUkj2A9s/Sahih0EpxfdZ7m3/sd8D6kWU=;
        b=TW6Yi7bkWCVrwWlk6uXrVdo9BV4a5H4p689hM3KSYNlwevPtaC1Yu6uiBTcj5UkJk0
         HduCgUodlzivXKBg96pKcjZyftOfpOjMlePiTvY00AuR5LIVcm4PgNX0QstRZLEpGg2l
         WHWiVK+3BQ7C2IcjkAAbwW0DUwOnMXh1nsPAAMT84a5tXhSOnYSDHrP9HEGGciai2kfg
         dKLWcWOJHkwpPim9c0iQuV6l+kLj9Ikg8BlmRh3MK94aVxCu1Ne9JLF0H2RIVzbQ/rai
         jeMhLXyGuqgRTXzhVX8qoRGd4xW1ZAuOYmGfRQJdOQTAOFnrM9qiWcPNrNLqmBWFPwnD
         yQ1A==
X-Forwarded-Encrypted: i=1; AHgh+Rq58msUgkbi1gqftgWThg0nVW6i0a59/4T1wrd7rGgiWDsDUHkPRey8knzMeSHV1Lf8AaI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxacbQcv0COwPrAxVdkrSRfp0uOzcqkMjx9ZJEHhWzp9lt0ZlXk
	6pEXgJA+RSk9e3WOv9uvjT48Ieh10xY73yWxuo0r5zF5RB/7Jw1Kb+iZ57AzNCvrL1XPDGcY7ZC
	671TR28YGKy+qpgsbYXlHPtNmqF4/Yr8=
X-Gm-Gg: AR+sD13TnTHlkJ+1aIihjDyAXrMs6Q3WXubi8JQnnGDxBwDFz8xB6cR+qZOwCAEGqo7
	nBl3pk3TZFgbCTDp1rIGNP2wQHuCCNgAiGHPz0W93OEuk8PFPKuKNidgrbMp8+95i7ZdOsnnbF0
	QomG9B4Ro2tSjDVRgiszacTZOnkCh/XP/SD4iVd90vOxfgZ0g1HLvLKbQrJLQFrf8a0Zh1KEBb2
	94VF+ETeg36BG+4jB38+R2L9vzdgLxjIiMG9n2DQpU8YuwaRRdW8yRnUU2AkesdsEGiJRlDEpem
	N8BzCBxHZHbUombZV5/1Y6t3sKUWr8ay4SY+ouvsWxpa1bQZBZi9kCCGjQjmZquGY9soO2GKUGY
	WDDiQldNJ6TQGWeSvOq7OqLWikmVof1pvFqliRhsxfsqVzx2QDc8va3rzhCVcB42z
X-Received: by 2002:a05:6a00:c82:b0:848:4754:28e5 with SMTP id
 d2e1a72fcca58-84ebc1fdaa9mr3988166b3a.16.1785450462053; Thu, 30 Jul 2026
 15:27:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706172744.3920417-1-puranjay@kernel.org> <20260706172744.3920417-3-puranjay@kernel.org>
 <CAEf4BzaDSeUxeZmHjXRYXnXDZj8Obwd3rmOsfNygjcXJ0yy5bA@mail.gmail.com> <DK4I97UIL347.3P2KEBO828JK8@gmail.com>
In-Reply-To: <DK4I97UIL347.3P2KEBO828JK8@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 30 Jul 2026 15:27:27 -0700
X-Gm-Features: AUfX_mwDesWtdCLE-1Fw6wnAI4608m7zqiXpKFs0ROJhEZiKm1s5xaCdqqVAUCY
Message-ID: <CAEf4Bza3LeVB-z3jwMdnBGLdjpPr9tZFhGHt5pUwui64ZX66Lw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] uprobes: Switch uretprobes_srcu to SRCU-fast-updown
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Puranjay Mohan <puranjay@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Josh Triplett <josh@joshtriplett.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, rcu@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 12:44=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Fri Jul 10, 2026 at 11:23 PM CEST, Andrii Nakryiko wrote:
> > On Mon, Jul 6, 2026 at 10:28=E2=80=AFAM Puranjay Mohan <puranjay@kernel=
.org> wrote:
> >>
> >> uretprobes_srcu currently uses normal SRCU, which issues
> >> two smp_mb() per read lock/unlock pair. This overhead is
> >> paid on every uretprobe hit.
> >>
> >> Switch to SRCU-fast-updown, which eliminates the per-reader
> >> memory barriers by moving the ordering cost to the
> >> grace-period side (synchronize_rcu() instead of smp_mb()).
> >> This is acceptable because grace periods (uprobe
> >> unregistration) are infrequent compared to reader-side
> >> uretprobe hits.
> >>
> >> The updown flavor is required because the SRCU read lock is
> >> taken in prepare_uretprobe() when a return instance is
> >> created and is held until that return instance is finalized.
> >> The traced thread returns to user space in between, so the
> >> lock is inherently released in a different context from
> >> where it was acquired: on the normal return path via
> >> uprobe_handle_trampoline() -> hprobe_finalize(), or from
> >> ri_timer() (expiry) or dup_utask() (fork) via
> >> hprobe_expire(). srcu_down_read_fast() / srcu_up_read_fast()
> >> are designed for this acquire-here / release-elsewhere
> >> pattern and, unlike the same-context srcu_read_lock_fast()
> >> variant, do not carry the lockdep read-side tracking that
> >> would warn on it.
> >>
> >> The short, same-context SRCU sections in ri_timer() and
> >> dup_utask() (which guard the uprobe against reuse across the
> >> hprobe_expire() cmpxchg) instead use guard(srcu_fast_updown)
> >> for proper lockdep coverage.
> >>
> >> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> >> ---
> >>  include/linux/uprobes.h |  5 +++--
> >>  kernel/events/uprobes.c | 29 +++++++++++++++++------------
> >>  2 files changed, 20 insertions(+), 14 deletions(-)
> >>
> >
> > Very straightforward replacement and will improve performance, thanks!
> > LGTM. Peter or Mingo, I assume you guys will want to route this
> > through your tip tree, right?
> >
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> >
>
> Hi Peter, Ingo,
>
> Gentle ping for this.
>

Another ping, please consider applying, thanks!

> > [...]
>
