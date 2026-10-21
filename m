Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.225.74
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792562724;
	b=LkT4nwrfJNCv4AlhNXhftPN4a/DOifLniZLi5zgXlsbKTBa5CX9+YGmgOiVL28CgyvrA
	 z+d7blnB+L6sVI1BZ/O+XUu6PUv2Xm8dYheDt+VWcsvEM1uAxpBlmg7C6ZygmOw7RhY5e
	 3j82OkYsOn/1gofk2By+zC5YzdWcfYUTKbDCrcgst9eJkmnBkCv9HotRBGNdhB6NSflyU
	 9rKpoUw39O3OQF+MeNlbK6UiDGESDR6U/tPXLFhSQeiS4Nx7sKrZQnGSwC9lKQYBCDZtK
	 kvSlh8YDSZ+x36fach4CaHOEWY+5QeDInF17AdAAec59HzDFCu09UWgHIJO15yeoCOA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792562724;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=pBw4LUv5P6dBy/YmrFxEgRkn5dzedDU5Ft5Mq0UqENs=;
	b=J7miahpW7PMM0dOmMHpPCvi2Ui0HpKgJE81vRo7963GdrbnTXes5Wr/e95jtJclMwdfd
	 Cribr0rpTEjn8mEk3Wv24k2E8+nhwTO/2WJdzvLnv7VGvrRcUiNAIvpfGFxu/Lj9e6ozM
	 mFr4ojlSj6nymA5evvZoOc/I0k2BhEHzeL2Wj8LdhNV8jBD+YFqla45/DgyRKaTyPZr64
	 0vR1Sioi5KNsoyiD+/ZuptqBSeQhMxqlMpTYBs8snLutoYDIOOYCvUZh7rFcPhASNBlRe
	 tmO8frC9sBmywldQ6W7aFFHpYQHFkVXNPsMEe5ew1O37UeeQ7k6VtpGWJneApV0Bw6g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WfR3XGo3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.225.74
Received: from mail-wr2-f10.google.com (mail-wr2-f10.google.com [74.125.225.74])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948DA60A260E
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 06:05:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 948DA60A260E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WfR3XGo3
Received: by mail-wr2-f10.google.com with SMTP id ffacd0b85a97d-48afdb491b1so97742f8f.1
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 23:05:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792562722; cv=none;
        d=google.com; s=arc-20260327;
        b=H5fRhHEE9XpNKvz8Nrnsnep2kNwMrp/tGLVGECpjwkyxg89QmBXYct6jFlw1E3rdzz
         VmxgG/mdvN5Sm2v3nvDkKAP23xvwf5ZkM90HVlVpyRkOFdiP5bk4YUosF72hupXk1VGi
         qM2ACQ8MlLUGrn/BgwUj5rLF9nrJKul2FJRZqhVHhVikpph8thbYVVrcLDEZGB2Tfwrs
         V4w/VsFfuave6zvbV34kpL2LXkE90o2oCjZjfw6uNtm9XzHVE4bUhjhWV6MAgTffdlrz
         oZjDmv6c0xPvE5kJ2ajBDM/Vm6ZYSoiDDoyD0KcdnSf0XeoXJanttPs9ZXDLvJIC4+mb
         /ZDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=pBw4LUv5P6dBy/YmrFxEgRkn5dzedDU5Ft5Mq0UqENs=;
        fh=X0Q42DI+2Ce2l/3alhHh70tj+zoKPp6axtZp9qr8hiA=;
        b=fj773qS3sJUyuFi6xJvT7xciDZ60EafPB0uXj+jHbRSmVVXXP/3e8F2YM1XBGhJ6Ps
         eqz03b2VEojNT1PBVf3Z0FvCOXHemea65NWQhYQ911nx2A+t84DJAIyeVsIFKeXeLAzf
         ikQhWVldvJj0gWTrM1sWt4RtRwtlO26Jvedl5g8y/GhGwfkj4x6lPBj5pKN+AVfh1emu
         rDxHGR27Eul5xcU5Zbr+Kydm2ieVuexTxIBcw5i8elhIsd9hzBQXemRDaQcLpFxgsiSi
         pRJ9QMcNi05gvlxYAGEEvJKRV1ef6tEQd8/iyBpQciImZCj6CEA3wfOdmMFy/EcgkB5E
         9c7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792562722; x=1793167522; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pBw4LUv5P6dBy/YmrFxEgRkn5dzedDU5Ft5Mq0UqENs=;
        b=WfR3XGo3u0VUtB4FbiSFYnY2XHDpwY5Z/k+5Ybv3EVPpRdSiBzmS1BECsAUVsAaADn
         awhQzFuVJH+3VUdRO/h7l7VBOCRaTNyo8QP6AWpQoi+c6y5uZmBy4dHDRMF0oB9Ay/RD
         C4k/Q52c+wbeC12vu6+So4QDpmwN20u1IGWi9cdTm2oeWpYkj7Nfh4Bb1hZabqEvUaCJ
         mLesV/IRkLMVhgwnkEoBF+3SlMURhOIKok00pewk5a7ehdbF/oG+BHEFhC4GoY4WefuR
         tAdKfvD5Gpn0fChq1HuMNyIQ7PsZ6cGmKFFv3vVxfggSX8JbHtYYQ2ijwpllLcAzR0sG
         genQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792562722; x=1793167522;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pBw4LUv5P6dBy/YmrFxEgRkn5dzedDU5Ft5Mq0UqENs=;
        b=riT4AUUOaapu0uUdJ3XD41fdiFwTq58wxHpHHIsYKAxqvV8CqninCurZ0uxp3cTNMP
         J9jVZLdTKArvU9VXx+lQFo/3xsTVnc243fu+N0auF1E92BdVJpgiv8n7mVZZkY6kcYFi
         4dk0Esbb6P6amqtFQMjwbcUbFuOvNNnMwYtdzPFz2Zo4k1bWM6mdO+tQ3ufPO2g5Gh8j
         6KOcLQmDzKosEflph/IT87xeu7WZimDQY6//alNhorVbcjd81jctUhet2vUAjA+dIi85
         R0FBkMqpEGqRSN0EfsshQrP8fVj95LQmjRl/D+V7k+xi1gUXkcAgXuXFJ6FNGf7kpMBU
         Zngg==
