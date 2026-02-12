Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A4F2DE711
	for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 23:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770940453; cv=none; b=d4y3J85frcJfe/pmJVm/2U8zKkt0FZ0xBwD4jcohcwqLiwAdykC7LNoxeFLdMIzrlxZOwbHx23S4Lw5yaGqUqeh9Aq6tuobE11Amce57nhqikfFXu8aF4Xk1nmFNTiaQL1QMgyWOWCv2V1BPVajP+NTvtM8SW9dZ4vgNtMSydrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770940453; c=relaxed/simple;
	bh=lnYa/cNhp1qzkDQhGAce/iSN26Ny+OqWiG9zUO+ihPI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=V6jT+9OgMhWSVnBjaP/F/qchYudQMo1YZvUSCpnS2c88wTBWYp9z28MVxRtUD6eT92JFDP0CqdorPX4l0jQBvBl1nXqC2twRrp2f8maSPO/92w65ISMwUHv3Ohm/e9DC2r4lxs8JDGY9Gns/Nlv8CqB+JBFyuuBaVkgO1cOALSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZlwWRC4t; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZlwWRC4t"
Message-ID: <2e8a8754-5b4e-45c4-a54a-488f0a7b1633@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770940439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ECZ3Gr3aPzDdLph7XL37lAMGWK6WSXx8uq0q0FNltrM=;
	b=ZlwWRC4t9UIkaxR129QlAsVOcFIufN3uopaEVE6kKLVKI4UQseHqGC6gXhLlEOaUZWjnY8
	K7oLkZiG0VfXrf8shahIoskBgaEYOXuHK+ZerzqWmuUPb8sgGo2Piah/RXxJYAw1+B5ETy
	tlmP/xiJ+Ls/LJu24WrA0Gp9gZuUDrA=
Date: Thu, 12 Feb 2026 15:53:49 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] selftests/bpf: Add powerpc support for
 get_preempt_count() in selftest
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Cc: hbathini@linux.ibm.com, sachinpb@linux.ibm.com, venkat88@linux.ibm.com,
 andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, song@kernel.org, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 christophe.leroy@csgroup.eu, maddy@linux.ibm.com, mpe@ellerman.id.au
References: <20260212092558.370623-1-skb99@linux.ibm.com>
 <a3dfdbc2-bd72-412d-83b4-f17d68949c6b@linux.dev>
In-Reply-To: <a3dfdbc2-bd72-412d-83b4-f17d68949c6b@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 2/12/26 3:52 PM, Yonghong Song wrote:
>
>
> On 2/12/26 1:25 AM, Saket Kumar Bhaskar wrote:
>> get_preempt_count() is enabled to return preempt_count for powerpc,
>> so that bpf_in_interrupt()/bpf_in_nmi()/bpf_in_serving_softirq()/
>> bpf_in_task()/bpf_in_hardirq()/get_preempt_count() works for
>> powerpc as well.
>>
>> Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
>> ---
>> Changes since v1:
>> * Updated the comments to include powerpc for the APIs.
>>
>> v1: 
>> https://lore.kernel.org/bpf/20260129054035.168078-1-skb99@linux.ibm.com/
>> ---
>>   tools/testing/selftests/bpf/bpf_experimental.h | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/tools/testing/selftests/bpf/bpf_experimental.h 
>> b/tools/testing/selftests/bpf/bpf_experimental.h
>> index 4b7210c318dd..9df77e59d4f5 100644
>> --- a/tools/testing/selftests/bpf/bpf_experimental.h
>> +++ b/tools/testing/selftests/bpf/bpf_experimental.h
>> @@ -645,6 +645,8 @@ static inline int get_preempt_count(void)
>> bpf_this_cpu_ptr(&pcpu_hot))->preempt_count;
>>   #elif defined(bpf_target_arm64)
>>       return bpf_get_current_task_btf()->thread_info.preempt.count;
>> +#elif defined(bpf_target_powerpc)
>> +    return bpf_get_current_task_btf()->thread_info.preempt_count;
>>   #endif
>
> Maybe do
>   #elif defined(bpf_target_arm64) || defined(bpf_target_powerpc)
> ?

Sorry, my bad. Please ignore as missing preempt.count vs. preempt_count.

>
>>       return 0;
>>   }
>> @@ -653,6 +655,7 @@ static inline int get_preempt_count(void)
>>    *    Report whether it is in interrupt context. Only works on the 
>> following archs:
>>    *    * x86
>>    *    * arm64
>> + *    * powerpc64
>>    */
>>   static inline int bpf_in_interrupt(void)
>>   {
>> @@ -672,6 +675,7 @@ static inline int bpf_in_interrupt(void)
>>    *    Report whether it is in NMI context. Only works on the 
>> following archs:
>>    *    * x86
>>    *    * arm64
>> + *    * powerpc64
>>    */
>>   static inline int bpf_in_nmi(void)
>>   {
>> @@ -682,6 +686,7 @@ static inline int bpf_in_nmi(void)
>>    *    Report whether it is in hard IRQ context. Only works on the 
>> following archs:
>>    *    * x86
>>    *    * arm64
>> + *    * powerpc64
>>    */
>>   static inline int bpf_in_hardirq(void)
>>   {
>> @@ -692,6 +697,7 @@ static inline int bpf_in_hardirq(void)
>>    *    Report whether it is in softirq context. Only works on the 
>> following archs:
>>    *    * x86
>>    *    * arm64
>> + *    * powerpc64
>>    */
>>   static inline int bpf_in_serving_softirq(void)
>>   {
>> @@ -710,6 +716,7 @@ static inline int bpf_in_serving_softirq(void)
>>    *    Report whether it is in task context. Only works on the 
>> following archs:
>>    *    * x86
>>    *    * arm64
>> + *    * powerpc64
>>    */
>>   static inline int bpf_in_task(void)
>>   {
>
>

