Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C674A3F1C
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 20:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790109255; cv=pass; b=Bkt9W/85iYuFe3GA21S3ofPt4E6zTNfGgjPh+15/Sx8Prqtd2Mh0RHZvohZw6SmPhESVB09Czcs/97JPSimRkqoslXAzhYiJIUGpNhxFIw/1Wny2ZO7uxGN/A5CEClyosuDa4YjGrbtOyTgo1famqnRFO9hFdFaOEKu/oF+mgYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790109255; c=relaxed/simple;
	bh=XxcnKx8aTyQRysco9yob8teG0Hm7pIWhDCbbc7ogXSM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NwGKcUlRORc5rSwLnO21yt/aYmRrk4RdIJ1C0C3WY3T1SSkXr6U6gfsru6v87RgyAAZN3ahxBvcHmGNTswFhmhXad2iqEq729oOrJhKC/qaJ5QuQXtA5DfJoJPyth1PVODKwDBlWly5DCDbeCfY61+KXUhvbzK1HsY5qtRSMXS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b2B9VLDB; arc=pass smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b2B9VLDB"
Received: by mail-pj2-f42.google.com with SMTP id 98e67ed59e1d1-396ccafb74fso231932a91.3
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 13:34:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790109247; cv=none;
        d=google.com; s=arc-20260327;
        b=YCb214OmwxatncopunGg3FMl8OZlrtDbhe3P90HiSQ7gz6REaBIa4gFLCXzST1AgLE
         gzFg/D8K8hTQWQgfBEw9rFaj9HU9oEEBsBbu4lDWG0VcfDB7xcHfj0a3s1nmdgraSr1N
         6OOP7wzoyLssQ8CUoe8lqRoHHyQ1cEWvWP8im+atiqTwZUTXOuBBtjRryN6FRjcgejTq
         LZvOXNEKvCS1Xv4rdZrjX+uBs9YCJ0jKkov5+3BesIBo5QFgrQbXthv7MBdtheNcgoMJ
         B7fNlvOGL811b7JDRR/WKdkzx7vg33/NKn4QEDY59mw0qP0nwMGcQoIc2531bW/811LV
         i5WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XxcnKx8aTyQRysco9yob8teG0Hm7pIWhDCbbc7ogXSM=;
        fh=y+uHn1fHH9qJp4/BqsR1dbaXs55kPEGYAyjkjmKL32A=;
        b=dbpDU83+dgZEWcu00u7F5Wuc6hALRZwbBmatsSdwgCzcaqWDQ38Nt1suLf+Ijs72oA
         AOa5BMBqfpF1TOXDLGKQWgV127rO2ujt3CsbWT/cjaWLEhNnycMnQvh7Q6aKaKKQu/JH
         bLG247tGlg41r6SLuA621b2U5lasF9SZsMrPYohndZaZTQe+lcKLkFXqn2daHw/DelUU
         2sf220UTkEzWb4B/yiNkvVsLY4oomrdicsLncDgabcI6re+pibdncSVugV/+3mkAc8Ko
         DWW3bqvXvs6T0O/hlCwOduJKvNt6dfcMm6VSI8VUkaVVHeaWQtU68mHOFB9s0fD8uLGU
         IlCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790109247; x=1790714047; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XxcnKx8aTyQRysco9yob8teG0Hm7pIWhDCbbc7ogXSM=;
        b=b2B9VLDBhB9/kDZFcqYet14QEct3vAWrNBGYUGDVra9qfDJ9RqFq6mtqry9ZHwl/yR
         SWRRsgblCDH+n+EcE9SK80q1tUCx0cfW/BDaYQoANVjqKo6uetl5lDKCkYHsQ/H6Xetg
         CisWWuJkr62mKIQimU1j3lw0VNN42wGD7LW/RqHRjM37UU/czUL6RSgp1y+uuH6NXyG2
         tD/MnnbhlfrBYTCg5K7ea85lJKjH/yKCBHZw7DSHqNDKd3fi52tB4jiBCziSFheiyznR
         tXp1CLnBK6RrdsA4muGgVktTFvSQGjMB9tlpkZ/G9/Z5HGuUtDmM0l/n0if4r8y1f5eO
         /kiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790109247; x=1790714047;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XxcnKx8aTyQRysco9yob8teG0Hm7pIWhDCbbc7ogXSM=;
        b=wv5OXpuKJ36WKNtK0hIUPGKaq3RngKLT1lNiL0qLjpl7vWgL3DTatgQ1l5bMt+s0WS
         cwuAhgyJQ2GjCCl3L0o8RQ1HwWHf8hGpapL6tjJowXfCMn+T3Sv/Sx/fpF164IOgyQ7+
         P+7EFJu5fGyQ3OhdSe6h0OdyYQwEzZLhXfe544VFWhAu4UbzOhpJGuqr2mk5X7EOK1+s
         F4taLw9//5SabndN8MrbUn3fsdJ3omSbQt2vjqEak5l+oQAKNmMzT+wkoK/bgwovX9GU
         NchGtFW8g94nZBiwGXkRxWepfQWDtL0QEZ7DpT64uaC/zuRVEOtJ9DP6p+HTopjUlg8w
         Q8NQ==
