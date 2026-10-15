Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D48E51AEFB
	for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 12:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792066408; cv=none; b=OhmmWPZdYx8ZjFOUO2hXarcwqnnYNR1ZZ9LaComEq8qkHf3tQ1OW0oG5ftguuGaxaz33t+IvOKd88OdFDzqVD299MPysLafmPwBpuhIp7nc2Bh6PBVfYSAJioE0gWAh14S/uA/kNu9Jo5V0xoR/w4LuWou+yCFigTD16dnIl1M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792066408; c=relaxed/simple;
	bh=DDSnhWDaeY6SFnZT+TxtSPlTtdU8En5rFQ14LbvRIOk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=dDEPtrs/enMM31khHuGaO4Ky7gTU8lpIgh6dBfl4ELVCiZUL2czcUilXx6kmqLW8RazlWeqdR+0rLknVw+UQZDs5j38QWtvtCK5RxnG6sJDqNv5qqgQhqhp7XoJoD7wkPZjCeFbFgs6uQlbmP617Ws47+ldlUuYDFG4ElQH21Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=b8mNN20W; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="b8mNN20W"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F9kBOP3000441;
	Thu, 15 Oct 2026 12:13:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=IKGWFP
	t7ZXo2RiAz8pMQR5f1uZQhYL4T8HMVZTTtJB0=; b=b8mNN20WUxvp6eF1lrnFDY
	CIxIuMC+fwJ5jUYRVmaobPabNEQIrmpUPhcNVJzamTr/BE1jsNKE0gvtzWbcrnTM
	E9yuN01hOdIfF7lsEB7MvDnnuphK54HMefupkz6zEyjHH8qEZeWqzCUmWUdOcFAZ
	BsxFXoRbXXor6KSwGhc+H2mZbRYpr3wpDA8Oj9w8GnY08UDuYYYZasDwsK86yyAr
	pqcmUfXJD+iUXrBPUZ/rCE8tOkHcGwpsaD1bKq3ND4OTtZgAVJ3FiN8SXf7Tuxmx
	2lYVMBjesFftTsxiJ7oYJO5opgpeyNEZL3dmbtjtBXWvvAW7WEeMSJ/qkZRLdhdQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dwhssyy-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 15 Oct 2026 12:13:10 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69F9o39W709784;
	Thu, 15 Oct 2026 12:13:09 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h9wvg75vf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Oct 2026 12:13:09 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69FCD80O33620496
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Oct 2026 12:13:08 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7539C5805C;
	Thu, 15 Oct 2026 12:13:08 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BDC155805F;
	Thu, 15 Oct 2026 12:13:06 +0000 (GMT)
Received: from [9.224.75.254] (unknown [9.224.75.254])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 15 Oct 2026 12:13:06 +0000 (GMT)
Message-ID: <0eca445a-d882-4821-b6f3-4ba124607ebc@linux.ibm.com>
Date: Thu, 15 Oct 2026 14:13:05 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix flaky refcount asserts in
 map_kptr_race
From: Maxim Khmelevskii <max@linux.ibm.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, Ilya Leoshkevich <iii@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
References: <20260723114042.559926-2-max@linux.ibm.com>
 <DK63HA8KEYWH.1W1W2IJEWEVRD@gmail.com>
 <ede5833e-59f1-40db-b72d-bef247a16f9e@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <ede5833e-59f1-40db-b72d-bef247a16f9e@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA0NiBTYWx0ZWRfX0P6mNzE7rDwA
 z0ZPTXefJFJ2SQl0TJ6AQvaEVfxz7m2cbReV9rgYi5Yu6WAhPsdKeym4+qpck0d70hNJlZwmvQH
 N12MDpb44CApdGxHFkMpJwa0Z9CiUuw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA0NiBTYWx0ZWRfXy0tpwRKx+5aI
 1HVfvZjEho33C7YsEDUJF7trPGqzcS1UGChhtpfBCkn5+UCWjl6pvttiX7KPZv3snv/RQOjjod5
 gLLeDkoO3pdpoL9qKFPMjZHmGnRqL473mkLiPPVVZlUSyvL2APzG9Vm94bcjifXcc/unx4qp+he
 jMInmT74sZLER7nBbdEsvAJGd/Fch598ZtvBxK5yM4dRk8PMDFBzFol6FDljb16jUosg2BiSnnl
 bAlVhxpNnUBxPikWeI5sFqEIErp/kWrLneaDSs2tBwyzpMviuouwQBZa+BrvOhkDbHWaVZcB6zs
 PPjjcSFpG7fyW2ATLIgpNd/4xl+4pFd+js74YEKu2qPpJvNs4Hu+qfcQIeEr3d4v755tnhtUu+W
 tdAy2sjbhbLNUkYJSebcvzEGUDw3+MmwFBTmusLD8JvWQ8zl7azxOgf4/3yDs+K671TSsFEnjif
 3+kYKp6fzCYc5LXWNUg==
X-Proofpoint-GUID: 8nGat5cvppcguGaBUxwk9cJ-oY7ZQSku
X-Authority-Analysis: v=2.4 cv=RoFQvymK c=1 sm=1 tr=0 ts=6ad0c356 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=xM3MXRMOojhcQ4c3HFEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: HK6xpqUodkryPGklJJbx96OgPyqkY_by
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 clxscore=1011
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610150046

