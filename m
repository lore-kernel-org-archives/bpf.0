Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792422334;
	b=bHqOtSx/3jdnO2R/yZ7/7V1FE2q9iRlGylNh5AYod7LcRCaPi/bjTTUavmA9q+XDKrxf
	 1FbJLkJoiM4YO6mfOQ3jE2RwF+6OyiAY0MPT3mFV4mo1UYYn/mh6eHHMrhbml5BXclwkR
	 2+ST1zDkLc/u39/sxTf5C1SBzQwQ2/FOdKdFk0HlAkUpB8rFnjdIvfBUyaa/zcAWYK6gc
	 MPIaT/YLYhGwea9D+XoSwu7djCe7YPVoqsnlPwLKPO4ZmSkaNC0OqnPWfnFRW7oPPeCi4
	 GJbhyMYMBKXkOcLKDIqYOL4Twt8ht7aVEStlEjrxEmQPi9fNnaOygGxCwzpu2YilrWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792422334;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=6U9zmaMvie7gM3Bs+cTksuu6owbWXyE4RzuhjH26Bao=;
	b=aSwDinauY8PZdiJBvyr4Q+9+53dwPilm+3W3nBbMI9dKKvo1JWcuC8Pn9wav1GXClm4W
	 DS2TRNTweKdBcY06ABN5kRJ2PnDGUx1uQjCEBcpqUK5Tht4I8GJTVO89wywfo+Tb8O5RK
	 dkbbOgHMpw5ZQut7zDt+hvhkVl0mYuS9VJilyt1nnZhdy8uxS5PDnk7zDLVvWYnJJjj8Y
	 NbJTtvthXCYeY6n2mYzwgVHh2iBofQMCENhCc99ypsxsmBtY8C5x/IOSFX9r//7WKGIjK
	 RwjW7627Dzoy01djVGKGlgJ+ej7sKRoQhlWr5U21lCXm7QZJW5z9EtywaI+yLAzN2Og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=tNTiI+F7;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F3B6080A9C
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 15:05:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0F3B6080A9C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=tNTiI+F7
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69JEEE6L4023944;
	Mon, 19 Oct 2026 15:05:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=6U9zma
	Mvie7gM3Bs+cTksuu6owbWXyE4RzuhjH26Bao=; b=tNTiI+F7fuOLtgAH8Uov9f
	0aeENU3ojZeVx8cdkl7LQDMzAZlpmFSHvzpF8NdMn8LLE8DcaYPCmY4LBYsBH3in
	DI4alILjFQ236ust5/E7c6ZVGmMxYaeheRbZMgiBvUUPRLqujB063725Ghnv2fui
	zorclAYlTdj/H+aAdxvkN3COs2fUbGhUmk2mAMZp5YVrks80fMRh+mqRkwe8k6XS
	8AHRFpJmJQpfzyulaHO6rQHRc1HBNP5zARFQR8CJ6+afC/1H0jkuckBpZudQOXUv
	Bh5PScP8KCUrTivSYlXtHVGVlsffPpXgrVjgsAxCT+ZsSfOS62mU/GlL8JYJcz0g
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hc0nvu162-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 19 Oct 2026 15:05:09 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69JE4rwG4173858;
	Mon, 19 Oct 2026 15:05:09 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hcmbjx6e6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Oct 2026 15:05:09 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69JF57Hw51970330
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Oct 2026 15:05:07 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B74FF58062;
	Mon, 19 Oct 2026 15:05:07 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1AD975805E;
	Mon, 19 Oct 2026 15:05:06 +0000 (GMT)
Received: from [9.224.75.254] (unknown [9.224.75.254])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 19 Oct 2026 15:05:05 +0000 (GMT)
Message-ID: <0ce208ae-b229-4f94-94ae-74edf96f371c@linux.ibm.com>
Date: Mon, 19 Oct 2026 17:05:05 +0200
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix flaky refcount asserts in
 map_kptr_race
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
References: <20260723114042.559926-2-max@linux.ibm.com>
 <DK63HA8KEYWH.1W1W2IJEWEVRD@gmail.com>
 <ede5833e-59f1-40db-b72d-bef247a16f9e@linux.ibm.com>
 <0eca445a-d882-4821-b6f3-4ba124607ebc@linux.ibm.com>
 <CAP01T743ZYEDDTxQ=_R+3kUJ8xLjQnm8jAeDnkPmLpc4Df+pNg@mail.gmail.com>