X-Forwarded-Encrypted: i=1; AKwUvBw7GndwBCCpHUEj5mm96SFa1d6kHuks1o/i9S59KrhX8p7289/NtfuABwqFWrxotggbVOw=@vger.kernel.org
X-Gm-Message-State: AFuF++n3yHtCncWTZEcO75RecrE7hdJqwgh+F+uamKwDc9ny3o744jzn
	qcfuDnIEx13dh9I0StJusudtrE/5+eIVZvPVs5bRKrbeLvhv1vj2PyRUP1CS+sadK7hjwwypC16
	dPXH3ioEPAv8oR5B5HmmE/+5rCNFlnAA=
X-Gm-Gg: AYBFou2W2pH2gvRKMrGTviGW2faakznoENq1sjsdMrS2zekA53Mrw2jUtMN4264Ll8I
	NGqyH6Dg+Dyfun3VR9ZWfAVhUsFzyJ3H7MaFgtl9csY9Y30B5AmCoVb7Dvg+lJsFEOb/i6KA0LI
	vsgD2Qu59JHcTWj+GTjejdzjnFBNWlLXT6zy5VYfd4D/5AkwCnPS/97+3fJFy3FNMxQ2LSoTgmk
	PQ39nQqd75ZgIzYIcjve4RrNEqYtu5v6jBdl1eAoRGBEvVjqdm6XCVaBnXE9jrFhRXYiolkbcpx
	3u3AWSF7g3syzIk3OI2MH/G7t5Pm98I5B7KyY/P8wKuqzRciEzLjixLJDGU/0QXxmpt+utAU0+P
	TIqyGJzACtbFW6EgQDRBJZiEaE6Rq9KZH0a3v/2byvW+kfSiuPoi7q3mwCMJDOqs=
X-Received: by 2002:a17:90b:4a45:b0:39e:2530:2102 with SMTP id
 98e67ed59e1d1-3a07e56552cmr499070a91.11.1790109247222; Tue, 22 Sep 2026
 13:34:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810133540.1947118-1-puranjay@kernel.org> <4f755a7f-0a55-4292-892a-28346ed235a4@huawei.com>
 <CAP-5=fUepMzyctDcUqYNJMG+xBOK0bdUF_cXPtQ43AxfFVL+Zw@mail.gmail.com>
In-Reply-To: <CAP-5=fUepMzyctDcUqYNJMG+xBOK0bdUF_cXPtQ43AxfFVL+Zw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 22 Sep 2026 13:33:52 -0700
X-Gm-Features: AcwNN1WthkF5BlZ1QMNrqoVSwR9HYVD5IHCsPcWIws_60KwDdxRC38bx-LOITwg
Message-ID: <CAEf4BzZZOqFvSfjp7YMAvEabQSrziv7j26P_SRwMczKf56WZ4A@mail.gmail.com>
Subject: Re: [PATCH v7 0/3] perf/core: sched_task() dispatch and branch entry fixes
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: wuyifan <wuyifan50@huawei.com>, Ian Rogers <irogers@google.com>, 
	Puranjay Mohan <puranjay@kernel.org>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
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

On Tue, Sep 15, 2026 at 3:47=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Thu, Sep 3, 2026 at 7:45=E2=80=AFPM wuyifan <wuyifan50@huawei.com> wro=
te:
> >
> > Hi Puranjay,
> >
> > On 8/10/2026 9:35 PM, Puranjay Mohan wrote:
> > > These three fixes were found while adding BRBE support for
> > > bpf_get_branch_snapshot() on arm64 and were carried in that series un=
til
> > > v6 [1]. They do not depend on it, so they go on their own; the versio=
n
> > > number continues from that series to avoid two numbering schemes for =
the
> > > same patches.
> > perf record -C <cpu> -b [<command>] triggers a NULL pointer dereference
> > in armv8pmu_sched_task().
> >
> > Commit fa9d27773873 ("perf: arm_pmu: Kill last use of per-CPU cpu_armpm=
u
> > pointer") changed armv8pmu_sched_task() from reading the per-CPU
> > cpu_armpmu variable to dereferencing pmu_ctx->pmu via
> > to_arm_pmu(pmu_ctx->pmu). Meanwhile, commit bd2756811766 ("perf:
> > Rewrite core context handling") made __perf_pmu_sched_task() pass
> > cpc->task_epc to pmu->sched_task(). cpc->task_epc is only non-NULL
> > while a task context is scheduled in; CPU-bound events do not schedule =
a
> > task context, so cpc->task_epc stays NULL. The NULL argument is derefer=
enced
> > and crashes.
> >
> > With the patches applied, perf record -C <cpu> -b no longer crashes,
> > and system-wide perf record -b -e <event> -a alongside a task-bound eve=
nt
> > on a different CPU runs without any WARN_ON.
> >
> > Tested-by: Yifan Wu <wuyifan50@huawei.com>
>
> Hi,
>
> Is there anything that needs doing to land this series? Avoiding a
> perf crash seems worthwhile. I believe Peter and Ingo are best placed
> to review the changes to kernel/events/core.c.
>

another ping... seems like worthwhile problems to fix

> Thanks,
> Ian
>