X-Forwarded-Encrypted: i=1; AKwUvBxpjYmnOvO41OpCIZcpR8B2d3RaZtv6T2+lMzECIw4FysxiHHcqsybpWnlGVDKYpAg1+ak=@vger.kernel.org
X-Gm-Message-State: AFq9FYKNQNFe/yvoqcfAmOXyfN1l6vOy+RCQ32+1jU9kohecZ5JI4+H4
	c3FbXLAE66oVKHgWgDD5P4mHfuyX5ZVBcsM62+3jVVRZj2GS4jnzYP8FXvbos1Q8ENsnqPvte7H
	/Xm6K/9pVATtP1GRF0a4LnLStc8dIBFk=
X-Gm-Gg: AYBFou1zqGINh0wW0yPqvO0bSCNHFqnO9htftG+GXX8pZQWW98DqJvhnAEecJa4Q6Pj
	efWT31NalUhZHfgv8CrvSuns7W0X+f9YRqSyQsHrd27HtIyinclNM3KFyV9+DG/p7d86ePMoJMR
	lsiUUHVmJh+qF/Tj1a0Rrbp5ZSMN+lP1biXnc5pOpQl9w1fyh3NXs/AX+uE8PdJPMZ/n0hkpHQu
	MTzWRXyAjerRl0oj6uvw9Lh1O6YDtyD/DfsZm2Y/KX5DpQMTdncNgXUAzpBZRWD5+vNdshIMqZO
	9Gxfj+cejA3vIjx4t4O5a8Jj1c0iyNfrrPZL7TBy3xLaJutXaT1VlztJAJaipSGZFXAodNwc3NR
	PqDK3tpbCPKUig+VUA8/bv2SWY/RKMRvXkfs+K2/Wf52ei8e5cmnuSVw6zzGIJTWLnFkHePrNiT
	8/mjrATHvJrT8XiAtAJPYOfeQj5Kj9J5hYCMMwX0WPUPlS+lDIK8V+HAtrmVfR7Z4bDl1fVtcHY
	e3KSFkSZ4boiLM=
