Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD90F4BE426
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 15:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791475148; cv=none; b=jZLRnr9QTK6enGClYNDYniZPsszulzqRxfhSSF13lQaTYFcoiMn8BJIy5Joz5JOFZrN9Cm12j/1VpLYS9lhcDy+WDd5Udtkw3slP9Jlm4IoGBOlArtto2mrdxK09iI4Uh0o4EDMvu/rksCZsj3aNs6JweXVMlb+vsS3g5EP/uDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791475148; c=relaxed/simple;
	bh=zPX96GQ6txDlUgmlBzrf0o0U08Z0u/U2GhsboQ9/95k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H1kBg1Ylvpvn+TLNq10tPdUP/Lrz5gFmPJoATz+AVrpuNqUalVrG2ID5eIftr1MsK12cPEcgeYOJ8nD/94+zFZBOwhtmD/IeQ4X+cCf4kyLlUSxIkVUYFSM0ix3mKr8EXTMLbYb4wUl/OkVm0yEuk+oMIreVlfHBb+Hl5slI3v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=lDKNiEn2; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="lDKNiEn2"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 3F4C182AA0;
	Thu, 08 Oct 2026 17:59:03 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KOHYqXGHgoyr; Thu,  8 Oct 2026 17:59:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1791475142; bh=zPX96GQ6txDlUgmlBzrf0o0U08Z0u/U2GhsboQ9/95k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=lDKNiEn2ZjlDGM1K1paZ35Wd+sqf8zQXvRQ2KXnNiwwkn973LM53VHGN3f6hqeJKN
	 nYg9Yn0ZgWjYhPt1tPvYHudUyzyfHX9hjEDq3jRrRAkwnoYG69bhKpDywdnHNWS0jO
	 X2ZyNWQQUnBoHnhsBM3VHUtqWdoogLK5UBHgqwMWBzvsXF4QSYNCN0FNVT9Isx+7K9
	 xyjKQdYjzzi7VsddnF0CvAgVF8FAOPfZw57NaStg6Ttb6j9AyFU2wRbyyDMgWtUWH1
	 2gXxBK1tRf11xyV9W2jFwnL8wX4+gcNh5QpMiVHuD0msbt0vyyMItRON9lsb3b9Qdt
	 HH9z+4wic+y5w==
Message-ID: <ffd08508-19bc-4787-8aed-26a8a0f43a8d@disroot.org>
Date: Thu, 8 Oct 2026 16:58:56 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v6 3/3] selftests/bpf: add tests for percpu map flags
 combination
To: Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, ihor.solodrai@linux.dev, john.fastabend@gmail.com
References: <20261008120734.1565972-1-maghasi@disroot.org>
 <20261008120734.1565972-4-maghasi@disroot.org>
 <2ae7b3d0-6350-4145-a5da-7a9a81a845d4@linux.dev>
Content-Language: en-US
From: Masoud Aghasi <maghasi@disroot.org>
In-Reply-To: <2ae7b3d0-6350-4145-a5da-7a9a81a845d4@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/10/2026 14:28, Leon Hwang wrote:
> On 2026/10/8 20:07, Masoud Aghasi wrote:
>> All possible combinations of (BPF_EXIST, BPF_NOEXIST) and
>> (BPF_F_ALL_CPUS, BPF_F_CPU) flags are covered for all percpu map types.
>>
>> As BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE does not support BPF_NOEXIST and
>> also in order to reduce the amount of code duplicates, I added its
>> new test scenarios to the existing cpu_flag_percpu_cgroup_storage test.
>>
>> But for other percpu map types, I added new tests to be able to
>> exercise all flag combinations and the edge cases such as percpu LRU
>> unnecessary deletion issue.
>>
>> Signed-off-by: Masoud Aghasi <maghasi@disroot.org>
> 
> Two concerns below, others lgtm.
> 
> Acked-by: Leon Hwang <leon.hwang@linux.dev>
> 
>> ---
>>  .../selftests/bpf/prog_tests/percpu_alloc.c   | 254 ++++++++++++++++++
>>  1 file changed, 254 insertions(+)
>>
> 
> [...]
> 
>> +
>> +	if (map_type != BPF_MAP_TYPE_LRU_PERCPU_HASH)
>> +		goto out;
>> +
>> +	/* Percpu LRU hash map should not delete old entries unnecessarily */
>> +	flags = BPF_F_ALL_CPUS | BPF_NOEXIST;
>> +	key = 2;
>> +	err = bpf_map_update_elem(map_fd, &key, values, flags);
>> +	if (!ASSERT_OK(err, "bpf_map_update_elem lru_percpu_hash all_cpus|noexist"))
>> +		goto out;
> 
> Update values[0] before update_elem(), and verify_map_value_all_cpus()?
> 
> Also update values[0] before the below update_elem().
> 
>> +
>> +	flags = BPF_F_ALL_CPUS | BPF_EXIST;
>> +	err = bpf_map_update_elem(map_fd, &key, values, flags);
>> +	if (!ASSERT_OK(err, "bpf_map_update_elem lru_percpu_hash all_cpus|exist"))
>> +		goto out;
>> +
>> +	key = 0;
> 
> Why do you use 'k = 0' instead of '2'?
> 
> I think we should update and verify using the same key.
> 
> Thanks,
> Leon
> 
> 
>> +	verify_map_value_all_cpus(map_fd, &key, values, elem_sz, first_value, nr_cpus);
>> +
>> +out:
>> +	close(map_fd);
>> +	free(values);
>> +}
>> +
> 
> [...]

Thanks for the review.

Regarding your remaining concerns, I designed these new tests to cover
all changes made in arraymap.c and hashtab.c. For example, if we revert
my change to __htab_lru_percpu_map_update_elem() in hashtab.c, the last
verification in this test for key '0' will fail.

It shows that the change is necessary to prevent unnecessary deletion of
old keys by percpu LRU maps. In the case of this test, inserting and
updating the last element (key '2') of a map of 3 entries should not
cause unnecessary deletion of the first key (key '0').

And regarding not verifying the last 2 updates, I left those out because
we already tested the (BPF_F_ALL_CPUS | BPF_NOEXIST) and
(BPF_F_ALL_CPUS | BPF_EXIST) flag combinations for LRU maps (and other
types) in previous code, so there was no need to test them again. the
final part of this test is only meant to cover a specific LRU map
scenario that I discussed with Alexei in V2.
