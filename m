Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF9125DB0D
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 22:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786575116; cv=none; b=Gogx5bPYNsTF2+ieN8Km7DnBfp9w6MLWBG0fctnSNLWgozgbz49lyU/b6r6c/HBilL8rYxtOlvBc+X8gNjqgM9YUINcqKSQA1we/UVb4vEpquRxGORf3e5fMod6xhGwUdsWUkE5vZy7dONCql30j1atnNzftQCspH+MfZ/fEaYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786575116; c=relaxed/simple;
	bh=RuKEzixFlaoAwG5SW9tRrZjzS3+E4VQKKrK920EH9x0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a2lLIjKi4Jgb/RqesFvonNCmAjW0RklloIJSC5gF8svGpcVf6Fyh65i19sE2hb22cA2nS4NDkJ/bnVQ3+VgMj8Zbg0z17F4V1QOPUeSbcZcoDYVMir8aJxppSI440+opHba7c3WWlZ99ePvR4rqC/5lMEsWf/wiB9i4pqTnGbRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ugd6s0QY; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ugd6s0QY"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CK3ps9324935;
	Wed, 12 Aug 2026 22:51:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=U3tOD8
	q5RI1uHak6D1qOaVskkdAri+gjC/+RYzA9pZQ=; b=Ugd6s0QY0YN4ig6vYYxf/Y
	UDlTNh6CpEtDKC7G/qnYwOb8fKGPn3Y9/z0qT8/dx+hHNxUdzZEhE9vuxpyEoELg
	gCVNTqzszp6NaXBoyg/i3Cj1ZYjoeVo6/WdW8RKNod0UeyWLWosTphBU+x8Xow4o
	FBkhsjO5eDqkd8eEGECU1TPCA5jvnCq2Obi560uNUOrNr/CpkQWhCXru/Xg7NgXu
	4o0OVrFcJfsnlrAn+pE0upoFqTD3bfVwVqZ31Ngy7ZbXCHX7k3pXFIiUrRdVDKol
	RBqS55Ygat00zOXndFO1RwoUpnkRvjaZ1W0dVQ6MuyPZw6LU51ddLQHroZ82KRrw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnwc80e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 22:51:36 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CMfHZe018079;
	Wed, 12 Aug 2026 22:51:35 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxh0ggaqh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 22:51:35 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CMpXT449217990
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 22:51:34 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B3F8258056;
	Wed, 12 Aug 2026 22:51:33 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C336F58052;
	Wed, 12 Aug 2026 22:51:31 +0000 (GMT)
Received: from [9.111.33.7] (unknown [9.111.33.7])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 22:51:31 +0000 (GMT)
Message-ID: <ede5833e-59f1-40db-b72d-bef247a16f9e@linux.ibm.com>
Date: Thu, 13 Aug 2026 00:51:30 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix flaky refcount asserts in
 map_kptr_race
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, Ilya Leoshkevich <iii@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
References: <20260723114042.559926-2-max@linux.ibm.com>
 <DK63HA8KEYWH.1W1W2IJEWEVRD@gmail.com>
Content-Language: en-US
From: Maxim Khmelevskii <max@linux.ibm.com>
In-Reply-To: <DK63HA8KEYWH.1W1W2IJEWEVRD@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a7cf8f8 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=UfM60PG_Xhx9u9UDEuAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: PTBWOMxqv0weWRkiNNTOB6LjzEtdrJxx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDE4MiBTYWx0ZWRfXzk85vA1tV+Bd
 RKYFnAN365rabPIlEQYOOzG5uIZFmftFyPU8QuX5FBI2Hq2WBOMuYRQzFmK2K/qA+irpYGhQg1P
 oBJhu5o4bMTDMOQkui5GNueG0F4srazFhPoyB03TFtEG0NzKxLl0FwDKF2EGO7kV48MQ1NIkE4y
 HQggsE9WmHLsjZHe9lUJNS8uQ2/AwXt5hdgEwnTNp7EqjuBRNSB3zeryP5ONtT0aiAZJvKTGQsI
 B12gxc81B+/eqw1iJC9lPOVwn2IsHlo5LcGuCbLOZ0aijujCUdnNz+QXC/AdbHdemqRqq4/NtbN
 lHCQCBu+60Zqe/AVuEwxXFUJ4ffZ8Ubpxo6ystUxK7T6Cc7ziZ/MCbsIHYji0WpjtLsp1QQSLkC
 QOSMup6kkE9qxZusiA+b1F8YakaL1Cx+vZHDz8WKCtT5AakQtWcF+AAJDiWghSvEHoPtfJ0sb0Z
 uSVa8DMt7FVgZb4VHGg==
