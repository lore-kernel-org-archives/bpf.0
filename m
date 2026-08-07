Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5C8363096
	for <bpf@vger.kernel.org>; Fri,  7 Aug 2026 08:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786091407; cv=none; b=KYXIY4+BOPfceHU3L2cjbFXDoVaT5m3EbYNpQz0EpbYv8ocOEmfthftXlefj6QObSmdEmf4cEufbC70j3WswUQZ7TQreLlVI8bCnLdtjNjTmvalPEu4OCevid4kfcdRMndsgI/k+9Pr5Gc5zngHZqVoK8SphzGLYRW/8PRjw6Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786091407; c=relaxed/simple;
	bh=zoMgyTnPcxmjrRKo8KjTs2mPLj2NU4aqE86gOU/JCXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ttQuC1tiU6m+22vLkLCH0H37ZCjgLpjV0pLplBDBn7yidXQoUoPMzLi+RjEuIDCC9ZdTw9CPpSbYKfRP6FDzf9YoZ8brRauxreYoYmGmRqxckNxCOwuAgJwlG1poB0QbIY4cgYlgwdc0vj2YbwctHV9l2xV7rFxoG1ZrWzcULfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cRbWAjG0; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cRbWAjG0"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4954afac04bso34620365e9.0
        for <bpf@vger.kernel.org>; Fri, 07 Aug 2026 01:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1786091403; x=1786696203; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1+lNGc2wq23H6MJ/sOQHuT0aX2LUv/n1NhY2pqg5I/E=;
        b=cRbWAjG03Thgrc21Eh0zl7WKXTzNYmOg2n5vQKhuYoc4LWFAj5ITM2rEr8fNGPN/uv
         Kr02QidYPiS1R8flnBNKFhEWxCXrb9KIZcX1e79dpt9RAlWOHTTGjVhsRIMgc/iNdRZU
         fU2i9Swbkjz2uTu5GoN7MPrOCZ6VlmtWhwguhU7ZNwtYi8L/iVSGvMHgxzPv+K8KQbL8
         dreZyyMJOV2qruysyhBbcWldmduS/7xEZiC3aZ93Kp3fA7CYrTHZVurEeAF33RlHnTEB
         Pe6MuNU5nOm6mUHYsuXgF48qihFk90Jowh+45xBZMBATJHYUHaqUfpmo01NFo6LVDGZB
         STbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786091403; x=1786696203;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1+lNGc2wq23H6MJ/sOQHuT0aX2LUv/n1NhY2pqg5I/E=;
        b=bb3fmz+TrCGOhq2vKXjXYNfbo+uEAs8G3jrFzjk8gBvw2usfmnvNDfkfl+YNIAQRf9
         LvmJ/9oMIwoP049eci0R/ykY02ns84nqszDm03WmnIh04uUb/7YkIVXXAotXthXV6SRo
         uEPFNO7f4+6yfhOgfrKoSVVcQd15lvoGOvxGhcwKq9HdUnnxq7lUjWBNQek2VzGyj17u
         E/hJvuvlS1AYT5j8tkRVFV3WHFuJn0jXlJatTx3UVPm7N+764DUj/UK66R0CF95inyyD
         HGxFN55jWm9tuIES4MEk1DFepCd81+TwEJl+SEJouxHrR4XFf5NNZ+PlmXaZ2CPQomhU
         N9/Q==
X-Forwarded-Encrypted: i=1; AHgh+Rrys7wKzYOEyoE2YEeE+ZNp9UINNOQS0W+5TFtBz7KzY9Gm6b5U65bXChm33VqVMA4D+OU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwClvJFbcBC7oVWENsOjaiArO+IpAsqlkQGYl4mDJ1crV7WZlUY
	M62MI9OgiSh8VJCDG5MsC1k/9B/ZODG/ZItRSzxJjusfiWisrXlm8JDQLqpnlbuYg6k=
X-Gm-Gg: AR+sD10r+1IOyHDShBHYGeJ54mQavIhD99qYVtNkPPd8mWkX3DaouILbsa3VrA327Xs
	oGx+usRal/GSipq/87vr9QwC5xBnMdk3qvY1d098wlQdfgIEdB6q+INB7IzhZFeHmArFd9PZnzG
	F1+zCid5ltPcG2mT+ByBydgMR/ut3QqMIMqocxCyH2CdgOkteB4MlXBb3IvfCp2tHKDnbifoXmH
	bmuXIk4CrjazMnTqhlq5i0jqOBjFe3Y7KCtv1RwGfZJdvVIiwGSstBlia46PS9QTaYpPTCNN9YT
	Ac83rzir9PAw72mvq1hjpDOXEdIvsOkUScQ0e6EapktZ4gqPdpAY3tyGVQCEiYf1+kh/OToNKnn
	B+E0fIk4DiON6vs/xuRE2MJNqGUDez+pZGgYYJ6hS9+AYuq0sYmBShN0poJhiv5MWgD1fAee55R
	VBJbJZ6kVQ0Klszg6r9QIADj5hDArv/wmvW8AWkdZ5/uO2YIizTcMcu4sqlDf4GtPD8nqjSA4wx
	Od9kA==
