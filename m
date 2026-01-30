Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0030C13B;
	Fri, 30 Jan 2026 01:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769735500; cv=none; b=rEMD+6pteKnzHfKDmbkGa/Ha5yx4om0A4fJSJE5jSDBg3dPlp5ccGh9U7VpAt2QokeaBYYtpqaVQ3uW0kAHxYgNYfyHMvyqZpsG85FYJ2u56iFvU02ucmUxZVnLzwlUMFfQoooOyOWY41EoJ4EATcNKgPZclpn6RbebLlkx16Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769735500; c=relaxed/simple;
	bh=GZwctE1GPzAuk4TYl0Xwxy7h1RdfjObOJBbgaLildfg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GiHg54DUVhteDFoiUoB7Zw1y9d0K+sFAEs0qu4DTDlH0wBMLGh/7UNHRcOgipAMrwZGlydXqjrtgVlqBoOBuOS9Fc/XPBUtABV5j2Sz1WdiUmN7QmTryCYuJLy5C5mpYahbCE+6BxphpcCCsQJY5TF+KwA2O3k2Y6awS8Dh0nP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=QAtMajkJ; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="QAtMajkJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=GNIQ4X2KtjzAKIzMWdneTlmJODkXhrfE+MfCKHv0WNQ=; b=QAtMajkJY7AqszaVpQQDw3u9U/
	WvdT9cWEtxXAFfN8OuGvV+Wlhfjz7SBQaHgT8GrqueukIfzpWgiVWV+dxsdlj5kdVPoeSbv513w1s
	Cy9cwEhTyIruG0ACzcbNk3M0gUUhYGkRkZiZ2K+bLOzwubFAGt4CmvFKiyyRI/GxfU6l7M9l+PL1x
	1UYZY3oUbL2oZYgqmjZT2iKOkI0Ldhu49Ei6lxpffFbvzjsL3szxtJiX+2DGLj6gmos4wStHyVGYZ
	TJGbeqxVErG3nSerMxAbJC06VJm4V5v4JawSB8uXDcz4JuLhTmSDVj3MY8KY28+qMDSiAadDC4uWM
	bBnjowRw==;
Received: from [58.29.143.236] (helo=[192.168.1.2])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1vld2T-00BYTs-Nm; Fri, 30 Jan 2026 02:11:10 +0100
Message-ID: <d41d48a9-f2f7-49fa-82bc-5b8237246c7b@igalia.com>
Date: Fri, 30 Jan 2026 10:10:56 +0900
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/bpf: Make x86 preempt_count access compatible
 across v6.14+
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 kernel-dev@igalia.com, bpf <bpf@vger.kernel.org>, sched-ext@lists.linux.dev,
 LKML <linux-kernel@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
References: <20260129135426.93424-1-changwoo@igalia.com>
 <CAADnVQL2huFSNAn4Pkbx2GOqAB=Z-rtd+Fp3BnJTZ-tbzOhgmw@mail.gmail.com>
From: Changwoo Min <changwoo@igalia.com>
Content-Language: en-US, ko-KR, en-US-large, ko, en-HK
In-Reply-To: <CAADnVQL2huFSNAn4Pkbx2GOqAB=Z-rtd+Fp3BnJTZ-tbzOhgmw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Thank you, Alexei, for quick review.

On 1/30/26 2:21 AM, Alexei Starovoitov wrote:
> On Thu, Jan 29, 2026 at 5:54 AM Changwoo Min <changwoo@igalia.com> wrote:
>>
>> Recent x86 kernels (v6.15+) export __preempt_count as a ksym, while older
>> kernels expose the preemption counter via pcpu_hot.preempt_count. The
>> existing selftest helper unconditionally dereferenced __preempt_count,
>> which breaks BPF program loading on older kernels.
>>
>> Make the x86 preemption count lookup version-agnostic by:
>> - Marking __preempt_count and pcpu_hot as weak ksyms.
>> - Introducing a BTF-described pcpu_hot___local layout with
>>    preserve_access_index.
>> - Selecting the appropriate access path at runtime using ksym availability
>>    and bpf_core_field_exists().
>>
>> This allows a single BPF binary to run correctly on both v6.14-and-older
>> and v6.15-and-newer kernels without relying on compile-time version checks.
> 
> See.. with bpf approach instead of kfunc this new helpers
> can work on old kernels without backporting kfuncs :)

You are right. I love the flexibility of BPF in deployment! \o/

> 
>> Fixes: 4b69e31329b6 ("selftests/bpf: Introduce experimental bpf_in_interrupt()")
> 
> fixes tag is not appropriate. It's not a bug fix.

Sure, I will drop the Fixes tag.

> 
>> Signed-off-by: Changwoo Min <changwoo@igalia.com>
>> ---
>>   tools/testing/selftests/bpf/bpf_experimental.h | 16 ++++++++++++++--
>>   1 file changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
>> index a39576c8ba04..0194c0090e50 100644
>> --- a/tools/testing/selftests/bpf/bpf_experimental.h
>> +++ b/tools/testing/selftests/bpf/bpf_experimental.h
>> @@ -614,7 +614,13 @@ extern int bpf_cgroup_read_xattr(struct cgroup *cgroup, const char *name__str,
>>
>>   extern bool CONFIG_PREEMPT_RT __kconfig __weak;
>>   #ifdef bpf_target_x86
>> -extern const int __preempt_count __ksym;
>> +extern const int __preempt_count __ksym __weak;
>> +
>> +struct pcpu_hot___local {
>> +       int preempt_count;
>> +} __attribute__((preserve_access_index));
>> +
>> +extern struct pcpu_hot___local pcpu_hot __ksym __weak;
>>   #endif
>>
>>   struct task_struct___preempt_rt {
>> @@ -624,7 +630,13 @@ struct task_struct___preempt_rt {
>>   static inline int get_preempt_count(void)
>>   {
>>   #if defined(bpf_target_x86)
>> -       return *(int *) bpf_this_cpu_ptr(&__preempt_count);
>> +       /* v6.15 or later */
>> +       if (&__preempt_count)
>> +               return *(int *) bpf_this_cpu_ptr(&__preempt_count);
> 
> please use bpf_ksym_exists().
> It helps to catch missing __weak. This patch adds it,
> but let's demonstrate best coding practices.

Sure, will change it as suggested.


> 
>> +       /* v6.14 or older */
>> +       if (bpf_core_field_exists(pcpu_hot.preempt_count))
>> +               return ((struct pcpu_hot___local *)
>> +                       bpf_this_cpu_ptr(&pcpu_hot))->preempt_count;
> 
> iirc pcpu_hot approach was there for a short time.
> Like 5.x kernel didn't have it. It was per-cpu var too.
> Pls adjust the comment.

Sure, I found that pcpu_hot had been used only between 6.1 -- 6.14.

I will send out v2 shortly.
Regards,
Changwoo Min

> 
> pw-bot: cr
> 

