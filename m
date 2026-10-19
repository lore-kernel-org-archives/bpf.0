Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609C41D9663
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 01:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792373200; cv=pass; b=u/YWKoho6lcbCospQZPmQeJHxjTGKV4+UNmCaMxBd9xvNbA1i6NAm5HWlDdzauyjqaS6Q6Nq+FaezsMBtKnTfQPY7hR427CikZ3LPZ6sKSifSobTVK2kXhpemWhWobdwPMRnWE7AZLYszZ9bVtST5pqgIcYd6iSesM7K6ZHjoxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792373200; c=relaxed/simple;
	bh=AQ03o12O9IdqsK59VhhG+Jt1ViPqQPPhVf0zLMdb05k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cGRuLbMYQT+DC6ZGFKWe41EsGvAfyZqwHAuAQO8oa1EYbVLMaO6zBxMMtAxFMUwdOcUCT7FDZTRHYPZl4UsJMdaSqP4E4QJgaEy3vxYg6nLwAH09jJNu7JKm4nKK3VyoV5chkfiWVocV9vLTZaAZMiivMOYWhq5LlyjllUDasz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UdbRAhc+; arc=pass smtp.client-ip=74.125.225.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UdbRAhc+"
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-4a0f23b853dso8272135e9.1
        for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 18:26:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792373197; cv=none;
        d=google.com; s=arc-20260327;
        b=k+gvE8ekuyr1409sNTT1ruptzi1UF7XZNu5PCdK9DtncmFYQQSbhgs4vogViaf/eWw
         pOL4t1n/MPRr4esKJnQZH83ELEQ/JmPBKRPLTN0XKPqaegsVw4L3R7njB49hCji23I6d
         0zL9zA0MZHBS+AJIWZFhdJuGTXdO0XBzU/Ci7PQOLbwJJciC15bYRjTJd6m764ZAmaQh
         4dLwmuKiZNaZ9bdKRUqCrbkOMm7zqKNC0ad3bQPoTZJ3ea9ag/MGdhx0zaSl+2iKhLdM
         w6EKFp5MiIH1frIrSeak71kuRnmHvDEQFMMOq0lCocht7+5a9Y5iI2rKtEsioSmfGQPA
         Mq9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=RQd44OdrVueqtH/s6XrJu0u8hZhKNo21NCR4aX2KSgk=;
        fh=zK0FSgi/QnYaeQP665moKTxPVDsI4YOtphCj83Wo86I=;
        b=qvO/bDvMzk6NM9EOYhc/sfZURsAA3KlD5LRcY5dqnWN9qK1L4ir/dqxKT92iKnrMGu
         SfVuvAIFHDSmxQy/0jjIR/PkiLsVc+GmNb6vzh1e+ExUEegBtT6AytmAl2u3wK9v9A1C
         0vyFJXHTYlygUTzobtpfzygcqXdFZzKrKSXSYPRcEyGsTB6TGquD+gILYou7XomsMut/
         JJR8qpOiZI4eNssXmual+ICX3vwJ2HkP7Hx7wSVJ3Ng3GqOfPsrQaKHBvrXH1wtnmF86
         TVjc8wmdaxn8yixCppFKqmVxLZRFgNbzBCkZ2Q63zAYY0BAUB98GiCNgzK+z0n2Yw9j+
         b1EA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792373197; x=1792977997; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RQd44OdrVueqtH/s6XrJu0u8hZhKNo21NCR4aX2KSgk=;
        b=UdbRAhc+Vtl+VHo/nxtouJa94Z5SFz+HmRNggITBiyCu9JVJD4hCmiyacUSDfnx7eC
         d9B9KCKoI4ZW+UOJr2l+AbALNS52GLC7JzDHa0LrgMdGr0Nj6edg73Hq1k+X4ZqybrX7
         tj7BQHV0GUdK79xCHIvvMUWa/ErvwJwL2MT23YSV/3GSHs+/Idx8Nl3WFlUl8YLm/X8d
         oug0yEo/L1TG5AlAmupxOZ21UZLTJHEhDhQEbln2zo3Z26MiAw+NazwaVs6RNHJ3QenJ
         7qqRClz5fftcDGW8iLoCtTUjo2DY/T4o98t7Tz9qsIaAoVmGQH0WTNpoOIGTbU3Cyk3K
         ZjQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792373197; x=1792977997;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RQd44OdrVueqtH/s6XrJu0u8hZhKNo21NCR4aX2KSgk=;
        b=ZRxj4nJAU8Umpfxc5esM215kuEDpidK1h7ynxcmdrULLE57W8i10CPhLrJUEZLLUUG
         Xs1PajbJ/I1HJj2cJJbFfSlvdUzLNrOdT8ph7WlXo69XBeZIUD7y/HIgA/42DZAjXAT9
         CThoDl6qhuPWmYktDk6bQTOhK6MS3WYfSvV+WTrcpeW0N3/uOanLMMOC/kuQZ6C1RVfn
         wuQIKcFIOcFgvVCjp74uDaniCjKQ36jduxtI0s7zhO5hGXaaYml1gAz04JZf/iek8cKa
         Qw8Q/j/udOI0/QTgKl6ANvdhW1NAkmHSJe+OYkw8+3gS1cmw8YY0eDYBCTaQ5me7LWT5
         qaWw==
