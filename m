Received: from mta1.migadu.com (out-122.mta1.migadu.com [95.215.58.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8AC2820AC
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 15:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792165817; cv=none; b=HXjkDF5wfAjxZRvVw/O1IpjlFqG7Jyn2/ZlT8rECAhhZ9+kZWK5G8R4rVFaUemRlllnAj6Q+DwDW2zmjR3geX3vNWoFezDO+iHW1t+znCEw41zmfnlfyeR9WtnMoJZ8tXSl+uU+K6JLbS6nT5Ua82uo0kFIxJe2mDZ7XcwXnrxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792165817; c=relaxed/simple;
	bh=qowOekNkerYC2L5Rwu/mhhul/YZ0dPwK59p6Wggv2uk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NGlLcfOFje87DVZaRJsLYT6dIup9/TWps8ojqgNFKKdhHKqy43pYwe9wN8WO6+ZIirG9cbs4jygXlN8i9fIkxamD8R/hiM/z1OtMCPIiAugIymgaexakIQtMJ88zrWnLEl5DJt2yDMZkR6lwHO9zKDBnD813BqDni6Z9q4rjYPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MY9MTIc1; arc=none smtp.client-ip=95.215.58.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MY9MTIc1"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=qowOekNkerYC2L5Rwu/mhhul/YZ0dPwK59p6Wggv2uk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792165813; v=1; x=1792770613;
 b=MY9MTIc1egs1EZTrtANReL0xrMefJEoIrwohlmzTBaDpRqw+atFKYBaFB5ZNrKEO7VnikohE
 yj0HQmZwVVx/o1Jtx2MJhMDxqfe5C5bda5oJLmFq2Jyg++YhMijeWROwXFGqe327ZCL4PsYX3ZG
 N3SUjhQHrmi83QQdT6bXe0PI=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 791dd37c3edc6a2a;
	Fri, 16 Oct 2026 15:50:13 +0000
X-Mizu-Trace-ID: 791dd37c3edc6a2a
X-Migadu-Flow: FLOW_OUT
Message-ID: <a420e9de-4546-4be8-9fc0-d9e9c9fa6fb3@linux.dev>
Date: Fri, 16 Oct 2026 08:50:10 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 00/11] bpf: Follow up by-value struct and
 __int128 argument support
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, kernel-team@fb.com
References: <20261013170910.2126673-1-yonghong.song@linux.dev>
 <DM5X4L58MG5M.2AK0D6DRZ5ERF@gmail.com>
Content-Language: en-GB
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <DM5X4L58MG5M.2AK0D6DRZ5ERF@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/15/26 7:48 PM, Alexei Starovoitov wrote:
> On Tue, Oct 13, 2026 at 10:09 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>>    v2 -> v3:
>>      - v2: https://lore.kernel.org/bpf/20261013003429.1853052-1-yonghong.song@linux.dev/
>>      - Index the two halves of a struct holding an __int128 in ctx by the
>>        byte order, so the tracing tests also hold on a big-endian
>>        kernel. (patches 6, 7 and 9)
> what?
> This is not enabled on s390, right?

Okay, I will enable s390.

> Pls don't add code just because a bot said so.

This is my mistake. In arm64, I just found:

config CPU_BIG_ENDIAN
         bool "Build big-endian kernel"
         depends on BROKEN
         help
           Say Y if you plan on running a kernel with a big-endian userspace.

apparently arm64 big endian does not get proper maintenance.