Content-Language: en-US
From: Maxim Khmelevskii <max@linux.ibm.com>
In-Reply-To: <CAP01T743ZYEDDTxQ=_R+3kUJ8xLjQnm8jAeDnkPmLpc4Df+pNg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA1OCBTYWx0ZWRfX/vIRUni7vtpe
 c1AMuN0cvfzw7FCiw8UMzW3En2OW46CusnW1m0nUD2/X6VFEBnRhyHr8ToVv8bCoWpP9YU/ppgB
 1EhZ5VOEIKVzkt0i/H76QhXZ8FjbpA0=
X-Proofpoint-ORIG-GUID: OJVOCkZMcJIN6EI0dYzhkks5YWy2Vm7S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA1OCBTYWx0ZWRfX9xpKWZzInbhP
 R6GuIqZfva4Lv3AIu+M1KjnNvvdBV/haltRyQaGRH0BmPB1/84ialSbfbdZU2ptdr5aU8ZZTxqd
 z9aUTtXSjsQfPj5a3JzC47w04UDQZaFkt3gPKfg0fUSZACux/4WxlkT7sjHioFY9ExXpdBZfbCP
 m7Dr15fJpEzMKnq8PFSVFNxMyBJhJWFWIQOPp9Lej5DJsFw9S3YK0H8iWMoUi1FhJiXhDFEW8v2
 5gRwQ9QrpaOLsSoeBDoZCMhtJlopY/e8lbcpIwfmlzcx8Ee/CER7E+JbiTk67VA7MEkK+sxmApN
 ffMRsuSJDpI4muc9GYOjmE3hdBWSskH4C6lOYpqqOmTsKPJHeDp/ZcCehnRzs0sUk8LpbAPyQOp
 Y/WZohap5v2dIQCXKv6SB+Wzn5yuvw==
X-Authority-Analysis: v=2.4 cv=MY35KJ/f c=1 sm=1 tr=0 ts=6ad631a5 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=7zsjvbA70KQimNFhlCEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: J8rdAPNP-c_8IGWdI9UHMZh8lUV5ILk8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_04,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190058