X-Received: by 2002:a05:600c:1f86:b0:499:52ab:a50c with SMTP id 5b1f17b1804b1-49952aba5b3mr163509935e9.1.1786091403124;
        Fri, 07 Aug 2026 01:30:03 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021e8c5asm4085508f8f.18.2026.08.07.01.30.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2026 01:30:02 -0700 (PDT)
Message-ID: <71b4a5c6-33d5-4d7f-9378-7f913143d0f8@linaro.org>
Date: Fri, 7 Aug 2026 09:30:01 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/3] perf/core: sched_task() dispatch and branch entry
 fixes
To: Puranjay Mohan <puranjay@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Usama Arif <usama.arif@linux.dev>,
 Will Deacon <will@kernel.org>, Anshuman Khandual
 <anshuman.khandual@arm.com>, Ravi Bangoria <ravi.bangoria@amd.com>,
 Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 x86@kernel.org, linux-perf-users@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>
References: <20260806135224.3267890-1-puranjay@kernel.org>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260806135224.3267890-1-puranjay@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 06/08/2026 14:52, Puranjay Mohan wrote:
> These three fixes were found while adding BRBE support for
> bpf_get_branch_snapshot() on arm64 and have been carried in that series
> since v1 [1]. They do not depend on it, so they go on their own from
> here; the version number continues from that series to avoid two
> numbering schemes for the same patches.
> 
> Patch 1 stops __perf_pmu_sched_task() passing a NULL pmu_ctx to
> pmu->sched_task(). armv8pmu_sched_task() is the only implementation that
> dereferences the argument, so the oops needs BRBE.
> 
> Patch 2 makes perf_pmu_sched_task() visit PMUs whose events are all
> CPU-wide. They are skipped today whenever the scheduled task has a perf
> event of its own, so branch records leak across task boundaries with
> perf record -b -a. intel_pmu_lbr_add() calls perf_sched_cb_inc()
> unconditionally, so x86 LBR is affected the same way.
> 
> Dropping the early return alone leaves both dispatch paths running for
> one case, so perf_ctx_sched_task_cb() gains a matching gate. The two
> could instead be collapsed into perf_pmu_sched_task() alone, since
> __perf_pmu_sched_task() already passes the same epc, but that would move
> the callback out of the perf_ctx_disable() window for every PMU rather
> than just that one case, which seemed like too much for a fix tagged for
> stable.
> 
> Patch 3 clears struct perf_branch_entry with a single struct assignment.
> perf_clear_branch_entry_bitfields() had drifted from the struct: new_type
> and priv were never cleared, and arm_pmuv3.c allocates the per-CPU branch
> stack with kmalloc().
> 
> Tested on a 128 CPU arm64 machine with BRBE. A WARN_ON_ONCE() at the gate
> patch 2 adds to perf_ctx_sched_task_cb() fires within seconds of running
> perf record -b -a alongside a task-bound event pinned to a different CPU.
> 
> Changes in v6:
> - Split the sched_task() fix into patches 1 and 2; the NULL dereference
>    and the missed dispatch are separate bugs with different reachability.
> - Gate perf_ctx_sched_task_cb() on cpc->task_epc. v5 removed the early
>    return in perf_pmu_sched_task() without it, so both paths ran for a
>    task whose event for that PMU is pinned to another CPU. Caught by the
>    WARN_ON_ONCE() described above.
> - Tag patches 1 and 2 for stable.
> - Send separately from the BRBE series, rebased onto tip perf/core.
> 
> [1] https://lore.kernel.org/all/20260616155716.2631508-1-puranjay@kernel.org/
> 
> Based on tip perf/core (f4dfab174244).
> 
> Puranjay Mohan (3):
>    perf/core: Fix NULL pmu_ctx passed to pmu->sched_task()
>    perf/core: Run sched_task() for PMUs with only CPU-wide events
>    perf/core: Clear the whole branch entry in perf_clear_branch_entry()
> 
>   arch/x86/events/amd/brs.c   |  2 +-
>   arch/x86/events/amd/lbr.c   |  2 +-
>   arch/x86/events/intel/lbr.c |  6 +++---
>   drivers/perf/arm_brbe.c     |  2 +-
>   include/linux/perf_event.h  | 16 ++--------------
>   kernel/events/core.c        | 15 +++++++++++----
>   6 files changed, 19 insertions(+), 24 deletions(-)
> 

Reviewed-by: James Clark <james.clark@linaro.org>

