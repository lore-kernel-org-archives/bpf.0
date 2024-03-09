Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07B5BA4D
	for <bpf@vger.kernel.org>; Sat,  9 Mar 2024 18:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710009836; cv=none; b=u8ghmfMiVBp4DtwepGhc337VC51Hy1D0WXlxVx6Z6vVt0fHsEbIfO+IeTYM73whPK4/9r+gsOLkQcCE+DdWoYjhqtWYFKDt14h9z8YFGyKtL/C90VyQN5+S7uAQk4tEWLMTLlVNMINAuNZcOzkKFcFec8hpCU9d6bKj8avsfyk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710009836; c=relaxed/simple;
	bh=sF1yl79clmsu0QnLYHNvQkTkVExCDAOQiAfJmQVPn2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u4mF3OCho4Q5n3/JhDq3UJL/uau3dcqqDgiAmt7UKTnVF1ae/oCs8X9tBvvvCN7iA4TWT+mqDw6qlapiZfCzWHZ9o3SPgu0L/oGc3+kprdzWDCTTpgtYf/f9D9f3z87BD9sEDLItqBSwGNJBwieeDARA1c0BGg2KJ21GO9Bc/4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=H+arfQGq; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="H+arfQGq"
Message-ID: <447531b4-a2a1-4921-b00d-871f522f1477@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710009832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ROshZART8urp73HBr0pmYYj6VNF2CC4dNHAXQ2k18O4=;
	b=H+arfQGqN0QvZ6hHgm9GrubXYBR1BAvUcXyTKaZmPDozu7+tUDyyVnHWLEtxOkOkZmx9jw
	fUeBKfCzW+VXBND8zyXoaUpV3W+VxEZ/HZLhQQLq1QwMqRu8dEG8VptlgFiT6WBz0Mq9Ug
	DBba91k2TVkKsyDg13RrNlXfCCeHmvM=
Date: Sat, 9 Mar 2024 10:43:44 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next 2/5] libbpf: Refactor bpf_program_attach_fd()
Content-Language: en-GB
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20240305202155.3890667-1-yonghong.song@linux.dev>
 <20240305202206.3891411-1-yonghong.song@linux.dev>
 <CAEf4Bza0sbBXRmFQDN82cE0=v7xiRqx5tcHG-tu+MwaLNqzn+w@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAEf4Bza0sbBXRmFQDN82cE0=v7xiRqx5tcHG-tu+MwaLNqzn+w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 3/8/24 5:02 PM, Andrii Nakryiko wrote:
> On Tue, Mar 5, 2024 at 12:22 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>> Refactor function bpf_program_attach_fd() to provide a helper function
>> which has attach_type as one of input parameters. This will make later
>> libbpf change easier to understand.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   tools/lib/bpf/libbpf.c | 18 +++++++++++++-----
>>   1 file changed, 13 insertions(+), 5 deletions(-)
>>
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index 6c2979f1b471..97b573516675 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -12151,11 +12151,10 @@ static int attach_lsm(const struct bpf_program *prog, long cookie, struct bpf_li
>>   }
>>
>>   static struct bpf_link *
>> -bpf_program_attach_fd(const struct bpf_program *prog,
>> -                     int target_fd, const char *target_name,
>> -                     const struct bpf_link_create_opts *opts)
>> +__bpf_program_attach_fd(const struct bpf_program *prog, int target_fd,
> I hope we won't need this patch at all (see my comment on later
> patch), but if we do need to do this refactoring then a) let's not
> used underscore-prefixed names, this is not a common practice in
> libbpf code base and b) I think we can just update all callers of
> bpf_program_attach_fd() to pass attach_type directly, there are just 6
> of them.

I thought about this 'update all callers of bpf_program_attach_fd
' but did not do that since it needs to update all callers. But since
you suggest this I certainly can do this.

>
>> +                       enum bpf_attach_type attach_type, const char *target_name,
>> +                       const struct bpf_link_create_opts *opts)
>>   {
>> -       enum bpf_attach_type attach_type;
>>          char errmsg[STRERR_BUFSIZE];
>>          struct bpf_link *link;
>>          int prog_fd, link_fd;
>> @@ -12171,7 +12170,6 @@ bpf_program_attach_fd(const struct bpf_program *prog,
>>                  return libbpf_err_ptr(-ENOMEM);
>>          link->detach = &bpf_link__detach_fd;
>>
>> -       attach_type = bpf_program__expected_attach_type(prog);
>>          link_fd = bpf_link_create(prog_fd, target_fd, attach_type, opts);
>>          if (link_fd < 0) {
>>                  link_fd = -errno;
>> @@ -12185,6 +12183,16 @@ bpf_program_attach_fd(const struct bpf_program *prog,
>>          return link;
>>   }
>>
>> +static struct bpf_link *
>> +bpf_program_attach_fd(const struct bpf_program *prog,
>> +                     int target_fd, const char *target_name,
>> +                     const struct bpf_link_create_opts *opts)
>> +{
>> +       return __bpf_program_attach_fd(prog, target_fd,
>> +                                      bpf_program__expected_attach_type(prog),
>> +                                      target_name, opts);
>> +}
>> +
>>   struct bpf_link *
>>   bpf_program__attach_cgroup(const struct bpf_program *prog, int cgroup_fd)
>>   {
>> --
>> 2.43.0
>>