On 19/10/2026 03:25, Kumar Kartikeya Dwivedi wrote:
> On Thu, 15 Oct 2026 at 14:13, Maxim Khmelevskii <max@linux.ibm.com> wrote:
>> On 13/08/2026 00:51, Maxim Khmelevskii wrote:
>>> On 23/07/2026 18:34, Kumar Kartikeya Dwivedi wrote:
>>>> On Thu Jul 23, 2026 at 1:40 PM CEST, Maxim Khmelevskii wrote:
>>>>> bpf_testmod shares objects across tests; prog_test_struct that holds
>>>>> cnt.refs.counter is one of them. Refcounter release is deferred behind
>>>>> an RCU grace period, so it may still be pending when this test asserts.
>>>>> wait_for_refs prevents flaky failures when other tests have
>>>>> contaminated
>>>>> the refcount.
>>>>>
>>>>> Fixed tests:
>>>>>    - test_htab_leak
>>>>>    - test_percpu_htab_leak
>>>>>    - test_sk_ls_leak
>>>>>
>>>>> Reported-by: Ilya Leoshkevich <iii@linux.ibm.com>
>>>>> Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
>>>>> Signed-off-by: Maxim Khmelevskii <max@linux.ibm.com>
>>>>> ---
>>>> Wouldn't this still be flaky? Could we order these tests and wait for
>>>> a RCU gp
>>>> to pass before finishing each one? We have kern_sync_rcu(). Either
>>>> way, I don't
>>>> think the current approach is the right way forward.
>>>>
>>>> pw-bot: cr
>>>>
>>>>> .../testing/selftests/bpf/prog_tests/map_kptr_race.c | 12 ++++++++++++
>>>>>    1 file changed, 12 insertions(+)
>>>>>
>>>>> diff --git a/tools/testing/selftests/bpf/prog_tests/map_kptr_race.c
>>>>> b/tools/testing/selftests/bpf/prog_tests/map_kptr_race.c
>>>>> index 506ed55e8528..5a543b3465a8 100644
>>>>> --- a/tools/testing/selftests/bpf/prog_tests/map_kptr_race.c
>>>>> +++ b/tools/testing/selftests/bpf/prog_tests/map_kptr_race.c
>>>>> @@ -28,6 +28,15 @@ static int read_refs(struct map_kptr_race *skel)
>>>>>        return skel->bss->num_of_refs;
>>>>>    }
>>>>>
>>>>> +static void wait_for_refs(struct map_kptr_race *skel)
>>>>> +{
>>>>> +    for (int i = 0; i < 500; i++) {
>>>>> +        if (read_refs(skel) == 2)
>>>>> +            return;
>>>>> +        usleep(10 * 1000);
>>>>> +    }
>>>>> +}
>>>>> +
>>>>>    static void test_htab_leak(void)
>>>>>    {
>>>>>        LIBBPF_OPTS(bpf_test_run_opts, opts,
>>>>> @@ -73,6 +82,7 @@ static void test_htab_leak(void)
>>>>>            sched_yield();
>>>>>
>>>>>        ASSERT_EQ(watcher->bss->map_freed, 1, "map_freed");
>>>>> +    wait_for_refs(watcher);
>>>>>        ASSERT_EQ(read_refs(watcher), 2, "htab refcount");
>>>>>
>>>>>    out_watcher:
>>>>> @@ -134,6 +144,7 @@ static void test_percpu_htab_leak(void)
>>>>>            sched_yield();
>>>>>
>>>>>        ASSERT_EQ(watcher->bss->map_freed, 1, "map_freed");
>>>>> +    wait_for_refs(watcher);
>>>>>        ASSERT_EQ(read_refs(watcher), 2, "percpu_htab refcount");
>>>>>
>>>>>    out_watcher:
>>>>> @@ -195,6 +206,7 @@ static void test_sk_ls_leak(void)
>>>>>            sched_yield();
>>>>>
>>>>>        ASSERT_EQ(watcher->bss->map_freed, 1, "map_freed");
>>>>> +    wait_for_refs(watcher);
>>>>>        ASSERT_EQ(read_refs(watcher), 2, "sk_ls refcount");
>>>>>
>>>>>    out_watcher:
>>>> Wouldn't this still be flaky?
>>> Yes, but it seems like the best solution to me.
>>>
>>>> Could we order these tests and wait for a RCU gp
>>> to pass before finishing each one?
>>>
>>> I don't think so, because an RCU gp does not guarantee that htab dtor
>>> was called.
>>>
>>>
>>> Let me try to explain these points and please correct me if they are
>>> wrong.
>>>
>>> That is how htab frees memory:
>>>
>>> const struct bpf_map_ops htab_map_ops = {
>>> ...
>>>      .map_free = htab_map_free,
>>> ...
>>>
>>> static void htab_map_free(struct bpf_map *map)
>>> |-> void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma)
>>>      wait for bpf_mem_refill
>>>
>>> static void bpf_mem_refill(struct irq_work *work)
>>> |-> static void free_bulk(struct bpf_mem_cache *c)
>>>      |-> static void do_call_rcu_ttrace(struct bpf_mem_cache *c)
>>>          |-> static inline void call_rcu_tasks_trace(struct rcu_head
>>> *rhp, rcu_callback_t func)
>>>              register callback __free_rcu
>>>
>>> static void __free_rcu(struct rcu_head *head)
>>> |-> static int free_all(struct bpf_mem_cache *c, struct llist_node
>>> *llnode, bool percpu)
>>>         here the htab destructor is called
>>>
>>> If this is correct, htab free happens after RCU gp and task RCU gp,
>>> which makes the option with waiting for the RCU gp after each test
>>> pointless. What kind of guarantees kern_sync_rcu gives right now?
>>>
>>> Polling on refs seems better because it improves chances for the test
>>> to pass without introducing major changes and it works with any RCU
>>> flavor, also the same hack is used already in bpf_testmod_exit.
>>>
>>> Considering all of this, what do you think is the way forward?
>>>
>> Hi, I know the solution isn't perfect and the issue most likely is low
>> priority, but still would be nice to improve the test. Please hit me up
>> whenever you have any comments regarding it.
>>
> I still feel this is not the right solution. If RCU gp isn't enough,
> trace when the dtor is called and set a bit that user space can wait
> upon, and we can spin with yields until that bit is set. If other
> tests modifying the refcount is problematic to wait properly then we
> can mark this one as serial, but I think that can be avoided.

What would you say on making a new prog to track 
bpf_kfunc_call_test_release ?

SEC("fexit/bpf_kfunc_call_test_release")
int BPF_PROG(test_release, struct prog_test_ref_kfunc *p)
{
     /* refs_settled is a global var */
     if (p->cnt.refs.counter == 1)
         refs_settled = 1;
     return 0;
}

Then it's possible to poll on refs_settled in wait_for_refs, like this:

     while (!READ_ONCE(skel->bss->refs_settled))
         sched_yield();

Would that be a better solution? If you want, I could send the v2, so 
you have all the details.

