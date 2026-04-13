Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A4438C2DF
	for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 21:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776114663; cv=none; b=oO755PwAWUQ698C4tB5d4eSEejxZc7Tekhl16YXO983LZWDwMlCr60rmDRnjs+K8sBBQng/YWLY5QQuv6IZB9HgQzdB07+3MrIzzY6paCjd6KIfy6O+ICdXnrC9d5QKHizEXlCkOL4G7G+4Wesn+d6XuJhgR5PRawSG9B3HWwHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776114663; c=relaxed/simple;
	bh=0zQ7nmr21fDAthgDHtT5MG9brM4iY5/RlvWDWslHz9E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XVPxLQHsGkv69ERkKNVPLcHpjB3WEFpSBZWZqPJB7H4gLmD/iRBd/XD9vGmnZIhfs77rg0HLQOW+1gjyGa9QdQD7pd3QTsm+auQb6hfZxZ23oOFy/BsITEVBQCExdJiGfHjD801UiaGWO8Eypc97JF7ubCrr/juOKyqeyRFI4GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dRvGhhlY; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dRvGhhlY"
Message-ID: <7cd7892e-0a6a-4790-b42e-d85693f54a26@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776114658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i0awaSKOG3/IBOrgNCWh6DMjOEC/iI/nLzVxdzPEZSo=;
	b=dRvGhhlY5M5utNaJ9FgTHOnmX1EA9dB428NiV/h+HWhNPmIkjL2a5kt1jYa2wBIpOf7mpt
	agdnO86MX3PNspWGS+qBt4y6T/fC2ZDkaHU5UBHcPgu2cnURXiWY/1iaqoCWHp/kQOAeqB
	VJJEPBVR9PJKYp67sNr9RWhI/Xoe/u8=
Date: Mon, 13 Apr 2026 14:10:53 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 15/18] bpf,x86: Implement JIT support for
 stack arguments
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 "Jose E . Marchesi" <jose.marchesi@oracle.com>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
References: <20260412045826.254200-1-yonghong.song@linux.dev>
 <20260412050033.267815-1-yonghong.song@linux.dev>
 <CAADnVQL462NnYNquWqJL8=CFZr6vJOxVzCPCpijV2MLAx0y67A@mail.gmail.com>
 <281485db-073e-45b6-8929-dad36fea5f87@linux.dev>
 <CAADnVQ+Xem-VErMn9f2MC52ugofFkA+XcUz4OqgvxJ9wTVz0JQ@mail.gmail.com>
 <8c205cc8-4c59-4c1d-a845-c647b2574d4e@linux.dev>
 <CAADnVQLPDdOxz+V6FO+CtEM5iA+QXey4BTtJTTtRHV4niZsizw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQLPDdOxz+V6FO+CtEM5iA+QXey4BTtJTTtRHV4niZsizw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 4/13/26 1:38 PM, Alexei Starovoitov wrote:
> On Mon, Apr 13, 2026 at 1:32 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>
>>
>> On 4/13/26 12:59 PM, Alexei Starovoitov wrote:
>>> On Mon, Apr 13, 2026 at 10:26 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>>>> Yes, we can do something like below:
>>>>
>>>>                    case BPF_ST | BPF_MEM | BPF_DW:
>>>> -                       if (adjust_stack_arg_off && insn->off == -outgoing_stack_arg_depth) {
>>>> +                       if (dst_reg == BPF_REG_STACK_ARG_BASE && insn->off == -outgoing_stack_arg_depth) {
>>> Something like that, but use BPF_REG_ARG_PTR name ?
>>> here and in the verifier?
>> We have a bunch of ARG_PTR_* (e.g. ARG_PTR_TO_MAP_VALUE, ...).
>> So maybe BPF_REG_STACK_ARG_PTR to distinguish ARG_PTR_*?
>> BPF_REG_STACK_ARG_BASE_PTR seems a better name as it does represents
>> the base pointer for stack arguments of a particular function.
>> But BPF_REG_STACK_ARG_BASE_PTR seems too long so BPF_REG_STACK_ARG_PTR?
> both are too long.
> I reacted to BPF_REG_STACK_ARG_BASE. Since it was already too long.
> BPF_REG_PARAMS ?

BPF_REG_PARAMS should be okay considering we do not want a longer name.

