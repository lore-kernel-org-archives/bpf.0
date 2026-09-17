Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1594D9F95;
	Thu, 17 Sep 2026 12:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789646700; cv=none; b=XechbJ5BwPV8wf+oF6h3GqcxJnYQLYznuwxWJGq6MujcIWqaExHDdcTGSiZwRdr+0hDMriGKuQomSRZCZEluUKGH40Y4IdQLdskHRCO/FCEu3bGKtfBuImppKtw23fqzvRBcSds3qFHRbo1fbHxMT595iGr2XC2KRll00gH+JGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789646700; c=relaxed/simple;
	bh=gPf0Wv9V06yPZ6NfessAKocdDrOInglc1/+DED/jGgM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a8UdBowmejWyu8lqOHxXSDs/OK5NJ0g6x3gJ+DyPP/gLNs7sstz6aXzrZ+zZmW27NrBLDHg6DAJ1QIgGfKwmi86vSVNNNTRss/WXIiviHTBlMpOA22lU5wEi6t7O2MDPvfNqpqQLUurrlP+VpHoxlUdE2BWpkkiz4DuPRkzOWhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=arfuc46m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="arfuc46m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 651DA1F00898;
	Thu, 17 Sep 2026 12:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789646689;
	bh=fqJctqSsWUaKTmU/Qz+H8xUGqGsrUtaLocLOYT0DIdU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=arfuc46mcpeq3nGAg25G36a71FXJd6dWRq4pyk3PftRT2itdvbqIkv6yZVDwiZ++g
	 MA/uAdcGSJsI+lSE5qF+rqacUrScsG4O1GkI6wDn6B5x8nXpyfqu6U7OOeqxG8I6tH
	 UQ857KF8y5QGyhOqMWfT0wb+NMm1N5Cx+TRzkRxuYeznWnKG/uhRbqQ4bBsp3mofRt
	 dMiOefNEliwx7xx4hLE5o52pNo4pquFYFAUna1Sax6CwHLyvcaonIKMyDKwkc6tjxb
	 87qYkbJZIdXYID/9qZkHOdETSlsdreLL1/DVIHpceuXdobVoPBtm8hAHRyswqujRKT
	 GT697KV9qqKAQ==
Message-ID: <046917ac-3de6-40e5-85c3-93b55160b098@kernel.org>
Date: Thu, 17 Sep 2026 13:04:45 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 3/3] selftests/bpf: Verify program FD after
 non-autoload programs in lskel
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>,
 Leon Hwang <leon.hwang@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Shuah Khan <shuah@kernel.org>,
 KP Singh <kpsingh@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260909042433.1775591-1-tweek@google.com>
 <20260909042433.1775591-3-tweek@google.com>
 <424ef244-f0e0-46e7-bc27-fffee80f348d@linux.dev>
 <CA+zpnLeRmo3RTAxmMUHepm+kmpG4nw+z_vhR_kNubqEEEAVxbA@mail.gmail.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <CA+zpnLeRmo3RTAxmMUHepm+kmpG4nw+z_vhR_kNubqEEEAVxbA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2026-09-17 11:06 UTC+1000 ~ Thiébaud Weksteen <tweek@google.com>
> On Thu, Sep 10, 2026 at 3:49 PM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>> On 9/9/26 12:24, Thiébaud Weksteen wrote:
>>> In test_global_percpu_data.c, dump_percpu_data is defined after two
>>> non-autoload SEC("?kprobe") programs (verifier_strncmp and
>>> verifier_snprintf). Verify in test_global_percpu_data_lskel() that
>>> lskel->progs.dump_percpu_data.prog_fd is properly populated (> 0) when
>>> loaded via the light skeleton.
>>>
>>> Signed-off-by: Thiébaud Weksteen <tweek@google.com>
>>> ---
>>> No changes since v1.
>>
>> The Fixes tags of v1 are dropped.
>>
>>>
>>>  tools/testing/selftests/bpf/prog_tests/global_data_init.c | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/tools/testing/selftests/bpf/prog_tests/global_data_init.c b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
>>> index 7c539cbcf3a1..ebda60200b71 100644
>>> --- a/tools/testing/selftests/bpf/prog_tests/global_data_init.c
>>> +++ b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
>>> @@ -214,6 +214,8 @@ static void test_global_percpu_data_lskel(void)
>>>       lskel = test_global_percpu_data_lskel__open_and_load();
>>>       if (!ASSERT_OK_PTR(lskel, "test_global_percpu_data_lskel__open_and_load"))
>>>               goto out;
>>> +     if (!ASSERT_GT(lskel->progs.dump_percpu_data.prog_fd, 0, "dump_percpu_data.prog_fd"))
>>> +             goto out;
>>
>> When the light skeleton does not skip the non-autoload progs,
>> lskel->progs.dump_percpu_data.prog_fd is 0, actually.
>>
>> But, theoretically, this ASSERT_GT() is not good enough to prove the FD
>> is the correct FD of dump_percpu_data prog.
>>
>> How about running the iter subtest against the lskel? Factor out
>> test_global_percpu_data_iter_fd() helper first. Then, add an iter
>> subtest using lskel.
>> When factoring out test_global_percpu_data_iter_fd() helper, pls change
>> 'do { } while (0);' to '{ /* no-op */ }' btw.
>>
> 
> Thanks for the review Leon. That sounds good, I can implement these
> changes. I am just waiting for Quentin's feedback on the first patch
> in this series before spinning up a new patch set.
> 


Apologies for the delay. Patch 1 looks good to me, I just posted some
minor suggestions regarding comments. Thank you!

Quentin