X-Proofpoint-ORIG-GUID: KpycWfHrI3UMw44UFQw7k2IgrH1JIyJY
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDE4MiBTYWx0ZWRfXwdz6BCQ/YY+z
 4afmK6/L6j79Mo2gB58+lBhrXO8mnz8s0ke42y/s+niSMESladPxzFqwZ+6NoL75gmLAOwHefjj
 tBje0Ab8j7KmTcegNufUGFqqLEU8La8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120182

On 23/07/2026 18:34, Kumar Kartikeya Dwivedi wrote:
> On Thu Jul 23, 2026 at 1:40 PM CEST, Maxim Khmelevskii wrote:
>> bpf_testmod shares objects across tests; prog_test_struct that holds
>> cnt.refs.counter is one of them. Refcounter release is deferred behind
>> an RCU grace period, so it may still be pending when this test asserts.
>> wait_for_refs prevents flaky failures when other tests have contaminated
>> the refcount.
>>
>> Fixed tests:
>>   - test_htab_leak
>>   - test_percpu_htab_leak
>>   - test_sk_ls_leak
>>
>> Reported-by: Ilya Leoshkevich <iii@linux.ibm.com>
>> Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
>> Signed-off-by: Maxim Khmelevskii <max@linux.ibm.com>
>> ---
> Wouldn't this still be flaky? Could we order these tests and wait for a RCU gp
> to pass before finishing each one? We have kern_sync_rcu(). Either way, I don't
> think the current approach is the right way forward.
>
> pw-bot: cr
>
>>   .../testing/selftests/bpf/prog_tests/map_kptr_race.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/map_kptr_race.c b/tools/testing/selftests/bpf/prog_tests/map_kptr_race.c
>> index 506ed55e8528..5a543b3465a8 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/map_kptr_race.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/map_kptr_race.c
>> @@ -28,6 +28,15 @@ static int read_refs(struct map_kptr_race *skel)
>>   	return skel->bss->num_of_refs;
>>   }
>>
>> +static void wait_for_refs(struct map_kptr_race *skel)
>> +{
>> +	for (int i = 0; i < 500; i++) {
>> +		if (read_refs(skel) == 2)
>> +			return;
>> +		usleep(10 * 1000);
>> +	}
>> +}
>> +
>>   static void test_htab_leak(void)
>>   {
>>   	LIBBPF_OPTS(bpf_test_run_opts, opts,
>> @@ -73,6 +82,7 @@ static void test_htab_leak(void)
>>   		sched_yield();
>>
>>   	ASSERT_EQ(watcher->bss->map_freed, 1, "map_freed");
>> +	wait_for_refs(watcher);
>>   	ASSERT_EQ(read_refs(watcher), 2, "htab refcount");
>>
>>   out_watcher:
>> @@ -134,6 +144,7 @@ static void test_percpu_htab_leak(void)
>>   		sched_yield();
>>
>>   	ASSERT_EQ(watcher->bss->map_freed, 1, "map_freed");
>> +	wait_for_refs(watcher);
>>   	ASSERT_EQ(read_refs(watcher), 2, "percpu_htab refcount");
>>
>>   out_watcher:
>> @@ -195,6 +206,7 @@ static void test_sk_ls_leak(void)
>>   		sched_yield();
>>
>>   	ASSERT_EQ(watcher->bss->map_freed, 1, "map_freed");
>> +	wait_for_refs(watcher);
>>   	ASSERT_EQ(read_refs(watcher), 2, "sk_ls refcount");
>>
>>   out_watcher:

 > Wouldn't this still be flaky?

Yes, but it seems like the best solution to me.

 > Could we order these tests and wait for a RCU gp
to pass before finishing each one?

I don't think so, because an RCU gp does not guarantee that htab dtor 
was called.


Let me try to explain these points and please correct me if they are wrong.

That is how htab frees memory:

const struct bpf_map_ops htab_map_ops = {
...
     .map_free = htab_map_free,
...

static void htab_map_free(struct bpf_map *map)
|-> void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma)
     wait for bpf_mem_refill

static void bpf_mem_refill(struct irq_work *work)
|-> static void free_bulk(struct bpf_mem_cache *c)
     |-> static void do_call_rcu_ttrace(struct bpf_mem_cache *c)
         |-> static inline void call_rcu_tasks_trace(struct rcu_head 
*rhp, rcu_callback_t func)
             register callback __free_rcu

static void __free_rcu(struct rcu_head *head)
|-> static int free_all(struct bpf_mem_cache *c, struct llist_node 
*llnode, bool percpu)
        here the htab destructor is called

If this is correct, htab free happens after RCU gp and task RCU gp, 
which makes the option with waiting for the RCU gp after each test 
pointless. What kind of guarantees kern_sync_rcu gives right now?

Polling on refs seems better because it improves chances for the test to 
pass without introducing major changes and it works with any RCU flavor, 
also the same hack is used already in bpf_testmod_exit.

Considering all of this, what do you think is the way forward?

