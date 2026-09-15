Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEB73A5E6F
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 22:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789511958; cv=pass; b=TRUDQZ3b+vYGbQFS+3Lf5bmUoJLu6NJ+ZMcxI0WpzCBpUaalOhlWNdJ211jtJkEbJ0PA4CtvZzrDvZtESU6P4uCHm+S1WHl2w22z8stHvI/1aWp9AuqWjJqHZIWEeFR2Q3ZSOXPMXW9Nu6iA+pTjjxcH9poxTPvj8r/3pjzN8BA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789511958; c=relaxed/simple;
	bh=vJsCws3FamyI5nwIu6NR9CwJlE0an5auOcy5PUi3Br4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TyL+jH4gSdC/PzQRWKL+KCOTv+4mNGvgL+xdtiROtFeuNJZKnKintXTpoNFicjQnJSvaEsIfcJK88xNviU5JsUNtQIymSc8NwClItDy97ykpB3Pl3NO3oMGgbNNH0tSdFePtx1dUNpRz6D8Q8dhtUFKBdrId26W1waCBTsElSZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rxyFWca/; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rxyFWca/"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-53012819c04so48011cf.0
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 15:39:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789511955; cv=none;
        d=google.com; s=arc-20260327;
        b=aLDfMQW85Q9oO1U4rcIkU5H1Ccx6qIfKT+s7RqkxbNXwhdheqJqFjcpy8pSTT/9Cak
         E8Mz7RnQwYmhbsRb/XqZcck3hhRY0k8UUEK83sB9W2klCl4h+2qI8H5ceI+Xdip9IFr/
         vDLCjsUGt0/WXiXTlnJI36iAAXgfShO3hKI4JSD1eVm9Zu/sETcgwB1zRFsMGIB4VlWW
         v2kqTFddWG9lo+mrucpEDJ52nApyNo7wH88gFfQ57COrk4R2/YbxCpP4GATe4pYgfZqS
         Buf26Pkf9k+n1fJwJF82xFlHukEy9Wwp9YpHPblNtKc2NpdswQlmdI/0uIZt8Nxc7dW+
         1dBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vJsCws3FamyI5nwIu6NR9CwJlE0an5auOcy5PUi3Br4=;
        fh=C6RYNT034I2D9gRrJqAlp4Syx7vQzwItITeOLZc0+Rk=;
        b=satESK4jrPRuUmj8qMc4ZQLr+43j06iLlxg8VtQESCavLwHg/nApAyLsg35QlT23tH
         8YjQdZJK2uNSsrgAZfvhh89PxWmv1/UWguLXb25lqrHlmJ1k1f3qqiDa8rIK6ndXHXLH
         SWG3+e4DRs0aPNK5jnOCI1659NZG2ZBH7P7ElaN7kF2Ubll+GA0umGuaQlQPxy1RiTK2
         R2MzxLHOZ9Qnn6T9cGixy6NyA8eRB/zX8SSGjUfSFD4G5Qb2YMnTR3hHbDq10DO6S/g3
         JlyhC+tl+1Wo48kHwbIHOh6UxKqrc8DspMh8PYA2PtZOFx7PiSjTKVaVH6IVzsS8xnju
         1xzw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789511955; x=1790116755; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vJsCws3FamyI5nwIu6NR9CwJlE0an5auOcy5PUi3Br4=;
        b=rxyFWca/nEoQjYXMPfAHyf9F1FN3x7rz6dtzEER14eDiw4UDqHIY7juAsfbLvmbPmJ
         TkDG0O2fJ4T/8b/PM7X2oHanauKcsNZFL+/1C+IBusrmvZP5qtYyTRey1vhqFdIyIzGV
         4dwM3FCfXXVPiqyqDkz92vVO5b169ErAe+Gf8uKsj7yOvBDnCxCqYnVbW+MzxwzddyhT
         tH9xI6GNS3A/qwOPzIVt3mWJ/xizDXVAPsbfgAWkEBOjnu90Z0L5ShniO9r/F8wpLbxS
         E2edOgTa27PKYtmnnDYuMkkuSzbwMlqwza1WkEL4Io3+palVNcRZgYe+WUkx9JeikXu/
         wGdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789511955; x=1790116755;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vJsCws3FamyI5nwIu6NR9CwJlE0an5auOcy5PUi3Br4=;
        b=njNv2QPX0bgT1L07JMQeG6o0+jseOiac9ekAqKQA/lXb2ooGOIOQP5+vrHjnUmw2bg
         0RjLTwtYdQHLNCjfKnJ1lNIAHeAXN6X12LmS1o4dcaTSM4npYeh8SBKBSLuj81Rdw/HN
         dxgewwM7DNNtSSqLtpp3nwp3ojb3Aab8FHUrSJoIImHfNE/fMqSeZSs6fSegcFzRRM7C
         1EzslIYR3DrVvfv/uG0z8Vx5pZIz4DYM/yyxGIQtFOLGtalLcQq0o3/vruRpDwUKFpvw
         pG+lQ4pVHM/S/wgQUyx/BTHfPYWm7MzzQKEnZoiu5fidtbMc5r8Or9cuOZtP86lVAbIW
         2vyg==
