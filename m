Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D35A535FA4;
	Tue, 22 Sep 2026 10:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790072604; cv=none; b=XFFJoOcIsSmXgEsfLudND0nw0Sr4XfsBcl/KNiex8ujct2gDHluhUXI035Y44LmclC4w6LgHpYwKnot7Siv3LcNl3uIY1H4hRckkUzB4SdNJ/H5fwz7/lJ7Ftb+RxeKs/qI7aHCLXoFojqhxAZtmtgmKtfb1sRUKNv9s8CWCSPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790072604; c=relaxed/simple;
	bh=OuXowQu0pFavRo/VbH4LNLgHYsFOhtCMxKtXQcJF5jY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d1fPcFw9QchpKGiTu1gTGjJZikDgMIb/p6gWOMF+GnuE5SuyhBP/WFsLQxLBrT5l6gDE5+pmlSaz96Blm4Vgm19iFBzPUJqWPweXLlWR19Vrjl1SThSIl3IAOaLM7oIfq769XwVXvA/5q+zmQiMrUx1Vyqm64Lf7DJ11q4TNLow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fKKN05Zr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fKKN05Zr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 194501F00899;
	Tue, 22 Sep 2026 10:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790072602;
	bh=sqMXtwWitw2wDFuAHBZDYhScXx6SNrG7wuj83oz5V/s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=fKKN05ZrnQE1yvvSgPtbG723m9C6bQvMtdcj3pOkpoCwu+Cxk+Xon9JEFo4XLxyhf
	 P84PhQC4Eucs8DejIwagA/SRiNnTCGWY6677nIPozitlFzmNHACsGS0/DyjksC6jdM
	 /pSjxKHMkXlwfnOu46i2SoqB3woBzDZGheqy8i0lMxvBpfaJlc6NLR9nEgzEfPqkai
	 BSmsHRFcWZqL67ioNyrISdxRRvOdsWMD5HV75tJW8rx5Z8wo/gwsb+ZL75n8TajyKW
	 /5tW0yImP1kMr2Jrv/3I0ty+YRRUbqQqRVNbfEbfoIYNkJNdUrxKp0f8zT6GnE2FZc
	 iUnzWQKoFXcnw==
Message-ID: <c709ed02-c263-4e1a-82e3-0668faf8986f@kernel.org>
Date: Tue, 22 Sep 2026 11:23:20 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 3/3] bpftool: Add support for BPF_F_PREORDER
 cgroup attach flag
To: sashiko-reviews@lists.linux.dev, Hui Su <sh_def@163.com>
Cc: bpf@vger.kernel.org
References: <20260922025442.3176057-1-sh_def@163.com>
 <20260922025442.3176057-4-sh_def@163.com>
 <20260922030143.E4F7F1F000FF@smtp.kernel.org>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20260922030143.E4F7F1F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2026-09-22 03:01 UTC+0000 ~ sashiko-bot@kernel.org
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] bpf: bpftool JSON ABI breakage for attach_flags field
> --
> 
> commit 7ba7f84eaca8177e2045dffce655aae4da559465
> Author: Hui Su <sh_def@163.com>
> 
> bpftool: Add support for BPF_F_PREORDER cgroup attach flag
> 
> This commit adds support for the BPF_F_PREORDER cgroup attach flag to
> bpftool. It updates attach operations to accept the new flag and modifies
> the show operations to output combinations of attach flags, rather than
> just a single flag.
> 
>> diff --git a/tools/bpf/bpftool/cgroup.c b/tools/bpf/bpftool/cgroup.c
>> index ce69d1e5468e3..fee1a260f6d1a 100644
>> --- a/tools/bpf/bpftool/cgroup.c
>> +++ b/tools/bpf/bpftool/cgroup.c
> 
> [ ... ]
> 
>> +static void show_attach_flags_json(__u32 flags)
>> +{
>> +	char buf[32];
>> +	size_t i;
>> +
>> +	jsonw_name(json_wtr, "attach_flags");
>> +	jsonw_start_array(json_wtr);
>> +
>> +	for (i = 0; i < ARRAY_SIZE(attach_flag_names); i++) {
>> +		if (!(flags & attach_flag_names[i].flag))
>> +			continue;
>> +
>> +		jsonw_string(json_wtr, attach_flag_names[i].name);
>> +		flags &= ~attach_flag_names[i].flag;
>> +	}
>> +
>> +	if (flags) {
>> +		snprintf(buf, sizeof(buf), "unknown(%x)", flags);
>> +		jsonw_string(json_wtr, buf);
>> +	}
>> +
>> +	jsonw_end_array(json_wtr);
>> +}
> 
> [ ... ]
> 
>> @@ -182,7 +240,7 @@ static int show_bpf_prog(int id, enum bpf_attach_type attach_type,
>>  		else
>>  			jsonw_uint_field(json_wtr, "attach_type", attach_type);
>>  		if (!(query_flags & BPF_F_QUERY_EFFECTIVE))
>> -			jsonw_string_field(json_wtr, "attach_flags", attach_flags_str);
>> +			show_attach_flags_json(attach_flags);
> 
> [Severity: Medium]
> Does this change break bpftool's JSON ABI by changing the attach_flags
> field from a string to an array?


It does. I suggested it, given that appending ",preorder" to the flag
may break parsing anyway, so we may just as well take this chance to use
the right JSON format for these flags. I'm fine taking in that change,
and documenting it in the next release notes on GitHub. Alexei may
disagree, though, so let's see.

Quentin


> Previously, this field was output as a single string. Changing the data type
> to an array could cause external scripts or applications using strict JSON
> parsers to crash or fail to unmarshal the output when running 
> bpftool cgroup show -j.
> 
> Would it be safer to format the multiple flags as a single comma-separated
> string in the JSON output, similar to what is done for the plain-text output,
> to maintain backwards compatibility?
> 
>>  		jsonw_string_field(json_wtr, "name", prog_name);
>>  		if (attach_btf_name)
>>  			jsonw_string_field(json_wtr, "attach_btf_name", attach_btf_name);
> 

