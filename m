Received: from mta1.migadu.com (out-89.mta1.migadu.com [95.215.58.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF84426437
	for <bpf@vger.kernel.org>; Mon,  7 Sep 2026 15:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788794662; cv=none; b=kDRT9ZVmh8QrZWtAREuKRRjpuCfSNJwvArlgeyqjjmXTfnHFAZCdl7bW7+1pexzL4WliVt/ResvwBrSi4ZfgaqXgCykkwDGWm4EsZ6pMB2G+XABdA/GXhXi1XDIPwBesuvPRcf9zeIdHbOUbJlxc8Pm3zHbzPgD5Wg4DjMhWRSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788794662; c=relaxed/simple;
	bh=53M13uLe2tDWwPpHOljST/aFN6C7iTXS5c1/+w9kOOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E9a1GYjcrtuzOTuWnkBo28Nw1gYiMyr/O8s68tEDfofF88KOxRVXhwmI6QxKHARIL+E2K8UBzLjcXfcUOP3IOdJHur7YdIAIA1saoPtAQ97LwVQAjKHhptLIKMcH+hS06hxVc8VsN/vBgQAUBKMlG4S62ojX6DFQQWrcmEdxToc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TgPLWoK3; arc=none smtp.client-ip=95.215.58.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TgPLWoK3"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=53M13uLe2tDWwPpHOljST/aFN6C7iTXS5c1/+w9kOOk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788794658; v=1; x=1789399458;
 b=TgPLWoK346LvOvh+5++prgFFITm2KxGTHxI3/b4WC+RmDpCtjzno7O8/7icyAw/y5TZPB5sa
 vZ4tkfTzteeI4k0M94U4dKj8xWV+qsu4eBOOYvlbiOArH02UHQOxlYl3L0vAPwioRC3ppzmWrCE
 eIt2DGRGp7ShlxKc598/6ipY=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 51765449fb49eae3;
	Mon, 07 Sep 2026 15:24:17 +0000
X-Mizu-Trace-ID: 51765449fb49eae3
X-Migadu-Flow: FLOW_OUT
Message-ID: <534e5a3b-5160-4619-8b2e-27a81783e17f@linux.dev>
Date: Mon, 7 Sep 2026 23:24:10 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/2] selftests/bpf: Move verifier failure tests
 out of test_global_percpu_data
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>,
 Quentin Monnet <qmo@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Shuah Khan <shuah@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, Sid Nayyar <sidnayyar@google.com>,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260904031912.2133476-1-tweek@google.com>
 <b965bb62-fcc8-4517-9947-24613650f1f5@linux.dev>
 <CA+zpnLc-WAqE9rA0PsjvOFe_YCZOdVj9YAzuayGXx0nhpqtw7g@mail.gmail.com>
Content-Language: en-US
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CA+zpnLc-WAqE9rA0PsjvOFe_YCZOdVj9YAzuayGXx0nhpqtw7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2026/9/7 13:46, Thiébaud Weksteen wrote:
> On Fri, Sep 4, 2026 at 4:07 PM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>> On 4/9/26 11:19, Thiébaud Weksteen wrote:
>>> Commit 4c9241bd731a ("selftests/bpf: Add tests to verify global percpu
>>> data") added test_global_percpu_data.c to LSKELS_EXTRA. Later, in commit
>>> 1ed2294b31fc ("selftests/bpf: Test verifier log for global percpu data")
>>> two verifier failure tests were added (verifier_strncmp and
>>> verifier_snprintf), both marked as non-autoload (SEC("?kprobe")).
>>>
>>> When bpftool generates light skeletons, non-autoloaded programs are
>>> skipped during loading, causing the loader program to store subsequent
>>> program FDs into incorrect skeleton struct fields (e.g. dump_percpu_data's
>>> FD was stored into verifier_strncmp's descriptor).
>>
>> IIUC, patch 2 will fix the issue totally.
>>
>> Better to add a subtest to verify both the issue and the fix?
> 
> Thanks for the review. That's right, patch 2 will fix the issue:
> bpftool will fail to build any program that is set up that way. That's
> why patch 1 is necessary; otherwise, the existing test would fail.
> 
> Just checking your suggestion: what I can do is add a new test to make
> sure that dump_percpu_data is set up as expected (fd > 0). I can write
> a new test_global_percpu_data_iter_lskel, that is similar to
> test_global_percpu_data_iter, but for lskel?
> 
> I can also write a test to ensure that bpftool fails when light
> skeletons are set up with autoload=false?
> 

imo, the rejection of autoload=false prog when generating light skeleton
is not friendly for users. Users should not care about mixing
autoload=false progs with autoload=true progs, even for light skeletons.

The users-friendly way is to skip those autoload=false progs when
generating light skeletons.

So, this is a bpftool issue. A selftest is unnecessary. You can verify
both the issue and the fix manually. Probably, paste the verification
result in the patch message.

Thanks,
Leon