X-Forwarded-Encrypted: i=1; AKwUvBzasqtAFtZTdRYkPhEusO250nq+Ft3sDVsu1Y3EshV07H4a/rEtbICpQB0CJTtwttHfv88=@vger.kernel.org
X-Gm-Message-State: AFuF++mdhIhWoYNERBuXyebbBnKc/yv+7JBtSnHUnkFerbYrTjvCQEOR
	4ZrjcuhaafrdVt+wZBPvqZHEZIiQmZXzt9GdvjOIOS0LPB+7XixkgHAeFx3pWhW8IuUhG4ezrHx
	r7E005vH09r4FxCzqElu5ZlFXqQPMri6ylJmSUij9
X-Gm-Gg: AYBFou1StdykVTbdh/mqtZzM4A7nfyd24v5cSHpMaegsAdpl1j7fL4IKnX8cbuHMQ/d
	MgOZWj3OAT3A2rqWxepiNTRXREcpaKFrULifFl9kWCSZvYnnHNE5UgaCgwfy3phiwdmZqaWGBVf
	uB0EsaKraS5tJh4uNRj1k7Anz7kzipwV9htazL6m6aOy6cUT68vMLzOYTMJq8Y1IhK7RC0JQjlQ
	sqrwiXYk6pFZhwaHsvNjP5ZFjre/gTN7oj1/hZ2x85PW6z2Z9dksAJ3H2xI69wR6ZXux+COT/+2
	O1Tt+foBprhrvY+WKPsbxQrPOlDw1B0KyDY0Fp2hMZ1f4uucR2zeQVnq31zUfk5G7MN96mxBpUv
	IyOJJYcniMmr2TIwC+4JP
X-Received: by 2002:a05:622a:4d8c:b0:531:34b9:2532 with SMTP id
 d75a77b69052e-5327ed8004emr2058291cf.4.1789511954807; Tue, 15 Sep 2026
 15:39:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810133540.1947118-1-puranjay@kernel.org> <4f755a7f-0a55-4292-892a-28346ed235a4@huawei.com>
In-Reply-To: <4f755a7f-0a55-4292-892a-28346ed235a4@huawei.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 15 Sep 2026 15:39:03 -0700
X-Gm-Features: AcwNN1VJtEici--U7gAI-B9LpTV32UhMFNQSbZNGUEhTbibENqFgMN18MX5xm4g
Message-ID: <CAP-5=fUepMzyctDcUqYNJMG+xBOK0bdUF_cXPtQ43AxfFVL+Zw@mail.gmail.com>
Subject: Re: [PATCH v7 0/3] perf/core: sched_task() dispatch and branch entry fixes
To: wuyifan <wuyifan50@huawei.com>, Puranjay Mohan <puranjay@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Usama Arif <usama.arif@linux.dev>, Will Deacon <will@kernel.org>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Thomas Gleixner <tglx@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 7:45=E2=80=AFPM wuyifan <wuyifan50@huawei.com> wrote=
:
>
> Hi Puranjay,
>
> On 8/10/2026 9:35 PM, Puranjay Mohan wrote:
> > These three fixes were found while adding BRBE support for
> > bpf_get_branch_snapshot() on arm64 and were carried in that series unti=
l
> > v6 [1]. They do not depend on it, so they go on their own; the version
> > number continues from that series to avoid two numbering schemes for th=
e
> > same patches.
> perf record -C <cpu> -b [<command>] triggers a NULL pointer dereference
> in armv8pmu_sched_task().
>
> Commit fa9d27773873 ("perf: arm_pmu: Kill last use of per-CPU cpu_armpmu
> pointer") changed armv8pmu_sched_task() from reading the per-CPU
> cpu_armpmu variable to dereferencing pmu_ctx->pmu via
> to_arm_pmu(pmu_ctx->pmu). Meanwhile, commit bd2756811766 ("perf:
> Rewrite core context handling") made __perf_pmu_sched_task() pass
> cpc->task_epc to pmu->sched_task(). cpc->task_epc is only non-NULL
> while a task context is scheduled in; CPU-bound events do not schedule a
> task context, so cpc->task_epc stays NULL. The NULL argument is dereferen=
ced
> and crashes.
>
> With the patches applied, perf record -C <cpu> -b no longer crashes,
> and system-wide perf record -b -e <event> -a alongside a task-bound event
> on a different CPU runs without any WARN_ON.
>
> Tested-by: Yifan Wu <wuyifan50@huawei.com>

Hi,

Is there anything that needs doing to land this series? Avoiding a
perf crash seems worthwhile. I believe Peter and Ingo are best placed
to review the changes to kernel/events/core.c.

Thanks,
Ian
