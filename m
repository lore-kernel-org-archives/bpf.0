Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A9E33ADA8
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 08:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771920227; cv=none; b=e+pmUyR5xyuX4kCDitq1KqI8Jpv4NFTdmoL+wflb4eZvV5GHCEpris/a8g6OCMyTisNvbDLbw7+Z63xUkNu3zpfxfUPJjTraB3WY5IGPgPdvsTTIt78UcrLIyfvS7CEnQFYfrAZOrgIIyLRzsP4m/duGw1RugnNvR707QEjpTRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771920227; c=relaxed/simple;
	bh=jP17Izar/lpJs7DpWjWC5ncCG35iIU3cY1TL8RTIa7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fuh2+GxEhglJgHhyfsnvo9wHQX9Zm4h1e+vynNgn543ngrJ+5JHCgD2IinivUXBB3L/BOrL2MKZQqtXg2BusKsLiw1jY8sBSMwffKBG6pE2J0vSMxcZSpAOzidVcsA+mdGDoucHGIkuxSI7Hn+vXpNex5spyNVxcs+kI15uNj4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CX8z24ZR; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UK8NG1d6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CX8z24ZR";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UK8NG1d6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771920224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9jKtLNf1wVvEnb8oGSMJXNrg9RCqp08LA00uDJtDQt4=;
	b=CX8z24ZRS7SzNcH1Kw2fK7/NwvOXxyakKoLGAC+YFPVJvH1LO2NHbEdyDMDnSV9g1Wzbp7
	qqzOdcheU++m5CpToGEvkl46+eVxWMVPFoNDZpBiGVVDXV/MN2nNSxsHQ5aNhCL89kchmy
	MUBw2IfMA7zplqNijEj7Qm2HpYV9lN8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-P3crErTXOZSROWi54QqHNQ-1; Tue, 24 Feb 2026 03:03:43 -0500
X-MC-Unique: P3crErTXOZSROWi54QqHNQ-1
X-Mimecast-MFC-AGG-ID: P3crErTXOZSROWi54QqHNQ_1771920222
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4837b9913c9so50989745e9.0
        for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 00:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771920221; x=1772525021; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9jKtLNf1wVvEnb8oGSMJXNrg9RCqp08LA00uDJtDQt4=;
        b=UK8NG1d6FmINmqmPExRv44i2PzVqNbfAkC8ome09wZc47lMF3407RgxysfKDj86cSO
         t0ZgooLKVKkrxqOCQEsLgZx5F90x3CVR/LXo2jnWMPp8OIS72iRBSG8chY2vziD4S0jj
         JtkTzjbZ3uAVL06ambZSs6rWQO61Ua6/3g0QuI7Gty+thy05dugH7fd6jLYxtXeGN8mT
         HmaCiZjL+fdM4QyTS1k6m4leTOEeHJbC4Lbx6JlddMJU7udTUjjJ9L8mWEywsOlYQ+W6
         J+Q6dM7BwsJqE52UxfRwNm+2WGN8gwQhEgfF3HB79ZqHxGIWFDLA4XxaEMY/TBxLBSDa
         YR+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771920221; x=1772525021;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9jKtLNf1wVvEnb8oGSMJXNrg9RCqp08LA00uDJtDQt4=;
        b=LZixcS7kAQY8j8w1Cz7sMjNtZ4P22C/71JcSUUER5/4gP3MDyIlnx7+glOkOxNPnP5
         PG1FiI84njYUYiS8W5beFICbAgf4T1LLrl6fxpkGaFw6R4J7nwYC4gP/NACr/gd2POTI
         NkYQZnB1O4rSNbo6ieTiRqqd1MEtnAXZSbSjdFPM4/AyUOo82gwscMIkHn5fSPVIStwk
         9/yC+EdtOSlgI8brNBwq9lgHZ9GeiSXeObUmp5Tqr1nc8RwXmDx5rLRPgc9RBZ0b+9IF
         SBSfXBqVS6cL8G6oK5pAsLg3A4ZD40E4N/C8cF8jiGkaWo6h4HfqScgAaN/sWHTuIp45
         McdQ==
X-Gm-Message-State: AOJu0YxXXZZSklQaocfOi9ixHefrxjJnAUl9ojI6oWHbOAbR9LWSQIpt
	TB7Vv7g5BlwP4MG4umeXr20Aulr9jDkcWQ9kRdVAK08hiOQ4l0SK1HlxRA6VneadPKReCS3UPAj
	zkO+48hXaNrKXvWNQrMFMpZ+6bW32Ex7+pNQSOcE1A2/qiiwpx+ZIoEfZG5M4
