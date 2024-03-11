Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F6358126
	for <bpf@vger.kernel.org>; Mon, 11 Mar 2024 21:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710194107; cv=none; b=Nl+rZiU4dzxDAoyG1GmvjX+WT73Rpea1R903jP/Jp9HTBW+7M1pVmgVn2sOapNxd1kagNHqdAIRkPDNj+2Q/F+IrPNv2IJXEta0EjEsJ0zpfWe2Hk3tr2OnMqiZr6j34awfaksv2OcwTP29EglI+hMesDkfktwxX9GfHXGmFDZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710194107; c=relaxed/simple;
	bh=Udi8+U/vtX2/LPgj4sUV0JI0Ggc7mamIf55Kp3zKe6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kvLskLLWqSHb2ZjXLUNA7xSjuwGX3s+tvTee4GQ8YAeE/UyTXk8xPBEGdadZIJHi1xb6QzbZ28BH2urfNrd3S7VYfSZP3g3UiXogwn73QRbzu4z+VMxgwUJYVAplVzyAQWBDIVDtwpsYnvJG7hWHIEQvZhtPe3/zOxOlCWIWQa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HSV3jFMY; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HSV3jFMY"
Message-ID: <f12bb629-868b-4357-a097-cdbb6c0df163@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710194104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uhtGK/COtiytU70gjYaRGYYvLbxnBHUfL2rl+0P/3jo=;
	b=HSV3jFMYBQVicuy5a816uP1R5g6Hj7SjHf2h3hehEvvyDgQs8HChQxg8bCZ/JbfO+Ssyyk
	mQU93t1LhIX/XQd/ozqDjas7gdAYCAVwzdLHETrNlqZtNPoY/vpQTcprT86kO31J+Oyrrt
	tJNWIejoInzy6m9tEW96QZIrjIq5iW8=
Date: Mon, 11 Mar 2024 14:54:58 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next 4/5] bpftool: Add link dump support for
 BPF_LINK_TYPE_SK_MSG
Content-Language: en-GB
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20240305202155.3890667-1-yonghong.song@linux.dev>
 <20240305202216.3891808-1-yonghong.song@linux.dev>
 <87frwyrku7.fsf@cloudflare.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <87frwyrku7.fsf@cloudflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 3/8/24 8:07 AM, Jakub Sitnicki wrote:
> On Tue, Mar 05, 2024 at 12:22 PM -08, Yonghong Song wrote:
>> An example output looks like:
>>    9: sk_msg  prog 108
>>            map_id 84  attach_type sk_msg_verdict
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   tools/bpf/bpftool/link.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
>> index afde9d0c2ea1..5eb140197d3f 100644
>> --- a/tools/bpf/bpftool/link.c
>> +++ b/tools/bpf/bpftool/link.c
>> @@ -526,6 +526,9 @@ static int show_link_close_json(int fd, struct bpf_link_info *info)
>>   		show_link_ifindex_json(info->netkit.ifindex, json_wtr);
>>   		show_link_attach_type_json(info->netkit.attach_type, json_wtr);
>>   		break;
>> +	case BPF_LINK_TYPE_SK_MSG:
>> +		jsonw_uint_field(json_wtr, "map_id", info->skmsg.map_id);
>> +		show_link_attach_type_json(info->skmsg.attach_type, json_wtr);
> Compiler says - missing break.

Ack, will fix.

>
>>   	case BPF_LINK_TYPE_XDP:
>>   		show_link_ifindex_json(info->xdp.ifindex, json_wtr);
>>   		break;
>> @@ -915,6 +918,11 @@ static int show_link_close_plain(int fd, struct bpf_link_info *info)
>>   		show_link_ifindex_plain(info->netkit.ifindex);
>>   		show_link_attach_type_plain(info->netkit.attach_type);
>>   		break;
>> +	case BPF_LINK_TYPE_SK_MSG:
>> +		printf("\n\t");
>> +		printf("map_id %u  ", info->skmsg.map_id);
>> +		show_link_attach_type_plain(info->skmsg.attach_type);
>> +		break;
>>   	case BPF_LINK_TYPE_XDP:
>>   		printf("\n\t");
>>   		show_link_ifindex_plain(info->xdp.ifindex);