X-Received: by 2002:a05:6000:4549:b0:487:21be:dcc6 with SMTP id
 ffacd0b85a97d-48e264b2a0amr971173f8f.21.1792562721630; Tue, 20 Oct 2026
 23:05:21 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260723114042.559926-2-max@linux.ibm.com> <DK63HA8KEYWH.1W1W2IJEWEVRD@gmail.com>
 <ede5833e-59f1-40db-b72d-bef247a16f9e@linux.ibm.com> <0eca445a-d882-4821-b6f3-4ba124607ebc@linux.ibm.com>
 <CAP01T743ZYEDDTxQ=_R+3kUJ8xLjQnm8jAeDnkPmLpc4Df+pNg@mail.gmail.com> <0ce208ae-b229-4f94-94ae-74edf96f371c@linux.ibm.com>
In-Reply-To: <0ce208ae-b229-4f94-94ae-74edf96f371c@linux.ibm.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 21 Oct 2026 08:04:43 +0200
X-Gm-Features: AclHuK9jg52pa5SV3qEWCCAEYYTDjmAxDgqebIo0aj6r6UdDX9mQAcEEyr1MSto
Message-ID: <CAP01T76Ag2w9kVbLRn7qqKnDPivG31kTMiXbW=+CWaF78Ysn_Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix flaky refcount asserts in map_kptr_race
To: Maxim Khmelevskii <max@linux.ibm.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 19 Oct 2026 at 17:05, Maxim Khmelevskii <max@linux.ibm.com> wrote:
>
> On 19/10/2026 03:25, Kumar Kartikeya Dwivedi wrote:
> > On Thu, 15 Oct 2026 at 14:13, Maxim Khmelevskii <max@linux.ibm.com> wrote:
> >> On 13/08/2026 00:51, Maxim Khmelevskii wrote:
> >>> On 23/07/2026 18:34, Kumar Kartikeya Dwivedi wrote:
> >>>> On Thu Jul 23, 2026 at 1:40 PM CEST, Maxim Khmelevskii wrote:
> >>>>> bpf_testmod shares objects across tests; prog_test_struct that holds
> >>>>> cnt.refs.counter is one of them. Refcounter release is deferred behind
> >>>>> an RCU grace period, so it may still be pending when this test asserts.
> >>>>> wait_for_refs prevents flaky failures when other tests have
> >>>>> contaminated
> >>>>> the refcount.
> >>>>>
> >>>>> Fixed tests:
> >>>>>    - test_htab_leak
> >>>>>    - test_percpu_htab_leak
> >>>>>    - test_sk_ls_leak
> >>>>>
> >>>>> Reported-by: Ilya Leoshkevich <iii@linux.ibm.com>
> >>>>> Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
> >>>>> Signed-off-by: Maxim Khmelevskii <max@linux.ibm.com>
> >>>>> ---
> >>>> Wouldn't this still be flaky? Could we order these tests and wait for
> >>>> a RCU gp
> >>>> to pass before finishing each one? We have kern_sync_rcu(). Either
> >>>> way, I don't
> >>>> think the current approach is the right way forward.
> >>>>
> >>>> pw-bot: cr
> >>>>
> >>>>> .../testing/selftests/bpf/prog_tests/map_kptr_race.c | 12 ++++++++++++
> >>>>>    1 file changed, 12 insertions(+)
> >>>>>
> >>>>> diff --git a/tools/testing/selftests/bpf/prog_tests/map_kptr_race.c
> >>>>> b/tools/testing/selftests/bpf/prog_tests/map_kptr_race.c
> >>>>> index 506ed55e8528..5a543b3465a8 100644
> >>>>> --- a/tools/testing/selftests/bpf/prog_tests/map_kptr_race.c
> >>>>> +++ b/tools/testing/selftests/bpf/prog_tests/map_kptr_race.c
> >>>>> @@ -28,6 +28,15 @@ static int read_refs(struct map_kptr_race *skel)
> >>>>>        return skel->bss->num_of_refs;
> >>>>>    }
> >>>>>
> >>>>> +static void wait_for_refs(struct map_kptr_race *skel)
> >>>>> +{
> >>>>> +    for (int i = 0; i < 500; i++) {
> >>>>> +        if (read_refs(skel) == 2)
> >>>>> +            return;
> >>>>> +        usleep(10 * 1000);
> >>>>> +    }
> >>>>> +}
> >>>>> +
> >>>>>    static void test_htab_leak(void)
> >>>>>    {
> >>>>>        LIBBPF_OPTS(bpf_test_run_opts, opts,
> >>>>> @@ -73,6 +82,7 @@ static void test_htab_leak(void)
> >>>>>            sched_yield();
> >>>>>
> >>>>>        ASSERT_EQ(watcher->bss->map_freed, 1, "map_freed");
> >>>>> +    wait_for_refs(watcher);
> >>>>>        ASSERT_EQ(read_refs(watcher), 2, "htab refcount");
> >>>>>
> >>>>>    out_watcher:
> >>>>> @@ -134,6 +144,7 @@ static void test_percpu_htab_leak(void)
> >>>>>            sched_yield();
> >>>>>
> >>>>>        ASSERT_EQ(watcher->bss->map_freed, 1, "map_freed");
> >>>>> +    wait_for_refs(watcher);
> >>>>>        ASSERT_EQ(read_refs(watcher), 2, "percpu_htab refcount");
> >>>>>
> >>>>>    out_watcher:
> >>>>> @@ -195,6 +206,7 @@ static void test_sk_ls_leak(void)
> >>>>>            sched_yield();
> >>>>>
> >>>>>        ASSERT_EQ(watcher->bss->map_freed, 1, "map_freed");
> >>>>> +    wait_for_refs(watcher);
> >>>>>        ASSERT_EQ(read_refs(watcher), 2, "sk_ls refcount");
> >>>>>
> >>>>>    out_watcher:
> >>>> Wouldn't this still be flaky?
> >>> Yes, but it seems like the best solution to me.
> >>>
> >>>> Could we order these tests and wait for a RCU gp
> >>> to pass before finishing each one?
> >>>
> >>> I don't think so, because an RCU gp does not guarantee that htab dtor
> >>> was called.
> >>>
> >>>
> >>> Let me try to explain these points and please correct me if they are
> >>> wrong.
> >>>
> >>> That is how htab frees memory:
> >>>
> >>> const struct bpf_map_ops htab_map_ops = {
> >>> ...
> >>>      .map_free = htab_map_free,
> >>> ...
> >>>
> >>> static void htab_map_free(struct bpf_map *map)
> >>> |-> void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma)
> >>>      wait for bpf_mem_refill
> >>>
> >>> static void bpf_mem_refill(struct irq_work *work)
> >>> |-> static void free_bulk(struct bpf_mem_cache *c)
> >>>      |-> static void do_call_rcu_ttrace(struct bpf_mem_cache *c)
> >>>          |-> static inline void call_rcu_tasks_trace(struct rcu_head
> >>> *rhp, rcu_callback_t func)
> >>>              register callback __free_rcu
> >>>
> >>> static void __free_rcu(struct rcu_head *head)
> >>> |-> static int free_all(struct bpf_mem_cache *c, struct llist_node
> >>> *llnode, bool percpu)
> >>>         here the htab destructor is called
> >>>
> >>> If this is correct, htab free happens after RCU gp and task RCU gp,
> >>> which makes the option with waiting for the RCU gp after each test
> >>> pointless. What kind of guarantees kern_sync_rcu gives right now?
> >>>
> >>> Polling on refs seems better because it improves chances for the test
> >>> to pass without introducing major changes and it works with any RCU
> >>> flavor, also the same hack is used already in bpf_testmod_exit.
> >>>
> >>> Considering all of this, what do you think is the way forward?
> >>>
> >> Hi, I know the solution isn't perfect and the issue most likely is low
> >> priority, but still would be nice to improve the test. Please hit me up
> >> whenever you have any comments regarding it.
> >>
> > I still feel this is not the right solution. If RCU gp isn't enough,
> > trace when the dtor is called and set a bit that user space can wait
> > upon, and we can spin with yields until that bit is set. If other
> > tests modifying the refcount is problematic to wait properly then we
> > can mark this one as serial, but I think that can be avoided.
>
> What would you say on making a new prog to track
> bpf_kfunc_call_test_release ?
>
> SEC("fexit/bpf_kfunc_call_test_release")
> int BPF_PROG(test_release, struct prog_test_ref_kfunc *p)
> {
>      /* refs_settled is a global var */
>      if (p->cnt.refs.counter == 1)
>          refs_settled = 1;
>      return 0;
> }
>
> Then it's possible to poll on refs_settled in wait_for_refs, like this:
>
>      while (!READ_ONCE(skel->bss->refs_settled))
>          sched_yield();
>
> Would that be a better solution? If you want, I could send the v2, so
> you have all the details.
>

Yes, makes much more sense. Please share a v2 and I'll take a closer look.
