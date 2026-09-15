Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969814A8FCF
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 16:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789488205; cv=none; b=d20tfr69fmGRVAiTyM+X+VKTdg/rHsGp3kSqioTapV9RUvpBAfIL1X+WUN1w3eaZVRVLHASJAIjhwyaixoWMos24USbWJtRfDiNWXUGLihoy9LU1iOERqozjQeqdwoYLZCOqN2nNpaliPZ17lc4UyaAQkbCPxh13ACF9hATKg9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789488205; c=relaxed/simple;
	bh=D3oau+TXcYzBPkd1gtd2LCOxJTWWah49cdKBmX9WcUI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ll3bL9QHDnTz3Edsu7NeHeDes5rZMZM6TJxcwSScdGyYgZpqxdBpo8oieFm76gx3cu+M9lEDRyYA7VobAc6//1aCuRyNOXtlnlI4XLdjxDlK8EyE95o+eXN6S/taRVCiBfn2wwPL3k/smUmx9mmnlwdHeZFlMq+DnORsG9Pq9wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=rqdbBmWF; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="rqdbBmWF"
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-939eb3249c1so409100785a.2
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 09:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1789488202; x=1790093002; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=D3oau+TXcYzBPkd1gtd2LCOxJTWWah49cdKBmX9WcUI=;
        b=rqdbBmWFbiv3znYqhz+mfg1EZrF/eWAdtsytKeL/GV7GgQ3A17ZN1+BbggEBFePUSh
         zUbhZB7LK9VVdP1Ry30EP8co2aBgvTvFySAGXpHQjiewHWbTFtRQ7RhQPnod5l0+k/es
         M0Kz6WQcZP35wweYsqh8mUiXuzyA23wrcg6toV7vNnvB0sWmw3JqmDRJDR4yQqwKZ0DW
         NtsmTPQWMIWuHiWGxmbto+L33VRViKwTMQyQh5mWHWf4ZGaxvQWDJzcAtjNw6Aedcgio
         uPR/Ze2YgMCrD9KlGDwAWUR1+Wrj2X1oB81uWVnIKetOtiAdoYm9UiJgQqQEJau7kp36
         WrrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789488202; x=1790093002;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:subject:cc:to:from:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D3oau+TXcYzBPkd1gtd2LCOxJTWWah49cdKBmX9WcUI=;
        b=kQULojAAxL36qR9CdWN47pJj+zpVA0zbmi0e45k/cyibXwnpZh9tYeUjLRGhNFj5b8
         R7CVkPA8N7V6je7l5YXO9FMwTbOF/gxmhDBfGYOW0xuzpkquqiS+hUPDSwdy4WqX+keI
         9aUKhyyV9HiGQjo8DvuRZa6bu77Nl/lCHhxqmRCYMj68XKu20F+ux6hEz0yjaHaGiL+k
         n06FBYXNBGUem5tZZJYDXcKxeJtP8IfZM4UspFClJ9kmVe56vZ+1z0aBJfmNyRi1H+P5
         IxjnRXtyH4ycugcv9xQz5bsYkhFQubf8lXCAbW72XsBLyBxCrLnn7Qs7WUTzu/2JO9Qq
         lzRA==
X-Gm-Message-State: AFuF++kXs11sCP20YdXB+kpWXQFOGldoksdin222kofWFnkDixneUBpJ
	GruPYvrCOn60ecIDNOJW+qH42JqgDzAN5XlmEe3IEEqRYc4xieIN20f2qoTjVkXZGJ8=
X-Gm-Gg: AYBFou0whHQEWudp2tt0pz9frLqb6ruMNSOCrbUtuvfrdLgBbLgTxMoJyfFr9TO6M+q
	9fjqT2VvWZSsrLpwNovfWvLFw9qM3QPjPG5GaWz8WbVtNFqLwZAmVL+YYOOJCRZq3IujOndp17Z
	8uNN8hupU25iwd+VWZiGQOCUPpKLIDZNflSK2cH0qT2rUwRmx+x8W5Zkv5udP8UAkGQCp8nTqdQ
	N7eR7Kx2LPB6kFLCHOrWBZm/HgnoQ5BNModaBDodT0kNLT0dIaCoyIOz9OEQfC4Ou5g9Y76d3kP
	PwQXqMZub1cq5cXzvIvz8rPhF1eZ7YqcICowyUvFSKmoIySJA3QLT7IJfKNSW+dazeFW3M5+ibC
	aMqVmOHQy4vYbD4kD04wJevJSybkNNTusRnqGTKATRekQyOYPsEu6+AbJcMXLCYNdUdpBQvUQyN
	PdYZYIWU/ST7BS/k5YZtTGdVQSjnEZkuJZMDC92sG41Ajab0+ELw8DGqC3AN0F1Q4S2P7LMUuQ/
	CvwIxyYtsL1EQas2vbKiQyT8as7VCb9ZJgB9StB/GbRybO/ETuSovQE
X-Received: by 2002:a05:620a:90d0:10b0:93a:2d2b:a5ed with SMTP id af79cd13be357-93a2d2bb71dmr992381385a.47.1789488197613;
        Tue, 15 Sep 2026 09:03:17 -0700 (PDT)
Received: from toxicpanda.com (ec2-34-228-114-98.compute-1.amazonaws.com. [34.228.114.98])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939ec337d23sm1222565385a.2.2026.09.15.09.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 09:03:16 -0700 (PDT)
Date: Tue, 15 Sep 2026 16:03:12 +0000
Message-ID: <da00ebd18989a30a9dfccff23be9ba14.josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH RFC v3 05/13] ftrace: Mark modules hosting direct-call trampolines for Tasks RCU
In-Reply-To: <08596bcdd997ab7122dafdb363cf80caaf038378f32ccb89fbca114c2fd9110a@mail.kernel.org>
References: <20260915-b4-rcu-tasks-preempt-qs-v3-0-0ad30c4c5ee7@toxicpanda.com> <20260915-b4-rcu-tasks-preempt-qs-v3-5-0ad30c4c5ee7@toxicpanda.com> <08596bcdd997ab7122dafdb363cf80caaf038378f32ccb89fbca114c2fd9110a@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 15 Sep 2026 14:17:49 +0000, bot+bpf-ci@kernel.org wrote:
> This isn't a bug, but could the field and ftrace_direct_mark_module()'s
> body be gated on CONFIG_TASKS_RCU_TRAMPOLINE_READERS instead?

Sure, done for v4, along with the other three from this run: the
rcu_read_unlock_tasks_trace() lockdep ordering in 02, the @regs kerneldoc
in 01, and the Documentation wording in 13 now mentions the
rcu_tasks_trampoline_text() / rcu_tasks_wait_irq_preempted() route the
kprobe optimizer takes. The kerneldoc here no longer points at the sample
header.

The Fixes: suggestion doesn't apply, 03 and 05 are the same series and
nothing selects the option until 13.

Thanks,

Josef