X-Forwarded-Encrypted: i=1; AKwUvBxdIRzjEKuRH9zKta1nhRHzZ7UTpZVra95AtQ51YDz8Ko2H9LoKiJvQG8d91saqXeaC3rA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKRvIpTcLqbBFYKoANARZEwKx/ibiUQiovnUAWxcYWPEbsCczat
	VfxOSQf+9VleUZAyQF+lBQPD0c9gJRmd+wwlgtX0dsGEfSZYuIXCzSR26dEwOZzjtVKfi6rrkxK
	zs+Bj1KRSNIs19arDwzJHUC5AMx5+/gA=
X-Gm-Gg: AYBFou05/uscTTcy3JC5ob97eZAWcIWP4+iSlnv0hExBuPL07F1IDMiX51XFd7Se9n9
	wsw78KYKQU1ms/CTCs8XlB91H0E2Y8wGsNrN9VNDIk6KCXEK0oU5jcfr+hwOW1qzGapD3W2QJbU
	9uT4uQyqLNDjr26HM3bgBtgLnuOd++2zZSpCRm2Kf6GqzjTogMNhXL022UI/RF6lr6JmM3DnXt8
	xf2h14dW/1k4Zew4o3d2+s83mt55rLPrEDLikXzPDFN7l5/jVME9e0MCGp7MvRpsW7jmhmgn8qY
	JHxWa5hsXFuJxQaLlXyYQ5pdIG6jdPbLgHvc1TX9ZE0ti3kXMrktR7tN3jMGpaEb5GM7tTJpshn
	Dm/wX//T4jWI4ZVRcx3BzSbUbmqnNXt13Jd8CMHKoUQQdh6TrKfQC5+cqI15QI+Zk5YMaKPPNHI
	TVa7UwX0CELO/Tl45dEInikqFcvU056oQ=
X-Received: by 2002:a05:600c:4e8a:b0:4a1:8961:78dd with SMTP id
 5b1f17b1804b1-4a1d7616464mr140734885e9.27.1792373197230; Sun, 18 Oct 2026
 18:26:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723114042.559926-2-max@linux.ibm.com> <DK63HA8KEYWH.1W1W2IJEWEVRD@gmail.com>
 <ede5833e-59f1-40db-b72d-bef247a16f9e@linux.ibm.com> <0eca445a-d882-4821-b6f3-4ba124607ebc@linux.ibm.com>
