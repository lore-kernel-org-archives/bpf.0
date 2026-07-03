Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8113DCD98
	for <bpf@vger.kernel.org>; Fri,  3 Jul 2026 14:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783087894; cv=none; b=uZ6jBSwNa2TzShpFLXiuJQZzzz8NLz8K9/qPqfamezhka70NdRVHoI23t9Mot/mANsvMMvoh53xhbQXNUS1vO92DRfMf2Wd+w4jLQv1y+fvPaO1yGVE3CPvSxAjih10rD82H58yWbhyj2O6cPtTCM/ZHcu427HPh7qSvUvvoOxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783087894; c=relaxed/simple;
	bh=rIV9RsnsSZDUK1q1Nd3LKY8epaIDzY11eLnwBM/DcUw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aTFtstOjylQzEraMg0j7RSkPfUibu2Qjsh9Q35wU+J75mlb7Fux4dOT2wEl4AaCtDKcIDX9MI8Htpl/Gqs/W7/dy9VUzI/C3eST5wyFjn3VcZ9KfDOHRJJCFb8tiVt0SnQ/6YNoEz3nVyCD7w+pYWDbYn7djzHH0X81kgpq7emY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VafHTFi4; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VafHTFi4"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-493c7902f47so3944615e9.1
        for <bpf@vger.kernel.org>; Fri, 03 Jul 2026 07:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783087891; x=1783692691; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QPgd2/au/1j1zvelBc/TbSy2FLXI5cvkqsoiJq1KpPY=;
        b=VafHTFi4KbMh7Afv9tT4M7SYkyQreMoN09GQqNbtex1LJNt7EUpEwYNe4qm4WKIohF
         sHQt1SlDf8dC+fpdDA5mHkPscZUMdtRWiNAmGa5xOlv9fIvy1teITtKBnFto+2a5jFA9
         idWBiaTmBS0wGqBKHEtPy2ndBRmGHASgxl5c1vxqPIH8OnHfBOvL0dZEVFHrfJ/DZv5C
         1831XNSnxEU81yri+hSd6NdEV5qsW3UPSn7QipViwl6VOu+T7gG8WLOuY2bU2Zlz4woq
         UIY1bEgajbUhYJ3i+gCWtgWwZ6NqF5UJg0dQY1wZgzRpLCalcSHSJQTxzNYN+1mZFCg1
         cCQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783087891; x=1783692691;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QPgd2/au/1j1zvelBc/TbSy2FLXI5cvkqsoiJq1KpPY=;
        b=OiCX7OGC3I3M7HPicKlz4CljPt1tNaUO6y/6RLVntbli9KR+kM9EXulG/VBTBYLqxm
         WYqHEXexI5HePEOoHMYHJfd7I6rudnW4bQa67bDDLft4qKFfif2mScm6vzLB0xIKo8CB
         Au2OuiwNZKI/I7m2Pfoh0vIUjPufZFvU4UcEIcXcpArhddbLUtVVk8myyuDbfzTr7wlp
         E/FAS6aWUkSSlCyC5FxwCjUrypVrJx3ax7ZfGds7Q4f/+ez107u1iT401dIwe69Kdgu1
         tBATTRmpYb16y9acGZr4STsoysXCmiZTkY+a1oqNuf9C6rUazI08HQNgtdrqHkncgHdK
         eAhw==
X-Forwarded-Encrypted: i=1; AFNElJ8hlPuiJ3MAsgyj+KdC8PhkGtgpM3n+qamx/Q84+FaatCzWuLBf0OXVpuMogOeYJqoTZ3M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/G7kXY9wYPzBToBO8rpp/DnRyl6ttLS1dNQtUkyAS1HxF4mEn
	d/Sq+Is8BS7bd7Q6ol8qHsAaSY5sllnzoT/BR0s6qwb0ZIegG3X//KOn
X-Gm-Gg: AfdE7ckARuMvVDR5r0z87gSltYbWXXwGxdgXIiqbieCZiru0bhHa/K23p5DmW40aBdr
	su7u2Ph9d97tObkjchQPRkOgImuVbFykJP8Sbt/GiAphorMW/wlnmCsnPd8naswABwc+mS40uP9
	QOZzG4SyYS4jScaVTK7f/EbXCGyrICEVjeRtHr7NrU0LavMd+9pAV4TM3jVyN16d+nDw+sVO4xs
	0868IFQYYyMw0O0rX3s3lRbW9YN82bjB6A9XjIH4+QPQM8jNslTyM/ze1pnRA7jbZns4qjv+w7x
	5Bg6adgY/XZv32GcEXe0vMxlLrMKi/81WmzplW8md8H7/n+9Y3JPEUsmHfegto3kJ17LP36i7Wf
	4LDdVvgHKNuTAkjchIJqGMicUk9TboR5T8A4k6InL5+AmmKHh3oPYExrHXqL8fte4tJfvi7utcn
	Vs0EqTw5cNFMtzXVnLR4p01uSTyVLLmwm+8mE=
X-Received: by 2002:a05:600c:8716:b0:490:c024:2ec8 with SMTP id 5b1f17b1804b1-493d0de258amr1138135e9.0.1783087890966;
        Fri, 03 Jul 2026 07:11:30 -0700 (PDT)
Received: from krava (37-188-223-191.red.o2.cz. [37.188.223.191])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c6381e4fsm157919945e9.8.2026.07.03.07.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 07:11:30 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 3 Jul 2026 16:11:26 +0200
To: Peter Zijlstra <peterz@infradead.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv6 03/13] uprobes/x86: Do not leak trampoline vma mapping
 on optimization failure
Message-ID: <akfDDundFgxkIt9j@krava>
References: <20260703114917.238144-1-jolsa@kernel.org>
 <20260703114917.238144-4-jolsa@kernel.org>
 <20260703124503.GP751831@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703124503.GP751831@noisy.programming.kicks-ass.net>

On Fri, Jul 03, 2026 at 02:45:03PM +0200, Peter Zijlstra wrote:
> On Fri, Jul 03, 2026 at 01:49:07PM +0200, Jiri Olsa wrote:
> > In case the optimization fails, we leak new-ly created trampoline
> > vma mapping (in case we just created it), let's unmap it.
> > 
> > Fixes: ba2bfc97b462 ("uprobes/x86: Add support to optimize uprobes")
> > Reviewed-by: Oleg Nesterov <oleg@redhat.com>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> What is the intention here? That is, Patch 1 has a Fixes and is already
> in tip/perf/urgent (from v5), patch 2 does not have Fixes, this patch
> (3) has Fixes and appears to rely on patch 2.
> 
> So should I stick both 2,3 into perf/urgent or what?

patch 3 fixes the vma mapping leak, and it is done on top
of bigger change in patch 2

I think we are ok without patch 3 in perf/urgent, but if we
want to have it there, it needs patch 2

jirka
