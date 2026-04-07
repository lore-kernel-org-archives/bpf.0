Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF551F94F
	for <bpf@vger.kernel.org>; Tue,  7 Apr 2026 00:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775521412; cv=none; b=hXPXQdbzIV6OFDVzAOEriFLKyP4zdwdQ+2mY0xACLYRsjIuIpVNuQ4dKSMbZSyZds7tPPvFMO+GD7E3KX/WfqFRU7xnOfSBES04VSKjnZYKuvcJhAnS5EXsVJaKscsTys+lK2BHZh/EdzTzEAehdjcH0khLer4LUh6xhTVAMisA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775521412; c=relaxed/simple;
	bh=lW1h8GIW1G7Y8bB+cJ7RTj5puhWMR1ctHsFJC0k0lWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o5qdmRHHS6UvwAHJUx245uUjdXgrm30Y+Y+nWEE1QAkE4HfHI4X8qSqiqTZrYbirldopakKliLG3dsU9Mu20FMRCd5XiSFhI0gcSkggUJ0aQ99NT+B7Qikuw/JIgF3qBapNB6eFDCKQe+L2dvjaIyHQwIpjK0z6Ne9nzCKGMEPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=yqKyYXrE; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="yqKyYXrE"
Received: from eig-obgw-5007b.ext.cloudfilter.net ([10.0.29.167])
	by cmsmtp with ESMTPS
	id 9mBiwNpQNnwj29uE1wGjOL; Tue, 07 Apr 2026 00:23:25 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id 9uE0wRKV4xUZ29uE1wYdBa; Tue, 07 Apr 2026 00:23:25 +0000
X-Authority-Analysis: v=2.4 cv=HJHDFptv c=1 sm=1 tr=0 ts=69d44e7d
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=chC0KcwHAXg1M6QkddG+Hg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=nBrjwPefxIf0sgGFksoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=2aFnImwKRvkU0tJ3nQRT:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3xEoyAKUR0aMkxGmDAp9eHmMZqaIfxw1R+sbaa6gt5c=; b=yqKyYXrECCIzd1nuiz0Fa9Uaz1
	ElyOACTfk2Liecd2KEU7+Pc9+b0j1yx69J5YW7cPTryfO4qJlN8mB0oJ1k+StPhqg4oDTTCYIMmZN
	ejOUUFBQvdJ6Sw41fkgJtHyiNhuL3jo2/jgCuz/HzuJd8AmrKjPVN2WCFM2WLvlfn2iT3OgsmVCg7
	soVNndT8lUzjhh/QgX1tHYv6eOueWJTJmAsMAsQthhMB77eUSPpvxdsBe03GoDEFace2RGHy1nPXI
	+rv9c98NP991TadlMIBFyz0vpikQ8QCc+nD9L7fqYAagIuygzkY5VtRCUxLQXXam2jwXiAd8ph3RM
	/vmQ1x0g==;
Received: from [177.238.18.219] (port=36690 helo=[192.168.0.36])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.99.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1w9uE0-00000000ad4-0S8K;
	Mon, 06 Apr 2026 19:23:24 -0500
Message-ID: <05f45fbc-858e-41d3-95fc-67cd4956dc3f@embeddedor.com>
Date: Mon, 6 Apr 2026 18:22:15 -0600
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2][next] bpf: Avoid thousands of
 -Wflex-array-members-not-at-end warnings
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Kees Cook <kees@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-hardening@vger.kernel.org
References: <acr7Whmn0br3xeBP@kspp>
 <CAADnVQL1kaAZE0L2k6svR4FK8UZvw44WXp=g+Df+SseMkc7xGA@mail.gmail.com>
 <202604052007.4EF0560F@keescook>
 <CAADnVQ+NMQMpkG8gZPnwBD1MMPsH+uJ65C9bMeGf_YH5Cchxpg@mail.gmail.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <CAADnVQ+NMQMpkG8gZPnwBD1MMPsH+uJ65C9bMeGf_YH5Cchxpg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 177.238.18.219
X-Source-L: No
X-Exim-ID: 1w9uE0-00000000ad4-0S8K
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.36]) [177.238.18.219]:36690
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfL+xHeA/WOnHFpaRYA3MAq3MgpdwK8vmnUrh5cwuaxelKoSBEPNod5TDOsIFcsOKcDkuO1UM3Rm2af40Tw8UnnE2ToK5jfr01jXsILU15FbLQcZOcxIZ
 3/Rx3j13vRDXVuXvi6ls+KPnMe8PFf02e23bCyWjJwDEyBMNfjdTLzn9wtGJK+gFZsfIKe/AU0Ibsyl+HexFsHXUq+xPojgqxuM=



On 4/6/26 17:24, Alexei Starovoitov wrote:
> On Sun, Apr 5, 2026 at 8:27 PM Kees Cook <kees@kernel.org> wrote:
>>
>> On Sun, Apr 05, 2026 at 07:44:51PM -0700, Alexei Starovoitov wrote:
>>> On Mon, Mar 30, 2026 at 3:39 PM Gustavo A. R. Silva
>>> <gustavoars@kernel.org> wrote:
>>>>
>>>> Apparently, struct bpf_empty_prog_array exists entirely to populate a
>>>> single element of "items" in a global variable. "null_prog" is only
>>>> used during the initializer.
>>>>
>>>> None of this is needed; globals will be correctly sized with an array
>>>> initializer of a flexible-array member.
>>>>
>>>> So, remove struct bpf_empty_prog_array and adjust the rest of the code,
>>>> accordingly.
>>>>
>>>> With these changes, fix the following warnings:
>>>>
>>>> 7659 ./include/linux/bpf.h:2369:31: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
>>>>
>>>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>>>> ---
>>>> Changes in v2:
>>>>   - Remove struct bpf_empty_prog_array. (Kees)
>>>
>>> Kees,
>>>
>>> It really bothers me that you ask people to clean up
>>> warnings for the sake of removing warnings.
>>
>> It's not for the sake of warnings; this is to remove the ambiguously
>> sized objects (i.e. structs that the compiler cannot reason about the
>> size of).
> 
> I read through the AI debug logs. What steps it took to reason that
> the fix is correct, and it convinced me that I'm wrong.

What prompted you to think this was a "ticking time bomb"?

> Applied.

Thanks

-Gustavo
