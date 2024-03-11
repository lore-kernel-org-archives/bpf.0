Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D803D433CC
	for <bpf@vger.kernel.org>; Mon, 11 Mar 2024 22:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710194857; cv=none; b=GMAAcCyKX2pqDnZ6JOEJj3uvZ4GukJGql1CyL6yb6OW6wycwzAEluwq63nuigqqFISqtPzmFQnQ2kcRw+PvPJUKVt9uPkSAxA8AZPypt9evoorvG3Q3c8VsHOHrCGB3yO3Xg1NlFJkvxacPgxbIIQDnLEBXdKL+m/jog51T6IFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710194857; c=relaxed/simple;
	bh=n5/e1tKxAn5jpFuT7rwOcfRKIcyufVzi2uBHdvqS1gg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZbE7oBUD9WMUa/CD1HP5KijgvJOqZGYzjOsvxzzJeIwlXnWXV1Y64yNsqiN9XP8L3+WWlt1suRrMm/STKc6/lO83h8Dd2QpKFOI6GeKYFXA/bXToOnS5YnqB/Xxi7lhry9A26tWVLd7meD8eywEQwf8WVKjJn1CZLNYYwfAGSEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=maf/UfW5; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="maf/UfW5"
Message-ID: <2f695aba-9bed-426b-a553-42df361b205e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710194853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L10RWgIVmNlY2vV5Qp2VtR1pwiOxEATKHqWmX28nL9E=;
	b=maf/UfW5ZsnwrVrmgJwys5Ctfptkmg62sMTMx/Ho6OJxwD8VdPgLh7fH+fgKI9Sgo3fshN
	+NxlcQf+QvjFAdsNHUI8UeU5TRvTNY1KdZ+jpioRlG0K1Pj6g2GsR7qBNpPZIGuSo4PBXm
	kFv0nq8TMm9YA4UR9GQSqxBIrW6Rj+o=
Date: Mon, 11 Mar 2024 15:07:27 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next 1/5] bpf: Add link support for sk_msg prog
Content-Language: en-GB
To: Jiri Olsa <olsajiri@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20240305202155.3890667-1-yonghong.song@linux.dev>
 <20240305202201.3891042-1-yonghong.song@linux.dev> <Ze7BI241JAWya1eo@krava>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <Ze7BI241JAWya1eo@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 3/11/24 1:30 AM, Jiri Olsa wrote:
> On Tue, Mar 05, 2024 at 12:22:00PM -0800, Yonghong Song wrote:
>
> SNIP
>
>> +
>> +int bpf_skmsg_link_create(const union bpf_attr *attr, struct bpf_prog *prog)
>> +{
>> +	struct bpf_link_primer link_primer;
>> +	struct bpf_skmsg_link *skmsg_link;
>> +	enum bpf_attach_type attach_type;
>> +	struct bpf_map *map;
>> +	int ret;
>> +
>> +	if (attr->link_create.flags)
>> +		return -EINVAL;
>> +
>> +	map = bpf_map_get_with_uref(attr->link_create.target_fd);
>> +	if (IS_ERR(map))
>> +		return PTR_ERR(map);
>> +
>> +	skmsg_link = kzalloc(sizeof(*skmsg_link), GFP_USER);
>> +	if (!skmsg_link) {
>> +		ret = -ENOMEM;
>> +		goto out;
>> +	}
>> +
>> +	attach_type = attr->link_create.attach_type;
>> +	bpf_link_init(&skmsg_link->link, BPF_LINK_TYPE_SK_MSG, &bpf_skmsg_link_ops, prog);
>> +	skmsg_link->map = map;
>> +	skmsg_link->attach_type = attach_type;
>> +
>> +	ret = bpf_link_prime(&skmsg_link->link, &link_primer);
>> +	if (ret) {
>> +		kfree(skmsg_link);
>> +		goto out;
>> +	}
>> +
>> +	ret = sock_map_prog_update(map, prog, NULL, attach_type);
>> +	if (ret) {
>> +		bpf_link_cleanup(&link_primer);
>> +		goto out;
>> +	}
>> +
>> +	bpf_prog_inc(prog);
> there's already prog ref taken in link_create, is this needed?
> also I might be missing some skmsg logic, but I can't see thi
> being released

Here, we are trying to do create/attach.
The prog reference count will be decremented during detach
(sock_map_prog_detach), so we need to increase prog ref count here.

Another thing, it is possible a attached prog is swapped out.
In current implementation, ref count will be decremented for
the prog swapped out. So increasing ref count for prog here
is needed to balance that ref count decrement.

>
> jirka
>
>> +
>> +	return bpf_link_settle(&link_primer);
>> +
>> +out:
>> +	bpf_map_put_with_uref(map);
>> +	return ret;
>> +}
[...]
