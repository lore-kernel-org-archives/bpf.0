Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B2C49BB57
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 18:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792175302; cv=none; b=MbDsq8y+91K1gfDmQWFwD/vXU2U+Lc3Px4W9fLj9zr7qxATwxm9pCkYLZIrB1hEKEO93q5e6wNgVx+O7DlbVuTsA614HeibZ5YRnBTeOT/Uu7o2gD/r/XGTDEnSmBW9qdb5Ui5VEx2vx6r59ZtqWcCNKLDaNrtMfA0HTM/rrteo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792175302; c=relaxed/simple;
	bh=ma6YwNPEIuaMk+9YiZiDq5rJF/y+IJ6pbtWjOaiw/II=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YtbHQX/8OEfs/XbqKQKnJs+AAzOKjhLxxRUNPuQDs0FtHv22Sgvsfx69dR7lrA6ifsphGwiMZyyHdcZ9iV8bLVozfSMSbYnsjOvFwJuiijJlh7g1WFtlmphk7cpi5qZbsqcCVLDCYs3Ia0X23+AjeKonJR6K3K/2jQ4O2ROVDbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=LR5YVb4H; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="LR5YVb4H"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=QtaVNtCkkz4aW/kftFdCI0Cra3bWyPaCZB7MzpS1R/M=; b=LR5YVb4HL3ksWDuOre90leHUlh
	V1vb4BOe9/khGUdBWEJFKnOsi0EUNxx6eQ95hcm6Wg80E8wMLLtQYPYmb4CrW2xHeNKqtatvnpZvn
	8h0j1+UpyUtTqyPKoEPnX93fhd3UoBfhXGLLBxnRP9SmZvY1XP77c3TLJxCY1gO6fZ5/xQpJ2OpYF
	tNfDPGvlt9q/d9d+k5FCfXRfLjWWbGMqZB2uJn46i03dAUL+9qblnHHsQXOM25bI97f4uVRiNBKtJ
	iZhxOF+cB12b3yAhMrjhCK3TAk5jpvnRQH4d698hAs8aCqyFTTfEhjeR47sMQe1BjTVB+JIRrjcQJ
	8T1h/mKw==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xHmf6-000I79-2g;
	Fri, 16 Oct 2026 20:28:12 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy03.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1xHmf6-000HU8-0n;
	Fri, 16 Oct 2026 20:28:12 +0200
Message-ID: <5c1b505e-2e92-4457-928e-e02b71652e13@iogearbox.net>
Date: Fri, 16 Oct 2026 20:28:11 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpf: Don't echo user-supplied map info fields
 back to userspace
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, Quentin Monnet <qmo@kernel.org>,
 Tianyi Chen <hi@tychen.cc>, KP Singh <kpsingh@kernel.org>
References: <20261016164153.656430-1-daniel@iogearbox.net>
 <DM6G8ZUKITW8.A0II2HNX8268@gmail.com>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
In-Reply-To: <DM6G8ZUKITW8.A0II2HNX8268@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28155/Fri Oct 16 08:24:17 2026)

On 10/16/26 7:47 PM, Alexei Starovoitov wrote:
> On Fri, Oct 16, 2026 at 06:41 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>> @@ -5450,7 +5451,11 @@ static int bpf_map_get_info_by_fd(struct file *file,
>>   	memset(&info, 0, sizeof(info));
>>   	if (copy_from_user(&info, uinfo, info_len))
>>   		return -EFAULT;
>> -
>> +	hash = info.hash;
>> +	hash_size = info.hash_size;
>> +	memset(&info, 0, sizeof(info));
>> +	info.hash = hash;
>> +	info.hash_size = hash_size;
> 
> can we do
> 	memset(&info, 0, offsetof(struct bpf_map_info, hash));
> here instead ?
> hash and hash_size are the last two fields and the padding after them
> is checked by bpf_check_uarg_tail_zero() above.
> Then no need for two extra variables and the 2nd full memset.

Yeap, will check.. or alternatively memset and only copy the two
members into the zeroed struct; will check what looks better and
do a v2.

Thanks,
Daniel