On 13/08/2026 00:51, Maxim Khmelevskii wrote:
> On 23/07/2026 18:34, Kumar Kartikeya Dwivedi wrote:
>> On Thu Jul 23, 2026 at 1:40 PM CEST, Maxim Khmelevskii wrote:
>>> bpf_testmod shares objects across tests; prog_test_struct that holds
>>> cnt.refs.counter is one of them. Refcounter release is deferred behind
>>> an RCU grace period, so it may still be pending when this test asserts.
>>> wait_for_refs prevents flaky failures when other tests have 
>>> contaminated
>>> the refcount.
>>>
>>> Fixed tests:
>>>   - test_htab_leak
>>>   - test_percpu_htab_leak
>>>   - test_sk_ls_leak
>>>
>>> Reported-by: Ilya Leoshkevich <iii@linux.ibm.com>
>>> Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
>>> Signed-off-by: Maxim Khmelevskii <max@linux.ibm.com>
>>> ---
>> Wouldn't this still be flaky? Could we order these tests and wait for 
>> a RCU gp
>> to pass before finishing each one? We have kern_sync_rcu(). Either 
>> way, I don't
>> think the current approach is the right way forward.
>>
>> pw-bot: cr
>>
>>> .../testing/selftests/bpf/prog_tests/map_kptr_race.c | 12 ++++++++++++
>>>   1 file changed, 12 insertions(+)
>>>
>>> diff --git a/tools/testing/selftests/bpf/prog_tests/map_kptr_race.c 
>>> b/tools/testing/selftests/bpf/prog_tests/map_kptr_race.c
>>> index 506ed55e8528..5a543b3465a8 100644
>>> --- a/tools/testing/selftests/bpf/prog_tests/map_kptr_race.c
>>> +++ b/tools/testing/selftests/bpf/prog_tests/map_kptr_race.c
>>> @@ -28,6 +28,15 @@ static int read_refs(struct map_kptr_race *skel)
>>>       return skel->bss->num_of_refs;
>>>   }
>>>
>>> +static void wait_for_refs(struct map_kptr_race *skel)
>>> +{
>>> +    for (int i = 0; i < 500; i++) {
>>> +        if (read_refs(skel) == 2)
>>> +            return;
>>> +        usleep(10 * 1000);
>>> +    }
>>> +}
>>> +
>>>   static void test_htab_leak(void)
>>>   {
>>>       LIBBPF_OPTS(bpf_test_run_opts, opts,
>>> @@ -73,6 +82,7 @@ static void test_htab_leak(void)
>>>           sched_yield();
>>>
>>>       ASSERT_EQ(watcher->bss->map_freed, 1, "map_freed");
>>> +    wait_for_refs(watcher);
>>>       ASSERT_EQ(read_refs(watcher), 2, "htab refcount");
>>>
>>>   out_watcher:
>>> @@ -134,6 +144,7 @@ static void test_percpu_htab_leak(void)
>>>           sched_yield();
>>>
>>>       ASSERT_EQ(watcher->bss->map_freed, 1, "map_freed");
>>> +    wait_for_refs(watcher);
>>>       ASSERT_EQ(read_refs(watcher), 2, "percpu_htab refcount");
>>>
>>>   out_watcher:
>>> @@ -195,6 +206,7 @@ static void test_sk_ls_leak(void)
>>>           sched_yield();
>>>
>>>       ASSERT_EQ(watcher->bss->map_freed, 1, "map_freed");
>>> +    wait_for_refs(watcher);
>>>       ASSERT_EQ(read_refs(watcher), 2, "sk_ls refcount");
>>>
>>>   out_watcher:
>
> > Wouldn't this still be flaky?
>
> Yes, but it seems like the best solution to me.
>
> > Could we order these tests and wait for a RCU gp
> to pass before finishing each one?
>
> I don't think so, because an RCU gp does not guarantee that htab dtor 
> was called.
>
>
> Let me try to explain these points and please correct me if they are 
> wrong.
>
> That is how htab frees memory:
>
> const struct bpf_map_ops htab_map_ops = {
> ...
>     .map_free = htab_map_free,
> ...
>
> static void htab_map_free(struct bpf_map *map)
> |-> void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma)
>     wait for bpf_mem_refill
>
> static void bpf_mem_refill(struct irq_work *work)
> |-> static void free_bulk(struct bpf_mem_cache *c)
>     |-> static void do_call_rcu_ttrace(struct bpf_mem_cache *c)
>         |-> static inline void call_rcu_tasks_trace(struct rcu_head 
> *rhp, rcu_callback_t func)
>             register callback __free_rcu
>
> static void __free_rcu(struct rcu_head *head)
> |-> static int free_all(struct bpf_mem_cache *c, struct llist_node 
> *llnode, bool percpu)
>        here the htab destructor is called
>
> If this is correct, htab free happens after RCU gp and task RCU gp, 
> which makes the option with waiting for the RCU gp after each test 
> pointless. What kind of guarantees kern_sync_rcu gives right now?
>
> Polling on refs seems better because it improves chances for the test 
> to pass without introducing major changes and it works with any RCU 
> flavor, also the same hack is used already in bpf_testmod_exit.
>
> Considering all of this, what do you think is the way forward?
>
Hi, I know the solution isn't perfect and the issue most likely is low 
priority, but still would be nice to improve the test. Please hit me up 
whenever you have any comments regarding it.