X-Gm-Gg: AZuq6aIz607wSZdQjOBNcgHq89UrhWX6jnWISuB1LVjj/aZOENk7aY02RkckLRkNMfi
	muBonZomVGU7jmwI16EpRxABsYgskNCNgvqH/jUNTqBhhzgrxixsQLdYv5eEgGPG05M3ndB8HcS
	v3AZ70giHSjQO6RP6bizikvYU+xlBYd5+5NO3aHPNL/akuRWDNKkvCtEh7UaHjWM4EjdRj2jvV1
	4SzrnDDfSZOFupoJzp2FOLOSo2O21a5YmYI8qEItEVUJYx3FgoUFLsMfiW//zBR2L7tQgn4+CJV
	KPJ75luxX1aRGWRbt/UAH2DqukXsY663NK+sP4S+tAz1v+7I5RF7M7o6XVfKWt5I7joh4CrvOBv
	qGhbOPPab
X-Received: by 2002:a05:600c:8b2c:b0:480:1b1a:5526 with SMTP id 5b1f17b1804b1-483a95e24ebmr222805495e9.16.1771920221518;
        Tue, 24 Feb 2026 00:03:41 -0800 (PST)
X-Received: by 2002:a05:600c:8b2c:b0:480:1b1a:5526 with SMTP id 5b1f17b1804b1-483a95e24ebmr222804945e9.16.1771920221064;
        Tue, 24 Feb 2026 00:03:41 -0800 (PST)
Received: from [10.43.17.26] ([213.175.46.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a9b75e63sm418214195e9.6.2026.02.24.00.03.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Feb 2026 00:03:40 -0800 (PST)
Message-ID: <ca5c38ad-5203-4b77-a8cc-552690ab70c5@redhat.com>
Date: Tue, 24 Feb 2026 09:03:38 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 0/3] Separate tests that need error injection
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Jordan Rome <linux@jordanrome.com>, Qais Yousef <qyousef@layalina.io>,
 Hou Tao <houtao1@huawei.com>
References: <cover.1770736390.git.vmalik@redhat.com>
 <CAADnVQLfV3PPYA8=EXDKwoQ925_W9HANf7gSn2=_fd42HD_FiA@mail.gmail.com>
 <d92e60ea-d590-4ce4-961f-4e8ce1cb0c42@redhat.com>
 <CAADnVQK6qP8izg+k9yV0vdcT-+=axtFQ2fKw7D-2Ei-V6WS5Dw@mail.gmail.com>
 <582944ed-ddd6-4843-ba36-b4aed03c5b2f@redhat.com>
 <CAADnVQJ4PU7bCb5XO9+zMZhLRSdbCKwxG6Rtojh2Rc3UZ8H43Q@mail.gmail.com>
 <d2706604-1674-49fd-a150-7ace8839657f@redhat.com>
 <CAADnVQLT7cGgExtaqusyk+XwrD=-x15kL0veJB5YPewjPo=PUg@mail.gmail.com>
 <fa67d3db-273f-4e4e-90a2-ba805f484bd1@redhat.com>
 <0675cf92-1833-4f1a-bd8e-53de5cc1ed7e@redhat.com>
 <CAADnVQ+BQZd4C8Mc4U1AnpQNPhouwjO=w89ORgF05AsoAH0RHg@mail.gmail.com>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <CAADnVQ+BQZd4C8Mc4U1AnpQNPhouwjO=w89ORgF05AsoAH0RHg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/24/26 03:58, Alexei Starovoitov wrote:
> On Mon, Feb 23, 2026 at 3:52 AM Viktor Malik <vmalik@redhat.com> wrote:
>>
>>
>> Looking into this more, I assume that the premise here is that injecting
>> errors into syscalls is not sufficient to implement a rootkit, more
>> mechanisms are necessary for that (even [1] uses bpf_probe_write_user
>> which is by default enabled on any kernel). On top of that, there are
>> tons of other ways to compromise a system using eBPF so enabling error
>> injection doesn't change much in that direction.
>>
>> With that, I'm ok with enabling fmod_ret for syscalls even with
>> CONFIG_ERROR_INJECTION=n, I'll send a patch.
> 
> Now we're on the same page. Thanks

Thanks for the confirmation.

The first patch of this series still looks reasonable to me since the
module_attach test flattens different test cases together. I'll send a
new version with just that first patch.

