Received: from mail-pj2-f3.google.com (mail-pj2-f3.google.com [74.125.227.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08501368D42
	for <bpf@vger.kernel.org>; Tue,  7 Jul 2026 23:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783466849; cv=none; b=aUM9ukzT64zzDyPRXhsAWjY57PnjYk71rKabwOIU9mWvAWZSgMJXrYQsyjGoD1OBrdjfe23D/qlrTXkXVQx+oSsjexD6WYGL7jra/Y6PeKAgzxVdhApqmE4ZGyY+DCHO+pyPd5ToKHz524zAsrCuSkKI5pcC7yt8Nswn9cVJO38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783466849; c=relaxed/simple;
	bh=yA65Igpc+/M9ffsQdYKBxXcWm6tKgX2mDaX/USRFioE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rk57L0EOw1fLkr1N/WNyByIvFs9LWTusWz10Rod44m+frGV8CaTl4TZmnZUcqhWB68+h2AoU131suBt8LTXbkmFGVkPDnHrdanXikDEmQGLhPWx//T9IGS2J6VHb2D1ps2l42xNvgEp4poKdCMlmDpQ3tZk1Zlt4Jn8FSlW3ytE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IvdJGdbm; arc=none smtp.client-ip=74.125.227.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IvdJGdbm"
Received: by mail-pj2-f3.google.com with SMTP id 98e67ed59e1d1-380755c89e4so33181a91.1
        for <bpf@vger.kernel.org>; Tue, 07 Jul 2026 16:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783466847; x=1784071647; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=056knz1SGCh1gABAXpDMbPSHV+jE2HKWxGqRP9xXJ6k=;
        b=IvdJGdbm+NiCNZG7vXX+BfO6O9eQhpxmLH9edApPjC41yf4mk9D2G6GqVwFG0LflPC
         Z3jd2FAVDgQL3zBAHMbMseHS/4dTardOUoi0k8WNO2oCuRwsA/cEswRD36RQ8cw8Fdd1
         yEZWwhd9Nn8LyjNRSigMjKMZRCAuyilhLNn2XNtZ99Il8T7df9UpHioylAq9FEgfYoeY
         rkTttAEIXIzXr7hOGmPSiWTHMxrcMBee/nh7phM7My+63IX0d9rkYHkhTAPuradmSpZK
         Vn+/vNP1V0OG7vmgQoH4rejeCOpCn1jXyiLDzUn6seZRKEqY27JsWYKsWDXVJx2KN1ac
         9gJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783466847; x=1784071647;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=056knz1SGCh1gABAXpDMbPSHV+jE2HKWxGqRP9xXJ6k=;
        b=GmI271Xe7LtkkkcxmNRjUGxGJ/bR06Bg5cAJpWVkuLJbS4LfinwbiE5yYy81lbNZun
         CLi62M02PQocgSSKwFXKRQz8ca/oXhQl0/cwgR/KUiNedenMGaL6lqav0wVF64DenyVg
         nRYNWrngcje8fpuA05m8JS+mh/IKeRVRw5bJkWZpTHE46fDNLvcugPr6TxnkfJIiYP9r
         PCH74fEv/36X/BnqtC9dzG4vrGUAy0KXhNfCtbidc1PkXoM/eoZMl5wLzYoLWkYkNhcR
         M/GAygXQzYEek6I/+B1a/tvt18dTD7MvVK5es603XviS1o5CjDZIJ2ibpZ8aLEUON9cf
         CCRA==
X-Forwarded-Encrypted: i=1; AHgh+RphEG++BNK8SjUXNrmw1NWzjT3387AuIljFIcSk+2VbrhavgVL5zCQF5oCWILtmOnKM7sI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5Gr4qOdqir+Uaj2evWxWK66bIs0dYEAh3X+fBelfSiR+mmOXX
	+1M5BvW5yAk4mpC3vYofZXZWZVC1a3IVWNhTaqGwH+IntaZtFpIZ4+D4/fc/VrWSpUQ=
X-Gm-Gg: AfdE7clcS6PqbKtI15P91fn7P/lpLfgOx+IPeJ5tuaVIaB0WPlbmr3QViN58i+NaMnl
	KArKbu0LfnqgfrIKmXTVFUq24rFVz/AmkPWu7bIZHSD3UaxBhiE9Hxtuj9gllWSQhjE7axEOLy1
	rrET/i4kE0KClMuyu9kCWtav7lbn3gu1XSxkLP5rzOW9r20XG30qQGtdIqYl64y4Uglto6iq5Hl
	MvXlAt33z/CYLUz1QkNFX1fLIGEFHHNCtlrzMKE7xpmxdsXR+0jFRn2qMVNzHEQp16NWYFPEFYS
	2kZ03UEXQ5Wh6PBkpnfQLYxRIU3KIbcue+A3wOVCsjgLkb0TI6TSI4rF3mdC09yVZ2iodh8UTyU
	PX10kSHDgbNIw9JgeY7/BEuODcX9vqvA03t7hbUwOewIP3DN9wh3LCxfj73F7exCKWz25vnVFKC
	/yzAoPhCnkEqanSTDqsuUyLJP/j7wE38ZW
X-Received: by 2002:a05:6300:6186:b0:3bf:6c08:2b27 with SMTP id adf61e73a8af0-3c08eef1138mr7948741637.47.1783466847249;
        Tue, 07 Jul 2026 16:27:27 -0700 (PDT)
Received: from devvm16600.scu0.facebook.com ([2a03:2880:9ff:63::])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b6594f9a0sm13570646c88.4.2026.07.07.16.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 16:27:26 -0700 (PDT)
Date: Tue, 7 Jul 2026 16:27:24 -0700
From: Ziyang Men <ziyang.meme@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>, Ziyang Men <ziyang.meme@gmail.com>,
	Roman Gushchin <roman.gushchin@linux.dev>, kernel-team@meta.com,
	linux-mm@kvack.org, cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] selftests/bpf: compare BPF and memory.stat memcg
 stat readers
Message-ID: <ak2LXDWoPFSJL2Q9@devvm16600.scu0.facebook.com>
References: <20260704045617.487664-1-ziyang.meme@gmail.com>
 <bc12730fe6eccde10d36e6544607ae2464357e05.camel@gmail.com>
 <akxW5dzvR9e2CfGq@linux.dev>
 <eccfd9a8dd1af1668e142b9b866194333647b0d5.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eccfd9a8dd1af1668e142b9b866194333647b0d5.camel@gmail.com>

On Tue, Jul 07, 2026 at 02:21:59AM -0700, Eduard Zingerman wrote:
>On Mon, 2026-07-06 at 18:50 -0700, Shakeel Butt wrote:
>> On Mon, Jul 06, 2026 at 05:17:50PM -0700, Eduard Zingerman wrote:
>> > On Fri, 2026-07-03 at 21:56 -0700, Ziyang Men wrote:
>> >
>> > [...]
>> >
>> > Hi Ziyang,
>> >
>> > I'm a bit hesitant adding 2.5K lines of code to the BPF selftests,
>> > as this code would need to be (a) maintained, (b) run at each CI invocation.
>> > Hence, the tests added need to be relevant for the BPF sub-system.
>> >
>> > Regarding the benchmarking part, as you state yourself:
>> >
>> >   > In my testing (a 60-CPU VM) the BPF path is roughly an order of magnitude
>> >   > faster than the per-cgroup memory.stat parse for a whole-tree scan, mainly
>> >   > because it avoids the per-cgroup open/read and string parsing.
>> >
>> > With this, I think the benchmarking code can be dropped altogether.
>> >
>> > Next, the three memcg_stat_{reader,churn,churn_percpu}.c files share a
>> > lot of utility code almost verbatim (e.g. tree definition/construction).
>> > Such duplication should be avoided.
>> >
>> > Finally, from the BPF point of view the test exercises the following functionality:
>> > - kfuncs:
>> >   - bpf_mem_cgroup_page_state
>> >   - bpf_mem_cgroup_vm_events
>> >   - bpf_put_mem_cgroup
>> >   - bpf_get_mem_cgroup
>> > - main iterator logic.
>> >
>> > All kfuncs but bpf_get_mem_cgroup() are thin wrappers around mm/memcontrol.c code,
>> > all kfuncs including the bpf_get_mem_cgroup() are already exercised in the selftests.
>> > The iterator logic itself is covered by 8 sub-tests in the prog_tests/cgroup_iter.c.
>> > Hence two questions:
>> > - What do these new tests add in terms of tests coverage?
>> > - Why do BPF selftests need to exercise the churn and churn_percpu scenarios?
>> >
>> > Shakeel, could you please comment as well?
>>
>> Hi Eduard,
>>
>> Thanks a lot for taking a look. The main motivation I had behind requesting
>> Ziyang to send this series (beside making him learn the tooling and process of
>> sending patches to lkml) was to have a reference implementation and performance
>> comparison for BPF based cgroup/memcg stats collection.
>>
>> However you have correctly pointed out that selftests might not be the right
>> place for such kind of code as selftests are more focused on functional tests
>> and run by a lot of CIs while this is a performance benchmarking code.
>>
>> I am wondering if there is a place for this benchmarking code in kernel under
>> tools folder but archiving it on lkml might be good enough and should be easily
>> searchable. Anyways thanks again for your time.
>
>Hi Shakeel,
>
>We do have bpf benchmarks in the kernel tree, the entry point is
>tools/testing/selftests/bpf/bench.c. These are supposed to be
>performance measurements and are executed manually from time to time
>(quite rarely, as far as I understand), not by CI.
>However, if I understand Ziyang's assessment correctly, this code is
>not really a performance test, but kind of a load test.
>
>Thanks,
>Eduard

Hi Eduard,

Thanks a lot for the review. Yes, as Shakeel mentioned, the performance
comparison for BPF-based cgroup stats collection was the original motivation.
But the patch also carries functional value: alongside that comparison, it
checks the correctness of the stats the kfuncs return.

Let me first answer the main question -- what these tests add over what we
already have -- and then lay out a plan.

First, the static test (memcg_stat_reader) vs the existing cgroup_iter_memcg.

The existing test calls the kfuncs, but for each value it only checks whether it
is greater than zero. For example, in prog_tests/cgroup_iter_memcg.c:

     memset(map, 1, len);                    /* dirty some anon */
     if (!ASSERT_OK(read_stats(link), "read stats"))
             goto cleanup;
     ASSERT_GT(memcg_query->nr_anon_mapped, 0, "final anon mapped val");

It never checks the value is actually correct -- i.e. compares it against the
value in cgroupfs -- only that it is non-zero.

Besides, it also walks a single cgroup:

     .cgroup.order = BPF_CGROUP_ITER_SELF_ONLY,

and reads only five fields.

The memcg_stat_reader in this patch adds three things:

   1. It compares the numbers. It reads the stats through the kfuncs and checks
      they match the values in memory.stat, instead of only checking they are
      non-zero (memcg_stat_reader.c, check_correctness()):

         /*
          * anon (NR_ANON_MAPPED) is rstat-flushed and, with the charger
          * stopped, deterministic: BPF and memory.stat must agree.
          */
         if ((b.anon > f.anon ? b.anon - f.anon
                              : f.anon - b.anon) > anon_tol)
                 anon_mism++;
         ...
         ASSERT_EQ(anon_mism, 0, "bpf vs file anon (rstat-flushed)");

      This is the main gap: b.anon comes from the kfunc, f.anon from parsing
      memory.stat, and the test requires them to agree.

   2. It covers a whole subtree, not a single cgroup:

         linfo.cgroup.order = BPF_CGROUP_ITER_DESCENDANTS_PRE;

   3. It reads a much broader field set (~40 fields, collect_full_stats()).
      Minor.

Second, the churn test adds something the static test cannot.

These counters are kept separately on each CPU for speed, and are only added
together when the code "flushes" them. The existing test does call the flush,
right before reading (progs/cgroup_iter_memcg.c):

     bpf_mem_cgroup_flush_stats(memcg);
     memcg_query.nr_anon_mapped = bpf_mem_cgroup_page_state(
             memcg, bpf_core_enum_value(enum node_stat_item, NR_ANON_MAPPED));

But if the cgroup is idle there is nothing to add up, so the flush does no real
work -- and since the result is only checked for non-zero, nothing verifies the
flush gathered anything. If bpf_mem_cgroup_flush_stats() were replaced by an
empty stub, this test would very likely still pass (the kernel also flushes on
its own, periodically and on thresholds).

With activity going on, especially spread across several CPUs, we can make the
flush do real work and then check it by comparing the numbers after the activity
stops. That flush check is missing from all of the current tests, and this is
where memcg_stat_churn / churn_percpu come in.

Finally, my plan:

   1. Keep the static (value-correctness) test, or fold it into cgroup_iter_memcg
      if that works better. I also noticed that several kfuncs are not called by
       any test today (no callers anywhere under tools/testing/selftests/bpf/,
       only __ksym declarations in vmlinux.h): bpf_get_root_mem_cgroup,
       bpf_mem_cgroup_usage, and bpf_mem_cgroup_memory_events. The static test
       would be a good place to cover them too.

   2. Keep only one of the two churn tests -- most likely the per-CPU one, since
      it is the stronger of the two -- and change its correctness check to
      actually verify the flush by comparing the numbers. The current check is
      weak; it only checks non-zero values and that every cgroup was visited:

         ASSERT_EQ(missing, 0, "all cgroups present in map");
         ASSERT_GT(total_anon, 0, "tree carries anon under churn");

   3. Move the code these tests share into a common header, to remove the
      duplication you pointed out. Or we can combine these two tests into a
      single one if works better.

   4. Keep the focus on functional testing in the selftests. The file-vs-BPF
      timing could stay as an extra bonus -- printed only as informational
      output in verbose mode, never as pass/fail -- but I'm happy to move that
      comparison to the bench framework if you think it fits better there.

Please let me know if you have any concerns with this plan. I am happy to take
any suggestions on how to improve the tests, or to change the focus of the
selftests

Thanks again,
Ziyang