In-Reply-To: <0eca445a-d882-4821-b6f3-4ba124607ebc@linux.ibm.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 19 Oct 2026 03:25:59 +0200
X-Gm-Features: AclHuK81nbxNTal5GHxSdakoHv5f4rvSwuNigSTADQ_gbSoSrO5ygZJIc_0EkJc
Message-ID: <CAP01T743ZYEDDTxQ=_R+3kUJ8xLjQnm8jAeDnkPmLpc4Df+pNg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix flaky refcount asserts in map_kptr_race
To: Maxim Khmelevskii <max@linux.ibm.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 Oct 2026 at 14:13, Maxim Khmelevskii <max@linux.ibm.com> wrote:
>
> On 13/08/2026 00:51, Maxim Khmelevskii wrote:
> > On 23/07/2026 18:34, Kumar Kartikeya Dwivedi wrote:
> >> On Thu Jul 23, 2026 at 1:40 PM CEST, Maxim Khmelevskii wrote:
> >>> bpf_testmod shares objects across tests; prog_test_struct that holds
> >>> cnt.refs.counter is one of them. Refcounter release is deferred behind
> >>> an RCU grace period, so it may still be pending when this test asserts.
> >>> wait_for_refs prevents flaky failures when other tests have
> >>> contaminated
> >>> the refcount.
> >>>
> >>> Fixed tests:
> >>>   - test_htab_leak
> >>>   - test_percpu_htab_leak
> >>>   - test_sk_ls_leak
> >>>
> >>> Reported-by: Ilya Leoshkevich <iii@linux.ibm.com>
> >>> Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
> >>> Signed-off-by: Maxim Khmelevskii <max@linux.ibm.com>
> >>> ---
> >> Wouldn't this still be flaky? Could we order these tests and wait for
> >> a RCU gp
> >> to pass before finishing each one? We have kern_sync_rcu(). Either
> >> way, I don't
> >> think the current approach is the right way forward.
> >>
> >> pw-bot: cr
> >>
> >>> .../testing/selftests/bpf/prog_tests/map_kptr_race.c | 12 ++++++++++++
> >>>   1 file changed, 12 insertions(+)
> >>>
> >>> diff --git a/tools/testing/selftests/bpf/prog_tests/map_kptr_race.c
> >>> b/tools/testing/selftests/bpf/prog_tests/map_kptr_race.c
> >>> index 506ed55e8528..5a543b3465a8 100644
> >>> --- a/tools/testing/selftests/bpf/prog_tests/map_kptr_race.c
> >>> +++ b/tools/testing/selftests/bpf/prog_tests/map_kptr_race.c
> >>> @@ -28,6 +28,15 @@ static int read_refs(struct map_kptr_race *skel)
> >>>       return skel->bss->num_of_refs;
> >>>   }
> >>>
> >>> +static void wait_for_refs(struct map_kptr_race *skel)
> >>> +{
> >>> +    for (int i = 0; i < 500; i++) {
> >>> +        if (read_refs(skel) == 2)
> >>> +            return;
> >>> +        usleep(10 * 1000);
> >>> +    }
> >>> +}
> >>> +
> >>>   static void test_htab_leak(void)
> >>>   {
> >>>       LIBBPF_OPTS(bpf_test_run_opts, opts,
> >>> @@ -73,6 +82,7 @@ static void test_htab_leak(void)
> >>>           sched_yield();
> >>>
> >>>       ASSERT_EQ(watcher->bss->map_freed, 1, "map_freed");
> >>> +    wait_for_refs(watcher);
> >>>       ASSERT_EQ(read_refs(watcher), 2, "htab refcount");
> >>>
> >>>   out_watcher:
> >>> @@ -134,6 +144,7 @@ static void test_percpu_htab_leak(void)
> >>>           sched_yield();
> >>>
> >>>       ASSERT_EQ(watcher->bss->map_freed, 1, "map_freed");
> >>> +    wait_for_refs(watcher);
> >>>       ASSERT_EQ(read_refs(watcher), 2, "percpu_htab refcount");
> >>>
> >>>   out_watcher:
> >>> @@ -195,6 +206,7 @@ static void test_sk_ls_leak(void)
> >>>           sched_yield();
> >>>
> >>>       ASSERT_EQ(watcher->bss->map_freed, 1, "map_freed");
> >>> +    wait_for_refs(watcher);
> >>>       ASSERT_EQ(read_refs(watcher), 2, "sk_ls refcount");
> >>>
> >>>   out_watcher:
> >
> > > Wouldn't this still be flaky?
> >
> > Yes, but it seems like the best solution to me.
> >
> > > Could we order these tests and wait for a RCU gp
> > to pass before finishing each one?
> >
> > I don't think so, because an RCU gp does not guarantee that htab dtor
> > was called.
> >
> >
> > Let me try to explain these points and please correct me if they are
> > wrong.
> >
> > That is how htab frees memory:
> >
> > const struct bpf_map_ops htab_map_ops = {
> > ...
> >     .map_free = htab_map_free,
> > ...
> >
> > static void htab_map_free(struct bpf_map *map)
> > |-> void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma)
> >     wait for bpf_mem_refill
> >
> > static void bpf_mem_refill(struct irq_work *work)
> > |-> static void free_bulk(struct bpf_mem_cache *c)
> >     |-> static void do_call_rcu_ttrace(struct bpf_mem_cache *c)
> >         |-> static inline void call_rcu_tasks_trace(struct rcu_head
> > *rhp, rcu_callback_t func)
> >             register callback __free_rcu
> >
> > static void __free_rcu(struct rcu_head *head)
> > |-> static int free_all(struct bpf_mem_cache *c, struct llist_node
> > *llnode, bool percpu)
> >        here the htab destructor is called
> >
> > If this is correct, htab free happens after RCU gp and task RCU gp,
> > which makes the option with waiting for the RCU gp after each test
> > pointless. What kind of guarantees kern_sync_rcu gives right now?
> >
> > Polling on refs seems better because it improves chances for the test
> > to pass without introducing major changes and it works with any RCU
> > flavor, also the same hack is used already in bpf_testmod_exit.
> >
> > Considering all of this, what do you think is the way forward?
> >
> Hi, I know the solution isn't perfect and the issue most likely is low
> priority, but still would be nice to improve the test. Please hit me up
> whenever you have any comments regarding it.
>

I still feel this is not the right solution. If RCU gp isn't enough,
trace when the dtor is called and set a bit that user space can wait
upon, and we can spin with yields until that bit is set. If other
tests modifying the refcount is problematic to wait properly then we
can mark this one as serial, but I think that can be avoided.
